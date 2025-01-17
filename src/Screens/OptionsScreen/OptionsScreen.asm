; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------
; (c) Selbi
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
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

		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		move.w	#0,BlackBars.Height

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

		; Load options font art
		vram	$AE00, VDP_Ctrl
		lea	ArtKospM_Options_MenuFont(pc), a0
		jsr	KosPlusMDec_VRAM

		; Load options header text
		move.l	#$64000002, VDP_Ctrl
		lea	ArtKospM_Options_Header(pc), a0
		jsr	KosPlusMDec_VRAM

		; Draw options header text
		lea	Mapeni_Options_Header(pc), a0
		lea	$FF0000, a1
		move.w	#$6520, d0
		jsr	EniDec

		vram	$C092, d0
		lea	$FF0000, a1
		moveq	#22-1, d1
		moveq	#3-1, d2
		jsr	ShowVDPGraphics

		moveq	#1,d0			; load to fade-in buffer
		bsr	Options_LoadPal
		bsr	Options_SetupBackground

		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute

		jsr	Options_PlayMenuTheme
		move.w	#0,BlackBars.Height	; make sure black bars are fully gone

		clr.b	Options_Exiting
		jsr	Options_InitState
		jsr	Options_IntialDraw

		VBlank_UnsetMusicOnly
		display_enable

		jsr	Pal_FadeTo

		assert.b VBlank_MusicOnly, eq
		; fallthrough

; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

OptionsScreen_MainLoop:
		jsr	RandomNumber

		move.l	#@FlushVRAMBufferPool, VBlankCallback
		move.b	#2,VBlankRoutine
		jsr	DelayProgram

		addq.w	#1, GameFrame

		assert.w Options_VRAMBufferPoolPtr, eq, #Art_Buffer		; VRAM buffer pool should be reset by the beginning of the frame
		assert.w Options_StringBufferCanary, eq, #Options_CanaryValue	; guard against buffer overflows

		bsr	Options_HandleUpdate
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute
		jsr	PLC_Execute

		jsr	ERZBanner_PalCycle
		bsr	Options_SelectedLinePalCycle
		jsr	WhiteFlash_Restore

		move.w	#0,VSRAM_PlaneA
		moveq	#0,d0			; no shake
		tst.b	(CameraShake).w		; is camera shake currently active?
		beq.s	@nocamshake		; if not, branch
		subq.b	#1,(CameraShake).w	; subtract one from timer
		bne.s	@do
		bra.s	@nocamshake
	@do:
		jsr	GenerateCameraShake
		move.w	(CameraShake_XOffset).w,d1
		btst	#GlobalOptions_CameraShake_Intense, GlobalOptions
		beq.s	@1
		add.w	d1,d1
	@1:
		add.w	d1,VSRAM_PlaneA	; set to VSRAM
@nocamshake:

		; indent block when a Reset option is selected
		lea	HSRAM_Buffer,a1
		move.w	#224-1,d3
		moveq	#0,d0
	@clearscroll:
		move.w	d0,(a1)+
		addq.w	#2,a1
		dbf	d3,@clearscroll

		move.w	Options_IndentTimer,d0
		subq.w	#1,Options_IndentTimer
		cmpi.w	#-4,Options_IndentTimer
		bge.s	@0
		move.w	#-4,Options_IndentTimer
@0:

		cmpi.w	#13,($FFFFFF82).w		; Reset Slot Options?
		beq.s	@indenttop
		cmpi.w	#14,($FFFFFF82).w		; Reset Global Options?
		beq.s	@indentbottom
		clr.w	Options_IndentTimer
		bra.s	@ChkLoop

@indenttop:
		lea	($FFFFCC00+(5*4*8)).w,a1
		move.w	#(9*8)+4-1,d3
	@scroll:
		move.w	d0,(a1)+
		addq.w	#2,a1
		dbf	d3,@scroll

		bra.s	@ChkLoop

@indentbottom:
		lea	($FFFFCC00+(15*4*8)-$10).w,a1
		move.w	#(7*8)-1,d3
	@scroll2:
		move.w	d0,(a1)+
		addq.w	#2,a1
		dbf	d3,@scroll2

@ChkLoop:
		cmp.b	#$24, GameMode				; are we still running Options gamemode?
		beq	OptionsScreen_MainLoop			; if yes, loop
		rts						; exit options menu

; ---------------------------------------------------------------------------
@FlushVRAMBufferPool:
		Screen_PoolReset Options_VRAMBufferPoolPtr, Art_Buffer, Art_Buffer_End
		rts

; ---------------------------------------------------------------------------
; Initializes options screen state
; ---------------------------------------------------------------------------

Options_InitState:
		Screen_PoolReset Options_VRAMBufferPoolPtr, Art_Buffer, Art_Buffer_End

		move.w	#Options_CanaryValue, Options_StringBufferCanary

		; Clear stuff
		moveq	#0, d0
 		move.b	d0, ($FFFFFF95).w	; force-kill flag
		move.w	d0, ($FFFFFF96).w	; Sonic on spring flag
		move.b	d0, ($FFFFFF98).w	; simulated peelout flag
		move.w	d0, ($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w

		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter

		tst.w	($FFFFFF82).w		; is a valid selection in memory?
		bpl.s	@0			; if yes, use that
		move.w	#Options_MenuData_NumItems-1, ($FFFFFF82).w ; otherwise select the exit entry by default
@0:		bra	Options_ReloadAHintID	; load A-hint ID for this item
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Subroutine to setup options menu background
; ---------------------------------------------------------------------------

Options_SetupBackground:
		; Load star tiles
		vram	$2000
		lea	Screens_Stars_ArtKospM, a0
		jsr	KosPlusMDec_VRAM

		; Generate stars
		move	#$2000/$20, d4				; art pointer
		moveq	#78-1, d6				; num stars - 1
		jmp	Screen_GenerateStarfieldObjects

; ---------------------------------------------------------------------------
; Plays options menu theme
; ---------------------------------------------------------------------------

Options_PlayMenuTheme:
		tst.b	Options_FirstStartFlag		; first time?
		bne.s	@ret				; no music

		moveq	#$FFFFFF00|Options_Music, d0	; play Options screen music (Spark Mandrill)
		jsr	PlayBGM
		moveq	#$FFFFFFE3, d0			; regular music speed
		btst	#SlotOptions2_PlacePlacePlace, SlotOptions2	; is easter egg flag enabled?
		beq.s	@play				; if not, branch
		moveq	#$FFFFFFE2, d0			; speed up music
@play:		jmp	PlayCommand

@ret		rts

; ---------------------------------------------------------------------------
; Resets everything to defaults
; ---------------------------------------------------------------------------

Options_SetDefaults:
		bsr.s	Options_SetSlotDefaults
		; fallthrough

Options_SetGlobalDefaults:
		move.b	#Default_GlobalOptions, GlobalOptions
		clr.b	BlackBars.HandlerId
		jmp	BlackBars.SetHandler

; ---------------------------------------------------------------------------
Options_SetSlotDefaults:
		move.b	#Default_SlotOptions, SlotOptions
		clr.b	SlotOptions2
		rts

; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to perform screen's first render
; ---------------------------------------------------------------------------

Options_IntialDraw:
		; Render header
		bsr	Options_RedrawHeader

		; Render footer
		lea	Options_DrawText_Normal(pc), a4
		lea	Options_ItemData_Footer(pc), a0
		bsr	Options_RedrawMenuItem_Direct

		; Render all interactive menu items
		bra	Options_RedrawAllMenuItems

; ---------------------------------------------------------------------------
Options_RedrawHeader:
		lea	Options_DrawText_Normal(pc), a4
		lea	Options_ItemData_Header_Plain(pc), a0
		tst.b	Options_AHintID
		beq	Options_RedrawMenuItem_Direct
		lea	Options_DrawText_Highlighted(pc), a4
		lea	Options_ItemData_Header_AHint(pc), a0
		bra	Options_RedrawMenuItem_Direct

; ---------------------------------------------------------------------------
Options_ItemData_Header_Plain:
		dcScreenPos $C000, 4, 0		; start on-screen position
		dc.l	Options_DrawHeaderPlain	; redraw handler

Options_ItemData_Header_AHint:
		dcScreenPos $C000, 4, 0		; start on-screen position
		dc.l	Options_DrawHeaderAHint	; redraw handler

Options_ItemData_Footer:
		dcScreenPos $C000, 25, 0	; start on-screen position
		dc.l	Options_DrawHeaderPlain	; redraw handler

; ---------------------------------------------------------------------------
Options_DrawHeaderPlain:
		Options_PipeString a4, '----------------------------------------'
		rts

Options_DrawHeaderAHint:
		Options_PipeString a4, '----------PRESS _` FOR DETAILS----------'
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle users input on the screen
; ---------------------------------------------------------------------------

Options_HandleUpdate:
		bsr	Options_HandleUpDown
		bne.s	@done				; if something was changed, branch
		bsr	Options_HandleAHint
		bne.s	@done				; if A-hint was handled, branch

		move.w	($FFFFFF82).w, d0
		bsr.w	Options_HandleMenuItem		; handle currently selected menu item

		tst.b	Options_Exiting			; was exiting flag set?
		bne.s	@HandleExit			; if yes, exit options screen
		tst.b	Options_RedrawCurrentItem	; was redraw flag set?
		beq.s	@done				; if not, branch
		sf.b	Options_RedrawCurrentItem	; reset flag
		bsr	Options_HandleReloadAHint	; reload A-hint ID in case it's dynamic
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

		moveq	#0,d0				; return to Uberhub by default
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
		move.w	@current_selection, @prev_selection	; remember previous selection now

		moveq	#$FFFFFF00|Start|Up|Down, @joypad
		and.b	Joypad|Press, @joypad			; Start, Up or Down pressed?
		bmi.s	@MoveSelectionToLast			; if Start, branch
		beq	@ReturnZ				; if nothing, branch
		lsr.w	@joypad					; Up pressed?
		bcc.s	@MoveSelectionDown			; if not, branch

		; Move selection up (with boundary checks)
		subq.w	#1, @current_selection
		bpl.s	@UpdateSelection

	@MoveSelectionToLast:
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
		cmp.w	@current_selection, @prev_selection	; nothing has changed?
		beq.w	@ReturnZ				; if yes, branch

		; Always reset SRAM delete counter
		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter

		move.w	@prev_selection, -(sp)
		bsr	Options_RedrawMenuItem		; redraw current item
		move.w	(sp)+, d0
		bsr	Options_RedrawMenuItem		; redraw previously selected item

		bsr	Options_HandleReloadAHint	; reload A-hit ID and redraw header if necessary

		clr.w	Options_IndentTimer
		moveq	#$FFFFFFD8, d0			; play move sound
		jsr	PlaySFX
		moveq	#1, d0				; return Z=0
	@ReturnZ:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Reloads A-hint ID for menu it and redraws header tooltip if necessary
; ---------------------------------------------------------------------------

Options_HandleReloadAHint:
		tst.b	Options_AHintID		; => Z=0 if set, Z=1 if unset
		sne.b	d7
		bsr	Options_ReloadAHintID	; => Z=0 if set, Z=1 if unset
		sne.b	d0
		eor.b	d7, d0
		beq.s	@noredraw
		KDebug.WriteLine "Options_HandleReloadAHint(): Must redraw header..."
		bra	Options_RedrawHeader		; redraw header if `Options_AHintID` went from zero to non-zero (or vice-versa)

@noredraw:	rts

; ---------------------------------------------------------------------------
; Loads A-hint ID
; ---------------------------------------------------------------------------

Options_ReloadAHintID:
		move.w	($FFFFFF82).w, d0
		Options_GetMenuItem d0, a0			; a0 = item pointer
		move.l	10(a0), d0				; d0 = A-hint
		bpl.s	@0					; if A-hint ID is not a dynamic function, branch
		movea.l	d0, a1					; call dynamic A-hint getter
		jsr	(a1)					; => d0 = A-hint
	@0:	KDebug.WriteLine "Options_ReloadAHintID(): id=%<.b d0>"
		move.b	d0, Options_AHintID			; set A-hint ID
		rts	; return the result of `move.b d0, ...`

; ===========================================================================
; ---------------------------------------------------------------------------
; Handler for bonus information when pressing A (specific options only)
; ---------------------------------------------------------------------------

Options_HandleAHint:
		btst	#iA,Joypad|Press	; is A pressed?
		beq.s	@returnZ		; if not, branch
		tst.b	Options_AHintID		; do we have an A hint to handle?
		beq.s	@returnZ		; if not, branch

		moveq	#$FFFFFFD9,d0		; play toggle on sound
		jsr	PlaySFX
		jsr 	Pal_FadeOut		; darken background...
		jsr 	Pal_FadeOut		; ...twice
		moveq	#$1D,d0			; load tutorial box palette...
		jsr	PalLoad2		; ...directly

		move.b	Options_AHintID, d0	; restore ID
		jsr	TutorialBox_Display	; VLADIK => Display hint

		moveq	#0, d0			; refresh options pal directly
		jmp	Options_LoadPal

		moveq	#1, d0			; return Z=0
@returnZ:	rts


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

		lea	Options_DrawMenuItem_Normal(pc), a4	; use normal drawer
		cmp.w	($FFFFFF82).w, d0			; is current item selected?
		bne.s	@0					; if not, branch
		lea	Options_DrawMenuItem_Highlighted(pc), a4; use highlighted drawer
	@0:	Options_GetMenuItem d0, a0			; a0 = item pointer

Options_RedrawMenuItem_Direct:
		move.w	(a0)+, Options_VRAMStartScreenPos	; set on-screen position
		move.l	(a0)+, a0				; a0 = redraw handler
		jmp	(a0)					; execute redraw

; ---------------------------------------------------------------------------
Options_HandleMenuItem:
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


; ---------------------------------------------------------------------------
; Standard drawers (no decorations)
Options_DrawText_Highlighted:
		move.w	#$4000, d6				; use palette line 3
		bra.s	Options_DrawText2

; ---------------------------------------------------------------------------
Options_DrawText_Normal:
		move.w	#$6000, d6				; use palette line 4

Options_DrawText2:
		Screen_PoolAllocate a1, Options_VRAMBufferPoolPtr, #Options_StringBufferSize*2
		move.l	a1, -(sp)
		bra	Options_DrawText_Cont

; ---------------------------------------------------------------------------
; Standard menu items (with "> " decoration if highlighted)
Options_DrawMenuItem_Highlighted:
		move.w	#$4000, d6				; use palette line 3
		move.l	#(Options_VRAM+$E|$4000)<<16, d7	; use "> " cursor ('>' with palette line 3 + empty tile)
		bra	Options_DrawMenuItem_Cont

; ---------------------------------------------------------------------------
Options_DrawMenuItem_Normal:
		move.w	#$6000, d6				; use palette line 4
		moveq	#0, d7					; use "  " cursor (2 empty tiles)

Options_DrawMenuItem_Cont:
		Screen_PoolAllocate a1, Options_VRAMBufferPoolPtr, #Options_StringBufferSize*2+2*2	; +2 tiles for cursor
		move.l	a1, -(sp)
		move.l	d7, (a1)+				; draw cursor (2 tiles)

Options_DrawText_Cont:
		clr.b	(a0)+					; finalize buffer

		lea	Options_StringBuffer, a0
		KDebug.WriteLine "Options_DrawText(): str='%<.l a0 str>'"

		moveq	#0, d7
		move.b	(a0)+, d7				; d7 = char
		beq.s	@done

		@loop:
			add.w	d7, d7
			move.w	Options_CharToTile-$20*2(pc, d7), d7
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

	@char:	= $20	; ignore ASCII codes $00..$1F, those are control character we'll never use
	while (@char < $80)
		if @char = ' '
			@return 0
		elseif @char = '-'
			@return Options_VRAM+$B
		elseif @char = '+'
			@return Options_VRAM+$C
		elseif @char = '<'
			@return Options_VRAM+$D
		elseif @char = '>'
			@return Options_VRAM+$E
		elseif @char = '^'
			@return Options_VRAM+$29
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
		lea	Pal_Target, a4
		lea	PalLoad1, a3	; => Pal_Target
		tst.b	d0
		bne.s	@ptrs_ok
		lea	Pal_Active, a4
		lea	PalLoad2, a3	; => Pal_Target
@ptrs_ok:
		moveq	#$1E, d0	; use casual options palette
		frantic
		beq.s	@0
		moveq	#$1F, d0	; use frantic options palette
	@0:	jsr	(a3)

		moveq	#STARFIELD_PAL_ID_BLUE, d2
		frantic
		beq.s	@1
		moveq	#STARFIELD_PAL_ID_RED, d2
	@1:	lea	$10(a4), a2
		jsr	Screen_LoadStarfieldPalette

		lea	Pal_ERaZorBanner, a1	; set ERaZor banner's palette pointer
		lea	$20(a4), a2		; set palette location
		rept 8
			move.l	(a1)+, (a2)+
		endr
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
; Options art (KosPM)
; ---------------------------------------------------------------------------

ArtKospM_Options_Header:
		incbin	"Screens/OptionsScreen/Data/Options_Header_Tiles.kospm"
		even

ArtKospM_Options_MenuFont:
		incbin	"Screens/OptionsScreen/Data/MenuFont.kospm"

MapEni_Options_Header:
		incbin	"Screens/OptionsScreen/Data/Options_Header_Map.eni"
		even
