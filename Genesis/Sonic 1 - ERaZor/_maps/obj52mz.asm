; ---------------------------------------------------------------------------
; Sprite mappings - moving blocks (MZ, SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_10054-Map_obj52, byte_1005A-Map_obj52
		dc.w byte_10065-Map_obj52, byte_1007A-Map_obj52
		dc.w byte_1008F-Map_obj52
byte_10054:	dc.b 1
		dc.b $F8, $F, 0, 8, $F0
byte_1005A:	dc.b 2
		dc.b $F8, $F, 0, 8, $E0
		dc.b $F8, $F, 0, 8, 0
byte_10065:	dc.b 4
		dc.b $F8, $C, $20, 0, $E0
		dc.b 0,	$D, 0, 4, $E0
		dc.b $F8, $C, $20, 0, 0
		dc.b 0,	$D, 0, 4, 0
byte_1007A:	dc.b 4
		dc.b $F8, $E, 0, 0, $C0
		dc.b $F8, $E, 0, 3, $E0
		dc.b $F8, $E, 0, 3, 0
		dc.b $F8, $E, 8, 0, $20
byte_1008F:	dc.b 3
		dc.b $F8, $F, 0, 8, $D0
		dc.b $F8, $F, 0, 8, $F0
		dc.b $F8, $F, 0, 8, $10
		even