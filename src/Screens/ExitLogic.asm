; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Exit Logic and Game Progress Coordination
; ---------------------------------------------------------------------------
; BOOT
; Sega Screen > Selbi Screen > Title Screen > GameplayStyleScreen/Chapter Screen
; 
; FIRST START
; GameplayStyleScreen > One Hot Day... > Story Screen > Uberhub > NHP Ring > Chapter Screen > NHP
; 
; MAIN LEVEL CYCLE
; Uberhub Level Ring > Chapter Screen > Level > Story Screen > Uberhub
; ---------------------------------------------------------------------------
ResumeFlag	equ	$FFFFF601
CurrentChapter	equ	$FFFFFFA7
StoryTextID	equ	$FFFFFF9E
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal "return to the hubworld" subroutines
; ---------------------------------------------------------------------------

ReturnToUberhub:
		; instantly
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		bra.s	StartLevel		; start level

ReturnToUberhub_Chapter:
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		bne.s	StartLevel		; if yes, skip chapter screen

		; show chapter screen first
		move.b	#$28,(GameMode).w	; set to chapters screen
		rts				; return to MainGameLoop


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal level starting subroutines
; ---------------------------------------------------------------------------

StartLevel:
		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag

		move.w	($FFFFFE10).w,d0	; get level ID
		cmpi.w	#$300,d0		; set to Special Place?
		beq.s	@startspecial		; if yes, branch
		cmpi.w	#$401,d0		; set to Unreal Place / Blackout Challenge?
		beq.s	@startspecial		; if yes, branch
		
		; regular level
		move.b	#$C,(GameMode).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts				; return to MainGameLoop

@startspecial:
		; special stage
		move.b	#$10,(GameMode).w	; set to special stage
		rts				; return to MainGameLoop


; ===========================================================================
; ---------------------------------------------------------------------------
; Various screen exiting routines
; ---------------------------------------------------------------------------

Start_FirstGameMode:
		move.b	#0,(GameMode).w		; set first game mode to Sega Screen

		move.b	#2,VBlankRoutine	; set to function 2 in V-blank
		jsr	DelayProgram		; do V-blank to read joypads
		btst	#4,($FFFFF604).w	; was B held as we exited?
		bne.s	@blackbarsscreen	; if yes, show black bars screen again

		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		bne.s	@skip			; if not, go straight to Sega screen

		; Emulator detection to autoskip the screen for known faulty behavior (primarily in Kega)
		; Inspired by: https://github.com/DevsArchive/genesis-emulator-detector
		lea	VDP_Debug, a0
		move.w	#1, (a0)		; Write to the VDP debug register (for BlastEm detection)
		ori.b	#0, d0
		move.w	(a0), d0		; Read VDP debug register
		move.w	#0, (a0)		; Reset VDP debug register
		ori.b	#0, d0
		cmpi.w	#-1, d0			; Did it return -1?
		beq.w	@skip			; If so, then Kega Fusion has been detected
		cmpi.w	#1, d0			; Did it return what it was last written?
		beq.w	@skip			; If so, then an old version of BlastEm has been detected

@blackbarsscreen:
		move.b	#$38,(GameMode).w	; set to Black Bars configuration screen

@skip:
		rts
; ===========================================================================

Exit_BlackBarsScreen:
		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		beq.s	@firststart		; if yes, branch
		move.b	#$24,(GameMode).w	; we came from the options menu, return to it
		rts

@firststart:
		move.b	#0,(GameMode).w		; set game mode to Sega Screen
		rts
; ===========================================================================

Exit_SegaScreen:
		btst	#4,($FFFFF604).w	; was B held as we exited?
		bne.s	@blackbarsscreen	; if yes, show black bars screen again
		move.b	#$1C,(GameMode).w	; set to Selbi splash screen
		rts

@blackbarsscreen:
		move.b	#$38,(GameMode).w	; set to Black Bars configuration screen
		rts
; ===========================================================================

Exit_SelbiSplash:
		move.b	#4,(GameMode).w		; set to title screen
		rts
; ===========================================================================

Exit_TitleScreen:
		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		bne.w	ReturnToUberhub_Chapter	; if not, go to Uberhub (and always show chapter screen)
		
		; first launch
		jsr	Options_SetDefaults	; load default options
		move.b	#0,(CurrentChapter).w	; set chapter to 0 (so screen gets displayed once NHP is entered for the first time)
		move.b	#$30,(GameMode).w	; for the first time, set to Gameplay Style Screen (which then starts the intro cutscene)
		rts
; ===========================================================================

Exit_GameplayStyleScreen:
		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		beq.s	@firststart		; if yes, branch

		frantic				; was the screen exited with frantic enabled?
		beq.s	@notfrantic		; if not, branch
		tst.b	(Doors_Frantic).w	; have any frantic levels been beaten yet?
		bne.s	@notfrantic		; if yes, branch
		tst.b	(Doors_Casual).w	; have any casual levels been beaten yet?
		beq.s	@notfrantic		; if not, this tip isn't necessary yet
		jsr	Pal_FadeFrom		; fade out palette to avoid visual glitches
		jsr	ClearScreen		; clear screen
		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette	
		moveq	#$13,d0			; load warning text about revisiting the tutorial for frantic
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint
@notfrantic:
		jsr	SRAM_SaveNow		; save our progress now
		move.b	#$24,(GameMode).w	; we came from the options menu, return to it
		rts
; ---------------------------------------------------------------------------	

@firststart:
		move.b	#1,(ResumeFlag).w	; set resume flag now

		btst	#6,($FFFFF604).w	; was A held as we exited?
		bne.s	@speedrun		; if yes, branch

		move.w	#$C3,d0			; play giant ring sound
		jsr	PlaySound_Special	
		jsr 	WhiteFlash2
		jsr 	Pal_FadeFrom
		moveq	#60,d0
@Wait:		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		subq.b	#1,d0
		bne.s 	@Wait

		jsr	SRAM_SaveNow		; save our progress now
		bra.w	HubRing_IntroStart	; start the intro cutscene
; ---------------------------------------------------------------------------	

@speedrun:
		jsr 	WhiteFlash2
		bset	#1,(OptionsBits).w	; enable Skip Story Screens
		bset	#2,(OptionsBits).w	; enable Skip Uberhub
		move.w	#$D3,d0			; play peelout release sound
		jsr	PlaySound_Special

		jsr	SRAM_SaveNow		; save our progress now
		bra.w	HubRing_NHP		; go straight to NHP
; ===========================================================================

Exit_OptionsScreen:
		jsr	SRAM_SaveNow		; save options to SRAM

		; d0 = destination ID
		cmpi.b	#1,d0			; is destination set to 1?
		bne.s	@chkbars		; if not, branch
		move.b	#$30,(GameMode).w	; set to GameplayStyleScreen if we chose that option
		rts
@chkbars:
		cmpi.b	#2,d0			; is destination set to 2?
		bne.s	@default		; if not, branch
		move.b	#$38,(GameMode).w	; set to BlackBarsConfigScreen if we chose that option
		rts

@default:
		bra.w	ReturnToUberhub		; return to Uberhub in all other cases
; ===========================================================================

Exit_SoundTestScreen:
		bra.w	ReturnToUberhub		; return to Uberhub
; ===========================================================================

Exit_ChapterScreen:
		cmpi.w	#$001,($FFFFFE10).w	; is this the intro cutscene?
		beq.w	Exit_OneHotDay		; if yes, start intro cutscene (and music)
		move.w	#$000,($FFFFFB02).w	; keep a specific color black to avoid flicker
		bra.w	StartLevel		; otherwise, start level set in FE10 normally
; ===========================================================================

Exit_StoryScreen:
		; d0 = screen ID from Story Screen
		cmpi.b	#8,d0			; is this the ending sequence?
		beq.s	@startending		; if yes, branch
		cmpi.b	#9,d0			; is this the end of the blackout challenge?
		beq.s	@postblackout		; if yes, branch

		; regular story screen (including intro)
		btst	#2,(OptionsBits).w	; is Skip Uberhub Place enabled?
		bne.w	SkipUberhub		; if yes, automatically go to the next level in order
		bra.w	ReturnToUberhub		; otherwise, always return to Uberhub
; ---------------------------------------------------------------------------

@startending:
		move.b	#$18,(GameMode).w	; set to ending sequence ($18)
		rts
; ---------------------------------------------------------------------------

@postblackout:
		btst	#0,($FFFFFFA0).w	; was nonstop inhuman unlock text set to be displayed?
		beq.s	@restartgame		; if not, branch

		jsr	Pal_FadeFrom		; fade out palette
		jsr	ClearScreen		; clear screen

		lea	($FFFFD000).w,a1	; clear object RAM...
		moveq	#0,d0			; ...cause the ERaZor logo doesn't play nicely here
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram

		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette

		moveq	#$16,d0			; load text after beating the blackout challenge for the first time
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@restartgame:
		bra.w	Start_FirstGameMode	; restart game
; ===========================================================================

Exit_CreditsScreen:
		tst.b	($FFFFFF95).w		; were any post-credits texts set to be displayed?
		beq.s	@restartfromcredits	; if not, branch

		jsr	Pal_FadeFrom		; fade out palette
		jsr	ClearScreen		; clear screen

		lea	($FFFFD000).w,a1	; clear object RAM (the stars)...
		moveq	#0,d0			; ...cause they cause slowdowns in these screens
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram

		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette

		btst	#0,($FFFFFF95).w
		beq.s	@checkfrantic
		moveq	#$F,d0			; load text after beating the game in casual mode
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint
		bra.s	@checkcinematicunlock
@checkfrantic:
		btst	#1,($FFFFFF95).w
		beq.s	@checkcinematicunlock
		moveq	#$10,d0			; load text after beating the game in frantic mode
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@checkcinematicunlock:
		btst	#2,($FFFFFF95).w
		beq.s	@checkmotionblur
		moveq	#$14,d0			; load Cinematic Mode unlock text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@checkmotionblur:
		btst	#3,($FFFFFF95).w
		beq.s	@checkblackout
		moveq	#$15,d0			; load motion blur unlock text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@checkblackout:
		btst	#4,($FFFFFF95).w
		beq.s	@restartfromcredits
		move.b	#$E0,d0
		jsr	PlaySound_Special	; fade out music to set the atmosphere
		moveq	#$12,d0			; load Blackout Challenge teaser text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@restartfromcredits:
		bra.w	Start_FirstGameMode	; restart game from Sega Screen


; ===========================================================================
; ---------------------------------------------------------------------------
; Cutscene exit routines
; ---------------------------------------------------------------------------

Exit_OneHotDay:
		move.b	#$95,d0			; play intro cutscene music
		jsr	PlaySound
		move.w	#$001,($FFFFFE10).w	; load intro cutscene
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_IntroCutscene:
		move.b	#1,(StoryTextID).w	; set number for text to 1 ("The spiked sucker...")
		bra.w	RunStory		; run story
; ===========================================================================

Exit_BombMachineCutscene:
		jsr	Pal_FadeFrom
		move.w	#$301,($FFFFFE10).w	; set level to Scar Night Place
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_EndingSequence:
		moveq	#0,d1			; set to no texts to display

		frantic				; did we beat the game in frantic?
		bne.s	@showfrantictext	; if yes, branch
		bsr	Check_BaseGameBeaten_Frantic ; is a player who already beat frantic for some reason revisitng the end in casual?
		bne.s	@showfrantictext	; if yes, show frantic text anyway
		bset	#0,d1			; load text after beating the game in casual mode
		bra.s	@checkcinematicunlock	; skip

	@showfrantictext:
		bset	#1,d1			; load text after beating the game in frantic mode

	@checkcinematicunlock:
		bsr	Check_BaseGameBeaten_Casual ; have you already beaten the base game in casual?
		bne.s	@checkmotionblur	; if yes, branch
		bset	#2,d1			; load Cinematic Mode unlock text
		
	@checkmotionblur:
		frantic				; was the game beaten in frantic?
		beq.s	@markgameasbeaten	; if not, branch
		bsr	Check_BaseGameBeaten_Frantic ; have you already beaten the base game in frantic?
		bne.s	@markgameasbeaten	; if yes, branch
		bset	#3,d1			; load Motion Blur unlock text
		
@markgameasbeaten:
		bsr	Set_BaseGameDone	; you have beaten the base game, congrats (casual only or frantic with casual)

	@checkblackoutteaser:
		bsr	Check_BlackoutFirst	; has the player unlocked but not beaten the blackout challenge?
		beq.s	@finish			; if not, branch
		bset	#4,d1			; load Blackout Challenge teaser text

@finish:
		move.b	d1,($FFFFFF95).w	; set which texts to display after the credits
 
		jsr	SRAM_SaveNow		; save now
		jsr	Pal_CutToBlack		; fill remaining palette to black for a smooth transition
		move.w	#0,BlackBars.Height	; reset black bars
		move.b	#$2C,(GameMode).w	; set scene to $2C (new credits)
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Routines to show chapter screen and story screens or go straight to level
; ---------------------------------------------------------------------------

; MakeChapterScreen:
RunChapter:
		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag

		jsr	FakeLevelID		; get fake level ID for current level
		tst.b	d5			; did we get a valid ID?
		bmi.s	@nochapter		; if not, something has gone terribly wrong

		cmpi.w	#$301,($FFFFFE10).w	; set to Scar Night Place?
		bne.s	@checkid		; if not, branch
		frantic				; are we in frantic?
		beq.s	@checkid		; if not, branch. big boy bombs only in big boy game modes
		move.w	#$500,($FFFFFE10).w	; start bomb machine cutscene

@checkid:
		cmp.b	(CurrentChapter).w,d5	; compare currently saved chapter number to fake level ID
		blt.s	@nochapter		; if this is a chapter from a level we already visited, skip chapter screen
		move.b	d5,(CurrentChapter).w	; we've entered a new level, update progress chapter ID

		bsr	Check_BaseGameBeaten_Any ; has the player already beaten the base game (of either mode)?
		bne.s	@nochapter		; if yes, no longer display chapter screens
		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		bne.s	@nochapter		; if yes, start level straight away

		jsr	SRAM_SaveNow		; save our progress now
		move.b	#$28,(GameMode).w	; new chapter discovered, run chapters screen
		rts

@nochapter:
		jsr	SRAM_SaveNow		; save our progress now
		bra.w	StartLevel		; start level in $FE10 directly
; ===========================================================================

RunStory:
		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		beq.s	RunStory_Force		; if not, run story as usual
		jsr	SRAM_SaveNow		; save our progress now
		move.b	(StoryTextID).w,d0	; copy story ID to d0 (needed for Exit_StoryScreen)
		bra.w	Exit_StoryScreen	; auto-skip story screen

RunStory_Force:
		jsr	SRAM_SaveNow		; save our progress now
		move.b	#$20,(GameMode).w	; start Story Screen
		rts				; return


; ===========================================================================
; ---------------------------------------------------------------------------
; Logic run after jumping into a giant ring (Uberhub or anywhere else)
; ---------------------------------------------------------------------------

; d0 = ID of the giant ring we jumped into (Uberhub only)
Exit_GiantRing:
		cmpi.w	#$400,($FFFFFE10).w	; did we jump into a ring from Uberhub?
		beq.s	Exit_UberhubRing	; if yes, go to its logic

		cmpi.w	#$001,($FFFFFE10).w	; is level intro cutscene?
		beq.w	MiscRing_IntroEnd	; if yes, branch
		cmpi.b	#5,($FFFFFE10).w	; is this the a ring in the tutorial/Finalor?
		beq.w	Exit_Level		; if yes, consider this a beaten level

		bra.w	ReturnToUberhub		; otherwise something went wrong, return to Uberhub as fallback
; ===========================================================================

Exit_UberhubRing:
		add.b	d0,d0				; double ID to word
		beq.w	ReturnToUberhub			; if it's 0, it's an invalid ring
		bhs.s	@notmisc			; if it's 1-7F, branch
		addi.w	#GRing_Misc-GRing_Exits,d0	; adjust for misc rings table
@notmisc:
		move.w	GRing_Exits(pc,d0.w),d0		; load offset to d0
		jmp	GRing_Exits(pc,d0.w)		; jumpt to respective ring exit logic

; ===========================================================================
GRing_Exits:	dc.w	ReturnToUberhub-GRing_Exits	; invalid ring
		dc.w	HubRing_NHP-GRing_Exits
		dc.w	HubRing_GHP-GRing_Exits
		dc.w	HubRing_SP-GRing_Exits
		dc.w	HubRing_RP-GRing_Exits
		dc.w	HubRing_LP-GRing_Exits
		dc.w	HubRing_UP-GRing_Exits
		dc.w	HubRing_SNP-GRing_Exits
		dc.w	HubRing_SAP-GRing_Exits
		dc.w	HubRing_FP-GRing_Exits		
; ---------------------------------------------------------------------------
GRing_Misc:	dc.w	ReturnToUberhub-GRing_Exits	; invalid ring
		dc.w	HubRing_Options-GRing_Exits ; <-- notice the offsets!
		dc.w	HubRing_Tutorial-GRing_Exits
		dc.w	HubRing_Blackout-GRing_Exits
		dc.w	HubRing_IntroStart-GRing_Exits
		dc.w	HubRing_Ending-GRing_Exits
		dc.w	HubRing_SoundTest-GRing_Exits
; ===========================================================================

HubRing_NHP:	move.w	#$000,($FFFFFE10).w	; set level to GHZ1
		bra.w	RunChapter

HubRing_GHP:	move.w	#$002,($FFFFFE10).w	; set level to GHZ3
		bra.w	StartLevel		; no chapter

HubRing_SP:	move.w	#$300,($FFFFFE10).w	; set level to Special Stage
		clr.b	(Blackout).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_RP:	move.w	#$200,($FFFFFE10).w	; set level to MZ1
		bra.w	RunChapter

HubRing_LP:
		btst	#3,(OptionsBits).w	; are black bars (cinematic mode) enabled?
		beq.s	@nobars			; if not, branch
		jsr	Pal_FadeFrom		; fade out palette to avoid visual glitches
		jsr	ClearScreen		; clear screen
		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette	
		moveq	#$11,d0			; load warning text that black bars don't work in LP
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint
@nobars:
		move.w	#$101,($FFFFFE10).w	; set level to LZ2
		bra.w	RunChapter

HubRing_UP:	move.w	#$401,($FFFFFE10).w	; set level to Special Stage 2
		clr.b	(Blackout).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_SNP:	move.w	#$301,($FFFFFE10).w	; set level to SLZ2
		bra.w	RunChapter

HubRing_SAP:	move.w	#$302,($FFFFFE10).w	; set level to SLZ3
		bra.w	StartLevel		; no chapter

HubRing_FP:	move.w	#$502,($FFFFFE10).w	; set level to FZ
		bra.w	RunChapter
; ---------------------------------------------------------------------------

HubRing_IntroStart:
		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag
		move.w	#$001,($FFFFFE10).w	; set to intro cutscene (this also controls the start of the intro cutscene itself)
		move.b	#$28,(GameMode).w	; load chapters screen for intro cutscene ("One Hot Day...")
		rts				; this is the only text screen not affected by Skip Story Texts

MiscRing_IntroEnd:
		move.b	#1,(StoryTextID).w	; set number for text to 1
		bra.w	RunStory

HubRing_Options:
		clr.w	($FFFFFF82).w		; set default selected entry
		move.b	#$24,(GameMode).w	; load options menu
		rts

HubRing_SoundTest:
		move.b	#$34,(GameMode).w	; load sound test screen
		rts

HubRing_Tutorial:
		move.w	#$501,($FFFFFE10).w	; set level to SBZ2
		bra.w	StartLevel

HubRing_Ending:
		move.b	#$9D,d0			; play ending sequence music
		jsr	PlaySound
		move.b	#8,(StoryTextID).w	; set number for text to 8
		bra.w	RunStory

HubRing_Blackout:
		bclr	#2,(ScreenFuzz).w	; clear temporary screen fuzz flag
		move.w	#$401,($FFFFFE10).w	; set level to Unreal
		move.b	#1,(Blackout).w		; set Blackout Challenge flag
		bra.w	StartLevel		; good luck


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to unlock the doors in Uberhub after you finish a normal level
; ---------------------------------------------------------------------------

; GotThroughAct:
Exit_Level:
		clr.w	($FFFFFE30).w		; clear any set level checkpoints

		cmpi.w	#$501,($FFFFFE10).w	; did we beat the tutorial?
		beq.w	GTA_Tutorial		; if yes, branch

		cmpi.w	#$002,($FFFFFE10).w	; did we beat NHP/GHP?
		beq.w	GTA_NHPGHP		; if yes, branch

		cmpi.w	#$300,($FFFFFE10).w	; did we beat Special Place?
		beq.w	GTA_SP			; if yes, branch

		cmpi.w	#$200,($FFFFFE10).w	; did we beat RP?
		beq.w	GTA_RP			; if yes, branch

		cmpi.w	#$101,($FFFFFE10).w	; did we beat LP?
		beq.w	GTA_LP			; if yes, branch

		cmpi.w	#$401,($FFFFFE10).w	; did we beat Unreal Place?
		bne.s	@notunreal		; if not, branch
		tst.b	(Blackout).w		; is this the blackout special stage?
		beq.w	GTA_UP			; if not, you've beaten UP
		bra.w	GTA_Blackout		; otherwise, you've beaten blackout

@notunreal:
		cmpi.w	#$302,($FFFFFE10).w	; did we beat SNP/SAP?
		beq.w	GTA_SNPSAP		; if yes, branch
		
		cmpi.w	#$502,($FFFFFE10).w	; did we beat FP?
		beq.w	GTA_FP			; if yes, branch

		bra.w	ReturnToUberhub		; uhh idk how this could ever happen, but just in case
; ---------------------------------------------------------------------------

GTA_Tutorial:	btst	#2,(OptionsBits).w	; is Skip Uberhub Place enabled?	
		beq.w	ReturnToUberhub		; if not, return to Uberhub
		bra.w	HubRing_NHP		; otherwise go straight to NHP

GTA_NHPGHP:	moveq	#0,d0			; unlock first door
		bsr	Set_DoorOpen
		move.b	#2,(StoryTextID).w	; set number for text to 2
		bra.w	RunStory

GTA_SP:		moveq	#1,d0			; unlock second door
		bsr	Set_DoorOpen
		move.b	#3,(StoryTextID).w	; set number for text to 3
		bra.w	RunStory

GTA_RP:		moveq	#2,d0			; unlock third door
		bsr	Set_DoorOpen
		move.b	#4,(StoryTextID).w	; set number for text to 4
		bra.w	RunStory

GTA_LP:		moveq	#3,d0			; unlock fourth door
		bsr	Set_DoorOpen
		move.b	#5,(StoryTextID).w	; set number for text to 5
		bra.w	RunStory

GTA_UP:		moveq	#4,d0			; open fifth door
		bsr	Set_DoorOpen
		move.b	#6,(StoryTextID).w	; set number for text to 6
		bra.w	RunStory

GTA_SNPSAP:	moveq	#5,d0			; unlock sixth door
		bsr	Set_DoorOpen
		move.b	#7,(StoryTextID).w	; set number for text to 7
		bra.w	RunStory

GTA_FP:		moveq	#6,d0			; unlock seventh door (door to the credits)
		bsr	Set_DoorOpen
		btst	#2,(OptionsBits).w	; is Skip Uberhub Place enabled?		
		beq.w	ReturnToUberhub		; if not, return to Uberhub
		jsr	Check_AllLevelsBeaten_Current ; has the player beaten all levels?
		beq.w	ReturnToUberhub		; if not, return to Uberhub as well
		bra.w	HubRing_Ending		; otherwise go straight to the ending
; ---------------------------------------------------------------------------

GTA_Blackout:	
		clr.b	($FFFFFFA0).w		; set to no post-text to display
		jsr	Check_BlackoutBeaten	; has the player already beaten the blackout challenge?
		bne.s	@alreadybeaten		; if yes, branch
		bset	#0,($FFFFFFA0).w	; display nonstop inhuman unlock after story text screen
@alreadybeaten:
		jsr	Set_BlackoutDone	; you have beaten the blackout challenge, mad respect
		jsr	SRAM_SaveNow		; save
		clr.b	(Blackout).w		; clear blackout special stage flag
		move.b	#9,(StoryTextID).w	; set number for text to 9 (final congratulations)
		bra.w	RunStory_Force		; show story screen even if they are disabled


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to go straight to the next level if Skip Uberhub is enabled
; ---------------------------------------------------------------------------

SkipUberhub:
		move.w	($FFFFFE10).w,d1	; get level number of the level we just beat
		lea	(NextLevel_Array).l,a1	; load the next level array
@autonextlevelloop:
		move.w	(a1)+,d2		; get the current level ID in the list (and increase pointer to next)
		tst.w	d2			; reached end of list?
		bmi.w	ReturnToUberhub		; if yes, fall back to Uberhub
		cmp.w	d1,d2			; does ID in list match with current level?
		bne.s	@autonextlevelloop	; if not, loop

		move.w	(a1)+,d2		; get ID of next level in order

		cmpi.w	#$500,d2		; is this the bomb machine cutscene?
		bne.s	@startlevel		; if not, branch
		frantic				; are we in frantic?
		bne.s	@startlevel		; if yes, branch
		move.w	(a1)+,d2		; skip cutscene in casual

@startlevel:	
		move.w	d2,($FFFFFE10).w	; write next level in list to level ID RAM
		bra.w	RunChapter		; start the level, potentially play a chapter screen

NextLevel_Array:
		dc.w	$001	; Intro Cutscene
		dc.w	$501	; Tutorial Place
		dc.w	$000	; Night Hill Place
		dc.w	$002	; Green Hill Place
		dc.w	$300	; Special Place
		dc.w	$200	; Ruined Place
		dc.w	$101	; Labyrinthy Place
		dc.w	$401	; Unreal Place
		dc.w	$500	; Bomb Machine Cutscene
		dc.w	$301	; Scar Night Place
		dc.w	$302	; Star Agony Place
		dc.w	$502	; Finalor Place
		dc.w	$601	; Ending Sequence
	;	dc.w	$666	; Blackout Challenge
		dc.w	-1	; uhhhhhhhh
		even


; ===========================================================================
; ---------------------------------------------------------------------------
; Subtroutines to ease coordinating the game progress (casual/frantic)
; (NOTE: Frantic takes priority over Casual in all instances!)
; ---------------------------------------------------------------------------
Doors_All	= %01111111 ; (upper bit is unused)
State_BaseGame_Casual	= 0
State_BaseGame_Frantic	= 1
State_Blackout          = 2
; ---------------------------------------------------------------------------

		; d0 = bit we want to test
Check_LevelBeaten_Current:
		frantic					; are we in frantic?
		bne.s	Check_LevelBeaten_Frantic	; if yes, branch

Check_LevelBeaten_Casual:
		btst	d0,(Doors_Casual).w		; check if door is open (casual)
		rts

Check_LevelBeaten_Frantic:
		btst	d0,(Doors_Frantic).w		; check if door is open (frantic)
		rts
; ---------------------------------------------------------------------------

Check_AllLevelsBeaten_Current:
		frantic					; are we in frantic?
		bne.s	@frantic			; if yes, branch
	 	bsr	Check_AllLevelsBeaten_Casual	; all levels legitimately beaten in casusal?
		rts
@frantic:
		bsr	Check_AllLevelsBeaten_Frantic	; all levels legitimately beaten in frantic?
		rts

Check_AllLevelsBeaten_Casual:
		andi.b	#Doors_All,(Doors_Casual).w	; mask against valid door bitsets
		cmpi.b	#Doors_All,(Doors_Casual).w	; check if all doors have been unlocked (casual)
		eori.b	#%00100,ccr			; invert Z flag
		rts

Check_AllLevelsBeaten_Frantic:
		andi.b	#Doors_All,(Doors_Frantic).w	; mask against valid door bitsets
		cmpi.b	#Doors_All,(Doors_Frantic).w	; check if all doors have been unlocked (frantic)
		eori.b	#%00100,ccr			; invert Z flag
		rts
; ---------------------------------------------------------------------------

Check_BaseGameBeaten_Any:
		bsr	Check_BaseGameBeaten_Casual
		bne.s	@end
		bsr	Check_BaseGameBeaten_Frantic
@end:		rts

Check_BaseGameBeaten_Both:
		bsr	Check_BaseGameBeaten_Casual
		beq.s	@end
		bsr	Check_BaseGameBeaten_Frantic
@end:		rts

Check_BaseGameBeaten_Casual:
		btst	#State_BaseGame_Casual,(Progress).w
		rts
Check_BaseGameBeaten_Frantic:
		btst	#State_BaseGame_Frantic,(Progress).w
		rts
; ---------------------------------------------------------------------------

Check_BlackoutBeaten:
		btst	#State_Blackout,(Progress).w
		rts

Check_BlackoutUnlocked:
		bra.s	Check_BaseGameBeaten_Both

Check_BlackoutFirst:
		bsr	Check_BlackoutUnlocked	; is the blackout challenge unlocked?
		beq.s	@end			; if not, branch
		bsr	Check_BlackoutBeaten	; have you already beaten the blackout challenge?		
		eori.b	#%00100,ccr		; invert Z flag
@end:		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Cheats
; ---------------------------------------------------------------------------

; cheat called from Selbi Screen
UnlockEverything:
		move.b	#Doors_All,d0			; unlock all doors...
		move.b	d0,(Doors_Casual).w		; ...in casual...
		move.b	d0,(Doors_Frantic).w		; ...and frantic
		bsr	Set_BaseGameDone_Casual		; unlock cinematic mode
		bsr	Set_BaseGameDone_Frantic	; unlock motion blur
		bsr	Set_BlackoutDone		; unlock nonstop inhuman
		move.b	#7,(CurrentChapter).w		; set to final chapter
		rts

; cheats called from options screen
Toggle_BaseGameBeaten_Casual:
		bchg	#State_BaseGame_Casual,(Progress).w	; to unlock cinematic mode
		rts

Toggle_BaseGameBeaten_Frantic:
		bchg	#State_BaseGame_Frantic,(Progress).w	; to unlock motion blur
		rts

Toggle_BlackoutBeaten:
		bchg	#State_Blackout,(Progress).w	; to unlock nonstop inhuman
		rts

; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to update and save game progression
; ---------------------------------------------------------------------------

Set_DoorOpen:
		; d0 = door bit index we want to open
		bset	d0,(Doors_Casual).w	; unlock door (casual)
		frantic				; are we in frantic?
		beq.s	@notfrantic		; if not, branch
		bset	d0,(Doors_Frantic).w	; unlock door (frantic)
@notfrantic:	rts
; ---------------------------------------------------------------------------

Set_BaseGameDone:
		bsr	Set_BaseGameDone_Casual
		frantic
		bne.s	Set_BaseGameDone_Frantic
		rts

Set_BaseGameDone_Frantic:
		bset	#State_BaseGame_Frantic,(Progress).w	; you have beaten the base game in frantic, congrats
		; also set in casual

Set_BaseGameDone_Casual:
		bset	#State_BaseGame_Casual,(Progress).w	; you have beaten the base game in casual, congrats
		rts

; ---------------------------------------------------------------------------

Set_BlackoutDone:
		bset	#State_Blackout,(Progress).w	; you have beaten the blackout challenge, mad respect
		rts
; ---------------------------------------------------------------------------
; ===========================================================================

