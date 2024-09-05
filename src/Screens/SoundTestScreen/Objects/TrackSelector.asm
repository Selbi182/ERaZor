
obSTSelectedTrack:	equ	$20	; .b

; ---------------------------------------------------------------------------
; Track selector controller for the sound test
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector:

	move.b	#$81, obSTSelectedTrack(a0)	; set initial track
	bsr	@RedrawTrackInfo		; display this track
	move.l	#@Main, obCodePtr(a0)

; ---------------------------------------------------------------------------
@Main:
	move.b	Joypad|Press, d0

	btst	#iRight, d0			; is Right pressed?
	beq.s	@chkLeft			; if not, branch
	cmp.b	#$9F, obSTSelectedTrack(a0)
	beq.s	@ret
	addq.b	#1, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkLeft:
	btst	#iLeft, d0			; is Left pressed?
	beq.s	@chkAction			; if not, branch
	cmp.b	#$81, obSTSelectedTrack(a0)
	beq.s	@ret
	subq.b	#1, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkAction:
	btst	#iC, d0				; is action pressed?
	beq.s	@ret				; if not, branch
	move.b	obSTSelectedTrack(a0), d0
	jmp	PlaySound_Special

@ret	rts

; ---------------------------------------------------------------------------
@RedrawTrackInfo:
	moveq	#0, d0
	move.b	obSTSelectedTrack(a0), d0
	sub.b	#$81, d0
	lsl.w	#3, d0
	lea	@TrackLineData(pc), a5
	adda.w	d0, a5
	KDebug.WriteLine "%<.l (a5) sym> %<.w d0>"

	move.l	a0, -(sp)
	move.w	d7, -(sp)

	lea	SoundTest_DrawText, a4
	SoundTest_DrawFormattedString a4, "%<.b obSTSelectedTrack(a0)> %<.l (a5) str>", 35, #SoundTest_PlaneA_VRAM+25*$80
	SoundTest_DrawFormattedString a4, "   %<.l 4(a5) str>", 35, #SoundTest_PlaneA_VRAM+26*$80

	move.w	(sp)+, d7
	move.l	(sp)+, a0
	rts

; ---------------------------------------------------------------------------
@TrackLineData:
	dc.l	@Music81_Name		; $81
	dc.l	@Music81_Source

	dc.l	@Music82_Name		; $82
	dc.l	@Music82_Source

	dc.l	@Music83_Name		; $83
	dc.l	@Music83_Source

	dc.l	@Music84_Name		; $84
	dc.l	@Music84_Source

	dc.l	@Music85_Name		; $85
	dc.l	@Music85_Source

	dc.l	@Music86_Name		; $86
	dc.l	@Music86_Source

	dc.l	@Music87_Name		; $87
	dc.l	@Music87_Source

	dc.l	@Music88_Name		; $88
	dc.l	@Music88_Source

	dc.l	@Music89_Name		; $89
	dc.l	@Music89_Source

	dc.l	@Music8A_Name		; $8A
	dc.l	@Music8A_Source

	dc.l	@Music8B_Name		; $8B
	dc.l	@Music8B_Source

	dc.l	@Music8C_Name		; $8C
	dc.l	@Music8C_Source

	dc.l	@Music8D_Name		; $8D
	dc.l	@Music8D_Source

	dc.l	@Music8E_Name		; $8E
	dc.l	@Music8E_Source

	dc.l	@Music8F_Name		; $8F
	dc.l	@Music8F_Source

	dc.l	@Music90_Name		; $90
	dc.l	@Music90_Source

	dc.l	@Music91_Name		; $91
	dc.l	@Music91_Source

	dc.l	@Music92_Name		; $92
	dc.l	@Music92_Source

	dc.l	@Music93_Name		; $93
	dc.l	@Music93_Source

	dc.l	@Music94_Name		; $94
	dc.l	@Music94_Source

	dc.l	@Music95_Name		; $95
	dc.l	@Music95_Source

	dc.l	@Music96_Name		; $96
	dc.l	@Music96_Source

	dc.l	@Music97_Name		; $97
	dc.l	@Music97_Source

	dc.l	@Music98_Name		; $98
	dc.l	@Music98_Source

	dc.l	@Music99_Name		; $99
	dc.l	@Music99_Source

	dc.l	@Music9A_Name		; $9A
	dc.l	@Music9A_Source

	dc.l	@Music9B_Name		; $9B
	dc.l	@Music9B_Source

	dc.l	@Music9C_Name		; $9C
	dc.l	@Music9C_Source

	dc.l	@Music9D_Name		; $9D
	dc.l	@Music9D_Source

	dc.l	@Music9E_Name		; $9E
	dc.l	@Music9E_Source

	dc.l	@Music9F_Name		; $9F
	dc.l	@Music9F_Source


@padLen: = 32
@padString: macro string
	dc.b	\string
	dcb.b	@padLen-strlen('\strlen')-1, ' '
	dc.b	0
	endm

@Music81_Name:
	@padString 'NIGHT HILL PLACE'
@Music81_Source:
	@padString 'F1 POLE POSITION'
	;@padString 'HOCKENHEIM RING'

@Music82_Name:
	@padString 'LABYRINTHY PLACE'
@Music82_Source:
	@padString 'MEGA MAN 4'
	;@padString 'DR. COSSACK STAGE 2'

@Music83_Name:
	@padString 'RUINED PLACE'
@Music83_Source:
	@padString 'ETERNAL CHAMPIONS'
	;@padString "BLADE'S THEME"

@Music84_Name:
	@padString 'SCAR NIGHT PLACE'
@Music84_Source:
	@padString 'MEGA MAN IV (GB)'
	;@padString 'TITLE SCREEN'

@Music85_Name:
	@padString 'UBERHUB PLACE'
@Music85_Source:
	@padString 'MEGA MAN 7'
	;@padString 'FREEZE MAN STAGE'

@Music86_Name:
	@padString 'GREEN HILL PLACE'
@Music86_Source:
	@padString 'MEGA MAN X'
	;@padString 'SPARK MANDRILL'

@Music87_Name:
	@padString 'TUTORIAL PLACE'
@Music87_Source:
	@padString 'NINJA GAIDEN'
	;@padString 'STAGE 4-2'

@Music88_Name:
	@padString 'SPECIAL STAGE DONE'
@Music88_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'SPECIAL STAGE DONE'

@Music89_Name:
	@padString 'SPECIAL PLACE'
@Music89_Source:
	@padString 'TECMO WRESTLING'
	;@padString 'HIDDEN TRACK'

@Music8A_Name:
	@padString 'TITLE SCREEN'
@Music8A_Source:
	@padString 'SUPER STREET FIGHTER II TURBO'
	;@padString 'OPENING SEQUENCE'

@Music8B_Name:
	@padString '=P MONITOR'
@Music8B_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'ENDING'

@Music8C_Name:
	@padString 'GREEN HILL PLACE - BOSS'
@Music8C_Source:
	@padString 'SONIC ADVANCE 3'
	;@padString 'BOSS'

@Music8D_Name:
	@padString 'FINALOR PLACE'
@Music8D_Source:
	@padString 'PULSEMAN'
	;@padString 'SHUTDOWN'

@Music8E_Name:
	@padString '(UNUSED)'
@Music8E_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'ACT CLEAR'

@Music8F_Name:
	@padString '(UNUSED)'
@Music8F_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'GAME OVER'

@Music90_Name:
	@padString 'ESCAPE FROM FINALOR'
@Music90_Source:
	@padString 'MEGA MAN X3'
	;@padString 'OPENING STAGE'

@Music91_Name:
	@padString 'TRUE ENDING'
@Music91_Source:
	@padString 'DANGEROUS SEED'
	;@padString 'ENDING THEME'

@Music92_Name:
	@padString 'DROWNING'
@Music92_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'DROWNING'

@Music93_Name:
	@padString '(UNUSED)'
@Music93_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString '1-UP JINGLE'

@Music94_Name:
	@padString 'GREEN HILL ZONE'
@Music94_Source:
	@padString 'SONIC THE HEDGEHOG'
	;@padString 'GREEN HILL ZONE'

@Music95_Name:
	@padString 'INTRO CUTSCENE'
@Music95_Source:
	@padString 'STREET FIGHTER II'
	;@padString "KEN'S THEME"

@Music96_Name:
	@padString 'STAR AGONY PLACE'
@Music96_Source:
	@padString 'THUNDER FORCE III'
	;@padString 'STAGE 7: ORN BASE'

@Music97_Name:
	@padString 'CREDITS'
@Music97_Source:
	@padString 'GUNDAM WING: ENDLESS DUEL'
	;@padString 'OPENING'

@Music98_Name:
	@padString 'CRABMEAT BOSS'
@Music98_Source:
	@padString 'SONIC ADVANCE 3'
	;@padString 'BOSS'

@Music99_Name:
	@padString 'TUTORIAL INTRODUCTION'
@Music99_Source:
	@padString 'MEGA MAN 5'
	;@padString 'DARK MAN (PROTO MAN) STAGES'

@Music9A_Name:
	@padString 'UNREAL PLACE'
@Music9A_Source:
	@padString 'SHINOBI III'
	;@padString 'WHIRLWIND'

@Music9B_Name:
	@padString 'WALKING BOMB BOSS'
@Music9B_Source:
	@padString 'SONIC ADVANCE 3'
	;@padString 'BOSS (PINCH)'

@Music9C_Name:
	@padString 'UNUSED???' ; Blackout Challenge
@Music9C_Source:
	@padString 'PULSEMAN'
	;@padString 'SHUTDOWN (REMIX)'

@Music9D_Name:
	@padString 'ENDING SEQUENCE'
@Music9D_Source:
	@padString 'ZILLION PUSH'
	;@padString 'PUSH!'

@Music9E_Name:
	@padString 'FINALOR PLACE - BOSS'
@Music9E_Source:
	@padString 'SONIC THE HEDGEHOG 3'
	;@padString 'FINAL BOSS'

@Music9F_Name:
	@padString 'INHUMAN MODE'
@Music9F_Source:
	@padString 'MEGA MAN ZERO 4'
	;@padString 'STRAIGHT AHEAD'

	even
