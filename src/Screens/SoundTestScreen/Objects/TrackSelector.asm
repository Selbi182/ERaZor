
obSTSelectedTrack:	equ	$20	; .b

obSTScrollDelay:	equ	$22	; .w
obSTScrollValue:	equ	$24	; .l	16.16 FIXED
obSTScrollTarget:	equ	$28	; .w
obSTScrollTarget2:	equ	$2A	; .w

obST_MinTrack	= $81
obST_MaxTrack	= $DF

; ---------------------------------------------------------------------------
; Track selector controller for the sound test
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector:
	; Create box overlay and arrow sub-objects
	SoundTest_CreateChildObject #SoundTest_Obj_TrackSelector_Overlay
	SoundTest_CreateChildObject #SoundTest_Obj_TrackSelector_Arrows

	; Initialize object now
	moveq	#$FFFFFF81, d0			; play initial music
	jsr	PlaySound_Special
	move.b	d0, obSTSelectedTrack(a0)	; set initial track
	bsr	@UpdateTrackInfo		; display this track
	move.l	#@Main, obCodePtr(a0)

; ---------------------------------------------------------------------------
@Main:
	bsr	@UpdateScrolling

	; React to button presses
	move.b	Joypad|Press, d0
	bmi.s	@ExitScreen

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
	btst	#iC, d0				; is C pressed?
	beq.s	@ret				; if not, branch
	move.b	obSTSelectedTrack(a0), d0
	jmp	PlaySound_Special

; ---------------------------------------------------------------------------
@ExitScreen:
	st.b	SoundTest_ExitFlag		; set exit flag
	move.b	#-$10, SoundTest_FadeCounter	; also perform a fade out

@ret:	rts

; ---------------------------------------------------------------------------
@UpdateTrackInfo:
	@track_info:	equr	a5

	moveq	#0, d0
	move.b	obSTSelectedTrack(a0), d0
	subi.b	#obST_MinTrack, d0
	lsl.w	#3, d0
	lea	@TrackLineData(pc), @track_info
	adda.w	d0, @track_info

	bsr	@SetupScrolling

*@RedrawTrackInfo:
	move.l	a0, -(sp)
	move.w	d7, -(sp)

	lea	SoundTest_DrawText(pc), a4

	SoundTest_DrawFormattedString a4, "%<.b obSTSelectedTrack(a0)>: %<.l (@track_info) str>                        ", 28, #SoundTest_PlaneA_VRAM+24*$80+4
	SoundTest_DrawFormattedString a4, "%<.l 4(@track_info) str>                                                    ", 52, #SoundTest_PlaneA_VRAM+26*$80+4

	move.w	(sp)+, d7
	move.l	(sp)+, a0
	rts

; ---------------------------------------------------------------------------
@SetupScrolling:
	@initial_scroll_delay: = 1*60+30 ; frames

	; Reset scrolling
	moveq	#0, d0
	move.l	d0, obSTScrollValue(a0)
	move.w	d0, obSTSCrollTarget2(a0)		; secondary scroll target for swapping (always zero)
	add.w	#(320-SoundTest_Visualizer_Width*8)/2-5*8, d0
	neg.w	d0
	move.w	d0, SoundTest_HScrollBuffer+25*2
	move.w	d0, SoundTest_HScrollBuffer+26*2

	; Determine scrolling max value
	moveq	#0, d0
	move.b	4(@track_info), d0			; get description string length
	sub.w	#33, d0
	lsl.w	#3, d0
	bls.s	@disable_scrolling			; branch if result is zero or negative

	move.w	#@initial_scroll_delay, obSTScrollDelay(a0)
	add.w	#2*8, d0				; small correction to account for right side padding
	move.w	d0, obSTScrollTarget(a0)		; want to scroll to the end
	rts

@disable_scrolling:
	moveq	#0, d0					; disable scrolling
	move.w	d0, obSTSCrollTarget(a0)		; ''

@disable_scrolling_2:
	move.w	#-1, obSTScrollDelay(a0)		; set an infinitely long delay
	rts

; ---------------------------------------------------------------------------
@UpdateScrolling:
	@scroll_vel: = $8000

	; This timer delays scrolling in-between cycles
	tst.w	obSTScrollDelay(a0)
	beq.s	@scrollToTarget
	subq.w	#1, obSTScrollDelay(a0)
	rts

@scrollToTarget:
	move.w	obSTScrollValue(a0), d0
	cmp.w	obSTScrollTarget(a0), d0
	beq.s	@scrollReachedTarget
	bhi.s	@scrollLeft
	addi.l	#@scroll_vel, obSTScrollValue(a0)
	bra.s	@setScrolling

@scrollLeft:
	subi.l	#@scroll_vel, obSTScrollValue(a0)

@setScrolling:
	move.w	obSTScrollValue(a0), d0
	add.w	#(320-SoundTest_Visualizer_Width*8)/2-5*8, d0
	neg.w	d0
	move.w	d0, SoundTest_HScrollBuffer+25*2
	move.w	d0, SoundTest_HScrollBuffer+26*2
	rts

@scrollReachedTarget:
	move.w	#0, obSTScrollValue+2(a0)		; clear fractional part
	move.l	obSTScrollTarget(a0), d0		; swap scroll targets
	swap	d0					; ''
	beq.s	@disable_scrolling_2			; if both targets are zero, we don't have scrolling
	move.l	d0, obSTScrollTarget(a0)		; ''
	move.w	#@initial_scroll_delay, obSTScrollDelay(a0); set scroll delay
	rts

; ---------------------------------------------------------------------------
@TrackLineData:
	include	"Screens/SoundTestScreen/Objects/TrackSelector.TrackData.asm"

; ---------------------------------------------------------------------------
; Subobject: Arrow keys
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector_Arrows:

	@char_to_tile:	equr	a2

	SoundTest_CreateChildObject #@Init	; a1 = right arror
	lea	SoundTest_CharToTile(pc), @char_to_tile
	move.w	('>'-$20)*2(@char_to_tile), obGfx(a1)	; right arrow settings
	move.w	#$80+320-8*4, obX(a1)			; ''
	move.w	('<'-$20)*2(@char_to_tile), obGfx(a0)	; left arrow settings
	move.w	#$80+8*3, obX(a0)			; ''

@Init:
	move.b	#1<<5, obRender(a0)		; sprite piece mode
	move.l	#@Sprite, obMap(a0)
	move.w	#$80+224-8*4-4, obScreenY(a0)
	move.l	#@Main, obCodePtr(a0)

@Main:
	jmp	DisplaySprite

; ---------------------------------------------------------------------------
@Sprite:
	dc.b	0, %0000, 0, 0, 0
	even

; ---------------------------------------------------------------------------
; Subobject: Shadowed box overlay
; ---------------------------------------------------------------------------

SoundTest_Obj_TrackSelector_Overlay:
	SoundTest_CreateChildObject #@Init	; a1 = secondary sprite
	move.w	#$80+3*8-4+$80, obX(a0)		; X-position for the primary sprite
	move.w	#$80+3*8-4+$80+$80, obX(a1)	; X-position for the secondary sprite
	move.b	#1, obFrame(a1)			; secondary sprite frame

@Init:
	move.w	#(SoundTest_UIBorderOverlay_VRAM/$20)|$6000, obGfx(a0)
	move.l	#@SpriteMappings, obMap(a0)
	move.b	#1, obPriority(a0)
	move.w	#$80+240-8*6-8, obScreenY(a0)
	move.l	#DisplaySprite, obCodePtr(a0)
	jmp	DisplaySprite

; ---------------------------------------------------------------------------
@SpriteMappings:
	dc.w	@Frame0-@SpriteMappings
	dc.w	@Frame1-@SpriteMappings

@Frame0:
	dc.b	8
	dc.b	0, %1111, 0, 4*13, -$80
	dc.b	0, %1111, 0, 4*8, -$60
	dc.b	0, %1111, 0, 4*8, -$40
	dc.b	0, %1111, 0, 4*8, -$20
	dc.b	0, %1111, 0, 4*8, $00
	dc.b	0, %1111, 0, 4*8, $20
	dc.b	0, %1111, 0, 4*8, $40
	dc.b	0, %1111, 0, 4*8, $60

@Frame1:
	dc.b	2
	dc.b	0, %1011, 0, 4*9, $00
	dc.b	0, %0011, $80, 4*12, $18
	even
