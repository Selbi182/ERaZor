
	include	"Screens/SoundTestScreen/Macros.asm"

; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------

SoundTest_VBlank:
	movem.l	d0-a6, -(sp)
	tst.b	VBlankRoutine
	beq	@LagFrame
	sf.b	VBlankRoutine

	jsr	ReadJoypads

	; Transfer palette
	move.l	#$94009340, (a5)
	move.l	#$96FD9580, (a5)
	move.w	#$977F, (a5)
	move.w	#$C000, (a5)
	move.w	#$80, -(sp)
	move.w	(sp)+, (a5)

	; Transfer sprites
	move.l	#$94019340, (a5)
	move.l	#$96FC9500, (a5)
	move.w	#$977F, (a5)
	move.w	#$7800, (a5)
	move.w	#$83, -(sp)
	move.w	(sp)+, (a5)

	; Transfer Vscroll/HScroll
	movea.w	SoundTest_ActiveVScrollBuffer, a0
	move.l	#$40000010, (a5)
	move.l	(a0)+, -4(a5)
	move.w	a0, SoundTest_ActiveVScrollBufferPos
	move.w	#SoundTest_HBlank, HBlankSubW
	move.w	#$8014, (a5)				; enable HInts
	move.w	#$8A00, (a5)

	vram	$FC00, (a5)
	move.w	#(320-SoundTest_Visualizer_Width*8)/2, -4(a5)	; HScroll
	move.w	#(320-SoundTest_Visualizer_Width*8)/2, -4(a5)	; HScroll

	; Transfer pixel buffer if requested
	move.w	SoundTest_VisualizerBufferPtr, d0	; do we have a pixel buffer to flush?
	beq.s	@0					; if not, branch
	movea.w	d0, a0
	move.l	SoundTest_VisualizerBufferDest, d0
	moveq	#0, d1
	move.w	d1, SoundTest_VisualizerBufferPtr
	move.l	d1, SoundTest_VisualizerBufferDest
	jsr	SoundTest_Visualizer_TransferPixelBufferToVRAM

@0:	SoundTest_ResetVRAMBufferPool

	; Note that music is only updated during non-lag frames to keep piano consistent
	jsr	UpdateSoundDriver

@Quit:
	; TODO: Action
	movem.l	(sp)+, d0-a6
	rte

@LagFrame:
	KDebug.WriteLine "LAG!"
	bra	@Quit
