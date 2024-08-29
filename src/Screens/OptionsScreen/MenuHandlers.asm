
; ===========================================================================
; ---------------------------------------------------------------------------
; Options screen menu data & handlers
; ---------------------------------------------------------------------------

Options_MenuData:

	; Gameplay style
	dcScreenPos	$E000, 5, 6			; start on-screen position
	dc.l	Options_GameplayStyle_Redraw		; redraw handler
	dc.l	Options_GameplayStyle_Handle		; update handler

	; Extended camera
	dcScreenPos	$E000, 7, 6			; start on-screen position
	dc.l	Options_ExtendedCamera_Redraw		; redraw handler
	dc.l	Options_ExtendedCamera_Handle		; update handler

	; Skip uberhub place
	dcScreenPos	$E000, 9, 6			; start on-screen position
	dc.l	Options_SkipUberhubPlace_Redraw		; redraw handler
	dc.l	Options_SkipUberHubPlace_Handle		; update handler

	; Skip story screens
	dcScreenPos	$E000, 11, 6			; start on-screen position
	dc.l	Options_SkipStoryScreens_Redraw		; redraw handler
	dc.l	Options_SkipStoryScreens_Handle		; update handler

	; Photosensitive mode
	dcScreenPos	$E000, 13, 6			; start on-screen position
	dc.l	Options_PhotosensitiveMode_Redraw	; redraw handler
	dc.l	Options_PhotosensitiveMode_Handle	; update handler

	; Cinematic mode
	dcScreenPos	$E000, 15, 6			; start on-screen position
	dc.l	Options_CinematicMode_Redraw		; redraw handler
	dc.l	Options_CinematicMode_Handle		; update handler

	; Motion blur
	dcScreenPos	$E000, 17, 6			; start on-screen position
	dc.l	Options_MotionBlur_Redraw		; redraw handler
	dc.l	Options_MotionBlur_Handle		; update handler

	; Non-stop inhuman
	dcScreenPos	$E000, 19, 6			; start on-screen position
	dc.l	Options_NonstopInhuman_Redraw		; redraw handler
	dc.l	Options_NonstopInhuman_Handle		; update handler

	; Delete save game
	dcScreenPos	$E000, 21, 6			; start on-screen position
	dc.l	Options_DeleteSaveGame_Redraw		; redraw handler
	dc.l	Options_DeleteSaveGame_Handle		; update handler

	; Black bars mode
	dcScreenPos	$E000, 23, 6			; start on-screen position
	dc.l	Options_BlackBarsMode_Redraw		; redraw handler
	dc.l	Options_BlackBarsMode_Handle		; update handler

Options_MenuData_End:

; ---------------------------------------------------------------------------

Options_MenuData_NumItems:	equ	(Options_MenuData_End-Options_MenuData)/10


; ===========================================================================
; ---------------------------------------------------------------------------
; "GAMEPLAY STYLE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_GameplayStyle_Redraw:
	lea	@Str_Option1(pc), a1
	moveq	#1<<5, d0
	and.b	OptionsBits, d0
	beq.s	@0
	lea	@Str_Option2(pc), a1
@0:	Options_PipeString a4, "GAMEPLAY STYLE       %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@Str_Option1:	dc.b	' CASUAL', 0
@Str_Option2:	dc.b	'FRANTIC', 0
	even

; ---------------------------------------------------------------------------
; "GAMEPLAY STYLE" handle function
; ---------------------------------------------------------------------------

Options_GameplayStyle_Handle:
	move.b	Joypad|Press, d1	; get button presses
 	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.s	@ret			; if not, branch
	
	tst.b	(PlacePlacePlace).w	; is easter egg flag set?
	beq.s	@noteaster		; if not, branch
	clr.b	(PlacePlacePlace).w	; clear easter egg flag
	bclr	#5,OptionsBits		; set to casual
	move.w	#$DF,d0			; jester explosion sound
	jsr	PlaySound
	move.w	#$E3,d0			; regular speed
	jsr	PlaySound_Special
	bra.s	@redraw

@noteaster:
	btst	#6,d1			; is specifically A pressed?
	bne.s	@quicktoggle		; if yes, quick toggle
	moveq	#1,d0			; set to GameplayStyleScreen
	jmp	Exit_OptionsScreen

@quicktoggle:
	bchg	#5, OptionsBits		; toggle gameplay style
	bsr	Options_PlayRespectiveToggleSound

@redraw:
	st.b	Options_RedrawCurrentItem
@ret:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "EXTENDED CAMERA" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_ExtendedCamera_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#0, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:	Options_PipeString a4, "EXTENDED CAMERA          %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
; "EXTENDED CAMERA" handle function
; ---------------------------------------------------------------------------

Options_ExtendedCamera_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done			; if not, branch
	bchg	#0, OptionsBits		; toggle extended camera
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "SKIP UBERHUB PLACE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_SkipUberHubPlace_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#2, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:	Options_PipeString a4, "SKIP UBERHUB PLACE       %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
; "SKIP UBERHUB PLACE" handle function
; ---------------------------------------------------------------------------

Options_SkipUberHubPlace_Handle:
	move.b	Joypad|Press, d1		; get button presses
	andi.b	#$FC, d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done				; if not, branch
	bchg	#2, OptionsBits			; toggle Uberhub autoskip
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "SKIP STORY SCREENS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_SkipStoryScreens_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#1, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:	Options_PipeString a4, "SKIP STORY SCREENS       %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
; "SKIP STORY SCREENS" handle function
; ---------------------------------------------------------------------------

Options_SkipStoryScreens_Handle:
	move.b	Joypad|Press, d1		; get button presses
	andi.b	#$FC, d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done				; if not, branch
	bchg	#1, OptionsBits			; toggle Uberhub autoskip
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "PHOTOSENSITIVE MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_PhotosensitiveMode_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#7, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:	Options_PipeString a4, "PHOTOSENSITIVE MODE      %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
Options_PhotosensitiveMode_Handle:
	move.b	Joypad|Press, d1		; get button presses
	andi.b	#$FC, d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done				; if not, branch
	bchg	#7, OptionsBits			; toggle Uberhub autoskip
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "CINEMATIC MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_CinematicMode_Redraw:
	bsr	Options_CinematicMode_BitsToId	; d0 = ModeId (%00..%11)
	add.w	d0, d0
	add.w	d0, d0				; d0 = ModeId * 4
	movea.l	@CinematicModeTextList(pc,d0), a1

	lea	@Str_Cinematic_Locked(pc), a0
	jsr	Check_BaseGameBeaten		; has the player beaten base game?
	beq.s	@0				; if not, branch
	lea	@Str_Cinematic_Normal(pc), a0

@0:	Options_PipeString a4, "%<.l a0 str>   %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@Str_Cinematic_Normal:
	dc.b	'CINEMATIC MODE', 0

@Str_Cinematic_Locked:
	dc.b	'????????? ????', 0
	even

@CinematicModeTextList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'        OFF',0
@Str_Mode01:	dc.b	' BLACK BARS',0
@Str_Mode10:	dc.b	'PISS FILTER',0
@Str_Mode11:	dc.b	'       BOTH',0
		even

; ---------------------------------------------------------------------------
; "CINEMATIC MODE" handle function
; ---------------------------------------------------------------------------

Options_CinematicMode_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	tst.w	($FFFFFFFA).w			; is debug mode enabled?
	beq.s	@nodebugunlock			; if not, branch
	cmpi.b	#$70,($FFFFF604).w		; is exactly ABC held?
	bne.s	@nodebugunlock			; if not, branch
	jsr	Toggle_BaseGameBeaten		; toggle base game beaten state to toggle the unlock for cinematic mode
	andi.b	#~((1<<6)|(1<<3)), OptionsBits	; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:		
	jsr	Check_BaseGameBeaten		; has the player beaten the base game?
	beq.w	Options_PlayDisallowedSound		; if not, cineamtic mode is disallowed

	bsr.s	Options_CinematicMode_BitsToId	; d0 = %PB (B = bars, P = piss)
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.w	#1, d0
	bra.s	@finalize

@selectPrevious:
	subq.w	#1, d0

@finalize:
	andi.w	#%11, d0
	bsr	Options_CinematicMode_IdToBits
	st.b	Options_RedrawCurrentItem
	move.b	#$D8,d0			; play move sound
	jmp	PlaySound_Special

@ret:	rts

; ---------------------------------------------------------------------------
Options_CinematicMode_BitsToId:
	KDebug.WriteLine "IN: bits: %<.b d0 bin>"
	moveq	#(1<<6)|(1<<3), d0
	and.b	OptionsBits, d0		; d0 = %0P00 B000, B = bars, P = piss
	lsr.b	#3, d0			; d0 = %0000 P00B, B = bars, P = piss
	ror.w	d0			; d0 = %Bxxx xxxx 0000 0P00
	lsr.b	#3-1, d0		; d0 = %Bxxx xxxx 0000 000P
	rol.w	d0			; d0 = %0000 00PB
	KDebug.WriteLine "OUT: id: %<.b d0 bin>"
	rts

; ---------------------------------------------------------------------------
Options_CinematicMode_IdToBits:
	KDebug.WriteLine "IN: id: %<.b d0 bin>"
	andi.b	#~((1<<6)|(1<<3)), OptionsBits
	ror.w	d0			; d0 = %Bxxx xxxx 0000 000P
	lsl.b	#(6-3)-1, d0		; d0 = %Bxxx xxxx 0000 0P00
	rol.w	d0			; d0 = %0000 P00B
	lsl.b	#3, d0			; d0 = %0P00 B000
	or.b	d0, OptionsBits
	KDebug.WriteLine "OUT: id: %<.b d0 bin>"
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "MOTION BLUR" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_MotionBlur_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#4, ScreenFuzz
	beq.s	@0
	lea	Options_Str_On(pc), a1

@0:	lea	@Str_MotionBlur_Locked(pc), a0
	jsr	Check_AllLevelsBeaten_Frantic	; has the player beaten all levels in frantic?
	beq.s	@1				; if not, branch
	lea	@Str_MotionBlur_Normal(pc), a0

@1:	Options_PipeString a4, "%<.l a0 str>              %<.l a1 str>", 28
	rts

@Str_MotionBlur_Normal:
	dc.b	'MOTION BLUR', 0

@Str_MotionBlur_Locked:
	dc.b	'?????? ????', 0
	even

; ---------------------------------------------------------------------------
; "MOTION BLUR" handle function
; ---------------------------------------------------------------------------

Options_MotionBlur_Handle:
	move.b	Joypad|Press, d1	; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, branch

	tst.w	($FFFFFFFA).w		; is debug mode enabled?
	beq.s	@nodebugunlock		; if not, branch
	cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
	bne.s	@nodebugunlock		; if not, branch
	jsr	Toggle_FranticBeaten	; toggle frantic beaten state to toggle the unlock for motion blur
	clr.b	(ScreenFuzz).w		; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:
	jsr	Check_AllLevelsBeaten_Frantic	; has the player beaten all levels in frantic?
	beq.w	Options_PlayDisallowedSound	; if not, branch
	bchg	#4, ScreenFuzz			; toggle motion blur (not saved to SRAM!)
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@ret:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "NONSTOP INHUMAN" redraw function
; ---------------------------------------------------------------------------

Options_NonstopInhuman_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#4, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1

@0:	lea	@Str_NonstopInhuman_Locked(pc), a0
	jsr	Check_BlackoutBeaten		; has the player beaten all levels in frantic?
	beq.s	@1				; if not, branch
	lea	@Str_NonstopInhuman_Normal(pc), a0

@1:	Options_PipeString a4, "%<.l a0 str>          %<.l a1 str>", 28
	rts

@Str_NonstopInhuman_Normal:
	dc.b	'NONSTOP INHUMAN', 0

@Str_NonstopInhuman_Locked:
	dc.b	'??????? ???????', 0
	even

; ---------------------------------------------------------------------------
; "NONSTOP INHUMAN" handle function
; ---------------------------------------------------------------------------

Options_NonstopInhuman_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, branch

	tst.w	($FFFFFFFA).w		; is debug mode enabled?
	beq.s	@nodebugunlock		; if not, branch
	cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
	bne.s	@nodebugunlock		; if not, branch
	jsr	Toggle_BlackoutBeaten	; toggle blackout challenge beaten state to toggle the unlock for nonstop inhuman
	bclr	#4,(OptionsBits).w	; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:
	tst.b	(PlacePlacePlace).w		; easter egg enabled?
	bne.w	Options_PlayDisallowedSound	; if yes, branch
	jsr	Check_BlackoutBeaten		; has the player specifically beaten the blackout challenge?
	beq.w	Options_PlayDisallowedSound	; if not, branch
	bchg	#4, OptionsBits			; toggle nonstop inhuman
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "DELETE SAVE GAME" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_DeleteSaveGame_Redraw:
	moveq	#0, d0
	move.b	Options_DeleteSRAMCounter, d0
	lea	@Str_DeleteSRAMCountDown(pc,d0), a1
	Options_PipeString a4, "DELETE SAVE GAME       %<.l a1 str>", 28
	rts

@Str_DeleteSRAMCountDown:
	dcb.b	Options_DeleteSRAMInitialCount, ' '
	dcb.b	Options_DeleteSRAMInitialCount, '>'
	dc.b	0
	even

; ---------------------------------------------------------------------------
Options_DeleteSaveGame_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, return

	subq.b	#1,Options_DeleteSRAMCounter	; sub one from delete counter
	beq.s	@dodelete			; if we reached zero, rip save file
	move.w	#$DF,d0				; play Jester explosion sound
	jsr	PlaySound_Special
	st.b	Options_RedrawCurrentItem
@ret	rts

@dodelete:
	ints_disable
	move.w	#90,($FFFFFF82).w	; set fade-out sequence time to 90 frames

@delete_fadeoutloop:
	subq.w	#1,($FFFFFF82).w	; subtract 1 from remaining time
	bmi.s	@delete_fadeoutend	; is time over? end fade-out sequence
	
	jsr	RandomNumber		; get new random number
	lea	($FFFFCC00).w,a1	; load scroll buffer address
	move.w	#223,d2			; do it for all 224 lines
@0	jsr	CalcSine		; further randomize the offset after every line
	move.l	d1,(a1)+		; dump to scroll buffer
	dbf	d2,@0			; repeat
	
	move.w	($FFFFFF82).w,d0	; get remaining time
	andi.w	#7,d0			; only trigger every 7th frame
	bne.s	@1			; is it not a 7th frame?, branch
	jsr	Pal_FadeOut		; partially fade-out palette
	move.b	#$C4,d0			; play explosion sound
	jsr	PlaySound_Special	; ''

@1	move.b	#2,VBlankRoutine	; run V-Blank
	jsr	DelayProgram		; ''
	bra.s	@delete_fadeoutloop	; loop

@delete_fadeoutend:
	move.b	#1,($A130F1).l		; enable SRAM
	clr.b	($200000+SRAM_Exists).l	; unset the magic number (actual SRAM deletion happens during restart)
	move.b	#0,($A130F1).l		; disable SRAM
	jmp	Init			; restart the game

; ===========================================================================
; ---------------------------------------------------------------------------
; "BLACK BARS MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_BlackBarsMode_Redraw:
	lea	@Str_BlackBars_Emulator(pc), a1
	btst	#1, BlackBars.HandlerId
	beq.s	@0
	lea	@Str_BlackBars_Hardware(pc), a1
@0:	Options_PipeString a4, "BLACK BARS MODE     %<.l a1 str>", 28
	rts

@Str_BlackBars_Emulator:
	dc.b	'EMULATOR', 0

@Str_BlackBars_Hardware:
	dc.b	'HARDWARE', 0
	even

; ---------------------------------------------------------------------------
; "BLACK BARS MODE" handle function
; ---------------------------------------------------------------------------

Options_BlackBarsMode_Handle:
	move.b	Joypad|Press,d1			; get button presses
 	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	btst	#6,d1				; is specifically A pressed?
	bne.s	@quicktoggle			; if yes, quick toggle
	moveq	#2,d0				; set to BlackBarsConfigScreen
	jmp	Exit_OptionsScreen

@quicktoggle:
	bchg	#1, BlackBars.HandlerId		; toggle black bars mode
	bsr	Options_PlayRespectiveToggleSound
	jsr	BlackBars.SetHandler
	st.b	Options_RedrawCurrentItem
@ret:	rts

; ---------------------------------------------------------------------------
; Helper functions and data
; ---------------------------------------------------------------------------

Options_PlayDisallowedSound:
	move.w	#$DC,d0			; play option disallowed sound
	jmp	PlaySound_Special

; ---------------------------------------------------------------------------
Options_PlayRespectiveToggleSound:
	beq.s	@toggleOn
	move.w	#$DA,d0			; play option toggled off sound
	jmp	PlaySound_Special

@toggleOn:
	move.w	#$D9,d0			; play option toggled on sound
	jmp	PlaySound_Special

; ---------------------------------------------------------------------------
Options_Str_On:	dc.b	' ON', 0
Options_Str_Off:dc.b	'OFF', 0
	even
