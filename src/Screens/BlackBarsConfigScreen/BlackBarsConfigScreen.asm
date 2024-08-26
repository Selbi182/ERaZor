
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

	; Load main patterns
	moveq	#0, d0
	jsr 	PLC_ExecuteOnce

	; Load Sonic's palette
	moveq	#3, d0
	jsr	PalLoad1

	; Init level
	move.w	#$0500, CurrentLevel			; set level to SBZ
	jsr	BlackBarsConfigScreen_LoadLevel
	jsr	BlackBarsConfigScreen_InitCamera
	jsr	BlackBarsConfigScreen_GenerateSprites
	jsr	LevelRenderer_DrawLayout_BG

	; Init screen
	move.w	#32, BlackBars.Height
	jsr	BlackBarsConfigScreen_InitUI

	VBlank_UnsetMusicOnly
	display_enable

	move.w	#$8014, VDP_Ctrl		; enable HInt-s

	jsr	Pal_FadeTo

@MainLoop:
	move.b	#4, VBlankRoutine
	jsr	DelayProgram

	jsr	RandomNumber			; better RNG please
	jsr	BlackBarsConfigScreen_HandleUI
	jsr	BlackBarsConfigScreen_MoveCamera
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	ChangeRingFrame
	jsr	PCL_Load
	jsr	BlackBarsConfigScreen_DeformBG
	jsr	LevelRenderer_Update_BG

	andi.b	#A|B|C|Start,Joypad|Press
	beq.s	@MainLoop
	jmp	Exit_BlackBarsScreen

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

	; Load level layout
	jsr	LevelLayoutLoad

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
	move.w	#$0300, d0		; Y
	move.w	d1, CamXpos
	move.w	d0, CamYpos
	jsr	BgScrollSpeed		; IN: d0, d1
	moveq	#0, d2
	move.l	d2, CamXpos3
	move.l	#$4C000, CamYpos3
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
;	add.l	d1, CamYpos2

	add.l	d0, d0
	add.l	d1, d1
	add.l	d0, CamXpos
;	add.l	d1, CamYpos

	cmpi.w	#$400+$100, CamXpos2
	blt.s	@j0
	cmpi.l	#-$4C000/@speed_divider, CamXpos3
	ble.s	@y
	sub.l	#$C00/@speed_divider, CamXpos3
	bra.s	@y
	rts

@j0:	cmpi.w	#$100, CamXpos2
	bgt.s	@j1
	cmpi.l	#$4C000/@speed_divider, CamXpos3
	bge.s	@y
	add.l	#$C00/@speed_divider, CamXpos3
@j1:

@y:	cmpi.w	#$200+$100, CamYpos2
	blt.s	@j2
	cmpi.l	#-$4C000/@speed_divider, CamYpos3
	ble.s	@ret
	sub.l	#$1C00/@speed_divider, CamYpos3
@ret:	rts

@j2:	cmpi.w	#$100, CamYpos2
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
	dc.w	$20, $10
	dc.w	$40, $10
	dc.w	$60, $10
	dc.w	$80, $10

	dc.w	$50, $28
	dc.w	$50, $28+$18
	dc.w	$50, $28+$18*2
	dc.w	$50, $28+$18*3

	dc.w	$80+$20, $40
	dc.w	$80+$40, $40
	dc.w	$80+$60, $40
	dc.w	$80+$80, $40
	dc.w	$80+$A0, $40

	dc.w	$70+$50, $78+$18*0
	dc.w	$70+$50, $78+$18*1
	dc.w	$70+$50, $78+$18*2
	dc.w	$70+$50, $78+$18*3
	dc.w	$70+$50, $78+$18*4

	dc.w	$120-$18*0, $A0
	dc.w	$120-$18*1, $A0
	dc.w	$120-$18*2, $A0
	dc.w	$120-$18*3, $A0

	dc.w	$00+$20, $C0
	dc.w	$00+$40, $C0
	dc.w	$00+$60, $C0
	dc.w	$00+$80, $C0
	dc.w	$00+$A0, $C0

	dc.w	-1

; ---------------------------------------------------------------
@Obj_Ring:
	move.l	#Map_obj25,obMap(a0)
	move.w	#$27B2,obGfx(a0)
	ori.b	#4,obRender(a0)
	move.b	#8,obActWid(a0)
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
	BBCS_EnterConsole a0
	Console.SetXY #4, #7
	Console.Write "Select the BLACK BARS mode%<endl>"
	Console.Write "that works best on your system!"

	Console.SetXY #4, #19
	Console.Write "%<pal2>Make sure both bars are visible%<endl>"
	Console.Write "%<pal2>and that there are no audio quirks.%<endl>"
	Console.Write "%<pal2>When in doubt, pick option one."

	BBCS_LeaveConsole a0

	bra	BlackBarsConfigScreen_RedrawUI

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

BlackBarsConfigScreen_RedrawUI:
	BBCS_EnterConsole a0

	Console.SetXY #6, #13

	tst.b	BlackBars.HandlerId
	bne.s	@1
	Console.Write "%<pal0>> Optimized for Emulators%<endl>%<endl>"
	Console.Write "%<pal2>  Optimized for Real Hardware"

	BBCS_LeaveConsole a0
	rts

@1:	Console.Write "%<pal2>  Optimized for Emulators%<endl>%<endl>"
	Console.Write "%<pal0>> Optimized for Real Hardware"

	BBCS_LeaveConsole a0
	rts

; ===============================================================
; ---------------------------------------------------------------
; Handle screen UI
; ---------------------------------------------------------------

BlackBarsConfigScreen_HandleUI:
	moveq	#Up|Down, d0
	and.b	Joypad|Press, d0
	beq.s	@Done

	bchg	#1, BlackBars.HandlerId
	jsr	BlackBars.SetHandler

	move.l	#BlackBarsConfigScreen_RedrawUI, VBlankCallback	; defer redraw to VInt
@Done:	rts
