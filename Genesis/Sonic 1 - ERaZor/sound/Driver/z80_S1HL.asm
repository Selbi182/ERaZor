; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic 1 Harder Levels - Sound Driver
; ---------------------------------------------------------------------------

Z80_Data:
		dc.b $F3,$F3,$F3,$31,$FC,$1F,$DD,$21,  0,$40,$AF,$32,$FD,$1F,$32,$FF,$1F,$3E,  1,$32
		dc.b   0,$60,  6,  8,$3E,  0,$32,  0,$60, $F,$10,$FA,$18,$10,  0,  1,  2,  4,  8,$10
		dc.b $20,$40,$80,$FF,$FE,$FC,$F8,$F0,$E0,$C0,$AF,$32,$FA,$1F,$21,$FF,$1F,$7E,$B7,$F2
		dc.b $39,  0,$D6,$81,$77,$11,  0,  0,$FD,$21,$D8,  0,$E6,$F0,$1F,$1F,$1F,$1F,$1F,$47
		dc.b $3A,$FF,$1F,$CB,$27,$CB,$27,$CB,$27,$4F,$FD,  9,$3E,  1,$32,  0,$60,  6,  8,$FD
		dc.b $7E,  6,$32,  0,$60, $F,$10,$FA,$FD,$7E,  7,$32,$FA,$1F,$FD,$5E,  0,$FD,$56,  1
		dc.b $FD,$4E,  2,$FD,$46,  3,$D9,$16,$80,$21,$FD,$1F,$72,$DD,$36,  0,$2B,$1E,$2A,$FD
		dc.b $4E,  4,$DD,$72,  1,$36,  0,$D9,$26,  0,$1A,$E6,$F0, $F, $F, $F, $F,$C6,$22,$6F
		dc.b $7E,$D9,$82,$57,$75,$DD,$73,  0,$DD,$72,  1,$74,$41,$10,$FE,$D9,$1A,$E6, $F,$C6
		dc.b $22,$6F,$7E,$D9,$82,$57,$75,$DD,$73,  0,$DD,$72,  1,$74,$41,$10,$FE,$D9,$3A,$FF
		dc.b $1F,$CB,$7F,$C2,$32,  0,$13, $B,$79,$B0,$C2,$96,  0,$C3,$32,  0

; ===========================================================================
; ---------------------------------------------------------------------------
AlignValue = $0D
; ---------------------------------------------------------------------------

Samples:
		dc.b   0,$80,$13,  2, $B,  0, AlignValue,  0
		dc.b $41,$ED,$94,  7,  3,  0, AlignValue,  0
		dc.b $B8,$8C,$FE,  4, $A,  0, AlignValue,  0
		dc.b $B7, $E,$EE,  4,  8,  0, AlignValue,  0
		dc.b   0,$80,$75,  4, $D,  0, AlignValue+1,0
		dc.b $74,$A1,$A6,  6,$17,  0, AlignValue,  0
		dc.b $1B,$A8,$7E,  3,$39,  0, AlignValue,  0
		dc.b $9A,$AB,$4E,  5,  6,  0, AlignValue,  0
		dc.b $E9,$B0,$C3,  5,$12,  0, AlignValue,  0
		dc.b $88,$D2,$21,  6,  5,  0, AlignValue,  0
		dc.b $88,$D2,$21,  6,  3,  0, AlignValue,  0
		dc.b $88,$D2,$21,  6,  1,  0, AlignValue,  0
		dc.b $AA,$D8,$5A,  9,  3,  0, AlignValue,  0
		dc.b $41,$ED,$94,  7,  3,  0, AlignValue,  0
		dc.b $41,$ED,$94,  7,  3,  0, AlignValue,  0
		dc.b $85,$FC,$CE,  2,  3,  0, AlignValue,  0
		dc.b $B8,$8C,$FE,  4, $E,  0, AlignValue,  0
		dc.b $B8,$8C,$FE,  4,$14,  0, AlignValue,  0
		dc.b $B8,$8C,$FE,  4,$18,  0, AlignValue,  0
		dc.b $9A,$AB,$4E,  5,$1E,  0, AlignValue,  0
		dc.b $9A,$AB,$4E,  5,$24,  0, AlignValue,  0
		dc.b $9A,$AB,$4E,  5,$17,  0, AlignValue,  0
		dc.b $88,$D2,$21,  6,$14,  0, AlignValue,  0
		dc.b $88,$D2,  0,  0,  6,  0, AlignValue,  0 ; silenced (this used to cause glitchy sounds)
		dc.b $88,$D2,$21,  6,$16,  0, AlignValue,  0
		dc.b $AA,$D8,$5A,  9,  9,  0, AlignValue,  0
		dc.b $AA,$D8,$5A,  9,$14,  0, AlignValue,  0
		dc.b $AA,$D8,$5A,  9,$21,  0, AlignValue,  0
		dc.b $41,$ED,$94,  7,  5,  0, AlignValue,  0
		dc.b $E0,$F4,$FF,  1,$17,  0, AlignValue,  0
		dc.b $40,$F8, $D,  4, $C,  0, AlignValue,  0
		dc.b $40,$F8, $D,  4, $C,  0, AlignValue,  0
		dc.b $A6,$96,$5F,  0,  8,  0, AlignValue,  0
		dc.b   6,$97,$86,  4,  7,  0, AlignValue,  0
		dc.b   6,$97,$86,  4, $B,  0, AlignValue,  0
		dc.b   6,$97,$86,  4, $C,  0, AlignValue,  0
		dc.b   6,$97,$86,  4,  8,  0, AlignValue,  0
		dc.b $8D,$9B,$6C,  4, $A,  0, AlignValue,  0
		dc.b $8D,$9B,$6C,  4, $E,  0, AlignValue,  0
		dc.b $8D,$9B,$6C,  4,$16,  0, AlignValue,  0
		dc.b $8D,$9B,$6C,  4,$1A,  0, AlignValue,  0
		dc.b $76,$84,$BD, $D, $F,  0, AlignValue+1,0
		dc.b $8D,$DE,$D2, $B, $F,  0, AlignValue+2,0
		dc.b $8D,$DE,$D2, $B, $F,  0, AlignValue+2,0
		dc.b $8D,$DE,$D2, $B, $F,  0, AlignValue+2,0
		dc.b   7,$99,$6B,  8, $A,  0, AlignValue+1,0
		dc.b $73,$A1,$BC,  8, $A,  0, AlignValue+1,0
		dc.b $30,$AA,$A7,  5, $A,  0, AlignValue+1,0
		dc.b $E0,$AF,$C8,  4,$1B,  0, AlignValue+1,0
		dc.b $B2,$B4,  3,  2,$16,  0, AlignValue+1,0
		dc.b $B6,$B6,$5B,  9, $A,  0, AlignValue+1,0
		dc.b $12,$C0,$31,  5, $D,  0, AlignValue+1,0
		dc.b $44,$C5,$71,$26, $F,  0, AlignValue+1,0
		dc.b $B6,$EB,$51,  3, $F,  0, AlignValue+1,0
		dc.b   8,$EF,$6F,  7,  1,  0, AlignValue+1,0
		dc.b   0,$80,$6F,$18,  1,  0, AlignValue+2,1
		dc.b $70,$98,$38,$25,  1,  0, AlignValue+2,1
		dc.b $78,$F6,  0,  2,  7,  0, AlignValue+1,0
		dc.b $79,$F8,  0,  2,  7,  0, AlignValue+1,0
		dc.b $A9,$BD,$EC,  6, $D,  0, AlignValue+2,0
		dc.b $96,$C4,$22, $D, $A,  0, AlignValue+2,0
		dc.b $96,$C4,$22, $D, $D,  0, AlignValue+2,0
		dc.b $96,$C4,$22, $D, $D,  0, AlignValue+2,0
		dc.b $7A,$FA,$17,  4, $D,  0, AlignValue+1,0
		dc.b $B9,$D1,$D3, $C,  6,  0, AlignValue+2,1
		dc.b $4C,$EC,$A5, $A,  6,  0, AlignValue+2,0
		dc.b $F2,$F6,$EB,  5,  6,  0, AlignValue+2,0
		dc.b $DE,$FC,$10,  3,$26,  0, AlignValue+2,0
		dc.b  $F,$FE,$60,  1,$1A,  0, AlignValue+1,0
		dc.b  $F,$FE,$60,  1,$2A,  0, AlignValue+1,0
		dc.b  $F,$FE,$60,  1,$3E,  0, AlignValue+1,0
		dc.b   0,$80,  8,  6,$10,  0, AlignValue+3,0
		dc.b $1C,$86,$10,  4,$1C,  0, AlignValue+3,0
		dc.b $18,$8E,$4C,  7,  8,  0, AlignValue+3,0
		dc.b $64,$95,$22,  6,$10,  0, AlignValue+3,0
		dc.b $86,$9B,$69,  4,  2,  0, AlignValue+3,0
		dc.b $86,$9B,$69,  4,  6,  0, AlignValue+3,0
		dc.b $EF,$9F,$80,$12,$10,  0, AlignValue+3,0
		dc.b $EF,$9F,$80,$12,$12,  0, AlignValue+3,0
		dc.b $EF,$9F,$80,$12,$12,  0, AlignValue+3,0
		dc.b $68,$B2,$DF,  3, $C,  0, AlignValue+3,0
		even
; ---------------------------------------------------------------------------
; ===========================================================================