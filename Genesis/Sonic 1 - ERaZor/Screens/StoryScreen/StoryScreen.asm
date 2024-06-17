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
		VBlank_SetMusicOnly
		display_disable
		
		lea	($C00004).l,a6
	;	move.w	#$8004,(a6)
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
		move.b	#1,($FFFFFF7D).w	; make sure the chapters screen leads us to the correct level
		bra.w	STS_ExitScreen		; auto-skip the cringe

@cont:	
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
		dbf	d1,STS_LoadText ; load uncompressed text patterns

		jsr	BGDeformation_Setup

		moveq	#$14,d0
		jsr	PalLoad1	; load level select pallet

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
		VBlank_UnsetMusicOnly
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
		jsr	Options_BackgroundEffects
		jsr	Options_ERZPalCycle

		bsr	StoryScreen_ContinueWriting

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
; Subroutine to continue loading the story text, if necessary
; ---------------------------------------------------------------------------

StoryScreen_ContinueWriting:
		moveq	#0,d0
		move.b	($FFFFFF9E).w,d0 	; get ID for the current text we want to display
		add.w	d0,d0
		add.w	d0,d0

		movea.l	StoryText_Index(pc,d0.w),a0
		
		;font at VRAM $D000
		;  0 - space
		; 20 - '
		; 40 - :
		; 60 - 3
		; 80 - 4
		; A0 - - (left)
		; C0 - - (middle)
		; E0 - - (right)
		;100 - >
		;120 - !
		;140 - A
		;... - the remaining alphabet
		;480 - Z
		;4A0 - -  
		;4C0 - .  
		;4E0 - ,  
		;500 - ?  

		rts
; ===========================================================================

StoryScreen_centerText:
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
; ---------------------------------------------------------------------------
; Story Text Index
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

STS_Continue:		dc.b	' PRESS START TO CONTINUE... '
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

StoryText_9:	; text after beating the blackout challenge special stage
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
; ===========================================================================

; ===========================================================================
STS_FontArt:	incbin	Screens\StoryScreen\StoryScreen_Font.bin
		even
; ===========================================================================
Pal_StoryScreen:	incbin	Screens\StoryScreen\StoryScreen_Pal.bin
		even
; ===========================================================================
