
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic 1 ERaZor - Black Bars Configuration Screen
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

BlackBarsConfig_VRAM_Font:		equ	$8000

BlackBarsConfig_ConsoleRAM:		equ	LevelLayout_FG		; borrow FG layout RAM
BlackBarsConfig_SelectedItemId:		equ	LevelLayout_FG+$40	; .b
BlackBarsConfig_RedrawUI:		equ	LevelLayout_FG+$41	; .b
BlackBarsConfig_JoypadHeldTimers:	equ	LevelLayout_FG+$42
BlackBarsConfig_Exiting:		equ	LevelLayout_FG+$43

; -----------------------------------------------------------------------------
BlackBarsConfigScreen:
	moveq	#$FFFFFFE0, d0
	jsr	PlaySound_Special
	jsr	Pal_FadeFrom
	jsr	PLC_ClearQueue
	jsr	DrawBuffer_Clear

	display_disable
	VBlank_SetMusicOnly

	; VDP setup
	lea	VDP_Ctrl, a6
	move.w	#$8004, (a6)
	move.w	#$8230, (a6)
	move.w	#$8407, (a6)
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

	; Load giant ring patterns
	moveq	#$1D, d0
	jsr 	PLC_ExecuteOnce

	; Load Sonic's palette
	moveq	#3, d0
	jsr	PalLoad1

	; Init level
	move.w	#$200, CurrentLevel			; set level to MZ
	jsr	BlackBarsConfigScreen_LoadLevel
	jsr	BlackBarsConfigScreen_InitCamera
	jsr	BlackBarsConfigScreen_GenerateSprites
	jsr	LevelRenderer_DrawLayout_BG

	; Init screen
	move.w	#BlackBars.MaxHeight, BlackBars.Height
	move.b	#0,BlackBarsConfig_Exiting
	jsr	BlackBarsConfigScreen_InitUI

	; Overwrite default console font 
	vram	$8000
	lea	($C00000).l,a6
	lea	(ArtKospM_FontOverrideArt).l,a0
	jsr	KosPlusMDec_VRAM
	
	; Brighten up white palette for better legibility
	move.w	#$EEE,d0
	move.w	d0,($FFFFFB84).w
	move.w	d0,($FFFFFB86).w
	move.w	d0,($FFFFFB88).w
	move.w	d0,($FFFFFB8A).w
	move.w	d0,($FFFFFB8C).w
	move.w	#$CCC,($FFFFFB8E).w

	VBlank_UnsetMusicOnly
	display_enable

	move.w	#$8014, VDP_Ctrl		; enable HInt-s

	jsr	Pal_FadeTo

; ---------------------------------------------------------------
; Main Loop
; ---------------------------------------------------------------

@MainLoop:
	move.b	#4, VBlankRoutine
	jsr	DelayProgram

	jsr	RandomNumber			; better RNG please
	jsr	BlackBarsConfigScreen_MoveCamera
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	ChangeRingFrame
	jsr	PCL_Load
	jsr	BlackBarsConfigScreen_DeformBG
	jsr	LevelRenderer_Update_BG

	tst.b	BlackBarsConfig_Exiting		; is exiting flag set?
	bne.s	@exiting			; if yes, ignore button presses

	; toggle selection on up/down
	moveq	#0,d0
	move.b	Joypad|Press,d0
	andi.b	#Up|Down, d0
	bne.s	@toggle

	; quit screen on other button press
	move.b	Joypad|Press,d0
	andi.b	#A|B|C|Start,d0
	beq.s	@MainLoop
	move.b	#1,BlackBarsConfig_Exiting	; set exiting flag
	move.l	#BlackBarsConfigScreen_RedrawUI, VBlankCallback	; redraw one last time
; ---------------------------------------------------------------

@exiting:
	cmpi.w	#224/2,BlackBars.Height		; did we fill up the full screen?
	bhs.s	@exit				; if yes, branch
	addq.w	#4,BlackBars.Height		; grow black bars
	bra.s	@MainLoop			; loop
; ===============================================================

@exit:
	jsr	Pal_CutToBlack			; fill remaining palette to black for a smooth transition
	move.w	#0,BlackBars.Height		; reset black bars
	jmp	Exit_BlackBarsScreen		; exit to Sega screen
; ===============================================================

@toggle:
	bchg	#1, BlackBars.HandlerId		; toggle selected option
	jsr	BlackBars.SetHandler
	move.l	#BlackBarsConfigScreen_RedrawUI, VBlankCallback	; defer redraw to VInt
	bra.w	@MainLoop

 ; ---------------------------------------------------------------
; ===============================================================


; ===============================================================
; ---------------------------------------------------------------
; Loads zone art and data
; ---------------------------------------------------------------
; NOTICE: This should be executed with display off
; ---------------------------------------------------------------

BlackBarsConfigScreen_LoadLevel:
	; Load level art block
	moveq	#0, d0
	move.b	CurrentZone, d0
	lsl.w	#4, d0
	lea 	MainLoadBlocks, a2
	lea 	(a2,d0.w), a2
	moveq	#0,d0
	move.b	(a2), d0
	beq.s	@skip_plc
	move.l	a2, -(sp)
	jsr 	PLC_ExecuteOnce			; clear PLC queue, decompress art immediately
	move.l	(sp)+, a2
@skip_plc:
	
	; Load level 16x16 blocks
	addq.l	#4, a2
	move.l	(a2)+, BlocksAddress

	; Load level chunks
	movea.l (a2)+, a0
	lea 	ChunksArray, a1			; RAM address for 256x256 mappings
	jsr 	KosPlusDec

	; Load level layout (BG only)
	jsr	LevelLayoutLoad_BG

	; Load level palette
	addq.w	#2, a2
	move.w	(a2)+, d0
	andi.w	#$FF, d0
	jmp	PalLoad1			; load palette (based on d0)

; ===============================================================
; ---------------------------------------------------------------
; Initializes camera
; ---------------------------------------------------------------

BlackBarsConfigScreen_InitCamera:
	move.w	#$0000, d1		; X
	move.w	#$0340, d0		; Y
	move.w	d1, CamXpos
	move.w	d0, CamYpos
	jsr	BgScrollSpeed		; IN: d0, d1
	moveq	#0, d2
	move.l	d2, CamXpos3
	move.l	#$40000/4, CamYpos3
	; fallthrough

; ---------------------------------------------------------------
; Deforms the background (stub)
; ---------------------------------------------------------------

BlackBarsConfigScreen_DeformBG:
	move.w	CamYpos2, ($FFFFF618).w	; update plane B vs-ram

	lea	HSRAM_Buffer, a1

	moveq	#0, d0
	move.w	CamXPos2, d0
	neg.w	d0

	moveq	#240/16-1, d1		; repeat to cover the entire 240-pixel screen
	jmp	DeformScreen_SendBlocks

; ---------------------------------------------------------------
; Moves da camera
; ---------------------------------------------------------------

BlackBarsConfigScreen_MoveCamera:

@speed_divider:	= 4

	move.l	CamXpos3, d0
	add.l	d0, CamXpos2
	move.l	CamYpos3, d1
	add.l	d1, CamYpos2

	add.l	d0, d0
	add.l	d1, d1
	add.l	d0, CamXpos
	add.l	d1, CamYpos

	cmpi.w	#$400+$200, CamXpos2
	blt.s	@j0
	cmpi.l	#-$4C000/@speed_divider, CamXpos3
	ble.s	@y
	sub.l	#$C00/@speed_divider, CamXpos3
	bra.s	@y
	rts

@j0:	cmpi.w	#$300, CamXpos2
	bgt.s	@j1
	cmpi.l	#$4C000/@speed_divider, CamXpos3
	bge.s	@y
	add.l	#$C00/@speed_divider, CamXpos3
@j1:

@y:	cmpi.w	#$200+$200, CamYpos2
	blt.s	@j2
	cmpi.l	#-$4C000/@speed_divider, CamYpos3
	ble.s	@ret
	sub.l	#$1C00/@speed_divider, CamYpos3
@ret:	rts

@j2:	cmpi.w	#$320, CamYpos2
	bgt.s	@j3
	cmpi.l	#$4C000/@speed_divider, CamYpos3
	bge.s	@ret
	add.l	#$1C00/@speed_divider, CamYpos3
@j3:
	rts

; ===============================================================
; ---------------------------------------------------------------
; Generates shitton of objects
; ---------------------------------------------------------------

BlackBarsConfigScreen_GenerateSprites:
	lea	@RingData(pc), a4
	move.w	CamXPos, d2
	move.w	CamYPos, d3

	@MakeRings:
		tst.w	(a4)
		bmi.s	@ret
		jsr	SingleObjLoad
		move.b	#$8D, (a1)
		move.l	#@Obj_Ring, $3C(a1)
		movem.w	(a4)+, d0/d1
		add.w	d2, d0
		add.w	d3, d1
		move.w	d0, 8(a1)
		move.w	d1, $C(a1)
		bra.s	@MakeRings

@ret:	rts

; ---------------------------------------------------------------
@RingData:
	dc.w	$0, $0
	dc.w	$54, $80
	dc.w	$54*2, $0
	dc.w	$54*3, $80

	dc.w	-1	; TODO proper screen wrapping
	dc.w	$0+320, $0+224
	dc.w	$54+320, $80+224
	dc.w	$54*2+320, $0+224
	dc.w	$54*3+320, $80+224
	dc.w	-1

; ---------------------------------------------------------------
@Obj_Ring:
	move.l	#Map_obj4B,obMap(a0)
	move.w	#$2000|($A200/$20),obGfx(a0)
	ori.b	#4,obRender(a0)
	move.b	#$60,obActWid(a0)
	move.b	#4,obPriority(a0)
	move.l	#@Main, $3C(a0)

@Main:
	move.w	8(a0), d0
	sub.w	CamXPos, d0
	cmpi.w	#-8, d0
	bge.s	@j0
	add.w	#320+16, 8(a0)
	bra.s	@xok

@j0:	cmp.w	#320+8, d0
	ble.s	@xok
	sub.w	#320+16, 8(a0)

@xok:
	move.w	$C(a0), d0
	sub.w	CamYPos, d0
	cmpi.w	#-8, d0
	bge.s	@j1
	add.w	#224+16, $C(a0)
	bra.s	@yok

@j1:	cmp.w	#224+8, d0
	ble.s	@yok
	sub.w	#224+16, $C(a0)

@yok:
	move.b	($FFFFFEC3).w, obFrame(a0)
	jmp	DisplaySprite


; ===============================================================
; ---------------------------------------------------------------
; Initialize screen UI
; ---------------------------------------------------------------
; WARNING:
; This should be called after `BlackBarsConfigScreen_LoadLevel`!
; Otherwise it will overwrite this screen's memory
; ---------------------------------------------------------------

BBCS_EnterConsole:	macro scratchReg
	move.l	usp, \scratchReg
	move.l	\scratchReg, -(sp)
	lea	BlackBarsConfig_ConsoleRAM, \scratchReg
	move.l	\scratchReg, usp
	endm

BBCS_LeaveConsole:	macro scratchReg
	move.l	(sp)+, \scratchReg
	move.l	\scratchReg, usp
	endm

; ---------------------------------------------------------------
BlackBarsConfigScreen_InitUI:
	lea	VDP_Ctrl, a5
	lea	-4(a5), a6

	; Load font
	vram	BlackBarsConfig_VRAM_Font, (a5)		; VDP => Setup font offset in VRAM
	lea	MDDBG__Art1bpp_Font, a0		; a0 = 1bpp source art
	lea	@ArtDecodeTable(pc), a1		; a1 = 1bpp decode table
	move.w	(a0)+, d4			; d4 = font size - 1
	jsr	MDDBG__Decomp1bpp		; decompress font (input: a0-a1/a6, uses: a0/d0-d4)

	; Initialize console subsystem (MD Debugger)
	lea	@ConsoleConfig(pc), a1			; a1 = console config
	lea	BlackBarsConfig_ConsoleRAM, a3		; a3 = console RAM
	jsr	MDDBG__Console_InitShared

	; Initial UI header
	bra	BlackBarsConfigScreen_WriteText

; ---------------------------------------------------------------
@ArtDecodeTable:
	dc.w	$0000, $0006, $0060, $0066	; decompression table for 6bpp nibbles
	dc.w	$0600, $0606, $0660, $0666	; ''
	dc.w	$6000, $6006, $6060, $6066	; ''
	dc.w	$6600, $6606, $6660, $6666	; ''

; ---------------------------------------------------------------
@ConsoleConfig:
	dcvram	$C000				; screen start address / plane nametable pointer
	dcvram	$FC00				; HSRAM address
	dc.w	$00				; VSRAM address

	dc.w	40				; number of characters per line
	dc.w	40				; number of characters on the first line (meant to be the same as the above)
	dc.w	$8000|(BlackBarsConfig_VRAM_Font/$20)-('!'-1)	; base font pattern (tile id for ASCII $00 + palette flags)
	dc.w	$80				; size of screen row (in bytes)

	dc.w	$2000/$20-1			; size of screen (in tiles - 1)

; ---------------------------------------------------------------
; Redraws screen UI
; ---------------------------------------------------------------

BlackBarsConfigScreen_WriteText:
	BBCS_EnterConsole a0

	Console.SetXY #12, #6
	Console.Write "  SONIC ERAZOR"
	Console.Write "%<endl>%<endl>"
	Console.Write "BLACK BARS SETUP"

	Console.SetXY #4, #20
	Console.Write "PICK THE FIRST IF YOU'RE UNSURE."
	Console.Write "%<endl>%<endl>"
	Console.Write "   BOTH BARS MUST BE VISIBLE!"

	BBCS_LeaveConsole a0
	; fallthrough
; ---------------------------------------------------------------

BlackBarsConfigScreen_RedrawUI:
	BBCS_EnterConsole a0
	Console.SetXY #6, #13
	bsr	@write
	BBCS_LeaveConsole a0
	rts

; ---------------------------------------------------------------
@write:
	tst.b	BlackBars.HandlerId	; is real hardware selected?
	bne.w	@realhardware		; if yes, render alternate text
	; fallthrough on emulators

@emulators:
	Console.Write "%<pal0>> OPTIMIZED FOR EMULATORS"
	Console.Write "%<endl>%<endl>"
	Console.Write "%<pal2>  OPTIMIZED FOR REAL HARDWARE"
	rts

@realhardware:
	Console.Write "%<pal2>  OPTIMIZED FOR EMULATORS"
	Console.Write "%<endl>%<endl>"	
	tst.b	BlackBarsConfig_Exiting
	bne.s	@hweaster
	Console.Write "%<pal0>> OPTIMIZED FOR REAL HARDWARE"
	rts
@hweaster:
	Console.Write '%<pal0>> "WINNERS DON''T USE GENS"   '
	rts
; ---------------------------------------------------------------
; ===============================================================


; ===============================================================
ArtKospM_FontOverrideArt:
	incbin	Screens\BlackBarsConfigScreen\Font_Override.kospm
	even
; ===============================================================