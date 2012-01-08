; ---------------------------------------------------------------------------
; Info screen
; ---------------------------------------------------------------------------

InfoScreen:				; XREF: GameModeArray
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

Info_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,Info_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0
		
		move	#$2700,sr
		move.l	#$40000001,($C00004).l
		lea	(Nem_InfoBG).l,a0 ; load Info	screen patterns
		jsr	NemDec
		lea	($C00000).l,a6
		move.l	#$50000003,4(a6)
	;	lea	(Art_Text).l,a5
		lea	(Info_FontArt).l,a5
		move.w	#$28F,d1

Info_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Info_LoadText ; load uncompressed text patterns

		jsr	Pal_FadeFrom

		move	#$2700,sr
		lea	($FF0000).l,a1
		lea	(Eni_InfoBG).l,a0 ; load	Info screen mappings
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

		move.b	#1,($A130F1).l		; enable SRAM
		move.b	($200007).l,($FFFFFF9C).w	; get number for text
		move.b	#0,($A130F1).l		; disable SRAM
		
		lea	($FFFFCA00).w,a1	; set location for the text
		moveq	#0,d0
		move.w	#559,d1			; do it for all 504 chars

Info_MakeFF:
		move.b	d0,(a1)+		; put $FF into current spot
		dbf	d1,Info_MakeFF	; loop


		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

Info_ClrScroll:
		move.l	d0,(a1)+
		dbf	d1,Info_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1

Info_ClrVram:
		move.l	d0,(a6)
		dbf	d1,Info_ClrVram ; fill	VRAM with 0
		move.w	#$14,($FFFFFF82).w

; ===========================================================================
; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
InfoScreen_MainLoop:
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		jsr	RunPLC_RAM
		tst.l	($FFFFF680).w
		bne.s	InfoScreen_MainLoop
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (Info_NoMore)?
		bne.s	Info_NoTextChange	; if yes, branch
		move.b	($FFFFF605).w,d1
		andi.b	#$80,d1
		beq.s	Info_NoStart
		move.b	#1,($FFFFFF9B).w
		bsr	InfoTextLoad		; update text
		bra.s	InfoScreen_MainLoop	; if not, branch
; ===========================================================================

Info_NoStart:
		subq.b	#1,($FFFFFF95).w	; sub 1 from delay
		bpl.s	Info_NoTextChange	; if time remains, branch (comment out to remove delay entirly)
		bsr	InfoTextLoad		; update text
		move.b	#1,($FFFFFF95).w	; reset delay timer
		cmpi.b	#6,($FFFFFF9A).w
		beq.s	@cont
		move.b	#2,($FFFFFF95).w

@cont:
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (Info_NoMore)?
		bne.s	Info_NoTextChange	; if yes, branch
		bra.s	InfoScreen_MainLoop
; ===========================================================================

Info_NoTextChange:
		move.b	($FFFFF605).w,d1
		andi.b	#$80,d1
		beq.s	InfoScreen_MainLoop	; if not, branch
		cmpi.b	#1,($FFFFFF9C).w	; is this the intro-dialouge?
		bne.s	Info_NoIntro		; if not, branch

		move.b	#1,($A130F1).l		; enable SRAM
		move.b	#1,($200001).l		; run first chapter screen
		move.b	#0,($A130F1).l		; disable SRAM
		move.b	#$28,($FFFFF600).w	; set to chapters screen ($28)
		rts

Info_NoIntro:
		cmpi.b	#8,($FFFFFF9C).w	; is this the ending sequence?
		bne.s	Info_NoEnding		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts

Info_NoEnding:
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.w	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w
		move.w	#$400,($FFFFFE10).w	; set level to SYZ1
		move.b	#$C,($FFFFF600).w
		jmp	NextLevelX
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to load level select text
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


InfoTextLoad:				; XREF: TitleScreen
		bsr	GetInfoText
		lea	($FFFFCA00).w,a1		
		lea	($C00000).l,a6
		move.l	#$620C0003,d4	; screen position (text)
		move.w	#$E680,d3	; VRAM setting
		moveq	#$14,d1		; number of lines of text


loc3_34FE:				; XREF: InfoTextLoad+26j
		move.l	d4,4(a6)
		bsr	Info_ChgLine
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
		bsr	Info_ChgLine
		move.w	#$C680,d3

loc3_3550:
		rts	
; End of function InfoTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Info_ChgLine:				; XREF: InfoTextLoad
		moveq	#$1B,d2		; number of characters per line $17 $1B

loc3_3588:
		moveq	#0,d0
		move.b	(a1)+,d0
		bpl.s	loc3_3598
		move.w	#0,(a6)
		dbf	d2,loc3_3588
		rts	
; ===========================================================================

loc3_3598:				; XREF: Info_ChgLine
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc3_3588
		rts	
; End of function Info_ChgLine

; ===========================================================================
; ===========================================================================
Info_Sound = $D8
Info_Speed = 1
Info_LagSpeed = 10
; ===========================================================================
; ===========================================================================

GetInfoText:
		tst.b	($FFFFFF9B).w		; is routine counter at $12 (Info_NoMore)?
		beq.w	Info_LoadUp		; if yes, branch
		
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA00).w,a1	; load destination location to a1
		lea	(Info_HeaderX).l,a2	; get text location 1
		move.w	#83,d5			; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Header1XX:
		move.b	(a2)+,d3		; load current char to a1
		cmpi.b	#$20,d3
		beq.s	Info_Loop_H1_SpaceXX
		cmpi.b	#$3D,d3
		beq.s	Info_Loop_H1_EqualXX
		subi.b	#$36,d3
		bra.s	Info_Loop_H1_NoSpaceXX
		
Info_Loop_H1_EqualXX:
		move.b	#$25,d3
		bra.s	Info_Loop_H1_NoSpaceXX

Info_Loop_H1_SpaceXX:
		move.b	#$00,d3

Info_Loop_H1_NoSpaceXX:
		move.b	d3,(a1)+
		dbf	d5,Info_Loop_Header1XX	; loop

; =============================

		bsr.w	Info_SetMainText
Info_Loop_MainXX:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	Info_DoNext1XX		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	Info_NoDot1XX		; if not, go to next char
		move.b	#$26,d3
		bra.s	Info_NoNumber1XX

Info_NoDot1XX:
		cmpi.b	#$3F,d3			; is current char a question mark?
		bne.s	Info_NoQMark1xx		; if not, branch
		move.b	#$28,d3
		bra.s	Info_NoNumber1xx

Info_NoQMark1xx:
		cmpi.b	#$2C,d3			; is current char a comma?
		bne.s	Info_NoComma1xx		; if not, branch
		move.b	#$27,d3
		bra.s	Info_NoNumber1xx

Info_NoComma1xx:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	Info_NoSpace1XX		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	Info_Loop_MainXX	; loop without taking time

Info_NoSpace1XX:
		cmpi.b	#$61,d3			; is current char an uncapitalized letter?
		blt.s	Info_NoUncapiXX		; if not, branch
		subi.b	#$20,d3			; use same font as capitalized letters

Info_NoUncapiXX:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	Info_NoNumber1XX	; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

Info_NoNumber1XX:
		move.b	d3,(a1)+		; load output to a1
		bra.s	Info_Loop_MainXX	; loop

; =============================

Info_DoNext1XX:
		lea	(Info_ContinueX).l,a2	; get text location 1
		move.w	#84,d5			; set numbers of loops (this will make the "typing" effect)
Info_Loop_ContinueXX:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	Info_NoDot2XX		; if not, go to next char
		move.b	#$26,d3
		bra.s	Info_NoNumber2XX

Info_NoDot2XX:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	Info_NoSpace2XX		; if not, go to next char
		move.b	#$00,d3			; load space char to a1		
		bra.s	Info_NoNumber2XX	; loop without taking time

Info_NoSpace2XX:
		subi.b	#$36,d3			; substract $36 from d3 (because it's in ascii)
		
Info_NoNumber2XX:

		move.b	d3,(a1)+		; load output to a1
		dbf	d5,Info_Loop_ContinueXX	; loop

		rts
; ===========================================================================
; ===========================================================================

Info_SetMainText:
		moveq	#0,d0			; clear d0
		lea	(InfoText_1).l,a2	; get text location 1 (which is also the start of the text locations in general)
		move.b	($FFFFFF9C).w,d0 	; get text ID
		subq.b	#1,d0			; sub 1 from it, because we want to use 0 as base, not 1
		move.w	d0,d1			; copy to d1 (for H-scroll)
		mulu.w	#422,d0			; multiply it by 422 (number of chars for a single block of text including the $FF)
		adda.w	d0,a2			; add result to text location (a2)

		lea	(ScrollText_1).l,a3	; load start address of scroll text
		mulu.w	#16,d1			; multiply it by 15 (number of entries)
		adda.w	d1,a3			; add result to scroll location (a3)
		lea	($FFFFCCE0).w,a4	; load H-scroll buffer address (start at line 7, where the main text begins)
		moveq	#14,d2			; set repeat times (15 lines)

ISMT_NextLine:
		tst.b	(a3)+			; test next byte
		bne.s	ISMT_DoCentering	; if it's 1, branch
		lea	$20(a4),a4		; increase a4 by $20
		bra.s	ISMT_NoCenter		; skip

ISMT_DoCentering:
		moveq	#4,d1			; set d1 to 4
		move.l	d1,(a4)+		; write to scroll buffer (line 1)
		move.l	d1,(a4)+		; write to scroll buffer (line 2)
		move.l	d1,(a4)+		; write to scroll buffer (line 3)
		move.l	d1,(a4)+		; write to scroll buffer (line 4)
		move.l	d1,(a4)+		; write to scroll buffer (line 5)
		move.l	d1,(a4)+		; write to scroll buffer (line 6)
		move.l	d1,(a4)+		; write to scroll buffer (line 7)
		move.l	d1,(a4)+		; write to scroll buffer (line 8)

ISMT_NoCenter:
		dbf	d2,ISMT_NextLine	; repeat til all lines are set
		rts				; return
; ===========================================================================
; ===========================================================================

Info_LoadUp:
		moveq	#0,d0			; clear d0
		move.b	($FFFFFF9A).w,d0	; get index number
		move.w	Info_Index(pc,d0.w),d1 ; get current index
		jmp	Info_Index(pc,d1.w)	; jump to set position
; ===========================================================================
Info_Index:	dc.w Info_Header1-Info_Index
		dc.w Info_Header2-Info_Index
		dc.w Info_Lag-Info_Index
		dc.w Info_MainText-Info_Index
		dc.w Info_Lag-Info_Index
		dc.w Info_ContinueText-Info_Index
		dc.w Info_NoMore-Info_Index
; ===========================================================================

Info_Header1:
		addq.w	#Info_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA00).w,a1	; load destination location to a1
		lea	(Info_HeaderText1).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Header1:
		move.b	(a2)+,d3		; load current char to a1
		cmpi.b	#$20,d3
		beq.s	Info_Loop_H1_Space
		subi.b	#$18,d3
		bra.s	Info_Loop_H1_NoSpace

Info_Loop_H1_Space:
		move.b	#$00,d3

Info_Loop_H1_NoSpace:
		move.b	d3,(a1)+
		dbf	d5,Info_Loop_Header1	; loop

		lea	($FFFFCA1C).w,a1	; load destination location to a1
		lea	(Info_HeaderText2).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Header2:
		move.b	(a2)+,d3		; load current char to a1
		subi.b	#$18,d3
		move.b	d3,(a1)+
		dbf	d5,Info_Loop_Header2	; loop
		
		move.l	#$00,($FFFFCA38).w
		move.l	#$00,($FFFFCA3C).w

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	Info_MultiReturn
		move.b	#Info_Sound,d0
		jsr	PlaySound_Special
		
		cmpi.w	#28,($FFFFFF96).w	; has char 71 been reached?
		bge.s	Info_DoNextHeader	; if yes, branch
		rts				; otherwise return
; ---------------------------------------------------------------------------

Info_DoNextHeader:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	Info_LoadUp		; kind of return
; ===========================================================================

Info_Header2:
		addq.w	#Info_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA08).w,a1	; load destination location to a1
		lea	(Info_HeaderText3).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Header3:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$58,d3			; has the end of the list been reached?	
		beq.s	Info_DoLag		; if yes, branch
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	Info_NoSpaceX2		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	Info_Loop_Header3	; loop without taking time

Info_NoSpaceX2:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	Info_NoNumberX2		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

Info_NoNumberX2:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,Info_Loop_Header3	; loop

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	Info_MultiReturn
		move.b	#Info_Sound,d0
		jsr	PlaySound_Special

		cmpi.w	#10,($FFFFFF96).w	; has char 71 been reached?
		bge.s	Info_DoLag		; if yes, branch
		rts				; otherwise return
; ---------------------------------------------------------------------------

Info_DoLag:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	Info_LoadUp		; kind of return
; ===========================================================================

Info_Lag:
		addq.w	#1,($FFFFFF96).w
		cmpi.w	#Info_LagSpeed,($FFFFFF96).w
		bge.s	Info_DoMain
		rts
; ---------------------------------------------------------------------------

Info_DoMain:
		clr.w	($FFFFFF96).w
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	Info_LoadUp		; kind of return
; ===========================================================================
		

Info_MainText:
		addq.w	#Info_Speed+1,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCA54).w,a1	; load destination location to a1
		bsr.w	Info_SetMainText
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Main:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	Info_DoNext1		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	Info_NoDot1		; if not, go to next char
		move.b	#$26,d3
		bra.s	Info_NoNumber1

Info_NoDot1:
		cmpi.b	#$3F,d3			; is current char a question mark?
		bne.s	Info_NoQMark1		; if not, branch
		move.b	#$28,d3
		bra.s	Info_NoNumber1

Info_NoQMark1:
		cmpi.b	#"!",d3			; is current char an exclamation mark?
		bne.s	Info_NoExMark1		; if not, branch
		move.b	#$0A,d3
		bra.s	Info_NoNumber1

Info_NoExMark1:
		cmpi.b	#$2C,d3			; is current char a comma?
		bne.s	Info_NoComma1		; if not, branch
		move.b	#$27,d3
		bra.s	Info_NoNumber1

Info_NoComma1:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	Info_NoSpace1		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	Info_Loop_Main		; loop without taking time

Info_NoSpace1:
		cmpi.b	#$61,d3			; is current char an uncapitalized letter?
		blt.s	Info_NoUncapi		; if not, branch
		subi.b	#$20,d3			; use same font as capitalized letters

Info_NoUncapi:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	Info_NoNumber1		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

Info_NoNumber1:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,Info_Loop_Main	; loop

		move.b	#Info_Sound,d0
		jsr	PlaySound_Special
	;	cmpi.w	#532,($FFFFFF96).w	; has last char been reached?
	;	bge.s	Info_DoNext2		; if yes, branch

Info_MultiReturn:
		rts				; return
; ---------------------------------------------------------------------------

Info_DoNext1:
		clr.w	($FFFFFF96).w		; clear counter for the next time
		addq.b	#2,($FFFFFF9A).w	; go to next text
		bra.w	Info_LoadUp		; kind of return
; ===========================================================================

Info_ContinueText:
		addq.w	#Info_Speed,($FFFFFF96).w	; increase main counter
		moveq	#0,d5			; make sure d5 is empty
		moveq	#0,d3			; make sure d3 is empty
		lea	($FFFFCC32).w,a1	; load destination location to a1
		lea	(Info_Continue).l,a2	; get text location
		move.w	($FFFFFF96).w,d5	; set numbers of loops (this will make the "typing" effect)
		
Info_Loop_Continue:
		move.b	(a2)+,d3		; move current char into d3
		cmpi.b	#$FF,d3			; has the end of the list been reached?	
		beq.s	Info_DoNext2		; if yes, branch
		cmpi.b	#$2E,d3			; is current char a dot?
		bne.s	Info_NoDot2		; if not, go to next char
		move.b	#$26,d3
		bra.s	Info_NoNumber2

Info_NoDot2:
		cmpi.b	#$20,d3			; is current char a space?
		bne.s	Info_NoSpace2		; if not, go to next char
		move.b	#$00,(a1)+		; load space char to a1		
		bra.s	Info_Loop_Continue	; loop without taking time

Info_NoSpace2:
		subi.b	#$2F,d3			; substract $2F from d3 (because it's in ascii)
		cmpi.b	#10,d3			; is the current char a number?
		ble.s	Info_NoNumber2		; if yes, branch
		subi.b	#7,d3			; otherwise, additionally substract 7 from it

Info_NoNumber2:
		move.b	d3,(a1)+		; load output to a1
		dbf	d5,Info_Loop_Continue	; loop

		move.w	($FFFFFF96).w,d2
		andi.w	#1,d2
		beq.w	Info_MultiReturn
		move.b	#Info_Sound,d0
		jsr	PlaySound_Special

		rts				; otherwise return
; ---------------------------------------------------------------------------

Info_DoNext2:
		clr.w	($FFFFFF96).w		; clear counter for the next time
		addq.b	#2,($FFFFFF9A).w	; go to next text
		move.b	#1,($FFFFFF9B).w	; set "done" flag
		move.b	#4,($FFFFFF9A).w	; increase routine counter

Info_NoMore:
		rts				; return
; ===========================================================================
; ===========================================================================
; ===========================================================================

Info_HeaderX:		dc.b	'======= SONIC ERAZOR ======='
			dc.b	'============================'
			dc.b	'                            '
			even

Info_ContinueX:		dc.b	'                            '
			dc.b	'                              '
			dc.b	' PRESS START TO CONTINUE... '
			even
; ---------------------------------------------------------------------------

Info_HeaderText1:	dc.b	'=======              ======='
			even

Info_HeaderText2:	dc.b	'============================'
			even

Info_HeaderText3:	dc.b	'SONIC ERAZORX'
			even
; ---------------------------------------------------------------------------

InfoText_1:	; text after intro cutscene
		dc.b	'ONE DAY SONIC DECIDED TO GO '
		dc.b	' BACK TO GREEN HILL ZONE TO '
		dc.b	' SEE IF EVERYTHING IS OKAY. '
		dc.b	'                            '
		dc.b	'AS SOON AS HE GOT THERE, HE '
		dc.b	'WAS ATTACKED BY AN EVIL GREY'
		dc.b	'   METALLIC BUZZ BOMBER!    '
		dc.b	'                            '
		dc.b	'     SONIC ESCAPED HIM.     '
		dc.b	'HOWEVER, THE RING HE JUMPED '
		dc.b	'IN SENT HIM TO SPRING YARD. '
		dc.b	'                            '
		dc.b	'NOW HE HAS TO USE THE RINGS '
		dc.b	'THERE TO FIND BACK TO EGGMAN'
		dc.b	'    TO STOP HIM AGAIN...    '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_2:	; text after beating Green Hill Zone
		dc.b	'SONIC WENT THROUGH THE ZONE '
		dc.b	'AND FACED EVEN MORE METALLIC'
		dc.b	'ENEMIES, ALL WANTING TO KILL'
		dc.b	'    HIM WITH EXPLOSIONS!    '
		dc.b	'                            '
		dc.b	'   AFTER A MAD FIGHT WITH   '
		dc.b	' A SPECIAL CRABMEAT, SONIC  '
		dc.b	'  CONTINUED HIS WAY TO THE  '
		dc.b	'GREEN HILL PLACE, HOPING IT '
		dc.b	' IS NOT EXPLODING AS WELL.  '
		dc.b	'   SAD BUT TRUE, THAT WAS   '
		dc.b	'     EXACTLY THE CASE.      '
		dc.b	'                            '
		dc.b	'BACK IN SYZ, A RING BLOCKED '
		dc.b	' HIS WAY TO RUINED PLACE... '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_3:	; text after beating Special Stage
		dc.b	'  SONIC WAS RAGING AND YOU  '
		dc.b	'   ARE PROBABLY AS WELL.    '
		dc.b	'                            '
		dc.b	'SORRY FOR ANY DAMAGE TO YOUR'
		dc.b	'      BRAIN, HONESTLY.      '
		dc.b	'                            '
		dc.b	' ANYWAY, AFTER BEATING THE  '
		dc.b	'SPECIAL STAGE OF HELL, SONIC'
		dc.b	' WAS FINALLY ABLE TO GO TO  '
		dc.b	' RUINED PLACE, THINKING IT  '
		dc.b	'   WILL BE EASY TO BEAT.    '
		dc.b	'                            '
		dc.b	'JUST BY ITS NAME, YOU SHOULD'
		dc.b	'  BE ABLE TO REALIZE, THAT  '
		dc.b	' THIS NOT THE CASE AT ALL.  '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_4:	; text after beating Marble Zone
		dc.b	'WHO WOULD HAVE THOUGHT THAT '
		dc.b	'  SPIKES CAN BE THAT BAD?   '
		dc.b	'   SONIC SURELY WAS NOT.    '
		dc.b	'                            '
		dc.b	' ANYWAY, AFTER BEATING THIS '
		dc.b	'HORRIBLE MAZE OF TELEPORTING'
		dc.b	'  SPIKES, SONIC THOUGHT HE  '
		dc.b	' WAS FINALLY ABLE TO PEACE  '
		dc.b	'       OUT A LITTLE.        '
		dc.b	'                            '
		dc.b	'  DO YOU KNOW HOW IT FEELS  '
		dc.b	'  WHEN YOUR OWN CAMERA MAN  '
		dc.b	'TREATS YOU TO DEATH? IF NOT,'
		dc.b	'  YOU WILL IN THE NEXT FEW  '
		dc.b	'         MINUTES...         '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_5:	; text after beating Labyrinth Zone
		dc.b	'    I CANNOT TAKE IT ANY    '
		dc.b	'      FUCKING MORE!!!       '
		dc.b	'                            '
		dc.b	' THAT IS WHAT SONIC THOUGHT '
		dc.b	' AFTER FINALLY BEATING THE  '
		dc.b	' HORRIBLE UNDERWATER LEVEL. '
		dc.b	'                            '
		dc.b	'AND THIS TIME GOD HEARD HIS '
		dc.b	'  WISHES! THE STEP BETWEEN  '
		dc.b	'ROBOTNIK AND SONIC WAS JUST '
		dc.b	'    A SINGLE TUBE AWAY!     '
		dc.b	'                            '
		dc.b	'  BUT DO YOU REALLY THINK,  '
		dc.b	' THAT THIS WILL MAKE STUFF  '
		dc.b	'     EASIER? HELL NO...     '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_6:	; text after beating Star Light Zone
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'  SPECIAL 2 PLACEHOLDER     '
		dc.b	'               TEXT         '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'    ASJHDBAJHSBDJABSD       '
		dc.b	'                            '
		dc.b	'            ASVDJHGAVSJGHD  '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_7:	; text after beating Star Light Zone
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'  STAR LIGHT PLACEHOLDER    '
		dc.b	'               TEXT         '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'    ASJHDBAJHSBDJABSD       '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

InfoText_8:	; text after jumping in the ring for the Ending Sequence
		dc.b	'   THE WORLD IS RESCUED,    '
		dc.b	'  SONIC ONCE AGAIN STOPPED  '
		dc.b	' ROBOTNIK FROM TAKING OVER  '
		dc.b	'         THE WORLD.         '
		dc.b	'                            '
		dc.b	' SO SONIC DECIDED TO MAKE A '
		dc.b	'QUICK RUN THROUGH THE GREEN '
		dc.b	'HILL ZONE AGAIN, SURROUNDED '
		dc.b	'  BY TONS OF ANIMALS WHICH  '
		dc.b	' SEEM TO LIKE TO JUMP INTO  '
		dc.b	'     BOTTOMLESS PITS...     '
		dc.b	'                            '
		dc.b	'                            '
		dc.b	'    THAT SAID, HOW WILL     '
		dc.b	' EVERYTHING END WITH SONIC? '
		dc.b	$FF
		even
; ---------------------------------------------------------------------------

Info_Continue:
		dc.b	' PRESS START TO CONTINUE...'
		dc.b	$FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll positions
; ---------------------------------------------------------------------------

ScrollText_1:	dc.b	1, 0, 0, 0
		dc.b	1, 0, 1, 0
		dc.b	0, 1, 1, 0
		dc.b	1, 0, 0
		even

ScrollText_2:	dc.b	1, 0, 0, 0
		dc.b	0, 0, 1, 0
		dc.b	1, 1, 0, 1
		dc.b	0, 1, 0
		even

ScrollText_3:	dc.b	0, 1, 0, 0
		dc.b	0, 0, 1, 0
		dc.b	1, 1, 1, 0
		dc.b	0, 0, 1
		even

ScrollText_4:	dc.b	1, 1, 1, 0
		dc.b	0, 0, 0, 1
		dc.b	1, 0, 0, 0
		dc.b	0, 0, 0
		even

ScrollText_5:	dc.b	0, 1, 0, 0
		dc.b	1, 0, 0, 1
		dc.b	0, 1, 1, 0
		dc.b	0, 1, 0
		even

ScrollText_6:	dc.b	0, 0, 0, 0
		dc.b	0, 0, 0, 0
		dc.b	0, 0, 0, 0
		dc.b	0, 0, 0
		even

ScrollText_7:	dc.b	0, 0, 0, 0
		dc.b	0, 0, 0, 0
		dc.b	0, 0, 0, 0
		dc.b	0, 0, 0
		even

ScrollText_8:	dc.b	1, 0, 1, 0
		dc.b	0, 0, 1, 1
		dc.b	0, 1, 0, 0
		dc.b	0, 1, 0
		even
; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
Info_FontArt:	incbin	Screens\InfoScreen\InfoScreen_Font.bin
		even
; ===========================================================================
Pal_InfoScreen:	incbin	Screens\InfoScreen\InfoScreen_Pal.bin
		even
; ===========================================================================
Nem_InfoBG:	incbin	Screens\InfoScreen\InfoScreen_ArtBG.bin
		even
; ===========================================================================
Eni_InfoBG:	incbin	Screens\InfoScreen\InfoScreen_MapsBG.bin
		even
; ===========================================================================