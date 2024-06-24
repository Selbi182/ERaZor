; ---------------------------------------------------------------------------
; Sprite mappings - spiked ball on a chain (SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_10AA6-Map_obj15b, byte_10AC0-Map_obj15b
		dc.w byte_10AC6-Map_obj15b
byte_10AA6:	dc.b 5
		dc.b $E8, 4, 0,	0, $F8
		dc.b $F0, $F, 0, 2, $F0
		dc.b $F8, 1, 0,	$12, $E8
		dc.b $F8, 1, 0,	$14, $10
		dc.b $10, 4, 0,	$16, $F8
byte_10AC0:	dc.b 1
		dc.b $F8, 5, 0,	$20, $F8
byte_10AC6:	dc.b 2
		dc.b $F8, $D, 0, $18, $F0
		dc.b $E8, $D, $10, $18,	$F0
		even