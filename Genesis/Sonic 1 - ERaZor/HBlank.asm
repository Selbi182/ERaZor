
; ---------------------------------------------------------------------------
; H-Blanking routine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

BlackBarHeight = 32
BlackBarHeight_Cinematic = 56
BlackBarGrow = 2
BarKillHeight = $E0/2

; PalToCRAM:
HBlank:
		cmpi.b	#1,($FFFFFE10).w	; are we in LZ?
		beq.w	@hblank_original	; if yes, skip bars (they cause issues with the water thingy)
		tst.b	(ScreenCropCurrent).w	; are cropped borders enabled?
		bgt.s	@blackbars		; if yes, branch
	
@skipblackbars:
		move.l	d0,-(sp)		; backup d0
		display_enable			; otherwise, make sure display is enabled
		move.l	(sp)+,d0		; restore d0
		move.w	#$8A00|$DF,($FFFFF624).w ; set H-int timing to not occur this frame anymore
		move.w	#$8720,($C00004).l	; reset background color
		bra.w	@hblank_original	; go to original H-Blank code
; ---------------------------------------------------------------------------
		
@blackbars:
		movem.l	d0-d2,-(sp)		; backup d0 and d1
		
		move.b	($FFFFF64F).w,d1	; get flag counter
		move.b	(ScreenCropCurrent).w,d2 ; get current bar height
		cmpi.b	#BarKillHeight,d2	; are we at the bar kill height?
		blo.s	@makebars		; if not, branch. otherwise, set the display to not render anymore to avoid flickers
		move.w	#$8701,($C00004).l	; set background color to black
		display_disable			; disable display
		bra.w	@hblank_continue
		
@makebars:
		btst	#7,d1			; is first flag set?
		beq.s	@checksecondflag	; if not, branch
		bclr	#7,d1			; clear first flag
		
		moveq	#0,d0			; clear d0
		move.b	#224-1,d0		; set maximum scan line count (minus 1)
		sub.b	d2,d0			; subtract current height once...
		sub.b	d2,d0 			; ...and twice
		
		ori.w	#$8A00,d0		; set as H-int counter instruction
		move.w	d0,($C00004).l		; send to VDP

		cmpi.b	#$C0/2,d2		; if bars are big enough, do V-Blank now...
		bhs.w	@hblank_continue	; ...to avoid flickers
		bra.w	@hblank_earlyexit	; exit without running any additional V-blank stuff

@checksecondflag:
		btst	#6,d1			; is second flag set?
		beq.s	@checkthirdflag		; if not, branch
		bclr	#6,d1			; clear second flag
		move.w	#$8A00|$DF,($C00004).l	; set H-int timing to not occur this frame anymore
		move.w	#$8720,($C00004).l	; reset background color
		display_enable			; enable display
		bra.w	@hblank_continue	; exit AND run any additional V-blank stuff

@checkthirdflag:
		btst	#5,d1			; is third flag set?
		beq.s	@hblank_continue	; if not, we're entirely done with the black bar stuff. exit
		bclr	#5,d1			; clear third flag
		move.w	#$8701,($C00004).l	; set background color to black
		display_disable			; disable display
		; exit without running any additional V-blank stuff

@hblank_earlyexit:
		move.b	d1,($FFFFF64F).w	; write updated flags
		movem.l	(sp)+,d0-d2		; restore d0
		rte				; exit H-int

@hblank_continue:
		move.b	d1,($FFFFF64F).w	; write updated flags
		movem.l	(sp)+,d0-d2		; restore d0 and d1

; LZ water effects
; Source: https://sonicresearch.org/community/index.php?threads/removing-the-water-surface-object-in-sonic-1.5975/

@hblank_original:
		tst.w	($FFFFF644).w
		beq.w	locret_119C
		clr.w	($FFFFF644).w
		movem.l	d0-d1/a0-a2,-(sp)

		cmpi.b	#1,($FFFFFE10).w	; are we in LZ?
		bne.w	@skipTransfer2		; if not, branch
		
	;	bra.w	@skipTransfer2		; disabled for now cause it sucks

	;	move.l	d0,-(sp)		; backup d0
	;	display_enable			; otherwise, make sure display is enabled
	;	move.l	(sp)+,d0		; restore d0
		lea	($C00000).l,a1
	;	move.w	#$8A00|$DF,($FFFFF624).w ; set H-int timing to not occur this frame anymore
	;	move.w	#$8A00|$DF,4(a1)		; Reset HInt timing (TODO: this needs to dynamically adjusted for the water surface in LZ in combination with the black bars)
		move.w	#$100,($A11100).l	; stop the Z80
@z80loop:	btst	#0,($A11100).l
		bne.s	@z80loop		; loop until it says it's stopped

		movea.l	($FFFFF610).w,a2
		moveq	#$F,d0			; adjust to push artifacts off screen
@loop:		dbf	d0,@loop		; waste a few cycles here

		move.w	(a2)+,d1
		move.b	($FFFFFE07).w,d0
		subi.b	#200,d0			; is H-int occuring below line 200?
		bcs.s	@transferColors		; if it is, branch
		sub.b	d0,d1
		bcs.s	@skipTransfer
		
@transferColors:
		move.w	(a2)+,d0
		lea	($FFFFFA80).w,a0
		andi.w	#-2,d0			; WEIRD hotfix because otherwise we get an odd addressing error
		adda.w	d0,a0
		addi.w	#$C000,d0
		swap	d0
		move.l	d0,4(a1)		; write to CRAM at appropriate address
		move.l	(a0)+,(a1)		; transfer two colors
		move.w	(a0)+,(a1)		; transfer the third color
		nop
		nop
		moveq	#$24,d0

@wasteSomeCycles:
		dbf    d0,@wasteSomeCycles
		dbf    d1,@transferColors	; repeat for number of colors

@skipTransfer:
		move.w	#0,($A11100).l		; start the Z80
@skipTransfer2:
		movem.l	(sp)+,d0-d1/a0-a2

locret_119C:
		rte	
; End of function HBlank

; ---------------------------------------------------------------------------
HBlank_Bars:
		move.l	#$81748720, VDP_Ctrl				; enable display, restore backdrop color
		move.w	BlackBars.SecondHCnt, VDP_Ctrl			; send $8Axx to VDP to set HInt counter for the second invocation
		move.w	#@ToBottom, HBlankSubW				; handle bottom next time
		rte

; ---------------------------------------------------------------------------
@ToBottom:
		move.w	#HBlank_Bars_Bottom, HBlankSubW
		rte

; ---------------------------------------------------------------------------
HBlank_Bars_Bottom:
		move.l	#$81348701, VDP_Ctrl				; disable display + set backdrop color to black
		move.w	#$8A00|$DF, VDP_Ctrl				; set H-int timing to not occur this frame anymore
		move.w	#HBlank_Bars, HBlankSubW			; restore the original routine for next frame
		rte
