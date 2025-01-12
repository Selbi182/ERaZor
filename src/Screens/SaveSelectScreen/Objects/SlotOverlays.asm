
SaveSelect_Obj_SlotOverlays:
	moveq	#4-1, d6
	@CreateOverlays:
		Screen_CreateChildObject #@Overlay
		move.w	d6,obSubtype(a1)
		dbf	d6, @CreateOverlays
	jmp	DeleteObject

; ---------------------------------------------------------------------------
@Overlay:
	move.b	#0, obFrame(a0)
	move.w	#$80+16+2+$80, obX(a0)
	Screen_CreateChildObject #@Init
	move.b	#1, obFrame(a1)
	move.w	#$80+16+2+$100, obX(a1)
	move.w	obSubtype(a0), obSubtype(a1)

@Init:	move.w	#$6000|(SaveSelect_VRAM_DummyHL/$20), obGfx(a0)
	move.l	#@Maps, obMap(a0)
	move.w	obSubtype(a0), d0
	add.w	d0, d0
	add.w	d0, d0
	move.w	@SlotIdData(pc, d0), obScreenY(a0)
	move.b	@SlotIdData+3(pc, d0), d0
	add.b	d0, obFrame(a0)
	move.l	#DisplaySprite, obCodePtr(a0)
	jmp	DisplaySprite

@SlotIdData:
	;	ypos,		frame
	dc.w	$80+$20+4,	0
	dc.w	$80+$38+4,	2
	dc.w	$80+$68+4,	2
	dc.w	$80+$98+4,	2

@Maps:	dc.w	@Frame_NoSave-@Maps
	dc.w	@Frame_NoSave_Part2-@Maps
	dc.w	@Frame_NormalSlot-@Maps
	dc.w	@Frame_NormalSlot_Part2-@Maps

@Frame_NoSave:
	dc.b	8
	dc.b	0, %1101, 0, 0, -$80
	dc.b	0, %1101, 0, 0, -$60
	dc.b	0, %1101, 0, 0, -$40
	dc.b	0, %1101, 0, 0, -$20
	dc.b	0, %1101, 0, 0, 0
	dc.b	0, %1101, 0, 0, $20
	dc.b	0, %1101, 0, 0, $40
	dc.b	0, %1101, 0, 0, $60

@Frame_NoSave_Part2:
	dc.b	1
	dc.b	0, %1101, 0, 0, 0-4

@Frame_NormalSlot:
	dc.b	16
	dc.b	0, %1111, 0, 0, -$80
	dc.b	0, %1111, 0, 0, -$60
	dc.b	0, %1111, 0, 0, -$40
	dc.b	0, %1111, 0, 0, -$20
	dc.b	0, %1111, 0, 0, 0
	dc.b	0, %1111, 0, 0, $20
	dc.b	0, %1111, 0, 0, $40
	dc.b	0, %1111, 0, 0, $60
	dc.b	$20, %1100, 0, 0, -$80
	dc.b	$20, %1100, 0, 0, -$60
	dc.b	$20, %1100, 0, 0, -$40
	dc.b	$20, %1100, 0, 0, -$20
	dc.b	$20, %1100, 0, 0, 0
	dc.b	$20, %1100, 0, 0, $20
	dc.b	$20, %1100, 0, 0, $40
	dc.b	$20, %1100, 0, 0, $60

@Frame_NormalSlot_Part2:
	dc.b	2
	dc.b	0, %1111, 0, 0, 0-4
	dc.b	$20, %1100, 0, 0, 0-4

	even


