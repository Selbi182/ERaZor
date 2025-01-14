; ---------------------------------------------------------------------------
; Enigma Decompression Algorithm
; For format explanation see http://info.sonicretro.org/Enigma_compression
; this one is optimised from the original, but with the more rom-intensive
; speedups locked behind some flags down below
; ---------------------------------------------------------------------------
; created by Malachi
; proper ASM68K support added by OrionNavattan
_Eni_Assembler:		equ 0	; ASM68K = 0, AS = 1
; ---------------------------------------------------------------------------
; INPUTS:
; d0 = starting art tile (added to each 8x8 before writing to destination)
; a0 = source address
; a1 = destination address
; TRASHES:
; d0,a0,a1
; STACK:
; - saved registers d1-d7/a2-a6 (13x4 bytes)
; - 4 bytes for one bsr (EniDec_GetInlineCopyVal and EniDec_ChkGetNextByte)
; - 2 bytes for word conversion
; ---------------------------------------------------------------------------
; equ instead of = for ASM68K compatibility
_Eni_CompatibilityMode:	equ 1
; if 1, stay compatible with the original Enigma
; (they saved d0 and a1, and made a0 point to the end of the file)
_Eni_EvenAligned:	equ 0
; if 1, allows Enigma compressed files to be at an odd numbered address
_Eni_RemoveJmpTable:	equ 0
; if 1, saves 22 cycles per loop (12 for SubE) at the cost of some rom space
_Eni_InlineBitStream:	equ 0
; if 1, inlines ChkGetNextByte in EniDec_Loop, for a speedup of 34 cycles per loop
; funny how this simple speedup greatly overshadows _Eni_RemoveJmpTable
; that one required infinitely more effort then this. oh well.

; macro explanations
; enidecpad16:
; - for RemoveJmpTable, routines needs to be aligned in 16($10) byte chunks
;   none of the routines can exceed that boundary, or the code won't work
;   the only exception to this is SubE; the last one
; enidec_checktileflags:
; - this was just repetitive
	if _Eni_Assembler=0
	pusho			; save current options
	opt l.			; use "." as local label symbol
enidecpad16: macro routine
	if (*-routine)>16	; if it exceeds 16, throw an error
	inform 3,"ADDR ERROR - EXCEED: routine exceeds 16 bytes! ($%h bytes)",*-routine
	elseif (*-routine)<16	; if it's below 16, pad it to 16
;	inform 0,"routine got padded by $%h bytes",*-routine   ; debug
	dcb.b 16-(*-routine),0
	endif
	endm
enidec_checktileflags: macro bit,setmode
	add.b	d1,d1
	bcc.s	.skip\@		; if that bit wasn't set, branch
	subq.w	#1,d6		; get next bit number
	btst	d6,d5		; is this tile flag bit set?
	beq.s	.skip\@		; if not, branch
	if setmode=0
	ori.w	#1<<bit,d3
	else
	addi.w	#1<<bit,d3
	endif
.skip\@:
	endm
	else
enidecpad16 macro routine
	if *-routine>16		; if it exceeds 16, throw an error
	fatal "ADDR ERROR - EXCEED: routine exceeds 16 bytes! ($\{*-routine} bytes)"
	elseif *-routine<16	; if it's below 16, pad it to 16
;	message "routine got padded by $\{16-(*-routine)} bytes"	; debug
	dc.b [16-(*-routine)]$69
	endif
	endm
enidec_checktileflags macro bit,setmode
	add.b	d1,d1
	bcc.s	.skip		; if that bit wasn't set, branch
	subq.w	#1,d6		; get next bit number
	btst	d6,d5		; is this tile flag bit set?
	beq.s	.skip		; if not, branch
	if setmode=0
	ori.w	#1<<bit,d3
	else
	addi.w	#1<<bit,d3
	endif
.skip
	endm
	endif
; ===========================================================================

EniDec:
	if _Eni_CompatibilityMode=0
	movem.l	d1-d7/a2-a6,-(sp)
	else
	movem.l	d0-d7/a1-a6,-(sp)
	endif

; compared to my original implementation, this prevents a race condition
; big thanks to DSK for finding this first
	subq.l	#2,sp		; allocate 2 bytes from stack
	lea	(sp),a6		; use those bytes (via a6) for conversions

; set subroutine loop address
; compared to a bra, jmp (aN) saves 2 cycles per-loop
	lea	EniDec_Loop(pc),a5

	movea.w	d0,a3		; store starting art tile

	move.b	(a0)+,d0
	ext.w	d0
	movea.w	d0,a2		; set initial bit amount for inline copy

	move.b	(a0)+,d0	; 000PCCHV ; set vram flag permits
	lsl.b	#3,d0		; PCCHV000 ; shift by 3
	move.w	d0,d2		; store in the high word of d2
	swap	d2
; set increment word
	if _Eni_EvenAligned=0
	move.w	(a0)+,d4
	else
	move.b	(a0)+,(a6)+
	move.b	(a0)+,(a6)+
	move.w	-(a6),d4
	endif
	add.w	a3,d4		; add starting art tile
; set static word
	if _Eni_EvenAligned=0
	move.w	(a0)+,d0
	else
	move.b	(a0)+,(a6)+
	move.b	(a0)+,(a6)+
	move.w	-(a6),d0
	endif
	add.w	a3,d0		; add starting art tile
	movea.w	d0,a4		; store in a4 (moves and adds are faster on dN.w, saves 4 cycles)
; set initial subroutine flag
	if _Eni_EvenAligned=0
	move.w	(a0)+,d5	
	else
	move.b	(a0)+,(a6)+
	move.b	(a0)+,(a6)+
	move.w	-(a6),d5
	endif
; set bit counter
	moveq	#16,d6		; 16 bits = 2 bytes
EniDec_Loop:
	moveq	#7,d0			; process 7 bits at a time
	move.w	d6,d7			; move d6 to d7
	sub.w	d0,d7			; subtract by 7 (convenient)
	move.w	d5,d1			; copy d5 into d1
	lsr.w	d7,d1			; right shift by value in d7

	move.w	d1,d2			; move d1 to d2
	andi.w	#%01110000,d1		; keep only 3 bits. Lower 4 are for d2, sign bit unused

	cmpi.w	#1<<6,d1		; is bit 6 set?
	bhs.s	.prcocess7bits		; if it is, branch
	moveq	#6,d0			; if not, process 6 bits instead of 7
	lsr.w	#1,d2			; bitfield now becomes TTSSSS instead of TTTSSSS
.prcocess7bits:
	if _Eni_InlineBitStream=0
	bsr.w	EniDec_ChkGetNextByte	; uses d0, doesn't touch d1 or d2
	else
;EniDec_ChkGetNextByte:
	sub.w	d0,d6		; subtract d0 from d6
	cmpi.w	#8,d6		; has it hit 8 or lower?
	bhi.s	.nonewbyte	; if not, branch
	addq.w	#8,d6		; 8 bits = 1 byte

	asl.w	#8,d5		; shift up by a byte
	move.b	(a0)+,d5	; store next byte in lower register byte
.nonewbyte:
	endif

	moveq	#$F,d3			; d3 is also used for SubE
	and.w	d3,d2			; keep only lower nybble
	if _Eni_RemoveJmpTable=0
; JmpTable addresses are word-sized.
; Due to its placement in rom, SubE just falls into itself
	lsr.w	#4-1,d1			; store upper nybble multiplied by 2 (max value = 7)
	jmp	EniDec_JmpTable(pc,d1.w)
	else
; all subroutines are offset by 16 bytes. Some of them barely fit, I'm quite proud of that
; SubE exceeds this, but it's the last one so it doesn't matter
	jmp	EniDec_Sub0(pc,d1.w)
	endif
; ---------------------------------------------------------------------------
EniDec_Sub0:
.loop:
	move.w	d4,(a1)+		; write to destination
	addq.w	#1,d4			; increment
	dbra	d2,.loop		; repeat
	jmp	(a5)		; EniDec_Loop
	if _Eni_RemoveJmpTable<>0
	enidecpad16 EniDec_Sub0
EniDec_Sub2:
.loop:
	move.w	d4,(a1)+		; write to destination
	addq.w	#1,d4			; increment
	dbra	d2,.loop		; repeat
	jmp	(a5)		; EniDec_Loop
	enidecpad16 EniDec_Sub2
	endif
; ---------------------------------------------------------------------------
EniDec_Sub4:
.loop:
	move.w	a4,(a1)+		; write to destination
	dbra	d2,.loop		; repeat
	jmp	(a5)		; EniDec_Loop
	if _Eni_RemoveJmpTable<>0
	enidecpad16 EniDec_Sub4
EniDec_Sub6:
.loop:
	move.w	a4,(a1)+		; write to destination
	dbra	d2,.loop		; repeat
	jmp	(a5)		; EniDec_Loop
	enidecpad16 EniDec_Sub6
	endif
; ---------------------------------------------------------------------------
EniDec_Sub8:
	bsr.s	EniDec_GetInlineCopyVal
.loop:
	move.w	d1,(a1)+
	dbra	d2,.loop
	jmp	(a5)		; EniDec_Loop
	if _Eni_RemoveJmpTable<>0
	enidecpad16 EniDec_Sub8
	endif
; ---------------------------------------------------------------------------
EniDec_SubA:
	bsr.s	EniDec_GetInlineCopyVal
.loop:
	move.w	d1,(a1)+
	addq.w	#1,d1
	dbra	d2,.loop
	jmp	(a5)		; EniDec_Loop
	if _Eni_RemoveJmpTable<>0
	enidecpad16 EniDec_SubA
	endif
; ---------------------------------------------------------------------------
EniDec_SubC:
	bsr.s	EniDec_GetInlineCopyVal
.loop:
	move.w	d1,(a1)+
	subq.w	#1,d1
	dbra	d2,.loop
	jmp	(a5)		; EniDec_Loop
	if _Eni_RemoveJmpTable<>0
	enidecpad16 EniDec_SubC
	else
; ---------------------------------------------------------------------------
EniDec_JmpTable:
	bra.s	EniDec_Sub0
	bra.s	EniDec_Sub0	; Sub2
	bra.s	EniDec_Sub4
	bra.s	EniDec_Sub4	; Sub6

	bra.s	EniDec_Sub8
	bra.s	EniDec_SubA
	bra.s	EniDec_SubC
	;bra.s	EniDec_SubE	; fall into SubE
	endif
; ---------------------------------------------------------------------------
; EniDec_SubE is truly a special case
EniDec_SubE:
	cmp.w	d3,d2			; d3 = $F ; is the loop set to 16?
	beq.s	EniDec_End		; if so, branch (signifies to end
.loop:
	bsr.s	EniDec_GetInlineCopyVal
	move.w	d1,(a1)+
	dbra	d2,.loop
	jmp	(a5)		; EniDec_Loop
EniDec_End:
	addq.l	#2,sp		; deallocate those 2 bytes

	if _Eni_CompatibilityMode=0
	movem.l	(sp)+,d1-d7/a2-a6
	else
; this code figures out where a0 should end
	subq.w	#1,a0
	cmpi.w	#16,d6			; were we going to start on a completely new byte?
	bne.s	.got_byte		; if not, branch
	subq.w	#1,a0
.got_byte:
	if _Eni_EvenAligned=0	; TODO: thorough testing
; Orion: small optimization, saves 8-10 cycles
	move.w	a0,d0
	andi.w	#1,d0
	adda.w	d0,a0			; ensure we're on an even byte
	endif

	movem.l	(sp)+,d0-d7/a1-a6
	endif
	rts
; ===========================================================================

EniDec_GetInlineCopyVal:
	move.w	a3,d3			; starting art tile
; original didn't need to use a high word
; this is a 4 cycle loss, though it's usually made up for everywhere else
	move.l	d2,d1			; get vram tile flags
	swap	d1			; (it's in the high word of d2)
	enidec_checktileflags 15,0
	enidec_checktileflags 14,1
	enidec_checktileflags 13,1
	enidec_checktileflags 12,0
	enidec_checktileflags 11,0

	move.w	d5,d1
	move.w	d6,d7			; get remaining bits
	sub.w	a2,d7			; subtract minimum bit number
	bhs.s	.got_enough		; if we're beyond that, branch
	move.w	d7,d6
	addi.w	#16,d6			; 16 bits = 2 bytes
	neg.w	d7			; calculate bit deficit
	lsl.w	d7,d1			; make space for this many bits
	move.b	(a0),d5			; get next byte
	rol.b	d7,d5			; make the upper X bits the lower X bits
	add.w	d7,d7
	and.w	.andvalues-2(pc,d7.w),d5; only keep X lower bits
	add.w	d5,d1			; compensate for the bit deficit
.got_field:
	move.w	a2,d0
	add.w	d0,d0
	and.w	.andvalues-2(pc,d0.w),d1; only keep as many bits as required
	add.w	d3,d1			; add starting art tile

;	move.b	(a0)+,d5	; 08 ; get current byte, move onto next byte
;	lsl.w	#8,d5		; 22 ; shift up by a byte
;	move.b	(a0)+,d5	; 08 ; store next byte in lower register byte
				; 38

; saves 4 cycles per branch, at the cost of saving and restoring a6, and setting up the register
; those caveats add around 24 cycles, but from my tests, it usually results in a speedup
	move.b	(a0)+,(a6)+	; 12 ; temporarily write into the destination
	move.b	(a0)+,(a6)+	; 12
	move.w	-(a6),d5	; 10 ; move result to d5, set destination back to correct spot
				; 34
	rts
; ---------------------------------------------------------------------------
.andvalues:
	dc.w	 1,    3,    7,   $F
	dc.w   $1F,  $3F,  $7F,  $FF
	dc.w  $1FF, $3FF, $7FF, $FFF
	dc.w $1FFF,$3FFF,$7FFF,$FFFF
; ---------------------------------------------------------------------------
.got_exact:
	moveq	#16,d6		; 16 bits = 2 bytes
	bra.s	.got_field
; ---------------------------------------------------------------------------
.got_enough:
	beq.s	.got_exact	; if the exact number of bits are leftover, branch
	lsr.w	d7,d1		; remove unneeded bits
	move.w	a2,d0
	add.w	d0,d0
	and.w	.andvalues-2(pc,d0.w),d1	; only keep as many bits as required
	add.w	d3,d1		; add starting art tile
	move.w	a2,d0		; store number of bits used up by inline copy
;	bra.s	EniDec_ChkGetNextByte	; move onto next byte
EniDec_ChkGetNextByte:
	sub.w	d0,d6		; subtract d0 from d6
	cmpi.w	#8,d6		; has it hit 8 or lower?
	bhi.s	.nonewbyte	; if not, branch
	addq.w	#8,d6		; 8 bits = 1 byte
; shift lowest byte to highest byte, and load a new value into low byte
	asl.w	#8,d5		; 22 ; shift up by a byte
	move.b	(a0)+,d5	; 08 ; store next byte in lower register byte
				; 30

;	move.b	d5,(a6)+	; 08
;	move.b	(a0)+,(a6)+	; 12
;	move.w	-(a6),d5	; 10
				; 30, sad.
.nonewbyte:
	rts
; ---------------------------------------------------------------------------
	if _Eni_Assembler=0
	popo			; restore previous options
	endif
