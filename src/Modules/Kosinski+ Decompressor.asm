
; ===========================================================================
; ---------------------------------------------------------------------------
; Decompress moduled Kosinski archive to VRAM
; ---------------------------------------------------------------------------
; WARNING! It doesn't repspect previously allocated art on the art buffer!
; ---------------------------------------------------------------------------
; INPUT:
;	a0	Source address
; ---------------------------------------------------------------------------

KosPlusMDec_VRAM:
	; Interrupts should be disabled
	if def(__DEBUG__)
		tst.b	VBlank_MusicOnly
		bne.s	@interrupts_ok
		move.w	sr, d5
		_assert.w d5, hs, #$2600
	@interrupts_ok:
	endif

	move.w	(a0)+, d5			; d5 = Uncompressed size
	move.w	d5, d6
	and.w	#$F000, d6
	rol.w	#4, d6				; d6 = Number of 4kb blocks - 1
	and.w	#$0FFF, d5			; is the size multiple of 4kb?
	seq.b	d5				; d5 = 0 if not, -1 otherwise
	add.b	d5, d6				; reduce number of modules if size is multiple of 4kb

	@decompress_module:
		move.w	d6, -(sp)

		lea	Art_Buffer, a1
		jsr	KosPlusDec(pc)

		assert.l a1, ls, #Art_Buffer_End	; buffer shouldn't overflow

		move.l	a0, -(sp)
		lea	Art_Buffer, a0			; a0 = transfer source
		move.w	a1, d1
		sub.w	a0, d1				; d1 = bytes to transfer
		lsr.w	#5, d1				; d1 = tiles to transfer
		subq.w	#1, d1
		lea	VDP_Data, a6

		@transfer_loop:				; WARNING! Slow
			rept	$20/4
				move.l	(a0)+, (a6)
			endr
			dbf	d1, @transfer_loop

		move.l	(sp)+, a0
		move.w	(sp)+, d6
		dbf	d6, @decompress_module
		rts

; ---------------------------------------------------------------------------
	if def(_DEBUG_)
@buffer_out_of_bounds:
		RaiseError	"Art buffer is out of bounds%<endl>BufferPtr: %<pal2>%<.l a1>%<endl,pal1>ModulesIterator: %<pal2>%<.w d6>"
	endc


; ---------------------------------------------------------------------------
; New format based on Kosinski. It changes several design decisions to allow
; a faster decompressor without loss of compression ratio.
; Created originally by Flamewing and vladikcomper (by discussions on IRC),
; further improvements by Clownacy.
; ---------------------------------------------------------------------------
; Permission to use, copy, modify, and/or distribute this software for any
; purpose with or without fee is hereby granted.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
; OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
; ---------------------------------------------------------------------------
; FUNCTION:
; 	KosPlusDec
;
; DESCRIPTION
; 	Kosinski+ Decompressor
;
; INPUT:
; 	a0	Source address
; 	a1	Destination address
; ---------------------------------------------------------------------------
_KosPlus_LoopUnroll = 3

_KosPlus_ReadBit macro
	dbf		d2, @skip\@
	moveq	#7, d2						; We have 8 new bits, but will use one up below.
	move.b	(a0)+, d0					; Get desc field low-byte.
@skip\@:
	add.b	d0, d0						; Get a bit from the bitstream.
	endm
; ===========================================================================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||
; ---------------------------------------------------------------------------
KosPlusDec:
	moveq	#(1<<_KosPlus_LoopUnroll)-1, d7
	moveq	#0, d2						; Flag as having no bits left.
	bra.s	@FetchNewCode
; ---------------------------------------------------------------------------
@FetchCodeLoop:
	; Code 1 (Uncompressed byte).
	move.b	(a0)+, (a1)+

@FetchNewCode:
	_KosPlus_ReadBit
	bcs.s	@FetchCodeLoop					; If code = 1, branch.

	; Codes 00 and 01.
	moveq	#-1,d5
	_KosPlus_ReadBit
	bcs.s	@Code_01

	; Code 00 (Dictionary ref. short).
	move.b	(a0)+, d5					; d5 = displacement.
	lea	(a1, d5), a5
	; Always copy at least two bytes.
	move.b	(a5)+, (a1)+
	move.b	(a5)+, (a1)+
	_KosPlus_ReadBit
	bcc.s	@Copy_01
	move.b	(a5)+, (a1)+
	move.b	(a5)+, (a1)+

@Copy_01:
	_KosPlus_ReadBit
	bcc.s	@FetchNewCode
	move.b	(a5)+, (a1)+
	bra.s	@FetchNewCode
; ---------------------------------------------------------------------------
@Code_01:
	moveq	#0,d4						; d4 will contain copy count.
	; Code 01 (Dictionary ref. long / special).
	move.b	(a0)+, d4					; d4 = %HHHHHCCC.
	move.b	d4, d5						; d5 = %11111111 HHHHHCCC.
	lsl.w	#5, d5						; d5 = %111HHHHH CCC00000.
	move.b	(a0)+, d5					; d5 = %111HHHHH LLLLLLLL.
	if (_KosPlus_LoopUnroll=3)
		and.w	d7, d4					; d4 = %00000CCC.
	else
		andi.w	#7, d4
	endc
	bne.s	@StreamCopy					; if CCC=0, branch.

	; special mode (extended counter)
	move.b	(a0)+, d4					; Read cnt
	beq.s	@Quit						; If cnt=0, quit decompression.

	lea		(a1, d5), a5
	move.w	d4, d6
	not.w	d6
	and.w	d7, d6
	add.w	d6, d6
	lsr.w	#_KosPlus_LoopUnroll, d4
	jmp		@largecopy(pc, d6.w)
; ---------------------------------------------------------------------------
@StreamCopy:
	lea		(a1, d5), a5
	move.b	(a5)+, (a1)+					; Do 1 extra copy (to compensate +1 to copy counter).
	add.w	d4, d4
	jmp		@mediumcopy-2(pc, d4.w)
; ---------------------------------------------------------------------------
@largecopy:
	rept (1<<_KosPlus_LoopUnroll)
		move.b	(a5)+, (a1)+
	endr
	dbra	d4, @largecopy

@mediumcopy:
	rept 8
		move.b	(a5)+, (a1)+
	endr
	bra.w	@FetchNewCode
; ---------------------------------------------------------------------------
@Quit:
	rts
; ===========================================================================

