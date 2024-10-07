
; ---------------------------------------------------------------------------
; Subroutine to	load a level's objects
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjPosLoad:				; XREF: Level; et al
		move.w	($FFFFF76C).w,d0
		jmp	OPL_Index(pc,d0.w)
; ===========================================================================
OPL_Index:	bra.w	OPL_Init		; $00
		bra.w	OPL_Main		; $04
; ===========================================================================

OPL_Init:				; XREF: OPL_Index
		addq.w	#4,($FFFFF76C).w

		lea	ObjectSpawnTable, a2
		move.w	#$0101, (a2)+
		moveq	#(ObjectSpawnTable_End-ObjectSpawnTable-2)/$10-1, d0
		moveq	#0, d6

	@ClearSpawnTable:
		rept 4
			move.l	d6, (a2)+
		endr
		dbf	d0, @ClearSpawnTable
		rept ((ObjectSpawnTable_End-ObjectSpawnTable-2) % $10) / 4
			move.l	d6, (a2)+
		endr
		if (ObjectSpawnTable_End-ObjectSpawnTable-2) & 2
			move.w	d6, (a2)+
		endif

		assert.w a2, eq, #ObjectSpawnTable_End

		move.w	CurrentLevel, d0		; d0 = %00000ZZZ 000000AA
		ror.b	#2,d0				; d0 = %00000ZZZ AA000000
		lsr.w	#5,d0				; d0 = %00000000 00ZZZAA0
		lea	ObjPos_Index, a0
		adda.w	(a0,d0.w),a0
		move.l	a0,($FFFFF770).w
		move.l	a0,($FFFFF774).w

		lea	ObjectSpawnTable,a2
		moveq	#0,d2
		move.w	CamXPos,d6
		subi.w	#$80,d6
		bcc.s	loc_D93C
		moveq	#0,d6

loc_D93C:
		andi.w	#$FF80,d6
		movea.l	($FFFFF770).w,a0

loc_D944:
		cmp.w	(a0),d6
		bls.s	loc_D956
		tst.b	4(a0)
		bpl.s	loc_D952
		move.b	(a2),d2
		addq.b	#1,(a2)

loc_D952:
		addq.w	#6,a0
		bra.s	loc_D944
; ===========================================================================

loc_D956:
		move.l	a0,($FFFFF770).w
		movea.l	($FFFFF774).w,a0
		subi.w	#$80,d6
		bcs.s	loc_D976

loc_D964:
		cmp.w	(a0),d6
		bls.s	loc_D976
		tst.b	4(a0)
		bpl.s	loc_D972
		addq.b	#1,1(a2)

loc_D972:
		addq.w	#6,a0
		bra.s	loc_D964
; ===========================================================================

loc_D976:
		move.l	a0,($FFFFF774).w
		move.w	#-1,($FFFFF76E).w

; ===========================================================================
OPL_Main:				; XREF: OPL_Index
		lea	ObjectSpawnTable,a2
		moveq	#0,d2
		move.w	CamXPos,d6
		andi.w	#$FF80,d6
		cmp.w	($FFFFF76E).w,d6
		beq.w	locret_DA3A
		bge.s	loc_D9F6
		move.w	d6,($FFFFF76E).w
		movea.l	($FFFFF774).w,a0
		subi.w	#$80,d6
		bcs.s	loc_D9D2

loc_D9A6:
		cmp.w	-6(a0),d6
		bge.s	loc_D9D2
		subq.w	#6,a0
		tst.b	obMap(a0)
		bpl.s	loc_D9BC
		subq.b	#1,1(a2)
		move.b	1(a2),d2

loc_D9BC:
		bsr	loc_DA3C
		bne.s	loc_D9C6
		subq.w	#6,a0
		bra.s	loc_D9A6
; ===========================================================================

loc_D9C6:
		tst.b	4(a0)
		bpl.s	loc_D9D0
		addq.b	#1,1(a2)

loc_D9D0:
		addq.w	#6,a0

loc_D9D2:
		move.l	a0,($FFFFF774).w
		movea.l	($FFFFF770).w,a0
		addi.w	#$300,d6

loc_D9DE:
		cmp.w	-6(a0),d6
		bgt.s	loc_D9F0
		tst.b	-2(a0)
		bpl.s	loc_D9EC
		subq.b	#1,(a2)

loc_D9EC:
		subq.w	#6,a0
		bra.s	loc_D9DE
; ===========================================================================

loc_D9F0:
		move.l	a0,($FFFFF770).w
		rts	
; ===========================================================================

loc_D9F6:
		move.w	d6,($FFFFF76E).w
		movea.l	($FFFFF770).w,a0
		addi.w	#$280,d6

loc_DA02:
		cmp.w	(a0),d6
		bls.s	loc_DA16
		tst.b	obMap(a0)
		bpl.s	loc_DA10
		move.b	(a2),d2
		addq.b	#1,(a2)

loc_DA10:
		bsr	loc_DA3C
		beq.s	loc_DA02
		tst.b	$04(a0)		; was this object a remember state?
		bpl.s	loc_DA16	; if not, branch
		subq.b	#1,(a2)		; move right counter back
		
loc_DA16:
		move.l	a0,($FFFFF770).w
		movea.l	($FFFFF774).w,a0
		subi.w	#$300,d6
		bcs.s	loc_DA36

loc_DA24:
		cmp.w	(a0),d6
		bls.s	loc_DA36
		tst.b	4(a0)
		bpl.s	loc_DA32
		addq.b	#1,1(a2)

loc_DA32:
		addq.w	#6,a0
		bra.s	loc_DA24
; ===========================================================================

loc_DA36:
		move.l	a0,($FFFFF774).w

locret_DA3A:
		rts	
; ===========================================================================

loc_DA3C:
		tst.b	4(a0)
		bpl.s	OPL_MakeItem
		btst	#7, 2(a2,d2.w)
		beq.s	OPL_MakeItem
		addq.w	#6, a0
		moveq	#0, d0
		rts	
; ===========================================================================

OPL_MakeItem:
		bsr	SingleObjLoad
		bne.s	OPL_MakeItem_Failed
		move.w	(a0)+,obX(a1)
		move.w	(a0)+,d0
		move.w	d0,d1
		andi.w	#$FFF,d0
		move.w	d0,obY(a1)
		rol.w	#2,d1
		andi.b	#3,d1
		move.b	d1,obRender(a1)
		move.b	d1,obStatus(a1)
		move.b	(a0)+,d0
		bpl.s	loc_DA80
		bset	#7, 2(a2,d2.w)		; set as spawn
		andi.b	#$7F,d0
		move.b	d2,obRespawnNo(a1)

loc_DA80:
		move.b	d0, (a1)
		move.b	(a0)+,obSubtype(a1)
		moveq	#0,d0
		rts

OPL_MakeItem_Failed:
		KDebug.WriteLine "OPL_MakeItem(): Object allocation failed (xpos=%<.w (a0)>, id=%<.b 4(a0)>, subtype=%<.b 5(a0)>)"
		rts
