
obSTSelectedTrack:	equ	$20	; .b

obST_MinTrack	= $81
obST_MaxTrack	= $DF

; ---------------------------------------------------------------------------
; Track selector controller for the sound test
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector:
	moveq	#$FFFFFF81, d0			; play initial music
	jsr	PlaySound_Special
	move.b	d0, obSTSelectedTrack(a0)	; set initial track
	bsr	@RedrawTrackInfo		; display this track
	move.l	#@Main, obCodePtr(a0)

; ---------------------------------------------------------------------------
@Main:
	move.b	Joypad|Press, d0

	btst	#iRight, d0			; is Right pressed?
	beq.s	@chkLeft			; if not, branch
	addq.b	#1, obSTSelectedTrack(a0)
	cmpi.b	#obST_MaxTrack, obSTSelectedTrack(a0)
	bls.s	@RedrawTrackInfo
	move.b	#obST_MinTrack, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkLeft:
	btst	#iLeft, d0			; is Left pressed?
	beq.s	@chkBigSkip			; if not, branch
	subq.b	#1, obSTSelectedTrack(a0)
	cmpi.b	#obST_MinTrack, obSTSelectedTrack(a0)
	bhs.s	@RedrawTrackInfo
	move.b	#obST_MaxTrack, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkBigSkip:
	btst	#iA, d0				; is A pressed?
	beq.s	@chkStop			; if not, branch
	moveq	#0,d0
	move.b	obSTSelectedTrack(a0),d0
	addi.b	#$10,d0				; skip 16 entries ahead
	cmpi.w	#obST_MaxTrack,d0		; did we surpass the max?
	bls.s	@skipdone			; if not, branch
	subi.b	#obST_MaxTrack-obST_MinTrack+2,d0 ; restart on the other side
@skipdone:
	move.b	d0,obSTSelectedTrack(a0)	; update ID
	bra	@RedrawTrackInfo

@chkStop:
	btst	#iB, d0				; is B pressed?
	beq.s	@chkPlay			; if not, branch
	move.b	#$E4, d0
	jmp	PlaySound_Special

@chkPlay:
	btst	#iC, d0				; is action pressed?
	beq.s	@ret				; if not, branch
	move.b	obSTSelectedTrack(a0), d0
	jmp	PlaySound_Special

@ret	rts

; ---------------------------------------------------------------------------
@RedrawTrackInfo:
	moveq	#0, d0
	move.b	obSTSelectedTrack(a0), d0
	subi.b	#obST_MinTrack, d0
	
	mulu.w	#2*2*3,d0
	
	lea	@TrackLineData(pc), a5
	adda.w	d0, a5

	move.l	a0, -(sp)
	move.w	d7, -(sp)

	lea	SoundTest_DrawText, a4
	
	;SoundTest_DrawFormattedString a4, "< %<.b obSTSelectedTrack(a0)> >  %<.l 4(a5) str>", 35, #SoundTest_PlaneA_VRAM+24*$80
	;SoundTest_DrawFormattedString a4, "        %<.l 8(a5) str>", 35, #SoundTest_PlaneA_VRAM+25*$80
	;SoundTest_DrawFormattedString a4, "%<.l (a5) str>", 35, #SoundTest_PlaneA_VRAM+26*$80
	
	SoundTest_DrawFormattedString a4, "< %<.b obSTSelectedTrack(a0)> >  %<.l (a5) str>", 35, #SoundTest_PlaneA_VRAM+24*$80
	SoundTest_DrawFormattedString a4, "%<.l 4(a5) str>", 35, #SoundTest_PlaneA_VRAM+25*$80
	SoundTest_DrawFormattedString a4, "%<.l 8(a5) str>", 35, #SoundTest_PlaneA_VRAM+26*$80

	move.w	(sp)+, d7
	move.l	(sp)+, a0
	rts

; ---------------------------------------------------------------------------
@TrackLineData:
	dc.l	@Music81_Name		; $81
	dc.l	@Music81_Source
	dc.l	@Music81_Source2

	dc.l	@Music82_Name		; $82
	dc.l	@Music82_Source
	dc.l	@Music82_Source2

	dc.l	@Music83_Name		; $83
	dc.l	@Music83_Source
	dc.l	@Music83_Source2

	dc.l	@Music84_Name		; $84
	dc.l	@Music84_Source
	dc.l	@Music84_Source2

	dc.l	@Music85_Name		; $85
	dc.l	@Music85_Source
	dc.l	@Music85_Source2

	dc.l	@Music86_Name		; $86
	dc.l	@Music86_Source
	dc.l	@Music86_Source2

	dc.l	@Music87_Name		; $87
	dc.l	@Music87_Source
	dc.l	@Music87_Source2

	dc.l	@Music88_Name		; $88
	dc.l	@Music88_Source
	dc.l	@Music88_Source2

	dc.l	@Music89_Name		; $89
	dc.l	@Music89_Source
	dc.l	@Music89_Source2

	dc.l	@Music8A_Name		; $8A
	dc.l	@Music8A_Source
	dc.l	@Music8A_Source2

	dc.l	@Music8B_Name		; $8B
	dc.l	@Music8B_Source
	dc.l	@Music8B_Source2

	dc.l	@Music8C_Name		; $8C
	dc.l	@Music8C_Source
	dc.l	@Music8C_Source2

	dc.l	@Music8D_Name		; $8D
	dc.l	@Music8D_Source
	dc.l	@Music8D_Source2

	dc.l	@Music8E_Name		; $8E
	dc.l	@Music8E_Source
	dc.l	@Music8E_Source2

	dc.l	@Music8F_Name		; $8F
	dc.l	@Music8F_Source
	dc.l	@Music8F_Source2

	dc.l	@Music90_Name		; $90
	dc.l	@Music90_Source
	dc.l	@Music90_Source2

	dc.l	@Music91_Name		; $91
	dc.l	@Music91_Source
	dc.l	@Music91_Source2

	dc.l	@Music92_Name		; $92
	dc.l	@Music92_Source
	dc.l	@Music92_Source2

	dc.l	@Music93_Name		; $93
	dc.l	@Music93_Source
	dc.l	@Music93_Source2

	dc.l	@Music94_Name		; $94
	dc.l	@Music94_Source
	dc.l	@Music94_Source2

	dc.l	@Music95_Name		; $95
	dc.l	@Music95_Source
	dc.l	@Music95_Source2

	dc.l	@Music96_Name		; $96
	dc.l	@Music96_Source
	dc.l	@Music96_Source2

	dc.l	@Music97_Name		; $97
	dc.l	@Music97_Source
	dc.l	@Music97_Source2

	dc.l	@Music98_Name		; $98
	dc.l	@Music98_Source
	dc.l	@Music98_Source2

	dc.l	@Music99_Name		; $99
	dc.l	@Music99_Source
	dc.l	@Music99_Source2

	dc.l	@Music9A_Name		; $9A
	dc.l	@Music9A_Source
	dc.l	@Music9A_Source2

	dc.l	@Music9B_Name		; $9B
	dc.l	@Music9B_Source
	dc.l	@Music9B_Source2

	dc.l	@Music9C_Name		; $9C
	dc.l	@Music9C_Source
	dc.l	@Music9C_Source2

	dc.l	@Music9D_Name		; $9D
	dc.l	@Music9D_Source
	dc.l	@Music9D_Source2

	dc.l	@Music9E_Name		; $9E
	dc.l	@Music9E_Source
	dc.l	@Music9E_Source2

	dc.l	@Music9F_Name		; $9F
	dc.l	@Music9F_Source
	dc.l	@Music9F_Source2

; ---------------------------------------------------------------------------

	dc.l	@Sound_Header, @SoundA0_Name, @Sound_NoSource	; $A0
	dc.l	@Sound_Header, @SoundA1_Name, @Sound_NoSource	; $A1
	dc.l	@Sound_Header, @SoundA2_Name, @Sound_NoSource	; $A2
	dc.l	@Sound_Header, @SoundA3_Name, @Sound_NoSource	; $A3
	dc.l	@Sound_Header, @SoundA4_Name, @Sound_NoSource	; $A4
	dc.l	@Sound_Header, @SoundA5_Name, @Sound_NoSource	; $A5
	dc.l	@Sound_Header, @SoundA6_Name, @Sound_NoSource	; $A6
	dc.l	@Sound_Header, @SoundA7_Name, @Sound_NoSource	; $A7
	dc.l	@Sound_Header, @SoundA8_Name, @Sound_NoSource	; $A8
	dc.l	@Sound_Header, @SoundA9_Name, @Sound_NoSource	; $A9
	dc.l	@Sound_Header, @SoundAA_Name, @Sound_NoSource	; $AA
	dc.l	@Sound_Header, @SoundAB_Name, @Sound_NoSource	; $AB
	dc.l	@Sound_Header, @SoundAC_Name, @Sound_NoSource	; $AC
	dc.l	@Sound_Header, @SoundAD_Name, @Sound_NoSource	; $AD
	dc.l	@Sound_Header, @SoundAE_Name, @Sound_NoSource	; $AE
	dc.l	@Sound_Header, @SoundAF_Name, @Sound_NoSource	; $AF
	dc.l	@Sound_Header, @SoundB0_Name, @Sound_NoSource	; $B0
	dc.l	@Sound_Header, @SoundB1_Name, @Sound_NoSource	; $B1
	dc.l	@Sound_Header, @SoundB2_Name, @Sound_NoSource	; $B2
	dc.l	@Sound_Header, @SoundB3_Name, @SoundB3_Source	; $B3
	dc.l	@Sound_Header, @SoundB4_Name, @Sound_NoSource	; $B4
	dc.l	@Sound_Header, @SoundB5_Name, @Sound_NoSource	; $B5
	dc.l	@Sound_Header, @SoundB6_Name, @Sound_NoSource	; $B6
	dc.l	@Sound_Header, @SoundB7_Name, @Sound_NoSource	; $B7
	dc.l	@Sound_Header, @SoundB8_Name, @Sound_NoSource	; $B8
	dc.l	@Sound_Header, @SoundB9_Name, @Sound_NoSource	; $B9
	dc.l	@Sound_Header, @SoundBA_Name, @Sound_NoSource	; $BA
	dc.l	@Sound_Header, @SoundBB_Name, @Sound_NoSource	; $BB
	dc.l	@Sound_Header, @SoundBC_Name, @Sound_NoSource	; $BC
	dc.l	@Sound_Header, @SoundBD_Name, @Sound_NoSource	; $BD
	dc.l	@Sound_Header, @SoundBE_Name, @Sound_NoSource	; $BE
	dc.l	@Sound_Header, @SoundBF_Name, @SoundBF_Source	; $BF
	dc.l	@Sound_Header, @SoundC0_Name, @Sound_NoSource	; $C0
	dc.l	@Sound_Header, @SoundC1_Name, @Sound_NoSource	; $C1
	dc.l	@Sound_Header, @SoundC2_Name, @Sound_NoSource	; $C2
	dc.l	@Sound_Header, @SoundC3_Name, @Sound_NoSource	; $C3
	dc.l	@Sound_Header, @SoundC4_Name, @Sound_NoSource	; $C4
	dc.l	@Sound_Header, @SoundC5_Name, @SoundC5_Source	; $C5
	dc.l	@Sound_Header, @SoundC6_Name, @Sound_NoSource	; $C6
	dc.l	@Sound_Header, @SoundC7_Name, @Sound_NoSource	; $C7
	dc.l	@Sound_Header, @SoundC8_Name, @SoundC8_Source	; $C8
	dc.l	@Sound_Header, @SoundC9_Name, @Sound_NoSource	; $C9
	dc.l	@Sound_Header, @SoundCA_Name, @Sound_NoSource	; $CA
	dc.l	@Sound_Header, @SoundCB_Name, @Sound_NoSource	; $CB
	dc.l	@Sound_Header, @SoundCC_Name, @Sound_NoSource	; $CC
	dc.l	@Sound_Header, @SoundCD_Name, @Sound_NoSource	; $CD
	dc.l	@Sound_Header, @SoundCE_Name, @Sound_NoSource	; $CE
	dc.l	@Sound_Header, @SoundCF_Name, @Sound_NoSource	; $CF
	dc.l	@Sound_Header, @SoundD0_Name, @Sound_NoSource	; $D0
	dc.l	@Sound_Header, @SoundD1_Name, @Sound_NoSource	; $D1
	dc.l	@Sound_Header, @SoundD2_Name, @Sound_NoSource	; $D2
	dc.l	@Sound_Header, @SoundD3_Name, @Sound_NoSource	; $D3
	dc.l	@Sound_Header, @SoundD4_Name, @Sound_NoSource	; $D4
	dc.l	@Sound_Header, @SoundD5_Name, @Sound_NoSource	; $D5
	dc.l	@Sound_Header, @SoundD6_Name, @Sound_NoSource	; $D6
	dc.l	@Sound_Header, @SoundD7_Name, @Sound_NoSource	; $D7
	dc.l	@Sound_Header, @SoundD8_Name, @Sound_NoSource	; $D8
	dc.l	@Sound_Header, @SoundD9_Name, @Sound_NoSource	; $D9
	dc.l	@Sound_Header, @SoundDA_Name, @Sound_NoSource	; $DA
	dc.l	@Sound_Header, @SoundDB_Name, @Sound_NoSource	; $DB
	dc.l	@Sound_Header, @SoundDC_Name, @Sound_NoSource	; $DC
	dc.l	@Sound_Header, @SoundDD_Name, @Sound_NoSource	; $DD
	dc.l	@Sound_Header, @SoundDE_Name, @Sound_NoSource	; $DE
	dc.l	@Sound_Header, @SoundDF_Name, @Sound_NoSource	; $DF

; ---------------------------------------------------------------------------

@padLen: = 32
@padString: macro string
	len: = strlen(\string)
	if (len>@padLen)
		inform 2, "line length must be 32 characters or less"
	endif

	dc.b	\string
	dcb.b	@padLen-strlen('\strlen')-1, ' '
	dc.b	0
	endm

@padStringR: macro string
	len: = strlen(\string)
	if (len>@padLen)
		inform 2, "line length must be 32 characters or less"
	endif

	preLen: = @padLen - strlen(\string) - 9
	rept preLen
		dc.b	' '
	endr
	
	dc.b	'- '
	dc.b	\string
	dc.b	' -'
	dcb.b	@padLen-strlen('\strlen')-1, ' '
	dc.b	0
	endm

@Music81_Name:		@padStringR 'NIGHT HILL PLACE'
@Music81_Source:	@padString 'F1 POLE POSITION'
@Music81_Source2:	@padString 'HOCKENHEIM RING'

@Music82_Name:		@padStringR 'LABYRINTHY PLACE'
@Music82_Source:	@padString 'MEGA MAN 4'
@Music82_Source2:	@padString 'DR. COSSACK STAGE 2'

@Music83_Name:		@padStringR 'RUINED PLACE'
@Music83_Source:	@padString 'ETERNAL CHAMPIONS'
@Music83_Source2:	@padString "BLADE'S THEME"

@Music84_Name		@padStringR 'SCAR NIGHT PLACE'
@Music84_Source:	@padString 'MEGA MAN IV - GB'
@Music84_Source2:	@padString 'TITLE SCREEN'

@Music85_Name:		@padStringR 'UBERHUB PLACE'
@Music85_Source:	@padString 'MEGA MAN 7'
@Music85_Source2:	@padString 'FREEZE MAN STAGE'

@Music86_Name:		@padStringR 'GREEN HILL PLACE'
@Music86_Source:	@padString 'MEGA MAN X'
@Music86_Source2:	@padString 'SPARK MANDRILL'

@Music87_Name:		@padStringR 'TUTORIAL PLACE'
@Music87_Source:	@padString 'NINJA GAIDEN'
@Music87_Source2:	@padString 'STAGE 4-2'

@Music88_Name:		@padStringR 'SPECIAL STAGE CLEAR'
@Music88_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music88_Source2:	@padString "YEAH, IT'S THE SAME"

@Music89_Name:		@padStringR 'SPECIAL PLACE'
@Music89_Source:	@padString 'TECMO WRESTLING'
@Music89_Source2:	@padString 'HIDDEN TRACK'

@Music8A_Name:		@padStringR 'TITLE SCREEN'
@Music8A_Source:	@padString 'SUPER STREET FIGHTER II TURBO'
@Music8A_Source2:	@padString 'OPENING SEQUENCE'

@Music8B_Name:		@padStringR '=P MONITOR'
@Music8B_Source:	@padString 'THE ORIGINAL VERSION OF'
@Music8B_Source2:	@padString 'SONIC ERAZOR FROM 2010'

@Music8C_Name:		@padStringR 'GREEN HILL PLACE BOSS'
@Music8C_Source:	@padString 'SONIC ADVANCE 3'
@Music8C_Source2:	@padString 'BOSS'

@Music8D_Name:		@padStringR 'FINALOR PLACE'
@Music8D_Source:	@padString 'PULSEMAN'
@Music8D_Source2:	@padString 'SHUTDOWN'

@Music8E_Name:		@padStringR '...UNUSED...'
@Music8E_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music8E_Source2:	@padString 'ACT CLEAR'

@Music8F_Name:		@padStringR '...ALSO UNUSED...'
@Music8F_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music8F_Source2:	@padString 'GAME OVER'

@Music90_Name:		@padStringR 'THE GREAT ESCAPE'
@Music90_Source:	@padString 'MEGA MAN X3'
@Music90_Source2:	@padString 'OPENING STAGE'

@Music91_Name:		@padStringR 'INVINCIBILITY'
@Music91_Source:	@padString 'DANGEROUS SEED'
@Music91_Source2:	@padString 'ENDING THEME'

@Music92_Name:		@padStringR 'FUN IN LABYRINTHY PLACE'
@Music92_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music92_Source2:	@padString 'DROWN'

@Music93_Name:		@padStringR "...YUP, UNUSED..."
@Music93_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music93_Source2:	@padString '1-UP JINGLE'

@Music94_Name:		@padStringR 'GREEN HILL ZO... PLACE'
@Music94_Source:	@padString 'SONIC THE HEDGEHOG 1'
@Music94_Source2:	@padString 'GREEN HILL ZONE'

@Music95_Name:		@padStringR 'INTRO CUTSCENE'
@Music95_Source:	@padString 'STREET FIGHTER II'
@Music95_Source2:	@padString "KEN'S THEME"

@Music96_Name:		@padStringR 'STAR AGONY PLACE'
@Music96_Source:	@padString 'THUNDER FORCE III'
@Music96_Source2:	@padString 'STAGE 7: ORN BASE'

@Music97_Name:		@padStringR 'CREDITS'
@Music97_Source:	@padString 'GUNDAM WING: ENDLESS DUEL'
@Music97_Source2:	@padString 'OPENING / RHYTHM EMOTION'

@Music98_Name:		@padStringR 'CRABMEAT BOSS'
@Music98_Source:	@padString 'SONIC ADVANCE 3'
@Music98_Source2:	@padString 'BOSS'

@Music99_Name:		@padStringR 'TUTORIAL INTRODUCTION'
@Music99_Source:	@padString 'MEGA MAN 5'
@Music99_Source2:	@padString 'DARK MAN/PROTO MAN STAGES'

@Music9A_Name:		@padStringR 'UNREAL PLACE'
@Music9A_Source:	@padString 'SHINOBI III'
@Music9A_Source2:	@padString 'WHIRLWIND'

@Music9B_Name:		@padStringR 'WALKING BOMB BOSS'
@Music9B_Source:	@padString 'SONIC ADVANCE 3'
@Music9B_Source2:	@padString 'BOSS - PINCH'

@Music9C_Name:		@padStringR '??? UNUSED ???' ; Blackout Challenge
@Music9C_Source:	@padString 'PULSEMAN'
@Music9C_Source2:	@padString 'SHUTDOWN - DARK REMIX'

@Music9D_Name:		@padStringR 'ENDING SEQUENCE'
@Music9D_Source:	@padString 'ZILLION PUSH'
@Music9D_Source2:	@padString 'PUSH!'

@Music9E_Name:		@padStringR 'FINAL BOSS'
@Music9E_Source:	@padString 'SONIC THE HEDGEHOG 3'
@Music9E_Source2:	@padString 'FINAL BOSS... TOO'

@Music9F_Name:		@padStringR 'INHUMAN MODE'
@Music9F_Source:	@padString 'MEGA MAN ZERO 4'
@Music9F_Source2:	@padString 'STRAIGHT AHEAD'

; ---------------------------------------------------------------------------

@Sound_Header:		@padString '-SFX-                           '	
@Sound_NoSource:	@padString '                                '

@SoundA0_Name:		@padString 'YOU JUMPED'
@SoundA1_Name:		@padString 'YOU TOUCHED A CHECKPOINT'
@SoundA2_Name:		@padString "THE SOUND OF... I DON'T KNOW"
@SoundA3_Name:		@padString 'YOU ARE DEAD'
@SoundA4_Name:		@padString 'YOU STOPPED'
@SoundA5_Name:		@padString 'A FIREBALL WAS SPAT, I GUESS?'
@SoundA6_Name:		@padString 'IMPALED WITH EXTREME PREJUDICE'
@SoundA7_Name:		@padString 'YOU ARE PUSHING A ROCK'
@SoundA8_Name:		@padString 'YOU ARE GETTING WARPED'
@SoundA9_Name:		@padString 'THE BEST SOUND IN THE GAME'
@SoundAA_Name:		@padString 'YOU ARE ENTERING WATER'
@SoundAB_Name:		@padString 'NO IDEA WHAT THIS IS EITHER'
@SoundAC_Name:		@padString 'EXPLOSIONS.'
@SoundAD_Name:		@padString 'YOU GOT AIR'
@SoundAE_Name:		@padString 'A FIREBALL WAS SPAT... AGAIN'
@SoundAF_Name:		@padString 'YOU GOT A SHIELD'
@SoundB0_Name:		@padString 'YOU ENTERED HELL'
@SoundB1_Name:		@padString "BZZZZ"
@SoundB2_Name:		@padString 'LEARN HOW TO SWIM DUMMY'
@SoundB3_Name:		@padString "HOW MANY DAMN FIREBALL SOUNDS"
 @SoundB3_Source:	@padString "ARE IN THIS GAME?!"
@SoundB4_Name:		@padString 'YOU HIT A BUMPER'
@SoundB5_Name:		@padString 'YOU GOT A RING'
@SoundB6_Name:		@padString 'SPIKES HAVE MOVED'
@SoundB7_Name:		@padString 'I WISH TERRAFORMING WAS REAL'
@SoundB8_Name:		@padString 'SPIKES HAVE MOVED... AGAIN'
@SoundB9_Name:		@padString 'YOU BROKE SOMETHING BIG TIME'
@SoundBA_Name:		@padString 'YOU TOUCHED GRA- I MEAN GLASS'
@SoundBB_Name:		@padString 'A FLAPPY DOOR HAS OPENED'
@SoundBC_Name:		@padString 'YOU DASHED'
@SoundBD_Name:		@padString 'A STOMPER HAS STOMPED'
@SoundBE_Name:		@padString 'YOU ARE SPINNING'
@SoundBF_Name:		@padString 'YOU WISH THIS SOUND WAS'
 @SoundBF_Source:	@padString 'ACTUALLY IN THE GAME'
@SoundC0_Name:		@padString 'A BAT IS TAKING TO THE SKIES'
@SoundC1_Name:		@padString 'EXPLOSIONS.'
@SoundC2_Name:		@padString 'YOU SHOULD GO OUTSIDE'
@SoundC3_Name:		@padString 'I WISH TELEPORTATION WAS REAL'
@SoundC4_Name:		@padString 'EXPLOSIONS.'
@SoundC5_Name:		@padString 'THE SOUND THAT PLAYS WHEN'
 @SoundC5_Source:	@padString 'YOUR CRUSH SAYS YES'
@SoundC6_Name:		@padString 'YOU SUCK'
@SoundC7_Name:		@padString "CHAINY THING GOIN' UP"
@SoundC8_Name:		@padString "ROCKET THING GOIN' UP"
 @SoundC8_Source:	@padString "ALSO IT'S ANOTHER FIREBALL SOUND"
@SoundC9_Name:		@padString 'JUST ONE MORE, COME ON...'
@SoundCA_Name:		@padString 'YOU ENTERED A SPECIAL STAGE'
@SoundCB_Name:		@padString 'EXPLOSIONS.'
@SoundCC_Name:		@padString 'YOU TOUCHED A SPRING'
@SoundCD_Name:		@padString 'YOU PRESSED A BUTTON'
@SoundCE_Name:		@padString 'YOU GOT ANOTHER RING'
@SoundCF_Name:		@padString 'YOU BEAT A LEVEL, HOORAY'
@SoundD0_Name:		@padString 'YOU DREAM OF THE BEACH'
@SoundD1_Name:		@padString 'YOU ARE ABOUT TO GO NYOOM'
@SoundD2_Name:		@padString 'YOU ARE ABOUT TO GO REALLY NYOOM'
@SoundD3_Name:		@padString 'YOU WENT REALLY NYOOM'
@SoundD4_Name:		@padString 'LITERALLY NOTHING'
@SoundD5_Name:		@padString 'THE SOUND OF SILENCE'
@SoundD6_Name:		@padString 'STILL NOTHING'
@SoundD7_Name:		@padString 'PATHETIC EXPLOSION'
@SoundD8_Name:		@padString 'MENU SELECTION'
@SoundD9_Name:		@padString 'OPTION CONFIRMED'
@SoundDA_Name:		@padString 'OPTION DENIED'
@SoundDB_Name:		@padString 'REALLY HECKING BIG EXPLOSION'
@SoundDC_Name:		@padString 'NUH UH'
@SoundDD_Name:		@padString 'PROBABLY A NUKE GOING OFF'
@SoundDE_Name:		@padString 'HOW HIGH IN THE SKY CAN YOU FLY?'
@SoundDF_Name:		@padString 'AW MAN YOU BROKE IT'


	even
