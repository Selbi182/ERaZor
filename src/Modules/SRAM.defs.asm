
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
; SRAM Save Slot structure
; --------------------------

			rsreset
SRAMSlot.GameBits:	rsp.b	1	; Slot State (Created/Not), Difficulty (Casual, Frantic), Mode (Arcade / Story), Beaten (Base Game / Blackout)
SRAMSlot.Chapter:	rsp.w	1	; Chapter
SRAMSlot.Rings:		rsp.w	1	; Ringage
SRAMSlot.Deaths:	rsp.w	1	; Deaths
SRAMSlot.Score:		rsp.l	1	; Game score
SRAMSlot.Doors:		rsp.w	1	; Open doors bitfield

SRAMSlot.Size:		equ	__rs


; ---------------------------
; SRAM Options structure
; ---------------------------
			rsreset
SRAMOptions.OptionsBits1:rsp.b	1	; => (OptionsBits).w
SRAMOptions.OptionsBits2:rsp.b	1	; => (OptionsBits2).w
SRAMOptions.ScreenFuzz: rsp.b	1	; => (ScreenFuzz).w
SRAMOptions.BlackBars:	rsp.b	1	; => (BlackBars.HandlerId).w
SRAMOptions.Size	equ	__rs

; --------------------------
; SRAM layout
; --------------------------

			rsreset
SRAM_Magic:		rsp.l	1			; SRAM magic string (if not set, SRAM is re-initialized)
SRAM_GlobalOptions:	rs.b	SRAMOptions.Size	; Global game option bitfield
SRAM_GlobalProgress:	rsp.b	1			; Game beaten (Causal / Frantic / Blackout)
SRAM_SelectedSlotId:	rsp.b	1			; Selected slot (0 = No Save, 1..3 = Slots 1..3)
SRAM_Slots:		rs.b	SRAMSlot.Size*3		; 3 slots

SRAM_Size:		equ	__rs

_SRAM_ExpectedMagic:	equ	'Ver0'
