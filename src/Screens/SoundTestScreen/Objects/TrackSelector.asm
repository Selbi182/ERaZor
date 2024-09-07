
obSTSelectedTrack:	equ	$20	; .b

obSTScrollDelay:	equ	$22	; .w
obSTScrollValue:	equ	$24	; .w
obSTScrollTarget:	equ	$26	; .w
obSTScrollTarget2:	equ	$28	; .w
obSTScrollMaxValue:	equ	$2A	; .w

obST_MinTrack	= $81
obST_MaxTrack	= $DF

; ---------------------------------------------------------------------------
; Track selector controller for the sound test
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector:
	moveq	#$FFFFFF81, d0			; play initial music
	jsr	PlaySound_Special
	move.b	d0, obSTSelectedTrack(a0)	; set initial track
	bsr	@UpdateTrackInfo		; display this track
	move.l	#@Main, obCodePtr(a0)

; ---------------------------------------------------------------------------
@Main:
	bsr	@UpdateScrolling

	move.b	Joypad|Press, d0

	btst	#iRight, d0			; is Right pressed?
	beq.s	@chkLeft			; if not, branch
	addq.b	#1, obSTSelectedTrack(a0)
	cmpi.b	#obST_MaxTrack, obSTSelectedTrack(a0)
	bls.s	@UpdateTrackInfo
	move.b	#obST_MinTrack, obSTSelectedTrack(a0)
	bra	@UpdateTrackInfo

@chkLeft:
	btst	#iLeft, d0			; is Left pressed?
	beq.s	@chkBigSkip			; if not, branch
	subq.b	#1, obSTSelectedTrack(a0)
	cmpi.b	#obST_MinTrack, obSTSelectedTrack(a0)
	bhs.s	@UpdateTrackInfo
	move.b	#obST_MaxTrack, obSTSelectedTrack(a0)
	bra	@UpdateTrackInfo

@chkBigSkip:
	btst	#iA, d0				; is A pressed?
	beq.s	@chkStop			; if not, branch
	moveq	#0,d0
	move.b	obSTSelectedTrack(a0),d0
	addi.b	#$10,d0				; skip 16 entries ahead
	cmpi.w	#obST_MaxTrack,d0		; did we surpass the max?
	bls.s	@skipdone			; if not, branch
	subi.b	#obST_MaxTrack-obST_MinTrack+2,d0 ; restart on the other side
@skipdone:
	move.b	d0,obSTSelectedTrack(a0)	; update ID
	bra	@UpdateTrackInfo

@chkStop:
	btst	#iB, d0				; is B pressed?
	beq.s	@chkPlay			; if not, branch
	move.b	#$E4, d0
	jmp	PlaySound_Special

@chkPlay:
	btst	#iC, d0				; is action pressed?
	beq.s	@ret				; if not, branch
	move.b	obSTSelectedTrack(a0), d0
	jmp	PlaySound_Special

@ret	rts

; ---------------------------------------------------------------------------
@UpdateTrackInfo:
	moveq	#0, d0
	move.b	obSTSelectedTrack(a0), d0
	subi.b	#obST_MinTrack, d0
	lsl.w	#3, d0
	lea	@TrackLineData(pc), a5
	adda.w	d0, a5

	move.w	#60*2, obSTScrollDelay(a0)		; set scroll delay

	; Reset scrolling
	moveq	#0, d0
	move.w	d0, obSTScrollValue(a0)
	move.w	d0, obSTSCrollTarget2(a0)
	add.w	#(320-SoundTest_Visualizer_Width*8)/2-5*8, d0
	neg.w	d0
	move.w	d0, SoundTest_HScrollBuffer+26*2

	; Determine scrolling max value
	moveq	#0, d0
	move.b	4(a5), d0				; get description string length
	sub.w	#33, d0
	lsl.w	#3, d0
	bpl.s	@setup_scrolling
	moveq	#0, d0					; disable scrolling

@setup_scrolling:
	move.w	d0, obSTScrollMaxValue(a0)
	move.w	d0, obSTSCrollTarget(a0)		; want to scroll to the end

@RedrawTrackInfo:
	move.l	a0, -(sp)
	move.w	d7, -(sp)

	lea	SoundTest_DrawText, a4

	SoundTest_DrawFormattedString a4, "< %<.b obSTSelectedTrack(a0)>:%<.l (a5) str> >", 35, #SoundTest_PlaneA_VRAM+24*$80
	SoundTest_DrawFormattedString a4, "  %<.l 4(a5) str>", 48, #SoundTest_PlaneA_VRAM+26*$80

	move.w	(sp)+, d7
	move.l	(sp)+, a0
	rts

; ---------------------------------------------------------------------------
@UpdateScrolling:
	tst.w	obSTScrollDelay(a0)
	beq.s	@scrollToTarget
	subq.w	#1, obSTScrollDelay(a0)
	rts

@scrollToTarget:
	move.w	obSTScrollValue(a0), d0
	cmp.w	obSTScrollTarget(a0), d0
	beq.s	@scrollReachedTarget
	bhi.s	@scrollLeft
	addq.w	#1+1, d0

@scrollLeft:
	subq.w	#1, d0

@setScrolling:
	move.w	d0, obSTScrollValue(a0)
	add.w	#(320-SoundTest_Visualizer_Width*8)/2-5*8, d0
	neg.w	d0
	move.w	d0, SoundTest_HScrollBuffer+26*2
	move.w	#1, obSTScrollDelay(a0)
	rts

@scrollReachedTarget:
	move.l	obSTScrollTarget(a0), d0		; swap scroll targets
	swap	d0					; ''
	move.l	d0, obSTScrollTarget(a0)		; ''
	move.w	#60*2, obSTScrollDelay(a0)		; set scroll delay
	rts

; ---------------------------------------------------------------------------
@TrackLineData:
	include	"Screens/SoundTestScreen/Objects/TrackSelector.TrackData.asm"
