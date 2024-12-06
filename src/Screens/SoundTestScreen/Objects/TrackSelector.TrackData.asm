
; Generates a string with length definition
@str:	macro *, string, maxLen
	if strlen(\string) > maxLen
		inform 3, "Maximum supported length exceeded!"
	endif
\*:	dc.b	\string
\*.len:	equ *-\*
	dc.b	0
	endm

; Writes down a padded string pointer, includes string length in MSB
@dcStr:	macro
	rept narg
		dc.l	((\1\.len)<<24) | (\1 & $FFFFFF)
		shift
	endr
	endm

; ---------------------------------------------------------------------------

	; BGM ($81..$9F)
	@dcStr	@Music81_Name, @Music81_Source	; $81
	@dcStr	@Music82_Name, @Music82_Source	; $82
	@dcStr	@Music83_Name, @Music83_Source	; $83
	@dcStr	@Music84_Name, @Music84_Source	; $84
	@dcStr	@Music85_Name, @Music85_Source	; $85
	@dcStr	@Music86_Name, @Music86_Source	; $86
	@dcStr	@Music87_Name, @Music87_Source	; $87
	@dcStr	@Music88_Name, @Music88_Source	; $88
	@dcStr	@Music89_Name, @Music89_Source	; $89
	@dcStr	@Music8A_Name, @Music8A_Source	; $8A
	@dcStr	@Music8B_Name, @Music8B_Source	; $8B
	@dcStr	@Music8C_Name, @Music8C_Source	; $8C
	@dcStr	@Music8D_Name, @Music8D_Source	; $8D
	@dcStr	@Music8E_Name, @Music8E_Source	; $8E
	@dcStr	@Music8F_Name, @Music8F_Source	; $8F
	@dcStr	@Music90_Name, @Music90_Source	; $90
	@dcStr	@Music91_Name, @Music91_Source	; $91
	@dcStr	@Music92_Name, @Music92_Source	; $92
	@dcStr	@Music93_Name, @Music93_Source	; $93
	@dcStr	@Music94_Name, @Music94_Source	; $94
	@dcStr	@Music95_Name, @Music95_Source	; $95
	@dcStr	@Music96_Name, @Music96_Source	; $96
	@dcStr	@Music97_Name, @Music97_Source	; $97
	@dcStr	@Music98_Name, @Music98_Source	; $98
	@dcStr	@Music99_Name, @Music99_Source	; $99
	@dcStr	@Music9A_Name, @Music9A_Source	; $9A
	@dcStr	@Music9B_Name, @Music9B_Source	; $9B
	@dcStr	@Music9C_Name, @Music9C_Source	; $9C
	@dcStr	@Music9D_Name, @Music9D_Source	; $9D
	@dcStr	@Music9E_Name, @Music9E_Source	; $9E
	@dcStr	@Music9F_Name, @Music9F_Source	; $9F

	; SFX ($A0..$DF)
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
	
	@dcStr	@Sound_Misc, @SoundE0_Name	; $E0
	@dcStr	@Sound_Misc, @SoundE1_Name	; $E1
	@dcStr	@Sound_Misc, @SoundE2_Name	; $E2
	@dcStr	@Sound_Misc, @SoundE3_Name	; $E3
	@dcStr	@Sound_Misc, @SoundE4_Name	; $E4

; ---------------------------------------------------------------------------
@titleMaxLen: = 28
@descMaxLen: = 52

@Music81_Name:		@str 'NIGHT HILL PLACE', @titleMaxLen
@Music81_Source:	@str 'F1 POLE POSITION - HOCKENHEIM RING', @descMaxLen

@Music82_Name:		@str 'LABYRINTHY PLACE', @titleMaxLen
@Music82_Source:	@str 'MEGA MAN 4 - DR. COSSACK STAGE 2', @descMaxLen

@Music83_Name:		@str 'RUINED PLACE', @titleMaxLen
@Music83_Source:	@str "ETERNAL CHAMPIONS - BLADE'S THEME", @descMaxLen

@Music84_Name		@str 'SCAR NIGHT PLACE', @titleMaxLen
@Music84_Source:	@str 'MEGA MAN IV - GB - TITLE SCREEN', @descMaxLen

@Music85_Name:		@str '^BERHUB PLACE', @titleMaxLen
@Music85_Source:	@str 'MEGA MAN 7 - FREEZE MAN STAGE', @descMaxLen

@Music86_Name:		@str 'GREEN HILL PLACE', @titleMaxLen
@Music86_Source:	@str 'MEGA MAN X - SPARK MANDRILL', @descMaxLen

@Music87_Name:		@str 'TUTORIAL PLACE', @titleMaxLen
@Music87_Source:	@str 'NINJA GAIDEN - STAGE 4-2', @descMaxLen

@Music88_Name:		@str 'SPECIAL STAGE CLEAR', @titleMaxLen
@Music88_Source:	@str "SONIC THE HEDGEHOG 1 - YEAH, IT'S THE SAME", @descMaxLen

@Music89_Name:		@str 'SPECIAL PLACE', @titleMaxLen
@Music89_Source:	@str 'TECMO WRESTLING - HIDDEN TRACK', @descMaxLen

@Music8A_Name:		@str 'TITLE SCREEN', @titleMaxLen
@Music8A_Source:	@str 'SUPER STREET FIGHTER II TURBO - OPENING SEQUENCE', @descMaxLen

@Music8B_Name:		@str '=P MONITOR', @titleMaxLen
@Music8B_Source:	@str 'THE ORIGINAL VERSION OF SONIC ERAZOR FROM 2010', @descMaxLen

@Music8C_Name:		@str 'GREEN HILL PLACE BOSS', @titleMaxLen
@Music8C_Source:	@str 'SONIC ADVANCE 3 - CHAOS ANGEL ACT 1', @descMaxLen

@Music8D_Name:		@str 'FINALOR PLACE', @titleMaxLen
@Music8D_Source:	@str 'PULSEMAN - SHUTDOWN', @descMaxLen

@Music8E_Name:		@str 'UNTERHUB PLACE', @titleMaxLen
@Music8E_Source:	@str 'SONIC 3D BLAST - THE FINAL FIGHT', @descMaxLen

@Music8F_Name:		@str 'NOT READING THE TUTORIAL', @titleMaxLen
@Music8F_Source:	@str 'SONIC THE HEDGEHOG 1 - GAME OVER', @descMaxLen

@Music90_Name:		@str 'THE GREAT ESCAPE', @titleMaxLen
@Music90_Source:	@str 'MEGA MAN X3 - OPENING STAGE', @descMaxLen

@Music91_Name:		@str 'INVINCIBILITY', @titleMaxLen
@Music91_Source:	@str 'DANGEROUS SEED - ENDING THEME', @descMaxLen

@Music92_Name:		@str 'FUN IN LABYRINTHY PLACE', @titleMaxLen
@Music92_Source:	@str 'SONIC THE HEDGEHOG 1 - DROWN', @descMaxLen

@Music93_Name:		@str 'UNTERHUB PLACE BOSS', @titleMaxLen
@Music93_Source:	@str 'GUNSTAR HEROES - MILITARY ON THE MAX POWER', @descMaxLen

@Music94_Name:		@str 'GREEN HILL ZO... PLACE', @titleMaxLen
@Music94_Source:	@str 'SONIC THE HEDGEHOG 1 - GREEN HILL ZONE', @descMaxLen

@Music95_Name:		@str 'INTRO CUTSCENE', @titleMaxLen
@Music95_Source:	@str 'STREET FIGHTER II - KEN''S THEME', @descMaxLen

@Music96_Name:		@str 'STAR AGONY PLACE', @titleMaxLen
@Music96_Source:	@str 'THUNDER FORCE III - STAGE 7: ORN BASE', @descMaxLen

@Music97_Name:		@str 'CREDITS', @titleMaxLen
@Music97_Source:	@str 'GUNDAM WING: ENDLESS DUEL - OPENING / RHYTHM EMOTION', @descMaxLen

@Music98_Name:		@str 'CRABMEAT BOSS', @titleMaxLen
@Music98_Source:	@str 'SONIC ADVANCE 3 - BOSS - PINCH', @descMaxLen

@Music99_Name:		@str 'TUTORIAL INTRODUCTION', @titleMaxLen
@Music99_Source:	@str 'MEGA MAN 5 - DARK MAN/PROTO MAN STAGES', @descMaxLen

@Music9A_Name:		@str 'UNREAL PLACE', @titleMaxLen
@Music9A_Source:	@str 'SHINOBI III - WHIRLWIND', @descMaxLen

@Music9B_Name:		@str 'WALKING BOMB BOSS', @titleMaxLen
@Music9B_Source:	@str 'SONIC ADVANCE 3 - BOSS - PINCH... BUT DIFFERENT', @descMaxLen

@Music9C_Name:		@str 'BLACKOUT CHALLENGE', @titleMaxLen
@Music9C_Source:	@str 'PULSEMAN - SHUTDOWN - DARK REMIX', @descMaxLen

@Music9D_Name:		@str 'ENDING SEQUENCE', @titleMaxLen
@Music9D_Source:	@str 'ZILLION PUSH - PUSH!', @descMaxLen

@Music9E_Name:		@str 'FINAL BOSS', @titleMaxLen
@Music9E_Source:	@str 'SONIC THE HEDGEHOG 3 - FINAL BOSS... TOO', @descMaxLen

@Music9F_Name:		@str 'INHUMAN MODE', @titleMaxLen
@Music9F_Source:	@str 'MEGA MAN ZERO 4 - STRAIGHT AHEAD', @descMaxLen

; ---------------------------------------------------------------------------

@Sound_Header:		@str '-SFX-', @titleMaxLen

@SoundA0_Name:		@str 'YOU JUMPED', @descMaxLen
@SoundA1_Name:		@str 'YOU TOUCHED A CHECKPOINT', @descMaxLen
@SoundA2_Name:		@str "THE SOUND OF... I DON'T KNOW", @descMaxLen
@SoundA3_Name:		@str 'YOU ARE DEAD', @descMaxLen
@SoundA4_Name:		@str 'YOU STOPPED', @descMaxLen
@SoundA5_Name:		@str 'A FIREBALL WAS SPAT, I GUESS?', @descMaxLen
@SoundA6_Name:		@str 'IMPALED WITH EXTREME PREJUDICE', @descMaxLen
@SoundA7_Name:		@str 'YOU ARE PUSHING A ROCK', @descMaxLen
@SoundA8_Name:		@str 'YOU ARE GETTING WARPED', @descMaxLen
@SoundA9_Name:		@str 'THE BEST SOUND IN THE GAME', @descMaxLen
@SoundAA_Name:		@str 'YOU ARE ENTERING WATER', @descMaxLen
@SoundAB_Name:		@str 'HE''S TRYING HIS BEST', @descMaxLen
@SoundAC_Name:		@str 'EXPLOSIONS.', @descMaxLen
@SoundAD_Name:		@str 'YOU GOT AIR', @descMaxLen
@SoundAE_Name:		@str 'A FIREBALL WAS SPAT... AGAIN', @descMaxLen
@SoundAF_Name:		@str 'YOU GOT A SHIELD', @descMaxLen
@SoundB0_Name:		@str 'YOU ENTERED HELL', @descMaxLen
@SoundB1_Name:		@str "BZZZZ", @descMaxLen
@SoundB2_Name:		@str 'LEARN HOW TO SWIM DUMMY', @descMaxLen
@SoundB3_Name:		@str "HOW MANY FIREBALL SOUNDS ARE IN THIS GAME?!", @descMaxLen
@SoundB4_Name:		@str 'YOU HIT A BUMPER', @descMaxLen
@SoundB5_Name:		@str 'YOU GOT A RING', @descMaxLen
@SoundB6_Name:		@str 'SPIKES HAVE MOVED', @descMaxLen
@SoundB7_Name:		@str 'I WISH TERRAFORMING WAS REAL', @descMaxLen
@SoundB8_Name:		@str 'SPIKES HAVE MOVED... AGAIN', @descMaxLen
@SoundB9_Name:		@str 'YOU BROKE SOMETHING BIG TIME', @descMaxLen
@SoundBA_Name:		@str 'YOU TOUCHED GRA- I MEAN GLASS', @descMaxLen
@SoundBB_Name:		@str 'A FLAPPY DOOR HAS OPENED', @descMaxLen
@SoundBC_Name:		@str 'YOU DASHED', @descMaxLen
@SoundBD_Name:		@str 'A STOMPER HAS STOMPED', @descMaxLen
@SoundBE_Name:		@str 'YOU ARE SPINNING', @descMaxLen
@SoundBF_Name:		@str 'YOU WISH THIS SOUND WAS ACTUALLY IN THE GAME', @descMaxLen
@SoundC0_Name:		@str 'A BAT IS TAKING TO THE SKIES', @descMaxLen
@SoundC1_Name:		@str 'EXPLOSIONS.', @descMaxLen
@SoundC2_Name:		@str 'YOU SHOULD GO OUTSIDE', @descMaxLen
@SoundC3_Name:		@str 'I WISH TELEPORTATION WAS REAL', @descMaxLen
@SoundC4_Name:		@str 'EXPLOSIONS.', @descMaxLen
@SoundC5_Name:		@str 'THE SOUND THAT PLAYS WHEN YOUR CRUSH SAYS YES', @descMaxLen
@SoundC6_Name:		@str 'YOU SUCK', @descMaxLen
@SoundC7_Name:		@str "CHAINY THING GOIN' UP", @descMaxLen
@SoundC8_Name:		@str "ROCKET THING GOIN' UP", @descMaxLen
@SoundC9_Name:		@str 'JUST ONE MORE, COME ON...', @descMaxLen
@SoundCA_Name:		@str 'YOU ENTERED A SPECIAL STAGE', @descMaxLen
@SoundCB_Name:		@str 'EXPLOSIONS.', @descMaxLen
@SoundCC_Name:		@str 'YOU TOUCHED A SPRING', @descMaxLen
@SoundCD_Name:		@str 'YOU PRESSED A BUTTON', @descMaxLen
@SoundCE_Name:		@str 'YOU GOT ANOTHER RING', @descMaxLen
@SoundCF_Name:		@str 'YOU BEAT A LEVEL, HOORAY', @descMaxLen
@SoundD0_Name:		@str 'YOU DREAM OF THE BEACH', @descMaxLen
@SoundD1_Name:		@str 'YOU ARE ABOUT TO GO NYOOM', @descMaxLen
@SoundD2_Name:		@str 'YOU ARE ABOUT TO GO REALLY NYOOM', @descMaxLen
@SoundD3_Name:		@str 'YOU WENT REALLY NYOOM', @descMaxLen
@SoundD4_Name:		@str 'LITERALLY NOTHING', @descMaxLen
@SoundD5_Name:		@str 'THE SOUND OF SILENCE', @descMaxLen
@SoundD6_Name:		@str 'STILL NOTHING', @descMaxLen
@SoundD7_Name:		@str 'PATHETIC EXPLOSION', @descMaxLen
@SoundD8_Name:		@str 'MENU SELECTION', @descMaxLen
@SoundD9_Name:		@str 'HECK YEAH', @descMaxLen
@SoundDA_Name:		@str 'HECK NO', @descMaxLen
@SoundDB_Name:		@str 'REALLY HECKING BIG EXPLOSION', @descMaxLen
@SoundDC_Name:		@str 'NUH UH', @descMaxLen
@SoundDD_Name:		@str 'PROBABLY A NUKE GOING OFF', @descMaxLen
@SoundDE_Name:		@str 'HOW HIGH IN THE SKY CAN YOU FLY?', @descMaxLen
@SoundDF_Name:		@str 'AW MAN YOU BROKE IT', @descMaxLen

; ---------------------------------------------------------------------------

@Sound_Misc:		@str '-MISC-', @titleMaxLen	

@SoundE0_Name:		@str 'FADE OUT MUSIC', @descMaxLen
@SoundE1_Name:		@str 'SEGA CHANT FEATURING YOURS TRULY', @descMaxLen
@SoundE2_Name:		@str 'MUSIC SPEED: FAST', @descMaxLen
@SoundE3_Name:		@str 'MUSIC SPEED: NORMAL', @descMaxLen
@SoundE4_Name:		@str 'STOP MUSIC', @descMaxLen

	even
