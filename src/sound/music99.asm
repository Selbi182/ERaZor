; =============================================================================================
; Project Name:		Music99
; Created:		20th July 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

Music99_Header:
	smpsHeaderVoice	Music99_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$01,	$07

	smpsHeaderDAC	Music99_DAC
	smpsHeaderFM	Music99_FM1,	smpsPitch00,	$0B
	smpsHeaderFM	Music99_FM2,	smpsPitch00,	$0B
	smpsHeaderFM	Music99_FM3,	smpsPitch00,	$0C
	smpsHeaderFM	Music99_FM4,	smpsPitch00,	$0C
	smpsHeaderFM	Music99_FM5,	smpsPitch00,	$13
	smpsHeaderPSG	Music99_PSG1,	smpsPitch02lo,	$06,	$00
	smpsHeaderPSG	Music99_PSG2,	smpsPitch02lo,	$02,	$00
	smpsHeaderPSG	Music99_PSG3,	smpsPitch02lo,	$02,	$00

; FM1 Data
Music99_FM1:
	smpsFMvoice	$00
	smpsModSet	$0D,	$01,	$02,	$06
	smpsPan		panCentre,	$00
	dc.b		nRst,	$24,	nE4,	$06,	nF4,	nAb4,	$0C,	nA4
	dc.b		$0A,	nRst,	$0E,	nB4,	$08,	nRst,	$04,	nRst
	dc.b		$0C,	nA4,	nAb4,	nF4,	nE4,	nF4,	nAb4,	nA4
	dc.b		nB4,	$06,	nRst,	nA4,	nRst,	$12,	nB4,	$18
	dc.b		nA4,	$0C,	nB4,	nC5,	nD5,	nB4,	nC5,	nD5
	dc.b		nE5,	nD5,	nC5,	nB4
Music99_Jump01:
	smpsFMvoice	$03
	dc.b		nA5,	$30,	nE5,	nF5,	$48,	nAb5,	$0C,	nB5
	dc.b		nA5,	$30,	nC6,	nB5,	nAb5,	nA5,	nE5,	nF5
	dc.b		$48,	nAb5,	$0C,	nB5,	nA5,	$30,	nC6,	nB5
	dc.b		nE6
	smpsFMvoice	$00
	dc.b		nRst,	$0C,	nD4,	nD4,	nC4,	nC4,	nB3,	nB3
	dc.b		nA3,	nAb3,	$18,	nA3,	$08,	nRst,	$04,	nB3
	dc.b		$08,	nRst,	$34,	nRst,	$0C,	nAb4,	$08,	nRst
	dc.b		$04,	nA4,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nC5,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nA4,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nD5,	$08,	nRst,	$04,	nC5,	$08,	nRst
	dc.b		$04,	nB4,	$08,	nRst,	$04,	nA4,	$08,	nRst
	dc.b		$04,	nAb4,	$08,	nRst,	$04,	nF4,	$08,	nRst
	dc.b		$04,	nE4,	$08,	nRst,	$04,	nD4,	$08,	nRst
	dc.b		$04,	nE5,	$08,	nRst,	$10,	nD5,	$08,	nRst
	dc.b		$40,	nC5,	$08,	nRst,	$10,	nB4,	$08,	nRst
	dc.b		$40,	nE5,	$08,	nRst,	$10,	nD5,	$08,	nRst
	dc.b		$40,	nAb5,	$08,	nRst,	$10,	nF5,	$08,	nRst
	dc.b		$10,	nB5,	$08,	nRst,	$04,	nD6,	$08,	nRst
	dc.b		$04
	smpsFMvoice	$04
	dc.b		nA4,	$0C,	nB4,	nC5,	$0B,	nRst,	$0D,	nC5
	dc.b		$18,	nB4,	$0B,	nRst,	$0D,	nB4,	$18,	nAb4
	dc.b		nA4,	$0C,	nB4,	nRst,	$30,	nRst,	$0C,	nC5
	dc.b		$0B,	nRst,	$19,	nB4,	$0B,	nRst,	$0D,	nA4
	dc.b		$0B,	nRst,	$0D,	nAb4,	$18,	nA4,	$0C,	nE4
	dc.b		$0A,	nRst,	$1A,	nA4,	$0C,	nB4,	nC5,	$0B
	dc.b		nRst,	$0D,	nC5,	$18,	nB4,	$0B,	nRst,	$0D
	dc.b		nB4,	$18,	nAb4,	nA4,	$0C,	nB4,	nRst,	$30
	dc.b		nRst,	$0C,	nC5,	$0B,	nRst,	$19,	nB4,	$0B
	dc.b		nRst,	$0D,	nC5,	$0B,	nRst,	$0D,	nD5,	$0C
	dc.b		nC5,	$06,	nRst,	nD5,	$07,	nRst,	$05,	nE5
	dc.b		$0C,	nD5,	$06,	nRst,	nE5,	$07,	nRst,	$05
	dc.b		nF5,	$0C,	nE5,	$07,	nRst,	$05
	smpsJump	Music99_Jump01
	smpsStop

; FM2 Data
Music99_FM2:
	smpsFMvoice	$01
	smpsModSet	$0D,	$01,	$02,	$06
	smpsPan		panCentre,	$00
Music99_Loop01:
	dc.b		nA1,	$0C,	nC2,	nA1,	nC2,	nA1,	nC2,	nA1
	dc.b		nC2
	smpsLoop	$00,	$03,	Music99_Loop01
	dc.b		nA1,	$0C,	nC2,	nA1,	nC2,	nD2,	nB1,	nAb1
	dc.b		nB1
Music99_Loop02:
	dc.b		nA1,	$0C,	nC2,	nA1,	nC2,	nA1,	nC2,	nA1
	dc.b		nC2,	nAb1,	nB1,	nAb1,	nB1,	nAb1,	nB1,	nAb1
	dc.b		nB1
	smpsLoop	$00,	$04,	Music99_Loop02
Music99_Loop03:
	dc.b		nE1,	$30,	nE1,	$0C,	nE1,	$0A,	nRst,	$1A
	dc.b		nRst,	$0C,	nE1,	nRst,	nE1,	nRst,	$30
	smpsLoop	$00,	$03,	Music99_Loop03
	dc.b		nE1,	$30,	nE1,	$0C,	nE1,	$0A,	nRst,	$1A
	dc.b		nRst,	$0C,	nE1,	nRst,	nE1,	nRst,	nB1,	$24
Music99_Loop04:
	dc.b		nA1,	$0C,	nA1,	nC2,	$0A,	nRst,	$0E,	nA1
	dc.b		$0C,	nA1,	nD2,	$0A,	nRst,	$0E,	nAb1,	$0C
	dc.b		nAb1,	nE2,	$0A,	nRst,	$0E,	nE2,	$0C,	nD2
	dc.b		nC2,	nB1
	smpsLoop	$00,	$04,	Music99_Loop04
	smpsJump	Music99_Loop02
	smpsStop

; FM3 Data
Music99_FM3:
	smpsFMvoice	$02
	smpsModSet	$0D,	$01,	$02,	$06
	smpsPan		panLeft,	$00
	dc.b		nRst,	$60,	nRst,	nB4,	$06,	nRst,	nA4,	nRst
	dc.b		$42,	nC5,	$06,	nRst,	nD5,	nRst,	nB4,	nRst
	dc.b		$1E,	nE5,	$06,	nRst,	nD5,	nRst,	$1E
Music99_Jump02:
	smpsFMvoice	$06
	dc.b		nA4,	$60,	nAb4,	$30,	nD5,	nC5,	$60,	nB4
	dc.b		$30,	nAb4,	nA4,	$60,	nAb4,	$30,	nD5,	nC5
	dc.b		$60,	nB4,	$30,	nAb4
	smpsFMvoice	$05
	dc.b		nRst,	$0C,	nD6,	$08,	nRst,	$04,	nAb6,	$0A
	dc.b		nRst,	$0E,	nAb6,	$0C,	nF6,	$0A,	nRst,	$0E
	dc.b		nD6,	$08,	nRst,	$04,	nRst,	$0C,	nB5,	$08
	dc.b		nRst,	$10,	nAb5,	$08,	nRst,	$28,	nB5,	$06
	dc.b		nC6,	nB5,	$08,	nRst,	$1C,	nAb5,	$08,	nRst
	dc.b		$1C,	nF5,	$08,	nRst,	$10,	nRst,	$0C,	nE5
	dc.b		$08,	nRst,	$1C,	nE5,	$08,	nRst,	$28,	nRst
	dc.b		$0C,	nE5,	nF5,	nAb5,	$08,	nRst,	$04,	nAb5
	dc.b		nA5,	nAb5,	$10,	nF5,	$0C,	nE5,	$08,	nRst
	dc.b		$04,	nRst,	$0C,	nE5,	nD5,	nC5,	nB4,	$04
	dc.b		nC5,	nB4,	$10,	nAb4,	$0C,	nE4,	nRst,	nE5
	dc.b		nF5,	nAb5,	$08,	nRst,	$04,	nAb5,	nA5,	nAb5
	dc.b		$10,	nF5,	$0C,	nE5,	$08,	nRst,	$04,	nA5
	dc.b		nB5,	nA5,	$10,	nAb5,	$0C,	nA5,	nB5,	nD6
	dc.b		nRst,	$18
	smpsFMvoice	$07
	dc.b		nRst,	$60,	nRst,	$3C,	nD5,	$08,	nRst,	$04
	dc.b		nC5,	$08,	nRst,	$04,	nB4,	$08,	nRst,	$04
	dc.b		nRst,	$60,	nRst,	$24,	nB4,	$04,	nC5,	nB4
	dc.b		$34,	nRst,	$60,	nRst,	$3C,	nD5,	$08,	nRst
	dc.b		$04,	nC5,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nRst,	$60,	nB4,	$08,	nRst,	$10,	nA4
	dc.b		$08,	nRst,	$10,	nAb4,	$08,	nRst,	$10,	nE4
	dc.b		$08,	nRst,	$10
	smpsJump	Music99_Jump02
	smpsStop

; FM4 Data
Music99_FM4:
	smpsFMvoice	$02
	smpsModSet	$0D,	$01,	$02,	$06
	smpsPan		panRight,	$00
	dc.b		nRst,	$60,	nRst,	nE4,	$06,	nRst,	nE4,	nRst
	dc.b		$42,	nE4,	$06,	nRst,	nE4,	nRst,	nE4,	nRst
	dc.b		$1E,	nAb4,	$06,	nRst,	nAb4,	nRst,	$1E
Music99_Loop05:
	dc.b		nRst,	$60,	nRst
	smpsFMvoice	$07
	dc.b		nRst,	$18,	nE5,	nC5,	nD5,	nB4,	nC5,	nAb4
	dc.b		nB4
	smpsLoop	$00,	$02,	Music99_Loop05
	dc.b		nRst,	$60,	nRst,	nRst,	nRst
	smpsFMvoice	$00
	dc.b		nC5,	$08,	nRst,	$10,	nB4,	$08,	nRst,	$40
	dc.b		nA4,	$08,	nRst,	$10,	nAb4,	$08,	nRst,	$40
	dc.b		nC5,	$08,	nRst,	$10,	nB4,	$08,	nRst,	$40
	dc.b		nF5,	$08,	nRst,	$10,	nD5,	$08,	nRst,	$10
	dc.b		nAb5,	$08,	nRst,	$04,	nB5,	$08,	nRst,	$10
	dc.b		nB5,	$08,	nRst,	$04
	smpsFMvoice	$06
	dc.b		nA4,	$60,	nB4,	nC5,	nB4,	nA4,	nB4,	nC5
	dc.b		nE5,	$30,	nAb5
	smpsJump	Music99_Loop05
	smpsStop

; FM5 Data
Music99_FM5:
	dc.b		nRst,	$10
	smpsFMvoice	$00
	smpsModSet	$0D,	$01,	$02,	$06
	smpsPan		panCentre,	$00
	dc.b		nRst,	$24,	nE4,	$06,	nF4,	nAb4,	$0C,	nA4
	dc.b		$0A,	nRst,	$0E,	nB4,	$08,	nRst,	$04,	nRst
	dc.b		$0C,	nA4,	nAb4,	nF4,	nE4,	nF4,	nAb4,	nA4
	dc.b		nB4,	$06,	nRst,	nA4,	nRst,	$12,	nB4,	$18
	dc.b		nA4,	$0C,	nB4,	nC5,	nD5,	nB4,	nC5,	nD5
	dc.b		nE5,	nD5,	nC5,	nB4
Music99_Jump03:
	smpsFMvoice	$03
	dc.b		nA5,	$30,	nE5,	nF5,	$48,	nAb5,	$0C,	nB5
	dc.b		nA5,	$30,	nC6,	nB5,	nAb5,	nA5,	nE5,	nF5
	dc.b		$48,	nAb5,	$0C,	nB5,	nA5,	$30,	nC6,	nB5
	dc.b		nE6
	smpsFMvoice	$00
	dc.b		nRst,	$0C,	nD4,	nD4,	nC4,	nC4,	nB3,	nB3
	dc.b		nA3,	nAb3,	$18,	nA3,	$08,	nRst,	$04,	nB3
	dc.b		$08,	nRst,	$34,	nRst,	$0C,	nAb4,	$08,	nRst
	dc.b		$04,	nA4,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nC5,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nA4,	$08,	nRst,	$04,	nB4,	$08,	nRst
	dc.b		$04,	nD5,	$08,	nRst,	$04,	nC5,	$08,	nRst
	dc.b		$04,	nB4,	$08,	nRst,	$04,	nA4,	$08,	nRst
	dc.b		$04,	nAb4,	$08,	nRst,	$04,	nF4,	$08,	nRst
	dc.b		$04,	nE4,	$08,	nRst,	$04,	nD4,	$08,	nRst
	dc.b		$04,	nE5,	$08,	nRst,	$10,	nD5,	$08,	nRst
	dc.b		$40,	nC5,	$08,	nRst,	$10,	nB4,	$08,	nRst
	dc.b		$40,	nE5,	$08,	nRst,	$10,	nD5,	$08,	nRst
	dc.b		$40,	nAb5,	$08,	nRst,	$10,	nF5,	$08,	nRst
	dc.b		$10,	nB5,	$08,	nRst,	$04,	nD6,	$08,	nRst
	dc.b		$04
	smpsFMvoice	$04
	dc.b		nA4,	$0C,	nB4,	nC5,	$0B,	nRst,	$0D,	nC5
	dc.b		$18,	nB4,	$0B,	nRst,	$0D,	nB4,	$18,	nAb4
	dc.b		nA4,	$0C,	nB4,	nRst,	$30,	nRst,	$0C,	nC5
	dc.b		$0B,	nRst,	$19,	nB4,	$0B,	nRst,	$0D,	nA4
	dc.b		$0B,	nRst,	$0D,	nAb4,	$18,	nA4,	$0C,	nE4
	dc.b		$0A,	nRst,	$1A,	nA4,	$0C,	nB4,	nC5,	$0B
	dc.b		nRst,	$0D,	nC5,	$18,	nB4,	$0B,	nRst,	$0D
	dc.b		nB4,	$18,	nAb4,	nA4,	$0C,	nB4,	nRst,	$30
	dc.b		nRst,	$0C,	nC5,	$0B,	nRst,	$19,	nB4,	$0B
	dc.b		nRst,	$0D,	nC5,	$0B,	nRst,	$0D,	nD5,	$0C
	dc.b		nC5,	$06,	nRst,	nD5,	$07,	nRst,	$05,	nE5
	dc.b		$0C,	nD5,	$06,	nRst,	nE5,	$07,	nRst,	$05
	dc.b		nF5,	$0C,	nE5,	$07,	nRst,	$05
	smpsJump	Music99_Jump03
	smpsStop

; DAC Data
Music99_DAC:
	dc.b		dKick,	$18,	dKick,	dKick,	dKick,	$0C,	dSnare
	smpsLoop	$00,	$03,	Music99_DAC
	dc.b		dKick,	$18,	dSnare,	dKick,	$0C,	dSnare,	dSnare,	dSnare
Music99_Loop06:
	dc.b		dKick,	$18,	dKick,	dKick,	dSnare
	smpsLoop	$00,	$07,	Music99_Loop06
	dc.b		dKick,	$0C,	dKick,	dSnare,	dKick,	dKick,	dSnare,	dSnare
	dc.b		dSnare,	dKick,	$18,	dSnare,	dKick,	$0C,	dKick,	dSnare
	dc.b		$18,	nRst,	$0C,	dKick,	dSnare,	dKick,	$0B,	nRst
	dc.b		$19,	dSnare,	$18,	dKick,	dSnare,	dKick,	$0C,	dKick
	dc.b		dSnare,	$18,	dKick,	dSnare,	$0C,	dKick,	dKick,	dKick
	dc.b		dSnare,	dSnare,	$06,	dSnare
Music99_Loop07:
	dc.b		dKick,	$18,	dSnare,	dKick,	$0C,	dKick,	dSnare,	$18
	smpsLoop	$00,	$03,	Music99_Loop07
	dc.b		dKick,	$18,	dSnare,	$0C,	dKick,	dKick,	dSnare,	$06
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare,	dKick,	$18,	dSnare
	dc.b		dKick,	$0C,	dKick,	dSnare,	$18,	dKick,	dSnare,	dKick
	dc.b		$0C,	dKick,	dSnare,	dKick,	dKick,	$18,	dSnare,	dKick
	dc.b		$0C,	dKick,	dSnare,	$18,	dKick,	dSnare,	dKick,	$0C
	dc.b		dKick,	dSnare,	dSnare,	dKick,	$18,	dSnare,	dKick,	$0C
	dc.b		dKick,	dSnare,	$18,	dKick,	dSnare,	dKick,	$0C,	dKick
	dc.b		dSnare,	dKick,	dKick,	$18,	dSnare,	dKick,	$0C,	dKick
	dc.b		dSnare,	$18,	dKick,	dSnare,	dKick,	$0C,	dSnare,	$06
	dc.b		dSnare,	dSnare,	dSnare,	dSnare,	dSnare
	smpsJump	Music99_Loop06
	smpsStop

; PSG1 Data
Music99_PSG1:
	smpsStop

; PSG2 Data
Music99_PSG2:
	smpsStop
	smpsStop

; PSG3 Data
Music99_PSG3:
	smpsStop

Music99_Voices:
	dc.b		$10,$57,$4B,$77,$41,$19,$12,$5F,$1F,$02,$06,$05,$01,$00,$0F,$00
	dc.b		$00,$18,$38,$58,$18,$25,$23,$23,$84;			Voice 00
	dc.b		$38,$75,$12,$71,$11,$DF,$5F,$1F,$1F,$09,$0A,$01,$01,$00,$00,$00
	dc.b		$00,$FF,$FF,$FF,$FF,$19,$1A,$1E,$81;			Voice 01
	dc.b		$02,$73,$52,$41,$11,$17,$16,$15,$17,$0A,$03,$05,$03,$00,$00,$00
	dc.b		$00,$FF,$FF,$FF,$FF,$0A,$1D,$23,$85;			Voice 02
	dc.b		$3D,$40,$02,$23,$71,$0D,$12,$52,$D2,$01,$01,$01,$01,$08,$00,$09
	dc.b		$00,$89,$F8,$F9,$F8,$19,$8B,$8D,$89;			Voice 03
	dc.b		$03,$61,$3E,$23,$41,$10,$10,$0F,$15,$1C,$01,$06,$05,$05,$01,$05
	dc.b		$01,$C9,$0C,$D9,$C9,$18,$19,$17,$83;			Voice 04
	dc.b		$02,$74,$50,$13,$31,$95,$D5,$15,$16,$06,$01,$01,$03,$0C,$13,$0C
	dc.b		$0B,$FF,$EF,$DF,$8F,$32,$18,$23,$81;			Voice 05
	dc.b		$38,$70,$20,$40,$40,$0B,$11,$0F,$10,$02,$03,$02,$02,$00,$06,$04
	dc.b		$07,$1F,$EC,$FF,$E8,$2C,$11,$15,$85;			Voice 06
	dc.b		$24,$44,$72,$17,$63,$1D,$1D,$1D,$1E,$0A,$08,$11,$0B,$00,$00,$00
	dc.b		$00,$57,$58,$57,$58,$19,$89,$32,$83;			Voice 07
	dc.b		$D8,$08,$00,$FF,$FF,$FF,$FF,$0F,$17,$1B,$81,$38,$4F,$47,$40,$40
	dc.b		$1C,$0F,$10,$11,$12,$09,$05,$07,$0D;			Voice 08
	dc.b		$13,$01,$01,$2F,$FF,$1F,$1F,$1B,$13,$17,$81,$13,$0C,$D9,$C9,$18
	dc.b		$17,$17,$88,$02,$74,$50,$13,$31,$95;			Voice 09
	dc.b		$D5,$15,$16,$06,$01,$01,$03,$0C,$13,$0C,$0B,$FF,$EF,$DF,$8F,$3D
	dc.b		$1D,$22,$81,$38,$70,$20,$41,$40,$0B;			Voice 0A
	dc.b		$11,$0F,$10,$02,$03,$02,$02,$00,$06,$04,$07,$1F,$EC,$FF,$E8,$2C
	dc.b		$11,$1A,$85,$24,$44,$72,$17,$63,$1D;			Voice 0B
	dc.b		$1D,$1D,$1E,$0A,$08,$11,$0B,$00,$00,$00,$00,$57,$58,$57,$58,$14
	dc.b		$89,$30,$87,$FF,$FF,$FF,$FF,$FF,$FF;			Voice 0C
	dc.b		$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;			Voice 0D
	even
