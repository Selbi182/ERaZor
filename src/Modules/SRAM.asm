
	include 'Modules/SRAM.defs.asm'

; ===========================================================================
; ---------------------------------------------------------------------------
; Initializes SRAM cache
; ---------------------------------------------------------------------------

SRAMCache_Init:
	_KDebug.WriteLine "SRAMCache_Init()..."

	if def(__MD_REPLAY__)
		rts
	else
		@sram:	equr	a1
		@var0:	equr	d0

		lea	SRAM_Start, @sram

		SRAMEnter
		movep.l	SRAM_Magic(@sram), @var0
		cmp.l	#_SRAM_ExpectedMagic, @var0
		bne	@LeaveSRAM_and_LoadDefaults

		_KDebug.WriteLine "SRAMCache_Init(): Copying data to SRAM cache..."

		@cache:	equr	a2

		lea	SRAMCache_RAM, @cache
		@offset: = 0
		rept SRAMCache.Size / 4
			movep.l	SRAM_Data+@offset(@sram), @var0
			move.l	@var0, (@cache)+
			@offset: = @offset + 4*2	; next LONG in SRAM
		endr
		rept SRAMCache.Size & 3 ; copy any leftover bytes that didn't fit longwords
			move.b	SRAM_Data+@offset(@sram), (@cache)+
			@offset: = @offset + 1*2	; next BYTE in SRAM
		endr
		SRAMLeave

		; Load globals
		move.b	SRAMCache.GlobalOptions + SaveOptions.OptionsBits1, OptionsBits
		move.b	SRAMCache.GlobalOptions + SaveOptions.OptionsBits2, OptionsBits2
		move.b	SRAMCache.GlobalOptions + SaveOptions.ScreenFuzz, ScreenFuzz
		move.b	SRAMCache.GlobalOptions + SaveOptions.BlackBars, BlackBars.HandlerId
		move.b	SRAMCache.GlobalProgress, GlobalProgress
		
		; Load last slot data (should be redundant, but satisfies sanity checks)
		bra	SRAMCache_LoadSelectedSlotId

	; ---------------------------------------------------------------------------
	@LeaveSRAM_and_LoadDefaults:
		SRAMLeave
	endif	; def(__MD_REPLAY__)

	@LoadDefaults:
		_KDebug.WriteLine "SRAMCache_Init(): Loading defaults..."

		_assert.l @sram, eq, #SRAM_Start
		_assert.w @cache, eq, #SRAMCache_RAM

		; Reset and save global options
		jsr	Options_SetDefaults	; resets OptionBits, OptionBits2, ScreenFuzz
						; WARNING! Doesn't reset Black Bars config!
		move.b	OptionsBits, 		SRAMCache.GlobalOptions + SaveOptions.OptionsBits1
		move.b	OptionsBits2, 		SRAMCache.GlobalOptions + SaveOptions.OptionsBits2
		move.b	ScreenFuzz, 		SRAMCache.GlobalOptions + SaveOptions.ScreenFuzz
		move.b	BlackBars.HandlerId, 	SRAMCache.GlobalOptions + SaveOptions.BlackBars

		; Reset and save global progress
		moveq	#0, @var0
		move.b	@var0, GlobalProgress			; ### TODO: Correct this
		move.b	GlobalProgress, SRAMCache.GlobalProgress

		; Reset and save current slot id
		move.b	@var0, SRAMCache.SelectedSlotId

		; Clear slots
		@slots:	equr	a2		; WARNING! Don't change (optimized for `SRAMCache_ClearSlot`)

		lea	SRAMCache.Slots, @slots
		rept 3
			bsr	SRAMCache_ClearSlot
		endr
		_assert.w @slots, eq, #SRAMCache_RAM+SRAMCache.Size
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Resets everything to defaults
; ---------------------------------------------------------------------------

SRAMCache_ResetEverythingToDefaults:	equ	@LoadDefaults

; ===========================================================================
; ---------------------------------------------------------------------------
; Commits SRAM cache contents to SRAM
; ---------------------------------------------------------------------------

SRAMCache_Commit:
	KDebug.WriteLine "SRAMCache_Commit()..."
	; Supress SRAM if MD Replay takes over it
	if def(__MD_REPLAY__)
		rts
	else
		@sram:	equr	a1
		@cache:	equr	a2
		@var0:	equr	d0

		lea	SRAM_Start, @sram
		lea	SRAMCache_RAM, @cache

		SRAMEnter
		moveq	#-1, @var0
		movep.l	@var0, SRAM_Magic(@sram)	; invalidate SRAM magic until transation is complete
							; avoids corruption if console is turned off in the middle of copying
		@offset: = 0
		rept SRAMCache.Size / 4
			move.l	(@cache)+, @var0
			movep.l	@var0, SRAM_Data+@offset(@sram)
			@offset: = @offset + 4*2	; next LONG in SRAM
		endr
		rept SRAMCache.Size & 3 ; commit any leftover bytes that didn't fit longwords
			move.b	(@cache)+, SRAM_Data+@offset(@sram)
			@offset: = @offset + 1*2	; next BYTE in SRAM
		endr

		move.l	#_SRAM_ExpectedMagic, @var0
		movep.l	@var0, SRAM_Magic(@sram)	; mark SRAM magic valid
		SRAMLeave
		rts
	endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Gets pointer to currently selected Save slot data
; ---------------------------------------------------------------------------
; OUTPUT:
;	a2	= Pointer to Save Slot structure
;	ccr	= Z=1 if "No Save" slot is selected
; ---------------------------------------------------------------------------

SRAMCache_GetSelectedSlotData:
	move.b	SRAMCache.SelectedSlotId, d0

SRAMCache_GetSlotData:	; INPUT: d0.b - Slot
	_assert.b d0, ls, #3

	and.w	#3, d0
	beq.s	@ret
	subq.w	#1, d0
	mulu.w	#SaveSlot.Size, d0
	add.w	#SRAMCache.Slots, d0
	movea.w	d0, a2
@ret:	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Sets currently selected slot id
; ---------------------------------------------------------------------------
; INPUT:
;	d0	.b 	- Slot Id
; ---------------------------------------------------------------------------

SRAMCache_SetSelectedSlotId:
	_assert.b d0, ls, #3

	move.b	d0, SRAMCache.SelectedSlotId
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Clears currently selected slot id
; ---------------------------------------------------------------------------

SRAMCache_ClearSelectedSlotId:
	bsr	SRAMCache_GetSelectedSlotData	; a2 = Slot data, Z = is "No Save" slot
	beq	SRAMCache_Clear_NoSlot		; skip if slot is "No Save"

SRAMCache_ClearSlot:	; INPUT: a2 = Slot data
	assert.w a2, hs, #SRAMCache.Slots
	assert.w a2, ls, #SRAMCache.Slots + SRAMCache.Size*(3-1)

	moveq	#0, d0
	rept SaveSlot.Size / 4
		move.l	d0, (a2)+
	endr
	rept SaveSlot.Size & 3
		move.b	d0, (a2)+
	endr

SRAMCache_Clear_NoSlot:
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Loads currently selected slot id
; ---------------------------------------------------------------------------

SRAMCache_LoadSelectedSlotId:
	bsr	SRAMCache_GetSelectedSlotData	; a2 = Slot data, Z = is "No Save" slot
	beq	SRAMCache_Load_NoSaveSlot	; skip if slot is "No Save"

SRAMCache_LoadSlot:	; INPUT: a2 = Slot data
	KDebug.WriteLine "SRAMCache_LoadSlot(): Loading data... (data=%<.l a2>)"

	assert.w a2, hs, #SRAMCache.Slots
	assert.w a2, ls, #SRAMCache.Slots + SRAMCache.Size*(3-1)

	move.b	SaveSlot.Progress(a2), SlotProgress
	move.b	SaveSlot.Chapter(a2), CurrentChapter
	move.w	SaveSlot.Rings(a2), Rings
	move.w	SaveSlot.Deaths(a2), Deaths
	move.l	SaveSlot.Score(a2), Score
	move.w	SaveSlot.Doors(a2), Doors_Casual	; FIXME
	KDebug.WriteLine "SRAMCache_LoadSlot(): Loaded data (progress=%<.b SaveSlot.Progress(a2)>, chapter=%<.b SaveSlot.Chapter(a2)>, doors=%<.w SaveSlot.Doors(a2)>...)"
	rts

SRAMCache_Load_NoSaveSlot:
	KDebug.WriteLine "SRAMCache_LoadSlot(): Loading 'no save' data..."
	move.b	#0, SlotProgress		; FIXME: Slot created bit?
	move.b	#0, CurrentChapter
	move.w	#0, Rings
	move.w	#0, Deaths
	move.l	#0, Score
	move.w	#0, Doors_Casual	; FIXME
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Saves currently selected slot id
; ---------------------------------------------------------------------------

SRAMCache_SaveSelectedSlotId:
	bsr	SRAMCache_GetSelectedSlotData	; a2 = Slot data, Z = is "No Save" slot
	beq	SRAMCache_Save_NoSaveSlot	; skip if slot is "No Save"

SRAMCache_SaveSlot:	; INPUT: a2 = Slot data
	KDebug.WriteLine "SRAMCache_SaveSlot(): Saving data... (data=%<.l a2>)"

	assert.w a2, hs, #SRAMCache.Slots
	assert.w a2, ls, #SRAMCache.Slots + SRAMCache.Size*(3-1)

	move.b	SlotProgress, SaveSlot.Progress(a2)
	move.b	CurrentChapter, SaveSlot.Chapter(a2)
	move.w	Rings, SaveSlot.Rings(a2)
	move.w	Deaths, SaveSlot.Deaths(a2)
	move.l	Score, SaveSlot.Score(a2)
	move.w	Doors_Casual, SaveSlot.Doors(a2)	; FIXME

	KDebug.WriteLine "SRAMCache_SaveSlot(): Saved data (progress=%<.b SaveSlot.Progress(a2)>, chapter=%<.b SaveSlot.Chapter(a2)>, doors=%<.w SaveSlot.Doors(a2)>...)"
	jmp	SRAMCache_Commit	; commit to SRAM

SRAMCache_Save_NoSaveSlot:
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Saves global options
; ---------------------------------------------------------------------------

SRAMCache_SaveGlobalsAndSelectedSlotId:
	pea	SRAMCache_SaveSelectedSlotId(pc)	; also commits to SRAM
	bra.s	SRAMCache_SaveGlobals2

SRAMCache_SaveGlobals:
	pea	SRAMCache_Commit(pc)	; commit to SRAM once we're done

SRAMCache_SaveGlobals2:
	move.b	OptionsBits,		SRAMCache.GlobalOptions+SaveOptions.OptionsBits1
	move.b	OptionsBits2,		SRAMCache.GlobalOptions+SaveOptions.OptionsBits2
	move.b	ScreenFuzz, 		SRAMCache.GlobalOptions+SaveOptions.ScreenFuzz
	move.b	BlackBars.HandlerId,	SRAMCache.GlobalOptions+SaveOptions.BlackBars
	move.b	GlobalProgress,		SRAMCache.GlobalProgress
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Save data debugger
; ---------------------------------------------------------------------------

SRAMCache_Debugger:
	_Console.WriteLine "%<pal1>GLOBALS:%<pal0>"
	_Console.WriteLine "optionsBits1=%<pal2>%<.b SRAMCache.GlobalOptions+SaveOptions.OptionsBits1 bin>%<pal0>"
	_Console.WriteLine "optionsBits2=%<pal2>%<.b SRAMCache.GlobalOptions+SaveOptions.OptionsBits2 bin>%<pal0>"
	_Console.WriteLine "screenFuzz=%<pal2>%<.b SRAMCache.GlobalOptions+SaveOptions.ScreenFuzz>%<pal0>, blackBars=%<pal2>%<.b SRAMCache.GlobalOptions+SaveOptions.BlackBars>%<pal0>"
	_Console.WriteLine "globalProgress=%<pal2>%<.b SRAMCache.GlobalProgress bin>%<pal0>"
	_Console.WriteLine "selectedSlotId=%<pal2>%<.b SRAMCache.SelectedSlotId> %<pal3>(SLOT %<.b SRAMCache.SelectedSlotId dec>)"

	@slot_id: = 1
	@slot_ptr: = SRAMCache.Slots
	rept 3
		_Console.WriteLine "%<pal1,endl>SLOT \#@slot_id\:%<pal0>"
		_Console.WriteLine "progress=%<pal2>%<.b @slot_ptr+SaveSlot.Progress bin>%<pal0>, chapter=%<pal2>%<.b @slot_ptr+SaveSlot.Chapter>%<pal0>"
		_Console.WriteLine "rings=%<pal2>%<.w @slot_ptr+SaveSlot.Rings dec>%<pal0>, deaths=%<pal2>%<.w @slot_ptr+SaveSlot.Deaths dec>%<pal0>, score=%<pal2>%<.l @slot_ptr+SaveSlot.Score dec>%<pal0>"
		_Console.WriteLine "doors=%<pal2>%<.w @slot_ptr+SaveSlot.Doors bin>%<pal0>"

		@slot_id: = @slot_id + 1
		@slot_ptr: = @slot_ptr + SaveSlot.Size
	endr
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; (In)sanity checker
; ---------------------------------------------------------------------------

SRAMCache_SanityCheck:
	@cmpm:	macro src, dest, scratchAReg, scratchDReg, failLoc
		lea	\src, \scratchAReg
		move.\0	\dest, \scratchDReg
		cmp.\0	(\scratchAReg), \scratchDReg
		bne	\failLoc
	endm

	@cmpm.b	OptionsBits,		SRAMCache.GlobalOptions+SaveOptions.OptionsBits1,	a0, d0, @desync_byte
	@cmpm.b	OptionsBits2,		SRAMCache.GlobalOptions+SaveOptions.OptionsBits2,	a0, d0, @desync_byte
	@cmpm.b	ScreenFuzz, 		SRAMCache.GlobalOptions+SaveOptions.ScreenFuzz,		a0, d0, @desync_byte
	@cmpm.b	BlackBars.HandlerId, 	SRAMCache.GlobalOptions+SaveOptions.BlackBars,		a0, d0, @desync_byte

	bsr	SRAMCache_GetSelectedSlotData	; a2 = Slot data, Z = is "No Save" slot
	beq	@ret				; skip if slot is "No Save"

	@cmpm.b	SlotProgress,	SaveSlot.Progress(a2),	a0, d0, @desync_byte
	@cmpm.b	CurrentChapter,	SaveSlot.Chapter(a2),	a0, d0, @desync_byte
	@cmpm.w	Rings,		SaveSlot.Rings(a2),	a0, d0, @desync_word
	@cmpm.w	Deaths,		SaveSlot.Deaths(a2),	a0, d0, @desync_word
	@cmpm.l	Score,		SaveSlot.Score(a2),	a0, d0, @desync_long
	@cmpm.w	Doors_Casual,	SaveSlot.Doors(a2),	a0, d0, @desync_word

@ret	rts

; ---------------------------------------------------------------------------
@desync_byte:
	RaiseError "SRAM cache desync:%<endl>addr=%<.w a0 sym>, cached=%<.b d0>, actual=%<.b (a0)>", SRAMCache_Debugger

@desync_word:
	RaiseError "SRAM cache desync:%<endl>addr=%<.w a0 sym>, cached=%<.w d0>, actual=%<.w (a0)>", SRAMCache_Debugger

@desync_long:
	RaiseError "SRAM cache desync:%<endl>addr=%<.w a0 sym>, cached=%<.l d0>, actual=%<.l (a0)>", SRAMCache_Debugger

