
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic ERaZor 8 - Black Bars Configuration Screen
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

BlackBarsConfig_VRAM_Font:		equ	$8000

BlackBarsConfig_ConsoleRAM:		equ	LevelLayout_FG		; borrow FG layout RAM
BlackBarsConfig_ConsoleUSP:		equ	LevelLayout_FG+$3C	; .l
BlackBarsConfig_SelectedItemId:		equ	LevelLayout_FG+$40	; .b
BlackBarsConfig_RedrawUI:		equ	LevelLayout_FG+$41	; .b
BlackBarsConfig_JoypadHeldTimers:	equ	LevelLayout_FG+$42	; .b
BlackBarsConfig_Exiting:		equ	LevelLayout_FG+$43	; .b
BlackBarsConfig_PreTextActive:		equ	LevelLayout_FG+$44	; .b

; -----------------------------------------------------------------------------
BlackBarsConfigScreen:
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
	jsr	BlackBarsConfigScreen_InitUI
	move.b	#0, BlackBarsConfig_Exiting

	if def(__WIDESCREEN__)
		move.w	#0, BlackBars.Height
		move.b	#1, BlackBarsConfig_PreTextActive
		jsr	BlackBarsConfigScreen_WriteText_WidescreenInfo
	else
		move.w	BlackBars.BaseHeight, BlackBars.Height
		move.b	#0, BlackBarsConfig_PreTextActive
		jsr	BlackBarsConfigScreen_WriteText
	endif

	; Brighten up white palette for better legibility
	move.w	#$EEE,d0
	move.w	d0,($FFFFFB84).w
	move.w	d0,($FFFFFB86).w
	move.w	d0,($FFFFFB88).w
	move.w	d0,($FFFFFB8A).w
	move.w	d0,($FFFFFB8C).w
	move.w	#$CCC,($FFFFFB8E).w
	
	move.w	#$000,($FFFFFBC0).w	; BG color

	VBlank_UnsetMusicOnly
	display_enable

	move.w	#$8014, VDP_Ctrl		; enable HInt-s

	jsr	Pal_FadeTo
	
; ---------------------------------------------------------------
; Main Loop
; ---------------------------------------------------------------

BlackBarsConfigScreen_MainLoop:
	move.b	#4, VBlankRoutine
	jsr	DelayProgram

	jsr	BlackBarsConfigScreen_MoveCamera
	DeleteQueue_Init
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	DeleteQueue_Execute
	jsr	ChangeRingFrame
	jsr	PCL_Load
	jsr	BlackBarsConfigScreen_DeformBG
	jsr	LevelRenderer_Update_BG

; ---------------------------------------------------------------
; Input Response
	tst.b	BlackBarsConfig_Exiting		; is exiting flag set?
	bne.w	@exiting			; if yes, ignore button presses

 if def(__WIDESCREEN__)
	; pre-text for the widescreen version
	moveq	#0,d0
	tst.b	BlackBarsConfig_PreTextActive	; is pre-text currently active?
	beq.w	@chkbaseheightadjust		; if not, branch
	andi.b	#Start|A|B|C,Joypad|Press		; anything pressed?
	beq.w	BlackBarsConfigScreen_MainLoop	; if not, loop

	bra.s	@SwapToBlackBarsSetup
	;tst.b	(CarryOverData).w		; is next game mode set to be options screen?
	;bne.s	@SwapToBlackBarsSetup		; if yes, always switch to black bars setup
	;jsr	CheckGlobal_BlackBarsConfigured	; have we already configured black bars upon first boot?
	;beq.s	@SwapToBlackBarsSetup		; if yes, swap to black bars setup
	move.b	#1,BlackBarsConfig_Exiting	; otherwise, directly exit the screen to make it less annoying
	bra.w	BlackBarsConfigScreen_MainLoop	; loop to start
 
 @SwapToBlackBarsSetup:
	VBlank_SetMusicOnly
	move.w	#$A9,d0
	jsr	PlaySFX
	jsr	ClearPlaneA
	clr.b	BlackBarsConfig_PreTextActive
	jsr	BlackBarsConfigScreen_WriteText_Controls
;	jsr	BlackBarsConfigScreen_WriteText
;	move.w	BlackBars.BaseHeight, BlackBars.Height
	VBlank_UnsetMusicOnly
	bra.w	BlackBarsConfigScreen_MainLoop
 endif

@chkbaseheightadjust:
	; adjust black bars base height on B + up/down
	;moveq	#0,d0
	;move.b	Joypad|Held,d0
	;btst	#iB,d0
	;beq.s	@chktoggle
	;btst	#iStart,Joypad|Press
	;bne.w	BlackBars_AdjustBaseHeight_Reset
	;andi.b	#Up|Down,d0
	;bne.w	BlackBars_AdjustBaseHeight

@chktoggle:
	; toggle selection on up/down
	;moveq	#0,d0
	;move.b	Joypad|Press,d0
	;andi.b	#Up|Down, d0
	;bne.s	@toggle
	
@chkexit:
	; quit screen on other button press
	moveq	#0,d0
	move.b	Joypad|Press,d0
	andi.b	#A|B|C|Start,d0
	beq.w	BlackBarsConfigScreen_MainLoop

	andi.b	#B,d0
	beq.s	@notb
	jsr	SetGlobal_BlackBarsConfigured
	jsr	SRAMCache_SaveGlobals
	move.w	#$D9,d0
	bra.s	@sfx
@notb:
	move.w	#$A9,d0
@sfx:
	jsr	PlaySFX
	move.b	#1,BlackBarsConfig_Exiting	; set exiting flag
;	move.l	#BlackBarsConfigScreen_RedrawUI, VBlankCallback	; redraw one last time
; ---------------------------------------------------------------

@exiting:
	cmpi.w	#224/2,BlackBars.Height		; did we fill up the full screen?
	bhs.s	@exit				; if yes, branch
	addq.w	#4,BlackBars.Height		; grow black bars
	bra.w	BlackBarsConfigScreen_MainLoop	; loop
; ===============================================================

@exit:
	jsr	Pal_CutToBlack			; fill remaining palette to black for a smooth transition
	move.w	#0,BlackBars.Height		; reset black bars
	jmp	Exit_BlackBarsScreen		; exit to Sega screen
; ===============================================================

;@toggle:
;	move.w	#$D8,d0
;	jsr	PlaySFX
;	bchg	#1, BlackBars.HandlerId		; toggle selected option
;	jsr	BlackBars.SetHandler
;	move.l	#BlackBarsConfigScreen_RedrawUI, VBlankCallback	; defer redraw to VInt
;	bra.w	BlackBarsConfigScreen_MainLoop
; ===============================================================

BlackBars_Adjust_Min = 0
BlackBars_Adjust_Max = 224/2
BlackBars_Adjust_Step = 2

BlackBars_AdjustBaseHeight:
	btst	#0,($FFFFFE0F).w		; only every other frame
	beq.w	BlackBarsConfigScreen_MainLoop

	moveq	#BlackBars_Adjust_Step,d1	; move down
	andi.b	#Up,d0
	beq.s	@adjust
	neg.w	d1				; move up

@adjust:
	move.w	BlackBars.BaseHeight,d2
	add.w	d1,d2				; set new height

BlackBars_AdjustBaseHeight_Direct:
	cmpi.w	#BlackBars_Adjust_Min,d2
	bge.s	@minok
	moveq	#BlackBars_Adjust_Min,d2
	bra.s	@justset
@minok:
	cmpi.w	#BlackBars_Adjust_Max,d2
	ble.s	@maxok
	move.w	#BlackBars_Adjust_Max,d2
	bra.s	@justset
@maxok:
	move.w	#$A2,d0
	jsr	PlaySFX

@justset:
	andi.w	#$FFFE,d2
	move.w	d2,BlackBars.BaseHeight
	move.w	d2,BlackBars.Height
	move.w	d2,BlackBars.TargetHeight
	bra.w	BlackBarsConfigScreen_MainLoop
; ---------------------------------------------------------------

BlackBars_AdjustBaseHeight_Reset:
	move.w	#BlackBars.DefaultBaseHeight,d2
	bra.s	BlackBars_AdjustBaseHeight_Direct
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
	move.w	CamYpos2, VSRAM_PlaneB	; update plane B vs-ram

	lea	HSRAM_Buffer, a1

	if SCREEN_XDISP
		move.w	#SCREEN_XDISP, d0
		sub.w	CamXPos2, d0
	else
		moveq	#0, d0
		move.w	CamXPos2, d0
		neg.w	d0
	endif

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
	
	@sprite_x_spacing: = $40
	@sprite_y_spacing: = $80
	@sprite_width: = 64
	@sprite_height: = 64

	; Dynamically generate sprites with the given spacing to cover the entire screen

	@x: = 0
	@sprite_x_warp_dist: = 0

	while @x <= SCREEN_WIDTH + @sprite_width

		@y: = 0
		@sprite_y_warp_dist: = 0

		while @y <= SCREEN_HEIGHT + @sprite_height
			dc.w	@x, @y	; first unque line
			dc.w	@x + @sprite_x_spacing, @y + @sprite_y_spacing	; second unqiue line (then repeat)

			@y: = @y + @sprite_y_spacing*2
			@sprite_y_warp_dist: = @sprite_y_warp_dist + @sprite_y_spacing*2
		endw

		@x: = @x + @sprite_x_spacing*2
		@sprite_x_warp_dist: = @sprite_x_warp_dist + @sprite_x_spacing*2
	endw

	dc.w	-1	; end of list marker

; ---------------------------------------------------------------
@Obj_Ring:
	move.l	#Map_obj4B,obMap(a0)
	move.w	#$2000|($A200/$20),obGfx(a0)
	ori.b	#%10100, obRender(a0)
	move.b	#@sprite_width/2, obActWid(a0)	; `obActWid` isn't correct, it should've been "visible X radius" or "width / 2"
	move.b	#@sprite_height/2, obHeight(a0)	; `obHeight` isn't correct, it should've been "visible Y redius" or "height / 2"
	move.b	#4,obPriority(a0)
	move.l	#@Main, $3C(a0)

@Main:
	move.w	obX(a0), d0
	sub.w	CamXPos, d0
	add.w	#@sprite_width/2, d0		; offset X position by sprite X-radius for proper culling
	bpl.s	@x_chk_right
	add.w	#@sprite_x_warp_dist, obX(a0)
	bra.s	@x_ok

@x_chk_right:
	cmp.w	#@sprite_x_warp_dist, d0
	blo.s	@x_ok
	sub.w	#@sprite_x_warp_dist, obX(a0)
@x_ok:

	move.w	obY(a0), d0
	sub.w	CamYPos, d0
	add.w	#@sprite_height/2, d0		; offset Y position by sprite Y-radius for proper culling
	bpl.s	@y_chk_bottom
	add.w	#@sprite_y_warp_dist, obY(a0)
	bra.s	@y_ok

@y_chk_bottom:
	cmp.w	#@sprite_y_warp_dist, d0
	blo.s	@y_ok
	sub.w	#@sprite_y_warp_dist, obY(a0)
@y_ok:

	move.b	($FFFFFEC3).w, obFrame(a0)

	;tst.b	BlackBarsConfig_PreTextActive
	;beq.s	@display
	rts
@display:
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
	move.l	BlackBarsConfig_ConsoleUSP, \scratchReg
	move.l	\scratchReg, usp
	endm

BBCS_LeaveConsole:	macro scratchReg
	move.l	(sp)+, \scratchReg
	move.l	\scratchReg, usp
	endm

; ---------------------------------------------------------------
BlackBarsConfigScreen_InitUI:
	; Initialize console subsystem (MD Debugger)
	lea	VDP_Ctrl, a5
	lea	-4(a5), a6
	lea	@ConsoleConfig(pc), a1			; a1 = console config
	lea	BlackBarsConfig_ConsoleRAM, a3		; a3 = console RAM
	vram	$C000, d5				; d5 = base draw position
	jsr	MDDBG__Console_InitShared
	move.l	usp, a0
	move.l	a0, BlackBarsConfig_ConsoleUSP

	; Load font
	vram	BlackBarsConfig_VRAM_Font, (a5)
	lea	Screens_MenuFont_ArtKospM, a0
	jmp	KosPlusMDec_VRAM

; ---------------------------------------------------------------
@ConsoleConfig:
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

	Console.SetXY #1, #2
	Console.Write "! DOESN'T WORK - PICK THE OTHER MODE !"

	Console.SetXY #12, #6
	Console.Write "  SONIC ERAZOR%<endl>"
	Console.Write "%<pal2>----------------%<pal0>%<endl>"
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
; ---------------------------------------------------------------

 if def(__WIDESCREEN__)
BlackBarsConfigScreen_WriteText_WidescreenInfo:
	BBCS_EnterConsole a0

	Console.SetXY #0, #2
	Console.Write "              SONIC ERAZOR"
	Console.Write "%<endl>%<endl>"
	Console.Write "      Z E N I T H    E D I T I O N"

	Console.SetXY #0, #6
	Console.Write "%<pal2>----------------------------------------%<pal0>"
	Console.Write "%<endl>%<endl>"
	Console.Write "%<endl>"
	Console.Write "     SONIC ERAZOR IS A ROM HACK OF%<endl>"
	Console.Write "    SONIC 1 FOR THE SEGA MEGA DRIVE.%<endl>"
	Console.Write "%<endl>"
	Console.Write "  THIS IS SPECIAL WIDESCREEN-OPTIMIZED%<endl>"
	Console.Write "    VERSION OF THIS HACK, POWERED BY%<endl>"
	Console.Write "  HEYJOEWAY'S  ""SONIC 2 COMMUNITY CUT""  %<endl>"
	Console.Write " EMULATOR, FORKED FROM GENESIS PLUS GX.%<endl>"
	Console.Write "%<endl>"
	Console.Write "THIS ISN'T JUST A CUSTOM SONIC FAN GAME,%<endl>"
	Console.Write "   IT'S A TURBO-CHARGED RETRO CONSOLE!%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<pal2>----------------------------------------%<pal0>"

	Console.SetXY #0, #24

	Console.Write "       PRESS ENTER TO CONTINUE...%<endl>"
	
	BBCS_LeaveConsole a0
	rts


BlackBarsConfigScreen_WriteText_Controls:
	BBCS_EnterConsole a0

	Console.SetXY #0, #2
	Console.Write "              SONIC ERAZOR"
	Console.Write "%<endl>%<endl>"
	Console.Write "    D E F A U L T    C O N T R O L S"

	Console.SetXY #0, #6
	Console.Write "%<pal2>----------------------------------------%<pal0>"
	Console.Write "%<endl>%<endl>"
	Console.Write "      KEYBOARD KEY -> IN-GAME BUTTON%<endl>"
	Console.Write "%<endl>"
	Console.Write "                 A -> A%<endl>"
	Console.Write "                 S -> B%<endl>"
	Console.Write "                 D -> C%<endl>"
	Console.Write "             ENTER -> START%<endl>"
	Console.Write "        ARROW KEYS -> D-PAD%<endl>"
	Console.Write "%<endl>"
	Console.Write "               F11 -> TOGGLE FULLSCREEN%<endl>"
	Console.Write "               TAB -> RESTART GAME%<endl>"
	Console.Write "               ESC -> QUIT GAME%<endl>"
	Console.Write "%<endl>"
	Console.Write "%<pal2>----------------------------------------%<pal0>"

	Console.SetXY #0, #22

	Console.Write "      PRESS ""START"" TO CONTINUE...%<endl>"
	Console.Write "%<endl>"
	;                                                      XXXXXXXXXXXXXX
	Console.Write "       PRESS ""B"" TO NOT SHOW THIS%<endl>"
	Console.Write "          INFORMATION AGAIN...%<endl>"
	
	BBCS_LeaveConsole a0
	rts


 endif
; ---------------------------------------------------------------
; ===============================================================
