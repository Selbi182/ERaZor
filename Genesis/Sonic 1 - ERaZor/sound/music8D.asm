; =============================================================================================
; Project Name:		m5A
; Created:		8th May 2016
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================
BlackMasterPitch = -2
m5A_Header:
	smpsHeaderVoice	m5A_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$03,	$03

	smpsHeaderDAC	m5A_DAC
	smpsHeaderFM	m5A_FM1,	smpsPitch00-$04+BlackMasterPitch,	$14
	smpsHeaderFM	m5A_FM2,	smpsPitch00-$06+BlackMasterPitch,	$14
	smpsHeaderFM	m5A_FM3,	smpsPitch00-$04-12+BlackMasterPitch,	$14
	smpsHeaderFM	m5A_FM4,	smpsPitch00-$04-12+BlackMasterPitch,	$14
	smpsHeaderFM	m5A_FM5,	smpsPitch00-$04-12+BlackMasterPitch,	$14
	smpsHeaderPSG	m5A_PSG1,	smpsPitch02lo+$04-12+BlackMasterPitch,	$08,	$101
	smpsHeaderPSG	m5A_PSG2,	smpsPitch02lo+$04-12+BlackMasterPitch,	$08,	$101
	smpsHeaderPSG	m5A_PSG3,	smpsPitch00-$06-12+BlackMasterPitch,	$06,	$02

; FM1 Data
m5A_FM1:
	smpsFMvoice	$01
	smpsAlterNote	$04
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nC2,	$04
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2,	nC2
	dc.b		nC3,	nC2,	nCs3,	nC2,	nC3,	nC3,	nEb3
m5A_Jump01:
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nEb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nAb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2,	nEb3
	dc.b		nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nAb3,	nFs3
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nEb3
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2,	nBb2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC3,	nEb3
	dc.b		nC2,	$04,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nEb3,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC2
	dc.b		nBb2,	nC2,	nC3,	nC2,	nCs3,	nC2,	nC3,	nC3
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nAb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nF2
	dc.b		nFs3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nAb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nF3,	nF2
	dc.b		nEb3,	nF2,	nF3,	nF2,	nFs3,	nF2,	nAb3,	nAb3
	dc.b		nFs3,	nC2,	$04,	nC3,	nC2,	nCs3,	nRst,	$08
	dc.b		nC2,	$04,	nC3,	nC2,	nCs3,	nRst,	$08,	nC2
	dc.b		$04,	nEb3,	nCs3,	nCs3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nRst,	$08,	nC2,	$04,	nC3,	nC2,	nCs3,	nRst
	dc.b		$08,	nC2,	$04,	nEb3,	nC3,	nCs3,	nC2,	nC3
	dc.b		nC2,	nCs3,	nRst,	$08,	nC2,	$04,	nC3,	nC2
	dc.b		nCs3,	nRst,	$08,	nC2,	$04,	nEb3,	nCs3,	nB2
	dc.b		nC2,	nC3,	nC2,	nCs3,	nC2,	$08,	nC2,	$04
	dc.b		nC3,	nC2,	nCs3,	nC2,	$08,	nC2,	$04,	nEb3
	dc.b		nEb3,	nCs3,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nC2,	$04,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nEb3,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC2,	nBb2,	nC2,	nC3,	nC2,	nCs3
	dc.b		nC2,	nC3,	nC3,	nEb3
	smpsJump	m5A_Jump01

; FM2 Data
m5A_FM2:
	smpsFMvoice	$00
	smpsAlterNote	$00
	dc.b		nRst,	$1C,	nRst,	$20,	nG1,	$02,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nRst,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1
m5A_Jump02:
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nG1
	dc.b		nG1,	$02,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst,	nG1
	dc.b		nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1
	dc.b		nG1,	nG1,	$02,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nG1,	nG1,	nRst
	dc.b		nG1,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1,	nRst
	dc.b		nG1,	nRst,	nG1,	nG1,	nG1,	nRst,	nG1,	nG1
	dc.b		nG1,	nG1
	smpsJump	m5A_Jump02

; FM3 Data
m5A_FM3:
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst
m5A_Jump03:
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	smpsFMvoice	$02
	smpsAlterNote	$FE
	dc.b		nC4,	$02,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nEb4,	nAb3,	nEb4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nB3,	nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3
	dc.b		nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3,	nFs3,	nB3
	dc.b		nFs3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nC4,	nG3,	nC4,	nG3,	nC4,	nG3,	nC4
	dc.b		nG3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nEb4,	nAb3,	nEb4,	nAb3,	nCs4,	nAb3,	nCs4
	dc.b		nAb3,	nD4,	nA3,	nD4,	nA3,	nD4,	nA3,	nD4
	dc.b		nA3,	nD4,	nA3,	nD4,	nA3,	nD4,	nA3,	nD4
	dc.b		nA3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4
	dc.b		nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4,	nBb3,	nEb4
	dc.b		nBb3,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nAb4,	nEb4,	nAb4,	nEb4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nE4,	nB3,	nE4,	nB3,	nE4,	nB3,	nE4
	dc.b		nB3,	nE4,	nB3,	nE4,	nB3,	nE4,	nB3,	nE4
	dc.b		nB3,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nF4,	nC4,	nF4,	nC4,	nF4,	nC4,	nF4
	dc.b		nC4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nAb4,	nEb4,	nAb4,	nEb4,	nFs4,	nCs4,	nFs4
	dc.b		nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4
	dc.b		nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4,	nCs4,	nG4
	dc.b		nCs4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5
	dc.b		nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5,	nAb4,	nCs5
	dc.b		nAb4
	smpsFMvoice	$01
	dc.b		nC5,	$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC5,	$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb5,	nRst,	nEb5,	nRst,	nCs5,	nRst,	$06,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	$08,	nRst,	$02,	nEb5
	dc.b		nRst,	nEb5,	nRst,	nEb5,	nRst,	nCs5,	nRst,	nC5
	dc.b		$0C,	nCs5,	$02,	nRst,	nC3,	$08,	nC5,	$0C
	dc.b		nCs5,	$02,	nRst,	nC3,	$08,	nEb5,	$02,	nRst
	dc.b		nEb5,	nRst,	nCs5,	nRst,	$06,	nC5,	$0C,	nCs5
	dc.b		$02,	nRst,	nC3,	$08,	nC5,	$0C,	nCs5,	$02
	dc.b		nRst,	nC3,	$08,	nEb5,	$02,	nRst,	nEb5,	nRst
	dc.b		nEb5,	nRst,	nCs5,	nRst
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4,	nRst,	$20
	smpsPan		panLeft,	$00
	dc.b		nC5,	$02
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4,	nRst,	$20
	smpsPan		panLeft,	$00
	dc.b		nC5,	$02
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4
	smpsPan		panLeft,	$00
	dc.b		nC5
	smpsPan		panRight,	$00
	dc.b		nG4,	nRst,	$20
	smpsPan		panRight,	$00
	dc.b		nC5,	$02
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panRight,	$00
	dc.b		nC5
	smpsPan		panLeft,	$00
	dc.b		nG4
	smpsPan		panCentre,	$00
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst
	smpsJump	m5A_Jump03

; FM4 Data
m5A_FM4:
	smpsFMvoice	$03
	smpsAlterNote	$02
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4
	dc.b		$08,	nD4,	nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4
	dc.b		$08,	nD4
m5A_Jump04:
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nBb3,	$20,	nB3,	nBb3,	nA3,	nBb3,	nB3,	nC4
	dc.b		nCs4,	$10,	nD4,	nEb4,	$20,	nD4,	nCs4,	nC4
	dc.b		nEb4,	nE4,	nF4,	nCs5
	smpsFMvoice	$01
	smpsAlterNote	$00
	dc.b		nG4,	$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nG4,	$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nBb4,	nRst,	nBb4,	nRst,	nAb4,	nRst,	$06,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	$08,	nRst,	$02,	nBb4
	dc.b		nRst,	nBb4,	nRst,	nBb4,	nRst,	nAb4,	nRst,	nG4
	dc.b		$0C,	nAb4,	$02,	nRst,	nC3,	$08,	nG4,	$0C
	dc.b		nAb4,	$02,	nRst,	nC3,	$08,	nBb4,	$02,	nRst
	dc.b		nBb4,	nRst,	nAb4,	nRst,	$06,	nG4,	$0C,	nAb4
	dc.b		$02,	nRst,	nC3,	$08,	nG4,	$0C,	nAb4,	$02
	dc.b		nRst,	nC3,	$08,	nBb4,	$02,	nRst,	nBb4,	nRst
	dc.b		nBb4,	nRst,	nAb4,	nRst
	smpsFMvoice	$03
	smpsAlterNote	$02
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nG4,	$0C,	nFs4,	nF4,	nE4,	nEb4,	$08,	nD4
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4,	nG4,	$0C,	nFs4
	dc.b		nF4,	nE4,	nEb4,	$08,	nD4
	smpsJump	m5A_Jump04

; FM5 Data
m5A_FM5:
	smpsFMvoice	$04
	smpsAlterNote	$FC
	dc.b		nRst,	$1C,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nC4,	$02,	nG3,	nC4,	nAb3,	nC4
	dc.b		nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nG3,	nC4
	dc.b		nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4,	nAb3,	nC4
	dc.b		nG3,	nC4,	nA3,	nCs4,	nAb3,	nCs4,	nA3,	nCs4
	dc.b		nG3,	nCs4,	nA3,	nCs4,	nG3,	nCs4,	nAb3,	nCs4
	dc.b		nG3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4,	nAb3,	nCs4
	dc.b		nA3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4,	nA3,	nCs4
	dc.b		nAb3,	nCs4,	nBb3
m5A_Jump05:
	dc.b		nC4,	nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nAb3
	dc.b		nC4,	nFs3,	nC4,	nG3,	nC4,	nFs3,	nC4,	nFs3
	dc.b		nC4,	nA3,	nC4,	nG3,	nC4,	nAb3,	nC4,	nFs3
	dc.b		nC4,	nA3,	nC4,	nAb3,	nC4,	nG3,	nC4,	nA3
	dc.b		nB3,	nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nG3
	dc.b		nB3,	nF3,	nB3,	nFs3,	nB3,	nF3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nFs3,	nB3,	nG3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nG3,	nB3,	nFs3,	nB3,	nAb3
	dc.b		nBb3,	nF3,	nBb3,	nFs3,	nBb3,	nE3,	nBb3,	nFs3
	dc.b		nBb3,	nE3,	nBb3,	nF3,	nBb3,	nE3,	nBb3,	nE3
	dc.b		nBb3,	nG3,	nBb3,	nF3,	nBb3,	nFs3,	nBb3,	nE3
	dc.b		nBb3,	nG3,	nBb3,	nFs3,	nBb3,	nF3,	nBb3,	nG3
	dc.b		nB3,	nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nG3
	dc.b		nB3,	nF3,	nB3,	nFs3,	nB3,	nF3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nFs3,	nB3,	nG3,	nB3,	nF3
	dc.b		nB3,	nAb3,	nB3,	nG3,	nB3,	nFs3,	nB3,	nAb3
	dc.b		nRst,	$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst
	dc.b		$02,	nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst
	dc.b		$02,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	$06
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb4,	nRst,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nC4,	$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02
	dc.b		nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	$06,	nC4
	dc.b		$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02,	nC4
	dc.b		$0C,	nCs4,	$02,	nRst,	$08,	nRst,	$02,	nEb4
	dc.b		nRst,	nEb4,	nRst,	nEb4,	nRst,	nCs4,	nRst,	nRst
	dc.b		$20,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst,	nRst
	dc.b		nRst,	nRst,	nRst,	nRst,	nC4,	$02,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4
	dc.b		nG3,	nC4,	nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nA3,	nB3,	nFs3,	nB3
	dc.b		nG3,	nB3,	nF3,	nB3,	nG3,	nB3,	nF3,	nB3
	dc.b		nFs3,	nB3,	nF3,	nB3,	nF3,	nB3,	nAb3,	nB3
	dc.b		nFs3,	nB3,	nG3,	nB3,	nF3,	nB3,	nAb3,	nB3
	dc.b		nG3,	nB3,	nFs3,	nB3,	nAb3,	nC4,	nG3,	nC4
	dc.b		nAb3,	nC4,	nFs3,	nC4,	nAb3,	nC4,	nFs3,	nC4
	dc.b		nG3,	nC4,	nFs3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nG3,	nC4,	nAb3,	nC4,	nFs3,	nC4,	nA3,	nC4
	dc.b		nAb3,	nC4,	nG3,	nC4,	nA3,	nCs4,	nAb3,	nCs4
	dc.b		nA3,	nCs4,	nG3,	nCs4,	nA3,	nCs4,	nG3,	nCs4
	dc.b		nAb3,	nCs4,	nG3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4
	dc.b		nAb3,	nCs4,	nA3,	nCs4,	nG3,	nCs4,	nBb3,	nCs4
	dc.b		nA3,	nCs4,	nAb3,	nCs4,	nBb3
	smpsJump	m5A_Jump05

; PSG1 Data
m5A_PSG1:
	dc.b		nRst,	$1C
m5A_Loop01:
	dc.b		nRst,	$20
	smpsLoop	$00,	$0C,	m5A_Loop01
m5A_Loop02:
	dc.b		nRst,	$20
	smpsLoop	$00,	$17,	m5A_Loop02
	dc.b		nCs4,	$20
m5A_Loop03:
	dc.b		nRst,	$20
	smpsLoop	$00,	$1C,	m5A_Loop03
	smpsJump	m5A_Loop02

; PSG2 Data
m5A_PSG2:
	smpsStop

; PSG3 Data
m5A_PSG3:
	smpsPSGform	$E7
	smpsSetVol	$FC
	dc.b		nRst,	$14,	nRst,	$20,	nRst,	nRst,	nRst,	nRst
	smpsPSGvoice	$01
	dc.b		nG6,	$08
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nRst,	nRst,	$0C,	nRst,	$20
	smpsPSGvoice	$01
	dc.b		nG6,	$08,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
m5A_Jump06:
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$08
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	$02,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04,	nG6
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	dc.b		nG6,	nG6,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6,	nG6,	nG6,	nG6,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsPSGvoice	$01
	dc.b		nG6,	$04
	smpsPSGvoice	$02
	dc.b		nG6,	$02,	nG6
	smpsJump	m5A_Jump06

; DAC Data
m5A_DAC:
	smpsAlterNote	$02
	dc.b		$C8,$04,dKick,	$80,	$80,	$C8,	dKick,	$80, 	$80
	dc.b		$C8,	dKick,	$80,	$80,	$C8,	dKick,	$80
	dc.b		$80,	$80,	$80,	$80,	$80,	$80,	$80,	$80
	dc.b		$80,	$80,	$80,	$80,	$80,	$80,	$80,	$80
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
m5A_Jump07:
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	dKick,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$04,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8
	dc.b		$B4,	$C8,	$04,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$8E,	$20,	$8E,	$8E,	$8E,	dKick
	dc.b		$04,	$B4,	dKick,	$B4,	dKick,	$B4,	dKick,	$B4
	dc.b		dKick,	$B4,	dKick,	$B4,	dKick,	$B4,	dKick,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	dc.b		$C8,	$B4,	$C8,	$B4,	$C8,	$B4,	$C8,	$B4
	smpsJump	m5A_Jump07

m5A_Voices:
	dc.b		$15,$01,$02,$00,$02,$FF,$FF,$FF,$FF,$08,$08,$08,$08,$00,$00,$00
	dc.b		$00,$FF,$FF,$FF,$FF,$8C,$80,$8B,$7C;			Voice 00
	dc.b		$72,$21,$22,$02,$22,$1F,$1F,$1F,$1F,$04,$09,$00,$11,$01,$1F,$0A
	dc.b		$05,$08,$0A,$08,$08,$97,$80,$94,$7E;			Voice 01
	dc.b		$75,$21,$64,$5C,$22,$1F,$1F,$1F,$1E,$05,$09,$00,$08,$00,$1F,$0A
	dc.b		$05,$08,$0A,$08,$08,$9B,$80,$8C,$78;			Voice 02
	dc.b		$75,$02,$03,$02,$02,$1F,$1F,$1F,$1F,$1F,$09,$00,$11,$06,$1F,$00
	dc.b		$00,$78,$08,$08,$0A,$84,$80,$80,$88;			Voice 03
	dc.b		$75,$12,$12,$12,$12,$18,$1A,$1D,$1E,$00,$06,$0C,$00,$00,$06,$0A
	dc.b		$08,$1F,$1F,$1F,$1F,$90,$80,$90,$A0;			Voice 04
	dc.b		$75,$C4,$54,$74,$44,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$03,$10,$10
	dc.b		$10,$08,$08,$08,$08,$80,$80,$80,$7F;			Voice 05
	even
