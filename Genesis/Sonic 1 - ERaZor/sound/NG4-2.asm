; =============================================================================================
; Project Name:		NG42
; Created:		7th June 2012
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

NG42_Header:
	smpsHeaderVoice	NG42_Voices
	smpsHeaderChan	$06,	$01
	smpsHeaderTempo	$01,	$03

	smpsHeaderDAC	NG42_DAC
	smpsHeaderFM	NG42_FM1,	smpsPitch00,	$0F
	smpsHeaderFM	NG42_FM2,	smpsPitch01lo,	$14
	smpsHeaderFM	NG42_FM3,	smpsPitch01lo,	$17
	smpsHeaderFM	NG42_FM4,	smpsPitch01lo,	$17
	smpsHeaderFM	NG42_FM5,	smpsPitch01lo,	$1B
	smpsHeaderPSG	NG42_PSG1,	smpsPitch03lo,	$02,	$00

NG42_Call01:
	smpsModSet	$1E,	$01,	$05,	$05
	smpsReturn
	smpsModSet	$01,	$01,	$E7,	$01
	smpsReturn

NG42_Call19:
	smpsModSet	$10,	$01,	$02,	$04
	smpsReturn

NG42_Call08:
	smpsModSet	$03,	$13,	$04,	$01
	smpsReturn

; FM1 Data
NG42_FM1:
	smpsCall	NG42_Call01
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
NG42_Jump01:
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call06
	smpsCall	NG42_Call07
	smpsCall	NG42_Call03
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
	smpsCall	NG42_Call04
	smpsCall	NG42_Call05
	smpsCall	NG42_Call02
	smpsCall	NG42_Call03
	smpsJump	NG42_Jump01

; FM2 Data
NG42_FM2:
	smpsCall	NG42_Call08
	smpsCall	NG42_Call09
	smpsCall	NG42_Call0A
NG42_Jump02:
	smpsCall	NG42_Call0B
	smpsCall	NG42_Call0C
	smpsCall	NG42_Call0D
	smpsCall	NG42_Call0A
	smpsCall	NG42_Call0B
	smpsCall	NG42_Call0C
	smpsCall	NG42_Call0D
	smpsCall	NG42_Call0E
	smpsCall	NG42_Call0F
	smpsCall	NG42_Call10
	smpsCall	NG42_Call11
	smpsCall	NG42_Call12
	smpsCall	NG42_Call13
	smpsCall	NG42_Call10
	smpsCall	NG42_Call11
	smpsCall	NG42_Call12
	smpsCall	NG42_Call14
	smpsCall	NG42_Call15
	smpsCall	NG42_Call16
	smpsCall	NG42_Call17
	smpsCall	NG42_Call18
	smpsCall	NG42_Call15
	smpsCall	NG42_Call16
	smpsCall	NG42_Call17
	smpsCall	NG42_Call18
	smpsCall	NG42_Call0A
	smpsJump	NG42_Jump02

; FM3 Data
NG42_FM3:
	smpsCall	NG42_Call19
	smpsCall	NG42_Call1A
	smpsCall	NG42_Call1B
NG42_Jump03:
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1B
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1F
	smpsCall	NG42_Call20
	smpsCall	NG42_Call1B
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1B
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1B
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1B
	smpsCall	NG42_Call1C
	smpsCall	NG42_Call1D
	smpsCall	NG42_Call1E
	smpsCall	NG42_Call1B
	smpsJump	NG42_Jump03

; FM4 Data
NG42_FM4:
	smpsCall	NG42_Call19
	smpsCall	NG42_Call21
	smpsCall	NG42_Call22
NG42_Jump04:
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call22
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call26
	smpsCall	NG42_Call27
	smpsCall	NG42_Call22
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call22
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call22
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call22
	smpsCall	NG42_Call23
	smpsCall	NG42_Call24
	smpsCall	NG42_Call25
	smpsCall	NG42_Call22
	smpsJump	NG42_Jump04

; FM5 Data
NG42_FM5:
	smpsCall	NG42_Call08
	smpsCall	NG42_Call28
	smpsCall	NG42_Call29
NG42_Jump05:
	smpsCall	NG42_Call2A
	smpsCall	NG42_Call2B
	smpsCall	NG42_Call2C
	smpsCall	NG42_Call29
	smpsCall	NG42_Call2A
	smpsCall	NG42_Call2B
	smpsCall	NG42_Call2C
	smpsCall	NG42_Call2D
	smpsCall	NG42_Call2E
	smpsCall	NG42_Call2F
	smpsCall	NG42_Call30
	smpsCall	NG42_Call31
	smpsCall	NG42_Call32
	smpsCall	NG42_Call2F
	smpsCall	NG42_Call30
	smpsCall	NG42_Call31
	smpsCall	NG42_Call33
	smpsCall	NG42_Call34
	smpsCall	NG42_Call35
	smpsCall	NG42_Call36
	smpsCall	NG42_Call37
	smpsCall	NG42_Call38
	smpsCall	NG42_Call35
	smpsCall	NG42_Call36
	smpsCall	NG42_Call37
	smpsCall	NG42_Call29
	smpsJump	NG42_Jump05

; PSG1 Data
NG42_PSG1:
	smpsPSGform	$E7
	smpsCall	NG42_Call39
	smpsCall	NG42_Call3A
NG42_Jump06:
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3C
	smpsCall	NG42_Call39
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3A
	smpsCall	NG42_Call3B
	smpsCall	NG42_Call3A
	smpsJump	NG42_Jump06

; DAC Data
NG42_DAC:
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3E
NG42_Jump07:
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3F
	smpsCall	NG42_Call40
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3F
	smpsCall	NG42_Call40
	smpsCall	NG42_Call41
	smpsCall	NG42_Call40
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call42
	smpsCall	NG42_Call43
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call44
	smpsCall	NG42_Call40
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call44
	smpsCall	NG42_Call40
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call3D
	smpsCall	NG42_Call44
	smpsCall	NG42_Call40
	smpsJump	NG42_Jump07

NG42_Call02:
	smpsFMvoice	$02
	dc.b		nCs2,	$08,	nCs3,	nCs2,	nCs3,	nCs2,	nCs3,	nCs2
	dc.b		nCs3
	smpsReturn

NG42_Call03:
	dc.b		nFs2,	$08,	nFs3,	nFs2,	nFs3,	nFs2,	nFs3,	nFs2
	dc.b		nFs3
	smpsReturn

NG42_Call04:
	dc.b		nD2,	$08,	nD3,	nD2,	nD3,	nD2,	nD3,	nD2
	dc.b		nD3
	smpsReturn

NG42_Call05:
	dc.b		nE2,	$08,	nE3,	nE2,	nE3,	nE2,	nE3,	nE2
	dc.b		nE3
	smpsReturn

NG42_Call06:
	dc.b		nFs2,	$08,	nFs3,	nE2,	nE3,	nD2,	nD3,	nCs2
	dc.b		nCs3
	smpsReturn

NG42_Call07:
	dc.b		nCs2,	$08,	nCs2,	nCs2,	nCs2,	nCs2,	$10,	nRst
	smpsReturn

NG42_Call09:
	dc.b		nRst,	$40
	smpsReturn

NG42_Call0A:
	smpsFMvoice	$00
	dc.b		nFs5,	$08,	nA5,	nFs5,	nB5,	nE5,	$04,	nFs5
	dc.b		$08,	nE5,	$04,	nFs5,	$08,	nB5,	$01,	nCs6
	dc.b		$07
	smpsReturn

NG42_Call0B:
	dc.b		nFs5,	$04,	nFs5,	nFs5,	nFs5,	nFs5,	$08,	nAb5
	dc.b		nAb5,	$01,	nA5,	$07,	nAb5,	$08,	nFs5,	$10
	smpsReturn

NG42_Call0C:
	dc.b		nAb5,	$08,	nFs5,	nB5,	nAb5,	nFs5,	$04,	nAb5
	dc.b		$08,	nFs5,	$04,	nAb5,	$08,	nB5,	$01,	nCs6
	dc.b		$07
	smpsReturn

NG42_Call0D:
	dc.b		nAb5,	$04,	nAb5,	nAb5,	nAb5,	nAb5,	$08,	nA5
	dc.b		nA5,	$01,	nB5,	$07,	nA5,	$08,	nAb5,	$10
	smpsReturn

NG42_Call0E:
	dc.b		nFs5,	$10,	nE5,	nD5,	nCs5
	smpsReturn

NG42_Call0F:
	dc.b		nRst,	$08,	nCs5,	nCs5,	nCs5,	nCs5,	nCs5,	nFs5
	dc.b		nAb5
	smpsReturn

NG42_Call10:
	dc.b		nA5,	$08,	nAb5,	nA5,	nFs5,	$10,	nB5,	$01
	dc.b		nCs6,	$07,	nB5,	$08,	nA5
	smpsReturn

NG42_Call11:
	dc.b		nB5,	$08,	nA5,	nB5,	nFs5,	$10,	nAb5,	$01
	dc.b		nA5,	$07,	nAb5,	$08,	nFs5
	smpsReturn

NG42_Call12:
	dc.b		nE5,	$08,	nAb5,	nB5,	nD6,	$01,	nE6,	$0F
	dc.b		nD6,	$08,	nCs6,	nB5
	smpsReturn

NG42_Call13:
	dc.b		nCs6,	$28,	nCs5,	$08,	nFs5,	nAb5
	smpsReturn

NG42_Call14:
	dc.b		nCs6,	$28,	nCs5,	$04,	nE5,	nFs5,	nAb5,	nA5
	dc.b		nB5
	smpsReturn

NG42_Call15:
	dc.b		nA5,	$08,	nAb5,	$04,	nA5,	$08,	nFs5,	$04
	dc.b		nA5,	$08,	nAb5,	$04,	nA5,	$08,	nFs5,	$04
	dc.b		nB5,	nA5,	nAb5,	nA5
	smpsReturn

NG42_Call16:
	dc.b		nA5,	$08,	nAb5,	$04,	nA5,	$08,	nFs5,	$04
	dc.b		nA5,	$08,	nAb5,	$04,	nA5,	$08,	nFs5,	$04
	dc.b		nB5,	nA5,	nAb5,	nFs5
	smpsReturn

NG42_Call17:
	dc.b		nB5,	$08,	nA5,	$04,	nB5,	$08,	nAb5,	$04
	dc.b		nB5,	$08,	nA5,	$04,	nB5,	$08,	nAb5,	$04
	dc.b		nCs6,	nB5,	nA5,	nAb5
	smpsReturn

NG42_Call18:
	dc.b		nFs5,	$04,	nE5,	nD5,	nCs5,	nD5,	nCs5,	nD5
	dc.b		nE5,	nA5,	nFs5,	nA5,	nB5,	nCs6,	$08,	nB5
	smpsReturn

NG42_Call1A:
	dc.b		nRst,	$40
	smpsReturn

NG42_Call1B:
	smpsFMvoice	$01
	dc.b		nCs3,	$08,	nCs4,	nCs3,	nCs4,	nCs3,	nCs4,	nCs3
	dc.b		nCs4
	smpsReturn

NG42_Call1C:
	dc.b		nA2,	$08,	nA3,	nA2,	nA3,	nA2,	nA3,	nA2
	dc.b		nA3
	smpsReturn

NG42_Call1D:
	dc.b		nB2,	$08,	nB3,	nB2,	nB3,	nB2,	nB3,	nB2
	dc.b		nB3
	smpsReturn

NG42_Call1E:
	dc.b		nAb2,	$08,	nAb3,	nAb2,	nAb3,	nAb2,	nAb3,	nAb2
	dc.b		nAb3
	smpsReturn

NG42_Call1F:
	dc.b		nCs3,	$08,	nCs4,	nB2,	nB3,	nA2,	nA3,	nAb2
	dc.b		nAb3
	smpsReturn

NG42_Call20:
	dc.b		nAb2,	$08,	nAb2,	nAb2,	nAb2,	nAb2,	$10,	nRst
	smpsReturn

NG42_Call21:
	dc.b		nRst,	$40
	smpsReturn

NG42_Call22:
	smpsFMvoice	$01
	dc.b		nFs3,	$08,	nFs4,	nFs3,	nFs4,	nFs3,	nFs4,	nFs3
	dc.b		nFs4
	smpsReturn

NG42_Call23:
	dc.b		nD3,	$08,	nD4,	nD3,	nD4,	nD3,	nD4,	nD3
	dc.b		nD4
	smpsReturn

NG42_Call24:
	dc.b		nE3,	$08,	nE4,	nE3,	nE4,	nE3,	nE4,	nE3
	dc.b		nE4
	smpsReturn

NG42_Call25:
	dc.b		nCs3,	$08,	nCs4,	nCs3,	nCs4,	nCs3,	nCs4,	nCs3
	dc.b		nCs4
	smpsReturn

NG42_Call26:
	dc.b		nFs3,	$08,	nFs4,	nE3,	nE4,	nD3,	nD4,	nCs3
	dc.b		nCs4
	smpsReturn

NG42_Call27:
	dc.b		nCs3,	$08,	nCs3,	nCs3,	nCs3,	nCs3,	$10,	nRst
	smpsReturn

NG42_Call28:
	dc.b		nRst,	$40
	smpsReturn

NG42_Call29:
	dc.b		smpsNoAttack,	$04
	smpsFMvoice	$00
	dc.b		nFs5,	$08,	nA5,	nFs5,	nB5,	nE5,	$04,	nFs5
	dc.b		$08,	nE5,	$04,	nFs5,	$08,	nB5,	$01,	nCs6
	dc.b		$03
	smpsReturn

NG42_Call2A:
	dc.b		smpsNoAttack,	$04,	nFs5,	nFs5,	nFs5,	nFs5,	nFs5,	$08
	dc.b		nAb5,	nAb5,	$01,	nA5,	$07,	nAb5,	$08,	nFs5
	dc.b		$0C
	smpsReturn

NG42_Call2B:
	dc.b		smpsNoAttack,	$04,	nAb5,	$08,	nFs5,	nB5,	nAb5,	nFs5
	dc.b		$04,	nAb5,	$08,	nFs5,	$04,	nAb5,	$08,	nB5
	dc.b		$01,	nCs6,	$03
	smpsReturn

NG42_Call2C:
	dc.b		smpsNoAttack,	$04,	nAb5,	nAb5,	nAb5,	nAb5,	nAb5,	$08
	dc.b		nA5,	nA5,	$01,	nB5,	$07,	nA5,	$08,	nAb5
	dc.b		$0C
	smpsReturn

NG42_Call2D:
	dc.b		smpsNoAttack,	$04,	nFs5,	$10,	nE5,	nD5,	nCs5,	$0C
	smpsReturn

NG42_Call2E:
	dc.b		smpsNoAttack,	$04,	nRst,	$08,	nCs5,	nCs5,	nCs5,	nCs5
	dc.b		nCs5,	nFs5,	nAb5,	$04
	smpsReturn

NG42_Call2F:
	dc.b		smpsNoAttack,	$04,	nA5,	$08,	nAb5,	nA5,	nFs5,	$10
	dc.b		nB5,	$01,	nCs6,	$07,	nB5,	$08,	nA5,	$04
	smpsReturn

NG42_Call30:
	dc.b		smpsNoAttack,	$04,	nB5,	$08,	nA5,	nB5,	nFs5,	$10
	dc.b		nAb5,	$01,	nA5,	$07,	nAb5,	$08,	nFs5,	$04
	smpsReturn

NG42_Call31:
	dc.b		smpsNoAttack,	$04,	nE5,	$08,	nAb5,	nB5,	nD6,	$01
	dc.b		nE6,	$0F,	nD6,	$08,	nCs6,	nB5,	$04
	smpsReturn

NG42_Call32:
	dc.b		smpsNoAttack,	$04,	nCs6,	$28,	nCs5,	$08,	nFs5,	nAb5
	dc.b		$04
	smpsReturn

NG42_Call33:
	dc.b		smpsNoAttack,	$04,	nCs6,	$28,	nCs5,	$04,	nE5,	nFs5
	dc.b		nAb5,	nA5
	smpsReturn

NG42_Call34:
	dc.b		nB5,	$04,	nA5,	$08,	nAb5,	$04,	nA5,	$08
	dc.b		nFs5,	$04,	nA5,	$08,	nAb5,	$04,	nA5,	$08
	dc.b		nFs5,	$04,	nB5,	nA5,	nAb5
	smpsReturn

NG42_Call35:
	dc.b		nA5,	$04,	$08,	nAb5,	$04,	nA5,	$08,	nFs5
	dc.b		$04,	nA5,	$08,	nAb5,	$04,	nA5,	$08,	nFs5
	dc.b		$04,	nB5,	nA5,	nAb5
	smpsReturn

NG42_Call36:
	dc.b		nFs5,	$04,	nB5,	$08,	nA5,	$04,	nB5,	$08
	dc.b		nAb5,	$04,	nB5,	$08,	nA5,	$04,	nB5,	$08
	dc.b		nAb5,	$04,	nCs6,	nB5,	nA5
	smpsReturn

NG42_Call37:
	dc.b		nAb5,	$04,	nFs5,	nE5,	nD5,	nCs5,	nD5,	nCs5
	dc.b		nD5,	nE5,	nA5,	nFs5,	nA5,	nB5,	nCs6,	$08
	dc.b		nB5,	$04
	smpsReturn

NG42_Call38:
	dc.b		smpsNoAttack,	$04,	nA5,	$08,	nAb5,	$04,	nA5,	$08
	dc.b		nFs5,	$04,	nA5,	$08,	nAb5,	$04,	nA5,	$08
	dc.b		nFs5,	$04,	nB5,	nA5,	nAb5
	smpsReturn

NG42_Call39:
	smpsPSGvoice	$02
	dc.b		nCs0,	$08,	$04,	nCs0,	nCs0,	$01,	nRst,	$03
	dc.b		nCs0,	$04,	nCs0,	nCs0,	nCs0,	$01,	nRst,	$07
	dc.b		nCs0,	$04,	nCs0,	nCs0,	$01,	nRst,	$03,	nCs0
	dc.b		$04,	nCs0,	nCs0
	smpsReturn

NG42_Call3A:
	smpsPSGvoice	$02
	dc.b		nCs0,	$01,	nRst,	$07,	nCs0,	$04,	nCs0,	nCs0
	dc.b		$01,	nRst,	$03,	nCs0,	$04,	nCs0,	nCs0,	nCs0
	dc.b		$01,	nRst,	$07,	nCs0,	$04,	nCs0,	nCs0,	$01
	dc.b		nRst,	$03,	nCs0,	$04,	nCs0,	nCs0
	smpsReturn

NG42_Call3B:
	smpsPSGvoice	$02
	dc.b		nCs0,	$01,	nRst,	$07,	nCs0,	$04,	nCs0,	nCs0
	dc.b		$01,	nRst,	$03,	nCs0,	$04,	nCs0,	nCs0,	nCs0
	dc.b		$01,	nRst,	$03,	$04,	nCs0,	nCs0,	nCs0,	$01
	dc.b		nRst,	$03,	nCs0,	$04,	nCs0,	nCs0
	smpsReturn

NG42_Call3C:
	smpsPSGvoice	$02
	dc.b		nCs0,	$01,	nRst,	$3F
	smpsReturn

NG42_Call3D:
	dc.b		$81,	$08,	$80,	$82,	$81,	$81,	$80,	$82
	dc.b		$81
	smpsReturn

NG42_Call3E:
	dc.b		$AA,	$08,	$80,	$82,	$81,	$81,	$80,	$82
	dc.b		$81
	smpsReturn

NG42_Call3F:
	dc.b		$81,	$08,	$80,	$82,	$81,	$81,	$04,	$82
	dc.b		$81,	$82,	$81,	$82,	$82,	$82
	smpsReturn

NG42_Call40:
	dc.b		$AA,	$08,	$80,	$04,	$80,	$82,	$08,	$81
	dc.b		$81,	$80,	$82,	$81
	smpsReturn

NG42_Call41:
	dc.b		$82,	$08,	$AA,	$AA,	$AA,	$AA,	$80,	$82
	dc.b		$82,	$04,	$82
	smpsReturn

NG42_Call42:
	dc.b		$81,	$08,	$80,	$82,	$81,	$82,	$04,	$82
	dc.b		$81,	$82,	$82,	$82,	$82,	$82
	smpsReturn

NG42_Call43:
	dc.b		$AA,	$0C,	$80,	$04,	$82,	$08,	$81,	$81
	dc.b		$80,	$82,	$81
	smpsReturn

NG42_Call44:
	dc.b		$81,	$08,	$80,	$82,	$81,	$82,	$04,	$82
	dc.b		$81,	$82,	$81,	$82,	$82,	$82
	smpsReturn

NG42_Voices:
	dc.b	$3d,$12,$14,$12,$11,$50,$1b,$1b,$1a,$f,$a,$a,$a,$5,$7,$8
	dc.b	$6,$1f,$1f,$1f,$1f,$15,$8b,$80,$80	; Voice 3 (PSIV-PS1Dungeon2-2:FM1 Lead Synth (Mod $01, $01, $05, $04))
	dc.b		$38,$33,$01,$51,$01,$10,$13,$1A,$1B,$0F,$1F,$1F,$1F,$01,$01,$01
	dc.b		$01,$33,$03,$03,$08,$16,$1A,$19,$80;			Voice 01

	dc.b		$3A,$31,$20,$41,$61,$8F,$8F,$8E,$54,$0E,$03,$0E,$03,$00,$00,$00
	dc.b		$00,$13,$F3,$13,$0A,$17,$21,$19,$80;			Voice 02
	even