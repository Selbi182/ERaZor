
	include	"Screens/SoundTestScreen/Variables.asm"

; ---------------------------------------------------------------------------
; Sound Test screen HBlank handlers
; ---------------------------------------------------------------------------

SoundTest_GenerateHBlankCode: macro start_buffer_pos
	@buffer_pos: = start_buffer_pos
	@scanline: = 0
	@next_scanline: = 1

	rept 224
	@HInt_Scanline_\#@scanline:
		move.w	@buffer_pos.w, VDP_Data
		if @scanline = 32 + SoundTest_Visualizer_Height*8
			move.l	#$40000010, VDP_Ctrl			; apply Plane A <-> Plane C switch
			move.w	(start_buffer_pos+225*2).w, VDP_Data	; ''
			move.l	#$40020010, VDP_Ctrl			; back to Plane B updates
		endif
		if @scanline < 223
			move.w	#@HInt_Scanline_\#@next_scanline, HBlankSubW
		else
			move.w	#NullInt, HBlankSubW
			move.l	#$80048ADF, VDP_Ctrl
		endif
		rte

		@buffer_pos: = @buffer_pos + 2
		@scanline: = @next_scanline
		@next_scanline: = @next_scanline + 1
	endr
	endm

; ---------------------------------------------------------------------------
SoundTest_HBlank_Buffer1:
	SoundTest_GenerateHBlankCode	SoundTest_VScrollBuffer1

; ---------------------------------------------------------------------------
SoundTest_HBlank_Buffer2:
	SoundTest_GenerateHBlankCode	SoundTest_VScrollBuffer2
