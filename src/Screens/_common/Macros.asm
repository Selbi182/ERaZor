
; ---------------------------------------------------------------------------
; Creates a dynamic object in A1
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	objPointerOp - operand to load object code pointer from
; ---------------------------------------------------------------------------
; EXAMPLES:
;	Screen_CreateObject #MySampleObject
;
;	lea	MySampleObject, a3
;	Screen_CreateObject a3
; ---------------------------------------------------------------------------

Screen_CreateObject: macro objPointerOp
	jsr	SingleObjLoad
	if def(__DEBUG__)
		beq.s	@ok\@
		RaiseError "Out of object slots"
	@ok\@:
	endif
	move.b	#$8D, (a1)
	move.l	\objPointerOp, obCodePtr(a1)
	endm

; ---------------------------------------------------------------------------
Screen_CreateChildObject: macro objPointerOp
	jsr	SingleObjLoad2
	if def(__DEBUG__)
		beq.s	@ok\@
		RaiseError "Out of object slots"
	@ok\@:
	endif
	move.b	#$8D, (a1)
	move.l	\objPointerOp, obCodePtr(a1)
	endm


; ---------------------------------------------------------------------------
; Resets pool allocator
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	poolPtrOp - operand representing buffer pool pointer
; ---------------------------------------------------------------------------

Screen_PoolReset:	macro ptrOp, poolStart, poolEnd
	__ScreenPoolEnd: = \poolEnd
	move.w	#\poolStart, \ptrOp
	endm

; ---------------------------------------------------------------------------
; Allocates given number of bytes on the pool (poor man's `malloc`)
; ---------------------------------------------------------------------------
; ARGUMENTS:
;	ptrOp - operand to load allocated memory to
;	poolPtrOp - operand representing buffer pool pointer
;	allocSizeOp - number of bytes to allocate
; ---------------------------------------------------------------------------

Screen_PoolAllocate:	macro	ptrOp, poolPtrOp, allocSizeOp
	move.w	\poolPtrOp, \ptrOp
	add.w	\allocSizeOp, \poolPtrOp
	assert.w \poolPtrOp, ls, #__ScreenPoolEnd
	endm
