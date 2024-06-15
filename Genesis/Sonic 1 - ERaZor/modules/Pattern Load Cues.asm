
			rsset	PLC_RAM
PLC_StreamHndl:		rs.l	1			; stream handler for the PLC
PLC_Pointer:		rs.l	1			; pointer to the ocurring entry in PLC list
PLC_Slot_1:		rs.l	1
PLC_Slot_2:		rs.l	1
PLC_Slot_3:		rs.l	1
PLC_VRAMAddr:		rs.w	1			; VRAM destination address
PLC_NumBlocks:		rs.w	1			; number of blocks to decompress
PLC_LastBlockSize:	rs.w	1			; size of the last block to decompress
PLC_ArtPtr:		rs.l	1			; pointer within compressed art

PLC_RAM_End:		equ	__RS

PLC_BlockSize = $1000	; 4 kb

; --------------------------------------------------------------
; Subroutine to execute PLC list
; --------------------------------------------------------------

PLC_Execute:
	movea.l	PLC_StreamHndl, a3
	jmp	(a3)

; --------------------------------------------------------------
PLC_ExecuteOnce:
	bsr	LoadPLC2

PLC_ExecuteOnce_Direct:
	VBlank_SetMusicOnly			; don't do VDP transfers in VBlank
	lea	VDP_Data, a6
	lea	4(a6), a5

	@loop:
		bsr.s	PLC_Execute
		jsr	ProcessDMAQueue
		tst.l	PLC_Pointer
		bne.s	@loop

	VBlank_UnsetMusicOnly
	rts

; --------------------------------------------------------------
PLC_ClearQueue:
	move.l	a0, -(sp)
	move.w	d0, -(sp)			; WARNING! High word of D0 is lost
	move.l	#PLC_ProcessQueue, PLC_StreamHndl
	moveq	#0, d0
	lea	PLC_Pointer, a0
	move.l	d0, (a0)+			; clear actual pointer
	move.l	d0, (a0)+			; clear slot 1
	move.l	d0, (a0)+			; clear slot 2
	move.l	d0, (a0)+			; clear slot 3
	move.w	(sp)+, d0
	move.l	(sp)+, a0
	
PLC_Return:
	rts

; --------------------------------------------------------------
PLC_LoadNextList:
	lea	PLC_Slot_1, a0
	lea	-4(a0), a1
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+
	move.l	(a0)+, (a1)+
	moveq	#0, d0
	move.l	d0, PLC_Slot_3		; clear out last slot
	;bra.s	PLC_ProcessQueue

; --------------------------------------------------------------
; PLC list execution flow
; --------------------------------------------------------------

PLC_ProcessQueue:
	move.l	PLC_Pointer, d0
	beq.s	PLC_Return
	movea.l	d0, a0
	move.l	(a0)+, d0				; get art offset
	bmi.s	PLC_LoadNextList			; if offset in the list is negative, branch

	; Initiate art decompression ...
	move.w	(a0)+, PLC_VRAMAddr			; remember start VRAM address
	move.l	a0, PLC_Pointer				; save pointer for when next entry should be fetched ...
	move.l	#PLC_DecompressArt, PLC_StreamHndl

	movea.l	d0, a0					; a0 = art pointer

	move.w	(a0)+, d2				; d2 = Kosinski+ moduled header
	move.w	d2, d3
	and.w	#$F000, d2
	rol.w	#4, d2					; d2 = number of blocks - 1
	and.w	#$0FFF, d3				; d3 = size of the last block
	move.w	d3, PLC_LastBlockSize			; save size
	seq.b	d3					; d3 = 0 if size if non-zero, -1 otherwise
	add.b	d3, d2					; reduce number of modules if the last module's size is zero ...

	move.w	d2, PLC_NumBlocks			; get number of blocks to decompress
	move.l	a0, PLC_ArtPtr

; --------------------------------------------------------------
PLC_DecompressArt:
	if def(__DEBUG__)
		movea.l	(sp), a1
		KDebug.WriteLine "PLC_DecompressArt(): block=%<.l PLC_ArtPtr sym>, pos=%<.l PLC_Pointer sym>, caller=%<.l a1 sym>"
	endif

	lea		Art_Buffer, a1			; a1 = decompression buffer
	move.l	PLC_ArtPtr, a0				; a0 = compressed art ptr
							; a1 = destination buffer
	jsr		KosPlusDec(pc)			; decompress block
	move.l	a0,	PLC_ArtPtr			; remember compressed art ptr

	assert.l	a1, ls, #Art_Buffer_End	; art buffer should be within bounds after decompression

	; Convert art in-memory, prepare DMA
	lea	Art_Buffer, a0				; a0 = source
							; a1 = end of buffer
	move.w	a1, d3
	sub.w	a0, d3					; d3 = size of decompressed block
	move.l	a0, d1					; d1 = source address
	andi.l	#$FFFFFF, d1
	move.w	PLC_VRAMAddr, d2			; d2 = destination VRAM address
	add.w	d3, PLC_VRAMAddr
	lsr.w	d3
	jsr	QueueDMATransfer			;

	subq.w	#1,	PLC_NumBlocks
	bpl.s	@return
	move.l	#PLC_ProcessQueue, PLC_StreamHndl	; fetch new entry next time

@return:
	rts

; --------------------------------------------------------------












; ==============================================================
; --------------------------------------------------------------
; Subroutine to add new entry in the list
; --------------------------------------------------------------

LoadPLC2:
	bsr	PLC_ClearQueue

LoadPLC:
	move.l	a1, -(sp)
	move.l	a2, -(sp)
	lea	ArtLoadCues, a1
	add.w	d0,d0
	add.w	(a1,d0.w), a1			; a1 = PLC list pointer
	lea	PLC_Pointer, a2

	; Find slot
	move.l	(a2)+, d0			; check actual pointer
	beq.s	@found
	move.l	(a2)+, d0			; check slot_1
	beq.s	@found
	move.l	(a2)+, d0			; check slot_2
	beq.s	@found
	move.l	(a2)+, d0			; check slot_3
	bne.s	@done

@found:
	move.l	a1, -(a2)			; save address in free slot

@done
	move.l	(sp)+, a2
	move.l	(sp)+, a1
	rts

; ==============================================================
LoadPLC_Direct:
	lea	PLC_Pointer, a2

	; Find slot
	move.l	(a2)+, d0			; check actual pointer
	beq.s	@found
	move.l	(a2)+, d0			; check slot_1
	beq.s	@found
	move.l	(a2)+, d0			; check slot_2
	beq.s	@found
	move.l	(a2)+, d0			; check slot_3
	bne.s	@done

@found:
	move.l	a1, -(a2)			; save address in free slot

@done:
	rts
