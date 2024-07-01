; ---------------------------------------------------------------------------
; Animation script - Eggman (bosses)
; ---------------------------------------------------------------------------
		dc.w byte_17CD4-Ani_Eggman
		dc.w byte_17CD8-Ani_Eggman
		dc.w byte_17CDC-Ani_Eggman
		dc.w byte_17CE0-Ani_Eggman
		dc.w byte_17CE4-Ani_Eggman
		dc.w byte_17CE8-Ani_Eggman
		dc.w byte_17CEC-Ani_Eggman
		dc.w byte_17CF0-Ani_Eggman
		dc.w byte_17CF4-Ani_Eggman
		dc.w byte_17CF8-Ani_Eggman
		dc.w byte_17CFC-Ani_Eggman
		dc.w byte_17D00-Ani_Eggman
byte_17CD4:	dc.b $F, 0, $FF, 0
byte_17CD8:	dc.b 5,	1, 2, $FF
byte_17CDC:	dc.b 3,	1, 2, $FF
byte_17CE0:	dc.b 1,	1, 2, $FF
byte_17CE4:	dc.b 4,	3, 4, $FF
byte_17CE8:	dc.b $1F, 5, 1,	$FF
byte_17CEC:	dc.b 3,	6, 1, $FF
byte_17CF0:	dc.b $F, $A, $FF, 0
byte_17CF4:	dc.b 3,	8, 9, $FF
byte_17CF8:	dc.b 1,	8, 9, $FF
byte_17CFC:	dc.b $F, 7, $FF, 0
byte_17D00:	dc.b 2,	9, 8, $B, $C, $B, $C, 9, 8, $FE, 2, 0
		even