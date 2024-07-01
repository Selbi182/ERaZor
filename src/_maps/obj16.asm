; ---------------------------------------------------------------------------
; Sprite mappings - harpoon (LZ)
; ---------------------------------------------------------------------------
		dc.w byte_11FA6-Map_obj16, byte_11FAC-Map_obj16
		dc.w byte_11FB2-Map_obj16, byte_11FBD-Map_obj16
		dc.w byte_11FC3-Map_obj16, byte_11FC9-Map_obj16
byte_11FA6:	dc.b 1
		dc.b $FC, 4, 0,	0, $F8
byte_11FAC:	dc.b 1
		dc.b $FC, $C, 0, 2, $F8
byte_11FB2:	dc.b 2
		dc.b $FC, 8, 0,	6, $F8
		dc.b $FC, 8, 0,	3, $10
byte_11FBD:	dc.b 1
		dc.b $F8, 1, 0,	9, $FC
byte_11FC3:	dc.b 1
		dc.b $E8, 3, 0,	$B, $FC
byte_11FC9:	dc.b 2
		dc.b $D8, 2, 0,	$B, $FC
		dc.b $F0, 2, 0,	$F, $FC
		even