; ---------------------------------------------------------------------------
; Animation script - Chopper enemy
; ---------------------------------------------------------------------------
		dc.w byte_ABBE-Ani_obj2B
		dc.w byte_ABC2-Ani_obj2B
		dc.w byte_ABC6-Ani_obj2B
byte_ABBE:	dc.b 7,	0, 1, $FF
byte_ABC2:	dc.b 3,	0, 1, $FF
byte_ABC6:	dc.b 7,	0, $FF
		even