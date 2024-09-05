
	include	"Screens/SoundTestScreen/Variables.asm"

; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------

SoundTest_HBlank:
	;move.l	a0, -(sp)
	;movea.w	SoundTest_ActiveVScrollBufferPos, a0
	;move.l	#$40000010, VDP_Ctrl
	;move.l	(a0)+, VDP_Data
	;move.w	a0, SoundTest_ActiveVScrollBufferPos
	;move.l	(sp)+, a0
	;rte

	@buffer_pos: = SoundTest_VScrollBuffer_A+4
	@scanline: = 0
	@next_scanline: = 1

	rept 223
	@HInt_Scanline_\#@scanline:
		move.l	#$40000010, VDP_Ctrl
		move.l	@buffer_pos.w, VDP_Data
		if @scanline < 222
			add.w	#@HInt_Scanline_\#@next_scanline - @HInt_Scanline_\#@scanline, HBlankSubW
		else
			move.w	#NullInt, HBlankSubW
			move.w	#$8ADF, VDP_Data
		endif
		rte

		@buffer_pos: = @buffer_pos + 4
		@scanline: = @next_scanline
		@next_scanline: = @next_scanline + 1
	endr
