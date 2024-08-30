
; ---------------------------------------------------------------------------
; Macro to pipe formatted string through a given function
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	flushFunctionOperand - function used to flush string (always `a4`)
;	string - formatted string (MD Debugger syntax)
;	bufferSize (optional) - limit max string len (minus null-terminator)
; ---------------------------------------------------------------------------

Options_PipeString:	macro	flushFunctionOperand, string, bufferSize
		if \bufferSize+0 > Options_StringBufferSize
			inform 3, "Max string length is too large!"
		elseif '\flushFunctionOperand'<>'a4'
			inform 3, "Only a4 is supported as input flush function operand"
		endif
		__FSTRING_GenerateArgumentsCode \string
		lea	Options_StringBuffer, a0	; a0 = buffer
		lea	@str\@(pc), a1			; a1 = string
		lea	(sp), a2			; a2 = arguments
		if strlen('\bufferSize')
			moveq	#\bufferSize-1, d7		; d7 = buffer size - 1
		else
			moveq	#Options_StringBufferSize-1, d7	; d7 = buffer size - 1
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
; Resets (flushes) VRAM buffer pool pointer
; ---------------------------------------------------------------------------

Options_ResetVRAMBufferPool:	macros
	move.w	#Art_Buffer, Options_VRAMBufferPoolPtr

; ---------------------------------------------------------------------------
; Allocates given number of bytes on VRAM buffer pool (poor man's `malloc`)
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	ptrOperand - operand to load allocated memory to
;	allocSizeOperand - number of bytes to allocate
; ---------------------------------------------------------------------------

Options_AllocateInVRAMBufferPool:	macro	ptrOperand, allocSizeOperand
	move.w	Options_VRAMBufferPoolPtr, \ptrOperand
	add.w	\allocSizeOperand, Options_VRAMBufferPoolPtr
	assert.w Options_VRAMBufferPoolPtr, ls, #Art_Buffer_End
	endm

; ---------------------------------------------------------------------------
; Loads menu item data by id
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	idReg - (IN) register that holds menu item id (zero-based)
;	ptrReg - (OUT) register that will hold menu data pointer
; ---------------------------------------------------------------------------

Options_GetMenuItem:	macro	idReg, ptrReg
	mulu.w	#10, \idReg
	lea	Options_MenuData(pc), \ptrReg
	adda.w	\idReg, \ptrReg
	endm
