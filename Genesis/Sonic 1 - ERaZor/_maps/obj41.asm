; ---------------------------------------------------------------------------
; Sprite mappings - springs
; ---------------------------------------------------------------------------
		dc.w byte_DD26-Map_obj41
		dc.w byte_DD31-Map_obj41
		dc.w byte_DD37-Map_obj41
		dc.w byte_DD47-Map_obj41
		dc.w byte_DD4D-Map_obj41
		dc.w byte_DD53-Map_obj41
byte_DD26:	dc.b 2
		dc.b $F8, $C, 0, 0, $F0
		dc.b 0,	$C, 0, 4, $F0
byte_DD31:	dc.b 1
		dc.b 0,	$C, 0, 0, $F0
byte_DD37:	dc.b 3
		dc.b $E8, $C, 0, 0, $F0
		dc.b $F0, 5, 0,	8, $F8
		dc.b 0,	$C, 0, $C, $F0
byte_DD47:	dc.b 1
		dc.b $F0, 7, 0,	0, $F8
byte_DD4D:	dc.b 1
		dc.b $F0, 3, 0,	4, $F8
byte_DD53:	dc.b 4
		dc.b $F0, 3, 0,	4, $10
		dc.b $F8, 9, 0,	8, $F8
		dc.b $F0, 0, 0,	0, $F8
		dc.b 8,	0, 0, 3, $F8
		even