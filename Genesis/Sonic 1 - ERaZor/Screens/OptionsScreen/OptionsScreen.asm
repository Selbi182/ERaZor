; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------
Options_Blank = $29 ; blank character, high priority
OptionsBuffer equ $FFFFC900 ; $200 bytes
Options_ShadowMode = 0
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		move	#$2700,sr

		lea	($C00004).l,a6
	;	move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)

	if Options_ShadowMode=1
		move.w	#$8C81|8,(a6) ; enable shadow mode
	endif
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram ; fill object RAM ($D000-$EFFF) with $0

		jsr	Pal_FadeFrom

		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F
@loadtextart:	move.w	(a5)+,(a6)
		dbf	d1,@loadtextart ; load uncompressed text patterns

		move.l	#$64000002,4(a6)
		lea	(ArtKospM_ERaZorNoBG).l,a0
		jsr	KosPlusMDec_VRAM

		lea	($FFFFD100).w,a0
		move.b	#2,(a0)			; load ERaZor banner object
		move.w	#$11E,obX(a0)		; set X-position
		move.w	#$87,obScreenY(a0)	; set Y-position
		bset	#7,obGfx(a0)		; otherwise make object high plane
		
		jsr	ObjectsLoad
		jsr	BuildSprites

	;	move.b	#$86,d0		; play Options screen music (Spark Mandrill)
		move.b	#$99,d0		; play Options screen music (introduction text music)
		jsr	PlaySound_Special
		bsr	Options_LoadPal
  
		bra.s	Options_ContinueSetup
		

; ---------------------------------------------------------------------------
Options_LoadPal:
		moveq	#2,d0		; load level select palette
		jsr	PalLoad1
	;	moveq	#3,d0		; load Sonic palette
	;	jsr	PalLoad1

		movem.l	d0-a2,-(sp)		; backup d0 to a2
		lea	(Pal_ERaZorBanner).l,a1	; set ERaZor banner's palette pointer
		lea	($FFFFFBA0).l,a2	; set palette location
		moveq	#7,d0			; set number of loops to 7
@0:		move.l	(a1)+,(a2)+		; load 2 colours (4 bytes)
		dbf	d0,@0			; loop
		movem.l	(sp)+,d0-a2		; restore d0 to a2
		rts
; ---------------------------------------------------------------------------

Options_ClearBuffer:
		moveq	#0,d0
		moveq	#0,d1
		lea	(OptionsBuffer).w,a1	; set location for the text
		move.b	d2,d0			; passed char
		move.b	d0,d1
		rept	3	; turn it into four bytes of the same thing
		rol.l	#8,d1
		or.l	d1,d0
		endr

		move.l	#($200/4)-1,d1		; do it for all 504 chars
@fillblank:	move.l	d0,(a1)+		; put blank character into current spot
		dbf	d1,@fillblank		; loop
		rts
; ---------------------------------------------------------------------------

Options_ContinueSetup:
		move.b	#Options_Blank,d2
		bsr.s	Options_ClearBuffer
		bsr	BGDeformation_Setup

 		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
		clr.w	($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w
		clr.w	($FFFFFF9C).w		; previously used to coordinate the intro sequence, now unused
		move.b	#$81,($FFFFFF84).w
				
		lea	($FFFFCC00).w,a1
		move	#$2700,sr
		moveq	#0,d0
		move.w	#$DF,d1
@clearscroll:	move.l	d0,(a1)+
		dbf	d1,@clearscroll ; fill scroll data with 0
		move.l	d0,($FFFFF616).w

Options_FinishSetup:
		move.w	#19,($FFFFFF82).w	; set default selected entry to exit
		bsr	OptionsTextLoad		; load options text
		display_enable
		jsr	Pal_FadeTo

		bra.w	OptionsScreen_MainLoop

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Options menu background effects
; ---------------------------------------------------------------------------

Options_BackgroundEffects:
		ints_push
		move.l	a2,-(sp)
		bsr	Options_BGPalCycle
		bsr	Options_BGDeformation
		bsr	Options_BGVScroll
		move.l	(sp)+,a2
		ints_pop
		rts
; ===========================================================================

BGDeformation_Setup:
		VBlank_SetMusicOnly

		lea	($C00000).l,a6		
		move.l	#$40200000,4(a6)
		lea	(Options_BGArt).l,a0
		jsr	KosPlusMDec_VRAM

		; background mappings
		vram	$C000,4(a6)		; set VDP to VRAM and start at E000 (location of Plane B nametable)
		moveq	#3,d6			; repeats
@repeat:	moveq	#1,d5
		moveq	#(256/8)-1,d1		; write columns
		moveq	#(256/8)/2-1,d2		; write lines
@row:		move.w	d1,d3			; reload number of columns
@column:	move.w	d5,(a6)			; dump map to VDP map slot
		addi.w	#1,d5			; go to next tile
		dbf	d3,@column		; repeat til columns have dumped
		dbf	d2,@row			; repeat til all rows have dumped	
		dbf	d6,@repeat

		VBlank_UnsetMusicOnly
		rts
; ===========================================================================

; Background palette rotation
Options_BGPalCycle:
		move.w	($FFFFFE0E).w,d0	; get V-blank timer
		andi.w	#$F,d0
		divu.w	#8,d0
		andi.l	#$FFFF0000,d0
		bne.w	@bgpalend
		addq.b	#1,($FFFFFF85).w	; increase timer

		moveq	#0,d0
		move.l	#Options_BGCycleColors_BW,d2
		movea.l	d2,a1
		move.b	($FFFFFF85).w,d0	; get timer
		andi.w	#$F,d0
		add.w	d0,d0
		adda.w	d0,a1

		lea	($FFFFFB02).w,a2
		moveq	#10-1,d6	; 10 colors
@bgpalcycle:
		moveq	#0,d0
		lea	(Obj03_BG).l,a3
		move.b	($FFFFFF9E).w,d0
		
		subq.b	#2,d0
		add.w	d0,d0
		adda.w	d0,a3
		
		move.w	(a3),d0		; get theme color

		move.w	(a1)+,d1	; get mask color
		bpl.s	@dolimit
		movea.l	d2,a1		; reset cycle location
		bra.s	@bgpalcycle
@dolimit:
		moveq	#0,d3		; limited color
		
		move.w	d1,d4		; copy mask color
		andi.w	#$00E,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$00E,d5
		cmp.w	d5,d4
		bls.s	@0
		move.w	d5,d4
@0		or.w	d4,d3

		move.w	d1,d4		; copy mask color
		andi.w	#$0E0,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$0E0,d5
		cmp.w	d5,d4
		bls.s	@1
		move.w	d5,d4
@1		or.w	d4,d3

		move.w	d1,d4		; copy mask color
		andi.w	#$E00,d4	; limit mask color
		move.w	d0,d5		; copy theme color
		andi.w	#$E00,d5
		cmp.w	d5,d4
		bls.s	@2
		move.w	d5,d4
@2		or.w	d4,d3

		move.w	d3,(a2)+
		dbf	d6,@bgpalcycle
@bgpalend:
		rts
; ---------------------------------------------------------------------------
Options_BGCycleColors_BW:
		dc.w	$000
		dc.w	$000
		dc.w	$222
		dc.w	$444
		dc.w	$666
		dc.w	$666
		dc.w	$888
		
		dc.w	$AAA
		dc.w	$AAA
		
		dc.w	$888
		dc.w	$666
		dc.w	$666
		dc.w	$444
		dc.w	$222
		dc.w	$000
		dc.w	$000

		dc.w	  -1
		even

Options_BGCycleColors:
		dc.w	$000
		dc.w	$000
		dc.w	$200
		dc.w	$420
		dc.w	$640
		dc.w	$860
		dc.w	$880
		
		dc.w	$680
		dc.w	$680
		
		dc.w	$880
		dc.w	$880
		dc.w	$680
		dc.w	$460
		dc.w	$240
		dc.w	$020
		dc.w	$220

		dc.w	  -1
		even
; ---------------------------------------------------------------------------

; Background deformation (the main effect)
Options_BGDeformation:
		moveq	#0,d0
	
Options_BGDeformation2:
		move.l	d7,-(sp)
		moveq	#0,d7
		move.w	($FFFFFE0E).w,d6	; get timer
		tst.b	d0
		beq.s	@noadjust
		move.w	d0,d7
@noadjust:
		lea	($FFFFCC00).w,a1
		move.w	#(224/1)-1,d3
		jsr	RandomNumber
@scroll:
		ror.l	#1,d1
		move.l	d1,d2
		andi.l	#$001F0000,d2
		
		moveq	#0,d0
		moveq	#0,d4
		move.w	d6,d0	; get timer
		swap	d0
		btst	#0,d3
		beq.s	@1
		neg.l	d0
@1:
		andi.l	#$0000FFFF,d0
		swap	d0
		add.w	d6,d0 ; scroll everything to the right
		btst	#0,d5
		beq.s	@3
		sub.w	d6,d0 ; scroll everything to the left
@3:
		move.w	d0,d4		; copy scroll
		add.w	d3,d4		; add line index
		subi.w	#224/2,d4
		movem.l	d0/d1,-(sp)
		move.w	d4,d0
		jsr	CalcSine
		
		move.w	d3,d5
		add.w	d6,d5
		btst	#7,d5
		beq.s	@2
		neg.w	d0
@2:
		move.w	d0,d4
		
		movem.l	(sp)+,d0/d1
		add.w	d4,d0
		swap	d0
		or.l	d0,d2
		tst.b	d7
		beq.s	@bla
		asr.l	d7,d2
		andi.l	#$FFFF0000,d2
@bla
		move.l	d2,(a1)+
		dbf	d3,@scroll ; fill scroll data with 0
		move.l	(sp)+,d7
		rts
; ---------------------------------------------------------------------------


; V-Scroll
Options_BGVScroll:
		lea	($C00000).l,a0			; init VDP data port in a0
		move.l	#$40000010,4(a0)		; set VDP control port to VSRAM mode and start at 00
		move.w	#(320/8)-1,d0			; do it for all 40 double-tiles (320 width = 80 tiles at 8 pixels)
@vScroll_loop:	moveq	#0,d1
		move.w	($FFFFFE0E).w,d1
		lsl.w	#1,d1
		swap	d1
		move.l	d1,(a0)				; dump art to VSRAM
		dbf	d0,@vScroll_loop		; repeat until all lines are done
		rts
; ---------------------------------------------------------------------------

; ERaZor banner palette cycle
Options_ERZPalCycle:
		; banner itself
		moveq	#0,d1
		lea	($FFFFFB20).w,a2
		jsr	ERaZorBannerPalette
		
		; selected line
		moveq	#0,d1
		lea	($FFFFFB40-6*2).w,a2
		jsr	ERaZorBannerPalette
		rts
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

OptionsScreen_MainLoop:
		move.b	#2,($FFFFF62A).w
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

		bsr	OptionsControls
		jsr	PLC_Execute
		
		bsr.w	Options_BackgroundEffects
		bsr.w	Options_ERZPalCycle

		tst.l	PLC_Pointer		; are pattern load cues empty?
		bne.s	OptionsScreen_MainLoop	; if not, branch to avoid visual corruptions

; ---------------------------------------------------------------------------
; All options are kept in a single byte to save space (it's all flags anyway)
; RAM location: $FFFFFF92
;  bit 0 = Extended Camera
;  bit 1 = Skip Story Screens
;  bit 2 = Skip Uberhub Place
;  bit 3 = Cinematic Mode
;  bit 4 = Nonstop Inhuman (Unlockable)
;  bit 5 = Gamplay Style (0 - Casual Mode // 1 - Frantic Mode)
;  bit 6 = [unused]
;  bit 7 = [unused]
; ---------------------------------------------------------------------------

Options_HandleChange:
		tst.b	($FFFFF605).w		; was anything at all pressed this frame?
		beq.s	OptionsScreen_MainLoop	; if not, branch


; randomize BG color with B, just for testing
@newbgcolor:	btst	#4,($FFFFF605).w	; has B been pressed?
		beq.s	@0
		jsr	RandomNumber
		add.w	d0,($FFFFFF9E).w
		subq.b	#2,d0
		add.w	d0,d0
		adda.w	d0,a3
		move.w	(a3),d0
		beq.s	@newbgcolor
		bra.w	Options_Return
@0:
	
		moveq	#0,d0			; make sure d0 is empty
		move.w	($FFFFFF82).w,d0	; get current selection
		subq.w	#3,d0			; first option starts at line 3
		move.w	OpHandle_Index(pc,d0.w),d0
		jmp	OpHandle_Index(pc,d0.w)
; ===========================================================================
OpHandle_Index:	dc.w	Options_HandleGameplayStyle-OpHandle_Index
		dc.w	Options_HandleExtendedCamera-OpHandle_Index
		dc.w	Options_HandleStoryTextScreens-OpHandle_Index
		dc.w	Options_HandleSkipUberhub-OpHandle_Index
		dc.w	Options_HandleCinematicMode-OpHandle_Index
		dc.w	Options_HandleNonstopInhuman-OpHandle_Index
		dc.w	Options_HandleDeleteSaveGame-OpHandle_Index
		dc.w	Options_HandleSoundTest-OpHandle_Index
		dc.w	Options_HandleExit-OpHandle_Index
; ===========================================================================

Options_HandleGameplayStyle:
		move.b	($FFFFF605).w,d1	; get button presses
	 	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch

		btst	#6,d1			; is A pressed?
		bne.s	@quicktoggle		; if yes, quick toggle

	 	andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen
	if Options_ShadowMode=1
		move.w	#$8C81|0,($C00004).l	; disable shadow mode		
	endif
		rts
@quicktoggle:
		bchg	#5,($FFFFFF92).w	; toggle gameplay style
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleExtendedCamera:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#0,($FFFFFF92).w	; toggle extended camera
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleStoryTextScreens:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#1,($FFFFFF92).w	; toggle text screens
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleSkipUberhub:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#2,($FFFFFF92).w	; toggle Uberhub autoskip
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleCinematicMode:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		bchg	#3,($FFFFFF92).w	; toggle cinematic HUD
		bsr	Options_LoadPal
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleNonstopInhuman:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$FC,d1			; is left, right, A, B, C, or Start pressed?
		beq.w	Options_Return		; if not, branch
		tst.b	($FFFFFF93).w		; has the player beaten the game?
		bne.s	@nonstopinhumanallowed	; if yes, branch
		move.w	#$DA,d0			; play option disallowed sound
		jsr	PlaySound_Special
		bra.w	Options_UpdateTextAfterChange_NoSound
		
@nonstopinhumanallowed:
		bchg	#4,($FFFFFF92).w	; toggle nonstop inhuman
		clr.b	($FFFFFFE7).w		; make sure inhuman is disabled if this option is as well
		bra.w	Options_UpdateTextAfterChange
; ---------------------------------------------------------------------------

Options_HandleDeleteSaveGame:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$80,d1			; is Start pressed? (this option only works on start because of how delicate it is)
		beq.w	Options_Return		; if not, return
		
		ints_disable
		move.w	#90,($FFFFFF82).w	; set fade-out sequence time to 90 frames
@delete_fadeoutloop:
		subq.w	#1,($FFFFFF82).w	; subtract 1 from remaining time
		bmi.s	@delete_fadeoutend	; is time over? end fade-out sequence
		
		jsr	RandomNumber		; get new random number
		lea	($FFFFCC00).w,a1	; load scroll buffer address
		move.w	#223,d2			; do it for all 224 lines
@0		jsr	CalcSine		; further randomize the offset after every line
		move.l	d1,(a1)+		; dump to scroll buffer
		dbf	d2,@0			; repeat
		
		move.w	($FFFFFF82).w,d0	; get remaining time
		andi.w	#7,d0			; only trigger every 7th frame
		bne.s	@1			; is it not a 7th frame?, branch
		jsr	Pal_FadeOut		; partially fade-out palette
		move.b	#$C4,d0			; play explosion sound
		jsr	PlaySound_Special	; ''

@1		move.b	#2,($FFFFF62A).w	; run V-Blank
		jsr	DelayProgram		; ''
		bra.s	@delete_fadeoutloop	; loop

@delete_fadeoutend:
		move.b	#1,($A130F1).l		; enable SRAM
		clr.b	($200000+SRAM_Exists).l	; unset the magic number (actual SRAM deletion happens during restart)
		move.b	#0,($A130F1).l		; disable SRAM
		jmp	Init			; restart the game
; ---------------------------------------------------------------------------

Options_HandleSoundTest:
		tst.b	($FFFFF605).w		; anything pressed this frame?
		beq.w	Options_Return		; if not, branch
		move.b	($FFFFF605).w,d1	; get button presses
		btst	#4,d1			; is button B pressed?
		bne.s	@soundtest_stop		; if yes, branch
		andi.b	#$A0,d1			; is C or Start pressed?
		beq.s	@soundtest_checkL	; if not, branch
		move.b	($FFFFFF84).w,d0	; move sound test ID to d0
		cmpi.b	#$80,d0			; is this ID $80?
		bne.s	@soundtest_not80	; if not, branch
@soundtest_stop:
		move.b	#$E4,d0			; otherwise, make it stop all sound
@soundtest_not80:
		jsr	PlaySound_Special	; play music

@soundtest_checkL:
		btst	#2,($FFFFF605).w	; has left been pressed?
		beq.s	@soundtest_checkR	; if not, branch
		subq.b	#1,($FFFFFF84).w	; decrease sound test ID by 1
		cmpi.b	#$7F,($FFFFFF84).w	; is ID now $7F?
		bne.s	@soundtest_checkR	; if not, branch
		move.b	#$DF,($FFFFFF84).w	; set ID to $DF

@soundtest_checkR:
		btst	#3,($FFFFF605).w	; has right been pressed?
		beq.s	@soundtest_checkA	; if not, branch
		addq.b	#1,($FFFFFF84).w	; increase sound test ID by 1
		cmpi.b	#$E0,($FFFFFF84).w	; is ID now $E0?
		bne.s	@soundtest_checkA	; if not, branch
		move.b	#$80,($FFFFFF84).w	; set ID to $80

@soundtest_checkA:
		btst	#6,($FFFFF605).w	; has A been pressed?
		beq.s	@soundtest_end		; if not, branch
		addi.b	#$10,($FFFFFF84).w	; increase sound test ID by $10
		cmpi.b	#$E0,($FFFFFF84).w	; is ID over or at $E0 now?
		blt.s	@soundtest_end		; if not, branch
		subi.b	#$60,($FFFFFF84).w	; restart on the other side

@soundtest_end:
		bra.w	Options_UpdateTextAfterChange_NoSound
; ---------------------------------------------------------------------------

Options_HandleExit:
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$F0,d1			; is A, B, C, or Start pressed?
		beq.s	Options_Return		; if not, branch
		
Options_Exit:
		moveq	#0,d2
		bsr.w	Options_ClearBuffer

		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.b	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w

		moveq	#0,d0			; clear d0
		move.b	#1,($A130F1).l		; enable SRAM
		move.b	($FFFFFF92).w,($200001).l	; backup options flags
		move.b	#0,($A130F1).l		; disable SRAM

		move.w	#$400,($FFFFFE10).w
		move.b	#$C,($FFFFF600).w	; set screen mode to level ($C)
	if Options_ShadowMode=1
		move.w	#$8C81|0,($C00004).l	; disable shadow mode
	endif
		rts
; ---------------------------------------------------------------------------

Options_UpdateTextAfterChange:
		move.w	#$D9,d0			; play option toggled sound
		jsr	PlaySound_Special

Options_UpdateTextAfterChange_NoSound:
		bsr	OptionsTextLoad

Options_Return:
		bra.w	OptionsScreen_MainLoop	; return
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to	change what you're selecting in the level select
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


OptionsControls:				; XREF: OptionsScreen_MainLoop
		move.b	($FFFFF605).w,d1
		andi.b	#3,d1		; is up/down pressed and held?
		bne.s	Options_UpDown	; if yes, branch
		subq.w	#1,($FFFFFF80).w ; subtract 1 from time	to next	move
		bpl.s	Options_SndTest	; if time remains, branch

Options_UpDown:
		move.w	#9,($FFFFFF80).w ; reset time delay ($B)
		move.b	($FFFFF604).w,d1
		andi.b	#3,d1		; is up/down pressed?
		beq.s	Options_SndTest	; if not, branch
		move.b	#$D8,d0
		jsr	PlaySound_Special
		move.w	($FFFFFF82).w,d0
		btst	#0,d1		; is up	pressed?
		beq.s	Options_Down	; if not, branch
		subq.w	#2,d0		; move up 1 selection
		cmpi.w	#3,d0
		bge.s	Options_Down
		moveq	#19,d0		; if selection moves below 4, jump to selection	19 (exit)

Options_Down:
		btst	#1,d1		; is down pressed?
		beq.s	Options_Refresh	; if not, branch
		addq.w	#2,d0		; move down 1 selection
		cmpi.w	#19,d0
		ble.s	Options_Refresh
		moveq	#3,d0		; if selection moves above 19,	jump to	selection 4 (first option)

Options_Refresh:
		move.w	d0,($FFFFFF82).w ; set new selection
		bsr	OptionsTextLoad	; refresh text
		rts
; ===========================================================================

Options_SndTest:				; XREF: OptionsControls
		move.b	($FFFFF605).w,d1
		andi.b	#$C,d1		; is left/right	pressed?
		beq.s	Options_NoMove	; if not, branch
		bsr	OptionsTextLoad	; refresh text

Options_NoMove:
		rts	
; End of function OptionsControls

; ---------------------------------------------------------------------------
; Subroutine to load the Options menu text
; ---------------------------------------------------------------------------
Options_VRAM = $E570
Options_VRAM_Red = $C570
Options_VDP = $600C0003

Options_LineCount = 22
Options_LineLength = 24
Options_Padding = 2
Options_LineLengthTotal = Options_LineLength + (Options_Padding * 2)

blankline macro lines
		rept	\lines
		move.l	d4,4(a6)
		rept	Options_LineLengthTotal
		move.w	#Options_VRAM+Options_Blank,(a6)
		endr
		addi.l	#$800000,d4
		endr
		endm
; ---------------------------------------------------------------------------

OptionsTextLoad:				; XREF: TitleScreen
		bsr	GetOptionsText

		lea	($FFFFC900).w,a1	; get preloaded text buffer	
		lea	($C00000).l,a6
		move.l	#Options_VDP,d4		; screen position (text)
		
		; prefill top with non-shadowy blank tiles
		blankline 4

		; write text to buffer
		move.w	#Options_VRAM,d3	; VRAM setting
		moveq	#Options_LineCount-1,d1		; number of lines of text
@writeline:	
		move.l	d4,4(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
		bsr	Options_WriteLine
		move.w	#Options_VRAM+Options_Blank,(a6)
		move.w	#Options_VRAM+Options_Blank,(a6)
@1:
		addi.l	#$800000,d4
		dbf	d1,@writeline
		
		; postfill bottom with non-shadowy blank tiles
		blankline 2

		rts	
; End of function OptionsTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Options_WriteLine:				; XREF: OptionsTextLoad
		moveq	#Options_LineLength-1,d2

Options_WriteLine2:
		moveq	#0,d0
		move.b	(a1)+,d0		; is text set to use the red font?
		bpl.s	OWL_WriteNoHighlight	; if not, render default

		cmpi.b	#$FF,d0			; reached end of list?
		beq.s	OWL_End			; if yes, branch

		move.w	#Options_VRAM_Red,d3	; red palette line
		andi.b	#$7F,d0
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,Options_WriteLine2

OWL_End:
		rts	
; ===========================================================================

OWL_WriteNoHighlight:				; XREF: Options_WriteLine
		move.w	#Options_VRAM,d3	; default palette line
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,Options_WriteLine2
		rts	
; End of function Options_WriteLine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the options text completely at once.
; ---------------------------------------------------------------------------

GetOptionsText:
		lea	($FFFFC900).w,a1		; set destination
		moveq	#0,d1				; use $FF as ending of the list

		lea	(OpText_Header1).l,a2		; set text location
		moveq	#-1,d2
		bsr.w	Options_Write			; write text

		lea	(OpText_Header2).l,a2		; set text location
		moveq	#-1,d2
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength*2,a1	; make two empty lines

		lea	(OpText_GameplayStyle).l,a2	; set text location
		moveq	#1,d2
		bsr.w	Options_Write			; write text
		moveq	#1,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_Extended).l,a2		; set text location
		moveq	#2,d2
		bsr.w	Options_Write			; write text
		moveq	#2,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_SkipStory).l,a2		; set text location
		moveq	#3,d2				; set d2 to 3
		bsr.w	Options_Write			; write text
		moveq	#3,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_SkipUberhub).l,a2	; set text location
		moveq	#4,d2				; set d2 to 3
		bsr.w	Options_Write			; write text
		moveq	#4,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		lea	(OpText_CinematicMode).l,a2	; set text location
		moveq	#5,d2				; set d2 to 3
		bsr.w	Options_Write			; write text
		moveq	#5,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line
		
		move.l	#OpText_EasterEgg_Locked,d6	; set locked text location	
		tst.b	($FFFFFF93).w			; has the player beaten the game?
		beq.s	@uselockedtext			; if not, branch
		move.l	#OpText_EasterEgg_Unlocked,d6	; set unlocked text location
@uselockedtext:
		movea.l	d6,a2				; set text location
		moveq	#6,d2				; set d2 to 4
		bsr.w	Options_Write			; write text
		moveq	#6,d2				; set d2 to 4
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		moveq	#6,d2				; set d2 to 4
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength,a1		; make one empty line

		lea	(OpText_DeleteSRAM).l,a2	; set text location
		moveq	#7,d2				; set d2 to 4
		bsr.w	Options_Write			; write text

		adda.w	#Options_LineLength+3,a1	; make one empty line + 3 characters (because the delete save option is a one-time action button)

; ---------------------------------------------------------------------------
		lea	(OpText_SoundTest).l,a2		; set text location
		moveq	#8,d2				; set d2 to 4
		bsr.w	Options_Write			; write text
		
		move.b	#$0D,-3(a1)			; write < before the ID
		move.b	#$0E,2(a1)			; write > after the ID

		move.b	($FFFFFF84).w,d0		; get sound test ID
		lsr.b	#4,d0				; swap first and second short
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip1			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)

GOT_Snd_Skip1:
		move.b	d0,-1(a1)			; set result to first digit ("8" 1)

		move.b	($FFFFFF84).w,d0		; get sound test ID
		andi.b	#$0F,d0				; clear first short
		cmpi.b	#9,d0				; is result greater than 9?
		ble.s	GOT_Snd_Skip2			; if not, branch
		addi.b	#5,d0				; skip the special chars (!, ?, etc.)

GOT_Snd_Skip2:
		move.b	d0,0(a1)			; set result to second digit (8 "1")
		adda.w	#3,a1				; adjust for the earlier sound test offset
; ---------------------------------------------------------------------------

		adda.w	#Options_LineLength*2,a1	; make two empty lines

		lea	(OpText_Exit).l,a2		; set text location
		moveq	#9,d2
		bsr.w	Options_Write			; write text

; ---------------------------------------------------------------------------

		; make currently selected line red
		lea	($FFFFC900+Options_LineLength).w,a1	; set location
		move.w	($FFFFFF82).w,d5			; get current selection
		cmpi.w	#19,d5					; are we on the exit line?
		bne.s	@0					; if not, branch
		addq.w	#1,d5					; adjust for exit line
@0:
		bsr.s	Options_HighlightLine			; apply highlight
		rts						; return
; ===========================================================================

Options_HighlightLine:
		mulu.w	#Options_LineLength,d5			; multiply by line length
		adda.w	d5,a1
		moveq	#Options_LineLength-1,d2
@redline:	ori.b	#$80,(a1)+				; mark line to use red
		dbf	d2,@redline
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the text given in the input (a2), into the given
; location (a1). Write until $FF, unless a value has been given (d1).
; Line will be highlighted if d2 negative.
; ---------------------------------------------------------------------------

Options_Write:
		move.b	(a2)+,d0		; get current char from a2

		tst.b	d1			; is d1 set?
		bne.s	OW_LimitGiven		; if yes, don't write until $FF, but instead with the input number given

		tst.b	d0			; is current character $FF or $FE?
		bpl.s	OW_NotFF		; if not, branch
		rts				; otherwise, return
; ---------------------------------------------------------------------------

OW_LimitGiven:
		subq.b	#1,d1			; sub 1 from d1
		bne.s	OW_NotFF		; if result isn't 0, contine writing
		rts				; otherwise, return
; ---------------------------------------------------------------------------

OW_NotFF:
		cmpi.b	#' ',d0			; is current character a space?
		bne.s	OW_NotSpace		; if not, branch
		move.b	#Options_Blank,d0	; write a space char to a1
		bra.s	OW_DoWrite		; skip

OW_NotSpace:
		cmpi.b	#'<',d0			; is current character a "<"?
		bne.s	OW_NotLeftArrow		; if not, branch
		move.b	#$0D,d0			; set correct value for "<"
		bra.s	OW_DoWrite		; skip

OW_NotLeftArrow:
		cmpi.b	#'>',d0			; is current character a ">"?
		bne.s	OW_NotRightArrow	; if not, branch
		move.b	#$0E,d0			; set correct value for ">"
		bra.s	OW_DoWrite		; skip

OW_NotRightArrow:
		cmpi.b	#'-',d0			; is current character a "-"?
		bne.s	OW_NotHyphen		; if not, branch
		move.b	#$0B,d0			; set correct value for "-"
		bra.s	OW_DoWrite		; skip

OW_NotHyphen:
		cmpi.b	#'?',d0			; is current character a "?"?
		bne.s	OW_NotQuestion		; if not, branch
		move.b	#$2A,d0			; set correct value for "?"
		bra.s	OW_DoWrite		; skip

OW_NotQuestion:
		subi.b	#50,d0			; otherwise it's a letter and has to be set to the correct value
		cmpi.b	#9,d0			; is result a number?
		bgt.s	OW_DoWrite		; if not, branch
		addq.b	#2,d0			; otherwise add 2 again

OW_DoWrite:
		tst.b	d2			; is highlighting enabled?
		bpl.s	OW_NoHighlight		; if not, branch
		ori.b	#$80,d0			; apply highlight
OW_NoHighlight:
		move.b	d0,(a1)+		; write output to a1
		moveq	#0,d0			; clear d0
		bra.w	Options_Write		; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an option is ON or OFF and set result to a2.
; ---------------------------------------------------------------------------

GOT_ChkOption:
		subq.w	#1,d2
		add.w	d2,d2
		move.w	GOT_Index(pc,d2.w),d2
		jmp	GOT_Index(pc,d2.w)
; ===========================================================================
GOT_Index:	dc.w	GOTCO_CasualFrantic-GOT_Index
		dc.w	GOTCO_ExtendedCamera-GOT_Index
		dc.w	GOTCO_SkipStoryScreens-GOT_Index
		dc.w	GOTCO_SkipUberhub-GOT_Index
		dc.w	GOTCO_CinematicMode-GOT_Index
		dc.w	GOTCO_NonstopInhuman-GOT_Index
		dc.w	GOTCO_SoundTest-GOT_Index
; ===========================================================================

GOTCO_CasualFrantic:
		lea	(OpText_Casual).l,a2		; use "CASUAL" text
		btst	#5,($FFFFFF92).w		; is Gameplay Style set to Frantic?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_Frantic).l,a2		; otherwise use "FRANTIC" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ExtendedCamera:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#0,($FFFFFF92).w		; is Extended Camera enabled?
		beq.w	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SkipStoryScreens:
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		btst	#1,($FFFFFF92).w		; is Skip Story Screens enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SkipUberhub:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#2,($FFFFFF92).w		; is Skip Uberhub enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_CinematicMode:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#3,($FFFFFF92).w		; is Cinematic HUD enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_NonstopInhuman:
		lea	(OpText_OFF).l,a2		; use "OFF" text
		btst	#4,($FFFFFF92).w		; is Nonstop Inhuman enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_SoundTest:
		lea	(OpText_SoundTestDefault).l,a2	; use default sound test text
; ---------------------------------------------------------------------------

GOTCO_Return:
		rts					; return
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Options Text
; ---------------------------------------------------------------------------

OpText_Header1:
		dc.b	'<---------------------->', $FF
		even

OpText_Header2:
		dc.b	'      CHANGE STUFF      ', $FF
		even
; ---------------------------------------------------------------------------

OpText_GameplayStyle:
		dc.b	'GAMEPLAY STYLE   ', $FF
		even
		
OpText_Extended:
		dc.b	'EXTENDED CAMERA      ', $FF
		even

OpText_SkipStory:
		dc.b	'SKIP STORY SCREENS   ', $FF
		even

OpText_SkipUberhub:
		dc.b	'SKIP UBERHUB PLACE   ', $FF
		even
		
OpText_CinematicMode:
		dc.b	'CINEMATIC MODE       ', $FF
		even
		
OpText_EasterEgg_Locked:
		dc.b	'???????????????      ', $FF
		even

OpText_EasterEgg_Unlocked:
		dc.b	'NONSTOP INHUMAN      ', $FF
		even

OpText_DeleteSRAM:
		dc.b	'DELETE SAVE GAME     ', $FF
		even
; ---------------------------------------------------------------------------

OpText_SoundTest:
		dc.b	'SOUND TEST           ', $FF
		even
OpText_SoundTestDefault:
		dc.b	'< 81 >', $FF
		even
; ---------------------------------------------------------------------------

OpText_Exit:	dc.b	'      SAVE OPTIONS      ', $FF
		even
; ---------------------------------------------------------------------------

OpText_ON:	dc.b	' ON', $FF
		even
OpText_OFF:	dc.b	'OFF', $FF
		even
OpText_Casual:	dc.b	' CASUAL', $FF
		even
OpText_Frantic:	dc.b	'FRANTIC', $FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
Options_TextArt:
		incbin	Screens\OptionsScreen\Options_TextArt.bin
		even
Options_BGArt:
		incbin	Screens\OptionsScreen\FuzzyBG.kospm
		even
; ---------------------------------------------------------------------------
; ===========================================================================
