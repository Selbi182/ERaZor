; ===========================================================================
; ---------------------------------------------------------------------------
; Credits Screens
; ---------------------------------------------------------------------------
Credits_Page equ $FFFFFF91 ; b
Credits_Scroll equ $FFFFFFA0 ; w

Credits_Pages = 12
Credits_Lines = 14
Credits_LineLength = 20
StartDelay = 150

Credits_ScrollTime = $1C0
Credits_FastThreshold = $60
Credits_SpeedSlow = 1
Credits_SpeedFast = 32
; ---------------------------------------------------------------------------
; ===========================================================================

CreditsScreen:
		move.b	#$97,d0
		jsr	PlaySound_Special			; play credits music
	;	jsr	Pal_FadeFrom
		
		; for a smooth transition from the ending sequence black bars
		jsr	Pal_CutToBlack
		move.b	#$18,VBlankRoutine
		jsr	DelayProgram

		VBlank_SetMusicOnly
		lea	($C00004).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8720,(a6)
		move.w	#$8407,(a6)
		move.w	#$8B07,(a6)
		move.w	#$9001,(a6)
		jsr	ClearScreen

		move.l	#$40000010,(a6)
		lea	($C00000).l,a0
		moveq	#0,d0
		moveq	#40-1,d1
@clearvsram:	move.w	d0,(a0)
		dbf	d1,@clearvsram

		vram	$0000
		lea	(ArtKospM_Credits).l,a0			; load address of compressed art
		jsr	KosPlusMDec_VRAM			; decompress and dump

		vram	$2000
		lea	($C00000).l,a6
		lea	(ArtKospM_PixelStars).l,a0
		jsr	KosPlusMDec_VRAM
		VBlank_UnsetMusicOnly

		lea	($FFFFFB80).w,a1
		lea	(Pal_Credits).l,a0
		moveq	#$20-1,d1
@loadpal:	move.l	(a0)+,(a1)+
		dbf	d1,@loadpal

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@clrobjram:	move.l	d0,(a1)+
		dbf	d1,@clrobjram

		display_enable
		jsr	Pal_FadeTo

		move.b	#0,(Credits_Page).w			; set current page ID to 0

		move.w	#Credits_ScrollTime,(Credits_Scroll).w	; pretend we're at the end of a previous page
		bsr	CS_ScrollMappings			; pre-center first page
		move.w	#0,(Credits_Scroll).w			; clear scroll again

		; opening delay to sync the screen to the music and prespawn some stars
		move.w	#StartDelay,d0
	@delay:
		move.b	#4,VBlankRoutine
		jsr	DelayProgram
		move.l	d0,-(sp)
		jsr	ObjectsLoad
		jsr	BuildSprites
		move.l	(sp)+,d0

		cmpi.w	#StartDelay-30,d0		; wait a bit before loading the starfield generator...
		bne.s	@loop				; ...to make sure stars begin at the center
		move.b	#$8B,($FFFFD000).w		; load starfield generator
		move.b	#0,($FFFFD000+obRoutine).w	; set to emitter
	@loop:
		dbf	d0,@delay


; ---------------------------------------------------------------------------
; Credits Main Loop
; ---------------------------------------------------------------------------

CreditsScreen_Loop:
		move.b	#4,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

@creditsmain:
		cmpi.b	#Credits_Pages,(Credits_Page).w		; final page?
		beq.w	@finalpage				; if yes, go to custom code

		; update scroll
		tst.b	($FFFFF604).w				; is any button held?
		beq.s	@scrollnormal				; if not, branch
		btst	#0,($FFFFFF95).w			; has this noob even finished the game in casual before? (checked through post-credit messages)
		bne.s	@scrollnormal				; if not, no fast scrolling
		bra.s	@fast					; fast forward
@scrollnormal:
		moveq	#Credits_SpeedSlow,d1			; use slowest speed by default
		move.w	(Credits_Scroll).w,d0			; get current scroll timer
		subi.w	#Credits_ScrollTime/2,d0		; normalize
		bpl.s	@chkfast				; if positive, branch
		neg.w	d0					; make positive
@chkfast:
		cmpi.w	#Credits_FastThreshold,d0		; are we above the fast scroll threshold?
		bhi.s	@fast					; if yes, scroll fast
		btst	#0,($FFFFFE0F).w			; are we on an odd frame?
		bne.s	CreditsScreen_Loop			; if yes, don't scroll (effectively halves speed)
		bra.s	@doscroll				; keep using slow speed
@fast:
		moveq	#Credits_SpeedFast,d1			; use fast threshold
@doscroll:
		sub.w	d1,(Credits_Scroll).w			; decrease X scroll position left
		blo.s	@nextpage				; if scroll time is up, go to next page
		bsr	CS_ScrollMappings			; run scrolling/deformation
		bra.s	CreditsScreen_Loop			; loop screen

@nextpage:
		; next page when scroll time expires
		addq.b	#1,(Credits_Page).w			; set to next screen
		bsr	CS_WriteCurrentPage			; run mapping
		move.w	#Credits_ScrollTime,(Credits_Scroll).w	; reset scroll time
		bra.w	@creditsmain				; loop screen
; ---------------------------------------------------------------------------

@finalpage:
		subi.w	#Credits_SpeedFast,(Credits_Scroll).w	; decrease X scroll position left
		cmpi.w	#Credits_ScrollTime/2,(Credits_Scroll).w; text centered?
		blt.s	Credits_EndLoop				; if scroll time is up, go to end loop
		bsr	CS_ScrollMappings			; run scrolling/deformation
		bra.w	CreditsScreen_Loop			; loop screen
; ---------------------------------------------------------------------------

Credits_EndLoop:
		; final loop on the final page
		move.b	#4,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		andi.b	#$F0,($FFFFF605).w			; is A, B, C, or Start pressed?
		beq.s	Credits_EndLoop				; if not, loop
		jmp	Exit_CreditsScreen			; exit screen

; ===========================================================================
; ---------------------------------------------------------------------------
; Scrolling and text centering
; ---------------------------------------------------------------------------

CS_ScrollMappings:
		; scroll top and bottom chunks of the screen
		lea	($FFFFCC00).w,a1		; load scroll buffer address
		moveq	#0,d0				; clear d0
		move.w	#Credits_ScrollTime/2,d0	; pre-center
		sub.w	(Credits_Scroll).w,d0		; load X scroll position
		swap	d0				; send left
		move.w	#$60-1,d1			; set repeat times
@scrolltop:	move.l	d0,(a1)+			; dump to scroll buffer
		dbf	d1,@scrolltop			; repeat til all scanlines are written to

		swap	d0				; send right
		neg.w	d0				; negate direction
		swap	d0				; send left
		move.w	#$80-1,d1			; set repeat times
@scrollbottom:	move.l	d0,(a1)+			; dump to scroll buffer
		dbf	d1,@scrollbottom		; repeat til all scanlines are written to
; ---------------------------------------------------------------------------

		; horizontal centering
		bsr	Credits_LoadPage		; load current page into a0
		lea	($FFFFCC00).w,a1		; set up H-scroll buffer to the point where the main text is located

		move.w	#Credits_LineLength,d0		; set line length
		moveq	#Credits_Lines-1,d1		; set default loop count of line count
@centertextloop:
		moveq	#0,d2				; clear d2
		movea.l	a0,a2				; create copy of text address
		adda.w	d0,a2				; add line length to the offset (so we start at the end)
		moveq	#Credits_LineLength,d3		; make sure we don't exceed the line limit (for blank lines)
@findlineend:	tst.b	-(a2)				; is current character a space?
		bne.s	@writescroll			; if not, we found the end of the line, branch
		addq.l	#1,d2				; increase 1 to center alignment counter
		subq.b	#1,d3				; subtract one remaining line length limit to check
		bhi.s	@findlineend			; loop until we found the end, or move on if it's a blank line

@writescroll:
		lsl.l	#3,d2				; multiply by 8px per space
		swap	d2				; send to plane A
		rept	16				; 16 scanlines (one row)
		add.l	d2,(a1)+			; write offset to scroll buffer
		endr					; rept end
		adda.w	d0,a0				; go to next line
		adda.w	#2,a0				; + line end marker skip
		dbf	d1,@centertextloop		; loop
		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Write mappings for current page in the credits
; ---------------------------------------------------------------------------

CS_WriteCurrentPage:
		VBlank_SetMusicOnly
		bsr	Credits_LoadPage		; load current page data offset into a0
		lea	($C00000).l,a1			; load VDP data port address to a1
		move.l	#$40000003,d3			; prepare V-Ram address
		move.l	d3,d6				; load V-Ram address
		move.l	#$00800000,d5			; prepare value for increase lines
		move.l	#$007C0000,d4			; prepare value to go to next character
		moveq	#(Credits_Lines*2)-1,d7		; load line repeat times (no idea why I gotta double it)
CS_NextCharacter:
		moveq	#0,d0				; clear d0
		move.b	(a0)+,d0			; load character
		bpl.w	CS_WriteChar			; if it's a regular char, write it
		cmpi.b	#-1,d0				; end of the line?
		bne.w	CS_WriteChar			; if not, it's a lowercase character, write it

		; next line
		add.l	d5,d3				; increase to next line
		move.l	d3,d6				; load V-Ram address
		dbf	d7,CS_NextCharacter		; repeat til all lines are done
		VBlank_UnsetMusicOnly
		rts					; page fully written
; ---------------------------------------------------------------------------

CS_WriteChar:
		move.l	d6,4(a1)			; set VDP

		tst.b	d0				; test current char
		smi.b	d1				; if it's negative, set lowercase char flag
		andi.w	#$7F,d0				; make positive again
		add.w	d0,d0				; multiply by...
		add.w	d0,d0				; ...4
		addi.w	#$8001,d0			; plus 1 + high priority (to not get covered by the stars)		
		tst.b	d1				; lowercase character flag set?
		bne.s	@drawchar			; if yes, branch
		addi.w	#$4000,d0			; use the second palette line

@drawchar:
		move.w	d0,(a1)				; save
		addq.w	#2,d0				; increase by 2
		move.w	d0,(a1)				; save
		subq.w	#1,d0				; decrease by 1
		add.l	d5,d6				; increase to next line
		move.l	d6,4(a1)			; set VDP
		
		addi.w	#$2000,d0			; use next palette row for lower half of the letters to give nice effect
		move.w	d0,(a1)				; save
		addq.w	#2,d0				; increase by 2
		move.w	d0,(a1)				; save

		sub.l	d4,d6				; decrease to previous line
		bra.w	CS_NextCharacter		; loop
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Data
; (single 0's are unused colors)
; ---------------------------------------------------------------------------

Pal_Credits:
		; line 1
		; - bg color
		dc.w	$000			
		dc.w	0
		; - header top
		dc.w	$0422,$0ECC,$0A88	
		dc.w	0,0
		; - stars
		dc.w	$EEE,$CCE,$ECC
		dc.w	0,0,0,0,0,0

		; line 2 - header bottom
		dc.w	0,0
		dc.w	$0400,$0EAA,$0A66
		dc.w	0,0,0,0,0,0,0,0,0,0,0

		; line 3 - main content top
		dc.w	0,0
		dc.w	$0444,$0EEE,$0AAA
		dc.w	0,0,0,0,0,0,0,0,0,0,0

		; line 4 - main content bottom
		dc.w	0,0
		dc.w	$0222,$0AAA,$0888
		dc.w	0,0,0,0,0,0,0,0,0,0,0
		even


; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Map Data
; ---------------------------------------------------------------------------

Credits_LoadPage:
		moveq	#0,d0				; clear d0
		move.b	(Credits_Page).w,d0		; get ID for the current page we want to display
		subq.b	#1,d0				; adjust for index
		bpl.s	@getindex			; if all good, branch
		moveq	#0,d0				; prevent underflow
@getindex:	add.w	d0,d0				; times four...
		add.w	d0,d0				; ...for long alignment
		movea.l	CreditsMaps_Index(pc,d0.w),a0	; load credits page into a0
		rts
; ---------------------------------------------------------------------------
CreditsMaps_Index:
		dc.l	Credits_Page1
		dc.l	Credits_Page2
		dc.l	Credits_Page3
		dc.l	Credits_Page4
		dc.l	Credits_Page5
		dc.l	Credits_Page6
		dc.l	Credits_Page7
		dc.l	Credits_Page8
		dc.l	Credits_Page9
		dc.l	Credits_Page10
		dc.l	Credits_Page11
		dc.l	Credits_Page12
; ---------------------------------------------------------------------------

; Macro to preprocess and output a character to its correct mapping
crdchar macro char		
		if     \char = ' '
			dc.b	0
		elseif \char = '1'
			dc.b	'Z' - 'A' + 2
		elseif \char = '7'
			dc.b	'Z' - 'A' + 3 + $80
		elseif (\char >= 'a') & (\char <= 'z')
			; lowercase letter
			dc.b	\char - 'a' + 1 + $80
		else
			; uppercase letter
			dc.b	\char - 'A' + 1
		endif
	endm
 
crdtxt macro string
		i:   = 1
		len: = strlen(\string)
		if (len<>Credits_LineLength)
			inform 2, "line must be EXACTLY 20 characters long"
		endif

		while (i<=len)
			char:	substr i,i,\string
			crdchar '\char'
			i: = i+1
		endw
		dc.w	$FFFF
	endm
; ---------------------------------------------------------------------------

Credits_Page1:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"direction and       "
		crdtxt	"                    "
		crdtxt	"lead development    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"SELBI               "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page2:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"blast               "
		crdtxt	"                    "
		crdtxt	"processing          "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"VLADIKCOMPER        "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page3:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"assistant           "
		crdtxt	"                    "
		crdtxt	"development         "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"FUZZY               "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page4:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"design advice and   "
		crdtxt	"                    "
		crdtxt	"hardware testing    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"SONICFAN1           "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page5:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"main original       "
		crdtxt	"                    "
		crdtxt	"beta testing        "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"NEONSYNTH           "
		crdtxt	"                    "
		crdtxt	"AKA SONICVAAN       "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
	
Credits_Page6:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"additional          "
		crdtxt	"                    "
		crdtxt	"beta testing        "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"AJCOX               "
		crdtxt	"                    "
		crdtxt	"PEANUT NOCEDA       "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page7:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"main music          "
		crdtxt	"                    "
		crdtxt	"ports               "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"AMPHOBIUS           "
		crdtxt	"                    "
		crdtxt	"AKA DALEKSAM        "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page8:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"additional music    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"SPANNER             "
		crdtxt	"                    "
		crdtxt	"EDUARDO             "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page9:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"special thanks      "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"MARKEYJESTER        "
		crdtxt	"                    "
		crdtxt	"REDHOTSONIC         "
		crdtxt	"                    "
		crdtxt	"MAINMEMORY          "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page10:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"a huge thanks to    "
		crdtxt	"                    "
		crdtxt	"the erazor 7 squad  "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"FUZZY               "
		crdtxt	"SONICFAN1           "
		crdtxt	"VLADIKCOMPER        "
		crdtxt	"NEONSYNTH           "
		crdtxt	"AJCOX               "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page11:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"original game       "
		crdtxt	"                    "
		crdtxt	"by                  "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"SONIC TEAM          "
		crdtxt	"                    "
		crdtxt	"SEGA                "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

Credits_Page12:
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"thank you           "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"FOR PLAYING         "
		crdtxt	"                    "
		crdtxt	"                    "
		crdtxt	"                    "

	even
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Art Data
; ---------------------------------------------------------------------------

ArtKospM_Credits:
		incbin	"Screens/CreditsScreen/Credits_FontArt.kospm"
		even

; ---------------------------------------------------------------------------
; ===========================================================================
