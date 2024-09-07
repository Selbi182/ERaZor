
; ---------------------------------------------------------------------------
; "Sound Test" header sprite
; ---------------------------------------------------------------------------

SoundTest_Obj_Header:
	move.w	#(SoundTest_HeaderFont_VRAM/$20)|$4000, obGfx(a0)
	move.l	#Map_Obj03, obMap(a0)
	move.w	#$80+320/2, obX(a0)
	move.w	#$80+12-8, obScreenY(a0)
	move.l	#@Display, obCodePtr(a0)
	move.b	#$B, obFrame(a0)

@Display:
	jmp	DisplaySprite
