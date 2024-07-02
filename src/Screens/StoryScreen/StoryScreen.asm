; ---------------------------------------------------------------------------
; Story Text Screens
; ---------------------------------------------------------------------------
STS_LineLength = 28
STS_LinesMain = 16
STS_LinesTotal = STS_LinesMain + 4
STS_Sound = $D8

		rsset	$FFFFFF95
STS_FullyWritten:	rs.b 1
STS_Row:		rs.b 1
STS_Column:		rs.b 1
STS_CurrentChar:	rs.w 1
STS_FinalPhase:		rs.b 1
STS_SkipBottomMeta:	rs.b 1
STS_ScreenID	equ	$FFFFFF9E ; hardcoded because it's fragile

; general values
STS_BaseRow = 7
STS_BaseCol = 6
STS_VRAMBase = $60000003|($800000*STS_BaseRow)|($20000*STS_BaseCol)
STS_VRAMSettings = $8000|$6000|($D000/$20)

; "Press Start..." text
STS_PressStartButton_Row = STS_BaseRow + STS_LinesTotal - 2
STS_PressStart_VRAMBase = $60000003|($800000*STS_PressStartButton_Row)|($20000*STS_BaseCol)
STS_PressStart_VRAMSettings = $8000|$4000|($D000/$20)

; lines at top and bottom
STS_DrawnLine_Extra	= 4
STS_DrawnLine_Length	= STS_LineLength+STS_DrawnLine_Extra-1
STS_VRAMBase_Line 	= $60000003|($20000*(STS_BaseCol-(STS_DrawnLine_Extra/2)))
STS_TopLine_Offset	= STS_BaseRow-2
STS_BottomLine_Offset	= STS_TopLine_Offset+STS_LinesTotal-2
STS_LineChar_Left	= $C0/$20
STS_LineChar_Middle	= $E0/$20
STS_LineChar_Right	= $100/$20
STS_LineChar_Arrow	= $120/$20 ; unused
; ---------------------------------------------------------------------------

StoryTextScreen:				; XREF: GameModeArray
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		VBlank_SetMusicOnly
		display_disable
		
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
		bne.s	@noautoskip		; if yes, branch
		move.b	#1,($FFFFFF7D).w	; make sure the chapters screen leads us to the correct level
		bra.w	STS_ExitScreen		; auto-skip the cringe

@noautoskip:
		move.l	#$64000002,($C00004).l
		lea	(ArtKospM_ERaZorNoBG).l,a0
		jsr	KosPlusMDec_VRAM

		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$11E,obX(a0)		; set X-position
		move.w	#$87,obScreenY(a0)	; set Y-position
		bset	#7,obGfx(a0)		; otherwise make object high plane

		jsr	ObjectsLoad
		jsr	BuildSprites
	
		lea	($C00000).l,a6
		move.l	#$50000003,4(a6)
		lea	(STS_FontArt).l,a5
		move.w	#$28F,d1
STS_LoadText:	move.w	(a5)+,(a6)
		dbf	d1,STS_LoadText		 ; load uncompressed text patterns

		jsr	BGDeformation_Setup

		moveq	#$14,d0
		jsr	PalLoad1		; load level select pallet

		movem.l	d0-a2,-(sp)		; backup d0 to a2
		lea	(Pal_ERaZorBanner).l,a1	; set ERaZor banner's palette pointer
		lea	($FFFFFBA0).l,a2	; set palette location
		moveq	#7,d0			; set number of loops to 7
@erzpalloop:	move.l	(a1)+,(a2)+		; load 2 colours (4 bytes)
		dbf	d0,@erzpalloop		; loop
		movem.l	(sp)+,d0-a2		; restore d0 to a2

		bsr	STS_ClearFlags

		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1
STS_ClrScroll:	move.l	d0,(a1)+
		dbf	d1,STS_ClrScroll	; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1
STS_ClrVram:	move.l	d0,(a6)
		dbf	d1,STS_ClrVram		; fill VRAM with 0
		
		cmpi.b	#9,(STS_ScreenID).w	; is this the blackout special stage?
		bne.s	@bottommeta		; if not, branch
		move.b	#1,(STS_SkipBottomMeta)	; if yes, don't draw bottom line and "Press Start..." stuff because the text is too long
@bottommeta:
		display_enable
		VBlank_UnsetMusicOnly
		jsr	Pal_FadeTo

; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
StoryScreen_MainLoop:
		bsr	StoryScreen_CenterText

		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	Options_BackgroundEffects
		jsr	Options_ERZPalCycle

		VBlank_SetMusicOnly
		bsr	StoryScreen_ContinueWriting
		VBlank_UnsetMusicOnly

		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq	StoryScreen_MainLoop	; if not, branch

		tst.b	(STS_FullyWritten).w	; is text already fully written?
		bne	STS_FadeOutScreen		; if yes, exit screen
		VBlank_SetMusicOnly
		bsr	StoryText_WriteFull	; write the complete text
		VBlank_UnsetMusicOnly
		bra	StoryScreen_MainLoop	; loop
; ---------------------------------------------------------------------------

STS_FadeOutScreen:
		bsr	StoryScreen_CenterText	; center text one last time
		move.b	#16,(STS_FinalPhase).w	; set fadeout time (using a RAM address we don't need at this point anymore) 
		
		cmpi.b	#8,(STS_ScreenID).w	; is this the ending sequence?
		beq.s	@finalfadeout		; if yes, don't fade out music
		move.w	#$E0,d0
		jsr	PlaySound_Special

@finalfadeout:
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

		lea	($FFFFCC00+STS_BaseRow*32).w,a0	; set up H-scroll buffer to the point where the main text is located
		moveq	#(STS_LinesMain)-1,d2		; set loop count of line count
		tst.b	(STS_SkipBottomMeta).w		; is bottom meta set to be skipped?
		beq.s	@loopout			; if not, branch
		addq.w	#2,d2				; add two extra lines to fade out
@loopout:
		moveq	#0,d0				; clear d0
		move.b	(STS_FinalPhase).w,d0		; get current
		btst	#0,d2				; are we on an odd row?
		beq.s	@notodd				; if not, branch
		neg.w	d0
@notodd:	rept 8
		add.l	d0,(a0)+			; write to h-scroll buffer (plane B)
		endr 
		dbf	d2,@loopout			; loop
		
		btst	#0,(STS_FinalPhase).w		; are we on an odd frame?
		bne.s	@oddframe			; if yes, branch
		jsr	Pal_FadeOut			; manually fade out
@oddframe:
		subq.b	#1,(STS_FinalPhase).w		; subtract 1 from timer
		bhi.s	@finalfadeout			; if we didn't reach the end, loop

; ---------------------------------------------------------------------------

STS_ExitScreen:
		moveq	#0,d2
		jsr	Options_ClearBuffer
		
		bsr	STS_ClearFlags

		move.b	(STS_ScreenID).w,d0
		cmpi.b	#1,d0			; is this the intro dialouge?
		bne.s	STS_NoIntro		; if not, branch
		move.w	#$400,($FFFFFE10).w	; set level to Uberhub
		move.b	#$28,($FFFFF600).w	; set to chapters screen
		rts

STS_NoIntro:
		cmpi.b	#8,d0			; is this the ending sequence?
		bne.s	STS_NoEnding		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts

STS_NoEnding:
		cmpi.b	#9,d0			; is this the blackout special stage?
		bne.s	STS_NoBlack		; if not, branch
		move.b	#$00,($FFFFF600).w	; set to sega screen ($00)
		rts

STS_NoBlack:
		jmp	NextLevelX
; ===========================================================================

STS_ClearFlags:
		clr.b	(STS_FullyWritten).w
		clr.b	(STS_Row).w
		clr.b	(STS_Column).w
		clr.w	(STS_CurrentChar).w
		clr.b	(STS_FinalPhase).w
		clr.b	(STS_SkipBottomMeta).w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to continue loading the story text, if necessary
; ---------------------------------------------------------------------------

StoryScreen_ContinueWriting:
		tst.b	(STS_FullyWritten).w		; is text already fully written?
		bne.w	@writeend			; if yes, don't continue writing
		tst.b	(STS_FinalPhase).w		; are we currently set to write the "Press Start..." text?
		bne.w	StoryScreen_WritePressStart	; if yes, branch
		bsr	StoryScreen_DrawLines		; continue drawing the lines, if necessary

@skipspaces:
		bsr	StoryText_Load			; load story text into a1
		adda.w	(STS_CurrentChar).w,a1		; find the char we want to write
		moveq	#0,d0				; clear d0
		move.b	(a1),d0				; move current char to d0
		bne.s	@notspace			; if it isn't a space, branch
		suba.w	(STS_CurrentChar).w,a1		; undo the offset adjustment from above
		bsr.w	@gotonextpos			; go to next char (skip spaces)
		bra.s	@skipspaces			; loop

@notspace:
		bpl.s	@dowrite			; did we reach the end of the list (-1)? if not, branch
		move.b	#1,(STS_FinalPhase).w		; set final phase flag
		clr.w	(STS_CurrentChar).w		; reset current char counter
		clr.b	(STS_Column).w			; reset column counter
		tst.b	(STS_SkipBottomMeta).w		; is bottom meta set to be not drawn?
		beq.s	@noskipbottom			; if not, branch
		move.b	#1,(STS_FullyWritten).w		; set the fully written flag now
@noskipbottom:
		rts					; don't continue writing

@dowrite:
		lea	($C00000).l,a6			; load VDP data port to a6
		move.l	#STS_VRAMBase,d3		; base screen position
		
		moveq	#0,d1				; clear d1
		moveq	#0,d2				; clear d2
		move.w	#$80,d1				; set d1 to $80 (we actually want $800000 but mulu only supports words)
		move.b	(STS_Row).w,d2			; get current row
		mulu.w	d2,d1				; multiply currrent row with VRAM offset
		swap	d1				; convert back into to the $800000-based format we want
		add.l	d1,d3				; add to base address

		moveq	#0,d1				; clear d1
		move.b	(STS_Column).w,d1		; get current column
		add.b	d1,d1				; double ($20000-based)
		swap	d1				; convert to the format we want
		add.l	d1,d3				; add to base address

		move.l	d3,4(a6)			; write final position to VDP
		add.w	#STS_VRAMSettings,d0		; apply VRAM settings (high plane, palette line 4, VRAM address $D000)
		move.w	d0,(a6)				; write char to screen

		tst.b	1(a1)				; is the next character a space?
		bne.s	@notspacenext			; if not, branch
		bsr	@playwritingsound		; play sound
@notspacenext:
		bsr	@gotonextpos			; go to next character
		tst.b	(STS_Column).w			; did column reset?
		bne.s	@writeend			; if not, branch
		bsr	@playwritingsound		; play sound

@writeend:
		rts
; ---------------------------------------------------------------------------

@playwritingsound:	
		move.w	#STS_Sound,d0			; play...
		jsr	PlaySound_Special		; ... text writing sound
		rts

@gotonextpos:
		addq.b	#1,(STS_Column).w		; go to next column
		cmpi.b	#STS_LineLength,(STS_Column).w	; did we reach the end of the row?
		blo.s	@nottheendoftherow		; if not, branch
		move.b	#0,(STS_Column).w		; reset column
		addq.b	#1,(STS_Row).w			; go to next row

@nottheendoftherow:
		addq.w	#1,(STS_CurrentChar).w		; go to next char for the next iteration
		rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the "Press Start to Continue..." text at the end
; ---------------------------------------------------------------------------

StoryScreen_WritePressStart:
		lea	(STS_Continue).l,a1		; load "Press Start..." text to a1
		adda.w	(STS_CurrentChar).w,a1		; find the char we want to write

		moveq	#0,d0				; clear d0
		move.b	(a1),d0				; move current char to d0
		bpl.s	@dowrite			; did we reach the end of the list (-1)? if not, branch
		move.b	#1,(STS_FullyWritten).w		; set flag that we're done
		rts					; don't continue writing

@dowrite:
		lea	($C00000).l,a6			; load VDP data port to a6
		move.l	#STS_PressStart_VRAMBase,d3	; base screen position
		
		moveq	#0,d1				; clear d1
		move.b	(STS_Column).w,d1		; get current column
		add.b	d1,d1				; double ($20000-based)
		swap	d1				; convert to the format we want
		add.l	d1,d3				; add to base address

		move.l	d3,4(a6)			; write final position to VDP
		add.w	#STS_PressStart_VRAMSettings,d0	; apply VRAM settings (high plane, palette line 3, VRAM address $D000)
		move.w	d0,(a6)				; write char to screen

		addq.b	#1,(STS_Column).w		; go to next column
		addq.w	#1,(STS_CurrentChar).w		; go to next char for the next iteration

@writeend:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the full text if Start is pressed
; ---------------------------------------------------------------------------

StoryText_WriteFull:
		move.b	(STS_SkipBottomMeta).w,d0	; backup skip bottom meta flag
		bsr	STS_ClearFlags			; make sure any previously written text doesn't interfere	
		move.b	d0,(STS_SkipBottomMeta).w	; restore skip bottom meta flag (it's the only one still used here)
		
		move.w	#STS_DrawnLine_Length*2,(STS_CurrentChar).w ; full line (times 2 because its speed is halved)
		bsr	StoryScreen_DrawLines		; finish drawing lines
		
		bsr	StoryText_Load			; reload beginning of story text into a1
		
		lea	($C00000).l,a6
		move.l	#STS_VRAMBase,d4		; base screen position
		move.w	#STS_VRAMSettings,d3		; VRAM setting (high plane, palette line 4, VRAM address $D000)
		moveq	#STS_LinesMain-1,d1		; number of lines of text

		tst.b	(STS_SkipBottomMeta).w		; is bottom meta set to be skipped?
		beq.s	@nextline			; if not, branch
		addq.w	#3,d1				; add two extra lines
	
@nextline:
		move.l	d4,4(a6)			; write whatever line we're on right now to the VDP
		moveq	#STS_LineLength-1,d2		; number of characters per line
@nextchar:
		moveq	#0,d0				; clear d0
		move.b	(a1)+,d0			; get next char
		bmi.s	@endwrite			; is it the end of the text? brancch
		add.w	d3,d0				; apply VRAM settings
		move.w	d0,(a6)				; write to VDP
		dbf	d2,@nextchar			; loop until row is done

		addi.l	#$800000,d4			; go to next line
		dbf	d1,@nextline			; loop until entire text is written

@endwrite:
		; "Press Start to Continue..." text
		tst.b	(STS_SkipBottomMeta).w		; is bottom meta set to be not drawn?
		bne.s	@finished			; if yes, skip
		tst.b	(STS_FinalPhase).w		; did we already write the final text?
		bne.s	@finished			; if yes, branch
		move.b	#1,(STS_FinalPhase).w		; set "final phase" flag
		lea	(STS_Continue).l,a1		; load "Press Start..." text to a1
		move.w	#STS_PressStart_VRAMSettings,d3	; use red palette line
		move.l	#STS_PressStart_VRAMBase,d4	; adjust position
		bra.s	@nextline			; write the line

@finished:
		move.b	#1,(STS_FullyWritten).w		; set "fully-written" flag
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the lines above and below text
; ---------------------------------------------------------------------------

StoryScreen_DrawLines:
		move.l	#STS_VRAMBase_Line|($800000*STS_TopLine_Offset),d0
		moveq	#0,d2			; draw from left to right
		bsr.s	STS_DrawLine		; draw top line

		tst.b	(STS_SkipBottomMeta).w	; is bottom meta set to be not drawn?
		bne.s	@nobottomline		; if yes, skip
		move.l	#STS_VRAMBase_Line|($800000*STS_BottomLine_Offset),d0
		moveq	#1,d2			; draw from right to left
		bsr.s	STS_DrawLine		; draw bottom line
@nobottomline:
		rts
; ---------------------------------------------------------------------------

STS_DrawLine:
		lea	($C00000).l,a6
		move.w	(STS_CurrentChar).w,d1		; make line length match the currently drawn text...
		lsr.w	#1,d1				; ...with its speed cut in half
		cmpi.w	#STS_DrawnLine_Length,d1	; are we at the maximum allowed line length?
		bls.s	@nolimit			; if not, draw line with given length
		move.w	#STS_DrawnLine_Length,d1	; otherwise, limit it to its maximum
@nolimit:
		tst.b	d2				; is line to be drawn from right to left?
		beq.s	@noreverse			; if not, branch
		move.l	#STS_DrawnLine_Length,d2	; get rightmost position
		sub.w	d1,d2				; subtract the current length
		add.b	d2,d2				; double ($20000-based)
		swap	d2				; convert to the format we want
		add.l	d2,d0				; add that as column offset to the base address

@noreverse:
		move.l	d0,4(a6)			; set VDP address given from d0
		move.w	#STS_VRAMSettings,d0		; VRAM setting (high plane, palette line 4, VRAM address $D000)
		moveq	#1,d3				; marker to make first char drawn the left-ending char
@drawline:
		move.w	d0,d2				; copy VRAM settings to d2
		move.w	#STS_LineChar_Middle,d4		; set middle char
		
		tst.b	d3				; are we drawing the first char?
		beq.s	@notfirst			; if not, branch
		move.w	#STS_LineChar_Left,d4		; set left char
		moveq	#0,d3				; clear first-char flag
		bra.s	@notlast			; branch
@notfirst:
		tst.b	d1				; are we drawing the last char?
		bne.s	@notlast			; if not, branch
		move.w	#STS_LineChar_Right,d4		; set right char
@notlast:	
		add.w	d4,d2				; apply chosen char to VRAM settings
		move.w	d2,(a6)				; write to char to VDP
		dbf	d1,@drawline			; loop until line is fully written
		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to center the text
; ---------------------------------------------------------------------------

StoryScreen_CenterText:
		bsr	StoryText_Load			; load story text into a1
		lea	($FFFFCC00+STS_BaseRow*32).w,a0	; set up H-scroll buffer to the point where the main text is located
		move.w	#STS_LineLength,d0		; set line length
		moveq	#STS_LinesMain-1,d1		; set default loop count of line count
		tst.b	(STS_SkipBottomMeta).w		; is bottom meta set to be skipped?
		beq.s	@notskipbottommeta		; if not, branch
		addq.w	#2,d1				; add two extra lines
@notskipbottommeta:
		tst.b	(STS_FullyWritten).w		; is text already fully written?
		bne.s	@centertextloop			; if yes, branch
		move.b	(STS_Row).w,d1			; set number of repetitions to current row count

@centertextloop:
		moveq	#0,d2				; clear d2
		tst.w	d1				; are we on the last row?
		bne.s	@notend				; if not, branch
		move.w	d0,d2				; copy line length to d2
		sub.b	(STS_Column),d2			; subtract current column length
		bra.s	@writescroll			; skip normal calculation

@notend:
		movea.l	a1,a2				; create copy of story text address
		adda.w	d0,a2				; add line length to the offset (so we start at the end)
@findlineend:	tst.b	-(a2)				; is current character a space?
		bne.s	@writescroll			; if not, we found the end of the line, branch
		addq.l	#1,d2				; increase 1 to center alignment counter
		bra.s	@findlineend			; loop until we found the end

@writescroll:
		lsl.l	#2,d2				; multiply by 4px per space
		rept	8				; 8 scanlines (one row)
		add.l	d2,(a0)+			; write offset to scroll buffer
		endr					; rept end
		adda.w	d0,a1				; go to next line
		dbf	d1,@centertextloop		; loop
		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Story Texts
; ---------------------------------------------------------------------------

; Macro to preprocess and output a character to its correct mapping
stschar macro char		
	if     \char = ' '
		dc.b	$0000
	elseif \char = "'"
		dc.b	$0040/$20
	elseif \char = ':'
		dc.b	$0060/$20
	elseif \char = '!'
		dc.b	$0140/$20
	elseif \char = '-'
		dc.b	$04A0/$20
	elseif \char = '.'
		dc.b	$04C0/$20
	elseif \char = ','
		dc.b	$04E0/$20
	elseif \char = '?'
		dc.b	$0500/$20
	else 	; regular letter
		dc.b	($0160/$20) + \char - 'A'
	endif
	endm
 
ststxt macro string
	i:   = 1
	len: = strlen(\string)
	if (len<>STS_LineLength)
		inform 2, "line must be EXACTLY 28 characters long"
	endif

	while (i<=len)
		char:	substr i,i,\string
		stschar '\char'
		i: = i+1
	endw
	endm
; ---------------------------------------------------------------------------

StoryText_Load:
		moveq	#0,d0				; clear d0
		move.b	(STS_ScreenID).w,d0 		; get ID for the current text we want to display
		add.w	d0,d0				; times four...
		add.w	d0,d0				; ...for long alignment
		movea.l	StoryText_Index(pc,d0.w),a1	; load story address into a1
		rts
; ---------------------------------------------------------------------------
StoryText_Index:
		dc.l	STS_Continue	; continue text at the bottom of the screen
		dc.l	StoryText_1	; text after intro cutscene
		dc.l	StoryText_2	; text after beating Night Hill Place
		dc.l	StoryText_3	; text after beating Special Place
		dc.l	StoryText_4	; text after beating Ruined Place
		dc.l	StoryText_5	; text after beating Labyrinth Place
		dc.l	StoryText_6	; text after beating Unreal Place
		dc.l	StoryText_7	; text after beating Scar Night Place
		dc.l	StoryText_8	; text after jumping in the ring for the Ending Sequence
		dc.l	StoryText_9	; text after beating the blackout challenge special stage
; ---------------------------------------------------------------------------

STS_Continue:	ststxt	" PRESS START TO CONTINUE... "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		ststxt	"THE SPIKED SUCKER DECIDED   "
		ststxt	"TO GO BACK TO THE HILLS,    "
		ststxt	"JUST TO SEE WHAT'S UP.      "
		ststxt	"                            "
		ststxt	"WHEN SUDDENLY... EXPLOSIONS!"
		ststxt	"EVERYWHERE! A GRAY METALLIC "
		ststxt	"BUZZ BOMBER SHOWERED HIM    "
		ststxt	"WITH MISSILES! SONIC MANAGED"
		ststxt	"TO ESCAPE IT, BUT MINDLESSLY"
		ststxt	"FELL INTO A CONVENIENTLY    "
		ststxt	"PLACED RING TRAP.           "
		ststxt	"                            "
		ststxt	"UPON WARPING, HE FINDS      "
		ststxt	"HIMSELF IN A STRANGE        "
		ststxt	"PARALLEL DIMENSION...       "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		ststxt	"TELEPORTING WATERFALLS,     "
		ststxt	"CRABMEATS WITH EXPLODING    "
		ststxt	"BALLS, AND THE ORIGINAL     "
		ststxt	"GREEN HILL ZONE TRANSFORMED "
		ststxt	"INTO SOMETHING OF AN ACTION "
		ststxt	"MOVIE. TOP IT OFF WITH      "
		ststxt	"EGGMAN AND HIS THREE SPIKED "
		ststxt	"BALLS OF STEEL, AND YOU CAN "
		ststxt	"TELL SONIC ISN'T EXACTLY    "
		ststxt	"HAVING THE TIME OF HIS LIFE."
		ststxt	"                            "
		ststxt	"BUT HEY, I HEARD THEY'VE GOT"
		ststxt	"A BUNCH OF EMERALDS NEARBY? "
		ststxt	"WOULD BE A REAL SHAME IF YOU"
		ststxt	"MISSED YOUR GOAL.           "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_3:	; text after beating Special Place
		ststxt	"WOW, FOUR EMERALDS ALREADY  "
		ststxt	"COLLECTED, AND SONIC DOESN'T"
		ststxt	"EVEN KNOW WHY HE NEEDS THEM."
		ststxt	"                            "
		ststxt	"FRANKLY, I GOT NO IDEA. BUT "
		ststxt	"HOW ELSE SHOULD I END THIS  "
		ststxt	"STAGE? WITH A BLOODY PARADE?"
		ststxt	"HOW ABOUT A COOKIE TOO?     "
		ststxt	"CATCH ME A BREAK HERE.      "
		ststxt	"                            "
		ststxt	"ANYWAY, LISTEN. WHATEVER YOU"
		ststxt	"DO, STAY AWAY FROM ANY      "
		ststxt	"SUSPICIOUS MONITORS!        "
		ststxt	"WHO KNOWS WHAT INHUMANITY   "
		ststxt	"LIES IN THERE...            "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_4:	; text after beating Ruined Place
		ststxt	"YOU DIDN'T LISTEN. WHAT A   "
		ststxt	"FOOL. WELL, AT LEAST YOUR   "
		ststxt	"PATHETIC EFFORTS SHOOTING   "
		ststxt	"YOURSELF THROUGH A MAZE OF  "
		ststxt	"SPIKES MADE FOR QUITE AN    "
		ststxt	"ENTERTAINING WATCH. REALLY, "
		ststxt	"I THINK YOU'VE GOT A GREAT  "
		ststxt	"CAREER AS A COMEDIAN AHEAD! "
		ststxt	"                            "
		ststxt	"ACTUALLY, THAT GIVES ME AN  "
		ststxt	"IDEA. LET'S SEE WHAT HAPPENS"
		ststxt	"WHEN THE CAMERA GUIDES THE  "
		ststxt	"NARRATIVE. I SURE HOPE YOU  "
		ststxt	"DON'T FEEL TOO DOWN, BECAUSE"
		ststxt	"THINGS CAN ONLY GO UP...    "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_5:	; text after beating Labyrinth Place
		ststxt	"MAN, IF YOU COULD SEE YOUR  "
		ststxt	"FACE RIGHT NOW! PRICELESS!  "
		ststxt	"                            "
		ststxt	"WELL, OUR CAMERA CREW WILL  "
		ststxt	"MAKE ENOUGH CASH FROM THAT  "
		ststxt	"AWFUL ATTEMPT OF YOURS TO   "
		ststxt	"LAST A LIFETIME. SO, NO MORE"
		ststxt	"FUNKY CAMERA BUSINESS.      "
		ststxt	"PINKY PROMISE.              "
		ststxt	"                            "
		ststxt	"UNFORTUNATELY, YOU HAVE     "
		ststxt	"KILLED THE JAWS OF DESTINY, "
		ststxt	"AND THEREFORE MUST BE SERVED"
		ststxt	"THE ULTIMATE PUNISHMENT:    "
		ststxt	"ANOTHER SPECIAL STAGE.      "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_6:	; text after beating Unreal Place
		ststxt	"IF I SEE SUCH A PATHETIC    "
		ststxt	"EXCUSE FOR WHAT YOU CALL    "
		ststxt	"SKILL AGAIN, I WILL GO AHEAD"
		ststxt	"AND DISABLE THE CHECKPOINTS "
		ststxt	"UNTIL YOU CAN DO THE ENTIRE "
		ststxt	"STAGE BLINDFOLDED!          "
		ststxt	"                            "
		ststxt	"BUT HEY, AT LEAST YOU       "
		ststxt	"COLLECTED ALL SIX EMERALDS, "
		ststxt	"WHICH MEANS YOU NEED TO GO  "
		ststxt	"TO SPACE OR SOMETHING.      "
		ststxt	"                            "
		ststxt	"JUST REMEMBER THAT IN THE   "
		ststxt	"VOID, NOBODY CAN HEAR YOUR  "
		ststxt	"CRIES FOR HELP...           "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_7:	; text after beating Scar Night Place
		ststxt	"WORD OF ADVICE:             "
		ststxt	"TOO MUCH SCREAMING ISN'T    "
		ststxt	"GOOD FOR YOUR VOCAL CORDS.  "
		ststxt	"YOU CLEARLY DIDN'T PAY ANY  "
		ststxt	"ATTENTION TO WHAT I SAID    "
		ststxt	"EARLIER ABOUT NOBODY BEING  "
		ststxt	"ABLE TO HEAR YOU IN SPACE.  "
		ststxt	"MORON. BUT I GET IT, I ALSO "
		ststxt	"SCREAM IN EXCITEMENT IF I   "
		ststxt	"PLAY A BUZZ WIRE GAME!      "
		ststxt	"                            "
		ststxt	"I HOPE YOUR ANGELIC VOICE   "
		ststxt	"CAN BE HEARD ONE MORE TIME  "
		ststxt	"IN THE FINALE! IT IS THE    "
		ststxt	"LAST STAGE AFTER ALL, RIGHT?"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_8:	; text after jumping in the ring for the Ending Sequence
		ststxt	"THE WORLD IS RESCUED!       "
		ststxt	"ANIMALS JUMP AROUND AND     "
		ststxt	"SPREAD THEIR HAPPINESS BY   "
		ststxt	"JUMPING OFF CLIFFS!         "
		ststxt	"                            "
		ststxt	"SONIC DECIDED TO TAKE ONE   "
		ststxt	"FINAL RUN THROUGH THE GREEN "
		ststxt	"HILLS, WHERE IT ALL STARTED,"
		ststxt	"TO CELEBRATE HIS AND YOUR   "
		ststxt	"HARD EFFORTS. WITHOUT YOUR  "
		ststxt	"HELP, THIS WOULD HAVE       "
		ststxt	"NEVER HAPPENED!             "
		ststxt	"                            "
		ststxt	"NOW WATCH YOURS AND SONIC'S "
		ststxt	"WELL DESERVED END...        "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_9:	; text after beating the blackout challenge special stage
		ststxt	"HOLY CRAP... YOU DID IT!    "
		ststxt	"YOU'VE CONQUERED THE        "
		ststxt	"BLACKOUT CHALLENGE.         "
		ststxt	"                            "
		ststxt	"WHEN I MOCKED YOU BACK IN   "
		ststxt	"UNREAL PLACE AND SAID YOU'D "
		ststxt	"HAVE TO DO THE STAGE        "
		ststxt	"BLINDFOLDED, I DIDN'T THINK "
		ststxt	"YOU'D ACTUALLY DO IT.       "
		ststxt	"                            "
		ststxt	"CHECK OUT THE OPTIONS MENU  "
		ststxt	"FOR SOMETHING SPECIAL JUST  "
		ststxt	"FOR YOU. YOU'VE EARNED IT!  "
		ststxt	"                            "
		ststxt	"THANK YOU FOR STICKING WITH "
		ststxt	"MY GAME TO THE BITTER END!  "
		ststxt	"IT MEANS THE WORLD TO ME.   "
		ststxt	"                            "
		ststxt	"                      -SELBI"
		dc.b	-1
		even
; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
STS_FontArt:	incbin	Screens\StoryScreen\StoryScreen_Font.bin
		even
; ===========================================================================
STS_Palette:	incbin	Screens\StoryScreen\StoryScreen_Pal.bin
		even
; ===========================================================================
