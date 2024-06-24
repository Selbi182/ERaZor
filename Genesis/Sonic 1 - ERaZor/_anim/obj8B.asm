; ---------------------------------------------------------------------------
; Animation script - Eggman on the "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------
		dc.w byte_5AA8-Ani_obj8B
		dc.w byte_5AAC-Ani_obj8B
		dc.w byte_5AB0-Ani_obj8B
byte_5AA8:	dc.b 5,	0, $FC,	1
byte_5AAC:	dc.b 5,	2, $FC,	3
byte_5AB0:	dc.b 7,	4, 5, 6, 5, 4, 5, 6, 5,	4, 5, 6, 5, 7, 5, 6, 5,	$FF
		even