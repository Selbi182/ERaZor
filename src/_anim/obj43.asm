; ---------------------------------------------------------------------------
; Animation script - Roller enemy
; ---------------------------------------------------------------------------
		dc.w byte_E190-Ani_obj43
		dc.w byte_E196-Ani_obj43
		dc.w byte_E19C-Ani_obj43
		dc.w byte_E196x-Ani_obj43
byte_E190:	dc.b $F, 0, $FF, 0		; standing
byte_E196:	dc.b 2, 1, 2, $FD, 2, 0		; change to ball
byte_E19C:	dc.b 2,	3, 4, 2, $FF		; rolling
byte_E196x:	dc.b 2, 2, 1, $FD, 0, 0		; uncurl
		even