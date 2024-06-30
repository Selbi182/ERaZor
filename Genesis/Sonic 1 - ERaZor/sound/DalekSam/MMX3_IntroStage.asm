; =============================================================================================
; Project Name:		MMX3_IntroStage
; Created:		30th June 2024
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

MMX3_IntroStage_Header:
	smpsHeaderVoice	MMX3_IntroStage_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$01,	$06

	smpsHeaderDAC	MMX3_IntroStage_DAC
	smpsHeaderFM	MMX3_IntroStage_FM1,	smpsPitch00,	$06
	smpsHeaderFM	MMX3_IntroStage_FM2,	smpsPitch00,	$07
	smpsHeaderFM	MMX3_IntroStage_FM3,	smpsPitch00,	$08
	smpsHeaderFM	MMX3_IntroStage_FM4,	smpsPitch00,	$0B
	smpsHeaderFM	MMX3_IntroStage_FM5,	smpsPitch00,	$0B
	smpsHeaderPSG	MMX3_IntroStage_PSG1,	smpsPitch00,	$00,	$00
	smpsHeaderPSG	MMX3_IntroStage_PSG2,	smpsPitch00,	$00,	$00
	smpsHeaderPSG	MMX3_IntroStage_PSG3,	smpsPitch00,	$00,	$00

; DAC Data
MMX3_IntroStage_DAC:
	smpsAlterNote	$02
	dc.b		dKick,	$10,	dSnare,	dKick,	$08,	$08,	dSnare,	$10
	dc.b		dKick,	dSnare,	dKick,	$08,	dSnare,	$10,	dKick,	$18
	dc.b		dSnare,	$10,	dKick,	$08,	$08,	dSnare,	dKick,	$10
	dc.b		$08,	dSnare,	$10,	$08,	dKick,	dSnare,	dKick,	$10
	dc.b		$04,	$04,	dSnare,	$10,	dKick,	$08,	$08,	dSnare
	dc.b		$10,	dKick,	dSnare,	dKick,	$04,	$04,	dSnare,	$08
	dc.b		dKick,	dKick,	$10,	$08,	dSnare,	$10,	dKick,	$08
	dc.b		$08,	dSnare,	dKick,	$10,	$04,	$04,	dSnare,	$10
	dc.b		$10,	$08,	dKick,	$18,	dSnare,	$10,	dKick,	dSnare
	dc.b		dKick,	$08,	$08,	dSnare,	dKick,	$10,	$08,	$08
	dc.b		$10,	$08,	dSnare,	$10,	dKick,	dSnare,	$08,	dKick
	dc.b		$18,	dSnare,	$08,	dKick,	$04,	$04,	$04,	$04
	dc.b		$04,	$04,	dSnare,	$08,	dKick,	$18,	dSnare,	$10
	dc.b		dKick,	dSnare,	dKick,	$08,	$08,	dSnare,	$10,	dKick
	dc.b		$08,	$08,	$08,	$18,	dSnare,	$10,	dKick,	dSnare
	dc.b		$08,	dKick,	$10,	$08,	dSnare,	dKick,	$10,	$08
	dc.b		dSnare,	dKick
MMX3_IntroStage_Jump01:
	dc.b		nRst,	$10
	smpsFMvoice	$FF
	dc.b		dSnare,	dKick,	$08,	$08,	dSnare,	$10,	dKick,	dSnare
	dc.b		dKick,	$08,	$08,	dSnare,	dKick,	$18,	dSnare,	$10
	dc.b		dKick,	$08,	$08,	dSnare,	$10,	dKick,	$08,	$08
	dc.b		dSnare,	$10,	dKick,	dSnare,	$08,	dKick,	$18,	dSnare
	dc.b		$10,	dKick,	$08,	$08,	dSnare,	$10,	dKick,	dSnare
	dc.b		dKick,	$08,	$08,	dSnare,	dKick,	$18,	dSnare,	$10
	dc.b		dKick,	$08,	$08,	dSnare,	$10,	dKick,	$08,	$08
	dc.b		dSnare,	$10,	dKick,	$04,	$04,	dSnare,	dSnare,	dSnare
	dc.b		$08,	dVLowTimpani,	dKick
MMX3_IntroStage_Loop01:
	dc.b		$10,	$08,	dSnare,	dVLowTimpani,	dKick,	dSnare,	dKick,	dKick
	dc.b		dKick,	dSnare,	$10,	dKick,	$08,	$08,	dSnare,	dKick
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop01
	dc.b		dKick,	$10,	$08,	dSnare,	dVLowTimpani,	dKick,	dSnare,	dKick
	dc.b		$10,	$08,	dSnare,	dVLowTimpani,	dKick,	dKick,	dSnare,	dKick
	dc.b		$10,	$08,	dSnare,	$10,	dKick,	$08,	$08,	dSnare
	dc.b		$10,	dKick,	dKick
MMX3_IntroStage_Loop02:
	dc.b		$08,	dSnare,	dVLowTimpani,	dKick,	dSnare,	dKick,	dKick,	dKick
	dc.b		dSnare,	$10,	dKick,	$08,	$08,	dSnare,	dKick,	dKick
	dc.b		$10
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop02
	dc.b		$08,	dSnare,	dVLowTimpani,	dKick,	dSnare,	dKick,	$10,	$08
	dc.b		dSnare,	dVLowTimpani,	dKick,	dKick,	dSnare,	dKick,	$18,	dSnare
	dc.b		$10,	dKick,	dSnare,	dKick,	dSnare,	dSnare,	$04,	$04
	dc.b		$08,	$08,	dKick,	$10,	$04,	$04,	dSnare,	$10
	dc.b		$10,	$10,	dKick,	dSnare,	dKick,	$08,	$08,	dSnare
	dc.b		$10,	dKick,	dSnare,	dKick,	$08,	dSnare,	$10,	dKick
	dc.b		$18,	dSnare,	$10,	dKick,	$08,	$08,	dSnare,	dKick
	dc.b		$10,	$08,	dSnare,	$10,	$08,	dKick,	dSnare,	dKick
	dc.b		$18,	dSnare,	$10,	dKick,	dSnare,	dKick,	$08,	$08
	dc.b		dSnare,	$10,	dKick,	$08,	$08,	$08,	$18,	dSnare
	dc.b		$10,	dKick,	dSnare,	$08,	dKick,	$10,	$08,	dSnare
	dc.b		dKick,	$10,	$08,	dSnare,	dKick
	smpsJump	MMX3_IntroStage_Jump01

; FM1 Data
MMX3_IntroStage_FM1:
	smpsPan		panCentre,	$00
	smpsAlterNote	$00
	smpsFMvoice	$00
	dc.b		nFs2
MMX3_IntroStage_Loop03:
	dc.b		$08
	smpsLoop	$00,	$0D,	MMX3_IntroStage_Loop03
MMX3_IntroStage_Loop05:
	dc.b		nE2,	$10,	nD2,	nD2,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nE2,	$10,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nFs2,	$10
MMX3_IntroStage_Loop04:
	dc.b		$08
	smpsLoop	$00,	$0C,	MMX3_IntroStage_Loop04
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop05
	dc.b		nE2,	$10,	nD2,	nD2,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nE2,	$10
MMX3_IntroStage_Loop06:
	dc.b		$08
	smpsLoop	$00,	$07,	MMX3_IntroStage_Loop06
	dc.b		nRst
MMX3_IntroStage_Loop07:
	dc.b		nFs2
	smpsLoop	$00,	$0C,	MMX3_IntroStage_Loop07
	dc.b		nE2,	$10,	nD2,	nD2,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nE2,	$10,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nFs2
MMX3_IntroStage_Jump02:
	dc.b		smpsNoAttack
MMX3_IntroStage_Loop08:
	dc.b		$08
	smpsLoop	$00,	$0F,	MMX3_IntroStage_Loop08
	dc.b		nD2,	$10,	$08,	$08,	$08,	$08,	$08,	$08
	dc.b		nE2,	$10,	$08,	$08,	$08,	$08,	$08,	$08
	dc.b		nFs2,	$10
MMX3_IntroStage_Loop09:
	dc.b		$08
	smpsLoop	$00,	$0E,	MMX3_IntroStage_Loop09
	dc.b		nD2,	$10
MMX3_IntroStage_Loop0C:
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	nE2,	$10
MMX3_IntroStage_Loop0A:
	dc.b		$08
	smpsLoop	$00,	$07,	MMX3_IntroStage_Loop0A
	dc.b		nFs2,	$10,	$08,	nE2,	$10,	$08,	nFs2,	$18
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop0A
MMX3_IntroStage_Loop0B:
	dc.b		$08
	smpsLoop	$00,	$07,	MMX3_IntroStage_Loop0B
	dc.b		$10,	$08,	nE2,	$10,	$08,	nD2,	$18
	smpsLoop	$02,	$02,	MMX3_IntroStage_Loop0C
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	nE2,	$10
MMX3_IntroStage_Loop0D:
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	nF2,	$10
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop0D
MMX3_IntroStage_Loop0E:
	dc.b		$08
	smpsLoop	$00,	$07,	MMX3_IntroStage_Loop0E
	dc.b		nFs2
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop0E
	dc.b		nFs2,	nFs2,	nFs2,	nFs2,	nE2,	$10,	nD2,	nD2
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	nE2,	$10
	dc.b		$08,	$08,	$08,	$08,	$08,	$08,	nFs2,	$10
MMX3_IntroStage_Loop0F:
	dc.b		$08
	smpsLoop	$00,	$0C,	MMX3_IntroStage_Loop0F
	dc.b		nE2,	$10,	nD2,	nD2,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nE2,	$10,	$08,	$08,	$08,	$08
	dc.b		$08,	$08,	nFs2
	smpsJump	MMX3_IntroStage_Jump02

; FM2 Data
MMX3_IntroStage_FM2:
	smpsModSet	$00,	$01,	$04,	$04
	smpsLoop	$00,	$03,	MMX3_IntroStage_FM2
	smpsPan		panRight,	$00
	smpsAlterNote	$00
	smpsFMvoice	$02
	dc.b		nFs4,	$04
	smpsPan		panRight,	$00
	dc.b		smpsNoAttack,	$64
MMX3_IntroStage_Loop10:
	dc.b		nCs4,	$10,	nD4,	$40,	nE4,	nFs4,	$70
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop10
	dc.b		nCs4,	$10,	nD4,	$40,	nE4,	nFs4,	$08
MMX3_IntroStage_Jump03:
	dc.b		smpsNoAttack,	$78,	nD4,	$40,	nE4,	nFs4,	$7F,	smpsNoAttack
	dc.b		$01,	nD4,	$40,	nE4,	nRst,	$08
	smpsPan		panCentre,	$00
	smpsFMvoice	$01
	smpsAlterVol	$03
MMX3_IntroStage_Loop11:
	dc.b		nCs5,	$05,	nB4,	$06,	nA4,	$05
	smpsLoop	$00,	$0E,	MMX3_IntroStage_Loop11
	dc.b		nE4,	nFs4,	$06,	nAb4,	$05,	nFs4,	nAb4,	$06
	dc.b		nA4,	$05,	nAb4,	nA4,	$06,	nB4,	$05,	nA4
	dc.b		nB4,	$06,	nCs5,	$05,	nB4,	nCs5,	$06,	nE5
	dc.b		$05
	smpsAlterNote	$06
	dc.b		$01
	smpsAlterNote	$EE
	dc.b		smpsNoAttack,	nF5
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$EE
	dc.b		smpsNoAttack,	nFs5
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44
	smpsAlterNote	$06
	dc.b		$01
	smpsAlterNote	$EA
	dc.b		smpsNoAttack,	nG5
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$EB
	dc.b		smpsNoAttack,	nAb5
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nFs5,	$08,	nE5,	nFs5,	nFs5,	nB4
	dc.b		nA4,	$10,	nAb4
	smpsAlterVol	$08
	dc.b		$08
	smpsAlterVol	$F8
	dc.b		nFs4,	$10
	smpsAlterVol	$08
	dc.b		$08
	smpsAlterVol	$F8
	dc.b		nAb4,	$10
	smpsAlterVol	$08
	dc.b		$08
	smpsAlterVol	$F8
	dc.b		nFs4,	$10,	nAb4,	$08
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nA4
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nB4
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nAb4
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nE4
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nAb4,	nAb4
	smpsAlterVol	$04
	dc.b		$08
	smpsAlterVol	$FC
	dc.b		nFs4,	$10,	nAb4
	smpsAlterNote	$0F
	dc.b		nG4,	$01
	smpsAlterNote	$F1
	dc.b		smpsNoAttack,	nAb4
	smpsAlterNote	$0C
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$EC
	dc.b		smpsNoAttack,	nA4
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nB4,	$10,	nCs5
	smpsAlterVol	$08
	dc.b		$08
	smpsAlterVol	$F8
	dc.b		nE5,	$10
	smpsAlterVol	$08
	dc.b		$08
	smpsAlterVol	$F8
	smpsAlterNote	$06
	dc.b		$01
	smpsAlterNote	$EF
	dc.b		smpsNoAttack,	nF5
	smpsAlterNote	$08
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$EF
	dc.b		smpsNoAttack,	nFs5
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44,	nAb5,	$40,	nA5
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$E1
	dc.b		smpsNoAttack,	nBb5
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$F3
	dc.b		smpsNoAttack,	nB5
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44
	smpsPan		panRight,	$00
	smpsAlterVol	$FB
	dc.b		nFs4,	$78,	nD4,	$40,	nE4,	nFs4,	$7F,	smpsNoAttack
	dc.b		$01,	nD4,	$40,	nE4,	nFs4,	$08
	smpsAlterVol	$02
	smpsJump	MMX3_IntroStage_Jump03

; FM3 Data
MMX3_IntroStage_FM3:
	smpsPan		panLeft,	$00
	smpsModSet	$00,	$01,	$04,	$04
	smpsModSet	$00,	$01,	$04,	$04
	smpsAlterNote	$00
	smpsFMvoice	$02
	smpsModSet	$00,	$01,	$04,	$04
	dc.b		nCs5,	$68
MMX3_IntroStage_Loop12:
	dc.b		nAb4,	$10,	nA4,	$40,	nB4,	nCs5,	$70
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop12
	dc.b		nAb4,	$10,	nA4,	$40,	nB4,	nCs5,	$08
MMX3_IntroStage_Jump04:
	dc.b		smpsNoAttack,	$78,	nA4,	$40,	nB4,	nCs5,	$7F,	smpsNoAttack
	dc.b		$01,	nA4,	$40,	nB4,	$48
	smpsAlterVol	$04
MMX3_IntroStage_Loop13:
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nE3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		nFs2,	$02,	nRst,	$06,	nFs2,	$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs2,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs2,	$18
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop13
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nE3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nD3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06,	nD3,	$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nD3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nD3,	$10,	nE3,	nRst,	$08
	smpsAlterVol	$0A
MMX3_IntroStage_Loop14:
	dc.b		nE2,	$02,	nRst,	$06
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop14
	smpsAlterVol	$F6
MMX3_IntroStage_Loop15:
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nE3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		nFs2,	$02,	nRst,	$06,	nFs2,	$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs2,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nFs2,	$18
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop15
	dc.b		nFs3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nE3,	$10
	smpsAlterVol	$0A
	dc.b		$02,	nRst,	$06
	smpsAlterVol	$F6
	dc.b		nD3,	$48,	nE3,	$40,	nF3,	nAb3,	$46,	nRst
	dc.b		$02
	smpsAlterVol	$FC
	dc.b		nCs5,	$68,	nAb4,	$10,	nA4,	$40,	nB4,	nCs5
	dc.b		$70,	nAb4,	$10,	nA4,	$40,	nB4,	nCs5,	$08
	smpsJump	MMX3_IntroStage_Jump04

; FM4 Data
MMX3_IntroStage_FM4:
	dc.b		smpsModOff,	smpsModOff
	smpsPan		panCentre,	$00
	smpsAlterNote	$00
	smpsFMvoice	$03
	dc.b		smpsModOff,	nFs2,	$07
MMX3_IntroStage_Loop19:
	dc.b		nRst,	$01,	nFs2
MMX3_IntroStage_Loop16:
	dc.b		nRst,	$07,	nFs2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop16
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$03,	nFs2,	$01
	dc.b		nRst,	$07,	nFs2,	nRst,	$01,	nFs2,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0F,	nRst,	$01
	dc.b		nE2,	$0F,	nRst,	$01,	nD2,	$0F,	nRst,	$01
	dc.b		nD2
MMX3_IntroStage_Loop17:
	dc.b		nRst,	$07,	nD2,	$01
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop17
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$03,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$01,	nRst,	$07,	nE2,	$0F
	dc.b		nRst,	$01,	nE2
MMX3_IntroStage_Loop18:
	dc.b		nRst,	$07,	nE2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop18
	dc.b		nRst,	$07,	nFs2,	$0F
	smpsLoop	$01,	$03,	MMX3_IntroStage_Loop19
	dc.b		nRst,	$01,	nFs2
MMX3_IntroStage_Loop1A:
	dc.b		nRst,	$07,	nFs2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop1A
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$03,	nFs2,	$01
	dc.b		nRst,	$07,	nFs2,	nRst,	$01,	nFs2,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0F,	nRst,	$01
	dc.b		nE2,	$0F,	nRst,	$01,	nD2,	$0F,	nRst,	$01
	dc.b		nD2
MMX3_IntroStage_Loop1B:
	dc.b		nRst,	$07,	nD2,	$01
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop1B
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$03,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$01,	nRst,	$07,	nE2,	$1D
	dc.b		nRst,	$03,	nE2,	$1D,	nRst,	$03,	nFs2,	$08
MMX3_IntroStage_Jump05:
	dc.b		smpsNoAttack,	$05
MMX3_IntroStage_Loop1C:
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$07
MMX3_IntroStage_Loop1D:
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop1C
	dc.b		nRst,	$03
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop1D
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$01,	nRst,	$07
	dc.b		nFs2,	$05,	nRst,	$03,	nD2,	$0D
MMX3_IntroStage_Loop1E:
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$07,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop1E
	dc.b		nRst,	$03,	nE2,	$0D
MMX3_IntroStage_Loop1F:
	dc.b		nRst,	$03,	nE2,	$01,	nRst,	$07,	nE2,	$01
	dc.b		nRst,	$07,	nE2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop1F
	dc.b		nRst,	$03,	nFs2,	$0D
MMX3_IntroStage_Loop20:
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$07
MMX3_IntroStage_Loop21:
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop20
	dc.b		nRst,	$03
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop21
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$01,	nRst,	$07
	dc.b		nFs2,	$05,	nRst,	$03,	nD2,	$0D
MMX3_IntroStage_Loop22:
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$07,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop22
	dc.b		nRst,	$03,	nE2,	$0D
MMX3_IntroStage_Loop23:
	dc.b		nRst,	$03,	nE2,	$01,	nRst,	$07,	nE2,	$01
	dc.b		nRst,	$07,	nE2,	$05
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop23
	dc.b		nRst,	$03,	nE2,	$01,	nRst,	$07
MMX3_IntroStage_Loop24:
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nE2,	$0D,	nRst,	$03,	nE2,	$01,	nRst,	$07
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0D,	nRst,	$03
	dc.b		nFs2,	$04,	nRst,	nFs2,	$15,	nRst,	$03
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop24
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nE2,	$0D,	nRst,	$03,	nE2,	$01,	nRst,	$07
	dc.b		nD2,	$0D,	nRst,	$03,	nD2,	$01,	nRst,	$07
	dc.b		nD2,	$01,	nRst,	$07,	nD2,	$0D,	nRst,	$03
	dc.b		nD2,	$04,	nRst,	nD2,	$0D,	nRst,	$03,	nE2
	dc.b		$15,	nRst,	$03
MMX3_IntroStage_Loop25:
	dc.b		nE2,	$01,	nRst,	$07
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop25
MMX3_IntroStage_Loop26:
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nE2,	$0D,	nRst,	$03,	nE2,	$01,	nRst,	$07
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0D,	nRst,	$03
	dc.b		nFs2,	$04,	nRst,	nFs2,	$15,	nRst,	$03
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop26
	dc.b		nFs2,	$0D,	nRst,	$03,	nFs2,	$01,	nRst,	$07
	dc.b		nE2,	$0D,	nRst,	$03,	nE2,	$01,	nRst,	$07
	dc.b		nD2,	$46,	nRst,	$02,	nE2,	$3E,	nRst,	$02
	dc.b		nF2,	$3E,	nRst,	$02,	nAb2,	$46,	nRst,	$02
	dc.b		nFs2,	$07,	nRst,	$01,	nFs2
MMX3_IntroStage_Loop27:
	dc.b		nRst,	$07,	nFs2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop27
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$03,	nFs2,	$01
	dc.b		nRst,	$07,	nFs2,	nRst,	$01,	nFs2,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0F,	nRst,	$01
	dc.b		nE2,	$0F,	nRst,	$01,	nD2,	$0F,	nRst,	$01
	dc.b		nD2
MMX3_IntroStage_Loop28:
	dc.b		nRst,	$07,	nD2,	$01
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop28
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$03,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$01,	nRst,	$07,	nE2,	$0F
	dc.b		nRst,	$01,	nE2
MMX3_IntroStage_Loop29:
	dc.b		nRst,	$07,	nE2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop29
	dc.b		nRst,	$07,	nFs2,	$0F,	nRst,	$01,	nFs2
MMX3_IntroStage_Loop2A:
	dc.b		nRst,	$07,	nFs2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop2A
	dc.b		nRst,	$03,	nFs2,	$01,	nRst,	$03,	nFs2,	$01
	dc.b		nRst,	$07,	nFs2,	nRst,	$01,	nFs2,	nRst,	$07
	dc.b		nFs2,	$01,	nRst,	$07,	nFs2,	$0F,	nRst,	$01
	dc.b		nE2,	$0F,	nRst,	$01,	nD2,	$0F,	nRst,	$01
	dc.b		nD2
MMX3_IntroStage_Loop2B:
	dc.b		nRst,	$07,	nD2,	$01
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop2B
	dc.b		nRst,	$03,	nD2,	$01,	nRst,	$03,	nD2,	$01
	dc.b		nRst,	$07,	nD2,	$01,	nRst,	$07,	nE2,	$0F
	dc.b		nRst,	$01,	nE2
MMX3_IntroStage_Loop2C:
	dc.b		nRst,	$07,	nE2,	$01
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop2C
	dc.b		nRst,	$07,	nFs2,	$08
	smpsJump	MMX3_IntroStage_Jump05

; FM5 Data
MMX3_IntroStage_FM5:
	dc.b		smpsModOff,	smpsModOff
	smpsAlterNote	$00
	smpsFMvoice	$04
	dc.b		smpsModOff
	smpsPan		panCentre,	$00
	dc.b		nCs3,	$06
MMX3_IntroStage_Loop30:
	dc.b		nRst,	$02
MMX3_IntroStage_Loop2D:
	dc.b		nFs2,	$03,	nRst,	$05
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop2D
	dc.b		nFs2,	$03,	nRst,	$01,	nFs2,	$03,	nRst,	$01
	dc.b		nFs2,	$07,	nRst,	$01,	nCs3,	$06,	nRst,	$02
	dc.b		nFs2,	$03,	nRst,	$05,	nFs2,	$03,	nRst,	$05
	dc.b		nCs3,	$0E,	nRst,	$02,	nB2,	$0E,	nRst,	$02
	dc.b		nA2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop2E:
	dc.b		nD2,	$03,	nRst,	$05
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop2E
	dc.b		nD2,	$03,	nRst,	$01,	nD2,	$03,	nRst,	$01
	dc.b		nD2,	$03,	nRst,	$05,	nD2,	$03,	nRst,	$05
	dc.b		nB2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop2F:
	dc.b		nE2,	$03,	nRst,	$05
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop2F
	dc.b		nCs3,	$0E
	smpsLoop	$01,	$03,	MMX3_IntroStage_Loop30
	dc.b		nRst,	$02
MMX3_IntroStage_Loop31:
	dc.b		nFs2,	$03,	nRst,	$05
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop31
	dc.b		nFs2,	$03,	nRst,	$01,	nFs2,	$03,	nRst,	$01
	dc.b		nFs2,	$07,	nRst,	$01,	nCs3,	$06,	nRst,	$02
	dc.b		nFs2,	$03,	nRst,	$05,	nFs2,	$03,	nRst,	$05
	dc.b		nCs3,	$0E,	nRst,	$02,	nB2,	$0E,	nRst,	$02
	dc.b		nA2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop32:
	dc.b		nD2,	$03,	nRst,	$05
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop32
	dc.b		nD2,	$03,	nRst,	$01,	nD2,	$03,	nRst,	$01
	dc.b		nD2,	$03,	nRst,	$05,	nD2,	$03,	nRst,	$05
	dc.b		nB2,	$1E,	nRst,	$02,	nB2,	$1E,	nRst,	$02
	dc.b		nCs3,	$08
MMX3_IntroStage_Jump06:
	dc.b		smpsNoAttack,	$06,	nRst,	$02,	nFs2
MMX3_IntroStage_Loop33:
	dc.b		nRst,	$06,	nFs2,	$02
MMX3_IntroStage_Loop34:
	dc.b		nRst,	$06,	nCs3,	$05,	nRst,	$03,	nFs2,	$02
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop33
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop34
	dc.b		nRst,	$06,	nFs2,	$02,	nRst,	$06,	nCs3,	$05
	dc.b		nRst,	$03,	nA2,	$0E,	nRst,	$02,	nD2,	nRst
	dc.b		$06,	nD2,	$02,	nRst,	$06,	nA2,	$05,	nRst
	dc.b		$03,	nD2,	$02,	nRst,	$06,	nD2,	$02,	nRst
	dc.b		$06,	nA2,	$05,	nRst,	$03,	nB2,	$0E,	nRst
	dc.b		$02,	nE2,	nRst,	$06,	nE2,	$02,	nRst,	$06
	dc.b		nB2,	$05,	nRst,	$03,	nE2,	$02,	nRst,	$06
	dc.b		nE2,	$02,	nRst,	$06,	nB2,	$05,	nRst,	$03
	dc.b		nCs3,	$0E,	nRst,	$02,	nFs2
MMX3_IntroStage_Loop35:
	dc.b		nRst,	$06,	nFs2,	$02
MMX3_IntroStage_Loop36:
	dc.b		nRst,	$06,	nCs3,	$05,	nRst,	$03,	nFs2,	$02
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop35
	smpsLoop	$01,	$02,	MMX3_IntroStage_Loop36
	dc.b		nRst,	$06,	nFs2,	$02,	nRst,	$06,	nCs3,	$05
	dc.b		nRst,	$03,	nA2,	$0E,	nRst,	$02,	nD2,	nRst
	dc.b		$06,	nD2,	$02,	nRst,	$06,	nA2,	$05,	nRst
	dc.b		$03,	nD2,	$02,	nRst,	$06,	nD2,	$02,	nRst
	dc.b		$06,	nA2,	$05,	nRst,	$03,	nB2,	$0E,	nRst
	dc.b		$02,	nE2,	nRst,	$06,	nE2,	$02,	nRst,	$06
	dc.b		nB2,	$05,	nRst,	$03,	nE2,	$02,	nRst,	$06
	dc.b		nE2,	$02,	nRst,	$06,	nB2,	$05,	nRst,	$0B
	smpsPan		panRight,	$00
	smpsAlterVol	$FC
MMX3_IntroStage_Loop37:
	dc.b		nCs3,	$0E,	nRst,	$02,	nCs3,	nRst,	$06,	nB2
	dc.b		$0E,	nRst,	$02,	nB2,	nRst,	$06,	nCs3,	$0E
	dc.b		nRst,	$02,	nCs3,	nRst,	$0E,	nCs3,	nRst,	$02
	dc.b		nFs2,	$05,	nRst,	$03,	nCs3,	$16,	nRst,	$02
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop37
	dc.b		nCs3,	$0E,	nRst,	$02,	nCs3,	nRst,	$06,	nB2
	dc.b		$0E,	nRst,	$02,	nB2,	nRst,	$06,	nA2,	$0E
	dc.b		nRst,	$02,	nA2,	nRst,	$06,	nA2,	$02,	nRst
	dc.b		$06,	nA2,	$0E,	nRst,	$02,	nD2,	$05,	nRst
	dc.b		$03,	nA2,	$0E,	nRst,	$02,	nB2,	$0E,	nRst
	dc.b		$0A
MMX3_IntroStage_Loop38:
	dc.b		nE2,	$05,	nRst,	$03
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop38
MMX3_IntroStage_Loop39:
	dc.b		nCs3,	$0E,	nRst,	$02,	nCs3,	nRst,	$06,	nB2
	dc.b		$0E,	nRst,	$02,	nB2,	nRst,	$06,	nCs3,	$0E
	dc.b		nRst,	$02,	nCs3,	nRst,	$0E,	nCs3,	nRst,	$02
	dc.b		nFs2,	$05,	nRst,	$03,	nCs3,	$16,	nRst,	$02
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop39
	dc.b		nCs3,	$0E,	nRst,	$02,	nCs3,	nRst,	$06,	nB2
	dc.b		$0E,	nRst,	$02,	nB2,	nRst,	$06,	nA2,	$46
	dc.b		nRst,	$02,	nB2,	$3E,	nRst,	$02,	nC3,	$3E
	dc.b		nRst,	$02,	nEb3,	$46,	nRst,	$02
	smpsPan		panCentre,	$00
	smpsAlterVol	$04
	dc.b		nCs3,	$06,	nRst,	$02
MMX3_IntroStage_Loop3A:
	dc.b		nFs2,	$03,	nRst,	$05
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop3A
	dc.b		nFs2,	$03,	nRst,	$01,	nFs2,	$03,	nRst,	$01
	dc.b		nFs2,	$07,	nRst,	$01,	nCs3,	$06,	nRst,	$02
	dc.b		nFs2,	$03,	nRst,	$05,	nFs2,	$03,	nRst,	$05
	dc.b		nCs3,	$0E,	nRst,	$02,	nB2,	$0E,	nRst,	$02
	dc.b		nA2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop3B:
	dc.b		nD2,	$03,	nRst,	$05
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop3B
	dc.b		nD2,	$03,	nRst,	$01,	nD2,	$03,	nRst,	$01
	dc.b		nD2,	$03,	nRst,	$05,	nD2,	$03,	nRst,	$05
	dc.b		nB2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop3C:
	dc.b		nE2,	$03,	nRst,	$05
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop3C
	dc.b		nCs3,	$0E,	nRst,	$02
MMX3_IntroStage_Loop3D:
	dc.b		nFs2,	$03,	nRst,	$05
	smpsLoop	$00,	$05,	MMX3_IntroStage_Loop3D
	dc.b		nFs2,	$03,	nRst,	$01,	nFs2,	$03,	nRst,	$01
	dc.b		nFs2,	$07,	nRst,	$01,	nCs3,	$06,	nRst,	$02
	dc.b		nFs2,	$03,	nRst,	$05,	nFs2,	$03,	nRst,	$05
	dc.b		nCs3,	$0E,	nRst,	$02,	nB2,	$0E,	nRst,	$02
	dc.b		nA2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop3E:
	dc.b		nD2,	$03,	nRst,	$05
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop3E
	dc.b		nD2,	$03,	nRst,	$01,	nD2,	$03,	nRst,	$01
	dc.b		nD2,	$03,	nRst,	$05,	nD2,	$03,	nRst,	$05
	dc.b		nB2,	$0E,	nRst,	$02
MMX3_IntroStage_Loop3F:
	dc.b		nE2,	$03,	nRst,	$05
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop3F
	dc.b		nCs3,	$08
	smpsJump	MMX3_IntroStage_Jump06

; PSG1 Data
MMX3_IntroStage_PSG1:
	smpsModSet	$00,	$02,	$02,	$02
	smpsModSet	$00,	$02,	$02,	$02
	smpsPSGvoice	$00
	smpsModSet	$00,	$02,	$02,	$02
	smpsAlterNote	$00
	dc.b		nFs2,	$60
MMX3_IntroStage_Loop40:
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nCs2
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nD2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nE2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$68
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop40
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nCs2,	nRst,	nD2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nE2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$68
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nCs2
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nD2,	$38
	smpsSetVol	$02
	dc.b		$08,	nRst,	$0C
	smpsSetVol	$03
	smpsAlterNote	$FF
	dc.b		nFs1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nG1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nAb1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nA1,	$08,	nB1,	nAb1,	$10,	nE1
	dc.b		$08,	$04
MMX3_IntroStage_Jump07:
	dc.b		smpsNoAttack,	$04
	smpsAlterNote	$FD
	dc.b		nE1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FD
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C
MMX3_IntroStage_Loop41:
	dc.b		nAb1,	$08,	nA1,	nFs1
	smpsLoop	$00,	$04,	MMX3_IntroStage_Loop41
	dc.b		nAb1,	nA1
	smpsAlterNote	$FF
	dc.b		nB1,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nC2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nCs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$34
	smpsSetVol	$04
	dc.b		$08
	smpsSetVol	$FC
	dc.b		nB1,	$10,	nA1,	$08,	nAb1,	nFs1,	$10,	nAb1
	dc.b		$08,	nA1
	smpsAlterNote	$FE
	dc.b		nE1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C
MMX3_IntroStage_Loop42:
	dc.b		nAb1,	$08,	nA1,	nFs1
	smpsLoop	$00,	$04,	MMX3_IntroStage_Loop42
	dc.b		nAb1,	nA1,	nD2,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nEb2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nE2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$34
	smpsSetVol	$06
	dc.b		$08
	smpsSetVol	$FA
	smpsAlterNote	$FF
	dc.b		nD2,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nEb2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nE2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nCs2,	$08,	nB1
	smpsAlterNote	$FF
	dc.b		nAb2,	$01
	smpsAlterNote	$FD
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nA2
	smpsAlterNote	$01
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nAb2,	$18
MMX3_IntroStage_Loop43:
	dc.b		nCs2,	$05,	nB1,	$06,	nA1,	$05
	smpsLoop	$00,	$0E,	MMX3_IntroStage_Loop43
	dc.b		nE1,	nFs1,	$06,	nAb1,	$05,	nFs1,	nAb1,	$06
	dc.b		nA1,	$05,	nAb1,	nA1,	$06,	nB1,	$05,	nA1
	dc.b		nB1,	$06,	nCs2,	$05,	nB1,	nCs2,	$06,	nE2
	dc.b		$05
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nF2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nFs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nG2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$02
	dc.b		smpsNoAttack,	nAb2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nFs2,	$08,	nE2,	nFs2,	nFs2,	nB1
	dc.b		nA1,	$10,	nAb1
	smpsSetVol	$04
	dc.b		$08
	smpsSetVol	$FC
	dc.b		nFs1,	$10
	smpsSetVol	$04
	dc.b		$08
	smpsSetVol	$FC
	dc.b		nAb1,	$10
	smpsSetVol	$04
	dc.b		$08
	smpsSetVol	$FC
	dc.b		nFs1,	$10,	nAb1,	$08
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nA1
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nB1
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nAb1
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nE1
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nAb1,	nAb1
	smpsSetVol	$01
	dc.b		$08
	smpsSetVol	$FF
	dc.b		nFs1,	$10,	nAb1
	smpsAlterNote	$FE
	dc.b		nG1,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nAb1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nA1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nB1,	$10,	nCs2,	nCs2,	$08,	nE2
	dc.b		$10,	$08
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nF2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nFs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44,	nAb2,	$40,	nA2
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nBb2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nB2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$38
	smpsSetVol	$FB
	dc.b		nFs2,	$60
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nCs2,	nRst,	nD2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nE2,	$38
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$68
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nCs2
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nD2,	$38
	smpsSetVol	$02
	dc.b		$08,	nRst,	$0C
	smpsSetVol	$03
	smpsAlterNote	$FD
	dc.b		nE1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FD
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nA1,	$08,	nB1,	nAb1,	$10,	nE1
	dc.b		$08,	$04
	smpsJump	MMX3_IntroStage_Jump07

; PSG2 Data
MMX3_IntroStage_PSG2:
	smpsPSGvoice	$00
	smpsAlterNote	$00
	dc.b		nAb2,	$60
MMX3_IntroStage_Loop44:
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		$08
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$78
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nAb2,	$68
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop44
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		$08
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$40
	smpsAlterNote	$FF
	dc.b		nFs1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nG1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nAb1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nA1,	$08,	nB1,	nAb1,	$10,	nE1
	dc.b		$08,	$08
	smpsAlterNote	$FD
	dc.b		$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FD
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$04
MMX3_IntroStage_Jump08:
	dc.b		smpsNoAttack,	$08
MMX3_IntroStage_Loop45:
	dc.b		nAb1,	nA1,	nFs1
	smpsLoop	$00,	$04,	MMX3_IntroStage_Loop45
	dc.b		nAb1,	nA1
	smpsAlterNote	$FF
	dc.b		nB1,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nC2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nCs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$34
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nB1,	$10,	nA1,	$08,	nAb1,	nFs1,	$10,	nAb1
	dc.b		$08,	nA1
	smpsAlterNote	$FE
	dc.b		nE1,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C
MMX3_IntroStage_Loop46:
	dc.b		nAb1,	$08,	nA1,	nFs1
	smpsLoop	$00,	$04,	MMX3_IntroStage_Loop46
	dc.b		nAb1,	nA1,	nD2,	$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nEb2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nE2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$34
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	smpsAlterNote	$FF
	dc.b		nD2,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nEb2
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nE2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nCs2,	$08,	nB1
	smpsAlterNote	$FF
	dc.b		nAb2,	$01
	smpsAlterNote	$FD
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nA2
	smpsAlterNote	$01
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nAb2,	$18
MMX3_IntroStage_Loop47:
	dc.b		nCs2,	$05,	nB1,	$06,	nA1,	$05
	smpsLoop	$00,	$0E,	MMX3_IntroStage_Loop47
	dc.b		nE1,	nFs1,	$06,	nAb1,	$05,	nFs1,	nAb1,	$06
	dc.b		nA1,	$05,	nAb1,	nA1,	$06,	nB1,	$05,	nA1
	dc.b		nB1,	$06,	nCs2,	$05,	nB1,	nCs2,	$06,	nE2
	dc.b		$05
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nF2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nFs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nG2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$02
	dc.b		smpsNoAttack,	nAb2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nFs2,	$08,	nE2,	nFs2,	nFs2,	nB1
	dc.b		nA1,	$10,	nAb1
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs1,	$10
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nAb1,	$10
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs1,	$10,	nAb1,	$08,	$08,	nA1,	nA1,	nB1
	dc.b		nB1,	nAb1,	nAb1,	nE1,	nE1,	nAb1,	nAb1,	nAb1
	dc.b		nFs1,	$10,	nAb1
	smpsAlterNote	$FE
	dc.b		nG1,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nAb1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$05
	dc.b		smpsNoAttack,	nA1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nB1,	$10,	nCs2,	nCs2,	$08,	nE2
	dc.b		$10,	$08
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$04
	dc.b		smpsNoAttack,	nF2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nFs2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44,	nAb2,	$40,	nA2
	smpsAlterNote	$FF
	dc.b		$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nBb2
	smpsAlterNote	$FF
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$03
	dc.b		smpsNoAttack,	nB2
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$44,	nAb2,	$60
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		$08
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$78
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nAb2,	$68
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		$08
	smpsSetVol	$02
	dc.b		$08
	smpsSetVol	$FE
	dc.b		nFs2,	$40
	smpsAlterNote	$FE
	dc.b		nFs1,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nG1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$06
	dc.b		smpsNoAttack,	nAb1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$0C,	nA1,	$08,	nB1,	nAb1,	$10,	nE1
	dc.b		$08,	$08
	smpsAlterNote	$FE
	dc.b		$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nF1
	smpsAlterNote	$FE
	dc.b		smpsNoAttack,	$01
	smpsAlterNote	$07
	dc.b		smpsNoAttack,	nFs1
	smpsAlterNote	$00
	dc.b		smpsNoAttack,	$04
	smpsJump	MMX3_IntroStage_Jump08

; PSG3 Data
MMX3_IntroStage_PSG3:
	smpsPSGform	$E7
	smpsAlterNote	$00
	smpsPSGvoice	$02
	dc.b		nA5
MMX3_IntroStage_Loop48:
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop48
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop49:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop49
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4A:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop4A
	smpsSetVol	$03
	dc.b		$04,	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4B:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop4B
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4C:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop4C
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4D:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop4D
	smpsSetVol	$03
	dc.b		$04
	smpsSetVol	$04
	dc.b		$04
	smpsSetVol	$F9
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4E:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop4E
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop4F:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop4F
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop50:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop50
	smpsSetVol	$03
	dc.b		$04
	smpsSetVol	$04
	dc.b		$04
	smpsSetVol	$F9
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop51:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop51
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop52:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop52
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop53:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop53
	smpsSetVol	$03
	dc.b		$04
	smpsSetVol	$04
	dc.b		$04
	smpsSetVol	$F9
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$08
MMX3_IntroStage_Jump09:
	dc.b		smpsNoAttack,	$08
	smpsPSGvoice	$02
MMX3_IntroStage_Loop54:
	smpsSetVol	$03
	dc.b		nA5
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$04,	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop54
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08,	$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop55:
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$04,	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop55
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$04,	$04
MMX3_IntroStage_Loop56:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08,	$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop56
MMX3_IntroStage_Loop57:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop57
MMX3_IntroStage_Loop58:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop58
MMX3_IntroStage_Loop59:
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop59
MMX3_IntroStage_Loop5A:
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop5A
MMX3_IntroStage_Loop5B:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08,	$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop5B
MMX3_IntroStage_Loop5C:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$04,	MMX3_IntroStage_Loop5C
MMX3_IntroStage_Loop5D:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop5D
MMX3_IntroStage_Loop5E:
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop5E
MMX3_IntroStage_Loop5F:
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop5F
MMX3_IntroStage_Loop60:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08,	$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop60
MMX3_IntroStage_Loop61:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop61
MMX3_IntroStage_Loop62:
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop62
MMX3_IntroStage_Loop63:
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop63
MMX3_IntroStage_Loop64:
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsPSGvoice	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$02
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$08,	MMX3_IntroStage_Loop64
MMX3_IntroStage_Loop65:
	smpsSetVol	$FD
	dc.b		$08
	smpsSetVol	$03
	dc.b		$08
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop65
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop66:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop66
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop67:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop67
	smpsSetVol	$03
	dc.b		$04,	$04
	smpsSetVol	$FD
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop68:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$06,	MMX3_IntroStage_Loop68
	smpsPSGvoice	$04
	dc.b		$08
	smpsPSGvoice	$02
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop69:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$03,	MMX3_IntroStage_Loop69
	smpsPSGvoice	$04
	dc.b		$10
	smpsPSGvoice	$02
MMX3_IntroStage_Loop6A:
	smpsSetVol	$03
	dc.b		$08
	smpsSetVol	$FD
	dc.b		$08
	smpsLoop	$00,	$02,	MMX3_IntroStage_Loop6A
	smpsSetVol	$03
	dc.b		$04
	smpsSetVol	$04
	dc.b		$04
	smpsSetVol	$F9
	dc.b		$08
	smpsPSGvoice	$04
	dc.b		$08
	smpsJump	MMX3_IntroStage_Jump09

MMX3_IntroStage_Voices:
	dc.b		$01,$2C,$00,$01,$71,$1F,$1F,$1F,$1F,$08,$08,$11,$06,$00,$02,$00
	dc.b		$00,$33,$36,$46,$16,$2A,$1F,$10,$00;			Voice 00
	dc.b		$3B,$77,$33,$70,$30,$1F,$90,$1F,$1F,$00,$10,$00,$00,$00,$00,$00
	dc.b		$00,$08,$15,$08,$08,$22,$1A,$19,$00;			Voice 01
	dc.b		$3B,$77,$33,$70,$30,$1F,$90,$1F,$1F,$00,$10,$00,$00,$00,$00,$00
	dc.b		$00,$08,$15,$08,$08,$22,$1A,$19,$00;			Voice 02
	dc.b		$28,$33,$53,$70,$30,$DF,$DC,$1F,$1F,$14,$05,$01,$01,$00,$01,$00
	dc.b		$1D,$11,$21,$10,$F8,$0E,$1B,$12,$00;			Voice 03
	dc.b		$38,$53,$51,$51,$51,$DF,$DF,$1F,$1F,$07,$0E,$07,$04,$04,$03,$03
	dc.b		$08,$F7,$31,$71,$68,$1B,$11,$10,$00;			Voice 04
	even
