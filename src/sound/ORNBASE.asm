; -------------------------------------------------------
; File created using XM4SMPS v4.1-beta (Qt 3.2.1 Win32)
; Created on Sat Jul 21 2012, 23:05:20
; -------------------------------------------------------

ORNBASE_Kick = $81
ORNBASE_Snare = $82
ORNBASE_HighTom = $A7
ORNBASE_MidTom = $A8
ORNBASE_LowTom = $A9
ORNBASE_Cymbal = $AA

ORNBASE_Header:
	smpsHeaderVoice	ORNBASE_Voices
	smpsHeaderChan	6,3
	smpsHeaderTempo	$1, $5
	smpsHeaderDAC	ORNBASE_DAC
	smpsHeaderFM	ORNBASE_FM5,	  2,  7		; bass
	smpsHeaderFM	ORNBASE_FM2,	-10,  9		; lead
	smpsHeaderFM	ORNBASE_FM3,	-10,  9		; lead 2
	smpsHeaderFM	ORNBASE_FM1,	-10,  7		; bass 2
	smpsHeaderFM	ORNBASE_FM4,	-22, 17		; backing
	smpsHeaderPSG	ORNBASE_PSG1,	-46,  0,  0
	smpsHeaderPSG	ORNBASE_PSG2,	-46,  4,  0
	smpsHeaderPSG	ORNBASE_PSG3,	-46,  1,  0

ORNBASE_MODB: ; Bass
	smpsModSet	$1E, $01, $05, $05
	smpsReturn
ORNBASE_ModS: ; Trumpet
	smpsModSet  $10, $01, $02, $04
	smpsReturn
ORNBASE_ModPSG:
	smpsModSet  $10, $01, $01, $02
	smpsReturn	
ORNBASE_ModPSG2:
	smpsModSet  $13, $02, $01, $01
	smpsReturn		
	
ORNBASE_FM1:
	smpsPan		panRight,0
	smpsCall	ORNBASE_MODB
	smpsCall	ORNBASE_FM1_p0
	smpsCall	ORNBASE_FM1_p1
ORNBASE_FM1_Loop:
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p8
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p8
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_pd
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_pd
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_pd
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_pd
	smpsCall	ORNBASE_FM1_p3
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p14
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p1
	smpsCall	ORNBASE_FM1_p2d
	smpsCall	ORNBASE_FM1_p1
	smpsJump	ORNBASE_FM1_Loop

ORNBASE_FM2:
	smpsPan		panLeft,0
	smpsCall	ORNBASE_MODS
	smpsCall	ORNBASE_FM2_p0
	smpsCall	ORNBASE_FM2_p1
ORNBASE_FM2_Loop:
	smpsCall	ORNBASE_FM2_p2
	smpsCall	ORNBASE_FM2_p3
	smpsCall	ORNBASE_FM2_p4
	smpsCall	ORNBASE_FM2_p1
	smpsCall	ORNBASE_FM2_p2
	smpsCall	ORNBASE_FM2_p7
	smpsCall	ORNBASE_FM2_p8
	smpsCall	ORNBASE_FM2_p1
	smpsCall	ORNBASE_FM2_p2
	smpsCall	ORNBASE_FM2_p3
	smpsCall	ORNBASE_FM2_p4
	smpsCall	ORNBASE_FM2_p1
	smpsCall	ORNBASE_FM2_p2
	smpsCall	ORNBASE_FM2_p9
	smpsCall	ORNBASE_FM2_pa
	smpsCall	ORNBASE_FM2_pb
	smpsCall	ORNBASE_FM2_pc
	smpsCall	ORNBASE_FM2_pd
	smpsCall	ORNBASE_FM2_pe
	smpsCall	ORNBASE_FM2_pb
	smpsCall	ORNBASE_FM2_pc
	smpsCall	ORNBASE_FM2_p8
	smpsCall	ORNBASE_FM2_p12
	smpsCall	ORNBASE_FM2_pb
	smpsCall	ORNBASE_FM2_pc
	smpsCall	ORNBASE_FM2_pd
	smpsCall	ORNBASE_FM2_pe
	smpsCall	ORNBASE_FM2_pb
	smpsCall	ORNBASE_FM2_pc
	smpsCall	ORNBASE_FM2_p8
	smpsCall	ORNBASE_FM2_p13
	smpsCall	ORNBASE_FM2_p14
	smpsCall	ORNBASE_FM2_p15
	smpsCall	ORNBASE_FM2_p16
	smpsCall	ORNBASE_FM2_p17
	smpsCall	ORNBASE_FM2_p18
	smpsCall	ORNBASE_FM2_p19
	smpsCall	ORNBASE_FM2_p1a
	smpsCall	ORNBASE_FM2_p1b
	smpsCall	ORNBASE_FM2_p14
	smpsCall	ORNBASE_FM2_p15
	smpsCall	ORNBASE_FM2_p16
	smpsCall	ORNBASE_FM2_p17
	smpsCall	ORNBASE_FM2_p18
	smpsCall	ORNBASE_FM2_p19
	smpsCall	ORNBASE_FM2_p1a
	smpsCall	ORNBASE_FM2_p1d
	smpsCall	ORNBASE_FM2_p1e
	smpsCall	ORNBASE_FM2_p1f
	smpsCall	ORNBASE_FM2_p20
	smpsCall	ORNBASE_FM2_p21
	smpsCall	ORNBASE_FM2_p22
	smpsCall	ORNBASE_FM2_p23
	smpsCall	ORNBASE_FM2_p24
	smpsCall	ORNBASE_FM2_p21
	smpsCall	ORNBASE_FM2_p1e
	smpsCall	ORNBASE_FM2_p1f
	smpsCall	ORNBASE_FM2_p20
	smpsCall	ORNBASE_FM2_p21
	smpsCall	ORNBASE_FM2_p22
	smpsCall	ORNBASE_FM2_p23
	smpsCall	ORNBASE_FM2_p24
	smpsCall	ORNBASE_FM2_p26
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p28
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p2a
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p28
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p2c
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p28
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p2a
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p28
	smpsCall	ORNBASE_FM2_p27
	smpsCall	ORNBASE_FM2_p2d
	smpsCall	ORNBASE_FM2_p1
	smpsJump	ORNBASE_FM2_Loop

ORNBASE_FM3:
	smpsPan		panRight,0
	smpsCall	ORNBASE_MODS
	smpsCall	ORNBASE_FM3_p0
	smpsCall	ORNBASE_FM3_p1
ORNBASE_FM3_Loop:
	smpsCall	ORNBASE_FM3_p2
	smpsCall	ORNBASE_FM3_p3
	smpsCall	ORNBASE_FM3_p4
	smpsCall	ORNBASE_FM3_p1
	smpsCall	ORNBASE_FM3_p2
	smpsCall	ORNBASE_FM3_p7
	smpsCall	ORNBASE_FM3_p8
	smpsCall	ORNBASE_FM3_p1
	smpsCall	ORNBASE_FM3_p2
	smpsCall	ORNBASE_FM3_p3
	smpsCall	ORNBASE_FM3_p4
	smpsCall	ORNBASE_FM3_p1
	smpsCall	ORNBASE_FM3_p2
	smpsCall	ORNBASE_FM3_p9
	smpsCall	ORNBASE_FM3_pa
	smpsCall	ORNBASE_FM3_pb
	smpsCall	ORNBASE_FM3_pc
	smpsCall	ORNBASE_FM3_pd
	smpsCall	ORNBASE_FM3_pe
	smpsCall	ORNBASE_FM3_pb
	smpsCall	ORNBASE_FM3_pc
	smpsCall	ORNBASE_FM3_p11
	smpsCall	ORNBASE_FM3_p12
	smpsCall	ORNBASE_FM3_pb
	smpsCall	ORNBASE_FM3_pc
	smpsCall	ORNBASE_FM3_pd
	smpsCall	ORNBASE_FM3_pe
	smpsCall	ORNBASE_FM3_pb
	smpsCall	ORNBASE_FM3_pc
	smpsCall	ORNBASE_FM3_p11
	smpsCall	ORNBASE_FM3_p13
	smpsCall	ORNBASE_FM3_p14
	smpsCall	ORNBASE_FM3_p15
	smpsCall	ORNBASE_FM3_p16
	smpsCall	ORNBASE_FM3_p17
	smpsCall	ORNBASE_FM3_p18
	smpsCall	ORNBASE_FM3_p19
	smpsCall	ORNBASE_FM3_p1a
	smpsCall	ORNBASE_FM3_p1b
	smpsCall	ORNBASE_FM3_p14
	smpsCall	ORNBASE_FM3_p15
	smpsCall	ORNBASE_FM3_p16
	smpsCall	ORNBASE_FM3_p17
	smpsCall	ORNBASE_FM3_p18
	smpsCall	ORNBASE_FM3_p19
	smpsCall	ORNBASE_FM3_p1a
	smpsCall	ORNBASE_FM3_p1d
	smpsCall	ORNBASE_FM3_p1e
	smpsCall	ORNBASE_FM3_p1f
	smpsCall	ORNBASE_FM3_p20
	smpsCall	ORNBASE_FM3_p21
	smpsCall	ORNBASE_FM3_p22
	smpsCall	ORNBASE_FM3_p23
	smpsCall	ORNBASE_FM3_p24
	smpsCall	ORNBASE_FM3_p21
	smpsCall	ORNBASE_FM3_p1e
	smpsCall	ORNBASE_FM3_p1f
	smpsCall	ORNBASE_FM3_p20
	smpsCall	ORNBASE_FM3_p21
	smpsCall	ORNBASE_FM3_p22
	smpsCall	ORNBASE_FM3_p23
	smpsCall	ORNBASE_FM3_p24
	smpsCall	ORNBASE_FM3_p26
	smpsCall	ORNBASE_FM3_p27
	smpsCall	ORNBASE_FM3_p28
	smpsCall	ORNBASE_FM3_p29
	smpsCall	ORNBASE_FM3_p2a
	smpsCall	ORNBASE_FM3_p27
	smpsCall	ORNBASE_FM3_p28
	smpsCall	ORNBASE_FM3_p29
	smpsCall	ORNBASE_FM3_p2c
	smpsCall	ORNBASE_FM3_p27
	smpsCall	ORNBASE_FM3_p28
	smpsCall	ORNBASE_FM3_p29
	smpsCall	ORNBASE_FM3_p2a
	smpsCall	ORNBASE_FM3_p27
	smpsCall	ORNBASE_FM3_p28
	smpsCall	ORNBASE_FM3_p29
	smpsCall	ORNBASE_FM3_p2d
	smpsCall	ORNBASE_FM3_p1
	smpsJump	ORNBASE_FM3_Loop

ORNBASE_FM4:
	smpsCall	ORNBASE_MODS
	smpsCall	ORNBASE_FM4_p0
	smpsCall	ORNBASE_FM4_p1
ORNBASE_FM4_Loop:
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_p3
	smpsCall	ORNBASE_FM4_p4
	smpsCall	ORNBASE_FM4_p1
	smpsCall	ORNBASE_FM4_p6
	smpsCall	ORNBASE_FM4_p7
	smpsCall	ORNBASE_FM4_p8
	smpsCall	ORNBASE_FM4_p1
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_p3
	smpsCall	ORNBASE_FM4_p4
	smpsCall	ORNBASE_FM4_p1
	smpsCall	ORNBASE_FM4_p6
	smpsCall	ORNBASE_FM4_p7
	smpsCall	ORNBASE_FM4_pa
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_pd
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p10
	smpsCall	ORNBASE_FM4_p11
	smpsCall	ORNBASE_FM4_p8
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_pd
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p10
	smpsCall	ORNBASE_FM4_p11
	smpsCall	ORNBASE_FM4_p8
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p17
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p14
	smpsCall	ORNBASE_FM4_p17
	smpsCall	ORNBASE_FM4_pb
	smpsCall	ORNBASE_FM4_p2
	smpsCall	ORNBASE_FM4_p11
	smpsCall	ORNBASE_FM4_p11
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p21
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p25
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p1e
	smpsCall	ORNBASE_FM4_p21
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p22
	smpsCall	ORNBASE_FM4_p25
	smpsCall	ORNBASE_FM4_p27
	smpsCall	ORNBASE_FM4_p28
	smpsCall	ORNBASE_FM4_p29
	smpsCall	ORNBASE_FM4_p2a
	smpsCall	ORNBASE_FM4_p27
	smpsCall	ORNBASE_FM4_p28
	smpsCall	ORNBASE_FM4_p29
	smpsCall	ORNBASE_FM4_p2c
	smpsCall	ORNBASE_FM4_p27
	smpsCall	ORNBASE_FM4_p28
	smpsCall	ORNBASE_FM4_p29
	smpsCall	ORNBASE_FM4_p2a
	smpsCall	ORNBASE_FM4_p27
	smpsCall	ORNBASE_FM4_p28
	smpsCall	ORNBASE_FM4_p29
	smpsCall	ORNBASE_FM4_p2d
	smpsCall	ORNBASE_FM4_p1
	smpsJump	ORNBASE_FM4_Loop

ORNBASE_FM5:
	smpsPan		panLeft,0
	smpsCall	ORNBASE_MODB
	smpsCall	ORNBASE_FM1_p0
	smpsCall	ORNBASE_FM1_p1
	smpsJump	ORNBASE_FM1_Loop

	smpsCall	ORNBASE_MODS
	smpsCall	ORNBASE_FM5_p0
	smpsCall	ORNBASE_FM5_p1
ORNBASE_FM5_Loop:
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_p3
	smpsCall	ORNBASE_FM5_p4
	smpsCall	ORNBASE_FM5_p1
	smpsCall	ORNBASE_FM5_p6
	smpsCall	ORNBASE_FM5_p7
	smpsCall	ORNBASE_FM5_p8
	smpsCall	ORNBASE_FM5_p1
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_p3
	smpsCall	ORNBASE_FM5_p4
	smpsCall	ORNBASE_FM5_p1
	smpsCall	ORNBASE_FM5_p6
	smpsCall	ORNBASE_FM5_p7
	smpsCall	ORNBASE_FM5_pa
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_pd
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p10
	smpsCall	ORNBASE_FM5_p11
	smpsCall	ORNBASE_FM5_p8
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_pd
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p10
	smpsCall	ORNBASE_FM5_p11
	smpsCall	ORNBASE_FM5_p8
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p17
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p14
	smpsCall	ORNBASE_FM5_p17
	smpsCall	ORNBASE_FM5_pb
	smpsCall	ORNBASE_FM5_p2
	smpsCall	ORNBASE_FM5_p11
	smpsCall	ORNBASE_FM5_p11
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p21
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p25
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p1e
	smpsCall	ORNBASE_FM5_p21
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p22
	smpsCall	ORNBASE_FM5_p25
	smpsCall	ORNBASE_FM5_p27
	smpsCall	ORNBASE_FM5_p28
	smpsCall	ORNBASE_FM5_p29
	smpsCall	ORNBASE_FM5_p2a
	smpsCall	ORNBASE_FM5_p27
	smpsCall	ORNBASE_FM5_p28
	smpsCall	ORNBASE_FM5_p29
	smpsCall	ORNBASE_FM5_p2c
	smpsCall	ORNBASE_FM5_p27
	smpsCall	ORNBASE_FM5_p28
	smpsCall	ORNBASE_FM5_p29
	smpsCall	ORNBASE_FM5_p2a
	smpsCall	ORNBASE_FM5_p27
	smpsCall	ORNBASE_FM5_p28
	smpsCall	ORNBASE_FM5_p29
	smpsCall	ORNBASE_FM5_p2d
	smpsCall	ORNBASE_FM5_p1
	smpsJump	ORNBASE_FM5_Loop

ORNBASE_PSG1:
	smpsCall	ORNBASE_MODPSG
	smpsCall	ORNBASE_PSG1_p0
	smpsCall	ORNBASE_PSG1_p1
ORNBASE_PSG1_Loop:
	smpsCall	ORNBASE_PSG1_p2
	smpsCall	ORNBASE_PSG1_p1
	smpsCall	ORNBASE_PSG1_p4
	smpsCall	ORNBASE_PSG1_p1
	smpsCall	ORNBASE_PSG1_p2
	smpsCall	ORNBASE_PSG1_p7
	smpsCall	ORNBASE_PSG1_p4
	smpsCall	ORNBASE_PSG1_p1
	smpsCall	ORNBASE_PSG1_p2
	smpsCall	ORNBASE_PSG1_p1
	smpsCall	ORNBASE_PSG1_p4
	smpsCall	ORNBASE_PSG1_p1
	smpsCall	ORNBASE_PSG1_p2
	smpsCall	ORNBASE_PSG1_p7
	smpsCall	ORNBASE_PSG1_p4
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_pd
	smpsCall	ORNBASE_PSG1_pe
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p10
	smpsCall	ORNBASE_PSG1_p11
	smpsCall	ORNBASE_PSG1_p12
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_pd
	smpsCall	ORNBASE_PSG1_pe
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p10
	smpsCall	ORNBASE_PSG1_p11
	smpsCall	ORNBASE_PSG1_p13
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_p15
	smpsCall	ORNBASE_PSG1_p11
	smpsCall	ORNBASE_PSG1_p12
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p19
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p1b
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_p15
	smpsCall	ORNBASE_PSG1_p11
	smpsCall	ORNBASE_PSG1_p12
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p19
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p1b
	smpsCall	ORNBASE_PSG1_p1e
	smpsCall	ORNBASE_PSG1_p1f
	smpsCall	ORNBASE_PSG1_p20
	smpsCall	ORNBASE_PSG1_p21
	smpsCall	ORNBASE_PSG1_p22
	smpsCall	ORNBASE_PSG1_p1f
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p25
	smpsCall	ORNBASE_PSG1_p1e
	smpsCall	ORNBASE_PSG1_p1f
	smpsCall	ORNBASE_PSG1_p20
	smpsCall	ORNBASE_PSG1_p21
	smpsCall	ORNBASE_PSG1_p22
	smpsCall	ORNBASE_PSG1_p1f
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p26
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p22
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_p2b
	smpsCall	ORNBASE_PSG1_p12
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p22
	smpsCall	ORNBASE_PSG1_p14
	smpsCall	ORNBASE_PSG1_pc
	smpsCall	ORNBASE_PSG1_pb
	smpsCall	ORNBASE_PSG1_p2d
	smpsCall	ORNBASE_PSG1_p1
	smpsJump	ORNBASE_PSG1_Loop

ORNBASE_PSG2:
	smpsCall	ORNBASE_MODPSG
	smpsCall	ORNBASE_PSG2_p0
	smpsCall	ORNBASE_PSG2_p1
ORNBASE_PSG2_Loop:
	smpsCall	ORNBASE_PSG2_p2
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p4
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p2
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p8
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p2
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p4
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p2
	smpsCall	ORNBASE_PSG2_p3
	smpsCall	ORNBASE_PSG2_p8
	smpsCall	ORNBASE_PSG2_pb
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_pd
	smpsCall	ORNBASE_PSG2_pe
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p10
	smpsCall	ORNBASE_PSG2_p11
	smpsCall	ORNBASE_PSG2_p12
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_pd
	smpsCall	ORNBASE_PSG2_pe
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p10
	smpsCall	ORNBASE_PSG2_p11
	smpsCall	ORNBASE_PSG2_p13
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_p15
	smpsCall	ORNBASE_PSG2_p11
	smpsCall	ORNBASE_PSG2_p12
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p19
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p1b
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_p15
	smpsCall	ORNBASE_PSG2_p11
	smpsCall	ORNBASE_PSG2_p12
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p19
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p1b
	smpsCall	ORNBASE_PSG2_p1e
	smpsCall	ORNBASE_PSG2_p1f
	smpsCall	ORNBASE_PSG2_p20
	smpsCall	ORNBASE_PSG2_p21
	smpsCall	ORNBASE_PSG2_p22
	smpsCall	ORNBASE_PSG2_p1f
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p25
	smpsCall	ORNBASE_PSG2_p1e
	smpsCall	ORNBASE_PSG2_p1f
	smpsCall	ORNBASE_PSG2_p20
	smpsCall	ORNBASE_PSG2_p21
	smpsCall	ORNBASE_PSG2_p22
	smpsCall	ORNBASE_PSG2_p1f
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p26
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p22
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_p2b
	smpsCall	ORNBASE_PSG2_p12
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p22
	smpsCall	ORNBASE_PSG2_p14
	smpsCall	ORNBASE_PSG2_pc
	smpsCall	ORNBASE_PSG2_pf
	smpsCall	ORNBASE_PSG2_p2d
	smpsCall	ORNBASE_PSG2_p2e
	smpsJump	ORNBASE_PSG2_Loop

ORNBASE_PSG3:
	smpsPSGform	$E7
	smpsCall	ORNBASE_PSG3_p0
	smpsCall	ORNBASE_PSG3_p1
ORNBASE_PSG3_Loop:
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsCall	ORNBASE_PSG3_p1
	smpsJump	ORNBASE_PSG3_Loop

ORNBASE_DAC:
	smpsCall	ORNBASE_DAC_p0
	smpsCall	ORNBASE_DAC_p1
ORNBASE_DAC_Loop:
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p8
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_pa
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p8
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p13
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p8
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p13
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p8
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p13
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p8
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p4
	smpsCall	ORNBASE_DAC_p1
	smpsCall	ORNBASE_DAC_p2
	smpsCall	ORNBASE_DAC_p3
	smpsCall	ORNBASE_DAC_p2d
	smpsCall	ORNBASE_DAC_p1
	smpsJump	ORNBASE_DAC_Loop


; Pattern data for FM1
ORNBASE_FM1_p0:
	dc.b		$80,$30
	smpsFMvoice	$0
	dc.b		$ab,$10
	smpsReturn

ORNBASE_FM1_p1:
	dc.b		$9f,$6
	dc.b		$80,$2
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$9f,$6
	dc.b		$80,$2
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$9f,$6
	dc.b		$80,$2
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$9f,$6
	dc.b		$80,$2
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$ab,$3
	dc.b		$80,$1
	smpsReturn

ORNBASE_FM1_p3:
	dc.b		$9a,$6
	dc.b		$80,$2
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$9a,$6
	dc.b		$80,$2
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$9a,$6
	dc.b		$80,$2
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$9a,$6
	dc.b		$80,$2
	dc.b		$a6,$3
	dc.b		$80,$1
	dc.b		$a6,$3
	dc.b		$80,$1
	smpsReturn

ORNBASE_FM1_p8:
	dc.b		$a6,$6
	dc.b		$80,$2
	dc.b		$b2,$3
	dc.b		$80,$1
	dc.b		$b2,$3
	dc.b		$80,$1
	dc.b		$a4,$6
	dc.b		$80,$2
	dc.b		$b0,$3
	dc.b		$80,$1
	dc.b		$b0,$3
	dc.b		$80,$1
	dc.b		$a2,$6
	dc.b		$80,$2
	dc.b		$ae,$3
	dc.b		$80,$1
	dc.b		$ae,$3
	dc.b		$80,$1
	dc.b		$ad,$6
	dc.b		$80,$2
	dc.b		$a9,$6
	dc.b		$80,$2
	smpsReturn

ORNBASE_FM1_pd:
	dc.b		$9d,$6
	dc.b		$80,$2
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$9d,$6
	dc.b		$80,$2
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$9d,$6
	dc.b		$80,$2
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$9d,$6
	dc.b		$80,$2
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$a9,$3
	dc.b		$80,$1
	smpsReturn

ORNBASE_FM1_p14:
	dc.b		$9b,$6
	dc.b		$80,$2
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$9b,$6
	dc.b		$80,$2
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$9b,$6
	dc.b		$80,$2
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$9b,$6
	dc.b		$80,$2
	dc.b		$a7,$3
	dc.b		$80,$1
	dc.b		$a7,$3
	dc.b		$80,$1
	smpsReturn

ORNBASE_FM1_p2d:
	dc.b		$9d,$6
	dc.b		$80,$2
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$a9,$3
	dc.b		$80,$1
	dc.b		$9f,$6
	dc.b		$80,$2
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$ab,$3
	dc.b		$80,$1
	dc.b		$a1,$6
	dc.b		$80,$2
	dc.b		$ad,$3
	dc.b		$80,$1
	dc.b		$ad,$3
	dc.b		$80,$1
	dc.b		$a2,$6
	dc.b		$80,$2
	dc.b		$ae,$3
	dc.b		$80,$1
	dc.b		$ae,$3
	dc.b		$80,$1
	smpsReturn

; Pattern data for FM2
ORNBASE_FM2_p0:
	smpsFMvoice	$1
	dc.b		$c3,$20
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_p1:
	dc.b		$c6,$40
	smpsReturn

ORNBASE_FM2_p2:
	dc.b		$c8,$18
	dc.b		$c6
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM2_p3:
	dc.b		$c1,$40
	smpsReturn

ORNBASE_FM2_p4:
	dc.b		$be,$40
	smpsReturn

ORNBASE_FM2_p7:
	dc.b		$c1,$18
	dc.b		$c8
	dc.b		$c6,$10
	smpsReturn

ORNBASE_FM2_p8:
	dc.b		$ca,$10
	dc.b		$c8
	dc.b		$c6
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_p9:
	dc.b		$c1,$18
	dc.b		$c6
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM2_pa:
	dc.b		$ca,$20
	dc.b		$c8,$10
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_pb:
	dc.b		$c6,$8
	dc.b		$c5
	dc.b		$c6,$18
	dc.b		$c8,$8
	dc.b		$c6
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_pc:
	dc.b		$c1,$28
	dc.b		$8
	dc.b		$c3
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_pd:
	dc.b		$c6,$10
	dc.b		$c5,$8
	dc.b		$c6,$10
	dc.b		$c8,$18
	smpsReturn

ORNBASE_FM2_pe:
	dc.b		$ca,$10
	dc.b		$c8,$8
	dc.b		$c6,$18
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM2_p12:
	dc.b		$c6,$10
	dc.b		$c5,$8
	dc.b		$c3,$18
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM2_p13:
	dc.b		$c6,$10
	dc.b		$c5,$8
	dc.b		$c3,$18
	dc.b		$c1,$10
	smpsReturn

ORNBASE_FM2_p14:
	dc.b		$c3,$18
	dc.b		$c3
	dc.b		$ca,$10
	smpsReturn

ORNBASE_FM2_p15:
	dc.b		$cd,$18
	dc.b		$cb
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM2_p16:
	dc.b		$ca,$40
	smpsReturn

ORNBASE_FM2_p17:
	dc.b		$c8,$20
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_p18:
	dc.b		$c6,$8
	dc.b		$c5,$10
	dc.b		$bf
	dc.b		$c5,$18
	smpsReturn

ORNBASE_FM2_p19:
	dc.b		$c6,$18
	dc.b		$c8,$28
	smpsReturn

ORNBASE_FM2_p1a:
	dc.b		$c6,$8
	dc.b		$c5,$10
	dc.b		$c3
	dc.b		$c1,$18
	smpsReturn

ORNBASE_FM2_p1b:
	dc.b		$bf,$18
	dc.b		$be,$28
	smpsReturn

ORNBASE_FM2_p1d:
	dc.b		$cb,$18
	dc.b		$ca,$28
	smpsReturn

ORNBASE_FM2_p1e:
	smpsFMvoice	$1
	dc.b		$cb,$40
	smpsReturn

ORNBASE_FM2_p1f:
	dc.b		$e7,$8
	dc.b		$cb
	dc.b		$cd
	dc.b		$cb
	dc.b		$ca
	dc.b		$c8
	dc.b		$c6
	dc.b		$c5
	smpsReturn

ORNBASE_FM2_p20:
	dc.b		$c8,$18
	dc.b		$ca,$28
	smpsReturn

ORNBASE_FM2_p21:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_FM2_p22:
	smpsFMvoice	$1
	dc.b		$c8,$40
	smpsReturn

ORNBASE_FM2_p23:
	dc.b		$e7,$8
	dc.b		$c8
	dc.b		$ca
	dc.b		$cb
	dc.b		$ca
	dc.b		$c8,$10
	dc.b		$c6,$8
	smpsReturn

ORNBASE_FM2_p24:
	dc.b		$c8,$18
	dc.b		$c6,$28
	smpsReturn

ORNBASE_FM2_p26:
	dc.b		$c5,$18
	dc.b		$c3,$28
	smpsReturn

ORNBASE_FM2_p27:
	dc.b		$c3,$8
	dc.b		$c1,$10
	dc.b		$c3,$8
	dc.b		$c1,$20
	smpsReturn

ORNBASE_FM2_p28:
	dc.b		$c6,$8
	dc.b		$c8,$10
	dc.b		$ca,$8
	dc.b		$c5
	dc.b		$c6,$10
	dc.b		$c5,$8
	smpsReturn

ORNBASE_FM2_p2a:
	dc.b		$c6,$20
	dc.b		$c8
	smpsReturn

ORNBASE_FM2_p2c:
	dc.b		$c6,$18
	dc.b		$c8
	dc.b		$ca,$10
	smpsReturn

ORNBASE_FM2_p2d:
	dc.b		$c3,$18
	dc.b		$c5
	dc.b		$c6,$10
	smpsReturn

; Pattern data for FM3
ORNBASE_FM3_p0:
;	dc.b		$80,$8
	smpsFMvoice	$1
	dc.b		$bf,$20
	dc.b		$c1,$18
	smpsReturn

ORNBASE_FM3_p1:
	dc.b		$e7,$8
	dc.b		$c3,$38
	smpsReturn

ORNBASE_FM3_p2:
	dc.b		$e7,$8
	dc.b		$c5,$18
	dc.b		$c3
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_p3:
	dc.b		$e7,$8
	dc.b		$be,$38
	smpsReturn

ORNBASE_FM3_p4:
	dc.b		$e7,$8
	dc.b		$ba,$38
	smpsReturn

ORNBASE_FM3_p7:
	dc.b		$e7,$8
	dc.b		$be,$18
	dc.b		$c5
	dc.b		$c3,$8
	smpsReturn

ORNBASE_FM3_p8:
	dc.b		$e7,$8
	dc.b		$c6,$10
	dc.b		$c5
	dc.b		$c3
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_p9:
	dc.b		$e7,$8
	dc.b		$be,$18
	dc.b		$c3
	dc.b		$c5,$8
	smpsReturn

ORNBASE_FM3_pa:
	dc.b		$e7,$8
	dc.b		$c6,$20
	dc.b		$c5,$10
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_pb:
	dc.b		$e7,$8
	dc.b		$c3
	dc.b		$c1
	dc.b		$c3,$18
	dc.b		$c5,$8
	dc.b		$c3
	smpsReturn

ORNBASE_FM3_pc:
	dc.b		$c1,$8
	dc.b		$be,$28
	dc.b		$8
	dc.b		$bf
	smpsReturn

ORNBASE_FM3_pd:
	dc.b		$c1,$8
	dc.b		$c3,$10
	dc.b		$c1,$8
	dc.b		$c3,$10
	dc.b		$c5
	smpsReturn

ORNBASE_FM3_pe:
	dc.b		$e7,$8
	dc.b		$c6,$10
	dc.b		$c5,$8
	dc.b		$c3,$18
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_p11:
	dc.b		$c1,$8
	dc.b		$c6,$10
	dc.b		$c5
	dc.b		$c3
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_p12:
	dc.b		$e7,$8
	dc.b		$c3,$10
	dc.b		$c1,$8
	dc.b		$bf,$18
	dc.b		$c1,$8
	smpsReturn

ORNBASE_FM3_p13:
	dc.b		$e7,$8
	dc.b		$c3,$10
	dc.b		$c1,$8
	dc.b		$bf,$18
	dc.b		$be,$8
	smpsReturn

ORNBASE_FM3_p14:
	dc.b		$e7,$8
	dc.b		$bf,$18
	dc.b		$c6
	dc.b		$c6,$8
	smpsReturn

ORNBASE_FM3_p15:
	dc.b		$e7,$8
	dc.b		$ca,$18
	dc.b		$c8
	dc.b		$c5,$8
	smpsReturn

ORNBASE_FM3_p16:
	dc.b		$e7,$8
	dc.b		$c6,$38
	smpsReturn

ORNBASE_FM3_p17:
	dc.b		$e7,$8
	dc.b		$c5,$20
	dc.b		$c1,$18
	smpsReturn

ORNBASE_FM3_p18:
	dc.b		$e7,$8
	dc.b		$c3
	dc.b		$c1,$10
	dc.b		$c3
	dc.b		$c1
	smpsReturn

ORNBASE_FM3_p19:
	dc.b		$e7,$8
	dc.b		$c3,$18
	dc.b		$c5,$20
	smpsReturn

ORNBASE_FM3_p1a:
	dc.b		$e7,$8
	dc.b		$c3
	dc.b		$c1,$10
	dc.b		$bf
	dc.b		$be
	smpsReturn

ORNBASE_FM3_p1b:
	dc.b		$e7,$8
	dc.b		$bc,$18
	dc.b		$ba,$20
	smpsReturn

ORNBASE_FM3_p1d:
	dc.b		$e7,$8
	dc.b		$c8,$18
	dc.b		$c6,$20
	smpsReturn

ORNBASE_FM3_p1e:
	dc.b		$e7,$8
	smpsFMvoice	$2
	dc.b		$c8,$38
	smpsReturn

ORNBASE_FM3_p1f:
	dc.b		$e7,$10
	dc.b		$c8,$8
	dc.b		$ca
	dc.b		$c8
	dc.b		$c6
	dc.b		$c5
	dc.b		$c3
	smpsReturn

ORNBASE_FM3_p20:
	dc.b		$c1,$8
	dc.b		$c5,$18
	dc.b		$c6,$20
	smpsReturn

ORNBASE_FM3_p21:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_FM3_p22:
	dc.b		$e7,$8
	smpsFMvoice	$1
	dc.b		$c5,$38
	smpsReturn

ORNBASE_FM3_p23:
	dc.b		$e7,$10
	dc.b		$c5,$8
	dc.b		$c6
	dc.b		$c8
	dc.b		$c6
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM3_p24:
	dc.b		$c3,$8
	dc.b		$c5,$18
	dc.b		$c3,$20
	smpsReturn

ORNBASE_FM3_p26:
	dc.b		$e7,$8
	dc.b		$c1,$18
	dc.b		$bf,$20
	smpsReturn

ORNBASE_FM3_p27:
	dc.b		$e7,$8
	dc.b		$bf
	dc.b		$be,$10
	dc.b		$bf,$8
	dc.b		$c5,$18
	smpsReturn

ORNBASE_FM3_p28:
	dc.b		$e7,$8
	dc.b		$c3
	dc.b		$c5,$10
	dc.b		$c6,$8
	dc.b		$c8
	dc.b		$c3,$10
	smpsReturn

ORNBASE_FM3_p29:
	dc.b		$c1,$8
	dc.b		$bf
	dc.b		$be,$10
	dc.b		$bf,$8
	dc.b		$c5,$18
	smpsReturn

ORNBASE_FM3_p2a:
	dc.b		$e7,$8
	dc.b		$c3,$20
	dc.b		$c5,$18
	smpsReturn

ORNBASE_FM3_p2c:
	dc.b		$e7,$8
	dc.b		$c3,$18
	dc.b		$c5
	dc.b		$c6,$8
	smpsReturn

ORNBASE_FM3_p2d:
	dc.b		$e7,$8
	dc.b		$bf,$18
	dc.b		$c1
	dc.b		$c3,$8
	smpsReturn

; Pattern data for FM4
ORNBASE_FM4_p0:
	dc.b		$80,$40
	smpsReturn

ORNBASE_FM4_p1:
	smpsFMvoice	$2
	dc.b		$c6,$40
	smpsReturn

ORNBASE_FM4_p2:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_FM4_p3:
	smpsFMvoice	$2
	dc.b		$be,$40
	smpsReturn

ORNBASE_FM4_p4:
	dc.b		$e7,$20
	dc.b		$c3,$10
	dc.b		$c5
	smpsReturn

ORNBASE_FM4_p6:
	dc.b		$c5,$18
	dc.b		$c6
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM4_p7:
	dc.b		$ca,$40
	smpsReturn

ORNBASE_FM4_p8:
	dc.b		$c8,$20
	dc.b		$c5
	smpsReturn

ORNBASE_FM4_pa:
	dc.b		$c8,$40
	smpsReturn

ORNBASE_FM4_pb:
	smpsFMvoice	$2
	dc.b		$c6,$10
	dc.b		$ba,$8
	dc.b		$c6,$28
	smpsReturn

ORNBASE_FM4_pd:
	smpsFMvoice	$2
	dc.b		$c1,$10
	dc.b		$b5,$8
	dc.b		$c1,$28
	smpsReturn

ORNBASE_FM4_p10:
	dc.b		$e7,$8
	dc.b		$c1
	dc.b		$c3
	dc.b		$c5
	dc.b		$c6
	dc.b		$c5
	dc.b		$c6
	dc.b		$c8
	smpsReturn

ORNBASE_FM4_p11:
	smpsFMvoice	$2
	dc.b		$ca,$10
	dc.b		$be,$8
	dc.b		$ca,$28
	smpsReturn

ORNBASE_FM4_p14:
	smpsFMvoice	$2
	dc.b		$bf,$8
	dc.b		$c3,$18
	dc.b		$c5,$10
	dc.b		$c6
	smpsReturn

ORNBASE_FM4_p17:
	dc.b		$ca,$10
	dc.b		$c8
	dc.b		$c6,$18
	dc.b		$c5,$8
	smpsReturn

ORNBASE_FM4_p1e:
	dc.b		$cb,$18
	dc.b		$ca
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM4_p21:
	dc.b		$cb,$20
	dc.b		$ca
	smpsReturn

ORNBASE_FM4_p22:
	dc.b		$c8,$18
	dc.b		$ca
	dc.b		$cb,$10
	smpsReturn

ORNBASE_FM4_p25:
	dc.b		$c8,$20
	dc.b		$c6
	smpsReturn

ORNBASE_FM4_p27:
	dc.b		$c3,$18
	dc.b		$c5,$28
	smpsReturn

ORNBASE_FM4_p28:
	dc.b		$ca,$18
	dc.b		$c8
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM4_p29:
	dc.b		$c6,$18
	dc.b		$c5,$28
	smpsReturn

ORNBASE_FM4_p2a:
	dc.b		$c6,$18
	dc.b		$c8,$28
	smpsReturn

ORNBASE_FM4_p2c:
	dc.b		$c6,$18
	dc.b		$c8
	dc.b		$ca,$10
	smpsReturn

ORNBASE_FM4_p2d:
	dc.b		$ab,$8
	dc.b		$b7
	dc.b		$c3
	dc.b		$ad
	dc.b		$b9
	dc.b		$c5
	dc.b		$ae
	dc.b		$c6
	smpsReturn

; Pattern data for FM5
ORNBASE_FM5_p0:
	dc.b		$80,$40
	smpsReturn

ORNBASE_FM5_p1:
	smpsFMvoice	$3
	dc.b		$c6,$40
	smpsReturn

ORNBASE_FM5_p2:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_FM5_p3:
	smpsFMvoice	$3
	dc.b		$be,$40
	smpsReturn

ORNBASE_FM5_p4:
	dc.b		$e7,$20
	dc.b		$c3,$10
	dc.b		$c5
	smpsReturn

ORNBASE_FM5_p6:
	dc.b		$c5,$18
	dc.b		$c6
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM5_p7:
	dc.b		$ca,$40
	smpsReturn

ORNBASE_FM5_p8:
	dc.b		$c8,$20
	dc.b		$c5
	smpsReturn

ORNBASE_FM5_pa:
	dc.b		$c8,$40
	smpsReturn

ORNBASE_FM5_pb:
	smpsFMvoice	$3
	dc.b		$c6,$10
	dc.b		$ba,$8
	dc.b		$c6,$28
	smpsReturn

ORNBASE_FM5_pd:
	smpsFMvoice	$3
	dc.b		$be,$10
	dc.b		$b2,$8
	dc.b		$be,$28
	smpsReturn

ORNBASE_FM5_p10:
	dc.b		$e7,$8
	dc.b		$c1
	dc.b		$c3
	dc.b		$c5
	dc.b		$c6
	dc.b		$c5
	dc.b		$c6
	dc.b		$c8
	smpsReturn

ORNBASE_FM5_p11:
	smpsFMvoice	$3
	dc.b		$ca,$10
	dc.b		$be,$8
	dc.b		$ca,$28
	smpsReturn

ORNBASE_FM5_p14:
	smpsFMvoice	$3
	dc.b		$bf,$8
	dc.b		$c3,$18
	dc.b		$c5,$10
	dc.b		$c6
	smpsReturn

ORNBASE_FM5_p17:
	dc.b		$ca,$10
	dc.b		$c8
	dc.b		$c6,$18
	dc.b		$c5,$8
	smpsReturn

ORNBASE_FM5_p1e:
	dc.b		$cb,$18
	dc.b		$ca
	dc.b		$c8,$10
	smpsReturn

ORNBASE_FM5_p21:
	dc.b		$cb,$20
	dc.b		$ca
	smpsReturn

ORNBASE_FM5_p22:
	dc.b		$c8,$18
	dc.b		$ca
	dc.b		$cb,$10
	smpsReturn

ORNBASE_FM5_p25:
	dc.b		$c8,$20
	dc.b		$c6
	smpsReturn

ORNBASE_FM5_p27:
	dc.b		$c3,$18
	dc.b		$c5,$28
	smpsReturn

ORNBASE_FM5_p28:
	dc.b		$ca,$18
	dc.b		$c8
	dc.b		$c5,$10
	smpsReturn

ORNBASE_FM5_p29:
	dc.b		$c6,$18
	dc.b		$c5,$28
	smpsReturn

ORNBASE_FM5_p2a:
	dc.b		$c6,$18
	dc.b		$c8,$28
	smpsReturn

ORNBASE_FM5_p2c:
	dc.b		$c6,$18
	dc.b		$c8
	dc.b		$ca,$10
	smpsReturn

ORNBASE_FM5_p2d:
	dc.b		$ab,$8
	dc.b		$b7
	dc.b		$c3
	dc.b		$ad
	dc.b		$b9
	dc.b		$c5
	dc.b		$ae
	dc.b		$c6
	smpsReturn

; Pattern data for PSG1
ORNBASE_PSG1_p0:
	dc.b		$80,$40
	smpsReturn

ORNBASE_PSG1_p1:
	smpsPSGvoice	$0
	dc.b		$be,$d
	dc.b		$80,$3
	dc.b		$c3,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c6,$8
	smpsReturn

ORNBASE_PSG1_p2:
	dc.b		$e7,$5
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c3,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c1,$d
	dc.b		$80,$3
	smpsReturn

ORNBASE_PSG1_p4:
	dc.b		$e7,$5
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c8,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c6,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$d
	dc.b		$80,$3
	smpsReturn

ORNBASE_PSG1_p7:
	dc.b		$be,$d
	dc.b		$80,$3
	dc.b		$c3,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$ca,$8
	smpsReturn

ORNBASE_PSG1_pb:
	smpsPSGvoice	$0
	dc.b		$d2,$40
	smpsReturn

ORNBASE_PSG1_pc:
	dc.b		$d1,$40
	smpsReturn

ORNBASE_PSG1_pd:
	dc.b		$cd,$40
	smpsReturn

ORNBASE_PSG1_pe:
	dc.b		$ca,$40
	smpsReturn

ORNBASE_PSG1_p10:
	dc.b		$d1,$20
	dc.b		$cd
	smpsReturn

ORNBASE_PSG1_p11:
	dc.b		$d6,$40
	smpsReturn

ORNBASE_PSG1_p12:
	dc.b		$d4,$20
	dc.b		$d1
	smpsReturn

ORNBASE_PSG1_p13:
	dc.b		$d4,$20
	dc.b		$d1,$10
	dc.b		$cd
	smpsReturn

ORNBASE_PSG1_p14:
	dc.b		$cf,$40
	smpsReturn

ORNBASE_PSG1_p15:
	dc.b		$d9,$40
	smpsReturn

ORNBASE_PSG1_p19:
	dc.b		$e7,$20
	dc.b		$d4
	smpsReturn

ORNBASE_PSG1_p1b:
	dc.b		$cb,$20
	dc.b		$ca
	smpsReturn

ORNBASE_PSG1_p1e:
	dc.b		$d7,$40
	smpsReturn

ORNBASE_PSG1_p1f:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_PSG1_p20:
	smpsPSGvoice	$0
	dc.b		$d4,$18
	dc.b		$d6
	dc.b		$d7,$10
	smpsReturn

ORNBASE_PSG1_p21:
	dc.b		$d4,$18
	dc.b		$d6,$28
	smpsReturn

ORNBASE_PSG1_p22:
	dc.b		$d4,$40
	smpsReturn

ORNBASE_PSG1_p25:
	dc.b		$d4,$18
	dc.b		$d2,$28
	smpsReturn

ORNBASE_PSG1_p26:
	dc.b		$d1,$18
	dc.b		$d2,$28
	smpsReturn

ORNBASE_PSG1_p2b:
	dc.b		$d2,$20
	dc.b		$d6
	smpsReturn

ORNBASE_PSG1_p2d:
	dc.b		$cf,$18
	dc.b		$d1
	dc.b		$d2,$10
	smpsReturn

; Pattern data for PSG2
ORNBASE_PSG2_p0:
	dc.b		$80,$40
	smpsReturn

ORNBASE_PSG2_p1:
	dc.b		$e7,$8
	smpsPSGvoice	$0 
	smpsAlterNote $01
	dc.b		$be,$d
	dc.b		$80,$3
	dc.b		$c3,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	smpsReturn

ORNBASE_PSG2_p2:
	dc.b		$c6,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c3,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c1,$8
	smpsReturn

ORNBASE_PSG2_p3:
	dc.b		$e7,$5
	dc.b		$80,$3
	dc.b		$be,$d
	dc.b		$80,$3
	dc.b		$c3,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	smpsReturn

ORNBASE_PSG2_p4:
	dc.b		$c6,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c8,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c6,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$8
	smpsReturn

ORNBASE_PSG2_p8:
	dc.b		$ca,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c8,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c6,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$8
	smpsReturn

ORNBASE_PSG2_pb:
	dc.b		$e7,$5
	dc.b		$80,$3
	dc.b		$d2,$38
	smpsReturn

ORNBASE_PSG2_pc:
	dc.b		$e7,$8
	dc.b		$d1,$38
	smpsReturn

ORNBASE_PSG2_pd:
	dc.b		$e7,$8
	dc.b		$cd,$38
	smpsReturn

ORNBASE_PSG2_pe:
	dc.b		$e7,$8
	dc.b		$ca,$38
	smpsReturn

ORNBASE_PSG2_pf:
	dc.b		$e7,$8
	smpsPSGvoice	$0
	dc.b		$d2,$38
	smpsReturn

ORNBASE_PSG2_p10:
	dc.b		$e7,$8
	dc.b		$d1,$20
	dc.b		$cd,$18
	smpsReturn

ORNBASE_PSG2_p11:
	dc.b		$e7,$8
	dc.b		$d6,$38
	smpsReturn

ORNBASE_PSG2_p12:
	dc.b		$e7,$8
	dc.b		$d4,$20
	dc.b		$d1,$18
	smpsReturn

ORNBASE_PSG2_p13:
	dc.b		$e7,$8
	dc.b		$d4,$20
	dc.b		$d1,$10
	dc.b		$cd,$8
	smpsReturn

ORNBASE_PSG2_p14:
	dc.b		$e7,$8
	dc.b		$cf,$38
	smpsReturn

ORNBASE_PSG2_p15:
	dc.b		$e7,$8
	dc.b		$d9,$38
	smpsReturn

ORNBASE_PSG2_p19:
	dc.b		$e7,$28
	dc.b		$d4,$18
	smpsReturn

ORNBASE_PSG2_p1b:
	dc.b		$e7,$8
	dc.b		$cb,$20
	dc.b		$ca,$18
	smpsReturn

ORNBASE_PSG2_p1e:
	dc.b		$e7,$8
	dc.b		$d7,$38
	smpsReturn

ORNBASE_PSG2_p1f:
	dc.b		$e7,$40
	smpsReturn

ORNBASE_PSG2_p20:
	dc.b		$e7,$8
	smpsPSGvoice	$0
	dc.b		$d4,$18
	dc.b		$d6
	dc.b		$d7,$8
	smpsReturn

ORNBASE_PSG2_p21:
	dc.b		$e7,$8
	dc.b		$d4,$18
	dc.b		$d6,$20
	smpsReturn

ORNBASE_PSG2_p22:
	dc.b		$e7,$8
	dc.b		$d4,$38
	smpsReturn

ORNBASE_PSG2_p25:
	dc.b		$e7,$8
	dc.b		$d4,$18
	dc.b		$d2,$20
	smpsReturn

ORNBASE_PSG2_p26:
	dc.b		$e7,$8
	dc.b		$d1,$18
	dc.b		$d2,$20
	smpsReturn

ORNBASE_PSG2_p2b:
	dc.b		$e7,$8
	dc.b		$d2,$20
	dc.b		$d6,$18
	smpsReturn

ORNBASE_PSG2_p2d:
	dc.b		$e7,$8
	dc.b		$cf,$18
	dc.b		$d1
	dc.b		$d2,$8
	smpsReturn

ORNBASE_PSG2_p2e:
	dc.b		$e7,$8
	dc.b		$be,$d
	dc.b		$80,$3
	dc.b		$c3,$d
	dc.b		$80,$3
	dc.b		$be,$6
	dc.b		$80,$2
	dc.b		$c5,$6
	dc.b		$80,$2
	dc.b		$be,$6
	dc.b		$80,$2
	smpsReturn

; Pattern data for PSG3 (Noise)
ORNBASE_PSG3_p0:
	smpsPSGvoice	$1
	dc.b		$82,$1
	dc.b		$80,$1f
	dc.b		$82,$1
	dc.b		$80,$1f
	smpsReturn

ORNBASE_PSG3_p1:
	smpsPSGvoice	$2
	dc.b		$82,$1
	dc.b		$80,$7
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$7
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$7
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$7
	dc.b		$82,$1
	dc.b		$80,$3
	dc.b		$82,$1
	dc.b		$80,$3
	smpsReturn

; Pattern data for DAC
ORNBASE_DAC_p0:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	smpsReturn

ORNBASE_DAC_p1:
	dc.b		ORNBASE_Cymbal,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	smpsReturn

ORNBASE_DAC_p2:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	smpsReturn

ORNBASE_DAC_p3:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	smpsReturn

ORNBASE_DAC_p4:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_HighTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$7
	smpsReturn

ORNBASE_DAC_p8:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_HighTom,$1
	dc.b		$80
	dc.b		ORNBASE_HighTom
	dc.b		$80
	dc.b		ORNBASE_HighTom
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_MidTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	smpsReturn

ORNBASE_DAC_pa:
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$7
	dc.b		ORNBASE_HighTom,$1
	dc.b		$80
	dc.b		ORNBASE_HighTom
	dc.b		$80
	dc.b		ORNBASE_HighTom
	dc.b		$80,$3
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$3
	dc.b		ORNBASE_MidTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	dc.b		ORNBASE_LowTom,$1
	dc.b		$80,$3
	smpsReturn

ORNBASE_DAC_p13:
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$f
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	dc.b		ORNBASE_Snare,$1
	dc.b		$80,$3
	smpsReturn

ORNBASE_DAC_p2d:
	dc.b		ORNBASE_Cymbal,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Cymbal,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Cymbal,$1
	dc.b		$80,$7
	dc.b		ORNBASE_Kick,$1
	dc.b		$80,$7
	smpsReturn

ORNBASE_Voices:
	dc.b	$3a,$31,$20,$41,$61,$8f,$8f,$8e,$54,$e,$3,$e,$3,$0,$0,$0
	dc.b	$0,$13,$f3,$13,$a,$17,$21,$19,$80	; Voice 0 (DangerousSeed-Jupiter-3:FM2 Synth Bass)
	dc.b	$38,$33,$1,$51,$1,$10,$13,$1a,$1b,$f,$1f,$1f,$1f,$1,$1,$1
	dc.b	$1,$33,$3,$3,$8,$16,$1a,$19,$80	; Voice 3 (DangerousSeed-Jupiter-A:FM2 Distortion Synth 2 (Mod $1E, $01, $05, $05))
	dc.b	$3d,$12,$14,$12,$11,$50,$1b,$1b,$1a,$f,$a,$a,$a,$5,$7,$8
	dc.b	$6,$1f,$1f,$1f,$1f,$15,$8b,$80,$80	; Voice 4 (PSIV-PS1Dungeon2-2:FM1 Lead Synth (Mod $01, $01, $05, $04))
	dc.b	$3a,$31,$20,$41,$61,$8f,$8f,$8e,$54,$e,$3,$e,$3,$0,$0,$0
	dc.b	$0,$13,$f3,$13,$a,$18,$22,$1b,$80	; Voice 2 (DangerousSeed-3rdTube-3:FM1 Lead (Mod $1E, $01, $05, $05))
	dc.b	$39,$38,$d8,$8,$8,$90,$8f,$94,$91,$9,$6,$3,$3,$0,$0,$0
	dc.b	$0,$38,$17,$16,$17,$16,$18,$1a,$80	; Voice 1 (G:\Sam\hax\music\graveyard_0.tfi)
	even