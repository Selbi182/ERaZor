; =============================================================================================
; Project Name:		M46_Boss
; Created:		6th June 2010
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

M46_Boss_Header:
	smpsHeaderVoice	M46_Boss_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$01,	$0C

	smpsHeaderDAC	M46_Boss_DAC
	smpsHeaderFM	M46_Boss_FM1,	smpsPitch00,	$0A
	smpsHeaderFM	M46_Boss_FM2,	smpsPitch00,	$10
	smpsHeaderFM	M46_Boss_FM3,	smpsPitch01lo,	$0F
	smpsHeaderFM	M46_Boss_FM4,	smpsPitch00,	$14
	smpsHeaderFM	M46_Boss_FM5,	smpsPitch00,	$0F
	smpsHeaderPSG	M46_Boss_PSG1,	smpsPitch02lo,	$0C,	$00
	smpsHeaderPSG	M46_Boss_PSG2,	smpsPitch03lo,	$02,	$00
	smpsHeaderPSG	M46_Boss_PSG3,	smpsPitch02hi+$0B,	$01,	$00

; FM1 Data
M46_Boss_FM1:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$05
M46_Boss_Jump01:
	smpsPan		panCentre,	$00
	smpsFMvoice	$01
	dc.b		nD4,	$0D,	nRst,	$02,	nG4,	$0F,	nFs4,	$04
	dc.b		nRst,	$01,	nG4,	$04,	nRst,	$01,	nD4,	$0F
	dc.b		nRst,	$05,	nG4,	$12,	nRst,	$02,	nD4,	$0D
	dc.b		nRst,	$02,	nG4,	$0F,	nFs4,	$04,	nRst,	$01
	dc.b		nG4,	$04,	nRst,	$01,	nA4,	$0F,	nRst,	$05
	dc.b		nC5,	$12,	nRst,	$02,	nD4,	$0D,	nRst,	$02
	dc.b		nG4,	$0F,	nBb4,	$04,	nRst,	$01,	nC5,	$04
	dc.b		nRst,	$01,	nD5,	$0F,	nRst,	$05,	nF4,	$12
	dc.b		nRst,	$02,	nG4,	$0F,	nRst,	$05,	nD5,	$0A
	dc.b		nC5,	nRst,	nBb4,	$14,	nA4,	$0A,	nF4,	$14
	dc.b		nEb5,	$0A,	nD5,	$14,	nF5,	nD5,	nRst,	$0A
	dc.b		nC5,	nBb4,	$14,	nD5,	nRst,	$0A,	nA4,	$14
	dc.b		nBb4,	$0A,	nA4,	$14,	nG4,	$0A,	nEb4,	nD4
	dc.b		nRst,	$50,	nD4,	$0D,	nRst,	$02,	nG4,	$0F
	dc.b		nFs4,	$04,	nRst,	$01,	nG4,	$04,	nRst,	$01
	dc.b		nD4,	$0F,	nRst,	$05,	nG4,	$12,	nRst,	$02
	dc.b		nD4,	$0D,	nRst,	$02,	nG4,	$0F,	nFs4,	$04
	dc.b		nRst,	$01,	nG4,	$04,	nRst,	$01,	nA4,	$0F
	dc.b		nRst,	$05,	nC5,	$12,	nRst,	$02,	nD4,	$0D
	dc.b		nRst,	$02,	nG4,	$0F,	nBb4,	$04,	nRst,	$01
	dc.b		nC5,	$04,	nRst,	$01,	nD5,	$0F,	nRst,	$05
	dc.b		nF4,	$12,	nRst,	$02,	nG4,	$0F,	nRst,	$05
	dc.b		nD5,	$0A,	nC5,	nRst,	nBb4,	$14,	nA4,	$0A
	dc.b		nF4,	$14,	nEb5,	$0A,	nD5,	$14,	nF5,	nD5
	dc.b		nRst,	$0A,	nC5,	nBb4,	$14,	nD5,	nRst,	$0A
	dc.b		nFs4,	nBb4,	nEb5,	nD5,	$14,	nFs5,	nD5,	$0A
	dc.b		nG5,	$1C,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$2B
	smpsJump	M46_Boss_Jump01

; FM2 Data
M46_Boss_FM2:
	smpsPan		panLeft,	$00
	smpsFMvoice	$00
	dc.b		nG2,	$0A
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panLeft,	$00
	dc.b		nD3,	nG2,	nBb2
	smpsPan		panRight,	$00
	dc.b		nG2,	nD3
	smpsPan		panCentre,	$00
	dc.b		nFs2
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nFs2
	smpsPan		panLeft,	$00
	dc.b		nD3,	nFs2
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panLeft,	$00
	dc.b		nFs2
	smpsPan		panRight,	$00
	dc.b		nD3,	nF2,	nBb2,	nF2
	smpsPan		panLeft,	$00
	dc.b		nD3,	nF2
	smpsPan		panCentre,	$00
	dc.b		nBb2,	nF2,	nD3
	smpsPan		panLeft,	$00
	dc.b		nE2,	nG2,	nBb2
	smpsPan		panRight,	$00
	dc.b		nC3
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nE2
	smpsPan		panRight,	$00
	dc.b		nD3
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panRight,	$00
	dc.b		nD3,	nG2,	nBb2
	smpsPan		panLeft,	$00
	dc.b		nG2
	smpsPan		panRight,	$00
	dc.b		nD3
	smpsPan		panLeft,	$00
	dc.b		nFs2
	smpsPan		panRight,	$00
	dc.b		nBb2,	nFs2
	smpsPan		panCentre,	$00
	dc.b		nD3
	smpsPan		panLeft,	$00
	dc.b		nFs2
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
	smpsPan		panRight,	$00
	dc.b		nF2,	nBb2,	nF2
	smpsPan		panCentre,	$00
	dc.b		nD3
	smpsPan		panRight,	$00
	dc.b		nF2
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nF2,	nD3
	smpsPan		panCentre,	$00
	dc.b		nE2,	nG2
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panLeft,	$00
	dc.b		nC3
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nE2,	nD3
	smpsPan		panLeft,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panLeft,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nD3
	smpsPan		panLeft,	$00
	dc.b		nG2,	nBb2,	nG2
	smpsPan		panRight,	$00
	dc.b		nD3,	nFs2,	nBb2
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
	smpsPan		panLeft,	$00
	dc.b		nFs2,	nBb2
	smpsPan		panRight,	$00
	dc.b		nFs2
	smpsPan		panCentre,	$00
	dc.b		nD3,	nF2
	smpsPan		panRight,	$00
	dc.b		nBb2,	nF2
	smpsPan		panLeft,	$00
	dc.b		nD3,	nF2,	nBb2
	smpsPan		panCentre,	$00
	dc.b		nF2
	smpsPan		panRight,	$00
	dc.b		nD3
	smpsPan		panCentre,	$00
	dc.b		nE2
	smpsPan		panLeft,	$00
	dc.b		nG2,	nBb2
	smpsPan		panCentre,	$00
	dc.b		nC3,	nBb2
	smpsPan		panLeft,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nE2
	smpsPan		panRight,	$00
	dc.b		nD3,	nF2
	smpsPan		panLeft,	$00
	dc.b		nC3
	smpsPan		panCentre,	$00
	dc.b		nF3
	smpsPan		panLeft,	$00
	dc.b		nG3
	smpsPan		panRight,	$00
	dc.b		nF3,	nC3
	smpsPan		panLeft,	$00
	dc.b		nF2
	smpsPan		panCentre,	$00
	dc.b		nA2
	smpsPan		panLeft,	$00
	dc.b		nBb2,	nF3,	nBb3,	nA3,	nF3,	nD3,	nBb2
	smpsPan		panRight,	$00
	dc.b		nF2,	nEb2,	nBb2
	smpsPan		panCentre,	$00
	dc.b		nEb3
	smpsPan		panLeft,	$00
	dc.b		nF3
	smpsPan		panRight,	$00
	dc.b		nEb3
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panLeft,	$00
	dc.b		nEb2,	nBb2
	smpsPan		panRight,	$00
	dc.b		nD2
	smpsPan		panLeft,	$00
	dc.b		nA2,	nC3
	smpsPan		panRight,	$00
	dc.b		nD3,	nC3
	smpsPan		panCentre,	$00
	dc.b		nA2
	smpsPan		panRight,	$00
	dc.b		nD2
	smpsPan		panLeft,	$00
	dc.b		nFs2
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panRight,	$00
	dc.b		nBb2,	nG2
	smpsPan		panLeft,	$00
	dc.b		nD3,	nG2
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nG2
	smpsPan		panLeft,	$00
	dc.b		nD3
	smpsPan		panRight,	$00
	dc.b		nFs2
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nFs2,	nD3
	smpsPan		panLeft,	$00
	dc.b		nFs2,	nBb2
	smpsPan		panCentre,	$00
	dc.b		nFs2,	nD3
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nF3
	smpsPan		panLeft,	$00
	dc.b		nBb3
	smpsPan		panRight,	$00
	dc.b		nA3
	smpsPan		panLeft,	$00
	dc.b		nF3
	smpsPan		panRight,	$00
	dc.b		nD3,	nBb2
	smpsPan		panLeft,	$00
	dc.b		nF2,	nE2
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panRight,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nC3
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nG2
	smpsPan		panLeft,	$00
	dc.b		nE2
	smpsPan		panCentre,	$00
	dc.b		nD3
	smpsPan		panLeft,	$00
	dc.b		nF2
	smpsPan		panCentre,	$00
	dc.b		nC3
	smpsPan		panLeft,	$00
	dc.b		nF3,	nG3
	smpsPan		panRight,	$00
	dc.b		nF3
	smpsPan		panCentre,	$00
	dc.b		nC3
	smpsPan		panLeft,	$00
	dc.b		nF2,	nA2
	smpsPan		panRight,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nBb2
	smpsPan		panRight,	$00
	dc.b		nG2
	smpsPan		panCentre,	$00
	dc.b		nD3
	smpsPan		panRight,	$00
	dc.b		nF2
	smpsPan		panLeft,	$00
	dc.b		nBb2
	smpsPan		panCentre,	$00
	dc.b		nF2
	smpsPan		panRight,	$00
	dc.b		nD3
	smpsPan		panCentre,	$00
	dc.b		nD2
	smpsPan		panRight,	$00
	dc.b		nA2,	nC3,	nD3,	nC3,	nA2,	nD2,	nFs2,	nRst
	dc.b		nG2
	smpsPan		panLeft,	$00
	dc.b		nG1
	smpsPan		panRight,	$00
	dc.b		nG2,	nRst
	smpsPan		panCentre,	$00
	dc.b		nF2
	smpsPan		panRight,	$00
	dc.b		nF1
	smpsPan		panCentre,	$00
	dc.b		nF2,	nRst
	smpsPan		panLeft,	$00
	dc.b		nEb2
	smpsPan		panRight,	$00
	dc.b		nEb1
	smpsPan		panCentre,	$00
	dc.b		nEb2,	nRst
	smpsPan		panLeft,	$00
	dc.b		nD2
	smpsPan		panCentre,	$00
	dc.b		nD1
	smpsPan		panRight,	$00
	dc.b		nD2,	nRst
	smpsPan		panLeft,	$00
	dc.b		nG2
	smpsPan		panRight,	$00
	dc.b		nG1
	smpsPan		panLeft,	$00
	dc.b		nG2,	nRst
	smpsPan		panCentre,	$00
	dc.b		nF2,	nF1,	nF2,	nRst,	nEb2,	nEb1
	smpsPan		panLeft,	$00
	dc.b		nEb2,	nRst
	smpsPan		panCentre,	$00
	dc.b		nD2
	smpsPan		panRight,	$00
	dc.b		nD1,	nD2
	smpsJump	M46_Boss_FM2

; FM3 Data
M46_Boss_FM3:
	smpsPan		panLeft,	$00
	smpsFMvoice	$00
	dc.b		nG4,	$05,	nRst
	smpsPan		panCentre,	$00
	dc.b		nG5,	$0A,	nRst,	$05
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nD5,	$0A
	smpsPan		panLeft,	$00
	dc.b		nBb4,	$05,	nA4,	nG4
	smpsPan		panCentre,	$00
	dc.b		nA4,	nBb4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panCentre,	$00
	dc.b		nD5
	smpsPan		panLeft,	$00
	dc.b		nG5
	smpsPan		panCentre,	$00
	dc.b		nFs4,	nRst
	smpsPan		panRight,	$00
	dc.b		nFs5,	$0A,	nRst,	$05,	nFs4
	smpsPan		panCentre,	$00
	dc.b		nD5,	$0A
	smpsPan		panLeft,	$00
	dc.b		nBb4,	$05
	smpsPan		panCentre,	$00
	dc.b		nA4,	nFs4
	smpsPan		panRight,	$00
	dc.b		nA4,	nBb4,	nC5,	nD5
	smpsPan		panLeft,	$00
	dc.b		nFs5
	smpsPan		panCentre,	$00
	dc.b		nF4,	nRst,	nF5,	$0A,	nRst,	$05
	smpsPan		panLeft,	$00
	dc.b		nF4,	nD5,	$0A
	smpsPan		panRight,	$00
	dc.b		nBb4,	$05
	smpsPan		panCentre,	$00
	dc.b		nA4
	smpsPan		panLeft,	$00
	dc.b		nF4
	smpsPan		panRight,	$00
	dc.b		nA4
	smpsPan		panLeft,	$00
	dc.b		nBb4,	nC5,	nD5
	smpsPan		panRight,	$00
	dc.b		nF5
	smpsPan		panLeft,	$00
	dc.b		nBb5,	$0A
	smpsPan		panRight,	$00
	dc.b		nA5,	$05,	nG5,	nRst
	smpsPan		panLeft,	$00
	dc.b		nBb5
	smpsPan		panRight,	$00
	dc.b		nE5,	nRst
	smpsPan		panLeft,	$00
	dc.b		nD5,	$04,	nE5,	$03
	smpsPan		panRight,	$00
	dc.b		nD6
	smpsPan		panCentre,	$00
	dc.b		nC5,	$04
	smpsPan		panRight,	$00
	dc.b		nE5,	$03,	nC6,	nBb4,	$04
	smpsPan		panCentre,	$00
	dc.b		nE5,	$03,	nBb5
	smpsPan		panRight,	$00
	dc.b		nC5,	$04
	smpsPan		panLeft,	$00
	dc.b		nE5,	$03
	smpsPan		panCentre,	$00
	dc.b		nC6
	smpsPan		panLeft,	$00
	dc.b		nD5,	$05,	nRst
	smpsPan		panRight,	$00
	dc.b		nD6,	$0A,	nRst,	$05,	nD5,	nC6,	$0A
	smpsPan		panLeft,	$00
	dc.b		nD6,	$05
	smpsPan		panRight,	$00
	dc.b		nC6
	smpsPan		panLeft,	$00
	dc.b		nBb5
	smpsPan		panRight,	$00
	dc.b		nC6
	smpsPan		panLeft,	$00
	dc.b		nG5
	smpsPan		panRight,	$00
	dc.b		nA5
	smpsPan		panLeft,	$00
	dc.b		nBb5
	smpsPan		panCentre,	$00
	dc.b		nD6
	smpsPan		panRight,	$00
	dc.b		nD5,	nRst
	smpsPan		panLeft,	$00
	dc.b		nD6,	$0A,	nRst,	$05
	smpsPan		panRight,	$00
	dc.b		nD5,	nC6,	$0A
	smpsPan		panLeft,	$00
	dc.b		nD6,	$05,	nC6,	nBb5
	smpsPan		panRight,	$00
	dc.b		nC6
	smpsPan		panCentre,	$00
	dc.b		nFs5,	nA5
	smpsPan		panRight,	$00
	dc.b		nBb5
	smpsPan		panCentre,	$00
	dc.b		nD6
	smpsPan		panLeft,	$00
	dc.b		nD5,	nRst
	smpsPan		panRight,	$00
	dc.b		nD6,	$0A,	nRst,	$05,	nD5
	smpsPan		panLeft,	$00
	dc.b		nC6,	$0A,	nD6,	$05
	smpsPan		panCentre,	$00
	dc.b		nC6
	smpsPan		panRight,	$00
	dc.b		nBb5
	smpsPan		panCentre,	$00
	dc.b		nC6
	smpsPan		panRight,	$00
	dc.b		nG5
	smpsPan		panCentre,	$00
	dc.b		nA5
	smpsPan		panLeft,	$00
	dc.b		nBb5,	nD6,	$0F,	nC6,	$05,	nBb5,	nRst,	nD6
	dc.b		nBb5,	nRst,	nG5,	$04,	nBb5,	$03
	smpsPan		panCentre,	$00
	dc.b		nG6
	smpsPan		panLeft,	$00
	dc.b		nF5,	$04,	nBb5,	$03
	smpsPan		panRight,	$00
	dc.b		nF6
	smpsPan		panLeft,	$00
	dc.b		nE5,	$04
	smpsPan		panRight,	$00
	dc.b		nBb5,	$03,	nE6
	smpsPan		panCentre,	$00
	dc.b		nG5,	$04,	nBb5,	$03
	smpsPan		panRight,	$00
	dc.b		nG6,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7B
	smpsJump	M46_Boss_FM3

; FM4 Data
M46_Boss_FM4:
	dc.b		nRst,	$7F,	$7F,	$7F,	$7F,	$75
M46_Boss_Jump02:
	smpsPan		panCentre,	$00
	smpsFMvoice	$07
	dc.b		nE2,	$05,	nRst,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7B
	smpsJump	M46_Boss_Jump02

; FM5 Data
M46_Boss_FM5:
	smpsPan		panCentre,	$00
	smpsFMvoice	$00
	dc.b		nG3,	$0A,	nG2,	nG3,	$14,	nG2,	$0A,	nG3
	dc.b		nG2,	nFs3,	$14,	nFs2,	$0A,	nFs3,	nRst,	nD3
	dc.b		nFs2,	nE3,	nFs2,	nF3,	nF2,	nF3,	$14,	nF2
	dc.b		$0A,	nG3,	nF2,	nE3,	$14,	nE2,	$0A,	nE3
	dc.b		nE2,	$05,	nRst,	nE2,	$0A,	nE3,	nF3,	nE3
	dc.b		nG3,	nG2,	nG3,	$14,	nG2,	$0A,	nG3,	nG2
	dc.b		nFs3,	$14,	nFs2,	$0A,	nFs3,	nRst,	nD3,	nFs2
	dc.b		nE3,	nFs2,	nF3,	nF2,	nF3,	$14,	nF2,	$0A
	dc.b		nG3,	nF2,	nE3,	$14,	nE2,	$0A,	nE3,	nE2
	dc.b		$05,	nRst,	nG3,	$14,	nC4,	nBb3,	$0A,	nG3
	dc.b		nRst,	$6E,	nG3,	$08,	nRst,	$02,	nBb3,	$14
	dc.b		$0A,	nG3,	$0A,	nRst,	$7F,	$7F,	$7F,	$4F
	dc.b		nBb3,	$0A,	nG3,	nRst,	$6E,	nG3,	$08,	nRst
	dc.b		$02,	nBb3,	$14,	$0A,	nG3,	$0A,	nRst,	$7F
	dc.b		$7F,	$7E,	nG2,	$14,	nG3,	nF2,	nG3,	nEb2
	dc.b		nG3,	nD2,	nG3,	nC2,	nG3,	nBb1,	nG3,	nA1
	dc.b		nG3,	nFs1,	nG3
	smpsJump	M46_Boss_FM5

; PSG1 Data
M46_Boss_PSG1:
	smpsPSGvoice	$00
	dc.b		nG3,	$0A,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nF3,	nBb3,	nF3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nF3,	nC4,	nF4,	nG4,	nF4,	nC4,	nF3
	dc.b		nA3,	nBb3,	nF4,	nBb4,	nA4,	nF4,	nD4,	nBb3
	dc.b		nF3,	nEb3,	nBb3,	nEb4,	nF4,	nEb4,	nBb3,	nEb3
	dc.b		nBb3,	nD3,	nA3,	nC4,	nD4,	nC4,	nA3,	nD3
	dc.b		nFs3,	nG3,	nBb3,	nG3,	nD4,	nG3,	nBb3,	nG3
	dc.b		nD4,	nFs3,	nBb3,	nFs3,	nD4,	nFs3,	nBb3,	nFs3
	dc.b		nD4,	nBb3,	nF4,	nBb4,	nA4,	nF4,	nD4,	nBb3
	dc.b		nF3,	nE3,	nG3,	nBb3,	nC4,	nBb3,	nG3,	nE3
	dc.b		nD4,	nF3,	nC4,	nF4,	nG4,	nF4,	nC4,	nF3
	dc.b		nA3,	nG3,	nBb3,	nG3,	nD4,	nF3,	nBb3,	nF3
	dc.b		nD4,	nD3,	nA3,	nC4,	nD4,	nC4,	nA3,	nD3
	dc.b		nFs3,	nRst,	nG3,	nG2,	nG3,	nRst,	nF3,	nF2
	dc.b		nF3,	nRst,	nEb3,	nEb2,	nEb3,	nRst,	nD3,	nD2
	dc.b		nD3,	nRst,	nG3,	nG2,	nG3,	nRst,	nF3,	nF2
	dc.b		nF3,	nRst,	nEb3,	nEb2,	nEb3,	nRst,	nD3,	nD2
	dc.b		nD3
	smpsJump	M46_Boss_PSG1

; PSG2 Data
M46_Boss_PSG2:
	smpsPSGvoice	$00
	dc.b		nG4,	$05,	nRst,	nG5,	$0A,	nRst,	$05,	nG4
	dc.b		nD5,	$0A,	nBb4,	$05,	nA4,	nG4,	nA4,	nBb4
	dc.b		nC5,	nD5,	nG5,	nFs4,	nRst,	nFs5,	$0A,	nRst
	dc.b		$05,	nFs4,	nD5,	$0A,	nBb4,	$05,	nA4,	nFs4
	dc.b		nA4,	nBb4,	nC5,	nD5,	nFs5,	nF4,	nRst,	nF5
	dc.b		$0A,	nRst,	$05,	nF4,	nD5,	$0A,	nBb4,	$05
	dc.b		nA4,	nF4,	nA4,	nBb4,	nC5,	nD5,	nF5,	nBb5
	dc.b		$0A,	nA5,	$05,	nG5,	nRst,	nBb5,	nE5,	nRst
	dc.b		nD5,	$04,	nE5,	$03,	nD6,	nC5,	$04,	nE5
	dc.b		$03,	nC6,	nBb4,	$04,	nE5,	$03,	nBb5,	nC5
	dc.b		$04,	nE5,	$03,	nC6,	nD5,	$05,	nRst,	nD6
	dc.b		$0A,	nRst,	$05,	nD5,	nC6,	$0A,	nD6,	$05
	dc.b		nC6,	nBb5,	nC6,	nG5,	nA5,	nBb5,	nD6,	nD5
	dc.b		nRst,	nD6,	$0A,	nRst,	$05,	nD5,	nC6,	$0A
	dc.b		nD6,	$05,	nC6,	nBb5,	nC6,	nFs5,	nA5,	nBb5
	dc.b		nD6,	nD5,	nRst,	nD6,	$0A,	nRst,	$05,	nD5
	dc.b		nC6,	$0A,	nD6,	$05,	nC6,	nBb5,	nC6,	nG5
	dc.b		nA5,	nBb5,	nD6,	$0F,	nC6,	$05,	nBb5,	nRst
	dc.b		nD6,	nBb5,	nRst,	nG5,	$04,	nBb5,	$03,	nG6
	dc.b		nF5,	$04,	nBb5,	$03,	nF6,	nE5,	$04,	nBb5
	dc.b		$03,	nE6,	nG5,	$04,	nBb5,	$03,	nG6,	nRst
	dc.b		$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F,	$7F
	dc.b		$7F,	$7F,	$7F,	$7B
	smpsJump	M46_Boss_PSG2

; PSG3 Data
M46_Boss_PSG3:
	smpsPSGform	$E7
M46_Boss_Jump03:
	smpsPSGvoice	$02
	dc.b		nAb6,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$0A,	$05,	$05
	dc.b		$03,	$02,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$0A,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$0A,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$0A,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$0A,	$05,	$05,	$05,	$05,	$05,	$05,	$0A
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$0A,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$05,	$04,	$03,	$03,	$05,	$05,	$05,	$05
	dc.b		$05,	$05,	$04,	$03,	$03,	$05,	$05,	$05
	dc.b		$05,	$05,	$05,	$04,	$03,	$03,	$05,	$05
	dc.b		$05,	$05,	$05,	$05,	$04,	$03,	$03,	$05
	dc.b		$05,	$05,	$05,	$05,	$05,	$04,	$03,	$03
	dc.b		$05,	$05,	$05,	$05,	$05,	$05,	$04,	$03
	dc.b		$03,	$05,	$05,	$05,	$05,	$05,	$05,	$04
	dc.b		$03,	$03,	$05,	$05,	$05,	$05,	$05,	$05
	dc.b		$04,	$03,	$03
	smpsJump	M46_Boss_Jump03

; DAC Data
M46_Boss_DAC:
	smpsPan		panCentre,	$00
	dc.b		dKick,	$0A,	nRst,	$8F,	nRst,	$14,	dKick,	$0A
	dc.b		$8F,	dKick,	nRst,	dKick,	$8F,	nRst,	dKick,	dKick
	dc.b		$8F,	dKick,	dKick,	nRst,	$8F,	dKick,	nRst,	dKick
	dc.b		$8F,	dKick,	nRst,	dKick,	$8F,	nRst,	$8F,	dKick
	dc.b		dKick,	$8F,	dKick,	nRst,	$8F,	nRst,	dKick,	dKick
	dc.b		$8F,	dKick,	nRst,	dKick,	$8F,	dKick,	$8F,	nRst
	dc.b		dKick,	$8F,	dKick,	nRst,	$8F,	nRst,	dKick,	dKick
	dc.b		$8F,	dKick,	$8F,	dKick,	dKick,	$8F,	nRst,	$8F
	dc.b		dKick,	$8F,	$05,	$05,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$09,	nRst,	$01
	dc.b		dKick,	$0A,	nRst,	$14,	dKick,	$0A,	nRst,	$8F
	dc.b		nRst,	dKick,	dKick,	$8F,	dKick,	nRst,	dKick,	$8F
	dc.b		dKick,	$8F,	nRst,	dKick,	$8F,	dKick,	nRst,	$8F
	dc.b		nRst,	dKick,	dKick,	$8F,	dKick,	$8F,	dKick,	dKick
	dc.b		$8F,	nRst,	$8F,	dKick,	$8F,	$05,	$05,	dKick
	dc.b		$0A,	nRst,	$8F,	nRst,	$14,	dKick,	$0A,	$8F
	dc.b		dKick,	nRst,	dKick,	$8F,	nRst,	dKick,	dKick,	$8F
	dc.b		dKick,	dKick,	nRst,	$8F,	dKick,	nRst,	dKick,	$8F
	dc.b		dKick,	nRst,	dKick,	$8F,	nRst,	$8F,	dKick,	dKick
	dc.b		$8F,	dKick,	nRst,	$8F,	nRst,	dKick,	dKick,	$8F
	dc.b		dKick,	nRst,	dKick,	$8F,	dKick,	$8F,	nRst,	dKick
	dc.b		$8F,	dKick,	nRst,	$8F,	nRst,	dKick,	dKick,	$8F
	dc.b		dKick,	nRst,	$14,	$B5,	nRst,	$B5,	nRst,	$B5
	dc.b		nRst,	$B5,	nRst,	$B5,	nRst,	$B5,	nRst,	$B5
	dc.b		nRst,	$B5
	smpsJump	M46_Boss_DAC

M46_Boss_Voices:
	dc.b		$3C,$31,$52,$50,$30,$52,$53,$52,$53,$08,$00,$08,$00,$04,$00,$04
	dc.b		$00,$10,$0B,$10,$0D,$19,$80,$0B,$80;			Voice 00
	dc.b		$3A,$01,$07,$01,$01,$8E,$8E,$8D,$53,$0E,$0E,$0E,$03,$00,$00,$00
	dc.b		$01,$1F,$FF,$1F,$0F,$17,$28,$27,$80;			Voice 01
	dc.b		$3A,$01,$40,$01,$31,$1F,$1F,$1F,$1F,$0B,$04,$04,$04,$02,$04,$03
	dc.b		$02,$5F,$1F,$5F,$2F,$18,$05,$11,$80;			Voice 02
	dc.b		$29,$16,$14,$58,$54,$1F,$1F,$DF,$1F,$00,$00,$01,$00,$00,$00,$03
	dc.b		$00,$06,$06,$06,$0A,$1B,$1C,$16,$00;			Voice 03
	dc.b		$08,$09,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04
	dc.b		$03,$2F,$2F,$2F,$2F,$25,$30,$0E,$84;			Voice 04
	dc.b		$08,$09,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04
	dc.b		$03,$2F,$2F,$2F,$2F,$25,$30,$13,$84;			Voice 05
	dc.b		$3D,$01,$01,$01,$01,$8E,$52,$14,$4C,$08,$08,$0E,$03,$00,$00,$00
	dc.b		$00,$1F,$1F,$1F,$1F,$1B,$80,$80,$9B;			Voice 06
	dc.b		$3A,$60,$66,$60,$61,$1F,$94,$1F,$1F,$0F,$10,$05,$0D,$07,$06,$06
	dc.b		$07,$2F,$4F,$1F,$5F,$21,$14,$28,$80;			Voice 07
	dc.b		$2C,$74,$74,$34,$34,$1F,$12,$1F,$1F,$00,$00,$00,$00,$00,$01,$00
	dc.b		$01,$0F,$3F,$0F,$3F,$16,$90,$17,$90;			Voice 08
	dc.b		$08,$0A,$70,$30,$00,$1F,$1F,$5F,$5F,$12,$0E,$0A,$0A,$00,$04,$04
	dc.b		$03,$2F,$2F,$2F,$2F,$24,$2D,$13,$80;			Voice 09
	dc.b		$3D,$01,$02,$02,$02,$1F,$08,$8A,$0A,$08,$08,$08,$08,$00,$01,$00
	dc.b		$00,$0F,$1F,$1F,$1F,$1F,$88,$88,$87;			Voice 0A
	dc.b		$3C,$31,$52,$50,$30,$52,$53,$52,$53,$08,$00,$08,$00,$04,$00,$04
	dc.b		$00,$1F,$0F,$1F,$0F,$1A,$80,$16,$80;			Voice 0B
	dc.b		$38,$02,$02,$02,$01,$1F,$11,$11,$10,$00,$00,$00,$02,$01,$01,$01
	dc.b		$01,$0F,$0F,$0F,$3F,$2C,$22,$22,$83;			Voice 0C
	dc.b		$38,$35,$05,$10,$01,$14,$14,$10,$0E,$05,$08,$02,$08,$00,$00,$00
	dc.b		$00,$9F,$0F,$0F,$1F,$25,$31,$2A,$80;			Voice 0D
	dc.b		$37,$52,$31,$34,$50,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00
	dc.b		$00,$0F,$0F,$0F,$0F,$80,$87,$87,$87;			Voice 0E
	dc.b		$06,$61,$03,$32,$71,$1F,$1F,$1F,$1F,$00,$00,$00,$00,$00,$00,$00
	dc.b		$00,$0F,$0F,$0F,$0F,$1E,$85,$80,$80;			Voice 0F
	dc.b		$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b		$FF,$FF,$FF,$00,$00,$00,$00,$00,$00;			Voice 10
	even
