; ===========================================================================
; ---------------------------------------------------------------------------
; Exit Logic - All the code that takes care of game progression
; ---------------------------------------------------------------------------
; Overview of this mess:
; - Exit_Level: called from Obj0D after it spins a while and special stages
; - Exit_GiantRing: called from within Obj4B after it moved off screen
; ---------------------------------------------------------------------------
; BOOT
; Sega Screen > Selbi Screen > Title Screen > GameplayStyleScreen/Chapter Screen
; 
; FIRST START
; GameplayStyleScreen > One Hot Day... > Story Screen > Ring Load > Chapter Screen > Uberhub > Chapter Screen > Level
; 
; MAIN LEVEL CYCLE
; Uberhub > Chapter Screen > Level > Story Screen > Uberhub
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Universal "return to the hubworld" subroutines
; ---------------------------------------------------------------------------

ReturnToUberhub:
		; instantly
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts				; return to MainGameLoop

ReturnToUberhub_Chapter:
		; show chapter screen first
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
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
		rts

@startspecial:
		; special stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Various screen exiting routines
; ---------------------------------------------------------------------------

Exit_SegaScreen:
		move.b	#$1C,($FFFFF600).w	; set to Selbi splash screen
		rts
; ===========================================================================


Exit_SelbiSplash:
		move.b	#4,($FFFFF600).w	; set to title screen
		rts
; ===========================================================================

Exit_TitleScreen:
		tst.b	d0			; d0 = 0 resume from savegame / 1 first time playing
		beq.w	ReturnToUberhub_Chapter	; always show chapter screen when returning to Uberhub on launch
		move.b	#$30,($FFFFF600).w	; for the first time, set to Gameplay Style Screen (which then starts the intro cutscene)
		rts
; ===========================================================================

Exit_GameplayStyleScreen:
		tst.b	d0			; d0 = 0 options / 1 intro sequence
		bne.w	HubRing_IntroStart	; on first start, start intro cutscene
		move.b	#$24,($FFFFF600).w	; we came from the options menu, return to it
		rts
; ===========================================================================

Exit_OptionsScreen:
		tst.b	d0			; d0 = 0 Uberhub / 1 GameplayStyleScreen
		beq.w	ReturnToUberhub		; return to Uberhub if we exited the screen
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen if we chose that option
		rts
; ===========================================================================

Exit_ChapterScreen:
		cmpi.w	#$001,($FFFFFE10).w	; were we sent here by the end of the intro sequence?
		beq.w	ReturnToUberhub		; if yes, return to Uberhub
		bra.w	StartLevel		; start level set in FE10 normally
; ===========================================================================

Exit_StoryScreen:
		; d0 = screen ID from StoryScreen.asm
		cmpi.b	#8,d0			; is this the ending sequence?
		bne.s	@checkblackout		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts
@checkblackout:
		cmpi.b	#9,d0			; is this the end of the blackout challenge?
		bne.s	@exitregular		; if not, branch
		move.b	#$00,($FFFFF600).w	; set to sega screen ($00)
		rts

@exitregular:
		btst	#2,($FFFFFF92).w	; is Skip Uberhub Place enabled?
		bne.w	SkipUberhub		; if yes, automatically go to the next level in order
		cmpi.b	#1,d0			; is this the intro dialouge?
		beq.w	ReturnToUberhub_Chapter	; if yes, make sure we run the chapter screen in case this was the first start
		bra.w	ReturnToUberhub		; otherwise, return to Uberhub instantly
; ===========================================================================

Exit_CreditsScreen:
		moveq	#$E,d0			; load FZ pallet (cause tutorial boxes are built into SBZ)
		jsr	PalLoad2		; load pallet

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
		move.b	#$00,($FFFFF600).w	; restart game from Sega Screen
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Cutscene exit routines
; ---------------------------------------------------------------------------

Exit_ChapterScreen_StartIntro:
		move.b	#$95,d0			; play intro cutscene music
		jsr	PlaySound
		move.w	#$001,($FFFFFE10).w	; load intro cutscene
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_IntroCutscene:
		move.b	#$20,($FFFFF600).w	; set screen mode to story text screens
		move.b	#1,($FFFFFF9E).w	; set number for text to 1 (this also controls the start of the intro cutscene itself)
		rts
; ===========================================================================

Exit_BombMachineCutscene:
		move.w	#$301,($FFFFFE10).w	; set level to Scar Night Place
		bra.w	StartLevel		; start level
; ===========================================================================

Exit_EndingSequence:
		move.b	#$2C,($FFFFF600).w	; set scene to $2C (new credits)
		move.w	#0,($FFFFFFF4).w	; set credits index number to 0
		move.w	#1,($FFFFFE02).w	; restart level
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Routine to show chapter screen or go straight to level
; ---------------------------------------------------------------------------

MakeChapterScreen:
		btst	#1,($FFFFFF92).w	; is "Skip Story Screens" enabled?
		bne.w	StartLevel		; if yes, start level straight away

		jsr	FakeLevelID		; get fake level ID for current level
		tst.b	d5			; did we get a valid ID?
		bmi.w	StartLevel		; if not, something has gone terribly wrong

		cmp.b	($FFFFFFA7).w,d5	; compare currently saved chapter number to fake level ID
		bls.w	StartLevel		; if this is a chapter from a level we already visited, skip chapter screen
		move.b	d5,($FFFFFFA7).w	; we've entered a new level, update progress chapter ID
		move.b	#$28,($FFFFF600).w	; run chapter screen
		rts


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
		cmpi.w	#$302,($FFFFFE10).w	; is this the easter egg ring in Star Agony Place?
		beq.w	MiscRing_SAP		; if yes, branch
		cmpi.b	#$5,($FFFFFE10).w	; is this the a ring in the tutorial/finalor?
		beq.w	MiscRing_TutorialFP	; if yes, branch

		bra.w	ReturnToUberhub		; otherwise something went wrong, return to Uberhub as fallback
; ===========================================================================

Exit_UberhubRing:
		tst.b	d0			; test ring ID we jumped into
		beq.w	ReturnToUberhub		; if it's zero, something has gone wrong, return to Uberhub as fallback
		bmi.s	@miscring		; if it's negative, it's a misc ring ($81-$83), use alternate table
		subq.b	#1,d0			; make d0 zero-based
		add.w	d0,d0
		move.w	GRing_Exits(pc,d0.w),d0
		jmp	GRing_Exits(pc,d0.w)

@miscring:	andi.w	#$0F,d0			; make d0 positive
		subi.b	#1,d0
		add.w	d0,d0
		move.w	GRing_Misc(pc,d0.w),d0
		jmp	GRing_Misc(pc,d0.w)

; ===========================================================================
GRing_Exits:	dc.w	HubRing_NHP-GRing_Exits
		dc.w	HubRing_GHP-GRing_Exits
		dc.w	HubRing_SP-GRing_Exits
		dc.w	HubRing_RP-GRing_Exits
		dc.w	HubRing_LP-GRing_Exits
		dc.w	HubRing_UP-GRing_Exits
		dc.w	HubRing_SNP-GRing_Exits
		dc.w	HubRing_SAP-GRing_Exits
		dc.w	HubRing_FP-GRing_Exits
		
		; TODO: move these to misc
		dc.w	HubRing_Ending-GRing_Exits
		dc.w	HubRing_IntroStart-GRing_Exits
; ---------------------------------------------------------------------------
GRing_Misc:	dc.w	HubRing_Options-GRing_Misc
		dc.w	HubRing_Tutorial-GRing_Misc
		dc.w	HubRing_Blackout-GRing_Misc
; ===========================================================================

HubRing_NHP:	move.w	#$000,($FFFFFE10).w	; set level to GHZ1
		bra.w	StartLevel

HubRing_GHP:	move.w	#$002,($FFFFFE10).w	; set level to GHZ3
		bra.w	StartLevel

HubRing_SP:	move.w	#$300,($FFFFFE10).w	; set level to Special Stage
		clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		bra.w	MakeChapterScreen

HubRing_RP:	move.w	#$200,($FFFFFE10).w	; set level to MZ1
		bra.w	MakeChapterScreen

HubRing_LP:	move.w	#$101,($FFFFFE10).w	; set level to LZ2
		bra.w	MakeChapterScreen

HubRing_UP:	move.w	#$401,($FFFFFE10).w	; set level to Special Stage 2
		clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		bra.w	MakeChapterScreen

HubRing_SNP:	move.w	#$301,($FFFFFE10).w	; set level to SLZ2
		frantic				; are we in frantic?
		beq.w	MakeChapterScreen	; big boy bombs only in big boy game modes
		move.w	#$500,($FFFFFE10).w	; start bomb machine cutscene
		bra.w	MakeChapterScreen

HubRing_SAP:	move.w	#$302,($FFFFFE10).w	; set level to SLZ3
		bra.w	MakeChapterScreen

HubRing_FP:	move.w	#$502,($FFFFFE10).w	; set level to FZ
		bra.w	MakeChapterScreen
; ---------------------------------------------------------------------------

HubRing_IntroStart:
		move.w	#$001,($FFFFFE10).w	; set to intro cutscene
		move.b	#$28,($FFFFF600).w	; load chapters screen for intro cutscene (One Hot Day...)
		rts

HubRing_Ending:
		move.b	#$20,($FFFFF600).w	; load info screen
		move.b	#8,($FFFFFF9E).w	; set number for text to 8
		move.b	#$9D,d0			; play ending sequence music
		jmp	PlaySound

HubRing_Options:
		move.b	#$24,($FFFFF600).w	; load options menu
		rts

HubRing_Tutorial:
		move.w	#$501,($FFFFFE10).w	; set level to SBZ2
		bra.w	StartLevel

HubRing_Blackout:
		move.w	#$401,($FFFFFE10).w	; set level to Special Stage 2 Easter
		move.b	#1,($FFFFFF5F).w	; set blackout special stage flag
		bra.w	StartLevel
; ---------------------------------------------------------------------------

MiscRing_IntroEnd:
		move.b	#1,($FFFFFF9E).w	; set number for text to 1
		move.b	#$20,($FFFFF600).w	; set screen mode to info screen
		rts

MiscRing_SAP:
		move.b	#$20,($FFFFF600).w	; load info screen
		move.b	#9,($FFFFFF9E).w	; set number for text to 9
		move.b	#$9D,d0			; play ending sequence music (cause it fits for the easter egg lol)
		jmp	PlaySound

MiscRing_TutorialFP:
		tst.b	(FZEscape).w		; is this also the Finalor escape sequence?
		beq.s	Exit_Level		; if not, just exit
		move.l	a0,-(sp)		; backup to stack
		move.w	#$DD,d0			; play one last big boom sound for good measure
		jsr	PlaySound_Special
		jsr	Pal_MakeWhite		; make white flash
		move.l (sp)+,a0			; restore from stack
		; hooray you've escaped, go to Exit_Level

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

GTA_Tutorial:	btst	#2,($FFFFFF92).w	; is Skip Uberhub Place enabled?	
		beq.w	ReturnToUberhub		; if not, return to Uberhub
		bra.w	HubRing_NHP		; otherwise go straight to NHP

GTA_NHPGHP:	moveq	#0,d0			; unlock first door
		bsr	Set_DoorOpen
		move.b	#2,($FFFFFF9E).w	; set number for text to 2
		bra	Exit_RunStory

GTA_SP:		moveq	#1,d0			; unlock second door
		bsr	Set_DoorOpen
		move.b	#3,($FFFFFF9E).w	; set number for text to 3
		bra	Exit_RunStory

GTA_RP:		moveq	#2,d0			; unlock third door
		bsr	Set_DoorOpen
		move.b	#4,($FFFFFF9E).w	; set number for text to 4
		bra	Exit_RunStory

GTA_LP:		moveq	#3,d0			; unlock fourth door
		bsr	Set_DoorOpen
		move.b	#5,($FFFFFF9E).w	; set number for text to 5
		bra	Exit_RunStory

GTA_UP:		moveq	#4,d0			; open fifth door
		bsr	Set_DoorOpen
		move.b	#6,($FFFFFF9E).w	; set number for text to 6
		bra	Exit_RunStory

GTA_SNPSAP:	moveq	#5,d0			; unlock sixth door
		bsr	Set_DoorOpen
		move.b	#7,($FFFFFF9E).w	; set number for text to 7
		bra	Exit_RunStory

GTA_FP:		moveq	#6,d0			; unlock seventh door (door to the credits)
		bsr	Set_DoorOpen
		btst	#2,($FFFFFF92).w	; is Skip Uberhub Place enabled?		
		beq.w	ReturnToUberhub		; if not, return to Uberhub
		bra.w	HubRing_Ending		; otherwise go straight to the ending

GTA_Blackout:	clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		move.b	#9,($FFFFFF9E).w	; set number for text to 9 instead
		bra	Exit_RunStory
; ---------------------------------------------------------------------------

Exit_RunStory:
		move.b	($FFFFFF9E).w,d0	; move story ID to d0
		btst	#1,($FFFFFF92).w	; is "Skip Story Screens" enabled?
		bne.w	Exit_StoryScreen	; if yes, well, skip it
		move.b	#$20,($FFFFF600).w	; set to Story Screen
		rts				; return

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
		bra.w	MakeChapterScreen	; start the level, potentially play a chapter screen

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
; ---------------------------------------------------------------------------
; bit indices in the progress RAM (FF8A/FF8B)
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

StateCheck_Yes:	moveq #0,d0
		rts
StateCheck_No:	moveq #-1,d0
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines to update and save game progression
; ---------------------------------------------------------------------------

Set_DoorOpen:
		bset	d0,($FFFFFF8A).w	; unlock door (casual, but also in frantic)
		frantic				; are we in frantic?
		beq.s	@end			; if not, branch
		bset	d0,($FFFFFF8B).w	; unlock door (frantic only)
@end:		jmp	SRAM_SaveNow		; save
; ---------------------------------------------------------------------------

Set_BaseGameDone:
		bset	#Casual_BaseGame,($FFFFFF93).w	; you have beaten the base game in casual, congrats
		frantic					; or was it acutally in frantic?
		beq.s	@save				; nah? that's a shame
		bset	#Frantic_BaseGame,($FFFFFF93).w	; you have beaten the base game in frantic, mad respect
@save:		jmp	SRAM_SaveNow			; save
; ---------------------------------------------------------------------------

Set_BlackoutDone:
		bset	#Casual_Blackout,($FFFFFF93).w	; you have beaten the blackout challenge in casual, congrats
		frantic					; or was it acutally in frantic?
		beq.s	@save				; nah? that's a shame
		bset	#Frantic_Blackout,($FFFFFF93).w	; you have beaten the base game in frantic, mad respect
@save:		bsr	Set_BaseGameDone		; also set base game beaten state, just in case
		jmp	SRAM_SaveNow			; save
; ---------------------------------------------------------------------------
; ===========================================================================
