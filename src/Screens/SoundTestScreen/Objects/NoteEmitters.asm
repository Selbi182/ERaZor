
; ---------------------------------------------------------------------------
; Note emitter
; ---------------------------------------------------------------------------

SoundTest_Obj_NoteEmitter:

@noteIndexPrepared:	equ	$34

@Wait:
;	add.b	#$100/16, $30(a0)
;	bcc	@ret
	move.w	#12, $32(a0)
	move.l	#@Emit, $3C(a0)

@Emit:
	move.w	@noteIndexPrepared(a0), d0
	lea	@NoteIndexToWriteRequest(pc), a1
	adda.w	d0, a1
	SoundTest_AddWriteRequest (a1)+, (a1)+, a2

	subq.w	#1, $32(a0)
	bne.s	@ret
	move.l	#@Wait, $3C(a0)

	addq.w	#6, @noteIndexPrepared(a0)
	cmp.w	#7*12*6, @noteIndexPrepared(a0)
	blo.s	@ret
	move.w	#0, @noteIndexPrepared(a0)

@ret:	rts

@NoteIndexToWriteRequest:
	@start_x: = 1

	rept 7 ; octaves
		dc.w	@start_x
		dc.l	@Note_Wide

		dc.w	@start_x+3
		dc.l	@Note_Narrow

		dc.w	@start_x+6
		dc.l	@Note_Wide

		dc.w	@start_x+9
		dc.l	@Note_Narrow

		dc.w	@start_x+12
		dc.l	@Note_Wide

	@start_x: = @start_x + 17

		dc.w	@start_x
		dc.l	@Note_Wide

		dc.w	@start_x+3
		dc.l	@Note_Narrow

		dc.w	@start_x+6
		dc.l	@Note_Wide

		dc.w	@start_x+9
		dc.l	@Note_Narrow

		dc.w	@start_x+12
		dc.l	@Note_Wide

		dc.w	@start_x+15
		dc.l	@Note_Narrow

		dc.w	@start_x+18
		dc.l	@Note_Wide

	@start_x: = @start_x + 23
	endr

; ---------------------------------------------------------------------------
; Pixel data for piano sheet
; ---------------------------------------------------------------------------

@Note_Wide:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$56, $65	; normal pixel data (even nibble start)
	dc.b	$05, $66, $50	; shifted pixel data (odd nibble start)
	even

@Note_Narrow:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$56, $50	; normal pixel data (even nibble start)
	dc.b	$05, $65	; shifted pixel data (odd nibble start)
	even
