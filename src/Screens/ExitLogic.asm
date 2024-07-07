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
; Uberhub > Chapter Screen > Level > Story Screen > Uberhub
; ---------------------------------------------------------------------------
; Default options when starting the game for the first time
; (Casual Mode, Extended Camera, Flashy Lights, Story Text Screens)
DefaultOptions = %10000011
; ---------------------------------------------------------------------------
ResumeFlag	equ	$FFFFF601
CurrentChapter	equ	$FFFFFFA7
StoryTextID	equ	$FFFFFF9E
OptionsBits	equ	$FFFFFF92
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
		move.b	#$28,($FFFFF600).w	; set to chapters screen
		rts				; return to MainGameLoop


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal level starting subroutines
; ---------------------------------------------------------------------------

StartLevel:
		move.w	($FFFFFE10).w,d0	; get level ID
		cmpi.w	#$300,d0		; set to Special Place?
		beq.s	@startspecial		; if yes, branch
		cmpi.w	#$401,d0		; set to Unreal Place / Blackout Challenge?
		beq.s	@startspecial		; if yes, branch
		
		; regular level
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts				; return to MainGameLoop

@startspecial:
		; special stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts				; return to MainGameLoop


; ===========================================================================
; ---------------------------------------------------------------------------
; Various screen exiting routines
; ---------------------------------------------------------------------------

Start_FirstGameMode:
		move.b	#0,($FFFFF600).w	; set first game mode to Sega Screen
		rts
; ===========================================================================

Exit_SegaScreen:
		move.b	#$1C,($FFFFF600).w	; set to Selbi splash screen
		rts
; ===========================================================================

Exit_SelbiSplash:
		move.b	#4,($FFFFF600).w	; set to title screen
		rts
; ===========================================================================

Exit_TitleScreen:
		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		bne.w	ReturnToUberhub_Chapter	; if not, go to Uberhub (and always show chapter screen)
		
		; first launch
		move.b	#DefaultOptions,(OptionsBits).w	; load default options
		move.b	#0,(CurrentChapter).w		; set chapter to 0 (so screen gets displayed once NHP is entered for the first time)
		move.b	#$30,($FFFFF600).w		; for the first time, set to Gameplay Style Screen (which then starts the intro cutscene)
		rts
; ===========================================================================

Exit_GameplayStyleScreen:
		tst.b	(ResumeFlag).w		; is this the first time the game is being played?
		bne.w	HubRing_Options		; if not, we came from the options menu, return to it
		
		; first launch
		move.b	#1,(ResumeFlag).w	; set resume flag now
		bra.w	HubRing_IntroStart	; start the intro cutscene
; ===========================================================================

Exit_OptionsScreen:
		tst.b	d0			; d0 = 0 Uberhub / 1 GameplayStyleScreen
		beq.w	ReturnToUberhub		; return to Uberhub if we exited the screen
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen if we chose that option
		rts
; ===========================================================================

Exit_SoundTestScreen:
		bra.w	ReturnToUberhub
; ===========================================================================

Exit_ChapterScreen:
		bra.w	StartLevel		; start level set in FE10 normally
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
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts
; ===========================================================================

Exit_CreditsScreen:
		moveq	#$E,d0			; load FZ palette (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load palette

		moveq	#$F,d0			; load text after beating the game in casual mode
		frantic				; have you beaten the game in frantic mode?
		beq.s	@basegamehint		; if not, pussy
		moveq	#$10,d0			; load text after beating the game in frantic mode
@basegamehint:	jsr	Tutorial_DisplayHint	; VLADIK => Display hint

		bsr	Check_BaseGameBeaten	; have you already beaten the base game?
		bne.s	@checkblackout		; if yes, branch
		moveq	#$11,d0			; load Cinematic Mode unlock text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@checkblackout:
		bsr	Check_BlackoutBeaten	; have you already beaten the blackout challenge?
		bne.s	@markgameasbeaten	; if yes, branch
		moveq	#$12,d0			; load Blackout Challenge teaser text
		jsr	Tutorial_DisplayHint	; VLADIK => Display hint

@markgameasbeaten:
		bsr	Set_BaseGameDone	; you have beaten the base game, congrats
		jsr	SRAM_SaveNow		; save
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
		move.b	#$2C,($FFFFF600).w	; set scene to $2C (new credits)
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Routines to show chapter screen and story screens or go straight to level
; ---------------------------------------------------------------------------

; MakeChapterScreen:
RunChapter:
		jsr	SRAM_SaveNow		; save our progress now

		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		beq.w	StartLevel		; if yes, start level straight away

		jsr	FakeLevelID		; get fake level ID for current level
		tst.b	d5			; did we get a valid ID?
		bmi.w	StartLevel		; if not, something has gone terribly wrong
		
		cmp.b	(CurrentChapter).w,d5	; compare currently saved chapter number to fake level ID
		blo.w	StartLevel		; if this is a chapter from a level we already visited, skip chapter screen

		move.b	d5,(CurrentChapter).w	; we've entered a new level, update progress chapter ID
		move.b	#$28,($FFFFF600).w	; run chapter screen
		rts
; ===========================================================================

RunStory:
		jsr	SRAM_SaveNow		; save our progress now

		move.b	(StoryTextID).w,d0	; copy story ID to d0 (needed for Exit_StoryScreen)
		btst	#1,(OptionsBits).w	; is "Skip Story Screens" enabled?
		beq.w	Exit_StoryScreen	; if yes, well, skip it

		move.b	#$20,($FFFFF600).w	; start Story Screen
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
		addi.w	#(GRing_Misc-GRing_Exits)-2,d0	; adjust for misc rings table
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
GRing_Misc:	dc.w	HubRing_Options-GRing_Exits ; <-- notice the offsets!
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
		move.b	#$28,($FFFFF600).w	; load chapters screen for intro cutscene ("One Hot Day...")
		rts				; this is the only text screen not affected by Skip Story Texts

MiscRing_IntroEnd:
		move.b	#1,(StoryTextID).w	; set number for text to 1
		bra.w	RunStory

HubRing_Options:
		move.b	#$24,($FFFFF600).w	; load options menu
		rts

HubRing_SoundTest:
		move.b	#$34,($FFFFF600).w	; load sound test screen
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
		bra.w	RunStory


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

		move.w	(a1),($FFFFFE10).w	; write next level in list to level ID RAM
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
; Bit indices in the progress RAM (FF8A/FF8B)
Casual_BaseGame  = 0
Casual_Blackout  = 1
Frantic_BaseGame = 2
Frantic_Blackout = 3
; ---------------------------------------------------------------------------

Check_LevelBeaten:
		; d0 = bit we want to test
		frantic				; are we in frantic?
		bne.s	@frantic		; if yes, branch
		btst	d0,($FFFFFF8A).w	; check if door is open (casual)
		rts
@frantic:
		btst	d0,($FFFFFF8B).w	; check if door is open (frantic)
		rts
; ===========================================================================

Check_BaseGameBeaten:
		bsr	Check_BaseGameBeaten_Frantic	; has the player beaten the base game in frantic?
		bne.s	StateCheck_Yes			; if yes, branch
		bra.s	Check_BaseGameBeaten_Casual	; check if at least casual was beaten

Check_BlackoutBeaten:
		bsr	Check_BlackoutBeaten_Frantic	; has the player beaten the blackout challenge in frantic?
		bne.s	StateCheck_Yes			; if yes, branch
		bra.s	Check_BlackoutBeaten_Casual	; check if at least casual was beaten
; ---------------------------------------------------------------------------

Check_BaseGameBeaten_Casual:
		btst	#Casual_BaseGame,($FFFFFF93).w
		rts
Check_BaseGameBeaten_Frantic:
		btst	#Frantic_BaseGame,($FFFFFF93).w
		rts

Check_BlackoutBeaten_Casual:
		btst	#Casual_Blackout,($FFFFFF93).w
		rts
Check_BlackoutBeaten_Frantic:
		btst	#Frantic_Blackout,($FFFFFF93).w
		rts
; ---------------------------------------------------------------------------

StateCheck_Yes:	moveq #-1,d0
		rts
StateCheck_No:	moveq #0,d0
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to update and save game progression
; ---------------------------------------------------------------------------

Set_DoorOpen:
		; d0 = door bit index we want to open
		bset	d0,($FFFFFF8A).w	; unlock door (casual, but also in frantic)
		frantic				; are we in frantic?
		beq.s	@end			; if not, branch
		bset	d0,($FFFFFF8B).w	; unlock door (frantic only)
@end:		rts
; ---------------------------------------------------------------------------

Set_BaseGameDone:
		bset	#Casual_BaseGame,($FFFFFF93).w	; you have beaten the base game in casual, congrats
		frantic					; or was it acutally in frantic?
		beq.s	@end				; nah? that's a shame
		bset	#Frantic_BaseGame,($FFFFFF93).w	; you have beaten the base game in frantic, mad respect
@end:		rts
; ---------------------------------------------------------------------------

Set_BlackoutDone:
		bsr	Set_BaseGameDone		; also set base game beaten state, just in case
		bset	#Casual_Blackout,($FFFFFF93).w	; you have beaten the blackout challenge in casual, congrats
		frantic					; or was it acutally in frantic?
		beq.s	@end				; nah? that's a shame
		bset	#Frantic_Blackout,($FFFFFF93).w	; you have beaten the base game in frantic, mad respect
@end:		rts
; ---------------------------------------------------------------------------
; ===========================================================================

