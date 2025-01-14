; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Exit Logic and Game Progress Coordination
; ---------------------------------------------------------------------------
; BOOT
; (Black Bars Screen) > Sega Screen > Selbi Screen > Title Screen > Save Select
; 
; FIRST START
; Save Select > GameplayStyleScreen > Options > One Hot Day... > Story Screen > Uberhub
; 
; MAIN LEVEL CYCLE
; Uberhub Level Ring > Chapter Screen > Level > Story Screen > Uberhub or Next Level
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal "return to the hubworld" subroutines
; ---------------------------------------------------------------------------

ReturnToUberhub:
		; instantly
		move.w	#$400, CurrentLevel			; set level to Uberhub
		bra.s	StartLevel				; start level

ReturnToUberhub_Chapter:
		move.w	#$400, CurrentLevel			; set level to Uberhub
		btst	#SlotOptions2_NoStory, SlotOptions2	; is no-story mode enabled?
		bne.s	StartLevel				; if yes, skip chapter screen

		; show chapter screen first
		move.b	#$28, GameMode				; set to chapters screen
		rts						; return to MainGameLoop


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal level starting subroutines
; ---------------------------------------------------------------------------

StartLevel:
	if def(__BENCHMARK__)
		bra.w	ReturnToSegaScreen
	endif
		bclr	#SlotOptions2_MotionBlurTemp, SlotOptions2
		jsr	SRAMCache_SaveGlobalsAndSelectedSlotId

		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag
		clr.w	($FFFFFE30).w		; clear any set level checkpoints
		clr.w	(RelativeDeaths).w	; clear relative death counter now that we have entered a new level

		move.w	CurrentLevel, d0	; get level ID
		cmpi.w	#$300, d0		; set to Special Place?
		beq.s	@startspecial		; if yes, branch
		cmpi.w	#$401, d0		; set to Unreal Place / Blackout Challenge?
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
	if def(__WIDESCREEN__)=0 ; always start in the black bars screen in widescreen mode because it has important info
		bsr	ReturnToSegaScreen	; set first game mode to Sega Screen

		bsr	CheckGlobal_BlackBarsConfigured
		bne.s	@skip

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
		beq.s	@skip			; If so, then an old version of BlastEm has been detected
	endif

		move.b	#$38,(GameMode).w	; set to Black Bars configuration screen
		move.b	#0,(CarryOverData).w	; set next game mode to be Sega screen
@skip:
		rts
; ===========================================================================

ReturnToSegaScreen:
		move.b	#0,(GameMode).w		; set game mode to Sega Screen
		rts
; ===========================================================================

Exit_BlackBarsScreen:
		bsr	SetGlobal_BlackBarsConfigured
		jsr	SRAMCache_SaveGlobals
		tst.b	(CarryOverData).w	; is next game mode set to be options screen?
		beq.s	ReturnToSegaScreen	; if not, assume this is the first start of the game
		clr.b	(CarryOverData).w	; clear carried-over data now no matter what
		move.b	#$24,(GameMode).w	; set to options menu
		rts
; ===========================================================================

Exit_SegaScreen:
		move.b	#$1C,(GameMode).w	; set to Selbi splash screen

		tst.w	($FFFFFFFA).w		; is debug mode enabled?
		beq.s	@end			; if not, branch
		btst	#4,($FFFFF604).w	; was B held as we exited?
		beq.s	@end			; if not, branch
		bra.w	HubRing_Options		; go straight to options screen
@end:		rts
; ===========================================================================

Exit_SelbiSplash:
		clr.b	(CarryOverData).w	; clear carried-over data now no matter what
		move.b	#4,(GameMode).w		; set to title screen
		rts
; ===========================================================================

Exit_TitleScreen:
		move.b	#$3C,(GameMode).w	; go to save select screen
		rts
; ===========================================================================

Exit_SaveSelectScreen:
		bsr	CheckSlot_FirstStart	; is this the first time the game is being played?
		bne.w	ReturnToUberhub_Chapter	; if not, go to Uberhub (and always show chapter screen)
		
		; first launch
		move.b	#0,(CurrentChapter).w	; set chapter to 0 (so screen gets displayed once NHP is entered for the first time)
		move.b	#$30,(GameMode).w	; for the first time, set to Gameplay Style Screen (which then starts the intro cutscene)
		rts
; ===========================================================================

Exit_GameplayStyleScreen:
		pea	SRAMCache_SaveSelectedSlotId		; save current slot data
		bset	#SlotState_Created, SlotProgress	; mark slot as created/started
		tst.b	(CarryOverData).w	; is next game mode set to be options screen?
		beq.s	@firststart		; if not, assume this is the first start of the game
		clr.b	(CarryOverData).w	; clear carried-over data now no matter what

		frantic				; was the screen exited with frantic enabled?
		beq.s	@nohint			; if not, branch
		tst.b	(Doors_Frantic).w	; have any frantic levels been beaten yet?
		bne.s	@nohint			; if yes, branch
		tst.b	(Doors_Casual).w	; have any casual levels been beaten yet?
		beq.s	@nohint			; if NOT, this tip isn't necessary yet

@showhint:
		jsr	Pal_FadeFrom		; fade out palette to avoid visual glitches
		jsr	ClearScreen		; clear screen
		moveq	#$1D,d0			; load tutorial box palette...
		jsr	PalLoad2		; ...directly
		moveq	#$13,d0			; load warning text about revisiting the tutorial for frantic
		jsr	TutorialBox_Display	; VLADIK => Display hint
		jsr	UnsetSlot_TutorialVisited	; show FREE CANDY

@nohint:
		move.b	#$24,(GameMode).w	; we came from the options menu, return to it
		rts
; ---------------------------------------------------------------------------	

@firststart:
		move.b	#1,Options_FirstStartFlag
		move.b	#$24,(GameMode).w	; go to options menu
		st.b	($FFFFFF82).w		; set default selected entry
		rts
; ===========================================================================

Exit_OptionsScreen:
		; d0 = destination ID
		cmpi.b	#-1,d0			; is destination set to -1?
		bne.s	@chkgss			; if not, branch
		bra.w	ReturnToSegaScreen	; game progress was reset, return to Sega Screen

@chkgss:
		cmpi.b	#1,d0			; is destination set to 1?
		bne.s	@chkbars		; if not, branch
		move.b	#$30,(GameMode).w	; set to GameplayStyleScreen if we chose that option
		move.b	#1,(CarryOverData).w	; return to options menu from there again
		rts
@chkbars:
		cmpi.b	#2,d0			; is destination set to 2?
		bne.s	@default		; if not, branch
		move.b	#$38,(GameMode).w	; set to BlackBarsConfigScreen if we chose that option
		move.b	#1,(CarryOverData).w	; return to options menu from there again
		rts

@default:
		tst.b	Options_FirstStartFlag
		bne.s	@firststart
		move.b	#3,(CarryOverData).w	; set that we came from the options menu
		bra.w	ReturnToUberhub		; return to Uberhub in all other cases
; ---------------------------------------------------------------------------

@firststart:
		clr.b	Options_FirstStartFlag
		cmpi.b	#A|Start,Joypad|Held	; was A+Start held as we exited?
		beq.s	@speedrun		; if yes, quick arcade game

		move.w	#$C3,d0			; play giant ring sound
		jsr	PlaySFX	
		jsr 	WhiteFlash
		jsr 	Pal_FadeFrom
		moveq	#60,d0
@Wait:		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		subq.b	#1,d0
		bne.s 	@Wait
		bra.w	HubRing_IntroStart	; start the intro cutscene
; ---------------------------------------------------------------------------

@speedrun:
		jsr 	WhiteFlash
		move.w	#$D3,d0			; play peelout release sound
		jsr	PlaySFX
		bra.w	HubRing_NHP		; go straight to NHP
; ===========================================================================

Exit_SoundTestScreen:
		move.b	#2,(CarryOverData).w	; set that we came from the sound test
		bra.w	ReturnToUberhub		; return to Uberhub
; ===========================================================================

Exit_ChapterScreen:
		cmpi.w	#$001,CurrentLevel	; is this the intro cutscene?
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

		; regular story screen
		btst	#SlotOptions2_ArcadeMode, SlotOptions2	; is Arcade Mode enabled?
		bne.w	SkipUberhub				; if yes, automatically go to the next level in order

		cmpi.b	#1,d0			; is this the intro cutscene?
		bne.w	ReturnToUberhub		; if not, return to Uberhub
		move.b	#1,(CarryOverData).w	; set that we came from the intro cutscene
		bra.w	ReturnToUberhub		; return to Uberhub
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

		moveq	#$1D,d0			; load tutorial box palette...
		jsr	PalLoad2		; ...directly

		moveq	#$16,d0			; load text after beating the blackout challenge for the first time
		jsr	TutorialBox_Display	; VLADIK => Display hint

@restartgame:
		bra.w	ReturnToUberhub		; return to uberhub, most players will now play with their new toys
; ===========================================================================

Exit_CreditsScreen:
		tst.b	(CarryOverData).w	; were any post-credits texts set to be displayed?
		beq.w	@restartfromcredits	; if not, branch

		jsr	Pal_FadeFrom		; fade out palette
		jsr	ClearScreen		; clear screen

		lea	($FFFFD000).w,a1	; clear object RAM (the stars)...
		moveq	#0,d0			; ...cause they cause slowdowns in these screens
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram

		moveq	#$1D,d0			; load tutorial box palette...
		jsr	PalLoad2		; ...directly

		btst	#0,(CarryOverData).w
		beq.s	@checkfrantic
		moveq	#$F,d0			; load text after beating the game in casual mode
		jsr	TutorialBox_Display	; VLADIK => Display hint
		bra.s	@checkcinematicunlock
@checkfrantic:
		btst	#1,(CarryOverData).w
		beq.s	@checkcinematicunlock
		moveq	#$10,d0			; load text after beating the game in frantic mode
		jsr	TutorialBox_Display	; VLADIK => Display hint

@checkcinematicunlock:
		btst	#2,(CarryOverData).w
		beq.s	@checkmotionblur
		moveq	#$14,d0			; load Cinematic Mode unlock text
		jsr	TutorialBox_Display	; VLADIK => Display hint

@checkmotionblur:
		btst	#3,(CarryOverData).w
		beq.s	@checkblackout
		moveq	#$15,d0			; load motion blur unlock text
		jsr	TutorialBox_Display	; VLADIK => Display hint

@checkblackout:
		btst	#4,(CarryOverData).w
		beq.s	@restartfromcredits
		move.b	#$E0,d0
		jsr	PlayCommand		; fade out music to set the atmosphere
		moveq	#$12,d0			; load Blackout Challenge teaser text
		jsr	TutorialBox_Display	; VLADIK => Display hint

@restartfromcredits:
		clr.b	(CarryOverData).w	; clear carried-over data now no matter what

		btst	#SlotOptions2_ArcadeMode, SlotOptions2	; is Arcade Mode enabled?
		beq.s	@dorestart		; if not, branch
		jsr	CheckSlot_BlackoutUnlocked
		bne.w	HubRing_Blackout	; if yes, automatically go to the black out challenge

@dorestart:
		tst.b	SRAMCache.SelectedSlotId ; are we playing in a "No Save" run?
		beq.w	ReturnToUberhub_Chapter	; if yes, return to Uberhub so no progress is lost
		bra.w	ReturnToSegaScreen	; restart game from Sega Screen

; ===========================================================================
; ---------------------------------------------------------------------------
; Cutscene exit routines
; ---------------------------------------------------------------------------

Exit_OneHotDay:
		move.b	#$95,d0			; play intro cutscene music
		jsr	PlayBGM
		move.w	#$001, CurrentLevel	; load intro cutscene
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_IntroCutscene:
		move.b	#1,(StoryTextID).w	; set number for text to 1 ("The spiked sucker...")
		bra.w	RunStory		; run story
; ===========================================================================

Exit_BombMachineCutscene:
		jsr	Pal_FadeFrom
		move.w	#$301, CurrentLevel	; set level to Scar Night Place
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_EndingSequence:
		moveq	#0,d1			; set to no texts to display

		frantic				; did we beat the game in frantic?
		bne.s	@showfrantictext	; if yes, branch
		bsr	CheckSlot_BaseGameBeaten_Frantic ; is a player who already beat frantic for some reason revisitng the end in casual?
		bne.s	@showfrantictext	; if yes, show frantic text anyway
		bset	#0,d1			; load text after beating the game in casual mode
		bra.s	@checkcinematicunlock	; skip

	@showfrantictext:
		bset	#1,d1			; load text after beating the game in frantic mode

	@checkcinematicunlock:
		bsr	CheckSlot_BaseGameBeaten_Casual ; have you already beaten the base game in casual?
		bne.s	@checkmotionblur	; if yes, branch
		bset	#2,d1			; load Cinematic Mode unlock text
		
	@checkmotionblur:
		frantic				; was the game beaten in frantic?
		beq.s	@markgameasbeaten	; if not, branch
		bsr	CheckSlot_BaseGameBeaten_Frantic ; have you already beaten the base game in frantic?
		bne.s	@markgameasbeaten	; if yes, branch
		bset	#3,d1			; load Motion Blur unlock text
		
@markgameasbeaten:
		bsr	Set_BaseGameBeaten	; you have beaten the base game, congrats (casual only or frantic with casual)

	@checkblackoutteaser:
		bsr	CheckSlot_BlackoutFirst	; has the player unlocked but not beaten the blackout challenge?
		beq.s	@finish			; if not, branch
		bset	#4,d1			; load Blackout Challenge teaser text

@finish:
		move.b	d1,(CarryOverData).w	; set which texts to display after the credits
 
		jsr	SRAMCache_SaveGlobalsAndSelectedSlotId	; ### TODO: optimize
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

		bsr	FindCurrentChapter	; find the respective chapter for the current level
		tst.b	d5			; did we get a valid ID?
		bmi.s	@nochapter		; if not, something has gone terribly wrong
		addq.b	#1,d5			; chapters are 1-based

		cmpi.w	#$301, CurrentLevel	; set to Scar Night Place?
		bne.s	@checkid		; if not, branch
		frantic				; are we in frantic?
		beq.s	@checkid		; if not, branch. big boy bombs only in big boy game modes
		move.w	#$500, CurrentLevel	; start bomb machine cutscene

@checkid:
		cmp.b	(CurrentChapter).w,d5	; compare currently saved chapter number to fake level ID
		blt.s	@nochapter		; if this is a chapter from a level we already visited, skip chapter screen
		move.b	d5,(CurrentChapter).w	; we've entered a new level, update progress chapter ID
		jsr	SRAMCache_SaveSelectedSlotId

		bsr	CheckSlot_BaseGameBeaten_Any		; has the player already beaten the base game (of either mode)?
		bne.s	@nochapter				; if yes, no longer display chapter screens
		btst	#SlotOptions2_NoStory, SlotOptions2	; is no-story mode enabled?
		bne.s	@nochapter				; if yes, start level straight away

		move.b	#$28,(GameMode).w	; new chapter discovered, run chapters screen
		rts

@nochapter:
		bra.w	StartLevel		; start level in $FE10 directly
; ---------------------------------------------------------------------------

FindCurrentChapter:
		moveq	#-1,d5			; set d5 to -1 (it'll be 0)
		lea	(@Chapters).l,a1	; set level array index to a1
@loop:
		addq.w	#1,d5			; increase d5
		move.w	(a1)+,d3		; get next level ID and load it into d3
		bmi.s	@error			; end of the list? quit loop
		cmp.w	CurrentLevel,d3	; does it match with the current ID?
		bne.s	@loop			; if not, loop
		rts
@error:
		moveq	#-1,d5			; set d5 to "no result"
		rts				; otherwise return

@Chapters:	dc.w	$000	; 1 - Night Hill Place
		dc.w	$300	; 2 - Special Place
		dc.w	$200	; 3 - Ruined Place
		dc.w	$101	; 4 - Labyrinthy Place
		dc.w	$401	; 5 - Unreal Place
		dc.w	$301	; 6 - Scar Night Place
		dc.w	$402	; 7 - Unterhub Place
		dc.w	$502	; 8 - Finalor Place
		dc.w	-1	; None of the above
		even

; ===========================================================================

RunStory:
		btst	#SlotOptions2_NoStory, SlotOptions2	; is no-story mode enabled?
		beq.s	RunStory_Force				; if not, run story as usual
		move.b	(StoryTextID).w,d0			; copy story ID to d0 (needed for Exit_StoryScreen)
		bra.w	Exit_StoryScreen			; auto-skip story screen

RunStory_Force:
		move.b	#$20,(GameMode).w	; start Story Screen
		rts				; return


; ===========================================================================
; ---------------------------------------------------------------------------
; Logic run after jumping into a giant ring (Uberhub or anywhere else)
; ---------------------------------------------------------------------------

; d0 = ID of the giant ring we jumped into (Uberhub only)
Exit_GiantRing:
		cmpi.w	#$400, CurrentLevel	; did we jump into a ring from Uberhub?
		beq.s	Exit_UberhubRing	; if yes, go to its logic

		cmpi.w	#$001, CurrentLevel	; is level intro cutscene?
		beq.w	MiscRing_IntroEnd	; if yes, branch
		cmpi.w	#$402, CurrentLevel	; did we beat Unterhub?
		beq.w	Exit_Level		; if yes, consider this a beaten level
		cmpi.b	#5, CurrentZone		; is this the a ring in the tutorial/Finalor?
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
		dc.w	HubRing_Escape-GRing_Exits		
; ---------------------------------------------------------------------------
GRing_Misc:	dc.w	ReturnToUberhub-GRing_Exits	; invalid ring
		dc.w	HubRing_Options-GRing_Exits ; <-- notice the offsets!
		dc.w	HubRing_Tutorial-GRing_Exits
		dc.w	HubRing_Blackout-GRing_Exits
		dc.w	HubRing_IntroStart-GRing_Exits
		dc.w	HubRing_Ending-GRing_Exits
		dc.w	HubRing_SoundTest-GRing_Exits
		dc.w	HubRing_Unterhub-GRing_Exits
; ===========================================================================

HubRing_NHP:	move.w	#$000, CurrentLevel	; set level to GHZ1
		bra.w	RunChapter

HubRing_GHP:	move.w	#$002, CurrentLevel	; set level to GHZ3
		bra.w	StartLevel		; no chapter

HubRing_SP:	move.w	#$300, CurrentLevel	; set level to Special Stage
		clr.b	(Blackout).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_RP:	move.w	#$200, CurrentLevel	; set level to MZ1
		bra.w	RunChapter

HubRing_LP:
		btst	#SlotOptions_CinematicBlackBars, SlotOptions	; are black bars (cinematic mode) enabled?
		beq.s	@nobars						; if not, branch
		movem.l	a0/d7,-(sp)
		jsr	Pal_FadeFrom		; fade out palette to avoid visual glitches
		jsr	ClearScreen		; clear screen
		clr.w	Blackbars.Height	; make sure box appears immediately
		moveq	#$1D,d0			; load tutorial box palette...
		jsr	PalLoad2		; ...directly
		movem.l	(sp)+,a0/d7
		moveq	#$11|_DH_WithBGFuzz,d0	; load warning text that black bars don't work in LP
		jsr	Queue_TutorialBox_Display ; VLADIK => Display hint
@nobars:
		move.w	#$101, CurrentLevel	; set level to LZ2
		bra.w	RunChapter

HubRing_Unterhub:
		move.w	#$402, CurrentLevel	; set level to SYZ3
		bra.w	RunChapter

HubRing_UP:	move.w	#$401, CurrentLevel	; set level to Special Stage 2
		clr.b	(Blackout).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_SNP:	move.w	#$301, CurrentLevel	; set level to SLZ2
		bra.w	RunChapter

HubRing_SAP:	move.w	#$302, CurrentLevel	; set level to SLZ3
		bra.w	StartLevel		; no chapter

HubRing_FP:	move.w	#$502, CurrentLevel	; set level to FZ
		bra.w	RunChapter

HubRing_Escape:
		move.w	#$502, CurrentLevel	; set level to FZ
		bsr	StartLevel		; start level normally and then...
		moveq	#1,d0			; ...pre-collect checkpoint...
		move.b	d0,($FFFFFE30).w	; ...before the...
		move.b	d0,($FFFFFE31).w	; ...escape sequence
		move.w	#3,(RelativeDeaths).w	; make sure checkpoint shows up immediately
		rts
; ---------------------------------------------------------------------------

HubRing_IntroStart:
		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag
		move.w	#$001, CurrentLevel	; set to intro cutscene (this also controls the start of the intro cutscene itself)
		move.b	#$28,(GameMode).w	; load chapters screen for intro cutscene ("One Hot Day...")
		rts				; this is the only text screen not affected by Skip Story Texts

MiscRing_IntroEnd:
		move.b	#1,(StoryTextID).w	; set number for text to 1
		bra.w	RunStory

HubRing_Options:
		st.b	($FFFFFF82).w		; set default selected entry
		clr.b	Options_FirstStartFlag
		move.b	#$24,(GameMode).w	; go straight to options
		rts

HubRing_SoundTest:
		move.b	#$34,(GameMode).w	; load sound test screen
		rts

HubRing_Tutorial:
		bsr	SetSlot_TutorialVisited	; the FUN begins
		move.w	#$501, CurrentLevel	; set level to SBZ2
		bra.w	StartLevel

HubRing_Ending:
		move.b	#$9D,d0			; play ending sequence music
		jsr	PlayBGM
		move.b	#8,(StoryTextID).w	; set number for text to 8
		bra.w	RunStory

HubRing_Blackout:
		bclr	#SlotOptions2_MotionBlurTemp, SlotOptions2	; clear temporary screen fuzz flag
		move.w	#$401, CurrentLevel	; set level to Unreal
		move.b	#1,(Blackout).w		; set Blackout Challenge flag
		bra.w	StartLevel		; good luck

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to unlock the doors in Uberhub after you finish a normal level
; ---------------------------------------------------------------------------

; GotThroughAct:
Exit_Level:
		cmpi.w	#$501, CurrentLevel	; did we beat the tutorial?
		beq.w	GTA_Tutorial		; if yes, branch

		cmpi.w	#$003, CurrentLevel	; did we beat NHP/GHP?
		beq.w	GTA_NHPGHP		; if yes, branch

		cmpi.w	#$300, CurrentLevel	; did we beat Special Place?
		beq.w	GTA_SP			; if yes, branch

		cmpi.w	#$200, CurrentLevel	; did we beat RP?
		beq.w	GTA_RP			; if yes, branch

		cmpi.w	#$402, CurrentLevel	; did we beat Unterhub?
		beq.w	GTA_Unterhub		; if yes, branch

		cmpi.w	#$101, CurrentLevel	; did we beat LP?
		beq.w	GTA_LP			; if yes, branch

		cmpi.w	#$401, CurrentLevel	; did we beat Unreal Place?
		bne.s	@notunreal		; if not, branch
		tst.b	(Blackout).w		; is this the blackout special stage?
		beq.w	GTA_UP			; if not, you've beaten UP
		bra.w	GTA_Blackout		; otherwise, you've beaten blackout

@notunreal:
		cmpi.w	#$302, CurrentLevel	; did we beat SNP/SAP?
		beq.w	GTA_SNPSAP		; if yes, branch
		
		cmpi.w	#$502, CurrentLevel	; did we beat FP?
		beq.w	GTA_FP			; if yes, branch

		bra.w	ReturnToUberhub		; uhh idk how this could ever happen, but just in case
; ---------------------------------------------------------------------------

GTA_Tutorial:	btst	#SlotOptions2_ArcadeMode, SlotOptions2	; is Arcade Mode enabled?	
		bne.w	HubRing_NHP		; if yes, go straight to NHP
		move.b	#4,(CarryOverData).w	; set that we came from the tutorial
		bra.w	ReturnToUberhub		; if not, return to Uberhub

GTA_NHPGHP:	moveq	#0,d0			; unlock first door
		bsr	SetSlot_DoorOpen
		move.b	#2,(StoryTextID).w	; set number for text to 2
		bra.w	RunStory

GTA_SP:		moveq	#1,d0			; unlock second door
		bsr	SetSlot_DoorOpen
		move.b	#3,(StoryTextID).w	; set number for text to 3
		bra.w	RunStory

GTA_RP:		moveq	#2,d0			; unlock third door
		bsr	SetSlot_DoorOpen
		moveq	#7,d0			; set Unterhub as NOT beaten
		bsr	SetSlot_DoorClosed	; (...only required to not sequence break replays)
		move.b	#4,(StoryTextID).w	; set number for text to 4
		bra.w	RunStory

GTA_LP:		moveq	#3,d0			; unlock fourth door
		bsr	SetSlot_DoorOpen
		move.b	#5,(StoryTextID).w	; set number for text to 5
		bra.w	RunStory

GTA_UP:		moveq	#4,d0			; open fifth door
		bsr	SetSlot_DoorOpen
		move.b	#6,(StoryTextID).w	; set number for text to 6
		tst.w	(RelativeDeaths).w	; zero death run?
		bne.w	RunStory		; if not, regular text
		move.b	#$A,(StoryTextID).w	; alternative text for pros
		bra.w	RunStory

GTA_SNPSAP:	moveq	#5,d0			; unlock sixth door
		bsr	SetSlot_DoorOpen
		move.b	#7,(StoryTextID).w	; set number for text to 7
		bra.w	RunStory

GTA_Unterhub:	moveq	#7,d0			; set Unterhub as beaten
		bsr	SetSlot_DoorOpen
		move.b	#$C,(StoryTextID).w	; set number for text to $C
		btst	#2,($FFFFF7A7).w	; did you kill the Roller?
		bne.w	RunStory		; if yes, run normal story
		move.b	#$D,(StoryTextID).w	; use pacifist story instead
		bra.w	RunStory

GTA_FP:		moveq	#6,d0					; unlock seventh door (door to the credits)
		bsr	SetSlot_DoorOpen
		bsr	SetSlot_TutorialVisited			; set tutorial visited now in case it wasn't already
		btst	#SlotOptions2_ArcadeMode, SlotOptions2	; is Arcade Mode enabled?		
		beq.s	@fromtutorialring			; if not, branch
		jsr	CheckSlot_AllLevelsBeaten_Current	; has the player beaten all levels?
		bne.w	HubRing_Ending				; if yes, go straight to the ending
@fromtutorialring:
		move.b	#4,(CarryOverData).w	; set that we came from the tutorial
		bra.w	ReturnToUberhub		; return to Uberhub
; ---------------------------------------------------------------------------

GTA_Blackout:	
		clr.b	($FFFFFFA0).w		; set to no post-text to display
		jsr	CheckSlot_BlackoutBeaten; has the player already beaten the blackout challenge?
		bne.s	@alreadybeaten		; if yes, branch
		bset	#0,($FFFFFFA0).w	; display nonstop inhuman unlock after story text screen
@alreadybeaten:
		jsr	Set_BlackoutBeaten	; you have beaten the blackout challenge, mad respect
		clr.b	(Blackout).w		; clear blackout special stage flag
		move.b	#5,(CarryOverData).w	; set that we came from the blackout challenge
		move.b	#9,(StoryTextID).w	; set number for text to 9 (final congratulations)
		bra.w	RunStory		; show story screen


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to go straight to the next level if Skip Uberhub is enabled
; ---------------------------------------------------------------------------

SkipUberhub:
		move.w	CurrentLevel, d1	; get level number of the level we just beat
		lea	NextLevel_Array(pc), a1	; load the next level array
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
		move.w	d2, CurrentLevel	; write next level in list to level ID RAM
		bra.w	RunChapter		; start the level, potentially play a chapter screen

NextLevel_Array:
		dc.w	$001	; Intro Cutscene
		dc.w	$501	; Tutorial Place
		dc.w	$000	; Night Hill Place
		dc.w	$003	; Green Hill Place (part 2)
		dc.w	$300	; Special Place
		dc.w	$200	; Ruined Place
		dc.w	$101	; Labyrinthy Place
		dc.w	$401	; Unreal Place
		dc.w	$500	; Bomb Machine Cutscene
		dc.w	$301	; Scar Night Place
		dc.w	$302	; Star Agony Place
		dc.w	$400	; Uberhub Place (for the cutscene)
		dc.w	$402	; Unterhub Place
		dc.w	$502	; Finalor Place
		dc.w	$601	; Ending Sequence
	;	dc.w	$666	; Blackout Challenge
		dc.w	-1	; uhhhhhhhh
		even


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to ease coordinating the game progress (casual/frantic)
; (NOTE: Frantic takes priority over Casual in all instances!)
; ---------------------------------------------------------------------------

Doors_All:				equ	%11111111

; RAM Location: `GlobalProgress`
GlobalState_BaseGameBeaten_Casual:	equ	0
GlobalState_BaseGameBeaten_Frantic:	equ	1
GlobalState_BlackoutBeaten:		equ	2
GlobalState_BlackBarsConfigured:	equ	7

; RAM Location: `SlotProgress`
SlotState_BaseGameBeaten_Casual:	equ	0
SlotState_BaseGameBeaten_Frantic:	equ	1
SlotState_BlackoutBeaten:		equ	2
SlotState_Difficulty:			equ	3	; 0 = casual, 1 = frantic
SlotState_TutorialVisited: 		equ	4
SlotState_HubEasterVisited:		equ	5
SlotState_Created:			equ	7	; 0 = empty slot, 1 = occupied slot
; ---------------------------------------------------------------------------

CheckSlot_FirstStart:
		btst	#SlotState_Created, SlotProgress
		rts

; ---------------------------------------------------------------------------

		; d0 = bit we want to test
CheckSlot_LevelBeaten_Current:
		frantic					; are we in frantic?
		bne.s	CheckSlot_LevelBeaten_Frantic	; if yes, branch

CheckSlot_LevelBeaten_Casual:
		btst	d0, Doors_Casual		; check if door is open (casual)
		rts

CheckSlot_LevelBeaten_Frantic:
		btst	d0, Doors_Frantic		; check if door is open (frantic)
		rts
; ---------------------------------------------------------------------------

CheckSlot_AllLevelsBeaten_Current:
		frantic					; are we in frantic?
		bne.s	@frantic			; if yes, branch
	 	bsr	CheckSlot_AllLevelsBeaten_Casual; all levels legitimately beaten in casusal?
		rts
@frantic:
		bsr	CheckSlot_AllLevelsBeaten_Frantic; all levels legitimately beaten in frantic?
		rts

CheckSlot_AllLevelsBeaten_Casual:
		cmpi.b	#Doors_All, Doors_Casual	; check if all doors have been unlocked (casual)
		eori.b	#%00100,ccr			; invert Z flag
		rts

CheckSlot_AllLevelsBeaten_Frantic:
		cmpi.b	#Doors_All, Doors_Frantic	; check if all doors have been unlocked (frantic)
		eori.b	#%00100,ccr			; invert Z flag
		rts
; ---------------------------------------------------------------------------

CheckGlobal_BaseGameBeaten_Any:
		bsr	CheckGlobal_BaseGameBeaten_Casual
		bne.s	@end
		bra	CheckGlobal_BaseGameBeaten_Frantic
@end:		rts

CheckGlobal_BaseGameBeaten_Both:
		bsr	CheckGlobal_BaseGameBeaten_Casual
		beq.s	@end
		bra	CheckGlobal_BaseGameBeaten_Frantic
@end:		rts

CheckGlobal_BaseGameBeaten_Casual:
		btst	#GlobalState_BaseGameBeaten_Casual, GlobalProgress
		rts

CheckGlobal_BaseGameBeaten_Frantic:
		btst	#GlobalState_BaseGameBeaten_Frantic, GlobalProgress
		rts

CheckGlobal_BlackoutBeaten:
		btst	#GlobalState_BlackoutBeaten, GlobalProgress
		rts

CheckGlobal_BlackoutUnlocked: 	equ CheckGlobal_BaseGameBeaten_Both
; ---------------------------------------------------------------------------

CheckSlot_BaseGameBeaten_Any:
		bsr	CheckSlot_BaseGameBeaten_Casual
		bne.s	@end
		bra	CheckSlot_BaseGameBeaten_Frantic
@end:		rts

CheckSlot_BaseGameBeaten_Both:
		bsr	CheckSlot_BaseGameBeaten_Casual
		beq.s	@end
		bra	CheckSlot_BaseGameBeaten_Frantic
@end:		rts

CheckSlot_BaseGameBeaten_Casual:
		btst	#SlotState_BaseGameBeaten_Casual, SlotProgress
		rts

CheckSlot_BaseGameBeaten_Frantic:
		btst	#SlotState_BaseGameBeaten_Frantic, SlotProgress
		rts

CheckSlot_BlackoutBeaten:
		btst	#SlotState_BlackoutBeaten, SlotProgress
		rts

CheckSlot_BlackoutUnlocked: 	equ CheckSlot_BaseGameBeaten_Both

; ---------------------------------------------------------------------------

CheckSlot_BlackoutFirst:
		bsr	CheckSlot_BlackoutUnlocked	; is the blackout challenge unlocked?
		beq.s	@end				; if not, branch
		bsr	CheckSlot_BlackoutBeaten	; have you already beaten the blackout challenge?		
		eori.b	#%00100,ccr			; invert Z flag
@end:		rts
; ---------------------------------------------------------------------------

CheckSlot_TutorialVisited:
		btst	#SlotState_TutorialVisited, SlotProgress
		rts
; ---------------------------------------------------------------------------

CheckSlot_HubEasterVisited:
		btst	#SlotState_HubEasterVisited, SlotProgress
		rts
; ---------------------------------------------------------------------------

CheckGlobal_BlackBarsConfigured:
		btst	#GlobalState_BlackBarsConfigured, GlobalProgress
		rts
; ---------------------------------------------------------------------------

CheckSlot_UnterhubUnlocked:
		moveq	#6-1,d0				; check if all 6 main trophies are collected
@checknext:						; (...NHP/GHP, SP, RP, LP, UP, SNP/SAP)
		bsr	CheckSlot_LevelBeaten_Current	; check if current level in d0 is beaten
		beq.s	@no				; if not, requirement failed
		subq.b	#1,d0				; check next level
		bpl.s	@checknext			; continue checking for all
@no:		rts

CheckSlot_UnterhubFirst:
		bsr	CheckSlot_UnterhubUnlocked	; even unlocked?
		beq.s	@no				; if not, branch
		bsr	CheckSlot_UnterhubBeaten	; Unterhub NOT beaten?
		eori.b	#%00100,ccr			; invert Z flag
@no:		rts

CheckSlot_UnterhubBeaten:
		bsr	CheckSlot_UnterhubUnlocked	; Unterhub eben unlocked?
		beq.s	@no				; if not, branch
		moveq	#7,d0				; Unterhub beaten?
		bsr	CheckSlot_LevelBeaten_Current
@no:		rts

; ---------------------------------------------------------------------------

Check_FullArcadeMode:
		btst	#SlotOptions2_NoStory, SlotOptions2
		beq.s	@end
		btst	#SlotOptions2_ArcadeMode, SlotOptions2
@end:		rts

; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Cheats
; ---------------------------------------------------------------------------

; cheat called from Selbi Screen
UnlockEverything:
		moveq	#$FFFFFF00|Doors_All, d0	; unlock all doors...
		move.b	d0, Doors_Casual		; ...in casual...
		move.b	d0, Doors_Frantic		; ...and frantic
		bsr	Set_BaseGameBeaten_Casual	; unlock cinematic mode
		bsr	Set_BaseGameBeaten_Frantic	; unlock motion blur
		bsr	Set_BlackoutBeaten		; unlock nonstop inhuman
		bsr	SetSlot_TutorialVisited		; set tutorial visited
		bsr	SetSlot_HubEasterVisited	; set Uberhub easter egg as visited
		move.b	#8,(CurrentChapter).w		; set to final chapter

		move.b	#3, SRAMCache.SelectedSlotId	; save to slot 3	
		jmp	SRAMCache_SaveGlobalsAndSelectedSlotId

; cheats called from options screen
ToggleGlobal_BaseGameBeaten_Casual:
		bchg	#GlobalState_BaseGameBeaten_Casual, GlobalProgress	; to unlock cinematic mode
		rts

ToggleGlobal_BaseGameBeaten_Frantic:
		bchg	#GlobalState_BaseGameBeaten_Frantic, GlobalProgress	; to unlock motion blur
		rts

ToggleGlobal_BlackoutBeaten:
		bchg	#GlobalState_BlackoutBeaten, GlobalProgress		; to unlock nonstop inhuman
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to update and save game progression
; ---------------------------------------------------------------------------

SetSlot_DoorOpen:
		; d0 = door bit index we want to open
		bset	d0, Doors_Casual	; unlock door (casual)
		frantic				; are we in frantic?
		beq.s	@notfrantic		; if not, branch
		bset	d0, Doors_Frantic	; unlock door (frantic)
@notfrantic:	rts
; ---------------------------------------------------------------------------

SetSlot_DoorClosed:
		frantic				; are we in frantic?
		bne.s	@frantic		; if yes, branch
		bclr	d0, Doors_Casual	; close door (casual)
		rts
@frantic:
		bclr	d0, Doors_Frantic	; close door (frantic)
		rts
; ---------------------------------------------------------------------------

SetGlobal_BlackBarsConfigured:
		bset	#GlobalState_BlackBarsConfigured, GlobalProgress
		rts
; ---------------------------------------------------------------------------

Set_BaseGameBeaten:
		bsr	Set_BaseGameBeaten_Casual
		frantic
		bne.s	Set_BaseGameBeaten_Frantic
		rts

Set_BaseGameBeaten_Frantic:
		bset	#SlotState_BaseGameBeaten_Frantic, SlotProgress		; you have beaten the base game in frantic, congrats
		bset	#GlobalState_BaseGameBeaten_Frantic, GlobalProgress	; ''
		; also set in casual

Set_BaseGameBeaten_Casual:
		bset	#SlotState_BaseGameBeaten_Casual, SlotProgress		; you have beaten the base game in casual, congrats
		bset	#GlobalState_BaseGameBeaten_Casual, GlobalProgress	; ''
		rts
; ---------------------------------------------------------------------------

Set_BlackoutBeaten:
		bset	#SlotState_BlackoutBeaten, SlotProgress			; you have beaten the blackout challenge, mad respect
		bset	#GlobalState_BlackoutBeaten, GlobalProgress		; ''
		rts
; ---------------------------------------------------------------------------

SetSlot_TutorialVisited:
		bset	#SlotState_TutorialVisited, SlotProgress
		rts
UnsetSlot_TutorialVisited:
		bclr	#SlotState_TutorialVisited, SlotProgress
		rts
; ---------------------------------------------------------------------------

SetSlot_HubEasterVisited:
		bset	#SlotState_HubEasterVisited, SlotProgress
		rts

; ---------------------------------------------------------------------------
; ===========================================================================

