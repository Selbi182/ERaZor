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
	dc.w PLC_SSBlackout-ArtLoadCues ; $1B
	dc.w PLC_Ending-ArtLoadCues	; $1C
	dc.w PLC_TryAgain-ArtLoadCues	; $1D
	dc.w PLC_EggmanSBZ2-ArtLoadCues	; $1E
	dc.w PLC_FZBoss-ArtLoadCues	; $1F
; ---------------------------------------------------------------------------
; Pattern load cues - standard block 1
; ---------------------------------------------------------------------------
PLC_Main:
		dc.l ArtKospM_Lamp		; lamppost
		dc.w $D800
		dc.l ArtKospM_Hud		; HUD
		dc.w $D940
		dc.l ArtKospM_Lives		; lives	counter
		dc.w $FA80
		dc.l ArtKospM_Ring		; rings
		dc.w $F640
		dc.l ArtKospM_ExplBall	; exploding balls from Inhuman Mode
		dc.w $D700
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - standard block 2
; ---------------------------------------------------------------------------
PLC_Main2:
		dc.l ArtKospM_Monitors	; monitors
		dc.w $D000
		dc.l ArtKospM_Shield		; shield
		dc.w $A820
		dc.w -1
; ---------------------------------------------------------------------------
; Pattern load cues - explosion
; ---------------------------------------------------------------------------
PLC_Explode:
		dc.l ArtKospM_Explode	; explosion
		dc.w $B400
		dc.w -1
; ---------------------------------------------------------------------------
; Pattern load cues - game/time	over
; ---------------------------------------------------------------------------
PLC_GameOver:
		dc.l ArtKospM_GameOver	; game/time over
		dc.w $ABC0
		dc.w -1
; ---------------------------------------------------------------------------
; Pattern load cues - Green Hill
; ---------------------------------------------------------------------------
PLC_GHZ:
		dc.l ArtKospM_GHZ		; GHZ main patterns
		dc.w 0
		dc.l ArtKospM_Stalk		; flower stalk
		dc.w $6B00
		dc.l ArtKospM_PplRock	; purple rock
		dc.w $7A00
		dc.l ArtKospM_Crabmeat	; crabmeat enemy
		dc.w $8000
		dc.l ArtKospM_Buzz		; buzz bomber enemy
		dc.w $8880
		dc.l ArtKospM_Chopper	; chopper enemy
		dc.w $8F60
		dc.l ArtKospM_HardPS		; hard part skipper
		dc.w $9360
		dc.l ArtKospM_Motobug	; motobug enemy
		dc.w $9E00
		dc.l ArtKospM_Spikes		; spikes
		dc.w $A360
		dc.l ArtKospM_HSpring	; horizontal spring
		dc.w $A460
		dc.l ArtKospM_VSpring	; vertical spring
		dc.w $A660
		dc.w -1

PLC_GHZ2:
		dc.l ArtKospM_Swing		; swinging platform
		dc.w $7000
		dc.l ArtKospM_Bridge		; bridge
		dc.w $71C0
		dc.l ArtKospM_SpikePole	; spiked pole
		dc.w $7300
		dc.l ArtKospM_Ball		; giant	ball
		dc.w $7540
		dc.l ArtKospM_GhzWall1	; breakable wall
		dc.w $A1E0
		dc.l ArtKospM_GhzWall2	; normal wall
		dc.w $6980
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Labyrinth
; ---------------------------------------------------------------------------
PLC_LZ:
		dc.l ArtKospM_LZ		; LZ main patterns
		dc.w 0
		dc.l ArtKospM_LzBlock1	; block
		dc.w $3C00
		dc.l ArtKospM_LzBlock2	; blocks
		dc.w $3E00
		dc.l ArtKospM_Splash		; waterfalls and splash
		dc.w $4B20
	;	dc.l ArtKospM_Water		; water	surface
	;	dc.w $6000
		dc.l ArtKospM_LzSpikeBall	; spiked ball
		dc.w $6200
		dc.l ArtKospM_FlapDoor	; flapping door
		dc.w $6500
		dc.l ArtKospM_Bubbles	; bubbles and numbers
		dc.w $6900
		dc.l ArtKospM_LzBlock3	; block
		dc.w $7780
		dc.l ArtKospM_LzDoor1	; vertical door
		dc.w $7880
		dc.l ArtKospM_Cork		; cork block
		dc.w $7980
	;	dc.l ArtKospM_Harpoon	; harpoon
	;	dc.w $7980
		dc.l ArtKospM_HardPS		; hard part skipper
		dc.w $94C0
		dc.w -1

PLC_LZ2:
		dc.l ArtKospM_LzPole		; pole that breaks
		dc.w $7BC0
		dc.l ArtKospM_LzDoor2	; large	horizontal door
		dc.w $7CC0
		dc.l ArtKospM_LzWheel	; wheel
		dc.w $7EC0
		dc.l ArtKospM_Gargoyle	; gargoyle head
		dc.w $5D20
		dc.l ArtKospM_LzPlatfm	; rising platform
		dc.w $89E0
		dc.l ArtKospM_Orbinaut	; orbinaut enemy
		dc.w $8CE0
		dc.l ArtKospM_Jaws		; jaws enemy
		dc.w $90C0
		dc.l ArtKospM_LzSwitch	; switch
		dc.w $A1E0
	;	dc.l ArtKospM_Cork		; cork block
	;	dc.w $A000
		dc.l ArtKospM_Spikes		; spikes
		dc.w $A360
		dc.l ArtKospM_HSpring	; horizontal spring
		dc.w $A460
		dc.l ArtKospM_VSpring	; vertical spring
		dc.w $A660
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Marble
; ---------------------------------------------------------------------------
PLC_MZ:
		dc.l ArtKospM_MZ		; MZ main patterns
		dc.w 0
		dc.l ArtKospM_MzMetal	; metal	blocks
		dc.w $6000
		dc.l ArtKospM_MzFire		; fireballs
		dc.w $68A0
		dc.l ArtKospM_Swing		; swinging platform
		dc.w $7000
		dc.l ArtKospM_MzGlass	; green	glassy block
		dc.w $71C0
		dc.l ArtKospM_Lava		; lava
		dc.w $7500
		dc.l ArtKospM_Buzz		; buzz bomber enemy
		dc.w $8880
		dc.l ArtKospM_Yadrin		; yadrin enemy
		dc.w $8F60
		dc.l ArtKospM_Basaran	; basaran enemy
		dc.w $9700
		dc.l ArtKospM_HardPS		; hard part skipper
		dc.w $9FE0
		dc.w -1

PLC_MZ2:
		dc.l ArtKospM_MzSwitch	; switch
		dc.w $A260
		dc.l ArtKospM_Spikes		; spikes
		dc.w $A360
		dc.l ArtKospM_HSpring	; horizontal spring
		dc.w $A460
		dc.l ArtKospM_VSpring	; vertical spring
		dc.w $A660
		dc.l ArtKospM_MzBlock	; green	stone block
		dc.w $5700
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Star Light
; ---------------------------------------------------------------------------
PLC_SLZ:
		dc.l ArtKospM_SLZ		; SLZ main patterns
		dc.w 0
		dc.l ArtKospM_Bomb		; bomb enemy
		dc.w $8000
		dc.l ArtKospM_LzSwitch	; switch
		dc.w $9000
		dc.l ArtKospM_Spikes		; spikes
		dc.w $A360
		dc.l ArtKospM_HSpring	; horizontal spring
		dc.w $A460
		dc.l ArtKospM_VSpring	; vertical spring
		dc.w $A660
		dc.w -1

PLC_SLZ2:
		dc.l ArtKospM_Pylon		; foreground pylon
		dc.w $7980
		dc.l ArtKospM_GiantBomb	; giant bomb
		dc.w $8580
		dc.l ArtKospM_Bonus		; bonus points
		dc.w $96C0
		dc.l ArtKospM_SLZPlatform	; SLZ platform
		dc.w $9C00
		dc.l ArtKospM_HardPS		; hard part skipper
		dc.w $9200
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Spring Yard
; ---------------------------------------------------------------------------
PLC_SYZ:
		dc.l ArtKospM_SYZ		; SYZ main patterns
		dc.w 0
		dc.l ArtKospM_SYZDoors		; SYZ doors
		dc.w $6000
		dc.l ArtKospM_LevelSigns	; level signs
		dc.w $6200
		dc.l ArtKospM_SYZEmblems	; SYZ casual/frantic progression emblems
		dc.w $6C00
		dc.w -1

PLC_SYZ2:
		dc.l ArtKospM_BigRing		; big rings
		dc.w $8440
		dc.l ArtKospM_SYZPlat		; exploding platform
		dc.w $A660
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Scrap Brain
; ---------------------------------------------------------------------------
PLC_SBZ:
		dc.l ArtKospM_SBZ		; SBZ main patterns
		dc.w 0
		dc.l ArtKospM_HardPS_Tut	; hard part skipper
		dc.w $6C00
		dc.l ArtKospM_LzSwitch	; switch
		dc.w $70A0
		dc.l ArtKospM_LevelSigns	; level signs
		dc.w $7300
		dc.l ArtKospM_SbzDoor1	; door
		dc.w $8000
		dc.w -1

PLC_SBZ2:
		dc.l ArtKospM_Spikes		; spikes
		dc.w $A360
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - title card
; ---------------------------------------------------------------------------
PLC_TitleCard:
		dc.l ArtKospM_TitleCard
		dc.w $AB80
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - act 3 boss
; ---------------------------------------------------------------------------
PLC_Boss:
		dc.l ArtKospM_Eggman		; Eggman main patterns
		dc.w $8000
		dc.l ArtKospM_Weapons	; Eggman's weapons
		dc.w $8D80
		dc.l ArtKospM_Bomb		; bomb enemy (gets overwritten)
		dc.w $A300
		dc.l ArtKospM_Exhaust	; exhaust flame
		dc.w $A540
	;	dc.l ArtKospM_ExplBall	; buzz bomber enemy
	;	dc.w $8E00
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - act 1/2 signpost
; ---------------------------------------------------------------------------
PLC_Signpost:
		dc.l ArtKospM_SignPost	; signpost
		dc.w $D000
		dc.l ArtKospM_HSpring	; horizontal spring
		dc.w $A460
	;	dc.l ArtKospM_Bonus		; hidden bonus points
	;	dc.w $96C0
	;	dc.l ArtKospM_BigFlash	; giant	ring flash effect
	;	dc.w $8C40
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - beta special stage warp effect
; ---------------------------------------------------------------------------
PLC_Warp:
		dc.l ArtKospM_Stars		; invincibility	stars
		dc.w $AB80
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - special stage
; ---------------------------------------------------------------------------
PLC_SpeStage:
		dc.l ArtKospM_SSBgCloud	; bubble and cloud background
		dc.w 0
		dc.l ArtKospM_TitleCard	; title cards
		dc.w $0A20
		dc.l ArtKospM_SSWalls	; walls
		dc.w $2840
		dc.l ArtKospM_Bumper		; bumper
		dc.w $4760
		dc.l ArtKospM_SSGOAL		; GOAL block
		dc.w $4A20
		dc.l ArtKospM_SSUpDown	; UP and DOWN blocks
		dc.w $4C60
		dc.l ArtKospM_SSRBlock	; R block
		dc.w $5E00
		dc.l ArtKospM_SSEmStars	; emerald collection stars
		dc.w $7E00
		dc.l ArtKospM_SSRedWhite	; red and white	block
		dc.w $8E00
		dc.l ArtKospM_SSGhost	; ghost	block
		dc.w $9E00
		dc.l ArtKospM_SSWBlock	; W block
		dc.w $AE00
		dc.l ArtKospM_SSGlass	; glass	block
		dc.w $BE00
		dc.l ArtKospM_SSEmerald	; emeralds
		dc.w $EE00
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - GHZ animals
; ---------------------------------------------------------------------------
PLC_GHZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - LZ animals
; ---------------------------------------------------------------------------
PLC_LZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - MZ animals
; ---------------------------------------------------------------------------
PLC_MZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - SLZ animals
; ---------------------------------------------------------------------------
PLC_SLZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - SYZ animals
; ---------------------------------------------------------------------------
PLC_SYZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - SBZ animals
; ---------------------------------------------------------------------------
PLC_SBZAnimals:
		dc.l ArtKospM_Null
		dc.w $B000
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Blackout Challenge special stage overrides
; ---------------------------------------------------------------------------
PLC_SSBlackout:
		dc.l ArtKospM_SSSkull	; Skull block
		dc.w $4A20
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - ending sequence
; ---------------------------------------------------------------------------
PLC_Ending:
		dc.l ArtKospM_GHZ		; GHZ patterns
		dc.w 0
		dc.l ArtKospM_Stalk		; flower stalk
		dc.w $6B00
		dc.l ArtKospM_EndFlower	; flowers
		dc.w $7400
		dc.l ArtKospM_EndEm		; emeralds
		dc.w $78A0
		dc.l ArtKospM_EndSonic	; Sonic
		dc.w $7C20
		dc.l ArtKospM_UMadBro	; U Mad Bro?!
		dc.w $A480
		dc.l ArtKospM_Rabbit		; rabbit
		dc.w $AA60
		dc.l ArtKospM_Chicken	; chicken
		dc.w $ACA0
		dc.l ArtKospM_BlackBird	; blackbird
		dc.w $AE60
		dc.l ArtKospM_Seal		; seal
		dc.w $B0A0
		dc.l ArtKospM_Pig		; pig
		dc.w $B260
		dc.l ArtKospM_Flicky		; flicky
		dc.w $B4A0
		dc.l ArtKospM_Squirrel	; squirrel
		dc.w $B660
		dc.l ArtKospM_EndStH		; "SONIC THE HEDGEHOG"
		dc.w $B8A0
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------
PLC_TryAgain:
		dc.l ArtKospM_EndEm		; emeralds
		dc.w $78A0
		dc.l ArtKospM_TryAgain	; Eggman
		dc.w $7C20
		dc.l ArtKospM_CreditText	; credits alphabet
		dc.w $B400
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - Eggman on SBZ 2
; ---------------------------------------------------------------------------
PLC_EggmanSBZ2:
		dc.l ArtKospM_Sbz2Eggman	; Eggman
		dc.w $8000
		dc.l ArtKospM_LzSwitch	; switch
		dc.w $9400
		dc.l ArtKospM_BombOld	; bomb enemy
		dc.w $A660
		dc.l ArtKospM_BombMach	; bomb machine
		dc.w $5600
		dc.w -1

; ---------------------------------------------------------------------------
; Pattern load cues - final boss
; ---------------------------------------------------------------------------
PLC_FZBoss:
		dc.l ArtKospM_SbzDoor1	; door
		dc.w $5500
		dc.l ArtKospM_FzEggman	; Eggman after boss
		dc.w $7400
		dc.l ArtKospM_FzBoss		; FZ boss
		dc.w $6000
		dc.l ArtKospM_Eggman		; Eggman main patterns
		dc.w $8000
		dc.l ArtKospM_Sbz2Eggman	; Eggman without ship
		dc.w $8E00
		dc.l ArtKospM_Exhaust	; exhaust flame
		dc.w $A540
		dc.w -1

; ---------------------------------------------------------------------------
