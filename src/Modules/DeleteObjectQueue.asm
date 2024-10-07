
; ===============================================================
; ---------------------------------------------------------------
; Executes delete objects queue
; ---------------------------------------------------------------

DeleteQueue_Execute:
	movea.w	DeleteQueue_Ptr, a5
	clr.w	(a5)

	lea	DeleteQueue, a0

	move.w	(a0)+, d0
	beq.s	@done

	moveq	#0, d4
	moveq	#0, d5
	moveq	#0, d6
	moveq	#0, d7
	move.l	d4, a2
	move.l	d5, a3
	move.l	d6, a4
	move.l	d7, a5

	@loop:
		movea.w	d0, a1
		movem.l	d4-d7/a2-a5, (a1)		; clear $20 bytes
		movem.l	d4-d7/a2-a5, $20(a1)		; clear $20 bytes
		lea	$40(a1), a1
		move.w	(a0)+, d0
		bne.s	@loop

@done:
	rts


; ---------------------------------------------------------------
; Fallback for when delete queue is full
; ---------------------------------------------------------------

ClearObjectSlot:
	if def(__DEBUG__)
		move.l	a2, -(sp)
		lea	Sprites_Queue, a1
		moveq	#8-1, d1

		@test_layer:
			lea	(a1), a2
			move.w	(a2)+, d0
			beq.s	@next_layer

			@test_layer_slot:
				cmp.w	(a2), a0
				beq	IllegalDelete
				addq.w	#2, a2
				subq.w	#2, d0
				bne.s	@test_layer_slot

		@next_layer:
			lea	$80(a1), a1
			dbf	d1, @test_layer

		move.l	(sp)+, a2
	endif

	movea.l a0, a1
	moveq	#0, d1

ClearObjectSlot2:
	rept $40/4
		move.l	d1, (a1)+		; clear the object structure
	endr
	rts
	
; ---------------------------------------------------------------
	if def(__DEBUG__)
IllegalDelete:
	RaiseError "Deleting object queued for display (%<.w a0>=%<.b (a0)>)"
	endif

; ---------------------------------------------------------------
; Delete object function
; ---------------------------------------------------------------

DeleteObject:
	movea.w	DeleteQueue_Ptr, a5
	if def(__DEBUG__)
		cmpa.w	#DeleteQueue, a5
		blo.s	DeleteObject_Ptr_OutOfBounds
		cmpa.w	#DeleteQueue_End-2, a5
		beq.s	DeleteObject_QueueOverflow
		bhi.s	DeleteObject_Ptr_OutOfBounds
	else
		cmpa.w	#DeleteQueue_End-2, a5
		bhs.s	@delete_fallback
	endc

	move.w	a0, (a5)+
	move.w	a5, DeleteQueue_Ptr
	rts

; ---------------------------------------------------------------
@delete_fallback:
	move.b	#$8E, (a0)		; => "ClearObjectSlot", delete object later
	rts

; ---------------------------------------------------------------
DeleteObject2:
	movea.w	DeleteQueue_Ptr, a5

	if def(_DEBUG_)
		cmpa.w	#DeleteQueue, a5
		blo.s	DeleteObject_Ptr_OutOfBounds
		cmpa.w	#DeleteQueue_End-2, a5
		beq.s	DeleteObject_QueueOverflow
		bhi.s	DeleteObject_Ptr_OutOfBounds
	else
		cmpa.w	#DeleteQueue_End-2, a5
		bhs.s	@delete_fallback
	endc

	move.w	a1, (a5)+
	move.w	a5, DeleteQueue_Ptr
	rts

; ---------------------------------------------------------------
@delete_fallback:
	move.b	#$8E, (a1)		; => "ClearObjectSlot", delete object later
	rts

; ---------------------------------------------------------------
	if def(__DEBUG__)
DeleteObject_QueueOverflow:
	RaiseError "DeleteQueue overflow"

DeleteObject_Ptr_OutOfBounds:
	RaiseError "DeleteQueue_Ptr out of bounds (%<.w DeleteQueue_Ptr>)"
	endif
