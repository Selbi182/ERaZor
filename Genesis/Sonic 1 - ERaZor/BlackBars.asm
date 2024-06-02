
; ---------------------------------------------------------------------------
BlackBars.Init:
		move.w	#0, BlackBars.Height
		move.l	#$8ADF8ADF, BlackBars.FirstHCnt ; + BlackBars.SecondHCnt
		rts

; ---------------------------------------------------------------------------
BlackBars.UpdateInVBlank:
		move.w	BlackBars.Height, d0		; is height 0?
		beq.s	@disable_bars				; if yes, branch
		cmp.w	#224/2-1, d0				; are we taking half the screen?
		bhi.s	@make_black_screen			; if yes, branch
		move.b	d0, BlackBars.FirstHCnt+1
		move.w	d0, d1
		add.w	d1, d1
		add.w	d0, d1
		sub.w	#224-1, d1
		neg.w	d1
		move.b	d1, BlackBars.SecondHCnt+1
		move.w	#HBlank_Bars, HBlankSubW
		move.w	BlackBars.FirstHCnt, VDP_Ctrl
		move.l	#$81348701, VDP_Ctrl		; disable display, set backdrop color to black
		rts

@make_black_screen:
		move.l	#$81348701, VDP_Ctrl		; disable display, set backdrop color to black

@disable_bars:
		move.w	#NullInt, HBlankSubW
		rts
