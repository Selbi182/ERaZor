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
		beq.s	StartLevel		; if yes, skip chapter screen

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
		rts
; ===========================================================================

Exit_SegaScreen:
		move.b	#$1C,(GameMode).w	; set to Selbi splash screen
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
		jsr	SRAM_SaveNow		; save our progress now

		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		beq.s	@firststart		; if yes, branch
		
		frantic				; was the screen exited with frantic enabled?
		beq.s	@notfrantic		; if not, branch
		tst.b	(Doors_Frantic).w	; have any frantic levels been beaten yet?
		bne.s	@notfrantic		; if yes, branch
		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette	
		moveq	#$13,d0			; load warning text about revisiting the tutorial for frantic
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint
@notfrantic:
		bra.w	HubRing_Options		; we came from the options menu, return to it
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
		bra.w	HubRing_IntroStart	; start the intro cutscene
; ---------------------------------------------------------------------------	

@speedrun:
		jsr 	WhiteFlash2
		bclr	#1,(OptionsBits).w	; disable story screens
		bset	#2,(OptionsBits).w	; enable Skip Uberhub
		move.w	#$D3,d0			; play peelout release sound
		jsr	PlaySound_Special
		bra.w	HubRing_NHP		; go straight to NHP
; ===========================================================================

Exit_OptionsScreen:
		jsr	SRAM_SaveNow		; save our progress now
		tst.b	d0			; d0 = 0 Uberhub / 1 GameplayStyleScreen
		beq.w	ReturnToUberhub		; return to Uberhub if we exited the screen
		move.b	#$30,(GameMode).w	; set to GameplayStyleScreen if we chose that option
		rts
; ===========================================================================

Exit_SoundTestScreen:
		bra.w	ReturnToUberhub
; ===========================================================================

Exit_ChapterScreen:
		cmpi.w	#$001,($FFFFFE10).w	; is this the intro cutscene?
		beq.w	Exit_OneHotDay		; if yes, start intro cutscene (and music)
		bra.w	StartLevel		; otherwise, start level set in FE10 normally
; ===========================================================================

Exit_StoryScreen:
		; d0 = screen ID from Story Screen
		cmpi.b	#8,d0			; is this the ending sequence?
		beq.s	@startending		; if yes, branch
		cmpi.b	#9,d0			; is this the end of the blackout challenge?
		beq.w	Start_FirstGameMode	; if yes, restart game
		
		; regular story screen (including intro)
		btst	#2,(OptionsBits).w	; is Skip Uberhub Place enabled?
		bne.w	SkipUberhub		; if yes, automatically go to the next level in order
		bra.w	ReturnToUberhub		; otherwise, always return to Uberhub

@startending:
		move.b	#$18,(GameMode).w	; set to ending sequence ($18)
		rts
; ===========================================================================

Exit_CreditsScreen:
		tst.b	($FFFFFF95).w		; were any post-credits texts set to be displayed?
		beq.s	@restartfromcredits	; if not, branch

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
		beq.s	@checkblackout
		moveq	#$11,d0			; load Cinematic Mode unlock text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@checkblackout:
		btst	#3,($FFFFFF95).w
		beq.s	@restartfromcredits
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
		move.w	#$301,($FFFFFE10).w	; set level to Scar Night Place
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_EndingSequence:
		moveq	#0,d1			; set to no texts to display

		frantic				; did we beat the game in frantic?
		bne.s	@showfrantictext	; if yes, branch
		bsr	Check_AllLevelsBeaten_Frantic ; is a player who already beat frantic for some reason revisitng the end in casual?
		bne.s	@showfrantictext	; if yes, show frantic text anyway
		bset	#0,d1			; load text after beating the game in casual mode
		bra.s	@checkcinematicunlock	; skip
	@showfrantictext:
		bset	#1,d1			; load text after beating the game in frantic mode
		
@checkcinematicunlock:
		bsr	Check_BaseGameBeaten	; have you already beaten the base game?
		bne.s	@checkblackout		; if yes, branch
		bset	#2,d1			; load Cinematic Mode unlock text

@checkblackout:
		bsr	Check_BlackoutBeaten	; have you already beaten the blackout challenge?
		bne.s	@markgameasbeaten	; if yes, branch
		bset	#3,d1			; load Blackout Challenge teaser text

@markgameasbeaten:
		move.b	d1,($FFFFFF95).w	; set which texts to display after the credits
		
		bsr	Set_BaseGameDone	; you have beaten the base game, congrats
		jsr	SRAM_SaveNow		; save now
 
		move.b	#$2C,(GameMode).w	; set scene to $2C (new credits)
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Routines to show chapter screen and story screens or go straight to level
; ---------------------------------------------------------------------------

; MakeChapterScreen:
RunChapter:
		jsr	SRAM_SaveNow		; save our progress now
		move.b	#1,($FFFFFFE9).w	; set fade-out in progress flag

		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		beq.w	StartLevel		; if yes, start level straight away
		bsr	Check_BaseGameBeaten	; has the player already beaten the base game?
		bne.w	StartLevel		; if yes, no longer display chapter screens

		jsr	FakeLevelID		; get fake level ID for current level
		tst.b	d5			; did we get a valid ID?
		bmi.w	StartLevel		; if not, something has gone terribly wrong
		
		cmp.b	(CurrentChapter).w,d5	; compare currently saved chapter number to fake level ID
		blo.w	StartLevel		; if this is a chapter from a level we already visited, skip chapter screen

		move.b	d5,(CurrentChapter).w	; we've entered a new level, update progress chapter ID
		move.b	#$28,(GameMode).w	; run chapter screen
		rts
; ===========================================================================

RunStory:
		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		bne.s	RunStory_Force		; if not, run story as usual
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
		clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_RP:	move.w	#$200,($FFFFFE10).w	; set level to MZ1
		bra.w	RunChapter

HubRing_LP:	move.w	#$101,($FFFFFE10).w	; set level to LZ2
		bra.w	RunChapter

HubRing_UP:	move.w	#$401,($FFFFFE10).w	; set level to Special Stage 2
		clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		bra.w	RunChapter

HubRing_SNP:	move.w	#$301,($FFFFFE10).w	; set level to SLZ2
		frantic				; are we in frantic?
		beq.w	RunChapter		; big boy bombs only in big boy game modes
		move.w	#$500,($FFFFFE10).w	; start bomb machine cutscene
		bra.w	RunChapter

HubRing_SAP:	move.w	#$302,($FFFFFE10).w	; set level to SLZ3
		bra.w	StartLevel		; no chapter

HubRing_FP:	move.w	#$502,($FFFFFE10).w	; set level to FZ
		bra.w	RunChapter
; ---------------------------------------------------------------------------

HubRing_IntroStart:
		move.w	#$001,($FFFFFE10).w	; set to intro cutscene (this also controls the start of the intro cutscene itself)
		move.b	#$28,(GameMode).w	; load chapters screen for intro cutscene ("One Hot Day...")
		rts				; this is the only text screen not affected by Skip Story Texts

MiscRing_IntroEnd:
		move.b	#1,(StoryTextID).w	; set number for text to 1
		bra.w	RunStory

HubRing_Options:
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
		move.w	#$401,($FFFFFE10).w	; set level to Unreal
		move.b	#1,($FFFFFF5F).w	; set Blackout Challenge flag
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
		tst.b	($FFFFFF5F).w		; is this the blackout special stage?
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
		bra.w	HubRing_Ending		; otherwise go straight to the ending

GTA_Blackout:	clr.b	($FFFFFF5F).w		; clear blackout special stage flag
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
State_BaseGame	= 0
State_Blackout  = 1
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
		cmpi.b	#Doors_All,(Doors_Casual).w	; check if all doors have been unlocked (casual)
		eori.b	#%00100,ccr			; invert Z flag
		rts

Check_AllLevelsBeaten_Frantic:
		cmpi.b	#Doors_All,(Doors_Frantic).w	; check if all doors have been unlocked (frantic)
		eori.b	#%00100,ccr			; invert Z flag
		rts
; ---------------------------------------------------------------------------

Check_BaseGameBeaten:
		btst	#State_BaseGame,(Progress).w
		rts

Check_BlackoutBeaten:
		btst	#State_Blackout,(Progress).w
		rts
; ---------------------------------------------------------------------------

Check_BlackoutUnlocked:
		bsr	Check_BaseGameBeaten
		beq.s	@end
		bsr	Check_AllLevelsBeaten_Frantic
@end:		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Cheats
; ---------------------------------------------------------------------------

; cheat called from Selbi Screen
UnlockEverything:
		move.b	#Doors_All,d0		; unlock all doors...
		move.b	d0,(Doors_Casual).w	; ...in casual...
		move.b	d0,(Doors_Frantic).w	; ...and frantic
		bsr	Set_BaseGameDone	; unlock screen effects
		bsr	Set_BlackoutDone	; unlock nonstop inhuman
		rts

; cheats called from options screen
Toggle_BaseGameBeaten:
		bchg	#State_BaseGame,(Progress).w	
		rts
Toggle_BlackoutBeaten:
		bchg	#State_Blackout,(Progress).w	
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
		bset	#State_BaseGame,(Progress).w	; you have beaten the base game, congrats
		rts
; ---------------------------------------------------------------------------

Set_BlackoutDone:
		bset	#State_Blackout,(Progress).w	; you have beaten the blackout challenge, mad respect
		bsr	Set_BaseGameDone		; also set base game beaten state, just in case
		rts
; ---------------------------------------------------------------------------
; ===========================================================================

