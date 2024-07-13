; =============================================================================================
; Project Name:		BossPinch
; Created:		20th July 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

BossPinch_Header:
	smpsHeaderVoice	BossPinch_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$02,	$04

	smpsHeaderDAC	BossPinch_DAC
	smpsHeaderFM	BossPinch_FM1,	smpsPitch00,	$0E
	smpsHeaderFM	BossPinch_FM2,	smpsPitch01lo,	$11
	smpsHeaderFM	BossPinch_FM4,	smpsPitch01lo,	$14
	smpsHeaderFM	BossPinch_FM5,	smpsPitch01lo,	$0F
	smpsHeaderFM	BossPinch_FM3,	smpsPitch01lo,	$12
	smpsHeaderPSG	BossPinch_PSG1,	smpsPitch03lo,	$03,	$00
	smpsHeaderPSG	BossPinch_PSG2,	smpsPitch03lo,	$03,	$00
	smpsHeaderPSG	BossPinch_PSG3,	$5C,		$02,	$00

BossPinch_Call01:
	smpsModSet	$1E,	$01,	$05,	$05
	smpsReturn

BossPinch_Call09:
	smpsModSet	$10,	$01,	$02,	$04
	smpsReturn

BossPinch_Call2C:
	smpsModSet	$03,	$13,	$04,	$01
	smpsReturn

BossPinch_Call38:
	smpsModSet	$10,	$01,	$01,	$02
	smpsReturn

BossPinch_Call42:
	smpsModSet	$13,	$02,	$01,	$01
	smpsReturn

; FM1 Data
BossPinch_FM1:
	smpsCall	BossPinch_Call01
	smpsCall	BossPinch_Call02
	smpsCall	BossPinch_Call03
BossPinch_Jump01:
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call03
	smpsCall	BossPinch_Call04
	smpsCall	BossPinch_Call05
	smpsCall	BossPinch_Call04
	smpsCall	BossPinch_Call06
	smpsCall	BossPinch_Call07
	smpsCall	BossPinch_Call08
	smpsCall	BossPinch_Call07
	smpsCall	BossPinch_Call08
	smpsCall	BossPinch_Call03
	smpsJump	BossPinch_Jump01

; FM2 Data
BossPinch_FM2:
	smpsCall	BossPinch_Call09
	smpsCall	BossPinch_Call0A
	smpsCall	BossPinch_Call0B
BossPinch_Jump02:
	smpsCall	BossPinch_Call0C
	smpsCall	BossPinch_Call0D
	smpsCall	BossPinch_Call0E
	smpsCall	BossPinch_Call0F
	smpsCall	BossPinch_Call10
	smpsCall	BossPinch_Call0F
	smpsCall	BossPinch_Call11
	smpsCall	BossPinch_Call0B
	smpsCall	BossPinch_Call0C
	smpsCall	BossPinch_Call0D
	smpsCall	BossPinch_Call0E
	smpsCall	BossPinch_Call12
	smpsCall	BossPinch_Call13
	smpsCall	BossPinch_Call12
	smpsCall	BossPinch_Call14
	smpsCall	BossPinch_Call15
	smpsCall	BossPinch_Call16
	smpsCall	BossPinch_Call15
	smpsCall	BossPinch_Call17
	smpsCall	BossPinch_Call0D
	smpsJump	BossPinch_Jump02

; FM3 Data
BossPinch_FM3:
	smpsCall	BossPinch_Call09
	smpsCall	BossPinch_Call18
	smpsCall	BossPinch_Call19
BossPinch_Jump03:
	smpsCall	BossPinch_Call1A
	smpsCall	BossPinch_Call1B
	smpsCall	BossPinch_Call1C
	smpsCall	BossPinch_Call1D
	smpsCall	BossPinch_Call1E
	smpsCall	BossPinch_Call1D
	smpsCall	BossPinch_Call1E
	smpsCall	BossPinch_Call1B
	smpsCall	BossPinch_Call1A
	smpsCall	BossPinch_Call1B
	smpsCall	BossPinch_Call1C
	smpsCall	BossPinch_Call1F
	smpsCall	BossPinch_Call20
	smpsCall	BossPinch_Call1F
	smpsCall	BossPinch_Call21
	smpsCall	BossPinch_Call22
	smpsCall	BossPinch_Call23
	smpsCall	BossPinch_Call22
	smpsCall	BossPinch_Call24
	smpsCall	BossPinch_Call1B
	smpsJump	BossPinch_Jump03

; FM4 Data
BossPinch_FM4:
	smpsCall	BossPinch_Call01
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
BossPinch_Jump04:
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call25
	smpsCall	BossPinch_Call26
	smpsCall	BossPinch_Call27
	smpsCall	BossPinch_Call26
	smpsCall	BossPinch_Call28
	smpsCall	BossPinch_Call29
	smpsCall	BossPinch_Call2A
	smpsCall	BossPinch_Call29
	smpsCall	BossPinch_Call2A
	smpsCall	BossPinch_Call2B
	smpsJump	BossPinch_Jump04

; FM5 Data
BossPinch_FM5:
	smpsCall	BossPinch_Call2C
	smpsCall	BossPinch_Call2D
	smpsCall	BossPinch_Call2E
BossPinch_Jump05:
	smpsCall	BossPinch_Call2F
	smpsCall	BossPinch_Call2E
	smpsCall	BossPinch_Call2D
	smpsCall	BossPinch_Call30
	smpsCall	BossPinch_Call31
	smpsCall	BossPinch_Call30
	smpsCall	BossPinch_Call32
	smpsCall	BossPinch_Call2E
	smpsCall	BossPinch_Call2F
	smpsCall	BossPinch_Call2E
	smpsCall	BossPinch_Call2D
	smpsCall	BossPinch_Call33
	smpsCall	BossPinch_Call34
	smpsCall	BossPinch_Call35
	smpsCall	BossPinch_Call36
	smpsCall	BossPinch_Call37
	smpsCall	BossPinch_Call37
	smpsCall	BossPinch_Call37
	smpsCall	BossPinch_Call37
	smpsCall	BossPinch_Call2E
	smpsJump	BossPinch_Jump05

; PSG1 Data
BossPinch_PSG1:
	smpsCall	BossPinch_Call38
	smpsCall	BossPinch_Call39
	smpsCall	BossPinch_Call3A
BossPinch_Jump06:
	smpsCall	BossPinch_Call3B
	smpsCall	BossPinch_Call3A
	smpsCall	BossPinch_Call3C
	smpsCall	BossPinch_Call3D
	smpsCall	BossPinch_Call3C
	smpsCall	BossPinch_Call3D
	smpsCall	BossPinch_Call39
	smpsCall	BossPinch_Call3A
	smpsCall	BossPinch_Call3B
	smpsCall	BossPinch_Call3A
	smpsCall	BossPinch_Call3C
	smpsCall	BossPinch_Call3E
	smpsCall	BossPinch_Call3F
	smpsCall	BossPinch_Call3E
	smpsCall	BossPinch_Call40
	smpsCall	BossPinch_Call41
	smpsCall	BossPinch_Call41
	smpsCall	BossPinch_Call41
	smpsCall	BossPinch_Call41
	smpsCall	BossPinch_Call3A
	smpsJump	BossPinch_Jump06

; PSG2 Data
BossPinch_PSG2:
	smpsCall	BossPinch_Call42
	smpsCall	BossPinch_Call43
	smpsCall	BossPinch_Call44
BossPinch_Jump07:
	smpsCall	BossPinch_Call45
	smpsCall	BossPinch_Call46
	smpsCall	BossPinch_Call47
	smpsCall	BossPinch_Call48
	smpsCall	BossPinch_Call49
	smpsCall	BossPinch_Call48
	smpsCall	BossPinch_Call4A
	smpsCall	BossPinch_Call44
	smpsCall	BossPinch_Call45
	smpsCall	BossPinch_Call46
	smpsCall	BossPinch_Call47
	smpsCall	BossPinch_Call4B
	smpsCall	BossPinch_Call4C
	smpsCall	BossPinch_Call4B
	smpsCall	BossPinch_Call4D
	smpsCall	BossPinch_Call4E
	smpsCall	BossPinch_Call4F
	smpsCall	BossPinch_Call4E
	smpsCall	BossPinch_Call50
	smpsCall	BossPinch_Call46
	smpsJump	BossPinch_Jump07

; PSG3 Data
BossPinch_PSG3:
	smpsPSGform	$E7
	smpsCall	BossPinch_Call51
	smpsCall	BossPinch_Call52
BossPinch_Jump08:
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsCall	BossPinch_Call52
	smpsJump	BossPinch_Jump08

; DAC Data
BossPinch_DAC:
	smpsCall	BossPinch_Call53
	smpsCall	BossPinch_Call54
BossPinch_Jump09:
	smpsCall	BossPinch_Call54
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call56
	smpsCall	BossPinch_Call54
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call54
	smpsCall	BossPinch_Call57
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call54
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call56
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call57
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call55
	smpsCall	BossPinch_Call57
	smpsCall	BossPinch_Call54
	smpsJump	BossPinch_Jump09

BossPinch_Call02:
	smpsFMvoice	$03
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE4,	nE2,	nB2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE4,	nE2,	nE3,	nA3
	dc.b		nD4,	nFs2,	nFs3,	nFs2,	nCs3,	nFs4,	nFs2,	nC3
	dc.b		nF3,	nF2,	nF4,	nF2,	nF3,	nF2,	nB2,	nF2
	dc.b		nF4
	smpsReturn

BossPinch_Call03:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE4,	nE2,	nB2
	dc.b		nE3,	nE2,	nE3,	nE2,	nE4,	nE2,	nE3,	nA3
	dc.b		nD4,	nFs2,	nFs3,	nFs2,	nCs3,	nFs4,	nFs2,	nC3
	dc.b		nF3,	nF2,	nF4,	nF2,	nF3,	nF2,	nB2,	nF2
	dc.b		nF4
	smpsReturn

BossPinch_Call04:
	dc.b		nA2,	$02,	nA3,	nA2,	nA3,	nA2,	nA2,	nE3
	dc.b		nE4,	nA2,	nA3,	nA2,	nA3,	nA2,	nA4,	nA2
	dc.b		nA3,	nA2,	nA3,	nA2,	nA3,	nA2,	nA2,	nE3
	dc.b		nE4,	nA2,	nA3,	nA2,	nA3,	nA2,	nE3,	nA3
	dc.b		nA4
	smpsReturn

BossPinch_Call05:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE2,	nE2,	nB2
	dc.b		nB3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE4,	nE2
	dc.b		nE3,	nG2,	nG3,	nG2,	nG3,	nG2,	nG2,	nD3
	dc.b		nD4,	nB2,	nB3,	nB2,	nB3,	nB2,	nB4,	nB2
	dc.b		nB3
	smpsReturn

BossPinch_Call06:
	dc.b		nE2,	$02,	nE3,	nE2,	nE3,	nE2,	nE2,	nB2
	dc.b		nB3,	nE2,	nE3,	nE2,	nE3,	nE2,	nE4,	nE2
	dc.b		nE3,	nFs2,	nFs3,	nFs2,	nFs3,	nFs2,	nFs2,	nCs3
	dc.b		nCs4,	nB2,	nB2,	nA2,	nB2,	nB2,	nB2,	nB3
	dc.b		nB2
	smpsReturn

BossPinch_Call07:
	dc.b		nE2,	$02,	nE2,	nD2,	nE2,	nRst,	$04,	nE2
	dc.b		$02,	nE2,	nD2,	nE2,	nRst,	$0C,	nFs2,	$02
	dc.b		nFs2,	nE2,	nFs2,	nRst,	$04,	nA2,	$02,	nA2
	dc.b		nAb2,	nA2,	nRst,	$04,	nC3,	$02,	nC3,	nB2
	dc.b		nC3
	smpsReturn

BossPinch_Call08:
	dc.b		nE2,	$02,	nE2,	nD2,	nE2,	nRst,	$04,	nE2
	dc.b		$02,	nE2,	nD2,	nE2,	nRst,	$0C,	nFs2,	$02
	dc.b		nFs2,	nE2,	nFs2,	nRst,	$04,	nEb2,	$02,	nEb2
	dc.b		nD2,	nEb2,	nRst,	$0C
	smpsReturn

BossPinch_Call0A:
	smpsFMvoice	$00
	dc.b		nB5,	$10,	nD6,	nCs6,	nE6
	smpsReturn

BossPinch_Call0B:
	dc.b		nRst,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch_Call0C:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nC6,	$02,	nCs6,	nC6,	nB5,	nFs5,	nD5
	dc.b		nC5,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call0D:
	dc.b		smpsNoAttack,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch_Call0E:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nAb6,	$02,	nA6,	nAb6,	nG6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call0F:
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch_Call10:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch_Call11:
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch_Call12:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch_Call13:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call14:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call15:
	dc.b		smpsNoAttack,	$3B,	nEb6,	$01,	nE6,	$02,	nF6
	smpsReturn

BossPinch_Call16:
	dc.b		nFs6,	$13,	nRst,	$01,	nFs6,	$02,	nG6,	$01
	dc.b		nFs6,	nEb6,	$02,	nC6,	$01,	nRst,	nA5,	nBb5
	dc.b		$03,	nA6,	$02,	nBb6,	nA6,	nF6,	nC6,	nG5
	dc.b		nF5,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call17:
	dc.b		nFs6,	$13,	nRst,	$01,	nA6,	$02,	nBb6,	$01
	dc.b		nA6,	nFs6,	$02,	nF6,	$01,	nRst,	nCs6,	nD6
	dc.b		$03,	nFs7,	$02,	nG7,	nFs7,	nC7,	nG6,	nEb6
	dc.b		nD6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call18:
	smpsFMvoice	$00
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch_Call19:
	dc.b		nRst,	$34,	nB5,	$02,	nD6,	$01,	nFs6,	$02
	dc.b		nB6,	nC7,	$01,	nCs7,	$02,	nF7
	smpsReturn

BossPinch_Call1A:
	dc.b		nFs7,	$13,	nRst,	$01,	nE7,	$02,	nF7,	$01
	dc.b		nFs7,	nF7,	$02,	nE7,	$01,	nRst,	nB6,	nFs6
	dc.b		$03,	nC7,	$02,	nCs7,	nC7,	nB6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call1B:
	dc.b		smpsNoAttack,	$34,	nB5,	$02,	nD6,	$01,	nFs6,	$02
	dc.b		nB6,	nC7,	$01,	nCs7,	$02,	nF7
	smpsReturn

BossPinch_Call1C:
	dc.b		nFs7,	$13,	nRst,	$01,	nE7,	$02,	nF7,	$01
	dc.b		nFs7,	nF7,	$02,	nE7,	$01,	nRst,	nB6,	nFs6
	dc.b		$03,	nAb7,	$02,	nA7,	nAb7,	nG7,	nFs7,	nD7
	dc.b		nC7,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call1D:
	smpsPan		panNone,	$14
	dc.b		nE7,	$08
	smpsPan		panNone,	$04
	dc.b		nBb7,	$10,	nA7
	smpsReturn

BossPinch_Call1E:
	smpsPan		panNone,	$10
	dc.b		nRst,	$30
	smpsReturn

BossPinch_Call1F:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch_Call20:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call21:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call22:
	dc.b		smpsNoAttack,	$3B,	nEb7,	$01,	nE7,	$02,	nF7
	smpsReturn

BossPinch_Call23:
	dc.b		nFs7,	$13,	nRst,	$01,	nFs7,	$02,	nG7,	$01
	dc.b		nFs7,	nEb7,	$02,	nC7,	$01,	nRst,	nA6,	nBb6
	dc.b		$03,	nA7,	$02,	nBb7,	nA7,	nF7,	nC7,	nG6
	dc.b		nF6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call24:
	dc.b		nFs7,	$13,	nRst,	$01,	nA7,	$02,	nBb7,	$01
	dc.b		nA7,	nFs7,	$02,	nF7,	$01,	nRst,	nCs7,	nD7
	dc.b		$03,	nRst,	$08,	nG7,	$02,	nEb7,	nD7,	$12
	dc.b		nRst,	$02
	smpsReturn

BossPinch_Call25:
	smpsFMvoice	$02
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nE3,	nE4,	$06,	nRst,	$01,	nE3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nB2,	nRst
	dc.b		$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nF3,	nF4,	$0A,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nF3,	$03,	nRst,	$01
	smpsReturn

BossPinch_Call26:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nE3,	nE4,	$06,	nRst,	$01,	nE3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nB2,	nRst
	dc.b		$01,	nE3,	nE4,	$06,	nRst,	$01,	nG3,	$03
	dc.b		nRst,	$01,	nG3,	nG4,	$06,	nRst,	$01,	nG3
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nG3,	nRst
	dc.b		$01
	smpsReturn

BossPinch_Call27:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nB2,	nB3,	$06,	nRst,	$01,	nB2
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nE3,	nRst
	dc.b		$01,	nG3,	nG4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nD3,	nD4,	$03,	nB2,	nRst
	dc.b		$01
	smpsReturn

BossPinch_Call28:
	dc.b		nE3,	$01,	nE4,	$06,	nRst,	$01,	nE3,	$03
	dc.b		nRst,	$01,	nB2,	nB3,	$06,	nRst,	$01,	nB2
	dc.b		$03,	nRst,	$01,	nB2,	nB3,	$03,	nE3,	nRst
	dc.b		$01,	nFs3,	nFs4,	$06,	nRst,	$01,	nFs3,	$03
	dc.b		nRst,	$01,	nA3,	nA4,	$06,	nRst,	$01,	nF3
	dc.b		$03,	nRst,	$01,	nD3,	nD4,	$03,	nB2,	nRst
	dc.b		$01
	smpsReturn

BossPinch_Call29:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nE3,	$01
	dc.b		nE4,	$08,	nRst,	$03,	nB2,	$01,	nB3,	$06
	dc.b		nRst,	$01,	nFs3,	nFs4,	$08,	nRst,	$03,	nF3
	dc.b		$01,	nF4,	$08,	nRst,	$03,	nB2,	$01,	nB3
	dc.b		$06,	nRst,	$01
	smpsReturn

BossPinch_Call2A:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nB2,	$01
	dc.b		nB3,	$08,	nRst,	$03,	nE3,	$01,	nE4,	$06
	dc.b		nRst,	$01,	nFs3,	nFs4,	$08,	nRst,	$03,	nF3
	dc.b		$01,	nF4,	$08,	nRst,	$03,	nB2,	$01,	nB3
	dc.b		$06,	nRst,	$01
	smpsReturn

BossPinch_Call2B:
	dc.b		nE3,	$01,	nE4,	$08,	nRst,	$03,	nE3,	$01
	dc.b		nE4,	$0A,	nRst,	$09,	nFs3,	$01,	nFs4,	$08
	dc.b		nRst,	$03,	nF3,	$01,	nF4,	$0A,	nRst,	$09
	smpsReturn

BossPinch_Call2D:
	smpsFMvoice	$01
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch_Call2E:
	smpsFMvoice	$01
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch_Call2F:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch_Call30:
	dc.b		nG6,	$14,	nB5,	$08,	nG6,	$04,	nFs6,	$10
	dc.b		nF6
	smpsReturn

BossPinch_Call31:
	dc.b		nG6,	$10,	nB6,	nBb6,	nA6
	smpsReturn

BossPinch_Call32:
	dc.b		nG6,	$10,	nB6,	nBb6,	nC7
	smpsReturn

BossPinch_Call33:
	dc.b		nRst,	$04,	nC7,	$01,	nRst,	$03,	nB6,	$04
	dc.b		nC7,	$01,	nRst,	$03,	nG6,	$0F,	nRst,	$01
	dc.b		nFs6,	$0B,	nRst,	$01,	nE6,	$04,	nRst,	nE6
	dc.b		$01,	nRst,	$03,	nD6,	$04,	nE6,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch_Call34:
	dc.b		nD6,	$0F,	nRst,	$05,	nFs6,	$01,	nRst,	$03
	dc.b		nE6,	$04,	nC6,	$01,	nRst,	$03,	nCs6,	$0F
	dc.b		nRst,	$01,	nFs6,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call35:
	dc.b		smpsNoAttack,	$04,	nC7,	$01,	nRst,	$03,	nB6,	$04
	dc.b		nC7,	$01,	nRst,	$03,	nG6,	$0F,	nRst,	$01
	dc.b		nFs6,	$0B,	nRst,	$01,	nE6,	$04,	nRst,	nE6
	dc.b		$01,	nRst,	$03,	nD6,	$04,	nE6,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch_Call36:
	dc.b		nD6,	$0F,	nRst,	$05,	nFs6,	$01,	nRst,	$03
	dc.b		nF6,	$04,	nFs6,	$01,	nRst,	$03,	nB6,	$0F
	dc.b		nRst,	$01,	nEb7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call37:
	dc.b		smpsNoAttack,	$40
	smpsReturn

BossPinch_Call39:
	smpsPSGvoice	$00
	dc.b		nE4,	$10,	nG4,	nBb4,	nA4
	smpsReturn

BossPinch_Call3A:
	dc.b		nG4,	$14,	nB3,	$08,	nG4,	$04,	nFs4,	$10
	dc.b		nF4
	smpsReturn

BossPinch_Call3B:
	dc.b		nG4,	$10,	nB4,	nBb4,	nA4
	smpsReturn

BossPinch_Call3C:
	dc.b		nE4,	$10,	nG4,	nFs4,	nF4
	smpsReturn

BossPinch_Call3D:
	dc.b		nE4,	$14,	nB3,	$08,	nE4,	$04,	nCs4,	$10
	dc.b		nC4
	smpsReturn

BossPinch_Call3E:
	dc.b		nA3,	$0B,	nRst,	$01,	nC4,	$13,	nRst,	$01
	dc.b		nEb4,	$0B,	nRst,	$01,	nE4,	$13,	nRst,	$01
	smpsReturn

BossPinch_Call3F:
	dc.b		nE4,	$0B,	nRst,	$01,	nG4,	$13,	nRst,	$01
	dc.b		nBb4,	$0F,	nRst,	$01,	nB4,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call40:
	dc.b		nG4,	$0B,	nRst,	$01,	nB4,	$13,	nRst,	$01
	dc.b		nEb5,	$0F,	nRst,	$01,	nFs5,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call41:
	dc.b		nG4,	$01,	nRst,	$05,	nG5,	$01,	nRst,	$05
	dc.b		nG4,	$01,	nRst,	$03,	nG4,	$01,	nRst,	$05
	dc.b		nB5,	$01,	nRst,	$05,	nG4,	$01,	nRst,	$03
	dc.b		nFs4,	$01,	nRst,	$05,	nFs5,	$01,	nRst,	$05
	dc.b		nBb4,	$01,	nRst,	$03,	nA4,	$01,	nRst,	$03
	dc.b		nA4,	$01,	nRst,	nA5,	nRst,	$03,	nF5,	$01
	dc.b		nRst,	nA4,	nRst,	$03
	smpsReturn

BossPinch_Call43:
	smpsPSGvoice	$00
	dc.b		nB5,	$10,	nD6,	nCs6,	nE6
	smpsReturn

BossPinch_Call44:
	dc.b		nRst,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch_Call45:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nC6,	$02,	nCs6,	nC6,	nB5,	nFs5,	nD5
	dc.b		nC5,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call46:
	dc.b		smpsNoAttack,	$34,	nB4,	$02,	nD5,	$01,	nFs5,	$02
	dc.b		nB5,	nC6,	$01,	nCs6,	$02,	nF6
	smpsReturn

BossPinch_Call47:
	dc.b		nFs6,	$13,	nRst,	$01,	nE6,	$02,	nF6,	$01
	dc.b		nFs6,	nF6,	$02,	nE6,	$01,	nRst,	nB5,	nFs5
	dc.b		$03,	nAb6,	$02,	nA6,	nAb6,	nG6,	nFs6,	nD6
	dc.b		nC6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call48:
	dc.b		nB6,	$14,	nE6,	$08,	nB6,	$04,	nBb6,	$10
	dc.b		nA6
	smpsReturn

BossPinch_Call49:
	dc.b		nB6,	$10,	nD7,	nCs7,	nC7
	smpsReturn

BossPinch_Call4A:
	dc.b		nB6,	$10,	nD7,	nCs7,	nE7
	smpsReturn

BossPinch_Call4B:
	dc.b		smpsNoAttack,	$04,	nG7,	$01,	nRst,	$03,	nFs7,	$04
	dc.b		nG7,	$01,	nRst,	$03,	nE7,	$0F,	nRst,	$01
	dc.b		nD7,	$0B,	nRst,	$01,	nC7,	$04,	nRst,	nC7
	dc.b		$01,	nRst,	$03,	nB6,	$04,	nC7,	$01,	nRst
	dc.b		$03
	smpsReturn

BossPinch_Call4C:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nC7,	$04,	nA6,	$01,	nRst,	$03,	nG6,	$0F
	dc.b		nRst,	$01,	nD7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call4D:
	dc.b		nB6,	$0F,	nRst,	$05,	nD7,	$01,	nRst,	$03
	dc.b		nCs7,	$04,	nD7,	$01,	nRst,	$03,	nFs7,	$0F
	dc.b		nRst,	$01,	nA7,	$0F,	nRst,	$01
	smpsReturn

BossPinch_Call4E:
	dc.b		smpsNoAttack,	$3B,	nEb6,	$01,	nE6,	$02,	nF6
	smpsReturn

BossPinch_Call4F:
	dc.b		nFs6,	$13,	nRst,	$01,	nFs6,	$02,	nG6,	$01
	dc.b		nFs6,	nEb6,	$02,	nC6,	$01,	nRst,	nA5,	nBb5
	dc.b		$03,	nA6,	$02,	nBb6,	nA6,	nF6,	nC6,	nG5
	dc.b		nF5,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call50:
	dc.b		nFs6,	$13,	nRst,	$01,	nA6,	$02,	nBb6,	$01
	dc.b		nA6,	nFs6,	$02,	nF6,	$01,	nRst,	nCs6,	nD6
	dc.b		$03,	nFs7,	$02,	nG7,	nFs7,	nC7,	nG6,	nEb6
	dc.b		nD6,	$12,	nRst,	$02
	smpsReturn

BossPinch_Call51:
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

BossPinch_Call52:
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

BossPinch_Call53:
	dc.b		dKick,	$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04
	dc.b		$02,	dKick,	nRst,	dSnare,	$04,	nRst,	$02,	nRst
	dc.b		dKick,	$04,	dSnare,	dSnare,	dKick,	$02,	nRst,	dSnare
	dc.b		dKick,	dSnare,	$04,	dKick,	nRst
	smpsReturn

BossPinch_Call54:
	dc.b		dKick,	$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04
	dc.b		$02,	dKick,	nRst,	dSnare,	$06,	nRst,	$02,	dKick
	dc.b		$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04,	$02
	dc.b		dKick,	nRst,	dSnare,	$08
	smpsReturn

BossPinch_Call55:
	dc.b		dKick,	$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04
	dc.b		$02,	dKick,	nRst,	dSnare,	$08,	dKick,	$04,	dKick
	dc.b		dSnare,	dKick,	$02,	dSnare,	$04,	$02,	dKick,	nRst
	dc.b		dSnare,	$08
	smpsReturn

BossPinch_Call56:
	dc.b		dKick,	$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04
	dc.b		$02,	dKick,	nRst,	dSnare,	$06,	nRst,	$02,	dKick
	dc.b		$04,	dSnare,	dSnare,	dKick,	$02,	nRst,	dSnare,	dKick
	dc.b		dSnare,	$04,	dKick,	$08
	smpsReturn

BossPinch_Call57:
	dc.b		dKick,	$04,	dKick,	dSnare,	dKick,	$02,	dSnare,	$04
	dc.b		$02,	dKick,	nRst,	dSnare,	$08,	dKick,	$04,	dSnare
	dc.b		dSnare,	dKick,	$02,	nRst,	dSnare,	dKick,	dSnare,	$04
	dc.b		dKick,	$08
	smpsReturn

BossPinch_Voices:
	dc.b		$3D,$01,$02,$02,$02,$10,$50,$50,$50,$07,$08,$08,$08,$01,$00,$00
	dc.b		$00,$20,$17,$17,$17,$1C,$88,$88,$88;			Voice 00
	dc.b		$3B,$51,$71,$61,$41,$51,$16,$18,$1A,$05,$01,$01,$00,$09,$01,$01
	dc.b		$01,$17,$97,$27,$87,$1C,$22,$15,$7F;			Voice 01
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 02
	dc.b		$3A,$31,$20,$41,$61,$8F,$8F,$8E,$54,$0E,$03,$0E,$03,$00,$00,$00
	dc.b		$00,$13,$F3,$13,$0A,$17,$21,$19,$80;			Voice 03
	even
