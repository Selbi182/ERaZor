
; ---------------------------------------------------------------------------
; Macro to pipe formatted string through a given function
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	flushFunctionOp - function used to flush string (always `a4`)
;	string - formatted string (MD Debugger syntax)
;	bufferSize (optional) - limit max string len (minus null-terminator)
;	vramScreenPosOp (options) - VRAM offset for start on-screen position
; ---------------------------------------------------------------------------

SoundTest_DrawFormattedString:	macro	flushFunctionOp, string, bufferSize, vramScreenPosOp
		if strlen('\vramScreenPosOp')
			move.w	\vramScreenPosOp, SoundTest_CurrentTextStartScreenPos
		endif
		if \bufferSize+0 > SoundTest_StringBufferSize
			inform 3, "Max string length is too large!"
		elseif '\flushFunctionOp'<>'a4'
			inform 3, "Only a4 is supported as input flush function operand"
		endif
		__FSTRING_GenerateArgumentsCode \string
		lea	SoundTest_StringBuffer, a0	; a0 = buffer
		lea	@str\@(pc), a1			; a1 = string
		lea	(sp), a2			; a2 = arguments
		if strlen('\bufferSize')
			moveq	#\bufferSize-1, d7		; d7 = buffer size - 1
		else
			moveq	#SoundTest_StringBufferSize-1, d7	; d7 = buffer size - 1
		endif
		jsr	MDDBG__FormatString
		if (__sp>8)
			lea	__sp(sp), sp
		elseif (__sp>0)
			addq.w	#__sp, sp
		endif
		bra	@instr_end\@
	@str\@:	__FSTRING_GenerateDecodedString \string
		even
	@instr_end\@:
	endm

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
