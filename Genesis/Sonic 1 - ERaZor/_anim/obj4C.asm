; ---------------------------------------------------------------------------
; Animation script - geyser of lava (MZ)
; ---------------------------------------------------------------------------
		dc.w byte_F220-Ani_obj4C
		dc.w byte_F22A-Ani_obj4C
		dc.w byte_F22E-Ani_obj4C
		dc.w byte_F232-Ani_obj4C
		dc.w byte_F23A-Ani_obj4C
		dc.w byte_F23E-Ani_obj4C
byte_F220:	dc.b 2,	0, 1, 0, 1, 4, 5, 4, 5,	$FC
byte_F22A:	dc.b 2,	2, 3, $FF
byte_F22E:	dc.b 2,	6, 7, $FF
byte_F232:	dc.b 2,	2, 3, 0, 1, 0, 1, $FC
byte_F23A:	dc.b $F, $13, $FF, 0
byte_F23E:	dc.b 2,	$11, $12, $FF
		even