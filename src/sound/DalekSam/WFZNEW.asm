; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Thu Oct 22 2009, 20:17:55
; -------------------------------------------------------

WFZNEW_Header:
	smpsHeaderVoice	WFZNEW_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$1, $4
	smpsHeaderDAC	WFZNEW_DAC
	smpsHeaderFM	WFZNEW_FM1,	$c, $e
	smpsHeaderFM	WFZNEW_FM2,	$0, $a
	smpsHeaderFM	WFZNEW_FM3,	$0, $11
	smpsHeaderFM	WFZNEW_FM4,	$0, $A
	smpsHeaderFM	WFZNEW_FM5,	$0, $11
	smpsHeaderPSG	WFZNEW_PSG1,	$dc, $2, $0
	smpsHeaderPSG	WFZNEW_PSG2,	$dc, $2, $0
	smpsHeaderPSG	WFZNEW_PSG3,	$dc, $1, $0

WFZNEW_FM1:
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p9
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p9
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_pd
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p10
	smpsCall	WFZNEW_FM1_pd
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p10
	smpsCall	WFZNEW_FM1_pd
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_p0
	smpsCall	WFZNEW_FM1_p10
	smpsCall	WFZNEW_FM1_pd
	smpsCall	WFZNEW_FM1_pd
	smpsCall	WFZNEW_FM1_pb
	smpsCall	WFZNEW_FM1_p19
	smpsJump	WFZNEW_FM1

WFZNEW_FM2:
	smpsCall	WFZNEW_FM2_p0
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p2
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p0
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p4
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p0
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p2
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p0
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p2
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p6
	smpsCall	WFZNEW_FM2_p7
	smpsCall	WFZNEW_FM2_p8
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p6
	smpsCall	WFZNEW_FM2_p7
	smpsCall	WFZNEW_FM2_pa
	smpsCall	WFZNEW_FM2_pb
	smpsCall	WFZNEW_FM2_p6
	smpsCall	WFZNEW_FM2_p7
	smpsCall	WFZNEW_FM2_p8
	smpsCall	WFZNEW_FM2_p1
	smpsCall	WFZNEW_FM2_p6
	smpsCall	WFZNEW_FM2_p7
	smpsCall	WFZNEW_FM2_pa
	smpsCall	WFZNEW_FM2_pb
	smpsCall	WFZNEW_FM2_pd
	smpsCall	WFZNEW_FM2_pe
	smpsCall	WFZNEW_FM2_pf
	smpsCall	WFZNEW_FM2_p10
	smpsCall	WFZNEW_FM2_pd
	smpsCall	WFZNEW_FM2_p12
	smpsCall	WFZNEW_FM2_p13
	smpsCall	WFZNEW_FM2_p14
	smpsCall	WFZNEW_FM2_pd
	smpsCall	WFZNEW_FM2_p12
	smpsCall	WFZNEW_FM2_p15
	smpsCall	WFZNEW_FM2_p16
	smpsCall	WFZNEW_FM2_pd
	smpsCall	WFZNEW_FM2_p0
	smpsCall	WFZNEW_FM2_p18
	smpsCall	WFZNEW_FM2_p19
	smpsJump	WFZNEW_FM2

WFZNEW_FM3:
	smpsCall	WFZNEW_FM3_p0
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p6
	smpsCall	WFZNEW_FM3_p7
	smpsCall	WFZNEW_FM3_p8
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p6
	smpsCall	WFZNEW_FM3_p7
	smpsCall	WFZNEW_FM3_pa
	smpsCall	WFZNEW_FM3_pb
	smpsCall	WFZNEW_FM3_p6
	smpsCall	WFZNEW_FM3_p7
	smpsCall	WFZNEW_FM3_p8
	smpsCall	WFZNEW_FM3_p1
	smpsCall	WFZNEW_FM3_p6
	smpsCall	WFZNEW_FM3_p7
	smpsCall	WFZNEW_FM3_pa
	smpsCall	WFZNEW_FM3_pc
	smpsCall	WFZNEW_FM3_pd
	smpsCall	WFZNEW_FM3_pe
	smpsCall	WFZNEW_FM3_pf
	smpsCall	WFZNEW_FM3_p10
	smpsCall	WFZNEW_FM3_pd
	smpsCall	WFZNEW_FM3_p12
	smpsCall	WFZNEW_FM3_p13
	smpsCall	WFZNEW_FM3_p14
	smpsCall	WFZNEW_FM3_pd
	smpsCall	WFZNEW_FM3_p12
	smpsCall	WFZNEW_FM3_p15
	smpsCall	WFZNEW_FM3_p16
	smpsCall	WFZNEW_FM3_pd
	smpsCall	WFZNEW_FM3_p17
	smpsCall	WFZNEW_FM3_p18
	smpsCall	WFZNEW_FM3_p19
	smpsJump	WFZNEW_FM3

WFZNEW_FM4:
	smpsCall	WFZNEW_FM4_p0
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p2
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p0
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p4
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p0
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p2
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p0
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p2
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p6
	smpsCall	WFZNEW_FM4_p7
	smpsCall	WFZNEW_FM4_p8
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p6
	smpsCall	WFZNEW_FM4_p7
	smpsCall	WFZNEW_FM4_pa
	smpsCall	WFZNEW_FM4_pb
	smpsCall	WFZNEW_FM4_p6
	smpsCall	WFZNEW_FM4_p7
	smpsCall	WFZNEW_FM4_p8
	smpsCall	WFZNEW_FM4_p1
	smpsCall	WFZNEW_FM4_p6
	smpsCall	WFZNEW_FM4_p7
	smpsCall	WFZNEW_FM4_pa
	smpsCall	WFZNEW_FM4_pb
	smpsCall	WFZNEW_FM4_pd
	smpsCall	WFZNEW_FM4_pe
	smpsCall	WFZNEW_FM4_pf
	smpsCall	WFZNEW_FM4_p10
	smpsCall	WFZNEW_FM4_p11
	smpsCall	WFZNEW_FM4_pe
	smpsCall	WFZNEW_FM4_pf
	smpsCall	WFZNEW_FM4_pf
	smpsCall	WFZNEW_FM4_p11
	smpsCall	WFZNEW_FM4_pe
	smpsCall	WFZNEW_FM4_pf
	smpsCall	WFZNEW_FM4_p10
	smpsCall	WFZNEW_FM4_p11
	smpsCall	WFZNEW_FM4_pe
	smpsCall	WFZNEW_FM4_p18
	smpsCall	WFZNEW_FM4_p19
	smpsJump	WFZNEW_FM4

WFZNEW_FM5:
	smpsCall	WFZNEW_FM5_p0
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p6
	smpsCall	WFZNEW_FM5_p7
	smpsCall	WFZNEW_FM5_p8
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p6
	smpsCall	WFZNEW_FM5_p7
	smpsCall	WFZNEW_FM5_pa
	smpsCall	WFZNEW_FM5_pb
	smpsCall	WFZNEW_FM5_p6
	smpsCall	WFZNEW_FM5_p7
	smpsCall	WFZNEW_FM5_p8
	smpsCall	WFZNEW_FM5_p1
	smpsCall	WFZNEW_FM5_p6
	smpsCall	WFZNEW_FM5_p7
	smpsCall	WFZNEW_FM5_pa
	smpsCall	WFZNEW_FM5_pc
	smpsCall	WFZNEW_FM5_pd
	smpsCall	WFZNEW_FM5_pe
	smpsCall	WFZNEW_FM5_pf
	smpsCall	WFZNEW_FM5_p10
	smpsCall	WFZNEW_FM5_pd
	smpsCall	WFZNEW_FM5_pe
	smpsCall	WFZNEW_FM5_pf
	smpsCall	WFZNEW_FM5_p10
	smpsCall	WFZNEW_FM5_pd
	smpsCall	WFZNEW_FM5_pe
	smpsCall	WFZNEW_FM5_pf
	smpsCall	WFZNEW_FM5_p10
	smpsCall	WFZNEW_FM5_pd
	smpsCall	WFZNEW_FM5_pd
	smpsCall	WFZNEW_FM5_pe
	smpsCall	WFZNEW_FM5_p19
	smpsJump	WFZNEW_FM5

WFZNEW_PSG1:
	smpsCall	WFZNEW_PSG1_p0
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p2
	smpsCall	WFZNEW_PSG1_p1
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsCall	WFZNEW_PSG1_p6
	smpsJump	WFZNEW_PSG1

WFZNEW_PSG2:
	smpsCall	WFZNEW_PSG2_p0
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p2
	smpsCall	WFZNEW_PSG2_p1
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p7
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p9
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p7
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_pb
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p7
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p9
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_p7
	smpsCall	WFZNEW_PSG2_p6
	smpsCall	WFZNEW_PSG2_pb
	smpsCall	WFZNEW_PSG2_pd
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_p10
	smpsCall	WFZNEW_PSG2_p11
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_p11
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_p10
	smpsCall	WFZNEW_PSG2_p11
	smpsCall	WFZNEW_PSG2_pe
	smpsCall	WFZNEW_PSG2_p18
	smpsCall	WFZNEW_PSG2_p19
	smpsJump	WFZNEW_PSG2

WFZNEW_PSG3:
	smpsPSGform	$E7
	smpsCall	WFZNEW_PSG3_p0
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p1
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsCall	WFZNEW_PSG3_p2
	smpsJump	WFZNEW_PSG3

WFZNEW_DAC:
	smpsCall	WFZNEW_DAC_p0
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p5
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p8
	smpsCall	WFZNEW_DAC_p9
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p8
	smpsCall	WFZNEW_DAC_p9
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p14
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p1
	smpsCall	WFZNEW_DAC_p6
	smpsCall	WFZNEW_DAC_p6
	smpsJump	WFZNEW_DAC


; Pattern data for FM1
WFZNEW_FM1_p0:
	smpsFMvoice	$2
	dc.b		$90,$8
	dc.b		$9c
	dc.b		$90
	dc.b		$9c
	dc.b		$90
	dc.b		$9c
	dc.b		$90
	dc.b		$9c
	smpsReturn

WFZNEW_FM1_p9:
	dc.b		$90,$8
	dc.b		$9c
	dc.b		$90
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	smpsReturn

WFZNEW_FM1_pb:
	dc.b		$8e,$8
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	smpsReturn

WFZNEW_FM1_pd:
	dc.b		$8c,$8
	dc.b		$98
	dc.b		$8c
	dc.b		$98
	dc.b		$8c
	dc.b		$98
	dc.b		$8c
	dc.b		$98
	smpsReturn

WFZNEW_FM1_p10:
	dc.b		$90,$8
	dc.b		$9c
	dc.b		$90
	dc.b		$9c
	dc.b		$8e
	dc.b		$9a
	dc.b		$8e
	dc.b		$9a
	smpsReturn

WFZNEW_FM1_p19:
	dc.b		$8f,$8
	dc.b		$9b
	dc.b		$8f
	dc.b		$9b
	dc.b		$8f
	dc.b		$9b
	dc.b		$8f
	dc.b		$9b
	smpsReturn

; Pattern data for FM2
WFZNEW_FM2_p0:
	smpsFMvoice	$1
	dc.b		$af,$18
	dc.b		$ad,$28
	smpsReturn

WFZNEW_FM2_p1:
	dc.b		$e7,$40
	smpsReturn

WFZNEW_FM2_p2:
	smpsFMvoice	$1
	dc.b		$af,$18
	dc.b		$ab,$28
	smpsReturn

WFZNEW_FM2_p4:
	smpsFMvoice	$1
	dc.b		$af,$18
	dc.b		$ab,$20
	dc.b		$ad,$8
	smpsReturn

WFZNEW_FM2_p6:
	smpsFMvoice	$1
	dc.b		$a8,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80,$1c
	dc.b		$a3,$4
	dc.b		$80
	smpsReturn

WFZNEW_FM2_p7:
	dc.b		$e7,$8
	dc.b		$a3,$4
	dc.b		$80,$c
	dc.b		$a3,$4
	dc.b		$80,$c
	dc.b		$a3,$18
	smpsReturn

WFZNEW_FM2_p8:
	dc.b		$a8,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM2_pa:
	dc.b		$a3,$20
	dc.b		$a3
	smpsReturn

WFZNEW_FM2_pb:
	dc.b		$a6,$20
	dc.b		$a6
	smpsReturn

WFZNEW_FM2_pd:
	dc.b		$b0,$28
	dc.b		$af,$8
	dc.b		$ad
	dc.b		$ab
	smpsReturn

WFZNEW_FM2_pe:
	dc.b		$aa,$10
	dc.b		$ab,$8
	dc.b		$ad,$10
	dc.b		$aa,$18
	smpsReturn

WFZNEW_FM2_pf:
	dc.b		$af,$28
	dc.b		$ad,$8
	dc.b		$ab
	dc.b		$aa
	smpsReturn

WFZNEW_FM2_p10:
	dc.b		$a8,$10
	dc.b		$aa,$8
	dc.b		$ab,$10
	dc.b		$aa,$8
	dc.b		$a8,$10
	smpsReturn

WFZNEW_FM2_p12:
	dc.b		$aa,$10
	dc.b		$ab,$8
	dc.b		$ad,$10
	dc.b		$ab,$18
	smpsReturn

WFZNEW_FM2_p13:
	dc.b		$b2,$10
	dc.b		$b0
	dc.b		$af
	dc.b		$ad
	smpsReturn

WFZNEW_FM2_p14:
	dc.b		$ad,$18
	dc.b		$ac,$8
	dc.b		$af,$20
	smpsReturn

WFZNEW_FM2_p15:
	dc.b		$b2,$10
	dc.b		$b0,$8
	dc.b		$af,$10
	dc.b		$ad,$18
	smpsReturn

WFZNEW_FM2_p16:
	dc.b		$ad,$18
	dc.b		$ac,$28
	smpsReturn

WFZNEW_FM2_p18:
	dc.b		$b2,$30
	dc.b		$af,$8
	dc.b		$ad
	smpsReturn

WFZNEW_FM2_p19:
	dc.b		$b4,$20
	dc.b		$b3
	smpsReturn

; Pattern data for FM3
WFZNEW_FM3_p0:
	dc.b		$80,$40
	smpsReturn

WFZNEW_FM3_p1:
	dc.b		$e7,$40
	smpsReturn

WFZNEW_FM3_p6:
	smpsFMvoice	$1
	dc.b		$b4,$8
	dc.b		$b6
	dc.b		$b7,$4
	dc.b		$80
	dc.b		$b7
	dc.b		$80,$1c
	dc.b		$b9,$4
	dc.b		$80
	smpsReturn

WFZNEW_FM3_p7:
	dc.b		$e7,$8
	dc.b		$b7,$4
	dc.b		$80,$c
	dc.b		$b6,$4
	dc.b		$80,$c
	dc.b		$af,$18
	smpsReturn

WFZNEW_FM3_p8:
	dc.b		$b4,$8
	dc.b		$b6
	dc.b		$b7,$4
	dc.b		$80
	dc.b		$b7
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM3_pa:
	dc.b		$b4,$20
	dc.b		$b4
	smpsReturn

WFZNEW_FM3_pb:
	dc.b		$b9,$20
	dc.b		$b7
	smpsReturn

WFZNEW_FM3_pc:
	dc.b		$b9,$20
	dc.b		$b9
	smpsReturn

WFZNEW_FM3_pd:
	smpsFMvoice	$3
	dc.b		$b0,$28
	dc.b		$af,$8
	dc.b		$ad
	dc.b		$ab
	smpsReturn

WFZNEW_FM3_pe:
	dc.b		$aa,$10
	dc.b		$ab,$8
	dc.b		$ad,$10
	dc.b		$aa,$18
	smpsReturn

WFZNEW_FM3_pf:
	dc.b		$af,$28
	dc.b		$ad,$8
	dc.b		$ab
	dc.b		$aa
	smpsReturn

WFZNEW_FM3_p10:
	dc.b		$a8,$10
	dc.b		$aa,$8
	dc.b		$ab,$10
	dc.b		$aa,$8
	dc.b		$a8,$10
	smpsReturn

WFZNEW_FM3_p12:
	dc.b		$aa,$10
	dc.b		$ab,$8
	dc.b		$ad,$10
	dc.b		$ab,$18
	smpsReturn

WFZNEW_FM3_p13:
	dc.b		$b2,$10
	dc.b		$b0
	dc.b		$af
	dc.b		$ad
	smpsReturn

WFZNEW_FM3_p14:
	dc.b		$ad,$18
	dc.b		$ac,$8
	dc.b		$af,$20
	smpsReturn

WFZNEW_FM3_p15:
	dc.b		$b2,$10
	dc.b		$b0,$8
	dc.b		$af,$10
	dc.b		$ad,$18
	smpsReturn

WFZNEW_FM3_p16:
	dc.b		$ad,$18
	dc.b		$ac,$28
	smpsReturn

WFZNEW_FM3_p17:
	dc.b		$af,$18
	dc.b		$ad,$28
	smpsReturn

WFZNEW_FM3_p18:
	dc.b		$b2,$30
	dc.b		$af,$8
	dc.b		$ad
	smpsReturn

WFZNEW_FM3_p19:
	dc.b		$b4,$20
	dc.b		$b3
	smpsReturn

; Pattern data for FM4
WFZNEW_FM4_p0:
	smpsFMvoice	$1
	dc.b		$b4,$18
	dc.b		$b2,$28
	smpsReturn

WFZNEW_FM4_p1:
	dc.b		$e7,$40
	smpsReturn

WFZNEW_FM4_p2:
	smpsFMvoice	$1
	dc.b		$b4,$18
	dc.b		$b0,$28
	smpsReturn

WFZNEW_FM4_p4:
	smpsFMvoice	$1
	dc.b		$b4,$18
	dc.b		$b0,$20
	dc.b		$b2,$8
	smpsReturn

WFZNEW_FM4_p6:
	smpsFMvoice	$1
	dc.b		$a3,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a3
	dc.b		$80,$1c
	dc.b		$a8,$4
	dc.b		$80
	smpsReturn

WFZNEW_FM4_p7:
	dc.b		$e7,$8
	dc.b		$a8,$4
	dc.b		$80,$c
	dc.b		$a8,$4
	dc.b		$80,$c
	dc.b		$a8,$18
	smpsReturn

WFZNEW_FM4_p8:
	dc.b		$a3,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a3
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_pa:
	dc.b		$a8,$20
	dc.b		$aa
	smpsReturn

WFZNEW_FM4_pb:
	dc.b		$ad,$20
	dc.b		$ab
	smpsReturn

WFZNEW_FM4_pd:
	smpsFMvoice	$4
	dc.b		$cc,$4
	dc.b		$80
	dc.b		$c3
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_pe:
	dc.b		$c5,$4
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c5
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_pf:
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c7
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_p10:
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c0
	dc.b		$80,$c
	dc.b		$c0,$4
	dc.b		$80
	dc.b		$be
	dc.b		$80
	dc.b		$be
	dc.b		$80
	smpsReturn

WFZNEW_FM4_p11:
	dc.b		$c8,$4
	dc.b		$80
	dc.b		$c3
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_p18:
	dc.b		$c5,$4
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$b9
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM4_p19:
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c2
	dc.b		$80
	dc.b		$c2
	dc.b		$80
	dc.b		$bf
	dc.b		$80,$24
	smpsReturn

; Pattern data for FM5
WFZNEW_FM5_p0:
	dc.b		$80,$40
	smpsReturn

WFZNEW_FM5_p1:
	dc.b		$e7,$40
	smpsReturn

WFZNEW_FM5_p6:
	smpsFMvoice	$1
	dc.b		$af,$10
	dc.b		$4
	dc.b		$80
	dc.b		$af
	dc.b		$80,$1c
	dc.b		$af,$4
	dc.b		$80
	smpsReturn

WFZNEW_FM5_p7:
	dc.b		$e7,$8
	dc.b		$af,$4
	dc.b		$80,$c
	dc.b		$af,$4
	dc.b		$80,$c
	dc.b		$b4,$18
	smpsReturn

WFZNEW_FM5_p8:
	dc.b		$af,$10
	dc.b		$4
	dc.b		$80
	dc.b		$af
	dc.b		$80,$24
	smpsReturn

WFZNEW_FM5_pa:
	dc.b		$bb,$20
	dc.b		$b9
	smpsReturn

WFZNEW_FM5_pb:
	dc.b		$b2,$20
	dc.b		$b2
	smpsReturn

WFZNEW_FM5_pc:
	dc.b		$be,$20
	dc.b		$bd
	smpsReturn

WFZNEW_FM5_pd:
	dc.b		$98,$8
	dc.b		$98
	dc.b		$98
	dc.b		$98
	dc.b		$98
	dc.b		$98
	dc.b		$98
	dc.b		$98
	smpsReturn

WFZNEW_FM5_pe:
	dc.b		$9a,$8
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	smpsReturn

WFZNEW_FM5_pf:
	dc.b		$9c,$8
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	smpsReturn

WFZNEW_FM5_p10:
	dc.b		$9c,$8
	dc.b		$9c
	dc.b		$9c
	dc.b		$9c
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	dc.b		$9a
	smpsReturn

WFZNEW_FM5_p19:
	dc.b		$9b,$8
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b
	smpsReturn

; Pattern data for PSG1
WFZNEW_PSG1_p0:
	smpsPSGvoice	$0
	dc.b		$c0,$4
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	smpsReturn

WFZNEW_PSG1_p1:
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	smpsReturn

WFZNEW_PSG1_p2:
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	smpsReturn

WFZNEW_PSG1_p6:
	dc.b		$80,$40
	smpsReturn

; Pattern data for PSG2
WFZNEW_PSG2_p0:
	smpsPSGvoice	$0
	dc.b		$c7,$4
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	smpsReturn

WFZNEW_PSG2_p1:
	dc.b		$c0,$4
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	smpsReturn

WFZNEW_PSG2_p2:
	dc.b		$c0,$4
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$bb
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	dc.b		$c0
	dc.b		$80
	smpsReturn

WFZNEW_PSG2_p6:
	smpsPSGvoice	$0
	dc.b		$80,$40
	smpsReturn

WFZNEW_PSG2_p7:
	dc.b		$e7,$40
	smpsReturn

WFZNEW_PSG2_p9:
	dc.b		$e7,$18
	dc.b		$80,$28
	smpsReturn

WFZNEW_PSG2_pb:
	dc.b		$80,$40
	smpsReturn

WFZNEW_PSG2_pd:
	dc.b		$c8,$4
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$cc
	dc.b		$80
	dc.b		$cc
	dc.b		$80,$24
	smpsReturn

WFZNEW_PSG2_pe:
	dc.b		$cc,$4
	dc.b		$80
	dc.b		$cc
	dc.b		$80
	dc.b		$ca
	dc.b		$80
	dc.b		$cc
	dc.b		$80,$24
	smpsReturn

WFZNEW_PSG2_p10:
	dc.b		$cc,$4
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$cc
	dc.b		$80
	dc.b		$c7
	dc.b		$80,$c
	dc.b		$c5,$4
	dc.b		$80
	dc.b		$c3
	dc.b		$80
	dc.b		$c2
	dc.b		$80
	smpsReturn

WFZNEW_PSG2_p11:
	dc.b		$cc,$4
	dc.b		$80
	dc.b		$c8
	dc.b		$80
	dc.b		$cc
	dc.b		$80
	dc.b		$cc
	dc.b		$80,$24
	smpsReturn

WFZNEW_PSG2_p18:
	dc.b		$ca,$4
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c0
	dc.b		$80,$24
	smpsReturn

WFZNEW_PSG2_p19:
	dc.b		$cb,$4
	dc.b		$80
	dc.b		$c5
	dc.b		$80
	dc.b		$c7
	dc.b		$80
	dc.b		$c2
	dc.b		$80,$24
	smpsReturn

; Pattern data for PSG3 (Noise)
WFZNEW_PSG3_p0:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	smpsReturn

WFZNEW_PSG3_p1:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	smpsReturn

WFZNEW_PSG3_p2:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	dc.b		$82
	dc.b		$80,$6
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	smpsReturn

; Pattern data for DAC
WFZNEW_DAC_p0:
	dc.b		$8f,$10
	dc.b		$95
	dc.b		$81
	dc.b		$95
	smpsReturn

WFZNEW_DAC_p1:
	dc.b		$81,$10
	dc.b		$95
	dc.b		$81
	dc.b		$95
	smpsReturn

WFZNEW_DAC_p5:
	dc.b		$81,$10
	dc.b		$95
	dc.b		$81,$8
	dc.b		$8f
	dc.b		$95,$10
	smpsReturn

WFZNEW_DAC_p6:
	dc.b		$8f,$10
	dc.b		$95
	dc.b		$81
	dc.b		$95
	smpsReturn

WFZNEW_DAC_p8:
	dc.b		$81,$10
	dc.b		$95
	dc.b		$81
	dc.b		$95,$8
	dc.b		$8f
	smpsReturn

WFZNEW_DAC_p9:
	dc.b		$81,$10
	dc.b		$95,$8
	dc.b		$8f
	dc.b		$81,$10
	dc.b		$95
	smpsReturn

WFZNEW_DAC_p14:
	dc.b		$8f,$10
	dc.b		$95
	dc.b		$8f
	dc.b		$95
	smpsReturn

WFZNEW_Voices:
	dc.b	$20,$36,$35,$30,$31,$df,$df,$9f,$9f,$7,$6,$9,$6,$7,$6,$6
	dc.b	$8,$20,$10,$10,$f8,$19,$37,$13,$80	; Voice 0 (Oerg-Bass)
	dc.b	$38,$33,$1,$51,$1,$10,$13,$1a,$1b,$f,$1f,$1f,$1f,$1,$1,$1
	dc.b	$1,$33,$3,$3,$8,$16,$1a,$19,$80	; Voice 1 (DangerousSeed-Jupiter-A:FM2 Distortion Synth 2 (Mod $1E, $01, $05, $05))
	dc.b	$3c,$1,$0,$0,$0,$1f,$1f,$15,$1f,$11,$d,$12,$5,$7,$4,$9
	dc.b	$2,$55,$3a,$25,$1a,$1a,$80,$7,$80	; Voice 2 (Synth Bass 2 )
	dc.b	$3d,$1,$2,$2,$2,$10,$50,$50,$50,$7,$8,$8,$8,$1,$0,$0
	dc.b	$0,$20,$17,$17,$17,$1c,$88,$88,$88	; Voice 3 (Puto-Sawtooth)
	dc.b	$3a,$1,$7,$31,$71,$8e,$8e,$8d,$53,$e,$e,$e,$3,$0,$0,$0
	dc.b	$7,$1f,$ff,$1f,$f,$18,$28,$27,$80	; Voice 4 (Synth Brass 1 )
	even
