; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Sun Aug 22 2010, 19:40:25
; -------------------------------------------------------

RHYTHM_Header:
	smpsHeaderVoice	RHYTHM_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$2, $3
	smpsHeaderDAC	RHYTHM_DAC
	smpsHeaderFM	RHYTHM_FM1,	$c, $c
	smpsHeaderFM	RHYTHM_FM2,	$c, $11
	smpsHeaderFM	RHYTHM_FM3,	$c, $11
	smpsHeaderFM	RHYTHM_FM4,	$e8, $17
	smpsHeaderFM	RHYTHM_FM5,	$e8, $17
	smpsHeaderPSG	RHYTHM_PSG1,	$dc, $4, $0
	smpsHeaderPSG	RHYTHM_PSG2,	$dc, $1, $0
	smpsHeaderPSG	RHYTHM_PSG3,	-24, $1, $0

RHYTHM_MODB:
	smpsModSet  $1E, $01, $05, $05
	smpsReturn
RHYTHM_ModS:
	smpsModSet  $10, $01, $02, $04
	smpsReturn
RHYTHM_ModPSG:
	smpsModSet  $10, $01, $01, $02
	smpsReturn
RHYTHM_ModPSG2:
	smpsModSet  $13, $02, $01, $01
 	smpsReturn
RHYTHM_ModT:
	smpsModSet  $03, $13, $04, $01
	smpsReturn
RHYTHM_ModGT:
	smpsModSet  $03, $02, $F0, $01
       	smpsReturn

RHYTHM_FM1:
        smpsCall	RHYTHM_ModB
	smpsCall	RHYTHM_FM1_p0
	smpsCall	RHYTHM_FM1_p1
	smpsCall	RHYTHM_FM1_p2
	smpsCall	RHYTHM_FM1_p3
	smpsCall	RHYTHM_FM1_p4
	smpsCall	RHYTHM_FM1_p5
	smpsCall	RHYTHM_FM1_p6
	smpsCall	RHYTHM_FM1_p7
	smpsCall	RHYTHM_FM1_p8
	smpsCall	RHYTHM_FM1_p9
	smpsCall	RHYTHM_FM1_pa
	smpsCall	RHYTHM_FM1_pb
	smpsCall	RHYTHM_FM1_pc
	smpsCall	RHYTHM_FM1_pd
	smpsCall	RHYTHM_FM1_pe
	smpsCall	RHYTHM_FM1_pf
	smpsCall	RHYTHM_FM1_p10
	smpsCall	RHYTHM_FM1_p11
	smpsCall	RHYTHM_FM1_p12
	smpsCall	RHYTHM_FM1_p13
	smpsCall	RHYTHM_FM1_p14
	smpsCall	RHYTHM_FM1_p15
	smpsCall	RHYTHM_FM1_p12
	smpsCall	RHYTHM_FM1_p17
	smpsStop

RHYTHM_FM2:
        smpsCall	RHYTHM_ModT
	smpsCall	RHYTHM_FM2_p0
	smpsCall	RHYTHM_FM2_p1
	smpsCall	RHYTHM_FM2_p2
	smpsCall	RHYTHM_FM2_p3
	smpsCall	RHYTHM_FM2_p4
	smpsCall	RHYTHM_FM2_p5
	smpsCall	RHYTHM_FM2_p6
	smpsCall	RHYTHM_FM2_p7
	smpsCall	RHYTHM_FM2_p8
	smpsCall	RHYTHM_FM2_p9
	smpsCall	RHYTHM_FM2_pa
	smpsCall	RHYTHM_FM2_pb
	smpsCall	RHYTHM_FM2_pc
	smpsCall	RHYTHM_FM2_pd
	smpsCall	RHYTHM_FM2_pe
	smpsCall	RHYTHM_FM2_pf
	smpsCall	RHYTHM_FM2_p10
	smpsCall	RHYTHM_FM2_p11
	smpsCall	RHYTHM_FM2_p12
	smpsCall	RHYTHM_FM2_p13
	smpsCall	RHYTHM_FM2_p10
	smpsCall	RHYTHM_FM2_p11
	smpsCall	RHYTHM_FM2_p16
	smpsCall	RHYTHM_FM2_p17
	smpsStop

RHYTHM_FM3:
        smpsCall	RHYTHM_ModT
	smpsPan		panLeft,0
	smpsCall	RHYTHM_FM3_p0
	smpsCall	RHYTHM_FM3_p1
	smpsCall	RHYTHM_FM3_p2
	smpsCall	RHYTHM_FM3_p3
	smpsCall	RHYTHM_FM3_p4
	smpsCall	RHYTHM_FM3_p5
	smpsCall	RHYTHM_FM3_p6
	smpsCall	RHYTHM_FM3_p7
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_pf
	smpsCall	RHYTHM_FM3_p10
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_p8
	smpsCall	RHYTHM_FM3_pf
	smpsCall	RHYTHM_FM3_p10
	smpsCall	RHYTHM_FM3_p15
	smpsCall	RHYTHM_FM3_p16
	smpsCall	RHYTHM_FM3_p7
	smpsStop

RHYTHM_FM4:
        smpsCall	RHYTHM_ModS
	smpsCall	RHYTHM_FM4_p0
	smpsCall	RHYTHM_FM4_p1
	smpsCall	RHYTHM_FM4_p2
	smpsCall	RHYTHM_FM4_p3
	smpsCall	RHYTHM_FM4_p4
	smpsCall	RHYTHM_FM4_p5
	smpsCall	RHYTHM_FM4_p6
	smpsCall	RHYTHM_FM4_p7
	smpsCall	RHYTHM_FM4_p8
	smpsCall	RHYTHM_FM4_p9
	smpsCall	RHYTHM_FM4_pa
	smpsCall	RHYTHM_FM4_pb
	smpsCall	RHYTHM_FM4_pc
	smpsCall	RHYTHM_FM4_pd
	smpsCall	RHYTHM_FM4_pe
	smpsCall	RHYTHM_FM4_pf
	smpsCall	RHYTHM_FM4_p10
	smpsCall	RHYTHM_FM4_p11
	smpsCall	RHYTHM_FM4_p12
	smpsCall	RHYTHM_FM4_p13
	smpsCall	RHYTHM_FM4_p10
	smpsCall	RHYTHM_FM4_p15
	smpsCall	RHYTHM_FM4_p12
	smpsCall	RHYTHM_FM4_p17
	smpsStop

RHYTHM_FM5:
        smpsCall	RHYTHM_ModS
	smpsPan		panRight,0
	smpsCall	RHYTHM_FM5_p0
	smpsCall	RHYTHM_FM5_p1
	smpsCall	RHYTHM_FM5_p2
	smpsCall	RHYTHM_FM5_p3
	smpsCall	RHYTHM_FM5_p4
	smpsCall	RHYTHM_FM5_p5
	smpsCall	RHYTHM_FM5_p5
	smpsCall	RHYTHM_FM5_p7
	smpsCall	RHYTHM_FM5_p8
	smpsCall	RHYTHM_FM5_p9
	smpsCall	RHYTHM_FM5_pa
	smpsCall	RHYTHM_FM5_p9
	smpsCall	RHYTHM_FM5_pc
	smpsCall	RHYTHM_FM5_pd
	smpsCall	RHYTHM_FM5_pe
	smpsCall	RHYTHM_FM5_pf
	smpsCall	RHYTHM_FM5_p10
	smpsCall	RHYTHM_FM5_p11
	smpsCall	RHYTHM_FM5_p12
	smpsCall	RHYTHM_FM5_p13
	smpsCall	RHYTHM_FM5_p14
	smpsCall	RHYTHM_FM5_p15
	smpsCall	RHYTHM_FM5_p16
	smpsCall	RHYTHM_FM5_p17
	smpsStop

RHYTHM_PSG1:
        smpsCall	RHYTHM_ModPSG
	smpsCall	RHYTHM_PSG1_p0
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p7
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_pb
	smpsCall	RHYTHM_PSG1_pc
	smpsCall	RHYTHM_PSG1_pd
	smpsCall	RHYTHM_PSG1_pe
	smpsCall	RHYTHM_PSG1_pf
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsCall	RHYTHM_PSG1_p1
	smpsStop

RHYTHM_PSG2:
        smpsCall	RHYTHM_ModPSG
	smpsCall	RHYTHM_PSG2_p0
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p7
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_pb
	smpsCall	RHYTHM_PSG2_pc
	smpsCall	RHYTHM_PSG2_pd
	smpsCall	RHYTHM_PSG2_pe
	smpsCall	RHYTHM_PSG2_pf
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsCall	RHYTHM_PSG2_p1
	smpsStop

RHYTHM_PSG3:
	smpsPSGform	$E7
	smpsCall	RHYTHM_PSG3_p0
	smpsCall	RHYTHM_PSG3_p1
	smpsCall	RHYTHM_PSG3_p1
	smpsCall	RHYTHM_PSG3_p1
	smpsCall	RHYTHM_PSG3_p1
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p7
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p13
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p5
	smpsCall	RHYTHM_PSG3_p17
	smpsStop

RHYTHM_DAC:
	smpsCall	RHYTHM_DAC_p0
	smpsCall	RHYTHM_DAC_p0
	smpsCall	RHYTHM_DAC_p0
	smpsCall	RHYTHM_DAC_p0
	smpsCall	RHYTHM_DAC_p4
	smpsCall	RHYTHM_DAC_p5
	smpsCall	RHYTHM_DAC_p5
	smpsCall	RHYTHM_DAC_p7
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_p9
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_pb
	smpsCall	RHYTHM_DAC_pc
	smpsCall	RHYTHM_DAC_pd
	smpsCall	RHYTHM_DAC_pc
	smpsCall	RHYTHM_DAC_pf
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_p9
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_p13
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_p9
	smpsCall	RHYTHM_DAC_p8
	smpsCall	RHYTHM_DAC_p17
	smpsStop


; Pattern data for FM1
RHYTHM_FM1_p0:
	smpsFMvoice	$0
	dc.b		$90,$40
	smpsReturn

RHYTHM_FM1_p1:
	dc.b		$90,$20
	dc.b		$95,$4
	dc.b		$9a
	dc.b		$80,$18
	smpsReturn

RHYTHM_FM1_p2:
	dc.b		$93,$20
	dc.b		$95,$6
	dc.b		$9c
	dc.b		$95,$4
	dc.b		$80,$10
	smpsReturn

RHYTHM_FM1_p3:
	dc.b		$98,$c
	dc.b		$93
	dc.b		$98,$8
	dc.b		$9a,$c
	dc.b		$95
	dc.b		$9a,$8
	smpsReturn

RHYTHM_FM1_p4:
	dc.b		$90,$20
	dc.b		$8
	dc.b		$90
	dc.b		$90
	dc.b		$90
	smpsReturn

RHYTHM_FM1_p5:
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	smpsReturn

RHYTHM_FM1_p6:
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	smpsReturn

RHYTHM_FM1_p7:
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	smpsReturn

RHYTHM_FM1_p8:
	dc.b		$9e,$4
	dc.b		$2
	dc.b		$9e
	dc.b		$9e,$4
	dc.b		$2
	dc.b		$9e
	dc.b		$9e,$4
	dc.b		$2
	dc.b		$9e
	dc.b		$9e,$4
	dc.b		$2
	dc.b		$9e
	dc.b		$9b,$4
	dc.b		$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$2
	dc.b		$9b
	smpsReturn

RHYTHM_FM1_p9:
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9b,$4
	dc.b		$2
	dc.b		$9b
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	smpsReturn

RHYTHM_FM1_pa:
	dc.b		$92,$4
	dc.b		$2
	dc.b		$92
	dc.b		$92,$4
	dc.b		$2
	dc.b		$92
	dc.b		$92,$4
	dc.b		$2
	dc.b		$92
	dc.b		$92,$4
	dc.b		$2
	dc.b		$92
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	smpsReturn

RHYTHM_FM1_pb:
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$94,$4
	dc.b		$2
	dc.b		$94
	dc.b		$94,$4
	dc.b		$2
	dc.b		$94
	dc.b		$94,$4
	dc.b		$2
	dc.b		$94
	dc.b		$94,$4
	dc.b		$2
	dc.b		$94
	smpsReturn

RHYTHM_FM1_pc:
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	dc.b		$99,$4
	dc.b		$2
	dc.b		$99
	smpsReturn

RHYTHM_FM1_pd:
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	smpsReturn

RHYTHM_FM1_pe:
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	smpsReturn

RHYTHM_FM1_pf:
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	smpsReturn

RHYTHM_FM1_p10:
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	smpsReturn

RHYTHM_FM1_p11:
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	smpsReturn

RHYTHM_FM1_p12:
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	smpsReturn

RHYTHM_FM1_p13:
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$2
	dc.b		$97
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	smpsReturn

RHYTHM_FM1_p14:
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$9a,$4
	dc.b		$2
	dc.b		$9a
	dc.b		$93,$4
	dc.b		$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$2
	dc.b		$93
	smpsReturn

RHYTHM_FM1_p15:
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$95,$4
	dc.b		$2
	dc.b		$95
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	dc.b		$98,$4
	dc.b		$2
	dc.b		$98
	smpsReturn

RHYTHM_FM1_p17:
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$9c,$4
	dc.b		$2
	dc.b		$9c
	dc.b		$80,$20
	smpsReturn

; Pattern data for FM2
RHYTHM_FM2_p0:
	dc.b		$e7,$40
	smpsReturn

RHYTHM_FM2_p1:
	smpsFMvoice	$2
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$6
	dc.b		$4
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$c0,$6
	dc.b		$c3,$4
	dc.b		$c1,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c2,$5
	dc.b		$c3,$6
	dc.b		$c4,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$3
	dc.b		$10
	smpsReturn

RHYTHM_FM2_p2:
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$c5,$6
	dc.b		$c7,$4
	dc.b		$7
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$8
	dc.b		$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$5
	dc.b		$c0,$6
	dc.b		$be,$4
	dc.b		$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c0,$f
	smpsReturn

RHYTHM_FM2_p3:
	dc.b		$c0,$6
	dc.b		$c0
	dc.b		$c0,$4
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$7
	dc.b		$c0,$8
	dc.b		$c2,$6
	dc.b		$c2
	dc.b		$c2,$4
	dc.b		$c4,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$7
	dc.b		$c2,$8
	smpsReturn

RHYTHM_FM2_p4:
	dc.b		$c4,$6
	dc.b		$c5
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$3
	dc.b		$30
	smpsReturn

RHYTHM_FM2_p5:
	dc.b		$80,$4
	dc.b		$c3
	dc.b		$c3
	dc.b		$80
	dc.b		$c2
	dc.b		$c3
	dc.b		$c2
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$c0
	dc.b		$80
	dc.b		$c2
	dc.b		$80
	dc.b		$c2
	dc.b		$c3
	smpsReturn

RHYTHM_FM2_p6:
	dc.b		$80,$4
	dc.b		$c3
	dc.b		$c3
	dc.b		$80
	dc.b		$c2
	dc.b		$c3
	dc.b		$c2
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$c0
	dc.b		$80
	dc.b		$c9,$10
	smpsReturn

RHYTHM_FM2_p7:
	dc.b		$e7,$20
	dc.b		$c3,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c4,$f
	dc.b		$80,$4
	dc.b		$c0
	dc.b		$c0
	dc.b		$c4
	smpsReturn

RHYTHM_FM2_p8:
	dc.b		$c5,$4
	dc.b		$c4,$8
	dc.b		$c2
	dc.b		$c0
	dc.b		$c2,$14
	dc.b		$80,$4
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$3
	dc.b		$4
	dc.b		$c2
	smpsReturn

RHYTHM_FM2_p9:
	dc.b		$c5,$6
	dc.b		$c4
	dc.b		$c2,$4
	dc.b		$c4,$8
	dc.b		$c2
	dc.b		$c0,$10
	dc.b		$80,$4
	dc.b		$c0
	dc.b		$c0
	dc.b		$c0
	smpsReturn

RHYTHM_FM2_pa:
	dc.b		$e7,$10
	dc.b		$80,$4
	dc.b		$bd
	dc.b		$bf
	dc.b		$c0
	dc.b		$bd,$6
	dc.b		$bf
	dc.b		$c0,$4
	dc.b		$6
	dc.b		$c2
	dc.b		$c4,$4
	smpsReturn

RHYTHM_FM2_pb:
	dc.b		$c2,$20
	dc.b		$c4,$c
	dc.b		$c4
	dc.b		$c4,$8
	smpsReturn

RHYTHM_FM2_pc:
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c4,$b
	dc.b		$c2,$c
	dc.b		$bf,$8
	dc.b		$c0,$c
	dc.b		$c2
	dc.b		$c4,$8
	smpsReturn

RHYTHM_FM2_pd:
	dc.b		$bd,$1c
	dc.b		$80,$4
	dc.b		$bd,$c
	dc.b		$bf
	dc.b		$c0,$8
	smpsReturn

RHYTHM_FM2_pe:
	dc.b		$bf,$c
	dc.b		$c0
	dc.b		$c2,$8
	dc.b		$c0,$6
	dc.b		$c2
	dc.b		$c3,$4
	dc.b		$6
	dc.b		$c5
	dc.b		$c7,$4
	smpsReturn

RHYTHM_FM2_pf:
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$b
	dc.b		$c5,$4
	dc.b		$10
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$6
	dc.b		$4
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$c0,$6
	dc.b		$c3,$4
	smpsReturn

RHYTHM_FM2_p10:
	dc.b		$c1,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c2,$5
	dc.b		$c3,$6
	dc.b		$c4,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$3
	dc.b		$10
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$c5,$6
	dc.b		$c7,$4
	dc.b		$7
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$8
	smpsReturn

RHYTHM_FM2_p11:
	dc.b		$c3,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$5
	dc.b		$c0,$6
	dc.b		$be,$4
	dc.b		$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c0,$f
	dc.b		$6
	dc.b		$c0
	dc.b		$c0,$4
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$7
	dc.b		$c0,$8
	smpsReturn

RHYTHM_FM2_p12:
	dc.b		$c2,$6
	dc.b		$c2
	dc.b		$c2,$4
	dc.b		$c4,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$7
	dc.b		$c2,$8
	dc.b		$c3,$6
	dc.b		$c3
	dc.b		$c3,$4
	dc.b		$c7,$8
	dc.b		$c3,$4
	dc.b		$c3
	smpsReturn

RHYTHM_FM2_p13:
	dc.b		$c5,$6
	dc.b		$c7
	dc.b		$c8,$4
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$f
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$6
	dc.b		$4
	dc.b		$c2,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c3,$5
	dc.b		$c0,$6
	dc.b		$c3,$4
	smpsReturn

RHYTHM_FM2_p16:
	dc.b		$c2,$6
	dc.b		$c2
	dc.b		$c2,$4
	dc.b		$c4,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$7
	dc.b		$c2,$8
	dc.b		$c4,$6
	dc.b		$c5
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$3
	dc.b		$10
	smpsReturn

RHYTHM_FM2_p17:
	dc.b		$e7,$20
	dc.b		$80
	smpsReturn

; Pattern data for FM3
RHYTHM_FM3_p0:
	dc.b		$e7,$40
	smpsReturn

RHYTHM_FM3_p1:
	smpsFMvoice	$2
	dc.b		$c7,$6
	dc.b		$c7
	dc.b		$c7,$4
	dc.b		$6
	dc.b		$c3
	dc.b		$c7,$4
	dc.b		$c5,$6
	dc.b		$c7
	dc.b		$c8,$4
	dc.b		$10
	smpsReturn

RHYTHM_FM3_p2:
	dc.b		$80,$40
	smpsReturn

RHYTHM_FM3_p3:
	smpsFMvoice	$2
	dc.b		$c3,$6
	dc.b		$c3
	dc.b		$c3,$4
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$7
	dc.b		$c3,$8
	dc.b		$c5,$6
	dc.b		$c5
	dc.b		$c5,$4
	dc.b		$c7,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c8,$7
	dc.b		$c5,$8
	smpsReturn

RHYTHM_FM3_p4:
	dc.b		$c7,$6
	dc.b		$c8
	dc.b		$c8,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$ca,$3
	dc.b		$30
	smpsReturn

RHYTHM_FM3_p5:
	dc.b		$80,$4
	dc.b		$c0
	dc.b		$c0
	dc.b		$80
	dc.b		$be
	dc.b		$c0
	dc.b		$be
	dc.b		$bc
	dc.b		$80
	dc.b		$bc
	dc.b		$bc
	dc.b		$80
	dc.b		$be
	dc.b		$80
	dc.b		$be
	dc.b		$c0
	smpsReturn

RHYTHM_FM3_p6:
	dc.b		$80,$4
	dc.b		$c0
	dc.b		$c0
	dc.b		$80
	dc.b		$be
	dc.b		$c0
	dc.b		$be
	dc.b		$bc
	dc.b		$80
	dc.b		$bc
	dc.b		$bc
	dc.b		$80
	dc.b		$c5,$10
	smpsReturn

RHYTHM_FM3_p7:
	dc.b		$e7,$20
	dc.b		$80
	smpsReturn

RHYTHM_FM3_p8:
	dc.b		$e7,$40
	smpsReturn

RHYTHM_FM3_pf:
	dc.b		$e7,$20
	smpsFMvoice	$2
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$5
	dc.b		$6
	dc.b		$4
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$5
	dc.b		$c3,$6
	dc.b		$c7,$4
	smpsReturn

RHYTHM_FM3_p10:
	dc.b		$c3,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c5,$5
	dc.b		$c7,$6
	dc.b		$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c8,$3
	dc.b		$10
	dc.b		$80,$20
	smpsReturn

RHYTHM_FM3_p15:
	dc.b		$e7,$20
	dc.b		$c3,$6
	dc.b		$c3
	dc.b		$c3,$4
	dc.b		$c5,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c7,$7
	dc.b		$c3,$8
	smpsReturn

RHYTHM_FM3_p16:
	dc.b		$c5,$6
	dc.b		$c5
	dc.b		$c5,$4
	dc.b		$c7,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$c8,$7
	dc.b		$c5,$8
	dc.b		$c7,$6
	dc.b		$c8
	dc.b		$c8,$1
	dc.b		smpsNoAttack ; max-speed portamento
	dc.b		$ca,$3
	dc.b		$10
	smpsReturn

; Pattern data for FM4
RHYTHM_FM4_p0:
	smpsFMvoice	$1
	dc.b		$b4,$2c
	dc.b		$c5,$14
	smpsReturn

RHYTHM_FM4_p1:
	dc.b		$af,$20
	dc.b		$ad
	smpsReturn

RHYTHM_FM4_p2:
	dc.b		$ab,$20
	dc.b		$ad
	smpsReturn

RHYTHM_FM4_p3:
	dc.b		$b0,$20
	dc.b		$b2
	smpsReturn

RHYTHM_FM4_p4:
	dc.b		$b4,$40
	smpsReturn

RHYTHM_FM4_p5:
	dc.b		$c0,$10
	dc.b		$be
	dc.b		$bc
	dc.b		$be
	smpsReturn

RHYTHM_FM4_p6:
	dc.b		$c0,$10
	dc.b		$be
	dc.b		$bc
	dc.b		$bd
	smpsReturn

RHYTHM_FM4_p7:
	dc.b		$e7,$20
	dc.b		$c0
	smpsReturn

RHYTHM_FM4_p8:
	dc.b		$c2,$20
	dc.b		$c
	dc.b		$bd,$14
	smpsReturn

RHYTHM_FM4_p9:
	dc.b		$c0,$20
	dc.b		$bd
	smpsReturn

RHYTHM_FM4_pa:
	dc.b		$b6,$20
	dc.b		$c5,$6
	dc.b		$c4
	dc.b		$c5,$4
	dc.b		$6
	dc.b		$c4
	dc.b		$c5,$4
	smpsReturn

RHYTHM_FM4_pb:
	dc.b		$c7,$20
	dc.b		$bf
	smpsReturn

RHYTHM_FM4_pc:
	dc.b		$bc,$20
	dc.b		$bd
	smpsReturn

RHYTHM_FM4_pd:
	dc.b		$c0,$20
	dc.b		$bd
	smpsReturn

RHYTHM_FM4_pe:
	dc.b		$bf,$20
	dc.b		$c0
	smpsReturn

RHYTHM_FM4_pf:
	dc.b		$be,$10
	dc.b		$bf
	dc.b		$bb,$20
	smpsReturn

RHYTHM_FM4_p10:
	dc.b		$b9,$20
	dc.b		$c5,$c
	dc.b		$c7,$14
	smpsReturn

RHYTHM_FM4_p11:
	dc.b		$c5,$c
	dc.b		$c8,$14
	dc.b		$bc,$20
	smpsReturn

RHYTHM_FM4_p12:
	dc.b		$be,$20
	dc.b		$c0
	smpsReturn

RHYTHM_FM4_p13:
	dc.b		$c2,$10
	dc.b		$8
	dc.b		$80
	dc.b		$bb,$20
	smpsReturn

RHYTHM_FM4_p15:
	dc.b		$c5,$c
	dc.b		$c9,$14
	dc.b		$bc,$20
	smpsReturn

RHYTHM_FM4_p17:
	dc.b		$e7,$20
	dc.b		$80
	smpsReturn

; Pattern data for FM5
RHYTHM_FM5_p0:
	smpsFMvoice	$1
	dc.b		$af,$2c
	dc.b		$c2,$14
	smpsReturn

RHYTHM_FM5_p1:
	dc.b		$ab,$20
	dc.b		$aa
	smpsReturn

RHYTHM_FM5_p2:
	dc.b		$a6,$20
	dc.b		$a8
	smpsReturn

RHYTHM_FM5_p3:
	dc.b		$ab,$20
	dc.b		$ad
	smpsReturn

RHYTHM_FM5_p4:
	dc.b		$af,$40
	smpsReturn

RHYTHM_FM5_p5:
	dc.b		$bb,$10
	dc.b		$b9
	dc.b		$b7
	dc.b		$b9
	smpsReturn

RHYTHM_FM5_p7:
	dc.b		$e7,$20
	dc.b		$bb
	smpsReturn

RHYTHM_FM5_p8:
	dc.b		$bd,$10
	dc.b		$c5,$8
	dc.b		$c4
	dc.b		$bb,$20
	smpsReturn

RHYTHM_FM5_p9:
	dc.b		$bb,$20
	dc.b		$b8
	smpsReturn

RHYTHM_FM5_pa:
	dc.b		$b1,$20
	dc.b		$b9
	smpsReturn

RHYTHM_FM5_pc:
	dc.b		$e7,$20
	dc.b		$b8
	smpsReturn

RHYTHM_FM5_pd:
	dc.b		$b9,$20
	dc.b		$b9
	smpsReturn

RHYTHM_FM5_pe:
	dc.b		$bb,$20
	dc.b		$bc
	smpsReturn

RHYTHM_FM5_pf:
	dc.b		$b9,$10
	dc.b		$bb
	dc.b		$b4,$20
	smpsReturn

RHYTHM_FM5_p10:
	dc.b		$b2,$10
	dc.b		$c5,$6
	dc.b		$ca
	dc.b		$c5,$4
	dc.b		$bc,$20
	smpsReturn

RHYTHM_FM5_p11:
	dc.b		$be,$c
	dc.b		$bc,$14
	dc.b		$b4,$20
	smpsReturn

RHYTHM_FM5_p12:
	dc.b		$b6,$20
	dc.b		$b7
	smpsReturn

RHYTHM_FM5_p13:
	dc.b		$b9,$10
	dc.b		$bb,$8
	dc.b		$80
	dc.b		$b7,$20
	smpsReturn

RHYTHM_FM5_p14:
	dc.b		$b6,$10
	dc.b		$c5,$6
	dc.b		$ca
	dc.b		$c5,$4
	dc.b		$b7,$20
	smpsReturn

RHYTHM_FM5_p15:
	dc.b		$b9,$20
	dc.b		$b7
	smpsReturn

RHYTHM_FM5_p16:
	dc.b		$b9,$20
	dc.b		$bb
	smpsReturn

RHYTHM_FM5_p17:
	dc.b		$e7,$20
	dc.b		$80
	smpsReturn

; Pattern data for PSG1
RHYTHM_PSG1_p0:
	dc.b		$e7,$6
	smpsPSGvoice	$0
	dc.b		$b4,$2
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c3
	dc.b		$80
	dc.b		$c2
	dc.b		$80,$6
	dc.b		$be,$2
	dc.b		$80,$a
	dc.b		$a8,$2
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$b7
	dc.b		$80,$c
	smpsReturn

RHYTHM_PSG1_p1:
	dc.b		$e7,$40
	smpsReturn

RHYTHM_PSG1_p7:
	dc.b		$e7,$8
	smpsPSGvoice	$0
	dc.b		$d0,$2
	dc.b		$cc
	dc.b		$c9
	dc.b		$c5
	dc.b		$cc
	dc.b		$c9
	dc.b		$c5
	dc.b		$c0
	dc.b		$c4
	dc.b		$c0
	dc.b		$bd
	dc.b		$b9
	dc.b		$c0
	dc.b		$bd
	dc.b		$b9
	dc.b		$b4
	dc.b		$80,$18
	smpsReturn

RHYTHM_PSG1_pb:
	dc.b		$e7,$28
	smpsPSGvoice	$0
	dc.b		$a0,$2
	dc.b		$a4
	dc.b		$a7
	dc.b		$ac
	dc.b		$80,$10
	smpsReturn

RHYTHM_PSG1_pc:
	dc.b		$e7,$8
	dc.b		$c4,$2
	dc.b		$bf
	dc.b		$bc
	dc.b		$b8
	dc.b		$bc
	dc.b		$b8
	dc.b		$b3
	dc.b		$b0
	dc.b		$b3
	dc.b		$b0
	dc.b		$ac
	dc.b		$a7
	dc.b		$ac
	dc.b		$a7
	dc.b		$a4
	dc.b		$a0
	dc.b		$a0
	dc.b		$a5
	dc.b		$a8
	dc.b		$ac
	dc.b		$80,$10
	smpsReturn

RHYTHM_PSG1_pd:
	dc.b		$e7,$8
	dc.b		$c9,$2
	dc.b		$c5
	dc.b		$c2
	dc.b		$bd
	dc.b		$c2
	dc.b		$bd
	dc.b		$b9
	dc.b		$b6
	dc.b		$b9
	dc.b		$b6
	dc.b		$b1
	dc.b		$ad
	dc.b		$b1
	dc.b		$ad
	dc.b		$aa
	dc.b		$a5
	dc.b		$a1
	dc.b		$a5
	dc.b		$aa
	dc.b		$ad
	dc.b		$80,$10
	smpsReturn

RHYTHM_PSG1_pe:
	dc.b		$e7,$8
	dc.b		$c7,$2
	dc.b		$c4
	dc.b		$bf
	dc.b		$bb
	dc.b		$bf
	dc.b		$bb
	dc.b		$b8
	dc.b		$b3
	dc.b		$b8
	dc.b		$b3
	dc.b		$af
	dc.b		$ac
	dc.b		$af
	dc.b		$ac
	dc.b		$a7
	dc.b		$a3
	dc.b		$9f
	dc.b		$a4
	dc.b		$a8
	dc.b		$ab
	dc.b		$80,$10
	smpsReturn

RHYTHM_PSG1_pf:
	dc.b		$e7,$8
	dc.b		$a1,$2
	dc.b		$a6
	dc.b		$aa
	dc.b		$ad
	dc.b		$aa
	dc.b		$ad
	dc.b		$b3
	dc.b		$b6
	dc.b		$b3
	dc.b		$b6
	dc.b		$bb
	dc.b		$bf
	dc.b		$bb
	dc.b		$bf
	dc.b		$c2
	dc.b		$c7
	dc.b		$80,$18
	smpsReturn

; Pattern data for PSG2
RHYTHM_PSG2_p0:
	smpsPSGvoice	$0
	dc.b		$b4,$2
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c3
	dc.b		$80
	dc.b		$c2
	dc.b		$80,$6
	dc.b		$be,$2
	dc.b		$80,$a
	dc.b		$a8,$2
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$b7
	dc.b		$80,$12
	smpsReturn

RHYTHM_PSG2_p1:
	dc.b		$e7,$40
	smpsReturn

RHYTHM_PSG2_p7:
	smpsPSGvoice	$0
	dc.b		$d0,$2
	dc.b		$cc
	dc.b		$c9
	dc.b		$c5
	dc.b		$cc
	dc.b		$c9
	dc.b		$c5
	dc.b		$c0
	dc.b		$c4
	dc.b		$c0
	dc.b		$bd
	dc.b		$b9
	dc.b		$c0
	dc.b		$bd
	dc.b		$b9
	dc.b		$b4
	dc.b		$80,$20
	smpsReturn

RHYTHM_PSG2_pb:
	dc.b		$e7,$20
	smpsPSGvoice	$0
	dc.b		$a0,$2
	dc.b		$a4
	dc.b		$a7
	dc.b		$ac
	dc.b		$80,$18
	smpsReturn

RHYTHM_PSG2_pc:
	dc.b		$c4,$2
	dc.b		$bf
	dc.b		$bc
	dc.b		$b8
	dc.b		$bc
	dc.b		$b8
	dc.b		$b3
	dc.b		$b0
	dc.b		$b3
	dc.b		$b0
	dc.b		$ac
	dc.b		$a7
	dc.b		$ac
	dc.b		$a7
	dc.b		$a4
	dc.b		$a0
	dc.b		$a0
	dc.b		$a5
	dc.b		$a8
	dc.b		$ac
	dc.b		$80,$18
	smpsReturn

RHYTHM_PSG2_pd:
	dc.b		$c9,$2
	dc.b		$c5
	dc.b		$c2
	dc.b		$bd
	dc.b		$c2
	dc.b		$bd
	dc.b		$b9
	dc.b		$b6
	dc.b		$b9
	dc.b		$b6
	dc.b		$b1
	dc.b		$ad
	dc.b		$b1
	dc.b		$ad
	dc.b		$aa
	dc.b		$a5
	dc.b		$a1
	dc.b		$a5
	dc.b		$aa
	dc.b		$ad
	dc.b		$80,$18
	smpsReturn

RHYTHM_PSG2_pe:
	dc.b		$c7,$2
	dc.b		$c4
	dc.b		$bf
	dc.b		$bb
	dc.b		$bf
	dc.b		$bb
	dc.b		$b8
	dc.b		$b3
	dc.b		$b8
	dc.b		$b3
	dc.b		$af
	dc.b		$ac
	dc.b		$af
	dc.b		$ac
	dc.b		$a7
	dc.b		$a3
	dc.b		$9f
	dc.b		$a4
	dc.b		$a8
	dc.b		$ab
	dc.b		$80,$18
	smpsReturn

RHYTHM_PSG2_pf:
	dc.b		$a1,$2
	dc.b		$a6
	dc.b		$aa
	dc.b		$ad
	dc.b		$aa
	dc.b		$ad
	dc.b		$b3
	dc.b		$b6
	dc.b		$b3
	dc.b		$b6
	dc.b		$bb
	dc.b		$bf
	dc.b		$bb
	dc.b		$bf
	dc.b		$c2
	dc.b		$c7
	dc.b		$80,$20
	smpsReturn

; Pattern data for PSG3 (Noise)
RHYTHM_PSG3_p0:
	dc.b		$80,$40
	smpsReturn

RHYTHM_PSG3_p1:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsReturn

RHYTHM_PSG3_p5:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsReturn

RHYTHM_PSG3_p7:
	dc.b		$e7,$2
	smpsPSGvoice	$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsReturn

RHYTHM_PSG3_p13:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	smpsReturn

RHYTHM_PSG3_p17:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$6
	smpsPSGvoice	$2
	dc.b		$2
	smpsPSGvoice	$1
	dc.b		$4
	dc.b		$80,$20
	smpsReturn

; Pattern data for DAC
RHYTHM_DAC_p0:
	dc.b		$80,$40
	smpsReturn

RHYTHM_DAC_p4:
	dc.b		$80,$20
	dc.b		$81,$8
	dc.b		$81
	dc.b		$81,$2
	dc.b		$8c
	dc.b		$97,$4
	dc.b		$81,$2
	dc.b		$98
	dc.b		$99,$4
	smpsReturn

RHYTHM_DAC_p5:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsReturn

RHYTHM_DAC_p7:
	dc.b		$81,$4
	dc.b		$97
	dc.b		$81
	dc.b		$99
	dc.b		$81,$2
	dc.b		$8c
	dc.b		$97
	dc.b		$97
	dc.b		$81
	dc.b		$98
	dc.b		$99
	dc.b		$99
	dc.b		$aa,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82
	smpsReturn

RHYTHM_DAC_p8:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82
	smpsReturn

RHYTHM_DAC_p9:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82
	smpsReturn

RHYTHM_DAC_pb:
	dc.b		$81,$4
	dc.b		$8c
	dc.b		$81,$2
	dc.b		$98,$4
	dc.b		$2
	dc.b		$81,$4
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	smpsReturn

RHYTHM_DAC_pc:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	smpsReturn

RHYTHM_DAC_pd:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82,$4
	dc.b		$82
	smpsReturn

RHYTHM_DAC_pf:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81,$4
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$aa,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82
	smpsReturn

RHYTHM_DAC_p13:
	dc.b		$81,$8
	dc.b		$82
	dc.b		$81,$2
	dc.b		$8c
	dc.b		$97
	dc.b		$97
	dc.b		$81
	dc.b		$98
	dc.b		$99
	dc.b		$99
	dc.b		$aa,$8
	dc.b		$82
	dc.b		$81
	dc.b		$82
	smpsReturn

RHYTHM_DAC_p17:
	dc.b		$81,$2
	dc.b		$82
	dc.b		$82,$4
	dc.b		$8
	dc.b		$81,$2
	dc.b		$8c
	dc.b		$97
	dc.b		$97
	dc.b		$81
	dc.b		$98
	dc.b		$99
	dc.b		$99
	dc.b		$aa,$8
	dc.b		$80,$18
	smpsReturn

RHYTHM_Voices:
	dc.b	$20,$36,$35,$30,$31,$df,$df,$9f,$9f,$7,$6,$9,$6,$7,$6,$6
	dc.b	$8,$2f,$1f,$1f,$ff,$19,$37,$13,$80	; Voice 0 (Sonic1-FinalZone-1:Bass)
	dc.b	$2c,$74,$74,$34,$34,$1f,$12,$1f,$1f,$0,$0,$0,$0,$0,$1,$0
	dc.b	$1,$0,$36,$0,$36,$16,$80,$17,$80	; Voice 1 (Sonic1-SpecialRHYTHMe-0:String)
	dc.b	$3a,$31,$20,$41,$61,$8f,$8f,$8e,$54,$e,$3,$e,$3,$0,$0,$0
	dc.b	$0,$13,$f3,$13,$a,$18,$22,$1b,$80	; Voice 2 (DangerousSeed-3rdTube-3:FM1 Lead (Mod $1E, $01, $05, $05))
	even
