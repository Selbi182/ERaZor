; ---------------------------------------------------------------------------
; Gameplay Style Screen (Casual Mode / Frantic Mode)
; ---------------------------------------------------------------------------

GameplayStyleScreen:
		move.b	#$E0,d0
		jsr	PlaySound_Special		; fade out music
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

		lea	($FFFFCC00).w,a1
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

		move.l	#$40000000,VDP_Ctrl		; load art
		lea	VDP_Data,a6
		lea	(ArtKospM_Difficulty).l,a0
		jsr	KosPlusMDec_VRAM

		vram	$2000
		lea	VDP_Data,a6
		lea	(ArtKospM_PixelStars).l,a0
		jsr	KosPlusMDec_VRAM

		lea	(Map_Difficulty).l,a1		; load maps
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		lea	VDP_Ctrl,a4
		move.l	#$800000,d4
@row:		move.l	d0,(a4)			; set VDP to VRam write mode
		move.w	d1,d3			; reload number of columns
@column:	move.w	(a1)+,d5		; load mapping
		ori.w	#$8000,d5		; make high-plane
		move.w	d5,(a6)			; dump map to VDP map slot
		dbf	d3,@column		; repeat til columns have dumped
		add.l	d4,d0			; increae to next row on VRam
		dbf	d2,@row			; repeat til all rows have dumped

	if def(__WIDESCREEN__)
		; making the screen slightly nicer in widescreen mode
		lea	($FFFFCC00).w,a1
		moveq	#SCREEN_XCORR,d0
		neg.w	d0
		swap	d0
		move.w	#224-1,d1
@wideadjust:
		move.l	d0,(a1)+
		cmpi.w	#112,d1
		bne.s	@next
		neg.l	d0
@next:		dbf	d1,@wideadjust
	endif

		moveq	#1,d0			; write palette to fade-in palette buffer
		bsr	GSS_LoadPal
		VBlank_UnsetMusicOnly
		display_enable
		jsr	Pal_FadeTo			; fade in

		move.b	#$8B,($FFFFD000).w		; load star object
		move.b	#0,($FFFFD000+obRoutine).w

		bra.s	GSS_MainLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; d0 = 0 FB00 / 1 FB80
GSS_LoadPal:
		lea	(Pal_Difficulty_Casual).l,a1	; load casual palette
		frantic
		beq.s	@loadpal
		lea	(Pal_Difficulty_Frantic).l,a1	; load frantic palette
@loadpal:
		moveq	#8-1,d1	
		lea	Pal_Active,a2
		tst.b	d0
		beq.s	@PalLoop
		adda.w	#$80,a2
@PalLoop:	move.l	(a1)+,(a2)+
		dbf	d1,@PalLoop
		rts
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

		move.b	($FFFFF605).w,d1	; get button presses
		btst	#0,d1			; specifically up pressed?
		bne.s	@uppress		; if yes, branch
		btst	#1,d1			; specifically down pressed?
		bne.s	@downpress		; if yes, branch
		bra.s	@NoUpdate		; skip

@uppress:
		bclr 	#5,(OptionsBits).w 	; set to casual (technically, "disable frantic")
		beq.s	@NoUpdate		; was it already set to casual? if so, no update
		bra.s	@update			; otherwise, refresh screen

@downpress:
		bset 	#5,(OptionsBits).w 	; enable frantic
		bne.s	@NoUpdate		; was it already set to frantic? if so, no update

@update:
		moveq	#0,d0			; write palette directly
		bsr	GSS_LoadPal		; refresh palette
		move.w	#$D8,d0			; play option toggle sound
		jsr	(PlaySound_Special).l

@NoUpdate:
		andi.b	#$B0,($FFFFF605).w	; is B, C, or Start pressed?
		beq.s	GSS_MainLoop		; if not, branch
		jmp	Exit_GameplayStyleScreen
; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
ArtKospM_Difficulty:
		incbin	"Screens/GameplayStyleScreen/Tiles_Difficulty.kospm"
		even
Map_Difficulty:
		incbin	"Screens/GameplayStyleScreen/Maps_Difficulty.bin"
		even
ArtKospM_PixelStars:	
		incbin	"Screens/GameplayStyleScreen/Tiles_Stars.kospm"
		even

Pal_Difficulty_Casual:
		;	bg	casual		    frantic		stars		    unused
		dc.w	$0200,  $0EEE,$0CAA,$0800,  $0444,$0222,$0000,  $0EEE,$0666,$0844,  0,0,0,0,0,0
Pal_Difficulty_Frantic:
		dc.w	$0002,  $0444,$0222,$0000,  $0EEE,$0AAC,$0008,  $0EEE,$0666,$0448,  0,0,0,0,0,0
		even
; ===========================================================================
