; ---------------------------------------------------------------------------
; Animation script - countdown numbers and bubbles (LZ)
; ---------------------------------------------------------------------------
		dc.w byte_140D6-Ani_obj0A
		dc.w byte_140E0-Ani_obj0A
		dc.w byte_140EA-Ani_obj0A
		dc.w byte_140F4-Ani_obj0A
		dc.w byte_140FE-Ani_obj0A
		dc.w byte_14108-Ani_obj0A
		dc.w byte_14112-Ani_obj0A
		dc.w byte_14118-Ani_obj0A
		dc.w byte_14120-Ani_obj0A
		dc.w byte_14128-Ani_obj0A
		dc.w byte_14130-Ani_obj0A
		dc.w byte_14138-Ani_obj0A
		dc.w byte_14140-Ani_obj0A
		dc.w byte_14148-Ani_obj0A
		dc.w byte_1414A-Ani_obj0A
byte_140D6:	dc.b 5,	0, 1, 2, 3, 4, 9, $D, $FC, 0
byte_140E0:	dc.b 5,	0, 1, 2, 3, 4, $C, $12,	$FC, 0
byte_140EA:	dc.b 5,	0, 1, 2, 3, 4, $C, $11,	$FC, 0
byte_140F4:	dc.b 5,	0, 1, 2, 3, 4, $B, $10,	$FC, 0
byte_140FE:	dc.b 5,	0, 1, 2, 3, 4, 9, $F, $FC, 0
byte_14108:	dc.b 5,	0, 1, 2, 3, 4, $A, $E, $FC, 0
byte_14112:	dc.b $E, 0, 1, 2, $FC, 0
byte_14118:	dc.b 7,	$16, $D, $16, $D, $16, $D, $FC
byte_14120:	dc.b 7,	$16, $12, $16, $12, $16, $12, $FC
byte_14128:	dc.b 7,	$16, $11, $16, $11, $16, $11, $FC
byte_14130:	dc.b 7,	$16, $10, $16, $10, $16, $10, $FC
byte_14138:	dc.b 7,	$16, $F, $16, $F, $16, $F, $FC
byte_14140:	dc.b 7,	$16, $E, $16, $E, $16, $E, $FC
byte_14148:	dc.b $E, $FC
byte_1414A:	dc.b $E, 1, 2, 3, 4, $FC
		even