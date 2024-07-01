; ---------------------------------------------------------------------------
; Sprite mappings - helix of spikes on a pole (GHZ)
; ---------------------------------------------------------------------------
		dc.w byte_7E08-Map_obj17, byte_7E0E-Map_obj17
		dc.w byte_7E14-Map_obj17, byte_7E1A-Map_obj17
		dc.w byte_7E20-Map_obj17, byte_7E26-Map_obj17
		dc.w byte_7E2D+1-Map_obj17, byte_7E2C-Map_obj17
byte_7E08:	dc.b 1
		dc.b $F0, 1, 0,	0, $FC
byte_7E0E:	dc.b 1
		dc.b $F5, 5, 0,	2, $F8
byte_7E14:	dc.b 1
		dc.b $F8, 5, 0,	6, $F8
byte_7E1A:	dc.b 1
		dc.b $FB, 5, 0,	$A, $F8
byte_7E20:	dc.b 1
		dc.b 0,	1, 0, $E, $FC
byte_7E26:	dc.b 1
		dc.b 4,	0, 0, $10, $FD
byte_7E2C:	dc.b 1
byte_7E2D:	dc.b $F4, 0, 0,	$11, $FD
		even