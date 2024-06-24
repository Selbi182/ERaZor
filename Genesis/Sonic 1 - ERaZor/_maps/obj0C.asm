; ---------------------------------------------------------------------------
; Sprite mappings - flapping door (LZ)
; ---------------------------------------------------------------------------
		dc.w byte_113F8-Map_obj0C
		dc.w byte_11403-Map_obj0C
		dc.w byte_1140E-Map_obj0C
byte_113F8:	dc.b 2
		dc.b $E0, 7, 0,	0, $F8
		dc.b 0,	7, $10,	0, $F8
byte_11403:	dc.b 2
		dc.b $DA, $F, 0, 8, $FB
		dc.b 6,	$F, $10, 8, $FB
byte_1140E:	dc.b 2
		dc.b $D8, $D, 0, $18, 0
		dc.b $18, $D, $10, $18,	0
		even