; ---------------------------------------------------------------------------
; Animation script - Newtron enemy
; ---------------------------------------------------------------------------
		dc.w byte_DF24-Ani_obj42
		dc.w byte_DF28-Ani_obj42
		dc.w byte_DF30-Ani_obj42
		dc.w byte_DF34-Ani_obj42
		dc.w byte_DF38-Ani_obj42
		dc.w byte_DF40-Ani_obj42
byte_DF24:	dc.b $F, $A, $FF, 0
byte_DF28:	dc.b $13, 0, 1,	3, 4, 5, $FE, 1
byte_DF30:	dc.b 2,	6, 7, $FF
byte_DF34:	dc.b 2,	8, 9, $FF
byte_DF38:	dc.b $13, 0, 1,	1, 2, 1, 1, 0, $FC, 0
byte_DF40:	dc.b 2,	2, $FF
		even