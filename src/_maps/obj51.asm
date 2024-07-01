; ---------------------------------------------------------------------------
; Sprite mappings - smashable green block (MZ)
; ---------------------------------------------------------------------------
		dc.w byte_FDD8-Map_obj51
		dc.w byte_FDE3-Map_obj51
byte_FDD8:	dc.b 2
		dc.b $F0, $D, 0, 0, $F0
		dc.b 0,	$D, 0, 0, $F0
byte_FDE3:	dc.b 4
		dc.b $F0, 5, $80, 0, $F0
		dc.b 0,	5, $80,	0, $F0
		dc.b $F0, 5, $80, 0, 0
		dc.b 0,	5, $80,	0, 0
		even