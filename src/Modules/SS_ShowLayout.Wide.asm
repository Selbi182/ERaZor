
; ==============================================================================
; ------------------------------------------------------------------------------
; Custom SS layout renderer
;
; Ported from Sonic 1 Blastless engine
; ------------------------------------------------------------------------------
; (c) Vladikcomper
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; SS layout configuration data
; ------------------------------------------------------------------------------

SS_ShowLayout_Config:

	@block_width: equ $18

	if def(__WIDESCREEN__)=0
		; 320x224
		@matrix_size: = $10
		dc.w	@matrix_size
		dc.w	(-@block_width*@matrix_size/2+12)
		dc.w	(-@block_width*@matrix_size/2+12)
	else
		; 400x224
		@matrix_size: = $14
		dc.w	@matrix_size
		dc.w	(-@block_width*@matrix_size/2+12)+6
		dc.w	(-@block_width*@matrix_size/2+12)+$18*2
	endif


; ==============================================================================
; ---------------------------------------------------------------------------
; Subroutine to show the special stage layout
; ---------------------------------------------------------------------------

SS_ShowLayout:

@block_width:		equ	$18
@max_matrix_size:	equ	$14

	bsr.w	SS_AniWallsRings
	bsr.w	SS_AniItems

	; ---------------------------------------------------------------------------
	; Calculate blocks positions depending on angle
	; Diplay area defaults to @matrix_size*$18 x @matrix_size*$18
	; ---------------------------------------------------------------------------
	; For 424x240 resolution:
	; 	@matrix_size = sqrt( 424 ** 2 + 240 ** 2 ) / $18 = $14
	;
	; For 400x224 resolution:
	; 	@matrix_size = sqrt( 424 ** 2 + 240 ** 2 ) / $18 = $13
	;
	; For 256x256 resolution:
	;	@matrix_size = sqrt( 256 ** 2 + 256 ** 2 ) / $18 = $0F
	; ---------------------------------------------------------------------------


	@var0:			equr	d0
	@hash:			equr	d1

	@block_dy:		equr	d4
	@block_dx:		equr	d5

	@matrix_x:		equr	a1
	@matrix_y:		equr	a2
	@matrix_col_jmp:	equr	a3

	@config:		equr	a5

	; Config variables
	@matrix_size:		equ	0
	@matrix_start_x:	equ	2
	@matrix_start_y:	equ	4

	lea	SS_ShowLayout_Config, @config
	lea 	SS_PositionMatrix, @matrix_x
	lea 	SS_PositionMatrix+2, @matrix_y

	moveq	#0, d0
	move.b	($FFFFF780).w, d0			; d0 = Angle
	jsr 	CalcSine
	move.w	d0, @block_dy
	move.w	d1, @block_dx
	muls.w	#@block_width, @block_dy		; @block_dy = Sin(Angle) * @block_width = $1800 .. -$1800
	muls.w	#@block_width, @block_dx		; @block_dx = Cos(Angle) * @block_width
	asl.l	#8, @block_dy
	asl.l	#8, @block_dx

	moveq	#0,d2
	move.w	CamXpos,d2
	divu.w	#@block_width,d2
	swap	d2
	neg.w	d2
	add.w	@matrix_start_x(@config), d2		; d2 = -180 - CamXpos % $18
	
	moveq	#0,d3
	move.w	CamYpos,d3
	divu.w	#@block_width,d3
	swap	d3
	neg.w	d3
	add.w	@matrix_start_y(@config), d3		; d3 = -180 - CamYpos % $18

	move.w	(@config), d7				; d7 = @matrix_size(@config)
	moveq	#@max_matrix_size, d6
	sub.w	d7, d6					; d6 = max_martix_size - matrix_size
	lsl.w	#3, d6					; d6 = (max_martix_size - matrix_size) * 8
	lea	@BuildPosMatrix_ColLoop_Start(pc, d6), @matrix_col_jmp
	subq.w	#1, d7

	@BuildPosMatrix_Loop:
		movem.w d0-d2, -(sp)

		neg.w	d0				; d0 = -Sin(Angle)
		muls.w	d2, d1				; d1 = Cos(Angle) * (-180 - CamXpos % $18)
		muls.w	d3, d0				; d0 = -Sin(angle) * (-180 - CamYpos % $18 + $18*Y)
		move.l	d0, d6
		add.l	d1, d6				; d6 = Cos * (-180 - CamXpos % $18) - Sin * (-180 - CamYpos % $18 + $18*Y)

		movem.w (sp), d0-d1

		muls.w	d2, d0				; d0 = Sin(Angle) * (-180 - CamXpos % $18)
		muls.w	d3, d1				; d1 = Cos(Angle) * (-180 - CamYpos % $18 + $18*Y)
		add.l	d0, d1				; d1 = Cos * (-180 - CamYpos % $18 + $18*Y) + Sin * (-180 - CamXpos % $18)
		move.l	d6, d2				; d2 = Cos * (-180 - CamXpos % $18) - Sin * (-180 - CamYpos % $18 + $18*Y)

		asl.l	#8, d1
		moveq	#16, d6
		swap	d6
		add.l	d6, d1				; shift X-pos by 16 pixels to optimize visibility checks later on ...

		asl.l	#8, d2
		add.l	d6, d2

		jmp	(@matrix_col_jmp)		; jumps to appropriate iteration in "@BuildPosMatrix_ColLoop_Start"

		@BuildPosMatrix_ColLoop_Start:
			rept @max_matrix_size
				; WARNING! This code should be exactly 8 bytes!
				move.l	d2, (@matrix_x)+	; WARNING! Overlapping writes below! => @matrix_y = @matrix_x + 2
				move.l	d1, (@matrix_y)+	; WARNING! This will overflow buffer by 2 bytes eventually ...
				add.l	@block_dx, d2		; Cos * (-180 - CamXpos % $18 + $18*X) - Sin * (-180 - CamYpos % $18 + $18*Y)
				add.l	@block_dy, d1		; Cos * (-180 - CamXpos % $18 + $18*X) - Sin * (-180 - CamYpos % $18 + $18*Y)
			endr
		@BuildPosMatrix_ColLoop_End:

		movem.w (sp)+, d0-d2
		add.w	#@block_width, d3
		dbf 	d7, @BuildPosMatrix_Loop

	assert.l a1, ls, #SS_PositionMatrix+$1000

	; ---------------------------------------------------------------------------
	; Fill sprites queue to render
	; ---------------------------------------------------------------------------

	;@var0:		equr	d0
	@xcorr:		equr	d1
	@ypos:		equr	d2
	@xpos:		equr	d3
	@xbound:	equr	d4
	@ybound:	equr	d5

	@layout:	equr	a0
	@spr_queue_end:	equr	a1
	@maps:		equr	a3
	@matrix:	equr	a4
	@obj:		equr	a5
	@spr_queue:	equr	a6

	lea 	($FF0000).l, @layout
	moveq	#0, @var0
	move.w	CamYpos, @var0
	divu.w	#@block_width, @var0
	mulu.w	#$80, @var0		; @var0 = (CamYpos / $18) * $80
	adda.l	@var0, @layout

	moveq	#0, @var0
	move.w	CamXpos, @var0
	divu.w	#@block_width, @var0	; @var0 = (CamXPos / $18)
	adda.w	@var0, @layout		; @layout = Layout + (CamYpos / $18) * $80 + (CamXPos / $18)

	lea	SS_SpritesQueue+2, @spr_queue
	lea	SS_SpritesQueue+2+80*8, @spr_queue_end
	lea 	SS_PositionMatrix, @matrix
	move.w	(@config), d7		; d7 = @matrix_size(@config)
	subq.w	#1, d7

	; Initialize X-correction variable
	move	#$80-16+SCREEN_XDISP, @xcorr

	; Initialize XY boundaries (corrected)
	moveq	#16+16, @xbound
	add.w	#SCREEN_WIDTH, @xbound
	moveq	#16+16, @ybound
	add.w	#SCREEN_HEIGHT, @ybound

	@SS_DisplayBlocks_RowLoop:
		; Checks if sprites limit was hit every once in a while ...
		cmpa.w	@spr_queue_end, @spr_queue
		bhs	@SS_DisplayBlocks_Quit

		move.w	(@config), d6				; d6 = @matrix_size(@config)
		subq.w	#1, d6

		@SS_DisplayBlocks_ColLoop:
			moveq	#0, @var0
			move.b	(@layout)+, @var0
			beq.s	@SS_DisplayBlocks_Next
			cmpi.b	#$4E, @var0
			bhi.s	@SS_DisplayBlocks_Next
			
			; Calc X coordinate, make sure it's in range
			move.w	(@matrix), @xpos
			add.w	#SCREEN_WIDTH/2, @xpos
			cmp.w	@xbound, @xpos
			bhi.s	@SS_DisplayBlocks_Next

			; Calc Y coordinate, make sure it's in range
			move.w	2(@matrix), @ypos
			add.w	#SCREEN_HEIGHT/2, @ypos
			cmp.w	@ybound, @ypos
			bhi.s	@SS_DisplayBlocks_Next

			move.l	@config, -(sp)			; @config shares register with @obj ...

			; Get sprite frame mappings ...
			lea 	$FF4000, @obj
			lsl.w	#3, @var0
			adda.w 	@var0, @obj
			movea.l	(@obj)+, @maps
			move.w	(@obj)+, @var0			; load frame
			add.w	@var0, @var0
			move.w	(@maps, @var0), @var0		; get sprite offset
			beq.s	@SS_DisplayBlocks_Done		; if offset is empty, branch
			adda.w	@var0, @maps

			; Start actual rendering now ...
			add.w	#$80-$10, @ypos
			add.w	(@maps)+, @ypos
			move.w	@ypos, (@spr_queue)+		; BUFFER => Send Y position ...
			move.w	(@maps)+, (@spr_queue)+		; BUFFER => Put WWHH and empty link field ...
			move.w	(@obj)+, @var0
			add.w	(@maps)+, @var0
			move.w	@var0, (@spr_queue)+		; BUFFER => Send art pointer ...
			add.w	@xcorr, @xpos
			add.w	(@maps)+, @xpos
			move.w	@xpos, (@spr_queue)+		; BUFFER => Send X position ...

		@SS_DisplayBlocks_Done:
			move.l	(sp)+, @config			; @config shares register with @obj ...

		@SS_DisplayBlocks_Next:
			addq.w	#4, @matrix
			dbf 	d6, @SS_DisplayBlocks_ColLoop

		moveq	#-$80, d6
		add.w	(@config), d6				; d6 = matrix_size - $80
		sub.w	d6, @layout				; @layout = @layout - matrix_size + $80 = @layout + $80 - matrix_size
		dbf 	d7, @SS_DisplayBlocks_RowLoop

@SS_DisplayBlocks_Quit:
	assert.w @spr_queue, ls, #SS_SpritesQueue+$800

	move.w	@spr_queue, @var0
	sub.w	#SS_SpritesQueue+2, @var0
	lsr.w	#3, @var0
	move.w	@var0, SS_SpritesQueue				; finalize sprites queue
	rts
