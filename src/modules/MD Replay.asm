
; ==============================================================================
; ------------------------------------------------------------------------------
; Macro to initialize MD Replay
; ------------------------------------------------------------------------------

MDReplay_Init:	macro
	if __MD_REPLAY__='rec'
		move.b	#1, $A130F1
		move.l	#'MDR1', $200000		; write down the header
		move.l	#$200004-2, MDReplay_RecPtr	; point to "R1" as broken record, so it's insta-incremented
		move.b	#0, $A130F1

	elseif __MD_REPLAY__='play'
		cmpi.l	#'MDR1', MDReplayMovie
		beq.s	@header_ok
		RaiseError "Invalid MD Replay movie header"
	@header_ok:
		move.l	#MDReplayMovie+4, MDReplay_PlayPtr	; load pointer to the first block
		move.b	MDReplayMovie+4+1, MDReplay_RLECount	; initialize RLE counter
		addq.b	#1, MDReplay_RLECount
	endif
	endm

; ==============================================================================
; ------------------------------------------------------------------------------
; Macro to perform "write" operation
; ------------------------------------------------------------------------------
; INPUT:
;	d0	.b	Joypad bitfield byte
; ------------------------------------------------------------------------------

MDReplay_Write: macro
		move.l	MDReplay_RecPtr, a1
		cmp.b	(a1), d0				; can we RLE-encode the same byte?
		beq.s	@rle_encode				; if yes, branch
		addq.l	#2, a1
		bra.s	@rle_newblock

	@rle_encode:
		addq.b	#1, 1(a1)				; RLE-encode
		bcc.s	@rle_done				; if length < 256, branch
		subq.b	#1, 1(a1)
		addq.l	#2, a1

	@rle_newblock:
		move.b	d0, (a1)
		move.b	#1, 1(a1)
		move.l	a1, MDReplay_RecPtr

	@rle_done:
	endm

; ==============================================================================
; ------------------------------------------------------------------------------
; Macro to perform "write" operation
; ------------------------------------------------------------------------------
; OUTPUT:
;	d0	.b	Joypad bitfield byte
; ------------------------------------------------------------------------------

MDReplay_Read:	macro	use_le
		move.l	MDReplay_PlayPtr, a1
		subq.b	#1, MDReplay_RLECount
		bne.s	@rle_ok
		addq.w	#2, a1
		move.l	a1, MDReplay_PlayPtr
		move.b	1(a1), MDReplay_RLECount

	@rle_ok:
		move.b	(a1), d0
	@movie_done:
	endm

; ==============================================================================
; ------------------------------------------------------------------------------
; Macro to update MD Replay
; ------------------------------------------------------------------------------

MDReplay_Update: macro
	if __MD_REPLAY__='rec'
		lea 	$FFFFF604, a0	 	; address where joypad states are written
		lea 	($A10003).l, a1		; first joypad port

		move.b	#0,(a1)
		nop 	
		nop 	
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		nop
		nop
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0

		move.b	#1, $A130F1
		MDReplay_Write			; <= d0 = value
		move.b	#0, $A130F1

		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+
		rts

	elseif __MD_REPLAY__='play'
		lea 	$FFFFF604, a0 		; address where joypad states are written

		MDReplay_Read			; => d0 = value

		move.b	(a0), d1
		eor.b	d0, d1
		move.b	d0, (a0)+
		and.b	d0, d1
		move.b	d1, (a0)+
		rts
	else
		RaiseError "Illegal __MD_REPLAY__ value"
	endif

	endm

; ==============================================================================
; ------------------------------------------------------------------------------
; Macro to include MD Play movie (playback mode only)
; ------------------------------------------------------------------------------

MDReplay_IncludeMovie: macro path
	if def(__MD_REPLAY__)
	if __MD_REPLAY__='play'
		MDReplayMovie:
			incbin	\path
		MDReplayMovie_End:
	endif
	endif
	endm

; ==============================================================================
