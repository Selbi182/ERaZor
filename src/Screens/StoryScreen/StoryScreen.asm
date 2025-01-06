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

; general values
STS_BaseRow = 7
STS_BaseCol = 6
STS_VRAMBase = $40000003|($800000*STS_BaseRow)|($20000*STS_BaseCol)
STS_VRAMSettings = $8000|$6000|($D000/$20)

; "Press Start..." text
STS_PressStartButton_Row = STS_BaseRow + STS_LinesTotal - 2
STS_PressStart_VRAMBase = $40000003|($800000*STS_PressStartButton_Row)|($20000*STS_BaseCol)
STS_PressStart_VRAMSettings = $8000|$4000|($D000/$20)

; lines at top and bottom
STS_DrawnLine_Extra	= 4
	if def(__WIDESCREEN__)
STS_DrawnLine_Length	= 8+STS_LineLength+STS_DrawnLine_Extra-1
STS_VRAMBase_Line 	= $40000003
	else
STS_DrawnLine_Length	= STS_LineLength+STS_DrawnLine_Extra-1
STS_VRAMBase_Line 	= $40000003|($20000*(STS_BaseCol-(STS_DrawnLine_Extra/2)))
	endif
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
		
		lea	VDP_Ctrl,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		
		move.w	#$8C81|$08,(a6)	; enable shadow/highlight mode (SH mode)

		clr.b	($FFFFF64E).w
		jsr	ClearScreen

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
STS_ClrObjRam:	move.l	d0,(a1)+
		dbf	d1,STS_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0

		move.l	#$64000002,VDP_Ctrl
		lea	(ArtKospM_ERaZorNoBG).l,a0
		jsr	KosPlusMDec_VRAM

		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$80+SCREEN_WIDTH/2-2,obX(a0)	; set X-position
		move.w	#$87,obScreenY(a0)		; set Y-position
		bset	#7,obGfx(a0)		; otherwise make object high plane


		; transparent sprites squeezed in between plane A and B to properly display the text in SH mode
		lea	($FFFFD140).w,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2-32,obX(a0)
		move.w	#$B0,obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2+(32*5)-32,obX(a0)
		move.w	#$B0,obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2-32,obX(a0)
		move.w	#$B0+(32*4),obScreenY(a0)

		adda.w	#$40,a0
		move.b	#2,(a0)
		move.b	#6,obRoutine(a0)
		move.w	#$80+SCREEN_WIDTH/2+(32*5)-32,obX(a0)
		move.w	#$B0+(32*4),obScreenY(a0)


		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute
	
		lea	VDP_Data,a6
		move.l	#$50000003,4(a6)
		lea	(STS_FontArt).l,a5
		move.w	#$28F,d1
STS_LoadText:	move.w	(a5)+,(a6)
		dbf	d1,STS_LoadText		 ; load uncompressed text patterns

		vram	$3000
		moveq	#-1,d0
		move.w	#$10-1,d1
@transparent:
		rept	8*2
		move.w	d0,(a6)
		endr
		dbf	d1,@transparent

		jsr	BackgroundEffects_Setup

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

		lea	VDP_Data,a6
		move.l	#$40000003,VDP_Ctrl
		move.w	#$3FF,d1
STS_ClrVram:	move.l	d0,(a6)
		dbf	d1,STS_ClrVram		; fill VRAM with 0

		move.w	#0,BlackBars.Height	; make sure black bars are fully gone
		
		display_enable
		VBlank_UnsetMusicOnly

		; load BG color
		moveq	#0,d0
		move.b	(StoryTextID).w,d0
		subq.b	#1,d0
		add.w	d0,d0
		move.w	StoryScreen_BGColors(pc,d0.w),d0
		move.w	d0,(BGThemeColor).w	; set theme color for background effects

		jsr	Pal_FadeTo
		bra.s	StoryScreen_MainLoop
; ---------------------------------------------------------------------------

StoryScreen_BGColors:
		dc.w	$0E0	; after intro cutscene
		dc.w	$2E4	; after NHP/GHP
		dc.w	$E2E	; after SP
		dc.w	$02E	; after RP
		dc.w	$EA2	; after LP
		dc.w	$E2A	; after UP
		dc.w	$E02	; after SNP/SAP
		dc.w	$000	; before ending sequence
		dc.w	$00E	; after blackout
		dc.w	$0EE	; after beating Unreal Place without touching any checkpoints
		dc.w	$0EE	; after beating the blackout challenge in true-BS mode
		dc.w	$E28	; after beating Unterhub Place
		dc.w	$0EE	; after beating Unterhub Place without destroying the last Roller
		even

; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
StoryScreen_MainLoop:
		move.b	#$1C,VBlankRoutine
		DeleteQueue_Init
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	DeleteQueue_Execute
		jsr	BuildSprites

		jsr	BackgroundEffects_Update
		jsr	ERZBanner_PalCycle

		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	StoryScreen_MainLoop	; if not, loop

		tst.b	(STS_FullyWritten).w	; is text already fully written?
		bne.s	STS_FadeOutScreen	; if yes, exit screen
		move.b	#1,(STS_FullyWritten).w	; set "fully-written" flag
		bsr	StoryScreen_CenterText	; center entire text before writing it
		move.b	#$1C,VBlankRoutine	; wait a frame for H-scroll to update
		jsr	DelayProgram		; ''
		bsr	StoryText_WriteFull	; write the complete text
		move.b	#1,(STS_FullyWritten).w	; make sure "fully-written" flag remains set
		bsr	StoryScreen_CenterText	; center entire text before writing it
		bra.w	StoryScreen_MainLoop	; loop
; ---------------------------------------------------------------------------

StoryScreen_UpdateFromVBlank:
		bsr	StoryScreen_ContinueWriting
		rts
; ---------------------------------------------------------------------------

STS_FadeOutScreen:
		bsr	StoryScreen_CenterText	; center text one last time
		move.b	#16,(STS_FinalPhase).w	; set fadeout time (using a RAM address we don't need at this point anymore) 
		
		cmpi.b	#8,(StoryTextID).w	; is this the ending sequence?
		beq.s	@finalfadeout		; if yes, don't fade out music
		move.w	#$E0,d0
		jsr	PlayCommand
		clr.b	(SoundDriverRAM+v_last_bgm).w ; clear previously set level music so it gets restarted properly

@finalfadeout:
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute

		lea	($FFFFCC00+STS_BaseRow*32).w,a0	; set up H-scroll buffer to the point where the main text is located
		moveq	#(STS_LinesMain)-1,d2		; set loop count of line count
@loopout:
		moveq	#0,d0				; clear d0
		move.b	(STS_FinalPhase).w,d0		; get current
		btst	#0,d2				; are we on an odd row?
		beq.s	@notodd				; if not, branch
		neg.w	d0
@notodd:	swap	d0
		rept 8
		add.l	d0,(a0)+			; write to h-scroll buffer (plane A)
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
		bsr	STS_ClearFlags

		move.w	#$8C81|$00,VDP_Ctrl		; disable shadow/highlight mode (SH mode)

		moveq	#0,d0
		move.b	(StoryTextID).w,d0	; remember screen ID we came from in d0
		jmp	Exit_StoryScreen	; return to main source
; ===========================================================================

STS_ClearFlags:
		moveq	#0,d0
		move.b	d0,(STS_FullyWritten).w
		move.b	d0,(STS_Row).w
		move.b	d0,(STS_Column).w
		move.w	d0,(STS_CurrentChar).w
		move.b	d0,(STS_FinalPhase).w
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
		bsr	STS_NextChar			; go to next char (skip spaces)
		bra.s	@skipspaces			; loop

@notspace:
		bpl.s	@dowrite			; did we reach the end of the text (-1)? if not, branch? if not, branch

		move.b	#1,(STS_FinalPhase).w		; set final phase flag
		clr.w	(STS_CurrentChar).w		; reset current char counter
		clr.b	(STS_Column).w			; reset column counter
		rts					; don't continue writing
; ---------------------------------------------------------------------------

@dowrite:
		lea	VDP_Data,a6			; load VDP data port to a6
		move.l	#STS_VRAMBase,d3		; base screen position
		
		moveq	#0,d1				; clear d1
		moveq	#0,d2				; clear d2
		move.w	#$80,d1				; set d1 to $80 (we actually want $800000 but mulu only supports words)
		move.b	(STS_Row).w,d2			; get current row
		mulu.w	d2,d1				; multiply current row with VRAM offset
		swap	d1				; convert back into to the $800000-based format we want
		add.l	d1,d3				; add to base address

		moveq	#0,d1				; clear d1
		move.b	(STS_Column).w,d1		; get current column
		add.b	d1,d1				; double ($20000-based)
		swap	d1				; convert to the format we want
		add.l	d1,d3				; add to base address

		VBlank_SetMusicOnly
		move.l	d3,4(a6)			; write final position to VDP
		add.w	#STS_VRAMSettings,d0		; apply VRAM settings (high plane, palette line 4, VRAM address $D000)
		move.w	d0,(a6)				; write char to screen
		VBlank_UnsetMusicOnly

		bsr	STS_CenterCurrentLine		; center current line

		bsr	STS_NextChar			; go to next character

		move.w	($FFFFFE0E).w,d0		; get frame counter
		andi.w	#3,d0				; only every four frames
		bne.s	@writeend			; if not on one, branch
		cmpi.b	#STS_LinesMain,(STS_Row).w	; are we writing beyond the main content?
		bhi.s	@writeend			; if yes, don't play sound
		move.w	#STS_Sound,d0			; play...
		jsr	PlaySFX				; ... text writing sound

@writeend:
		rts
; ---------------------------------------------------------------------------

STS_NextChar:
		addq.b	#1,(STS_Column).w		; go to next column
		cmpi.b	#STS_LineLength,(STS_Column).w	; did we reach the end of the row?
		blo.s	@thisisnottheendoftherow	; if not, branch
		move.b	#0,(STS_Column).w		; reset column
		addq.b	#1,(STS_Row).w			; go to next row

@thisisnottheendoftherow:
		addq.w	#1,(STS_CurrentChar).w		; go to next char for the next iteration
		rts
; ---------------------------------------------------------------------------

STS_CenterCurrentLine:
		lea	($FFFFCC00+STS_BaseRow*32).w,a0	; set up H-scroll buffer to the point where the main text is located
		moveq	#0,d0				; clear d0
		move.b	(STS_Row).w,d0			; get current row
		lsl.w	#5,d0				; multiply by 32
		adda.w	d0,a0				; add to H-scroll buffer offset

		moveq	#STS_LineLength-1,d0		; set line length
		sub.b	(STS_Column).w,d0		; subtract current column length
		add.w	d0,d0				; multiply...
		add.w	d0,d0				; ...by 4
		
		rept	8				; 8 scanlines (one row)
		move.w	d0,(a0)+			; write offset to scroll buffer
		addq.w	#2,a0				; skip B-plane
		endr					; rept end
		rts					; return


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the "Press Start to Continue..." text at the end
; ---------------------------------------------------------------------------

StoryScreen_WritePressStart:
		lea	(STS_Continue).l,a1		; load "Press Start..." text to a1
		tst.b	(PlacePlacePlace).w		; PLACE PLACE PLACE?
		beq.s	@normal				; if not, branch
		lea	(STS_ContPlace).l,a1		; load dumb text
@normal:
		adda.w	(STS_CurrentChar).w,a1		; find the char we want to write

		moveq	#0,d0				; clear d0
		move.b	(a1),d0				; move current char to d0
		bpl.s	@dowrite			; did we reach the end of the list (-1)? if not, branch
		move.b	#1,(STS_FullyWritten).w		; set flag that we're done
		rts					; don't continue writing

@dowrite:
		lea	VDP_Data,a6			; load VDP data port to a6
		move.l	#STS_PressStart_VRAMBase,d3	; base screen position
		
		moveq	#0,d1				; clear d1
		move.b	(STS_Column).w,d1		; get current column
		add.b	d1,d1				; double ($20000-based)
		swap	d1				; convert to the format we want
		add.l	d1,d3				; add to base address

		VBlank_SetMusicOnly
		move.l	d3,4(a6)			; write final position to VDP
		add.w	#STS_PressStart_VRAMSettings,d0	; apply VRAM settings (high plane, palette line 3, VRAM address $D000)
		move.w	d0,(a6)				; write char to screen
		VBlank_UnsetMusicOnly

		addq.b	#1,(STS_Column).w		; go to next column
		addq.w	#1,(STS_CurrentChar).w		; go to next char for the next iteration

@writeend:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the full text if Start is pressed
; ---------------------------------------------------------------------------

StoryText_WriteFull:
		bsr	STS_ClearFlags			; make sure any previously written text doesn't interfere	
		
		move.w	#STS_DrawnLine_Length*2,(STS_CurrentChar).w ; full line (times 2 because its speed is halved)
		bsr	StoryScreen_DrawLines		; finish drawing lines
		
		bsr	StoryText_Load			; reload beginning of story text into a1
		
		VBlank_SetMusicOnly
		lea	VDP_Data,a6
		move.l	#STS_VRAMBase,d4		; base screen position
		move.w	#STS_VRAMSettings,d3		; VRAM setting (high plane, palette line 4, VRAM address $D000)
		moveq	#STS_LinesMain-1,d1		; number of lines of text

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
		tst.b	(STS_FinalPhase).w		; did we already write the final text?
		bne.s	@finished			; if yes, branch
		move.b	#1,(STS_FinalPhase).w		; set "final phase" flag
		lea	(STS_Continue).l,a1		; load "Press Start..." text to a1
		move.w	#STS_PressStart_VRAMSettings,d3	; use red palette line
		move.l	#STS_PressStart_VRAMBase,d4	; adjust position
		bra.w	@nextline			; write the line

@finished:
		VBlank_UnsetMusicOnly
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the lines above and below text
; ---------------------------------------------------------------------------

StoryScreen_DrawLines:
		move.l	#STS_VRAMBase_Line|($800000*STS_TopLine_Offset),d0
		moveq	#0,d2			; draw from left to right
		bsr.s	STS_DrawLine		; draw top line

		move.l	#STS_VRAMBase_Line|($800000*STS_BottomLine_Offset),d0
		moveq	#1,d2			; draw from right to left
		bsr.s	STS_DrawLine		; draw bottom line
@nobottomline:
		rts
; ---------------------------------------------------------------------------

STS_DrawLine:
		lea	VDP_Data,a6
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
		tst.b	(STS_FullyWritten).w		; is text already fully written?
		bne.s	@centertextloop			; if yes, branch
		move.b	(STS_Row).w,d1			; set number of repetitions to current row count

@centertextloop:
		moveq	#0,d2				; clear d2
		tst.w	d1				; are we on the last row?
		bne.s	@notend				; if not, branch
		move.w	d0,d2				; copy line length to d2
		sub.b	(STS_Column).w,d2		; subtract current column length
		bra.s	@writescroll			; skip normal calculation

@notend:
		movea.l	a1,a2				; create copy of story text address
		adda.w	d0,a2				; add line length to the offset (so we start at the end)
		moveq	#STS_LineLength,d3		; make sure we don't exceed the line limit (for blank lines)
@findlineend:	tst.b	-(a2)				; is current character a space?
		bne.s	@writescroll			; if not, we found the end of the line, branch
		addq.l	#1,d2				; increase 1 to center alignment counter
		subq.b	#1,d3				; subtract one remaining line length limit to check
		bhi.s	@findlineend			; loop until we found the end, or move on if it's a blank line
		moveq	#0,d2				; blank lines need no centering

@writescroll:
		lsl.l	#2,d2				; multiply by 4px per space
		
		rept	8				; 8 scanlines (one row)
		move.w	d2,(a0)+			; write offset to scroll buffer
		addq.w	#2,a0				; skip B-plane
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
	if     \char = '~' ; space without delay
		dc.b	$0000/$20
	elseif \char = ' ' ; space with delay (basically an invisible letter)
		dc.b	$0020/$20
	elseif \char = "'"
		dc.b	$0040/$20
	elseif \char = ':'
		dc.b	$0060/$20
	elseif \char = "^"
		dc.b	$0080/$20
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
	elseif (\char>='A') & (\char<='Z') 	; regular letter
		dc.b	($0160/$20) + \char - 'A'
	else
		inform 2, "illegal char \char"
	endif
	endm
 
ststxt macro string
	i:   = 1
	len: = strlen(\string)
	if (len>STS_LineLength)
		inform 2, "line length must be 28 characters or less"
	endif

	while (i<=len)
		char:	substr i,i,\string
		stschar '\char'
		i: = i+1
	endw

	; fill rest with instantly skipped spaces
	i: = 0
	while (i<(STS_LineLength-len))
		stschar "~"
		i: = i+1
	endw	
	;stschar " "
	endm

ststxt_line macro
	rept STS_LineLength
		stschar "~"
	endr
	;stschar " "
	endm	
; ---------------------------------------------------------------------------

StoryText_Load:
		moveq	#0,d0				; clear d0
		move.b	(StoryTextID).w,d0 		; get ID for the current text we want to display

		tst.b	(PlacePlacePlace).w		; PLACE PLACE PLACE?
		beq.s	@normal				; if not, branch
		lea	(StoryText_Place).l,a1		; PLACE PLACE PLACE!
		cmpi.b	#9,d0				; is this the blackout challenge?
		bne.s	@ret				; if not, branch
		lea	(StoryText_9X).l,a1		; use even stupider secret text for the meme
	@ret:	rts

@normal:
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
		dc.l	StoryText_5	; text after beating Labyrinthy Place
		dc.l	StoryText_6	; text after beating Unreal Place
		dc.l	StoryText_7	; text after beating Scar Night Place
		dc.l	StoryText_8	; text after jumping in the ring for the Ending Sequence
		dc.l	StoryText_9	; text after beating the blackout challenge special stage
		dc.l	StoryText_6X	; text after beating Unreal Place without touching any checkpoints
		dc.l	StoryText_9X	; text after beating the blackout challenge in true-BS mode
		dc.l	StoryText_Unter	; text after beating Unterhub Place
		dc.l	StoryText_UnterP; text after beating Unterhub Place without destroying the last Roller
; ---------------------------------------------------------------------------

STS_Continue:	ststxt	"~PRESS~START~TO~CONTINUE...~"
		dc.b	-1
		even

STS_ContPlace:	ststxt	"~~~PLACE~PLACE~TO~PLACE...~~"
		dc.b	-1
		even

; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		ststxt	"ONE DAY, THE SPIKED SUCKER"
		ststxt	"RETURNED TO THE HILLS"
		ststxt	"FOR OLD TIME'S SAKE."
		ststxt_line
		ststxt	"WHEN SUDDENLY..."
		ststxt	"EXPLOSIONS! EVERYWHERE!"
		ststxt	"A GRAY BUZZ BOMBER HAD SONIC"
		ststxt	"RUNNING FOR HIS DEAR LIFE,"
		ststxt	"BUT HE MANAGED TO ESCAPE..."
		ststxt_line
		ststxt	"...ONLY TO THEN LAUNCH"
		ststxt	"HIMSELF STRAIGHT INTO A VERY"
		ststxt	"CONVENIENTLY PLACED TRAP."
		ststxt_line
		ststxt	"SO MUCH FOR A QUICK REVISIT."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		ststxt	"SONIC'S NOT HAVING THE"
		ststxt	"TIME OF HIS LIFE."
		ststxt_line
		ststxt	"TELEPORTING WATERFALLS,"
		ststxt	"CRABMEATS WITH EXPLODING"
		ststxt	"PROJECTILES, AND THE"
		ststxt	"ORIGINAL GREEN HILL ZONE"
		ststxt	"TURNED INTO CINEMA HELL!"
		ststxt	"EGGMAN'S BALLS OF STEEL"
		ststxt	"DIDN'T HELP MUCH EITHER."
		ststxt_line
		ststxt	"BUT HEY, I HEARD THEY'VE GOT"
		ststxt	"A BUNCH OF EMERALDS NEARBY?"
		ststxt	"IT WOULD BE A SHAME IF YOU"
		ststxt	"WERE TO MISS YOUR GOAL..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_3:	; text after beating Special Place
		ststxt	"FOUR EMERALDS ALREADY"
		ststxt	"COLLECTED, AND SONIC DOESN'T"
		ststxt	"EVEN KNOW WHY HE NEEDS THEM."
		ststxt_line
		ststxt	"HONESTLY, NEITHER DO I,"
		ststxt	"BUT HOW ELSE SHOULD I END"
		ststxt	"THIS STAGE? WITH A PARADE?"
		ststxt	"HOW ABOUT A COOKIE TOO?"
		ststxt	"GIVE ME A BREAK HERE."
		ststxt_line
		ststxt	"ANYWAYS, LISTEN UP:"
		ststxt	"DON'T TOUCH ANY UNUSUAL"
		ststxt	"MONITORS IN THE NEXT STAGE!"
		ststxt	"WHO KNOWS WHAT INHUMANITY"
		ststxt	"LIES IN THERE..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_4:	; text after beating Ruined Place
		ststxt	"WAS THIS LEVEL A METAPHOR"
		ststxt	"FOR CAPITALISM OR SOMETHING?"
		ststxt_line
		ststxt	"AT LEAST YOUR EFFORTS OF"
		ststxt	"SHOOTING YOURSELF THROUGH"
		ststxt	"A MAZE OF SPIKES WERE PRETTY"
		ststxt	"ENTERTAINING TO WATCH."
		ststxt	"REALLY, I THINK YOU SHOULD"
		ststxt	"LOOK INTO BEING A COMEDIAN!"
		ststxt_line
		ststxt	"WAIT A MINUTE, I JUST HAD"
		ststxt	"AN ABSOLUTELY AMAZING IDEA."
		ststxt	"LET'S SEE HOW YOU DO"
		ststxt	"WHEN THE CAMERA"
		ststxt	"GUIDES THE NARRATIVE..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_5:	; text after beating Labyrinthy Place
		ststxt	"IF ONLY YOU COULD SEE YOUR"
		ststxt	"FACE RIGHT NOW! PRICELESS!"
		ststxt_line
		ststxt	"WELL, OUR CAMERA CREW HAS"
		ststxt	"FILMED ENOUGH MATERIAL FOR"
		ststxt	"TWO FEATURE-LENGTH FILMS"
		ststxt	"AND A SPIN-OFF SERIES."
		ststxt	"SO, NO MORE FUNKY CAMERA"
		ststxt	"BUSINESS FROM NOW ON,"
		ststxt	"PINKY PROMISE!"
		ststxt_line
		ststxt	"HOWEVER, YOU HAVE KILLED"
		ststxt	"THE MIGHTY ^JAWS^ OF DESTINY"
		ststxt	"AND THEREFORE MUST BE SERVED"
		ststxt	"THE ULTIMATE PUNISHMENT!"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_6:	; text after beating Unreal Place
		ststxt	"IF I SEE SUCH A PATHETIC"
		ststxt	"EXCUSE FOR WHAT YOU CALL"
		ststxt	"^SKILL^ AGAIN, I WILL"
		ststxt	"DISABLE THE CHECKPOINTS"
		ststxt	"UNTIL YOU CAN DO THE ENTIRE"
		ststxt	"STAGE BLINDFOLDED!"
		ststxt_line
		ststxt	"ANYWAYS, YOU'VE GOT ALL THE"
		ststxt	"EMERALDS NOW. SUPER SONIC"
		ststxt	"AIN'T GONNA HAPPEN, THOUGH,"
		ststxt	"AS THIS GAME ONLY HAS SIX."
		ststxt_line
		ststxt	"YOU'LL GO TO SPACE, THOUGH!"
		ststxt	"IT SORTA MAKES UP FOR THAT"
		ststxt	"SEVENTH EMERALD. SORTA."
		dc.b	-1
		even

StoryText_6X:	; ($A) text after beating Unreal Place without touching any checkpoints
		ststxt	"IF I SEE SUCH A PATHETIC"
		ststxt	"EXCUSE FOR WHAT YOU CALL"
		ststxt	"^SKILL^ AGAIN-"
		ststxt_line
		ststxt	"WAIT A MINUTE, WHAT?!"
		ststxt	"YOU BEAT THE ENTIRE STAGE"
		ststxt	"WITHOUT TOUCHING EVEN"
		ststxt	"A SINGLE GOAL BLOCK???"
		ststxt	"UHH... I DON'T KNOW WHAT"
		ststxt	"TO SAY, OTHER THAN WOW."
		ststxt	"THIS MUST HAVE TAKEN A LONG"
		ststxt	"TIME TO GET RIGHT!"
		ststxt_line
		ststxt	"BUT THIS CHANGES NOTHING,"
		ststxt	"YOU'LL STILL GO TO SPACE."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_7:	; text after beating Scar Night Place
		ststxt	"LOOK, I REALLY DO GET IT."
		ststxt	"WHEN I PLAY BUZZ WIRE GAMES,"
		ststxt	"I ALSO SCREAM IN EXCITEMENT!"
		ststxt	"BUT I'M REALLY STARTING"
		ststxt	"TO GET CONCERNEND ABOUT"
		ststxt	"YOUR VOCAL CORDS."
		ststxt_line
		ststxt	"AFTER ALL, THE FINALE IS"
		ststxt	"UP AHEAD AND I WAS REALLY"
		ststxt	"HOPING WE WOULD BE BLESSED"
		ststxt	"BY YOUR ANGELIC VOICE"
		ststxt	"ONE LAST TIME!"
		ststxt_line
		ststxt	"AFTER ALL, YOU'VE GOT EVERY"
		ststxt	"TROPHY NOW... RIGHT?"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_Unter: ; text after beating Unterhub Place
		ststxt	"THE PROPHECIES COULDN'T"
		ststxt	"HAVE PREPARED ME FOR THE"
		ststxt	"ABSOLUTE TERRORS THIS"
		ststxt	"UNHOLY REALM BENEATH OUR"
		ststxt	"COZY HUB WORLD HAD IN"
		ststxt	"STORE FOR HUMANITY."
		ststxt	"IT'S A MIRACLE YOU EVEN"
		ststxt	"MADE IT OUT ALIVE."
		ststxt_line
		ststxt	"EGGMAN WAS THERE, TOO."
		ststxt_line
		ststxt	"YOU'RE SO CLOSE TO THE END,"
		ststxt	"YOU MUSTN'T GIVE UP NOW!"
		ststxt	"I HOPE YOU'VE MASTERED"
		ststxt	"THE TUTORIAL..."
		dc.b	-1
		even

StoryText_UnterP: ; text after beating Unterhub Place without destroying the last Roller
		ststxt	"PACIFIST BONUS FUN FACT"
		ststxt_line
		ststxt	"I'M SICK AND TIRED OF"
		ststxt	"PEOPLE COMPLAINING ABOUT"
		ststxt	"THE LABYRINTH ZONE BOSS,"
		ststxt	"EVEN THOUGH THE REAL"
		ststxt	"HORRORS ALREADY CAME IN"
		ststxt	"SPRING YARD ZONE."
		ststxt	"SO, THIS STAGE WAS MY WAY"
		ststxt	"OF VISUALIZING WHAT FIGHTING"
		ststxt	"THAT BOSS FELT LIKE WHEN"
		ststxt	"I WAS LIKE SEVEN YEARS OLD."
		ststxt_line
		ststxt	"BUT ENOUGH TRAUMA TALK,"
		ststxt	"THE FINALE AWAITS..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_8:	; text after jumping in the ring for the Ending Sequence
		ststxt	"THE WORLD IS RESCUED!"
		ststxt	"ANIMALS JUMP AROUND AND"
		ststxt	"SPREAD THEIR HAPPINESS BY"
		ststxt	"JUMPING OFF CLIFFS!"
		ststxt_line
		ststxt	"AFTER ESCAPING THE STRANGE"
		ststxt	"PARALLEL DIMENSION, SONIC"
		ststxt	"DECIDED TO TAKE ONE FINAL"
		ststxt	"RUN THROUGH THE HILLS,"
		ststxt	"WHERE IT ALL STARTED."
		ststxt	"WITHOUT YOU, THIS WOULD"
		ststxt	"HAVE NEVER HAPPENED!"
		ststxt_line
		ststxt	"NOW WATCH YOURS AND SONIC'S"
		ststxt	"WELL-DESERVED PARTY..."
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_9:	; text after beating the blackout challenge special stage
		ststxt	"HOLY CRAP... YOU DID IT!"
		ststxt	"YOU'VE CONQUERED THE"
		ststxt	"BLACKOUT CHALLENGE."
		ststxt_line
		ststxt	"WHEN I MOCKED YOU BACK IN"
		ststxt	"UNREAL PLACE AND SAID YOU'D"
		ststxt	"HAVE TO DO THE ENTIRE STAGE"
		ststxt	"BLINDFOLDED, I DIDN'T THINK"
		ststxt	"YOU'D ACTUALLY DO IT."
		ststxt_line
		ststxt	"THANK YOU FOR STICKING WITH"
		ststxt	"MY GAME TO THE BITTER END!"
		ststxt	"IT MEANS THE WORLD TO ME."
		ststxt_line
		ststxt	"- SELBI -"
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_Place: ; text when PLACE PLACE PLACE
		ststxt	"PLACE PLACE! PLACE,"
		ststxt	"PLACE, PLACE PLACE PLACE?"
		ststxt	"PLACE PLACE PLACE... PLACE."
		ststxt_line
		ststxt	"PLACE PLACE PLACE"
		ststxt	"PLACE, PLACE! PLACE?"
		ststxt	"PLACE PLACE PLACE, PLACE,"
		ststxt	"PLACE PLACE, PLACE... PLACE."
		ststxt	"PLACE! PLACE! PLACE! PLACE!"
		ststxt	"PLACE, PLACE PLACE!"
		ststxt	"PLACE PLACE."
		ststxt_line
		ststxt	"PLACE... PLACE PLACE."
		ststxt	"PLACE, PLACE PLACE... PLACE?"
		ststxt	"PLACE PLACE PLACE. PLACE."
		dc.b	-1
		even

; ---------------------------------------------------------------------------

StoryText_9X:	; text after beating the blackout challenge in true-BS mode
		ststxt	"HOLY PLACE... YOU PLACED IT!"
		ststxt	"YOU'VE PLACED THE"
		ststxt	"PLACE PLACE PLACE CHALLENGE!"
		ststxt_line
		ststxt	"WHEN I PLACED YOU BACK IN"
		ststxt	"PLACE PLACE AND SAID YOU'D"
		ststxt	"HAVE TO PLACE THE ENTIRE"
		ststxt	"PLACE, I DIDN'T THINK"
		ststxt	"YOU'D ACTUALLY PLACE IT."
		ststxt_line
		ststxt	"THANK YOU FOR PLACING MY"
		ststxt	"PLACE TO THE BITTER PLACE!"
		ststxt	"IT MEANS THE PLACE TO ME."
		ststxt_line
		ststxt	"- PLACE -"
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
