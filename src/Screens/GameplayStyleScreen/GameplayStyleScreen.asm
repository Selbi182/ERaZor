; ---------------------------------------------------------------------------
; Gameplay Style Screen (Casual Mode / Frantic Mode)
; ---------------------------------------------------------------------------

; VRAM layout
				rsset $00
GameplayStyle_VRAM_Difficulty:	rsfile	'Screens/GameplayStyleScreen/Tiles_Difficulty.unc'
GameplayStyle_VRAM_Stars:	rsfile	'Screens/_common/Data/Stars_Tiles.unc'

GameplayStyle_VRAM_FG:		equ	$C000

; ---------------------------------------------------------------------------

GameplayStyleScreen:
		move.b	#$E0,d0
		jsr	PlayCommand			; fade out music
		jsr	PLC_ClearQueue			; clear PLCs
		jsr	Pal_FadeFrom			; fade out previous palette

		VBlank_SetMusicOnly
		lea	VDP_Ctrl,a6			; Setup VDP
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		move.w	#0,BlackBars.Height

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@ClrObjRam:	move.l	d0,(a1)+
		dbf	d1,@ClrObjRam

		lea	($FFFFFB80).w,a1
		moveq	#0,d0
		move.w	#$1F,d1
@ClrPal:	move.l	d0,(a1)+
		dbf	d1,@ClrPal

		lea	HSRAM_Buffer,a1
		moveq	#0,d0
		move.w	#224-1,d1
@clearscroll:	move.l	d0,(a1)+
		dbf	d1,@clearscroll

		move.l	#$40000010,(a6)
		lea	VDP_Data,a0
		moveq	#0,d0
		moveq	#40-1,d1
@clearvsram:	move.w	d0,(a0)
		dbf	d1,@clearvsram

		; Load all compressed graphics
		lea	GGS_PLCList(pc), a1
		jsr	LoadPLC_Direct
		jsr	PLC_ExecuteOnce_Direct

		; Load mappings
		lea	MapEni_Difficulty(pc), a0	; load maps
		lea	$FF0000, a1
		move.w	#$8000, d0
		jsr	EniDec

		vram	GameplayStyle_VRAM_FG, d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

	if def(__WIDESCREEN__)
		; making the screen slightly nicer in widescreen mode
		lea	HSRAM_Buffer,a1
		moveq	#SCREEN_XCORR,d0
		neg.w	d0
		swap	d0
		moveq	#112-1,d1
	@loop0:	move.l	d0,(a1)+
		dbf	d1,@loop0
		neg.l	d0
		moveq	#112-1,d1
	@loop1:	move.l	d0,(a1)+
		dbf	d1,@loop1
	endif

		lea	Pal_Target, a2			; write palette to fade-in palette buffer
		bsr	GSS_LoadPal
		VBlank_UnsetMusicOnly
		display_enable
		jsr	Pal_FadeTo			; fade in

		move	#GameplayStyle_VRAM_Stars/$20, d4	; art pointer
		moveq	#78-1, d6				; num stars - 1
		jsr	Screen_GenerateStarfieldObjects

		bra	GSS_MainLoop

; ===========================================================================
GGS_PLCList:
		dc.l	ArtKospM_Difficulty
		dc.w	GameplayStyle_VRAM_Difficulty

		dc.l	Screens_Stars_ArtKospM
		dc.w	GameplayStyle_VRAM_Stars

		dc.w	-1	; end marker

; ===========================================================================
; ---------------------------------------------------------------------------
; a2 = Pal_Active / Pal_Target
GSS_LoadPal:
		assert.w a2, hs, #Pal_Active
		assert.w a2, ls, #Pal_Target

		moveq	#STARFIELD_PAL_ID_BLUE, d2
		lea	Pal_Difficulty_Casual(pc), a1	; load casual palette
		frantic
		beq.s	@loadpal
		moveq	#STARFIELD_PAL_ID_RED, d2
		lea	Pal_Difficulty_Frantic(pc), a1	; load frantic palette

	@loadpal:
		rept 8/2
			move.l	(a1)+, (a2)+
		endr
		jmp	Screen_LoadStarfieldPalette	; INPUT: d2, a2

; ---------------------------------------------------------------------------
; ===========================================================================

; I HATE THIS CODE SO MUCH <-- I think it's already pretty swag ngl
GSS_MainLoop:
		move.w	#0,Pal_Active
		move.b	#$12,VBlankRoutine
		jsr	DelayProgram
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute

		move.b	Joypad|Press,d1		; get button presses
		btst	#0,d1			; specifically up pressed?
		bne.s	@uppress		; if yes, branch
		btst	#2,d1			; specifically left pressed?
		bne.s	@uppress		; if yes, branch
		btst	#1,d1			; specifically down pressed?
		bne.s	@downpress		; if yes, branch
		btst	#3,d1			; specifically right pressed?
		bne.s	@downpress		; if yes, branch
		bra.s	@NoUpdate		; skip

@uppress:
		bclr 	#SlotState_Difficulty, SlotProgress 	; set to casual (technically, "disable frantic")
		beq.s	@NoUpdate		; was it already set to casual? if so, no update
		bra.s	@update			; otherwise, refresh screen

@downpress:
		bset 	#SlotState_Difficulty, SlotProgress 	; enable frantic
		bne.s	@NoUpdate		; was it already set to frantic? if so, no update

@update:
		lea	Pal_Active,a2		; write palette directly
		bsr	GSS_LoadPal		; refresh palette
		move.w	#$D8,d0			; play option toggle sound
		jsr	PlaySFX

@NoUpdate:
		moveq	#$FFFFFF00|Start|A|B|C,d0 ; is A, B, C, or Start pressed?
		and.b	Joypad|Press,d0
		beq.s	GSS_MainLoop		; if not, loop
@exit:
		jmp	Exit_GameplayStyleScreen
; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
ArtKospM_Difficulty:
		incbin	"Screens/GameplayStyleScreen/Tiles_Difficulty.kospm"
		even
MapEni_Difficulty:
		incbin	"Screens/GameplayStyleScreen/Maps_Difficulty.eni"
		even

Pal_Difficulty_Casual:
		;	bg	casual		    frantic
		dc.w	$0200,  $0EEE,$0CAA,$0800,  $0444,$0222,$0000, 0
Pal_Difficulty_Frantic:
		dc.w	$0002,  $0444,$0222,$0000,  $0EEE,$0AAC,$0008, 0
; ===========================================================================
