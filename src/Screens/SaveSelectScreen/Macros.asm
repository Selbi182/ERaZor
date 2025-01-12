
; ---------------------------------------------------------------------------
; Writes a given formatted string to the screen (using MD Debugger's IO)
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	flushFunctionOperand - function used to flush string (always `a4`)
;	string - formatted string (MD Debugger syntax)
;	bufferSize (optional) - limit max string len (minus null-terminator)
;	vramScreenPosOp (optional) - VRAM offset for start on-screen position
; ---------------------------------------------------------------------------

SaveSelect_WriteString:	macro	flushFunctionOperand, startX, startY, string, bufferSize
		if \bufferSize+0 > SaveSelect_StringBufferSize
			inform 3, "Max string length is too large!"
		elseif '\flushFunctionOperand'<>'a4'
			inform 3, "Only a4 is supported as input flush function operand"
		endif
		move.w	#SaveSelect_VRAM_FG+((startY)*$80)+((startX)*2), SaveSelect_StringScreenPos
		__FSTRING_GenerateArgumentsCode \string
		movem.l	a0-a2/d7, -(sp)
		lea	SaveSelect_StringBuffer, a0	; a0 = buffer
		lea	@str\@(pc), a1			; a1 = string
		lea	$10(sp), a2			; a2 = arguments
		if strlen('\bufferSize')
			moveq	#\bufferSize-1, d7		; d7 = buffer size - 1
		else
			moveq	#SaveSelect_StringBufferSize-1, d7	; d7 = buffer size - 1
		endif
		jsr	MDDBG__FormatString
		movem.l	(sp)+, a0-a2/d7
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
