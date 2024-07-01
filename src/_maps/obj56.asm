; ---------------------------------------------------------------------------
; Sprite mappings - moving blocks (SYZ/SLZ/LZ)
; ---------------------------------------------------------------------------
		dc.w byte_10710-Map_obj56, byte_10716-Map_obj56
		dc.w byte_1072B-Map_obj56, byte_10736-Map_obj56
		dc.w byte_1074B-Map_obj56, byte_1075B-Map_obj56
		dc.w byte_10761-Map_obj56, byte_1076C-Map_obj56
byte_10710:	dc.b 1
		dc.b $F0, $F, 0, $61, $F0
byte_10716:	dc.b 4
		dc.b $E0, $F, 0, $61, $E0
		dc.b $E0, $F, 0, $61, 0
		dc.b 0,	$F, 0, $61, $E0
		dc.b 0,	$F, 0, $61, 0
byte_1072B:	dc.b 2
		dc.b $E0, $F, 0, $61, $F0
		dc.b 0,	$F, 0, $61, $F0
byte_10736:	dc.b 4
		dc.b $E6, $F, 0, $81, $E0
		dc.b $E6, $F, 0, $81, 0
		dc.b 0,	$F, 0, $81, $E0
		dc.b 0,	$F, 0, $81, 0
byte_1074B:	dc.b 3
		dc.b $D9, $F, 0, $81, $F0
		dc.b $F3, $F, 0, $81, $F0
		dc.b $D, $F, 0,	$81, $F0
byte_1075B:	dc.b 1
		dc.b $F0, $F, 0, $21, $F0
byte_10761:	dc.b 2
		dc.b $E0, 7, 0,	0, $F8
		dc.b 0,	7, $10,	0, $F8
byte_1076C:	dc.b 4
		dc.b $F0, $F, 0, $22, $C0
		dc.b $F0, $F, 0, $22, $E0
		dc.b $F0, $F, 0, $22, 0
		dc.b $F0, $F, 0, $22, $20
		even