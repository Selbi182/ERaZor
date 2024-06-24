; ---------------------------------------------------------------------------
; Sprite mappings - blocks that	disintegrate when Eggman presses a switch
; ---------------------------------------------------------------------------
		dc.w byte_19D1C-Map_obj83, byte_19D22-Map_obj83
		dc.w byte_19D2E-Map_obj83, byte_19D3A-Map_obj83
		dc.w byte_19D46-Map_obj83
byte_19D1C:	dc.b 1
		dc.b $F0, $F, 0, 0, $F0
byte_19D22:	dc.b 2
		dc.b $F8, 1, 0,	0, $F8
		dc.b $F8, 1, 0,	4, 0
		dc.b 0
byte_19D2E:	dc.b 2
		dc.b $F8, 1, 0,	8, $F8
		dc.b $F8, 1, 0,	$C, 0
		dc.b 0
byte_19D3A:	dc.b 2
		dc.b $F8, 1, 0,	2, $F8
		dc.b $F8, 1, 0,	6, 0
		dc.b 0
byte_19D46:	dc.b 2
		dc.b $F8, 1, 0,	$A, $F8
		dc.b $F8, 1, 0,	$E, 0
		even