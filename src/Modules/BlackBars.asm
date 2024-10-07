
_BB_BuildSpritesCallback:	equ	$04
_BB_HandlerIdMask:		equ	%1<<1			; corresponds to number of handlers

; ===========================================================================
; ---------------------------------------------------------------------------
; Black bars initialization and reset functions
; ---------------------------------------------------------------------------

BlackBars.Init:
	bsr.s	BlackBars.SetHandler

BlackBars.Reset:
	KDebug.WriteLine "BlackBars.Reset()..."
	move.w	#NullInt,HBlankSubW				; don't run any code during HInt
	move.w	#0,BlackBars.Height				; set current height to 0
	move.w	#BlackBars.MaxHeight,BlackBars.BaseHeight	; set base height to default
	move.w	BlackBars.BaseHeight,BlackBars.TargetHeight	; set target height to default
	move.l	#$8ADF8ADF, BlackBars.FirstHCnt			; + BlackBars.SecondHCnt
	rts

BlackBars.SetHandler:
	KDebug.WriteLine "BlackBars.SetHandler(): id=%<.b BlackBars.HandlerId>"
	moveq	#_BB_HandlerIdMask, d0
	and.b	BlackBars.HandlerId, d0
	move.w	BlackBars.HandlerList(pc, d0), BlackBars.Handler
	rts

; ---------------------------------------------------------------------------
BlackBars.HandlerList:
	dc.w	BlackBars.EmulatorOptimizedHandlers		; $00
	dc.w	BlackBars.HardwareOptimizedHandlers		; $02

; ---------------------------------------------------------------------------
; called from VBlank every single frame
; ---------------------------------------------------------------------------

BlackBars.VBlankUpdate:
	cmp.b	#$38, GameMode					; is mode Black bars config?
	beq.s	@blackbars_raw					; if yes, don't run state routine
	tst.w	($FFFFFE02).w					; is level set to restart?
	bne.s	@notlz						; if yes, branch
	tst.b	($FFFFFFE9).w					; is fade out currently in progress?
	bne.s	@notlz						; if yes, branch
	cmpi.b	#1, CurrentZone					; are we in LZ?
	bne.s	@notlz						; if not, branch
	cmpi.b	#$C, GameMode					; are we done with the pre-level sequence?
	bne.w	@notlz						; if not, branch
	move.w	#HBlank_WaterSurface, HBlankSubW
@end	rts

@notlz:
	bsr	BlackBars.SetState

@blackbars_raw:
	if def(__DEBUG__)
		moveq	#_BB_HandlerIdMask, d1
		and.b	BlackBars.HandlerId, d1
		move.w	BlackBars.HandlerList(pc, d1), d1
		assert.w d1, eq, BlackBars.Handler, Debugger_BlackBars
	endif

	move.w	BlackBars.Handler, a0
	jmp	(a0)

; ---------------------------------------------------------------------------
; Emulator-optimized Black bars implementation
; ---------------------------------------------------------------------------

BlackBars.EmulatorOptimizedHandlers:
	bra.w	@VBlankCallback			; $00
	bra.w	@BuildSpritesCallback		; $04

; ---------------------------------------------------------------------------
@VBlankCallback:
	move.w	BlackBars.Height,d0				; is height 0?
	beq.s	@disable_bars					; if yes, branch

	; Sprite masking trick for the last rendered raster line
	move.w	#224+$80+1, d1
	sub.w	d0, d1
	move.w	d1, Sprite_Buffer
	move.w	d1, Sprite_Buffer+8

	cmp.w	#224/2-1,d0					; are we taking half the screen?
	bhi.s	@make_black_screen				; if yes, branch
	cmp.w	#224/4-1,d0					; are we quater the screen?
	bhs.s	@make_bars_past_quarter				; if yes, branch

	move.w	#HBlank_Bars_EmulatorOptimized, HBlankSubW
	move.w	d0,d1
	add.w	d1,d1
	add.w	d0,d1
	sub.w	#224-1,d1
	neg.w	d1

@make_bars_cont:
	move.b	d0, BlackBars.FirstHCnt+1
	move.b	d1, BlackBars.SecondHCnt+1
	move.w	BlackBars.FirstHCnt, VDP_Ctrl
	move.l	#$81348701, VDP_Ctrl				; disable display, set backdrop color to black
	rts
; ---------------------------------------------------------------------------

@make_bars_past_quarter:
	move.w	#HBlank_Bars_PastQuarter_EmulatorOptimized, HBlankSubW
	move.w	d0,d1
	add.w	d1,d1
	sub.w	#224-1,d1
	neg.w	d1
	lsr.w	#1,d0
	bcc.s	@make_bars_cont
	move.w	#HBlank_Bars_PastQuarterOdd_EmulatorOptimized, HBlankSubW
	bra.s	@make_bars_cont
; ---------------------------------------------------------------------------

@make_black_screen:
	move.l	#$81348701,VDP_Ctrl				; disable display, set backdrop color to black
	move.w	#NullInt,HBlankSubW
	rts

@disable_bars:
	move.l	#$81748720,VDP_Ctrl				; enable display, restore backdrop color
	move.w	#NullInt,HBlankSubW
	rts

; ---------------------------------------------------------------------------
@BuildSpritesCallback:
	; Reserve 2 sprite slots for sprite masking
	; NOTE: These slots are finalized in BlackBars handler during VBlank
	if USE_NEW_BUILDSPRITES
		subq.w	#2, d5			; reserve 2 slots
	else
		addq.w	#2, d5			; reserve 2 slots
	endif
	move.l	#$01700F01, (a2)+	; Y-pos, size, link
	move.l	#$00000001, (a2)+	; pattern, X-pos
	move.l	#$01700F02, (a2)+	; Y-pos, size, link
	move.l	#$00000000, (a2)+	; pattern, X-pos
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Hardware-optimized Black bars implementation
; ---------------------------------------------------------------------------
; NOTE:
; As of 2024 no mainstream emulators properly support this implementation
; yet. Blastem-nightly comes the closest.
; ---------------------------------------------------------------------------

BlackBars.HardwareOptimizedHandlers:
	bra.w	@VBlankCallback			; $00
	rts					; $04

; ---------------------------------------------------------------------------
@VBlankCallback:
	move.w	BlackBars.Height,d0				; is height 0?
	beq.s	@disable_bars					; if yes, branch

	cmp.w	#224/2-1,d0					; are we taking half the screen?
	bhi.s	@make_black_screen				; if yes, branch
	cmp.w	#224/4-1,d0					; are we quater the screen?
	bhs.s	@make_bars_past_quarter				; if yes, branch

	move.w	#HBlank_Bars_HardwareOptimized, HBlankSubW
	move.w	d0,d1
	add.w	d1,d1
	add.w	d0,d1
	sub.w	#224-1,d1
	neg.w	d1

@make_bars_cont:
	move.b	d0, BlackBars.FirstHCnt+1
	move.b	d1, BlackBars.SecondHCnt+1
	lea	VDP_Debug, a0
	move.l	#$81748701, VDP_Ctrl-VDP_Debug(a0)		; enable display, set backdrop color to black
	move.w	BlackBars.FirstHCnt, VDP_Ctrl-VDP_Debug(a0)
	move.w	#$40, (a0)					; evil disable display hack
	ori.b	#0, d0						; what the fuck?
	move.l	a0, usp
	st.b	VDPDebugPortSet
	rts
; ---------------------------------------------------------------------------

@make_bars_past_quarter:	
	move.w	#HBlank_Bars_PastQuarter_HardwareOptimized, HBlankSubW
	move.w	d0,d1
	add.w	d1,d1
	sub.w	#224-1,d1
	neg.w	d1
	lsr.w	#1,d0
	bcc.s	@make_bars_cont
	move.w	#HBlank_Bars_PastQuarterOdd_HardwareOptimized, HBlankSubW
	bra.s	@make_bars_cont
; ---------------------------------------------------------------------------

@make_black_screen:
	move.l	#$81348701, VDP_Ctrl				; disable display, set backdrop color to black
	move.w	#NullInt, HBlankSubW
	rts

@disable_bars:
	tst.b	VDPDebugPortSet
	beq.s	@debug_port_ok
	lea	VDP_Debug, a0
	move.w	#0, (a0)					; evil enable display hack
	ori.b	#0, d0						; what the fuck?
	sf.b	VDPDebugPortSet

@debug_port_ok:
	move.l	#$81748720, VDP_Ctrl				; enable display, restore backdrop color
	move.w	#NullInt, HBlankSubW
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Black bars debugger
; ---------------------------------------------------------------------------

	if def(__DEBUG__)

Debugger_BlackBars:
	Console.WriteLine "%<pal1>BlackBarsRAM:%<endl>"
	Console.WriteLine "%<pal1>HandlerId: %<pal2>%<.b BlackBars.HandlerId>"
	Console.WriteLine "%<pal1>Handler: %<pal2>%<.w BlackBars.Handler> %<pal0>%<.w BlackBars.Handler sym>"
	Console.WriteLine "%<pal1>Height: %<pal2>%<.w BlackBars.Height>"
	Console.WriteLine "%<pal1>FirstHCnt: %<pal2>%<.w BlackBars.FirstHCnt>"
	Console.WriteLine "%<pal1>SecondHCnt: %<pal2>%<.w BlackBars.SecondHCnt>"
	rts

	endif
