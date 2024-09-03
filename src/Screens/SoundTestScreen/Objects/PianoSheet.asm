
; ---------------------------------------------------------------------------
; Scrolling piano sheet object
; ---------------------------------------------------------------------------

SoundTest_Obj_PianoSheet: rts

	@base_x: = 0;(320 - SoundTest_Visualizer_Width*8) / 2
	@base_y: = 40

	@frame_1_width:	= SoundTest_Visualizer_Width*8
	@frame_2_width:	= 0
	@frame_height: = SoundTest_Visualizer_Height*8

	if @frame_1_width > 256
		@frame_2_width: = @frame_1_width - 256
		@frame_1_width: = 256
	endif

	move.w	#$80+@base_x+@frame_1_width/2, obX(a0)
	if @frame_2_width
		SoundTest_CreateChildObject #@Init_Cont
		move.b	#1, obFrame(a1)
		move.w	#$80+@base_x+@frame_1_width+@frame_2_width/2, obX(a1)
	endif

@Init_Cont:
	move.l	#@ObjMap_PianoSheet, obMap(a0)
	move.w	#$80+@base_y+@frame_height/2, obScreenY(a0)
	move.w	#(SoundTest_Visualizer_VRAM/$20)|$8000|$6000, obGfx(a0)
	move.l	#DisplaySprite, $3C(a0)
	rts

; ---------------------------------------------------------------------------
@ObjMap_PianoSheet:

@generateFrame: macro width, height, baseTileIndex, fullWidthTiles
	dc.b	(@frameEnd\@ - @frameStart\@)/5

@frameStart\@:
	@curr_y: = 0
	@curr_tile: = baseTileIndex

	while @curr_y < height
		@next_y: = @curr_y + 32
		if @next_y > height
			@next_y: = height
		endif

		@next_tile: = @curr_tile + fullWidthTiles*(32/8)

		@curr_x: = 0

		while @curr_x < width
			@next_x: = @curr_x + 32
			if @next_x > width
				@next_x: = width
			endif

			@size: = (((@next_x - @curr_x)/8-1)<<2) | ((@next_y - @curr_y)/8-1)

			dc.b	@curr_y - height/2	; y
			dc.b	@size			; size
			dc.w	@curr_tile		; tile index
			dc.b	@curr_x - width/2	; x

			@curr_tile: = @curr_tile + ((@next_x - @curr_x)/8)*((@next_y - @curr_y)/8)

			@curr_x: = @next_x
		endw
		@curr_y: = @next_y
		@curr_tile: = @next_tile
	endw
@frameEnd\@:
	endm

; ---------------------------------------------------------------------------
@Index:
	dc.w	@Frame1 - @Index
	dc.w	@Frame2 - @Index

@Frame1:
	@generateFrame @frame_1_width, @frame_height, 0, SoundTest_Visualizer_Width

@Frame2:
	@generateFrame @frame_2_width, @frame_height, (@frame_1_width/8)*(32/8), SoundTest_Visualizer_Width
