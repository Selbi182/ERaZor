; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------
; (c) Selbi
; ---------------------------------------------------------------------------

	include	"Screens/OptionsScreen/Macros.asm"

; ---------------------------------------------------------------------------

Options_Music = $99

Options_DeleteSRAMInitialCount = 8

Options_VRAM = $8570
Options_StringBufferSize = 40+1

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
Options_Exiting:		rs.b	1
Options_HasAHint:		rs.b	1

; ---------------------------------------------------------------------------
; All options are kept in a single byte to save space (it's all flags anyway)
; RAM location: `OptionsBits`
;  bit 0 = Extended Camera
;  bit 1 = <<UNUSED>>
;  bit 2 = Disable HUD
;  bit 3 = Cinematic Mode (black bars)
;  bit 4 = Nonstop Inhuman Mode
;  bit 5 = <<UNUSED>>
;  bit 6 = Max White Flash
;  bit 7 = Photosensitive Mode (Screen Flash set to weak)
; ---------------------------------------------------------------------------
; Second options bitfield
; RAM location: `OptionsBits2`
;  bit 0 = Disable Music
;  bit 1 = Disable SFX
;  bit 2 = Weak Camera Shake
;  bit 3 = Intense Camera Shake
;  bit 4 = Classic/Remasterd Palettes
;  bit 5 = Space Golf/Antigrav Mode
;  bit 6 = Alt HUD - Total Seconds for Score
;  bit 7 = Alt HUD - Errors for Deaths
; ---------------------------------------------------------------------------
; Screen Effects
; RAM location: `ScreenFuzz`
;  bit 0 = piss filter
;  bit 1 = motion blur

; Default options when starting the game for the first time
	if def(__WIDESCREEN__)
DefaultOptions  = %00000000	; extended camera not needed in widescreen
	else
DefaultOptions  = %00000001
	endif

DefaultOptions2 = %00010000	; remastered palettes
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
		move.w	#$8B07, (a6)
		move.w	#$8720, (a6)
		move.w	#$8C81|$08,(a6)	; enable shadow/highlight mode (SH mode)

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
		lea	ArtKospM_ERaZorNoBG, a0
		jsr	KosPlusMDec_VRAM

		; Load objects
		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$80+SCREEN_WIDTH/2-2,obX(a0)	; set X-position
		move.w	#$82,obScreenY(a0)		; set Y-position
		bset	#7,obGfx(a0)		; make object high plane


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


		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute

		tst.b	($FFFFFF84).w
		bne.s	@firststart
		move.b	#Options_Music,d0	; play Options screen music (Spark Mandrill)
		jsr	PlayBGM
		move.w	#$E3,d0			; regular music speed
		tst.b	(PlacePlacePlace).w	; is easter egg flag enabled?
		beq.s	@play			; if not, branch
		move.w	#$E2,d0			; speed up music
@play:		jsr	PlayCommand
		bra.s	@cont

@firststart:
		vram	$2000
		lea	VDP_Data,a6
		lea	(ArtKospM_PixelStars).l,a0
		jsr	KosPlusMDec_VRAM

		move.b	#$8B,($FFFFD000).w		; load star object
		move.b	#0,($FFFFD000+obRoutine).w
		move.w 	#$80+SCREEN_WIDTH/2,($FFFFD000+obX).w		; horizontally center emitter
		move.w 	#$EC,($FFFFD000+obScreenY).w

@cont:
		vram	$3000
		lea	VDP_Data,a6
		moveq	#-1,d0
		move.w	#$10-1,d1
@transparent:
		rept	8*2
		move.w	d0,(a6)
		endr
		dbf	d1,@transparent

		move.w	#0,BlackBars.Height	; make sure black bars are fully gone
		

		jsr	BackgroundEffects_Setup
		move.w	#$806,(BGThemeColor).w	; set theme color for background effects

		moveq	#1,d0			; load to fade-in buffer
		bsr	Options_LoadPal

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

		assert.w Options_VRAMBufferPoolPtr, eq, #Art_Buffer		; VRAM buffer pool should be reset by the beginning of the frame
		assert.w Options_StringBufferCanary, eq, #Options_CanaryValue	; guard against buffer overflows

		bsr	Options_HandleUpdate
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute
		jsr	PLC_Execute

		tst.b	($FFFFFF84).w
		bne.s	@nobg
		jsr	BackgroundEffects_Update
@nobg:
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
		btst	#3, OptionsBits2	; intense cam shake also enabled?
		beq.s	@1			; if not, branch
		add.w	d1,d1
	@1:
		add.w	d1,($FFFFF616).w	; set to VSRAM
@nocamshake:

		cmp.b	#$24, GameMode				; are we still running Options gamemode?
		beq	OptionsScreen_MainLoop			; if yes, loop
		rts						; exit options menu

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
; Resets everything to defaults
; ---------------------------------------------------------------------------

Options_SetDefaults:
		move.b	#DefaultOptions,(OptionsBits).w		; load default options
		move.b	#DefaultOptions2,(OptionsBits2).w	; load default options 2
		clr.b	(ScreenFuzz).w				; clear visual fx
		clr.b	(BlackBars.HandlerId).w			; reset black bars to emulator mode
		jmp	BlackBars.SetHandler			; update handler

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
@draw:
		bra	Options_RedrawMenuItem_Direct

; ---------------------------------------------------------------------------
@ItemData_Header_Plain:
		dcScreenPos $C000, 4, 1		; start on-screen position
		dc.l	@DrawHeaderPlain		; redraw handler
@ItemData_Header_AHint:
		dcScreenPos $C000, 4, 1		; start on-screen position
		dc.l	@DrawHeaderAHint		; redraw handler
; ---------------------------------------------------------------------------
@DrawHeaderPlain:
		Options_PipeString a4, '<------------------------------------>'
		rts
@DrawHeaderAHint:
		Options_PipeString a4, '<--------PRESS _` FOR DETAILS-------->'
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

		cmpi.w	#9,d1				; Cinematic Mode selected?
		bne.s	@notcinematic			; if not, branch
		jsr	CheckGlobal_BaseGameBeaten_Casual; has the player beaten base game in casual?
		bne.s	@ahint				; if yes, show A hint
	@notcinematic:
		cmpi.w	#10,d1				; ERaZor Powers selected?
		bne.s	@notpowers			; if not, branch
		jsr	CheckGlobal_BaseGameBeaten_Frantic; has the player beaten base game in frantic?
		bne.s	@ahint				; if yes, show A hint
	@notpowers:
		cmpi.w	#11,d1				; True-BS selected?
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
		tst.b	d0
		bne.s	@tobuffer
		moveq	#2,d0		; load level select palette
		jsr	PalLoad2

		movem.l	a1-a2, -(sp)		; backup d0 to a2
		lea	Pal_ERaZorBanner, a1	; set ERaZor banner's palette pointer
		lea	$FFFFFBA0-$80, a2		; set palette location
		rept 8
			move.l	(a1)+, (a2)+
		endr
		movem.l	(sp)+, a1-a2		; restore d0 to a2
		rts

@tobuffer:
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
