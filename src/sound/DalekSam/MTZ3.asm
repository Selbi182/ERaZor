; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Tue Sep 15 2009, 12:18:11
; -------------------------------------------------------

MTZ_Header:
	smpsHeaderVoice	MTZ_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$1, $3
	smpsHeaderDAC	MTZ_DAC
	smpsHeaderFM	MTZ_FM1,	$c, $10
	smpsHeaderFM	MTZ_FM2,	$0, $a
	smpsHeaderFM	MTZ_FM3,	$0, $10
	smpsHeaderFM	MTZ_FM4,	$e8, $1a
	smpsHeaderFM	MTZ_FM5,	$e8, $1a
	smpsHeaderPSG	MTZ_PSG1,	$dc, $3, $0
	smpsHeaderPSG	MTZ_PSG2,	$dc, $1, $0
	smpsHeaderPSG	MTZ_PSG3,	$dc, $2, $0

MTZ_FM1:
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p1
	smpsCall	MTZ_FM1_p2
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p1
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p1
	smpsCall	MTZ_FM1_p6
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_pe
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_pe
	smpsCall	MTZ_FM1_p10
	smpsCall	MTZ_FM1_pe
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p13
	smpsCall	MTZ_FM1_p14
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p1
	smpsCall	MTZ_FM1_p17
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p0
	smpsCall	MTZ_FM1_p1
	smpsCall	MTZ_FM1_p2
	smpsCall	MTZ_FM1_p0
	smpsJump	MTZ_FM1

MTZ_FM2:
	smpsCall	MTZ_FM2_p0
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_p4
	smpsCall	MTZ_FM2_p5
	smpsCall	MTZ_FM2_p6
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_p8
	smpsCall	MTZ_FM2_p9
	smpsCall	MTZ_FM2_pa
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_pc
	smpsCall	MTZ_FM2_p5
	smpsCall	MTZ_FM2_p6
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_p8
	smpsCall	MTZ_FM2_p9
	smpsCall	MTZ_FM2_pa
	smpsCall	MTZ_FM2_p1
	smpsCall	MTZ_FM2_pe
	smpsCall	MTZ_FM2_pf
	smpsCall	MTZ_FM2_pe
	smpsCall	MTZ_FM2_p10
	smpsCall	MTZ_FM2_p11
	smpsCall	MTZ_FM2_p12
	smpsCall	MTZ_FM2_p13
	smpsCall	MTZ_FM2_p14
	smpsCall	MTZ_FM2_p15
	smpsCall	MTZ_FM2_p16
	smpsCall	MTZ_FM2_p17
	smpsCall	MTZ_FM2_p18
	smpsCall	MTZ_FM2_p15
	smpsCall	MTZ_FM2_p16
	smpsCall	MTZ_FM2_p1b
	smpsCall	MTZ_FM2_p1c
	smpsJump	MTZ_FM2

MTZ_FM3:
	smpsCall	MTZ_FM3_p0
	smpsCall	MTZ_FM3_p1
	smpsCall	MTZ_FM3_p1
	smpsCall	MTZ_FM3_p3
	smpsCall	MTZ_FM3_p4
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_p5
	smpsCall	MTZ_FM3_pd
	smpsCall	MTZ_FM3_pe
	smpsCall	MTZ_FM3_pf
	smpsCall	MTZ_FM3_pe
	smpsCall	MTZ_FM3_pe
	smpsCall	MTZ_FM3_pe
	smpsCall	MTZ_FM3_pf
	smpsCall	MTZ_FM3_p13
	smpsCall	MTZ_FM3_p14
	smpsCall	MTZ_FM3_p0
	smpsCall	MTZ_FM3_p16
	smpsCall	MTZ_FM3_p0
	smpsCall	MTZ_FM3_p16
	smpsCall	MTZ_FM3_p0
	smpsCall	MTZ_FM3_p16
	smpsCall	MTZ_FM3_p0
	smpsCall	MTZ_FM3_p16
	smpsJump	MTZ_FM3

MTZ_FM4:
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p2
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_p6
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p6
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_p6
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p6
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p5
	smpsCall	MTZ_FM4_pe
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_pe
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_pe
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p13
	smpsCall	MTZ_FM4_p14
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_pe
	smpsCall	MTZ_FM4_p2
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_p0
	smpsCall	MTZ_FM4_pe
	smpsCall	MTZ_FM4_p2
	smpsCall	MTZ_FM4_p0
	smpsJump	MTZ_FM4

MTZ_FM5:
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p1
	smpsCall	MTZ_FM5_p2
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_p6
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_p1
	smpsCall	MTZ_FM5_p6
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_p6
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_p1
	smpsCall	MTZ_FM5_p6
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p5
	smpsCall	MTZ_FM5_pe
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_pe
	smpsCall	MTZ_FM5_p1
	smpsCall	MTZ_FM5_pe
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p13
	smpsCall	MTZ_FM5_p14
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p16
	smpsCall	MTZ_FM5_p2
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p0
	smpsCall	MTZ_FM5_p16
	smpsCall	MTZ_FM5_p2
	smpsCall	MTZ_FM5_p0
	smpsJump	MTZ_FM5

MTZ_PSG1:
	smpsCall	MTZ_PSG1_p0
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_p4
	smpsCall	MTZ_PSG1_p5
	smpsCall	MTZ_PSG1_p6
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_p8
	smpsCall	MTZ_PSG1_p9
	smpsCall	MTZ_PSG1_pa
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_pc
	smpsCall	MTZ_PSG1_p5
	smpsCall	MTZ_PSG1_p6
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_p8
	smpsCall	MTZ_PSG1_p9
	smpsCall	MTZ_PSG1_pa
	smpsCall	MTZ_PSG1_p1
	smpsCall	MTZ_PSG1_pe
	smpsCall	MTZ_PSG1_pf
	smpsCall	MTZ_PSG1_pe
	smpsCall	MTZ_PSG1_p10
	smpsCall	MTZ_PSG1_p11
	smpsCall	MTZ_PSG1_p12
	smpsCall	MTZ_PSG1_p13
	smpsCall	MTZ_PSG1_p14
	smpsCall	MTZ_PSG1_p15
	smpsCall	MTZ_PSG1_p16
	smpsCall	MTZ_PSG1_p17
	smpsCall	MTZ_PSG1_p18
	smpsCall	MTZ_PSG1_p19
	smpsCall	MTZ_PSG1_p16
	smpsCall	MTZ_PSG1_p1b
	smpsCall	MTZ_PSG1_p1c
	smpsJump	MTZ_PSG1

MTZ_PSG2:
	smpsCall	MTZ_PSG2_p0
	smpsCall	MTZ_PSG2_p1
	smpsCall	MTZ_PSG2_p2
	smpsCall	MTZ_PSG2_p3
	smpsCall	MTZ_PSG2_p4
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p5
	smpsCall	MTZ_PSG2_p17
	smpsCall	MTZ_PSG2_p18
	smpsCall	MTZ_PSG2_p19
	smpsCall	MTZ_PSG2_p1a
	smpsCall	MTZ_PSG2_p1b
	smpsCall	MTZ_PSG2_p1c
	smpsJump	MTZ_PSG2

MTZ_PSG3:
	smpsPSGform	$E7
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsCall	MTZ_PSG3_p0
	smpsJump	MTZ_PSG3

MTZ_DAC:
	smpsCall	MTZ_DAC_p0
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p3
	smpsCall	MTZ_DAC_p4
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p3
	smpsCall	MTZ_DAC_p4
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p3
	smpsCall	MTZ_DAC_p4
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p3
	smpsCall	MTZ_DAC_p4
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p1
	smpsCall	MTZ_DAC_p3
	smpsJump	MTZ_DAC


; Pattern data for FM1
MTZ_FM1_p0:
	smpsFMvoice	$0
	dc.b		$93,$4
	dc.b		$93
	dc.b		$93
	dc.b		$80
	dc.b		$9a,$8
	dc.b		$96,$4
	dc.b		$93
	dc.b		$80
	dc.b		$93
	dc.b		$9a,$8
	dc.b		$93
	dc.b		$96
	smpsReturn

MTZ_FM1_p1:
	dc.b		$9b,$4
	dc.b		$9b
	dc.b		$96
	dc.b		$80
	dc.b		$9b,$8
	dc.b		$96
	dc.b		$9b,$4
	dc.b		$96
	dc.b		$80
	dc.b		$96
	dc.b		$9b,$8
	dc.b		$96
	smpsReturn

MTZ_FM1_p2:
	dc.b		$98,$4
	dc.b		$98
	dc.b		$93
	dc.b		$80
	dc.b		$98,$8
	dc.b		$93,$4
	dc.b		$95
	dc.b		$80
	dc.b		$95
	dc.b		$91,$8
	dc.b		$95
	dc.b		$91
	smpsReturn

MTZ_FM1_p6:
	dc.b		$91,$4
	dc.b		$91
	dc.b		$91
	dc.b		$80
	dc.b		$98,$8
	dc.b		$95,$4
	dc.b		$91
	dc.b		$80
	dc.b		$91
	dc.b		$98,$8
	dc.b		$91
	dc.b		$95
	smpsReturn

MTZ_FM1_pe:
	dc.b		$94,$4
	dc.b		$94
	dc.b		$94
	dc.b		$80
	dc.b		$9b,$8
	dc.b		$94,$4
	dc.b		$94
	dc.b		$80
	dc.b		$94
	dc.b		$9b,$8
	dc.b		$94
	dc.b		$94
	smpsReturn

MTZ_FM1_p10:
	dc.b		$98,$4
	dc.b		$98
	dc.b		$93
	dc.b		$80
	dc.b		$98,$8
	dc.b		$93,$4
	dc.b		$98
	dc.b		$80
	dc.b		$93
	dc.b		$98,$8
	dc.b		$98
	dc.b		$93,$4
	dc.b		$98
	smpsReturn

MTZ_FM1_p13:
	dc.b		$94,$4
	dc.b		$94
	dc.b		$94
	dc.b		$80
	dc.b		$9b,$8
	dc.b		$94,$4
	dc.b		$94
	dc.b		$95
	dc.b		$95
	dc.b		$95
	dc.b		$80
	dc.b		$95,$8
	dc.b		$4
	dc.b		$95
	smpsReturn

MTZ_FM1_p14:
	dc.b		$96,$4
	dc.b		$96
	dc.b		$96
	dc.b		$80
	dc.b		$96,$8
	dc.b		$4
	dc.b		$96
	dc.b		$97
	dc.b		$97
	dc.b		$97
	dc.b		$80
	dc.b		$97,$8
	dc.b		$4
	dc.b		$97
	smpsReturn

MTZ_FM1_p17:
	dc.b		$98,$4
	dc.b		$98
	dc.b		$93
	dc.b		$80
	dc.b		$98,$8
	dc.b		$93,$4
	dc.b		$95,$8
	dc.b		$4
	dc.b		$91,$8
	dc.b		$95
	dc.b		$91
	smpsReturn

; Pattern data for FM2
MTZ_FM2_p0:
	smpsModSet	$02,	$03,	$01,	$04
	dc.b		$80,$40
	smpsReturn

MTZ_FM2_p1:
	dc.b		$e7,$40
	smpsReturn

MTZ_FM2_p4:
	dc.b		$e7,$10
	smpsFMvoice	$2
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$bc,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_FM2_p5:
	dc.b		$ba,$10
	dc.b		$bc,$8
	dc.b		$ba,$10
	dc.b		$b9,$8
	dc.b		$ba,$10
	smpsReturn

MTZ_FM2_p6:
	dc.b		$b9,$40
	smpsReturn

MTZ_FM2_p8:
	dc.b		$80,$8
	smpsFMvoice	$2
	dc.b		$b3
	dc.b		$b5
	dc.b		$b7
	dc.b		$b9
	dc.b		$ba,$10
	dc.b		$b7,$8
	smpsReturn

MTZ_FM2_p9:
	dc.b		$e7,$8
	dc.b		$b3
	dc.b		$b5
	dc.b		$b7
	dc.b		$b9
	dc.b		$ba,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_FM2_pa:
	dc.b		$e7,$10
	dc.b		$ba,$8
	dc.b		$b7,$28
	smpsReturn

MTZ_FM2_pc:
	dc.b		$80,$10
	smpsFMvoice	$2
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$bc,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_FM2_pe:
	dc.b		$80,$10
	smpsFMvoice	$2
	dc.b		$c3
	dc.b		$c1
	dc.b		$bf
	smpsReturn

MTZ_FM2_pf:
	dc.b		$be,$18
	dc.b		$b7,$28
	smpsReturn

MTZ_FM2_p10:
	dc.b		$c3,$20
	dc.b		$bc,$c
	dc.b		$be
	dc.b		$bf,$8
	smpsReturn

MTZ_FM2_p11:
	dc.b		$bf,$18
	dc.b		$bf
	dc.b		$c1,$8
	dc.b		$bf
	smpsReturn

MTZ_FM2_p12:
	dc.b		$be,$20
	dc.b		$c
	dc.b		$bf
	dc.b		$be,$8
	smpsReturn

MTZ_FM2_p13:
	dc.b		$bf,$20
	dc.b		$c0
	smpsReturn

MTZ_FM2_p14:
	dc.b		$c1,$20
	dc.b		$c6
	smpsReturn

MTZ_FM2_p15:
	dc.b		$80,$8
	dc.b		$be
	dc.b		$ba
	dc.b		$80
	dc.b		$b7
	dc.b		$ba
	dc.b		$80
	dc.b		$bc
	smpsReturn

MTZ_FM2_p16:
	dc.b		$be,$8
	dc.b		$80
	dc.b		$be
	dc.b		$80
	dc.b		$bc
	dc.b		$ba
	dc.b		$b5
	dc.b		$b7
	smpsReturn

MTZ_FM2_p17:
	dc.b		$80,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$80,$20
	dc.b		$b9,$8
	smpsReturn

MTZ_FM2_p18:
	dc.b		$ba,$8
	dc.b		$80,$18
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$b7
	smpsReturn

MTZ_FM2_p1b:
	dc.b		$80,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$80
	dc.b		$b0
	dc.b		$b2
	dc.b		$80
	dc.b		$b5
	smpsReturn

MTZ_FM2_p1c:
	dc.b		$b7,$8
	dc.b		$80
	dc.b		$bc
	dc.b		$ba
	dc.b		$be
	dc.b		$bc
	dc.b		$ba
	dc.b		$b7
	smpsReturn

; Pattern data for FM3
MTZ_FM3_p0:
	smpsFMvoice	$3
	dc.b		$ae,$4
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	smpsReturn

MTZ_FM3_p1:
	dc.b		$ab,$4
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	smpsReturn

MTZ_FM3_p3:
	dc.b		$ab,$4
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$b2
	dc.b		$b0
	dc.b		$ae
	dc.b		$b0
	dc.b		$ae
	dc.b		$ab
	dc.b		$a9
	smpsReturn

MTZ_FM3_p4:
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$ae,$8
	dc.b		$ab,$4
	dc.b		$ae
	dc.b		$b2
	dc.b		$ae
	dc.b		$80
	dc.b		$b2
	dc.b		$ab
	dc.b		$ae
	dc.b		$b2
	dc.b		$ab
	dc.b		$ae
	smpsReturn

MTZ_FM3_p5:
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$b2
	dc.b		$ae
	dc.b		$80
	dc.b		$b2
	dc.b		$ab
	dc.b		$ae
	dc.b		$b2
	dc.b		$ab
	dc.b		$ae
	smpsReturn

MTZ_FM3_pd:
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$b2
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$b0
	dc.b		$b2
	dc.b		$b3
	dc.b		$b5
	dc.b		$b7
	smpsReturn

MTZ_FM3_pe:
	dc.b		$ab,$4
	dc.b		$ab
	dc.b		$a7
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$a7
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$a7
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	smpsReturn

MTZ_FM3_pf:
	dc.b		$a9,$4
	dc.b		$a9
	dc.b		$a6
	dc.b		$80
	dc.b		$a9
	dc.b		$80
	dc.b		$a6
	dc.b		$a9
	dc.b		$80
	dc.b		$a9
	dc.b		$a6
	dc.b		$80
	dc.b		$a9
	dc.b		$80
	dc.b		$a6
	dc.b		$80
	smpsReturn

MTZ_FM3_p13:
	dc.b		$a4,$4
	dc.b		$80
	dc.b		$a4
	dc.b		$a4
	dc.b		$80
	dc.b		$a4
	dc.b		$a4
	dc.b		$80
	dc.b		$a5
	dc.b		$80
	dc.b		$a5
	dc.b		$a5
	dc.b		$80
	dc.b		$a5
	dc.b		$a5
	dc.b		$80
	smpsReturn

MTZ_FM3_p14:
	dc.b		$a6,$4
	dc.b		$80
	dc.b		$a6
	dc.b		$a6
	dc.b		$80
	dc.b		$a6
	dc.b		$a6
	dc.b		$80
	dc.b		$a9
	dc.b		$80
	dc.b		$a9
	dc.b		$a9
	dc.b		$80
	dc.b		$a9
	dc.b		$a9
	dc.b		$80
	smpsReturn

MTZ_FM3_p16:
	dc.b		$ae,$4
	dc.b		$ae
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$ae
	dc.b		$80
	dc.b		$b2
	dc.b		$b0
	dc.b		$ae
	dc.b		$b0
	dc.b		$ae
	dc.b		$ab
	dc.b		$a9
	smpsReturn

; Pattern data for FM4
MTZ_FM4_p0:
	smpsFMvoice	$1
	dc.b		$b7,$40
	smpsReturn

MTZ_FM4_p2:
	dc.b		$b7,$20
	dc.b		$b0
	smpsReturn

MTZ_FM4_p5:
	dc.b		$e7,$40
	smpsReturn

MTZ_FM4_p6:
	smpsFMvoice	$1
	dc.b		$b0,$40
	smpsReturn

MTZ_FM4_pe:
	smpsFMvoice	$1
	dc.b		$b3,$40
	smpsReturn

MTZ_FM4_p13:
	dc.b		$b3,$20
	dc.b		$b4
	smpsReturn

MTZ_FM4_p14:
	dc.b		$b5,$20
	dc.b		$b5
	smpsReturn

; Pattern data for FM5
MTZ_FM5_p0:
	smpsFMvoice	$1
	dc.b		$b2,$40
	smpsReturn

MTZ_FM5_p1:
	smpsFMvoice	$1
	dc.b		$b3,$40
	smpsReturn

MTZ_FM5_p2:
	dc.b		$b3,$20
	dc.b		$b5
	smpsReturn

MTZ_FM5_p5:
	dc.b		$e7,$40
	smpsReturn

MTZ_FM5_p6:
	smpsFMvoice	$1
	dc.b		$b5,$40
	smpsReturn

MTZ_FM5_pe:
	smpsFMvoice	$1
	dc.b		$b8,$40
	smpsReturn

MTZ_FM5_p13:
	dc.b		$b8,$20
	dc.b		$b9
	smpsReturn

MTZ_FM5_p14:
	dc.b		$ba,$20
	dc.b		$bb
	smpsReturn

MTZ_FM5_p16:
	dc.b		$b7,$40
	smpsReturn

; Pattern data for PSG1
MTZ_PSG1_p0:
	dc.b		$80,$40
	smpsReturn

MTZ_PSG1_p1:
	dc.b		$e7,$40
	smpsReturn

MTZ_PSG1_p4:
	dc.b		$e7,$10
	smpsPSGvoice	$0
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$bc,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_PSG1_p5:
	dc.b		$ba,$10
	dc.b		$bc,$8
	dc.b		$ba,$10
	dc.b		$b9,$8
	dc.b		$ba,$10
	smpsReturn

MTZ_PSG1_p6:
	dc.b		$b9,$40
	smpsReturn

MTZ_PSG1_p8:
	dc.b		$80,$8
	smpsPSGvoice	$0
	dc.b		$b3
	dc.b		$b5
	dc.b		$b7
	dc.b		$b9
	dc.b		$ba,$10
	dc.b		$b7,$8
	smpsReturn

MTZ_PSG1_p9:
	dc.b		$e7,$8
	dc.b		$b3
	dc.b		$b5
	dc.b		$b7
	dc.b		$b9
	dc.b		$ba,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_PSG1_pa:
	dc.b		$e7,$10
	dc.b		$ba,$8
	dc.b		$b7,$28
	smpsReturn

MTZ_PSG1_pc:
	dc.b		$80,$10
	smpsPSGvoice	$0
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$bc,$10
	dc.b		$b9,$8
	smpsReturn

MTZ_PSG1_pe:
	dc.b		$80,$10
	smpsPSGvoice	$0
	dc.b		$c3
	dc.b		$c1
	dc.b		$bf
	smpsReturn

MTZ_PSG1_pf:
	dc.b		$be,$18
	dc.b		$b7,$28
	smpsReturn

MTZ_PSG1_p10:
	dc.b		$c3,$20
	dc.b		$bc,$c
	dc.b		$be
	dc.b		$bf,$8
	smpsReturn

MTZ_PSG1_p11:
	dc.b		$bf,$18
	dc.b		$bf
	dc.b		$c1,$8
	dc.b		$bf
	smpsReturn

MTZ_PSG1_p12:
	dc.b		$be,$20
	dc.b		$c
	dc.b		$bf
	dc.b		$be,$8
	smpsReturn

MTZ_PSG1_p13:
	dc.b		$bf,$20
	dc.b		$c0
	smpsReturn

MTZ_PSG1_p14:
	dc.b		$c1,$20
	dc.b		$c6
	smpsReturn

MTZ_PSG1_p15:
	dc.b		$80,$8
	dc.b		$be
	dc.b		$ba
	dc.b		$80
	dc.b		$b7
	dc.b		$ba
	dc.b		$80
	dc.b		$bc
	smpsReturn

MTZ_PSG1_p16:
	dc.b		$be,$8
	dc.b		$80
	dc.b		$be
	dc.b		$80
	dc.b		$bc
	dc.b		$ba
	dc.b		$b5
	dc.b		$b7
	smpsReturn

MTZ_PSG1_p17:
	dc.b		$80,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$80,$20
	dc.b		$b9,$8
	smpsReturn

MTZ_PSG1_p18:
	dc.b		$ba,$8
	dc.b		$80,$18
	dc.b		$be,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$b7
	smpsReturn

MTZ_PSG1_p19:
	dc.b		$e7,$8
	dc.b		$be
	dc.b		$ba
	dc.b		$80
	dc.b		$b7
	dc.b		$ba
	dc.b		$80
	dc.b		$bc
	smpsReturn

MTZ_PSG1_p1b:
	dc.b		$80,$8
	dc.b		$bc
	dc.b		$ba
	dc.b		$80
	dc.b		$b0
	dc.b		$b2
	dc.b		$80
	dc.b		$b5
	smpsReturn

MTZ_PSG1_p1c:
	dc.b		$b7,$8
	dc.b		$80
	dc.b		$bc
	dc.b		$ba
	dc.b		$be
	dc.b		$bc
	dc.b		$ba
	dc.b		$b7
	smpsReturn

; Pattern data for PSG2
MTZ_PSG2_p0:
	smpsPSGvoice	$0
	dc.b		$b2,$40
	smpsReturn

MTZ_PSG2_p1:
	dc.b		$bc,$10
	dc.b		$ba
	dc.b		$b9
	dc.b		$ba
	smpsReturn

MTZ_PSG2_p2:
	dc.b		$b9,$20
	dc.b		$b2,$10
	dc.b		$b5
	smpsReturn

MTZ_PSG2_p3:
	dc.b		$b7,$40
	smpsReturn

MTZ_PSG2_p4:
	dc.b		$80,$40
	smpsReturn

MTZ_PSG2_p5:
	dc.b		$e7,$40
	smpsReturn

MTZ_PSG2_p17:
	dc.b		$e7,$20
	smpsPSGvoice	$0
	dc.b		$ab,$8
	dc.b		$ae
	dc.b		$80,$10
	smpsReturn

MTZ_PSG2_p18:
	dc.b		$e7,$10
	dc.b		$b0,$8
	dc.b		$ae
	dc.b		$80,$20
	smpsReturn

MTZ_PSG2_p19:
	dc.b		$80,$8
	dc.b		$ba
	dc.b		$b7
	dc.b		$80
	dc.b		$b2
	dc.b		$b7
	dc.b		$80
	dc.b		$b9
	smpsReturn

MTZ_PSG2_p1a:
	dc.b		$ba,$8
	dc.b		$80
	dc.b		$ba
	dc.b		$80
	dc.b		$b9
	dc.b		$b7
	dc.b		$b5
	dc.b		$b7
	smpsReturn

MTZ_PSG2_p1b:
	dc.b		$80,$8
	dc.b		$ba
	dc.b		$b7
	dc.b		$80
	dc.b		$b0
	dc.b		$b2
	dc.b		$80
	dc.b		$b5
	smpsReturn

MTZ_PSG2_p1c:
	dc.b		$b7,$8
	dc.b		$80
	dc.b		$bc
	dc.b		$ba
	dc.b		$ba
	dc.b		$b9
	dc.b		$b7
	dc.b		$b2
	smpsReturn

; Pattern data for PSG3 (Noise)
MTZ_PSG3_p0:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	dc.b		$82
	dc.b		$80
	smpsReturn

; Pattern data for DAC
MTZ_DAC_p0:
	dc.b		$81,$8
	dc.b		$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$7
	smpsReturn

MTZ_DAC_p1:
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$7
	smpsReturn

MTZ_DAC_p3:
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$82
	dc.b		$81,$1
	dc.b		$80,$3
	smpsReturn

MTZ_DAC_p4:
	dc.b		$81,$8
	dc.b		$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$81,$1
	dc.b		$80,$3
	dc.b		$81,$1
	dc.b		$80,$7
	dc.b		$82,$4
	dc.b		$80
	dc.b		$81,$1
	dc.b		$80,$7
	smpsReturn

MTZ_Voices:
	dc.b	$20,$36,$35,$30,$31,$df,$df,$9f,$9f,$7,$6,$9,$6,$7,$6,$6
	dc.b	$8,$20,$10,$10,$f8,$19,$37,$13,$80	; Voice 0 (Oerg-Bass)
	dc.b	$2c,$74,$74,$34,$34,$1f,$12,$1f,$1f,$0,$0,$0,$0,$0,$1,$0
	dc.b	$1,$f,$3f,$f,$3f,$16,$80,$17,$80	; Voice 1 (Puto-String(set volume and pitch to 24/-24))
	dc.b	$3d,$1,$2,$2,$2,$10,$50,$50,$50,$7,$8,$8,$8,$1,$0,$0
	dc.b	$0,$20,$17,$17,$17,$1c,$88,$88,$88	; Voice 2 (Puto-Sawtooth)
	dc.b	$20,$7a,$31,$0,$0,$9f,$d8,$dc,$df,$10,$a,$4,$4,$f,$8,$8
	dc.b	$8,$5f,$5f,$bf,$bf,$14,$2b,$17,$80	; Voice 3 (GoldenAxe2Results-Bass)
	even
