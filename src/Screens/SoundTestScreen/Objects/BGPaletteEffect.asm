
SoundTest_Obj_BGPaletteEffect:

	@timer:	= $30		; .w
	@fade_factor: = $32	; .b
	@fade_factor_dir: = $33	; .b

	@source_palette:equr	a1
	@target_palette:equr	a2

	move.w	#32, @timer(a0)
	move.l	#@ObjRoutine_UpdatePalette, obCodePtr(a0)

@ObjRoutine_UpdatePalette:
	; TODO: Disable in photosensitive mode

	subq.w	#1, @timer(a0)
	bne	@ret
	move.w	#4, @timer(a0)


	tst.b	@fade_factor_dir(a0)
	sne.b	d0			; d0 = 0 or -1
	add.b	d0, d0			; d0 = 0 or -2
	addq.w	#1, d0			; d0 = 1 or -1
	;add.b	d0, d0			; d0 = 2 or -2

	add.b	d0, @fade_factor(a0)
	beq.s	@reverse_fade_factor
	cmp.b	#$06, @fade_factor(a0)
	bhs.s	@reverse_fade_factor
	bra.s	@0

@reverse_fade_factor:
	eor.b	#$FF, @fade_factor_dir(a0)
	move.w	#16, @timer(a0)

@0

	@value_of_E:	equr	d4
	@color_cnt:	equr	d6

	lea	SoundTest_Palette+$22, @source_palette
	lea	Pal_Active+$22, @target_palette

	;KDebug.WriteLine "%<.b @fade_factor(a0)>"

	moveq	#-2, d1
	and.b	@fade_factor(a0), d1
	move.b	d1, d3
	lsl.b	#4, d3

	moveq	#$E, @value_of_E
	moveq	#8-1, @color_cnt

	@color_loop:
		move.b	(@source_palette)+, d0	; d0 = $0B
		add.b	d1, d0
		cmp.b	@value_of_E, d0
		bls.s	@blue_ok
		moveq	#$E, d0
	@blue_ok:
		move.b	d0, (@target_palette)+

		move.b	(@source_palette)+, d0	; d0 = $GR
		move.b	d0, d2
		and.b	#$E0, d2
		add.b	d3, d2
		bcc.s	@green_ok
		move.b	#$E0, d2
	@green_ok:

		and.b	@value_of_E, d0
		add.b	d1, d0
		cmp.b	@value_of_E, d0
		bls.s	@red_ok
		moveq	#$E, d0
	@red_ok:
		or.b	d2, d0
		move.b	d0, (@target_palette)+

		dbf	@color_cnt, @color_loop

@ret	rts
