
; ===========================================================================
; ---------------------------------------------------------------------------
; Options screen menu data & handlers
; ---------------------------------------------------------------------------

Options_MenuData:

	; Gameplay style
	dcScreenPos	$E000, 6, 6			; start on-screen position
	dc.l	Options_GameplayStyle_Redraw		; redraw handler
	dc.l	Options_GameplayStyle_Handle		; update handler
	; Autoskip
	dcScreenPos	$E000, 7, 6			; start on-screen position
	dc.l	Options_Autoskip_Redraw			; redraw handler
	dc.l	Options_Autoskip_Handle			; update handler

	; Extended camera
	dcScreenPos	$E000, 9, 6			; start on-screen position
	dc.l	Options_ExtendedCamera_Redraw		; redraw handler
	dc.l	Options_ExtendedCamera_Handle		; update handler
	; Peelout style
	dcScreenPos	$E000, 10, 6			; start on-screen position
	dc.l	Options_PeeloutStyle_Redraw		; redraw handler
	dc.l	Options_PeeloutStyle_Handle		; update handler
	; Flashy Lights
	dcScreenPos	$E000, 11, 6			; start on-screen position
	dc.l	Options_FlashyLights_Redraw		; redraw handler
	dc.l	Options_FlashyLights_Handle		; update handler
	; Camera Shake
	dcScreenPos	$E000, 12, 6			; start on-screen position
	dc.l	Options_CameraShake_Redraw		; redraw handler
	dc.l	Options_CameraShake_Handle		; update handler
	; Audio
	dcScreenPos	$E000, 13, 6			; start on-screen position
	dc.l	Options_Audio_Redraw			; redraw handler
	dc.l	Options_Audio_Handle			; update handler

	; Black bars setup
	dcScreenPos	$E000, 15, 6			; start on-screen position
	dc.l	Options_BlackBarsMode_Redraw		; redraw handler
	dc.l	Options_BlackBarsMode_Handle		; update handler

	; E - Cinematic mode
	dcScreenPos	$E000, 17, 6			; start on-screen position
	dc.l	Options_CinematicMode_Redraw		; redraw handler
	dc.l	Options_CinematicMode_Handle		; update handler
	; R - Screen Effects
	dcScreenPos	$E000, 18, 6			; start on-screen position
	dc.l	Options_ScreenEffects_Redraw		; redraw handler
	dc.l	Options_ScreenEffects_Handle		; update handler
	; Z - True Inhuman
	dcScreenPos	$E000, 19, 6			; start on-screen position
	dc.l	Options_NonstopInhuman_Redraw		; redraw handler
	dc.l	Options_NonstopInhuman_Handle		; update handler

	; Delete save game
	dcScreenPos	$E000, 21, 6			; start on-screen position
	dc.l	Options_DeleteSaveGame_Redraw		; redraw handler
	dc.l	Options_DeleteSaveGame_Handle		; update handler



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
	tst.b	(PlacePlacePlace).w	; is easter egg flag set?
	beq.s	@noteaster		; if not, branch
	lea	@Str_Option3(pc), a1
	bra.s	@0
@noteaster:
	lea	@Str_Option1(pc), a1
	moveq	#1<<5, d0
	and.b	OptionsBits, d0
	beq.s	@0
	lea	@Str_Option2(pc), a1
@0:	Options_PipeString a4, "DIFFICULTY           %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@Str_Option1:	dc.b	' CASUAL', 0
@Str_Option2:	dc.b	'FRANTIC', 0
@Str_Option3:	dc.b	'TRUE-BS', 0
	even

; ---------------------------------------------------------------------------
; "GAMEPLAY STYLE" handle function
; ---------------------------------------------------------------------------

Options_GameplayStyle_Handle:
	moveq	#0,d1
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
	andi.b	#$C,d1			; specifically left or right pressed?
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
; "PEELOUT STYLE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_PeeloutStyle_Redraw:
	lea	@Str_UPandA(pc), a1
	btst	#4, OptionsBits2
	beq.s	@0
	lea	@Str_UPandABC(pc), a1
@0:	Options_PipeString a4, "PEELOUT STYLE       %<.l a1 str>", 28
	rts

@Str_UPandA:
	dc.b	'   ^ + A', 0
	even
@Str_UPandABC:
	dc.b	' ^ + ABC', 0
	even

; ---------------------------------------------------------------------------
; "PEELOUT STYLE" handle function
; ---------------------------------------------------------------------------

Options_PeeloutStyle_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done			; if not, branch
	bchg	#4, OptionsBits2	; toggle peelout style
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "AUTOSKIP" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_Autoskip_Redraw:
	moveq	#0,d0
	btst	#1, OptionsBits		; skip story screens enabled?
	beq.s	@0
	addq.b	#1,d0
@0:
	btst	#2, OptionsBits		; skip Uberhub Place enabled?
	beq.s	@1
	addq.b	#2,d0
@1:
	add.w	d0, d0
	add.w	d0, d0				; d0 = ModeId * 4
	movea.l	@AutoskipList(pc,d0), a1
	
	Options_PipeString a4, "AUTOSKIP       %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@AutoskipList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'          OFF',0
@Str_Mode01:	dc.b	'STORY SCREENS',0
@Str_Mode10:	dc.b	'UBERHUB PLACE',0
@Str_Mode11:	dc.b	'         BOTH',0
		even


; ---------------------------------------------------------------------------
; "AUTOSKIP" handle function
; ---------------------------------------------------------------------------

Options_Autoskip_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	moveq	#0,d0
	move.b	OptionsBits,d0
	lsr.b	#1,d0
	andi.b	#%11, d0
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.b	#1, d0				; use next mode
	bra.s	@finalize
@selectPrevious:
	subq.b	#1, d0				; use previous mode
@finalize:
	andi.b	#%11, d0			; wrap modes
	move.b	d0,d1
	lsl.b	#1,d0
	
	bclr	#1,OptionsBits
	bclr	#2,OptionsBits
	or.b	d0,OptionsBits

	st.b	Options_RedrawCurrentItem

	tst.b	d1				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

@ret:	rts



; ===========================================================================
; ---------------------------------------------------------------------------
; "PHOTOSENSITIVE MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_FlashyLights_Redraw:
	moveq	#0,d0
	btst	#7, OptionsBits		; photosensitive mode enabled?
	beq.s	@0			; if not, branch
	addq.b	#1,d0
@0:
	btst	#6, OptionsBits		; max white flash enabled?
	beq.s	@1			; if not, branch
	moveq	#2,d0
@1:
	add.w	d0, d0
	add.w	d0, d0				; d0 = ModeId * 4
	movea.l	@FlashyLightsList(pc,d0), a1
	
	Options_PipeString a4, "FLASHY LIGHTS %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@FlashyLightsList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10

@Str_Mode00:	dc.b	'      STANDARD',0
@Str_Mode01:	dc.b	'       REDUCED',0
@Str_Mode10:	dc.b	' MAX INTENSITY',0
		even

; ---------------------------------------------------------------------------
; "PHOTOSENSITIVE MODE" handle function
; ---------------------------------------------------------------------------

Options_FlashyLights_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	moveq	#0,d0
	move.b	OptionsBits,d0
	lsr.b	#6,d0
	andi.b	#%11, d0
@repeat:
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.b	#1, d0				; use next mode
	bra.s	@finalize
@selectPrevious:
	subq.b	#1, d0				; use previous mode
@finalize:
	andi.b	#%11, d0			; wrap modes
	cmpi.b	#%11, d0			; is photosensitive mode and max white mode enabled at once?
	beq.s	@repeat				; this is an illegal state, repeat button input

	move.b	d0,d1
	lsl.b	#6,d0
	
	bclr	#6,OptionsBits
	bclr	#7,OptionsBits
	or.b	d0,OptionsBits

	st.b	Options_RedrawCurrentItem

	tst.b	d1				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "CAMERA SHAKING" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_CameraShake_Redraw:
	lea	@Str_Normal(pc), a1
	btst	#2, OptionsBits2
	beq.s	@0
	lea	@Str_Weak(pc), a1
@0:	Options_PipeString a4, "CAMERA SHAKE        %<.l a1 str>", 28
	rts

@Str_Normal:
	dc.b	'STANDARD', 0
	even
@Str_Weak:
	dc.b	'    WEAK', 0
	even

; ===========================================================================
; ---------------------------------------------------------------------------
; "CAMERA SHAKING" handle function
; ---------------------------------------------------------------------------

Options_CameraShake_Handle:
	move.b	Joypad|Press, d1		; get button presses
	andi.b	#$FC, d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done				; if not, branch
	bchg	#2, OptionsBits2		; toggle weak camera shaking
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts



; ===========================================================================
; ---------------------------------------------------------------------------
; "AUDIO" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_Audio_Redraw:
	moveq	#0,d0
	btst	#0, OptionsBits2	; is music disabled?
	beq.s	@0
	addq.b	#1,d0
@0:
	btst	#1, OptionsBits2	; is sfx disabled?
	beq.s	@1
	addq.b	#2,d0
@1:
	add.w	d0, d0
	add.w	d0, d0				; d0 = ModeId * 4
	movea.l	@AudioList(pc,d0), a1
	
	Options_PipeString a4, "AUDIO      %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@AudioList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'         STANDARD',0
@Str_Mode01:	dc.b	'    DISABLE MUSIC',0
@Str_Mode10:	dc.b	'      DISABLE SFX',0
@Str_Mode11:	dc.b	'          SILENCE',0
		even

; ---------------------------------------------------------------------------
; "AUDIO" handle function
; ---------------------------------------------------------------------------

Options_Audio_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	moveq	#0,d0
	move.b	OptionsBits2,d0
	andi.b	#%11, d0
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.b	#1, d0				; use next mode
	bra.s	@finalize
@selectPrevious:
	subq.b	#1, d0				; use previous mode
@finalize:
	andi.b	#%11, d0			; wrap modes
	move.b	d0,d1
	
	bclr	#0,OptionsBits2
	bclr	#1,OptionsBits2
	or.b	d0,OptionsBits2

	st.b	Options_RedrawCurrentItem

	tst.b	d1				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

@ret:	rts



; ===========================================================================
; ---------------------------------------------------------------------------
; "CINEMATIC MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_CinematicMode_Redraw:	
	lea	Options_Str_Off(pc), a1
	btst	#3, OptionsBits
	beq.s	@0
	lea	Options_Str_On(pc), a1

@0:	lea	@Str_Cinematic_Locked(pc), a0
	jsr	Check_BaseGameBeaten_Casual	; has the player beaten base game in casual?
	beq.s	@1				; if not, branch
	lea	@Str_Cinematic_Normal(pc), a0

@1:	Options_PipeString a4, "%<.l a0 str>         %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@Str_Cinematic_Normal:
	dc.b	'E CINEMATIC MODE', 0

@Str_Cinematic_Locked:
	dc.b	'E ????????? ????', 0
	even

; ---------------------------------------------------------------------------
; "CINEMATIC MODE" handle function
; ---------------------------------------------------------------------------

Options_CinematicMode_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, branch

	tst.w	($FFFFFFFA).w		; is debug mode enabled?
	beq.s	@nodebugunlock		; if not, branch
	cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
	bne.s	@nodebugunlock		; if not, branch
	jsr	Toggle_BaseGameBeaten_Casual	; toggle base game beaten in casual state to toggle the unlock for cinematic mode
	bclr	#3,(OptionsBits).w	; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:
	jsr	Check_BaseGameBeaten_Casual	; has the player beaten the base game in casual?
	beq.w	Options_PlayDisallowedSound	; if not, branch
	bchg	#3, OptionsBits			; toggle cinematic mode
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "SCREEN EFFECTS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawText_Normal` or `Options_DrawText_Highlighted`
; ---------------------------------------------------------------------------

Options_ScreenEffects_Redraw:
	moveq	#0,d0
	move.b	(ScreenFuzz).w,d0
	add.w	d0, d0
	add.w	d0, d0				; d0 = ModeId * 4
	movea.l	@ScreenEffectsTextList(pc,d0), a1

	lea	@Str_ScreenEffects_Locked(pc), a0
	jsr	Check_BaseGameBeaten_Frantic	; has the player beaten base game in frantic?
	beq.s	@0				; if not, branch
	lea	@Str_ScreenEffects_Normal(pc), a0

@0:	Options_PipeString a4, "%<.l a0 str> %<.l a1 str>", 28
	rts

; ---------------------------------------------------------------------------
@Str_ScreenEffects_Normal:
	dc.b	'R VISUAL FX     ', 0

@Str_ScreenEffects_Locked:
	dc.b	'R ?????? ??     ', 0
	even

@ScreenEffectsTextList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'        OFF',0
@Str_Mode01:	dc.b	'MOTION BLUR',0
@Str_Mode10:	dc.b	'PISS FILTER',0
@Str_Mode11:	dc.b	'       BOTH',0
		even

; ---------------------------------------------------------------------------
; "MOTION BLUR" handle function
; ---------------------------------------------------------------------------

Options_ScreenEffects_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	tst.w	($FFFFFFFA).w			; is debug mode enabled?
	beq.s	@nodebugunlock			; if not, branch
	cmpi.b	#$70,($FFFFF604).w		; is exactly ABC held?
	bne.s	@nodebugunlock			; if not, branch
	jsr	Toggle_BaseGameBeaten_Frantic	; toggle frantic beaten state to toggle the unlock for motion blur
	clr.b	(ScreenFuzz).w			; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:		
	jsr	Check_BaseGameBeaten_Frantic	; has the player beaten the base game in frantic?
	beq.w	Options_PlayDisallowedSound	; if not, cineamtic mode is disallowed

	moveq	#0,d0
	move.b	(ScreenFuzz).w,d0
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.w	#1, d0				; use next mode
	bra.s	@finalize

@selectPrevious:
	subq.w	#1, d0				; use previous mode

@finalize:
	andi.w	#%11, d0			; wrap modes
	move.b	d0,(ScreenFuzz).w
	st.b	Options_RedrawCurrentItem

	tst.b	d0				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

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

@1:	Options_PipeString a4, "%<.l a0 str>      %<.l a1 str>", 28
	rts

@Str_NonstopInhuman_Normal:
	dc.b	'Z TRUE INHUMAN     ', 0

@Str_NonstopInhuman_Locked:
	dc.b	'Z ???? ???????     ', 0
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
	;tst.b	(PlacePlacePlace).w		; easter egg enabled?
	;bne.w	Options_PlayDisallowedSound	; if yes, branch
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
@0:	Options_PipeString a4, "BLACK BARS SETUP    %<.l a1 str>", 28
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
 	andi.b	#$F0,d1				; is A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	btst	#6,d1				; is specifically A pressed?
	beq.s	@gotosetupscreen		; if not, branch
	tst.w	($FFFFFFFA).w			; is debug mode enabled?
	beq.s	@gotosetupscreen		; if not, branch

@quicktoggle:
	bchg	#1, BlackBars.HandlerId		; toggle black bars mode
	bsr	Options_PlayRespectiveToggleSound
	jsr	BlackBars.SetHandler
	st.b	Options_RedrawCurrentItem
@ret:	rts

@gotosetupscreen:
	moveq	#2,d0				; set to BlackBarsConfigScreen
	jmp	Exit_OptionsScreen

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
