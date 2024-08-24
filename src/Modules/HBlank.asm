
; ===========================================================================
; ---------------------------------------------------------------------------
; HBlank entry point, copied to RAM
; ---------------------------------------------------------------------------

HBlank_BaseHandler:
	; WARNING! Don't change this code or opcode size unless you know
	; what you're doing! This may break interrupt handler completely!
	jmp	NullInt.w

; ===========================================================================
; ---------------------------------------------------------------------------
; H-Blank handler for LZ water palette swap effect
; ---------------------------------------------------------------------------

HBlank_WaterSurface:
	movem.l	d0-d2/a0-a2,-(sp)
	move.w	#NullInt, HBlankSubW	; disable further interrupts
	
	lea	VDP_Data,a1
	move.w	#$8A00|$DF,4(a1)	; Reset HInt timing

	movea.l	($FFFFF610).w,a2
	move.w	(a2)+,d1
	move.b	($FFFFFE07).w,d0	; get water surface height for the screen transfer
	subi.b	#200,d0			; is H-int occuring below line 200?
	bcs.s	@transferColors		; if it is, branch
	sub.b	d0,d1
	bcs.s	@skipTransfer

	@transferColors:
		moveq	#0, d0
		move.w	(a2)+,d0
		lea	($FFFFFA80).w,a0
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,4(a1)		; write to CRAM at appropriate address

		swap	d1			; high word of D1 is used for buffering
		move.l	(a0)+, d2		; buffer colors to registers for faster transfer
		move.w	(a0)+, d1		; ''

		moveq	#$FFFFFFA0, d0
	@waitforit:
		cmp.b	9(a1), d0
		bhi.s	@waitforit

		move.l	d2, (a1)		; transfer two colors
		move.w	d1, (a1)		; transfer the third color

		swap	d1			; use D1 as counter again
		dbf	d1,@transferColors	; repeat for number of colors

@skipTransfer:
	movem.l	(sp)+,d0-d2/a0-a2
	rte

; ===========================================================================
; ---------------------------------------------------------------------------
; Emulator-optimized black bar routines
; ---------------------------------------------------------------------------

HBlank_Bars_EmulatorOptimized:
	move.l	#$81748720,VDP_Ctrl				; enable display, restore backdrop color
	move.w	BlackBars.SecondHCnt,VDP_Ctrl			; send $8Axx to VDP to set HInt counter for the second invocation
	move.w	#@ToBottom,HBlankSubW				; handle bottom next time
	rte
@ToBottom:
	move.w	#HBlank_Bars_Bottom,HBlankSubW
	rte
; ---------------------------------------------------------------------------

HBlank_Bars_PastQuarter_EmulatorOptimized:
	move.w	BlackBars.SecondHCnt,VDP_Ctrl			; send $8Axx to VDP to set HInt counter for the second invocation
	move.w	#@ToBottom,HBlankSubW				; handle bottom next time
	rte

@ToBottom:
	move.l	#$81748720,VDP_Ctrl				; enable display, restore backdrop color
	move.w	#HBlank_Bars_Bottom,HBlankSubW
	rte
; ---------------------------------------------------------------------------

HBlank_Bars_Bottom:
	move.l	#$81348701,VDP_Ctrl				; disable display + set backdrop color to black
	move.w	#$8A00|$DF,VDP_Ctrl				; set H-int timing to not occur this frame anymore
	move.w	#NullInt,HBlankSubW				; don't run any code during HInt
	rte

; ===========================================================================
; ---------------------------------------------------------------------------
; Emulator-optimized black bar routines
; ---------------------------------------------------------------------------

HBlank_Bars_HardwareOptimized:
	move.l	a0, -(sp)
	move.l	usp, a0
	move.w	#0, (a0)					; evil display enable hack
	ori.b	#0, d0						; what the fuck?
	move.w	#$8720, 4-$1C(a0)				; restore backdrop color
	move.w	BlackBars.SecondHCnt, 4-$1C(a0)			; send $8Axx to VDP to set HInt counter for the second invocation
	move.w	#@ToBottom, HBlankSubW				; handle bottom next time
	sf.b	VDPDebugPortSet
	assert.l a0, eq, #$C0001C
	move.l	(sp)+, a0
	rte
@ToBottom:
	move.w	#HBlank_Bars_Bottom,HBlankSubW
	rte
; ---------------------------------------------------------------------------

HBlank_Bars_PastQuarter_HardwareOptimized:
	move.w	BlackBars.SecondHCnt,VDP_Ctrl			; send $8Axx to VDP to set HInt counter for the second invocation
	move.w	#@ToBottom,HBlankSubW				; handle bottom next time
	rte

@ToBottom:
	move.l	a0, -(sp)
	move.l	usp, a0
	move.w	#0, (a0)					; evil display enable hack
	ori.b	#0, d0						; what the fuck?
	move.w	#$8720, 4-$1C(a0)				; restore backdrop color
	move.w	#HBlank_Bars_Bottom,HBlankSubW
	sf.b	VDPDebugPortSet
	move.l	(sp)+, a0
	rte
; ---------------------------------------------------------------------------
