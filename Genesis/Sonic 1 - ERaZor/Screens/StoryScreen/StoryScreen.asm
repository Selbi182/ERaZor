; ---------------------------------------------------------------------------
; Story Text Screens
; ---------------------------------------------------------------------------

STS_LineLength = 28

STS_LinesMain = 15
STS_LinesExtra = 5
STS_LinesTotal = STS_LinesMain + STS_LinesExtra

StoryScreen:				; XREF: GameModeArray
	;	move.b	#$E4,d0
	;	bsr	PlaySound_Special ; stop music
		jsr	ClearPLC
		jsr	Pal_FadeFrom
		move	#$2700,sr
	;	bsr	SoundDriverLoad
		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

STS_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,STS_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0
				
		btst	#1,($FFFFFF92).w	; are story text screens enabled?
		bne.s	@cont			; if yes, branch
		cmpi.b	#9,($FFFFFF9E).w	; is this the easter egg?
		beq.s	@cont			; if not, don't skip cause that's the whole point lmao
		move.b	#1,($FFFFFF7D).w	; make sure the chapters screen leads us to the correct level
		bra.w	STS_ExitScreen		; auto-skip the cringe

@cont:
		move	#$2700,sr
		move.l	#$40000001,($C00004).l
		lea	(Nem_StoryBG).l,a0 ; load Info	screen patterns
		jsr	NemDec
		lea	($C00000).l,a6
		move.l	#$50000003,4(a6)
	;	lea	(Art_Text).l,a5
		lea	(STS_FontArt).l,a5
		move.w	#$28F,d1

STS_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,STS_LoadText ; load uncompressed text patterns

		jsr	Pal_FadeFrom

		move	#$2700,sr
		lea	($FF0000).l,a1
		lea	(Eni_StoryBG).l,a0 ; load	Info screen mappings
		move.w	#0,d0
		jsr	EniDec
		lea	($FF0000).l,a1
		move.l	#$42060003,d0
		moveq	#$21,d1
		moveq	#$15,d2
		jsr	ShowVDPGraphics

		moveq	#$14,d0
		jsr	PalLoad2	; load level select pallet

		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.w	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w		
				
		lea	($FFFFCA00).w,a1	; set location for the text
		moveq	#0,d0
		move.w	#559,d1			; do it for all 504 chars

STS_MakeFF:
		move.b	d0,(a1)+		; put $FF into current spot
		dbf	d1,STS_MakeFF	; loop


		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

STS_ClrScroll:
		move.l	d0,(a1)+
		dbf	d1,STS_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1

STS_ClrVram:
		move.l	d0,(a6)
		dbf	d1,STS_ClrVram ; fill	VRAM with 0
		move.w	#STS_LinesTotal,($FFFFFF82).w
		display_enable

; ===========================================================================
; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
StoryScreen_MainLoop:
		move.b	#2,($FFFFF62A).w
		jsr	DelayProgram
		jsr	SineWavePalette
		jsr	RunPLC_RAM
		tst.l	($FFFFF680).w
		bne.s	StoryScreen_MainLoop
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (STS_NoMore)?
		bne.s	STS_NoTextChange	; if yes, branch
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	STS_NoStart		; if not, branch
		move.b	#1,($FFFFFF9B).w
		bsr	StoryTextLoad		; update text
		bra.s	StoryScreen_MainLoop	; if not, branch
; ===========================================================================

STS_NoStart:
		subq.b	#1,($FFFFFF95).w	; sub 1 from delay
		bpl.s	STS_NoTextChange	; if time remains, branch (comment out to remove delay entirly)
		bsr	StoryTextLoad		; update text
		move.b	#1,($FFFFFF95).w	; reset delay timer
		cmpi.b	#6,($FFFFFF9A).w
		beq.s	@cont
		move.b	#2,($FFFFFF95).w

@cont:
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (STS_NoMore)?
		bne.s	STS_NoTextChange	; if yes, branch
		bra.s	StoryScreen_MainLoop
; ===========================================================================

STS_NoTextChange:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	StoryScreen_MainLoop	; if not, branch
; ===========================================================================

STS_ExitScreen:
		cmpi.b	#1,($FFFFFF9E).w	; is this the intro-dialouge?
		bne.s	STS_NoIntro		; if not, branch
		cmpi.b	#1,($FFFFFFA7).w	; is this the first time visiting the tutorial?
		bgt.s	@notfirstvisit		; if not, branch
		move.b	#1,($FFFFFFA7).w	; run first chapter screen
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	#1,($200000+SRAM_Chapter).l	; save chapter to SRAM
		move.b	#0,($A130F1).l		; disable SRAM
@notfirstvisit:
		move.b	#$28,($FFFFF600).w	; set to chapters screen ($28)
		rts

STS_NoIntro:
		cmpi.b	#8,($FFFFFF9E).w	; is this the ending sequence?
		bne.s	STS_NoEnding		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts

STS_NoEnding:
		cmpi.b	#9,($FFFFFF9E).w	; is this the easter egg?
		bne.s	STS_NoEaster		; if not, branch
		move.w	#$302,($FFFFFE10).w	; set level to SLZ3
		move.b	#$C,($FFFFF600).w
		move.w	#1,($FFFFFE02).w	; restart level
		rts

STS_NoEaster:
		cmpi.b	#$A,($FFFFFF9E).w	; is this the black special stage?
		bne.s	STS_NoBlack		; if not, branch
		move.b	#$00,($FFFFF600).w	; set to sega screen ($00)
		rts

STS_NoBlack:
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.w	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w
		jmp	NextLevelX
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to load story text
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


StoryTextLoad:
		bsr	GetStoryText
		lea	($FFFFCA00).w,a1		
		lea	($C00000).l,a6
		move.l	#$620C0003,d4	; screen position (text)
		move.w	#$E680,d3	; VRAM setting
		moveq	#STS_LinesTotal,d1		; number of lines of text


loc3_34FE:
		move.l	d4,4(a6)
		bsr	STS_ChgLine
		addi.l	#$800000,d4
		dbf	d1,loc3_34FE
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
	;	move.w	#1,d0
		move.w	d0,d1
		move.l	#$620C0003,d4
		lsl.w	#7,d0
		swap	d0
		add.l	d0,d4
		lea	($FFFFCA00).w,a1
		lsl.w	#3,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		adda.w	d1,a1
		move.w	#$C680,d3
		move.l	d4,4(a6)

		lea	($FFFFCC32).w,a1	; set location
		bsr	STS_ChgLine
		move.w	#$C680,d3

loc3_3550:
		rts	
; End of function StoryTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

STS_ChgLine:				; XREF: StoryTextLoad
		moveq	#$1B,d2		; number of characters per line $17 $1B

loc3_3588:
		moveq	#0,d0
		move.b	(a1)+,d0
		bpl.s	loc3_3598
		move.w	#0,(a6)
		dbf	d2,loc3_3588
		rts	
; ===========================================================================

loc3_3598:				; XREF: STS_ChgLine
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc3_3588
		rts	
; End of function STS_ChgLine

; ===========================================================================
; ===========================================================================
STS_Sound = $D8
STS_Speed = 1
STS_LagSpeed = 10
; ===========================================================================
; ===========================================================================

GetStoryText:
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (STS_NoMore)?
		beq.w	STS_LoadUp		; if yes, branch
		
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA00).w,a1	; load destination location to a1
		lea	(STS_HeaderX).l,a2	; get text location 1
		move.w	#83,d5			; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Header1XX:
		move.b	(a2)+,d3		; load current char to a1

		cmpi.b	#'<',d3
		bne.s	@0
		move.b	#6,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@0		cmpi.b	#'~',d3
		bne.s	@1
		move.b	#7,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@1		cmpi.b	#'#',d3
		bne.s	@2
		move.b	#8,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@2	



		cmpi.b	#$20,d3
		beq.s	STS_Loop_H1_SpaceXX
		cmpi.b	#$3D,d3
		beq.s	STS_Loop_H1_EqualXX
		subi.b	#$36,d3
		bra.s	STS_Loop_H1_NoSpaceXX
		
STS_Loop_H1_EqualXX:
		move.b	#$25,d3
		bra.s	STS_Loop_H1_NoSpaceXX

STS_Loop_H1_SpaceXX:
		move.b	#$00,d3

STS_Loop_H1_NoSpaceXX:
		move.b	d3,(a1)+
		dbf	d5,STS_Loop_Header1XX	; loop

; =============================

		bsr.w	STS_SetMainText
STS_Loop_MainXX:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	STS_DoNext1XX		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	STS_NoDot1XX		; if not, go to next char
		move.b	#$26,d3
		bra.s	STS_NoNumber1XX

STS_NoDot1XX:
		cmpi.b	#$3F,d3			; is current char a question mark?
		bne.s	STS_NoQMark1xx		; if not, branch
		move.b	#$28,d3
		bra.s	STS_NoNumber1xx

STS_NoQMark1xx:
		cmpi.b	#"!",d3			; is current char an exclamation mark?
		bne.s	STS_NoExMark1xx		; if not, branch
		move.b	#$0A,d3
		bra.s	STS_NoNumber1xx

STS_NoExMark1xx:
		cmpi.b	#$2C,d3			; is current char a comma?
		bne.s	STS_NoComma1xx		; if not, branch
		move.b	#$27,d3
		bra.s	STS_NoNumber1xx

STS_NoComma1xx:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	STS_NoSpace1XX		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	STS_Loop_MainXX	; loop without taking time

STS_NoSpace1XX:
		cmpi.b	#$61,d3			; is current char an uncapitalized letter?
		blt.s	STS_NoUncapiXX		; if not, branch
		subi.b	#$20,d3			; use same font as capitalized letters

STS_NoUncapiXX:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	STS_NoNumber1XX	; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

STS_NoNumber1XX:
		move.b	d3,(a1)+		; load output to a1
		bra.s	STS_Loop_MainXX	; loop

; =============================

STS_DoNext1XX:
		lea	(STS_ContinueX).l,a2	; get text location 1
		move.w	#84,d5			; set numbers of loops (this will make the "typing" effect)
STS_Loop_ContinueXX:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	STS_NoDot2XX		; if not, go to next char
		move.b	#$26,d3
		bra.s	STS_NoNumber2XX

STS_NoDot2XX:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	STS_NoSpace2XX		; if not, go to next char
		move.b	#$00,d3			; load space char to a1		
		bra.s	STS_NoNumber2XX	; loop without taking time

STS_NoSpace2XX:
		subi.b	#$36,d3			; substract $36 from d3 (because it's in ascii)
		
STS_NoNumber2XX:

		move.b	d3,(a1)+		; load output to a1
		dbf	d5,STS_Loop_ContinueXX	; loop

		rts
; ===========================================================================
; ===========================================================================

STS_SetMainText:
		moveq	#0,d0			; clear d0
		lea	(StoryText_1).l,a2	; get text location 1 (which is also the start of the text locations in general)
		move.b	($FFFFFF9E).w,d0 	; get text ID
		subq.b	#1,d0			; sub 1 from it, because we want to use 0 as base, not 1
		bpl.s	@0
		moveq	#0,d0			; make sure we never get any illegal values from underflows
@0:
		mulu.w	#422,d0			; multiply it by 422 (number of chars for a single block of text including the $FF)
		adda.w	d0,a2			; add result to text location (a2)
	
		; center the text using H-scroll
		movea.l	a2,a3			; copy text location to a3
		lea	($FFFFCCE0).w,a4	; set up H-scroll buffer to a4
		moveq	#STS_LineLength,d3	; set line length to d3
		moveq	#STS_LinesMain-1,d4	; set loop count of line count
@centertextloop:
		moveq	#0,d5			; clear d5
		adda.w	d3,a3			; add line length to the offset (so we start at the end)
@findlineend:
		cmpi.b	#' ',-(a3)		; is current character a space?
		bne.s	@foundend		; if yes, we found the end of the line, branch
		addq.l	#1,d5
		bra.s	@findlineend		; loop until we found the end
@foundend:
		move.l	d5,d6
		lsl.l	#2,d6			; multiply by 4px per space
		rept	8			; 8 scanlines (one row)
		move.l	d6,(a4)+		; write to scroll buffer (line 1)
		endr
		
		adda.l	d5,a3
		adda.l	#1,a3
		dbf	d4,@centertextloop

		rts				; return
; ===========================================================================
; ===========================================================================

STS_LoadUp:
		moveq	#0,d0			; clear d0
		move.b	($FFFFFF9A).w,d0	; get index number
		move.w	STS_Index(pc,d0.w),d1 ; get current index
		jmp	STS_Index(pc,d1.w)	; jump to set position
; ===========================================================================
STS_Index:	dc.w STS_Header1-STS_Index
		dc.w STS_Header2-STS_Index
		dc.w STS_Lag-STS_Index
		dc.w STS_MainText-STS_Index
		dc.w STS_Lag-STS_Index
		dc.w STS_ContinueText-STS_Index
		dc.w STS_NoMore-STS_Index
; ===========================================================================

STS_Header1:
		addq.w	#STS_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA00).w,a1	; load destination location to a1
		lea	(STS_HeaderText1).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Header1:
		move.b	(a2)+,d3		; load current char to a1
		cmpi.b	#$20,d3
		beq.s	STS_Loop_H1_Space
		subi.b	#$18,d3
		bra.s	STS_Loop_H1_NoSpace

STS_Loop_H1_Space:
		move.b	#$00,d3

STS_Loop_H1_NoSpace:
		move.b	d3,(a1)+
		dbf	d5,STS_Loop_Header1	; loop

		lea	($FFFFCA1C).w,a1	; load destination location to a1
		lea	(STS_HeaderText2).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Header2:
		move.b	(a2)+,d3		; load current char to a1
		cmpi.b	#'<',d3
		bne.s	@0
		move.b	#6,d3
@0		cmpi.b	#'~',d3
		bne.s	@1
		move.b	#7,d3
@1		cmpi.b	#'#',d3
		bne.s	@2
		move.b	#8,d3
@2	
		move.b	d3,(a1)+
		dbf	d5,STS_Loop_Header2	; loop
		
		move.l	#$00,($FFFFCA38).w
		move.l	#$00,($FFFFCA3C).w

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	STS_MultiReturn
		move.b	#STS_Sound,d0
		jsr	PlaySound_Special
		
		cmpi.w	#28,($FFFFFF96).w	; has char 71 been reached?
		bge.s	STS_DoNextHeader	; if yes, branch
		rts				; otherwise return
; ---------------------------------------------------------------------------

STS_DoNextHeader:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	STS_LoadUp		; kind of return
; ===========================================================================

STS_Header2:
		addq.w	#STS_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA08).w,a1	; load destination location to a1
		lea	(STS_HeaderText3).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Header3:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$58,d3			; has the end of the list been reached?	
		beq.s	STS_DoLag		; if yes, branch
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	STS_NoSpaceX2		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	STS_Loop_Header3	; loop without taking time

STS_NoSpaceX2:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	STS_NoNumberX2		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

STS_NoNumberX2:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,STS_Loop_Header3	; loop

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	STS_MultiReturn
		move.b	#STS_Sound,d0
		jsr	PlaySound_Special

		cmpi.w	#10,($FFFFFF96).w	; has char 71 been reached?
		bge.s	STS_DoLag		; if yes, branch
		rts				; otherwise return
; ---------------------------------------------------------------------------

STS_DoLag:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	STS_LoadUp		; kind of return
; ===========================================================================

STS_Lag:
		addq.w	#1,($FFFFFF96).w
		cmpi.w	#STS_LagSpeed,($FFFFFF96).w
		bge.s	STS_DoMain
		rts
; ---------------------------------------------------------------------------

STS_DoMain:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	STS_LoadUp		; kind of return
; ===========================================================================
		

STS_MainText:
		addq.w	#STS_Speed+1,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA54).w,a1	; load destination location to a1
		bsr.w	STS_SetMainText
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Main:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	STS_DoNext1		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	STS_NoDot1		; if not, go to next char
		move.b	#$26,d3
		bra.s	STS_NoNumber1

STS_NoDot1:
		cmpi.b	#$3F,d3			; is current char a question mark?
		bne.s	STS_NoQMark1		; if not, branch
		move.b	#$28,d3
		bra.s	STS_NoNumber1

STS_NoQMark1:
		cmpi.b	#"!",d3			; is current char an exclamation mark?
		bne.s	STS_NoExMark1		; if not, branch
		move.b	#$0A,d3
		bra.s	STS_NoNumber1

STS_NoExMark1:
		cmpi.b	#$2C,d3			; is current char a comma?
		bne.s	STS_NoComma1		; if not, branch
		move.b	#$27,d3
		bra.s	STS_NoNumber1

STS_NoComma1:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	STS_NoSpace1		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	STS_Loop_Main		; loop without taking time

STS_NoSpace1:
		cmpi.b	#$61,d3			; is current char an uncapitalized letter?
		blt.s	STS_NoUncapi		; if not, branch
		subi.b	#$20,d3			; use same font as capitalized letters

STS_NoUncapi:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	STS_NoNumber1		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

STS_NoNumber1:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,STS_Loop_Main	; loop

		move.b	#STS_Sound,d0
		jsr	PlaySound_Special
	;	cmpi.w	#532,($FFFFFF96).w	; has last char been reached?
	;	bge.s	STS_DoNext2		; if yes, branch

STS_MultiReturn:
		rts				; return
; ---------------------------------------------------------------------------

STS_DoNext1:
		clr.w	($FFFFFF96).w		; clear counter for the next time
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	STS_LoadUp		; kind of return
; ===========================================================================

STS_ContinueText:
		addq.w	#STS_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCC32).w,a1	; load destination location to a1
		lea	(STS_Continue).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Continue:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	STS_DoNext2		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	STS_NoDot2		; if not, go to next char
		move.b	#$26,d3
		bra.s	STS_NoNumber2

STS_NoDot2:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	STS_NoSpace2		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	STS_Loop_Continue	; loop without taking time

STS_NoSpace2:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	STS_NoNumber2		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

STS_NoNumber2:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,STS_Loop_Continue	; loop

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	STS_MultiReturn
		move.b	#STS_Sound,d0
		jsr	PlaySound_Special

		rts				; otherwise return
; ---------------------------------------------------------------------------

STS_DoNext2:
		clr.w	($FFFFFF96).w		; clear counter for the next time
		addq.b	#2,($FFFFFF9A).w	; go to next text
		move.b	#1,($FFFFFF9B).w	; set "done" flag
		move.b	#4,($FFFFFF9A).w	; increase routine counter

STS_NoMore:
		rts				; return
; ===========================================================================
; ===========================================================================
; ===========================================================================

STS_HeaderX:		dc.b	'        SONIC ERAZOR        '
			dc.b	'<~~~~~~~~~~~~~~~~~~~~~~~~~~#'
			dc.b	'                            '
			even

STS_ContinueX:		dc.b	'                            '
			dc.b	'                              '
			dc.b	' PRESS START TO CONTINUE... '
			even
; ---------------------------------------------------------------------------

STS_HeaderText1:	dc.b	'                            '
			even

STS_HeaderText2:	dc.b	'<~~~~~~~~~~~~~~~~~~~~~~~~~~#'
			even

STS_HeaderText3:	dc.b	'SONIC ERAZORX'
			even
; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		dc.b	'THE SPIKED SUCKER DECIDED   ' ;1
		dc.b	'TO GO BACK TO THE HILLS AND ' ;1
		dc.b	'CHECK OUT WHAT WAS GOING ON.' ;0
		dc.b	'                            ' ;0
		dc.b	'WHEN SUDDENLY...            ' ;0
		dc.b	'EXPLOSIONS! EVERYWHERE!     ' ;1
		dc.b	'A GRAY METALLIC BUZZ BOMBER ' ;1
		dc.b	'SHOWERED EXPLODING BOMBS ON ' ;1
		dc.b	'HIM! SONIC ESCAPED IT, BUT  ' ;0
		dc.b	'MINDLESSLY FELL INTO A RING ' ;1
		dc.b	'TRAP AND LANDED IN A        ' ;0
		dc.b	'STRANGE PARALLEL DIMENSION. ' ;1
		dc.b	'                            ' ;0
		dc.b	'HE NEEDS TO BLAST HIS WAY TO' ;0
		dc.b	'EGGMAN AND ESCAPE IT...     ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		dc.b	'TELEPORTING WATERFALLS,     ' ;1
		dc.b	'CRABMEATS WITH EXPLODING    ' ;0
		dc.b	'BALLS, AND THE ORIGINAL     ' ;1
		dc.b	'GREEN HILL ZONE TRANSFORMED ' ;1
		dc.b	'INTO AN ACTION MOVIE OR     ' ;1
		dc.b	'SOMETHING. TOP IT OFF WITH  ' ;1
		dc.b	'EGGMAN AND HIS THREE SPIKED ' ;1
		dc.b	'BALLS OF STEEL, AND YOU CAN ' ;1
		dc.b	'TELL SONIC ISN\T EXACTLY    ' ;0
		dc.b	'HAVING THE TIME OF HIS LIFE.' ;1
		dc.b	'                            ' ;1
		dc.b	'BUT HEY, I HEARD THEY\VE GOT' ;0
		dc.b	'A BUNCH OF EMERALDS NEARBY? ' ;0
		dc.b	'WOULD BE A REAL SHAME IF YOU' ;1
		dc.b	'MISSED YOUR GOAL.           ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_3:	; text after beating Special Place
		dc.b	'WOW, ALREADY 4 EMERALDS     ' ;1
		dc.b	'COLLECTED, AND SONIC DOESN\T' ;0
		dc.b	'EVEN KNOW WHY HE NEEDS THEM.' ;0
		dc.b	'                            ' ;0
		dc.b	'FRANKLY, I GOT NO IDEA. HOW ' ;0
		dc.b	'ELSE SHOULD I END THIS      ' ;0
		dc.b	'STAGE? WITH A BLOODY PARADE?' ;1
		dc.b	'HOW ABOUT A COOKIE TOO?     ' ;0
		dc.b	'CATCH ME A BREAK HERE.      ' ;0
		dc.b	'                            ' ;0
		dc.b	'ANYWAY, LISTEN. WHATEVER YOU' ;0
		dc.b	'DO, STAY AWAY FROM ANY      ' ;1
		dc.b	'SUSPICIOUS MONITORS!        ' ;1
		dc.b	'WHO KNOWS WHAT INHUMANITY   ' ;1
		dc.b	'LIES IN THERE...            ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_4:	; text after beating Ruined Place
		dc.b	'YOU DIDN\T LISTEN. WHAT A   ' ;1
		dc.b	'FOOL. WELL, AT LEAST YOUR   ' ;1
		dc.b	'PATHETIC EFFORTS SHOOTING   ' ;0
		dc.b	'YOURSELF THROUGH A MAZE OF  ' ;0
		dc.b	'SPIKES MADE FOR QUITE AN    ' ;1
		dc.b	'ENTERTAINING WATCH. REALLY, ' ;1
		dc.b	'I THINK YOU\VE GOT A GREAT  ' ;0
		dc.b	'CAREER AS A COMMEDIAN AHEAD!' ;0
		dc.b	'                            ' ;0
		dc.b	'ACTUALLY, THAT GIVES ME AN  ' ;1
		dc.b	'IDEA. LET\S SEE WHAT HAPPENS' ;1
		dc.b	'WHEN THE CAMERA GUIDES THE  ' ;1
		dc.b	'NARRATIVE. I SURE HOPE YOU  ' ;0
		dc.b	'DON\T FEEL TOO DOWN, BECAUSE' ;1
		dc.b	'THINGS CAN ONLY GO UP...    ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_5:	; text after beating Labyrinth Place
		dc.b	'MAN, IF YOU COULD SEE YOUR  ' ;0
		dc.b	'FACE RIGHT NOW! PRICELESS!  ' ;0
		dc.b	'                            ' ;0
		dc.b	'WELL, OUR CAMERA CREW WILL  ' ;0
		dc.b	'MAKE ENOUGH CASH FROM THAT  ' ;0
		dc.b	'PATHETIC ATTEMPT OF YOURS   ' ;0
		dc.b	'TO LAST FOR A LIFETIME.     ' ;0
		dc.b	'SO, NO MORE FUNKY CAMERA    ' ;0
		dc.b	'BUSINESS. PINKY PROMISE.    ' ;0
		dc.b	'                            ' ;1
		dc.b	'BUT YOU HAVE KILLED THE     ' ;1
		dc.b	'JAWS OF DESTINY             ' ;1
		dc.b	'AND THEREFORE MUST BE SERVED' ;0
		dc.b	'THE ULTIMATE PUNISHMENT:    ' ;1
		dc.b	'AN AUTOSCROLLER LEVEL.      ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_6:	; text after beating Unreal Place
		dc.b	'IF I SEE SUCH A PATHETIC    ' ;0
		dc.b	'EXCUSE FOR WHAT YOU CALL    ' ;0
		dc.b	'SKILL AGAIN, I WILL GO AHEAD' ;1
		dc.b	'AND DISABLE THE CHECKPOINTS ' ;0
		dc.b	'UNTIL YOU CAN DO THE ENTIRE ' ;1
		dc.b	'STAGE BLINDFOLDED!          ' ;0
		dc.b	'                            ' ;1
		dc.b	'BUT HEY, YOU COLLECTED ALL  ' ;0
		dc.b	'SIX EMERALDS, SO THAT MEANS ' ;1
		dc.b	'YOU GO TO SPACE NOW! LIKE IN' ;0
		dc.b	'EVERY OTHER SONIC GAME!     ' ;1
		dc.b	'                            ' ;0
		dc.b	'JUST REMEMBER ONE THING:    ' ;1
		dc.b	'IN SPACE, NO ONE CAN HEAR   ' ;0
		dc.b	'YOU SCREAM FOR HELP.        ' ;0
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_7:	; text after beating Scar Night Place
		dc.b	'WORD OF ADVICE:             ' ;0
		dc.b	'TOO MUCH SCREAMING ISN\T    ' ;0
		dc.b	'GOOD FOR YOUR VOCAL CORDS.  ' ;0
		dc.b	'YOU CLEARLY DIDN\T PAY ANY  ' ;1
		dc.b	'ATTENTION TO WHAT I SAID    ' ;1
		dc.b	'EARLIER ABOUT NOBODY BEING  ' ;1
		dc.b	'ABLE TO HEAR YOU IN SPACE.  ' ;0
		dc.b	'MORON. BUT I GET IT, I ALSO ' ;0
		dc.b	'SCREAM IN EXCITEMENT IF I   ' ;1
		dc.b	'PLAY A BUZZ WIRE GAME!      ' ;0
		dc.b	'                            ' ;0
		dc.b	'I HOPE YOUR ANGELIC VOICE   ' ;0
		dc.b	'CAN BE HEARD ONE MORE TIME  ' ;0
		dc.b	'IN THE FINALE! IT IS THE    ' ;0
		dc.b	'FINALE, OR?                 ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_8:	; text after jumping in the ring for the Ending Sequence
		dc.b	'THE WORLD IS RESCUED!       ' ;1
		dc.b	'ANIMALS JUMP AROUND AND     ' ;1
		dc.b	'SPREAD THEIR HAPPINESS BY   ' ;1
		dc.b	'JUMPING OFF CLIFFS!         ' ;1
		dc.b	'                            ' ;0
		dc.b	'SONIC DECIDED TO MAKE ONE   ' ;1
		dc.b	'QUICK FINAL RUN THROUGH THE ' ;1
		dc.b	'HILLS, WHERE IT ALL STARTED,' ;1
		dc.b	'TO CELEBRATE HIS AND YOUR   ' ;1
		dc.b	'HARD EFFORTS. WITHOUT YOUR  ' ;0
		dc.b	'HELP, THIS WOULD HAVE       ' ;1
		dc.b	'NEVER HAPPENED!             ' ;1
		dc.b	'                            ' ;0
		dc.b	'NOW WATCH SONIC ARRIVE AT   ' ;1
		dc.b	'HIS WELL DESERVED PARTY...  ' ;0
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_9:	; "One Hot Night", Tongara's hidden easter egg fanfic 
		dc.b	'I REMEMBER WHEN I STUCK MY  ' ;0
		dc.b	'DICK INSIDE *******. WHAT A ' ;1
		dc.b	'MAGICAL DAY IT WAS! ********' ;0
		dc.b	'GOT SO JEALOUS. SO HE       ' ;1
		dc.b	'DECIDED TO STICK HIS DICK IN' ;0
		dc.b	'**********. HE ENJOYED THIS.' ;0
		dc.b	'IT MADE HIM FEEL HOT. ******' ;0
		dc.b	'THEN WALKED INTO THE ROOM,  ' ;0
		dc.b	'UNEXPECTEDLY. HE GOT WET    ' ;1
		dc.b	'THE INSTANT HE SAW ******   ' ;0
		dc.b	'ON THE FLOOR NAKED. THEY HAD' ;0
		dc.b	'A MAGICAL NIGHT OF LOVE     ' ;1
		dc.b	'MAKING. AND THEN, *******   ' ;1
		dc.b	'DIED AND EVERYONE WAS HAPPY.' ;0
		dc.b	'THE END!                    ' ;0
		dc.b	$FF
		even

StoryText_A:
		; "The Morning After", the second half of the fanfic, for the weirdos that dig through the source in a hex editor or something lol
		dc.b	'THE MORNING SUN ROSE.       ' ;1
		dc.b	'IT WAS BEAUTIFUL.           ' ;1
		dc.b	'THE SUN SHONE DOWN INTO     ' ;1
		dc.b	'THE ROOM, WHERE ALL THE     ' ;1
		dc.b	'LOVE MAKERS SLEPT.          ' ;0
		dc.b	'****** AWOKE NEXT TO        ' ;0
		dc.b	'THE ROTTING BODY OF *******,' ;0
		dc.b	'BAKING IN THE SUN.          ' ;0
		dc.b	'IT MADE HIM HORNY.          ' ;0
		dc.b	'HE TURNED ******* OVER AND  ' ;0
		dc.b	'MADE LOVE TO HIS ANUS.      ' ;0
		dc.b	'WHAT A MAGICAL ANUS IT WAS! ' ;1
		dc.b	'HE THEN CAME.               ' ;1
		dc.b	'                            ' ;0
		dc.b	'THE END!                    ' ;0
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_B:	; hidden easter egg text found after the blackout special stage
		dc.b	'CONGRATULATIONS!            ' ;0
		dc.b	'                            ' ;0
		dc.b	'YOU HAVE BEATEN THE         ' ;1
		dc.b	'BLACKOUT CHALLENGE.         ' ;1
		dc.b	'                            ' ;0
		dc.b	'CHECK OUT THE OPTIONS MENU, ' ;1
		dc.b	'A NEW COOL FEATURE HAS BEEN ' ;1
		dc.b	'UNLOCKED FOR YOU TO MESS    ' ;0
		dc.b	'AROUND WITH!                ' ;0
		dc.b	'                            ' ;0
		dc.b	'HAVE FUN AND THANK YOU SO   ' ;1
		dc.b	'MUCH FOR PLAYING MY GAME!   ' ;1
		dc.b	'                            ' ;0
		dc.b	'                            ' ;0
		dc.b	'SELBI                       ' ;1
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

STS_Continue:
		dc.b	' PRESS START TO CONTINUE...'
		dc.b	$FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
STS_FontArt:	incbin	Screens\StoryScreen\StoryScreen_Font.bin
		even
; ===========================================================================
Pal_StoryScreen:	incbin	Screens\StoryScreen\StoryScreen_Pal.bin
		even
; ===========================================================================
Nem_StoryBG:	incbin	Screens\StoryScreen\StoryScreen_ArtBG.bin
		even
; ===========================================================================
Eni_StoryBG:	incbin	Screens\StoryScreen\StoryScreen_MapsBG.bin
		even
; ===========================================================================