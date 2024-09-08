
; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------

SoundTest_Obj_BGPaletteEffect:

	@max_fade_factor: = $A00
	@min_fade_factor: = $000

	@fade_factor: = $22	; .w	8.8 FIXED
	@fade_vel: = $24	; .w

	move.w	#@min_fade_factor, @fade_factor(a0)
	move.w	#0, @fade_vel(a0)
	move.l	#@ObjRoutine_Main, obCodePtr(a0)

@ObjRoutine_Main:
	tst.b	SoundTest_FadeCounter			; are we fading?
	bne	@ret					; if yes, don't mess with the palette

	bsr	@UpdateFadeFactor
	bsr	@UpdatePalette

	move.b	(SoundDriverRAM+v_music_dac_track+TrackNoteOutput).w, d0
	beq	@ret
	clr.b	(SoundDriverRAM+v_music_dac_track+TrackNoteOutput).w
	; TODO: Other samples for the effect
	cmp.b	#$82, d0			; is sample snare?
	bne	@ret				; if not, branch

	move.w	#$120, @fade_vel(a0)
	rts

; ---------------------------------------------------------------------------
@UpdateFadeFactor:
	sub.w	#$24, @fade_vel(a0)
	cmp.w	#-$200, @fade_vel(a0)
	bgt.s	@fade_velocity_ok
	move.w	#-$200, @fade_vel(a0)		; cap fade velocity
@fade_velocity_ok:

	move.w	@fade_vel(a0), d0
	bmi.s	@DecreaseFadeFactor
	add.w	d0, @fade_factor(a0)
	cmp.w	#@max_fade_factor, @fade_factor(a0)
	blo	@ret
	move.w	#@max_fade_factor, @fade_factor(a0)
	rts

@DecreaseFadeFactor:
	add.w	d0, @fade_factor(a0)
	cmp.w	#@min_fade_factor, @fade_factor(a0)
	bgt.s	@ret
	move.w	#@min_fade_factor, @fade_factor(a0)
	rts

; ---------------------------------------------------------------------------
@UpdatePalette:

	@value_of_E:		equr	d4
	@color_cnt:		equr	d6
	@source_palette:	equr	a1
	@target_palette:	equr	a2

	lea	SoundTest_Palette+$22, @source_palette
	lea	Pal_Active+$22, @target_palette

	moveq	#-2, d1
	and.b	@fade_factor(a0), d1
	move.b	d1, d3
	lsl.b	#4, d3

	moveq	#$E, @value_of_E
	moveq	#8-1, @color_cnt

	@color_loop:
		move.b	(@source_palette)+, (@target_palette)+		; copy Blue channel as is

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
