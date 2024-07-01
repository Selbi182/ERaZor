; ===========================================================================
; ---------------------------------------------------------------------------
; Overview of this mess:
; - Exit_Level: called from Obj0D after it spins a while
; - Exit_SpecialStage: same as Exit_Level but for special stages
; - Exit_StoryScreen: called when story screen ends (d0 = story ID)
; - Exit_ChapterScreen: called when chapter screen ends (d0 = chapter ID)
; - Exit_GiantRing: called from within Obj4B after it moved off screen
; ---------------------------------------------------------------------------
; BOOT
; Sega Screen > Selbi Screen > Title Screen > GameplayStyleScreen/Chapter Screen
; ---------------------------------------------------------------------------
; FIRST START
; GameplayStyleScreen > One Hot Day... > Story Screen > Ring Load > Chapter Screen > Uberhub > Chapter Screen > Level
; ---------------------------------------------------------------------------
; CYCLE
; Level > Story Screen > Chapter Screen > Level
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
		; potentially show chapter screen first
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		move.b	#$28,($FFFFF600).w	; set to chapters screen
		rts				; return to MainGameLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; Various screen exiting routines
; ---------------------------------------------------------------------------

Exit_SelbiSplash:
		move.b	#4,($FFFFF600).w	; set to title screen
		rts
; ===========================================================================

Exit_TitleScreen:
		tst.b	d0			; d0 = 0 resume from savegame / 1 first time playing
		bne.s	@firsttime
		move.b	#$28,($FFFFF600).w	; set to Chapters Screen
		rts
@firsttime:
		move.b	#$30,($FFFFF600).w	; set to Gameplay Style Screen (which then starts the intro cutscene)
		rts				; return
; ===========================================================================

Exit_OptionsScreen:
		tst.b	d0			; d0 = 0 Uberhub / 1 GameplayStyleScreen
		bne.s	@gss
		jmp	ReturnToUberhub
@gss:
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen
		rts
; ===========================================================================

Exit_GameplayStyleScreen:
		tst.b	d0			; d0 = 0 options / 1 intro sequence
		bne.s	@firsttime
		move.b	#$24,($FFFFF600).w	; we came from the options menu, return to it
		rts
@firsttime:
		move.b	#$28,($FFFFF600).w	; load chapters screen for intro cutscene (One Hot Day...)
		move.w	#$001,($FFFFFE10).w	; set to intro cutscene
		rts
; ===========================================================================

Exit_StoryScreen:
		; d0 = screen ID from StoryScreen.asm
		cmpi.b	#1,d0			; is this the intro dialouge?
		bne.s	@checkend		; if not, branch
		bra	ReturnToUberhub_Chapter	; make sure we run the chapter screen in case this was the first start
@checkend:
		cmpi.b	#8,d0			; is this the ending sequence?
		bne.s	@checkblackout		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts
@checkblackout:
		cmpi.b	#9,d0			; is this the blackout special stage?
		bne.s	@exitregular		; if not, branch
		move.b	#$00,($FFFFF600).w	; set to sega screen ($00)
		rts

@exitregular:
		btst	#2,($FFFFFF92).w	; is Skip Uberhub Place enabled?
		bne.w	AutoSkipUberhub		; if yes, automatically go to the next level in order
		beq.w	ReturnToUberhub		; otherwise, return to Uberhub every time

; ===========================================================================

Exit_EndingSequence:
		move.b	#$2C,($FFFFF600).w ; set scene to $2C (new credits)
		move.w	#0,($FFFFFFF4).w ; set credits index number to 0
		move.w	#1,($FFFFFE02).w	; restart level
		rts

; ===========================================================================

Exit_CreditsScreen:
		addq.w	#4,sp			; skip return address (weird quirk from the credits screen)
		move.b	#$00,($FFFFF600).w	; restart from Sega Screen
		rts

; ===========================================================================
; ===========================================================================

Exit_IntroCutscene:
	;	bsr	ClearEverySpecialFlag	; clear flags
		move.b	#$20,($FFFFF600).w	; set screen mode to $20 (Info Screen)
		move.b	#1,($FFFFFF9E).w	; set number for text to 1
	;	clr.b	($FFFFFFE7).w		; make sure Sonic is not inhuman
		rts

; ===========================================================================

Exit_BombMachineCutscene:
		move.w	#$301,($FFFFFE10).w	; set level to Scar Night Place
		move.b	#$C,($FFFFF600).w
		move.w	#1,($FFFFFE02).w
		rts

; ===========================================================================
; ===========================================================================

; d0 = chapter ID from ChapterScreen.asm
Exit_ChapterScreen:		
StartLevel:
		cmpi.w	#$001,($FFFFFE10).w	; were we sent here by the story screen of the intro sequence?
		beq.w	ReturnToUberhub		; if yes, return to Uberhub

		move.w	#$400,($FFFFFE10).w	; set level to SYZ1 (Uberhub)

		cmpi.b	#2,($FFFFFFA7).w	; is this chapter 2?
		bne.s	CS_ChkChapter3		; if not, branch
		move.w	#$300,($FFFFFE10).w	; use correct stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts

CS_ChkChapter3:
		cmpi.b	#3,($FFFFFFA7).w	; is this chapter 3?
		bne.s	CS_ChkChapter4		; if not, branch
		move.w	#$200,($FFFFFE10).w	; set level to MZ1
		bra.s 	CS_PlayLevel

CS_ChkChapter4:
		cmpi.b	#4,($FFFFFFA7).w	; is this chapter 4?
		bne.s	CS_ChkChapter5		; if not, branch
		move.w	#$101,($FFFFFE10).w	; set level to LZ2
		bra.s 	CS_PlayLevel

CS_ChkChapter5:
		cmpi.b	#5,($FFFFFFA7).w	; is this chapter 5?
		bne.s	CS_ChkChapter6		; if not, branch
		move.w	#$401,($FFFFFE10).w	; use correct stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts
CS_ChkChapter6:
		cmpi.b	#6,($FFFFFFA7).w	; is this chapter 6?
		bne.s	CS_ChkChapter7		; if not, branch
		move.w	#$500,($FFFFFE10).w	; set level to SBZ1
		bra.s 	CS_PlayLevel

CS_ChkChapter7:
		cmpi.b	#7,($FFFFFFA7).w	; is this chapter 7?
		bne.s	CS_PlayLevel		; if not, branch
		move.w	#$502,($FFFFFE10).w	; set level to FZ

CS_PlayLevel:
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts
; ===========================================================================

Exit_ChapterScreen_StartIntro:
		move.b	#$95,d0			; play intro cutscene music
		jsr	PlaySound
		move.w	#$001,($FFFFFE10).w	; load intro cutscene
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to unlock the doors in SYZ1 after you finish a normal level

; ($FFFFFF8A).w	- casual
; ($FFFFFF8B).w	- frantic
; Bit 0 = GHZ | SS1
; Bit 1 = SS1 | MZ
; Bit 2 = MZ | LZ
; Bit 3 = LZ | SS2
; Bit 4 = SS2 | SLZ
; Bit 5 = SLZ | FZ
; Bit 6 = FZ | Ending Sequence and credits
; ---------------------------------------------------------------------------

; d0 = 0 exited via Pause+A / 1 beaten legitimately
Exit_Level:				; XREF: Obj3E_EndAct
		tst.b	d0			; was stage exited via Pause+A?
		beq	ReturnToUberhub		; if yes, branch

		cmpi.w	#$002,($FFFFFE10).w	; is level GHZ3?
		bne.s	GTA_ChkMZ1		; if not, branch
		moveq	#0,d0			; unlock first door
		jsr	OpenDoor
		move.b	#2,($FFFFFF9E).w	; set number for text to 2

GTA_ChkMZ1:
		cmpi.w	#$200,($FFFFFE10).w	; is level MZ1?
		bne.s	GTA_ChkLZ2		; if not, branch
		moveq	#2,d0			; unlock third door
		jsr	OpenDoor
		move.b	#4,($FFFFFF9E).w	; set number for text to 4

GTA_ChkLZ2:
		cmpi.w	#$101,($FFFFFE10).w	; is level LZ2?
		bne.s	GTA_ChkSLZ2		; if not, branch
		moveq	#3,d0			; unlock fourth door
		jsr	OpenDoor
		move.b	#5,($FFFFFF9E).w	; set number for text to 5

GTA_ChkSLZ2:
		cmpi.w	#$302,($FFFFFE10).w	; is level SLZ3?
		bne.s	GTA_NoDoor		; if not, branch
		moveq	#5,d0			; unlock fifth door
		jsr	OpenDoor
		move.b	#7,($FFFFFF9E).w	; set number for text to 7

		cmpi.w	#$300,($FFFFFE10).w	; did we beat Special Place?
		beq.s	@spbeaten		; if yes, branch
		cmpi.w	#$401,($FFFFFE10).w	; did we beat Unreal Place/Blackout Challenge?
		beq.s	@upbeaten		; if yes, branch
		bra.w	ReturnToUberhub		; uhh idk how this could ever happen, but just in case

@spbeaten:
		moveq	#1,d0			; open door after Special Place
		jsr	OpenDoor
		move.b	#3,($FFFFFF9E).w	; set number for text to 3
		bra.s	@runinfoscreen

@upbeaten:
		moveq	#4,d0			; open door after Unreal Place
		jsr	OpenDoor
		move.b	#6,($FFFFFF9E).w	; set number for text to 6
		tst.b	($FFFFFF5F).w		; is this the blackout special stage?
		beq.s	@runinfoscreen		; if not, branch
		move.b	#9,($FFFFFF9E).w	; set number for text to 9 instead

@runinfoscreen:
		clr.b	($FFFFFF5F).w		; clear blackout special stage flag
		move.b	#$20,($FFFFF600).w	; set to info screen
		rts
; ===========================================================================




GTA_NoDoor:
		move.b	#$20,($FFFFF600).w	; set to Info Screen
		rts				; return
; End of function GotThroughAct
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ===========================================================================
; ===========================================================================

MakeChapterScreen:
		jsr	FakeLevelID
		tst.b	d5
		bmi.s	MCS_NotSpecial
		cmp.b	($FFFFFFA7).w,d5
		bgt.s	MCS_DoChapter
		cmpi.w	#$301,($FFFFFE10).w	; are we enterting SNP?
		bne.s	@notsnp			; if not, branch
		frantic				; are we in frantic?
		beq.s	@notsnp			; big boy bombs only in big boy game modes
		move.w	#$500,($FFFFFE10).w	; start bomb machine cutscene
		bra.s	MCS_NotSpecial
@notsnp:
		cmpi.w	#$300,($FFFFFE10).w
		beq.s	MCS_Special
		cmpi.w	#$401,($FFFFFE10).w
		bne.s	MCS_NotSpecial

MCS_Special:
		move.b	#$10,($FFFFF600).w
		rts

MCS_NotSpecial:
		move.b	#$C,($FFFFF600).w
		move.w	#1,($FFFFFE02).w
		rts

MCS_DoChapter:
		btst	#1,($FFFFFF92).w		; are story text screens enabled?
		beq.s	@startchapter			; if not, branch
		nop ; here if yes
@startchapter:
		move.b	d5,($FFFFFFA7).w
		move.b	#$28,($FFFFF600).w
		rts


; ===========================================================================
; ===========================================================================
; ===========================================================================


Exit_GiantRing:
		cmpi.b	#$5,($FFFFFE10).w	; is this the tutorial/finalor?
		bne.s	Obj4B_SNZ		; if not, branch
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		tst.b	(FZEscape).w		; is this also the Finalor escape sequence?
		beq.w	Obj4B_PlayLevel		; if not, branch
		jmp	Exit_FinalBoss		; this stuff was originally part of the FZ boss

Obj4B_SNZ:
		cmpi.w	#$302,($FFFFFE10).w	; is this the easter egg ring in Star Agony Place?
		bne.s	Obj4B_ChkGHZ1		; if not, branch
		move.b	#$20,($FFFFF600).w	; load info screen
		move.b	#9,($FFFFFF9E).w	; set number for text to 9
		move.b	#$9D,d0			; play ending sequence music (cause it fits for the easter egg lol)
		jmp	PlaySound

; ---------------------------------------------------------------------------
; Logic specific to intro cutscene

Obj4B_ChkGHZ2:
		cmpi.w	#$001,($FFFFFE10).w	; is level intro cutscene?
		bne.w	Obj4B_ChkGHZ1		; if not, branch

		clr.b	($FFFFFFB8).w
		clr.b	($FFFFFFB7).w
		clr.b	($FFFFFFB6).w
		
		move.b	#1,($FFFFFF9E).w	; set number for text to 1
		move.b	#$20,($FFFFF600).w	; set screen mode to info screen
		rts
; ---------------------------------------------------------------------------
; Uberhub loading logic

Obj4B_ChkGHZ1:
		cmpi.b	#GRing_NightHill,obSubtype(a0)	; is this the ring to Night Hill Place?
		bne.s	Obj4B_ChkGHZ3			; if not, branch
		move.w	#$000,($FFFFFE10).w		; set level to GHZ1
		bra.w	Obj4B_PlayLevel
	
Obj4B_ChkGHZ3:
		cmpi.b	#GRing_GreenHill,obSubtype(a0)	; is this the ring to Green Hill Place?
		bne.s	Obj4B_ChkSpecial1		; if not, branch
		move.w	#$002,($FFFFFE10).w		; set level to GHZ3
		bra.w	Obj4B_PlayLevel

Obj4B_ChkSpecial1:
		cmpi.b	#GRing_Special,obSubtype(a0)		; is this the ring to Special Place?
		bne.s	Obj4B_ChkMZ			; if not, branch
		move.w	#$300,($FFFFFE10).w		; set level to Special Stage
		clr.b	($FFFFFF5F).w			; clear blackout blackout special stage flag
		bsr	MakeChapterScreen

		move.b  #0,($FFFFFFD0).w               ; FUZZY: Let's clear the distortion flag,
		move.b  #0,($FFFFFF64).w               ; and the shake timer.
		lea     ($FFFFCC00).w, a1
		move.w  #224,d3
@ClearScroll:	move.w  #0,(a1)+			; Send AAAA HScroll entry
		dbra    d3,@ClearScroll
		rts

Obj4B_ChkMZ:
		cmpi.b	#GRing_Ruined,obSubtype(a0)	; is this the ring to Ruined Place?
		bne.s	Obj4B_ChkLZ2			; if not, branch
		move.w	#$200,($FFFFFE10).w		; set level to MZ1
		bsr	MakeChapterScreen
		bra.w	Obj4B_PlayLevel

Obj4B_ChkLZ2:
		cmpi.b	#GRing_Labyrinthy,obSubtype(a0)	; is this the ring to Labyrinthy Place?
		bne.s	Obj4B_ChkSpecial2		; if not, branch
		move.w	#$101,($FFFFFE10).w		; set level to LZ2
		bsr	MakeChapterScreen
		bra.w	Obj4B_PlayLevel

Obj4B_ChkSpecial2:
		cmpi.b	#GRing_Unreal,obSubtype(a0)	; is this the ring to Unreal Place?
		bne.s	Obj4B_ChkSLZ2			; if not, branch
		move.w	#$401,($FFFFFE10).w		; set level to Special Stage 2
		clr.b	($FFFFFF5F).w			; clear blackout blackout special stage flag
		bsr	MakeChapterScreen
		rts

Obj4B_ChkSLZ2:
		cmpi.b	#GRing_ScarNight,obSubtype(a0)	; is this the ring to Scar Night Place?
		bne.s	Obj4B_ChkSLZ3			; if not, branch
		move.w	#$301,($FFFFFE10).w		; set level to SLZ2
		bsr	MakeChapterScreen
		bra.w	Obj4B_PlayLevel

Obj4B_ChkSLZ3:
		cmpi.b	#GRing_StarAgony,obSubtype(a0)	; is this the ring to Star Agony Place?
		bne.s	Obj4B_ChkFZ			; if not, branch
		move.w	#$302,($FFFFFE10).w		; set level to SLZ3
		bra.w	Obj4B_PlayLevel

Obj4B_ChkFZ:
		cmpi.b	#GRing_Finalor,obSubtype(a0)	; is this the ring to Finalor Place?
		bne.s	Obj4B_ChkEnding			; if not, branch
		move.w	#$502,($FFFFFE10).w		; set level to FZ
		bsr	MakeChapterScreen
		bra.s	Obj4B_PlayLevel

Obj4B_ChkEnding:
		cmpi.b	#GRing_Ending,obSubtype(a0)	; is this the ring to the ending sequence?
		bne.s	Obj4B_ChkIntro			; if not, branch
		move.b	#$20,($FFFFF600).w		; load info screen
		move.b	#8,($FFFFFF9E).w		; set number for text to 8
		move.b	#$9D,d0				; play ending sequence music
		jmp	PlaySound

Obj4B_ChkIntro:
		cmpi.b	#GRing_Intro,obSubtype(a0)	; is this the ring to the intro sequence?
		bne.s	Obj4B_ChkOptions		; if not, branch
		move.b	#$28,($FFFFF600).w		; load chapters screen for intro cutscene (One Hot Day...)
		move.w	#$001,($FFFFFE10).w		; set to intro cutscene
		rts

Obj4B_ChkOptions:
		cmpi.b	#GRing_Options,obSubtype(a0)	; is this the ring to the options menu?
		bne.s	Obj4B_ChkTutorial		; if not, branch
		move.b	#$24,($FFFFF600).w		; load options menu
		rts

Obj4B_ChkTutorial:
		cmpi.b	#GRing_Tutorial,obSubtype(a0)	; is this the ring to the tutorial?
		bne.s	Obj4B_ChkBlackout		; if not, branch
		move.w	#$501,($FFFFFE10).w		; set level to SBZ2
		bra.w	Obj4B_PlayLevel

Obj4B_ChkBlackout:
		cmpi.b	#GRing_Blackout,obSubtype(a0)	; is this the blackout challenge ring?
		bne.s	Obj4B_Fallback			; if not, branch
		move.w	#$401,($FFFFFE10).w		; set level to Special Stage 2 Easter
		move.b	#1,($FFFFFF5F).w		; set blackout blackout special stage flag
		move.b	#$10,($FFFFF600).w		; set game mode to special stage (needs to be done manually since no chapter screen)
		rts

Obj4B_Fallback:
		move.w	#$400,($FFFFFE10).w		; set level to Uberhub (as fallback; this should never happen)
; ---------------------------------------------------------------------------

Obj4B_PlayLevel:
		cmpi.b	#$28,($FFFFF600).w	
		beq.s	@end
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
@end:
		rts
; ===========================================================================

; Used to be called right after the cutscene after the final boss finishes,
; now it's called from Obj4B
Exit_FinalBoss:
		move.w	#$DD,d0
		jsr	PlaySound_Special

		move.l	a0,-(sp)		; backup to stack
		jsr	Pal_MakeWhite		; make white flash
		move.l (sp)+,a0			; restore from stack

		moveq	#6,d0			; unlock door to the credits
		jsr	OpenDoor
		
		btst	#2,($FFFFFF92).w	; is Skip Uberhub Place enabled?
		bne.s	@straighttoend		; if yes, go directly to ending sequence instead of back to Uberhub
		jsr	ReturnToUberhub
		jmp	DeleteObject

@straighttoend:
		move.b	#$20,($FFFFF600).w	; load info screen
		move.b	#8,($FFFFFF9E).w	; set number for text to 8
		move.b	#$9D,d0			; play ending sequence music
		jmp	PlaySound

; ===========================================================================
; ===========================================================================
; ===========================================================================

AutoSkipUberhub:
		; "Skip Uberhub" option
		move.w	($FFFFFE10).w,d1	; get current level number
		lea	(NextLevel_Array).l,a1	; load the next level array
@autonextlevelloop:
		move.w	(a1)+,d2		; get the current level ID in the list (and increase pointer to next)
		tst.w	d2			; reached end of list?
		bmi.w	ReturnToUberhub		; if yes, fall back to Uberhub
		cmp.w	d1,d2			; does ID in list match with current level?
		bne.s	@autonextlevelloop	; if not, loop
	
		move.w	(a1),($FFFFFE10).w	; write next level in list to level ID RAM
		jmp	MakeChapterScreen	; start the level, potentially play a chapter screen

NextLevel_Array:
		dc.w	$001	; Intro Cutscene
		dc.w	$400	; Uberhub Place
		dc.w	$501	; Tutorial Place
		dc.w	$000	; Night Hill Place
		dc.w	$002	; Green Hill Place
		dc.w	$300	; Special Place (yes, it uses SLZ1's ID)
		dc.w	$200	; Ruined Place
		dc.w	$101	; Labyrinthy Place
		dc.w	$401	; Unreal Place
		dc.w	$301	; Scar Night Place
		dc.w	$302	; Star Agony Place
		dc.w	$502	; Finalor Place
		dc.w	$601	; Ending Sequence
	;	dc.w	$666	; Blackout Challenge
		dc.w	$FFFF	; uhhhhhhhh
		even

