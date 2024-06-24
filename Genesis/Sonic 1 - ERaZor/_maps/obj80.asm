; ---------------------------------------------------------------------------
; Sprite mappings - Continue screen
; ---------------------------------------------------------------------------
		dc.w byte_5066-Map_obj80, byte_509E-Map_obj80
		dc.w byte_50AE-Map_obj80, byte_50BE-Map_obj80
		dc.w byte_50CE-Map_obj80, byte_50D9-Map_obj80
		dc.w byte_50D9-Map_obj80, byte_50DF-Map_obj80
byte_5066:	dc.b $B
		dc.b $F8, 5, 0,	$88, $C4 ; "CONTINUE", stars and countdown
		dc.b $F8, 5, 0,	$B2, $D4
		dc.b $F8, 5, 0,	$AE, $E4
		dc.b $F8, 5, 0,	$C2, $F4
		dc.b $F8, 1, 0,	$A0, 4
		dc.b $F8, 5, 0,	$AE, $C
		dc.b $F8, 5, 0,	$C6, $1C
		dc.b $F8, 5, 0,	$90, $2C
		dc.b $38, 5, $20, $21, $E8
		dc.b $38, 5, $20, $21, 8
		dc.b $36, 5, 1,	$FC, $F8
byte_509E:	dc.b 3
		dc.b 4,	5, 0, $15, $FC	; Sonic	on floor
		dc.b $F4, $A, 0, 6, $EC
		dc.b $F4, 6, 0,	$F, 4
byte_50AE:	dc.b 3
		dc.b 4,	5, 0, $19, $FC	; Sonic	on floor #2
		dc.b $F4, $A, 0, 6, $EC
		dc.b $F4, 6, 0,	$F, 4
byte_50BE:	dc.b 3
		dc.b 4,	5, 0, $1D, $FC	; Sonic	on floor #3
		dc.b $F4, $A, 0, 6, $EC
		dc.b $F4, 6, 0,	$F, 4
byte_50CE:	dc.b 2
		dc.b $60, 9, $20, 0, $E8 ; circle on the floor
		dc.b $60, 9, $28, 0, 0
byte_50D9:	dc.b 1
		dc.b 0,	6, 0, $12, 0	; mini Sonic
byte_50DF:	dc.b 1
		dc.b 0,	6, 0, $18, 0	; mini Sonic #2
		even