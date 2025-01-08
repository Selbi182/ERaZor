
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic 1 ERaZor - Save Select Screen
;
; (c) 2024, vladikcomper
; -----------------------------------------------------------------------------

	include	'Screens/SaveSelectScreen/Macros.asm'

; -----------------------------------------------------------------------------

SaveSelect_VRAM_Font:		equ	$4000
SaveSelect_VRAM_Header:		equ	$A000
SaveSelect_VRAM_FG:		equ	$C000
SaveSelect_Pat_Font:		equ	$8000|(SaveSelect_VRAM_Font/$20)-('!'-1)

; -----------------------------------------------------------------------------
SaveSelect_StringBufferSize = 40+1
SaveSelect_CanaryValue = $F00D

; -----------------------------------------------------------------------------
SaveSelectScreen_RAM:		equ	$FFFF8000

				rsset	SaveSelectScreen_RAM
SaveSelect_StringBuffer:	rs.b	SaveSelect_StringBufferSize+(SaveSelect_StringBufferSize&1)
SaveSelect_StringBufferCanary:	rs.w	1
SaveSelect_StringScreenPos:	rs.w	1
SaveSelect_VRAMBufferPoolPtr:	rs.w	1
SaveSelect_SelectedSlotId:	rs.b	1
SaveSelect_ExitFlag:		rs.b	1
SaveSelectScreen_RAM.Size:	equ	__rs-SaveSelectScreen_RAM

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
	SaveSelect_ResetVRAMBufferPool
	move.w	#SaveSelect_CanaryValue, SaveSelect_StringBufferCanary
	move.b	SRAMCache.SelectedSlotId, SaveSelect_SelectedSlotId	; use last save slot ...
	bne.s	@default_slot_ok					; ...
	move.b	#1, SaveSelect_SelectedSlotId				; ... unless it's "NO SAVE", then suggest Slot 1
@default_slot_ok:

	jsr	BackgroundEffects_Setup
	move.w	#$824,(BGThemeColor).w	; set theme color for background effects

	jsr	SaveSelect_InitUI
	jsr	SaveSelect_InitialDraw

	VBlank_UnsetMusicOnly
	display_enable

	move.b	#Options_Music, d0
	jsr	PlayBGM

	jsr	BackgroundEffects_Update
	; Copy BG palette to fade in buffer ###
	lea	Pal_Active+2, a0
	lea	Pal_Target+2, a1
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+

	jsr	Pal_FadeTo
	assert.b VBlank_MusicOnly, eq
	; fallthrough

; ---------------------------------------------------------------------------
; Save select screen - Main Loop
; ---------------------------------------------------------------------------

SaveSelect_MainLoop:
	move.l	#@FlushVRAMBufferPool, VBlankCallback
	move.b	#2, VBlankRoutine
	jsr	DelayProgram

	assert.w SaveSelect_VRAMBufferPoolPtr, eq, #Art_Buffer			; VRAM buffer pool should be reset by the beginning of the frame
	assert.w SaveSelect_StringBufferCanary, eq, #SaveSelect_CanaryValue	; guard against buffer overflows

	jsr	BackgroundEffects_Update
	bsr	SaveSelect_HandleUI

	tst.b	SaveSelect_ExitFlag			; are we exiting?
	beq	SaveSelect_MainLoop			; if not, branch

	; TODO: Exit to title screen?
	move.b	SaveSelect_SelectedSlotId, SRAMCache.SelectedSlotId
	jsr	SRAMCache_LoadSelectedSlotId		; load game from selected slot
	jmp	Exit_SaveSelectScreen

; ---------------------------------------------------------------------------
@FlushVRAMBufferPool:
	SaveSelect_ResetVRAMBufferPool
	rts

; ---------------------------------------------------------------------------
; UI Routines
; ---------------------------------------------------------------------------

SaveSelect_InitUI:
	; Load all compressed graphics
	lea	@PLC_List(pc), a1
	jsr	LoadPLC_Direct
	jsr	PLC_ExecuteOnce_Direct

	; Load header mappings (### TODO: Replace this placeholder)
	lea	SoundTest_Header_MapEni, a0
	lea	$FF0000, a1
	move.w	#$8000|$6000|(SaveSelect_VRAM_Header/$20), d0
	jsr	EniDec

	vram	SaveSelect_VRAM_FG+$80+10*2, d0
	lea	$FF0000, a1
	moveq	#20-1, d1
	moveq	#2-1, d2
	jsr	ShowVDPGraphics

	; Load palette (### TODO: Improve code and palettes)
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
	lea	Pal_Target+$60, a0
	lea	@PaletteData_Header(pc), a1
	rept 8/2
		move.l	(a1)+, (a0)+
	endr
	rts

; ---------------------------------------------------------------
@PaletteData_Highlighted:
	dc.w	$0000, $0444, $0EEE, $0EEE, $0EEE, $0EEE, $0CCC, $0AAA

@PaletteData_Normal:
	dc.w	$0000, $0444/2, $0EEE/2, $0EEE/2, $0EEE/2, $0EEE/2, $0CCC/2, $0AAA/2

@PaletteData_Header:
	dc.w	$0000, $0422, $0E88, $0E88, $0E88, $0E88, $0C66, $0A44

; ---------------------------------------------------------------
@PLC_List:
	dc.l	BBCS_ArtKospM_Font
	dc.w	SaveSelect_VRAM_Font

	dc.l	SoundTest_Header_Tiles_KospM	; ###
	dc.w	SaveSelect_VRAM_Header

	dc.w	-1	; end marker

; ---------------------------------------------------------------------------
SaveSelect_InitialDraw:
	; Draw hints
	lea	SaveSelect_DrawText_Inactive(pc), a4
	SaveSelect_WriteString a4, 6, 26, "- START: SELECT, B: DELETE -"

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
	movea.l	@tbl(pc,d0), a0
	jmp	(a0)

@tbl:	dc.l	SaveSelect_DrawSlot_0	; "NO SAVE"
	dc.l	SaveSelect_DrawSlot_1	; "SLOT 1"
	dc.l	SaveSelect_DrawSlot_2	; "SLOT 2"
	dc.l	SaveSelect_DrawSlot_3	; "SLOT 3"

__slotId: = 0

	rept 4
SaveSelect_DrawSlot_\#__slotId:
	; Draw "No Slot"
	if __slotId = 0
		__baseX: = 2
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
		__baseX: = 2
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

		lea	SaveSelect_StrTbl_Chapters(pc), a5
		moveq	#$F, d0
		and.b	SaveSlot.Chapter+(__slotRAM), d0			; d0 = chapter
		add.w	d0, d0
		add.w	d0, d0
		movea.l	(a5, d0), a5						; a5 = chapter text

		move.b	SaveSlot.Doors+(__slotRAM), d3				; use casual doors
		lea	SaveSelect_StrDifficulty_Casual(pc), a3			; use "casual" text
		btst	#SlotState_Difficulty, d5				; are we frantic?
		beq.s	@1							; if not, branch
		move.b	SaveSlot.Doors+1+(__slotRAM), d3			; use frantic doors
		lea	SaveSelect_StrDifficulty_Frantic(pc), a3		; use "frantic" text
	@1:
		and.b	#%1111111, d3						; don't count "Unterhub" as a separate trophy
		popcnt.b d3, d4, d0						; d4 = number of 1's in d3 (`popcnt` is a x86_64 instruction)
		btst	#SlotState_BlackoutBeaten, d5				; did we beat blackout?
		beq.s	@2							; if not, branch
		addq.b	#1, d4							; count that as +1 trophy
	@2:
		SaveSelect_WriteString a4, __baseX, __baseY,		"SLOT \#__slotId: %<.l a5 str>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"DEATHS: %<.w SaveSlot.Deaths+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+3,	"SCORE: %<.l SaveSlot.Score+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+20, __baseY+2,	"%<.l a3 str>"	; CASUAL / FRANTIC
		SaveSelect_WriteString a4, __baseX+20, __baseY+3,	"TROPHIES: %<.b d4 dec>/7"
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
	movea.l	@tbl(pc,d0), a0
	jmp	(a0)

@tbl:	dc.l	SaveSelect_ClearSlot_0	; "NO SAVE"
	dc.l	SaveSelect_ClearSlot_1	; "SLOT 1"
	dc.l	SaveSelect_ClearSlot_2	; "SLOT 2"
	dc.l	SaveSelect_ClearSlot_3	; "SLOT 3"

__slotId: = 0

	rept 4
SaveSelect_ClearSlot_\#__slotId:
	if __slotId = 0
		rts

	else
		__baseX: = 2
		__baseY: = __slotId*6+2

		QueueStaticDMA SaveSelect_EmptyTiles, (40-4)*2, SaveSelect_VRAM_FG+((__baseY)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-4)*2, SaveSelect_VRAM_FG+((__baseY+2)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-4)*2, SaveSelect_VRAM_FG+((__baseY+3)*$80)+((__baseX)*2)
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
	dc.l	@0, @1, @2, @3
	dc.l	@4, @5, @6, @7
	dc.l	@8, @N, @N, @N
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
	SaveSelect_AllocateInVRAMBufferPool a1, #SaveSelect_StringBufferSize*2
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

SaveSelect_HandleUI:
	move.b	SaveSelect_SelectedSlotId, d7	; d7 = previous selection
	move.b	Joypad|Press, d0
	bmi.s	@PlayCurrentSlot
	btst	#iB, d0
	bne.s	@ClearSelection
	btst	#iUp, d0
	bne.s	@PreviousSelection
	btst	#iDown, d0
	bne.s	@NextSelection
@ret	rts

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

@ClearSelection:
	move.b	d7, d0
	beq	@ret				; if slot is empty, bail
	jsr	SRAMCache_GetSlotData		; INPUT: d0 = Slot id, OUTPUT: a2 = Slot data
	jsr	SRAMCache_ClearSlot		; INPUT: a2 = Slot data
	move.b	d7, d0
	bsr	SaveSelect_ClearSlot		; clear all lines on this slot
	move.b	d7, d0
	bsr	SaveSelect_DrawSlot		; redraw slot
	moveq	#$FFFFFFC3, d0
	jmp	PlaySFX

@PlayCurrentSlot:
	st.b	SaveSelect_ExitFlag
	moveq	#$FFFFFFC3, d0
	jmp	PlaySFX
