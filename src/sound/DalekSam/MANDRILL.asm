; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Sun Nov 8 2009, 06:09:53
; -------------------------------------------------------

MANDRILL_Header:
	smpsHeaderVoice	MANDRILL_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$1, $4
	smpsHeaderDAC	MANDRILL_DAC
	smpsHeaderFM	MANDRILL_FM1,	$c, $c
	smpsHeaderFM	MANDRILL_FM2,	$0, $e
	smpsHeaderFM	MANDRILL_FM3,	$0, $12
	smpsHeaderFM	MANDRILL_FM4,	$0, $11
	smpsHeaderFM	MANDRILL_FM5,	$0, $11
	smpsHeaderPSG	MANDRILL_PSG1,	$dc, $2, $0
	smpsHeaderPSG	MANDRILL_PSG2,	$dc, $3, $0
	smpsHeaderPSG	MANDRILL_PSG3,	$dc, $2, $0

MANDRILL_FM1:
	smpsCall	MANDRILL_FM1_p0
MANDRILL_FM1_Loop:
	smpsCall	MANDRILL_FM1_p1
	smpsCall	MANDRILL_FM1_p2
	smpsCall	MANDRILL_FM1_p3
	smpsCall	MANDRILL_FM1_p4
	smpsCall	MANDRILL_FM1_p1
	smpsCall	MANDRILL_FM1_p2
	smpsCall	MANDRILL_FM1_p3
	smpsCall	MANDRILL_FM1_p4
	smpsCall	MANDRILL_FM1_p1
	smpsCall	MANDRILL_FM1_p2
	smpsCall	MANDRILL_FM1_p3
	smpsCall	MANDRILL_FM1_p4
	smpsCall	MANDRILL_FM1_p1
	smpsCall	MANDRILL_FM1_p2
	smpsCall	MANDRILL_FM1_p3
	smpsCall	MANDRILL_FM1_p10
	smpsCall	MANDRILL_FM1_p11
	smpsCall	MANDRILL_FM1_p12
	smpsCall	MANDRILL_FM1_p13
	smpsCall	MANDRILL_FM1_p14
	smpsCall	MANDRILL_FM1_p3
	smpsCall	MANDRILL_FM1_p10
	smpsCall	MANDRILL_FM1_p17
	smpsCall	MANDRILL_FM1_p18
	smpsCall	MANDRILL_FM1_p19
	smpsCall	MANDRILL_FM1_p1a
	smpsCall	MANDRILL_FM1_p1b
	smpsCall	MANDRILL_FM1_p1c
	smpsCall	MANDRILL_FM1_p1d
	smpsCall	MANDRILL_FM1_p1e
	smpsCall	MANDRILL_FM1_p0
	smpsCall	MANDRILL_FM1_p20
	smpsCall	MANDRILL_FM1_p21
	smpsCall	MANDRILL_FM1_p22
	smpsCall	MANDRILL_FM1_p24
	smpsJump	MANDRILL_FM1_Loop

MANDRILL_FM2:
	smpsCall	MANDRILL_FM2_p0
MANDRILL_FM2_Loop:
	smpsCall	MANDRILL_FM2_p1
	smpsCall	MANDRILL_FM2_p2
	smpsCall	MANDRILL_FM2_p3
	smpsCall	MANDRILL_FM2_p4
	smpsCall	MANDRILL_FM2_p1
	smpsCall	MANDRILL_FM2_p6
	smpsCall	MANDRILL_FM2_p7
	smpsCall	MANDRILL_FM2_p4
	smpsCall	MANDRILL_FM2_p1
	smpsCall	MANDRILL_FM2_p2
	smpsCall	MANDRILL_FM2_p3
	smpsCall	MANDRILL_FM2_p4
	smpsCall	MANDRILL_FM2_p1
	smpsCall	MANDRILL_FM2_pe
	smpsCall	MANDRILL_FM2_p7
	smpsCall	MANDRILL_FM2_p10
	smpsCall	MANDRILL_FM2_p11
	smpsCall	MANDRILL_FM2_p12
	smpsCall	MANDRILL_FM2_p13
	smpsCall	MANDRILL_FM2_p14
	smpsCall	MANDRILL_FM2_p15
	smpsCall	MANDRILL_FM2_p16
	smpsCall	MANDRILL_FM2_p17
	smpsCall	MANDRILL_FM2_p10
	smpsCall	MANDRILL_FM2_p19
	smpsCall	MANDRILL_FM2_p1a
	smpsCall	MANDRILL_FM2_p1b
	smpsCall	MANDRILL_FM2_p1c
	smpsCall	MANDRILL_FM2_p1d
	smpsCall	MANDRILL_FM2_p1e
	smpsCall	MANDRILL_FM2_p1f
	smpsCall	MANDRILL_FM2_p10
	smpsCall	MANDRILL_FM2_p1
	smpsCall	MANDRILL_FM2_p22
	smpsCall	MANDRILL_FM2_p24
	smpsJump	MANDRILL_FM2_Loop

MANDRILL_FM3:
	smpsPan		panRight,0
	smpsCall	MANDRILL_FM3_p0
MANDRILL_FM3_Loop:
	smpsCall	MANDRILL_FM3_p1
	smpsCall	MANDRILL_FM3_p2
	smpsCall	MANDRILL_FM3_p3
	smpsCall	MANDRILL_FM3_p4
	smpsCall	MANDRILL_FM3_p1
	smpsCall	MANDRILL_FM3_p6
	smpsCall	MANDRILL_FM3_p7
	smpsCall	MANDRILL_FM3_p8
	smpsCall	MANDRILL_FM3_p1
	smpsCall	MANDRILL_FM3_p2
	smpsCall	MANDRILL_FM3_p3
	smpsCall	MANDRILL_FM3_p4
	smpsCall	MANDRILL_FM3_p1
	smpsCall	MANDRILL_FM3_pe
	smpsCall	MANDRILL_FM3_p7
	smpsCall	MANDRILL_FM3_p10
	smpsCall	MANDRILL_FM3_p11
	smpsCall	MANDRILL_FM3_p12
	smpsCall	MANDRILL_FM3_p13
	smpsCall	MANDRILL_FM3_p14
	smpsCall	MANDRILL_FM3_p15
	smpsCall	MANDRILL_FM3_p16
	smpsCall	MANDRILL_FM3_p17
	smpsCall	MANDRILL_FM3_p10
	smpsCall	MANDRILL_FM3_p19
	smpsCall	MANDRILL_FM3_p1a
	smpsCall	MANDRILL_FM3_p1b
	smpsCall	MANDRILL_FM3_p1c
	smpsCall	MANDRILL_FM3_p1d
	smpsCall	MANDRILL_FM3_p1e
	smpsCall	MANDRILL_FM3_p1f
	smpsCall	MANDRILL_FM3_p10
	smpsCall	MANDRILL_FM3_p1
	smpsCall	MANDRILL_FM3_p22
	smpsCall	MANDRILL_FM3_p24
	smpsJump	MANDRILL_FM3_Loop

MANDRILL_FM4:
	smpsPan		panLeft,0
	smpsCall	MANDRILL_FM4_p0
MANDRILL_FM4_Loop:
	smpsCall	MANDRILL_FM4_p1
	smpsCall	MANDRILL_FM4_p2
	smpsCall	MANDRILL_FM4_p3
	smpsCall	MANDRILL_FM4_p4
	smpsCall	MANDRILL_FM4_p1
	smpsCall	MANDRILL_FM4_p2
	smpsCall	MANDRILL_FM4_p3
	smpsCall	MANDRILL_FM4_p4
	smpsCall	MANDRILL_FM4_p1
	smpsCall	MANDRILL_FM4_p2
	smpsCall	MANDRILL_FM4_p3
	smpsCall	MANDRILL_FM4_p4
	smpsCall	MANDRILL_FM4_p1
	smpsCall	MANDRILL_FM4_p2
	smpsCall	MANDRILL_FM4_p3
	smpsCall	MANDRILL_FM4_p10
	smpsCall	MANDRILL_FM4_p11
	smpsCall	MANDRILL_FM4_p12
	smpsCall	MANDRILL_FM4_p13
	smpsCall	MANDRILL_FM4_p14
	smpsCall	MANDRILL_FM4_p3
	smpsCall	MANDRILL_FM4_p10
	smpsCall	MANDRILL_FM4_p11
	smpsCall	MANDRILL_FM4_p18
	smpsCall	MANDRILL_FM4_p19
	smpsCall	MANDRILL_FM4_p10
	smpsCall	MANDRILL_FM4_p12
	smpsCall	MANDRILL_FM4_p1c
	smpsCall	MANDRILL_FM4_p1d
	smpsCall	MANDRILL_FM4_p1e
	smpsCall	MANDRILL_FM4_p0
	smpsCall	MANDRILL_FM4_p20
	smpsCall	MANDRILL_FM4_p21
	smpsCall	MANDRILL_FM4_p22
	smpsCall	MANDRILL_FM4_p24
	smpsJump	MANDRILL_FM4_Loop

MANDRILL_FM5:
	smpsPan		panRight,0
	smpsCall	MANDRILL_FM5_p0
MANDRILL_FM5_Loop:
	smpsCall	MANDRILL_FM5_p1
	smpsCall	MANDRILL_FM5_p2
	smpsCall	MANDRILL_FM5_p3
	smpsCall	MANDRILL_FM5_p4
	smpsCall	MANDRILL_FM5_p1
	smpsCall	MANDRILL_FM5_p2
	smpsCall	MANDRILL_FM5_p3
	smpsCall	MANDRILL_FM5_p4
	smpsCall	MANDRILL_FM5_p1
	smpsCall	MANDRILL_FM5_p2
	smpsCall	MANDRILL_FM5_p3
	smpsCall	MANDRILL_FM5_p4
	smpsCall	MANDRILL_FM5_p1
	smpsCall	MANDRILL_FM5_p2
	smpsCall	MANDRILL_FM5_p3
	smpsCall	MANDRILL_FM5_p10
	smpsCall	MANDRILL_FM5_p11
	smpsCall	MANDRILL_FM5_p12
	smpsCall	MANDRILL_FM5_p13
	smpsCall	MANDRILL_FM5_p14
	smpsCall	MANDRILL_FM5_p3
	smpsCall	MANDRILL_FM5_p10
	smpsCall	MANDRILL_FM5_p11
	smpsCall	MANDRILL_FM5_p18
	smpsCall	MANDRILL_FM5_p19
	smpsCall	MANDRILL_FM5_p10
	smpsCall	MANDRILL_FM5_p12
	smpsCall	MANDRILL_FM5_p1c
	smpsCall	MANDRILL_FM5_p1d
	smpsCall	MANDRILL_FM5_p1e
	smpsCall	MANDRILL_FM5_p0
	smpsCall	MANDRILL_FM5_p20
	smpsCall	MANDRILL_FM5_p21
	smpsCall	MANDRILL_FM5_p22
	smpsCall	MANDRILL_FM5_p24
	smpsJump	MANDRILL_FM5_Loop

MANDRILL_PSG1:
	smpsCall	MANDRILL_PSG1_p0
MANDRILL_PSG1_Loop:
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p8
	smpsCall	MANDRILL_PSG1_p9
	smpsCall	MANDRILL_PSG1_pa
	smpsCall	MANDRILL_PSG1_pb
	smpsCall	MANDRILL_PSG1_pc
	smpsCall	MANDRILL_PSG1_p9
	smpsCall	MANDRILL_PSG1_pa
	smpsCall	MANDRILL_PSG1_pb
	smpsCall	MANDRILL_PSG1_p10
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p14
	smpsCall	MANDRILL_PSG1_p15
	smpsCall	MANDRILL_PSG1_p16
	smpsCall	MANDRILL_PSG1_p17
	smpsCall	MANDRILL_PSG1_p18
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p1
	smpsCall	MANDRILL_PSG1_p22
	smpsCall	MANDRILL_PSG1_p24
	smpsJump	MANDRILL_PSG1_Loop

MANDRILL_PSG2:
	smpsCall	MANDRILL_PSG2_p0
MANDRILL_PSG2_Loop:
	smpsCall	MANDRILL_PSG2_p1
	smpsCall	MANDRILL_PSG2_p2
	smpsCall	MANDRILL_PSG2_p3
	smpsCall	MANDRILL_PSG2_p4
	smpsCall	MANDRILL_PSG2_p1
	smpsCall	MANDRILL_PSG2_p6
	smpsCall	MANDRILL_PSG2_p7
	smpsCall	MANDRILL_PSG2_p8
	smpsCall	MANDRILL_PSG2_p1
	smpsCall	MANDRILL_PSG2_p2
	smpsCall	MANDRILL_PSG2_p3
	smpsCall	MANDRILL_PSG2_p4
	smpsCall	MANDRILL_PSG2_p1
	smpsCall	MANDRILL_PSG2_pe
	smpsCall	MANDRILL_PSG2_p7
	smpsCall	MANDRILL_PSG2_p10
	smpsCall	MANDRILL_PSG2_p11
	smpsCall	MANDRILL_PSG2_p12
	smpsCall	MANDRILL_PSG2_p13
	smpsCall	MANDRILL_PSG2_p14
	smpsCall	MANDRILL_PSG2_p15
	smpsCall	MANDRILL_PSG2_p16
	smpsCall	MANDRILL_PSG2_p17
	smpsCall	MANDRILL_PSG2_p10
	smpsCall	MANDRILL_PSG2_p19
	smpsCall	MANDRILL_PSG2_p1a
	smpsCall	MANDRILL_PSG2_p1b
	smpsCall	MANDRILL_PSG2_p1c
	smpsCall	MANDRILL_PSG2_p1d
	smpsCall	MANDRILL_PSG2_p1e
	smpsCall	MANDRILL_PSG2_p1f
	smpsCall	MANDRILL_PSG2_p10
	smpsCall	MANDRILL_PSG2_p1
	smpsCall	MANDRILL_PSG2_p22
	smpsCall	MANDRILL_PSG2_p24
	smpsJump	MANDRILL_PSG2_Loop

MANDRILL_PSG3:
	smpsPSGform	$E7
	smpsCall	MANDRILL_PSG3_p0
MANDRILL_PSG3_Loop:
	smpsCall	MANDRILL_PSG3_p1
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p7
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p9
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_pc
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p10
	smpsCall	MANDRILL_PSG3_p11
	smpsCall	MANDRILL_PSG3_p11
	smpsCall	MANDRILL_PSG3_p13
	smpsCall	MANDRILL_PSG3_p14
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p7
	smpsCall	MANDRILL_PSG3_p18
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p18
	smpsCall	MANDRILL_PSG3_p2
	smpsCall	MANDRILL_PSG3_p3
	smpsCall	MANDRILL_PSG3_p18
	smpsCall	MANDRILL_PSG3_p18
	smpsCall	MANDRILL_PSG3_p18
	smpsCall	MANDRILL_PSG3_p22
	smpsCall	MANDRILL_PSG3_p24
	smpsJump	MANDRILL_PSG3_Loop

MANDRILL_DAC:
	smpsCall	MANDRILL_DAC_p0
MANDRILL_DAC_Loop:
	smpsCall	MANDRILL_DAC_p1
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p4
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p8
	smpsCall	MANDRILL_DAC_p9
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_pc
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_pf
	smpsCall	MANDRILL_DAC_p8
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p13
	smpsCall	MANDRILL_DAC_p14
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p18
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p3
	smpsCall	MANDRILL_DAC_p1c
	smpsCall	MANDRILL_DAC_p2
	smpsCall	MANDRILL_DAC_p1e
	smpsCall	MANDRILL_DAC_p1f
	smpsCall	MANDRILL_DAC_p20
	smpsCall	MANDRILL_DAC_p21
	smpsCall	MANDRILL_DAC_p22
	smpsCall	MANDRILL_DAC_p24
	smpsJump	MANDRILL_DAC_Loop


; Pattern data for FM1
MANDRILL_FM1_p0:
	smpsFMvoice	$0
	dc.b		$95,$8
	dc.b		$93
	dc.b		$92
	dc.b		$93
	dc.b		$92
	dc.b		$8e
	dc.b		$90,$10
	smpsReturn

MANDRILL_FM1_p1:
	dc.b		$90,$4
	dc.b		$90
	dc.b		$95
	dc.b		$97
	dc.b		$90
	dc.b		$90
	dc.b		$90,$8
	dc.b		$4
	dc.b		$90
	dc.b		$95
	dc.b		$97
	dc.b		$90
	dc.b		$90
	dc.b		$90,$8
	smpsReturn

MANDRILL_FM1_p2:
	dc.b		$90,$4
	dc.b		$90
	dc.b		$95
	dc.b		$97
	dc.b		$90
	dc.b		$90
	dc.b		$90,$8
	dc.b		$4
	dc.b		$90
	dc.b		$95
	dc.b		$97
	dc.b		$90
	dc.b		$90
	dc.b		$95,$8
	smpsReturn

MANDRILL_FM1_p3:
	dc.b		$95,$4
	dc.b		$95
	dc.b		$9a
	dc.b		$9c
	dc.b		$95
	dc.b		$95
	dc.b		$95,$8
	dc.b		$4
	dc.b		$95
	dc.b		$9a
	dc.b		$9c
	dc.b		$95
	dc.b		$95
	dc.b		$8e,$8
	smpsReturn

MANDRILL_FM1_p4:
	dc.b		$8e,$4
	dc.b		$8e
	dc.b		$93
	dc.b		$95
	dc.b		$8e
	dc.b		$8e
	dc.b		$8e,$8
	dc.b		$4
	dc.b		$8e
	dc.b		$93
	dc.b		$95
	dc.b		$8e
	dc.b		$8e
	dc.b		$90,$8
	smpsReturn

MANDRILL_FM1_p10:
	dc.b		$8e,$4
	dc.b		$8e
	dc.b		$93
	dc.b		$95
	dc.b		$8e
	dc.b		$8e
	dc.b		$8e,$8
	dc.b		$4
	dc.b		$8e
	dc.b		$93
	dc.b		$95
	dc.b		$8e
	dc.b		$8e
	dc.b		$97,$8
	smpsReturn

MANDRILL_FM1_p11:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	smpsReturn

MANDRILL_FM1_p12:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$90,$8
	smpsReturn

MANDRILL_FM1_p13:
	dc.b		$90,$4
	dc.b		$90
	dc.b		$9a
	dc.b		$9c
	dc.b		$90
	dc.b		$90
	dc.b		$92,$8
	dc.b		$4
	dc.b		$92
	dc.b		$9c
	dc.b		$9e
	dc.b		$92
	dc.b		$92
	dc.b		$93,$8
	smpsReturn

MANDRILL_FM1_p14:
	dc.b		$93,$4
	dc.b		$93
	dc.b		$9e
	dc.b		$9f
	dc.b		$93
	dc.b		$93
	dc.b		$94,$8
	dc.b		$4
	dc.b		$94
	dc.b		$9e
	dc.b		$a0
	dc.b		$94
	dc.b		$94
	dc.b		$95,$8
	smpsReturn

MANDRILL_FM1_p17:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$9c
	dc.b		$9e
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$9c
	dc.b		$9e
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	smpsReturn

MANDRILL_FM1_p18:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$9c
	dc.b		$9e
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$9c
	dc.b		$9e
	dc.b		$97
	dc.b		$97
	dc.b		$98,$8
	smpsReturn

MANDRILL_FM1_p19:
	dc.b		$98,$4
	dc.b		$98
	dc.b		$a2
	dc.b		$a4
	dc.b		$98
	dc.b		$98
	dc.b		$98,$8
	dc.b		$4
	dc.b		$98
	dc.b		$a2
	dc.b		$a4
	dc.b		$98
	dc.b		$98
	dc.b		$9a,$8
	smpsReturn

MANDRILL_FM1_p1a:
	dc.b		$9a,$4
	dc.b		$9a
	dc.b		$a4
	dc.b		$a6
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a,$8
	dc.b		$4
	dc.b		$9a
	dc.b		$a4
	dc.b		$a6
	dc.b		$9a
	dc.b		$9a
	dc.b		$97,$8
	smpsReturn

MANDRILL_FM1_p1b:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$a0
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$a0
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$9c,$8
	smpsReturn

MANDRILL_FM1_p1c:
	dc.b		$9c,$4
	dc.b		$9c
	dc.b		$a5
	dc.b		$a8
	dc.b		$9c
	dc.b		$9c
	dc.b		$9a,$8
	dc.b		$4
	dc.b		$9a
	dc.b		$a3
	dc.b		$a6
	dc.b		$9a
	dc.b		$9a
	dc.b		$98,$8
	smpsReturn

MANDRILL_FM1_p1d:
	dc.b		$98,$4
	dc.b		$98
	dc.b		$a2
	dc.b		$a4
	dc.b		$98
	dc.b		$98
	dc.b		$98,$8
	dc.b		$4
	dc.b		$98
	dc.b		$a2
	dc.b		$a4
	dc.b		$98
	dc.b		$98
	dc.b		$97,$8
	smpsReturn

MANDRILL_FM1_p1e:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	dc.b		$a1
	dc.b		$a3
	dc.b		$97
	dc.b		$97
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM1_p20:
	dc.b		$e7,$38
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM1_p21:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_FM1_p22:
	dc.b		$e7,$38
	smpsReturn

MANDRILL_FM1_p24:
	smpsFMvoice	$0
	dc.b		$90,$10
	smpsReturn

; Pattern data for FM2
MANDRILL_FM2_p0:
        smpsModSet      $1E, $01, $05, $05        
	smpsFMvoice	$1
	dc.b		$b7,$2
	dc.b		$b9,$6
	dc.b		$b7,$8
	dc.b		$b6
	dc.b		$b7
	dc.b		$b6
	dc.b		$b2
	dc.b		$b4,$10
	smpsReturn

MANDRILL_FM2_p1:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_FM2_p2:
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b7
	dc.b		$af
	dc.b		$b9
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb,$6
	smpsReturn

MANDRILL_FM2_p3:
	dc.b		$e7,$8
	dc.b		$b9
	dc.b		$b9,$20
	dc.b		$b7,$8
	dc.b		$b6,$4
	dc.b		$b4
	smpsReturn

MANDRILL_FM2_p4:
	dc.b		$b2,$28
	dc.b		$b4,$4
	dc.b		$ad
	dc.b		$af
	dc.b		$b2
	dc.b		$b4,$8
	smpsReturn

MANDRILL_FM2_p6:
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af,$8
	dc.b		$b7,$4
	dc.b		$b7
	dc.b		$af,$8
	dc.b		$b9,$4
	dc.b		$b9
	dc.b		$af,$8
	dc.b		$b9,$2
	dc.b		$bb,$6
	smpsReturn

MANDRILL_FM2_p7:
	dc.b		$e7,$8
	dc.b		$b9
	dc.b		$b9,$10
	dc.b		$b7,$8
	dc.b		$b4
	dc.b		$b6,$10
	smpsReturn

MANDRILL_FM2_pe:
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af
	dc.b		$af
	dc.b		$b7
	dc.b		$b7
	dc.b		$af
	dc.b		$af
	dc.b		$b9
	dc.b		$b9
	dc.b		$af
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb,$6
	smpsReturn

MANDRILL_FM2_p10:
	dc.b		$e7,$38
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM2_p11:
	smpsFMvoice	$1
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b9
	dc.b		$af
	dc.b		$b6
	dc.b		$b9
	dc.b		$b7
	smpsReturn

MANDRILL_FM2_p12:
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b4
	dc.b		$af
	dc.b		$b6
	dc.b		$af
	dc.b		$b7,$2
	dc.b		$b9,$6
	smpsReturn

MANDRILL_FM2_p13:
	dc.b		$e7,$10
	dc.b		$b7,$18
	dc.b		$b6,$10
	dc.b		$a8,$4
	dc.b		$af
	smpsReturn

MANDRILL_FM2_p14:
	dc.b		$b4,$10
	dc.b		$b3,$4
	dc.b		$b4
	dc.b		$b6,$8
	dc.b		$b4,$4
	dc.b		$b6
	dc.b		$b7,$10
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM2_p15:
	dc.b		$e7,$20
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b6
	smpsReturn

MANDRILL_FM2_p16:
	dc.b		$ad,$8
	dc.b		$b2
	dc.b		$b6
	dc.b		$b9
	dc.b		$b6
	dc.b		$b9
	dc.b		$be
	dc.b		$be,$2
	dc.b		$c0,$6
	smpsReturn

MANDRILL_FM2_p17:
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$bf,$10
	smpsReturn

MANDRILL_FM2_p19:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$be,$2
	dc.b		$c0,$1e
	dc.b		$4
	dc.b		$be
	dc.b		$bb
	dc.b		$b9
	dc.b		$b9,$2
	dc.b		$bb,$6
	smpsReturn

MANDRILL_FM2_p1a:
	dc.b		$bb,$8
	dc.b		$be
	dc.b		$b7,$2
	dc.b		$b9,$16
	dc.b		$4
	dc.b		$b7
	dc.b		$b6,$8
	dc.b		$b9,$2
	dc.b		$bb,$6
	smpsReturn

MANDRILL_FM2_p1b:
	dc.b		$e7,$8
	dc.b		$bb,$4
	dc.b		$b9
	dc.b		$b7
	dc.b		$b6
	dc.b		$b3
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$c2,$2
	dc.b		$c3,$6
	smpsReturn

MANDRILL_FM2_p1c:
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$be
	dc.b		$c0
	dc.b		$be,$2
	dc.b		$c0,$6
	smpsReturn

MANDRILL_FM2_p1d:
	dc.b		$e7,$10
	dc.b		$c0,$4
	dc.b		$be
	dc.b		$bb,$18
	dc.b		$4
	dc.b		$b9
	dc.b		$b7,$8
	smpsReturn

MANDRILL_FM2_p1e:
	dc.b		$e7,$10
	dc.b		$b7,$4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM2_p1f:
	dc.b		$c3,$2
	dc.b		$c5,$6
	dc.b		$c3,$8
	dc.b		$c2
	dc.b		$c3
	dc.b		$c2
	dc.b		$be
	dc.b		$c0,$10
	smpsReturn

MANDRILL_FM2_p22:
	dc.b		$e7,$28
	smpsFMvoice	$1
	dc.b		$af,$4
	dc.b		$b1
	dc.b		$b2
	dc.b		$b3
	smpsReturn

MANDRILL_FM2_p24:
	dc.b		$b4,$10
	smpsReturn

; Pattern data for FM3
MANDRILL_FM3_p0:
	dc.b		$e7,$4
        smpsModSet      $1E, $01, $05, $05
	smpsFMvoice	$1
	dc.b		$b7,$2
	dc.b		$b9,$6
	dc.b		$b7,$8
	dc.b		$b6
	dc.b		$b7
	dc.b		$b6
	dc.b		$b2
	dc.b		$b4,$c
	smpsReturn

MANDRILL_FM3_p1:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_FM3_p2:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b7
	dc.b		$af
	dc.b		$b9
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_FM3_p3:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$b9,$8
	dc.b		$20
	dc.b		$b7,$8
	dc.b		$b6,$4
	smpsReturn

MANDRILL_FM3_p4:
	smpsFMvoice	$1
	dc.b		$b4,$4
	dc.b		$b2,$28
	dc.b		$b4,$4
	dc.b		$ad
	dc.b		$af
	dc.b		$b2
	dc.b		$b4
	smpsReturn

MANDRILL_FM3_p6:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af,$8
	dc.b		$b7,$4
	dc.b		$b7
	dc.b		$af,$8
	dc.b		$b9,$4
	dc.b		$b9
	dc.b		$af,$8
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_FM3_p7:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$b9,$8
	dc.b		$10
	dc.b		$b7,$8
	dc.b		$b4
	dc.b		$b6,$c
	smpsReturn

MANDRILL_FM3_p8:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$b2,$28
	dc.b		$b4,$4
	dc.b		$ad
	dc.b		$af
	dc.b		$b2
	dc.b		$b4
	smpsReturn

MANDRILL_FM3_pe:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af
	dc.b		$af
	dc.b		$b7
	dc.b		$b7
	dc.b		$af
	dc.b		$af
	dc.b		$b9
	dc.b		$b9
	dc.b		$af
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_FM3_p10:
	dc.b		$e7,$3c
	dc.b		$80,$4
	smpsReturn

MANDRILL_FM3_p11:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b9
	dc.b		$af
	dc.b		$b6
	dc.b		$b9
	dc.b		$b7,$4
	smpsReturn

MANDRILL_FM3_p12:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b4
	dc.b		$af
	dc.b		$b6
	dc.b		$af
	dc.b		$b7,$2
	dc.b		$b9
	smpsReturn

MANDRILL_FM3_p13:
	dc.b		$e7,$14
	smpsFMvoice	$1
	dc.b		$b7,$18
	dc.b		$b6,$10
	dc.b		$a8,$4
	smpsReturn

MANDRILL_FM3_p14:
	smpsFMvoice	$1
	dc.b		$af,$4
	dc.b		$b4,$10
	dc.b		$b3,$4
	dc.b		$b4
	dc.b		$b6,$8
	dc.b		$b4,$4
	dc.b		$b6
	dc.b		$b7,$10
	dc.b		$80,$4
	smpsReturn

MANDRILL_FM3_p15:
	dc.b		$e7,$24
	smpsFMvoice	$1
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b6,$4
	smpsReturn

MANDRILL_FM3_p16:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$ad,$8
	dc.b		$b2
	dc.b		$b6
	dc.b		$b9
	dc.b		$b6
	dc.b		$b9
	dc.b		$be
	dc.b		$be,$2
	dc.b		$c0
	smpsReturn

MANDRILL_FM3_p17:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$bf,$c
	smpsReturn

MANDRILL_FM3_p19:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$be,$2
	dc.b		$c0,$1e
	dc.b		$4
	dc.b		$be
	dc.b		$bb
	dc.b		$b9
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_FM3_p1a:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$bb,$8
	dc.b		$be
	dc.b		$b7,$2
	dc.b		$b9,$16
	dc.b		$4
	dc.b		$b7
	dc.b		$b6,$8
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_FM3_p1b:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$bb,$4
	dc.b		$b9
	dc.b		$b7
	dc.b		$b6
	dc.b		$b3
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$c2,$2
	dc.b		$c3
	smpsReturn

MANDRILL_FM3_p1c:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$be
	dc.b		$c0
	dc.b		$be,$2
	dc.b		$c0
	smpsReturn

MANDRILL_FM3_p1d:
	dc.b		$e7,$14
	smpsFMvoice	$1
	dc.b		$c0,$4
	dc.b		$be
	dc.b		$bb,$18
	dc.b		$4
	dc.b		$b9
	dc.b		$b7
	smpsReturn

MANDRILL_FM3_p1e:
	dc.b		$e7,$14
	smpsFMvoice	$1
	dc.b		$b7,$4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$80
	smpsReturn

MANDRILL_FM3_p1f:
	dc.b		$e7,$4
	smpsFMvoice	$1
	dc.b		$c3,$2
	dc.b		$c5,$6
	dc.b		$c3,$8
	dc.b		$c2
	dc.b		$c3
	dc.b		$c2
	dc.b		$be
	dc.b		$c0,$c
	smpsReturn

MANDRILL_FM3_p22:
	dc.b		$e7,$2c
	smpsFMvoice	$1
	dc.b		$af,$4
	dc.b		$b1
	dc.b		$b2
	smpsReturn

MANDRILL_FM3_p24:
	smpsFMvoice	$1
	dc.b		$b3,$4
	dc.b		$b4,$c
	smpsReturn

; Pattern data for FM4
MANDRILL_FM4_p0:
	smpsFMvoice	$1
	dc.b		$ad,$8
	dc.b		$ab
	dc.b		$aa
	dc.b		$ab
	dc.b		$aa
	dc.b		$a6
	dc.b		$a8,$10
	smpsReturn

MANDRILL_FM4_p1:
	dc.b		$a8,$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	smpsReturn

MANDRILL_FM4_p2:
	dc.b		$a8,$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$ad,$8
	smpsReturn

MANDRILL_FM4_p3:
	dc.b		$ad,$4
	dc.b		$ad
	dc.b		$ad,$8
	dc.b		$4
	dc.b		$ad
	dc.b		$ad,$8
	dc.b		$4
	dc.b		$ad
	dc.b		$ad,$8
	dc.b		$4
	dc.b		$ad
	dc.b		$a6,$8
	smpsReturn

MANDRILL_FM4_p4:
	dc.b		$a6,$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a8,$8
	smpsReturn

MANDRILL_FM4_p10:
	dc.b		$a6,$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM4_p11:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM4_p12:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a8,$8
	smpsReturn

MANDRILL_FM4_p13:
	dc.b		$a8,$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$aa,$8
	dc.b		$4
	dc.b		$aa
	dc.b		$aa,$8
	dc.b		$4
	dc.b		$aa
	dc.b		$ab,$8
	smpsReturn

MANDRILL_FM4_p14:
	dc.b		$ab,$4
	dc.b		$ab
	dc.b		$ab,$8
	dc.b		$4
	dc.b		$ab
	dc.b		$ac,$8
	dc.b		$4
	dc.b		$ac
	dc.b		$ac,$8
	dc.b		$4
	dc.b		$ac
	dc.b		$ad,$8
	smpsReturn

MANDRILL_FM4_p18:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a4,$8
	smpsReturn

MANDRILL_FM4_p19:
	dc.b		$a4,$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a6,$8
	smpsReturn

MANDRILL_FM4_p1c:
	dc.b		$a8,$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a4,$8
	smpsReturn

MANDRILL_FM4_p1d:
	dc.b		$a4,$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a4,$8
	dc.b		$4
	dc.b		$a4
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM4_p1e:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM4_p20:
	dc.b		$e7,$38
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM4_p21:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_FM4_p22:
	dc.b		$e7,$38
	smpsReturn

MANDRILL_FM4_p24:
	smpsFMvoice	$1
	dc.b		$a8,$10
	smpsReturn

; Pattern data for FM5
MANDRILL_FM5_p0:
	smpsFMvoice	$1
	dc.b		$a8,$8
	dc.b		$a6
	dc.b		$a5
	dc.b		$a6
	dc.b		$a5
	dc.b		$a1
	dc.b		$a3,$10
	smpsReturn

MANDRILL_FM5_p1:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM5_p2:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a8,$8
	smpsReturn

MANDRILL_FM5_p3:
	dc.b		$a8,$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a8,$8
	dc.b		$4
	dc.b		$a8
	dc.b		$a1,$8
	smpsReturn

MANDRILL_FM5_p4:
	dc.b		$a1,$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM5_p10:
	dc.b		$a1,$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$9e,$8
	smpsReturn

MANDRILL_FM5_p11:
	dc.b		$9e,$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	smpsReturn

MANDRILL_FM5_p12:
	dc.b		$9e,$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$a3,$8
	smpsReturn

MANDRILL_FM5_p13:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a5,$8
	dc.b		$4
	dc.b		$a5
	dc.b		$a5,$8
	dc.b		$4
	dc.b		$a5
	dc.b		$a6,$8
	smpsReturn

MANDRILL_FM5_p14:
	dc.b		$a6,$4
	dc.b		$a6
	dc.b		$a6,$8
	dc.b		$4
	dc.b		$a6
	dc.b		$a7,$8
	dc.b		$4
	dc.b		$a7
	dc.b		$a7,$8
	dc.b		$4
	dc.b		$a7
	dc.b		$a8,$8
	smpsReturn

MANDRILL_FM5_p18:
	dc.b		$9e,$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9f,$8
	smpsReturn

MANDRILL_FM5_p19:
	dc.b		$9f,$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$a1,$8
	smpsReturn

MANDRILL_FM5_p1c:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3,$8
	dc.b		$4
	dc.b		$a3
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$a1,$8
	dc.b		$4
	dc.b		$a1
	dc.b		$9f,$8
	smpsReturn

MANDRILL_FM5_p1d:
	dc.b		$9f,$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$9f,$8
	dc.b		$4
	dc.b		$9f
	dc.b		$9e,$8
	smpsReturn

MANDRILL_FM5_p1e:
	dc.b		$9e,$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$4
	dc.b		$9e
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM5_p20:
	dc.b		$e7,$38
	dc.b		$80,$8
	smpsReturn

MANDRILL_FM5_p21:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_FM5_p22:
	dc.b		$e7,$38
	smpsReturn

MANDRILL_FM5_p24:
	smpsFMvoice	$1
	dc.b		$a3,$10
	smpsReturn

; Pattern data for PSG1
MANDRILL_PSG1_p0:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_PSG1_p1:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_PSG1_p8:
	dc.b		$e7,$38
	smpsModSet      $10, $01, $01, $02
	smpsPSGvoice	$0
	dc.b		$c0,$8
	smpsReturn

MANDRILL_PSG1_p9:
	dc.b		$e7,$18
	dc.b		$c2,$20
	dc.b		$c3,$8
	smpsReturn

MANDRILL_PSG1_pa:
	dc.b		$e7,$18
	dc.b		$c7,$20
	dc.b		$c5,$8
	smpsReturn

MANDRILL_PSG1_pb:
	dc.b		$e7,$18
	dc.b		$c7,$20
	dc.b		$c8,$8
	smpsReturn

MANDRILL_PSG1_pc:
	dc.b		$e7,$18
	dc.b		$ca,$20
	dc.b		$c0,$8
	smpsReturn

MANDRILL_PSG1_p10:
	dc.b		$e7,$18
	dc.b		$ca,$20
	dc.b		$80,$8
	smpsReturn

MANDRILL_PSG1_p14:
	dc.b		$e7,$38
	smpsPSGvoice	$0
	dc.b		$bc,$8
	smpsReturn

MANDRILL_PSG1_p15:
	dc.b		$e7,$38
	dc.b		$c2,$8
	smpsReturn

MANDRILL_PSG1_p16:
	dc.b		$e7,$38
	dc.b		$bb,$8
	smpsReturn

MANDRILL_PSG1_p17:
	dc.b		$e7,$38
	dc.b		$bb,$4
	dc.b		$bf
	smpsReturn

MANDRILL_PSG1_p18:
	dc.b		$c2,$4
	dc.b		$c7
	dc.b		$cc,$18
	dc.b		$cb
	dc.b		$80,$8
	smpsReturn

MANDRILL_PSG1_p22:
	dc.b		$e7,$38
	smpsReturn

MANDRILL_PSG1_p24:
	dc.b		$e7,$10
	smpsReturn

; Pattern data for PSG2
MANDRILL_PSG2_p0:
	dc.b		$e7,$4
	smpsPSGvoice	$0
	dc.b		$b7,$2
	dc.b		$b9,$6
	dc.b		$b7,$8
	dc.b		$b6
	dc.b		$b7
	dc.b		$b6
	dc.b		$b2
	dc.b		$b4,$c
	smpsReturn

MANDRILL_PSG2_p1:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_PSG2_p2:
	dc.b		$e7,$4
	smpsPSGvoice	$0
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b7
	dc.b		$af
	dc.b		$b9
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_PSG2_p3:
	dc.b		$e7,$c
	dc.b		$b9,$8
	dc.b		$20
	dc.b		$b7,$8
	dc.b		$b6,$4
	smpsReturn

MANDRILL_PSG2_p4:
	dc.b		$b4,$4
	dc.b		$b2,$28
	dc.b		$b4,$4
	dc.b		$ad
	dc.b		$af
	dc.b		$b2
	dc.b		$b4
	smpsReturn

MANDRILL_PSG2_p6:
	dc.b		$e7,$4
	smpsPSGvoice	$0
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af,$8
	dc.b		$b7,$4
	dc.b		$b7
	dc.b		$af,$8
	dc.b		$b9,$4
	dc.b		$b9
	dc.b		$af,$8
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_PSG2_p7:
	dc.b		$e7,$c
	dc.b		$b9,$8
	dc.b		$10
	dc.b		$b7,$8
	dc.b		$b4
	dc.b		$b6,$c
	smpsReturn

MANDRILL_PSG2_p8:
	dc.b		$e7,$4
	dc.b		$b2,$28
	dc.b		$b4,$4
	dc.b		$ad
	dc.b		$af
	dc.b		$b2
	dc.b		$b4
	smpsReturn

MANDRILL_PSG2_pe:
	dc.b		$e7,$4
	smpsPSGvoice	$0
	dc.b		$af,$8
	dc.b		$b6,$4
	dc.b		$b6
	dc.b		$af
	dc.b		$af
	dc.b		$b7
	dc.b		$b7
	dc.b		$af
	dc.b		$af
	dc.b		$b9
	dc.b		$b9
	dc.b		$af
	dc.b		$af
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_PSG2_p10:
	dc.b		$e7,$3c
	dc.b		$80,$4
	smpsReturn

MANDRILL_PSG2_p11:
	dc.b		$e7,$4
	smpsPSGvoice	$0
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b9
	dc.b		$af
	dc.b		$b6
	dc.b		$b9
	dc.b		$b7,$4
	smpsReturn

MANDRILL_PSG2_p12:
	dc.b		$e7,$4
	dc.b		$af,$8
	dc.b		$b6
	dc.b		$af
	dc.b		$b4
	dc.b		$af
	dc.b		$b6
	dc.b		$af
	dc.b		$b7,$2
	dc.b		$b9
	smpsReturn

MANDRILL_PSG2_p13:
	dc.b		$e7,$14
	dc.b		$b7,$18
	dc.b		$b6,$10
	dc.b		$a8,$4
	smpsReturn

MANDRILL_PSG2_p14:
	dc.b		$af,$4
	dc.b		$b4,$10
	dc.b		$b3,$4
	dc.b		$b4
	dc.b		$b6,$8
	dc.b		$b4,$4
	dc.b		$b6
	dc.b		$b7,$10
	dc.b		$80,$4
	smpsReturn

MANDRILL_PSG2_p15:
	dc.b		$e7,$24
	dc.b		$b9,$2
	dc.b		$bb,$6
	dc.b		$b9,$8
	dc.b		$b7
	dc.b		$b6,$4
	smpsReturn

MANDRILL_PSG2_p16:
	dc.b		$e7,$4
	dc.b		$ad,$8
	dc.b		$b2
	dc.b		$b6
	dc.b		$b9
	dc.b		$b6
	dc.b		$b9
	dc.b		$be
	dc.b		$be,$2
	dc.b		$c0
	smpsReturn

MANDRILL_PSG2_p17:
	dc.b		$e7,$4
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$be,$8
	dc.b		$bb
	dc.b		$be,$2
	dc.b		$c0,$6
	dc.b		$bf,$c
	smpsReturn

MANDRILL_PSG2_p19:
	dc.b		$e7,$c
	smpsPSGvoice	$0
	dc.b		$be,$2
	dc.b		$c0,$1e
	dc.b		$4
	dc.b		$be
	dc.b		$bb
	dc.b		$b9
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_PSG2_p1a:
	dc.b		$e7,$4
	dc.b		$bb,$8
	dc.b		$be
	dc.b		$b7,$2
	dc.b		$b9,$16
	dc.b		$4
	dc.b		$b7
	dc.b		$b6,$8
	dc.b		$b9,$2
	dc.b		$bb
	smpsReturn

MANDRILL_PSG2_p1b:
	dc.b		$e7,$c
	dc.b		$bb,$4
	dc.b		$b9
	dc.b		$b7
	dc.b		$b6
	dc.b		$b3
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$c2,$2
	dc.b		$c3
	smpsReturn

MANDRILL_PSG2_p1c:
	dc.b		$e7,$4
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$2
	dc.b		$c3,$6
	dc.b		$c2,$8
	dc.b		$be
	dc.b		$c0
	dc.b		$be,$2
	dc.b		$c0
	smpsReturn

MANDRILL_PSG2_p1d:
	dc.b		$e7,$14
	dc.b		$c0,$4
	dc.b		$be
	dc.b		$bb,$18
	dc.b		$4
	dc.b		$b9
	dc.b		$b7
	smpsReturn

MANDRILL_PSG2_p1e:
	dc.b		$e7,$14
	dc.b		$b7,$4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b4
	dc.b		$b6
	dc.b		$b7
	dc.b		$b9
	dc.b		$bb
	dc.b		$be
	dc.b		$c0
	dc.b		$80
	smpsReturn

MANDRILL_PSG2_p1f:
	dc.b		$e7,$4
	dc.b		$c3,$2
	dc.b		$c5,$6
	dc.b		$c3,$8
	dc.b		$c2
	dc.b		$c3
	dc.b		$c2
	dc.b		$be
	dc.b		$c0,$c
	smpsReturn

MANDRILL_PSG2_p22:
	dc.b		$e7,$2c
	smpsPSGvoice	$0
	dc.b		$af,$4
	dc.b		$b1
	dc.b		$b2
	smpsReturn

MANDRILL_PSG2_p24:
	dc.b		$b3,$4
	dc.b		$b4,$c
	smpsReturn

; Pattern data for PSG3 (Noise)
MANDRILL_PSG3_p0:
	dc.b		$80,$40
	smpsReturn

MANDRILL_PSG3_p1:
	smpsPSGvoice	$2
	dc.b		$82,$1
	dc.b		$80,$7
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80
	smpsReturn

MANDRILL_PSG3_p2:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80
	smpsReturn

MANDRILL_PSG3_p3:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$14
	smpsReturn

MANDRILL_PSG3_p7:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$10
	smpsPSGvoice	$2
	dc.b		$82,$4
	smpsReturn

MANDRILL_PSG3_p9:
	smpsPSGvoice	$2
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$3
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80
	smpsReturn

MANDRILL_PSG3_pc:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$5
	dc.b		$7
	dc.b		$82,$4
	dc.b		$80,$5
	dc.b		$f
	smpsReturn

MANDRILL_PSG3_p10:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	dc.b		$82,$4
	dc.b		$80,$c
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsReturn

MANDRILL_PSG3_p11:
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsReturn

MANDRILL_PSG3_p13:
	dc.b		$e7,$8
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$7
	smpsPSGvoice	$1
	dc.b		$82,$8
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80,$e
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsReturn

MANDRILL_PSG3_p14:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$e
	smpsPSGvoice	$1
	dc.b		$82,$8
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	dc.b		$80,$c
	smpsReturn

MANDRILL_PSG3_p18:
	dc.b		$e7,$40
	smpsReturn

MANDRILL_PSG3_p22:
	dc.b		$e7,$38
	smpsReturn

MANDRILL_PSG3_p24:
	dc.b		$e7,$10
	smpsReturn

; Pattern data for DAC
	include	"sound\DalekSam\MANDRILLDAC.asm"

MANDRILL_Voices:
	dc.b	$20,$7a,$31,$0,$0,$9f,$d8,$dc,$df,$10,$a,$4,$4,$f,$8,$8
	dc.b	$8,$5f,$5f,$bf,$bf,$14,$2b,$17,$80	; Voice 0 (GoldenAxe2Results-Bass)
	dc.b	$38,$33,$1,$51,$1,$10,$13,$1a,$1b,$f,$1f,$1f,$1f,$1,$1,$1
	dc.b	$1,$33,$3,$3,$8,$16,$1a,$19,$80	; Voice 1 (DangerousSeed-Jupiter-A:FM2 Distortion Synth 2 (Mod $1E, $01, $05, $05))
	even
