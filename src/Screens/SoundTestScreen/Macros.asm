
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
