; -------------------------------------------------------
; File created using XM4SMPS v4.0 (Qt 4.5.0-tp1 Win32)
; Created on Sun May 8 2011, 12:41:33
; -------------------------------------------------------

hockenhiem_Header:
	smpsHeaderVoice	hockenhiem_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$2, $4
	smpsHeaderDAC	hockenhiem_DAC
	smpsHeaderFM	hockenhiem_FM1,	$0, $a
	smpsHeaderFM	hockenhiem_FM2,	-36, $c
	smpsHeaderFM	hockenhiem_FM3,	-12, $e
	smpsHeaderFM	hockenhiem_FM4,	-12, $e
	smpsHeaderFM	hockenhiem_FM5,	-12, $e
	smpsHeaderPSG	hockenhiem_PSG1,	$dc, $3, $0
	smpsHeaderPSG	hockenhiem_PSG2,	$dc, $3, $0
	smpsHeaderPSG	hockenhiem_PSG3,	$df, $2, $0

	
hockenhiem_FM1:
	smpsCall	hockenhiem_FM1_p13
hockenhiem_FM1_Loop:
	smpsCall	hockenhiem_FM1_p0
	smpsCall	hockenhiem_FM1_p1
	smpsCall	hockenhiem_FM1_p0
	smpsCall	hockenhiem_FM1_p1
	smpsCall	hockenhiem_FM1_p0
	smpsCall	hockenhiem_FM1_p1
	smpsCall	hockenhiem_FM1_p0
	smpsCall	hockenhiem_FM1_p1
	smpsCall	hockenhiem_FM1_p7
	smpsCall	hockenhiem_FM1_p7
	smpsCall	hockenhiem_FM1_p7
	smpsCall	hockenhiem_FM1_pa
	smpsCall	hockenhiem_FM1_pb
	smpsCall	hockenhiem_FM1_pc
	smpsCall	hockenhiem_FM1_pb
	smpsCall	hockenhiem_FM1_pc
	smpsCall	hockenhiem_FM1_pe
	smpsCall	hockenhiem_FM1_pf
	smpsCall	hockenhiem_FM1_p10
	smpsCall	hockenhiem_FM1_p11
	smpsCall	hockenhiem_FM1_p12
	smpsJump	hockenhiem_FM1_Loop

hockenhiem_FM2:
	smpsCall	hockenhiem_FM2_p13
hockenhiem_FM2_Loop:
	smpsCall	hockenhiem_FM2_p0
	smpsCall	hockenhiem_FM2_p1
	smpsCall	hockenhiem_FM2_p1
	smpsCall	hockenhiem_FM2_p1
	smpsCall	hockenhiem_FM2_p4
	smpsCall	hockenhiem_FM2_p5
	smpsCall	hockenhiem_FM2_p4
	smpsCall	hockenhiem_FM2_p5
	smpsCall	hockenhiem_FM2_p1
	smpsCall	hockenhiem_FM2_p8
	smpsCall	hockenhiem_FM2_p8
	smpsCall	hockenhiem_FM2_p8
	smpsCall	hockenhiem_FM2_pb
	smpsCall	hockenhiem_FM2_pc
	smpsCall	hockenhiem_FM2_pb
	smpsCall	hockenhiem_FM2_pd
	smpsCall	hockenhiem_FM2_pe
	smpsCall	hockenhiem_FM2_pf
	smpsCall	hockenhiem_FM2_p10
	smpsCall	hockenhiem_FM2_p11
	smpsCall	hockenhiem_FM2_p12
	smpsJump	hockenhiem_FM2_Loop

hockenhiem_FM3:
	smpsPan		panRight,0
	smpsCall	hockenhiem_FM3_p13
hockenhiem_FM3_Loop:
	smpsCall	hockenhiem_FM3_p0
	smpsCall	hockenhiem_FM3_p1
	smpsCall	hockenhiem_FM3_p0
	smpsCall	hockenhiem_FM3_p1
	smpsCall	hockenhiem_FM3_p0
	smpsCall	hockenhiem_FM3_p5
	smpsCall	hockenhiem_FM3_p0
	smpsCall	hockenhiem_FM3_p5
	smpsCall	hockenhiem_FM3_p7
	smpsCall	hockenhiem_FM3_p7
	smpsCall	hockenhiem_FM3_p9
	smpsCall	hockenhiem_FM3_pa
	smpsCall	hockenhiem_FM3_pb
	smpsCall	hockenhiem_FM3_pc
	smpsCall	hockenhiem_FM3_pb
	smpsCall	hockenhiem_FM3_pc
	smpsCall	hockenhiem_FM3_pe
	smpsCall	hockenhiem_FM3_pe
	smpsCall	hockenhiem_FM3_pe
	smpsCall	hockenhiem_FM3_pe
	smpsCall	hockenhiem_FM3_p12
	smpsJump	hockenhiem_FM3_Loop

hockenhiem_FM4:
	smpsPan		panLeft,0
	smpsCall	hockenhiem_FM4_p13
hockenhiem_FM4_Loop:
	smpsCall	hockenhiem_FM4_p0
	smpsCall	hockenhiem_FM4_p1
	smpsCall	hockenhiem_FM4_p0
	smpsCall	hockenhiem_FM4_p1
	smpsCall	hockenhiem_FM4_p0
	smpsCall	hockenhiem_FM4_p5
	smpsCall	hockenhiem_FM4_p0
	smpsCall	hockenhiem_FM4_p5
	smpsCall	hockenhiem_FM4_p7
	smpsCall	hockenhiem_FM4_p7
	smpsCall	hockenhiem_FM4_p9
	smpsCall	hockenhiem_FM4_pa
	smpsCall	hockenhiem_FM4_pb
	smpsCall	hockenhiem_FM4_pc
	smpsCall	hockenhiem_FM4_pb
	smpsCall	hockenhiem_FM4_pc
	smpsCall	hockenhiem_FM4_pa
	smpsCall	hockenhiem_FM4_pa
	smpsCall	hockenhiem_FM4_pa
	smpsCall	hockenhiem_FM4_pa
	smpsCall	hockenhiem_FM4_p12
	smpsJump	hockenhiem_FM4_Loop

hockenhiem_FM5:
	smpsCall	hockenhiem_FM5_p13
hockenhiem_FM5_Loop:
	smpsCall	hockenhiem_FM5_p0
	smpsCall	hockenhiem_FM5_p1
	smpsCall	hockenhiem_FM5_p0
	smpsCall	hockenhiem_FM5_p1
	smpsCall	hockenhiem_FM5_p0
	smpsCall	hockenhiem_FM5_p5
	smpsCall	hockenhiem_FM5_p0
	smpsCall	hockenhiem_FM5_p5
	smpsCall	hockenhiem_FM5_p7
	smpsCall	hockenhiem_FM5_p7
	smpsCall	hockenhiem_FM5_p9
	smpsCall	hockenhiem_FM5_pa
	smpsCall	hockenhiem_FM5_pb
	smpsCall	hockenhiem_FM5_pc
	smpsCall	hockenhiem_FM5_pb
	smpsCall	hockenhiem_FM5_pc
	smpsCall	hockenhiem_FM5_pa
	smpsCall	hockenhiem_FM5_pa
	smpsCall	hockenhiem_FM5_pa
	smpsCall	hockenhiem_FM5_pa
	smpsCall	hockenhiem_FM5_p12
	smpsJump	hockenhiem_FM5_Loop

hockenhiem_PSG1:
	smpsCall	hockenhiem_PSG1_p13
hockenhiem_PSG1_Loop:
	smpsCall	hockenhiem_PSG1_p0
	smpsCall	hockenhiem_PSG1_p1
	smpsCall	hockenhiem_PSG1_p0
	smpsCall	hockenhiem_PSG1_p1
	smpsCall	hockenhiem_PSG1_p0
	smpsCall	hockenhiem_PSG1_p5
	smpsCall	hockenhiem_PSG1_p0
	smpsCall	hockenhiem_PSG1_p5
	smpsCall	hockenhiem_PSG1_p7
	smpsCall	hockenhiem_PSG1_p7
	smpsCall	hockenhiem_PSG1_p7
	smpsCall	hockenhiem_PSG1_p7
	smpsCall	hockenhiem_PSG1_pb
	smpsCall	hockenhiem_PSG1_pc
	smpsCall	hockenhiem_PSG1_pb
	smpsCall	hockenhiem_PSG1_pc
	smpsCall	hockenhiem_PSG1_pe
	smpsCall	hockenhiem_PSG1_pe
	smpsCall	hockenhiem_PSG1_pe
	smpsCall	hockenhiem_PSG1_pe
	smpsCall	hockenhiem_PSG1_p12
	smpsJump	hockenhiem_PSG1_Loop

hockenhiem_PSG2:
	smpsCall	hockenhiem_PSG2_p13
hockenhiem_PSG2_Loop:
	smpsCall	hockenhiem_PSG2_p0
	smpsCall	hockenhiem_PSG2_p1
	smpsCall	hockenhiem_PSG2_p0
	smpsCall	hockenhiem_PSG2_p1
	smpsCall	hockenhiem_PSG2_p0
	smpsCall	hockenhiem_PSG2_p5
	smpsCall	hockenhiem_PSG2_p0
	smpsCall	hockenhiem_PSG2_p5
	smpsCall	hockenhiem_PSG2_p7
	smpsCall	hockenhiem_PSG2_p8
	smpsCall	hockenhiem_PSG2_p7
	smpsCall	hockenhiem_PSG2_pa
	smpsCall	hockenhiem_PSG2_pb
	smpsCall	hockenhiem_PSG2_pc
	smpsCall	hockenhiem_PSG2_pb
	smpsCall	hockenhiem_PSG2_pc
	smpsCall	hockenhiem_PSG2_pe
	smpsCall	hockenhiem_PSG2_pe
	smpsCall	hockenhiem_PSG2_pe
	smpsCall	hockenhiem_PSG2_pe
	smpsCall	hockenhiem_PSG2_p12
	smpsJump	hockenhiem_PSG2_Loop

hockenhiem_PSG3:
	smpsPSGform	$E7
	smpsCall	hockenhiem_PSG3_p13
hockenhiem_PSG3_Loop:
	smpsCall	hockenhiem_PSG3_p0
	smpsCall	hockenhiem_PSG3_p0
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p6
	smpsCall	hockenhiem_PSG3_p7
	smpsCall	hockenhiem_PSG3_p7
	smpsCall	hockenhiem_PSG3_p7
	smpsCall	hockenhiem_PSG3_pa
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_pd
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p2
	smpsCall	hockenhiem_PSG3_p12
	smpsJump	hockenhiem_PSG3_Loop

hockenhiem_DAC:
	smpsCall	hockenhiem_DAC_p13
hockenhiem_DAC_Loop:
	smpsCall	hockenhiem_DAC_p0
	smpsCall	hockenhiem_DAC_p1
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_p3
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_p3
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_p6
	smpsCall	hockenhiem_DAC_p7
	smpsCall	hockenhiem_DAC_p8
	smpsCall	hockenhiem_DAC_p8
	smpsCall	hockenhiem_DAC_pa
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_p3
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_pd
	smpsCall	hockenhiem_DAC_p2
	smpsCall	hockenhiem_DAC_p3
	smpsCall	hockenhiem_DAC_p6
	smpsCall	hockenhiem_DAC_p11
	smpsCall	hockenhiem_DAC_p12
	smpsJump	hockenhiem_DAC_Loop


; Pattern data for FM1
hockenhiem_FM1_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_FM1_p0:
	smpsFMvoice	$2
	dc.b		$8f,$4
	dc.b		$8f
	dc.b		$8f
	dc.b		$8f,$2
	dc.b		$8f
	dc.b		$8f,$4
	dc.b		$8f
	dc.b		$8f
	dc.b		$8f,$2
	dc.b		$8f
	dc.b		$8f,$4
	dc.b		$8f
	dc.b		$8f
	dc.b		$8f,$2
	dc.b		$8f
	dc.b		$8f,$4
	dc.b		$8f
	dc.b		$8f
	dc.b		$9b,$2
	dc.b		$96
	smpsReturn

hockenhiem_FM1_p1:
	dc.b		$97,$4
	dc.b		$97
	dc.b		$97
	dc.b		$97,$2
	dc.b		$97
	dc.b		$97,$4
	dc.b		$97
	dc.b		$97
	dc.b		$97,$2
	dc.b		$97
	dc.b		$96,$4
	dc.b		$96
	dc.b		$96
	dc.b		$96,$2
	dc.b		$96
	dc.b		$8d,$4
	dc.b		$2
	dc.b		$99
	dc.b		$8d
	dc.b		$99
	dc.b		$8e
	dc.b		$9a
	smpsReturn

hockenhiem_FM1_p7:
	dc.b		$8f,$4
	dc.b		$90
	dc.b		$90
	dc.b		$8f
	dc.b		$90
	dc.b		$90
	dc.b		$8f
	dc.b		$90
	dc.b		$90
	dc.b		$8f
	dc.b		$90
	dc.b		$90
	dc.b		$99
	dc.b		$9b
	dc.b		$9c
	dc.b		$99
	smpsReturn

hockenhiem_FM1_pa:
	dc.b		$8d,$c
	dc.b		$99,$24
	dc.b		$97,$4
	dc.b		$96
	dc.b		$97
	dc.b		$92
	smpsReturn

hockenhiem_FM1_pb:
	dc.b		$94,$4
	dc.b		$94
	dc.b		$94
	dc.b		$94,$2
	dc.b		$94
	dc.b		$94,$4
	dc.b		$2
	dc.b		$a0
	dc.b		$94
	dc.b		$9e
	dc.b		$a0
	dc.b		$94
	dc.b		$92,$4
	dc.b		$92
	dc.b		$92
	dc.b		$92,$2
	dc.b		$92
	dc.b		$97,$4
	dc.b		$2
	dc.b		$a3
	dc.b		$96,$4
	dc.b		$2
	dc.b		$a2
	smpsReturn

hockenhiem_FM1_pc:
	dc.b		$92,$4
	dc.b		$92
	dc.b		$92
	dc.b		$92,$2
	dc.b		$92
	dc.b		$92,$4
	dc.b		$92
	dc.b		$9e,$2
	dc.b		$92
	dc.b		$92,$4
	dc.b		$90
	dc.b		$90
	dc.b		$90,$2
	dc.b		$90
	dc.b		$90,$4
	dc.b		$90
	dc.b		$90,$2
	dc.b		$8f
	dc.b		$92,$4
	dc.b		$2
	dc.b		$9e
	smpsReturn

hockenhiem_FM1_pe:
	dc.b		$94,$2
	dc.b		$a0
	dc.b		$94
	dc.b		$97,$4
	dc.b		$a3,$2
	dc.b		$99
	dc.b		$a5
	dc.b		$92
	dc.b		$9e
	dc.b		$92
	dc.b		$92,$4
	dc.b		$9e,$2
	dc.b		$93
	dc.b		$9f
	dc.b		$9b
	dc.b		$9e
	dc.b		$9b
	dc.b		$9e,$4
	dc.b		$9b,$2
	dc.b		$9e
	dc.b		$9b
	dc.b		$a2
	dc.b		$9b
	dc.b		$8f
	dc.b		$8f
	dc.b		$90
	dc.b		$90
	dc.b		$92
	dc.b		$92
	smpsReturn

hockenhiem_FM1_pf:
	dc.b		$9b,$6
	dc.b		$a7,$2
	dc.b		$a5
	dc.b		$a7
	dc.b		$a2
	dc.b		$99
	dc.b		$9b
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	dc.b		$a5
	dc.b		$a7
	dc.b		$a2
	dc.b		$9b
	dc.b		$96
	dc.b		$a2
	dc.b		$80
	dc.b		$a2
	dc.b		$a0
	dc.b		$a2
	dc.b		$9d
	dc.b		$96
	dc.b		$92
	dc.b		$9e
	dc.b		$94
	dc.b		$a0
	dc.b		$99
	dc.b		$99
	dc.b		$9d
	dc.b		$a9
	smpsReturn

hockenhiem_FM1_p10:
	dc.b		$a5,$2
	dc.b		$a7
	dc.b		$a2
	dc.b		$9d
	dc.b		$9b
	dc.b		$80
	dc.b		$a5
	dc.b		$a7
	dc.b		$a2
	dc.b		$9d
	dc.b		$80
	dc.b		$9b,$4
	dc.b		$a7,$2
	dc.b		$80
	dc.b		$a7
	dc.b		$a5
	dc.b		$a7
	dc.b		$a2
	dc.b		$9d
	dc.b		$9b
	dc.b		$80
	dc.b		$a5
	dc.b		$a7
	dc.b		$a2
	dc.b		$9d
	dc.b		$80
	dc.b		$9b
	dc.b		$80
	dc.b		$a7
	dc.b		$80
	dc.b		$a7
	smpsReturn

hockenhiem_FM1_p11:
	dc.b		$9b,$2
	dc.b		$9b
	dc.b		$9d
	dc.b		$9d
	dc.b		$9e
	dc.b		$9e
	dc.b		$9d
	dc.b		$9d
	dc.b		$9e
	dc.b		$9e
	dc.b		$a0
	dc.b		$a0
	dc.b		$99
	dc.b		$99
	dc.b		$9d
	dc.b		$9d
	dc.b		$97
	dc.b		$97
	dc.b		$99
	dc.b		$99
	dc.b		$9b
	dc.b		$9b
	dc.b		$99
	dc.b		$99
	dc.b		$9b
	dc.b		$9b
	dc.b		$9d
	dc.b		$9d
	dc.b		$9e
	dc.b		$9e
	dc.b		$9d
	dc.b		$9d
	smpsReturn

hockenhiem_FM1_p12:
	dc.b		$8d,$8
	dc.b		$8d
	dc.b		$8d
	dc.b		$8d
	smpsReturn

; Pattern data for FM2
hockenhiem_FM2_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_FM2_p0:
	dc.b		$80,$40
	smpsReturn

hockenhiem_FM2_p1:
	dc.b		$80,$40
	smpsReturn

hockenhiem_FM2_p4:
    smpsModSet			$08, $03, $E7, $D7
	smpsFMvoice	$1
	dc.b		$bf,$8
	smpsAlterVol		$02 
	dc.b		$bf
	smpsAlterVol		$02 ;4
	dc.b		$bf
	smpsAlterVol		$02 ;6
	dc.b		$bf
	smpsAlterVol		$02 ;8
	dc.b		$bf
	smpsAlterVol		$02 ;A
	dc.b		$bf
	smpsAlterVol		$02 ;C
	dc.b		$bf
	smpsAlterVol		$02 ;E
	dc.b		$bf
	smpsReturn

hockenhiem_FM2_p5:
    smpsModSet			$08, $03, $04, $04
	smpsAlterVol		$F2
	dc.b		$af,$20
	dc.b		$b1
	smpsReturn

hockenhiem_FM2_p8:
	dc.b		$e7,$40
	smpsReturn

hockenhiem_FM2_pb:
	smpsFMvoice	$1
	dc.b		$c4,$2
	dc.b		$bf
	dc.b		$c6
	dc.b		$bf
	dc.b		$c7
	dc.b		$bf
	dc.b		$c9
	dc.b		$bf
	dc.b		$c6
	dc.b		$bf
	dc.b		$c7
	dc.b		$bf
	dc.b		$c9
	dc.b		$bf
	dc.b		$c6
	dc.b		$bf
	dc.b		$c7
	dc.b		$bf
	dc.b		$c4
	dc.b		$bf
	dc.b		$c6
	dc.b		$bf
	dc.b		$c2
	dc.b		$bf
	dc.b		$c4
	dc.b		$b8
	dc.b		$bf
	dc.b		$b8
	dc.b		$c2
	dc.b		$b8
	dc.b		$c1
	dc.b		$b8
	smpsReturn

hockenhiem_FM2_pc:
	dc.b		$bd,$2
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$bb
	dc.b		$b6
	dc.b		$bd
	dc.b		$b6
	dc.b		$bb
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$b8
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$bb
	dc.b		$b4
	dc.b		$b8
	dc.b		$b4
	dc.b		$ba
	dc.b		$b4
	dc.b		$bb
	dc.b		$b4
	dc.b		$ba
	dc.b		$b1
	dc.b		$b6
	dc.b		$b1
	dc.b		$b8
	dc.b		$b1
	dc.b		$ba
	dc.b		$b1
	smpsReturn

hockenhiem_FM2_pd:
	dc.b		$bd,$2
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$bb
	dc.b		$b6
	dc.b		$bd
	dc.b		$b6
	dc.b		$bb
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$b8
	dc.b		$b6
	dc.b		$ba
	dc.b		$b6
	dc.b		$b8,$c
	dc.b		$ba
	dc.b		$b3,$8
	smpsReturn

hockenhiem_FM2_pe:
	dc.b		$80,$4
	smpsFMvoice	$2
	smpsAlterVol		$04	
	dc.b		$b8,$2
	dc.b		$c4
	dc.b		$b8
	dc.b		$bb,$4
	dc.b		$c7,$2
	dc.b		$bd
	dc.b		$c9
	dc.b		$b6
	dc.b		$c2
	dc.b		$b6
	dc.b		$b6,$4
	dc.b		$c2,$2
	dc.b		$b7
	dc.b		$c3
	dc.b		$bf
	dc.b		$c2
	dc.b		$bf
	dc.b		$c2,$4
	dc.b		$bf,$2
	dc.b		$c2
	dc.b		$bf
	dc.b		$c6
	dc.b		$bf
	dc.b		$b3
	dc.b		$b3
	dc.b		$b4
	dc.b		$b4
	smpsReturn

hockenhiem_FM2_pf:
	dc.b		$b6,$2
	dc.b		$b6
	dc.b		$bf,$6
	dc.b		$cb,$2
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$bd
	dc.b		$bf
	dc.b		$cb
	dc.b		$80
	dc.b		$cb
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$bf
	dc.b		$ba
	dc.b		$c6
	dc.b		$80
	dc.b		$c6
	dc.b		$c4
	dc.b		$c6
	dc.b		$c1
	dc.b		$ba
	dc.b		$b6
	dc.b		$c2
	dc.b		$b8
	dc.b		$c4
	dc.b		$bd
	dc.b		$bd
	smpsReturn

hockenhiem_FM2_p10:
	dc.b		$c1,$2
	dc.b		$cd
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$c1
	dc.b		$bf
	dc.b		$80
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$c1
	dc.b		$80
	dc.b		$bf,$4
	dc.b		$cb,$2
	dc.b		$80
	dc.b		$cb
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$c1
	dc.b		$bf
	dc.b		$80
	dc.b		$c9
	dc.b		$cb
	dc.b		$c6
	dc.b		$c1
	dc.b		$80
	dc.b		$bf
	dc.b		$80
	dc.b		$cb
	smpsReturn

hockenhiem_FM2_p11:
	dc.b		$80,$2
	dc.b		$cb
	dc.b		$bf
	dc.b		$bf
	dc.b		$c1
	dc.b		$c1
	dc.b		$c2
	dc.b		$c2
	dc.b		$c1
	dc.b		$c1
	dc.b		$c2
	dc.b		$c2
	dc.b		$c4
	dc.b		$c4
	dc.b		$bd
	dc.b		$bd
	dc.b		$c1
	dc.b		$c1
	dc.b		$bb
	dc.b		$bb
	dc.b		$bd
	dc.b		$bd
	dc.b		$bf
	dc.b		$bf
	dc.b		$bd
	dc.b		$bd
	dc.b		$bf
	dc.b		$bf
	dc.b		$c1
	dc.b		$c1
	dc.b		$c2
	dc.b		$c2
	smpsReturn

hockenhiem_FM2_p12:
	dc.b		$c1,$2
	dc.b		$c1
	dc.b		$80,$1c
	smpsAlterVol		$FB
	smpsReturn

; Pattern data for FM3
hockenhiem_FM3_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_FM3_p0:
	smpsFMvoice	$0
	dc.b		$a7,$4
	dc.b		$a7
	dc.b		$a7
	dc.b		$a7,$2
	dc.b		$a7
	dc.b		$a7,$4
	dc.b		$a7
	dc.b		$a7
	dc.b		$a7,$2
	dc.b		$a7
	dc.b		$a7,$4
	dc.b		$a7
	dc.b		$a7
	dc.b		$a7,$2
	dc.b		$a7
	dc.b		$a7,$4
	dc.b		$a7
	dc.b		$a7
	dc.b		$b3,$2
	dc.b		$ae
	smpsReturn

hockenhiem_FM3_p1:
	dc.b		$af,$4
	dc.b		$af
	dc.b		$af
	dc.b		$af,$2
	dc.b		$af
	dc.b		$af,$4
	dc.b		$af
	dc.b		$af
	dc.b		$af,$2
	dc.b		$af
	dc.b		$ae,$4
	dc.b		$ae
	dc.b		$ae
	dc.b		$ae,$2
	dc.b		$ae
	dc.b		$a5,$4
	dc.b		$2
	dc.b		$b1
	dc.b		$a5
	dc.b		$b1
	dc.b		$a6
	dc.b		$b2
	smpsReturn

hockenhiem_FM3_p5:
	dc.b		$af,$20
	dc.b		$b1
	smpsReturn

hockenhiem_FM3_p7:
	dc.b		$a7,$3
	dc.b		$80,$9
	dc.b		$a7,$3
	dc.b		$80,$9
	dc.b		$a7,$3
	dc.b		$80,$9
	dc.b		$a7,$3
	dc.b		$80,$9
	dc.b		$a8,$8
	dc.b		$a7
	smpsReturn

hockenhiem_FM3_p9:
	dc.b		$b3,$3
	dc.b		$80,$9
	dc.b		$b3,$3
	dc.b		$80,$9
	dc.b		$b3,$3
	dc.b		$80,$9
	dc.b		$b3,$3
	dc.b		$80,$9
	dc.b		$b4,$8
	dc.b		$b3
	smpsReturn

hockenhiem_FM3_pa:
	dc.b		$b3,$4
	dc.b		$b1
	dc.b		$b3
	dc.b		$b4,$34
	smpsReturn

hockenhiem_FM3_pb:
	dc.b		$ac,$20
	dc.b		$aa
	smpsReturn

hockenhiem_FM3_pc:
	dc.b		$aa,$20
	dc.b		$a8,$10
	dc.b		$aa
	smpsReturn

hockenhiem_FM3_pe:
	dc.b		$80,$40
	smpsReturn

hockenhiem_FM3_p12:
	dc.b		$80,$20
	smpsReturn

; Pattern data for FM4
hockenhiem_FM4_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_FM4_p0:
	smpsFMvoice	$0
	dc.b		$a2,$4
	dc.b		$a2
	dc.b		$a2
	dc.b		$a2,$2
	dc.b		$a2
	dc.b		$a2,$4
	dc.b		$a2
	dc.b		$a2
	dc.b		$a2,$2
	dc.b		$a2
	dc.b		$a2,$4
	dc.b		$a2
	dc.b		$a2
	dc.b		$a2,$2
	dc.b		$a2
	dc.b		$a2,$4
	dc.b		$a2
	dc.b		$a2
	dc.b		$ae,$2
	dc.b		$a9
	smpsReturn

hockenhiem_FM4_p1:
	dc.b		$aa,$4
	dc.b		$aa
	dc.b		$aa
	dc.b		$aa,$2
	dc.b		$aa
	dc.b		$aa,$4
	dc.b		$aa
	dc.b		$aa
	dc.b		$aa,$2
	dc.b		$aa
	dc.b		$a9,$4
	dc.b		$a9
	dc.b		$a9
	dc.b		$a9,$2
	dc.b		$a9
	dc.b		$a0,$4
	dc.b		$2
	dc.b		$ac
	dc.b		$a0
	dc.b		$ac
	dc.b		$a1
	dc.b		$ad
	smpsReturn

hockenhiem_FM4_p5:
	dc.b		$aa,$20
	dc.b		$ac
	smpsReturn

hockenhiem_FM4_p7:
	dc.b		$a2,$3
	dc.b		$80,$9
	dc.b		$a2,$3
	dc.b		$80,$9
	dc.b		$a2,$3
	dc.b		$80,$9
	dc.b		$a2,$3
	dc.b		$80,$9
	dc.b		$a3,$8
	dc.b		$a2
	smpsReturn

hockenhiem_FM4_p9:
	dc.b		$ae,$3
	dc.b		$80,$9
	dc.b		$ae,$3
	dc.b		$80,$9
	dc.b		$ae,$3
	dc.b		$80,$9
	dc.b		$ae,$3
	dc.b		$80,$9
	dc.b		$af,$8
	dc.b		$ae
	smpsReturn

hockenhiem_FM4_pa:
	dc.b		$80,$40
	smpsReturn

hockenhiem_FM4_pb:
	smpsFMvoice	$0
	dc.b		$a7,$20
	dc.b		$a5
	smpsReturn

hockenhiem_FM4_pc:
	dc.b		$a5,$20
	dc.b		$a3,$10
	dc.b		$a5
	smpsReturn

hockenhiem_FM4_p12:
	dc.b		$80,$20
	smpsReturn

; Pattern data for FM5
hockenhiem_FM5_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_FM5_p0:
	smpsFMvoice	$0
	dc.b		$9b,$4
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b,$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b,$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$9b
	dc.b		$9b
	dc.b		$9b,$2
	dc.b		$9b
	dc.b		$9b,$4
	dc.b		$9b
	dc.b		$9b
	dc.b		$a7,$2
	dc.b		$a2
	smpsReturn

hockenhiem_FM5_p1:
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3
	dc.b		$a3,$2
	dc.b		$a3
	dc.b		$a3,$4
	dc.b		$a3
	dc.b		$a3
	dc.b		$a3,$2
	dc.b		$a3
	dc.b		$a2,$4
	dc.b		$a2
	dc.b		$a2
	dc.b		$a2,$2
	dc.b		$a2
	dc.b		$99,$4
	dc.b		$2
	dc.b		$a5
	dc.b		$99
	dc.b		$a5
	dc.b		$9a
	dc.b		$a6
	smpsReturn

hockenhiem_FM5_p5:
	dc.b		$a3,$20
	dc.b		$a5
	smpsReturn

hockenhiem_FM5_p7:
	dc.b		$9b,$3
	dc.b		$80,$1
	dc.b		$a7
	dc.b		$80,$3
	dc.b		$a7,$1
	dc.b		$80,$3
	dc.b		$9b
	dc.b		$80,$1
	dc.b		$a7
	dc.b		$80,$3
	dc.b		$a7,$1
	dc.b		$80,$3
	dc.b		$9b
	dc.b		$80,$1
	dc.b		$a7
	dc.b		$80,$3
	dc.b		$a7,$1
	dc.b		$80,$3
	dc.b		$9b
	dc.b		$80,$1
	dc.b		$a7
	dc.b		$80,$3
	dc.b		$a7,$1
	dc.b		$80,$3
	dc.b		$9c,$8
	dc.b		$9b
	smpsReturn

hockenhiem_FM5_p9:
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$b3
	dc.b		$80,$3
	dc.b		$b3,$1
	dc.b		$80,$3
	dc.b		$a7
	dc.b		$80,$1
	dc.b		$b3
	dc.b		$80,$3
	dc.b		$b3,$1
	dc.b		$80,$3
	dc.b		$a7
	dc.b		$80,$1
	dc.b		$b3
	dc.b		$80,$3
	dc.b		$b3,$1
	dc.b		$80,$3
	dc.b		$a7
	dc.b		$80,$1
	dc.b		$b3
	dc.b		$80,$3
	dc.b		$b3,$1
	dc.b		$80,$3
	dc.b		$a8,$8
	dc.b		$a7
	smpsReturn

hockenhiem_FM5_pa:
	dc.b		$80,$40
	smpsReturn

hockenhiem_FM5_pb:
	smpsFMvoice	$0
	dc.b		$a0,$20
	dc.b		$9e
	smpsReturn

hockenhiem_FM5_pc:
	dc.b		$9e,$20
	dc.b		$9c,$10
	dc.b		$9e
	smpsReturn

hockenhiem_FM5_p12:
	dc.b		$80,$20
	smpsReturn

; Pattern data for PSG1
hockenhiem_PSG1_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_PSG1_p0:
	smpsPSGvoice	$0
	smpsModSet  $13, $02, $01, $01	
	dc.b		$ae,$40
	smpsReturn

hockenhiem_PSG1_p1:
	dc.b		$b6,$20
	dc.b		$b5,$10
	dc.b		$ac
	smpsReturn

hockenhiem_PSG1_p5:
	dc.b		$b6,$20
	dc.b		$b8
	smpsReturn

hockenhiem_PSG1_p7:
	dc.b		$ba,$40
	smpsReturn

hockenhiem_PSG1_pb:
	dc.b		$b3,$20
	dc.b		$b3
	smpsReturn

hockenhiem_PSG1_pc:
	dc.b		$b1,$20
	dc.b		$b3
	smpsReturn

hockenhiem_PSG1_pe:
	dc.b		$80,$40
	smpsReturn

hockenhiem_PSG1_p12:
	dc.b		$80,$20
	smpsReturn

; Pattern data for PSG2
hockenhiem_PSG2_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_PSG2_p0:
	smpsPSGvoice	$0
	smpsModSet  $13, $02, $01, $01	
	dc.b		$b3,$40
	smpsReturn

hockenhiem_PSG2_p1:
	dc.b		$bb,$20
	dc.b		$ba,$10
	dc.b		$b1
	smpsReturn

hockenhiem_PSG2_p5:
	dc.b		$bb,$20
	dc.b		$bd
	smpsReturn

hockenhiem_PSG2_p7:
	dc.b		$bf,$30
	dc.b		$bd,$4
	dc.b		$bf
	dc.b		$c0
	dc.b		$bd
	smpsReturn

hockenhiem_PSG2_p8:
	dc.b		$bf,$30
	dc.b		$bd,$4
	dc.b		$c0
	dc.b		$bf
	dc.b		$bd
	smpsReturn

hockenhiem_PSG2_pa:
	dc.b		$bd,$40
	smpsReturn

hockenhiem_PSG2_pb:
	dc.b		$b8,$20
	dc.b		$b6
	smpsReturn

hockenhiem_PSG2_pc:
	dc.b		$b5,$20
	dc.b		$b6
	smpsReturn

hockenhiem_PSG2_pe:
	dc.b		$80,$40
	smpsReturn

hockenhiem_PSG2_p12:
	dc.b		$80,$20
	smpsReturn

; Pattern data for PSG3 (Noise)
hockenhiem_PSG3_p13:
	dc.b		$80,$10
	smpsReturn

hockenhiem_PSG3_p0:
	smpsPSGvoice	$1
	dc.b		$82,$8
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsReturn

hockenhiem_PSG3_p2:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	smpsReturn

hockenhiem_PSG3_p6:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$80
	smpsReturn

hockenhiem_PSG3_p7:
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	smpsReturn

hockenhiem_PSG3_pa:
	smpsPSGvoice	$2
	dc.b		$82,$4
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsPSGvoice	$2
	dc.b		$82
	smpsReturn

hockenhiem_PSG3_pd:
	smpsPSGvoice	$2
	dc.b		$82,$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$4
	smpsPSGvoice	$2
	dc.b		$2
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82,$8
	dc.b		$82
	dc.b		$82
	smpsReturn

hockenhiem_PSG3_p12:
	smpsPSGvoice	$2
	dc.b		$82,$8
	dc.b		$82
	dc.b		$82
	smpsPSGvoice	$1
	dc.b		$82
	smpsReturn
	
; Pattern data for DAC
	include	"sound\DalekSam\hockenhiem_DAC.asm"

hockenhiem_Voices:
	dc.b	$38,$dc,$f4,$36,$8,$1b,$13,$1a,$1b,$e,$0,$8,$a,$0,$5,$5
	dc.b	$2,$34,$5,$14,$15,$1a,$19,$18,$80	; Voice 0 (G:\Sam\hax\music\graveyard_1.tfi)
	dc.b	$39,$38,$d8,$8,$8,$90,$8f,$94,$91,$9,$6,$3,$3,$0,$0,$0
	dc.b	$0,$38,$17,$16,$17,$16,$18,$1a,$80	; Voice 1 (G:\Sam\hax\music\graveyard_0.tfi)
	dc.b	$20,$fb,$0,$31,$1,$1e,$1f,$1f,$1f,$c,$11,$11,$c,$2,$c,$2
	dc.b	$1,$1d,$25,$36,$6,$11,$2e,$10,$80	; Voice 2 (G:\Sam\hax\music\airpassage_2.tfi)
	even
