; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	ClearPLC
		jsr	Pal_FadeFrom
		move	#$2700,sr
		jsr	SoundDriverLoad
		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

Options_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,Options_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0

		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F

Options_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Options_LoadText ; load uncompressed text patterns

		move.l	#$64000002,($C00004).l
		lea	(Nem_ERaZor).l,a0
		jsr	NemDec

		jsr	Pal_FadeFrom

		move.b	#$02,($FFFFD100).w	; load ERaZor banner object
		move.w	#$120,($FFFFD108).w	; set X-position
		move.w	#$81,($FFFFD10A).w	; set Y-position
		jsr	ObjectsLoad
		jsr	BuildSprites

		move.b	#$86,d0		; play Options screen music
		jsr	PlaySound_Special
		bsr	Options_LoadPal
		bra.s	Options_ContinueSetup

; ---------------------------------------------------------------------------
Options_LoadPal:
		moveq	#2,d0		; load Options screen pallet
		jsr	PalLoad1
		moveq	#3,d0		; load Options screen pallet
		jsr	PalLoad1
		rts
; ---------------------------------------------------------------------------

Options_ContinueSetup:		
		moveq	#0,d0
		lea	($FFFFCA00).w,a1	; set location for the text
		move.b	#$F0,d0			; put over $F0s
		move.w	#503,d1			; do it for all 504 chars

Options_MakeF0s:
		move.b	d0,(a1)+		; put $FF into current spot
		dbf	d1,Options_MakeF0s	; loop
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
		clr.w	($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w
		clr.w	($FFFFFF9C).w		; previously used to coordinate the intro sequence, now unused
		move.b	#$81,($FFFFFF84).w
		
		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

Options_ClrScroll:
		move.l	d0,(a1)+
		dbf	d1,Options_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1

Options_ClrVram:
		move.l	d0,(a6)
		dbf	d1,Options_ClrVram	; fill	VRAM with 0
		move.w	#19,($FFFFFF82).w	; set default selected entry to exit

		bsr	OptionsTextLoad		; load options text
		display_enable
		jsr	Pal_FadeTo
		bra.w	OptionsScreen_MainLoop

; ===========================================================================

Options_PalCycle:
		; background palette rotation
		jsr	SineWavePalette
	
	
		; ERaZor banner palette rotation
PalLocationO = $FFFFFB20
		move.w	($FFFFF614).w,d0			; load remaining time into d0
		andi.w	#3,d0					; mask it against 3
		bne.s	O_PalSkip_1				; if result isn't 0, branch
		move.w	(PalLocationO+$04).w,d0			; load first blue colour of sonic's palette into d0
		moveq	#7,d1					; set loop counter to 7
		lea	(PalLocationO+$06).w,a1			; load second blue colour into a1

O_PalLoop:
		move.w	(a1),-2(a1)				; move colour to last spot
		adda.l	#2,a1					; increase location pointer
		dbf	d1,O_PalLoop				; loop
		move.w	d0,(PalLocationO+$12).w			; move first colour to last one

O_PalSkip_1:
		move.w	($FFFFF614).w,d0			; load remaining time into d0
		andi.w	#7,d0					; mask it against 7
		bne.s	O_PalSkip_2				; if result isn't 0, branch
		move.w	(PalLocationO+$18).w,d0			; backup first colour of the red
		move.w	(PalLocationO+$1A).w,(PalLocationO+$18).w	; move second colour to first one
		move.w	(PalLocationO+$1C).w,(PalLocationO+$1A).w	; move third colour to second one
		move.w	d0,(PalLocationO+$1C).w			; load first colour into third one

O_PalSkip_2:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
OptionsScreen_MainLoop:
		move.b	#2,($FFFFF62A).w
		jsr	DelayProgram

		tst.w	($FFFFF614).w		; is timer empty?
		bne.s	O_DontResetTimer	; if not, branch
		move.w	#$618,($FFFFF614).w	; otherwise, reset it

O_DontResetTimer:
		bsr	OptionsControls
		jsr	RunPLC_RAM
		
		bsr.w	Options_PalCycle

		tst.l	($FFFFF680).w		; are pattern load cues empty?
		bne.s	OptionsScreen_MainLoop	; if not, branch

; ===========================================================================
; All options are kept in a single byte to save space (it's all flags anyway)
; RAM location: $FFFFFF92
;  bit 0 = Extended Camera
;  bit 1 = Story Text Screens
;  bit 2 = Skip Uberhub Place
;  bit 3 = Cinematic HUD
;  bit 4 = Nonstop Inhuman
;  bit 5 = Gamplay Style (0 - Casual Mode // 1 - Frantic Mode)

Options_HandleChange:
		moveq	#0,d0			; make sure d0 is empty
		move.w	($FFFFFF82).w,d0	; get current selection
; ---------------------------------------------------------------------------

Options_HandleGameplayStyle:
		cmpi.w	#3,d0
		bne.s	Options_HandleExtendedCamera
		move.b	($FFFFF605).w,d1	; get button presses
	 	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
	;	bchg	#5,($FFFFFF92).w	; toggle gameplay style
	;	bra.w	Options_UpdateTextAfterChange
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen
		rts
; ---------------------------------------------------------------------------

Options_HandleExtendedCamera:
		cmpi.w	#5,d0
		bne.s	Options_HandleStoryTextScreens
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#0,($FFFFFF92).w	; toggle extended camera
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleStoryTextScreens:
		cmpi.w	#7,d0
		bne.s	Options_HandleSkipUberhub
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#1,($FFFFFF92).w	; toggle text screens
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleSkipUberhub:
		cmpi.w	#9,d0
		bne.s	Options_HandleCinematicHud
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#2,($FFFFFF92).w	; toggle Uberhub autoskip
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleCinematicHud:
		cmpi.w	#11,d0
		bne.s	Options_HandleNonstopInhuman
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#3,($FFFFFF92).w	; toggle cinematic HUD
		bsr	Options_LoadPal
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleNonstopInhuman:
		cmpi.w	#13,d0	
		bne.s	Options_HandleDeleteSaveGame
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		tst.b	($FFFFFF93).w		; has the player beaten the game?
		bne.s	@nonstopinhumanallowed	; if yes, branch
		move.w	#$DA,d0			; play option disallowed sound
		jsr	PlaySound_Special
		bra.w	Options_UpdateTextAfterChange_NoSound
		
@nonstopinhumanallowed:
		bchg	#4,($FFFFFF92).w	; toggle nonstop inhuman
		clr.b	($FFFFFFE7).w		; make sure inhuman is disabled if this option is as well
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleDeleteSaveGame:
		cmpi.w	#15,d0
		bne.w	Options_HandleSoundTest
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$80,d1			; is Start pressed? (this option only works on start because of how delicate it is)
		beq.w	Options_Return		; if not, return
		
		
		move.w	#90,($FFFFFF82).w	; set fade-out sequence time to 90 frames
@delete_fadeoutloop:
		subq.w	#1,($FFFFFF82).w	; subtract 1 from remaining time
		bmi.s	@delete_fadeoutend	; is time over? end fade-out sequence
		
		jsr	RandomNumber		; get new random number
		lea	($FFFFCC00).w,a1	; load scroll buffer address
		move.w	#223,d2			; do it for all 224 lines
@0		jsr	CalcSine		; further randomize the offset after every line
		move.l	d1,(a1)+		; dump to scroll buffer
		dbf	d2,@0			; repeat
		
		move.w	($FFFFFF82).w,d0	; get remaining time
		andi.w	#7,d0			; only trigger every 7th frame
		bne.s	@1			; is it not a 7th frame?, branch
		jsr	Pal_FadeOut		; partially fade-out palette
		move.b	#$C4,d0			; play explosion sound
		jsr	PlaySound_Special	; ''

@1		move.b	#2,($FFFFF62A).w	; run V-Blank
		jsr	DelayProgram		; ''
		bra.s	@delete_fadeoutloop	; loop


@delete_fadeoutend:
		move.b	#1,($A130F1).l		; enable SRAM
		clr.b	($200000+SRAM_Exists).l	; unset the magic number (actual SRAM deletion happens during restart)
		move.b	#0,($A130F1).l		; disable SRAM
		
		lea	($FFFFD000).w,a1	; get start of object RAM
		moveq	#0,d0			; overwrite everything with 0
		move.w	#$BFF,d1		; $BFF iterations to cover the entirety of the RAM
@clear_ram:	move.l	d0,(a1)+		; clear four bytes of RAM
		dbf	d1,@clear_ram		; clear	the RAM
		jmp	EntryPoint		; restart the game
; ---------------------------------------------------------------------------

Options_HandleSoundTest:
		cmpi.w	#17,d0
		bne.s	Options_HandleExit
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$EC,d1			; is left, right, A, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$A0,d1			; is C or Start pressed?
		beq.s	@soundtest_checkL	; if not, branch
		move.b	($FFFFFF84).w,d0	; move sound test ID to d0
		cmpi.b	#$80,d0			; is this ID $80?
		bne.s	@soundtest_not80	; if not, branch
		move.b	#$E4,d0			; otherwise, make it stop all sound
@soundtest_not80:
		jsr	PlaySound_Special	; play music

@soundtest_checkL:
		btst	#2,($FFFFF605).w	; has left been pressed?
		beq.s	@soundtest_checkR	; if not, branch
		subq.b	#1,($FFFFFF84).w	; decrease sound test ID by 1
		cmpi.b	#$7F,($FFFFFF84).w	; is ID now $7F?
		bne.s	@soundtest_checkR	; if not, branch
		move.b	#$DF,($FFFFFF84).w	; set ID to $DF

@soundtest_checkR:
		btst	#3,($FFFFF605).w	; has right been pressed?
		beq.s	@soundtest_checkA	; if not, branch
		addq.b	#1,($FFFFFF84).w	; increase sound test ID by 1
		cmpi.b	#$E0,($FFFFFF84).w	; is ID now $E0?
		bne.s	@soundtest_checkA	; if not, branch
		move.b	#$80,($FFFFFF84).w	; set ID to $80

@soundtest_checkA:
		btst	#6,($FFFFF605).w	; has A been pressed?
		beq.s	@soundtest_end		; if not, branch
		addi.b	#$10,($FFFFFF84).w	; increase sound test ID by $10
		cmpi.b	#$E0,($FFFFFF84).w	; is ID over or at $E0 now?
		blt.s	@soundtest_end		; if not, branch
		subi.b	#$60,($FFFFFF84).w	; restart on the other side

@soundtest_end:
		bra.w	Options_UpdateTextAfterChange_NoSound
; ---------------------------------------------------------------------------

Options_HandleExit:
		cmpi.w	#19,d0
		bne.s	Options_Return

		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$EC,d1			; is left, right, A, C, or Start pressed?
		beq.s	Options_Return		; if not, branch
		
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.b	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w

		moveq	#0,d0			; clear d0
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	($FFFFFF92).w,($200001).l	; backup options flags
		move.b	#0,($A130F1).l		; disable SRAM

		move.w	#$400,($FFFFFE10).w
		move.b	#$C,($FFFFF600).w	; set screen mode to level ($C)
		rts
; ---------------------------------------------------------------------------

Options_UpdateTextAfterChange:
		move.w	#$D9,d0			; play option toggled sound
		jsr	PlaySound_Special

Options_UpdateTextAfterChange_NoSound:
		bsr	OptionsTextLoad

Options_Return:
		bra.w	OptionsScreen_MainLoop	; return
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to	change what you're selecting in the level select
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


OptionsControls:				; XREF: OptionsScreen_MainLoop
		move.b	($FFFFF605).w,d1
		andi.b	#3,d1		; is up/down pressed and held?
		bne.s	Options_UpDown	; if yes, branch
		subq.w	#1,($FFFFFF80).w ; subtract 1 from time	to next	move
		bpl.s	Options_SndTest	; if time remains, branch

Options_UpDown:
		move.w	#9,($FFFFFF80).w ; reset time delay ($B)
		move.b	($FFFFF604).w,d1
		andi.b	#3,d1		; is up/down pressed?
		beq.s	Options_SndTest	; if not, branch
		move.b	#$D8,d0
		jsr	PlaySound_Special
		move.w	($FFFFFF82).w,d0
		btst	#0,d1		; is up	pressed?
		beq.s	Options_Down	; if not, branch
		subq.w	#2,d0		; move up 1 selection
		cmpi.w	#3,d0
		bge.s	Options_Down
		moveq	#19,d0		; if selection moves below 4, jump to selection	19 (exit)

Options_Down:
		btst	#1,d1		; is down pressed?
		beq.s	Options_Refresh	; if not, branch
		addq.w	#2,d0		; move down 1 selection
		cmpi.w	#19,d0
		ble.s	Options_Refresh
		moveq	#3,d0		; if selection moves above 19,	jump to	selection 4 (first option)

Options_Refresh:
		move.w	d0,($FFFFFF82).w ; set new selection
		bsr	OptionsTextLoad	; refresh text
		rts
; ===========================================================================

Options_SndTest:				; XREF: OptionsControls
		move.b	($FFFFF605).w,d1
		andi.b	#$C,d1		; is left/right	pressed?
		beq.s	Options_NoMove	; if not, branch
		bsr	OptionsTextLoad	; refresh text

Options_NoMove:
		rts	
; End of function OptionsControls

; ---------------------------------------------------------------------------
; Subroutine to load level select text
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


OptionsTextLoad:				; XREF: TitleScreen
		bsr	GetOptionsText
		lea	($FFFFCA00).w,a1		
		lea	($C00000).l,a6
		move.l	#$62100003,d4	; screen position (text)
		move.w	#$E570,d3	; VRAM setting
		moveq	#$14,d1		; number of lines of text

loc2_34FE:				; XREF: OptionsTextLoad
		move.l	d4,4(a6)
		bsr	Options_ChgLine
		addi.l	#$800000,d4
		dbf	d1,loc2_34FE
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
		move.w	d0,d1
		move.l	#$62100003,d4
		lsl.w	#7,d0
		swap	d0
		add.l	d0,d4
		lea	($FFFFCA00).w,a1
		lsl.w	#3,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		adda.w	d1,a1
		move.w	#$C570,d3
		move.l	d4,4(a6)
		
		lea	($FFFFCA00).w,a1	; set location
		move.w	($FFFFFF82).w,d5	; get current selection
		mulu.w	#24,d5			; multiply it by 24 (number of characters per line)
		adda.w	d5,a1			; add result to pointer
		
		bsr	Options_ChgLine
loc2_3550:
		rts	
; End of function OptionsTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Options_ChgLine:				; XREF: OptionsTextLoad
		moveq	#$17,d2		; number of characters per line

loc2_3588:
		moveq	#0,d0
		move.b	(a1)+,d0
		bpl.s	loc2_3598
		move.w	#0,(a6)
		dbf	d2,loc2_3588
		rts	
; ===========================================================================

loc2_3598:				; XREF: Options_ChgLine
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc2_3588
		rts	
; End of function Options_ChgLine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the options text completely at once.
; ---------------------------------------------------------------------------

GetOptionsText:
		lea	($FFFFCA00).w,a1		; set destination
		moveq	#0,d1				; use $FF as ending of the list

		lea	(OpText_Header2).l,a2		; set text location
		bsr.w	Options_Write			; write text
		lea	(OpText_Header1).l,a2		; set text location
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line

		lea	(OpText_GameplayStyle).l,a2	; set text location
		bsr.w	Options_Write			; write text
		moveq	#1,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line
		
		lea	(OpText_Extended).l,a2		; set text location
		bsr.w	Options_Write			; write text
		moveq	#2,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line

		lea	(OpText_StoryTextScreens).l,a2	; set text location
		bsr.w	Options_Write			; write text
		moveq	#3,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line
		
		lea	(OpText_SkipUberhub).l,a2	; set text location
		bsr.w	Options_Write			; write text
		moveq	#4,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line
		
		lea	(OpText_CinematicMode).l,a2	; set text location
		bsr.w	Options_Write			; write text
		moveq	#5,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line
		
		move.l	#OpText_EasterEgg_Locked,d6	; set locked text location	
		tst.b	($FFFFFF93).w			; has the player beaten the game?
		beq.s	@uselockedtext			; if not, branch
		move.l	#OpText_EasterEgg_Unlocked,d6	; set unlocked text location
@uselockedtext:
		movea.l	d6,a2				; set text location
		bsr.w	Options_Write			; write text
		moveq	#6,d2				; set d2 to 4
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#(1*24),a1			; make one empty line

		lea	(OpText_DeleteSRAM).l,a2	; set text location
		bsr.w	Options_Write			; write text

		adda.w	#(1*24+3),a1			; make one empty line + 3 characters (because the delete save option is a one-time action button)

; ---------------------------------------------------------------------------
		lea	(OpText_SoundTest).l,a2		; set text location
		bsr.w	Options_Write			; write text
		
		move.b	#$0D,-3(a1)			; write < before the ID
		move.b	#$0E,2(a1)			; write > after the ID

		move.b	($FFFFFF84).w,d0		; get sound test ID
		lsr.b	#4,d0				; swap first and second short
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip1			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)

GOT_Snd_Skip1:
		move.b	d0,-1(a1)			; set result to first digit ("8" 1)

		move.b	($FFFFFF84).w,d0		; get sound test ID
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip2			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)

GOT_Snd_Skip2:
		move.b	d0,0(a1)			; set result to second digit (8 "1")
; ---------------------------------------------------------------------------

		adda.w	#(1*24+3),a1			; make one empty line and adjust for the earlier sound test offset

		lea	(OpText_Exit).l,a2		; set text location
		bsr.w	Options_Write			; write text

		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the text given in the input (a2), into the given
; location (a1). Write until $FF, unless a value has been given (d1).
; ---------------------------------------------------------------------------

Options_Write:
		move.b	(a2)+,d0		; get current char from a2

		tst.b	d1			; is d1 set?
		bne.s	OW_LimitGiven		; if yes, don't write until $FF, but instead with the input number given

		tst.b	d0			; is current character $FF or $FE?
		bpl.s	OW_NotFF		; if not, branch
		rts				; otherwise, return
; ---------------------------------------------------------------------------

OW_LimitGiven:
		subq.b	#1,d1			; sub 1 from d1
		bne.s	OW_NotFF		; if result isn't 0, contine writing
		rts				; otherwise, return
; ---------------------------------------------------------------------------

OW_NotFF:
		cmpi.b	#' ',d0			; is current character a space?
		bne.s	OW_NotSpace		; if not, branch
		cmpi.b	#4,($FFFFFF98).w	; are the options being written now?
		bne.s	OW_SpaceLoop		; if not, branch
		move.b	#$29,d0			; set correct value for space
		bra.s	OW_DoWrite		; skip

OW_SpaceLoop:
		move.b	#$F0,(a1)+		; write a space char to a1
		cmpi.b	#' ',(a2)+		; is next character a space as well?
		beq.s	OW_SpaceLoop		; if yes, loop until not anymore
		suba.w	#1,a2			; sub 1 from a2
		bra.s	Options_Write		; loop

OW_NotSpace:
		cmpi.b	#'<',d0			; is current character a "<"?
		bne.s	OW_NotLeftArrow		; if not, branch
		move.b	#$0D,d0			; set correct value for "<"
		bra.s	OW_DoWrite		; skip

OW_NotLeftArrow:
		cmpi.b	#'>',d0			; is current character a ">"?
		bne.s	OW_NotRightArrow	; if not, branch
		move.b	#$0E,d0			; set correct value for ">"
		bra.s	OW_DoWrite		; skip

OW_NotRightArrow:
		cmpi.b	#'=',d0			; is current character a "="?
		bne.s	OW_NotEqual		; if not, branch
		move.b	#$0C,d0			; set correct value for "="
		bra.s	OW_DoWrite		; skip

OW_NotEqual:
		cmpi.b	#'-',d0			; is current character a "-"?
		bne.s	OW_NotHyphen		; if not, branch
		move.b	#$0B,d0			; set correct value for "-"
		bra.s	OW_DoWrite		; skip

OW_NotHyphen:
		cmpi.b	#'$',d0			; is current character a "$"?
		bne.s	OW_NotDollar		; if not, branch
		move.b	#$0B,d0			; set correct value for "$"
		bra.s	OW_DoWrite		; skip

OW_NotDollar:
		cmpi.b	#'!',d0			; is current character a "!"?
		bne.s	OW_NotExclam		; if not, branch
		move.b	#$0A,d0			; set correct value for "!"
		bra.s	OW_DoWrite		; skip

OW_NotExclam:
		cmpi.b	#'?',d0			; is current character a "?"?
		bne.s	OW_NotQuestion		; if not, branch
		move.b	#$2A,d0			; set correct value for "?"
		bra.s	OW_DoWrite		; skip

OW_NotQuestion:
		subi.b	#50,d0			; otherwise it's a letter and has to be set to the correct value
		cmpi.b	#9,d0			; is result a number?
		bgt.s	OW_DoWrite		; if not, branch
		addq.b	#2,d0			; otherwise add 2 again

OW_DoWrite:
		move.b	d0,(a1)+		; write output to a1
		moveq	#0,d0			; clear d0
		bra.w	Options_Write		; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an option is ON or OFF and set result to a2.
; ---------------------------------------------------------------------------

GOT_ChkOption:
		cmpi.b	#1,d2				; is d2 set to 1?
		bne.s	GOTCO_ChkExtendedCamera		; if not, branch
		lea	(OpText_Casual).l,a2		; use "CASUAL" text
		btst	#5,($FFFFFF92).w		; is Gameplay Style set to Frantic?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_Frantic).l,a2		; otherwise use "FRANTIC" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkExtendedCamera:
		cmpi.b	#2,d2				; is d2 set to 2?
		bne.s	GOTCO_ChkAutoSkipText		; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#0,($FFFFFF92).w		; is Extended Camera enabled?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkAutoSkipText:
		cmpi.b	#3,d2				; is d2 set to 3?
		bne.s	GOTCO_ChkSkipUberhub		; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#1,($FFFFFF92).w		; is Auto-Skip-Text enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkSkipUberhub:
		cmpi.b	#4,d2				; is d2 set to 4?
		bne.s	GOTCO_ChkCinematicHud		; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#2,($FFFFFF92).w		; is Skip Uberhub enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkCinematicHud:
		cmpi.b	#5,d2				; is d2 set to 5?
		bne.s	GOTCO_ChkEasterEgg		; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#3,($FFFFFF92).w		; is Cinematic HUD enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkEasterEgg:
		cmpi.b	#6,d2				; is d2 set to 6?
		bne.s	GOTCO_SoundTest			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#4,($FFFFFF92).w		; is Nonstop Inhuman enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SoundTest:
		cmpi.b	#7,d2				; is d2 set to 7?
		bne.s	GOTCO_Return			; if not, branch
		lea	(OpText_SoundTestDefault).l,a2	; use default sound test text

GOTCO_Return:
		rts					; return
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Options Text
; ---------------------------------------------------------------------------

OpText_Header1:
		dc.b	'------------------------', $FF
		even

OpText_Header2:
		dc.b	'      OPTIONS MENU      ', $FF
		even
; ---------------------------------------------------------------------------

OpText_GameplayStyle:
		dc.b	'GAMEPLAY STYLE   ', $FF
		even
		
OpText_Extended:
		dc.b	'EXTENDED CAMERA      ', $FF
		even

OpText_StoryTextScreens:
		dc.b	'STORY TEXT SCREENS   ', $FF
		even

OpText_SkipUberhub:
		dc.b	'SKIP UBERHUB PLACE   ', $FF
		even
		
OpText_CinematicMode:
		dc.b	'CINEMATIC MODE       ', $FF
		even
		
OpText_EasterEgg_Locked:
		dc.b	'???????????????      ', $FF
		even

OpText_EasterEgg_Unlocked:
		dc.b	'NONSTOP INHUMAN      ', $FF
		even

OpText_DeleteSRAM:
		dc.b	'DELETE SAVE GAME     ', $FF
		even
; ---------------------------------------------------------------------------

OpText_SoundTest:
		dc.b	'SOUND TEST           ', $FF
		even
OpText_SoundTestDefault:
		dc.b	'< 81 >', $FF
		even
; ---------------------------------------------------------------------------

OpText_Exit:	dc.b	'      EXIT OPTIONS   ', $FF
		even
; ---------------------------------------------------------------------------

OpText_ON:	dc.b	' ON', $FF
		even
OpText_OFF:	dc.b	'OFF', $FF
		even
OpText_Casual:	dc.b	' CASUAL', $FF
		even
OpText_Frantic:	dc.b	'FRANTIC', $FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
Options_TextArt:
		incbin	Screens\OptionsScreen\Options_TextArt.bin
		even
; ---------------------------------------------------------------------------
; ===========================================================================
