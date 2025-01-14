
; -----------------------------------------------------------------------------
; Optimized sprite renderer with sprite piece culling for widescreen
; -----------------------------------------------------------------------------
; (c) 2024, Vladikcomper
; -----------------------------------------------------------------------------

BuildSprites:

	; USED REGISTERS:
	@obj:		equr	a0
	@camera:	equr	a1
	@spr_buffer:	equr	a2	; WARNING! Don't change
	@proc_layer_sp:	equr	a3
	@spr_queue:	equr	a4
	@base_xpos:	equr	a5
	@base_ypos:	equr	a6

	@var0:		equr	d0
	@var1:		equr	d1
	@ypos:		equr	d2
	@xpos:		equr	d3
	@render:	equr	d4
	@spr_counter:	equr	d5	; WARNING! Don't change
	@spr_link:	equr	d6
	@piece_cnt:	equr	d7

	lea 	Sprite_Buffer, @spr_buffer
	moveq	#80-1, @spr_counter

	; Black Bars(tm) may inject special code for sprite masking
	move.w	BlackBars.Handler, a0
	jsr	_BB_BuildSpritesCallback(a0)	; updates @spr_buffer, @spr_counter

	moveq	#80, @spr_link
	sub.b	@spr_counter, @spr_link

	; Process 8 sprite priority layers in order
	bsr	@ProcessSpriteLayers

@FinalizeSpriteBuffer:
	; Clear sprite queue and unlink the last sprite
	moveq	#0, @var0
	tst.w	@spr_counter			; do we have any sprites left?
	beq.s	@unlink_done			; if not, branch
	move.l	@var0, (@spr_buffer)+
@unlink_done:

	@current_queue_ptr: = Sprites_Queue
	rept 8
		move.w	@var0, @current_queue_ptr
		@current_queue_ptr: = @current_queue_ptr + $80
	endr
	rts

; --------------------------------------------------------------
; Special variant of BuildSprites for Special stages
; --------------------------------------------------------------

@BuildSprites_SS:
	jsr	SS_ShowLayout			; prepare SS sprites

	lea 	Sprite_Buffer, @spr_buffer
	moveq	#80-1, @spr_counter

	; Black Bars(tm) may inject special code for sprite masking
	move.w	BlackBars.Handler, a0
	jsr	_BB_BuildSpritesCallback(a0)	; updates @spr_buffer, @spr_counter

	moveq	#80, @spr_link
	sub.b	@spr_counter, @spr_link

	bsr	@ProcessSpriteLayers
	bsr	@ProcessSSLayout

	bra	@FinalizeSpriteBuffer

; --------------------------------------------------------------
;
; --------------------------------------------------------------

@ProcessSpriteLayers:
	movea.w	sp, @proc_layer_sp

	@current_spr_queue: = Sprites_Queue
	@layers_cnt: = 8

	while @layers_cnt > 0
		lea	@current_spr_queue.w, @spr_queue
		moveq	#$7E, @var0
		sub.w	(@spr_queue)+, @var0			; @var0 = ($40 - sprites - 1) * 2
		if @layers_cnt > 1
			jsr	@ProcessSpriteLayers.ExecuteQueue(pc, @var0)
		else
			jmp	@ProcessSpriteLayers.ExecuteQueue(pc, @var0)
		endif

		@current_spr_queue: = @current_spr_queue + $80
		@layers_cnt: = @layers_cnt - 1
	endw
	
	if def(__DEBUG__)
		illegal	; WHY WE'RE HERE...
	endif

; --------------------------------------------------------------
@ProcessSpriteLayers.ExecuteQueue:
	rept	$3F-1
		bsr.s	@ProcessSpriteLayers.ExecuteQueue.ProcessObject
	endr
		bra.s	@ProcessSpriteLayers.ExecuteQueue.ProcessObject	; tail optimization
	rts

; --------------------------------------------------------------
@ProcessSpriteLayers.ExecuteQueue.ProcessObject:

	movea.w	(@spr_queue)+, @obj

	assert.l obMap(@obj), ne, , @Debugger_Object

	move.b	obRender(@obj), @render
	moveq	#%1100, @var0
	and.b	@render, @var0
	beq.s	@OnScreenCoordinateSprite	; if on-screen coordinate system used, branch
	lea	Camera_FG, @camera		; NOTICE! in-background coordinates are no longer supported

	; Check range: Y + obHeight(@obj) = 0 .. SCREEN_HEIGHT + 2*obHeight(@obj)
	move.w	obY(@obj), @ypos
	sub.w	4(@camera), @ypos
	moveq	#$20, @var0			; use default sprite Y-radius of $20 pixels
	btst	#4, @render			; is "custom height" flag set?
	beq.s	@y_radius_ok			; if not, branch
	move.b	obHeight(@obj), @var0
@y_radius_ok:
	move.w	#SCREEN_HEIGHT, @var1
	add.w	@var0, @var1			; @var1 = SCREEN_HEIGHT + obHeight(@obj)
	add.w	@var0, @var1			; @var1 = SCREEN_HEIGHT + 2*obHeight(@obj)
	add.w	@ypos, @var0			; @var0 = Y + obHeight(@obj)
	cmp.w	@var1, @var0
	bhs.s	@MarkSpriteOffscreen

	; Check range: X + obActWid(@obj) = 0 .. SCREEN_WIDTH + 2*obActWid(@obj)
	move.w	obX(@obj), @xpos
	sub.w	(@camera), @xpos
	;moveq	#0, @var0			-- OPTIMIZED OUT
	move.b	obActWid(@obj), @var0
	move.w	#SCREEN_WIDTH, @var1
	add.w	@var0, @var1			; @var1 = SCREEN_WIDTH + obActWid(@obj)
	add.w	@var0, @var1			; @var1 = SCREEN_WIDTH + 2*obActWid(@obj)
	add.w	@xpos, @var0			; @var0 = X + obActWid(@obj)
	cmp.w	@var1, @var0
	blo.s	@DisplaySprite

@MarkSpriteOffscreen:
	and.b	#$7F, obRender(@obj)		; clear display flag
	rts

@OnScreenCoordinateSprite:
	moveq	#$20-$80, @ypos
	add.w	obScreenY(@obj), @ypos
	moveq	#$20-$80, @xpos
	add.w	obX(@obj), @xpos
	bra.s	@DisplaySprite2

; --------------------------------------------------------------
@DisplaySprite:

	@maps:	equr	@camera

	moveq	#$20, @var0
	add.w	@var0, @xpos
	add.w	@var0, @ypos

@DisplaySprite2:

	ori.b	#$80, obRender(@obj)		; mark object as displayed
	movea.l	obMap(@obj), @maps

	move.w	@xpos, @base_xpos
	move.w	@ypos, @base_ypos

	moveq	#0, @piece_cnt
	btst	#5, @render			; is raw mappings bit set?
	bne.s	@DrawSprite			; if yes, branch

	;moveq	#0, @var0			-- OPTIMIZED OUT
	move.b	obFrame(@obj), @var0		; get mapping frame
	add.w	@var0, @var0
	adda.w	(@maps, @var0), @maps		; load mappings for this frame

	move.b	(@maps)+, @piece_cnt		; get pieces count from mappings data
	subq.w	#1, @piece_cnt
	bpl.s	@DrawSprite			; if we have pieces to draw, branch
	rts					; otherwise, do nothing ...

; ==============================================================
@DrawSprite:
	@base_pat:	equr	@obj
	@pat:		equr	@render

	move.w	obGfx(@obj), @base_pat

	lsr.b	@render				; is object fliped on the X-axis?
	bcs.w	@DrawSprite_HasXFlip		; if yes, branch
	lsr.b	@render
	bcs.w	@DrawSprite_YFlip

@GenerateDrawSprite:	macro xflip, yflip

	@DrawSpritePiece_Loop_\@:
		; Check sprite visibility on Y-axis
		move.b	(@maps)+, @ypos
		move.b	(@maps)+, @var1			; @var1 = %WWHH
		ext.w	@ypos
		if yflip
			neg.w	@ypos
			moveq	#%11, @var0
			and.w	@var1, @var0		; @var0 = Height - 1
			lsl.w	#3, @var0		; @var1 = (Height - 1) * 8
			addq.w	#8, @var0		; @var1 = Height * 8
			sub.w	@var0, @ypos
		endif
		add.w	@base_ypos, @ypos		; @ypos = SpritePiece.YPos + On-Screen YPos + $20
		cmp.w	#SCREEN_HEIGHT+$20, @ypos
		bhs.s	@DrawSpritePiece_Skip_\@

		; Read sprite pattern
		move.b	(@maps)+, -(sp)
		move.w	(sp)+, @pat
		move.b	(@maps)+, @pat

		; Check sprite visibility on X-axis
		move.b	(@maps)+, @xpos
		ext.w	@xpos
		if xflip
			neg.w	@xpos
			moveq	#%1100, @var0
			and.w	@var1, @var0		; @var0 = (SpriteWidth - 1) * 4
			add.w	@var0, @var0		; @var0 = (SpriteWidth - 1) * 8
			addq.w	#8, @var0		; @var0 = SpriteWidth * 8
			sub.w	@var0, @xpos
		endif
		add.w	@base_xpos, @xpos		; @xpos = SpritePiece.XPos + On-Screen XPos + $20
		cmp.w	#SCREEN_WIDTH+$20, @xpos
		bhs.s	@DrawSpritePiece_Next_\@

		; Write sprite to the buffer
		if SCREEN_XDISP
			add.w	#$80-$20+SCREEN_XDISP, @xpos
			add.w	#$80-$20, @ypos
		else
			moveq	#$80-$20, @var0
			add.w	@var0, @xpos
			add.w	@var0, @ypos
		endif
		add.w	@base_pat, @pat
		if xflip & yflip
			eor.w	#$1800, @pat
		elseif xflip
			eor.w	#$800, @pat
		elseif yflip
			eor.w	#$1000, @pat
		endif

		move.w	@ypos, (@spr_buffer)+
		move.b	@var1, (@spr_buffer)+
		move.b	@spr_link, (@spr_buffer)+
		addq.b	#1, @spr_link
		move.w	@pat, (@spr_buffer)+
		move.w	@xpos, (@spr_buffer)+

		dbf	@spr_counter, @DrawSpritePiece_Next_\@	; go on if we still have sprites to draw ...
		move.w	@proc_layer_sp, sp			; otherwise short-circuit layer processing
		rts						; ''

	@DrawSpritePiece_Next_\@:
		dbf 	@piece_cnt, @DrawSpritePiece_Loop_\@
		rts

	@DrawSpritePiece_Skip_\@:
		addq.w	#3, @maps
		dbf 	@piece_cnt, @DrawSpritePiece_Loop_\@
		rts
	endm	

@DrawSprite_Normal:
	@GenerateDrawSprite 0, 0

@DrawSprite_YFlip:
	@GenerateDrawSprite 0, 1

@DrawSprite_XYFlip:
	@GenerateDrawSprite 1, 1

@DrawSprite_HasXFlip:
	lsr.b	@render
	bcs.s	@DrawSprite_XYFlip
	
	@GenerateDrawSprite 1, 0

; --------------------------------------------------------------
;
; --------------------------------------------------------------

	if def(__DEBUG__)
@Debugger_Object:
	Console.WriteLine "addr=%<.w @obj>"
	Console.WriteLine "id=%<.b (@obj)>"
	Console.WriteLine "art=%<.w obGfx(@obj)>"
	Console.WriteLine "maps=%<.l obMap(@obj) sym>"
	Console.WriteLine "frame=%<.b obFrame(@obj)>"
	rts
	endif

; --------------------------------------------------------------
;
; --------------------------------------------------------------

	rept 80
		move.l	(@spr_queue)+, @var0
		move.b	@spr_link, @var0
		addq.b	#1, @spr_link
		move.l	@var0, (@spr_buffer)+
		move.l	(@spr_queue)+, (@spr_buffer)+
	endr

@ProcessSSLayout.ExecuteQueue:
	rts

; --------------------------------------------------------------
@ProcessSSLayout:
	lea	SS_SpritesQueue, @spr_queue
	move.w	(@spr_queue)+, @var0
	addq.w	#1, @spr_counter
	cmp.w	@spr_counter, @var0
	bls.s	@ProcessSSLayout.SpriteCount_Ok
	move.w	@spr_counter, @var0

@ProcessSSLayout.SpriteCount_Ok:
	mulu.w	#10, @var0
	neg.w	@var0
	jmp	@ProcessSSLayout.ExecuteQueue(pc, @var0)

; --------------------------------------------------------------

; A ditry trick to make a local label global without breaking everything else
BuildSprites_SS:	equ	@BuildSprites_SS
