; ---------------------------------------------------------------------------
; Sprite mappings - pole that breaks (LZ)
; ---------------------------------------------------------------------------
		dc.w byte_11326-Map_obj0B
		dc.w byte_11331-Map_obj0B
byte_11326:	dc.b 2			; normal pole
		dc.b $E0, 3, 0,	0, $FC
		dc.b 0,	3, $10,	0, $FC
byte_11331:	dc.b 4			; broken pole
		dc.b $E0, 1, 0,	0, $FC
		dc.b $F0, 5, 0,	4, $FC
		dc.b 0,	5, $10,	4, $FC
		dc.b $10, 1, $10, 0, $FC
		even