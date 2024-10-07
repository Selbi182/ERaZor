; ---------------------------------------------------------------------------
; Ultra DMA Queue
;
; (c) flamewing
; ASM68K port by Vladikcomper
; ---------------------------------------------------------------------------

; ===========================================================================
; ---------------------------------------------------------------------------
; ROUTINE QueueDMATransfer
; Queues a DMA with parameters given in registers.
;
; Input:
; 	d1	Source address (in bytes, or in words
;		if AssumeSourceAddressInBytes is set to 0)
; 	d2	Destination address
; 	d3	Transfer length (in words)
; Output:
; 	d0,d1,d2,d3,a1	trashed
; ---------------------------------------------------------------------------

QueueDMATransfer:
	if UseVIntSafeDMA=1
		move.w	sr, -(sp)				; Save current interrupt mask
		ints_push					; Mask off interrupts
	endif ; UseVIntSafeDMA=1
	movea.w	DMAQueuePos, a1
	cmpa.w	#DMAQueuePos, a1
	beq.s	@done						; Return if there's no more room in the buffer

	if AssumeSourceAddressInBytes<>0
		lsr.l	#1, d1						; Source address is in words for the VDP registers
	endif
	if UseRAMSourceSafeDMA<>0
		bclr.l	#23, d1						; Make sure bit 23 is clear (68k->VDP DMA flag)
	endif	; UseRAMSourceSafeDMA
	movep.l	d1, DMAEntry.Source(a1)				; Write source address; the useless top byte will be overwritten later
	moveq	#0,d0						; We need a zero on d0

	if Use128kbSafeDMA<>0
		; Detect if transfer crosses 128KB boundary
		; Using sub+sub instead of move+add handles the following edge cases:
		; (1) d3.w == 0 => 128kB transfer
		;   (a) d1.w == 0 => no carry, don't split the DMA
		;   (b) d1.w != 0 => carry, need to split the DMA
		; (2) d3.w != 0
		;   (a) if there is carry on d1.w + d3.w
		;     (* ) if d1.w + d3.w == 0 => transfer comes entirely from current 128kB block, don't split the DMA
		;     (**) if d1.w + d3.w != 0 => need to split the DMA
		;   (b) if there is no carry on d1.w + d3.w => don't split the DMA
		; The reason this works is that carry on d1.w + d3.w means that
		; d1.w + d3.w >= $10000, whereas carry on (-d3.w) - (d1.w) means that
		; d1.w + d3.w > $10000.
		sub.w	d3,d0					; Using sub instead of move and add allows checking edge cases
		sub.w	d1,d0					; Does the transfer cross over to the next 128kB block?
		bcs.s	@doubletransfer				; Branch if yes
	endif	; Use128kbSafeDMA
	; It does not cross a 128kB boundary. So just finish writing it.
	movep.w	d3,DMAEntry.Size(a1)			; Write DMA length, overwriting useless top byte of source address

@finishxfer:
	; Command to specify destination address and begin DMA
	move.w	d2,d0											; Use the fact that top word of d0 is zero to avoid clearing on vdpCommReg
	vdpCommReg d0,cVRAM,cDMA,0			; Convert destination address to VDP DMA command
	lea	DMAEntry.Command(a1), a1		; Seek to correct RAM address to store VDP DMA command
	move.l	d0, (a1)+										; Write VDP DMA command for destination address
	move.w	a1, DMAQueuePos				; Write next queue slot

@done:
	if UseVIntSafeDMA=1
		ints_pop
	endif ;UseVIntSafeDMA=1
	rts
; ---------------------------------------------------------------------------
	if Use128kbSafeDMA<>0
@doubletransfer:
		; We need to split the DMA into two parts, since it crosses a 128kB block
		add.w	d3,d0										; Set d0 to the number of words until end of current 128kB block
		movep.w	d0,DMAEntry.Size(a1)			; Write DMA length of first part, overwriting useless top byte of source addres

		cmpa.w	#DMAQueuePos-DMAEntry.len,a1		; Does the queue have enough space for both parts?
		beq.s	@finishxfer									; Branch if not

		; Get second transfer's source, destination, and length
		sub.w	d0,d3					; Set d3 to the number of words remaining
		add.l	d0,d1					; Offset the source address of the second part by the length of the first part
		add.w	d0,d0					; Convert to number of bytes
		add.w	d2,d0					; Set d0 to the VRAM destination of the second part

		; If we know top word of d2 is clear, the following vdpCommReg can be set to not
		; clear it. There is, unfortunately, no faster way to clear it than this.
		vdpCommReg d2,cVRAM,cDMA,1			; Convert destination address of first part to VDP DMA command
		move.l	d2, DMAEntry.Command(a1)		; Write VDP DMA command for destination address of first part

		; Do second transfer
		movep.l	d1, DMAEntry.len+DMAEntry.Source(a1)	; Write source address of second part; useless top byte will be overwritten later
		movep.w	d3, DMAEntry.len+DMAEntry.Size(a1)	; Write DMA length of second part, overwriting useless top byte of source addres

		; Command to specify destination address and begin DMA
		vdpCommReg d0,cVRAM,cDMA,0			; Convert destination address to VDP DMA command; we know top half of d0 is zero
		lea	DMAEntry.len+DMAEntry.Command(a1),a1	; Seek to correct RAM address to store VDP DMA command of second part
		move.l	d0, (a1)+				; Write VDP DMA command for destination address of second part

		move.w	a1,DMAQueuePos				; Write next queue slot
		if UseVIntSafeDMA=1
			ints_pop
		endif ;UseVIntSafeDMA=1
		rts
	endif	; Use128kbSafeDMA

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine for issuing all VDP commands that were queued
; (by earlier calls to QueueDMATransfer)
; Resets the queue when it's done
; ---------------------------------------------------------------------------

ProcessDMAQueue:
	movea.w	DMAQueuePos, a1
	jmp	@jump_table-DMAQueue(a1)
; ---------------------------------------------------------------------------
@jump_table:
	rts
	rept 6
		illegal					; Just in case
	endr
; ---------------------------------------------------------------------------
	@c: = 1
	rept QueueSlotCount
		lea	VDP_Ctrl, a5
		lea	DMAQueue, a1
		if @c<>QueueSlotCount
			bra.w	@jump0 - @c*8
		endif
		@c: = @c + 1
	endr
; ---------------------------------------------------------------------------
	rept QueueSlotCount
		move.l	(a1)+,(a5)			; Transfer length
		move.l	(a1)+,(a5)			; Source address high
		move.l	(a1)+,(a5)			; Source address low + destination high
		move.w	(a1)+,(a5)			; Destination low, trigger DMA
	endr

@jump0:
	ResetDMAQueue
	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine for initializing the DMA queue.
; ---------------------------------------------------------------------------

InitDMAQueue:
	lea	DMAQueue, a0
	moveq	#-$6C,d0				; fast-store $94 (sign-extended) in d0
	move.l	#$93979695,d1

	@c: = 0
	rept QueueSlotCount
		move.b	d0, @c+DMAEntry.Reg94(a0)
		movep.l	d1, @c+DMAEntry.Reg93(a0)
		@c: = @c + DMAEntry.len
	endr

	ResetDMAQueue
	rts
