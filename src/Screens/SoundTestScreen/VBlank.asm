
	include	"Screens/SoundTestScreen/Macros.asm"

; ---------------------------------------------------------------------------
; Sound Test screen VBlank handler
; ---------------------------------------------------------------------------

SoundTest_VBlank:
	movem.l	d0-a6, -(sp)
	tst.b	VBlankRoutine
	beq	@LagFrame
	sf.b	VBlankRoutine

	jsr	ReadJoypads

	lea	VDP_Ctrl, a5
	move.w	#$8F02, (a5)				; restore auto-increment

	btst	#6,($FFFFFFF8).w			; are we PAL?
	beq.s	@not_PAL				; if not, branch
	move.w	#$700,d0
	dbf	d0, *					; waste ~$700 * 10 cycles on PAL consoles
@not_PAL:

	; Transfer sprites
	move.l	#$94019340, (a5)
	move.l	#$96FC9500, (a5)
	move.w	#$977F, (a5)
	move.w	#$7800, (a5)
	move.w	#$83, -(sp)
	move.w	(sp)+, (a5)

	; Transfer HScroll buffer
	@dma_source: = SoundTest_HScrollBuffer
	@dma_dest: = $FC00+2
	@dma_len: = 28*2

	move.w	#$8F20, (a5)		; set auto-increment for per-tile HScroll-buffer
	move.l	#$94000000+((((@dma_len)>>1)&$FF00)<<8)+$9300+(((@dma_len)>>1)&$FF),(a5)
	move.l	#$96000000+((((@dma_source)>>1)&$FF00)<<8)+$9500+(((@dma_source)>>1)&$FF), (a5)
	move.w	#$9700+(((((@dma_source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#$4000+((@dma_dest)&$3FFF),(a5)
	move.w	#$80+(((@dma_dest)&$C000)>>14), -(sp)
	move.w	(sp)+, (a5)
	move.w	#$8F02, (a5)		; restore auto-increment

	; Transfer palette
	move.l	#$94009340, (a5)
	move.l	#$96FD9580, (a5)
	move.w	#$977F, (a5)
	move.w	#$C000, (a5)
	move.w	#$80, -(sp)
	move.w	(sp)+, (a5)

	; Transfer standard DMA queue
	jsr	ProcessDMAQueue

	; Transfer pixel buffer if requested
	move.w	SoundTest_VisualizerBufferPtr, d0	; do we have a pixel buffer to flush?
	beq.s	@0					; if not, branch
	movea.w	d0, a0
	move.l	SoundTest_VisualizerBufferDest, d0
	moveq	#0, d1
	move.w	d1, SoundTest_VisualizerBufferPtr
	move.l	d1, SoundTest_VisualizerBufferDest
	jsr	SoundTest_Visualizer_TransferPixelBufferToVRAM

@0:	Screen_PoolReset SoundTest_VRAMBufferPoolPtr, Art_Buffer, Art_Buffer_End

	; Transfer Vscroll/HScroll
	move.l	SoundTest_VScrollBufferPtrSwapper, d0	; perform a buffer swap
	swap	d0					; ''
	move.l	d0, SoundTest_VScrollBufferPtrSwapper	; ''

	bsr	SoundTest_VBlank_SetupHBlank

	if def(__BENCHMARK__)=0
		; Note that music is only updated during non-lag frames to keep piano consistent
		jsr	UpdateSoundDriver
	endif

@Quit:
	movem.l	(sp)+, d0-a6
	rte

@LagFrame:
	; WARNING! DO NOT run Sound driver in lag frames, otherwise piano roll notes may desync
	bsr	SoundTest_VBlank_SetupHBlank
	bra	@Quit

; ---------------------------------------------------------------------------
; This should be called at the end of VBlank, but before Sound driver update
; ---------------------------------------------------------------------------

SoundTest_VBlank_SetupHBlank:
	lea	VDP_Ctrl, a5

	move.w	#$8F02, (a5)				; restore auto-increment
	movea.w	SoundTest_ActiveVScrollBufferPtr, a0
	move.l	(a0), d0				; d0 => HIGH: Plane B position, LOW: ignored
	move.w	225*2(a0), d0				; d0 => LOW: Plane A position
	move.l	#$40000010, (a5)
	move.l	d0, -4(a5)				; send initial scroll values for both planes

	move.w	#SoundTest_HBlank_Buffer1, HBlankSubW	; use HBlank for buffer 1
	cmpa.w	#SoundTest_VScrollBuffer1, a0		; are we using buffer 1?
	beq.s	@hblank_sub_ok				; if yes, branch
	move.w	#SoundTest_HBlank_Buffer2, HBlankSubW	; use HBlank for buffer 2
@hblank_sub_ok:

	move.l	#$80148A00, (a5)			; enable HInts, per-line horizontal interrupts
	move.w	#$8F00, (a5)				; disable auto-increment
	move.l	#$40000010, (a5)			; setup VSRAM write position for HInt

	rts
