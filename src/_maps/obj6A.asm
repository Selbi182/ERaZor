; ---------------------------------------------------------------------------
; Sprite mappings - ground saws	and pizza cutters (SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_15BA0-Map_obj6A, byte_15BC4-Map_obj6A
		dc.w byte_15BE8-Map_obj6A, byte_15BFD-Map_obj6A
byte_15BA0:	dc.b 7
		dc.b $C4, 1, 0,	$20, $FC
		dc.b $D4, 1, 0,	$20, $FC
		dc.b $E4, 3, 0,	$20, $FC
		dc.b $E0, $F, 0, 0, $E0
		dc.b $E0, $F, 8, 0, 0
		dc.b 0,	$F, $10, 0, $E0
		dc.b 0,	$F, $18, 0, 0
byte_15BC4:	dc.b 7
		dc.b $C4, 1, 0,	$20, $FC
		dc.b $D4, 1, 0,	$20, $FC
		dc.b $E4, 3, 0,	$20, $FC
		dc.b $E0, $F, 0, $10, $E0
		dc.b $E0, $F, 8, $10, 0
		dc.b 0,	$F, $10, $10, $E0
		dc.b 0,	$F, $18, $10, 0
byte_15BE8:	dc.b 4
		dc.b $E0, $F, 0, 0, $E0
		dc.b $E0, $F, 8, 0, 0
		dc.b 0,	$F, $10, 0, $E0
		dc.b 0,	$F, $18, 0, 0
byte_15BFD:	dc.b 4
		dc.b $E0, $F, 0, $10, $E0
		dc.b $E0, $F, 8, $10, 0
		dc.b 0,	$F, $10, $10, $E0
		dc.b 0,	$F, $18, $10, 0
		even