; ---------------------------------------------------------------------------
; Sprite mappings - explosion from when	a boss is destroyed
; ---------------------------------------------------------------------------
		dc.w byte_8ED0X-Map_obj3F
		dc.w byte_8F16-Map_obj3F
		dc.w byte_8F1C-Map_obj3F
		dc.w byte_8EE2X-Map_obj3F
		dc.w byte_8EF7X-Map_obj3F
byte_8ED0X:	dc.b 1
		dc.b $F8, 9, 0,	0, $F4
byte_8F16:	dc.b 1
		dc.b $F0, $F, 0, $40, $F0
byte_8F1C:	dc.b 1
		dc.b $F0, $F, 0, $50, $F0
byte_8EE2X:	dc.b 4
		dc.b $EC, $A, 0, $26, $EC
		dc.b $EC, 5, 0,	$2F, 4
		dc.b 4,	5, $18,	$2F, $EC
		dc.b $FC, $A, $18, $26,	$FC
byte_8EF7X:	dc.b 4
		dc.b $EC, $A, 0, $33, $EC
		dc.b $EC, 5, 0,	$3C, 4
		dc.b 4,	5, $18,	$3C, $EC
		dc.b $FC, $A, $18, $33,	$FC
		even