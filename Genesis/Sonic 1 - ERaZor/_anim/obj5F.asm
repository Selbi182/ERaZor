; ---------------------------------------------------------------------------
; Animation script - Bomb enemy
; ---------------------------------------------------------------------------
		dc.w byte_11C12-Ani_obj5F
		dc.w byte_11C16-Ani_obj5F
		dc.w byte_11C1C-Ani_obj5F
		dc.w byte_11C20-Ani_obj5F
		dc.w byte_11C24-Ani_obj5F
		dc.w byte_11C20X-Ani_obj5F
byte_11C12:	dc.b 3, 1, 0,	$FF		; idle / explosion
byte_11C16:	dc.b 7, 4, 2, 0, 3, $FF		; walking
byte_11C1C:	dc.b 7, 7, 6,	$FF		; unused (was explosion)
byte_11C20:	dc.b 2,	5, 6, $FF		; fuse
byte_11C24:	dc.b 2,	7, 8,	$FF		; bomb
byte_11C20X:	dc.b 2,	8, 9, $FF		; fuseX
		even