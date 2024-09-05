
obSTSelectedTrack:	equ	$20	; .b

; ---------------------------------------------------------------------------
; Track selector controller for the sound test
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector:

	move.b	#$81, obSTSelectedTrack(a0)	; set initial track
	bsr	@RedrawTrackInfo		; display this track
	move.l	#@Main, obCodePtr(a0)

; ---------------------------------------------------------------------------
@Main:
	move.b	Joypad|Press, d0

	btst	#iRight, d0			; is Right pressed?
	beq.s	@chkLeft			; if not, branch
	cmp.b	#$9F, obSTSelectedTrack(a0)
	beq.s	@ret
	addq.b	#1, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkLeft:
	btst	#iLeft, d0			; is Left pressed?
	beq.s	@chkAction			; if not, branch
	cmp.b	#$81, obSTSelectedTrack(a0)
	beq.s	@ret
	subq.b	#1, obSTSelectedTrack(a0)
	bra	@RedrawTrackInfo

@chkAction:
	btst	#iC, d0				; is action pressed?
	beq.s	@ret				; if not, branch
	move.b	obSTSelectedTrack(a0), d0
	jmp	PlaySound_Special

@ret	rts

; ---------------------------------------------------------------------------
@RedrawTrackInfo:
	moveq	#0, d0
	move.b	obSTSelectedTrack(a0), d0
	sub.b	#$81, d0
	lsl.w	#3, d0
	lea	@TrackLineData(pc), a5
	adda.w	d0, a5
	KDebug.WriteLine "%<.l (a5) sym> %<.w d0>"

	move.l	a0, -(sp)
	move.w	d7, -(sp)

	lea	SoundTest_DrawText, a4
	SoundTest_DrawFormattedString a4, "%<.b obSTSelectedTrack(a0)> %<.l (a5) str>", 35, #SoundTest_PlaneA_VRAM+25*$80
	SoundTest_DrawFormattedString a4, "   %<.l 4(a5) str>", 35, #SoundTest_PlaneA_VRAM+26*$80

	move.w	(sp)+, d7
	move.l	(sp)+, a0
	rts

; ---------------------------------------------------------------------------
@TrackLineData:
	dc.l	@Music81_Name		; $81
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $82
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $83
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $84
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $85
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $86
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $87
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $88
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $89
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8A
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8B
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8C
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8D
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8E
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $8F
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $90
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $91
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $92
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $93
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $94
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $95
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $96
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $97
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $98
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $99
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9A
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9B
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9C
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9D
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9E
	dc.l	@Music81_Source

	dc.l	@Music81_Name		; $9F
	dc.l	@Music81_Source


@padLen: = 32
@padString: macro string
	dc.b	\string
	dcb.b	@padLen-strlen('\strlen')-1, ' '
	dc.b	0
	endm

@Music81_Name:
	@padString 'NIGHT HILL ZONE'

@Music81_Source:
	@padString 'F1 POLE POSITION'

	even
