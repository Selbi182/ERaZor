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
byte_11C16:	dc.b 5, 5, 4,	3, 2, $FF	; walking
byte_11C1C:	dc.b 2, 5, 4,	3, 2, $FF	; running
byte_11C20:	dc.b 2,	8, 9, $FF		; fuse
byte_11C24:	dc.b 2,	$A, $B,	$FF		; bomb
byte_11C20X:	dc.b 2,	8, 9, $FF		; fuseX
		even