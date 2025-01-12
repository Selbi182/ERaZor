
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic 1 ERaZor - Save Select Screen
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

	include	'Screens/SaveSelectScreen/Macros.asm'
	include	'Screens/SaveSelectScreen/Variables.asm'

; -----------------------------------------------------------------------------
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
	move.w	#$8407, (a6)
	move.w	#$8C81+8, (a6)	; enable S&H
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

	; Clear screen RAM
	lea	SaveSelectScreen_RAM, a1
	moveq	#0, d0
	moveq	#SaveSelectScreen_RAM.Size/4-1, d1

	@clear_screen_ram_loop:
		move.l	d0, (a1)+
		dbf	d1, @clear_screen_ram_loop

	rept SaveSelectScreen_RAM.Size&3
		move.b	d0, (a1)+
	endr
	assert.w a1, eq, #SaveSelectScreen_RAM+SaveSelectScreen_RAM.Size

	; Init screen variables
	Screen_PoolReset SaveSelect_VRAMBufferPoolPtr, Art_Buffer, Art_Buffer_End
	move.w	#SaveSelect_CanaryValue, SaveSelect_StringBufferCanary
	move.b	SRAMCache.SelectedSlotId, SaveSelect_SelectedSlotId	; use last save slot ...
	bne.s	@default_slot_ok					; ...
	move.b	#1, SaveSelect_SelectedSlotId				; ... unless it's "NO SAVE", then suggest Slot 1
@default_slot_ok:

	jsr	SaveSelect_InitUI
	move.w	#$824,(BGThemeColor).w					; set theme color for background effects
	jsr	BackgroundEffects_Setup

	jsr	SaveSelect_InitialDraw

	; Setup objects
	Screen_CreateObject #SaveSelect_Obj_SlotOverlays

	VBlank_UnsetMusicOnly
	display_enable

	move.b	#Options_Music, d0
	jsr	PlayBGM

	DeleteQueue_Init
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	DeleteQueue_Execute

	jsr	Pal_FadeTo
	assert.b VBlank_MusicOnly, eq
	; fallthrough

; ---------------------------------------------------------------------------
; Save select screen - Main Loop
; ---------------------------------------------------------------------------

SaveSelect_MainLoop:
	jsr	WhiteFlash_Restore	; restore white flash, if applicable

	move.l	#@FlushVRAMBufferPool, VBlankCallback
	move.b	#2, VBlankRoutine
	jsr	DelayProgram

	addq.w	#1, GameFrame

	assert.w SaveSelect_VRAMBufferPoolPtr, eq, #Art_Buffer			; VRAM buffer pool should be reset by the beginning of the frame
	assert.w SaveSelect_StringBufferCanary, eq, #SaveSelect_CanaryValue	; guard against buffer overflows

	jsr	BackgroundEffects_Update
	bsr	SaveSelect_HandleUI
	bsr	SaveSelect_HandlePaletteEffects

	DeleteQueue_Init
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	DeleteQueue_Execute

	tst.b	SaveSelect_ExitFlag			; are we exiting?
	beq	SaveSelect_MainLoop			; if not, branch

	; TODO: Exit to title screen?
	move.b	SaveSelect_SelectedSlotId, SRAMCache.SelectedSlotId
	jsr	SRAMCache_LoadSelectedSlotId		; load game from selected slot
	jsr	Pal_FadeFrom
	move.w	#$8C81, VDP_Ctrl			; disable S&H
	jmp	Exit_SaveSelectScreen

; ---------------------------------------------------------------------------
@FlushVRAMBufferPool:
	Screen_PoolReset SaveSelect_VRAMBufferPoolPtr, Art_Buffer, Art_Buffer_End
	rts

; ---------------------------------------------------------------------------
; Objects
; ---------------------------------------------------------------------------

	include	"Screens/SaveSelectScreen/Objects/SlotOverlays.asm"

; ---------------------------------------------------------------------------
; UI Routines
; ---------------------------------------------------------------------------

SaveSelect_InitUI:
	; Load all compressed graphics
	lea	@PLC_List(pc), a1
	jsr	LoadPLC_Direct
	jsr	PLC_ExecuteOnce_Direct

	lea	VDP_Ctrl, a5
	lea	VDP_Data, a6

	; Load and draw base UI elements (header + borders)
	lea	SaveSelect_UI_MapEni, a0
	lea	$FF0000, a1
	move.w	#$8000|$6000|(SaveSelect_VRAM_UIElements/$20), d0
	jsr	EniDec

	vram	SaveSelect_VRAM_FG, d0
	lea	$FF0000, a1
	moveq	#40-1, d1
	moveq	#28-1, d2
	jsr	ShowVDPGraphics

	; Load FG palettes
	lea	Pal_Target+$20, a0
	lea	@PaletteData(pc), a1
	moveq	#(@PaletteData_End-@PaletteData)/16-1, d0
	@loop:
		rept 16/4
			move.l	(a1)+, (a0)+
		endr
		dbf	d0, @loop

	rts

; ---------------------------------------------------------------
@PaletteData:
	; Line 1 - Highlighted text
	dc.w	$0000, $0444, $0EEE, $0EEE, $0EEE, $0EEE, $0CCC, $0AAA
	dc.w	$0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E

	; Line 2 - Normal text
	dc.w	$0000, $0444/2, $0EEE/2, $0EEE/2, $0EEE/2, $0EEE/2, $0CCC/2, $0AAA/2
	dc.w	$0CEE, $0ACC, $08AA, $0888, $0688, $0666, $0444, $0222

	; Line 3 - UI elements
	dc.w	$0000, $0422, $0E8A, $0E8A, $0EAA, $0E8A, $0C68, $0846	; UI small font
	dc.w	$0000, $0000, $0000, $0000, $0000, $0EEE, $0AAA, $0E0E	; UI borders + header
@PaletteData_End:

; ---------------------------------------------------------------
@PLC_List:
	dc.l	BBCS_ArtKospM_Font
	dc.w	SaveSelect_VRAM_Font

	dc.l	SaveSelect_UI_Tiles_KospM
	dc.w	SaveSelect_VRAM_UIElements

	dc.l	Screens_SH_Shadow_ArtKospM
	dc.w	SaveSelect_VRAM_SH_Shadow

	dc.w	-1	; end marker

; ---------------------------------------------------------------------------
SaveSelect_InitialDraw:
	; Draw hints
	lea	SaveSelect_DrawText_Inactive(pc), a4
	SaveSelect_WriteString a4, 6, 26, "-  A > B > C: DELETE SLOT  -"

	; Redraw all slots
	bsr	SaveSelect_DrawSlot_0
	bsr	SaveSelect_DrawSlot_1
	bsr	SaveSelect_DrawSlot_2
	bra	SaveSelect_DrawSlot_3

; ---------------------------------------------------------------------------
; INPUT:
;	d0 .b	- Slot Id
; ---------------------------------------------------------------------------

SaveSelect_DrawSlot:
	and.w	#3, d0
	add.w	d0, d0
	add.w	d0, d0
	jmp	@tbl(pc,d0)

@tbl:	bra.w	SaveSelect_DrawSlot_0	; "NO SAVE"
	bra.w	SaveSelect_DrawSlot_1	; "SLOT 1"
	bra.w	SaveSelect_DrawSlot_2	; "SLOT 2"
	bra.w	SaveSelect_DrawSlot_3	; "SLOT 3"

__slotId: = 0

	rept 4
SaveSelect_DrawSlot_\#__slotId:
	; Draw "No Slot"
	if __slotId = 0
		__baseX: = 3
		__baseY: = 5

		lea	SaveSelect_DrawText_Highlighted(pc), a4		; use highlighted font
		tst.b	SaveSelect_SelectedSlotId			; are we selected slot?
		beq.s	@0						; if yes, branch
		lea	SaveSelect_DrawText_Normal(pc), a4		; use normal font
	@0:
		SaveSelect_WriteString a4, __baseX, __baseY, "NO SAVE"
		rts

	; Draw "Slot X"
	else
		__baseX: = 3
		__baseY: = __slotId*6+2
		__slotRAM: = SRAMCache.Slots+(__slotId-1)*SaveSlot.Size

		lea	SaveSelect_DrawText_Highlighted(pc), a4			; use highlighted font
		cmp.b	#__slotId, SaveSelect_SelectedSlotId			; are we selected slot?
		beq.s	@0							; if yes, branch
		lea	SaveSelect_DrawText_Normal(pc), a4			; use normal font
	@0:
		move.b	SaveSlot.Progress+(__slotRAM), d5
		btst	#SlotState_Created, d5					; are we empty slot?
		beq	@emptySlot						; if yes, branch


		move.b	SaveSlot.Doors+(__slotRAM), d3				; use casual doors
		lea	SaveSelect_StrDifficulty_Casual(pc), a3			; use "casual" text
		btst	#SlotState_Difficulty, d5				; are we frantic?
		beq.s	@1							; if not, branch
		move.b	SaveSlot.Doors+1+(__slotRAM), d3			; use frantic doors
		lea	SaveSelect_StrDifficulty_Frantic(pc), a3		; use "frantic" text
	@1:
		popcnt.b d3, d4, d0						; d4 = number of 1's in d3 (`popcnt` is a x86_64 instruction)
		btst	#SlotState_BlackoutBeaten, d5				; did we beat blackout?
		beq.s	@2							; if not, branch
		addq.b	#1, d4							; count that as +1 trophy
	@2:
		lea	SaveSelect_StrTbl_Chapters(pc), a5
		moveq	#$F, d0
		and.b	SaveSlot.Chapter+(__slotRAM), d0			; d0 = chapter
		add.w	d0, d0
		add.w	d0, d0
		btst	#SlotOptions2_PlacePlacePlace, SaveSlot.Options2+(__slotRAM)
		bne.w	@3
		movea.l	(a5, d0), a5						; a5 = chapter text

		SaveSelect_WriteString a4, __baseX, __baseY,		"SLOT \#__slotId: %<.l a5 str>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"DEATHS: %<.w SaveSlot.Deaths+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+3,	"SCORE: %<.l SaveSlot.Score+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+19, __baseY+2,	"TROPHIES: %<.b d4 dec>/8"
		SaveSelect_WriteString a4, __baseX+19, __baseY+3,	"%<.l a3 str>"	; CASUAL / FRANTIC
		rts

	@3:	movea.l	$40(a5, d0), a5						; a5 = chapter text

		SaveSelect_WriteString a4, __baseX, __baseY,		"SLOT \#__slotId: %<.l a5 str>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"PLACE: %<.w SaveSlot.Deaths+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+3,	"PLACE: %<.l SaveSlot.Score+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+19, __baseY+2,	"PLACE: %<.b d4 dec>/8"
		SaveSelect_WriteString a4, __baseX+19, __baseY+3,	"PLACE PLACE"	; CASUAL / FRANTIC
		rts

	@emptySlot:
		SaveSelect_WriteString a4, __baseX, __baseY,		"SLOT \#__slotId:"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"EMPTY"
		rts
	endif

	__slotId: = __slotId+1
	endr

; ---------------------------------------------------------------------------
; INPUT:
;	d0 .b	- Slot Id
; ---------------------------------------------------------------------------

SaveSelect_ClearSlot:
	and.w	#3, d0
	add.w	d0, d0
	add.w	d0, d0
	jmp	@tbl(pc,d0)

@tbl:	bra.w	SaveSelect_ClearSlot_0	; "NO SAVE"
	bra.w	SaveSelect_ClearSlot_1	; "SLOT 1"
	bra.w	SaveSelect_ClearSlot_2	; "SLOT 2"
	bra.w	SaveSelect_ClearSlot_3	; "SLOT 3"

__slotId: = 0

	rept 4
SaveSelect_ClearSlot_\#__slotId:
	if __slotId = 0
		rts

	else
		__baseX: = 3
		__baseY: = __slotId*6+2

		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_FG+((__baseY)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_FG+((__baseY+2)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_FG+((__baseY+3)*$80)+((__baseX)*2)
		rts
	endif

	__slotId: = __slotId+1
	endr

; ---------------------------------------------------------------------------
SaveSelect_EmptyTiles:
	dcb.b	$80, 0

; ---------------------------------------------------------------------------
SaveSelect_StrDifficulty_Casual:
	dc.b	'CASUAL', 0

SaveSelect_StrDifficulty_Frantic:
	dc.b	'FRANTIC', 0
	even

SaveSelect_StrTbl_Chapters:
	dc.l	@0, @1, @2, @3		; Normal versions
	dc.l	@4, @5, @6, @7
	dc.l	@8, @N, @N, @N
	dc.l	@N, @N, @N, @N

	dc.l	@0p, @1p, @2p, @3p	; Place Place Place versions
	dc.l	@4p, @5p, @6p, @7p
	dc.l	@8p, @N, @N, @N
	dc.l	@N, @N, @N, @N

@0:	dc.b	'ONE HOT DAY', 0
@1:	dc.b	'RUN TO THE HILLS', 0
@2:	dc.b	'SPECIAL FRUSTRATION', 0
@3:	dc.b	'INHUMAN THROUGH THE RUINS', 0
@4:	dc.b	'WET PIT OF DEATH', 0
@5:	dc.b	'HOVER INTO YOUR FRUSTRATION', 0
@6:	dc.b	'WATCH THE NIGHT EXPLODE', 0
@7:	dc.b	'SOMETHING UNDERNEATH', 0
@8:	dc.b	'IN THE END', 0

@0p:	dc.b	'ONE PLACE DAY', 0
@1p:	dc.b	'PLACE TO THE PLACE', 0
@2p:	dc.b	'PLACIAL PLACESTATION', 0
@3p:	dc.b	'INPLACE THROUGH THE PLACE', 0
@4p:	dc.b	'PLACE PLACE OF PLACE', 0
@5p:	dc.b	'PLACE INTO YOUR PLACESTATION', 0
@6p:	dc.b	'PLACE THE PLACE EXPLACE', 0
@7p:	dc.b	'PLACING UNDERPLACE', 0
@8p:	dc.b	'IN THE PLACE', 0

@N:	dc.b	0	; invalid/fallback
	even

; ---------------------------------------------------------------------------
SaveSelect_DrawText_Inactive:
	move.w	#$6000, d1				; use palette line 3
	bra.s	SaveSelect_DrawText_Cont

SaveSelect_DrawText_Highlighted:
	move.w	#$2000, d1				; use palette line 1
	bra.s	SaveSelect_DrawText_Cont

SaveSelect_DrawText_Normal:
	move.w	#$4000, d1				; use palette line 2

SaveSelect_DrawText_Cont:
	Screen_PoolAllocate a1, SaveSelect_VRAMBufferPoolPtr, #SaveSelect_StringBufferSize*2
	move.l	a1, -(sp)

	clr.b	(a0)+					; finalize buffer
	lea	SaveSelect_StringBuffer, a0

	add.w	#SaveSelect_Pat_Font, d1
	moveq	#0, d7
	move.b	(a0)+, d7				; d7 = char
	beq.s	@done

	@loop:	add.w	d1, d7
		move.w	d7, (a1)+				; send tile
		moveq	#0, d7
		move.b	(a0)+, d7				; d7 = char
		bne.s	@loop

	move.l	(sp)+, d1				; d1 = source pointer
	andi.l	#$FFFFFF, d1
	move.w	SaveSelect_StringScreenPos, d2		; d2 = destination VRAM
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
; Update palette to highlight current selection
; ---------------------------------------------------------------------------

SaveSelect_HandlePaletteEffects:

	@var0:		equr	d0
	@var1:		equr	d1
	@slot_active:	equr	d5		; active color/slot
	@slot_cnt:	equr	d6		; color/slot counter

	@palette: 	equr	a0

	lea	Pal_Active+$70, @palette			; 
	moveq	#4-1, @slot_active
	sub.b	SaveSelect_SelectedSlotId, @slot_active
	moveq	#4-1, @slot_cnt

	@update_color_loop:
		cmp.w	@slot_active, @slot_cnt
		beq.s	@update_color_active

	; ---------------------------------------------------------------------------
*	@update_color_inactive:
		move.b	(@palette)+, @var0		; blue
		beq.s	@i0
		subq.b	#2, -1(@palette)
	@i0:	move.b	(@palette)+, @var0		; green/red
		beq.s	@inext
		moveq	#$E, @var1
		and.b	@var0, @var1
		beq.s	@i2
		subq.b	#2, @var1
	@i2:	and.b	#$E0, @var0
		beq.s	@i3
		sub.b	#$20, @var0
	@i3:	or.b	@var1, @var0
		move.b	@var0, -1(@palette)
	@inext:	dbf	@slot_cnt, @update_color_loop
		rts

	; ---------------------------------------------------------------------------
	@update_color_active:
		move.b	(@palette)+, @var0		; blue
		cmp.b	#$E, @var0
		beq.s	@a0
		addq.b	#2, -1(@palette)
	@a0:	move.b	(@palette), @var0		; green/red
		moveq	#$E, @var1
		and.b	@var0, @var1
		cmp.b	#$E, @var1
		beq.s	@a2
		addq.b	#2, @var1
	@a2:	and.b	#$E0, @var0
		cmp.b	#$E0, @var0
		beq.s	@a3
		add.b	#$20, @var0
	@a3:	or.b	@var1, @var0
		move.b	@var0, (@palette)+
		dbf	@slot_cnt, @update_color_loop

	rts

; ---------------------------------------------------------------------------
; Subroutine to handle/control UI
; ---------------------------------------------------------------------------

SaveSelect_HandleUI:
	move.b	SaveSelect_SelectedSlotId, d7	; d7 = previous selection
	
	move.b	Joypad|Press, d0
	bmi.s	@PlayCurrentSlot		; start pressed? confirm slot selection

	cmpi.b	#C, d0				; exactly C pressed?
	bne.s	@notc				; if not, branch
	cmp.b	Joypad|Held, d0			; exactly C held?
	beq.s	@PlayCurrentSlot		; if yes, also confirm slot selection
@notc:

	moveq	#A|B|C, d1
	and.b	d0, d1
	beq.s	@nodel
	moveq	#$FFFFFFA9, d0
	jsr	PlaySFX
	cmpi.b	#A|B|C, Joypad|Held		; exactly A+B+C held?
	beq.s	@DeleteSelectedSlot		; if yes, delete selected slot
	rts
@nodel:

	; handle up/down
	btst	#iUp, d0
	bne.s	@PreviousSelection
	btst	#iDown, d0
	bne.s	@NextSelection

@ret	rts

; ---------------------------------------------------------------------------
@NextSelection:
	move.b	d7, d0
	addq.b	#1, d0
	and.b	#3, d0
	bra.s	@UpdateSelection

@PreviousSelection:
	move.b	d7, d0
	subq.b	#1, d0
	and.b	#3, d0

@UpdateSelection:
	move.b	d0, SaveSelect_SelectedSlotId
	jsr	SaveSelect_DrawSlot		; re-draw newly selected slot

@UpdateSelection2:
	move.b	d7, d0
	jsr	SaveSelect_DrawSlot		; re-draw unselected slot
	moveq	#$FFFFFFD8, d0
	jmp	PlaySFX

@DeleteSelectedSlot:
	move.b	d7, d0
	beq	@ret				; if slot is empty, bail
	jsr	SRAMCache_GetSlotData		; INPUT: d0 = Slot id, OUTPUT: a2 = Slot data
	jsr	SRAMCache_ClearSlot		; INPUT: a2 = Slot data
	move.b	d7, d0
	bsr	SaveSelect_ClearSlot		; clear all lines on this slot
	move.b	d7, d0
	bsr	SaveSelect_DrawSlot		; redraw slot
	jsr	WhiteFlash
	moveq	#$FFFFFFDF, d0
	jmp	PlaySFX

@PlayCurrentSlot:
	st.b	SaveSelect_ExitFlag
	moveq	#$FFFFFFC3, d0
	jmp	PlaySFX

; ---------------------------------------------------------------------------
SaveSelect_UI_Tiles_KospM:
	incbin	"Screens/SaveSelectScreen/Data/ScreenUI_Tiles.kospm"
	even

SaveSelect_UI_MapEni:
	incbin	"Screens/SaveSelectScreen/Data/ScreenUI_Map.eni"
	even
