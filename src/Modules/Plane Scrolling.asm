
; ---------------------------------------------------------------------------
; Subroutine to	set scroll speed of some backgrounds
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BgScrollSpeed:				; XREF: LevelSizeLoad
		tst.b	($FFFFFE30).w
		bne.s	loc_6206
		move.w	d0,($FFFFF70C).w
		move.w	d0,($FFFFF714).w
		move.w	d1,($FFFFF708).w
		move.w	d1,($FFFFF710).w
		move.w	d1,($FFFFF718).w

loc_6206:
		moveq	#0,d2
		move.b	($FFFFFE10).w,d2
		add.w	d2,d2
		move.w	BgScroll_Index(pc,d2.w),d2
		jmp	BgScroll_Index(pc,d2.w)
; End of function BgScrollSpeed

; ===========================================================================
BgScroll_Index:	dc.w BgScroll_GHZ-BgScroll_Index, BgScroll_LZ-BgScroll_Index
		dc.w BgScroll_MZ-BgScroll_Index, BgScroll_SLZ-BgScroll_Index
		dc.w BgScroll_SYZ-BgScroll_Index, BgScroll_SBZ-BgScroll_Index
		dc.w BgScroll_End-BgScroll_Index
; ===========================================================================

BgScroll_GHZ:				; XREF: BgScroll_Index
		clr.l	($FFFFF708).w
		clr.l	($FFFFF70C).w
		clr.l	($FFFFF714).w
		clr.l	($FFFFF71C).w
		lea	Camera_BG,a2
		clr.l	(a2)+
		clr.l	(a2)+
		clr.l	(a2)+
		rts 
; ===========================================================================
 
BgScroll_LZ:				; XREF: BgScroll_Index
		; Initialize Y-position only (since warp happens on Y-axis exclusively)
		move.l	CamYPos, d0
		asr.l	#1, d0
		move.l	d0, CamYPos2
		rts
; ===========================================================================
 
BgScroll_MZ:				; XREF: BgScroll_Index
		rts	
; ===========================================================================
 
BgScroll_SLZ:				; XREF: BgScroll_Index
		asr.l	#1,d0
		addi.w	#$C0,d0
		move.w	d0,($FFFFF70C).w
		clr.l	($FFFFF708).w
		rts	
; ===========================================================================
 
BgScroll_SYZ:				; XREF: BgScroll_Index
		asl.l	#4,d0
		move.l	d0,d2
		asl.l	#1,d0
		add.l	d2,d0
		asr.l	#8,d0
		addq.w	#1,d0
		move.w	d0,($FFFFF70C).w
		clr.l	($FFFFF708).w
		rts	
; ===========================================================================
 
BgScroll_SBZ:				; XREF: BgScroll_Index
		; Initialize y-position only (since warp happens on Y-axis exclusively)
		move.l	CamYPos, d0
		asr.l	#3, d0
		move.l	d0, CamYPos2
		rts
; ===========================================================================
 
BgScroll_End:				; XREF: BgScroll_Index
		move.w	($FFFFF700).w,d0
		asr.w	#1,d0
		move.w	d0,($FFFFF708).w
		move.w	d0,($FFFFF710).w
		asr.w	#2,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		move.w	d0,($FFFFF718).w
		clr.l	($FFFFF70C).w
		clr.l	($FFFFF714).w
		clr.l	($FFFFF71C).w
		lea	Camera_BG,a2
		clr.l	(a2)+
		clr.l	(a2)+
		clr.l	(a2)+
		rts   


; ===========================================================================
; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DeformBgLayer:				; XREF: TitleScreen; Level; EndingSequence
		tst.b	($FFFFFFE9).w		; is level set to restart?
		bne.w	DeformBgLayer_Done	; if yes, branch

		bsr	ScrollHoriz
		bsr	ScrollVertical
		bsr	DynScrResizeLoad
 	
 		jsr	GenerateCameraShake	; apply camera shake now (needs to be done after the above scroll routines)
 
 DeformBgLayer2:
		moveq	#0,d0
		move.b	CurrentZone, d0
		add.w	d0,d0
		move.w	Deform_Index(pc,d0.w),d0
		jsr	Deform_Index(pc,d0.w)		; do background deformation now
		move.w	CamYpos, ($FFFFF616).w	; set plane A vs-ram
		move.w	CamYpos2, ($FFFFF618).w	; set plane B vs-ram

DeformBgLayer_Done:
		rts
; End of function DeformBgLayer
; ===========================================================================

; ---------------------------------------------------------------------------
; Offset index for background layer deformation	code
; ---------------------------------------------------------------------------
Deform_Index:	dc.w Deform_GHZ-Deform_Index, Deform_LZ-Deform_Index
		dc.w Deform_MZ-Deform_Index, Deform_SLZ-Deform_Index
		dc.w Deform_SYZ-Deform_Index, Deform_SBZ-Deform_Index
		dc.w Deform_GHZ-Deform_Index


; ===========================================================================
; ---------------------------------------------------------------------------
; Generic subroutine to deform screen in 16-bit mode
; ---------------------------------------------------------------------------

DeformScreen_Generic:
		lea	HSRAM_Buffer, a1

		move.w	CamYShift, d0
		ext.l	d0
		lsl.l	#8-3, d0
		add.l	d0, CamYPos2

		move.w	CamXPos, d0		; apply horizontal scrolling
		neg.w	d0			; ''
		swap	d0
		move.w	CamXPos2, d0
		neg.w	d0

		moveq	#240/16-1, d1		; repeat to cover the entire 240-pixel screen

DeformScreen_SendBlocks:
	@scroll_loop:
		rept 16
			move.l	d0, (a1)+
		endr
		dbf	d1, @scroll_loop
		rts


; ---------------------------------------------------------------------------
; Green	Hill Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Deform_GHZ:
		cmpi.b	#4,(GameMode).w ; is this the title screen?
		beq.w	Deform_TS ; if yes, use optimized deformation
	;	cmpi.w	#$001,($FFFFFE10).w ; check if level is	GHZ 2
	;	beq.w	Deform_LZ

		; Setup layers scrolling
		moveq	#0, d0
		move.w	CamXPos, d0			; d0 = Camera X-pos
		swap	d0
		asr.l	#3, d0				; d0 = Camera X-pos / 8
		move.l	d0, d1				; d1 = Camera X-pos / 8
		add.l	d1, d1				; d1 = Camera X-pos / 4
		add.l	d0, d1				; d1 = Camera X-pos * 3/8
		swap	d1
		move.w	d1, CamXpos4			; setup BG Layer 3 X-position

		move.w	CamXPos, d0
		asr.w	#1, d0
		move.w	d0, CamXpos3			; setup BG Layer 2 X-position

		; Setup BG Y-position
		move.w	CamYPos, d0
		andi.w	#$7FF, d0
		lsr.w	#5, d0
		neg.w	d0
		addi.w	#$20, d0
		bpl.s	@y_pos_no_limit
		moveq	#0, d0

@y_pos_no_limit:
		move.w	d0, CamYPos2

		; Update moving clouds positions
		lea	Camera_BG, a2
		add.l	#$10000, $C(a2)
		add.l	#$C000, $14(a2)
		add.l	#$8000, $18(a2)			; make sure this one is unused!

		move.w	CamXPos, d0
		neg.w	d0
		swap	d0

		move.w	CamYPos2, d4

		lea	HSRAM_Buffer, a1
		lea	DeformScreen_SendBlocks(pc), a2

		; Scroll moving clouds
		move.w	Camera_BG+$C, d0
		add.w	CamXpos4, d0
		neg.w	d0
		moveq	#$20-1, d1
		sub.w	d4, d1
		bcs.s	@clouds_pt2

		@clouds_p1_loop:		
			move.l	d0, (a1)+
			dbf	d1, @clouds_p1_loop

	@clouds_pt2:
		move.w	Camera_BG+$14, d0
		add.w	CamXpos4, d0
		neg.w	d0
		moveq	#$10/$10-1, d1				; d1 = Number of 16x16 blocks to send
		jsr	(a2)

		move.w	Camera_BG+$18, d0
		add.w	CamXpos4, d0
		neg.w	d0
		moveq	#$10/$10-1, d1				; d1 = Number of 16x16 blocks to send
		jsr	(a2)

		; Scroll mountains (rear)
		move.w	CamXpos4, d0
		neg.w	d0
		moveq	#$30/$10-1, d1				; d1 = Number of 16x16 blocks to send
		jsr	(a2)

		; Scroll mountains (near)
		move.w	CamXpos3, d0
		neg.w	d0

		moveq	#$20/$10-1, d1				; d1 = Number of 16x16 blocks to send
		jsr	(a2)

		moveq	#8/2-1, d1

		@mountains_near_loop:
			rept 2
				move.l	d0, (a1)+
			endr
			dbf	d1, @mountains_near_loop

		; Scroll sea
		move.w	CamXpos3, d0
		move.w	CamXpos, d2
		sub.w	d0, d2
		ext.l	d2
		asl.l	#8, d2
		divs.w	#$68, d2
		ext.l	d2
		asl.l	#8, d2
		moveq	#0, d3
		move.w	d0, d3
		moveq	#$58-1, d1
		add.w	d4, d1

		@sea_loop:
			move.w	d3, d0
			neg.w	d0
			move.l	d0, (a1)+
			swap.w	d3
			add.l	d2, d3
			swap.w	d3
			dbf	d1, @sea_loop

		rts


; ---------------------------------------------------------------------------
;Title Screen background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_TS:				; XREF: Deform_Index
		lea	($FFFFCC00).w,a1	; set a1 to horizontal scroll buffer

		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$01,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$000F,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop1:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop1		; repeat d1 number of scanlines

		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$02,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$000F,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop2:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop2		; repeat d1 number of scanlines

		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$03,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$0007,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop3:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop3		; repeat d1 number of scanlines

		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$04,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$0007,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop3x:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop3x		; repeat d1 number of scanlines

		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$05,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$000F,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop4:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop4		; repeat d1 number of scanlines



		move.w	($FFFFD008).w,d0	; load screen's X position
		neg.w	d0			; negate (positive to negative)
		asr.w	#$06,d0			; divide by 2 (Slow down the scroll position)
		move.w	#$001F,d1		; set number of scan lines to dump (minus 1 for dbf)
DeformLoop5:
		move.l	d0,(a1)+		; dump both the FG and BG scanline position to buffer
		dbf	d1,DeformLoop5		; repeat d1 number of scanlines


		move.w	($FFFFD008).w,d0	; set d0 to camera position
		ext.l	d0			; extend to long
		lsl.l	#8,d0			; multiply it by $100
		lsl.l	#2,d0			; multiply it by 4
		neg.l	d0			; negate it
		move.w	#$80,d2			; set loops to $80 (yes $80, not $7F)
		moveq	#0,d3
DTS_Loop:
		move.w	d3,d1			; get deformation speed for the current line
		move.l	d1,(a1)+		; set it to scroll buffer
		add.l	d0,d3			; increase speed for next row
		swap	d3			; swap it
		dbf	d2,DTS_Loop		; loop
		rts				; return
; End of function Deform_TS

; ===========================================================================

Deform_LZ:
		tst.b 	($FFFFFFFE).w		; is the =P monitor enabled?
		bne.s	Deform_LZ_Extended	; if yes, use alternate deformation

	; original code, takes A LOT less cycles than the extended code

		; Calculate x-position for the background
		move.w	CamXPos, d0
		asr.w	#1, d0
		move.w	d0, CamXPos2

		; Calculate y-position for the background
		; based on displacement since the last camera move
		move.w	CamYShift, d0		; d0 = CamYShift (8.8 fixed)
		ext.l	d0
		lsl.l	#8-1, d0		; d0 = CamYShift / 2 (16.16 fixed)
		add.l	d0, CamYPos2

		move.w	($FFFFF70C).w,($FFFFF618).w
		lea	($FFFFCC00).w,a1
		move.w	#$DF,d1
		move.w	($FFFFF700).w,d0
		neg.w	d0
		swap	d0
		move.w	($FFFFF708).w,d0
		neg.w	d0

loc_63C6:
		move.l	d0,(a1)+
		dbf	d1,loc_63C6
		move.w	($FFFFF646).w,d0
		sub.w	($FFFFF704).w,d0
		rts	
; End of function Deform_LZ
; ===========================================================================

; extended code, takes way a ton more cycles
Deform_LZ_Extended:
		; Calculate x-position for the background
		move.w	CamXPos, d0
		asr.w	#1, d0
		move.w	d0, CamXPos2

		; Calculate y-position for the background
		; based on displacement since the last camera move
		move.w	CamYShift, d0		; d0 = CamYShift (8.8 fixed)
		ext.l	d0
		lsl.l	#8-1, d0		; d0 = CamYShift / 2 (16.16 fixed)
		add.l	d0, CamYPos2

		move.w	($FFFFF70C).w,($FFFFF618).w	; load 'Cam_BG_Y' into VSRAM buffer

		; Setup scroll value
		lea	($FFFFCC00).w,a1
		move.w	($FFFFF700).w,d0
		neg.w	d0			; d0 = Plane A scrolling
		move.w	d0,d1			; d1 = Plane A scrolling (backup)
		swap	d0
		move.w	($FFFFF708).w,d0
		neg.w	d0			; d0 = Plane B scrolling

		; Calculate water line and decide where to start
		moveq	#0,d2
		move.b	($FFFFF7D8).w,d2
		move.w	d2,d3
		addi.w	#$80,($FFFFF7D8).w	; WaveValue += 0.5    
		add.b	($FFFFF704+1).w,d3	; d3 = (WaveValue + Cam_Y) & $FF
		add.b	($FFFFF70C+1).w,d2	; d2 = (WaveValue + Cam_Y) & $FF
		move.w	#224,d6			; d6 = Number of lines
		move.w	($FFFFF646).w,d4	; d4 = WaterLevel
		sub.w	($FFFFF704).w,d4	; d4 = WaterLevel - Cam_Y
		beq.s	@DeformWater_2
		bmi.s	@DeformWater_2		; if water line is above screen, branch
		cmp.w	d6,d4			; d4 > Lines on screen?
		blt.s	@DeformDry_Partial	; if not, branch

; ---------------------------------------------------------------------------
; Works, if full screen is dry

		subq.w	#1,d6

@DeformDry_Full:
		move.l	d0,(a1)+
		dbf	d6,@DeformDry_Full
		rts

; ---------------------------------------------------------------------------
; Works, if only part of screen is dry

@DeformDry_Partial:
		move.w	d4,d5			; d5 = WaterLevel
		subq.w	#1,d4

	@0:	move.l	d0,(a1)+
		dbf	d4,@0

; ---------------------------------------------------------------------------
; Works if screen is full of water, or water at least takes place

@DeformWater:
		sub.w	d5,d6			; d6 = 224 - WaterLevel = Lines left for water
		add.b	d5,d2			;
		add.b	d5,d3			;

@DeformWater_2:
		subq.w	#1,d6
		lea	(Obj0A_WobbleData).l,a2	; a2 = Water Deformation Data for Plane B
		lea	LZ_Wave_Data(pc),a3	; a3 = Water Deformation Data for Plane A
		add.w	d2,a2			; load array from position of water line
		add.w	d3,a3			;

	@1:	move.b	(a3)+,d2
		ext.w	d2
		add.w	d1,d2			; d2 = Plane A scrolling
		move.w	d2,(a1)+
		move.b	(a2)+,d2
		ext.w	d2
		add.w	d0,d2			; d2 = Plane B scrolling
		move.w	d2,(a1)+
		dbf	d6,@1
		rts

; ===========================================================================
LZ_Wave_Data:	dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0

; ===============================================================================

 
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
 
 
Deform_MZ:
		moveq	#0, d0				;
		move.w	CamXpos, d0			;
		swap	d0				;

		move.l	d0, d1				; Layer 1 - interior
		asr.l	#2, d1				; ''
		move.l	d1, d2				; ''
		add.l	d2, d2				; ''
		add.l	d2, d1				; ''
		move.l	d1, CamXpos2			; ''

		move.l	d0, d1				; Layer 2 - bushes
		asr.l	#1, d1				; ''
		move.l	d1, CamXpos3			; ''

		move.l	d0, d1				; Layer 3 - mountains
		asr.l	#2, d1				; ''
		move.l	d1, CamXpos4			; ''

		; Calculate y-position of background
		move.w	#$200, d0			; start with 512px, ignoring 2 chunks
		move.w	CamYPos, d1
		subi.w	#$1C8, d1			; 0% scrolling when y <= 56px 
		bcs.s	@noYscroll
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		asr.w	#2,d1
		add.w	d1,d0

	@noYscroll:
		move.w	d0, CamYPos2

		; Init Hscroll buffer
		lea	ScrollBlocks_Buffer, a1
		move.w	CamXPos, d2

		; NOTICE:
		; The cloud scrolling calculation has been re-implemented and improved.
		;
		; The original code used some unwise shifts and division, thus loosing some precision.
		; It attempted to calculate d0 as follows in 16.16FIXED format:
		;	d0 = (3/40) * CamXPos = 0.075 * CamXPos
		; The optimized code uses the following approximation:
		;	d0 = (19/256) * CamXPos = 0.07421875 * CamXPos

		move.w	d2, d1			; d1 = CamXPos
		ext.l	d1
		asl.l	#8, d1			; d1 = (1 / 256) * CamXPos
		move.l	d1, d0
		asl.l	#4, d0			; d0 = (16 / 256) * CamXPos = (1 / 16) * CamXPos
		add.l	d1, d0			; d0 = (17 / 256) * CamXPos
		add.l	d1, d0			; d0 = (18 / 256) * CamXPos
		add.l	d1, d0			; d0 = (19 / 256) * CamXPos

		neg.w	d2
		moveq	#0, d3
		move.w	d2, d3
		ext.l	d3
		swap	d3
		asr.l	#1, d3
		moveq	#5-1, d1

		; Clouds scrolling
		@cloudLoop:		
			swap	d3
			move.w	d3, (a1)+
			swap	d3
			add.l	d0, d3
			dbf	d1, @cloudLoop

		; Mountains scrolling
		move.w	CamXpos4, d0
		neg.w	d0
		rept 2
			move.w	d0, (a1)+
		endr

		; Bushes scrolling
		move.w	CamXpos3, d0
		neg.w	d0
		moveq	#9-1, d1
	@bushLoop:		
		move.w	d0, (a1)+
		dbf	d1, @bushLoop

		; Interior scrolling
		move.w	CamXpos2, d0
		neg.w	d0
		moveq	#$10/2-1, d1

	@interiorLoop:	
		rept 2	
			move.w	d0, (a1)+
		endr
		dbf	d1, @interiorLoop

		lea	ScrollBlocks_Buffer, a2
		move.w	CamYPos2, d0
		subi.w	#$200, d0		; subtract 512px (unused 2 chunks)
		move.w	d0, d2
		cmpi.w	#$100, d0
		bcs.s	@limitY
		move.w	#$100, d0

	@limitY:
		andi.w	#$1F0, d0
		lsr.w	#3, d0
		lea	(a2, d0), a2
		;bra.w	DeformScreen_ProcessBlocks

; ===========================================================================
; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------
; INPUT:
;		a2		Block scroll buffer pointer
;		d2	.w	Camera Y-position
; ---------------------------------------------------------------------------

DeformScreen_ProcessBlocks:
	if def(__DEBUG__)
		; WARNING! Make sure the caller uses A1 to write to "scroll blocks" buffer
		;jsr	Deform_CheckBlocksBuffer_Overflow
	endif

DeformScreen_ProcessBlocks_NoOverflowCheck:
		lea	HSRAM_Buffer, a1
		move.w	CamXPos, d0
		neg.w	d0
		swap	d0
		andi.w	#$F, d2
		add.w	d2, d2
		move.w	(a2)+, d0
		moveq	#$F-1, d1			; repeat for $F blocks to cover up to 240 pixels (but see below)
		jsr	@pixelJump(pc, d2)		; skip pixels for first row

		sub.w	#$10*2, d2
		neg.w	d2
		move.w	(a2)+, d0
		moveq	#1-1, d1			; repeat for one more block to cover exactly 240 pixels
		jmp	@pixelJump(pc, d2)		; skip pixels for the last row

		@blockLoop:
			move.w	(a2)+, d0		; get block X-position for scrolling

		@pixelJump:
			rept 16
				move.l	d0, (a1)+
			endr
			dbf	d1, @blockLoop

		rts

; ===========================================================================


; ===========================================================================

DSLZ_Pos = $120
DSLZ_PosX = $000

Deform_SLZ:
		move.w	#DSLZ_Pos,($FFFFF70C).w
		move.w	($FFFFF70C).w,($FFFFF618).w

		lea	($FFFFCC00).w,a1	; load beginning address of horizontal scroll buffer to a1
		move.w	($FFFFF700).w,d4	; load FG screen's X position
		neg.w	d4			; negate (positive to negative)

		move.w	($FFFFFE04).w,d2
		ori.w	#1,d2
	;	add.w	d2,d2

		cmpi.w	#$301,($FFFFFE10).w
		bne.s	@cont
		cmpi.w	#$3D0,($FFFFF726).w	; is boss playing?
		bne.s	@cont

		add.w	d2,d2
		add.w	d2,d2
		move.w	#DSLZ_PosX,($FFFFF70C).w

@cont:
		cmpi.w	#$302,($FFFFFE10).w
		bne.s	@cont2
		tst.b	($FFFFFF77).w
		beq.s	@cont2

		add.w	d2,d2
		move.w	#DSLZ_Pos,($FFFFF70C).w

@cont2:
		neg.w	d2
		move.w	d2,d0
		asr.w	#3,d0
		sub.w	d2,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$1C,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0

		moveq	#0,d3
		move.w	d2,d3

		move.w	#$E0/8-1,d1		; set number of scan lines to dump (minus 1 for dbf)
SLZ_DeformLoop_1:
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+

		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,SLZ_DeformLoop_1	; repeat d1 number of scanlines
		rts
; End of function Deform_SLZ
; ===========================================================================

Deform_All:				; CODE XREF: Deform_MZ+F4?j
		lea	($FFFFCC00).w,a1
		move.w	#$E,d1
		move.w	($FFFFF700).w,d0
		neg.w	d0
		swap	d0
		andi.w	#$F,d2
		add.w	d2,d2
		move.w	(a2)+,d0
		jmp	Deform_All_2(pc,d2.w)

Deform_All_1:				; CODE XREF: ROM:0000670A?j
		move.w	(a2)+,d0

Deform_All_2:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,Deform_All_1
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; Deform_Uberhub: 
Deform_SYZ:
		; Setup X-layers scrolling
		move.l	CamXPos, d0
		asr.l	#3, d0					; layer 2 - buildings
		move.l	d0, CamXPos3				; ''

		asr.l	#1, d0					; layer 1 - mountains
		move.l	d0, CamXPos2				;

		; Calculate y-position of the background
		moveq	#0, d0
		move.w	CamYPos, d0
		swap	d0
		asr.l	#4, d0
		move.l	d0, d1
		asr.l	#1, d0
		add.l	d1, d0

		swap	d0
		move.w	d0, d1
		add.w	#224, d1
		sub.w	#$100, d1
		bmi.s	@0
		sub.w	d1, d0
@0:		
;	moveq	#0,d0
		move.w	d0, CamYPos2
		
 
		lea	ScrollBlocks_Buffer, a1

		; Scroll clouds
		moveq	#0, d2
		move.w	CamXPos, d2
		lsr.w	#2,d2
		
	move.w	($FFFFFE04).w,d3
	add.w	d3,d3
	add.w	d3,d2
		
		neg.w	d2
		swap	d2
		move.l	d2, d3

		move.l	d2, d0				; d0 = - CamXPos
		asr.l	#4, d0				; d0 = - CamXPos / $10
		move.l	d0, d1
		asr.l	#3, d0				; d1 = - CamXpos / $80
		add.l	d1, d0				; d1 = - 7 / $80 * CamXPos

		asr.l	#1, d3				; d3 = - CamXPos / 2
		moveq	#8-1, d1

		@cloud_loop:
			swap	d3
			move.w	d3, (a1)+
			swap	d3
			sub.l	d0, d3
			dbf	d1, @cloud_loop

		; Scroll mountains
		move.w	CamXPos2, d0
		neg.w	d0
		moveq	#5-1, d1

		@mountains_loop:
			move.w	d0, (a1)+
			dbf	d1, @mountains_loop

		; Scroll buildings
		move.w	CamXPos3, d0
		neg.w	d0
		moveq	#6-1, d1

		@buildings_loop:
			move.w	d0, (a1)+
			dbf	d1, @buildings_loop

		; Scroll bushes
		; 
		; NOTICE:
		; Bushes scrolling calculation has been re-implemented and improved.
		;
		; The original code used some unwise shifts and division, thus loosing some precision.
		; It attempted to calculate d0 as follows in 16.16FIXED format:
		;	d0 = (1/28) * CamXPos = 0.0357142857143 * CamXPos
		; The optimized code uses the following approximation:
		;	d0 = (5/128) * CamXPos = 0,0390625 * CamXPos

		moveq	#0, d0
		move.w	CamXPos, d0
		neg.w	d0
		swap	d0				; d0 = - CamXPos
		move.l	d0, d2
		asr.l	#4, d0				; d0 = - CamXPos / 16
		move.l	d0, d1
		asr.l	#7-4, d1			; d1 = - CamXPos / 128
		sub.l	d1, d0				; d0 = - (9 / 128) * CamXPos

		asr.l	#2, d2
		moveq	#$D-1, d1

		@bushes_loop:
			swap	d2
			move.w	d2, (a1)+
			swap	d2
			add.l	d0, d2
			dbf	d1, @bushes_loop

		lea	ScrollBlocks_Buffer, a2
		move.w	CamYPos2, d0
		move.w	d0, d2
		andi.w	#$1F0, d0
		lsr.w	#3, d0
		lea	(a2,d0), a2
		bsr	DeformScreen_ProcessBlocks

		; screen fuzz for blackout room
		tst.b	($FFFFFFD0).w		; jumped into blackout ring?
		beq.s	@nospoop		; if not, branch
		move.b	#$10,($FFFFF73A).w	; pretend 16 pixels have been scrolled for the bzzzzz
@nospoop:	rts
; ===========================================================================

 
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
 
 
Deform_SBZ:
		cmpi.w	#$502,($FFFFFE10).w	; is this Finalor Place?
		beq.w	Deform_FZ		; if yes, use alternate deformation

		; Setup X-layers scrolling
		move.l	CamXPos, d0
		
		asr.l	#1, d0				; layer 2 - black buildings
		move.l	d0, CamXPos3			;

		asr.l	#1, d0				; layer 1 - brown buildings
		move.l	d0, CamXPos2			;

		tst.b	($FFFFFE11).w			; is it Tutorial?
		bne.w	DeformScreen_Generic		; if yes, branch

		move.l	d0, d1				; layer 3 - near buildings
		asr.l	#1, d1				;
		add.l	d1, d0				;
		move.l	d0, CamXPos4			;

		; Calculate y-position for the background
		; based on displacement since the last camera move
		move.w	CamYShift, d0
		ext.l	d0
		lsl.l	#8-3, d0
		add.l	d0, CamYPos2

		lea	ScrollBlocks_Buffer, a1
		
		; Scroll clouds
		;
		; NOTICE:
		; Clouds scrolling calculation has been re-implemented and improved.
		;
		move.l	CamXPos, d0
		asr.l	#1, d0							; d0 = 1/2 * CamXPos
		move.l	d0, d1
		asr.l	#6-1, d1						; d1 = 1/64 * CamXPos

		neg.l	d0
		swap	d0
		moveq	#4-1, d2

		@cloud_loop:
			move.w	d0, (a1)+
			swap	d0
			add.l	d1, d0
			swap	d0
			dbf	d2, @cloud_loop

		; Scroll distant brown buildings
		move.w	CamXPos2, d0
		neg.w	d0
		moveq	#$A-1, d1

		@buildings_loop1:
			move.w	d0, (a1)+
			dbf	d1, @buildings_loop1

		; Scroll upper black buildings
		move.w	CamXPos4, d0
		neg.w	d0
		moveq	#7-1, d1

		@buildings_loop2:
			move.w	d0, (a1)+
			dbf	d1, @buildings_loop2

		; Scroll lower black buildings
		move.w	CamXPos3,d0
		neg.w	d0
		moveq	#$B-1, d1

		@buildings_loop3:
			move.w	d0, (a1)+
			dbf	d1, @buildings_loop3

		lea	ScrollBlocks_Buffer, a2
		move.w	CamYPos2, d0
		move.w	d0, d2
		andi.w	#$1F0, d0
		lsr.w	#3, d0
		lea	(a2,d0), a2
		bra.w	DeformScreen_ProcessBlocks

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

DFZ_Pos = $120

Deform_FZ:
		move.w	#DFZ_Pos,($FFFFF70C).w		; force vertical background position in place
		move.w	($FFFFF70C).w,($FFFFF618).w 

		lea	($FFFFCC00).w,a1	; load beginning address of horizontal scroll buffer to a1
		move.w	($FFFFF700).w,d4	; load FG screen's X position
		neg.w	d4			; negate (positive to negative)

		move.w	($FFFFFE04).w,d2	; get current level timer
		lsl.w	#2,d2			; speed it up
		btst	#1,(FZEscape).w		; escape active?
		beq.s	@notescape		; if not, branch
		add.w	d2,d2			; double background speed
@notescape:
		neg.w	d2
		move.w	d2,d0
		asr.w	#3,d0
		sub.w	d2,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$1C,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0

		moveq	#0,d3
		move.w	d2,d3

		moveq	#$1B,d1		; set number of scan lines to dump (minus 1 for dbf)
FZ_DeformLoop:
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+

		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,FZ_DeformLoop	; repeat d1 number of scanlines
		rts
; End of function Deform_FZ

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level horizontally as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollHoriz:				; XREF: DeformBgLayer
		cmpi.w	#$200,($FFFFFE10).w	; is level MZ1?
		beq.s	@cont1			; if yes, branch
		cmpi.b	#1,($FFFFFFAA).w	; is Sonic fighting against the crabmeat?
		bne.s	@cont1			; if not, branch
		move.w	($FFFFF72A).w,($FFFFF728).w	; lock left screen position

@cont1:
		move.w	($FFFFF700).w,d4

		tst.b	($FFFFFFB2).w	; is camera delay set?
		beq.s	SH_NoDelay	; if not, branch
		subq.b	#1,($FFFFFFB2).w ; sub one from camera delay
		clr.w	($FFFFF73A).w
		rts
; ===========================================================================

SH_NoDelay:
		move.w	($FFFFC904).w,d1
		beq.s	@cont1
		sub.w	#$100,d1
		move.w	d1,($FFFFC904).w
		moveq	#0,d1
		move.b	($FFFFC904).w,d1
		lsl.b	#2,d1
		addq.b	#4,d1
		move.w	($FFFFF7A8).w,d0
		sub.b	d1,d0
		lea	($FFFFCB00).w,a1
		move.w	(a1,d0.w),d0
		and.w	#$3FFF,d0
		bra.w	S_H_NoExtendedCam
		
@cont1:
		move.w	($FFFFD008).w,d0	; move Sonic's X-pos to d0

CamSpeed = 2					; set camera moving speed (standart 2 or 3)

		cmpi.w	#$601,($FFFFFE10).w	; is this the ending sequence?
		bne.s	S_H_NoEnding		; if not, branch
		sub.w	#$60,d0			; substract $40 from the camera position constantly
		bra.w	S_H_NoExtendedCam	; skip
; ===========================================================================

S_H_NoEnding:
		cmpi.w	#$001,($FFFFFE10).w	; is level GHZ2?
		bne.s	S_H_ExtendedCamera	; if not, branch
		tst.b	($FFFFFFD8).w		; has Buzz Bomber been destroyed?
		bne.s	S_H_BuzzIgnore		; if yes, branch
		sub.w	#$35,d0			; make the middle between Sonic and the Bomber the cam-position
		bra.w	S_H_NoExtendedCam	; skip
; ===========================================================================

S_H_ExtendedCamera:
		btst	#0,(OptionsBits).w	; is extended camera enabled?
		beq.w	S_H_NoExtendedCam	; if not, you're lame and old-fashioned but k

		cmpi.b	#3,($FFFFFE10).w
		bne.s	S_H_BuzzIgnore		; if not, branch
		tst.b	($FFFFFFA9).w		; is Sonic fighting against the walking bomb?
		bne.w	S_H_ResetCamera		; if yes, branch	
		tst.b	($FFFFFF77).w		; is antigrav enabled?
		bne.w	S_H_ResetCamera		; if yes, branch

S_H_BuzzIgnore:
		tst.b	($FFFFF7CD).w
		bne.s	S_H_ResetCamera

		cmpi.w	#$501,($FFFFFE10).w
		bne.s	@cont
		cmpi.w	#$1B00,($FFFFD008).w
		bcs.s	@cont
		cmpi.w	#$2100,($FFFFD008).w
		bcc.s	@cont
		tst.b	($FFFFFFEB).w
		beq.s	@cont
		bra.s	S_H_ResetCamera

@cont:
		tst.b	($FFFFFFAF).w		; has a flag been set to do this? (Peelout / Spindash)
		bne.s	S_H_PeeloutSpindash	; if yes, branch
		move.w	($FFFFD014).w,d2	; load sonic's ground speed to d2
		btst	#1,($FFFFD022).w	; is sonic in the air?
		beq.s	S_H_ChkDirection	; if not, branch
		move.w	($FFFFD010).w,d2	; load sonic's general speed to d2 instead

S_H_ChkDirection:
		move.w	d2,d3			; backup speed to d3
		tst.w	d2			; is speed positve?
		bpl.s	S_H_SpeedPositive	; if yes, branch
		neg.w	d2			; otherwise negate it

S_H_SpeedPositive:
		cmpi.w	#$600,d2		; is Sonic's speed more than $600 (or less than -$600)?
		blt.s	S_H_ResetCamera		; if not, branch
		tst.w	d3			; is Speed negative?
		bpl.s	S_H_FastEnough_Right	; if yes, branch to code when Sonic's running to the right
		bra.s	S_H_FastEnough_Left	; otherwise use the code when Sonic's running to the left
; ===========================================================================

S_H_PeeloutSpindash:
		btst	#1,($FFFFD022).w	; is Sonic in air?
		beq.s	@allgood		; if not, branch
		clr.b	($FFFFFFAF).w		; otherwise make sure camera shift doesn't get stuck
		bra.s	S_H_ResetCamera
@allgood:
		btst	#0,($FFFFD022).w	; is Sonic facing right while performing a Peelout / Spindash?
		beq.s	S_H_FastEnough_Right	; if yes, branch
		bra.s	S_H_FastEnough_Left	; otherwise, use code for left
; ===========================================================================

S_H_FastEnough_Right:
		cmpi.w	#$40,($FFFFFFCE).w	; is camera moving counter at or over $40?
		bge.s	S_H_CameraMove_End	; if yes, don't change camera moving
		add.w	#CamSpeed,($FFFFFFCE).w	; otherwise, make camera move to the left
		bra.s	S_H_CameraMove_End	; skip to processing code
; ===========================================================================

S_H_FastEnough_Left:
		cmpi.w	#-$40,($FFFFFFCE).w	; is camera moving counter at or below -$40?
		ble.s	S_H_CameraMove_End	; if yes, don't change camera moving
		sub.w	#CamSpeed,($FFFFFFCE).w	; otherwise, make camera move to the right
		bra.s	S_H_CameraMove_End	; skip to processing code
; ===========================================================================

S_H_ResetCamera:
		tst.w	($FFFFFFCE).w		; is camera moving counter empty?
		beq.s	S_H_CameraMove_End	; if yes, branch to end
		bpl.s	S_H_ResetCamera_Left	; is it positive? if yes, branch to code for left moving
		add.w	#CamSpeed,($FFFFFFCE).w	; otherwise make it move to the right again
		bra.s	S_H_CameraMove_End	; skip to end
; ===========================================================================

S_H_ResetCamera_Left:
		sub.w	#CamSpeed,($FFFFFFCE).w	; make camera move to the elft again

S_H_CameraMove_End:
		add.w	($FFFFFFCE).w,d0	; add counter to normal camera location

S_H_NoExtendedCam:
		sub.w	($FFFFF700).w,d0
		subi.w	#$90,d0
		bmi.s	loc_65F6
		subi.w	#$10,d0
		bpl.s	loc_65CC
		clr.w	($FFFFF73A).w
		rts
; ===========================================================================

loc_65CC:
		cmpi.w	#$10,d0
		bcs.s	loc_65D6
		move.w	#$10,d0

loc_65D6:
		add.w	($FFFFF700).w,d0
		cmp.w	($FFFFF72A).w,d0
		blt.s	loc_65E4
		move.w	($FFFFF72A).w,d0

loc_65E4:
		move.w	d0,d1
		sub.w	($FFFFF700).w,d1
		asl.w	#8,d1
		move.w	d0,($FFFFF700).w
		move.w	d1,($FFFFF73A).w
		rts	
; ===========================================================================

loc_65F6:				; XREF: ScrollHoriz2
		cmpi.w	#-$10,d0
		bcc.s	@cont
		move.w	#-$10,d0	
		
@cont:
		add.w	($FFFFF700).w,d0
		cmp.w	($FFFFF728).w,d0
		bgt.s	loc_65E4
		move.w	($FFFFF728).w,d0
		bra.s	loc_65E4
; End of function ScrollHoriz2

; ===========================================================================
		tst.w	d0
		bpl.s	loc_6610
		move.w	#-2,d0
		bra.s	loc_65F6
; ===========================================================================

loc_6610:
		move.w	#2,d0
		bra.s	loc_65CC

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level vertically as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollVertical:				; XREF: DeformBgLayer
		; one part of the Labyrinthy Place camera code (the other half is in Resize_LZ2)
		cmpi.w	#$101,($FFFFFE10).w	; is level LZ2?
		bne.s	SV_NotLZ2		; if not, branch
		tst.b 	($FFFFFFFE).w
		beq.w	SV_NotGHZ2
		move.w	#-$250,($FFFFF73C).w	; move background up
		cmpi.b	#1,($FFFFFF97).w	; was first lamppost passed?
		beq.s	SV_Lamppost		; if yes, branch
		cmpi.b	#3,($FFFFFF97).w	; was third lamppost passed?
		beq.s	SV_Lamppost		; if yes, branch
		tst.b	($FFFFFF96).w		; Sonic on a spring?
		bne.s	SV_NotLZ2		; if yes, branch
		btst	#1,($FFFFD022).w	; is Sonic on the ground?
		beq.s	SV_NotLZ2		; if yes, branch
		rts				; otherwise don't move camera
; ---------------------------------------------------------------------------
		
SV_Lamppost:
		move.w	#$250,($FFFFF73C).w	; move background down

SV_NotLZ2:
		cmpi.w	#$001,($FFFFFE10).w	; is level GHZ2 (intro level)?
		bne.s	SV_NotGHZ2		; if not, branch
	;	cmpi.b	#3,($FFFFFFB4).w	; is sonic jumped on a spring 3 times yet?
	;	blt.s	SV_NotGHZ2		; if not, branch
		cmpi.w	#$19C0,($FFFFF700).w	; is camera at the part yet?
		blo.s	SV_NotGHZ2		; if not, branch
		rts				; don't move camera vertically
; ===========================================================================

SV_NotGHZ2:
		moveq	#0,d1
		moveq	#0,d0			; clear d0
		move.w	($FFFFD00C).w,d0	; get Sonic's Y position

		cmpi.w	#$101,($FFFFFE10).w	; is level LZ2?
		bne.s	SV_NotLZ2_2		; if not, branch
		tst.b 	($FFFFFFFE).w
		beq.w	SV_NotLZ2_2
		subi.w	#$45,d0			; substract $45 pixels from Sonic's cam position
		cmpi.b	#1,($FFFFFF97).w
		beq.s	@cont
		cmpi.b	#3,($FFFFFF97).w
		beq.s	@cont
		bra.s	SV_NotLZ2_2

@cont:
		addi.w	#$45,d0			; vertical camera offset when moving down in LZ

SV_NotLZ2_2:
		sub.w	($FFFFF704).w,d0	; sub current Y position from Sonic's Y position
		btst	#2,($FFFFD022).w 	; is Sonic jumping or rolling?
		beq.s	loc_662A
		subq.w	#5,d0

loc_662A:
		btst	#1,($FFFFD022).w	; is Sonic in air?
		beq.s	loc_664A
		addi.w	#$20,d0
		sub.w	($FFFFF73E).w,d0
		bcs.s	loc_6696
		subi.w	#$40,d0
		bcc.s	loc_6696
		tst.b	($FFFFF75C).w
		bne.s	loc_66A8
		bra.s	loc_6656
; ===========================================================================

loc_664A:
		sub.w	($FFFFF73E).w,d0
		bne.s	loc_665C
		tst.b	($FFFFF75C).w
		bne.s	loc_66A8

loc_6656:
		cmpi.w	#$101,($FFFFFE10).w	; is level LZ2?
		bne.s	@cont			; if not, branch
		tst.b 	($FFFFFFFE).w		; is =P monitor active?
		bne.s	@cont2			; if yes, branch
@cont:	
		clr.w	($FFFFF73C).w 		; clear camera Y-shift
@cont2:
		rts
; ===========================================================================

loc_665C:
		cmpi.w	#$60,($FFFFF73E).w
		bne.s	loc_6684
		move.w	($FFFFD014).w,d1
		bpl.s	loc_666C
		neg.w	d1

loc_666C:
		move.w	#$1000,d1
		cmpi.w	#$10,d0
		bgt.s	loc_66F6
		cmpi.w	#-$10,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_6684:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_66F6
		cmpi.w	#-2,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_6696:
		move.w	#$1000,d1
		cmpi.w	#$10,d0
		bgt.s	loc_66F6
		cmpi.w	#-$10,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_66A8:
		moveq	#0,d0
		move.b	d0,($FFFFF75C).w

loc_66AE:
		moveq	#0,d1
		move.w	d0,d1
		add.w	($FFFFF704).w,d1
		tst.w	d0
		bpl.w	loc_6700
		bra.w	loc_66CC
; ===========================================================================

loc_66C0:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	($FFFFF704).w,d1
		swap	d1

loc_66CC:
		cmp.w	($FFFFF72C).w,d1
		bgt.s	ScrVert_SetFinal
		cmpi.w	#-$100,d1
		bgt.s	loc_66F0
		andi.w	#$7FF,d1
		andi.w	#$7FF,($FFFFD00C).w
		andi.w	#$7FF,($FFFFF704).w
		andi.w	#$3FF,($FFFFF70C).w
		bra.s	ScrVert_SetFinal
; ===========================================================================

loc_66F0:
		move.w	($FFFFF72C).w,d1
		bra.s	ScrVert_SetFinal
; ===========================================================================

loc_66F6:
		ext.l	d1
		asl.l	#8,d1
		add.l	($FFFFF704).w,d1
		swap	d1

loc_6700:
		cmp.w	($FFFFF72E).w,d1
		blt.s	ScrVert_SetFinal
		subi.w	#$800,d1
		bcs.s	loc_6720
		andi.w	#$7FF,($FFFFD00C).w
		subi.w	#$800,($FFFFF704).w
		andi.w	#$3FF,($FFFFF70C).w
		bra.s	ScrVert_SetFinal
; ===========================================================================

loc_6720:
		move.w	($FFFFF72E).w,d1	; set y-pos to bottom boundary
; ---------------------------------------------------------------------------

ScrVert_SetFinal:
		swap	d1
		move.l	d1,d3
		sub.l	($FFFFF704).w,d3
		ror.l	#8,d3

		cmpi.w	#$101,($FFFFFE10).w	; is level LZ2?
		bne.s	@notlz			; if not, branch
		tst.b 	($FFFFFFFE).w		; is =P monitor active?
		bne.s	@yfinal			; if yes, branch
@notlz:
		move.w	d3,($FFFFF73C).w	; set number of pixels scrolled vertically this frame
@yfinal:
		move.l	d1,($FFFFF704).w	; set new camera Y position
		rts	
; End of function ScrollVertical