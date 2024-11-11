
; ===========================================================================
; ---------------------------------------------------------------------------
; SRAM Loading Routine
; ---------------------------------------------------------------------------
; Format (note, SRAM can only be written to odd addresses):
; 00 o1 00 o2  00 ch 00 d1  00 d2 00 l1  00 l2 00 r1  00 r2 00 s1  00 s2 00 s3  00 s4 00 cm  00 rs 00 bb  00 mb 00 mg
;    01    03     05    07     09    0B     0D    0F     11    13     15    17     19    1B     1D    1F     21    23
;
;  o1 = Options Bitset ($FFFFFF92)
;  o2 = Options Bitset 2 ($FFFFFF94)
;  ch = Current Chapter ($FFFFFFA7)
;  d_ = Open Doors Bitset - Casual/Frantic  ($FFFFFF8A-FFFFFF8B)
;  l_ = Lives (or Deaths rather, lol) ($FFFFFE12-FFFFFE13)
;  r_ = Rings ($FFFFFE20-FFFFFE21)
;  s_ = Score ($FFFFFE26-FFFFFE29)
;  cm = Complete (Base Game / Blackout challenge) ($FFFFFF93)
;  rs = Resume Flag (0 first launch / 1 load save game) ($FFFFF601)
;  mb = Motion Blur (bit 0 of $FFFFFF91)
;  bb = Black Bars Config (0 emu mode / 2 hardware mode) ($FFFFF5D2)
;  mg = Magic Number (always set to 182, absence implies no SRAM)
; ---------------------------------------------------------------------------
SRAM_Options	= 1
SRAM_Options2	= 2 + SRAM_Options
SRAM_Chapter	= 2 + SRAM_Options2
SRAM_Doors	= 2 + SRAM_Chapter ; 2 bytes
SRAM_Lives	= 4 + SRAM_Doors ; 2 bytes
SRAM_Rings	= 4 + SRAM_Lives ; 2 bytes
SRAM_Score	= 4 + SRAM_Rings ; 4 bytes
SRAM_Complete	= 8 + SRAM_Score
SRAM_Resume	= 2 + SRAM_Complete
SRAM_ScreenFuzz	= 2 + SRAM_Resume
SRAM_BlackBars	= 2 + SRAM_ScreenFuzz

SRAM_Exists	= 2 + SRAM_BlackBars
SRAM_MagicNumber = 182
; ---------------------------------------------------------------------------

SRAM_Load:
	KDebug.WriteLine "SRAM_Load()..."
	; Supress SRAM if MD Replay takes over it
	if def(__MD_REPLAY__)
		rts
	else
		moveq	#0,d0					; clear d0
		move.b	#1,($A130F1).l				; enable SRAM
		lea	($200000).l,a1				; base of SRAM
		cmpi.b	#SRAM_MagicNumber,SRAM_Exists(a1)	; does SRAM exist?
		beq.s	SRAMFound				; if yes, branch
		
		bsr.s	SRAM_Reset				; reset any existing SRAM
		bra.w	SRAMEnd

SRAMFound:
		lea	($200000).l,a1				; base of SRAM

		move.b	SRAM_Options(a1),(OptionsBits).w	; load options flags
		move.b	SRAM_Options2(a1),(OptionsBits2).w	; load options 2 flags

		move.b	SRAM_Chapter(a1),($FFFFFFA7).w		; load current chapter

		movep.w	SRAM_Doors(a1),d0			; load...
		move.w	d0,(Doors_Casual).w			; ...open doors bitsets (casual and frantic)

		movep.w	SRAM_Lives(a1),d0			; load...
		move.w	d0,($FFFFFE12).w			; ...lives/deaths counter

		movep.w	SRAM_Rings(a1),d0			; load...
		move.w	d0,($FFFFFE20).w			; ...rings

		movep.l	SRAM_Score(a1),d0			; load...
		move.l	d0,($FFFFFE26).w			; ...score

		move.b	SRAM_Complete(a1),($FFFFFF93).w		; load game beaten state

		move.b	SRAM_Resume(a1),(ResumeFlag).w		; load resume flag

		move.b	SRAM_ScreenFuzz(a1),d0			; load motion blur flag
		andi.b	#%11,d0					; mask it against the only bits we need
		move.b	d0,(ScreenFuzz).w			; set motion blur flag

		move.b	SRAM_BlackBars(a1),d0			; load black bars handler ID
		andi.b	#%10,d0					; mask it against the only bit we need
		move.b	d0,(BlackBars.HandlerId).w		; set handler ID

SRAMEnd:
		move.b	#0,($A130F1).l				; disable SRAM
		rts
	endif	; def(__MD_REPLAY__)=0
; ===========================================================================

SRAM_Reset:
	KDebug.WriteLine "SRAM_Reset()..."
	if def(__MD_REPLAY__)
		rts
	else
		; Fun fact: Did you know Kega initializes SRAM to $FF instead of $00?
		; Thank me later, I just saved you hours.
		moveq	#0,d0					; set d0 to 0
		move.b	d0,SRAM_Options(a1)			; clear option flags
		move.b	d0,SRAM_Options2(a1)			; clear option 2 flags
		move.b	d0,SRAM_Chapter(a1)			; clear current chapter
		movep.w	d0,SRAM_Doors(a1)			; clear open doors bitset
		movep.w	d0,SRAM_Lives(a1)			; clear lives/deaths
		movep.w	d0,SRAM_Rings(a1)			; clear rings
		movep.l	d0,SRAM_Score(a1)			; clear score
		move.b	d0,SRAM_Complete(a1)			; clear option flags
		move.b	d0,SRAM_Resume(a1)			; clear resume flag
		move.b	d0,SRAM_ScreenFuzz(a1)			; clear motion blur flag
		move.b	d0,SRAM_BlackBars(a1)			; clear black bars flag
	
		jsr	Options_SetDefaults			; reset default options
		move.b	(OptionsBits).w,SRAM_Options(a1)	; ^
		move.b	(OptionsBits2).w,SRAM_Options2(a1)	; ^

		move.b	#SRAM_MagicNumber,SRAM_Exists(a1) 	; set magic number ("SRAM exists")
	endif	; def(__MD_REPLAY__)=0
		
ResetGameProgress:
	KDebug.WriteLine "ResetGameProgress()..."
	moveq	#0,d0
	move.b	d0,($FFFFFFA7).w			; clear current chapter
	move.w	d0,(Doors_Casual).w			; clear open doors bitsets
	move.w	d0,($FFFFFE12).w			; clear lives/deaths counter
	move.w	d0,($FFFFFE20).w			; clear rings
	move.l	d0,($FFFFFE26).w			; clear score
	move.b	d0,($FFFFFF93).w			; clear game beaten state
	rts

; ===========================================================================

SRAM_SaveNow:
	KDebug.WriteLine "SRAM_SaveNow()..."
	; Supress SRAM if MD Replay takes over it
	if def(__MD_REPLAY__)
		rts
	else
		move.b	#1,($A130F1).l				; enable SRAM
		lea	($200000).l,a1				; base of SRAM
		cmpi.b	#SRAM_MagicNumber,SRAM_Exists(a1)	; does SRAM exist?
		bne.s	SRAM_SaveNow_End			; if not, branch
		
		move.l	d0,-(sp)				; backup d0
		moveq	#0,d0					; clear d0
		move.b	(OptionsBits).w,d0			; move option flags to d0
		move.b	d0,SRAM_Options(a1)			; backup option flags
		move.b	(OptionsBits2).w,d0			; move option 2 flags to d0
		move.b	d0,SRAM_Options2(a1)			; backup option 2 flags
		move.b	($FFFFFFA7).w,d0			; move current chapter to d0
		move.b	d0,SRAM_Chapter(a1)			; backup current chapter
		move.w	(Doors_Casual).w,d0			; move open doors bitset to d0
		movep.w	d0,SRAM_Doors(a1)			; backup open doors bitset
		move.w	($FFFFFE12).w,d0			; move lives/deaths to d0
		movep.w	d0,SRAM_Lives(a1)			; backup lives/deaths
		move.w	($FFFFFE20).w,d0			; move rings to d0
		movep.w	d0,SRAM_Rings(a1)			; backup rings
		move.l	($FFFFFE26).w,d0			; move score to d0
		movep.l	d0,SRAM_Score(a1)			; backup score
		move.b	($FFFFFF93).w,d0			; move game beaten state to d0
		move.b	d0,SRAM_Complete(a1)			; backup option flags
		move.b	(ResumeFlag).w,d0			; move resume flag to d0
		move.b	d0,SRAM_Resume(a1)			; backup resume flag
		move.b	(ScreenFuzz).w,d0			; move screen fuzz to d0
		andi.b	#%11,d0					; mask it against the only bits we need
		move.b	d0,SRAM_ScreenFuzz(a1)			; backup motion blur flag
		move.b	BlackBars.HandlerId,d0			; move black bars flag to d0
		andi.b	#%10,d0					; mask it against the only bit we need
		move.b	d0,SRAM_BlackBars(a1)			; backup black bars flag
		move.l	(sp)+,d0				; restore d0

SRAM_SaveNow_End:
		move.b	#0,($A130F1).l				; disable SRAM
		rts
	endif	; def(__MD_REPLAY__)=0