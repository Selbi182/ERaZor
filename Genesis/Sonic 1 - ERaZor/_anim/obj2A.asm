; ---------------------------------------------------------------------------
; Animation script - doors (SBZ)
; ---------------------------------------------------------------------------
		dc.w Ani_obj2A_Shut-Ani_obj2A
		dc.w Ani_obj2A_Open-Ani_obj2A
Ani_obj2A_Shut:	dc.b 0,	8, 7, 6, 5, 4, 3, 2, 1,	0, $FE,	1
Ani_obj2A_Open:	dc.b 0,	0, 1, 2, 3, 4, 5, 6, 7,	8, $FE,	1
		even