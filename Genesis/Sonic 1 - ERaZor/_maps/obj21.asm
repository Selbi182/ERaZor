; ================================================================================
; --------------------------------------------------------------------------------
; Sprite mappings - HUD
; --------------------------------------------------------------------------------

Obj21_Mappings:
		dc.w	Obj21_Blank-Obj21_Mappings	; [$0]
		dc.w	Obj21_Score-Obj21_Mappings	; [$1]
		dc.w	Obj21_Rings-Obj21_Mappings	; [$2]
		dc.w	Obj21_AltRings-Obj21_Mappings	; [$3]
		dc.w	Obj21_Time-Obj21_Mappings	; [$4]
		dc.w	Obj21_Lives-Obj21_Mappings	; [$5]
		dc.w	Obj21_LivesB-Obj21_Mappings	; [$6]
; --------------------------------------------------------------------------------

Obj21_Blank	dc.b 0
		dc.b $00, $00, $00, $00, $00	; Blank

Obj21_Score:	dc.b 5
		dc.b $F9, $0D, $80, $00, $C8	; SCOR
		dc.b $F9, $01, $80, $16, $E8	; E
		dc.b $F8, $0D, $80, $18, $F0	; First part of Score Counter
		dc.b $F8, $09, $80, $20, $10	; Second part of Score Counter
		dc.b $F8, $01, $80, $26, $28	; faked zero

Obj21_Rings:	dc.b 3
		dc.b $F8, $09, $80, $30, $DF	; Rings Counter
		dc.b $F9, $0D, $80, $08, $01	; RING
		dc.b $F9, $01, $80, $00, $1D	; S

Obj21_AltRings:	dc.b 3
		dc.b $F8, $09, $A0, $30, $DE	; Rings Counter (Alternate)
		dc.b $FB, $0D, $A0, $08, $01	; RING (Alternate)
		dc.b $FB, $01, $A0, $00, $1C	; S (Alternate)

Obj21_Time:	dc.b 4
		dc.b $F9, $09, $80, $10, $E0	; TIM
		dc.b $F9, $01, $80, $16, $F6	; E
		dc.b $F8, $01, $80, $28, $07	; First digit of Timer
		dc.b $F8, $05, $80, $2C, $0F	; Second and third digit of Timer

Obj21_Lives:	dc.b 6
		dc.b $F8, $01, $80, $24, $C8	; the 10s digit from the score counter
		dc.b $F8, $05, $81, $12, $D0	; Deaths Counter
		dc.b $F9, $01, $81, $0A, $E8	; D
		dc.b $F9, $01, $80, $16, $F0	; E
		dc.b $F9, $09, $81, $0C, $F8	; ATH
		dc.b $F9, $01, $80, $00, $10	; S

Obj21_LivesB:	dc.b 1
		dc.b $F8, $05, $A1, $12, $08	; Boss Health Counter
		even
; --------------------------------------------------------------------------------
; ================================================================================