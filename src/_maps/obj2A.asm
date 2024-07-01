; ---------------------------------------------------------------------------
; Sprite mappings - doors (SBZ)
; ---------------------------------------------------------------------------
		dc.w byte_89FE-Map_obj2A, byte_8A09-Map_obj2A
		dc.w byte_8A14-Map_obj2A, byte_8A1F-Map_obj2A
		dc.w byte_8A2A-Map_obj2A, byte_8A35-Map_obj2A
		dc.w byte_8A40-Map_obj2A, byte_8A4B-Map_obj2A
		dc.w byte_8A56-Map_obj2A
byte_89FE:	dc.b 2
		dc.b $E0, 7, 8,	0, $F8	; door closed
		dc.b 0,	7, 8, 0, $F8
byte_8A09:	dc.b 2
		dc.b $DC, 7, 8,	0, $F8
		dc.b 4,	7, 8, 0, $F8
byte_8A14:	dc.b 2
		dc.b $D8, 7, 8,	0, $F8
		dc.b 8,	7, 8, 0, $F8
byte_8A1F:	dc.b 2
		dc.b $D4, 7, 8,	0, $F8
		dc.b $C, 7, 8, 0, $F8
byte_8A2A:	dc.b 2
		dc.b $D0, 7, 8,	0, $F8
		dc.b $10, 7, 8,	0, $F8
byte_8A35:	dc.b 2
		dc.b $CC, 7, 8,	0, $F8
		dc.b $14, 7, 8,	0, $F8
byte_8A40:	dc.b 2
		dc.b $C8, 7, 8,	0, $F8
		dc.b $18, 7, 8,	0, $F8
byte_8A4B:	dc.b 2
		dc.b $C4, 7, 8,	0, $F8
		dc.b $1C, 7, 8,	0, $F8
byte_8A56:	dc.b 2
		dc.b $C0, 7, 8,	0, $F8	; door fully open
		dc.b $20, 7, 8,	0, $F8
		even