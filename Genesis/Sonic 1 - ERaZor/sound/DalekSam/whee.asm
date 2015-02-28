; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Tue Sep 15 2009, 17:30:21
; -------------------------------------------------------

whee_Header:
	smpsHeaderVoice	whee_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$2, $3
	smpsHeaderDAC	whee_DAC
	smpsHeaderFM	whee_FM1,	$c, $10
	smpsHeaderFM	whee_FM2,	$0, $6
	smpsHeaderFM	whee_FM3,	$0, $12
	smpsHeaderFM	whee_FM4,	$0, $12
	smpsHeaderFM	whee_FM5,	$0, $12
	smpsHeaderPSG	whee_PSG1,	$dc, $2, $0
	smpsHeaderPSG	whee_PSG2,	$dc, $1, $0
	smpsHeaderPSG	whee_PSG3,	$dc, $2, $0

whee_FM1:
	smpsCall	whee_FM1_p0
whee_FM1_Loop:
	smpsCall	whee_FM1_p1
	smpsCall	whee_FM1_p2
	smpsCall	whee_FM1_p3
	smpsCall	whee_FM1_p4
	smpsCall	whee_FM1_p5
	smpsCall	whee_FM1_p6
	smpsCall	whee_FM1_p7
	smpsCall	whee_FM1_p6
	smpsCall	whee_FM1_p9
	smpsCall	whee_FM1_pa
	smpsCall	whee_FM1_pb
	smpsCall	whee_FM1_pc
	smpsCall	whee_FM1_pd
	smpsCall	whee_FM1_p6
	smpsCall	whee_FM1_p7
	smpsCall	whee_FM1_p6
	smpsCall	whee_FM1_p11
	smpsCall	whee_FM1_p12
	smpsCall	whee_FM1_p13
	smpsCall	whee_FM1_p14
	smpsCall	whee_FM1_p15
	smpsJump	whee_FM1_Loop

whee_FM2:
	smpsCall	whee_FM2_p0
whee_FM2_Loop:
	smpsCall	whee_FM2_p1
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p5
	smpsCall	whee_FM2_p6
	smpsCall	whee_FM2_p7
	smpsCall	whee_FM2_p6
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p5
	smpsCall	whee_FM2_p6
	smpsCall	whee_FM2_p7
	smpsCall	whee_FM2_p6
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p2
	smpsCall	whee_FM2_p15
	smpsJump	whee_FM2_Loop

whee_FM3:
	smpsCall	whee_FM3_p0
whee_FM3_Loop:
	smpsCall	whee_FM3_p1
	smpsCall	whee_FM3_p2
	smpsCall	whee_FM3_p3
	smpsCall	whee_FM3_p2
	smpsCall	whee_FM3_p5
	smpsCall	whee_FM3_p6
	smpsCall	whee_FM3_p7
	smpsCall	whee_FM3_p8
	smpsCall	whee_FM3_p7
	smpsCall	whee_FM3_pa
	smpsCall	whee_FM3_pa
	smpsCall	whee_FM3_pa
	smpsCall	whee_FM3_pa
	smpsCall	whee_FM3_p6
	smpsCall	whee_FM3_p7
	smpsCall	whee_FM3_p8
	smpsCall	whee_FM3_p11
	smpsCall	whee_FM3_p12
	smpsCall	whee_FM3_p13
	smpsCall	whee_FM3_p14
	smpsCall	whee_FM3_p15
	smpsJump	whee_FM3_Loop

whee_FM4:
	smpsCall	whee_FM4_p0
whee_FM4_Loop:
	smpsCall	whee_FM4_p1
	smpsCall	whee_FM4_p2
	smpsCall	whee_FM4_p3
	smpsCall	whee_FM4_p2
	smpsCall	whee_FM4_p5
	smpsCall	whee_FM4_p6
	smpsCall	whee_FM4_p7
	smpsCall	whee_FM4_p8
	smpsCall	whee_FM4_p7
	smpsCall	whee_FM4_pa
	smpsCall	whee_FM4_pa
	smpsCall	whee_FM4_pa
	smpsCall	whee_FM4_pa
	smpsCall	whee_FM4_p6
	smpsCall	whee_FM4_p7
	smpsCall	whee_FM4_p8
	smpsCall	whee_FM4_p11
	smpsCall	whee_FM4_p12
	smpsCall	whee_FM4_p13
	smpsCall	whee_FM4_p14
	smpsCall	whee_FM4_p15
	smpsJump	whee_FM4_Loop

whee_FM5:
	smpsCall	whee_FM5_p0
whee_FM5_Loop:
	smpsCall	whee_FM5_p1
	smpsCall	whee_FM5_p2
	smpsCall	whee_FM5_p3
	smpsCall	whee_FM5_p2
	smpsCall	whee_FM5_p5
	smpsCall	whee_FM5_p6
	smpsCall	whee_FM5_p7
	smpsCall	whee_FM5_p8
	smpsCall	whee_FM5_p9
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_p6
	smpsCall	whee_FM5_p7
	smpsCall	whee_FM5_p10
	smpsCall	whee_FM5_p7
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_pa
	smpsCall	whee_FM5_p15
	smpsJump	whee_FM5_Loop

whee_PSG1:
	smpsCall	whee_PSG1_p0
whee_PSG1_Loop:
	smpsCall	whee_PSG1_p1
	smpsCall	whee_PSG1_p2
	smpsCall	whee_PSG1_p3
	smpsCall	whee_PSG1_p2
	smpsCall	whee_PSG1_p5
	smpsCall	whee_PSG1_p6
	smpsCall	whee_PSG1_p5
	smpsCall	whee_PSG1_p6
	smpsCall	whee_PSG1_p9
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_p6
	smpsCall	whee_PSG1_p5
	smpsCall	whee_PSG1_p6
	smpsCall	whee_PSG1_p9
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_pa
	smpsCall	whee_PSG1_p15
	smpsJump	whee_PSG1_Loop

whee_PSG2:
	smpsCall	whee_PSG2_p0
whee_PSG2_Loop:
	smpsCall	whee_PSG2_p1
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p9
	smpsCall	whee_PSG2_pa
	smpsCall	whee_PSG2_pb
	smpsCall	whee_PSG2_pc
	smpsCall	whee_PSG2_pd
	smpsCall	whee_PSG2_pe
	smpsCall	whee_PSG2_pf
	smpsCall	whee_PSG2_p10
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p2
	smpsCall	whee_PSG2_p15
	smpsJump	whee_PSG2_Loop

whee_PSG3:
	smpsPSGform	$E7
	smpsCall	whee_PSG3_p0
whee_PSG3_Loop:
	smpsCall	whee_PSG3_p1
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p3
	smpsCall	whee_PSG3_p4
	smpsCall	whee_PSG3_p5
	smpsCall	whee_PSG3_p3
	smpsCall	whee_PSG3_p5
	smpsCall	whee_PSG3_p3
	smpsCall	whee_PSG3_p5
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p3
	smpsCall	whee_PSG3_p5
	smpsCall	whee_PSG3_p3
	smpsCall	whee_PSG3_p5
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p2
	smpsCall	whee_PSG3_p15
	smpsJump	whee_PSG3_Loop

whee_DAC:
	smpsCall	whee_DAC_p0
whee_DAC_Loop:
	smpsCall	whee_DAC_p1
	smpsCall	whee_DAC_p2
	smpsCall	whee_DAC_p3
	smpsCall	whee_DAC_p3
	smpsCall	whee_DAC_p5
	smpsCall	whee_DAC_p6
	smpsCall	whee_DAC_p5
	smpsCall	whee_DAC_p8
	smpsCall	whee_DAC_p9
	smpsCall	whee_DAC_pa
	smpsCall	whee_DAC_p9
	smpsCall	whee_DAC_pa
	smpsCall	whee_DAC_p5
	smpsCall	whee_DAC_p6
	smpsCall	whee_DAC_p5
	smpsCall	whee_DAC_p6
	smpsCall	whee_DAC_p11
	smpsCall	whee_DAC_p12
	smpsCall	whee_DAC_p13
	smpsCall	whee_DAC_p14
	smpsCall	whee_DAC_p15
	smpsJump	whee_DAC_Loop


; Pattern data for FM1
whee_FM1_p0:
	dc.b		$80,$8
	smpsFMvoice	$0
	dc.b		$91,$4
	smpsReturn

whee_FM1_p1:
	dc.b		$e7,$3
	dc.b		$80,$5
	dc.b		$91,$2
	dc.b		$91
	dc.b		$91,$4
	dc.b		$9d
	dc.b		$80
	dc.b		$9c
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$2
	dc.b		$91
	dc.b		$91,$4
	dc.b		$9d
	smpsReturn

whee_FM1_p2:
	dc.b		$9c,$4
	dc.b		$80
	dc.b		$93,$7
	dc.b		$80,$5
	dc.b		$93,$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$9f
	dc.b		$80
	dc.b		$9d
	dc.b		$93,$7
	dc.b		$80,$5
	dc.b		$93,$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$9f
	smpsReturn

whee_FM1_p3:
	dc.b		$80,$4
	dc.b		$9f
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$2
	dc.b		$91
	dc.b		$91,$4
	dc.b		$9d
	dc.b		$80
	dc.b		$9c
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$2
	dc.b		$91
	dc.b		$91,$4
	dc.b		$9d
	smpsReturn

whee_FM1_p4:
	dc.b		$9c,$4
	dc.b		$80
	dc.b		$93,$7
	dc.b		$80,$5
	dc.b		$93,$2
	dc.b		$93
	dc.b		$93,$4
	dc.b		$9f
	dc.b		$80
	dc.b		$9d
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$4
	dc.b		$9f
	smpsReturn

whee_FM1_p5:
	dc.b		$80,$4
	dc.b		$9f
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$4
	dc.b		$9d
	dc.b		$80
	dc.b		$9d
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$4
	dc.b		$91
	dc.b		$9d
	smpsReturn

whee_FM1_p6:
	dc.b		$9d,$4
	dc.b		$80
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$4
	dc.b		$93
	dc.b		$80
	dc.b		$93
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$6
	dc.b		$2
	dc.b		$4
	dc.b		$93
	smpsReturn

whee_FM1_p7:
	dc.b		$93,$4
	dc.b		$9f
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$4
	dc.b		$9d
	dc.b		$80
	dc.b		$9d
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$4
	dc.b		$91
	dc.b		$9d
	smpsReturn

whee_FM1_p9:
	dc.b		$93,$4
	dc.b		$9f
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	smpsReturn

whee_FM1_pa:
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$93,$7
	dc.b		$80,$1
	smpsReturn

whee_FM1_pb:
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	smpsReturn

whee_FM1_pc:
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$6
	dc.b		$2
	dc.b		$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$92,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	dc.b		$93,$3
	dc.b		$80,$1
	smpsReturn

whee_FM1_pd:
	dc.b		$93,$7
	dc.b		$80,$1
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$7
	dc.b		$80,$1
	dc.b		$91,$4
	dc.b		$9d
	dc.b		$80
	dc.b		$9d
	dc.b		$91,$7
	dc.b		$80,$5
	dc.b		$91,$4
	dc.b		$91
	dc.b		$9d
	smpsReturn

whee_FM1_p11:
	dc.b		$93,$4
	dc.b		$9f
	dc.b		$80,$38
	smpsReturn

whee_FM1_p12:
	dc.b		$e7,$40
	smpsReturn

whee_FM1_p13:
	dc.b		$e7,$8
	smpsFMvoice	$0
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$98,$2
	dc.b		$98
	dc.b		$98,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$95,$3
	dc.b		$80,$1
	smpsReturn

whee_FM1_p14:
	dc.b		$95,$2
	dc.b		$95
	dc.b		$95,$3
	dc.b		$80,$1
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$96,$2
	dc.b		$96
	dc.b		$96
	dc.b		$96
	dc.b		$96,$3
	dc.b		$80,$1
	dc.b		$97,$7
	dc.b		$80,$5
	dc.b		$97,$4
	dc.b		$7
	dc.b		$80,$1
	smpsReturn

whee_FM1_p15:
	dc.b		$e7,$4
	dc.b		$97
	dc.b		$97,$7
	dc.b		$80,$5
	dc.b		$97,$4
	dc.b		$7
	dc.b		$80,$5
	dc.b		$97,$4
	dc.b		$91
	smpsReturn

; Pattern data for FM2
whee_FM2_p0:
	dc.b		$80,$c
	smpsReturn

whee_FM2_p1:
        smpsModSet      $02,	$02,	$03,	$02
	dc.b		$e7,$34
	smpsReturn

whee_FM2_p2:
	dc.b		$e7,$40
	smpsReturn

whee_FM2_p5:
	dc.b		$e7,$c
	smpsFMvoice	$2
	dc.b		$bc,$4
	dc.b		$bb
	dc.b		$b9
	dc.b		$bb,$6
	dc.b		$b9
	dc.b		$bc,$8
	dc.b		$4
	dc.b		$bb
	dc.b		$b9
	dc.b		$bb,$6
	dc.b		$b9,$2
	smpsReturn

whee_FM2_p6:
	dc.b		$e7,$7
	dc.b		$80,$39
	smpsReturn

whee_FM2_p7:
	dc.b		$e7,$c
	smpsFMvoice	$2
	dc.b		$bc,$4
	dc.b		$bb
	dc.b		$b9
	dc.b		$bb,$6
	dc.b		$bc
	dc.b		$be,$8
	dc.b		$c0,$4
	dc.b		$c1
	dc.b		$c0
	dc.b		$c1,$6
	dc.b		$c0,$2
	smpsReturn

whee_FM2_p15:
	dc.b		$e7,$2c
	smpsReturn

; Pattern data for FM3
whee_FM3_p0:
	dc.b		$80,$c
	smpsReturn

whee_FM3_p1:
	smpsFMvoice	$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	smpsReturn

whee_FM3_p2:
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	smpsReturn

whee_FM3_p3:
	dc.b		$be,$6
	dc.b		$80
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	smpsReturn

whee_FM3_p5:
	dc.b		$be,$6
	dc.b		$80,$3a
	smpsReturn

whee_FM3_p6:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	smpsReturn

whee_FM3_p7:
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$39
	smpsReturn

whee_FM3_p8:
	dc.b		$e7,$8
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$5
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	smpsReturn

whee_FM3_pa:
	dc.b		$e7,$40
	smpsReturn

whee_FM3_p11:
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$be,$3
	dc.b		$80,$1
	dc.b		$c0,$4
	dc.b		$be,$2
	dc.b		$bc,$6
	dc.b		$b7,$4
	dc.b		$bc,$6
	dc.b		$be
	dc.b		$c0,$4
	dc.b		$c3
	dc.b		$c1,$2
	dc.b		$c0,$4
	dc.b		$c1
	dc.b		$be,$a
	smpsReturn

whee_FM3_p12:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$c3,$4
	dc.b		$c1,$2
	dc.b		$bf,$6
	dc.b		$ba,$4
	dc.b		$bf,$6
	dc.b		$c1
	dc.b		$c3,$4
	dc.b		$c4
	dc.b		$c3,$2
	dc.b		$c1,$4
	dc.b		$c3
	dc.b		$c3,$9
	dc.b		$80,$1
	smpsReturn

whee_FM3_p13:
	dc.b		$c1,$7
	dc.b		$80,$1
	dc.b		$c0,$4
	dc.b		$be,$2
	dc.b		$bc,$6
	dc.b		$b7,$4
	dc.b		$bc,$6
	dc.b		$be
	dc.b		$c0,$4
	dc.b		$c3
	dc.b		$c1,$2
	dc.b		$c0,$4
	dc.b		$c1
	dc.b		$be,$a
	smpsReturn

whee_FM3_p14:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$c3,$4
	dc.b		$c1,$2
	dc.b		$bf,$6
	dc.b		$ba,$4
	dc.b		$bf,$6
	dc.b		$c1
	dc.b		$c3,$4
	dc.b		$7
	dc.b		$80,$1
	dc.b		$c4,$7
	dc.b		$80,$1
	dc.b		$c3,$7
	dc.b		$80,$1
	smpsReturn

whee_FM3_p15:
	dc.b		$c1,$7
	dc.b		$80,$1
	dc.b		$c7,$e
	dc.b		$80,$2
	dc.b		$c4,$e
	dc.b		$80,$6
	smpsReturn

; Pattern data for FM4
whee_FM4_p0:
	dc.b		$80,$c
	smpsReturn

whee_FM4_p1:
	smpsFMvoice	$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	smpsReturn

whee_FM4_p2:
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	smpsReturn

whee_FM4_p3:
	dc.b		$c1,$6
	dc.b		$80
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	smpsReturn

whee_FM4_p5:
	dc.b		$c1,$6
	dc.b		$80,$3a
	smpsReturn

whee_FM4_p6:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	smpsReturn

whee_FM4_p7:
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$39
	smpsReturn

whee_FM4_p8:
	dc.b		$e7,$8
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$5
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	smpsReturn

whee_FM4_pa:
	dc.b		$e7,$40
	smpsReturn

whee_FM4_p11:
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$c1,$3
	dc.b		$80,$1
	dc.b		$cc,$4
	dc.b		$ca,$2
	dc.b		$c8,$6
	dc.b		$c3,$4
	dc.b		$c8,$6
	dc.b		$ca
	dc.b		$cc,$4
	dc.b		$cf
	dc.b		$cd,$2
	dc.b		$cc,$4
	dc.b		$cd
	dc.b		$ca,$a
	smpsReturn

whee_FM4_p12:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$cf,$4
	dc.b		$cd,$2
	dc.b		$cb,$6
	dc.b		$c6,$4
	dc.b		$cb,$6
	dc.b		$cd
	dc.b		$cf,$4
	dc.b		$d0
	dc.b		$cf,$2
	dc.b		$cd,$4
	dc.b		$cf
	dc.b		$cf,$9
	dc.b		$80,$1
	smpsReturn

whee_FM4_p13:
	dc.b		$cd,$7
	dc.b		$80,$1
	dc.b		$cc,$4
	dc.b		$ca,$2
	dc.b		$c8,$6
	dc.b		$c3,$4
	dc.b		$c8,$6
	dc.b		$ca
	dc.b		$cc,$4
	dc.b		$cf
	dc.b		$cd,$2
	dc.b		$cc,$4
	dc.b		$cd
	dc.b		$ca,$a
	smpsReturn

whee_FM4_p14:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$cf,$4
	dc.b		$cd,$2
	dc.b		$cb,$6
	dc.b		$c6,$4
	dc.b		$cb,$6
	dc.b		$cd
	dc.b		$cf,$4
	dc.b		$7
	dc.b		$80,$1
	dc.b		$d0,$7
	dc.b		$80,$1
	dc.b		$cf,$7
	dc.b		$80,$1
	smpsReturn

whee_FM4_p15:
	dc.b		$cd,$7
	dc.b		$80,$1
	dc.b		$d3,$e
	dc.b		$80,$2
	dc.b		$d0,$e
	dc.b		$80,$6
	smpsReturn

; Pattern data for FM5
whee_FM5_p0:
	dc.b		$80,$c
	smpsReturn

whee_FM5_p1:
	smpsFMvoice	$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p2:
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$5
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p3:
	dc.b		$ca,$6
	dc.b		$80
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p5:
	dc.b		$ca,$6
	dc.b		$80,$3a
	smpsReturn

whee_FM5_p6:
	dc.b		$e7,$c
	smpsFMvoice	$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p7:
	dc.b		$ca,$3
	dc.b		$80,$1
	dc.b		$ca,$3
	dc.b		$80,$39
	smpsReturn

whee_FM5_p8:
	dc.b		$e7,$8
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$ca,$3
	dc.b		$80,$1
	dc.b		$ca,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p9:
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c7,$3
	dc.b		$80,$39
	smpsReturn

whee_FM5_pa:
	dc.b		$e7,$40
	smpsReturn

whee_FM5_p10:
	dc.b		$e7,$8
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$5
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c5,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c3,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c7,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	dc.b		$c8,$3
	dc.b		$80,$1
	smpsReturn

whee_FM5_p15:
	dc.b		$e7,$2c
	smpsReturn

; Pattern data for PSG1
whee_PSG1_p0:
	dc.b		$80,$c
	smpsReturn

whee_PSG1_p1:
	dc.b		$e7,$10
	smpsPSGvoice	$0
	dc.b		$a9,$1
	dc.b		$80
	dc.b		$a6
	dc.b		$a9
	dc.b		$b0
	dc.b		$80
	dc.b		$ad
	dc.b		$b0
	dc.b		$b5
	dc.b		$80
	dc.b		$b2
	dc.b		$b5
	dc.b		$bc
	dc.b		$80
	dc.b		$b9
	dc.b		$bc
	dc.b		$c1
	dc.b		$80
	dc.b		$be
	dc.b		$c1
	dc.b		$c8
	dc.b		$80
	dc.b		$c5
	dc.b		$cd
	dc.b		$d4
	dc.b		$80
	dc.b		$d1
	dc.b		$d6
	dc.b		$d9
	dc.b		$80
	dc.b		$d6
	dc.b		$d9
	dc.b		$d1
	dc.b		$80
	dc.b		$cd
	dc.b		$d1
	smpsReturn

whee_PSG1_p2:
	dc.b		$ca,$1
	dc.b		$80
	dc.b		$c8
	dc.b		$ca
	dc.b		$c8
	dc.b		$80,$17
	dc.b		$ab,$1
	dc.b		$80
	dc.b		$a9
	dc.b		$ab
	dc.b		$b2
	dc.b		$80
	dc.b		$b0
	dc.b		$b2
	dc.b		$b7
	dc.b		$80
	dc.b		$b5
	dc.b		$b7
	dc.b		$be
	dc.b		$80
	dc.b		$bc
	dc.b		$be
	dc.b		$c3
	dc.b		$80
	dc.b		$c1
	dc.b		$c3
	dc.b		$ca
	dc.b		$80
	dc.b		$c8
	dc.b		$cf
	dc.b		$d6
	dc.b		$80
	dc.b		$cf
	dc.b		$d4
	dc.b		$db
	dc.b		$80
	dc.b		$d9
	dc.b		$db
	dc.b		$d6
	dc.b		$80
	dc.b		$cd
	dc.b		$cf
	smpsReturn

whee_PSG1_p3:
	dc.b		$ca,$1
	dc.b		$80
	dc.b		$c8
	dc.b		$ca
	dc.b		$c3
	dc.b		$80,$17
	dc.b		$a9,$1
	dc.b		$80
	dc.b		$a6
	dc.b		$a9
	dc.b		$b0
	dc.b		$80
	dc.b		$ad
	dc.b		$b0
	dc.b		$b5
	dc.b		$80
	dc.b		$b2
	dc.b		$b5
	dc.b		$bc
	dc.b		$80
	dc.b		$b9
	dc.b		$bc
	dc.b		$c1
	dc.b		$80
	dc.b		$be
	dc.b		$c1
	dc.b		$c8
	dc.b		$80
	dc.b		$c5
	dc.b		$cd
	dc.b		$d4
	dc.b		$80
	dc.b		$d1
	dc.b		$d6
	dc.b		$d9
	dc.b		$80
	dc.b		$d6
	dc.b		$d9
	dc.b		$d1
	dc.b		$80
	dc.b		$cd
	dc.b		$d1
	smpsReturn

whee_PSG1_p5:
	dc.b		$ca,$1
	dc.b		$80
	dc.b		$c8
	dc.b		$ca
	dc.b		$c3
	dc.b		$80,$3b
	smpsReturn

whee_PSG1_p6:
	dc.b		$e7,$1c
	smpsPSGvoice	$0
	dc.b		$ab,$1
	dc.b		$80
	dc.b		$a9
	dc.b		$ab
	dc.b		$b2
	dc.b		$80
	dc.b		$b0
	dc.b		$b2
	dc.b		$b7
	dc.b		$80
	dc.b		$b5
	dc.b		$b7
	dc.b		$be
	dc.b		$80
	dc.b		$bc
	dc.b		$be
	dc.b		$c3
	dc.b		$80
	dc.b		$c1
	dc.b		$c3
	dc.b		$ca
	dc.b		$80
	dc.b		$c8
	dc.b		$cf
	dc.b		$d6
	dc.b		$80
	dc.b		$cf
	dc.b		$d4
	dc.b		$db
	dc.b		$80
	dc.b		$d9
	dc.b		$db
	dc.b		$d6
	dc.b		$80
	dc.b		$cd
	dc.b		$cf
	smpsReturn

whee_PSG1_p9:
	dc.b		$ca,$1
	dc.b		$80
	dc.b		$c8
	dc.b		$ca
	dc.b		$c3,$4
	dc.b		$80,$38
	smpsReturn

whee_PSG1_pa:
	dc.b		$e7,$40
	smpsReturn

whee_PSG1_p15:
	dc.b		$e7,$2c
	smpsReturn

; Pattern data for PSG2
whee_PSG2_p0:
	dc.b		$80,$c
	smpsReturn

whee_PSG2_p1:
	dc.b		$e7,$34
	smpsReturn

whee_PSG2_p2:
	dc.b		$e7,$40
	smpsReturn

whee_PSG2_p9:
	dc.b		$e7,$8
	smpsPSGvoice	$6
	dc.b		$c8,$b
	dc.b		$80,$1
	dc.b		$ca,$2
	dc.b		$c8
	dc.b		$c7,$4
	dc.b		$c5
	dc.b		$c3
	dc.b		$c0
	dc.b		$c7,$b
	dc.b		$80,$1
	dc.b		$c8,$2
	dc.b		$c7
	dc.b		$c5,$4
	dc.b		$c3
	smpsReturn

whee_PSG2_pa:
	dc.b		$c0,$4
	dc.b		$bc
	dc.b		$c5,$b
	dc.b		$80,$1
	dc.b		$c5,$2
	dc.b		$c7
	dc.b		$c8,$4
	dc.b		$ca
	dc.b		$cc
	dc.b		$c8
	dc.b		$cc,$e
	dc.b		$80,$2
	dc.b		$ca,$8
	smpsReturn

whee_PSG2_pb:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$c8,$b
	dc.b		$80,$1
	dc.b		$ca,$2
	dc.b		$c8
	dc.b		$c7,$4
	dc.b		$c5
	dc.b		$c3
	dc.b		$c0
	dc.b		$ca,$b
	dc.b		$80,$1
	dc.b		$ca,$2
	dc.b		$cc
	dc.b		$cd,$4
	dc.b		$cc
	smpsReturn

whee_PSG2_pc:
	dc.b		$ca,$4
	dc.b		$c7
	dc.b		$c8,$b
	dc.b		$80,$1
	dc.b		$c8,$7
	dc.b		$80,$1
	dc.b		$ca,$4
	dc.b		$cc
	dc.b		$c8
	dc.b		$cc,$e
	dc.b		$80,$2
	dc.b		$ca,$8
	smpsReturn

whee_PSG2_pd:
	dc.b		$e7,$6
	dc.b		$80,$2
	dc.b		$c1,$2b
	dc.b		$80,$1
	dc.b		$c5,$2
	dc.b		$c7
	dc.b		$c8,$4
	dc.b		$c7
	smpsReturn

whee_PSG2_pe:
	dc.b		$c8,$c
	dc.b		$80,$34
	smpsReturn

whee_PSG2_pf:
	dc.b		$e7,$8
	dc.b		$c1,$2b
	dc.b		$80,$1
	dc.b		$ca,$2
	dc.b		$c8
	dc.b		$ca,$4
	dc.b		$c8
	smpsReturn

whee_PSG2_p10:
	dc.b		$c7,$c
	dc.b		$80,$34
	smpsReturn

whee_PSG2_p15:
	dc.b		$e7,$2c
	smpsReturn

; Pattern data for PSG3 (Noise)
whee_PSG3_p0:
	dc.b		$80,$c
	smpsReturn

whee_PSG3_p1:
	dc.b		$e7,$34
	smpsReturn

whee_PSG3_p2:
	dc.b		$e7,$40
	smpsReturn

whee_PSG3_p3:
	dc.b		$e7,$c
	smpsPSGvoice	$2
	dc.b		$82,$4
	dc.b		$80
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80
	dc.b		$82,$1
	dc.b		$82
	dc.b		$82
	dc.b		$80
	dc.b		$82,$2
	dc.b		$80,$4
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80,$4
	dc.b		$82
	dc.b		$80,$6
	dc.b		$82,$2
	dc.b		$80
	dc.b		$82,$1
	dc.b		$82
	dc.b		$82
	dc.b		$80
	dc.b		$82,$2
	smpsReturn

whee_PSG3_p4:
	dc.b		$80,$4
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80,$4
	dc.b		$82
	dc.b		$80
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80
	dc.b		$82,$1
	dc.b		$82
	dc.b		$82
	dc.b		$80
	dc.b		$82,$2
	dc.b		$80,$4
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80,$4
	dc.b		$82
	dc.b		$80,$6
	dc.b		$82,$2
	dc.b		$80
	dc.b		$82,$1
	dc.b		$82
	dc.b		$82
	dc.b		$80
	dc.b		$82,$2
	smpsReturn

whee_PSG3_p5:
	dc.b		$80,$4
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	dc.b		$80,$38
	smpsReturn

whee_PSG3_p15:
	dc.b		$e7,$2c
	smpsReturn

; Pattern data for DAC
whee_DAC_p0:
	dc.b		$8f,$7
	dc.b		$80,$1
	dc.b		$81,$4
	smpsReturn

whee_DAC_p1:
	dc.b		$80,$3
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p2:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p3:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$81
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$4
	dc.b		$81
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p5:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p6:
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$81
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$4
	dc.b		$81
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p8:
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$81
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$4
	dc.b		$81
	dc.b		$82
	dc.b		$82
	smpsReturn

whee_DAC_p9:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$6
	dc.b		$81
	dc.b		$81,$4
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$6
	dc.b		$81
	dc.b		$81,$4
	smpsReturn

whee_DAC_pa:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$6
	dc.b		$81
	dc.b		$81,$4
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$5
	dc.b		$81,$4
	smpsReturn

whee_DAC_p11:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$9
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$9
	smpsReturn

whee_DAC_p12:
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$9
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$81
	smpsReturn

whee_DAC_p13:
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p14:
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$81,$4
	dc.b		$82
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	smpsReturn

whee_DAC_p15:
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$7
	dc.b		$80,$1
	dc.b		$81,$7
	dc.b		$80,$1
	dc.b		$82,$4
	dc.b		$82
	dc.b		$81
	smpsReturn

whee_Voices:
	dc.b	$20,$36,$35,$30,$31,$df,$df,$9f,$9f,$7,$6,$9,$6,$7,$6,$6
	dc.b	$8,$20,$10,$10,$f8,$19,$37,$13,$80	; Voice 0 (Oerg-Bass)
	dc.b	$3b,$51,$71,$61,$41,$51,$16,$18,$1a,$5,$1,$1,$0,$9,$1,$1
	dc.b	$1,$17,$97,$27,$87,$1c,$22,$15,$7f	; Voice 1 (nineko-String)
	dc.b	$3a,$32,$1,$52,$31,$1f,$1f,$1f,$18,$1,$1f,$0,$0,$0,$f,$0
	dc.b	$0,$5a,$f,$3,$1a,$3b,$30,$4f,$0	; Voice 2 (nineko-ARZ Pan flute)
	even