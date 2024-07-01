; ---------------------------------------------------------------------------
; Animation script - monitors
; ---------------------------------------------------------------------------
		dc.w byte_A51C-Ani_obj26, byte_A522-Ani_obj26, byte_A52E-Ani_obj26
		dc.w byte_A53A-Ani_obj26, byte_A546-Ani_obj26, byte_A552-Ani_obj26
		dc.w byte_A55E-Ani_obj26, byte_A56A-Ani_obj26, byte_A576-Ani_obj26
		dc.w byte_A582-Ani_obj26
byte_A51C:	dc.b 1,	0, 1, 2, $FF, 0
byte_A522:	dc.b 1,	0, 3, 3, 1, 3, 3, 2, 3,	3, $FF,	0
byte_A52E:	dc.b 1,	0, 4, 4, 1, 4, 4, 2, 4,	4, $FF,	0
byte_A53A:	dc.b 1,	0, 5, 5, 1, 5, 5, 2, 5,	5, $FF,	0
byte_A546:	dc.b 1,	0, 6, 6, 1, 6, 6, 2, 6,	6, $FF,	0
byte_A552:	dc.b 1,	0, 7, 7, 1, 7, 7, 2, 7,	7, $FF,	0
byte_A55E:	dc.b 1,	0, 8, 8, 1, 8, 8, 2, 8,	8, $FF,	0
byte_A56A:	dc.b 1,	0, 9, 9, 1, 9, 9, 2, 9,	9, $FF,	0
byte_A576:	dc.b 1,	0, $A, $A, 1, $A, $A, 2, $A, $A, $FF, 0
byte_A582:	dc.b 2,	0, 1, 2, $B, $FE, 1, 0
		even