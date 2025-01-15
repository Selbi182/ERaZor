
; =============================================================================
; -----------------------------------------------------------------------------
; Sonic ERaZor 8 - Save Select Screen
;
; (c) 2024-2025, vladikcomper
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
	move.w	#$8B00, (a6)
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
	jsr	SaveSelect_InitialDraw
	jsr	SaveSelect_InitialHandleBG	; force-render Plane C the first time

	; Setup objects
	Screen_CreateObject #SaveSelect_Obj_SlotOverlays

	VBlank_UnsetMusicOnly
	display_enable

	move.b	#SaveSelect_Music, d0
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

	bsr	SaveSelect_HandleUI
	bsr	SaveSelect_HandleBG
	bsr	SaveSelect_HandlePaletteEffects

	DeleteQueue_Init
	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	DeleteQueue_Execute

	; exit save select
	tst.b	SaveSelect_ExitFlag			; are we exiting?
	beq	SaveSelect_MainLoop			; if not, loop

	tst.b	WhiteFlashCounter			; white flash still active?
	bne	SaveSelect_MainLoop			; if yes, wait
	move.b	SaveSelect_SelectedSlotId, SRAMCache.SelectedSlotId
	jsr	SRAMCache_LoadSelectedSlotId		; load game from selected slot
	jsr	SRAMCache_Commit
	jsr	Pal_FadeFrom
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
; Renders a cool looking BG on the third scrollable layer (BG C)
; ---------------------------------------------------------------------------

SaveSelect_InitialHandleBG:
	move.w	#-1, SaveSelect_BG_C_PrevFrame	; force BG C redraw

; ---------------------------------------------------------------------------
SaveSelect_HandleBG:
	; Calculate BG B position (relative to time)
	move.w	GameFrame, d0
	lsr.w	d0
	move.w	d0, VSRAM_Buffer+2
	move.w	d0, d1
	neg.w	d1			; d1 = -GameFrame/2
	move.w	d1, HSRAM_Buffer+2

	; Calculate BG C position (relative to time)
	; INPUT: d1 = -GameFrame/2
	lsr.w	d0
	add.w	d1, d0
	and.w	#$1F, d0
	ror.w	#16-10, d0

	; Render BG C frame
	cmp.w	SaveSelect_BG_C_PrevFrame, d0	; is this frame rendered?
	beq.s	@ret				; if yes, branch
	move.w	d0, SaveSelect_BG_C_PrevFrame
	move.l	#SaveSelectScreen_BG_C_Buffer, d1
	add.w	d0, d1				; d1 = $FF0000 + FrameOffset
	move.w	#SaveSelect_VRAM_BG_C, d2
	move.w	#SaveSelect_BG_C_FrameSize/2, d3
	jmp	QueueDMATransfer

@ret:	rts


; ---------------------------------------------------------------------------
; UI Routines
; ---------------------------------------------------------------------------

SaveSelect_InitUI:
	; Load all compressed graphics
	lea	@PLC_List(pc), a1
	jsr	LoadPLC_Direct
	jsr	PLC_ExecuteOnce_Direct

	; Load BG B
	lea	SaveSelect_BG_B_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#SaveSelect_Pat_BG_B, d0
	jsr	EniDec

	vramWrite $FF0000, $1000, SaveSelect_VRAM_PlaneB

	; Load base UI elements (header + borders)
	lea	SaveSelect_UI_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#SaveSelect_Pat_UIElements, d0
	jsr	EniDec

	vramWrite $FF0000, $1000, SaveSelect_VRAM_PlaneA

	; Load BG C buffer
	; WARNING! This sound stay at the bottom so we don't overwrite BG C buffer ($FF0000)!
	lea	SaveSelect_BG_C_Tiles_Kosp, a0
	lea	SaveSelectScreen_BG_C_Buffer, a1
	jsr	KosPlusDec
	_assert.l a1, eq, #$FF8000	; decompressed data should be 32 KiB

	; Load palettes
	lea	Pal_Target, a0
	lea	@PaletteData(pc), a1
	moveq	#(@PaletteData_End-@PaletteData)/16-1, d0
	@loop2:
		rept 16/4
			move.l	(a1)+, (a0)+
		endr
		dbf	d0, @loop2

	rts

; ---------------------------------------------------------------
@PaletteData:
	; Line 0 - Slot text (white)
	dc.w	$0000, $0000, $0EEE, $0EEE, $0EEE, $0EEE, $0CCC, $0AAA
	dc.w	$0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E

	; Line 1 - Slot text (yellow)
	dc.w	$0000, $0000, $04EE, $04EE, $06EE, $04EE, $02CC, $00AA
	dc.w	$0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E

	; Line 2 - UI label text + Header text
	dc.w	$0000, $0000, $08EE, $08EE, $0AEE, $08EE, $06CC, $04AA	; highlighted yellow
	dc.w	$0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E

	; Line 3 - Backgrounds
	dc.w	$0000, $0462, $0462, $0682, $0824, $0A46, $0804/2, $0C48/2
	dc.w	$0000, $0000, $0000, $0000, $0000, $0EEE, $0AAA, $0E0E	; UI borders + header
@PaletteData_End:

; ---------------------------------------------------------------
@PLC_List:
	dc.l	SaveSelect_BG_B_Tiles_KospM
	dc.w	SaveSelect_VRAM_BG_B

	dc.l	Screens_MenuFont_ArtKospM
	dc.w	SaveSelect_VRAM_Font

	dc.l	SaveSelect_UI_Tiles_KospM
	dc.w	SaveSelect_VRAM_UIElements

	dc.l	Screens_SH_Shadow_ArtKospM
	dc.w	SaveSelect_VRAM_SH_Shadow

	dc.w	-1	; end marker

; ---------------------------------------------------------------------------
SaveSelect_InitialDraw:
	; Draw hints
	bsr	SaveSelect_DrawBottomHint

	; Redraw all slots
	bsr	SaveSelect_DrawSlot_0
	bsr	SaveSelect_DrawSlot_1
	bsr	SaveSelect_DrawSlot_2
	bra	SaveSelect_DrawSlot_3
; ---------------------------------------------------------------------------

SaveSelect_DrawBottomHint:
	lea	SaveSelect_DrawText_UILabel(pc), a4
	tst.b	SaveSelect_SelectedSlotId		; No Save selected?
	beq.s	@nosave					; if yes, branch

	SaveSelect_WriteString a4, 6, 26, "-  A > B > C: DELETE SLOT  -"
	rts
@nosave:
	SaveSelect_WriteString a4, 6, 26, "A > B > C : RESET EVERYTHING"
	rts
@empty:
	SaveSelect_WriteString a4, 6, 26, "                            "
	rts


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

		lea	SaveSelect_DrawText_ActiveSlot(pc), a4		; use highlighted drawer
		tst.b	SaveSelect_SelectedSlotId			; are we selected slot?
		beq.s	@0						; if yes, branch
		lea	SaveSelect_DrawText_InactiveSlot(pc), a4	; use normal drawer
	@0:
		SaveSelect_WriteString a4, __baseX, __baseY, "%<pal1>NO SAVE"
		rts

	; Draw "Slot X"
	else
		__baseX: = 3
		__baseY: = __slotId*6+2
		__slotRAM: = SRAMCache.Slots+(__slotId-1)*SaveSlot.Size

		lea	SaveSelect_DrawText_ActiveSlot(pc), a4			; use highlighted drawer
		cmp.b	#__slotId, SaveSelect_SelectedSlotId			; are we selected slot?
		beq.s	@0							; if yes, branch
		lea	SaveSelect_DrawText_InactiveSlot(pc), a4		; use normal drawer
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

		move.l	SaveSlot.Score+(__slotRAM), d1				; multiply score by 10 because the HUD fakes a 0
		add.l	d1, d1							; 2x
		move.l	d1, d2
		lsl.l	#2, d1							; 8x
		add.l	d2, d1							; 10x

		btst	#SlotOptions2_PlacePlacePlace, SaveSlot.Options2+(__slotRAM)
		bne.w	@3
		movea.l	(a5, d0), a5						; a5 = chapter text

		SaveSelect_WriteString a4, __baseX, __baseY,		"%<pal1>SLOT \#__slotId: %<pal0>%<.l a5 str>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"%<pal1>DEATHS: %<pal0>%<.w SaveSlot.Deaths+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+3,	"%<pal1>SCORE: %<pal0>%<.l d1 dec>"
		SaveSelect_WriteString a4, __baseX+19, __baseY+2,	"%<pal1>TROPHIES: %<pal0>%<.b d4 dec>/8"
		SaveSelect_WriteString a4, __baseX+19, __baseY+3,	"%<pal1>%<.l a3 str>"	; CASUAL / FRANTIC
		rts

	@3:	movea.l	$40(a5, d0), a5						; a5 = place place

		SaveSelect_WriteString a4, __baseX, __baseY,		"%<pal1>SLOT \#__slotId: %<pal0>%<.l a5 str>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"%<pal1>PLACE: %<pal0>%<.w SaveSlot.Deaths+(__slotRAM) dec>"
		SaveSelect_WriteString a4, __baseX+2, __baseY+3,	"%<pal1>PLACE: %<pal0>%<.l d1 dec>"
		SaveSelect_WriteString a4, __baseX+19, __baseY+2,	"%<pal1>PLACE: %<pal0>%<.b d4 dec>/8"
		SaveSelect_WriteString a4, __baseX+19, __baseY+3,	"%<pal1>PLACE PLACE"
		rts

	@emptySlot:
		SaveSelect_WriteString a4, __baseX, __baseY,		"%<pal1>SLOT \#__slotId:"
		SaveSelect_WriteString a4, __baseX+2, __baseY+2,	"%<pal1>CREATE NEW SAVE"
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

		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_PlaneA+((__baseY)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_PlaneA+((__baseY+2)*$80)+((__baseX)*2)
		QueueStaticDMA SaveSelect_EmptyTiles, (40-6)*2, SaveSelect_VRAM_PlaneA+((__baseY+3)*$80)+((__baseX)*2)
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
@5:	dc.b	'HOVER INTO FRUSTRATION', 0
@6:	dc.b	'WATCH THE NIGHT EXPLODE', 0
@7:	dc.b	'SOMETHING UNDERNEATH', 0
@8:	dc.b	'IN THE END', 0

@0p:	dc.b	'ONE PLACE DAY', 0
@1p:	dc.b	'PLACE TO THE PLACE', 0
@2p:	dc.b	'PLACIAL PLACESTATION', 0
@3p:	dc.b	'INPLACE THROUGH THE PLACE', 0
@4p:	dc.b	'PLACE PLACE OF PLACE', 0
@5p:	dc.b	'PLACE INTO PLACETATION', 0
@6p:	dc.b	'PLACE THE PLACE EXPLACE', 0
@7p:	dc.b	'PLACING UNDERPLACE', 0
@8p:	dc.b	'IN THE PLACE', 0

@N:	dc.b	0	; invalid/fallback
	even

; ---------------------------------------------------------------------------
SaveSelect_DrawText_UILabel:
	move.w	#$4000|$8000, d1			; use palette line 2 / normal intensity
	bra.s	SaveSelect_DrawText_Cont

SaveSelect_DrawText_ActiveSlot:
	move.w	#$8000, d1				; use palette line 1 / normal intensity
	bra.s	SaveSelect_DrawText_Cont

SaveSelect_DrawText_InactiveSlot:
	moveq	#0, d1					; use palette line 1 / shadowed
	;fallthrough

SaveSelect_DrawText_Cont:
	Screen_PoolAllocate a1, SaveSelect_VRAMBufferPoolPtr, #SaveSelect_StringBufferSize*2
	move.l	a1, -(sp)

	clr.b	(a0)+					; finalize buffer
	lea	SaveSelect_StringBuffer, a0

	add.w	#SaveSelect_Pat_Font, d1
	moveq	#0, d7
	move.b	(a0)+, d7				; d7 = char
	beq.s	@done
	bmi.s	@flag

	@loop:	add.w	d1, d7
		move.w	d7, (a1)+				; send tile
		moveq	#0, d7
	@next:	move.b	(a0)+, d7				; d7 = char
		bgt.s	@loop					; if d7 = 00..7F, branch
		bmi.s	@flag

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

@flag:	sub.b	#pal0, d7				; pal0?
	beq.s	@pal0
	subq.b	#pal1-pal0, d7				; pal1?
	bne.s	@next
@pal1:	or.w	#$2000, d1
	bra.s	@next

@pal0:	andi.w	#~$2000, d1
	bra.s	@next

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
	bmi.w	@PlayCurrentSlot		; start pressed? confirm slot selection

	cmpi.b	#B, d0				; exactly B pressed?
	beq.s	@chksingle			; if yes, branch
	cmpi.b	#C, d0				; exactly C pressed?
	bne.s	@notbc				; if not, branch
@chksingle:
	cmp.b	Joypad|Held, d0			; exactly C held?
	beq.w	@PlayCurrentSlot		; if yes, also confirm slot selection
@notbc:

	; handle delete on ABC
	moveq	#A|B|C, d1
	and.b	d0, d1
	beq.s	@nodel
	moveq	#$FFFFFFA9, d0
	jsr	PlaySFX
	cmpi.b	#A|B|C, Joypad|Held		; exactly A+B+C held?
	bne.s	@ret				; if not, branch
	tst.b	d7				; is No Save selected?
	beq.s	@DeleteEverything		; if yes, delete everything
	bra.s	@DeleteSelectedSlot		; if yes, delete selected slot
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
	jsr	SaveSelect_DrawBottomHint
	moveq	#$FFFFFFD8, d0
	jmp	PlaySFX

; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
@DeleteEverything:
	ints_disable
	move.b	#90,SaveSelect_ExitFlag	; set fade-out sequence time to 90 frames

@delete_fadeoutloop:
	subq.b	#1,SaveSelect_ExitFlag	; subtract 1 from remaining time
	bmi.s	@delete_fadeoutend	; is time over? end fade-out sequence
	
	jsr	RandomNumber		; get new random number
	lea	($FFFFCC00).w,a1	; load scroll buffer address
	move.w	#223,d2			; do it for all 224 lines
@0	jsr	CalcSine		; further randomize the offset after every line
	move.l	d1,(a1)+		; dump to scroll buffer
	dbf	d2,@0			; repeat
	
	moveq	#7,d0			; only trigger every 7th frame
	and.b	SaveSelect_ExitFlag,d0	; get remaining time
	bne.s	@1			; is it not a 7th frame?, branch
	jsr	Pal_FadeOut		; partially fade-out palette
	move.b	#$C4,d0			; play explosion sound
	jsr	PlaySFX	; ''

@1	move.b	#2,VBlankRoutine	; run V-Blank
	jsr	DelayProgram		; ''
	bra.s	@delete_fadeoutloop	; loop

@delete_fadeoutend:
	jsr	SRAMCache_ResetEverythingToDefaults ; delete the actual SRAM now
	addq.l	#4,sp			; skip return address
	jmp	Start_FirstGameMode	; restart game


; ---------------------------------------------------------------------------
@PlayCurrentSlot:
	st.b	SaveSelect_ExitFlag
	jsr	WhiteFlash
	moveq	#$FFFFFFC3, d0
	jmp	PlaySFX

; ---------------------------------------------------------------------------
SaveSelect_UI_Tiles_KospM:
	incbin	"Screens/SaveSelectScreen/Data/ScreenUI_Tiles.kospm"
	even

SaveSelect_UI_MapEni:
	incbin	"Screens/SaveSelectScreen/Data/ScreenUI_Map.eni"
	even

; ---------------------------------------------------------------------------
SaveSelect_BG_B_Tiles_KospM:
	incbin	"Screens/SaveSelectScreen/Data/BG_B_Tiles.kospm"
	even

SaveSelect_BG_B_MapEni:
	incbin	"Screens/SaveSelectScreen/Data/BG_B_Map.eni"
	even

; ---------------------------------------------------------------------------
SaveSelect_BG_C_Tiles_Kosp:
	incbin	"Screens/SaveSelectScreen/Data/BG_C_Tiles.kosp"
	even
