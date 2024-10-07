
; ---------------------------------------------------------------------------
; Subroutine to	convert	mappings (etc) to proper Megadrive sprites
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

BuildSprites_SS:
		jsr	SS_ShowLayout

BuildSprites:				; XREF: TitleScreen; et al
		lea	($FFFFF800).w,a2 ; set address for sprite table
		moveq	#0,d5
		lea	($FFFFAC00).w,a4
		moveq	#7,d7

		if def(__DEBUG__)
			moveq	#_BB_HandlerIdMask, d1
			and.b	BlackBars.HandlerId, d1
			lea	BlackBars.HandlerList, a0
			move.w	(a0, d1), d1
			assert.w d1, eq, BlackBars.Handler, Debugger_BlackBars
		endif

		move.w	BlackBars.Handler, a0
		jsr	_BB_BuildSpritesCallback(a0)

loc_D66A:
		tst.w	(a4)
		beq.w	loc_D72E
		moveq	#2,d6

loc_D672:
		movea.w	(a4,d6.w),a0
		tst.b	(a0)
		beq.w	loc_D726
		bclr	#7,obRender(a0)
		move.b	obRender(a0),d0
		move.b	d0,d4
		andi.w	#$C,d0
		beq.s	loc_D6DE
		movea.l	BldSpr_ScrPos(pc,d0.w),a1
		moveq	#0,d0		; MJ: Shorter/quicker code
		move.b	obActWid(a0),d0
		move.w	d0,d1
		move.w	obX(a0),d3
		sub.w	(a1),d3

		add.w	d3,d0
		add.w	d1,d1
		addi.w	#SCREEN_WIDTH,d1
		cmp.w	d1,d0
		bhi	loc_D726
		addi.w	#$80+SCREEN_XDISP,d3
		btst	#4,d4
		beq.s	loc_D6E8
		moveq	#0,d0		; MJ: Shorter/quicker code
		move.b	obHeight(a0),d0
		move.w	d0,d1
		move.w	obY(a0),d2
		sub.w	obMap(a1),d2
		add.w	d2,d0
		add.w	d1,d1
		addi.w	#SCREEN_HEIGHT,d1
		cmp.w	d1,d0
		bhi.s	loc_D726
		addi.w	#$80,d2
		bra.s	loc_D700
; ===========================================================================
BldSpr_ScrPos:	dc.l 0			; blank
		dc.l $FFF700		; main screen x-position
		dc.l $FFF708		; background x-position	1
		dc.l $FFF718		; background x-position	2

; ===========================================================================
loc_D6DE:
		move.w	obScreenY(a0),d2
		move.w	obX(a0),d3
		bra.s	loc_D700
; ===========================================================================

loc_D6E8:
		move.w	obY(a0),d2
		sub.w	obMap(a1),d2
		addi.w	#$80,d2
		cmpi.w	#$60,d2
		bcs.s	loc_D726
		cmpi.w	#$180,d2
		bcc.s	loc_D726

loc_D700:
		movea.l	obMap(a0),a1
		moveq	#0,d1
		btst	#5,d4
		bne.s	loc_D71C
		move.b	obFrame(a0),d1
		add.b	d1,d1
		adda.w	(a1,d1.w),a1
		move.b	(a1)+,d1
		subq.b	#1,d1
		bmi.s	loc_D720

loc_D71C:
		bsr	sub_D750

loc_D720:
		bset	#7,obRender(a0)

loc_D726:
		addq.w	#2,d6
		subq.w	#2,(a4)
		bne.w	loc_D672

loc_D72E:
		lea	$80(a4),a4
		dbf	d7,loc_D66A
		move.b	d5,($FFFFF62C).w
		cmpi.b	#$50,d5
		beq.s	loc_D748
		move.l	#0,(a2)
		rts	
; ===========================================================================

loc_D748:
		move.b	#0,-5(a2)
		rts	
; End of function BuildSprites


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_D750:				; XREF: BuildSprites
		movea.w	obGfx(a0),a3
		btst	#0,d4
		bne.s	loc_D796
		btst	#1,d4
		bne.w	loc_D7E4
; End of function sub_D750


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_D762:				; XREF: sub_D762; SS_ShowLayout
		cmpi.b	#$50,d5
		beq.s	locret_D794
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d2,d0
		move.w	d0,(a2)+
		move.b	(a1)+,(a2)+
		addq.b	#1,d5
		move.b	d5,(a2)+
		move.b	(a1)+,d0
		lsl.w	#8,d0
		move.b	(a1)+,d0
		add.w	a3,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d3,d0
		andi.w	#$1FF,d0
		bne.s	loc_D78E
		addq.w	#1,d0

loc_D78E:
		move.w	d0,(a2)+
		dbf	d1,sub_D762

locret_D794:
		rts	
; End of function sub_D762

; ===========================================================================

loc_D796:
		btst	#1,d4
		bne.w	loc_D82A

loc_D79E:
		cmpi.b	#$50,d5
		beq.s	locret_D7E2
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d2,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d4
		move.b	d4,(a2)+
		addq.b	#1,d5
		move.b	d5,(a2)+
		move.b	(a1)+,d0
		lsl.w	#8,d0
		move.b	(a1)+,d0
		add.w	a3,d0
		eori.w	#$800,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d0
		ext.w	d0
		neg.w	d0
		add.b	d4,d4
		andi.w	#$18,d4
		addq.w	#8,d4
		sub.w	d4,d0
		add.w	d3,d0
		andi.w	#$1FF,d0
		bne.s	loc_D7DC
		addq.w	#1,d0

loc_D7DC:
		move.w	d0,(a2)+
		dbf	d1,loc_D79E

locret_D7E2:
		rts	
; ===========================================================================

loc_D7E4:				; XREF: sub_D750
		cmpi.b	#$50,d5
		beq.s	locret_D828
		move.b	(a1)+,d0
		move.b	(a1),d4
		ext.w	d0
		neg.w	d0
		lsl.b	#3,d4
		andi.w	#$18,d4
		addq.w	#8,d4
		sub.w	d4,d0
		add.w	d2,d0
		move.w	d0,(a2)+
		move.b	(a1)+,(a2)+
		addq.b	#1,d5
		move.b	d5,(a2)+
		move.b	(a1)+,d0
		lsl.w	#8,d0
		move.b	(a1)+,d0
		add.w	a3,d0
		eori.w	#$1000,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d0
		ext.w	d0
		add.w	d3,d0
		andi.w	#$1FF,d0
		bne.s	loc_D822
		addq.w	#1,d0

loc_D822:
		move.w	d0,(a2)+
		dbf	d1,loc_D7E4

locret_D828:
		rts	
; ===========================================================================

loc_D82A:
		cmpi.b	#$50,d5
		beq.s	locret_D87C
		move.b	(a1)+,d0
		move.b	(a1),d4
		ext.w	d0
		neg.w	d0
		lsl.b	#3,d4
		andi.w	#$18,d4
		addq.w	#8,d4
		sub.w	d4,d0
		add.w	d2,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d4
		move.b	d4,(a2)+
		addq.b	#1,d5
		move.b	d5,(a2)+
		move.b	(a1)+,d0
		lsl.w	#8,d0
		move.b	(a1)+,d0
		add.w	a3,d0
		eori.w	#$1800,d0
		move.w	d0,(a2)+
		move.b	(a1)+,d0
		ext.w	d0
		neg.w	d0
		add.b	d4,d4
		andi.w	#$18,d4
		addq.w	#8,d4
		sub.w	d4,d0
		add.w	d3,d0
		andi.w	#$1FF,d0
		bne.s	loc_D876
		addq.w	#1,d0

loc_D876:
		move.w	d0,(a2)+
		dbf	d1,loc_D82A

locret_D87C:
		rts	