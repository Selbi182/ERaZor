; ---------------------------------------------------------------------------
; Animation script - flamethrower (SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_E5C4-Ani_obj6D
		dc.w byte_E5D2-Ani_obj6D
		dc.w byte_E5DC-Ani_obj6D
		dc.w byte_E5EA-Ani_obj6D
byte_E5C4:	dc.b 3,	$16, $17, $FF, 0
byte_E5D2:	dc.b 0,	9, 7, 5, 3, 1, 0, $FE, 1, 0
byte_E5DC:	dc.b 3,	$B, $C,	$D, $E,	$F, $10, $11, $12, $13,	$14, $15, $FE, 2
byte_E5EA:	dc.b 0,	$14, $12, $11, $F, $D, $B, $FE,	1, 0
		even