; ===========================================================================
; ---------------------------------------------------------------------------
; Background effect used in various screens
; ---------------------------------------------------------------------------

; must be called once during game mode init
BackgroundEffects_Setup:
		VBlank_SetMusicOnly

		lea	($C00000).l,a6
		move.l	#$40200000,4(a6)
		lea	(BGEffects_FuzzArt).l,a0
		jsr	KosPlusMDec_VRAM

		vram	$C000,4(a6)		; set VDP to VRAM and start at C000 (location of Plane A nametable)
		moveq	#0,d5			; clear d5
		move.w	#(512*256/64)-1,d1	; do for all tiles in the 512x256 plane
@column:
		addi.w	#1,d5			; go to next tile
		move.w	d5,(a6)			; dump map to VDP map slot
		tst.b	d5			; did we reach tile $80?
		bpl.s	@noreset		; if not, branch
		moveq	#0,d5			; reset index
@noreset:
		dbf	d1,@column		; repeat til columns have dumped

		VBlank_UnsetMusicOnly
		rts
; ---------------------------------------------------------------------------

; must called every frame from the respective game mode's main loop
BackgroundEffects_Update:
		VBlank_SetMusicOnly

		move.l	a2,-(sp)
		bsr	BackgroundEffects_PalCycle
		bsr	BackgroundEffects_Deformation
		bsr	BackgroundEffects_VScroll
		move.l	(sp)+,a2

		VBlank_UnsetMusicOnly
		rts
; ===========================================================================

; Background palette rotation
BackgroundEffects_PalCycle:
		move.w	($FFFFFE0E).w,d0	; get V-blank timer
		andi.w	#$F,d0
		divu.w	#8,d0
		andi.l	#$FFFF0000,d0
		bne.w	@bgpalend
		addq.b	#1,($FFFFFF85).w	; increase timer

		moveq	#0,d0
		move.l	#Options_BGCycleColors_BW,d2
		movea.l	d2,a1
		move.b	($FFFFFF85).w,d0	; get timer
		andi.w	#$F,d0
		add.w	d0,d0
		adda.w	d0,a1

		lea	($FFFFFB02).w,a2
		moveq	#10-1,d6	; 10 colors
@bgpalcycle:
		move.w	($FFFFF5D6).w,d0 ; get theme color
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
		dc.w	$000
		dc.w	$000
		dc.w	$222
		dc.w	$444
		dc.w	$666
		dc.w	$666
		dc.w	$888
		
		dc.w	$AAA
		dc.w	$AAA
		
		dc.w	$888
		dc.w	$666
		dc.w	$666
		dc.w	$444
		dc.w	$222
		dc.w	$000
		dc.w	$000

		dc.w	  -1
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
		moveq	#0,d0
	
BackgroundEffects_Deformation2:
		move.l	d7,-(sp)
		moveq	#0,d7
		move.w	($FFFFFE0E).w,d6	; get timer
		tst.b	d0
		beq.s	@noadjust
		move.w	d0,d7
@noadjust:
		lea	($FFFFCC00).w,a1
		move.w	#(224/1)-1,d3
		jsr	RandomNumber
@scroll:
		ror.l	#1,d1
		move.l	d1,d2
		andi.l	#$001F0000,d2
		
		moveq	#0,d0
		moveq	#0,d4
		move.w	d6,d0	; get timer
		swap	d0
		btst	#0,d3
		beq.s	@1
		neg.l	d0
@1:
		andi.l	#$0000FFFF,d0
		swap	d0
		add.w	d6,d0 ; scroll everything to the right
		btst	#0,d5
		beq.s	@3
		sub.w	d6,d0 ; scroll everything to the left
@3:
		move.w	d0,d4		; copy scroll
		add.w	d3,d4		; add line index
		subi.w	#224/2,d4
		movem.l	d0/d1,-(sp)
		move.w	d4,d0
		jsr	CalcSine
		
		move.w	d3,d5
		add.w	d6,d5
		btst	#7,d5
		beq.s	@2
		neg.w	d0
@2:
		move.w	d0,d4
		
		movem.l	(sp)+,d0/d1
		add.w	d4,d0
		swap	d0
		or.l	d0,d2
		tst.b	d7
		beq.s	@bla
		asr.l	d7,d2
@bla
		andi.l	#$FFFF0000,d2
		swap	d2
		move.w	d2,(a1)+
		addq.w	#2,a1
		dbf	d3,@scroll ; fill scroll data with 0
		move.l	(sp)+,d7
		rts
; ---------------------------------------------------------------------------

; V-Scroll
BackgroundEffects_VScroll:
		lea	($C00000).l,a0			; init VDP data port in a0
		move.l	#$40000010,4(a0)		; set VDP control port to VSRAM mode and start at 00
		move.w	#(320/8)-1,d0			; do it for all 40 double-tiles (320 width = 80 tiles at 8 pixels)
@vScroll_loop:	moveq	#0,d1
		move.w	($FFFFFE0E).w,d1
		lsl.w	#1,d1
		swap	d1
		move.l	d1,(a0)				; dump art to VSRAM
		dbf	d0,@vScroll_loop		; repeat until all lines are done
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------

BGEffects_FuzzArt:
		incbin	Screens\FuzzyBG.kospm
		even

; ---------------------------------------------------------------------------
; ===========================================================================