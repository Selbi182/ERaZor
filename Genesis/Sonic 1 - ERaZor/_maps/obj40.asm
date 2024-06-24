; ---------------------------------------------------------------------------
; Sprite mappings - Moto Bug enemy (GHZ)
; ---------------------------------------------------------------------------
		dc.w byte_F7AE-Map_obj40, byte_F7C3-Map_obj40
		dc.w byte_F7D8-Map_obj40, byte_F7F2-Map_obj40
		dc.w byte_F7F8-Map_obj40, byte_F7FE-Map_obj40
		dc.w byte_F804-Map_obj40
byte_F7AE:	dc.b 4
		dc.b $F0, $D, 0, 0, $EC
		dc.b 0,	$C, 0, 8, $EC
		dc.b $F8, 1, 0,	$C, $C
		dc.b 8,	8, 0, $E, $F4
byte_F7C3:	dc.b 4
		dc.b $F1, $D, 0, 0, $EC
		dc.b 1,	$C, 0, 8, $EC
		dc.b $F9, 1, 0,	$C, $C
		dc.b 9,	8, 0, $11, $F4
byte_F7D8:	dc.b 5
		dc.b $F0, $D, 0, 0, $EC
		dc.b 0,	$C, 0, $14, $EC
		dc.b $F8, 1, 0,	$C, $C
		dc.b 8,	4, 0, $18, $EC
		dc.b 8,	4, 0, $12, $FC
byte_F7F2:	dc.b 1
		dc.b $FA, 0, 0,	$1A, $10
byte_F7F8:	dc.b 1
		dc.b $FA, 0, 0,	$1B, $10
byte_F7FE:	dc.b 1
		dc.b $FA, 0, 0,	$1C, $10
byte_F804:	dc.b 0
		even