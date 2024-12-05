; ---------------------------------------------------------------------------
; Animation script - Roller enemy
; ---------------------------------------------------------------------------
		dc.w byte_E190-Ani_obj43
		dc.w byte_E196-Ani_obj43
		dc.w byte_E19C-Ani_obj43
byte_E190:	dc.b $F, 0, $FF, 0
byte_E196:	dc.b 3, 1, 2, $FD, 2, 0
byte_E19C:	dc.b 2,	3, 4, 2, $FF
		even