; ===========================================================================
; ---------------------------------------------------------------------------
; Background effect used in various screens
; ---------------------------------------------------------------------------

; must be called once during game mode init
BackgroundEffects_Setup:
		VBlank_SetMusicOnly
		move.w	#$8B03,VDP_Ctrl	; set scrolling mode to H: per-scanline // V: whole screen

		lea	VDP_Data, a6
		vram	$E000, 4(a6)		; set VDP to VRAM and start at E000 (location of Plane B nametable)

		move.l	#$00020002, d6
		moveq	#$40*$20/$80-1, d1	; cover the entire 512x256 pixel plane (64x32 tiles, 128 tile steps)

		@send128Tiles:
			move.l	#$00010002, d5
			rept	$80/2
				move.l	d5, (a6)
				add.l	d6, d5
			endr
			dbf	d1, @send128Tiles		; repeat til columns have dumped

		vram	$20, 4(a6)
		lea	BGEffects_FuzzArt, a0
		jsr	KosPlusMDec_VRAM

		VBlank_UnsetMusicOnly
		rts

; ---------------------------------------------------------------------------

; must called every frame from the respective game mode's main loop
BackgroundEffects_Update:
		move.l	a2,-(sp)
		bsr	BackgroundEffects_PalCycle
		bsr	BackgroundEffects_Deformation
		bsr	BackgroundEffects_VScroll
		move.l	(sp)+,a2
		rts
; ===========================================================================


; Background palette rotation
BackgroundEffects_PalCycle:
		move.w	($FFFFFE0E).w,d0	; get V-blank timer
		divu.w	#4,d0
		andi.l	#$FFFF0000,d0
		bne.w	@bgpalend
	;	addq.b	#1,($FFFFFF85).w	; increase timer

		tst.b	WhiteFlashCounter	; whiteflash in progress?
		bne.w	@bgpalend		; if yes, branch

		move.l	#Options_BGCycleColors_BW,d2
		movea.l	d2,a1
		moveq	#0,d0
		move.b	($FFFFFF85).w,d0	; get timer
		andi.w	#$F,d0
		add.w	d0,d0
		adda.w	d0,a1

		lea	($FFFFFB02).w,a2
		moveq	#10-1,d6	; 10 colors
@bgpalcycle:
		move.w	BGThemeColor,d0 ; get theme color
		move.w	(a1)+,d1	; get mask color
		bpl.s	@dolimit
		movea.l	d2,a1		; reset cycle location
		bra.s	@bgpalcycle
@dolimit:
		moveq	#0,d3		; limited color
		
		move.w	d1,d4		; copy mask color
		andi.w	#$00E,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$00E,d5
		cmp.w	d5,d4
		bls.s	@0
		move.w	d5,d4
@0		or.w	d4,d3

		move.w	d1,d4		; copy mask color
		andi.w	#$0E0,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$0E0,d5
		cmp.w	d5,d4
		bls.s	@1
		move.w	d5,d4
@1		or.w	d4,d3

		move.w	d1,d4		; copy mask color
		andi.w	#$E00,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$E00,d5
		cmp.w	d5,d4
		bls.s	@2
		move.w	d5,d4
@2		or.w	d4,d3

		move.w	d3,(a2)+
		dbf	d6,@bgpalcycle
@bgpalend:
		rts
; ---------------------------------------------------------------------------
Options_BGCycleColors_BW:
		dc.w	$222
		dc.w	$444
		dc.w	$666
		dc.w	$666
		dc.w	$888
		dc.w	$AAA
		dc.w	$AAA
		dc.w	$CCC
		dc.w	$CCC
		dc.w	$AAA
		dc.w	$AAA
		dc.w	$888
		dc.w	$666
		dc.w	$666
		dc.w	$444
		dc.w	$444
		dc.w	  -1

		dc.w	$222
		dc.w	$222
		dc.w	$444
		dc.w	$666
		dc.w	$888
		dc.w	$AAA
		dc.w	$CCC
		dc.w	$EEE
		dc.w	$CCC
		dc.w	$CCC
		dc.w	$EEE
		dc.w	$CCC
		dc.w	$AAA
		dc.w	$888
		dc.w	$666
		dc.w	$444
		even

Options_BGCycleColors:
		dc.w	$000
		dc.w	$000
		dc.w	$200
		dc.w	$420
		dc.w	$640
		dc.w	$860
		dc.w	$880
		
		dc.w	$680
		dc.w	$680
		
		dc.w	$880
		dc.w	$880
		dc.w	$680
		dc.w	$460
		dc.w	$240
		dc.w	$020
		dc.w	$220

		dc.w	  -1
		even
; ---------------------------------------------------------------------------

; Background deformation (the main effect)
BackgroundEffects_Deformation:
		move.w	($FFFFFE0E).w,d6	; get timer
		asr.w	#1,d6

		lea	($FFFFCC00).w,a1
		move.w	#224-1,d3
@scroll:
		move.w	d6,d2			; get timer
		add.w	d3,d2

		btst	#0,d3
		beq.s	@0
		neg.w	d2
		add.w	d6,d2
@0:

		addi.w	#$20,d2			; manual adjustment cause I fucked up the art import
		addq.w	#2,a1
		move.w	d2,(a1)+
		dbf	d3,@scroll
		rts
; ---------------------------------------------------------------------------

; V-Scroll
BackgroundEffects_VScroll:
		move.w	($FFFFFE0E).w,d1
		neg.w	d1
		move.w	d1,($FFFFF618).w	; set plane-B VSRAM
		rts
	
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------

BGEffects_FuzzArt:
		incbin	Screens\FuzzyBG.kospm
		even

; ---------------------------------------------------------------------------
; ===========================================================================
