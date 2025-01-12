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

		tst.b	($FFFFFF84).w
		bne.s	@nosh
		move.w	#$8C81|$08,(a6)	; enable shadow/highlight mode (SH mode)
@nosh:

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

		; Load options text art
		@vram_dest: = $AE00

		vramWrite Options_TextArt, filesize("Screens/OptionsScreen/Options_TextArt.bin"), @vram_dest

		; Load ERZ banner art
		lea	VDP_Data, a6
		move.l	#$64000002,4(a6)
		lea	ArtKospM_OptionsHeader, a0
		jsr	KosPlusMDec_VRAM

		; Load objects
		lea	($FFFFD100).w,a0
		move.b	#2,(a0)				; load ERaZor banner object
		move.b	#2,obRoutine(a0)		; set to "Obj02_Display"
		move.l	#Maps_OptionsHeader,obMap(a0)	; load mappings
		move.b	#0,obPriority(a0)		; set priority
		move.b	#0,obRender(a0)			; set render flag
		move.w	#$6520,obGfx(a0)		; set art, use fourth palette line
		bset	#7,obGfx(a0)			; make object high plane
		move.w	#$80+SCREEN_WIDTH/2-2,obX(a0)	; set X-position
		move.w	#$7F,obScreenY(a0)		; set Y-position

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

		jsr	Options_HandleBackground
		jsr	ERZBanner_PalCycle
		bsr	Options_SelectedLinePalCycle
		jsr	WhiteFlash_Restore

		move.w	#0,($FFFFF616).w
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
		add.w	d1,($FFFFF616).w	; set to VSRAM
@nocamshake:


		; indent block when a Reset option is selected
		lea	($FFFFCC00).w,a1
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

		cmpi.w	#12,($FFFFFF82).w		; Reset Slot Options?
		beq.s	@indenttop
		cmpi.w	#13,($FFFFFF82).w		; Reset Global Options?
		beq.s	@indentbottom
		clr.w	Options_IndentTimer
		bra.s	@ChkLoop

@indenttop:
		lea	($FFFFCC00+(5*4*8)).w,a1
		move.w	#(10*8)+4-1,d3
	@scroll:
		move.w	d0,(a1)+
		addq.w	#2,a1
		dbf	d3,@scroll

		bra.s	@ChkLoop

@indentbottom:
		lea	($FFFFCC00+(16*4*8)-$10).w,a1
		move.w	#(5*8)-1,d3
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

		if def(__DEBUG__)
			move.w	#Options_CanaryValue, Options_StringBufferCanary
		endif

		; Clear stuff
		moveq	#0, d0
 		move.b	d0, ($FFFFFF95).w
		move.w	d0, ($FFFFFF96).w
		move.b	d0, ($FFFFFF98).w
		move.w	d0, ($FFFFFFB8).w
		move.b	d0, Options_HasAHint
		move.w	#21,($FFFFFF9A).w

		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter

		tst.w	($FFFFFF82).w		; is a valid selection in memory?
		bpl.s	@end			; if yes, use that
		bsr	Options_SelectExit	; otherwise select the exit entry by default
@end:		rts
; ---------------------------------------------------------------------------

Options_SelectExit:
		move.w	#Options_MenuData_NumItems-1, ($FFFFFF82).w
		rts

; ---------------------------------------------------------------------------
; Subroutine to setup options menu background
; ---------------------------------------------------------------------------

Options_SetupBackground:
		tst.b	($FFFFFF84).w		; first time?
		bne	@SetupStarfieldBG	; if yes, branch

*@SetupFuzzyBG:
		move.w	#$806,(BGThemeColor).w	; set theme color for background effects
		jsr	BackgroundEffects_Setup

		; Load SH shadow overlay art
		vram	$3000
		lea	Screens_SH_Shadow_ArtKospM, a0
		jsr	KosPlusMDec_VRAM

		; transparent sprites squeezed in between plane A and B to properly display the text in SH mode
		lea	($FFFFD140).w,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2-32,obX(a0)
		move.w	#$B0,obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2+(32*5)-32,obX(a0)
		move.w	#$B0,obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2-32,obX(a0)
		move.w	#$B0+(32*4),obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2+(32*5)-32,obX(a0)
		move.w	#$B0+(32*4),obScreenY(a0)
		rts

; ---------------------------------------------------------------------------
@SetupStarfieldBG:
		; Load star tiles
		vram	$2000
		lea	Screens_Stars_ArtKospM, a0
		jsr	KosPlusMDec_VRAM

		; Generate stars
		move	#$2000/$20, d4				; art pointer
		moveq	#78-1, d6				; num stars - 1
		jmp	Screen_GenerateStarfieldObjects


; ---------------------------------------------------------------------------
; Subroutine to handle/update BG
; ---------------------------------------------------------------------------

Options_HandleBackground:
		tst.b	($FFFFFF84).w		; first time?
		bne.s	@HandleStarfieldBG	; if yes, branch
		jmp	BackgroundEffects_Update

; ---------------------------------------------------------------------------
@HandleStarfieldBG:
		rts				; BG handles itself

; ---------------------------------------------------------------------------
; Plays options menu theme
; ---------------------------------------------------------------------------

Options_PlayMenuTheme:
		tst.b	($FFFFFF84).w			; first time?
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
		; Render header and tool tip
		bsr	Options_RedrawHeader

		; Render all interactive menu items
		bra	Options_RedrawAllMenuItems
; ===========================================================================

Options_RedrawHeader:
		lea	Options_DrawText_Normal(pc), a4
		lea	@ItemData_Header_Plain(pc), a0
		tst.b	Options_HasAHint
		beq.s	@draw
		lea	Options_DrawText_Highlighted(pc), a4
		lea	@ItemData_Header_AHint(pc), a0
@draw:		bsr	Options_RedrawMenuItem_Direct

	;	lea	Options_DrawText_Normal(pc), a4
	;	lea	@ItemData_Header_Middle(pc), a0
	;	bsr	Options_RedrawMenuItem_Direct

		lea	Options_DrawText_Normal(pc), a4
		lea	@ItemData_Header_Bottom(pc), a0
		bra	Options_RedrawMenuItem_Direct

; ---------------------------------------------------------------------------
@ItemData_Header_Plain:
		dcScreenPos $C000, 4, 0		; start on-screen position
		dc.l	@DrawHeaderPlain	; redraw handler
@ItemData_Header_AHint:
		dcScreenPos $C000, 4, 0		; start on-screen position
		dc.l	@DrawHeaderAHint	; redraw handler

@ItemData_Header_Middle:
		dcScreenPos $C000, 16, 0	; start on-screen position
		dc.l	@DrawHeaderPlain	; redraw handler

@ItemData_Header_Bottom:
		dcScreenPos $C000, 24, 0	; start on-screen position
		dc.l	@DrawHeaderPlain	; redraw handler

; ---------------------------------------------------------------------------
@DrawHeaderPlain:
		Options_PipeString a4, '----------------------------------------'
		rts
@DrawHeaderAHint:
		Options_PipeString a4, '----------PRESS _` FOR DETAILS----------'
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle users input on the screen
; ---------------------------------------------------------------------------

Options_HandleUpdate:
		bsr	Options_HandleUpDown
		
		move.w	($FFFFFF82).w, d0
		bsr.w	Options_HandleMenuItem		; handle currently selected menu item
		
		tst.b	Options_Exiting			; was exiting flag set?
		bne.s	@HandleExit			; if yes, exit options screen
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

		cmpi.b	#Start,Joypad|Held
		beq.s	@MoveSelectionToLast

		moveq	#Up|Down, @joypad
		and.b	Joypad|Press, @joypad			; Up or Down pressed?
		beq	@Done					; if not, branch


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

		cmp.w	@current_selection, @prev_selection
		beq.w	@Done
		bclr	#iStart,Joypad|Press
		assert.w @current_selection, ne, @prev_selection

		; Always reset SRAM delete counter
		move.b	#Options_DeleteSRAMInitialCount, Options_DeleteSRAMCounter

		move.w	@prev_selection, -(sp)
		jsr	Options_RedrawMenuItem		; redraw current item
		move.w	(sp)+, d0
		jsr	Options_RedrawMenuItem		; redraw previously selected item

		; hint to press A for the extra details on specific options
		moveq	#0,d0				; hide A hint by default
		move.w	($FFFFFF82).w,d1		; get current selection
	if def(__WIDESCREEN__)
		cmpi.w	#1,d1				; Extended Widescreen Camera selected?
		beq.s	@ahint				; if yes, show A hint
	endif
		cmpi.w	#2,d1				; Track Your Mistakes mode selected?
		beq.s	@ahint				; if yes, show A hint
		cmpi.w	#3,d1				; Speedrun Mode selected?
		beq.s	@ahint				; if yes, show A hint
		cmpi.w	#4,d1				; Palette Style selected?
		beq.s	@ahint				; if yes, show A hint

		cmpi.w	#5,d1				; Cinematic Mode selected?
		bne.s	@notcinematic			; if not, branch
		jsr	CheckGlobal_BaseGameBeaten_Casual; has the player beaten base game in casual?
		bne.s	@ahint				; if yes, show A hint
	@notcinematic:
		cmpi.w	#6,d1				; ERaZor Powers selected?
		bne.s	@notpowers			; if not, branch
		jsr	CheckGlobal_BaseGameBeaten_Frantic; has the player beaten base game in frantic?
		bne.s	@ahint				; if yes, show A hint
	@notpowers:
		cmpi.w	#7,d1				; True-BS selected?
		bne.s	@nottruebs			; if not, branch
		jsr	CheckGlobal_BlackoutBeaten	; has the player beaten the Blackout Challenge
		bne.s	@ahint				; if yes, show A hint
	@nottruebs:

		; expand as necessary
		bra.s	@redrawheader			; otherwise, hide A hint

	@ahint:
		moveq	#1,d0				; show A hint

	@redrawheader:
		move.b	d0,Options_HasAHint		; set state of A hint flag
		bsr	Options_RedrawHeader		; redraw header accordingly

@playsound:
		clr.w	Options_IndentTimer
		move.b	#$D8,d0				; play move sound
		jmp	PlaySFX

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
		lea	PalLoad1, a2	; => Pal_Target
		tst.b	d0
		bne.s	@ptrs_ok
		lea	Pal_Active, a4
		lea	PalLoad2, a2	; => Pal_Target
@ptrs_ok:
		moveq	#2,d0		; load level select palette
		jsr	(a2)

		tst.b	($FFFFFF84).w	; first time?
		beq.s	@nostars	; if not, branch
		lea	@Star_Palette(pc), a0
		lea	$10(a4), a1
		rept 8/2
			move.l	(a0)+, (a1)+
		endr
@nostars:
		lea	Pal_ERaZorBanner, a1	; set ERaZor banner's palette pointer
		lea	$20(a4), a2		; set palette location
		rept 8
			move.l	(a1)+, (a2)+
		endr
		rts

; ---------------------------------------------------------------------------
@Star_Palette:	dc.w	$0CEE,$0ACC,$08AA,$0888,$0688,$0666,$0444,$0222

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

; ===========================================================================
; ---------------------------------------------------------------------------
; Options header art (KosPM)
; ---------------------------------------------------------------------------

ArtKospM_OptionsHeader:
		incbin	Screens\OptionsScreen\Options_Header.kospm
		even

Maps_OptionsHeader:
		include	"Screens\OptionsScreen\Options_Header.asm"
		even