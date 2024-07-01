; ---------------------------------------------------------------------------
; Sprite mappings - Eggman (boss levels)
; ---------------------------------------------------------------------------
		dc.w byte_17D26-Map_Eggman, byte_17D45-Map_Eggman
		dc.w byte_17D50-Map_Eggman, byte_17D5B-Map_Eggman
		dc.w byte_17D6B-Map_Eggman, byte_17D7B-Map_Eggman
		dc.w byte_17D8B-Map_Eggman, byte_17D9B-Map_Eggman
		dc.w byte_17DB0-Map_Eggman, byte_17DB6-Map_Eggman
		dc.w byte_17DBC-Map_Eggman, byte_17DBD-Map_Eggman
		dc.w byte_17DC8-Map_Eggman
byte_17D26:	dc.b 6
		dc.b $EC, 1, 0,	$A, $E4
		dc.b $EC, 5, 0,	$C, $C
		dc.b $FC, $E, $20, $10,	$E4
		dc.b $FC, $E, $20, $1C,	4
		dc.b $14, $C, $20, $28,	$EC
		dc.b $14, 0, $20, $2C, $C
byte_17D45:	dc.b 2
		dc.b $E4, 4, 0,	0, $F4
		dc.b $EC, $D, 0, 2, $EC
byte_17D50:	dc.b 2
		dc.b $E4, 4, 0,	0, $F4
		dc.b $EC, $D, 0, $35, $EC
byte_17D5B:	dc.b 3
		dc.b $E4, 8, 0,	$3D, $F4
		dc.b $EC, 9, 0,	$40, $EC
		dc.b $EC, 5, 0,	$46, 4
byte_17D6B:	dc.b 3
		dc.b $E4, 8, 0,	$4A, $F4
		dc.b $EC, 9, 0,	$4D, $EC
		dc.b $EC, 5, 0,	$53, 4
byte_17D7B:	dc.b 3
		dc.b $E4, 8, 0,	$57, $F4
		dc.b $EC, 9, 0,	$5A, $EC
		dc.b $EC, 5, 0,	$60, 4
byte_17D8B:	dc.b 3
		dc.b $E4, 4, 0,	$64, 4
		dc.b $E4, 4, 0,	0, $F4
		dc.b $EC, $D, 0, $35, $EC
byte_17D9B:	dc.b 4
		dc.b $E4, 9, 0,	$66, $F4
		dc.b $E4, 8, 0,	$57, $F4
		dc.b $EC, 9, 0,	$5A, $EC
		dc.b $EC, 5, 0,	$60, 4
byte_17DB0:	dc.b 1
		dc.b 4,	5, 0, $2D, $22
byte_17DB6:	dc.b 1
		dc.b 4,	5, 0, $31, $22
byte_17DBC:	dc.b 0
byte_17DBD:	dc.b 2
		dc.b 0,	8, 1, $2A, $22
		dc.b 8,	8, $11,	$2A, $22
byte_17DC8:	dc.b 2
		dc.b $F8, $B, 1, $2D, $22
		dc.b 0,	1, 1, $39, $3A
		even