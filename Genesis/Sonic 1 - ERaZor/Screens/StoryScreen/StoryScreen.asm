; ---------------------------------------------------------------------------
; Story Text Screens
; ---------------------------------------------------------------------------

STS_LineLength = 28

STS_LinesMain = 15
STS_LinesExtra = 5
STS_LinesTotal = STS_LinesMain + STS_LinesExtra

STSBuffer equ $FFFFC900

StoryScreen:				; XREF: GameModeArray
	;	move.b	#$E4,d0
	;	bsr	PlaySound_Special ; stop music
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		move	#$2700,sr
	;	bsr	SoundDriverLoad
		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
STS_ClrObjRam:	move.l	d0,(a1)+
		dbf	d1,STS_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0
				
		btst	#1,($FFFFFF92).w	; are story text screens enabled?
		bne.s	@cont			; if yes, branch
		cmpi.b	#9,($FFFFFF9E).w	; is this the easter egg?
		beq.s	@cont			; if not, don't skip cause that's the whole point lmao
		move.b	#1,($FFFFFF7D).w	; make sure the chapters screen leads us to the correct level
		bra.w	STS_ExitScreen		; auto-skip the cringe

@cont:
		move	#$2700,sr
		jsr	Pal_FadeFrom

		move	#$2700,sr
		move.l	#$64000002,($C00004).l
		lea	(ArtKospM_ERaZorNoBG).l,a0
		jsr	KosPlusMDec_VRAM
		
		moveq	#20,d1
	@delay:	
		jsr	PLC_Execute
		move.b	#2,($FFFFF62A).w
		jsr	DelayProgram
		dbf	d1,@delay
		move	#$2700,sr
		display_disable

		move	#$2700,sr
		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$11E,obX(a0)		; set X-position
		move.w	#$87,obScreenY(a0)	; set Y-position
		bset	#7,obGfx(a0)		; otherwise make object high plane
		
		jsr	ObjectsLoad
		jsr	BuildSprites
		
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$50000003,4(a6)
		lea	(STS_FontArt).l,a5
		move.w	#$28F,d1
STS_LoadText:	move.w	(a5)+,(a6)
		dbf	d1,STS_LoadText ; load uncompressed text patterns

		jsr	BGDeformation_Setup

	;	move.l	#$40000001,($C00004).l
	;	lea	(Nem_StoryBG).l,a0 ; load Info	screen patterns
	;	jsr	NemDec
	;	move	#$2700,sr
	;	lea	($FF0000).l,a1
	;	lea	(Eni_StoryBG).l,a0 ; load	Info screen mappings
	;	move.w	#0,d0
	;	jsr	EniDec
	;	lea	($FF0000).l,a1
	;	move.l	#$42060003,d0
	;	moveq	#$21,d1
	;	moveq	#$15,d2
	;	jsr	ShowVDPGraphics

		moveq	#$14,d0
		jsr	PalLoad1	; load level select pallet
	;	moveq	#2,d0		; load level select palette
	;	jsr	PalLoad2

		movem.l	d0-a2,-(sp)		; backup d0 to a2
		lea	(Pal_ERaZorBanner).l,a1	; set ERaZor banner's palette pointer
		lea	($FFFFFBA0).l,a2	; set palette location
		moveq	#7,d0			; set number of loops to 7
@0:		move.l	(a1)+,(a2)+		; load 2 colours (4 bytes)
		dbf	d0,@0			; loop
		movem.l	(sp)+,d0-a2		; restore d0 to a2

		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.w	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w		
				
		lea	(STSBuffer).w,a1	; set location for the text
		moveq	#0,d0
		move.w	#559+$100,d1			; do it for all 504 chars
STS_MakeFF:	move.b	d0,(a1)+		; put $FF into current spot
		dbf	d1,STS_MakeFF	; loop

		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1
STS_ClrScroll:	move.l	d0,(a1)+
		dbf	d1,STS_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1
STS_ClrVram:	move.l	d0,(a6)
		dbf	d1,STS_ClrVram ; fill	VRAM with 0
		
		move.w	#STS_LinesTotal,($FFFFFF82).w
		display_enable
		jsr	Pal_FadeTo

; ===========================================================================
; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
StoryScreen_MainLoop:
		move.b	#2,($FFFFF62A).w
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
	;	jsr	SineWavePalette
		jsr	PLC_Execute
		jsr	Options_BackgroundEffects
		jsr	Options_ERZPalCycle
		tst.l	PLC_Pointer
		bne.s	StoryScreen_MainLoop


		tst.b	($FFFFFF9B).w		; is is text already fully written out?
		bne.s	STS_NoTextChange	; if yes, branch
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	STS_NoStart		; if not, branch
		move.b	#1,($FFFFFF9B).w	; set text-fully-written flag
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
		tst.b	($FFFFFF9B).w		; is text already fully written out?
		bne.s	STS_NoTextChange	; if yes, branch
		bra.s	StoryScreen_MainLoop
; ===========================================================================

STS_NoTextChange:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	StoryScreen_MainLoop	; if not, branch
; ---------------------------------------------------------------------------

STS_ExitScreen:
		moveq	#0,d2
		jsr	Options_ClearBuffer

		cmpi.b	#1,($FFFFFF9E).w	; is this the intro dialouge?
		bne.s	STS_NoIntro		; if not, branch
		cmpi.b	#1,($FFFFFFA7).w	; is this the first time start of the game?
		bgt.s	@notfirstvisit		; if not, branch
		move.b	#1,($FFFFFFA7).w	; run first chapter screen
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	#1,($200000+SRAM_Chapter).l	; save chapter to SRAM
		move.b	#0,($A130F1).l		; disable SRAM
@notfirstvisit:
		move.b	#4,($FFFFF600).w	; set to title screen
	;	move.b	#$28,($FFFFF600).w	; set to chapters screen ($28)
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
		cmpi.b	#$A,($FFFFFF9E).w	; is this the blackout special stage?
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
		lea	(STSBuffer).w,a1		
		lea	($C00000).l,a6
		move.l	#$620C0003,d4	; screen position (text)
		move.w	#$E680,d3	; VRAM setting
		moveq	#STS_LinesTotal,d1		; number of lines of text
loc3_34FE:
		move.l	d4,4(a6)
		bsr	STS_ChgLine
		addi.l	#$800000,d4
		dbf	d1,loc3_34FE
		
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
		lea	(STSBuffer).w,a1	; load destination location to a1
		lea	(STS_HeaderX).l,a2	; get text location 1
		move.w	#83,d5			; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Header1XX:
		move.b	(a2)+,d3		; load current char to a1

		cmpi.b	#'<',d3
		bne.s	@0
		move.b	#6,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@0:		cmpi.b	#'~',d3
		bne.s	@1
		move.b	#7,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@1:		cmpi.b	#'#',d3
		bne.s	@2
		move.b	#8,d3
		bra.s	STS_Loop_H1_NoSpaceXX
@2:
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

		cmpi.b	#':',d3			; is current char a colon?
		bne.s	STS_NoColon1XX		; if not, go to next char
		move.b	#3,d3
		bra.s	STS_NoNumber1XX

STS_NoColon1XX:
		cmpi.b	#'\',d3			; is current char a backslash?
		bne.s	STS_NoBSlash1XX		; if not, go to next char
		move.b	#2,d3
		bra.s	STS_NoNumber1XX

STS_NoBSlash1XX:
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
		rts
		lea	(STS_ContinueX).l,a2	; get text location 1
		move.w	#84,d5			; set numbers of loops (this will make the "typing" effect)
STS_Loop_ContinueXX:
		move.b	(a2)+,d3		; move current char into d3

		cmpi.b	#':',d3			; is current char a colon?
		bne.s	STS_NoColon2XX		; if not, go to next char
		move.b	#3,d3
		bra.s	STS_NoNumber2XX

STS_NoColon2XX:
		cmpi.b	#'\',d3			; is current char a backslash?
		bne.s	STS_NoBSlash2XX		; if not, go to next char
		move.b	#2,d3
		bra.s	STS_NoNumber2XX

STS_NoBSlash2XX:
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
		bpl.s	@pos			; is it positive? branch
		moveq	#0,d0			; make sure we never get any illegal values from underflows
@pos:
		ext.w	d0			; convert to word
		mulu.w	#422,d0			; multiply it by 422 (number of chars for a single block of text including the $FF)
		adda.w	d0,a2			; add result to text location (a2)
		
		; center the text using H-scroll
		rts	; disabled for now
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
		dc.w STS_Header1-STS_Index
		dc.w STS_Lag-STS_Index
		dc.w STS_MainText-STS_Index
		dc.w STS_Lag-STS_Index
	;	dc.w STS_ContinueText-STS_Index
		dc.w STS_NoMore-STS_Index
; ===========================================================================

STS_Header1:
		addq.w	#STS_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty

		lea	(STSBuffer+$1C).w,a1	; load destination location to a1
		tst.b	($FFFFFF9A).w	; bottom line?
		beq.s	@0
		adda.w	#STS_LineLength*18,a1
@0:
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
		
		; hotfix to get rid of some glitchy vv stuff
		lea	(STSBuffer+$38).w,a1	; load destination location to a1
		tst.b	($FFFFFF9A).w	; bottom line?
		beq.s	@0x
		adda.w	#STS_LineLength*18,a1
@0x:
		move.l	#0,(a1)+
		move.l	#0,(a1)

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
		lea	(STSBuffer+$8).w,a1	; load destination location to a1
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
		lea	(STSBuffer+$54).w,a1	; load destination location to a1
		bsr.w	STS_SetMainText
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Main:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	STS_DoNext1		; if yes, branch


		cmpi.b	#':',d3			; is current char a colon?
		bne.s	STS_NoColon1		; if not, go to next char
		move.b	#3,d3
		bra.s	STS_NoNumber1

STS_NoColon1:
		cmpi.b	#'\',d3			; is current char a backslash?
		bne.s	STS_NoBSlash1		; if not, go to next char
		move.b	#2,d3
		bra.s	STS_NoNumber1

STS_NoBSlash1:
		cmpi.b	#'.',d3			; is current char a dot?
		bne.s	STS_NoDot1		; if not, go to next char
		move.b	#$26,d3
		bra.s	STS_NoNumber1

STS_NoDot1:
		cmpi.b	#'?',d3			; is current char a question mark?
		bne.s	STS_NoQMark1		; if not, branch
		move.b	#$28,d3
		bra.s	STS_NoNumber1

STS_NoQMark1:
		cmpi.b	#"!",d3			; is current char an exclamation mark?
		bne.s	STS_NoExMark1		; if not, branch
		move.b	#$0A,d3
		bra.s	STS_NoNumber1

STS_NoExMark1:
		cmpi.b	#',',d3			; is current char a comma?
		bne.s	STS_NoComma1		; if not, branch
		move.b	#$27,d3
		bra.s	STS_NoNumber1

STS_NoComma1:
		cmpi.b	#' ',d3			; is current char a space?
		bne.s	STS_NoSpace1		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	STS_Loop_Main		; loop without taking time

STS_NoSpace1:
		cmpi.b	#'a',d3			; is current char an uncapitalized letter?
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
		lea	(STSBuffer+$232).w,a1	; load destination location to a1
		lea	(STS_Continue).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
STS_Loop_Continue:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	STS_DoNext2		; if yes, branch


		cmpi.b	#':',d3			; is current char a colon?
		bne.s	STS_NoColon2		; if not, go to next char
		move.b	#3,d3
		bra.s	STS_NoNumber2

STS_NoColon2:
		cmpi.b	#'\',d3			; is current char a backslash?
		bne.s	STS_NoBSlash2		; if not, go to next char
		move.b	#2,d3
		bra.s	STS_NoNumber2

STS_NoBSlash2:
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

STS_HeaderX:		dc.b	'                            '
			dc.b	'<~~~~~~~~~~~~~~~~~~~~~~~~~~#'
			dc.b	'                            '
			even

STS_ContinueX:		dc.b	' PRESS START TO CONTINUE... '
			even
; ---------------------------------------------------------------------------

STS_HeaderText1:	dc.b	'                            '
			even

STS_HeaderText2:	dc.b	'<~~~~~~~~~~~~~~~~~~~~~~~~~~#'
			even

STS_HeaderText3:	dc.b	'            X'
			even
; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		dc.b	'THE SPIKED SUCKER DECIDED   '
		dc.b	'TO GO BACK TO THE HILLS AND '
		dc.b	'CHECK OUT WHAT WAS GOING ON.'
		dc.b	'                            '
		dc.b	'WHEN SUDDENLY...            '
		dc.b	'EXPLOSIONS! EVERYWHERE!     '
		dc.b	'A GRAY METALLIC BUZZ BOMBER '
		dc.b	'SHOWERED EXPLODING BOMBS ON '
		dc.b	'HIM! SONIC ESCAPED IT, BUT  '
		dc.b	'MINDLESSLY FELL INTO A RING '
		dc.b	'TRAP AND LANDED IN A        '
		dc.b	'STRANGE PARALLEL DIMENSION. '
		dc.b	'                            '
		dc.b	'HE NEEDS TO BLAST HIS WAY TO'
		dc.b	'EGGMAN AND ESCAPE IT...     '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		dc.b	'TELEPORTING WATERFALLS,     '
		dc.b	'CRABMEATS WITH EXPLODING    '
		dc.b	'BALLS, AND THE ORIGINAL     '
		dc.b	'GREEN HILL ZONE TRANSFORMED '
		dc.b	'INTO AN ACTION MOVIE OR     '
		dc.b	'SOMETHING. TOP IT OFF WITH  '
		dc.b	'EGGMAN AND HIS THREE SPIKED '
		dc.b	'BALLS OF STEEL, AND YOU CAN '
		dc.b	'TELL SONIC ISN\T EXACTLY    '
		dc.b	'HAVING THE TIME OF HIS LIFE.'
		dc.b	'                            '
		dc.b	'BUT HEY, I HEARD THEY\VE GOT'
		dc.b	'A BUNCH OF EMERALDS NEARBY? '
		dc.b	'WOULD BE A REAL SHAME IF YOU'
		dc.b	'MISSED YOUR GOAL.           '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_3:	; text after beating Special Place
		dc.b	'WOW, FOUR EMERALDS ALREADY  '
		dc.b	'COLLECTED, AND SONIC DOESN\T'
		dc.b	'EVEN KNOW WHY HE NEEDS THEM.'
		dc.b	'                            '
		dc.b	'FRANKLY, I GOT NO IDEA. BUT '
		dc.b	'HOW ELSE SHOULD I END THIS  '
		dc.b	'STAGE? WITH A BLOODY PARADE?'
		dc.b	'HOW ABOUT A COOKIE TOO?     '
		dc.b	'CATCH ME A BREAK HERE.      '
		dc.b	'                            '
		dc.b	'ANYWAY, LISTEN. WHATEVER YOU'
		dc.b	'DO, STAY AWAY FROM ANY      '
		dc.b	'SUSPICIOUS MONITORS!        '
		dc.b	'WHO KNOWS WHAT INHUMANITY   '
		dc.b	'LIES IN THERE...            '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_4:	; text after beating Ruined Place
		dc.b	'YOU DIDN\T LISTEN. WHAT A   '
		dc.b	'FOOL. WELL, AT LEAST YOUR   '
		dc.b	'PATHETIC EFFORTS SHOOTING   '
		dc.b	'YOURSELF THROUGH A MAZE OF  '
		dc.b	'SPIKES MADE FOR QUITE AN    '
		dc.b	'ENTERTAINING WATCH. REALLY, '
		dc.b	'I THINK YOU\VE GOT A GREAT  '
		dc.b	'CAREER AS A COMMEDIAN AHEAD!'
		dc.b	'                            '
		dc.b	'ACTUALLY, THAT GIVES ME AN  '
		dc.b	'IDEA. LET\S SEE WHAT HAPPENS'
		dc.b	'WHEN THE CAMERA GUIDES THE  '
		dc.b	'NARRATIVE. I SURE HOPE YOU  '
		dc.b	'DON\T FEEL TOO DOWN, BECAUSE'
		dc.b	'THINGS CAN ONLY GO UP...    '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_5:	; text after beating Labyrinth Place
		dc.b	'MAN, IF YOU COULD SEE YOUR  '
		dc.b	'FACE RIGHT NOW! PRICELESS!  '
		dc.b	'                            '
		dc.b	'WELL, OUR CAMERA CREW WILL  '
		dc.b	'MAKE ENOUGH CASH FROM THAT  '
		dc.b	'AWFUL ATTEMPT OF YOURS TO   '
		dc.b	'LAST A LIFETIME. SO, NO MORE'
		dc.b	'FUNKY CAMERA BUSINESS. PINKY'
		dc.b	'PROMISE.                    '
		dc.b	'                            '
		dc.b	'UNFORTUNATELY, YOU HAVE     '
		dc.b	'KILLED THE JAWS OF DESTINY, '
		dc.b	'AND THEREFORE MUST BE SERVED'
		dc.b	'THE ULTIMATE PUNISHMENT:    '
		dc.b	'ANOTHER SPECIAL STAGE.      '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_6:	; text after beating Unreal Place
		dc.b	'IF I SEE SUCH A PATHETIC    '
		dc.b	'EXCUSE FOR WHAT YOU CALL    '
		dc.b	'SKILL AGAIN, I WILL GO AHEAD'
		dc.b	'AND DISABLE THE CHECKPOINTS '
		dc.b	'UNTIL YOU CAN DO THE ENTIRE '
		dc.b	'STAGE BLINDFOLDED!          '
		dc.b	'                            '
		dc.b	'BUT HEY, AT LEAST YOU       '
		dc.b	'COLLECTED ALL SIX EMERALDS, '
		dc.b	'WHICH MEANS YOU NEED TO GO  '
		dc.b	'TO SPACE OR SOMETHING.      '
		dc.b	'                            '
		dc.b	'JUST REMEMBER THAT IN THE   '
		dc.b	'VOID, NOBODY CAN HEAR YOUR  '
		dc.b	'CRIES FOR HELP...           '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_7:	; text after beating Scar Night Place
		dc.b	'WORD OF ADVICE:             '
		dc.b	'TOO MUCH SCREAMING ISN\T    '
		dc.b	'GOOD FOR YOUR VOCAL CORDS.  '
		dc.b	'YOU CLEARLY DIDN\T PAY ANY  '
		dc.b	'ATTENTION TO WHAT I SAID    '
		dc.b	'EARLIER ABOUT NOBODY BEING  '
		dc.b	'ABLE TO HEAR YOU IN SPACE.  '
		dc.b	'MORON. BUT I GET IT, I ALSO '
		dc.b	'SCREAM IN EXCITEMENT IF I   '
		dc.b	'PLAY A BUZZ WIRE GAME!      '
		dc.b	'                            '
		dc.b	'I HOPE YOUR ANGELIC VOICE   '
		dc.b	'CAN BE HEARD ONE MORE TIME  '
		dc.b	'IN THE FINALE! IT IS THE    '
		dc.b	'LAST STAGE AFTER ALL, RIGHT?'
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_8:	; text after jumping in the ring for the Ending Sequence
		dc.b	'THE WORLD IS RESCUED!       '
		dc.b	'ANIMALS JUMP AROUND AND     '
		dc.b	'SPREAD THEIR HAPPINESS BY   '
		dc.b	'JUMPING OFF CLIFFS!         '
		dc.b	'                            '
		dc.b	'SONIC DECIDED TO TAKE ONE   '
		dc.b	'FINAL RUN THROUGH THE GREEN '
		dc.b	'HILLS, WHERE IT ALL STARTED,'
		dc.b	'TO CELEBRATE HIS AND YOUR   '
		dc.b	'HARD EFFORTS. WITHOUT YOUR  '
		dc.b	'HELP, THIS WOULD HAVE       '
		dc.b	'NEVER HAPPENED!             '
		dc.b	'                            '
		dc.b	'NOW WATCH YOURS AND SONIC\S '
		dc.b	'WELL DESERVED END...        '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_9:	; "One Hot Night", Tongara's hidden easter egg fanfic 
		dc.b	'I REMEMBER WHEN I STUCK MY  '
		dc.b	'DICK INSIDE *******. WHAT A '
		dc.b	'MAGICAL DAY IT WAS! ********'
		dc.b	'GOT SO JEALOUS. SO HE       '
		dc.b	'DECIDED TO STICK HIS DICK IN'
		dc.b	'**********. HE ENJOYED THIS.'
		dc.b	'IT MADE HIM FEEL HOT. ******'
		dc.b	'THEN WALKED INTO THE ROOM,  '
		dc.b	'UNEXPECTEDLY. HE GOT WET    '
		dc.b	'THE INSTANT HE SAW ******   '
		dc.b	'ON THE FLOOR NAKED. THEY HAD'
		dc.b	'A MAGICAL NIGHT OF LOVE     '
		dc.b	'MAKING. AND THEN, *******   '
		dc.b	'DIED AND EVERYONE WAS HAPPY.'
		dc.b	'THE END!                    '
		dc.b	$FF
		even

StoryText_A:
		; "The Morning After", the second half of the fanfic, for the weirdos that dig through the source in a hex editor or something lol
		dc.b	'THE MORNING SUN ROSE.       '
		dc.b	'IT WAS BEAUTIFUL.           '
		dc.b	'THE SUN SHONE DOWN INTO     '
		dc.b	'THE ROOM, WHERE ALL THE     '
		dc.b	'LOVE MAKERS SLEPT.          '
		dc.b	'****** AWOKE NEXT TO        '
		dc.b	'THE ROTTING BODY OF *******,'
		dc.b	'BAKING IN THE SUN.          '
		dc.b	'IT MADE HIM HORNY.          '
		dc.b	'HE TURNED ******* OVER AND  '
		dc.b	'MADE LOVE TO HIS ANUS.      '
		dc.b	'WHAT A MAGICAL ANUS IT WAS! '
		dc.b	'HE THEN CAME.               '
		dc.b	'                            '
		dc.b	'THE END!                    '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

StoryText_B:	; hidden easter egg text found after the blackout special stage
		dc.b	'CONGRATULATIONS!            '
		dc.b	'                            '
		dc.b	'YOU HAVE BEATEN THE         '
		dc.b	'BLACKOUT CHALLENGE.         '
		dc.b	'                            '
		dc.b	'CHECK OUT THE OPTIONS MENU, '
		dc.b	'A NEW COOL FEATURE HAS BEEN '
		dc.b	'UNLOCKED FOR YOU TO MESS    '
		dc.b	'AROUND WITH!                '
		dc.b	'                            '
		dc.b	'HAVE FUN AND THANK YOU SO   '
		dc.b	'MUCH FOR PLAYING MY GAME!   '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'SELBI                       '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

STS_Continue:
		dc.b	'PRESS START TO CONTINUE... '
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