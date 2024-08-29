; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------
; (c) Selbi
; ---------------------------------------------------------------------------

	include	"Screens/OptionsScreen/Macros.asm"

; ---------------------------------------------------------------------------

Options_DeleteSRAMInitialCount = 5

Options_VRAM = $8570
Options_StringBufferSize = 40+1
Options_DefaultSelect = 1

	if def(__DEBUG__)
Options_CanaryValue = $BEEF
	endif

Options_RAM:	equ	$FFFF8000

	rsset	Options_RAM
Options_StringBuffer:		rs.b	Options_StringBufferSize+(Options_StringBufferSize&1)
	if def(__DEBUG__)
Options_StringBufferCanary:	rs.w	1			; DEBUG builds only
	endif
Options_VRAMStartScreenPos:	rs.w	1
Options_VRAMBufferPoolPtr:	rs.w	1
Options_DeleteSRAMCounter:	rs.b	1
Options_RedrawCurrentItem:	rs.b	1

; ---------------------------------------------------------------------------
; All options are kept in a single byte to save space (it's all flags anyway)
; RAM location: $FFFFFF92
;  bit 0 = Extended Camera
;  bit 1 = Skip Story Screens
;  bit 2 = Skip Uberhub Place
;  bit 3 = Cinematic Mode (black bars)
;  bit 4 = Nonstop Inhuman Mode
;  bit 5 = Gamplay Style (0 - Casual Mode // 1 - Frantic Mode)
;  bit 6 = Cinematic Mode (piss filter)
;  bit 7 = Photosensitive Mode
; ---------------------------------------------------------------------------
; Default options when starting the game for the first time
; (Casual Mode, Extended Camera)
DefaultOptions = %00000001
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
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
		move.w	#$8B07, (a6)
		move.w	#$8720, (a6)
		clr.b	($FFFFF64E).w
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

		VBlank_SetMusicOnly

		; Load options text art
		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F
@loadtextart:	move.w	(a5)+,(a6)
		dbf	d1,@loadtextart ; load uncompressed text patterns

		; Load ERZ banner art
		move.l	#$64000002,4(a6)
		lea	ArtKospM_ERaZorNoBG, a0
		jsr	KosPlusMDec_VRAM
		VBlank_UnsetMusicOnly

		; Load objects
		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$11E,obX(a0)		; set X-position
		move.w	#$7F,obScreenY(a0)	; set Y-position
		bset	#7,obGfx(a0)		; make object high plane
		jsr	ObjectsLoad
		jsr	BuildSprites

		move.b	#$86,d0		; play Options screen music (Spark Mandrill)
		jsr	PlaySound_Special
		bsr	Options_LoadPal
		move.w	#$00E,(BGThemeColor).w	; set theme color for background effects

		jsr	BackgroundEffects_Setup

		jsr	Options_InitState
		bsr	CheckEnable_PlacePlacePlace
		jsr	Options_IntialDraw

		VBlank_UnsetMusicOnly
		display_enable
		jsr	Pal_FadeTo
		; fallthrough

; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

OptionsScreen_MainLoop:
		move.l	#@FlushVRAMBufferPool, VBlankCallback
		move.b	#2,VBlankRoutine
		jsr	DelayProgram

		assert.w Options_VRAMBufferPoolPtr, eq, #Art_Buffer		; VRAM buffer pool should be reset by the beginning of the frame
		assert.w Options_StringBufferCanary, eq, #Options_CanaryValue	; guard against buffer overflows

		bsr	Options_HandleUpdate
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	PLC_Execute

		jsr	BackgroundEffects_Update
		jsr	ERZBanner_PalCycle
		bsr	Options_SelectedLinePalCycle

		cmp.b	#$24, GameMode				; are we still running Options gamemode?
		beq	OptionsScreen_MainLoop			; if yes, branch
		rts

; ---------------------------------------------------------------------------
@FlushVRAMBufferPool:
		Options_ResetVRAMBufferPool
		rts

; ---------------------------------------------------------------------------
; Initializes options screen state
; ---------------------------------------------------------------------------

Options_InitState:
		Options_ResetVRAMBufferPool

		if def(__DEBUG__)
			move.w	#Options_CanaryValue, Options_StringBufferCanary
		endif

		; Clear stuff
		moveq	#0, d0
 		move.b	d0, ($FFFFFF95).w
		move.w	d0, ($FFFFFF96).w
		move.b	d0, ($FFFFFF98).w
		move.w	d0, ($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w
		move.b	#$81,($FFFFFF84).w

		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter
		rts

; ---------------------------------------------------------------------------
; Resets everything to defaults
; ---------------------------------------------------------------------------

Options_SetDefaults:
		move.b	#DefaultOptions,(OptionsBits).w	; load default options
		rts

; ---------------------------------------------------------------------------
; PLACE PLACE PLACE easter egg
; ---------------------------------------------------------------------------

CheckEnable_PlacePlacePlace:
		cmpi.b	#$70,($FFFFF604).w	; exactly ABC held?
		bne.s	@noenable		; if not, branch
		move.b	#1,(PlacePlacePlace).w	; enable PLACE PLACE PLACE
		bset	#5,(OptionsBits).w	; force-enable frantic mode
		bclr	#4,(OptionsBits).w	; force-disable nonstop inhuman
		bclr	#1,(OptionsBits).w	; force-enable story screens
@noenable:
		move.w	#$E3,d0			; regular music speed
		tst.b	(PlacePlacePlace).w	; is easter egg flag enabled?
		beq.s	@play			; if not, branch
		move.w	#$E2,d0			; speed up music
@play:		jmp	PlaySound_Special
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to perform screen's first render
; ---------------------------------------------------------------------------

Options_IntialDraw:
		; Render header and tool tip
		lea	Options_DrawText_Normal(pc), a4
		lea	@ItemData_Header_Top(pc), a0
		bsr	Options_RedrawMenuItem_Direct
		lea	@ItemData_Header_Bottom(pc), a0
		bsr	Options_RedrawMenuItem_Direct
		lea	@ItemData_Tooltip(pc), a0
		bsr	Options_RedrawMenuItem_Direct

		; Render all interactive menu items
		bra	Options_RedrawAllMenuItems

; ---------------------------------------------------------------------------
@ItemData_Header_Top:
		dcScreenPos $E000, 3, 4			; start on-screen position
		dc.l	@DrawHeader			; redraw handler

@ItemData_Header_Bottom:
		dcScreenPos $E000, 25, 4		; start on-screen position
		dc.l	@DrawHeader			; redraw handler

@ItemData_Tooltip:
		dcScreenPos $E000, 26, 10		; start on-screen position
		dc.l	@DrawTooltip			; redraw handler

; ---------------------------------------------------------------------------
@DrawHeader:
		Options_PipeString a4, '<------------------------------>'
		rts

@DrawTooltip:
		Options_PipeString a4, 'PRESS  _`abc TO EXIT'
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle users input on the screen
; ---------------------------------------------------------------------------

Options_HandleUpdate:
		tst.b	Joypad|Press			; Start pressed?
		bmi.s	@HandleExit			; if yes, branch

		bsr	Options_HandleUpDown
		
		move.w	($FFFFFF82).w, d0
		bsr.w	Options_HandeMenuItem		; handle currently selected menu item
		
		tst.b	Options_RedrawCurrentItem	; was redraw flag set?
		beq.s	@done				; if not, branch
		sf.b	Options_RedrawCurrentItem	; reset flag
		move.w	($FFFFFF82).w, d0
		bra.w	Options_RedrawMenuItem		; redraw current menu item
@done:		rts

; ---------------------------------------------------------------------------
@HandleExit:
		moveq	#0, d0
		move.b	d0, ($FFFFFF95).w
		move.w	d0, ($FFFFFF96).w
		move.w	d0, ($FFFFFF98).w
		move.b	d0, ($FFFFFF9A).w

		move.b	#1,($A130F1).l		; enable SRAM
		move.b	OptionsBits,($200001).l	; backup options flags
		move.b	#0,($A130F1).l		; disable SRAM

		moveq	#0,d0			; return to Uberhub
		jmp	Exit_OptionsScreen


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	change the selected option when pressing up or down
; ---------------------------------------------------------------------------

Options_HandleUpDown:

@current_selection:	equr	d0
@prev_selection:	equr	d4
@joypad:		equr	d1

		move.w	($FFFFFF82).w, @current_selection	; get current selection
		moveq	#Up|Down, @joypad
		and.b	Joypad|Press, @joypad			; Up or Down pressed?
		beq	@Done					; if not, branch
		move.w	@current_selection, @prev_selection	; remember previous selection now
		lsr.w	@joypad					; Up pressed?
		bcc.s	@MoveSelectionDown			; if not, branch

		; Move selection up (with boundary checks)
		subq.w	#1, @current_selection
		bpl.s	@UpdateSelection
		moveq	#Options_MenuData_NumItems-1, @current_selection
		bra.s	@UpdateSelection

	@MoveSelectionDown:
		; Move selection down (with boundary checks)
		addq.w	#1, @current_selection
		cmp.w	#Options_MenuData_NumItems, @current_selection
		bne.s	@UpdateSelection
		moveq	#0, @current_selection			; move to the top
		; fallthrough

	@UpdateSelection:
		KDebug.WriteLine "Setting selection: %<.w d0>"
		move.w	@current_selection, ($FFFFFF82).w	; set new selection
		assert.w @current_selection, ne, @prev_selection

		; Always reset SRAM delete counter
		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter

		move.w	@prev_selection, -(sp)
		;move.w	@current_selection, d0		; the same register currently
		jsr	Options_RedrawMenuItem		; redraw current item
		move.w	(sp)+, d0
		jsr	Options_RedrawMenuItem		; redraw previously selected item

		move.b	#$D8,d0				; play move sound
		jmp	PlaySound_Special

	@Done:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Force-redraws all menu items
; ---------------------------------------------------------------------------

Options_RedrawAllMenuItems:
		moveq	#Options_MenuData_NumItems-1, d0

		@redrawItemLoop:
			move.w	d0, -(sp)
			bsr.s	Options_RedrawMenuItem
			move.w	(sp)+, d0
			dbf	d0, @redrawItemLoop

		rts

; ---------------------------------------------------------------------------
; Redraws menu item by id
; ---------------------------------------------------------------------------
; INPUT:
;	d0	.w	Menu item ID (zero-based)
; ---------------------------------------------------------------------------

Options_RedrawMenuItem:
		KDebug.WriteLine "Options_RedrawMenuItem(): id=%<.w d0 dec>"

		lea	Options_DrawText_Normal(pc), a4		; use normal drawer
		cmp.w	($FFFFFF82).w, d0			; is current item selected?
		bne.s	@0					; if not, branch
		lea	Options_DrawText_Highlighted(pc), a4	; use highlighted drawer
	@0:	Options_GetMenuItem d0, a0			; a0 = item pointer

Options_RedrawMenuItem_Direct:
		move.w	(a0)+, Options_VRAMStartScreenPos	; set on-screen position
		move.l	(a0)+, a0				; a0 = redraw handler
		jmp	(a0)					; execute redraw

; ---------------------------------------------------------------------------
Options_HandeMenuItem:
		Options_GetMenuItem d0, a0			; a0 = item pointer
		move.l	6(a0), a0				; a0 = update handler
		jmp	(a0)					; execute update

; ===========================================================================
; ---------------------------------------------------------------------------
; String flush functions for MDDBG__FormatString; pipe string to VRAM buffer
; ---------------------------------------------------------------------------
; INPUT:
;	a0		Last buffer position
;	d7	.w	Number of characters remaining in buffer - 1
;
; WARNING: Must return Carry=1 to terminate buffer! Otherwise it will crash
; further flushes because some registers are trashed.
; ---------------------------------------------------------------------------

Options_DrawText_Highlighted:
		move.w	#$4000, d6				; use palette line 3
		bra.s	Options_DrawText2

; ---------------------------------------------------------------------------
Options_DrawText_Normal:
		move.w	#$6000, d6				; use palette line 4

Options_DrawText2:
		clr.b	(a0)+					; finalize buffer

		lea	Options_StringBuffer, a0
		Options_AllocateInVRAMBufferPool a1, #Options_StringBufferSize*2
		move.l	a1, -(sp)

		KDebug.WriteLine "Options_DrawText(): str='%<.l a0 str>'"

		moveq	#0, d7
		move.b	(a0)+, d7				; d7 = char
		beq.s	@done

		@loop:
			add.w	d7, d7
			move.w	Options_CharToTile(pc, d7), d7
			or.w	d6, d7
			move.w	d7, (a1)+
			moveq	#0, d7
			move.b	(a0)+, d7				; d7 = char
			bne.s	@loop

		move.l	(sp)+, d1				; d1 = source pointer
		andi.l	#$FFFFFF, d1
		move.w	Options_VRAMStartScreenPos, d2		; d2 = destination VRAM
		move.l	d1, d3
		sub.l	a1, d3
		neg.w	d3					; d3 = transfer size
		lsr.w	d3					; d3 = transfer size (words)
		jsr	QueueDMATransfer

	@done:
		moveq	#0, d7
		subq.w	#1, d7					; return C=1
		rts

; ---------------------------------------------------------------------------
; High-level char to tile converter (100% high-level programming)
; ---------------------------------------------------------------------------

Options_CharToTile:

; Defines function return type
@return: macros value
	dc.w \value

	@char:	= 0
	while (@char < $80)
		if @char = ' '
			@return 0
		elseif @char = '-'
			@return Options_VRAM+$B
		elseif @char = '<'
			@return Options_VRAM+$D
		elseif @char = '>'
			@return Options_VRAM+$E
		elseif @char = '?'
			@return Options_VRAM+$2A
		elseif @char = '.'
			@return Options_VRAM+$2B
		elseif @char = ','
			@return Options_VRAM+$2C
		elseif (@char >= '0') & (@char <= '9')
			@return Options_VRAM+@char-50+2
		else
			@return	Options_VRAM+@char-50
		endif
		@char: = @char + 1
	endw

; ===========================================================================

		include	'Screens/OptionsScreen/MenuHandlers.asm'

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load options palette
; ---------------------------------------------------------------------------

Options_LoadPal:
		moveq	#2,d0		; load level select palette
		jsr	PalLoad1

		movem.l	a1-a2, -(sp)		; backup d0 to a2
		lea	Pal_ERaZorBanner, a1	; set ERaZor banner's palette pointer
		lea	$FFFFFBA0, a2		; set palette location
		rept 8
			move.l	(a1)+, (a2)+
		endr
		movem.l	(sp)+, a1-a2		; restore d0 to a2
		rts

; ---------------------------------------------------------------------------
; Palette cycle for highlighted menu item
; ---------------------------------------------------------------------------

Options_SelectedLinePalCycle:
		moveq	#0,d1
		lea	($FFFFFB40-6*2).w,a2
		jmp	GenericPalCycle_Red
; ---------------------------------------------------------------------------

; ===========================================================================
; ---------------------------------------------------------------------------
; Options font (uncompressed)
; ---------------------------------------------------------------------------

Options_TextArt:
		incbin	Screens\OptionsScreen\Options_TextArt.bin
		even
