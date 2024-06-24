; ---------------------------------------------------------------------------
; Animation script - Roller enemy
; ---------------------------------------------------------------------------
		dc.w byte_E190-Ani_obj43
		dc.w byte_E196-Ani_obj43
		dc.w byte_E19C-Ani_obj43
byte_E190:	dc.b $F, 2, 1, 0, $FE, 1
byte_E196:	dc.b $F, 1, 2, $FD, 2, 0
byte_E19C:	dc.b 3,	3, 4, 2, $FF
		even