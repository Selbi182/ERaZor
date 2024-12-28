
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic 1 ERaZor - Save Select Screen
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

SaveSelect_VRAM_Font:		equ	$4000
SaveSelect_FG_VRAM:		equ	$8000

SaveSelect_ConsoleRAM:	equ	LevelLayout_FG		; borrow FG layout RAM

SaveSelectScreen:
	moveq	#$FFFFFFE0, d0
	jsr	PlayCommand
	jsr	Pal_FadeFrom
	jsr	PLC_ClearQueue
	jsr	DrawBuffer_Clear

	display_disable
	VBlank_SetMusicOnly

	; VDP setup
	lea	VDP_Ctrl, a6
	move.w	#$8004, (a6)
	move.w	#$8230, (a6)
	move.w	#$8400|(SaveSelect_FG_VRAM/$2000), (a6)
	move.w	#$9001, (a6)
	move.w	#$9200, (a6)
	move.w	#$8B03, (a6)
	move.w	#$8720, (a6)
	jsr	ClearScreen

	; Clear object RAM
	lea	Objects, a1
	moveq	#0, d0
	move.w	#(Objects_End-Objects)/$40-1, d1

	@clear_obj_ram_loop:
		rept $40/4
			move.l	d0, (a1)+
		endr
		dbf	d1, @clear_obj_ram_loop

	assert.w a1, eq, #Objects_End

	jsr	BackgroundEffects_Setup
	move.w	#$824,(BGThemeColor).w	; set theme color for background effects

	jsr	SaveSelect_InitUI
	jsr	SaveSelect_InitialDraw

	VBlank_UnsetMusicOnly
	display_enable

	move.b	#Options_Music, d0
	jsr	PlayBGM

	jsr	Pal_FadeTo
	assert.b VBlank_MusicOnly, eq
	; fallthrough

; ---------------------------------------------------------------------------
; Save select screen - Main Loop
; ---------------------------------------------------------------------------

SaveSelect_MainLoop:
	move.b	#4, VBlankRoutine
	move.l	#SaveSelect_HandleUI, VBlankCallback
	jsr	DelayProgram

	jsr	BackgroundEffects_Update
	bra.s	SaveSelect_MainLoop


; ---------------------------------------------------------------------------
; UI Routines
; ---------------------------------------------------------------------------

SaveSelect_InitUI:
	; Initialize console subsystem (MD Debugger)
	lea	VDP_Ctrl, a5
	lea	-4(a5), a6
	lea	@ConsoleConfig(pc), a1			; a1 = console config
	lea	SaveSelect_ConsoleRAM, a3		; a3 = console RAM
	vram	SaveSelect_FG_VRAM, d5			; d5 = base draw position
	jsr	MDDBG__Console_InitShared

	; Load palette
	lea	Pal_Target+$20, a0
	lea	@PaletteData_Highlighted(pc), a1
	rept 8/2
		move.l	(a1)+, (a0)+
	endr
	lea	Pal_Target+$40, a0
	lea	@PaletteData_Normal(pc), a1
	rept 8/2
		move.l	(a1)+, (a0)+
	endr

	; Load font
	vram	SaveSelect_VRAM_Font, (a5)
	lea	BBCS_ArtKospM_Font(pc), a0		; ### TODO: Replace or dedup
	jmp	KosPlusMDec_VRAM

; ---------------------------------------------------------------
@ConsoleConfig:
	dc.w	40				; number of characters per line
	dc.w	40				; number of characters on the first line (meant to be the same as the above)
	dc.w	$8000|(SaveSelect_VRAM_Font/$20)-('!'-1)	; base font pattern (tile id for ASCII $00 + palette flags)
	dc.w	$80				; size of screen row (in bytes)

	dc.w	$2000/$20-1			; size of screen (in tiles - 1)

@PaletteData_Highlighted:
	dc.w	$0000, $0444, $0EEE, $0EEE, $0EEE, $0EEE, $0CCC, $0AAA

@PaletteData_Normal:
	dc.w	$0000, $0444/2, $0EEE/2, $0EEE/2, $0EEE/2, $0EEE/2, $0CCC/2, $0AAA/2

; ---------------------------------------------------------------------------

SaveSelect_InitialDraw:
	moveq	#0, d0
	bsr	SaveSelect_DrawSlot

	moveq	#1, d0
	bsr	SaveSelect_DrawSlot

	moveq	#2, d0
	bsr	SaveSelect_DrawSlot

	moveq	#3, d0
	bsr	SaveSelect_DrawSlot
	rts

; ---------------------------------------------------------------------------
; INPUT:
;	d0 - Slot Id
; ---------------------------------------------------------------------------

SaveSelect_DrawSlot:
	lea	@Cursor_Selected(pc), a1	; use selected cursor
	cmp.b	SaveSlotId, d0			; are we selected slot?
	beq.s	@cursor_done
	lea	@Cursor_Normal(pc), a1		; use no cursor
@cursor_done:

	moveq	#1, d1				; Y-position for "No Save"
	tst.b	d0				; are we "No Save"?
	beq	@draw_no_save			; if yes, branch

	; Draw "Slot X"
	moveq	#0, d1
	move.b	d0, d1
	mulu.w	#8, d1
	subq.w	#4, d1				; Y-position for "Slot X"

	_Console.SetXY #1, d1
	_Console.Write "%<.l a1 str>SLOT %<.b d0 dec>%<endl>%<endl>%<setx,4>"
	_Console.Write "SCORE: %<.l Score dec>%<endl>"
	_Console.Write "RINGS: %<.w Rings dec>%<endl>"
	_Console.Write "DEATHS: %<.w Deaths dec>%<endl>"
	_Console.Write "DOORS: %<.w Doors_Casual bin>"
	rts

@draw_no_save:
	_Console.SetXY #1, d1
	_Console.Write "%<.l a1 str>NO SAVE"
	rts

; ---------------------------------------------------------------------------
@Cursor_Selected:
	dc.b	pal1, '> ', 0

@Cursor_Normal:
	dc.b	pal2, '  ', 0

; ---------------------------------------------------------------------------

SaveSelect_HandleUI:
	move.b	Joypad|Press, d0
	btst	#iUp, d0
	bne.s	@PreviousSelection
	btst	#iDown, d0
	bne.s	@NextSelection
	rts

@NextSelection:
	move.b	SaveSlotId, d7			; d7 = previous selection
	move.b	d7, d0
	addq.b	#1, d0
	and.b	#3, d0
	bra.s	@UpdateSelection

@PreviousSelection:
	move.b	SaveSlotId, d7			; d7 = previous selection
	move.b	d7, d0
	subq.b	#1, d0
	and.b	#3, d0

@UpdateSelection:
	move.b	d0, SaveSlotId
	jsr	SaveSelect_DrawSlot		; re-draw newly selected slot
	move.b	d7, d0
	jsr	SaveSelect_DrawSlot		; re-draw unselected slot
	moveq	#$FFFFFFD8, d0
	jmp	PlaySFX
