; ===========================================================================
; ---------------------------------------------------------------------------
; Kosinski decompression routine
;
; Created by vladikcomper
; Special thanks to flamewing and MarkeyJester
; ---------------------------------------------------------------------------

_Kos_RunBitStream macro
	dbf	d2,@skip\@
	moveq	#7,d2
	move.b	d1,d0
	swap	d3
	bpl.s	@skip\@
	move.b	(a0)+,d0			; get desc. bitfield
	move.b	(a0)+,d1			;
	move.b	(a4,d0.w),d0			; reload converted desc. bitfield from a LUT
	move.b	(a4,d1.w),d1			;
@skip\@
	endm
; ---------------------------------------------------------------------------

KosDec:
	moveq	#7,d7
	moveq	#0,d0
	moveq	#0,d1
	lea	KosDec_ByteMap(pc),a4
	move.b	(a0)+,d0			; get desc field low-byte
	move.b	(a0)+,d1			; get desc field hi-byte
	move.b	(a4,d0.w),d0			; reload converted desc. bitfield from a LUT
	move.b	(a4,d1.w),d1			;
	moveq	#7,d2				; set repeat count to 8
	moveq	#-1,d3				; d3 will be desc field switcher
	clr.w	d3				;
	bra.s	KosDec_FetchNewCode

KosDec_FetchCodeLoop:
	; code 1 (Uncompressed byte)
	_Kos_RunBitStream
	move.b	(a0)+,(a1)+

KosDec_FetchNewCode:
	add.b	d0,d0				; get a bit from the bitstream
	bcs.s	KosDec_FetchCodeLoop		; if code = 0, branch

	; codes 00 and 01
	_Kos_RunBitStream
	moveq	#0,d4				; d4 will contain copy count
	add.b	d0,d0				; get a bit from the bitstream
	bcs.s	KosDec_Code_01

	; code 00 (Dictionary ref. short)
	_Kos_RunBitStream
	add.b	d0,d0				; get a bit from the bitstream
	addx.w	d4,d4
	_Kos_RunBitStream
	add.b	d0,d0				; get a bit from the bitstream
	addx.w	d4,d4
	_Kos_RunBitStream
	moveq	#-1,d5
	move.b	(a0)+,d5			; d5 = displacement

KosDec_StreamCopy:
	lea	(a1,d5),a3
	move.b	(a3)+,(a1)+			; do 1 extra copy (to compensate for +1 to copy counter)

KosDec_copy:
	move.b	(a3)+,(a1)+
	dbf	d4,KosDec_copy
	bra.w	KosDec_FetchNewCode
; ---------------------------------------------------------------------------
KosDec_Code_01:
	; code 01 (Dictionary ref. long / special)
	_Kos_RunBitStream
	move.b	(a0)+,d6			; d6 = %LLLLLLLL
	move.b	(a0)+,d4			; d4 = %HHHHHCCC
	moveq	#-1,d5
	move.b	d4,d5				; d5 = %11111111 HHHHHCCC
	lsl.w	#5,d5				; d5 = %111HHHHH CCC00000
	move.b	d6,d5				; d5 = %111HHHHH LLLLLLLL
	and.w	d7,d4				; d4 = %00000CCC
	bne.s	KosDec_StreamCopy		; if CCC=0, branch

	; special mode (extended counter)
	move.b	(a0)+,d4			; read cnt
	beq.s	KosDec_Quit			; if cnt=0, quit decompression
	subq.b	#1,d4
	beq.w	KosDec_FetchNewCode		; if cnt=1, fetch a new code

	lea	(a1,d5),a3
	move.b	(a3)+,(a1)+			; do 1 extra copy (to compensate for +1 to copy counter)
	move.w	d4,d6
	not.w	d6
	and.w	d7,d6
	add.w	d6,d6
	lsr.w	#3,d4
	jmp	KosDec_largecopy(pc,d6.w)

KosDec_largecopy:
	rept 8
	move.b	(a3)+,(a1)+
	endr
	dbf	d4,KosDec_largecopy
	bra.w	KosDec_FetchNewCode

KosDec_Quit:
	rts

; ---------------------------------------------------------------------------
; A look-up table to invert bits order in desc. field bytes
; ---------------------------------------------------------------------------

KosDec_ByteMap:
	dc.b	$00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0
	dc.b	$08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8
	dc.b	$04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4
	dc.b	$0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC
	dc.b	$02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2
	dc.b	$0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA
	dc.b	$06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6
	dc.b	$0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE
	dc.b	$01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1
	dc.b	$09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9
	dc.b	$05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5
	dc.b	$0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD
	dc.b	$03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3
	dc.b	$0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB
	dc.b	$07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7
	dc.b	$0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF
