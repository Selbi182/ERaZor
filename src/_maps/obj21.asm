; ================================================================================
; --------------------------------------------------------------------------------
; Sprite mappings - HUD
; --------------------------------------------------------------------------------

Obj21_Mappings:
		dc.w	Obj21_Blank-Obj21_Mappings	; [$0]
		dc.w	Obj21_Score-Obj21_Mappings	; [$1]
		dc.w	Obj21_Rings-Obj21_Mappings	; [$2]
		dc.w	Obj21_AltRings-Obj21_Mappings	; [$3]
		dc.w	Obj21_AltRings2-Obj21_Mappings	; [$4]
		dc.w	Obj21_Time-Obj21_Mappings	; [$5]
		dc.w	Obj21_Deaths-Obj21_Mappings	; [$6]
		dc.w	Obj21_Death-Obj21_Mappings	; [$7]
		dc.w	Obj21_Fumbles-Obj21_Mappings	; [$8]
		dc.w	Obj21_Boss-Obj21_Mappings	; [$9]
		dc.w	Obj21_ScoreTime-Obj21_Mappings	; [$A]
		dc.w	Obj21_TimeEscape-Obj21_Mappings	; [$B]
; --------------------------------------------------------------------------------

Obj21_Blank	dc.b 0
		dc.b $00, $00, $00, $00, $00	; Blank


Obj21_Score:	dc.b 6
		dc.b $F9, $0D, $80, $00, $C8	; SCOR
		dc.b $F9, $01, $80, $16, $E8	; E

		dc.b $F8, $0D, $80, $18, $F0	; First part of Score Counter
		dc.b $F8, $05, $80, $20, $10	; Second part of Score Counter
		dc.b $F8, $01, $80, $26, $20	; faked zero
		dc.b $F8, $01, $80, $26, $28	; faked zero

Obj21_ScoreTime:dc.b 7
		dc.b $F9, $01, $80, $00, $C8	; S
		dc.b $F9, $01, $80, $16, $D0	; E
		dc.b $F9, $01, $80, $02, $D8	; C
		dc.b $F9, $01, $80, $00, $E0	; S

		dc.b $F8, $01, $80, $1A, $F2	; First part of Score Counter
		dc.b $F8, $05, $80, $1C, $FA	; Second part of Score Counter
		dc.b $F8, $05, $80, $20, $0A	; Third part of Score Counter


Obj21_Rings:	dc.b 4
		dc.b $F8, $09, $80, $30, $DF	; Rings Counter

		dc.b $F9, $01, $80, $06, $01	; R
		dc.b $F9, $09, $80, $0A, $09	; ING
		dc.b $F9, $01, $80, $00, $1D	; S

Obj21_AltRings:	dc.b 4
		dc.b $F8, $09, $A0, $30, $DF	; Rings Counter (Alternate pal 3)

		dc.b $F9, $01, $A0, $06, $01	; R (Alternate)
		dc.b $F9, $09, $A0, $0A, $09	; ING (Alternate)
		dc.b $F9, $01, $A0, $00, $1D	; S (Alternate)

Obj21_AltRings2: dc.b 4
		dc.b $F8, $09, $C0, $30, $DF	; Rings Counter (Alternate pal 4)

		dc.b $F9, $01, $C0, $06, $01	; R (Alternate)
		dc.b $F9, $09, $C0, $0A, $09	; ING (Alternate)
		dc.b $F9, $01, $C0, $00, $1D	; S (Alternate)

Obj21_Time:	dc.b 4
		dc.b $F9, $09, $80, $10, $E0	; TIM
		dc.b $F9, $01, $80, $16, $F6	; E

		dc.b $F8, $01, $80, $28, $07	; First digit of Timer
		dc.b $F8, $05, $80, $2C, $0F	; Second and third digit of Timer

Obj21_TimeEscape: dc.b 3
		dc.b $F9, $09, $80, $10, $E4	; TIM
		dc.b $F9, $01, $80, $16, $FA	; E

		dc.b $F8, $05, $80, $2C, $0B	; Second and third digit of Timer

Obj21_Deaths:	dc.b 6
		dc.b $F8, $01, $80, $24, $C8	; the 10s digit from the score counter
		dc.b $F8, $05, $81, $12, $D0	; Deaths Counter

		dc.b $F9, $01, $81, $0A, $E8	; D
		dc.b $F9, $01, $80, $16, $F0	; E
		dc.b $F9, $09, $81, $0C, $F8	; ATH
		dc.b $F9, $01, $80, $00, $10	; S

Obj21_Death:	dc.b 5
		dc.b $F8, $01, $80, $24, $C8+8	; the 10s digit from the score counter
		dc.b $F8, $05, $81, $12, $D0+8	; Deaths Counter

		dc.b $F9, $01, $81, $0A, $E8+8	; D
		dc.b $F9, $01, $80, $16, $F0+8	; E
		dc.b $F9, $09, $81, $0C, $00	; ATH

Obj21_Fumbles:	dc.b 8
		dc.b $F8, $01, $80, $24, $C8	; the 10s digit from the score counter
		dc.b $F8, $05, $81, $12, $D0	; Deaths Counter

		dc.b $F9, $01, $80, $16, $E8	; E
		dc.b $F9, $01, $80, $06, $F0	; R
		dc.b $F9, $01, $80, $06, $F8	; R
		dc.b $F9, $01, $80, $04, $00	; O
		dc.b $F9, $01, $80, $06, $08	; R
		dc.b $F9, $01, $80, $00, $10	; S

Obj21_Boss:	dc.b 5
		dc.b $F8, $05, $81, $12, $DE	; Boss Health Counter

		dc.b $F9, $01, $A0, $08, $F8	; B
		dc.b $F9, $01, $A0, $04, $00	; O
		dc.b $F9, $01, $A0, $00, $08	; S
		dc.b $F9, $01, $A0, $00, $10	; S

		even
; --------------------------------------------------------------------------------
; ================================================================================