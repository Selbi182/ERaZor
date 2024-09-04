
; ---------------------------------------------------------------------------
; Note emitter test
; ---------------------------------------------------------------------------

SoundTest_Obj_NoteEmitterTest:

@noteIndexPrepared:	equ	$34

	@index: = 12
	rept 6+3-1
		SoundTest_CreateChildObject #@Wait
		move.w	#@index, @noteIndexPrepared(a1)

		@index: = @index + 12*3
	endr

	move.l	#@Wait, $3C(a0)

@Wait:
;	add.b	#$100/16, $30(a0)
;	bcc	@ret
	move.w	#12*2, $32(a0)
	move.l	#@Emit, $3C(a0)
	move.b	#0, $1A(a0)

@Emit:
	move.w	@noteIndexPrepared(a0), d0
	lea	@NoteIndexToWriteRequest(pc), a1
	adda.w	d0, a1
	move.w	(a1)+, d0
	SoundTest_AddWriteRequest d0, (a1)+, a2
	move.l	(a1)+, 4(a0)
	move.w	(a1)+, 2(a0)
	add.w	#$80+(320-SoundTest_Visualizer_Width*8)/2, d0
	move.w	d0, 8(a0)
	move.w	#$80+40+SoundTest_Visualizer_Height*8, $A(a0)
	jsr	DisplaySprite

	cmp.w	#12*2-1, $32(a0)
	bne.s	@0
	move.b	#1, $1A(a0)
@0
	subq.w	#1, $32(a0)
	bne.s	@ret
	move.l	#@Wait, $3C(a0)

	add.w	#12, @noteIndexPrepared(a0)
	cmp.w	#7*12*12, @noteIndexPrepared(a0)
	blo.s	@ret
	move.w	#0, @noteIndexPrepared(a0)

@ret:	rts

; ---------------------------------------------------------------------------
@NoteIndexToWriteRequest:

	@base_pat: = (SoundTest_PianoOverlays_VRAM/$20)|$6000|$8000

	@start_x: = 1

	rept 7 ; octaves
		dc.w	@start_x
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+0

		dc.w	@start_x+3
		dc.l	@Note_Narrow
		dc.l	@SpriteTable_Note_Narrow
		dc.w	@base_pat+216/8

		dc.w	@start_x+6
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+72/8

		dc.w	@start_x+9
		dc.l	@Note_Narrow
		dc.l	@SpriteTable_Note_Narrow
		dc.w	@base_pat+216/8

		dc.w	@start_x+12
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+144/8

	@start_x: = @start_x + 17

		dc.w	@start_x
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+0

		dc.w	@start_x+3
		dc.l	@Note_Narrow
		dc.l	@SpriteTable_Note_Narrow
		dc.w	@base_pat+216/8

		dc.w	@start_x+6
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+72/8

		dc.w	@start_x+9
		dc.l	@Note_Narrow
		dc.l	@SpriteTable_Note_Narrow
		dc.w	@base_pat+216/8

		dc.w	@start_x+12
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+72/8

		dc.w	@start_x+15
		dc.l	@Note_Narrow
		dc.l	@SpriteTable_Note_Narrow
		dc.w	@base_pat+216/8

		dc.w	@start_x+18
		dc.l	@Note_Wide
		dc.l	@SpriteTable_Note_Wide
		dc.w	@base_pat+144/8

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

; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------

@SpriteTable_Note_Wide:
	dc.w	@Note_Wide_Highlight-@SpriteTable_Note_Wide
	dc.w	@Note_Wide_FM-@SpriteTable_Note_Wide
	dc.w	@Note_Wide_PSG-@SpriteTable_Note_Wide

@Note_Wide_Highlight:
	dc.b	1
	dc.b	1, %0010, 0, 0, -1

@Note_Wide_FM:
	dc.b	1
	dc.b	1, %0010, 0, 3, -1

@Note_Wide_PSG:
	dc.b	1
	dc.b	1, %0010, 0, 6, -1
	even

; ---------------------------------------------------------------------------
@SpriteTable_Note_Narrow:
	dc.w	@Note_Narrow_Highlight-@SpriteTable_Note_Narrow
	dc.w	@Note_Narrow_FM-@SpriteTable_Note_Narrow
	dc.w	@Note_Narrow_PSG-@SpriteTable_Note_Narrow

@Note_Narrow_Highlight:
	dc.b	1
	dc.b	1, %0001, 0, 0, 0

@Note_Narrow_FM:
	dc.b	1
	dc.b	1, %0001, 0, 2, 0

@Note_Narrow_PSG:
	dc.b	1
	dc.b	1, %0001, 0, 4, 0
	even
