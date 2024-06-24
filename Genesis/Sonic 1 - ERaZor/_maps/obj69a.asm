; ---------------------------------------------------------------------------
; Sprite mappings - spinning platforms (SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_15944-Map_obj69a, byte_1594F-Map_obj69a
		dc.w byte_1595A-Map_obj69a, byte_15965-Map_obj69a
		dc.w byte_15970-Map_obj69a
byte_15944:	dc.b 2
		dc.b $F8, 5, 0,	0, $F0
		dc.b $F8, 5, 8,	0, 0
byte_1594F:	dc.b 2
		dc.b $F0, $D, 0, $14, $F0
		dc.b 0,	$D, 0, $1C, $F0
byte_1595A:	dc.b 2
		dc.b $F0, 9, 0,	4, $F0
		dc.b 0,	9, 0, $A, $F8
byte_15965:	dc.b 2
		dc.b $F0, 9, 0,	$24, $F0
		dc.b 0,	9, 0, $2A, $F8
byte_15970:	dc.b 2
		dc.b $F0, 5, 0,	$10, $F8
		dc.b 0,	5, $10,	$10, $F8
		even