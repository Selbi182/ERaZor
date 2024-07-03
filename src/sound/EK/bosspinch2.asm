; =============================================================================================
; Project Name:		BossPinch2
; Created:		20th July 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

BossPinch2_Header:
	smpsHeaderVoice	BossPinch2_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$02,	$06

	smpsHeaderDAC	BossPinch2_DAC
	smpsHeaderFM	BossPinch2_FM1,	smpsPitch00,	$0E
	smpsHeaderFM	BossPinch2_FM2,	smpsPitch01lo,	$11
	smpsHeaderFM	BossPinch2_FM4,	smpsPitch01lo,	$14
	smpsHeaderFM	BossPinch2_FM5,	smpsPitch01lo,	$0F
	smpsHeaderFM	BossPinch2_FM3,	smpsPitch01lo,	$12
	smpsHeaderPSG	BossPinch2_PSG1,	smpsPitch03lo,	$03,	$00
	smpsHeaderPSG	BossPinch2_PSG2,	smpsPitch03lo,	$03,	$00
	smpsHeaderPSG	BossPinch2_PSG3,	smpsPitch03lo,	$02,	$00

BossPinch2_Call01:
	smpsModSet	$1E,	$01,	$05,	$05
	smpsReturn

BossPinch2_Call09:
	smpsModSet	$10,	$01,	$02,	$04
	smpsReturn

BossPinch2_Call2C:
	smpsModSet	$03,	$13,	$04,	$01
	smpsReturn

BossPinch2_Call38:
	smpsModSet	$10,	$01,	$01,	$02
	smpsReturn

BossPinch2_Call42:
	smpsModSet	$13,	$02,	$01,	$01
	smpsReturn

; FM1 Data
BossPinch2_FM1:
	smpsCall	BossPinch2_Call01
	smpsCall	BossPinch2_Call02
	smpsCall	BossPinch2_Call03
BossPinch2_Jump01:
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call03
	smpsCall	BossPinch2_Call04
	smpsCall	BossPinch2_Call05
	smpsCall	BossPinch2_Call04
	smpsCall	BossPinch2_Call06
	smpsCall	BossPinch2_Call07
	smpsCall	BossPinch2_Call08
	smpsCall	BossPinch2_Call07
	smpsCall	BossPinch2_Call08
	smpsCall	BossPinch2_Call03
	smpsJump	BossPinch2_Jump01

; FM2 Data
BossPinch2_FM2:
	smpsCall	BossPinch2_Call09
	smpsCall	BossPinch2_Call0A
	smpsCall	BossPinch2_Call0B
BossPinch2_Jump02:
	smpsCall	BossPinch2_Call0C
	smpsCall	BossPinch2_Call0D
	smpsCall	BossPinch2_Call0E
	smpsCall	BossPinch2_Call0F
	smpsCall	BossPinch2_Call10
	smpsCall	BossPinch2_Call0F
	smpsCall	BossPinch2_Call11
	smpsCall	BossPinch2_Call0B
	smpsCall	BossPinch2_Call0C
	smpsCall	BossPinch2_Call0D
	smpsCall	BossPinch2_Call0E
	smpsCall	BossPinch2_Call12
	smpsCall	BossPinch2_Call13
	smpsCall	BossPinch2_Call12
	smpsCall	BossPinch2_Call14
	smpsCall	BossPinch2_Call15
	smpsCall	BossPinch2_Call16
	smpsCall	BossPinch2_Call15
	smpsCall	BossPinch2_Call17
	smpsCall	BossPinch2_Call0D
	smpsJump	BossPinch2_Jump02

; FM3 Data
BossPinch2_FM3:
	smpsCall	BossPinch2_Call09
	smpsCall	BossPinch2_Call18
	smpsCall	BossPinch2_Call19
BossPinch2_Jump03:
	smpsCall	BossPinch2_Call1A
	smpsCall	BossPinch2_Call1B
	smpsCall	BossPinch2_Call1C
	smpsCall	BossPinch2_Call1D
	smpsCall	BossPinch2_Call1E
	smpsCall	BossPinch2_Call1D
	smpsCall	BossPinch2_Call1E
	smpsCall	BossPinch2_Call1B
	smpsCall	BossPinch2_Call1A
	smpsCall	BossPinch2_Call1B
	smpsCall	BossPinch2_Call1C
	smpsCall	BossPinch2_Call1F
	smpsCall	BossPinch2_Call20
	smpsCall	BossPinch2_Call1F
	smpsCall	BossPinch2_Call21
	smpsCall	BossPinch2_Call22
	smpsCall	BossPinch2_Call23
	smpsCall	BossPinch2_Call22
	smpsCall	BossPinch2_Call24
	smpsCall	BossPinch2_Call1B
	smpsJump	BossPinch2_Jump03

; FM4 Data
BossPinch2_FM4:
	smpsCall	BossPinch2_Call01
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
BossPinch2_Jump04:
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call25
	smpsCall	BossPinch2_Call26
	smpsCall	BossPinch2_Call27
	smpsCall	BossPinch2_Call26
	smpsCall	BossPinch2_Call28
	smpsCall	BossPinch2_Call29
	smpsCall	BossPinch2_Call2A
	smpsCall	BossPinch2_Call29
	smpsCall	BossPinch2_Call2A
	smpsCall	BossPinch2_Call2B
	smpsJump	BossPinch2_Jump04

; FM5 Data
BossPinch2_FM5:
	smpsCall	BossPinch2_Call2C
	smpsCall	BossPinch2_Call2D
	smpsCall	BossPinch2_Call2E
BossPinch2_Jump05:
	smpsCall	BossPinch2_Call2F
	smpsCall	BossPinch2_Call2E
	smpsCall	BossPinch2_Call2D
	smpsCall	BossPinch2_Call30
	smpsCall	BossPinch2_Call31
	smpsCall	BossPinch2_Call30
	smpsCall	BossPinch2_Call32
	smpsCall	BossPinch2_Call2E
	smpsCall	BossPinch2_Call2F
	smpsCall	BossPinch2_Call2E
	smpsCall	BossPinch2_Call2D
	smpsCall	BossPinch2_Call33
	smpsCall	BossPinch2_Call34
	smpsCall	BossPinch2_Call35
	smpsCall	BossPinch2_Call36
	smpsCall	BossPinch2_Call37
	smpsCall	BossPinch2_Call37
	smpsCall	BossPinch2_Call37
	smpsCall	BossPinch2_Call37
	smpsCall	BossPinch2_Call2E
	smpsJump	BossPinch2_Jump05

; PSG1 Data
BossPinch2_PSG1:
	smpsCall	BossPinch2_Call38
	smpsCall	BossPinch2_Call39
	smpsCall	BossPinch2_Call3A
BossPinch2_Jump06:
	smpsCall	BossPinch2_Call3B
	smpsCall	BossPinch2_Call3A
	smpsCall	BossPinch2_Call3C
	smpsCall	BossPinch2_Call3D
	smpsCall	BossPinch2_Call3C
	smpsCall	BossPinch2_Call3D
	smpsCall	BossPinch2_Call39
	smpsCall	BossPinch2_Call3A
	smpsCall	BossPinch2_Call3B
	smpsCall	BossPinch2_Call3A
	smpsCall	BossPinch2_Call3C
	smpsCall	BossPinch2_Call3E
	smpsCall	BossPinch2_Call3F
	smpsCall	BossPinch2_Call3E
	smpsCall	BossPinch2_Call40
	smpsCall	BossPinch2_Call41
	smpsCall	BossPinch2_Call41
	smpsCall	BossPinch2_Call41
	smpsCall	BossPinch2_Call41
	smpsCall	BossPinch2_Call3A
	smpsJump	BossPinch2_Jump06

; PSG2 Data
BossPinch2_PSG2:
	smpsCall	BossPinch2_Call42
	smpsCall	BossPinch2_Call43
	smpsCall	BossPinch2_Call44
BossPinch2_Jump07:
	smpsCall	BossPinch2_Call45
	smpsCall	BossPinch2_Call46
	smpsCall	BossPinch2_Call47
	smpsCall	BossPinch2_Call48
	smpsCall	BossPinch2_Call49
	smpsCall	BossPinch2_Call48
	smpsCall	BossPinch2_Call4A
	smpsCall	BossPinch2_Call44
	smpsCall	BossPinch2_Call45
	smpsCall	BossPinch2_Call46
	smpsCall	BossPinch2_Call47
	smpsCall	BossPinch2_Call4B
	smpsCall	BossPinch2_Call4C
	smpsCall	BossPinch2_Call4B
	smpsCall	BossPinch2_Call4D
	smpsCall	BossPinch2_Call4E
	smpsCall	BossPinch2_Call4F
	smpsCall	BossPinch2_Call4E
	smpsCall	BossPinch2_Call50
	smpsCall	BossPinch2_Call46
	smpsJump	BossPinch2_Jump07

; PSG3 Data
BossPinch2_PSG3:
	smpsPSGform	$E7
	smpsCall	BossPinch2_Call51
	smpsCall	BossPinch2_Call52
BossPinch2_Jump08:
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsCall	BossPinch2_Call52
	smpsJump	BossPinch2_Jump08

; DAC Data
BossPinch2_DAC:
	smpsCall	BossPinch2_Call53
	smpsCall	BossPinch2_Call54
BossPinch2_Jump09:
	smpsCall	BossPinch2_Call54
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call56
	smpsCall	BossPinch2_Call54
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call54
	smpsCall	BossPinch2_Call57
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call54
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call56
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call57
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call55
	smpsCall	BossPinch2_Call57
	smpsCall	BossPinch2_Call54
	smpsJump	BossPinch2_Jump09

BossPinch2_Call02:
	smpsFMvoice	$03
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE4,	nE2,	nB2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE4,	nE2,	nE3,	nA3
	dc.b		nD4,	nFs2,	nFs3,	nFs2,	nCs3,	nFs4,	nFs2,	nC3
	dc.b		nF3,	nF2,	nF4,	nF2,	nF3,	nF2,	nB2,	nF2
	dc.b		nF4
	smpsReturn

BossPinch2_Call03:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE4,	nE2,	nB2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE4,	nE2,	nE3,	nA3
	dc.b		nD4,	nFs2,	nFs3,	nFs2,	nCs3,	nFs4,	nFs2,	nC3
	dc.b		nF3,	nF2,	nF4,	nF2,	nF3,	nF2,	nB2,	nF2
	dc.b		nF4
	smpsReturn

BossPinch2_Call04:
	dc.b		nA2,	$02,	nA3,	nA2,	nA3,	nA2,	nA2,	nE3
	dc.b		nE4,	nA2,	nA3,	nA2,	nA3,	nA2,	nA4,	nA2
	dc.b		nA3,	nA2,	nA3,	nA2,	nA3,	nA2,	nA2,	nE3
	dc.b		nE4,	nA2,	nA3,	nA2,	nA3,	nA2,	nE3,	nA3
	dc.b		nA4
	smpsReturn

BossPinch2_Call05:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE2,	nE2,	nB2
	dc.b		nB3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE4,	nE2
	dc.b		nE3,	nG2,	nG3,	nG2,	nG3,	nG2,	nG2,	nD3
	dc.b		nD4,	nB2,	nB3,	nB2,	nB3,	nB2,	nB4,	nB2
	dc.b		nB3
	smpsReturn

BossPinch2_Call06:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE2,	nE2,	nB2
	dc.b		nB3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE4,	nE2
	dc.b		nE3,	nFs2,	nFs3,	nFs2,	nFs3,	nFs2,	nFs2,	nCs3
	dc.b		nCs4,	nB2,	nB2,	nA2,	nB2,	nB2,	nB2,	nB3
	dc.b		nB2
	smpsReturn

BossPinch2_Call07:
	dc.b		nE2,	$02,	nE2,	nD2,	nE2,	nRst,	$04,	nE2
	dc.b		$02,	nE2,	nD2,	nE2,	nRst,	$0C,	nFs2,	$02
	dc.b		nFs2,	nE2,	nFs2,	nRst,	$04,	nA2,	$02,	nA2
	dc.b		nAb2,	nA2,	nRst,	$04,	nC3,	$02,	nC3,	nB2
	dc.b		nC3
	smpsReturn

BossPinch2_Call08:
	dc.b		nE2,	$02,	nE2,	nD2,	nE2,	nRst,	$04,	nE2
	dc.b		$02,	nE2,	nD2,	nE2,	nRst,	$0C,	nFs2,	$02
	dc.b		nFs2,	nE2,	nFs2,	nRst,	$04,	nEb2,	$02,	nEb2
	dc.b		nD2,	nEb2,	nRst,	$0C
	smpsReturn

BossPinch2_Call0A:
	smpsFMvoice	$00
	dc.b		nB5,	$10,	nD6,	nCs6,	nE6
	smpsReturn

BossPinch2_Call0B:
	dc.b		nRst,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch2_Call0C:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nC6,	$02,	nCs6,	nC6,	nB5,	nFs5,	nD5
	dc.b		nC5,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call0D:
	dc.b		smpsNoAttack,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch2_Call0E:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nAb6,	$02,	nA6,	nAb6,	nG6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call0F:
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch2_Call10:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch2_Call11:
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch2_Call12:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch2_Call13:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call14:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call15:
	dc.b		smpsNoAttack,	$3B,	nEb6,	$01,	nE6,	$02,	nF6
	smpsReturn

BossPinch2_Call16:
	dc.b		nFs6,	$13,	nRst,	$01,	nFs6,	$02,	nG6,	$01
	dc.b		nFs6,	nEb6,	$02,	nC6,	$01,	nRst,	nA5,	nBb5
	dc.b		$03,	nA6,	$02,	nBb6,	nA6,	nF6,	nC6,	nG5
	dc.b		nF5,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call17:
	dc.b		nFs6,	$13,	nRst,	$01,	nA6,	$02,	nBb6,	$01
	dc.b		nA6,	nFs6,	$02,	nF6,	$01,	nRst,	nCs6,	nD6
	dc.b		$03,	nFs7,	$02,	nG7,	nFs7,	nC7,	nG6,	nEb6
	dc.b		nD6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call18:
	smpsFMvoice	$00
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch2_Call19:
	dc.b		nRst,	$34,	nB5,	$02,	nD6,	$01,	nFs6,	$02
	dc.b		nB6,	nC7,	$01,	nCs7,	$02,	nF7
	smpsReturn

BossPinch2_Call1A:
	dc.b		nFs7,	$13,	nRst,	$01,	nE7,	$02,	nF7,	$01
	dc.b		nFs7,	nF7,	$02,	nE7,	$01,	nRst,	nB6,	nFs6
	dc.b		$03,	nC7,	$02,	nCs7,	nC7,	nB6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call1B:
	dc.b		smpsNoAttack,	$34,	nB5,	$02,	nD6,	$01,	nFs6,	$02
	dc.b		nB6,	nC7,	$01,	nCs7,	$02,	nF7
	smpsReturn

BossPinch2_Call1C:
	dc.b		nFs7,	$13,	nRst,	$01,	nE7,	$02,	nF7,	$01
	dc.b		nFs7,	nF7,	$02,	nE7,	$01,	nRst,	nB6,	nFs6
	dc.b		$03,	nAb7,	$02,	nA7,	nAb7,	nG7,	nFs7,	nD7
	dc.b		nC7,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call1D:
	smpsPan		panNone,	$14
	dc.b		nE7,	$08
	smpsPan		panNone,	$04
	dc.b		nBb7,	$10,	nA7
	smpsReturn

BossPinch2_Call1E:
	smpsPan		panNone,	$10
	dc.b		nRst,	$30
	smpsReturn

BossPinch2_Call1F:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch2_Call20:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call21:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call22:
	dc.b		smpsNoAttack,	$3B,	nEb7,	$01,	nE7,	$02,	nF7
	smpsReturn

BossPinch2_Call23:
	dc.b		nFs7,	$13,	nRst,	$01,	nFs7,	$02,	nG7,	$01
	dc.b		nFs7,	nEb7,	$02,	nC7,	$01,	nRst,	nA6,	nBb6
	dc.b		$03,	nA7,	$02,	nBb7,	nA7,	nF7,	nC7,	nG6
	dc.b		nF6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call24:
	dc.b		nFs7,	$13,	nRst,	$01,	nA7,	$02,	nBb7,	$01
	dc.b		nA7,	nFs7,	$02,	nF7,	$01,	nRst,	nCs7,	nD7
	dc.b		$03,	nRst,	$08,	nG7,	$02,	nEb7,	nD7,	$12
	dc.b		nRst,	$02
	smpsReturn

BossPinch2_Call25:
	smpsFMvoice	$02
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nE3,	nE4,	$06,	nRst,	$01,	nE3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nB2,	nRst
	dc.b		$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nF3,	nF4,	$0A,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nF3,	$03,	nRst,	$01
	smpsReturn

BossPinch2_Call26:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nE3,	nE4,	$06,	nRst,	$01,	nE3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nB2,	nRst
	dc.b		$01,	nE3,	nE4,	$06,	nRst,	$01,	nG3,	$03
	dc.b		nRst,	$01,	nG3,	nG4,	$06,	nRst,	$01,	nG3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nG3,	nRst
	dc.b		$01
	smpsReturn

BossPinch2_Call27:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nB2,	nB3,	$06,	nRst,	$01,	nB2
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nE3,	nRst
	dc.b		$01,	nG3,	nG4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nD3,	nD4,	$03,	nB2,	nRst
	dc.b		$01
	smpsReturn

BossPinch2_Call28:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nB2,	nB3,	$06,	nRst,	$01,	nB2
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nE3,	nRst
	dc.b		$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nA3,	nA4,	$06,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nD3,	nD4,	$03,	nB2,	nRst
	dc.b		$01
	smpsReturn

BossPinch2_Call29:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nE3,	$01
	dc.b		nE4,	$08,	nRst,	$03,	nB2,	$01,	nB3,	$06
	dc.b		nRst,	$01,	nFs3,	nFs4,	$08,	nRst,	$03,	nF3
	dc.b		$01,	nF4,	$08,	nRst,	$03,	nB2,	$01,	nB3
	dc.b		$06,	nRst,	$01
	smpsReturn

BossPinch2_Call2A:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nB2,	$01
	dc.b		nB3,	$08,	nRst,	$03,	nE3,	$01,	nE4,	$06
	dc.b		nRst,	$01,	nFs3,	nFs4,	$08,	nRst,	$03,	nF3
	dc.b		$01,	nF4,	$08,	nRst,	$03,	nB2,	$01,	nB3
	dc.b		$06,	nRst,	$01
	smpsReturn

BossPinch2_Call2B:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nE3,	$01
	dc.b		nE4,	$0A,	nRst,	$09,	nFs3,	$01,	nFs4,	$08
	dc.b		nRst,	$03,	nF3,	$01,	nF4,	$0A,	nRst,	$09
	smpsReturn

BossPinch2_Call2D:
	smpsFMvoice	$01
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch2_Call2E:
	smpsFMvoice	$01
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch2_Call2F:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch2_Call30:
	dc.b		nG6,	$14,	nB5,	$08,	nG6,	$04,	nFs6,	$10
	dc.b		nF6
	smpsReturn

BossPinch2_Call31:
	dc.b		nG6,	$10,	nB6,	nBb6,	nA6
	smpsReturn

BossPinch2_Call32:
	dc.b		nG6,	$10,	nB6,	nBb6,	nC7
	smpsReturn

BossPinch2_Call33:
	dc.b		nRst,	$04,	nC7,	$01,	nRst,	$03,	nB6,	$04
	dc.b		nC7,	$01,	nRst,	$03,	nG6,	$0F,	nRst,	$01
	dc.b		nFs6,	$0B,	nRst,	$01,	nE6,	$04,	nRst,	nE6
	dc.b		$01,	nRst,	$03,	nD6,	$04,	nE6,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch2_Call34:
	dc.b		nD6,	$0F,	nRst,	$05,	nFs6,	$01,	nRst,	$03
	dc.b		nE6,	$04,	nC6,	$01,	nRst,	$03,	nCs6,	$0F
	dc.b		nRst,	$01,	nFs6,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call35:
	dc.b		smpsNoAttack,	$04,	nC7,	$01,	nRst,	$03,	nB6,	$04
	dc.b		nC7,	$01,	nRst,	$03,	nG6,	$0F,	nRst,	$01
	dc.b		nFs6,	$0B,	nRst,	$01,	nE6,	$04,	nRst,	nE6
	dc.b		$01,	nRst,	$03,	nD6,	$04,	nE6,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch2_Call36:
	dc.b		nD6,	$0F,	nRst,	$05,	nFs6,	$01,	nRst,	$03
	dc.b		nF6,	$04,	nFs6,	$01,	nRst,	$03,	nB6,	$0F
	dc.b		nRst,	$01,	nEb7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call37:
	dc.b		smpsNoAttack,	$40
	smpsReturn

BossPinch2_Call39:
	smpsPSGvoice	$00
	dc.b		nE4,	$10,	nG4,	nBb4,	nA4
	smpsReturn

BossPinch2_Call3A:
	dc.b		nG4,	$14,	nB3,	$08,	nG4,	$04,	nFs4,	$10
	dc.b		nF4
	smpsReturn

BossPinch2_Call3B:
	dc.b		nG4,	$10,	nB4,	nBb4,	nA4
	smpsReturn

BossPinch2_Call3C:
	dc.b		nE4,	$10,	nG4,	nFs4,	nF4
	smpsReturn

BossPinch2_Call3D:
	dc.b		nE4,	$14,	nB3,	$08,	nE4,	$04,	nCs4,	$10
	dc.b		nC4
	smpsReturn

BossPinch2_Call3E:
	dc.b		nA3,	$0B,	nRst,	$01,	nC4,	$13,	nRst,	$01
	dc.b		nEb4,	$0B,	nRst,	$01,	nE4,	$13,	nRst,	$01
	smpsReturn

BossPinch2_Call3F:
	dc.b		nE4,	$0B,	nRst,	$01,	nG4,	$13,	nRst,	$01
	dc.b		nBb4,	$0F,	nRst,	$01,	nB4,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call40:
	dc.b		nG4,	$0B,	nRst,	$01,	nB4,	$13,	nRst,	$01
	dc.b		nEb5,	$0F,	nRst,	$01,	nFs5,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call41:
	dc.b		nG4,	$01,	nRst,	$05,	nG5,	$01,	nRst,	$05
	dc.b		nG4,	$01,	nRst,	$03,	nG4,	$01,	nRst,	$05
	dc.b		nB5,	$01,	nRst,	$05,	nG4,	$01,	nRst,	$03
	dc.b		nFs4,	$01,	nRst,	$05,	nFs5,	$01,	nRst,	$05
	dc.b		nBb4,	$01,	nRst,	$03,	nA4,	$01,	nRst,	$03
	dc.b		nA4,	$01,	nRst,	nA5,	nRst,	$03,	nF5,	$01
	dc.b		nRst,	nA4,	nRst,	$03
	smpsReturn

BossPinch2_Call43:
	smpsPSGvoice	$00
	dc.b		nB5,	$10,	nD6,	nCs6,	nE6
	smpsReturn

BossPinch2_Call44:
	dc.b		nRst,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch2_Call45:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nC6,	$02,	nCs6,	nC6,	nB5,	nFs5,	nD5
	dc.b		nC5,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call46:
	dc.b		smpsNoAttack,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch2_Call47:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nAb6,	$02,	nA6,	nAb6,	nG6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call48:
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch2_Call49:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch2_Call4A:
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch2_Call4B:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch2_Call4C:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call4D:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch2_Call4E:
	dc.b		smpsNoAttack,	$3B,	nEb6,	$01,	nE6,	$02,	nF6
	smpsReturn

BossPinch2_Call4F:
	dc.b		nFs6,	$13,	nRst,	$01,	nFs6,	$02,	nG6,	$01
	dc.b		nFs6,	nEb6,	$02,	nC6,	$01,	nRst,	nA5,	nBb5
	dc.b		$03,	nA6,	$02,	nBb6,	nA6,	nF6,	nC6,	nG5
	dc.b		nF5,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call50:
	dc.b		nFs6,	$13,	nRst,	$01,	nA6,	$02,	nBb6,	$01
	dc.b		nA6,	nFs6,	$02,	nF6,	$01,	nRst,	nCs6,	nD6
	dc.b		$03,	nFs7,	$02,	nG7,	nFs7,	nC7,	nG6,	nEb6
	dc.b		nD6,	$12,	nRst,	$02
	smpsReturn

BossPinch2_Call51:
	smpsPSGvoice	$02
	dc.b		nCs0,	$02,	nCs0
	smpsPSGvoice	$01
	dc.b		nCs0,	$04
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0,	$02,	nRst,	nCs0,	$04,	$06,	nRst,	$02
	dc.b		nCs0,	$04,	$08,	$02,	nRst
	smpsReturn

BossPinch2_Call52:
	smpsPSGvoice	$02
	dc.b		nCs0,	$02,	nCs0
	smpsPSGvoice	$01
	dc.b		nCs0,	$04
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0,	$02,	nCs0
	smpsPSGvoice	$01
	dc.b		nCs0,	$04
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsPSGvoice	$02
	dc.b		nCs0
	smpsPSGvoice	$01
	dc.b		nCs0
	smpsReturn

BP2Kick = $90
BP2Snare = $8F

BossPinch2_Call53:
	dc.b		BP2Kick,	$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04
	dc.b		$02,	BP2Kick,	nRst,	BP2Snare,	$04,	nRst,	$02,	nRst
	dc.b		BP2Kick,	$04,	BP2Snare,	BP2Snare,	BP2Kick,	$02,	nRst,	BP2Snare
	dc.b		BP2Kick,	BP2Snare,	$04,	BP2Kick,	nRst
	smpsReturn

BossPinch2_Call54:
	dc.b		BP2Kick,	$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04
	dc.b		$02,	BP2Kick,	nRst,	BP2Snare,	$06,	nRst,	$02,	BP2Kick
	dc.b		$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04,	$02
	dc.b		BP2Kick,	nRst,	BP2Snare,	$08
	smpsReturn

BossPinch2_Call55:
	dc.b		BP2Kick,	$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04
	dc.b		$02,	BP2Kick,	nRst,	BP2Snare,	$08,	BP2Kick,	$04,	BP2Kick
	dc.b		BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04,	$02,	BP2Kick,	nRst
	dc.b		BP2Snare,	$08
	smpsReturn

BossPinch2_Call56:
	dc.b		BP2Kick,	$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04
	dc.b		$02,	BP2Kick,	nRst,	BP2Snare,	$06,	nRst,	$02,	BP2Kick
	dc.b		$04,	BP2Snare,	BP2Snare,	BP2Kick,	$02,	nRst,	BP2Snare,	BP2Kick
	dc.b		BP2Snare,	$04,	BP2Kick,	$08
	smpsReturn

BossPinch2_Call57:
	dc.b		BP2Kick,	$04,	BP2Kick,	BP2Snare,	BP2Kick,	$02,	BP2Snare,	$04
	dc.b		$02,	BP2Kick,	nRst,	BP2Snare,	$08,	BP2Kick,	$04,	BP2Snare
	dc.b		BP2Snare,	BP2Kick,	$02,	nRst,	BP2Snare,	BP2Kick,	BP2Snare,	$04
	dc.b		BP2Kick,	$08
	smpsReturn

BossPinch2_Voices:
	dc.b	$F2, $31, $21, $51, $21, $1F, $1F, $1F, $1F, $01, $04, $04, $82, $00, $00, $00, $00, $03, $05, $05, $07, $13, $18, $1B, $05
	dc.b	$3a,$31,$20,$41,$61,$8f,$8f,$8e,$54,$e,$3,$e,$3,$0,$0,$0
	dc.b	$0,$13,$f3,$13,$a,$18,$22,$1b,$80	; Voice 2 (DangerousSeed-3rdTube-3:FM1 Lead (Mod $1E, $01, $05, $05))
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 02
	dc.b	$3d,$1,$2,$2,$2,$10,$50,$50,$50,$7,$8,$8,$8,$1,$0,$0
	dc.b	$0,$20,$17,$17,$17,$1c,$88,$88,$88	; Voice 2 (Puto-Sawtooth)


	dc.b	$38,$dc,$f4,$36,$8,$1b,$13,$1a,$1b,$e,$0,$8,$a,$0,$5,$5
	dc.b	$2,$34,$5,$14,$15,$1a,$19,$18,$80	; Voice 0 (G:\Sam\hax\music\graveyard_1.tfi)
	dc.b	$39,$38,$d8,$8,$8,$90,$8f,$94,$91,$9,$6,$3,$3,$0,$0,$0
	dc.b	$0,$38,$17,$16,$17,$16,$18,$1a,$80	; Voice 1 (G:\Sam\hax\music\graveyard_0.tfi)
	dc.b	$10,$fb,$0,$31,$1,$1e,$1f,$1f,$1f,$c,$11,$11,$c,$2,$c,$2
	dc.b	$1,$1d,$25,$36,$6,$11,$2e,$10,$80	; Voice 2 (G:\Sam\hax\music\airpassage_2.tfi)


	dc.b		$3D,$01,$02,$02,$02,$10,$50,$50,$50,$07,$08,$08,$08,$01,$00,$00
	dc.b		$00,$20,$17,$17,$17,$1C,$88,$88,$88;			Voice 00
	dc.b		$3B,$51,$71,$61,$41,$51,$16,$18,$1A,$05,$01,$01,$00,$09,$01,$01
	dc.b		$01,$17,$97,$27,$87,$1C,$22,$15,$7F;			Voice 01
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 02
	dc.b		$3A,$31,$20,$41,$61,$8F,$8F,$8E,$54,$0E,$03,$0E,$03,$00,$00,$00
	dc.b		$00,$13,$F3,$13,$0A,$17,$21,$19,$80;			Voice 03

	even
