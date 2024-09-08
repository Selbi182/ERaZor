
SoundTest_Obj_DummyHL:
	SoundTest_CreateChildObject #@Init	; generate secondary sprite (becase we can't cover more than 256 pixels)
	move.w	#$80+3*8-4+$80, obX(a0)
	move.w	#$80+3*8-4+$80+$80, obX(a1)
	move.b	#1, obFrame(a1)

@Init:
	move.w	#(SoundTest_DummyHL_VRAM/$20)|$6000, obGfx(a0)
	move.l	#@SpriteMappings, obMap(a0)
	move.b	#0, obPriority(a0)
	move.w	#$80+5*8-8, obScreenY(a0)
	move.l	#@Display, obCodePtr(a0)

@Display:
	jmp	DisplaySprite

@SpriteMappings:
	dc.w	@Frame1-@SpriteMappings
	dc.w	@Frame2-@SpriteMappings

@Frame1:
	dc.b	8*4

	@y: = 0
	rept 4
		dc.b	@y, $F, 0, 4*2, -$80
		dc.b	@y, $F, 0, 4*1, -$60
		dc.b	@y, $F, 0, 0, -$40
		dc.b	@y, $F, 0, 4*4, -$20
		dc.b	@y, $F, 0, 4*3, 0
		dc.b	@y, $F, 0, 4*2, $20
		dc.b	@y, $F, 0, 4*1, $40
		dc.b	@y, $F, 0, 0, $60
		@y: = @y + $20
	endr

@Frame2:
	dc.b	4

	@y: = 0
	rept 4
		dc.b	@y, %1011, 0, 4*4, 0
		@y: = @y + $20
	endr
	even


Dummy_HL_Art:
	@dcSpriteLine: macro line
		rept 8*4
			dc.l	\line
		endr
		endm

	@dcSpriteLine2: macro line, line2, line3
		rept 8*4/2-1
			dc.l	\line2
			dc.l	\line
		endr
		dc.l	\line2
		dc.l	\line3
		endm


	@dcSpriteLine	$EEEEEEEE
	@dcSpriteLine	$EEEEEEEE

	@dcSpriteLine	$0EEEEEEE
	@dcSpriteLine	$EEEEEEEE
	@dcSpriteLine	$E0EEEEEE ; -
	@dcSpriteLine	$EEEEEEEE

	@dcSpriteLine	$EEEEEEEE
	@dcSpriteLine	$0EEEEEEE

	; Just HL
	@i: = $D

	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i

	@dcSpriteLine	$10000000*@i

	@dcSpriteLine2	$0FFFFFFF+$10000000*@i, $0FFFFFFF+$10000000*@i, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i
	@dcSpriteLine2	$FFFFFFFF, $FFFFFFFF, $11111111*@i



Dummy_HL_Art.len: equ *-Dummy_HL_Art
