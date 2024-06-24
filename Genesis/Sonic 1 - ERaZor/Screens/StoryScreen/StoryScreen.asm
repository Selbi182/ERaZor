; ---------------------------------------------------------------------------
; Story Text Screens
; ---------------------------------------------------------------------------
STS_LineLength = 28
STS_LinesTotal = 20
STS_Sound = $D8

STS_FullyWritten	equ $FFFFFF95 ; b
STS_Row			equ $FFFFFF96 ; b
STS_Column		equ $FFFFFF97 ; w
STS_CurrentChar		equ $FFFFFF98 ; w
STS_Delay		equ $FFFFFF9A ; b
STS_ScreenID		equ $FFFFFF9E ; b
; ---------------------------------------------------------------------------

; StoryTextScreen:
StoryScreen:				; XREF: GameModeArray
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
		
		move.w	#STS_LinesTotal,($FFFFFF82).w
		display_enable
		VBlank_UnsetMusicOnly
		jsr	Pal_FadeTo

; ===========================================================================
; ---------------------------------------------------------------------------
; Info Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
StoryScreen_MainLoop:
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	Options_BackgroundEffects
		jsr	Options_ERZPalCycle

		bsr	StoryScreen_ContinueWriting

		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	StoryScreen_MainLoop	; if not, branch

		tst.b	(STS_FullyWritten).w	; is text already fully written?
		bne.s	STS_ExitScreen		; if yes, exit screen
		bsr.w	StoryText_WriteFull	; write the complete text
		bra.s	StoryScreen_MainLoop	; loop
; ---------------------------------------------------------------------------

STS_ExitScreen:
		moveq	#0,d2
		jsr	Options_ClearBuffer

		cmpi.b	#1,(STS_ScreenID).w	; is this the intro dialouge?
		bne.s	STS_NoIntro		; if not, branch
		cmpi.b	#1,($FFFFFFA7).w	; is this the first time start of the game?
		bgt.s	@notfirstvisit		; if not, branch
		move.b	#1,($FFFFFFA7).w	; run first chapter screen
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	#1,($200000+SRAM_Chapter).l	; save chapter to SRAM
		move.b	#0,($A130F1).l		; disable SRAM
@notfirstvisit:
		move.b	#4,($FFFFF600).w	; set to title screen
		rts

STS_NoIntro:
		cmpi.b	#8,(STS_ScreenID).w	; is this the ending sequence?
		bne.s	STS_NoEnding		; if not, branch
		move.b	#$18,($FFFFF600).w	; set to ending sequence ($18)
		rts

STS_NoEnding:
		cmpi.b	#9,(STS_ScreenID).w	; is this the easter egg?
		bne.s	STS_NoEaster		; if not, branch
		move.w	#$302,($FFFFFE10).w	; set level to SLZ3
		move.b	#$C,($FFFFF600).w
		move.w	#1,($FFFFFE02).w	; restart level
		rts

STS_NoEaster:
		cmpi.b	#$A,(STS_ScreenID).w	; is this the blackout special stage?
		bne.s	STS_NoBlack		; if not, branch
		move.b	#$00,($FFFFF600).w	; set to sega screen ($00)
		rts

STS_NoBlack:
		bsr	STS_ClearFlags
		jmp	NextLevelX
; ===========================================================================

STS_ClearFlags:
		clr.b	(STS_FullyWritten).w
		clr.b	(STS_Row).w
		clr.b	(STS_Column).w
		clr.w	(STS_CurrentChar).w
		clr.b	(STS_Delay).w
		rts
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to continue loading the story text, if necessary
; ---------------------------------------------------------------------------
STS_BaseRow = 7
STS_BaseCol = 6
STS_VRAMBase = $60000003|($800000*STS_BaseRow)|($20000*STS_BaseCol)
; ---------------------------------------------------------------------------

StoryScreen_ContinueWriting:
		tst.b	(STS_FullyWritten).w		; is text already fully written?
		bne.w	@writeend			; if yes, don't continue writing

@skipspaces:	bsr	StoryText_Load			; load story text into a1
		adda.w	(STS_CurrentChar).w,a1		; find the char we want to write

		moveq	#0,d0				; clear d0
		move.b	(a1),d0				; move current char to d0
		bne.s	@notspace			; if it isn't a space, branch
		suba.w	(STS_CurrentChar).w,a1		; undo the offset adjustment from above
		bsr.w	@gotonextpos			; go to next char (skip spaces)
		bra.s	@skipspaces			; loop

@notspace:
		bpl.s	@dowrite			; did we reach the end of the list (-1)? if not, branch
		move.b	#1,(STS_FullyWritten).w		; otherwise, mark as complete
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

		VBlank_SetMusicOnly
		move.l	d3,4(a6)			; write final position to VDP
		add.w	#$8000|$6000|($D000/$20),d0	; apply VRAM settings (high plane, palette line 4, VRAM address $D000)
		move.w	d0,(a6)				; write char to screen
		VBlank_UnsetMusicOnly

		move.b	#STS_Sound,d0			; play...
		jsr	PlaySound_Special		; ... text writing sound

@gotonextpos:
		addq.b	#1,(STS_Column).w		; go to next column
		cmpi.b	#STS_LineLength,(STS_Column).w	; did we reach the end of the row?
		blo.s	@nottheendoftherow		; if not, branch
		move.b	#0,(STS_Column).w		; reset column
		addq.b	#1,(STS_Row).w			; go to next row

@nottheendoftherow:
		addq.w	#1,(STS_CurrentChar).w		; go to next char for the next iteration

@writeend:
		rts
; ---------------------------------------------------------------------------

StoryText_WriteFull:
		VBlank_SetMusicOnly
		bsr	STS_ClearFlags			; make sure any previously written text doesn't interfere	
		bsr	StoryText_Load			; reload beginning of story text into a1
		
		lea	($C00000).l,a6
		move.l	#STS_VRAMBase,d4		; base screen position
		move.w	#$8000|$6000|($D000/$20),d3	; VRAM setting (high plane, palette line 4, VRAM address $D000)
		moveq	#STS_LinesTotal,d1		; number of lines of text

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
		move.b	#1,(STS_FullyWritten).w		; set flag
		VBlank_UnsetMusicOnly
		rts

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

STS_Continue:	ststxt	"PRESS START TO CONTINUE...  "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_1:	; text after intro cutscene
		ststxt	"THE SPIKED SUCKER DECIDED   "
		ststxt	"TO GO BACK TO THE HILLS AND "
		ststxt	"CHECK OUT WHAT WAS GOING ON."
		ststxt	"                            "
		ststxt	"WHEN SUDDENLY...            "
		ststxt	"EXPLOSIONS! EVERYWHERE!     "
		ststxt	"A GRAY METALLIC BUZZ BOMBER "
		ststxt	"SHOWERED EXPLODING BOMBS ON "
		ststxt	"HIM! SONIC ESCAPED IT, BUT  "
		ststxt	"MINDLESSLY FELL INTO A RING "
		ststxt	"TRAP AND LANDED IN A        "
		ststxt	"STRANGE PARALLEL DIMENSION. "
		ststxt	"                            "
		ststxt	"HE NEEDS TO BLAST HIS WAY TO"
		ststxt	"EGGMAN AND ESCAPE IT...     "
		dc.b	-1
		even
; ---------------------------------------------------------------------------

StoryText_2:	; text after beating Night Hill Place
		ststxt	"TELEPORTING WATERFALLS,     "
		ststxt	"CRABMEATS WITH EXPLODING    "
		ststxt	"BALLS, AND THE ORIGINAL     "
		ststxt	"GREEN HILL ZONE TRANSFORMED "
		ststxt	"INTO AN ACTION MOVIE OR     "
		ststxt	"SOMETHING. TOP IT OFF WITH  "
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
		ststxt	"CAREER AS A COMMEDIAN AHEAD!"
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
		ststxt	"CONGRATULATIONS!            "
		ststxt	"                            "
		ststxt	"YOU HAVE BEATEN THE         "
		ststxt	"BLACKOUT CHALLENGE.         "
		ststxt	"                            "
		ststxt	"CHECK OUT THE OPTIONS MENU, "
		ststxt	"A NEW COOL FEATURE HAS BEEN "
		ststxt	"UNLOCKED FOR YOU TO MESS    "
		ststxt	"AROUND WITH!                "
		ststxt	"                            "
		ststxt	"HAVE FUN AND THANK YOU SO   "
		ststxt	"MUCH FOR PLAYING MY GAME!   "
		ststxt	"                            "
		ststxt	"                            "
		ststxt	"SELBI                       "
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
