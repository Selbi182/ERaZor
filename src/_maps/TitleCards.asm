; ---------------------------------------------------------------------------
; Sprite Mappings - Title Cards - output from ClownMapEd
; ---------------------------------------------------------------------------
; NOTE: The ID order of the title cards is a historically grown mess.
;       For readability of the source, the actual mappings have been
;       reordered to match the level structure of the game.
; ---------------------------------------------------------------------------

Map_Obj34:
		dc.w	TTL_NightHill-Map_Obj34
		dc.w	TTL_Labyrinthy-Map_Obj34
		dc.w	TTL_Ruined-Map_Obj34
		dc.w	TTL_Special-Map_Obj34
		dc.w	TTL_Uberhub-Map_Obj34
		dc.w	TTL_GreenHill-Map_Obj34
		dc.w	TTL_PLACE-Map_Obj34
		dc.w	TTL_Act_1-Map_Obj34
		dc.w	TTL_Act_2-Map_Obj34
		dc.w	TTL_Act_3-Map_Obj34
		dc.w	TTL_Act_4-Map_Obj34
		dc.w	TTL_Act_5-Map_Obj34
		dc.w	TTL_Act_6-Map_Obj34
		dc.w	TTL_Act_7-Map_Obj34
		dc.w	TTL_Act_8-Map_Obj34
		dc.w	TTL_Oval-Map_Obj34
		dc.w	TTL_Finalor-Map_Obj34
		dc.w	TTL_ScarNight-Map_Obj34
		dc.w	TTL_Tutorial-Map_Obj34
		dc.w	TTL_Unreal-Map_Obj34
		dc.w	TTL_StarAgony-Map_Obj34
		dc.w	TTL_Act_9-Map_Obj34
		dc.w	TTL_Unterhub-Map_Obj34
; ---------------------------------------------------------------------------

TTL_Uberhub:
		dc.b	9

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	-35

		; Ü dots
		dc.b	-18
		dc.b	$00
		dc.w	$0029
		dc.b	-34
		dc.b	-18
		dc.b	$00
		dc.w	$0029
		dc.b	-26

		dc.b	-8
		dc.b	$05
		dc.w	$0004
		dc.b	-19

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	-3

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	11

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	28

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	44

		dc.b	-8
		dc.b	$05
		dc.w	$0004
		dc.b	60

TTL_Unterhub:
		dc.b	8

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	-51

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	-35

		dc.b	-8
		dc.b	$05
		;dc.w	$000C ; D
		dc.w	$0042 ; T
		dc.b	-19

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	-3

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	11

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	28

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	44

		dc.b	-8
		dc.b	$05
		dc.w	$0004
		dc.b	60

TTL_Tutorial:
		dc.b	8

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	-44

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	-29

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	-14

		dc.b	-8
		dc.b	$05
		dc.w	$0032
		dc.b	2

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	20

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	36

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	45

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	60

TTL_NightHill:
		dc.b	10

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	-56

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	-41

		dc.b	-8
		dc.b	$05
		dc.w	$0018
		dc.b	-32

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	-13

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	3

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	27

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	42

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	48

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	60

		dc.b	-1
		dc.b	$00
		dc.w	$002D
		dc.b	-16

TTL_GreenHill:
		dc.b	10

		dc.b	-8
		dc.b	$05
		dc.w	$0018
		dc.b	-61

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	-42

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	-26

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	-12

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	2

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	27

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	42

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	48

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	60

		dc.b	0
		dc.b	$00
		dc.w	$002D
		dc.b	-45

TTL_Special:
		dc.b	7

		dc.b	-8
		dc.b	$05
		dc.w	$003E
		dc.b	-26

		dc.b	-8
		dc.b	$05
		dc.w	$0036
		dc.b	-10

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	6

		dc.b	-8
		dc.b	$05
		dc.w	$0008
		dc.b	20

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	36

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	45

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	60

TTL_Ruined:
		dc.b	6

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	-9

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	6

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	20

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	29

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	46

		dc.b	-8
		dc.b	$05
		dc.w	$000C
		dc.b	60

TTL_Labyrinthy:
		dc.b	10

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	-78

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	-63

		dc.b	-8
		dc.b	$05
		dc.w	$0004
		dc.b	-45

		dc.b	-8
		dc.b	$05
		dc.w	$004A
		dc.b	-30

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	-12

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	3

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	12

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	28

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	44

		dc.b	-8
		dc.b	$05
		dc.w	$004A
		dc.b	60

TTL_Unreal:
		dc.b	6

		dc.b	-8
		dc.b	$05
		dc.w	$0046
		dc.b	-19

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	-3

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	14

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	31

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	45

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	60

TTL_ScarNight:
		dc.b	10

		dc.b	-8
		dc.b	$05
		dc.w	$003E
		dc.b	-74

		dc.b	-8
		dc.b	$05
		dc.w	$0008
		dc.b	-58

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	-41

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	-23

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	0

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	16

		dc.b	-8
		dc.b	$05
		dc.w	$0018
		dc.b	25

		dc.b	-8
		dc.b	$05
		dc.w	$001C
		dc.b	44

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	60

		dc.b	-1
		dc.b	$00
		dc.w	$002D
		dc.b	41

TTL_StarAgony:
		dc.b	10

		dc.b	-8
		dc.b	$05
		dc.w	$003E
		dc.b	-81

		dc.b	-8
		dc.b	$05
		dc.w	$0042
		dc.b	-67

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	-53

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	-35

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	-11

		dc.b	-8
		dc.b	$05
		dc.w	$0018
		dc.b	7

		dc.b	-8
		dc.b	$05
		dc.w	$0032
		dc.b	26

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	44

		dc.b	-8
		dc.b	$05
		dc.w	$004A
		dc.b	60

		dc.b	-1
		dc.b	$00
		dc.w	$002D
		dc.b	23

TTL_Finalor:
		dc.b	7

		dc.b	-8
		dc.b	$05
		dc.w	$0014
		dc.b	-26

		dc.b	-8
		dc.b	$01
		dc.w	$0020
		dc.b	-14

		dc.b	-8
		dc.b	$05
		dc.w	$002E
		dc.b	-5

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	12

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	27

		dc.b	-8
		dc.b	$05
		dc.w	$0032
		dc.b	42

		dc.b	-8
		dc.b	$05
		dc.w	$003A
		dc.b	60
; ---------------------------------------------------------------------------

TTL_PLACE:
		dc.b	5

		dc.b	-8
		dc.b	$05
		dc.w	$0036
		dc.b	-45

		dc.b	-8
		dc.b	$05
		dc.w	$0026
		dc.b	-32

		dc.b	-8
		dc.b	$05
		dc.w	$0000
		dc.b	-17

		dc.b	-8
		dc.b	$05
		dc.w	$0008
		dc.b	1

		dc.b	-8
		dc.b	$05
		dc.w	$0010
		dc.b	19

TTL_Act_1:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$02
		dc.w	$0057
		dc.b	9

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	19

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_2:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$005A
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_3:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$0060
		dc.b	8

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_4:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$0A
		dc.w	$0080
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	21

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_5:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$0089
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_6:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$008F
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_7:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$0095
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_8:
		dc.b	5

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$06
		dc.w	$009B
		dc.b	7

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43

TTL_Act_9:
		dc.b	6

		dc.b	4
		dc.b	$0C
		dc.w	$0053
		dc.b	-20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	7

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	15

		dc.b	-12
		dc.b	$06
		dc.w	$0066
		dc.b	20

		dc.b	-12
		dc.b	$02
		dc.w	$00A1
		dc.b	35

		dc.b	-12
		dc.b	$02
		dc.w	$002A
		dc.b	43
; ---------------------------------------------------------------------------

TTL_Oval:
		dc.b	13

		dc.b	-28
		dc.b	$0C
		dc.w	$0070
		dc.b	-12

		dc.b	-28
		dc.b	$02
		dc.w	$0074
		dc.b	20

		dc.b	-20
		dc.b	$04
		dc.w	$0077
		dc.b	-20

		dc.b	-12
		dc.b	$05
		dc.w	$0079
		dc.b	-28

		dc.b	20
		dc.b	$0C
		dc.w	$1870
		dc.b	-20

		dc.b	4
		dc.b	$02
		dc.w	$1874
		dc.b	-28

		dc.b	12
		dc.b	$04
		dc.w	$1877
		dc.b	4

		dc.b	-4
		dc.b	$05
		dc.w	$1879
		dc.b	12

		dc.b	-20
		dc.b	$08
		dc.w	$007D
		dc.b	-4

		dc.b	-12
		dc.b	$0C
		dc.w	$007C
		dc.b	-12

		dc.b	-4
		dc.b	$08
		dc.w	$007C
		dc.b	-12

		dc.b	4
		dc.b	$0C
		dc.w	$007C
		dc.b	-20

		dc.b	12
		dc.b	$08
		dc.w	$007C
		dc.b	-20

		even