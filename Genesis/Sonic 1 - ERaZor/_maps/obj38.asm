; ---------------------------------------------------------------------------
; Sprite mappings - shield and invincibility stars
; ---------------------------------------------------------------------------
		dc.w byte_143CD-Map_obj38, byte_143C2-Map_obj38
		dc.w byte_143D7-Map_obj38, byte_143EC-Map_obj38
		dc.w byte_14401-Map_obj38, byte_14416-Map_obj38
		dc.w byte_1442B-Map_obj38, byte_14440-Map_obj38
byte_143C2:	dc.b 4
		dc.b $E8, $A, 0, 0, $E8
		dc.b $E8, $A, 0, 9, 0
byte_143CD:	dc.b 0,	$A, $10, 0, $E8
		dc.b 0,	$A, $10, 9, 0
byte_143D7:	dc.b 4
		dc.b $E8, $A, 8, $12, $E9
		dc.b $E8, $A, 0, $12, 0
		dc.b 0,	$A, $18, $12, $E9
		dc.b 0,	$A, $10, $12, 0
byte_143EC:	dc.b 4
		dc.b $E8, $A, 8, 9, $E8
		dc.b $E8, $A, 8, 0, 0
		dc.b 0,	$A, $18, 9, $E8
		dc.b 0,	$A, $18, 0, 0
byte_14401:	dc.b 4
		dc.b $E8, $A, 0, 0, $E8
		dc.b $E8, $A, 0, 9, 0
		dc.b 0,	$A, $18, 9, $E8
		dc.b 0,	$A, $18, 0, 0
byte_14416:	dc.b 4
		dc.b $E8, $A, 8, 9, $E8
		dc.b $E8, $A, 8, 0, 0
		dc.b 0,	$A, $10, 0, $E8
		dc.b 0,	$A, $10, 9, 0
byte_1442B:	dc.b 4
		dc.b $E8, $A, 0, $12, $E8
		dc.b $E8, $A, 0, $1B, 0
		dc.b 0,	$A, $18, $1B, $E8
		dc.b 0,	$A, $18, $12, 0
byte_14440:	dc.b 4
		dc.b $E8, $A, 8, $1B, $E8
		dc.b $E8, $A, 8, $12, 0
		dc.b 0,	$A, $10, $12, $E8
		dc.b 0,	$A, $10, $1B, 0
		even