; =============================================================================================
; Project Name:		ENDING
; Created:		4th February 2010
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

ENDING_Header:
;	Voice Pointer	location
	smpsHeaderVoice	ENDING_Voices
;	Channel Setup	FM	PSG
	smpsHeaderChan	$06,	$02
;	Tempo Setup	divider	modifier
	smpsHeaderTempo	$02,	$26

;	DAC Pointer	location
	smpsHeaderDAC	ENDING_DAC
;	FM1 Pointer	location	pitch		volume
	smpsHeaderFM	ENDING_FM1,	smpsPitch01hi,	$0C
;	FM2 Pointer	location	pitch		volume
	smpsHeaderFM	ENDING_FM2,	smpsPitch00,	$12
;	FM3 Pointer	location	pitch		volume
	smpsHeaderFM	ENDING_FM3,	smpsPitch00,	$12
;	FM4 Pointer	location	pitch		volume
	smpsHeaderFM	ENDING_FM4,	smpsPitch00,	$12
;	FM5 Pointer	location	pitch		volume
	smpsHeaderFM	ENDING_FM5,	smpsPitch00,	$11
;	PSG1 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ENDING_PSG1,	smpsPitch03lo,	$00,	$02
;	PSG2 Pointer	location	pitch		volume	instrument
	smpsHeaderPSG	ENDING_PSG2,	smpsPitch00+$0B,	$02,	$00

;DAC Macros - edit as nessacary
ENDKick = $81
ENDSnare = $82
ENDCymbal = $8E

; FM1 Data
ENDING_FM1:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$01
	dc.b		nC2,	$38,	nG1,	$03,	nRst,	$01,	nBb1,	$04
	dc.b		nC2,	$38,	nG1,	$03,	nRst,	$01,	nBb1,	$04
	dc.b		nC2,	$03,	nRst,	$01,	nC2,	$04,	nC3,	$03
	dc.b		nRst,	$01,	nC2,	$04,	nRst,	nC3,	$03,	nRst
	dc.b		$01,	nC2,	$03,	nRst,	$01,	nC2,	$03,	nRst
	dc.b		$01,	nC2,	$03,	nRst,	$01,	nC2,	$04,	nC3
	dc.b		$03,	nRst,	$01,	nC2,	$04,	nRst,	nC3,	$03
	dc.b		nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2,	$03
	dc.b		nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2,	$04
	dc.b		nC3,	$03,	nRst,	$01,	nC2,	$04,	nRst,	nC3
	dc.b		$03,	nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2
	dc.b		$03,	nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2
	dc.b		$04,	nC3,	$03,	nRst,	$01,	nC2,	$04,	nRst
	dc.b		nG2,	$03,	nRst,	$01,	nC2,	$03,	nRst,	$01
	dc.b		nC2,	$03,	nRst,	$01,	nC2,	$03,	nRst,	$01
	dc.b		nC2,	$04,	nC3,	$03,	nRst,	$01,	nC2,	$04
	dc.b		nRst,	nC3,	$03,	nRst,	$01,	nC2,	$03,	nRst
	dc.b		$01,	nC2,	$03,	nRst,	$01,	nC2,	$03,	nRst
	dc.b		$01,	nC2,	$04,	nC3,	$03,	nRst,	$01,	nC2
	dc.b		$04,	nRst,	nC3,	$03,	nRst,	$01,	nC2,	$03
	dc.b		nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2,	$03
	dc.b		nRst,	$01,	nC2,	$04,	nC3,	$03,	nRst,	$01
	dc.b		nC2,	$04,	nRst,	nC3,	$03,	nRst,	$01,	nC2
	dc.b		$03,	nRst,	$01,	nC2,	$03,	nRst,	$01,	nC2
	dc.b		$03,	nRst,	$01,	nC2,	$04,	nC3,	$03,	nRst
	dc.b		$01,	nC2,	$04,	nRst,	nG2,	$03,	nRst,	$01
	dc.b		nC2,	$03,	nRst,	$01,	nC2,	$03,	nRst,	$01
	dc.b		nAb1,	$03,	nRst,	$01,	nAb1,	$04,	nAb2,	$03
	dc.b		nRst,	$01,	nAb1,	$04,	nRst,	nAb2,	$03,	nRst
	dc.b		$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$03,	nRst
	dc.b		$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$04,	nAb2
	dc.b		$03,	nRst,	$01,	nAb1,	$04,	nRst,	nAb1,	$03
	dc.b		nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$03
	dc.b		nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$04
	dc.b		nAb2,	$03,	nRst,	$01,	nAb1,	$04,	nRst,	nAb2
	dc.b		$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1
	dc.b		$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1
	dc.b		$04,	nAb2,	$03,	nRst,	$01,	nAb1,	$04,	nRst
	dc.b		nEb2,	$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01
	dc.b		nAb1,	$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01
	dc.b		nAb1,	$04,	nAb2,	$03,	nRst,	$01,	nAb1,	$04
	dc.b		nRst,	nAb2,	$03,	nRst,	$01,	nAb1,	$03,	nRst
	dc.b		$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$03,	nRst
	dc.b		$01,	nAb1,	$04,	nAb2,	$03,	nRst,	$01,	nAb1
	dc.b		$04,	nRst,	nAb1,	$03,	nRst,	$01,	nAb1,	$03
	dc.b		nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$03
	dc.b		nRst,	$01,	nAb1,	$04,	nAb2,	$03,	nRst,	$01
	dc.b		nAb1,	$04,	nRst,	nAb2,	$03,	nRst,	$01,	nAb1
	dc.b		$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01,	nAb1
	dc.b		$03,	nRst,	$01,	nAb1,	$04,	nAb2,	$03,	nRst
	dc.b		$01,	nAb1,	$04,	nRst,	nEb2,	$03,	nRst,	$01
	dc.b		nAb1,	$03,	nRst,	$01,	nAb1,	$03,	nRst,	$01
	dc.b		nC2,	$7F,	smpsNoAttack,	$01,	nRst,	$40
	smpsStop

; FM2 Data
ENDING_FM2:
	dc.b		nRst,	$78
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$00
	dc.b		nBb3,	$03,	nRst,	$01,	nC4,	$03,	nRst,	$01
	dc.b		nG4,	$2F,	nRst,	$09,	nC4,	$08,	nD4,	$20
	dc.b		nEb4,	$10,	nD4,	nBb3,	$18,	nG3,	$48,	nRst
	dc.b		$20,	nBb3,	$02,	nC4,	$3D,	nRst,	$01,	nBb3
	dc.b		$02,	nC4,	$16,	nG4,	$18,	nC5,	$10,	nD5
	dc.b		$02,	nRst,	$01,	nEb5,	nC5,	$3B,	nRst,	$41
	dc.b		nBb4,	$02,	nC5,	$6E,	nRst,	$50
	smpsStop

; FM3 Data
ENDING_FM3:
	dc.b		nRst,	$07
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$01,	nEb5,	$0C,	nBb4,	nEb5,	nD5,	nBb4
	dc.b		$0E,	nRst,	$01,	nC5,	nEb5,	$0C,	nBb4,	nEb5
	dc.b		nF5,	nD5,	$0E,	nRst,	$01,	nC5,	nC5,	$0C
	dc.b		nBb4,	nEb5,	nD5,	nD5,	$0E,	nRst,	$01,	nC5
	dc.b		nC5,	$0C,	nBb4,	nEb5,	nD5,	nD5,	$0E,	nRst
	dc.b		$01,	nC5,	nC5,	$0C,	nBb4,	nEb5,	nD5,	nD5
	dc.b		$0E,	nRst,	$01,	nC5,	nC5,	$0C,	nBb4,	nEb5
	dc.b		nF5,	nD5,	$0E,	nRst,	$01,	nC5,	nC5,	$0C
	dc.b		nBb4,	nEb5,	nD5,	nD5,	$0E,	nRst,	$01,	nC5
	dc.b		nC5,	$0C,	nBb4,	nEb5,	nD5,	nD5,	$0E,	nRst
	dc.b		$01,	nC5,	nC5,	$0C,	nBb4,	nEb5,	nD5,	nD5
	dc.b		$0E,	nRst,	$01,	nC5,	nC5,	$0C,	nD5,	nEb5
	dc.b		nF5,	nBb4,	$08,	nC3,	$40,	nRst,	$7F,	$01
	smpsStop

; FM4 Data
ENDING_FM4:
	dc.b		nRst,	$08
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$02
	dc.b		nC5,	$0C,	nD5,	nC5,	nF5,	nD5,	$0E,	nRst
	dc.b		$02,	nC5,	$0C,	nD5,	nC5,	nD5,	nBb4,	$0E
	dc.b		nRst,	$02,	nEb5,	$0C,	nD5,	nC5,	nF5,	nBb4
	dc.b		$0E,	nRst,	$02,	nEb5,	$0C,	nD5,	nC5,	nF5
	dc.b		nBb4,	$0E,	nRst,	$02,	nEb5,	$0C,	nD5,	nC5
	dc.b		nF5,	nBb4,	$0E,	nRst,	$02,	nEb5,	$0C,	nD5
	dc.b		nC5,	nD5,	nBb4,	$0E,	nRst,	$02,	nEb5,	$0C
	dc.b		nD5,	nC5,	nF5,	nBb4,	$0E,	nRst,	$02,	nEb5
	dc.b		$0C,	nD5,	nC5,	nF5,	nBb4,	$0E,	nRst,	$02
	dc.b		nEb5,	$0C,	nD5,	nC5,	nF5,	nBb4,	$0E,	nRst
	dc.b		$02,	nEb5,	$0C,	nBb4,	nC5,	nD5,	nD5,	$08
	dc.b		nG2,	$40,	nRst,	$7F,	$01
	smpsStop

; FM5 Data
ENDING_FM5:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
;	Set FM Voice	#
	smpsFMvoice	$03
	dc.b		nC2,	$38,	nBb1,	$08,	nC2,	$38,	nBb2,	$08
	dc.b		nC2,	$07,	nRst,	$01,	nC2,	$03,	nRst,	$01
	dc.b		nC2,	$04,	nC3,	$08,	nC2,	nC2,	$04,	$03
	dc.b		nRst,	$01,	nC2,	$08,	nC3,	nC2,	$07,	nRst
	dc.b		$01,	nC2,	$07,	nRst,	$01,	nC2,	$03,	nRst
	dc.b		$01,	nC2,	$04,	nC3,	$08,	nC2,	nC2,	$04
	dc.b		$03,	nRst,	$01,	nC3,	$08,	nC2,	$04,	nC3
	dc.b		nC2,	$07,	nRst,	$01,	nC2,	$07,	nRst,	$01
	dc.b		nC2,	$03,	nRst,	$01,	nC2,	$04,	nC3,	$08
	dc.b		nC2,	nC2,	$04,	$03,	nRst,	$01,	nC2,	$08
	dc.b		nC3,	nC2,	$07,	nRst,	$01,	nC2,	$07,	nRst
	dc.b		$01,	nC2,	$03,	nRst,	$01,	nC2,	$04,	nC3
	dc.b		$08,	nC2,	nC2,	$04,	$03,	nRst,	$01,	nC3
	dc.b		$08,	nC2,	$04,	nC3,	nC2,	$07,	nRst,	$01
	dc.b		nAb1,	$07,	nRst,	$01,	nAb1,	$03,	nRst,	$01
	dc.b		nAb1,	$04,	nAb2,	$08,	nAb1,	nAb1,	$04,	$03
	dc.b		nRst,	$01,	nAb1,	$08,	nAb2,	nAb1,	$07,	nRst
	dc.b		$01,	nAb1,	$07,	nRst,	$01,	nAb1,	$03,	nRst
	dc.b		$01,	nAb1,	$04,	nAb2,	$08,	nAb1,	nAb1,	$04
	dc.b		$03,	nRst,	$01,	nAb2,	$08,	nAb1,	$04,	nAb2
	dc.b		nAb1,	$07,	nRst,	$01,	nAb1,	$07,	nRst,	$01
	dc.b		nAb1,	$03,	nRst,	$01,	nAb1,	$04,	nAb2,	$08
	dc.b		nAb1,	nAb1,	$04,	$03,	nRst,	$01,	nAb1,	$08
	dc.b		nAb2,	nAb1,	$07,	nRst,	$01,	nAb1,	$07,	nRst
	dc.b		$01,	nAb1,	$03,	nRst,	$01,	nAb1,	$04,	nAb2
	dc.b		$08,	nAb1,	nAb1,	$04,	$03,	nRst,	$01,	nAb2
	dc.b		$08,	nAb1,	$04,	nBb2,	nC3,	$07,	nRst,	$01
	dc.b		nC2,	$7F,	smpsNoAttack,	$01,	nRst,	$40
	smpsStop

; PSG1 Data
ENDING_PSG1:
	dc.b		nRst,	$78
;	Set PSG Voice	#
	smpsPSGvoice	$00
	dc.b		nBb3,	$03,	nRst,	$01,	nC4,	$03,	nRst,	$01
	dc.b		nG4,	$2F,	nRst,	$09,	nC4,	$08,	nD4,	$20
	dc.b		nEb4,	$10,	nD4,	nBb3,	$18,	nG3,	$48,	nRst
	dc.b		$20,	nBb3,	$02,	nC4,	$3D,	nRst,	$01,	nBb3
	dc.b		$02,	nC4,	$16,	nG4,	$18,	nC5,	$10,	nD5
	dc.b		$02,	nRst,	$01,	nEb5,	nC5,	$3B,	nRst,	$41
	dc.b		nBb4,	$02,	nC5,	$6E,	nRst,	$50
	smpsStop

; PSG2 Data
ENDING_PSG2:
;	Set PSG WvForm	#
	smpsPSGform	$E7
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$07
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$03,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$07
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$03,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	nAb6,	nRst,	nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$07
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$03,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$07
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	$03,	nRst,	$04,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$01
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$05
;	Set PSG Voice	#
	smpsPSGvoice	$02
	dc.b		nAb6,	$01,	nRst,	$03,	nAb6,	$01,	nRst,	$03
;	Set PSG Voice	#
	smpsPSGvoice	$01
	dc.b		nAb6,	nRst,	$7F,	$46
	smpsStop

; DAC Data
ENDING_DAC:
;	Panning	 	direction	amsfms
	smpsPan		panCentre,	$00
	dc.b		ENDKick,	$04,	$04,	ENDCymbal,	$08,	ENDKick,	$10,	$10
	dc.b		$04,	$04,	ENDSnare,	$08,	ENDCymbal,	ENDSnare,	ENDKick,	ENDSnare
	dc.b		$02,	$02,	$04,	ENDCymbal,	$08,	ENDKick,	$04,	ENDSnare
	dc.b		ENDCymbal,	ENDSnare,	ENDKick,	$08,	ENDCymbal,	ENDKick,	$04,	$04
	dc.b		ENDSnare,	$08,	ENDKick,	$0C,	$04,	$08,	ENDSnare,	$08
	dc.b		ENDKick,	ENDKick,	ENDKick,	$04,	$04,	ENDSnare,	$08,	ENDKick
	dc.b		$0C,	$04,	$08,	ENDSnare,	$04,	$04,	ENDKick,	$08
	dc.b		$08,	$04,	$04,	ENDSnare,	$08,	ENDKick,	$0C,	$04
	dc.b		$08,	ENDSnare,	$08,	ENDKick,	ENDKick,	ENDKick,	$04,	$04
	dc.b		ENDSnare,	$08,	ENDKick,	$0C,	$04,	ENDSnare,	$02,	$02
	dc.b		$04,	ENDCymbal,	$04,	ENDSnare,	ENDKick,	$08,	ENDCymbal,	ENDKick
	dc.b		$04,	$04,	ENDSnare,	$08,	ENDKick,	$0C,	$04,	$08
	dc.b		ENDSnare,	$08,	ENDKick,	ENDKick,	ENDKick,	$04,	$04,	ENDSnare
	dc.b		$08,	ENDKick,	$0C,	$04,	$08,	ENDSnare,	$04,	$04
	dc.b		ENDKick,	$08,	$08,	$04,	$04,	ENDSnare,	$08,	ENDKick
	dc.b		$0C,	$04,	$08,	ENDSnare,	$08,	ENDKick,	ENDCymbal,	ENDKick
	dc.b		$04,	$04,	ENDSnare,	$04,	$04,	ENDCymbal,	$0C,	ENDSnare
	dc.b		$04,	$02,	$02,	$04,	ENDCymbal,	$04,	ENDSnare,	ENDSnare
	dc.b		$08,	ENDCymbal,	$7F,	nRst,	$41
	smpsFade
	smpsStop

ENDING_Voices:
	dc.b		$3D,$31,$31,$33,$31,$50,$52,$58,$59,$0F,$02,$02,$02,$04,$00,$00
	dc.b		$00,$17,$09,$19,$19,$13,$0C,$14,$80;			Voice 00
	dc.b		$18,$36,$35,$30,$31,$5F,$1F,$5F,$5F,$13,$10,$04,$05,$08,$06,$05
	dc.b		$07,$57,$45,$43,$07,$14,$20,$1E,$80;			Voice 01
	dc.b		$00,$64,$63,$00,$01,$1A,$5F,$92,$97,$12,$12,$0D,$01,$02,$03,$01
	dc.b		$02,$36,$43,$23,$16,$18,$12,$14,$80;			Voice 02
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 03
	even
