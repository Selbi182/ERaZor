; ---------------------------------------------------------------------------
; Sprite mappings - Crabmeat enemy (GHZ, SYZ)
; ---------------------------------------------------------------------------
		dc.w byte_975E-Map_obj1F, byte_9773-Map_obj1F
		dc.w byte_9788-Map_obj1F, byte_979D-Map_obj1F
		dc.w byte_97B2-Map_obj1F, byte_97D1-Map_obj1F
		dc.w byte_97D7-Map_obj1F
byte_975E:	dc.b 4
		dc.b $F0, 9, 0,	0, $E8
		dc.b $F0, 9, 8,	0, 0
		dc.b 0,	5, 0, 6, $F0
		dc.b 0,	5, 8, 6, 0
byte_9773:	dc.b 4
		dc.b $F0, 9, 0,	$A, $E8
		dc.b $F0, 9, 0,	$10, 0
		dc.b 0,	5, 0, $16, $F0
		dc.b 0,	9, 0, $1A, 0
byte_9788:	dc.b 4
		dc.b $EC, 9, 0,	0, $E8
		dc.b $EC, 9, 8,	0, 0
		dc.b $FC, 5, 8,	6, 0
		dc.b $FC, 6, 0,	$20, $F0
byte_979D:	dc.b 4
		dc.b $EC, 9, 0,	$A, $E8
		dc.b $EC, 9, 0,	$10, 0
		dc.b $FC, 9, 0,	$26, 0
		dc.b $FC, 6, 0,	$2C, $F0
byte_97B2:	dc.b 6
		dc.b $F0, 4, 0,	$32, $F0
		dc.b $F0, 4, 8,	$32, 0
		dc.b $F8, 9, 0,	$34, $E8
		dc.b $F8, 9, 8,	$34, 0
		dc.b 8,	4, 0, $3A, $F0
		dc.b 8,	4, 8, $3A, 0
byte_97D1:	dc.b 1
		dc.b $F8, 5, 0,	$3C, $F8
byte_97D7:	dc.b 1
		dc.b $F8, 5, 0,	$40, $F8
		even