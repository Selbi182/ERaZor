; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------
Options_Blank = $29 ; blank character, high priority
OptionsBuffer equ $FFFFC900 ; $200 bytes
DeleteCounter equ $FFFFFF9C
DeleteCounts = 3
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		VBlank_SetMusicOnly

		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		VBlank_UnsetMusicOnly

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram ; fill object RAM ($D000-$EFFF) with $0

		jsr	Pal_FadeFrom

		VBlank_SetMusicOnly
		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F
@loadtextart:	move.w	(a5)+,(a6)
		dbf	d1,@loadtextart ; load uncompressed text patterns

		move.l	#$64000002,4(a6)
		lea	(ArtKospM_ERaZorNoBG).l,a0
		jsr	KosPlusMDec_VRAM
		VBlank_UnsetMusicOnly

		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$11E,obX(a0)		; set X-position
		move.w	#$87,obScreenY(a0)	; set Y-position
		bset	#7,obGfx(a0)		; otherwise make object high plane
		
		jsr	ObjectsLoad
		jsr	BuildSprites

		move.b	#$86,d0		; play Options screen music (Spark Mandrill)
		jsr	PlaySound_Special
		bsr	Options_LoadPal
		move.b	#9,($FFFFFF9E).w ; BG pal
  
		bra.s	Options_ContinueSetup
	
; ---------------------------------------------------------------------------
Options_LoadPal:
		moveq	#2,d0		; load level select palette
		jsr	PalLoad1

		movem.l	d0-a2,-(sp)		; backup d0 to a2
		lea	(Pal_ERaZorBanner).l,a1	; set ERaZor banner's palette pointer
		lea	($FFFFFBA0).l,a2	; set palette location
		moveq	#7,d0			; set number of loops to 7
@0:		move.l	(a1)+,(a2)+		; load 2 colours (4 bytes)
		dbf	d0,@0			; loop
		movem.l	(sp)+,d0-a2		; restore d0 to a2
		rts
; ---------------------------------------------------------------------------

Options_ClearBuffer:
		moveq	#0,d0
		moveq	#0,d1
		lea	(OptionsBuffer).w,a1	; set location for the text
		move.b	d2,d0			; passed char
		move.b	d0,d1
		rept	3	; turn it into four bytes of the same thing
		rol.l	#8,d1
		or.l	d1,d0
		endr

		move.l	#($200/4)-1,d1		; do it for all 504 chars
@fillblank:	move.l	d0,(a1)+		; put blank character into current spot
		dbf	d1,@fillblank		; loop
		rts
; ---------------------------------------------------------------------------

Options_ContinueSetup:
		move.b	#Options_Blank,d2
		bsr.s	Options_ClearBuffer

		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1
@clearscroll:	move.l	d0,(a1)+
		dbf	d1,@clearscroll ; fill scroll data with 0
		move.l	d0,($FFFFF616).w

		jsr	BackgroundEffects_Setup

 		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
		clr.w	($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w
		move.b	#$81,($FFFFFF84).w

		move.b	#DeleteCounts,(DeleteCounter).w

Options_FinishSetup:
		move.w	#19,($FFFFFF82).w	; set default selected entry to exit
		bsr	OptionsTextLoad		; load options text
		display_enable
		jsr	Pal_FadeTo


; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

OptionsScreen_MainLoop:
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	PLC_Execute

		jsr	BackgroundEffects_Update
		jsr	ERZBanner_PalCycle

		bsr	Options_UpDown
		bsr	Options_SelectedLinePalCycle

		tst.l	PLC_Pointer		; are pattern load cues empty?
		bne.s	OptionsScreen_MainLoop	; if not, branch to avoid visual corruptions

; ---------------------------------------------------------------------------
; All options are kept in a single byte to save space (it's all flags anyway)
; RAM location: $FFFFFF92
;  bit 0 = Extended Camera
;  bit 1 = Skip Story Screens
;  bit 2 = Skip Uberhub Place
;  bit 3 = Cinematic Mode (unlocked after beating the base game)
;  bit 4 = True Inhuman Mode (unlocked after beating the blackout challenge)
;  bit 5 = Gamplay Style (0 - Casual Mode // 1 - Frantic Mode)
;  bit 6 = Cinematic Mode Fuzz
;  bit 7 = [unused]
; ---------------------------------------------------------------------------

Options_HandleChange:
		tst.b	($FFFFF605).w		; was anything at all pressed this frame?
		beq.s	OptionsScreen_MainLoop	; if not, branch

		moveq	#0,d0			; make sure d0 is empty
		move.w	($FFFFFF82).w,d0	; get current selection
		subq.w	#3,d0			; first option starts at line 3
		move.w	OpHandle_Index(pc,d0.w),d0
		jmp	OpHandle_Index(pc,d0.w)
; ===========================================================================
OpHandle_Index:	dc.w	Options_HandleGameplayStyle-OpHandle_Index
		dc.w	Options_HandleExtendedCamera-OpHandle_Index
		dc.w	Options_HandleStoryTextScreens-OpHandle_Index
		dc.w	Options_HandleSkipUberhub-OpHandle_Index
		dc.w	Options_HandleCinematicMode-OpHandle_Index
		dc.w	Options_HandleNonstopInhuman-OpHandle_Index
		dc.w	Options_HandleDeleteSaveGame-OpHandle_Index
		dc.w	Options_HandleSoundTest-OpHandle_Index
		dc.w	Options_HandleExit-OpHandle_Index
; ===========================================================================

Options_HandleGameplayStyle:
		move.b	($FFFFF605).w,d1	; get button presses
	 	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		btst	#6,d1			; is specifically A pressed?
		bne.s	@quicktoggle		; if yes, quick toggle
		moveq	#1,d0			; set to GameplayStyleScreen
		jmp	Exit_OptionsScreen

@quicktoggle:
		bchg	#5,($FFFFFF92).w	; toggle gameplay style
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleExtendedCamera:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#0,($FFFFFF92).w	; toggle extended camera
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleStoryTextScreens:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#1,($FFFFFF92).w	; toggle text screens
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleSkipUberhub:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#2,($FFFFFF92).w	; toggle Uberhub autoskip
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleCinematicMode:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$F8,d1			; is right, A, B, C, or Start pressed? (not left cause it's awkward)
		beq.w	Options_Return		; if not, branch

		tst.w	($FFFFFFFA).w		; is debug mode enabled?
		beq.s	@nodebugunlock		; if not, branch
		cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
		bne.s	@nodebugunlock		; if not, branch
		bchg	#0,($FFFFFF93).w	; toggle base game as beaten to toggle the unlock for cinematic mode
		bclr	#3,($FFFFFF92).w	; make sure option doesn't stay accidentally enabled
		bclr	#6,($FFFFFF92).w	; ''
		bra.w	Options_UpdateTextAfterChange_NoSound
@nodebugunlock:
		jsr	Check_BaseGameBeaten	; has the player beaten the base game?
		bne.s	@cinematidmodeallowed	; if yes, cineamtic mode is allowed
		move.w	#$DA,d0			; play option disallowed sound
		jsr	PlaySound_Special
		bra.w	Options_UpdateTextAfterChange_NoSound

@cinematidmodeallowed:
		btst	#3,($FFFFFF92).w	; was cinematic already enabled?
		bne.s	@chkfuzz		; if yes, branch
		btst	#6,($FFFFFF92).w	; was at least fuzz already enabled?
		bne.s	@both			; if yes, enable both
		bra.s	@normal			; otherwise, enable normal
@chkfuzz:
		btst	#6,($FFFFFF92).w	; was fuzz also enabled?
		bne.s	@off			; if yes, turn both off
		bra.s	@fuzzy			; otherwise, enable fuzzy-only

@off:		bclr	#3,($FFFFFF92).w	; disable cinematic mode
		bclr	#6,($FFFFFF92).w	; disable fuzz
		bra.s	@end
@normal:	bset	#3,($FFFFFF92).w	; enable cinematic mode
		bclr	#6,($FFFFFF92).w	; disable fuzz
		bra.s	@end
@fuzzy:		bclr	#3,($FFFFFF92).w	; disable cinematic mode
		bset	#6,($FFFFFF92).w	; enable fuzz
		bra.s	@end
@both:		bset	#3,($FFFFFF92).w	; enable cinematic mode
		bset	#6,($FFFFFF92).w	; enable fuzz

@end:		bsr	Options_LoadPal
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleNonstopInhuman:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch

		tst.w	($FFFFFFFA).w		; is debug mode enabled?
		beq.s	@nodebugunlock		; if not, branch
		cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
		bne.s	@nodebugunlock		; if not, branch
		bchg	#1,($FFFFFF93).w	; toggle blackout challenge beaten state to toggle the unlock for nonstop inhuman
		bclr	#4,($FFFFFF92).w	; make sure option doesn't stay accidentally enabled
		bra.w	Options_UpdateTextAfterChange_NoSound

@nodebugunlock:
		jsr	Check_BlackoutBeaten	; has the player specifically beaten the blackout challenge?
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
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$F0,d1			; is A, B, C, or Start pressed? (not on left/right because of how delicate it is)
		beq.w	Options_Return		; if not, return

		subq.b	#1,(DeleteCounter).w	; sub one from delete counter
		beq.s	@dodelete		; if we reached zero, rip save file
		move.w	#$DF,d0			; play Jester explosion sound
		jsr	PlaySound_Special
		bra.w	Options_UpdateTextAfterChange_NoSound

@dodelete:
		ints_disable
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

@1		move.b	#2,VBlankRoutine	; run V-Blank
		jsr	DelayProgram		; ''
		bra.s	@delete_fadeoutloop	; loop

@delete_fadeoutend:
		move.b	#1,($A130F1).l		; enable SRAM
		clr.b	($200000+SRAM_Exists).l	; unset the magic number (actual SRAM deletion happens during restart)
		move.b	#0,($A130F1).l		; disable SRAM
		jmp	Init			; restart the game
; ---------------------------------------------------------------------------

SoundTest_Min = $80
SoundTest_Max = $DF
SoundTest_AStep = $10

Options_HandleSoundTest:
		move.w	#$80,d0			; default sound (null)
		move.b	($FFFFF605).w,d1	; get button presses
		move.b	($FFFFFF84).w,d2	; move current sound test ID to d2

@soundtest_checkL:
		btst	#2,d1			; has left been pressed?
		beq.s	@soundtest_checkR	; if not, branch
		subq.b	#1,d2			; decrease sound test ID by 1
		cmpi.b	#SoundTest_Min-1,d2	; is ID below the minimum now?
		bne.w	@soundtest_end		; if not, branch
		move.b	#SoundTest_Max,d2	; reset ID to max
		bra.w	@soundtest_end		; branch

@soundtest_checkR:
		btst	#3,d1			; has right been pressed?
		beq.s	@soundtest_checkA	; if not, branch
		addq.b	#1,d2			; increase sound test ID by 1
		cmpi.b	#SoundTest_Max+1,d2	; is ID above the maximum now?
		bne.w	@soundtest_end		; if not, branch
		move.b	#SoundTest_Min,d2	; reset ID to min
		bra.w	@soundtest_end		; branch

@soundtest_checkA:
		btst	#6,d1			; has A been pressed?
		beq.s	@soundtest_chkb		; if not, branch
		addi.b	#SoundTest_AStep,d2	; increase sound test ID by $10
		cmpi.b	#SoundTest_Max+1,d2	; is ID above the maximum now?
		blt.w	@soundtest_end		; if not, branch
		subi.b	#SoundTest_Max-SoundTest_Min+1,d2 ; restart on the other side
		bra.w	@soundtest_end		; branch

@soundtest_chkb:
		btst	#4,d1			; is button B pressed?
		beq.s	@soundtest_chkplay	; if not, branch
		move.b	#$E4,d0			; set to stop all sound
		bra.s	@soundtest_play		; branch

@soundtest_chkplay:
		andi.b	#$A0,d1			; is C or Start pressed?
		beq.s	@soundtest_end		; if not, branch
		move.b	d2,d0			; set to play the selected sound
		cmpi.b	#$80,d2			; is current song selection ID $80?
		bne.s	@soundtest_play		; if not, branch
		move.b	#$E4,d0			; set to stop all sound (for convenience)
@soundtest_play:
		jsr	PlaySound_Special	; play selected sound

@soundtest_end:
		move.b	d2,($FFFFFF84).w	; update ID
		bra.w	Options_UpdateTextAfterChange_NoSound
; ---------------------------------------------------------------------------

Options_HandleExit:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$F0,d1			; is A, B, C, or Start pressed?
		beq.s	Options_Return		; if not, branch
		
Options_Exit:
		moveq	#0,d2
		bsr.w	Options_ClearBuffer

		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.b	($FFFFFF9A).w
		clr.b	(DeleteCounter).w

		moveq	#0,d0			; clear d0
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	($FFFFFF92).w,($200001).l	; backup options flags
		move.b	#0,($A130F1).l		; disable SRAM

		moveq	#0,d0			; return to Uberhub
		jmp	Exit_OptionsScreen
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
; Subroutine to	change the selected option when pressing up or down
; ---------------------------------------------------------------------------

Options_UpDown:				; XREF: OptionsScreen_MainLoop
		move.w	($FFFFFF82).w,d0	; get current selection
		move.b	($FFFFF605).w,d1	; get button presses
		btst	#0,d1			; is up	pressed?
		beq.s	Options_Down		; if not, check down
		subq.w	#2,d0			; move up 1 selection
		cmpi.w	#3,d0			; did we move to before the first option?
		bge.s	Options_Refresh		; if not, branch
		moveq	#19,d0			; if selection moves below 4, jump to selection 19 (exit)
		bra.s	Options_Refresh		; branch

Options_Down:
		btst	#1,d1			; is down pressed?
		beq.s	Options_NoMove		; if not, branch
		addq.w	#2,d0			; move down 1 selection
		cmpi.w	#19,d0			; did we move past the last option?
		ble.s	Options_Refresh		; if not, branch
		moveq	#3,d0			; if selection moves above 19, jump to selection 4 (first option)

Options_Refresh:
		move.w	d0,($FFFFFF82).w	; set new selection
		bsr	OptionsTextLoad		; refresh text
		move.b	#$D8,d0			; play move sound
		jsr	PlaySound_Special
		
		moveq	#0,d0			; clear d0
		move.b	(DeleteCounter).w,d0	; get current delete counter
		cmpi.b	#DeleteCounts,d0	; did we move off the delete counter with at least one input done?
		beq.s	Options_NoMove		; if not, branch
		move.b	#DeleteCounts,(DeleteCounter).w	; reset delete counter
		bsr	OptionsTextLoad		; refresh text

Options_NoMove:
		rts	
; ===========================================================================

Options_SelectedLinePalCycle:
		moveq	#0,d1
		lea	($FFFFFB40-6*2).w,a2
		jmp	GenericPalCycle_Red
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load the Options menu text
; ---------------------------------------------------------------------------
Options_VRAM = $E570
Options_VRAM_Red = $C570
Options_VDP = $600C0003

Options_LineCount = 22
Options_LineLength = 24
Options_Padding = 2
Options_LineLengthTotal = Options_LineLength + (Options_Padding * 2)

blankline macro lines
		rept	\lines
		move.l	d4,4(a6)
		rept	Options_LineLengthTotal
		move.w	#Options_VRAM+Options_Blank,(a6)
		endr
		addi.l	#$800000,d4
		endr
		endm
; ---------------------------------------------------------------------------

OptionsTextLoad:				; XREF: TitleScreen
		bsr	GetOptionsText

		lea	($FFFFC900).w,a1	; get preloaded text buffer	
		lea	($C00000).l,a6
		move.l	#Options_VDP,d4		; screen position (text)

		VBlank_SetMusicOnly
		
		; prefill top with non-shadowy blank tiles
		blankline 4

		; write text to buffer
		move.w	#Options_VRAM,d3	; VRAM setting
		moveq	#Options_LineCount-1,d1		; number of lines of text
@writeline:	
		move.l	d4,4(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
		bsr	Options_WriteLine
		move.w	#Options_VRAM+Options_Blank,(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
@1:
		addi.l	#$800000,d4
		dbf	d1,@writeline
		
		; postfill bottom with non-shadowy blank tiles
		blankline 2

		VBlank_UnsetMusicOnly
		rts	
; End of function OptionsTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Options_WriteLine:				; XREF: OptionsTextLoad
		moveq	#Options_LineLength-1,d2

Options_WriteLine2:
		moveq	#0,d0
		move.b	(a1)+,d0		; is text set to use the red font?
		bpl.s	OWL_WriteNoHighlight	; if not, render default

		cmpi.b	#$FF,d0			; reached end of list?
		beq.s	OWL_End			; if yes, branch

		move.w	#Options_VRAM_Red,d3	; red palette line
		andi.b	#$7F,d0
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,Options_WriteLine2

OWL_End:
		rts	
; ===========================================================================

OWL_WriteNoHighlight:				; XREF: Options_WriteLine
		move.w	#Options_VRAM,d3	; default palette line
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,Options_WriteLine2
		rts	
; End of function Options_WriteLine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the options text completely at once.
; ---------------------------------------------------------------------------

GetOptionsText:
		lea	($FFFFC900).w,a1		; set destination
		moveq	#0,d1				; use $FF as ending of the list

		lea	(OpText_Header1).l,a2		; set text location
		moveq	#-1,d2
		bsr.w	Options_Write			; write text

		lea	(OpText_Header2).l,a2		; set text location
		moveq	#-1,d2
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength*2,a1	; make two empty lines

		lea	(OpText_GameplayStyle).l,a2	; set text location
		moveq	#1,d2
		bsr.w	Options_Write			; write text
		moveq	#1,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_Extended).l,a2		; set text location
		moveq	#2,d2
		bsr.w	Options_Write			; write text
		moveq	#2,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_SkipStory).l,a2		; set text location
		moveq	#3,d2
		bsr.w	Options_Write			; write text
		moveq	#3,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_SkipUberhub).l,a2	; set text location
		moveq	#4,d2
		bsr.w	Options_Write			; write text
		moveq	#4,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line

		move.l	#OpText_CinematicMode_Locked,d6	; set locked text location	
		jsr	Check_BaseGameBeaten		; has the player beaten base game?
		beq.s	@basegamenotbeaten		; if not, branch
		move.l	#OpText_CinematicMode,d6	; set unlocked text location
@basegamenotbeaten:
		movea.l	d6,a2				; set text location
		moveq	#5,d2
		bsr.w	Options_Write			; write text
		moveq	#5,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		moveq	#5,d2
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		move.l	#OpText_NonstopInhuman_Locked,d6; set locked text location	
		jsr	Check_BlackoutBeaten		; has the player specifically beaten the blackout challenge?
		beq.s	@blackoutchallengenotbeaten	; if not, branch
		move.l	#OpText_NonstopInhuman,d6	; set unlocked text location
@blackoutchallengenotbeaten:
		movea.l	d6,a2				; set text location
		moveq	#6,d2
		bsr.w	Options_Write			; write text
		moveq	#6,d2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		moveq	#6,d2
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line

		lea	(OpText_DeleteSRAM).l,a2	; set text location
		moveq	#7,d2
		bsr.w	Options_Write			; write text
		moveq	#7,d2
		bsr.w	GOT_ChkOption			; get state of deletion
		moveq	#7,d2
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line

		lea	(OpText_SoundTest).l,a2		; set text location
		moveq	#8,d2
		bsr.w	Options_Write			; write text
		move.b	#$0D,-3(a1)			; write < before the ID
		move.b	#$0E,2(a1)			; write > after the ID
		bsr	Options_SoundTestID		; write the sound test ID
		adda.w	#3,a1				; adjust for the earlier sound test offset

		adda.w	#Options_LineLength*2,a1	; make two empty lines

		lea	(OpText_Exit).l,a2		; set text location
		moveq	#9,d2
		bsr.w	Options_Write			; write text
; ---------------------------------------------------------------------------

		; make currently selected line red
		lea	($FFFFC900+Options_LineLength).w,a1	; set location
		move.w	($FFFFFF82).w,d5			; get current selection
		cmpi.w	#19,d5					; are we on the exit line?
		bne.s	@0					; if not, branch
		addq.w	#1,d5					; adjust for exit line
@0:
		bsr.s	Options_HighlightLine			; apply highlight
		rts						; return
; ===========================================================================

Options_HighlightLine:
		mulu.w	#Options_LineLength,d5			; multiply by line length
		adda.w	d5,a1
		moveq	#Options_LineLength-1,d2
@redline:	ori.b	#$80,(a1)+				; mark line to use red
		dbf	d2,@redline
		rts
; ===========================================================================

; write the sound test ID ($FFFFFF84) at offset -1(a1)
Options_SoundTestID:
		moveq	#0,d0
		move.b	($FFFFFF84).w,d0		; get sound test ID
		lsr.b	#4,d0				; swap first and second short
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip1			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)
GOT_Snd_Skip1:	move.b	d0,-1(a1)			; set result to first digit ("8" 1)

		move.b	($FFFFFF84).w,d0		; get sound test ID
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip2			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)
GOT_Snd_Skip2:	move.b	d0,0(a1)			; set result to second digit (8 "1")

		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the text given in the input (a2), into the given
; location (a1). Write until $FF, unless a value has been given (d1).
; Line will be highlighted if d2 negative.
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
		move.b	#Options_Blank,d0	; write a space char to a1
		bra.s	OW_DoWrite		; skip

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
		cmpi.b	#'-',d0			; is current character a "-"?
		bne.s	OW_NotHyphen		; if not, branch
		move.b	#$0B,d0			; set correct value for "-"
		bra.s	OW_DoWrite		; skip

OW_NotHyphen:
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
		tst.b	d2			; is highlighting enabled?
		bpl.s	OW_NoHighlight		; if not, branch
		ori.b	#$80,d0			; apply highlight
OW_NoHighlight:
		move.b	d0,(a1)+		; write output to a1
		moveq	#0,d0			; clear d0
		bra.w	Options_Write		; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an option is ON or OFF and set result to a2.
; ---------------------------------------------------------------------------

GOT_ChkOption:
		subq.w	#1,d2
		add.w	d2,d2
		move.w	GOT_Index(pc,d2.w),d2
		jmp	GOT_Index(pc,d2.w)
; ===========================================================================
GOT_Index:	dc.w	GOTCO_CasualFrantic-GOT_Index
		dc.w	GOTCO_ExtendedCamera-GOT_Index
		dc.w	GOTCO_SkipStoryScreens-GOT_Index
		dc.w	GOTCO_SkipUberhub-GOT_Index
		dc.w	GOTCO_CinematicMode-GOT_Index
		dc.w	GOTCO_NonstopInhuman-GOT_Index
		dc.w	GOTCO_DeleteSaveGame-Got_Index
		dc.w	GOTCO_SoundTest-GOT_Index
; ===========================================================================

GOTCO_CasualFrantic:
		lea	(OpText_Casual).l,a2		; use "CASUAL" text
		btst	#5,($FFFFFF92).w		; is Gameplay Style set to Frantic?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_Frantic).l,a2		; otherwise use "FRANTIC" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ExtendedCamera:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#0,($FFFFFF92).w		; is Extended Camera enabled?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SkipStoryScreens:
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		btst	#1,($FFFFFF92).w		; is Skip Story Screens enabled?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SkipUberhub:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#2,($FFFFFF92).w		; is Skip Uberhub enabled?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_CinematicMode:
		lea	(OpText_CinOff).l,a2		; use cinematic mode "OFF" text

		btst	#3,($FFFFFF92).w		; is Cinematic Mode enabled?
		beq.s	@chkfuzz			; if not, branch
		lea	(OpText_CinNorm).l,a2		; use cinematic mode "NORMAL" text
		btst	#6,($FFFFFF92).w		; is fuzz also enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_CinBoth).l,a2		; use cinematic mode "BOTH" text
		rts

@chkfuzz:
		btst	#6,($FFFFFF92).w		; is fuzz enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_CinFuzz).l,a2		; use cinematic mode "FUZZY" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_NonstopInhuman:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#4,($FFFFFF92).w		; is Nonstop Inhuman enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_DeleteSaveGame:
		moveq	#0,d0
		move.b	(DeleteCounter).w,d0
		cmpi.b	#1,d0
		beq.s	@del1
		cmpi.b	#2,d0
		beq.s	@del2

@del3:
		lea	(OpText_Del3).l,a2		; >>>
		rts
@del2:
		lea	(OpText_Del2).l,a2		; >>
		rts
@del1:
		lea	(OpText_Del1).l,a2		; >
		rts
; ---------------------------------------------------------------------------

GOTCO_SoundTest:
		lea	(OpText_SoundTestDefault).l,a2	; use default sound test text
		rts
; ---------------------------------------------------------------------------

GOTCO_Return:
		rts					; return
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Options Text
; ---------------------------------------------------------------------------

OpText_Header1:
		dc.b	'<---------------------->', $FF
		even

OpText_Header2:
		dc.b	'      CHANGE STUFF      ', $FF
		even
; ---------------------------------------------------------------------------

OpText_GameplayStyle:
		dc.b	'GAMEPLAY STYLE   ', $FF
		even
		
OpText_Extended:
		dc.b	'EXTENDED CAMERA      ', $FF
		even

OpText_SkipStory:
		dc.b	'SKIP STORY SCREENS   ', $FF
		even

OpText_SkipUberhub:
		dc.b	'SKIP UBERHUB PLACE   ', $FF
		even

OpText_CinematicMode:
		dc.b	'CINEMATIC MODE  ', $FF
		even
OpText_CinematicMode_Locked:
		dc.b	'????????? ????  ', $FF
		even
		
OpText_NonstopInhuman:
		dc.b	'TRUE INHUMAN MODE    ', $FF
		even
OpText_NonstopInhuman_Locked:
		dc.b	'???? ??????? ????    ', $FF
		even

OpText_DeleteSRAM:
		dc.b	'DELETE SAVE GAME     ', $FF
		even
OpText_Del3:	dc.b	'>>>', $FF
		even
OpText_Del2:	dc.b	' >>', $FF
		even
OpText_Del1:	dc.b	'  >', $FF
		even
; ---------------------------------------------------------------------------

OpText_SoundTest:
		dc.b	'SOUND TEST           ', $FF
		even
OpText_SoundTestDefault:
		dc.b	'< 81 >', $FF
		even
; ---------------------------------------------------------------------------

OpText_Exit:	dc.b	'      SAVE OPTIONS      ', $FF
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

OpText_CinOff:	dc.b	'     OFF', $FF
		even
OpText_CinNorm:	dc.b	' TYPICAL', $FF
		even
OpText_CinFuzz:	dc.b	'   FUZZY', $FF
		even
OpText_CinBoth:	dc.b	'    BOTH', $FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
Options_TextArt:
		incbin	Screens\OptionsScreen\Options_TextArt.bin
		even
Options_BGArt:
		incbin	Screens\OptionsScreen\FuzzyBG.kospm
		even
; ---------------------------------------------------------------------------
; ===========================================================================
