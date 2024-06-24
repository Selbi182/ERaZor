; ---------------------------------------------------------------------------
; Sprite mappings - Jaws enemy (LZ)
; ---------------------------------------------------------------------------
		dc.w byte_AC78-Map_obj2C
		dc.w byte_AC83-Map_obj2C
		dc.w byte_AC8E-Map_obj2C
		dc.w byte_AC99-Map_obj2C
byte_AC78:	dc.b 1
		dc.b $F4, $E, 0, 0, $F0
		dc.b $F5, 5, 0,	$18, $10
byte_AC83:	dc.b 1
		dc.b $F4, $E, 0, $C, $F0
		dc.b $F5, 5, 0,	$1C, $10
byte_AC8E:	dc.b 2
		dc.b $F4, $E, 0, 0, $F0
		dc.b $F5, 5, $10, $18, $10
byte_AC99:	dc.b 2
		dc.b $F4, $E, 0, $C, $F0
		dc.b $F5, 5, $10, $1C, $10
		even