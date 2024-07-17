; ---------------------------------------------------------------------------
; Animation script - Bomb enemy
; ---------------------------------------------------------------------------
		dc.w xbyte_11C12-Ani_obj5E
		dc.w xbyte_11C16-Ani_obj5E
		dc.w xbyte_11C1C-Ani_obj5E
		dc.w xbyte_11C20-Ani_obj5E
		dc.w xbyte_11C24-Ani_obj5E
		dc.w xbyte_11C20X-Ani_obj5E
xbyte_11C12:	dc.b 3, 1, 0,	$FF		; idle / explosion
xbyte_11C16:	dc.b 7, 4, 2, 0, 3, $FF		; walking
xbyte_11C1C:	dc.b 7, 7, 6,	$FF		; unused (was explosion)
xbyte_11C20:	dc.b 2,	5, 6, $FF		; fuse
xbyte_11C24:	dc.b 2,	7, 8,	$FF		; bomb
xbyte_11C20X:	dc.b 2,	8, 9, $FF		; fuseX
		even