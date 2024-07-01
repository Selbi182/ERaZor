; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Fri Dec 25 2009, 16:48:43
; -------------------------------------------------------

KEN_Header:
	smpsHeaderVoice	KEN_Voices
	smpsHeaderChan	6,2
	smpsHeaderTempo	$1, $5
	smpsHeaderDAC	KEN_DAC
	smpsHeaderFM	KEN_FM1,	$c, $b
	smpsHeaderFM	KEN_FM2,	$0, $c
	smpsHeaderFM	KEN_FM3,	$0, $13
	smpsHeaderFM	KEN_FM4,	$0, $13
	smpsHeaderFM	KEN_FM5,	$0, $13
	smpsHeaderPSG	KEN_PSG1,	$dc, $2, $0
	smpsHeaderPSG	KEN_PSG2,	$dc, $3, $0

KEN_FM1:
	smpsCall	KEN_FM1_p1
	smpsCall	KEN_FM1_p2
	smpsCall	KEN_FM1_p3
	smpsCall	KEN_FM1_p4
	smpsCall	KEN_FM1_p5
	smpsCall	KEN_FM1_p6
	smpsCall	KEN_FM1_p7
	smpsCall	KEN_FM1_p8
KEN_FM1_Loop:
	smpsCall	KEN_FM1_p9
	smpsCall	KEN_FM1_pa
	smpsCall	KEN_FM1_pb
	smpsCall	KEN_FM1_pc
	smpsCall	KEN_FM1_pd
	smpsCall	KEN_FM1_pe
	smpsCall	KEN_FM1_p7
	smpsCall	KEN_FM1_p10
	smpsCall	KEN_FM1_p9
	smpsCall	KEN_FM1_p12
	smpsCall	KEN_FM1_pb
	smpsCall	KEN_FM1_p14
	smpsCall	KEN_FM1_pd
	smpsCall	KEN_FM1_pe
	smpsCall	KEN_FM1_p7
	smpsCall	KEN_FM1_p17
	smpsCall	KEN_FM1_p18
	smpsCall	KEN_FM1_p19
	smpsCall	KEN_FM1_p1a
	smpsCall	KEN_FM1_p1b
	smpsCall	KEN_FM1_p1c
	smpsCall	KEN_FM1_p1d
	smpsCall	KEN_FM1_p18
	smpsCall	KEN_FM1_p1f
	smpsCall	KEN_FM1_p20
	smpsCall	KEN_FM1_p21
	smpsCall	KEN_FM1_p22
	smpsCall	KEN_FM1_p23
	smpsCall	KEN_FM1_p9
	smpsCall	KEN_FM1_p25
	smpsCall	KEN_FM1_pb
	smpsCall	KEN_FM1_p14
	smpsCall	KEN_FM1_pd
	smpsCall	KEN_FM1_pe
	smpsCall	KEN_FM1_p7
	smpsCall	KEN_FM1_p10
	smpsCall	KEN_FM1_p9
	smpsCall	KEN_FM1_p25
	smpsCall	KEN_FM1_pb
	smpsCall	KEN_FM1_p2f
	smpsCall	KEN_FM1_p30
	smpsCall	KEN_FM1_p31
	smpsCall	KEN_FM1_p32
	smpsCall	KEN_FM1_p33
	smpsJump	KEN_FM1_Loop

KEN_FM2:
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
KEN_FM2_Loop:
	smpsCall	KEN_FM2_p9
	smpsCall	KEN_FM2_pa
	smpsCall	KEN_FM2_p9
	smpsCall	KEN_FM2_pa
	smpsCall	KEN_FM2_pd
	smpsCall	KEN_FM2_pe
	smpsCall	KEN_FM2_pf
	smpsCall	KEN_FM2_p10
	smpsCall	KEN_FM2_p9
	smpsCall	KEN_FM2_pa
	smpsCall	KEN_FM2_p9
	smpsCall	KEN_FM2_pa
	smpsCall	KEN_FM2_pd
	smpsCall	KEN_FM2_p16
	smpsCall	KEN_FM2_pf
	smpsCall	KEN_FM2_p10
	smpsCall	KEN_FM2_p18
	smpsCall	KEN_FM2_p19
	smpsCall	KEN_FM2_p1a
	smpsCall	KEN_FM2_p1b
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p18
	smpsCall	KEN_FM2_p19
	smpsCall	KEN_FM2_p1a
	smpsCall	KEN_FM2_p1b
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_p1
	smpsCall	KEN_FM2_pd
	smpsCall	KEN_FM2_p25
	smpsCall	KEN_FM2_p26
	smpsCall	KEN_FM2_p27
	smpsCall	KEN_FM2_p28
	smpsCall	KEN_FM2_p29
	smpsCall	KEN_FM2_p2a
	smpsCall	KEN_FM2_p2b
	smpsCall	KEN_FM2_p2c
	smpsCall	KEN_FM2_p2d
	smpsCall	KEN_FM2_p26
	smpsCall	KEN_FM2_p27
	smpsCall	KEN_FM2_p30
	smpsCall	KEN_FM2_p31
	smpsCall	KEN_FM2_p32
	smpsCall	KEN_FM2_p33
	smpsJump	KEN_FM2_Loop

KEN_FM3:
	smpsCall	KEN_FM3_p1
	smpsCall	KEN_FM3_p2
	smpsCall	KEN_FM3_p3
	smpsCall	KEN_FM3_p4
	smpsCall	KEN_FM3_p5
	smpsCall	KEN_FM3_p6
	smpsCall	KEN_FM3_p7
	smpsCall	KEN_FM3_p8
KEN_FM3_Loop:
	smpsCall	KEN_FM3_p9
	smpsCall	KEN_FM3_pa
	smpsCall	KEN_FM3_p9
	smpsCall	KEN_FM3_pc
	smpsCall	KEN_FM3_pd
	smpsCall	KEN_FM3_pe
	smpsCall	KEN_FM3_pf
	smpsCall	KEN_FM3_p10
	smpsCall	KEN_FM3_p0
	smpsCall	KEN_FM3_p12
	smpsCall	KEN_FM3_p13
	smpsCall	KEN_FM3_p14
	smpsCall	KEN_FM3_p15
	smpsCall	KEN_FM3_p16
	smpsCall	KEN_FM3_pf
	smpsCall	KEN_FM3_p17
	smpsCall	KEN_FM3_p18
	smpsCall	KEN_FM3_p0
	smpsCall	KEN_FM3_p1a
	smpsCall	KEN_FM3_p1b
	smpsCall	KEN_FM3_p1c
	smpsCall	KEN_FM3_p1d
	smpsCall	KEN_FM3_p0
	smpsCall	KEN_FM3_p0
	smpsCall	KEN_FM3_p20
	smpsCall	KEN_FM3_p21
	smpsCall	KEN_FM3_p22
	smpsCall	KEN_FM3_p23
	smpsCall	KEN_FM3_p24
	smpsCall	KEN_FM3_p25
	smpsCall	KEN_FM3_p26
	smpsCall	KEN_FM3_p27
	smpsCall	KEN_FM3_p28
	smpsCall	KEN_FM3_p29
	smpsCall	KEN_FM3_p2a
	smpsCall	KEN_FM3_p2b
	smpsCall	KEN_FM3_p2c
	smpsCall	KEN_FM3_p2d
	smpsCall	KEN_FM3_p2e
	smpsCall	KEN_FM3_p2f
	smpsCall	KEN_FM3_p30
	smpsCall	KEN_FM3_p31
	smpsCall	KEN_FM3_p32
	smpsCall	KEN_FM3_p33
	smpsJump	KEN_FM3_Loop

KEN_FM4:
	smpsCall	KEN_FM4_p1
	smpsCall	KEN_FM4_p2
	smpsCall	KEN_FM4_p3
	smpsCall	KEN_FM4_p4
	smpsCall	KEN_FM4_p5
	smpsCall	KEN_FM4_p6
	smpsCall	KEN_FM4_p7
	smpsCall	KEN_FM4_p8
KEN_FM4_Loop:
	smpsCall	KEN_FM4_p9
	smpsCall	KEN_FM4_pa
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_pc
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_pe
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_p10
	smpsCall	KEN_FM4_p11
	smpsCall	KEN_FM4_p12
	smpsCall	KEN_FM4_p13
	smpsCall	KEN_FM4_p14
	smpsCall	KEN_FM4_p15
	smpsCall	KEN_FM4_p16
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_p17
	smpsCall	KEN_FM4_p18
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_p1a
	smpsCall	KEN_FM4_p1b
	smpsCall	KEN_FM4_p1c
	smpsCall	KEN_FM4_p1d
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_p0
	smpsCall	KEN_FM4_p20
	smpsCall	KEN_FM4_p21
	smpsCall	KEN_FM4_p22
	smpsCall	KEN_FM4_p23
	smpsCall	KEN_FM4_p24
	smpsCall	KEN_FM4_p25
	smpsCall	KEN_FM4_p26
	smpsCall	KEN_FM4_p27
	smpsCall	KEN_FM4_p28
	smpsCall	KEN_FM4_p29
	smpsCall	KEN_FM4_p2a
	smpsCall	KEN_FM4_p2b
	smpsCall	KEN_FM4_p2c
	smpsCall	KEN_FM4_p2d
	smpsCall	KEN_FM4_p2e
	smpsCall	KEN_FM4_p2f
	smpsCall	KEN_FM4_p30
	smpsCall	KEN_FM4_p31
	smpsCall	KEN_FM4_p32
	smpsCall	KEN_FM4_p33
	smpsJump	KEN_FM4_Loop

KEN_FM5:
	smpsCall	KEN_FM5_p1
	smpsCall	KEN_FM5_p2
	smpsCall	KEN_FM5_p3
	smpsCall	KEN_FM5_p4
	smpsCall	KEN_FM5_p5
	smpsCall	KEN_FM5_p6
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p8
KEN_FM5_Loop:
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_pa
	smpsCall	KEN_FM5_pb
	smpsCall	KEN_FM5_pc
	smpsCall	KEN_FM5_pb
	smpsCall	KEN_FM5_pe
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p10
	smpsCall	KEN_FM5_p11
	smpsCall	KEN_FM5_p12
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p14
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p16
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p17
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p1b
	smpsCall	KEN_FM5_p1c
	smpsCall	KEN_FM5_p1d
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p21
	smpsCall	KEN_FM5_p22
	smpsCall	KEN_FM5_p23
	smpsCall	KEN_FM5_p24
	smpsCall	KEN_FM5_p25
	smpsCall	KEN_FM5_p26
	smpsCall	KEN_FM5_p27
	smpsCall	KEN_FM5_p28
	smpsCall	KEN_FM5_p29
	smpsCall	KEN_FM5_p2a
	smpsCall	KEN_FM5_p2b
	smpsCall	KEN_FM5_p2c
	smpsCall	KEN_FM5_p2d
	smpsCall	KEN_FM5_p2e
	smpsCall	KEN_FM5_p2f
	smpsCall	KEN_FM5_p0
	smpsCall	KEN_FM5_p31
	smpsCall	KEN_FM5_p32
	smpsCall	KEN_FM5_p33
	smpsJump	KEN_FM5_Loop

KEN_PSG1:
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
KEN_PSG1_Loop:
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p18
	smpsCall	KEN_PSG1_p19
	smpsCall	KEN_PSG1_p1a
	smpsCall	KEN_PSG1_p1b
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p1d
	smpsCall	KEN_PSG1_p18
	smpsCall	KEN_PSG1_p19
	smpsCall	KEN_PSG1_p1a
	smpsCall	KEN_PSG1_p1b
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p1d
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsCall	KEN_PSG1_p0
	smpsJump	KEN_PSG1_Loop

KEN_PSG2:
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
KEN_PSG2_Loop:
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p18
	smpsCall	KEN_PSG2_p19
	smpsCall	KEN_PSG2_p1a
	smpsCall	KEN_PSG2_p1b
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p18
	smpsCall	KEN_PSG2_p19
	smpsCall	KEN_PSG2_p20
	smpsCall	KEN_PSG2_p21
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsCall	KEN_PSG2_p0
	smpsJump	KEN_PSG2_Loop

KEN_DAC:
	smpsCall	KEN_DAC_p1
	smpsCall	KEN_DAC_p2
	smpsCall	KEN_DAC_p3
	smpsCall	KEN_DAC_p4
	smpsCall	KEN_DAC_p5
	smpsCall	KEN_DAC_p6
	smpsCall	KEN_DAC_p7
	smpsCall	KEN_DAC_p6
KEN_DAC_Loop:
	smpsCall	KEN_DAC_p7
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p6
	smpsCall	KEN_DAC_p7
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_pa
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p17
	smpsCall	KEN_DAC_p18
	smpsCall	KEN_DAC_p19
	smpsCall	KEN_DAC_p18
	smpsCall	KEN_DAC_p1b
	smpsCall	KEN_DAC_p1c
	smpsCall	KEN_DAC_p6
	smpsCall	KEN_DAC_p1e
	smpsCall	KEN_DAC_p19
	smpsCall	KEN_DAC_p18
	smpsCall	KEN_DAC_p1b
	smpsCall	KEN_DAC_p1c
	smpsCall	KEN_DAC_p6
	smpsCall	KEN_DAC_p7
	smpsCall	KEN_DAC_p25
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p25
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p25
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p2b
	smpsCall	KEN_DAC_p7
	smpsCall	KEN_DAC_p25
	smpsCall	KEN_DAC_pb
	smpsCall	KEN_DAC_p6
	smpsCall	KEN_DAC_p30
	smpsCall	KEN_DAC_p31
	smpsCall	KEN_DAC_p32
	smpsCall	KEN_DAC_p33
	smpsJump	KEN_DAC_Loop


; Pattern data for FM1
KEN_FM1_p1:
	smpsFMvoice	$2
	dc.b		$94,$40
	smpsReturn

KEN_FM1_p2:
	dc.b		$e7,$18
	dc.b		$94,$8
	dc.b		$a0
	dc.b		$9e
	dc.b		$80
	dc.b		$9c
	smpsReturn

KEN_FM1_p3:
	dc.b		$e7,$40
	smpsReturn

KEN_FM1_p4:
	dc.b		$e7,$2f
	smpsFMvoice	$2
	dc.b		$9c,$7
	dc.b		$80,$2
	dc.b		$9b,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_p5:
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_p6:
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$9b,$8
	smpsReturn

KEN_FM1_p7:
	dc.b		$e7,$8
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_p8:
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$a0,$8
	smpsReturn

KEN_FM1_p9:
	dc.b		$e7,$8
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_pa:
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$94,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$9
	dc.b		$9c,$8
	smpsReturn

KEN_FM1_pb:
	dc.b		$e7,$8
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_pc:
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$99,$8
	smpsReturn

KEN_FM1_pd:
	dc.b		$e7,$8
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_pe:
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$99,$7
	dc.b		$80,$1
	dc.b		$96,$6
	dc.b		$80,$a
	dc.b		$9b,$8
	smpsReturn

KEN_FM1_p10:
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$9
	dc.b		$a0,$8
	smpsReturn

KEN_FM1_p12:
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$94,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$9e,$6
	dc.b		$80,$a
	dc.b		$9c,$8
	smpsReturn

KEN_FM1_p14:
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9b,$6
	dc.b		$80,$2
	dc.b		$99,$8
	smpsReturn

KEN_FM1_p17:
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$11
	smpsReturn

KEN_FM1_p18:
	dc.b		$9c,$8
	dc.b		$80,$10
	dc.b		$9c,$28
	smpsReturn

KEN_FM1_p19:
	dc.b		$9c,$8
	dc.b		$80,$10
	dc.b		$9c
	dc.b		$9c,$8
	dc.b		$9b,$10
	smpsReturn

KEN_FM1_p1a:
	dc.b		$99,$8
	dc.b		$80,$10
	dc.b		$99,$28
	smpsReturn

KEN_FM1_p1b:
	dc.b		$99,$8
	dc.b		$80,$10
	dc.b		$99
	dc.b		$99,$8
	dc.b		$9b
	dc.b		$94
	smpsReturn

KEN_FM1_p1c:
	dc.b		$e7,$8
	dc.b		$94
	dc.b		$97
	dc.b		$9b
	dc.b		$9e
	dc.b		$9d
	dc.b		$80
	dc.b		$94
	smpsReturn

KEN_FM1_p1d:
	dc.b		$97,$8
	dc.b		$9b
	dc.b		$9e
	dc.b		$9d
	dc.b		$80,$18
	dc.b		$97,$8
	smpsReturn

KEN_FM1_p1f:
	dc.b		$9c,$8
	dc.b		$80,$10
	dc.b		$9c
	dc.b		$9c,$8
	dc.b		$10
	smpsReturn

KEN_FM1_p20:
	dc.b		$9e,$8
	dc.b		$80,$10
	dc.b		$9e,$28
	smpsReturn

KEN_FM1_p21:
	dc.b		$9e,$8
	dc.b		$80,$10
	dc.b		$9e
	dc.b		$9e,$8
	dc.b		$9e
	dc.b		$9b
	smpsReturn

KEN_FM1_p22:
	dc.b		$e7,$8
	dc.b		$9b
	dc.b		$9e
	dc.b		$a2
	dc.b		$a7,$7
	dc.b		$80,$1
	dc.b		$a5,$10
	dc.b		$a7,$8
	smpsReturn

KEN_FM1_p23:
	dc.b		$e7,$8
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$1
	dc.b		$9b,$7
	dc.b		$80,$9
	dc.b		$a0,$8
	smpsReturn

KEN_FM1_p25:
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$94,$6
	dc.b		$80,$2
	dc.b		$a0,$7
	dc.b		$80,$1
	dc.b		$9e,$6
	dc.b		$80,$a
	dc.b		$9c,$8
	smpsReturn

KEN_FM1_p2f:
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$7
	dc.b		$80,$1
	dc.b		$9c,$6
	dc.b		$80,$2
	dc.b		$9e,$8
	smpsReturn

KEN_FM1_p30:
	dc.b		$e7,$8
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	dc.b		$9e,$7
	dc.b		$80,$1
	smpsReturn

KEN_FM1_p31:
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$9f,$7
	dc.b		$80,$1
	dc.b		$a0,$8
	smpsReturn

KEN_FM1_p32:
	dc.b		$e7,$38
	dc.b		$80,$8
	smpsReturn

KEN_FM1_p33:
	dc.b		$e7,$20
	smpsFMvoice	$2
	dc.b		$94,$8
	dc.b		$a0
	dc.b		$80
	dc.b		$a0
	smpsReturn

; Pattern data for FM2
KEN_FM2_p1:
	dc.b		$e7,$40
	smpsReturn

KEN_FM2_p9:
	dc.b		$e7,$10
	smpsFMvoice	$0
	dc.b		$b3
	dc.b		$b8
	dc.b		$bd,$8
	dc.b		$bb
	smpsReturn

KEN_FM2_pa:
	dc.b		$e7,$8
	dc.b		$ba
	dc.b		$b8,$10
	dc.b		$8
	dc.b		$b6,$10
	dc.b		$b8,$8
	smpsReturn

KEN_FM2_pd:
	dc.b		$e7,$10
	smpsFMvoice	$0
	dc.b		$b3
	dc.b		$b8
	dc.b		$bd,$8
	dc.b		$bf
	smpsReturn

KEN_FM2_pe:
	dc.b		$e7,$8
	dc.b		$c0
	dc.b		$bf
	dc.b		$bd,$10
	dc.b		$bb,$8
	dc.b		$bd
	dc.b		$bf
	smpsReturn

KEN_FM2_pf:
	dc.b		$e7,$f
	dc.b		$bd,$21
	dc.b		$bb,$10
	smpsReturn

KEN_FM2_p10:
	dc.b		$ba,$10
	dc.b		$b8,$8
	dc.b		$b7,$10
	dc.b		$18
	smpsReturn

KEN_FM2_p16:
	dc.b		$e7,$8
	dc.b		$c0
	dc.b		$bf
	dc.b		$bd,$10
	dc.b		$bb,$7
	dc.b		$ba,$9
	dc.b		$bf,$8
	smpsReturn

KEN_FM2_p18:
	smpsFMvoice	$0
	dc.b		$b8,$18
	dc.b		$ba,$28
	smpsReturn

KEN_FM2_p19:
	dc.b		$bb,$18
	dc.b		$bd,$10
	dc.b		$bb,$8
	dc.b		$ba
	dc.b		$b8
	smpsReturn

KEN_FM2_p1a:
	dc.b		$b4,$18
	dc.b		$bf,$28
	smpsReturn

KEN_FM2_p1b:
	dc.b		$e7,$30
	dc.b		$bd,$8
	dc.b		$bf
	smpsReturn

KEN_FM2_p25:
	dc.b		$e7,$10
	dc.b		$bd,$8
	dc.b		$bb,$10
	dc.b		$ba
	dc.b		$bb,$8
	smpsReturn

KEN_FM2_p26:
	dc.b		$e7,$10
	dc.b		$ba,$8
	dc.b		$b8,$10
	dc.b		$b6
	dc.b		$b8,$8
	smpsReturn

KEN_FM2_p27:
	dc.b		$e7,$20
	dc.b		$ba,$8
	dc.b		$bb,$18
	smpsReturn

KEN_FM2_p28:
	dc.b		$e7,$10
	dc.b		$bd
	dc.b		$bb
	dc.b		$ba,$8
	dc.b		$bd
	smpsReturn

KEN_FM2_p29:
	dc.b		$e7,$8
	dc.b		$bd
	dc.b		$bb,$10
	dc.b		$ba
	dc.b		$bb,$8
	dc.b		$ba
	smpsReturn

KEN_FM2_p2a:
	dc.b		$e7,$10
	dc.b		$b8
	dc.b		$b7
	dc.b		$b8,$8
	dc.b		$bf
	smpsReturn

KEN_FM2_p2b:
	dc.b		$e7,$8
	dc.b		$bf
	dc.b		$bf
	dc.b		$bf
	dc.b		$bf
	dc.b		$bf,$10
	dc.b		$8
	smpsReturn

KEN_FM2_p2c:
	dc.b		$e7,$10
	dc.b		$bd
	dc.b		$bb
	dc.b		$bd,$8
	dc.b		$bb
	smpsReturn

KEN_FM2_p2d:
	dc.b		$e7,$8
	dc.b		$ba,$10
	dc.b		$b8
	dc.b		$b3
	dc.b		$bb,$8
	smpsReturn

KEN_FM2_p30:
	dc.b		$e7,$10
	dc.b		$bd
	dc.b		$bf
	dc.b		$c0,$8
	dc.b		$bf
	smpsReturn

KEN_FM2_p31:
	dc.b		$e7,$8
	dc.b		$bf
	dc.b		$bd,$10
	dc.b		$bb
	dc.b		$b7,$8
	dc.b		$ba
	smpsReturn

KEN_FM2_p32:
	dc.b		$e7,$10
	dc.b		$b8,$30
	smpsReturn

KEN_FM2_p33:
	dc.b		$e7,$30
	dc.b		$80,$10
	smpsReturn

; Pattern data for FM3
KEN_FM3_p1:
	smpsFMvoice	$1
	dc.b		$ac,$40
	smpsReturn

KEN_FM3_p2:
	dc.b		$e7,$18
	dc.b		$9b,$8
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	dc.b		$aa,$4
	dc.b		$80
	smpsReturn

KEN_FM3_p3:
	dc.b		$e7,$8
	dc.b		$a8
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	dc.b		$a8,$28
	smpsReturn

KEN_FM3_p4:
	dc.b		$e7,$30
	dc.b		$a3,$8
	dc.b		$aa
	smpsReturn

KEN_FM3_p5:
	dc.b		$ac,$10
	dc.b		$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$a8,$4
	dc.b		$a0,$2
	dc.b		$a0
	smpsReturn

KEN_FM3_p6:
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	dc.b		$ac,$10
	dc.b		$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ae,$8
	smpsReturn

KEN_FM3_p7:
	dc.b		$e7,$8
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ae,$10
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	smpsReturn

KEN_FM3_p8:
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	dc.b		$ae,$10
	dc.b		$4
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$b1,$8
	smpsReturn

KEN_FM3_p9:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$af
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM3_pa:
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$b1,$8
	smpsReturn

KEN_FM3_pc:
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$b3,$8
	smpsReturn

KEN_FM3_pd:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$b1
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b3,$8
	dc.b		$b3
	dc.b		$b1
	smpsReturn

KEN_FM3_pe:
	dc.b		$80,$8
	dc.b		$b1
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_pf:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$ae
	dc.b		$80,$10
	dc.b		$ac,$8
	dc.b		$ac
	dc.b		$ae
	smpsReturn

KEN_FM3_p10:
	dc.b		$80,$8
	dc.b		$ae
	dc.b		$80
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$a7
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7,$8
	smpsReturn

KEN_FM3_p0:
	dc.b		$e7,$40
	smpsReturn

KEN_FM3_p12:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$af
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7,$8
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p13:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$8
	smpsReturn

KEN_FM3_p14:
	dc.b		$e7,$8
	dc.b		$af
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a8,$8
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p15:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b3,$8
	dc.b		$b3
	dc.b		$ac
	smpsReturn

KEN_FM3_p16:
	dc.b		$e7,$8
	dc.b		$a5
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$4
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p17:
	dc.b		$80,$8
	dc.b		$ae
	dc.b		$a7
	dc.b		$a7
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80,$14
	smpsReturn

KEN_FM3_p18:
	dc.b		$a8,$40
	smpsReturn

KEN_FM3_p1a:
	smpsFMvoice	$1
	dc.b		$a5,$40
	smpsReturn

KEN_FM3_p1b:
	dc.b		$e7,$38
	dc.b		$b1,$8
	smpsReturn

KEN_FM3_p1c:
	dc.b		$e7,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM3_p1d:
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$8
	dc.b		$af,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a3,$8
	smpsReturn

KEN_FM3_p20:
	smpsFMvoice	$1
	dc.b		$aa,$40
	smpsReturn

KEN_FM3_p21:
	dc.b		$e7,$38
	dc.b		$ab,$8
	smpsReturn

KEN_FM3_p22:
	dc.b		$e7,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$af,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	smpsReturn

KEN_FM3_p23:
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$80
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$80
	dc.b		$ac
	smpsReturn

KEN_FM3_p24:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$af,$8
	smpsReturn

KEN_FM3_p25:
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$b1,$8
	smpsReturn

KEN_FM3_p26:
	dc.b		$e7,$10
	dc.b		$af,$8
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM3_p27:
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p28:
	dc.b		$e7,$10
	dc.b		$b1,$8
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$a5
	dc.b		$80
	dc.b		$a5
	dc.b		$80
	dc.b		$b3,$8
	dc.b		$ac
	smpsReturn

KEN_FM3_p29:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a7,$8
	smpsReturn

KEN_FM3_p2a:
	dc.b		$e7,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac,$8
	dc.b		$ac
	dc.b		$a7,$4
	dc.b		$80
	smpsReturn

KEN_FM3_p2b:
	dc.b		$e7,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ae
	dc.b		$80,$c
	dc.b		$a7,$8
	smpsReturn

KEN_FM3_p2c:
	dc.b		$e7,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p2d:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM3_p2e:
	dc.b		$e7,$10
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$af,$8
	smpsReturn

KEN_FM3_p2f:
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$af,$8
	smpsReturn

KEN_FM3_p30:
	dc.b		$e7,$10
	dc.b		$aa,$4
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$af,$8
	dc.b		$af
	dc.b		$ae
	smpsReturn

KEN_FM3_p31:
	dc.b		$80,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80,$c
	dc.b		$b1,$8
	smpsReturn

KEN_FM3_p32:
	dc.b		$e7,$10
	dc.b		$af,$20
	dc.b		$80,$10
	smpsReturn

KEN_FM3_p33:
	dc.b		$a0,$2
	dc.b		$80
	dc.b		$a0
	dc.b		$80
	dc.b		$ac,$8
	dc.b		$a7,$4
	dc.b		$a0,$2
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$a0,$2
	dc.b		$80
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b1,$8
	smpsReturn

; Pattern data for FM4
KEN_FM4_p1:
	smpsFMvoice	$1
	dc.b		$a7,$40
	smpsReturn

KEN_FM4_p2:
	dc.b		$e7,$18
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$a0
	dc.b		$a0
	dc.b		$a7,$8
	dc.b		$a7
	dc.b		$80
	dc.b		$a3
	smpsReturn

KEN_FM4_p3:
	dc.b		$80,$8
	dc.b		$a3
	dc.b		$80
	dc.b		$a3,$28
	smpsReturn

KEN_FM4_p4:
	dc.b		$e7,$30
	dc.b		$a8,$8
	dc.b		$a5
	smpsReturn

KEN_FM4_p5:
	dc.b		$a8,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8,$10
	dc.b		$a0,$2
	dc.b		$a0
	dc.b		$80,$4
	smpsReturn

KEN_FM4_p6:
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$ab,$8
	smpsReturn

KEN_FM4_p7:
	dc.b		$e7,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab,$10
	dc.b		$4
	dc.b		$80
	smpsReturn

KEN_FM4_p8:
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab,$10
	dc.b		$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM4_p9:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80,$14
	dc.b		$ac,$10
	dc.b		$8
	smpsReturn

KEN_FM4_pa:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$a8
	smpsReturn

KEN_FM4_p0:
	dc.b		$e7,$40
	smpsReturn

KEN_FM4_pc:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a8
	dc.b		$80,$10
	dc.b		$a8,$8
	dc.b		$80,$10
	dc.b		$a5,$8
	smpsReturn

KEN_FM4_pe:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a5
	dc.b		$80,$10
	dc.b		$a5,$8
	dc.b		$80,$10
	dc.b		$a7,$8
	smpsReturn

KEN_FM4_p10:
	smpsFMvoice	$1
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ab,$10
	dc.b		$80,$8
	dc.b		$ab,$10
	dc.b		$80,$8
	dc.b		$ac
	smpsReturn

KEN_FM4_p11:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$8
	smpsReturn

KEN_FM4_p12:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80,$10
	dc.b		$b1,$8
	smpsReturn

KEN_FM4_p13:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$af
	dc.b		$80,$10
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM4_p14:
	dc.b		$80,$8
	dc.b		$a8
	dc.b		$80,$10
	dc.b		$ac
	dc.b		$80,$8
	dc.b		$b3
	smpsReturn

KEN_FM4_p15:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$b1
	dc.b		$80,$10
	dc.b		$ac
	dc.b		$b1,$8
	smpsReturn

KEN_FM4_p16:
	dc.b		$80,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$b1
	dc.b		$80,$10
	dc.b		$a7,$8
	smpsReturn

KEN_FM4_p17:
	smpsFMvoice	$1
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ab,$10
	dc.b		$4
	dc.b		$80
	dc.b		$a7,$8
	dc.b		$a7
	dc.b		$80,$10
	smpsReturn

KEN_FM4_p18:
	dc.b		$a3,$40
	smpsReturn

KEN_FM4_p1a:
	smpsFMvoice	$1
	dc.b		$a0,$40
	smpsReturn

KEN_FM4_p1b:
	dc.b		$e7,$38
	dc.b		$ac,$8
	smpsReturn

KEN_FM4_p1c:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$4
	dc.b		$80
	smpsReturn

KEN_FM4_p1d:
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7,$10
	dc.b		$af,$4
	dc.b		$80
	dc.b		$af
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$af
	dc.b		$80
	dc.b		$a8,$8
	smpsReturn

KEN_FM4_p20:
	smpsFMvoice	$1
	dc.b		$a5,$40
	smpsReturn

KEN_FM4_p21:
	dc.b		$e7,$38
	dc.b		$a7,$8
	smpsReturn

KEN_FM4_p22:
	dc.b		$e7,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$af,$8
	dc.b		$ae
	smpsReturn

KEN_FM4_p23:
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ab,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$ab,$4
	dc.b		$80,$c
	dc.b		$a7,$8
	smpsReturn

KEN_FM4_p24:
	dc.b		$e7,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$a7,$4
	dc.b		$80
	smpsReturn

KEN_FM4_p25:
	dc.b		$e7,$8
	dc.b		$a7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM4_p26:
	dc.b		$e7,$10
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	smpsReturn

KEN_FM4_p27:
	dc.b		$e7,$8
	dc.b		$a8,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80,$c
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$b3,$8
	smpsReturn

KEN_FM4_p28:
	dc.b		$e7,$10
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b3,$8
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$a5
	dc.b		$80
	smpsReturn

KEN_FM4_p29:
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$a5,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a5
	dc.b		$80
	dc.b		$a5,$10
	dc.b		$ac,$8
	smpsReturn

KEN_FM4_p2a:
	dc.b		$e7,$10
	dc.b		$ae,$8
	dc.b		$80,$10
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ab,$8
	smpsReturn

KEN_FM4_p2b:
	dc.b		$e7,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$a7
	dc.b		$80,$c
	dc.b		$b1,$8
	smpsReturn

KEN_FM4_p2c:
	dc.b		$e7,$10
	dc.b		$af,$8
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$ac,$10
	dc.b		$a7,$4
	dc.b		$80
	smpsReturn

KEN_FM4_p2d:
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$b1,$8
	smpsReturn

KEN_FM4_p2e:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$a8,$4
	dc.b		$80
	smpsReturn

KEN_FM4_p2f:
	dc.b		$e7,$8
	dc.b		$a8,$10
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$ac,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$aa,$8
	smpsReturn

KEN_FM4_p30:
	dc.b		$e7,$8
	dc.b		$aa,$4
	dc.b		$80
	dc.b		$ae,$8
	dc.b		$80,$10
	dc.b		$aa,$4
	dc.b		$80
	dc.b		$aa
	dc.b		$80
	dc.b		$ab,$8
	smpsReturn

KEN_FM4_p31:
	dc.b		$e7,$8
	dc.b		$ae
	dc.b		$80,$10
	dc.b		$ae,$8
	dc.b		$80,$10
	dc.b		$ae,$8
	smpsReturn

KEN_FM4_p32:
	dc.b		$e7,$10
	dc.b		$80,$30
	smpsReturn

KEN_FM4_p33:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$a0,$2
	dc.b		$80,$6
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$8
	dc.b		$a7,$4
	dc.b		$80,$c
	dc.b		$ac,$8
	smpsReturn

; Pattern data for FM5
KEN_FM5_p1:
	smpsFMvoice	$1
	dc.b		$a0,$40
	smpsReturn

KEN_FM5_p2:
	dc.b		$e7,$18
	dc.b		$80,$8
	dc.b		$a0
	dc.b		$9e
	dc.b		$80
	dc.b		$9e
	smpsReturn

KEN_FM5_p3:
	dc.b		$80,$8
	dc.b		$9c
	dc.b		$80
	dc.b		$9c,$28
	smpsReturn

KEN_FM5_p4:
	dc.b		$e7,$30
	dc.b		$80,$8
	dc.b		$a7
	smpsReturn

KEN_FM5_p5:
	dc.b		$a5,$40
	smpsReturn

KEN_FM5_p6:
	dc.b		$e7,$28
	dc.b		$80,$8
	dc.b		$a5
	dc.b		$a7
	smpsReturn

KEN_FM5_p0:
	dc.b		$e7,$40
	smpsReturn

KEN_FM5_p8:
	dc.b		$e7,$28
	dc.b		$80,$8
	smpsFMvoice	$1
	dc.b		$a7
	dc.b		$a7
	smpsReturn

KEN_FM5_pa:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a7
	dc.b		$80,$10
	dc.b		$a7,$8
	dc.b		$80,$10
	dc.b		$ac,$8
	smpsReturn

KEN_FM5_pb:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80,$14
	dc.b		$ac,$10
	dc.b		$8
	smpsReturn

KEN_FM5_pc:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac
	smpsReturn

KEN_FM5_pe:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac,$10
	dc.b		$80
	smpsReturn

KEN_FM5_p10:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a7
	dc.b		$80,$10
	dc.b		$a7,$8
	dc.b		$80,$10
	dc.b		$b1,$8
	smpsReturn

KEN_FM5_p11:
	dc.b		$e7,$8
	dc.b		$80
	dc.b		$af
	dc.b		$80,$10
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM5_p12:
	dc.b		$80,$8
	dc.b		$a7
	dc.b		$80,$10
	dc.b		$ac
	dc.b		$80,$8
	dc.b		$a8
	smpsReturn

KEN_FM5_p14:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80,$10
	dc.b		$a5,$8
	smpsReturn

KEN_FM5_p16:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$b1
	dc.b		$80,$10
	dc.b		$a5,$8
	dc.b		$80,$18
	smpsReturn

KEN_FM5_p17:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$a7
	dc.b		$80
	dc.b		$ae
	dc.b		$80,$20
	smpsReturn

KEN_FM5_p1b:
	dc.b		$e7,$38
	smpsFMvoice	$1
	dc.b		$a7,$8
	smpsReturn

KEN_FM5_p1c:
	dc.b		$e7,$10
	dc.b		$af
	dc.b		$80,$8
	dc.b		$a7,$10
	dc.b		$4
	dc.b		$80
	smpsReturn

KEN_FM5_p1d:
	dc.b		$e7,$8
	dc.b		$af,$10
	dc.b		$80,$8
	dc.b		$a7,$4
	dc.b		$80
	dc.b		$ac,$8
	dc.b		$80,$10
	smpsReturn

KEN_FM5_p21:
	dc.b		$e7,$38
	smpsFMvoice	$1
	dc.b		$af,$8
	smpsReturn

KEN_FM5_p22:
	dc.b		$e7,$10
	dc.b		$ab,$4
	dc.b		$80,$14
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	smpsReturn

KEN_FM5_p23:
	dc.b		$e7,$8
	dc.b		$a7,$10
	dc.b		$80,$8
	dc.b		$ab,$4
	dc.b		$80
	dc.b		$a7,$10
	dc.b		$b1,$8
	smpsReturn

KEN_FM5_p24:
	dc.b		$e7,$10
	dc.b		$af,$8
	dc.b		$80,$10
	dc.b		$ac
	dc.b		$ac,$8
	smpsReturn

KEN_FM5_p25:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80,$10
	dc.b		$a8,$8
	smpsReturn

KEN_FM5_p26:
	dc.b		$e7,$8
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80,$14
	dc.b		$ac,$10
	dc.b		$8
	smpsReturn

KEN_FM5_p27:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$a5
	smpsReturn

KEN_FM5_p28:
	dc.b		$e7,$8
	dc.b		$a5,$4
	dc.b		$80
	dc.b		$ac
	dc.b		$80,$14
	dc.b		$ac,$10
	dc.b		$b1,$8
	smpsReturn

KEN_FM5_p29:
	dc.b		$80,$8
	dc.b		$b1
	dc.b		$80,$10
	dc.b		$b1,$8
	dc.b		$80,$18
	smpsReturn

KEN_FM5_p2a:
	dc.b		$e7,$38
	dc.b		$ae,$8
	smpsReturn

KEN_FM5_p2b:
	dc.b		$e7,$8
	dc.b		$ae,$4
	dc.b		$80
	dc.b		$ab
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ae
	dc.b		$80
	dc.b		$ab
	dc.b		$80,$c
	dc.b		$ac,$8
	smpsReturn

KEN_FM5_p2c:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80,$14
	dc.b		$b1,$8
	dc.b		$b1
	dc.b		$af
	smpsReturn

KEN_FM5_p2d:
	dc.b		$80,$8
	dc.b		$af
	dc.b		$80,$10
	dc.b		$af,$8
	dc.b		$80,$10
	dc.b		$a8,$8
	smpsReturn

KEN_FM5_p2e:
	dc.b		$e7,$8
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$af,$8
	dc.b		$80,$10
	dc.b		$a8,$4
	dc.b		$80
	dc.b		$a8
	dc.b		$80
	dc.b		$ac,$8
	smpsReturn

KEN_FM5_p2f:
	dc.b		$e7,$8
	dc.b		$ac,$10
	dc.b		$80,$8
	dc.b		$ac,$4
	dc.b		$80,$1c
	smpsReturn

KEN_FM5_p31:
	dc.b		$e7,$38
	smpsFMvoice	$1
	dc.b		$ac,$8
	smpsReturn

KEN_FM5_p32:
	dc.b		$e7,$10
	dc.b		$ac,$20
	dc.b		$80,$10
	smpsReturn

KEN_FM5_p33:
	dc.b		$e7,$10
	dc.b		$ac,$4
	dc.b		$80,$c
	dc.b		$a0,$2
	dc.b		$80,$16
	dc.b		$a7,$8
	smpsReturn

; Pattern data for PSG1
KEN_PSG1_p0:
	dc.b		$e7,$40
	smpsReturn

KEN_PSG1_p18:
	dc.b		$e7,$6
	smpsPSGvoice	$5
	dc.b		$b8,$18
	dc.b		$ba,$22
	smpsReturn

KEN_PSG1_p19:
	dc.b		$e7,$6
	dc.b		$bb,$18
	dc.b		$bd,$10
	dc.b		$bb,$8
	dc.b		$ba
	dc.b		$b8,$2
	smpsReturn

KEN_PSG1_p1a:
	dc.b		$e7,$6
	dc.b		$b4,$18
	dc.b		$bf,$22
	smpsReturn

KEN_PSG1_p1b:
	dc.b		$e7,$36
	dc.b		$bd,$8
	dc.b		$bf,$2
	smpsReturn

KEN_PSG1_p1d:
	dc.b		$e7,$3e
	dc.b		$80,$2
	smpsReturn

; Pattern data for PSG2
KEN_PSG2_p0:
	dc.b		$e7,$40
	smpsReturn

KEN_PSG2_p18:
	dc.b		$e7,$8
	smpsPSGvoice	$4
	dc.b		$b4
	dc.b		$b8
	dc.b		$bf,$28
	smpsReturn

KEN_PSG2_p19:
	dc.b		$80,$8
	dc.b		$b4
	dc.b		$b8
	dc.b		$bf,$10
	dc.b		$bb,$8
	dc.b		$ba
	dc.b		$b8
	smpsReturn

KEN_PSG2_p1a:
	dc.b		$e7,$8
	dc.b		$b1
	dc.b		$b4
	dc.b		$bb,$28
	smpsReturn

KEN_PSG2_p1b:
	dc.b		$80,$8
	dc.b		$b1
	dc.b		$b4
	dc.b		$80,$1
	dc.b		$bb,$f
	dc.b		$80,$18
	smpsReturn

KEN_PSG2_p20:
	dc.b		$e7,$8
	dc.b		$b6
	dc.b		$ba
	dc.b		$c2,$28
	smpsReturn

KEN_PSG2_p21:
	dc.b		$80,$8
	dc.b		$b6
	dc.b		$ba
	dc.b		$c2,$10
	dc.b		$c0,$8
	dc.b		$80,$10
	smpsReturn

; Pattern data for DAC
	include	"sound\DalekSam\KEN_DAC.asm"

KEN_Voices:
	dc.b	$3d,$1,$2,$2,$2,$10,$50,$50,$50,$7,$8,$8,$8,$1,$0,$0
	dc.b	$0,$20,$17,$17,$17,$1c,$88,$88,$88	; Voice 0 (Puto-Sawtooth)
	dc.b	$38,$33,$1,$51,$1,$10,$13,$1a,$1b,$f,$1f,$1f,$1f,$1,$1,$1
	dc.b	$1,$33,$3,$3,$8,$16,$1a,$19,$80	; Voice 1 (DangerousSeed-Jupiter-A:FM2 Distortion Synth 2 (Mod $1E, $01, $05, $05))
	dc.b	$38,$a,$70,$30,$0,$1f,$1f,$5f,$5f,$12,$e,$a,$a,$0,$4,$4
	dc.b	$3,$26,$26,$26,$26,$23,$2d,$12,$80	; Voice 2 (DangerousSeed-Jupiter-7)
	even
