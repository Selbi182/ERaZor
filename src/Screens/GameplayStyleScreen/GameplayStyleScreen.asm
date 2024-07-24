; ---------------------------------------------------------------------------
; Gameplay Style Screen (Casual Mode / Frantic Mode)
; ---------------------------------------------------------------------------

GameplayStyleScreen:
		move.b	#$E0,d0
		jsr	PlaySound_Special		; fade out music
		jsr	PLC_ClearQueue			; clear PLCs
		jsr	Pal_FadeFrom			; fade out previous palette

		VBlank_SetMusicOnly
		lea	($C00004).l,a6			; Setup VDP
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
		lea	($C00000).l,a0
		moveq	#0,d0
		moveq	#40-1,d1
@clearvsram:	move.w	d0,(a0)
		dbf	d1,@clearvsram

		move.l	#$40000000,($C00004).l		; load art
		lea	($C00000).l,a6
		lea	(ArtKospM_Difficulty).l,a0
		jsr	KosPlusMDec_VRAM

		vram	$2000
		lea	($C00000).l,a6
		lea	(ArtKospM_PixelStars).l,a0
		jsr	KosPlusMDec_VRAM

		lea	(Map_Difficulty).l,a1		; load maps
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		moveq	#1,d0
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
		lea	($FFFFFB00).w,a2
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
		move.w	#0,($FFFFFB00).w
		move.b	#$12,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

		move.b	($FFFFF605).w,d1	; get button presses
	 	andi.b	#3,d1			; is up or down pressed?
		beq.s	@NoUpdate		; if not, branch
		moveq	#0,d0			; set to highlight casual
		bchg 	#5,(OptionsBits).w 	; toggle casual/frantic flag
		moveq	#0,d0
		bsr	GSS_LoadPal
		move.w	#$D8,d0
		jsr	(PlaySound_Special).l	; play "blip" sound

@NoUpdate:
		andi.b	#$F0,($FFFFF605).w	; is A, B, C, or Start pressed?
		beq.s	GSS_MainLoop		; if not, branch
; ---------------------------------------------------------------------------

@Exit:
		move.w	#$C3,d0			; set giant ring sound
		jsr	PlaySound_Special	; play giant ring sound
		jsr 	WhiteFlash2
		jsr 	Pal_FadeFrom
		move.w  #$20,($FFFFF614).w
		jsr	SRAM_SaveNow

@Wait:
		move.b	#2, VBlankRoutine
		jsr	DelayProgram
		tst.w 	($FFFFF614).w
		bne.s 	@Wait
		
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
		dc.w	$0000,  $0ECC,$0CAA,$0200,  $0444,$0222,$0000,  $0EEE,$0666,$0822,  0,0,0,0,0,0
Pal_Difficulty_Frantic:
		dc.w	$0000,  $0444,$0222,$0000,  $0CCE,$022E,$0002,  $0EEE,$0666,$0822,  0,0,0,0,0,0
		even
; ===========================================================================
