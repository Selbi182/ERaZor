
; Generates a padded string with length definition
@paddedString: macro *, string, padLen
\*:	dc.b	\string
\*.len:	equ *-\*
	dcb.b	\padLen-strlen(\string), ' '
	dc.b	0
	endm

; Writes down a padded string pointer
@dcStr:	macro
	rept narg
		dc.l	((\1\.len)<<24) | (\1 & $FFFFFF)
		shift
	endr
	endm

; ---------------------------------------------------------------------------

	; BGM
	@dcStr	@Music81_Name, @Music81_Source
	@dcStr	@Music82_Name, @Music82_Source
	@dcStr	@Music83_Name, @Music83_Source
	@dcStr	@Music84_Name, @Music84_Source
	@dcStr	@Music85_Name, @Music85_Source
	@dcStr	@Music86_Name, @Music86_Source
	@dcStr	@Music87_Name, @Music87_Source
	@dcStr	@Music88_Name, @Music88_Source
	@dcStr	@Music89_Name, @Music89_Source
	@dcStr	@Music8A_Name, @Music8A_Source
	@dcStr	@Music8B_Name, @Music8B_Source
	@dcStr	@Music8C_Name, @Music8C_Source
	@dcStr	@Music8D_Name, @Music8D_Source
	@dcStr	@Music8E_Name, @Music8E_Source
	@dcStr	@Music8F_Name, @Music8F_Source
	@dcStr	@Music90_Name, @Music90_Source
	@dcStr	@Music91_Name, @Music91_Source
	@dcStr	@Music92_Name, @Music92_Source
	@dcStr	@Music93_Name, @Music93_Source
	@dcStr	@Music94_Name, @Music94_Source
	@dcStr	@Music95_Name, @Music95_Source
	@dcStr	@Music96_Name, @Music96_Source
	@dcStr	@Music97_Name, @Music97_Source
	@dcStr	@Music98_Name, @Music98_Source
	@dcStr	@Music99_Name, @Music99_Source
	@dcStr	@Music9A_Name, @Music9A_Source
	@dcStr	@Music9B_Name, @Music9B_Source
	@dcStr	@Music9C_Name, @Music9C_Source
	@dcStr	@Music9D_Name, @Music9D_Source
	@dcStr	@Music9E_Name, @Music9E_Source
	@dcStr	@Music9F_Name, @Music9F_Source

	; SFX
	@dcStr	@Sound_Header, @SoundA0_Name	; $A0
	@dcStr	@Sound_Header, @SoundA1_Name	; $A1
	@dcStr	@Sound_Header, @SoundA2_Name	; $A2
	@dcStr	@Sound_Header, @SoundA3_Name	; $A3
	@dcStr	@Sound_Header, @SoundA4_Name	; $A4
	@dcStr	@Sound_Header, @SoundA5_Name	; $A5
	@dcStr	@Sound_Header, @SoundA6_Name	; $A6
	@dcStr	@Sound_Header, @SoundA7_Name	; $A7
	@dcStr	@Sound_Header, @SoundA8_Name	; $A8
	@dcStr	@Sound_Header, @SoundA9_Name	; $A9
	@dcStr	@Sound_Header, @SoundAA_Name	; $AA
	@dcStr	@Sound_Header, @SoundAB_Name	; $AB
	@dcStr	@Sound_Header, @SoundAC_Name	; $AC
	@dcStr	@Sound_Header, @SoundAD_Name	; $AD
	@dcStr	@Sound_Header, @SoundAE_Name	; $AE
	@dcStr	@Sound_Header, @SoundAF_Name	; $AF
	@dcStr	@Sound_Header, @SoundB0_Name	; $B0
	@dcStr	@Sound_Header, @SoundB1_Name	; $B1
	@dcStr	@Sound_Header, @SoundB2_Name	; $B2
	@dcStr	@Sound_Header, @SoundB3_Name	; $B3
	@dcStr	@Sound_Header, @SoundB4_Name	; $B4
	@dcStr	@Sound_Header, @SoundB5_Name	; $B5
	@dcStr	@Sound_Header, @SoundB6_Name	; $B6
	@dcStr	@Sound_Header, @SoundB7_Name	; $B7
	@dcStr	@Sound_Header, @SoundB8_Name	; $B8
	@dcStr	@Sound_Header, @SoundB9_Name	; $B9
	@dcStr	@Sound_Header, @SoundBA_Name	; $BA
	@dcStr	@Sound_Header, @SoundBB_Name	; $BB
	@dcStr	@Sound_Header, @SoundBC_Name	; $BC
	@dcStr	@Sound_Header, @SoundBD_Name	; $BD
	@dcStr	@Sound_Header, @SoundBE_Name	; $BE
	@dcStr	@Sound_Header, @SoundBF_Name	; $BF
	@dcStr	@Sound_Header, @SoundC0_Name	; $C0
	@dcStr	@Sound_Header, @SoundC1_Name	; $C1
	@dcStr	@Sound_Header, @SoundC2_Name	; $C2
	@dcStr	@Sound_Header, @SoundC3_Name	; $C3
	@dcStr	@Sound_Header, @SoundC4_Name	; $C4
	@dcStr	@Sound_Header, @SoundC5_Name	; $C5
	@dcStr	@Sound_Header, @SoundC6_Name	; $C6
	@dcStr	@Sound_Header, @SoundC7_Name	; $C7
	@dcStr	@Sound_Header, @SoundC8_Name	; $C8
	@dcStr	@Sound_Header, @SoundC9_Name	; $C9
	@dcStr	@Sound_Header, @SoundCA_Name	; $CA
	@dcStr	@Sound_Header, @SoundCB_Name	; $CB
	@dcStr	@Sound_Header, @SoundCC_Name	; $CC
	@dcStr	@Sound_Header, @SoundCD_Name	; $CD
	@dcStr	@Sound_Header, @SoundCE_Name	; $CE
	@dcStr	@Sound_Header, @SoundCF_Name	; $CF
	@dcStr	@Sound_Header, @SoundD0_Name	; $D0
	@dcStr	@Sound_Header, @SoundD1_Name	; $D1
	@dcStr	@Sound_Header, @SoundD2_Name	; $D2
	@dcStr	@Sound_Header, @SoundD3_Name	; $D3
	@dcStr	@Sound_Header, @SoundD4_Name	; $D4
	@dcStr	@Sound_Header, @SoundD5_Name	; $D5
	@dcStr	@Sound_Header, @SoundD6_Name	; $D6
	@dcStr	@Sound_Header, @SoundD7_Name	; $D7
	@dcStr	@Sound_Header, @SoundD8_Name	; $D8
	@dcStr	@Sound_Header, @SoundD9_Name	; $D9
	@dcStr	@Sound_Header, @SoundDA_Name	; $DA
	@dcStr	@Sound_Header, @SoundDB_Name	; $DB
	@dcStr	@Sound_Header, @SoundDC_Name	; $DC
	@dcStr	@Sound_Header, @SoundDD_Name	; $DD
	@dcStr	@Sound_Header, @SoundDE_Name	; $DE
	@dcStr	@Sound_Header, @SoundDF_Name	; $DF

; ---------------------------------------------------------------------------
@titlePadding: = 28
@descPadding: = 52

@Music81_Name:		@paddedString 'NIGHT HILL PLACE', @titlePadding
@Music81_Source:	@paddedString 'F1 POLE POSITION - HOCKENHEIM RING', @descPadding

@Music82_Name:		@paddedString 'LABYRINTHY PLACE', @titlePadding
@Music82_Source:	@paddedString 'MEGA MAN 4 - DR. COSSACK STAGE 2', @descPadding

@Music83_Name:		@paddedString 'RUINED PLACE', @titlePadding
@Music83_Source:	@paddedString "ETERNAL CHAMPIONS - BLADE'S THEME", @descPadding

@Music84_Name		@paddedString 'SCAR NIGHT PLACE', @titlePadding
@Music84_Source:	@paddedString 'MEGA MAN IV - GB - TITLE SCREEN', @descPadding

@Music85_Name:		@paddedString 'UBERHUB PLACE', @titlePadding
@Music85_Source:	@paddedString 'MEGA MAN 7 - FREEZE MAN STAGE', @descPadding

@Music86_Name:		@paddedString 'GREEN HILL PLACE', @titlePadding
@Music86_Source:	@paddedString 'MEGA MAN X - SPARK MANDRILL', @descPadding

@Music87_Name:		@paddedString 'TUTORIAL PLACE', @titlePadding
@Music87_Source:	@paddedString 'NINJA GAIDEN - STAGE 4-2', @descPadding

@Music88_Name:		@paddedString 'SPECIAL STAGE CLEAR', @titlePadding
@Music88_Source:	@paddedString "SONIC THE HEDGEHOG 1 - YEAH, IT'S THE SAME", @descPadding

@Music89_Name:		@paddedString 'SPECIAL PLACE', @titlePadding
@Music89_Source:	@paddedString 'TECMO WRESTLING - HIDDEN TRACK', @descPadding

@Music8A_Name:		@paddedString 'TITLE SCREEN', @titlePadding
@Music8A_Source:	@paddedString 'SUPER STREET FIGHTER II TURBO - OPENING SEQUENCE', @descPadding

@Music8B_Name:		@paddedString '=P MONITOR', @titlePadding
@Music8B_Source:	@paddedString 'ORIGINAL VERSION OF SONIC ERAZOR FROM 2010', @descPadding

@Music8C_Name:		@paddedString 'GREEN HILL PLACE BOSS', @titlePadding
@Music8C_Source:	@paddedString 'SONIC ADVANCE 3 - BOSS', @descPadding

@Music8D_Name:		@paddedString 'FINALOR PLACE', @titlePadding
@Music8D_Source:	@paddedString 'PULSEMAN - SHUTDOWN', @descPadding

@Music8E_Name:		@paddedString '...UNUSED...', @titlePadding
@Music8E_Source:	@paddedString 'SONIC THE HEDGEHOG 1 - ACT CLEAR', @descPadding

@Music8F_Name:		@paddedString '...ALSO UNUSED...', @titlePadding
@Music8F_Source:	@paddedString 'SONIC THE HEDGEHOG 1 - GAME OVER', @descPadding

@Music90_Name:		@paddedString 'THE GREAT ESCAPE', @titlePadding
@Music90_Source:	@paddedString 'MEGA MAN X3 - OPENING STAGE', @descPadding

@Music91_Name:		@paddedString 'INVINCIBILITY', @titlePadding
@Music91_Source:	@paddedString 'DANGEROUS SEED - ENDING THEME', @descPadding

@Music92_Name:		@paddedString 'FUN IN LABYRINTHY PLACE', @titlePadding
@Music92_Source:	@paddedString 'SONIC THE HEDGEHOG 1 - DROWN', @descPadding

@Music93_Name:		@paddedString '...YUP, UNUSED...', @titlePadding
@Music93_Source:	@paddedString 'SONIC THE HEDGEHOG 1 - 1-UP JINGLE', @descPadding

@Music94_Name:		@paddedString 'GREEN HILL ZO... PLACE', @titlePadding
@Music94_Source:	@paddedString 'SONIC THE HEDGEHOG 1 - GREEN HILL ZONE', @descPadding

@Music95_Name:		@paddedString 'INTRO CUTSCENE', @titlePadding
@Music95_Source:	@paddedString 'STREET FIGHTER II - KEN''S THEME', @descPadding

@Music96_Name:		@paddedString 'STAR AGONY PLACE', @titlePadding
@Music96_Source:	@paddedString 'THUNDER FORCE III - STAGE 7: ORN BASE', @descPadding

@Music97_Name:		@paddedString 'CREDITS', @titlePadding
@Music97_Source:	@paddedString 'GUNDAM WING: ENDLESS DUEL - OPENING / RHYTHM EMOTION', @descPadding

@Music98_Name:		@paddedString 'CRABMEAT BOSS', @titlePadding
@Music98_Source:	@paddedString 'SONIC ADVANCE 3 - BOSS', @descPadding

@Music99_Name:		@paddedString 'TUTORIAL INTRODUCTION', @titlePadding
@Music99_Source:	@paddedString 'MEGA MAN 5 - DARK MAN/PROTO MAN STAGES', @descPadding

@Music9A_Name:		@paddedString 'UNREAL PLACE', @titlePadding
@Music9A_Source:	@paddedString 'SHINOBI III - WHIRLWIND', @descPadding

@Music9B_Name:		@paddedString 'WALKING BOMB BOSS', @titlePadding
@Music9B_Source:	@paddedString 'SONIC ADVANCE 3 - BOSS - PINCH', @descPadding

@Music9C_Name:		@paddedString '??? UNUSED ???', @titlePadding ; Blackout Challenge
@Music9C_Source:	@paddedString 'PULSEMAN - SHUTDOWN - DARK REMIX', @descPadding

@Music9D_Name:		@paddedString 'ENDING SEQUENCE', @titlePadding
@Music9D_Source:	@paddedString 'ZILLION PUSH - PUSH!', @descPadding

@Music9E_Name:		@paddedString 'FINAL BOSS', @titlePadding
@Music9E_Source:	@paddedString 'SONIC THE HEDGEHOG 3 - FINAL BOSS... TOO', @descPadding

@Music9F_Name:		@paddedString 'INHUMAN MODE', @titlePadding
@Music9F_Source:	@paddedString 'MEGA MAN ZERO 4 - STRAIGHT AHEAD', @descPadding

; ---------------------------------------------------------------------------

@Sound_Header:		@paddedString '-SFX-', @titlePadding	
@Sound_NoSource:	@paddedString ' ', @descPadding

@SoundA0_Name:		@paddedString 'YOU JUMPED', @descPadding
@SoundA1_Name:		@paddedString 'YOU TOUCHED A CHECKPOINT', @descPadding
@SoundA2_Name:		@paddedString "THE SOUND OF... I DON'T KNOW", @descPadding
@SoundA3_Name:		@paddedString 'YOU ARE DEAD', @descPadding
@SoundA4_Name:		@paddedString 'YOU STOPPED', @descPadding
@SoundA5_Name:		@paddedString 'A FIREBALL WAS SPAT, I GUESS?', @descPadding
@SoundA6_Name:		@paddedString 'IMPALED WITH EXTREME PREJUDICE', @descPadding
@SoundA7_Name:		@paddedString 'YOU ARE PUSHING A ROCK', @descPadding
@SoundA8_Name:		@paddedString 'YOU ARE GETTING WARPED', @descPadding
@SoundA9_Name:		@paddedString 'THE BEST SOUND IN THE GAME', @descPadding
@SoundAA_Name:		@paddedString 'YOU ARE ENTERING WATER', @descPadding
@SoundAB_Name:		@paddedString 'NO IDEA WHAT THIS IS EITHER', @descPadding
@SoundAC_Name:		@paddedString 'EXPLOSIONS.', @descPadding
@SoundAD_Name:		@paddedString 'YOU GOT AIR', @descPadding
@SoundAE_Name:		@paddedString 'A FIREBALL WAS SPAT... AGAIN', @descPadding
@SoundAF_Name:		@paddedString 'YOU GOT A SHIELD', @descPadding
@SoundB0_Name:		@paddedString 'YOU ENTERED HELL', @descPadding
@SoundB1_Name:		@paddedString "BZZZZ", @descPadding
@SoundB2_Name:		@paddedString 'LEARN HOW TO SWIM DUMMY', @descPadding
@SoundB3_Name:		@paddedString "HOW MANY DAMN FIREBALL SOUNDS ARE IN THIS GAME?!", @descPadding
@SoundB4_Name:		@paddedString 'YOU HIT A BUMPER', @descPadding
@SoundB5_Name:		@paddedString 'YOU GOT A RING', @descPadding
@SoundB6_Name:		@paddedString 'SPIKES HAVE MOVED', @descPadding
@SoundB7_Name:		@paddedString 'I WISH TERRAFORMING WAS REAL', @descPadding
@SoundB8_Name:		@paddedString 'SPIKES HAVE MOVED... AGAIN', @descPadding
@SoundB9_Name:		@paddedString 'YOU BROKE SOMETHING BIG TIME', @descPadding
@SoundBA_Name:		@paddedString 'YOU TOUCHED GRA- I MEAN GLASS', @descPadding
@SoundBB_Name:		@paddedString 'A FLAPPY DOOR HAS OPENED', @descPadding
@SoundBC_Name:		@paddedString 'YOU DASHED', @descPadding
@SoundBD_Name:		@paddedString 'A STOMPER HAS STOMPED', @descPadding
@SoundBE_Name:		@paddedString 'YOU ARE SPINNING', @descPadding
@SoundBF_Name:		@paddedString 'YOU WISH THIS SOUND WAS ACTUALLY IN THE GAME', @descPadding
@SoundC0_Name:		@paddedString 'A BAT IS TAKING TO THE SKIES', @descPadding
@SoundC1_Name:		@paddedString 'EXPLOSIONS.', @descPadding
@SoundC2_Name:		@paddedString 'YOU SHOULD GO OUTSIDE', @descPadding
@SoundC3_Name:		@paddedString 'I WISH TELEPORTATION WAS REAL', @descPadding
@SoundC4_Name:		@paddedString 'EXPLOSIONS.', @descPadding
@SoundC5_Name:		@paddedString 'THE SOUND THAT PLAYS WHEN YOUR CRUSH SAYS YES', @descPadding
@SoundC6_Name:		@paddedString 'YOU SUCK', @descPadding
@SoundC7_Name:		@paddedString "CHAINY THING GOIN' UP", @descPadding
@SoundC8_Name:		@paddedString "ROCKET THING GOIN' UP / ANOTHER FIREBALL SOUND", @descPadding
@SoundC9_Name:		@paddedString 'JUST ONE MORE, COME ON...', @descPadding
@SoundCA_Name:		@paddedString 'YOU ENTERED A SPECIAL STAGE', @descPadding
@SoundCB_Name:		@paddedString 'EXPLOSIONS.', @descPadding
@SoundCC_Name:		@paddedString 'YOU TOUCHED A SPRING', @descPadding
@SoundCD_Name:		@paddedString 'YOU PRESSED A BUTTON', @descPadding
@SoundCE_Name:		@paddedString 'YOU GOT ANOTHER RING', @descPadding
@SoundCF_Name:		@paddedString 'YOU BEAT A LEVEL, HOORAY', @descPadding
@SoundD0_Name:		@paddedString 'YOU DREAM OF THE BEACH', @descPadding
@SoundD1_Name:		@paddedString 'YOU ARE ABOUT TO GO NYOOM', @descPadding
@SoundD2_Name:		@paddedString 'YOU ARE ABOUT TO GO REALLY NYOOM', @descPadding
@SoundD3_Name:		@paddedString 'YOU WENT REALLY NYOOM', @descPadding
@SoundD4_Name:		@paddedString 'LITERALLY NOTHING', @descPadding
@SoundD5_Name:		@paddedString 'THE SOUND OF SILENCE', @descPadding
@SoundD6_Name:		@paddedString 'STILL NOTHING', @descPadding
@SoundD7_Name:		@paddedString 'PATHETIC EXPLOSION', @descPadding
@SoundD8_Name:		@paddedString 'MENU SELECTION', @descPadding
@SoundD9_Name:		@paddedString 'OPTION CONFIRMED', @descPadding
@SoundDA_Name:		@paddedString 'OPTION DENIED', @descPadding
@SoundDB_Name:		@paddedString 'REALLY HECKING BIG EXPLOSION', @descPadding
@SoundDC_Name:		@paddedString 'NUH UH', @descPadding
@SoundDD_Name:		@paddedString 'PROBABLY A NUKE GOING OFF', @descPadding
@SoundDE_Name:		@paddedString 'HOW HIGH IN THE SKY CAN YOU FLY?', @descPadding
@SoundDF_Name:		@paddedString 'AW MAN YOU BROKE IT', @descPadding

	even
