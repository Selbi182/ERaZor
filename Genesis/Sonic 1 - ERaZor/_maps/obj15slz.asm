; ---------------------------------------------------------------------------
; Sprite mappings - SLZ	swinging platforms
; ---------------------------------------------------------------------------
		dc.w byte_7C6C-Map_obj15a
		dc.w byte_7C95-Map_obj15a
		dc.w byte_7C9B-Map_obj15a
byte_7C6C:	dc.b 8
		dc.b $F0, $F, 0, 4, $E0
		dc.b $F0, $F, 8, 4, 0
		dc.b $F0, 5, 0,	$14, $D0
		dc.b $F0, 5, 8,	$14, $20
		dc.b $10, 4, 0,	$18, $E0
		dc.b $10, 4, 8,	$18, $10
		dc.b $10, 1, 0,	$1A, $F8
		dc.b $10, 1, 8,	$1A, 0
byte_7C95:	dc.b 1
		dc.b $F8, 5, $40, 0, $F8
byte_7C9B:	dc.b 1
		dc.b $F8, 5, 0,	$1C, $F8
		even