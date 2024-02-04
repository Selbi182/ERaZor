; =============================================================================================
; Project Name:		TrollMusic
; Created:		4th February 2024
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

TrollMusic_Header:
	smpsHeaderVoice	TrollMusic_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$01,	$05

	smpsHeaderDAC	TrollMusic_DAC
	smpsHeaderFM	TrollMusic_FM1,	smpsPitch01lo,	$0E
	smpsHeaderFM	TrollMusic_FM2,	smpsPitch01lo,	$09
	smpsHeaderFM	TrollMusic_FM3,	smpsPitch01lo,	$0D
	smpsHeaderFM	TrollMusic_FM4,	smpsPitch01lo,	$0D
	smpsHeaderFM	TrollMusic_FM5,	smpsPitch01lo,	$17
	smpsHeaderPSG	TrollMusic_PSG1,	smpsPitch04lo,	$05,	$05
	smpsHeaderPSG	TrollMusic_PSG2,	smpsPitch03lo,	$05,	$05
	smpsHeaderPSG	TrollMusic_PSG3,	smpsPitch00,	$03,	$04

; FM1 Data
TrollMusic_FM1:
	smpsFMvoice	$00
	dc.b		nRst,	$60
	smpsCall	TrollMusic_Call01
	dc.b		nRst,	$60
	smpsAlterVol	$FB
	dc.b		nRst,	$0C,	nE6,	$06,	nRst,	nB6,	nE6,	$06
	dc.b		nRst,	$0C,	nE6,	$06,	nRst,	nB6,	nE6,	$06
	dc.b		nRst,	$18
	smpsAlterVol	$05
	dc.b		nRst,	$0C,	nA3,	nRst,	nA3,	nRst,	$24
	smpsAlterNote	$02
	smpsAlterVol	$08
	dc.b		nA2,	$6C
	smpsStop

TrollMusic_Call01:
	dc.b		nRst,	$0C,	nCs6,	$15,	nRst,	$03,	nCs6,	$06
	dc.b		nRst,	nD6,	$0F,	nRst,	$03,	nB5,	$18,	nRst
	dc.b		$06,	nCs6,	nRst,	nCs6,	nRst,	nCs6,	nRst,	nA5
	dc.b		nRst,	nG5,	$0F,	nRst,	$03,	nB5,	$18,	nRst
	dc.b		$06
	smpsLoop	$00,	$02,	TrollMusic_Call01
	smpsReturn

; FM2 Data
TrollMusic_FM2:
	smpsFMvoice	$01
	smpsE2		$01
	dc.b		nRst,	$60
TrollMusic_Loop01:
	dc.b		nA3,	$06,	nRst,	nA3,	nRst,	nE3,	nRst,	nE3
	dc.b		nRst,	nG3,	$12,	nFs3,	$0C,	nG3,	$06,	nFs3
	dc.b		$0C,	nA3,	$06,	nRst,	nA3,	nRst,	nE3,	nRst
	dc.b		nE3,	nRst,	nD4,	$12,	nCs4,	$0C,	nD4,	$06
	dc.b		nCs4,	$0C
	smpsLoop	$00,	$02,	TrollMusic_Loop01
	dc.b		nG3,	$06,	nRst,	nE3,	nRst,	nF3,	nRst,	nFs3
	dc.b		nRst,	nG3,	nG3,	nE3,	nRst,	nF3,	nRst,	nG3
	dc.b		nRst,	nE3,	nRst,	nE3,	nRst,	nAb3,	nRst,	nAb3
	dc.b		nRst,	nB3,	nRst,	nB3,	nRst,	nD4,	nRst,	nD4
	dc.b		nRst,	nRst,	$0C,	nA2,	$12,	nRst,	$06,	nA2
	dc.b		$12,	nAb3,	nA3,	$06,	nRst
	smpsAlterVol	$FD
	dc.b		nA2,	$6C
	smpsE2		$01
	smpsStop

; FM3 Data
TrollMusic_FM3:
	smpsFMvoice	$02
	dc.b		nRst,	$60
TrollMusic_Loop02:
	dc.b		nE6,	$06,	nRst,	nE6,	nRst,	nCs6,	nRst,	nCs6
	dc.b		nRst,	nD6,	$12,	nD6,	$1E,	nE6,	$06,	nRst
	dc.b		nE6,	nRst,	nCs6,	nRst,	nCs6,	nRst,	nG6,	$12
	dc.b		nG6,	$1E
	smpsLoop	$00,	$02,	TrollMusic_Loop02
	dc.b		nRst,	$0C,	nD6,	$12,	nRst,	$06,	nD6,	nRst
	dc.b		nCs6,	$12,	nD6,	nCs6,	$0C,	nAb5,	$18,	nB5
	dc.b		nD6,	nAb6,	nRst,	$0C,	nE6,	nRst,	nE6,	$12
	dc.b		nEb6,	nE6,	$06,	nRst
	smpsAlterVol	$F8
	smpsFMvoice	$01
	smpsAlterNote	$03
	dc.b		nA2,	$6C
	smpsStop

; FM4 Data
TrollMusic_FM4:
	smpsFMvoice	$02
	dc.b		nRst,	$60
TrollMusic_Loop03:
	dc.b		nCs6,	$06,	nRst,	nCs6,	nRst,	nA5,	nRst,	nA5
	dc.b		nRst,	nB5,	$12,	nB5,	$1E,	nCs6,	$06,	nRst
	dc.b		nCs6,	nRst,	nA5,	nRst,	nA5,	nRst,	nD6,	$12
	dc.b		nD6,	$1E
	smpsLoop	$00,	$02,	TrollMusic_Loop03
	smpsAlterNote	$03
	smpsAlterVol	$08
	smpsCall	TrollMusic_Call02
	smpsAlterVol	$F0
	smpsFMvoice	$01
	smpsModSet	$00,	$01,	$06,	$04
	dc.b		nA2,	$6C
	smpsStop

TrollMusic_Call02:
	smpsFMvoice	$00
	dc.b		nRst,	$0C,	nG6,	nB6,	nD7,	nFs7,	$0C,	nRst
	dc.b		$06,	nFs7,	$0C,	nG7,	$06,	nFs7,	$0C,	nAb7
	dc.b		$60,	nA7,	$0C,	nRst,	nA7,	nRst,	nRst,	$06
	dc.b		nAb7,	$12,	nA7,	$0C
	smpsReturn

; FM5 Data
TrollMusic_FM5:
	smpsFMvoice	$02
	smpsAlterNote	$03
	smpsAlterVol	$F7
	dc.b		nRst,	$60
	smpsCall	TrollMusic_Call01
	smpsAlterVol	$09
	smpsModSet	$00,	$01,	$06,	$04
	smpsCall	TrollMusic_Call02
	smpsStop

; PSG1 Data
TrollMusic_PSG1:
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	nRst,	nRst,	$0C
	dc.b		nB5,	$12,	nRst,	$06,	nB5,	nRst,	nA5,	$12
	dc.b		nB5,	nA5,	$0C,	nE5,	$18,	nAb5,	nB5,	nD6
	dc.b		nRst,	$0C,	nCs6,	nRst,	nCs6,	$12,	nC6,	nCs6
	dc.b		$06
	smpsStop

; PSG2 Data
TrollMusic_PSG2:
	smpsAlterNote	$01
	dc.b		nRst,	$60,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		$0C,	nE6,	$06,	nRst,	nB6,	nE6,	nRst,	$0C
	dc.b		nE6,	$06,	nRst,	nB6,	nE6,	nRst,	$18
	smpsStop

; PSG3 Data
TrollMusic_PSG3:
	smpsPSGform	$E7
TrollMusic_Loop04:
	smpsNoteFill	$03
	dc.b		nA5,	$0C
	smpsNoteFill	$0C
	dc.b		$0C
	smpsNoteFill	$03
	dc.b		$0C
	smpsNoteFill	$0C
	dc.b		$0C
	smpsLoop	$00,	$0F,	TrollMusic_Loop04
	smpsNoteFill	$03
	dc.b		nA5,	$06
	smpsNoteFill	$0E
	dc.b		$12
	smpsNoteFill	$03
	dc.b		$0C
	smpsNoteFill	$0F
	dc.b		$0C
	smpsStop

; DAC Data
TrollMusic_DAC:
	dc.b		dKick,	$0C,	dSnare,	dKick,	dSnare,	dKick,	$0C,	dSnare
	dc.b		dKick,	$06,	nRst,	$02,	dSnare,	dSnare,	dSnare,	$09
	dc.b		dSnare,	$03
TrollMusic_Loop05:
	dc.b		dKick,	$0C,	dSnare,	dKick,	dSnare,	dKick,	$0C,	dSnare
	dc.b		dKick,	dSnare,	dKick,	$0C,	dSnare,	dKick,	dSnare,	dKick
	dc.b		$0C,	dSnare,	dKick,	$06,	nRst,	$02,	dSnare,	dSnare
	dc.b		dSnare,	$09,	dSnare,	$03
	smpsLoop	$00,	$03,	TrollMusic_Loop05
	dc.b		dKick,	$0C,	dSnare,	dKick,	dSnare,	dKick,	$06,	dSnare
	dc.b		$12,	dSnare,	$0C,	dKick
	smpsStop

TrollMusic_Voices:	
	dc.b		$40,$70,$33,$30,$70,$FF,$FF,$FF,$FF,$1F,$1F,$1F,$1F,$09,$08,$09
	dc.b		$03,$08,$08,$18,$16,$2C,$1F,$0C,$00;			Voice 00 (bass)
	dc.b		$31,$71,$31,$31,$72,$8D,$08,$08,$5F,$0D,$0B,$01,$0A,$01,$0F,$02
	dc.b		$02,$02,$02,$02,$08,$0D,$16,$04,$00;			Voice 01 (disgusting)
	dc.b		$18,$77,$31,$30,$71,$1F,$1F,$5F,$5F,$0A,$0A,$0C,$0A,$00,$04,$04
	dc.b		$03,$56,$50,$50,$56,$1E,$2D,$0F,$80;			Voice 02 (twang)
	dc.b		$F4,$71,$31,$32,$72,$17,$17,$1F,$14,$1C,$1C,$1C,$1C,$0E,$00,$07
	dc.b		$00,$16,$16,$16,$16,$01,$04,$0E,$05;			Voice 03 (high note)
	even
