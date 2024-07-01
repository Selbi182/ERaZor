; ---------------------------------------------------------------------------
; Animation script - Burrobot enemy
; ---------------------------------------------------------------------------
		dc.w byte_AE4C-Ani_obj2D
		dc.w byte_AE50-Ani_obj2D
		dc.w byte_AE54-Ani_obj2D
		dc.w byte_AE58-Ani_obj2D
byte_AE4C:	dc.b 3,	0, 6, $FF
byte_AE50:	dc.b 3,	0, 1, $FF
byte_AE54:	dc.b 3,	2, 3, $FF
byte_AE58:	dc.b 3,	4, $FF
		even