
; ===========================================================================
; ---------------------------------------------------------------------------
; Options screen menu data & handlers
; ---------------------------------------------------------------------------

Options_MenuData:
	OpBaseDest: = $C000
	OpBaseY: = 6
 if def(__WIDESCREEN__)
	OpBaseX: = 0
	OpLength: = 30+6
 else
 	OpBaseX: = 3
	OpLength: = 30
 endif

; slot-specific options

	; Difficulty
	dcScreenPos	OpBaseDest, OpBaseY+0, OpBaseX	; start on-screen position
	dc.l	Options_GameplayStyle_Redraw		; redraw handler
	dc.l	Options_GameplayStyle_Handle		; update handler
	
	; Extended camera
	dcScreenPos	OpBaseDest, OpBaseY+1, OpBaseX	; start on-screen position
	dc.l	Options_ExtendedCamera_Redraw		; redraw handler
	dc.l	Options_ExtendedCamera_Handle		; update handler
	; Arcade mode / Speedrun mode
	dcScreenPos	OpBaseDest, OpBaseY+2, OpBaseX	; start on-screen position
	dc.l	Options_Autoskip_Redraw			; redraw handler
	dc.l	Options_Autoskip_Handle			; update handler
	; Alternate HUD
	dcScreenPos	OpBaseDest, OpBaseY+3, OpBaseX	; start on-screen position
	dc.l	Options_AlternateHUD_Redraw		; redraw handler
	dc.l	Options_AlternateHUD_Handle		; update handler
	; Palette style
	dcScreenPos	OpBaseDest, OpBaseY+4, OpBaseX	; start on-screen position
	dc.l	Options_PaletteStyle_Redraw		; redraw handler
	dc.l	Options_PaletteStyle_Handle		; update handler

	; E - Cinematic effects
	dcScreenPos	OpBaseDest, OpBaseY+6, OpBaseX	; start on-screen position
	dc.l	Options_CinematicEffects_Redraw		; redraw handler
	dc.l	Options_CinematicEffects_Handle		; update handler
	; R - ERaZor powers
	dcScreenPos	OpBaseDest, OpBaseY+7, OpBaseX	; start on-screen position
	dc.l	Options_ErazorPowers_Redraw		; redraw handler
	dc.l	Options_ErazorPowers_Handle		; update handler
	; Z - True-BS mode
	dcScreenPos	OpBaseDest, OpBaseY+8, OpBaseX	; start on-screen position
	dc.l	Options_TrueBSMode_Redraw		; redraw handler
	dc.l	Options_TrueBSMode_Handle		; update handler

; global options

	; Flashy lights
	dcScreenPos	OpBaseDest, OpBaseY+10, OpBaseX	; start on-screen position
	dc.l	Options_FlashyLights_Redraw		; redraw handler
	dc.l	Options_FlashyLights_Handle		; update handler
	; Camera shake
	dcScreenPos	OpBaseDest, OpBaseY+11, OpBaseX	; start on-screen position
	dc.l	Options_CameraShake_Redraw		; redraw handler
	dc.l	Options_CameraShake_Handle		; update handler
	; Audio mode
	dcScreenPos	OpBaseDest, OpBaseY+12, OpBaseX	; start on-screen position
	dc.l	Options_Audio_Redraw			; redraw handler
	dc.l	Options_Audio_Handle			; update handler
	; Black bars setup
	dcScreenPos	OpBaseDest, OpBaseY+13, OpBaseX	; start on-screen position
	dc.l	Options_BlackBarsMode_Redraw		; redraw handler
	dc.l	Options_BlackBarsMode_Handle		; update handler


	; Reset slot-specifc options
	dcScreenPos	OpBaseDest, OpBaseY+15, OpBaseX	; start on-screen position
	dc.l	Options_ResetLocalOptions_Redraw	; redraw handler
	dc.l	Options_ResetLocalOptions_Handle	; update handler

	; Reset global options
	dcScreenPos	OpBaseDest, OpBaseY+16, OpBaseX	; start on-screen position
	dc.l	Options_ResetGlobalOptions_Redraw	; redraw handler
	dc.l	Options_ResetGlobalOptions_Handle	; update handler


	; Save & exit options / Start game
	dcScreenPos	OpBaseDest, OpBaseY+20, OpBaseX	; start on-screen position
	dc.l	Options_Exit_Redraw			; redraw handler
	dc.l	Options_Exit_Handle			; update handler


Options_MenuData_End:

; ---------------------------------------------------------------------------

Options_MenuData_NumItems:	equ	(Options_MenuData_End-Options_MenuData)/10


; ===========================================================================
; ---------------------------------------------------------------------------
; "GAMEPLAY STYLE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_GameplayStyle_Redraw:
	lea	@Str_Option1(pc), a1
	btst	#SlotState_Difficulty, SlotProgress
	beq.s	@0
	lea	@Str_Option2(pc), a1
@0:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "DIFFICULTY                   %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "DIFFICULTY             %<.l a1 str>", OpLength
 endif

	rts

; ---------------------------------------------------------------------------
@Str_Option1:	dc.b	' CASUAL', 0
@Str_Option2:	dc.b	'FRANTIC', 0
	even

; ---------------------------------------------------------------------------
; "GAMEPLAY STYLE" handle function
; ---------------------------------------------------------------------------

Options_GameplayStyle_Handle:
	moveq	#$FFFFFF00|(A|B|C|Start), d1
	and.b	Joypad|Press, d1	; is A, B, C, or Start pressed?
	beq.s	@ret			; if not, branch

	btst	#iA, d1			; is specifically A pressed?
	beq.s	@gss			; if not, branch
	tst.w	($FFFFFFFA).w		; is debug mode enabled?
	beq.s	@gss			; if not, branch
	bchg	#SlotState_Difficulty, SlotProgress	; quick toggle gameplay style
	bsr	Options_PlayRespectiveToggleSound
	bra.s	@redraw

@gss:
	moveq	#1,d0			; set to GameplayStyleScreen
	jmp	Exit_OptionsScreen

@redraw:
	st.b	Options_RedrawCurrentItem
@ret:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; "EXTENDED CAMERA" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_ExtendedCamera_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#SlotOptions_ExtendedCamera, SlotOptions
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "EXTENDED WIDESCREEN CAMERA       %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "EXTENDED CAMERA            %<.l a1 str>", OpLength
 endif

	rts

; ---------------------------------------------------------------------------
; "EXTENDED CAMERA" handle function
; ---------------------------------------------------------------------------

Options_ExtendedCamera_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.s	@done			; if not, branch

 if def(__WIDESCREEN__)
	; hint on A
	moveq	#$1B,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed
 endif

	bchg	#SlotOptions_ExtendedCamera, SlotOptions
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@done:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "PALETTE STYLE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_PaletteStyle_Redraw:
	lea	@Str0(pc), a1
	btst	#SlotOptions_NewPalettes, SlotOptions
	beq.s	@0
	lea	@Str1(pc), a1
@0:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "PALETTE STYLE             %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "PALETTE STYLE       %<.l a1 str>", OpLength
 endif
	rts

@Str0:	dc.b	'OLD-SCHOOL', 0
@Str1:	dc.b	'REMASTERED', 0
	even


; ---------------------------------------------------------------------------
; "PALETTE STYLE" handle function
; ---------------------------------------------------------------------------

Options_PaletteStyle_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done			; if not, branch

	; hint on A
	moveq	#$1A,d0			; ID for the explanation textbox
	bsr	Options_HandleAHint	; show explanation textbox if A is pressed

	bchg	#SlotOptions_NewPalettes, SlotOptions
	bsr	Options_PlayRespectiveToggleSound

	moveq	#0,d0			; write directly
	jsr	Options_LoadPal		; refresh palette accordingly

	st.b	Options_RedrawCurrentItem
@done:	rts




; ===========================================================================
; ---------------------------------------------------------------------------
; "ALTERNATE HUD" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_AlternateHUD_Redraw:
	move.b	SlotOptions, d1
	moveq	#0, d0			; d0 = strId * 4
	btst	#SlotOptions_AltHUD_ShowSeconds, d1
	beq.s	@0
	addq.b	#1*4, d0
@0:
	btst	#SlotOptions_AltHUD_ShowErrors, d1
	beq.s	@1
	addq.b	#2*4,d0
@1:
	btst	#SlotOptions_NoHUD, d1
	beq.s	@2
	moveq	#4*4,d0
@2:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "ALTERNATE HUD        %<.l @AltHUDList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "ALTERNATE HUD  %<.l @AltHUDList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@AltHUDList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11,@Str_ModeXX

@Str_Mode00:	dc.b	'            OFF',0
@Str_Mode01:	dc.b	'     TOTAL TIME',0
@Str_Mode10:	dc.b	' TOTAL MISTAKES',0
@Str_Mode11:	dc.b	'TIME + MISTAKES',0
@Str_ModeXX:	dc.b	'DISABLE ALL HUD',0
		even

; ---------------------------------------------------------------------------
; "ALTERNATE HUD" handle function
; ---------------------------------------------------------------------------

Options_AlternateHUD_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	; hint on A
	moveq	#$19,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed

	moveq	#0,d0
	btst	#SlotOptions_AltHUD_ShowSeconds, SlotOptions
	beq.s	@0
	bset	#0,d0
@0	btst	#SlotOptions_AltHUD_ShowErrors, SlotOptions
	beq.s	@1
	bset	#1,d0
@1
	btst	#SlotOptions_NoHUD, SlotOptions
	beq.s	@2				; if not, branch
	moveq	#%111,d0
@2:
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.w	#1, d0				; use next mode
	bra.s	@finalize

@selectPrevious:
	btst	#2,d0
	beq.s	@bla
	moveq	#%100,d0
@bla:
	subq.w	#1, d0				; use previous mode

@finalize:
	andi.w	#%111, d0			; wrap modes

	bclr	#SlotOptions_NoHUD, SlotOptions
	btst	#2,d0
	beq.s	@2x
	bset	#SlotOptions_NoHUD, SlotOptions
	moveq	#0,d0
@2x	

	bclr	#SlotOptions_AltHUD_ShowSeconds, SlotOptions
	btst	#0,d0
	beq.s	@0x
	bset	#SlotOptions_AltHUD_ShowSeconds, SlotOptions
@0x	
	bclr	#SlotOptions_AltHUD_ShowErrors, SlotOptions
	btst	#1,d0
	beq.s	@1x
	bset	#SlotOptions_AltHUD_ShowErrors, SlotOptions
@1x	

	st.b	Options_RedrawCurrentItem

	tst.b	d0				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "AUTOSKIP" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_Autoskip_Redraw:
	lea	Options_Str_Off(pc), a1
	btst	#SlotOptions2_ArcadeMode, SlotOptions2
	beq.s	@0
	lea	Options_Str_On(pc), a1
@0:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "ARCADE MODE                      %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "ARCADE MODE                %<.l a1 str>", OpLength
 endif

	rts

; ---------------------------------------------------------------------------
; "AUTOSKIP" handle function
; ---------------------------------------------------------------------------

Options_Autoskip_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	; hint on A
	moveq	#$18,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed

	bchg	#SlotOptions2_ArcadeMode, SlotOptions2
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem

@ret:	rts



; ===========================================================================
; ---------------------------------------------------------------------------
; "PHOTOSENSITIVE MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_FlashyLights_Redraw:
	moveq	#0, d0
	btst	#GlobalOptions_ScreenFlash_Weak, GlobalOptions
	beq.s	@0
	addq.b	#1*4, d0
@0:
	btst	#GlobalOptions_ScreenFlash_Intense, GlobalOptions
	beq.s	@1
	moveq	#2*4, d0
@1:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "FLASHING LIGHTS       %<.l @FlashyLightsList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "FLASHY LIGHTS   %<.l @FlashyLightsList(pc,d0) str>", OpLength
 endif

	rts

; ---------------------------------------------------------------------------
@FlashyLightsList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10

@Str_Mode00:	dc.b	'        NORMAL',0
@Str_Mode01:	dc.b	'PHOTOSENSITIVE',0
@Str_Mode10:	dc.b	'     EPILEPTIC',0
		even

; ---------------------------------------------------------------------------
; "PHOTOSENSITIVE MODE" handle function
; ---------------------------------------------------------------------------

Options_FlashyLights_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	tst.b	WhiteFlashCounter		; whiteflash in progress?
	bne.w	@ret				; if yes, prevent change to avoid the palette getting stuck

	moveq	#0, d0
	move.b	GlobalOptions, d0
	lsr.b	#GlobalOptions_ScreenFlash_Intense, d0
	andi.b	#%11, d0
@repeat:
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	subq.b	#1, d0				; use next mode
	bra.s	@finalize
@selectPrevious:
	addq.b	#1, d0				; use previous mode
@finalize:
	andi.b	#%11, d0			; wrap modes
	cmpi.b	#%11, d0			; is photosensitive mode and max white mode enabled at once?
	beq.s	@repeat				; this is an illegal state, repeat button input

	move.b	d0,d1
	lsl.b	#GlobalOptions_ScreenFlash_Intense, d0	
	bclr	#GlobalOptions_ScreenFlash_Intense, GlobalOptions
	bclr	#GlobalOptions_ScreenFlash_Weak, GlobalOptions
	or.b	d0, GlobalOptions

	jsr	WhiteFlash
	move.w	#$C3,d0
	jsr	PlaySFX

	st.b	Options_RedrawCurrentItem

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "CAMERA SHAKING" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_CameraShake_Redraw:
	moveq	#0, d0
	btst	#GlobalOptions_CameraShake_Weak, GlobalOptions
	beq.s	@0
	addq.b	#1*4, d0
@0:
	btst	#GlobalOptions_CameraShake_Intense, GlobalOptions
	beq.s	@1
	moveq	#2*4, d0
@1:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "CAMERA SHAKING        %<.l @CameraShakeList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "CAMERA SHAKE    %<.l @CameraShakeList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@CameraShakeList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10

@Str_Mode00:	dc.b	'        NORMAL',0
@Str_Mode01:	dc.b	'PHOTOSENSITIVE',0
@Str_Mode10:	dc.b	'     EPILEPTIC',0
		even


; ===========================================================================
; ---------------------------------------------------------------------------
; "CAMERA SHAKING" handle function
; ---------------------------------------------------------------------------

Options_CameraShake_Handle:
	move.b	Joypad|Press, d1		; get button presses
	andi.b	#$FC, d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	moveq	#0,d0
	move.b	GlobalOptions, d0
	lsr.b	#GlobalOptions_CameraShake_Weak, d0
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
	cmpi.b	#%11, d0			; is weak and intense camera shake enabled at once?
	beq.s	@repeat				; this is an illegal state, repeat button input

	move.b	d0, d1
	lsl.b	#GlobalOptions_CameraShake_Weak, d0
	bclr	#GlobalOptions_CameraShake_Weak, GlobalOptions
	bclr	#GlobalOptions_CameraShake_Intense, GlobalOptions
	or.b	d0, GlobalOptions

	ori.b	#30,(CameraShake).w
	move.b	#0,(CameraShake_Intensity).w
	jsr	GenerateCameraShake
	move.w	#0,($FFFFF618).w

	st.b	Options_RedrawCurrentItem

	move.w	#$C4,d0
	jsr	PlaySFX

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "AUDIO" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_Audio_Redraw:
	moveq	#0, d0
	btst	#GlobalOptions_DisableBGM, GlobalOptions
	beq.s	@0
	addq.b	#1*4,d0
@0:
	btst	#GlobalOptions_DisableSFX, GlobalOptions
	beq.s	@1
	addq.b	#2*4,d0
@1:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "AUDIO MODE             %<.l @AudioList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "AUDIO MODE       %<.l @AudioList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@AudioList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'       NORMAL',0
@Str_Mode01:	dc.b	'DISABLE MUSIC',0
@Str_Mode10:	dc.b	'  DISABLE SFX',0
@Str_Mode11:	dc.b	'TOTAL SILENCE',0
		even

; ---------------------------------------------------------------------------
; "AUDIO" handle function
; ---------------------------------------------------------------------------

Options_Audio_Handle:
	move.b	Joypad|Press,d1			; get button presses
	andi.b	#$FC,d1				; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	moveq	#0,d0
	move.b	GlobalOptions, d0
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
	
	and.b	#%11111100, GlobalOptions
	or.b	d0, GlobalOptions

	st.b	Options_RedrawCurrentItem

	moveq	#0,d0
	btst	#GlobalOptions_DisableBGM, GlobalOptions
	beq.s	@0
	move.w	#$E4,d0			; stop music
	jsr	PlayCommand
	move.b	#2,VBlankRoutine
	jsr	DelayProgram
	bra.s	@1
@0:
	jsr	Options_PlayMenuTheme
@1:

	moveq	#%11,d1
	and.b	GlobalOptions, d1
	eori.b	#%00100, ccr			; invert Z flag (play off sound for off, on for anything else)
	bra	Options_PlayRespectiveToggleSound

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "CINEMATIC EFFECTS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_CinematicEffects_Redraw:
	lea	@Str_Cinematic_Locked(pc), a0
	jsr	CheckGlobal_BaseGameBeaten_Casual	; has the player beaten base game in casual?
	beq.s	@0					; if not, branch
	lea	@Str_Cinematic_Normal(pc), a0
@0:
	moveq	#0, d0
	btst	#SlotOptions_CinematicBlackBars, SlotOptions
	beq.s	@1
	addq.b	#1*4,d0
@1:
	btst	#SlotOptions2_MotionBlur, SlotOptions2
	beq.s	@2
	addq.b	#2*4,d0
@2:
	btst	#SlotOptions2_PissFilter, SlotOptions2
	beq.s	@3
	add.b	#4*4,d0
@3:
 if def(__WIDESCREEN__)
	Options_PipeString a4, "%<.l a0 str>       %<.l @CinematicModeList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "%<.l a0 str> %<.l @CinematicModeList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@Str_Cinematic_Normal:
	dc.b	'E CINEMATIC MODE', 0
	even
@Str_Cinematic_Locked:
	dc.b	'E ????????? ????', 0
	even

@CinematicModeList:
	dc.l	@Str_Mode000,@Str_Mode001,@Str_Mode010,@Str_Mode011
	dc.l	@Str_Mode100,@Str_Mode101,@Str_Mode110,@Str_Mode111

@Str_Mode000:	dc.b	'          OFF',0
@Str_Mode001:	dc.b	'   BLACK BARS',0
@Str_Mode010:	dc.b	'  MOTION BLUR',0
@Str_Mode011:	dc.b	'  BARS + BLUR',0
@Str_Mode100:	dc.b	'  PISS FILTER',0
@Str_Mode101:	dc.b	'BARS + FILTER',0
@Str_Mode110:	dc.b	'BLUR + FILTER',0
@Str_Mode111:	dc.b	'   EVERYTHING',0
		even

; ---------------------------------------------------------------------------
; "CINEMATIC Effects" handle function
; ---------------------------------------------------------------------------

Options_CinematicEffects_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, branch

	tst.w	($FFFFFFFA).w		; is debug mode enabled?
	beq.s	@nodebugunlock		; if not, branch
	cmpi.b	#$70,($FFFFF604).w	; is exactly ABC held?
	bne.s	@nodebugunlock		; if not, branch
	jsr	ToggleGlobal_BaseGameBeaten_Casual  ; toggle base game beaten in casual state to toggle the unlock for cinematic mode
	bclr	#SlotOptions_CinematicBlackBars, SlotOptions
	bclr	#SlotOptions2_MotionBlur, SlotOptions2
	bclr	#SlotOptions2_PissFilter, SlotOptions2
	st.b	Options_RedrawCurrentItem
	moveq	#0,d0				; refresh pal directly
	jmp	Options_LoadPal

@nodebugunlock:
	jsr	CheckGlobal_BaseGameBeaten_Casual	; has the player beaten the base game in casual?
	beq.w	Options_PlayDisallowedSound		; if not, branch

	; hint on A
	moveq	#$1C,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed

	moveq	#0,d0
	btst	#SlotOptions_CinematicBlackBars, SlotOptions
	beq.s	@0
	bset	#0,d0
@0	btst	#SlotOptions2_MotionBlur, SlotOptions2
	beq.s	@1
	bset	#1,d0
@1	btst	#SlotOptions2_PissFilter, SlotOptions2
	beq.s	@2
	bset	#2,d0
@2
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.w	#1, d0				; use next mode
	bra.s	@finalize

@selectPrevious:
	subq.w	#1, d0				; use previous mode

@finalize:
	andi.w	#%111, d0			; wrap modes

	bclr	#SlotOptions_CinematicBlackBars, SlotOptions
	btst	#0,d0
	beq.s	@0x
	bset	#SlotOptions_CinematicBlackBars, SlotOptions
@0x
	bclr	#SlotOptions2_MotionBlur, SlotOptions2
	btst	#1,d0
	beq.s	@1x
	bset	#SlotOptions2_MotionBlur, SlotOptions2
@1x
	bclr	#SlotOptions2_PissFilter, SlotOptions2
	btst	#2,d0
	beq.s	@2x
	bset	#SlotOptions2_PissFilter, SlotOptions2
@2x
	tst.b	d0				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

	st.b	Options_RedrawCurrentItem

	moveq	#0,d0				; refresh pal directly
	jmp	Options_LoadPal

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "ERAZOR POWERS" redraw function
; ---------------------------------------------------------------------------

Options_ErazorPowers_Redraw:
	lea	@Str_ErazorPower_Locked(pc), a0
	jsr	CheckGlobal_BaseGameBeaten_Frantic	; has the player beaten the base game in frantic?
	beq.s	@0					; if not, branch
	lea	@Str_ErazorPower_Normal(pc), a0
@0:
	moveq	#0,d0
	btst	#SlotOptions_NonstopInhuman, SlotOptions
	beq.s	@1
	addq.b	#1*4,d0
@1:
	btst	#SlotOptions_SpaceGolf, SlotOptions
	beq.s	@2
	addq.b	#2*4,d0
@2:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "%<.l a0 str>         %<.l @ErazorPowerTextList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "%<.l a0 str>   %<.l @ErazorPowerTextList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@Str_ErazorPower_Normal:
	dc.b	'R ERAZOR POWERS', 0

@Str_ErazorPower_Locked:
	dc.b	'R ?????? ??????', 0
	even

@ErazorPowerTextList:
	dc.l	@Str_Mode00,@Str_Mode01,@Str_Mode10,@Str_Mode11

@Str_Mode00:	dc.b	'         OFF',0
@Str_Mode01:	dc.b	'TRUE INHUMAN',0
@Str_Mode10:	dc.b	'  SPACE GOLF',0
@Str_Mode11:	dc.b	'    ...BOTH?',0
		even

; ---------------------------------------------------------------------------
; "ERAZOR POWERS" handle function
; ---------------------------------------------------------------------------

Options_ErazorPowers_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, branch

	tst.w	($FFFFFFFA).w			; is debug mode enabled?
	beq.s	@nodebugunlock			; if not, branch
	cmpi.b	#$70,($FFFFF604).w		; is exactly ABC held?
	bne.s	@nodebugunlock			; if not, branch
	jsr	ToggleGlobal_BaseGameBeaten_Frantic		; toggle frantic beaten state to toggle the unlock for ERaZor Powers
	bclr	#SlotOptions_NonstopInhuman, SlotOptions	; make sure option doesn't stay accidentally enabled
	bclr	#SlotOptions_SpaceGolf, SlotOptions		; make sure option doesn't stay accidentally enabled
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:		
	jsr	CheckGlobal_BaseGameBeaten_Frantic	; has the player beaten the base game in frantic?
	beq.w	Options_PlayDisallowedSound	; if not, disallowed

	; hint on A
	moveq	#$1D,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed

	moveq	#0,d0
	btst	#SlotOptions_NonstopInhuman, SlotOptions
	beq.s	@0
	bset	#0,d0
@0	btst	#SlotOptions_SpaceGolf, SlotOptions
	beq.s	@1
	bset	#1,d0
@1
	btst	#iLeft, Joypad|Press		; is left pressed?
	bne.s	@selectPrevious			; if yes, branch
	addq.w	#1, d0				; use next mode
	bra.s	@finalize

@selectPrevious:
	subq.w	#1, d0				; use previous mode

@finalize:
	andi.w	#%11, d0			; wrap modes

	bclr	#SlotOptions_NonstopInhuman, SlotOptions
	btst	#0,d0
	beq.s	@0x
	bset	#SlotOptions_NonstopInhuman, SlotOptions
@0x:
	bclr	#SlotOptions_SpaceGolf, SlotOptions
	btst	#1,d0
	beq.s	@1x
	bset	#SlotOptions_SpaceGolf, SlotOptions
@1x:
	st.b	Options_RedrawCurrentItem

	tst.b	d0				; check if current selection is OFF
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound

@ret:	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "TRUE-BS MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_TrueBSMode_Redraw:
	lea	@Str_TrueBSMode_Locked(pc), a0
	jsr	CheckGlobal_BlackoutBeaten	; has the player beaten the blackout challenge?
	beq.s	@0				; if not, branch
	lea	@Str_TrueBSMode_Normal(pc), a0
@0:
	moveq	#0, d0
	btst	#SlotOptions2_PlacePlacePlace, SlotOptions2
	beq.s	@1
	moveq	#4, d0
@1:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "%<.l a0 str>                 %<.l @TrueBSModeTextList(pc,d0) str>", OpLength
 else
	Options_PipeString a4, "%<.l a0 str>           %<.l @TrueBSModeTextList(pc,d0) str>", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
@Str_TrueBSMode_Normal:
	dc.b	'Z TRUE-BS MODE', 0

@Str_TrueBSMode_Locked:
	dc.b	'Z ???? ?? ????', 0
	even

@TrueBSModeTextList:
	dc.l	@Str_Mode00,@Str_Mode01

@Str_Mode00:	dc.b	'  OFF',0
@Str_Mode01:	dc.b	'PLACE',0
		even

; ---------------------------------------------------------------------------
; "TRUE-BS MODE" handle function
; ---------------------------------------------------------------------------

Options_TrueBSMode_Handle:
	moveq	#$FFFFFF00|(Left|Right|A|B|C|Start), d1
	and.b	Joypad|Press, d1		; is left, right, A, B, C, or Start pressed?
	beq.w	@ret				; if not, branch

	tst.w	($FFFFFFFA).w			; is debug mode enabled?
	beq.s	@nodebugunlock			; if not, branch
	cmpi.b	#A|B|C, Joypad|Held		; is exactly ABC held?
	bne.s	@nodebugunlock			; if not, branch
	jsr	ToggleGlobal_BlackoutBeaten	; toggle blackout challenge beaten state to toggle the unlock for nonstop inhuman
	st.b	Options_RedrawCurrentItem
	rts

@nodebugunlock:		
	jsr	CheckGlobal_BlackoutBeaten	; has the player beaten the blackout challenge?
	beq.w	Options_PlayDisallowedSound	; if not, disallowed

	; hint on A
	moveq	#$1E,d0				; ID for the explanation textbox
	bsr	Options_HandleAHint		; show explanation textbox if A is pressed

	moveq	#$FFFFFFE3,d0			; resume at regular speed
	bchg	#SlotOptions2_PlacePlacePlace, SlotOptions2
	bne.s	@on
	moveq	#$FFFFFFE2,d0			; speed up music
@on:	jsr	PlayCommand

	btst	#SlotOptions2_PlacePlacePlace, SlotOptions2
	eori.b	#%00100,ccr			; invert Z flag (play off sound for off, on for anything else)
	bsr	Options_PlayRespectiveToggleSound
	st.b	Options_RedrawCurrentItem
@ret:	rts



; ===========================================================================
; ---------------------------------------------------------------------------
; "RESET LOCAL OPTIONS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_ResetLocalOptions_Redraw:
	moveq	#0, d0
	move.b	Options_DeleteSRAMCounter, d0
	lea	@Str_DeleteSRAMCountDown(pc,d0), a1
 if def(__WIDESCREEN__)
	Options_PipeString a4, "RESET SLOT OPTIONS             %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "RESET SLOT OPTIONS       %<.l a1 str>", OpLength
 endif
	rts

@Str_DeleteSRAMCountDown:
	dcb.b	Options_DeleteSRAMInitialCount, ' '
	dcb.b	Options_DeleteSRAMInitialCount, '>'
	dc.b	0
	even

; ---------------------------------------------------------------------------
Options_ResetLocalOptions_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, return

	subq.b	#1,Options_DeleteSRAMCounter	; sub one from delete counter
	beq.s	@dodelete			; if we reached zero, rip save file
	move.w	#$DF,d0				; play Jester explosion sound
	jsr	PlaySFX
	st.b	Options_RedrawCurrentItem
@ret	rts

@dodelete:
	jsr	Options_SetSlotDefaults

	ori.b	#30,(CameraShake).w
	move.b	#0,(CameraShake_Intensity).w
	jsr	GenerateCameraShake
	move.w	#0,($FFFFF618).w
	moveq	#0,d0				; refresh pal directly
	jsr	Options_LoadPal
	jsr	WhiteFlash

	move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter
	jsr	Options_RedrawAllMenuItems

	move.b	#$B9,d0			; play explosion sound
	jmp	PlaySFX



; ===========================================================================
; ---------------------------------------------------------------------------
; "RESET GLOBAL OPTIONS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_ResetGlobalOptions_Redraw:
	moveq	#0, d0
	move.b	Options_DeleteSRAMCounter, d0
	lea	@Str_DeleteSRAMCountDown(pc,d0), a1
 if def(__WIDESCREEN__)
	Options_PipeString a4, "RESET GLOBAL OPTIONS           %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "RESET GLOBAL OPTIONS     %<.l a1 str>", OpLength
 endif
	rts

@Str_DeleteSRAMCountDown:
	dcb.b	Options_DeleteSRAMInitialCount, ' '
	dcb.b	Options_DeleteSRAMInitialCount, '>'
	dc.b	0
	even

; ---------------------------------------------------------------------------
Options_ResetGlobalOptions_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@ret			; if not, return

	subq.b	#1,Options_DeleteSRAMCounter	; sub one from delete counter
	beq.s	@dodelete			; if we reached zero, rip save file
	move.w	#$DF,d0				; play Jester explosion sound
	jsr	PlaySFX
	st.b	Options_RedrawCurrentItem
@ret	rts

@dodelete:
	jsr	Options_SetGlobalDefaults

	ori.b	#30,(CameraShake).w
	move.b	#0,(CameraShake_Intensity).w
	jsr	GenerateCameraShake
	move.w	#0,($FFFFF618).w
	moveq	#0,d0				; refresh pal directly
	jsr	Options_LoadPal
	jsr	WhiteFlash

	move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter
	jsr	Options_RedrawAllMenuItems


	move.b	#$B9,d0			; play explosion sound
	jsr	PlaySFX
	tst.b	($FFFFFF84).w
	bne.s	@firststart
	move.b	#Options_Music,d0
	jsr	PlayBGM
@firststart:
	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; "BLACK BARS MODE" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_BlackBarsMode_Redraw:
	lea	@Str_BlackBars_Emulator(pc), a1
	tst.b	BlackBars.HandlerId
	beq.s	@0
	lea	@Str_BlackBars_Hardware(pc), a1
@0:

 if def(__WIDESCREEN__)
	Options_PipeString a4, "BLACK BARS SETUP            %<.l a1 str>", OpLength
 else
	Options_PipeString a4, "BLACK BARS SETUP      %<.l a1 str>", OpLength
 endif
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



; ===========================================================================
; ---------------------------------------------------------------------------
; "EXIT OPTIONS" redraw function
; ---------------------------------------------------------------------------
; INPUT:
;	a4	= `Options_DrawMenuItem_Normal` or `Options_DrawMenuItem_Highlighted`
; ---------------------------------------------------------------------------

Options_Exit_Redraw:
	tst.b	($FFFFFF84).w
	bne.s	@firststart

 if def(__WIDESCREEN__)
	Options_PipeString a4, "      SAVE + EXIT OPTIONS MENU        ", OpLength
	rts
  	@firststart:
	Options_PipeString a4, "             START GAME               ", OpLength
 else
	Options_PipeString a4, "   SAVE + EXIT OPTIONS MENU   ", OpLength
	rts
	@firststart:
	Options_PipeString a4, "          START GAME          ", OpLength
 endif
	rts

; ---------------------------------------------------------------------------
; "EXIT OPTIONS" handle function
; ---------------------------------------------------------------------------

Options_Exit_Handle:
	move.b	Joypad|Press,d1		; get button presses
	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
	beq.w	@done			; if not, branch

	; randomize background color on left/right
	andi.b	#$C,d1
	beq.s	@exit
	jsr	RandomNumber
	andi.w	#$EEE,d0
	move.w	d0,(BGThemeColor).w
	move.w	#$A9,d0			; play blip sound
	jmp	PlaySFX

@exit:
	st.b	Options_Exiting		; exit options menu
@done:	rts



; ---------------------------------------------------------------------------
; Helper functions and data
; ---------------------------------------------------------------------------

Options_PlayDisallowedSound:
	move.w	#$DC,d0			; play option disallowed sound
	jmp	PlaySFX

; ---------------------------------------------------------------------------
Options_PlayRespectiveToggleSound:
	beq.s	@toggleOn

@toggleOff:
	move.w	#$DA,d0			; play option toggled off sound
	jmp	PlaySFX

; ---------------------------------------------------------------------------
Options_PlayRespectiveToggleSound2: equ *
	bne.s	@toggleOff

@toggleOn:
	move.w	#$D9,d0			; play option toggled on sound
	jmp	PlaySFX

; ---------------------------------------------------------------------------
Options_Str_On:	dc.b	' ON', 0
Options_Str_Off:dc.b	'OFF', 0
	even

; ===========================================================================
; ---------------------------------------------------------------------------
; Handler for bonus information when pressing A (specific options only)
; ---------------------------------------------------------------------------

Options_HandleAHint:
	btst	#6,Joypad|Press		; is specifically A pressed?
	beq.s	@end			; if not, branch

	move.l	d0,-(sp)		; backup ID

	moveq	#0,d0			; play option toggled on sound
	bsr	Options_PlayRespectiveToggleSound

	jsr 	Pal_FadeOut		; darken background...
	jsr 	Pal_FadeOut		; ...twice
	moveq	#$1D,d0			; load tutorial box palette...
	jsr	PalLoad2		; ...directly

	move.l	(sp)+,d0		; restore ID
	jsr	TutorialBox_Display	; VLADIK => Display hint

	moveq	#0,d0			; refresh options pal directly
	jsr	Options_LoadPal

	addq.l	#4,sp			; skip remaining stuff in the option handler
@end:
	rts

; ---------------------------------------------------------------------------
; ===========================================================================