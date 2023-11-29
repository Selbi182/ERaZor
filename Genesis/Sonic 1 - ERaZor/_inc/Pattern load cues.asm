; ---------------------------------------------------------------------------
; Pattern load cues - index
; ---------------------------------------------------------------------------
	dc.w PLC_Main-ArtLoadCues	; $00
	dc.w PLC_Main2-ArtLoadCues	; $01
	dc.w PLC_Explode-ArtLoadCues	; $02
	dc.w PLC_GameOver-ArtLoadCues	; $03
	dc.w PLC_GHZ-ArtLoadCues	; $04
	dc.w PLC_GHZ2-ArtLoadCues	; $05
	dc.w PLC_LZ-ArtLoadCues		; $06
	dc.w PLC_LZ2-ArtLoadCues	; $07
	dc.w PLC_MZ-ArtLoadCues		; $08
	dc.w PLC_MZ2-ArtLoadCues	; $09
	dc.w PLC_SLZ-ArtLoadCues	; $0A
	dc.w PLC_SLZ2-ArtLoadCues	; $0B
	dc.w PLC_SYZ-ArtLoadCues	; $0C
	dc.w PLC_SYZ2-ArtLoadCues	; $0D
	dc.w PLC_SBZ-ArtLoadCues	; $0E
	dc.w PLC_SBZ2-ArtLoadCues	; $0F
	dc.w PLC_TitleCard-ArtLoadCues	; $10
	dc.w PLC_Boss-ArtLoadCues	; $11
	dc.w PLC_Signpost-ArtLoadCues	; $12
	dc.w PLC_Warp-ArtLoadCues	; $13
	dc.w PLC_SpeStage-ArtLoadCues	; $14
	dc.w PLC_GHZAnimals-ArtLoadCues	; $15
	dc.w PLC_LZAnimals-ArtLoadCues	; $16
	dc.w PLC_MZAnimals-ArtLoadCues	; $17
	dc.w PLC_SLZAnimals-ArtLoadCues	; $18
	dc.w PLC_SYZAnimals-ArtLoadCues	; $19
	dc.w PLC_SBZAnimals-ArtLoadCues	; $1A
	dc.w PLC_SpeStResult-ArtLoadCues; $1B
	dc.w PLC_Ending-ArtLoadCues	; $1C
	dc.w PLC_TryAgain-ArtLoadCues	; $1D
	dc.w PLC_EggmanSBZ2-ArtLoadCues	; $1E
	dc.w PLC_FZBoss-ArtLoadCues	; $1F
; ---------------------------------------------------------------------------
; Pattern load cues - standard block 1
; ---------------------------------------------------------------------------
PLC_Main:	dc.w 4
		dc.l Nem_Lamp		; lamppost
		dc.w $D800
		dc.l Nem_Hud		; HUD
		dc.w $D940
		dc.l Nem_Lives		; lives	counter
		dc.w $FA80
		dc.l Nem_Ring		; rings
		dc.w $F640
		dc.l Nem_ExplBall	; exploding balls from Inhuman Mode
		dc.w $D700
; ---------------------------------------------------------------------------
; Pattern load cues - standard block 2
; ---------------------------------------------------------------------------
PLC_Main2:	dc.w 1
		dc.l Nem_Monitors	; monitors
		dc.w $D000
		dc.l Nem_Shield		; shield
		dc.w $A820
; ---------------------------------------------------------------------------
; Pattern load cues - explosion
; ---------------------------------------------------------------------------
PLC_Explode:	dc.w 0
		dc.l Nem_Explode	; explosion
		dc.w $B400
; ---------------------------------------------------------------------------
; Pattern load cues - game/time	over
; ---------------------------------------------------------------------------
PLC_GameOver:	dc.w 0
		dc.l Nem_GameOver	; game/time over
		dc.w $ABC0
; ---------------------------------------------------------------------------
; Pattern load cues - Green Hill
; ---------------------------------------------------------------------------
PLC_GHZ:	dc.w $A
		dc.l Nem_GHZ		; GHZ main patterns
		dc.w 0
		dc.l Nem_Stalk		; flower stalk
		dc.w $6B00
		dc.l Nem_PplRock	; purple rock
		dc.w $7A00
		dc.l Nem_Crabmeat	; crabmeat enemy
		dc.w $8000
		dc.l Nem_Buzz		; buzz bomber enemy
		dc.w $8880
		dc.l Nem_Chopper	; chopper enemy
		dc.w $8F60
		dc.l Nem_HardPS		; hard part skipper
		dc.w $9360
		dc.l Nem_Motobug	; motobug enemy
		dc.w $9E00
		dc.l Nem_Spikes		; spikes
		dc.w $A360
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
		dc.l Nem_VSpring	; vertical spring
		dc.w $A660
PLC_GHZ2:	dc.w 5
		dc.l Nem_Swing		; swinging platform
		dc.w $7000
		dc.l Nem_Bridge		; bridge
		dc.w $71C0
		dc.l Nem_SpikePole	; spiked pole
		dc.w $7300
		dc.l Nem_Ball		; giant	ball
		dc.w $7540
		dc.l Nem_GhzWall1	; breakable wall
		dc.w $A1E0
		dc.l Nem_GhzWall2	; normal wall
		dc.w $6980
; ---------------------------------------------------------------------------
; Pattern load cues - Labyrinth
; ---------------------------------------------------------------------------
PLC_LZ:		dc.w $A
		dc.l Nem_LZ		; LZ main patterns
		dc.w 0
		dc.l Nem_LzBlock1	; block
		dc.w $3C00
		dc.l Nem_LzBlock2	; blocks
		dc.w $3E00
		dc.l Nem_Splash		; waterfalls and splash
		dc.w $4B20
	;	dc.l Nem_Water		; water	surface
	;	dc.w $6000
		dc.l Nem_LzSpikeBall	; spiked ball
		dc.w $6200
		dc.l Nem_FlapDoor	; flapping door
		dc.w $6500
		dc.l Nem_Bubbles	; bubbles and numbers
		dc.w $6900
		dc.l Nem_LzBlock3	; block
		dc.w $7780
		dc.l Nem_LzDoor1	; vertical door
		dc.w $7880
		dc.l Nem_Harpoon	; harpoon
		dc.w $7980
		dc.l Nem_HardPS		; hard part skipper
		dc.w $94C0
PLC_LZ2:	dc.w $A
		dc.l Nem_LzPole		; pole that breaks
		dc.w $7BC0
		dc.l Nem_LzDoor2	; large	horizontal door
		dc.w $7CC0
		dc.l Nem_LzWheel	; wheel
		dc.w $7EC0
		dc.l Nem_Gargoyle	; gargoyle head
		dc.w $5D20
		dc.l Nem_LzPlatfm	; rising platform
		dc.w $89E0
		dc.l Nem_Orbinaut	; orbinaut enemy
		dc.w $8CE0
		dc.l Nem_Jaws		; jaws enemy
		dc.w $90C0
		dc.l Nem_LzSwitch	; switch
		dc.w $A1E0
	;	dc.l Nem_Cork		; cork block
	;	dc.w $A000
		dc.l Nem_Spikes		; spikes
		dc.w $A360
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
		dc.l Nem_VSpring	; vertical spring
		dc.w $A660
; ---------------------------------------------------------------------------
; Pattern load cues - Marble
; ---------------------------------------------------------------------------
PLC_MZ:		dc.w 9
		dc.l Nem_MZ		; MZ main patterns
		dc.w 0
		dc.l Nem_MzMetal	; metal	blocks
		dc.w $6000
		dc.l Nem_MzFire		; fireballs
		dc.w $68A0
		dc.l Nem_Swing		; swinging platform
		dc.w $7000
		dc.l Nem_MzGlass	; green	glassy block
		dc.w $71C0
		dc.l Nem_Lava		; lava
		dc.w $7500
		dc.l Nem_Buzz		; buzz bomber enemy
		dc.w $8880
		dc.l Nem_Yadrin		; yadrin enemy
		dc.w $8F60
		dc.l Nem_Basaran	; basaran enemy
		dc.w $9700
		dc.l Nem_HardPS		; hard part skipper
		dc.w $9FE0
PLC_MZ2:	dc.w 4
		dc.l Nem_MzSwitch	; switch
		dc.w $A260
		dc.l Nem_Spikes		; spikes
		dc.w $A360
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
		dc.l Nem_VSpring	; vertical spring
		dc.w $A660
		dc.l Nem_MzBlock	; green	stone block
		dc.w $5700
; ---------------------------------------------------------------------------
; Pattern load cues - Star Light
; ---------------------------------------------------------------------------
PLC_SLZ:	dc.w 5
		dc.l Nem_SLZ		; SLZ main patterns
		dc.w 0
		dc.l Nem_Bomb		; bomb enemy
		dc.w $8000
		dc.l Nem_LzSwitch	; switch
		dc.w $9000
		dc.l Nem_Spikes		; spikes
		dc.w $A360
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
		dc.l Nem_VSpring	; vertical spring
		dc.w $A660
PLC_SLZ2:	dc.w 4
		dc.l Nem_Pylon		; foreground pylon
		dc.w $7980
		dc.l Nem_GiantBomb	; giant bomb
		dc.w $8580
		dc.l Nem_Bonus		; bonus points
		dc.w $96C0
		dc.l Nem_SLZPlatform	; SLZ platform
		dc.w $9C00
		dc.l Nem_HardPS		; hard part skipper
		dc.w $9200
; ---------------------------------------------------------------------------
; Pattern load cues - Spring Yard
; ---------------------------------------------------------------------------
PLC_SYZ:	dc.w 1
		dc.l Nem_SYZ		; SYZ main patterns
		dc.w $0000
		dc.l Nem_LevelSigns	; level signs
		dc.w $6E40
PLC_SYZ2:	dc.w 2
		dc.l Nem_SYZPlat	; platform
		dc.w $9200
		dc.l Nem_LzSwitch	; switch
		dc.w $A1E0
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
; ---------------------------------------------------------------------------
; Pattern load cues - Scrap Brain
; ---------------------------------------------------------------------------
PLC_SBZ:	dc.w 4
		dc.l Nem_SBZ		; SBZ main patterns
		dc.w 0
		dc.l Nem_HardPS_Tut	; hard part skipper
		dc.w $6E40
		dc.l Nem_SbzDoor1	; door
		dc.w $5500		; VLADIK => Fixed from $5D00
		dc.l Nem_Buzz		; buzz bomber enemy
		dc.w $8880
		dc.l Nem_LzSwitch	; switch
		dc.w $7400
PLC_SBZ2:	dc.w 2
		dc.l Nem_Electric	; electric orb
		dc.w $8FC0
		dc.l Nem_Spikes		; spikes
		dc.w $A360
		dc.l Nem_FlamePipe	; flaming pipe
		dc.w $7B20
; ---------------------------------------------------------------------------
; Pattern load cues - title card
; ---------------------------------------------------------------------------
PLC_TitleCard:	dc.w 0
		dc.l Nem_TitleCard
		dc.w $AB80
; ---------------------------------------------------------------------------
; Pattern load cues - act 3 boss
; ---------------------------------------------------------------------------
PLC_Boss:	dc.w 4
		dc.l Nem_Eggman		; Eggman main patterns
		dc.w $8000
		dc.l Nem_Weapons	; Eggman's weapons
		dc.w $8D80
		dc.l Nem_Prison		; prison capsule
		dc.w $93A0
		dc.l Nem_Bomb		; bomb enemy (gets overwritten)
		dc.w $A300
		dc.l Nem_Exhaust	; exhaust flame
		dc.w $A540
	;	dc.l Nem_ExplBall	; buzz bomber enemy
	;	dc.w $8E00
; ---------------------------------------------------------------------------
; Pattern load cues - act 1/2 signpost
; ---------------------------------------------------------------------------
PLC_Signpost:	dc.w 1
		dc.l Nem_SignPost	; signpost
		dc.w $D000
		dc.l Nem_HSpring	; horizontal spring
		dc.w $A460
	;	dc.l Nem_Bonus		; hidden bonus points
	;	dc.w $96C0
	;	dc.l Nem_BigFlash	; giant	ring flash effect
	;	dc.w $8C40
; ---------------------------------------------------------------------------
; Pattern load cues - beta special stage warp effect
; ---------------------------------------------------------------------------
PLC_Warp:	dc.w 1
		dc.l Nem_Stars		; invincibility	stars
		dc.w $AB80
		dc.l Nem_Explode	; explosion
		dc.w $B400
; ---------------------------------------------------------------------------
; Pattern load cues - special stage
; ---------------------------------------------------------------------------
PLC_SpeStage:	dc.w $C
		dc.l Nem_SSBgCloud	; bubble and cloud background
		dc.w 0
		dc.l Nem_TitleCard	; title cards
		dc.w $0A20
		dc.l Nem_SSWalls	; walls
		dc.w $2840
		dc.l Nem_Bumper		; bumper
		dc.w $4760
		dc.l Nem_SSGOAL		; GOAL block
		dc.w $4A20
		dc.l Nem_SSUpDown	; UP and DOWN blocks
		dc.w $4C60
		dc.l Nem_SSRBlock	; R block
		dc.w $5E00
		dc.l Nem_SSEmStars	; emerald collection stars
		dc.w $7E00
		dc.l Nem_SSRedWhite	; red and white	block
		dc.w $8E00
		dc.l Nem_SSGhost	; ghost	block
		dc.w $9E00
		dc.l Nem_SSWBlock	; W block
		dc.w $AE00
		dc.l Nem_SSGlass	; glass	block
		dc.w $BE00
		dc.l Nem_SSEmerald	; emeralds
		dc.w $EE00
; ---------------------------------------------------------------------------
; Pattern load cues - GHZ animals
; ---------------------------------------------------------------------------
PLC_GHZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - LZ animals
; ---------------------------------------------------------------------------
PLC_LZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - MZ animals
; ---------------------------------------------------------------------------
PLC_MZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - SLZ animals
; ---------------------------------------------------------------------------
PLC_SLZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - SYZ animals
; ---------------------------------------------------------------------------
PLC_SYZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - SBZ animals
; ---------------------------------------------------------------------------
PLC_SBZAnimals:	dc.w 0
		dc.l Nem_Null
		dc.w $B000
; ---------------------------------------------------------------------------
; Pattern load cues - special stage results screen
; ---------------------------------------------------------------------------
PLC_SpeStResult:dc.w 1
		dc.l Nem_ResultEm	; emeralds
		dc.w $A820
		dc.l Nem_MiniSonic	; mini Sonic
		dc.w $AA20
; ---------------------------------------------------------------------------
; Pattern load cues - ending sequence
; ---------------------------------------------------------------------------
PLC_Ending:	dc.w $E
		dc.l Nem_GHZ_1st	; GHZ main patterns
		dc.w 0
		dc.l Nem_GHZ_2nd	; GHZ secondary	patterns
		dc.w $39A0
		dc.l Nem_Stalk		; flower stalk
		dc.w $6B00
		dc.l Nem_EndFlower	; flowers
		dc.w $7400
		dc.l Nem_EndEm		; emeralds
		dc.w $78A0
		dc.l Nem_EndSonic	; Sonic
		dc.w $7C20
		dc.l Nem_UMadBro	; U Mad Bro?!
		dc.w $A480
		dc.l Nem_Rabbit		; rabbit
		dc.w $AA60
		dc.l Nem_Chicken	; chicken
		dc.w $ACA0
		dc.l Nem_BlackBird	; blackbird
		dc.w $AE60
		dc.l Nem_Seal		; seal
		dc.w $B0A0
		dc.l Nem_Pig		; pig
		dc.w $B260
		dc.l Nem_Flicky		; flicky
		dc.w $B4A0
		dc.l Nem_Squirrel	; squirrel
		dc.w $B660
		dc.l Nem_EndStH		; "SONIC THE HEDGEHOG"
		dc.w $B8A0
; ---------------------------------------------------------------------------
; Pattern load cues - "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------
PLC_TryAgain:	dc.w 2
		dc.l Nem_EndEm		; emeralds
		dc.w $78A0
		dc.l Nem_TryAgain	; Eggman
		dc.w $7C20
		dc.l Nem_CreditText	; credits alphabet
		dc.w $B400
; ---------------------------------------------------------------------------
; Pattern load cues - Eggman on SBZ 2
; ---------------------------------------------------------------------------
PLC_EggmanSBZ2:	dc.w 3
		dc.l Nem_Sbz2Eggman	; Eggman
		dc.w $8000
		dc.l Nem_LzSwitch	; switch
		dc.w $9400
		dc.l Nem_BombOld	; bomb enemy
		dc.w $A660
		dc.l Nem_BombMach	; bomb machine
		dc.w $5600
; ---------------------------------------------------------------------------
; Pattern load cues - final boss
; ---------------------------------------------------------------------------
PLC_FZBoss:	dc.w 4
		dc.l Nem_FzEggman	; Eggman after boss
		dc.w $7400
		dc.l Nem_FzBoss		; FZ boss
		dc.w $6000
		dc.l Nem_Eggman		; Eggman main patterns
		dc.w $8000
		dc.l Nem_Sbz2Eggman	; Eggman without ship
		dc.w $8E00
		dc.l Nem_Exhaust	; exhaust flame
		dc.w $A540
		even
; ---------------------------------------------------------------------------