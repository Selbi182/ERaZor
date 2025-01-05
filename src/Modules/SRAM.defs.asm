
SRAM_Start:	equ	$200001

; --------------------------
; Macros
; --------------------------

; Special "RS" version for MOVEP
rsp:	macro	*,cnt
\*:	rs.\0	cnt*2	; skip every other byte
	endm

; Enter/leave SRAM
SRAMEnter	macro
	move.b	#1, $A130F1
	endm

SRAMLeave:	macro
	move.b	#0, $A130F1
	endm

; --------------------------
; Save Slot structure
; --------------------------

			rsreset
SaveSlot.Progress:	rs.b	1	; Slot State (Created/Not), Difficulty (Casual, Frantic), Mode (Arcade / Story), Beaten (Base Game / Blackout), Tutorial Visted, Hub easter egg visited
SaveSlot.Chapter:	rs.b	1	; Chapter
SaveSlot.Rings:		rs.w	1	; Ringage
SaveSlot.Deaths:	rs.w	1	; Deaths
SaveSlot.Score:		rs.l	1	; Game score
SaveSlot.Doors:		rs.w	1	; Open doors bitfield
SaveSlot.Size:		equ	__rs

	if SaveSlot.Size&1
		inform 2, "SaveSlot.Size must be even (got \#SaveSlot.Size)"
	endif

; ---------------------------
; Save Options structure
; ---------------------------
				rsreset
SaveOptions.OptionsBits1:	rs.b	1	; => (OptionsBits).w
SaveOptions.OptionsBits2:	rs.b	1	; => (OptionsBits2).w
SaveOptions.ScreenFuzz: 	rs.b	1	; => (ScreenFuzz).w
SaveOptions.BlackBars:		rs.b	1	; => (BlackBars.HandlerId).w
SaveOptions.Size:		equ	__rs

	if SaveOptions.Size&1
		inform 2, "SaveSlot.Size must be even (got \#SaveSlot.Size)"
	endif

; --------------------------
; SRAM Cache layout
; --------------------------

				rsset	SRAMCache_RAM
SRAMCache.GlobalOptions:	rs.b	SaveOptions.Size	; Global game option bitfield
SRAMCache.GlobalProgress:	rs.b	1			; Game beaten (Causal / Frantic / Blackout)
SRAMCache.SelectedSlotId:	rs.b	1			; Selected slot (0 = No Save, 1..3 = Slots 1..3)
SRAMCache.Slots:		rs.b	SaveSlot.Size*3		; 3 slots
SRAMCache.Size:			equ	__rs-SRAMCache_RAM

	if SRAMCache.Size&1
		inform 2, "SRAMCache.Size must be even (got \#SaveSlot.Size)"
	endif
	if SRAMCache_RAM+SRAMCache.Size > SRAMCache_RAM_End
		inform 2, "SRAMCache structure is too big"
	endif

; --------------
; SRAM layout
; --------------

				rsreset
SRAM_Magic:			rsp.l	1			; SRAM magic string (if not set, SRAM is re-initialized)
SRAM_Data:			rsp.b	SRAMCache.Size		; copied to `SRAMCache_RAM`

_SRAM_ExpectedMagic:		equ	'Ver0'
