
	include 'Modules/SRAM.defs.asm'

; ===========================================================================
; ---------------------------------------------------------------------------
; Load SRAM
; ---------------------------------------------------------------------------

SRAM_Load:
	_KDebug.WriteLine "SRAM_Load()..."
	clr.b	SaveSlotId		; use default save slot id (unless SRAM is alive and overrides it)

	if def(__MD_REPLAY__)
		rts
	else
		SRAMEnter
		lea	SRAM_Start, a1
		movep.l	SRAM_Magic(a1), d0
		cmp.l	#_SRAM_ExpectedMagic, d0
		bne	@ResetSRAM_and_LoadDefaults

		_KDebug.WriteLine "SRAM_Load(): Loading global data..."

		; Load global options
		move.b	SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1), OptionsBits
		move.b	SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1), OptionsBits2
		moveq	#%11,d0
		and.b	SRAM_GlobalOptions+SRAMOptions.ScreenFuzz(a1), d0
		move.b	d0, ScreenFuzz
		moveq	#%10, d0
		and.b	SRAM_GlobalOptions+SRAMOptions.BlackBars(a1), d0
		move.b	d0, BlackBars.HandlerId

		; Load global progress
		move.b	SRAM_GlobalProgress(a1), Progress	; ### TODO: Correct this

		; Load selected save slot
		moveq	#3, d0
		and.b	SRAM_SelectedSlotId(a1), d0
		_KDebug.WriteLine "SRAM_Load(): Loading slot data (slot=%<.b d0 dec>)..."
		move.b	d0, SaveSlotId
		beq.s	@LoadNoSaveData
		mulu.w	#SRAMSlot.Size, d0
		lea	SRAM_Slots-SRAMSlot.Size(a1, d0), a1

		;movep.w	SRAMSlot.GameBits(a1), d0	; ### TODO
		move.b	SRAMSlot.Chapter(a1), CurrentChapter
		movep.w	SRAMSlot.Rings(a1), d0
		move.w	d0, Rings
		movep.w	SRAMSlot.Deaths(a1), d0
		move.w	d0, Deaths
		movep.l	SRAMSlot.Score(a1), d0
		move.l	d0, Score
		movep.w	SRAMSlot.Doors(a1), d0
		move.w	d0, Doors_Casual			; ### TODO
		bra.s	@LoadDone

	@LoadNoSaveData:
		moveq	#0, d0
		move.b	d0, SaveSlotId
		; ### TODO: SRAMSlot.GameBits ###
		move.b	d0, CurrentChapter
		move.w	d0, Doors_Casual			; ### TODO
		move.w	d0, Deaths
		move.w	d0, Rings
		move.l	d0, Score

	@LoadDone:
		SRAMLeave
		rts

	; ---------------------------------------------------------------------------
	@ResetSRAM_and_LoadDefaults:
		_KDebug.WriteLine "SRAM_Load(): Resetting and loading defaults..."

		_assert.l a1, eq, #SRAM_Start

		move.l	#_SRAM_ExpectedMagic, d0
		movep.l	d0, SRAM_Magic(a1)

		; Reset and save global options
		jsr	Options_SetDefaults		; resets OptionBits, OptionBits2, ScreenFuzz
		; WARNING! Doesn't reset Black Bars config!
		move.b	OptionsBits, SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1)
		move.b	OptionsBits2, SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1)
		move.b	ScreenFuzz, SRAM_GlobalOptions+SRAMOptions.ScreenFuzz(a1)
		move.b	BlackBars.HandlerId, SRAM_GlobalOptions+SRAMOptions.BlackBars(a1)

		; Reset and save global progress
		moveq	#0, d0
		move.b	d0, Progress			; ### TODO: Correct this
		move.b	Progress, SRAM_GlobalProgress(a1)

		; Reset and save current slot id
		move.b	d0, SaveSlotId
		move.b	d0, SRAM_SelectedSlotId(a1)

		; Clear slots
		lea	SRAM_Slots(a1), a1
		_assert.l d0, eq
		rept SRAMSlot.Size*3/8
			movep.l	d0, 0(a1)
			addq.l	#8, a1
		endr
		rept (SRAMSlot.Size*3/2) & 3
			move.b	d0, (a1)
			addq.l	#2, a1
		endr
		_assert.l a1, eq, #SRAM_Start+SRAM_Size

		bra	@LoadNoSaveData
	endif


; ===========================================================================
; ---------------------------------------------------------------------------
; Save SRAM
; ---------------------------------------------------------------------------

SRAM_SaveNow:
	KDebug.WriteLine "SRAM_SaveNow()..."
	; Supress SRAM if MD Replay takes over it
	if def(__MD_REPLAY__)
		rts
	else
		SRAMEnter
		lea	SRAM_Start, a1

		; Don't save is SRAM is not supported
		movep.l	SRAM_Magic(a1), d0
		cmp.l	#_SRAM_ExpectedMagic, d0
		bne	@SaveDone

		move.b	OptionsBits, SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1)
		move.b	OptionsBits2, SRAM_GlobalOptions+SRAMOptions.OptionsBits1(a1)
		move.b	ScreenFuzz, SRAM_GlobalOptions+SRAMOptions.ScreenFuzz(a1)
		move.b	BlackBars.HandlerId, SRAM_GlobalOptions+SRAMOptions.BlackBars(a1)

		move.b	Progress, SRAM_GlobalProgress(a1)

		moveq	#3, d0
		and.b	SaveSlotId, d0
		move.b	d0, SRAM_SelectedSlotId(a1)
		beq.s	@SaveDone

		; Save slot data
		KDebug.WriteLine "SRAM_SaveNow(): Saving slot data (slot=%<.b d0 dec>)"
		mulu.w	#SRAMSlot.Size, d0
		lea	SRAM_Slots-SRAMSlot.Size(a1, d0), a1

		; SRAMSlot.GameBits(a1)	; ### TODO
		move.b	CurrentChapter, SRAMSlot.Chapter(a1)
		move.w	Rings, d0
		movep.w	d0, SRAMSlot.Rings(a1)
		move.w	Deaths, d0
		movep.w	d0, SRAMSlot.Deaths(a1)
		move.l	Score, d0
		movep.l	d0, SRAMSlot.Score(a1)
		move.w	Doors_Casual, d0
		movep.w	d0, SRAMSlot.Doors(a1)

	@SaveDone:
		SRAMLeave
		rts
	endif


sram_optionsmenu_resetgameprogress: _unimplemented
sram_optionsmenu_resetoptions: _unimplemented
