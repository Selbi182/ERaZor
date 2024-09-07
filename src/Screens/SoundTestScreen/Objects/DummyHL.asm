
SoundTest_Obj_DummyHL:
	move.b	#0, 1(a0)
	move.w	#(SoundTest_DummyHL_VRAM/$20)|$6000, 2(a0)
	move.l	#@Map, 4(a0)
	move.w	#$80+3*8-4+$80, 8(a0)
	move.b	#1, obPriority(a0)
	move.w	#$80+5*8, $A(a0)
	move.l	#@Main, $3C(a0)

@Main:	
	jmp	DisplaySprite

@Map:	dc.w	2
	dc.b	32+4
	dc.b	$0, $F, 0, 0, -$80
	dc.b	$0, $F, 0, 0, -$60
	dc.b	$0, $F, 0, 0, -$40
	dc.b	$0, $F, 0, 0, -$20
	dc.b	$0, $F, 0, 0, 0
	dc.b	$0, $F, 0, 0, $20
	dc.b	$0, $F, 0, 0, $40
	dc.b	$0, $F, 0, 0, $60
	dc.b	$0, $F, 0, 0, $78

	dc.b	$20, $F, 0, 0, -$80
	dc.b	$20, $F, 0, 0, -$60
	dc.b	$20, $F, 0, 0, -$40
	dc.b	$20, $F, 0, 0, -$20
	dc.b	$20, $F, 0, 0, 0
	dc.b	$20, $F, 0, 0, $20
	dc.b	$20, $F, 0, 0, $40
	dc.b	$20, $F, 0, 0, $60
	dc.b	$20, $F, 0, 0, $78

	dc.b	$40, $F, 0, 0, -$80
	dc.b	$40, $F, 0, 0, -$60
	dc.b	$40, $F, 0, 0, -$40
	dc.b	$40, $F, 0, 0, -$20
	dc.b	$40, $F, 0, 0, 0
	dc.b	$40, $F, 0, 0, $20
	dc.b	$40, $F, 0, 0, $40
	dc.b	$40, $F, 0, 0, $60
	dc.b	$40, $F, 0, 0, $78

	dc.b	$60, $F, 0, 0, -$80
	dc.b	$60, $F, 0, 0, -$60
	dc.b	$60, $F, 0, 0, -$40
	dc.b	$60, $F, 0, 0, -$20
	dc.b	$60, $F, 0, 0, 0
	dc.b	$60, $F, 0, 0, $20
	dc.b	$60, $F, 0, 0, $40
	dc.b	$60, $F, 0, 0, $60
	dc.b	$60, $F, 0, 0, $78
	even
