
; ---------------------------------------------------------------------------
; Creates a dynamic object
; ---------------------------------------------------------------------------

SoundTest_CreateObject: macro objPointerOp
	jsr	SingleObjLoad
	if def(__DEBUG__)
		beq.s	@ok\@
		RaiseError "Out of object slots"
	@ok\@:
	endif
	move.b	#$8D, (a1)
	move.l	\objPointerOp, $3C(a1)
	endm

; ---------------------------------------------------------------------------
SoundTest_CreateChildObject: macro objPointerOp
	jsr	SingleObjLoad2
	if def(__DEBUG__)
		beq.s	@ok\@
		RaiseError "Out of object slots"
	@ok\@:
	endif
	move.b	#$8D, (a1)
	move.l	\objPointerOp, $3C(a1)
	endm


; ---------------------------------------------------------------------------
; Resets (flushes) VRAM buffer pool pointer
; ---------------------------------------------------------------------------

SoundTest_ResetVRAMBufferPool:	macros
	move.w	#Art_Buffer, SoundTest_VRAMBufferPoolPtr

; ---------------------------------------------------------------------------
; Allocates given number of bytes on VRAM buffer pool (poor man's `malloc`)
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	ptrOperand - operand to load allocated memory to
;	allocSizeOperand - number of bytes to allocate
; ---------------------------------------------------------------------------

SoundTest_AllocateInVRAMBufferPool:	macro	ptrOperand, allocSizeOperand
	move.w	SoundTest_VRAMBufferPoolPtr, \ptrOperand
	add.w	\allocSizeOperand, SoundTest_VRAMBufferPoolPtr
	assert.w SoundTest_VRAMBufferPoolPtr, ls, #Art_Buffer_End
	endm

; ---------------------------------------------------------------------------
; Resets (flushes) VRAM buffer pool pointer
; ---------------------------------------------------------------------------

SoundTest_InitWriteRequests:	macros
	move.w	#SoundTest_VisualizerWriteRequests, SoundTest_VisualizerWriteRequestsPos

; ---------------------------------------------------------------------------
; Allocates given number of bytes on VRAM buffer pool (poor man's `malloc`)
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	ptrOperand - operand to load allocated memory to
;	allocSizeOperand - number of bytes to allocate
; ---------------------------------------------------------------------------

SoundTest_AddWriteRequest:	macro	xposOperand, pixelDataOperand, scratchAReg
	movea.w	SoundTest_VisualizerWriteRequestsPos, \scratchAReg
	if def(__DEBUG__)
		assert.w \scratchAReg, lo, #SoundTest_VisualizerWriteRequests_End
	else
		cmpa.w	#SoundTest_VisualizerWriteRequests_End, \scratchAReg
		bhs.s	@skip\@
	endif
	move.w	\xposOperand, (\scratchAReg)+
	move.l	\pixelDataOperand, (\scratchAReg)+
	move.w	\scratchAReg, SoundTest_VisualizerWriteRequestsPos
@skip\@:
	endm

; ---------------------------------------------------------------------------
SoundTest_FinalizeWriteRequests:	macro	scratchAReg
	movea.w	SoundTest_VisualizerWriteRequestsPos, \scratchAReg
	move.w	#-2, (\scratchAReg)
	endm
