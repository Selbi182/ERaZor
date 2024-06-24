; ---------------------------------------------------------------------------
; Animation script - Motobug enemy
; ---------------------------------------------------------------------------
		dc.w byte_F788-Ani_obj40
		dc.w byte_F78C-Ani_obj40
		dc.w byte_F792-Ani_obj40
byte_F788:	dc.b $F, 2, $FF, 0
byte_F78C:	dc.b 7,	0, 1, 0, 2, $FF
byte_F792:	dc.b 1,	3, 6, 3, 6, 4, 6, 4, 6,	4, 6, 5, $FC, 0
		even