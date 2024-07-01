; ---------------------------------------------------------------------------
; Sprite mappings - "PRESS START BUTTON" and "TM" from title screen
; ---------------------------------------------------------------------------
		dc.w byte_A7CD-Map_obj0F
		dc.w byte_A7CC-Map_obj0F
		dc.w byte_A7EB-Map_obj0F
		dc.w byte_A882-Map_obj0F
byte_A7CC:	dc.b 6			; "PRESS START BUTTON"
byte_A7CD:	dc.b 0,	$C, 0, $F0, 0
		dc.b 0,	0, 0, $F3, $20
		dc.b 0,	0, 0, $F3, $30
		dc.b 0,	$C, 0, $F4, $38
		dc.b 0,	8, 0, $F8, $60
		dc.b 0,	8, 0, $FB, $78
byte_A7EB:	dc.b $1E		; sprite list filler
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $B8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $D8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
		dc.b $F8, $F, 0, 0, $80
byte_A882:	dc.b 1			; "TM"
		dc.b $FC, 4, 0,	0, $F8
		even