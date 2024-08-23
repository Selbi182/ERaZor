; ---------------------------------------------------------------------------
; Sound Test Screen
;
; THIS FILE IS PROPERTY OF FUZZY
; (you can touch it though)
; ---------------------------------------------------------------------------

SoundTest_Min = $80
SoundTest_Max = $DF
SoundTest_AStep = $10

SoundTest_TileOptions = $A000
SoundTest_Tile = $81|SoundTest_TileOptions

; LRLR ???? XXXX XXXX
NotePositionBuffer = $FFFFCF80

; ---------------------------------------------------------------------------

SoundTestScreen:
		move.b	#$E4, d0
		jsr	PlaySound_Special ; stop music
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		VBlank_SetMusicOnly

		; VDP setup
		lea	($C00004).l, a6
		move.w	#$8004, (a6)
		move.w	#$8230, (a6)
		move.w	#$8407, (a6)
		move.w	#$9001, (a6)
		move.w	#$9200, (a6)
		move.w	#$8B07, (a6)
		move.w	#$8720, (a6)
		clr.b	($FFFFF64E).w

		jsr	ClearScreen

		lea	($C00000).l, a6
		vram	$80*$20
		lea	(ArtKospM_Keyboard).l, a0
		jsr	KosPlusMDec_VRAM

		move.l	#$6E000002, 4(a6)
		lea	(Options_TextArt).l, a5
		move.w	#$59F, d1		; Original: $28F

@LoadTextArt:
		move.w	(a5)+, (a6)
		dbf	d1, @LoadTextArt ; load uncompressed text patterns
		VBlank_UnsetMusicOnly
		
		lea	($FFFFD000).w, a1
		moveq	#0, d0
		move.w	#$7FF, d1

@ClearObjects:
		move.l	d0, (a1)+
		dbf	d1, @ClearObjects ; fill object RAM ($D000-$EFFF) with $0

		lea	($FFFFCC00).w, a1
		moveq	#0, d0
		move.w	#$DF, d1

@ClearScroll:
		move.l	d0, (a1)+
		dbf	d1, @ClearScroll ; fill scroll data with 0
		move.l	d0, ($FFFFF616).w

  		move.b	#Options_Blank, d2
		jsr	Options_ClearBuffer

		jsr	BackgroundEffects_Setup

		bsr	Options_LoadPal
		move.b	#9, ($FFFFFF9E).w ; BG pal
		move.w	#$A0A, (BGThemeColor).w
 		
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
		clr.w	($FFFFFFB8).w
		move.w	#21, ($FFFFFF9A).w
		move.b	#$81, ($FFFFFF84).w

SoundTest_FinishSetup:
		jsr	ObjectsLoad
		jsr	BuildSprites		
		bsr	SoundTest_TextLoad

		display_enable
		jsr	Pal_FadeTo


; ---------------------------------------------------------------------------
; Sound Test Screen - Main Loop
; ---------------------------------------------------------------------------
SoundTest_MainLoop:
		move.b	#2, VBlankRoutine
		
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	PLC_Execute

		jsr	BackgroundEffects_Update
		jsr	SoundTest_UpdatePianoRoll

		moveq	#0, d1
		move.b	($FFFFF605).w, d1	; get button presses
		beq.s	SoundTest_MainLoop	; was anything at all pressed this frame? if not, loop

		btst	#7, d1			; is Start pressed?
		bne.w	SoundTest_Exit		; if yes, exit sound test screen

		move.w	#$80, d0		; default sound (null)
		move.b	($FFFFFF84).w, d2	; move current sound test ID to d2

@CheckLeft:
		btst	#2, d1			; has left been pressed?
		beq.s	@CheckRight		; if not, branch
		
		subq.b	#1, d2			; decrease sound test ID by 1
		cmpi.b	#SoundTest_Min-1, d2	; is ID below the minimum now?
		bne.w	@UpdateText		; if not, branch
		
		move.b	#SoundTest_Max, d2	; reset ID to max
		bra.w	@UpdateText		; branch

@CheckRight:
		btst	#3, d1			; has right been pressed?
		beq.s	@CheckC			; if not, branch
		
		addq.b	#1, d2			; increase sound test ID by 1
		cmpi.b	#SoundTest_Max+1, d2	; is ID above the maximum now?
		bne.w	@UpdateText		; if not, branch

		move.b	#SoundTest_Min, d2	; reset ID to min
		bra.w	@UpdateText		; branch

@CheckC:
		btst	#5, d1			; is C pressed?
		beq.s	@CheckAB		; if not, branch

		move.b	d2, d0			; set to play the selected sound
		cmpi.b	#$80, d2		; is current song selection ID $80?
		bne.s	@PlaySound		; if not, branch

		move.b	#$E4, d0		; set to stop all sound (for convenience)

@PlaySound:
		jsr	PlaySound_Special	; play selected sound

@CheckAB:
		and.w 	#%01010000, d1		; filter 1 to A and B bits
		beq.s	@UpdateText		; if not, branch
		
		addi.b	#SoundTest_AStep, d2	; increase sound test ID by $10
		cmpi.b	#SoundTest_Max+1, d2	; is ID above the maximum now?
		blt.w	@UpdateText		; if not, branch

		subi.b	#SoundTest_Max-SoundTest_Min+1, d2 ; restart on the other side

@UpdateText:
		move.b	d2, ($FFFFFF84).w	; update ID
		bsr	SoundTest_TextLoad

SoundTest_Return:
		bra.w	SoundTest_MainLoop	; return

; ===========================================================================

SoundTest_Exit:
		jmp	Exit_SoundTestScreen

; ===========================================================================

SoundTest_TextLoad:
		lea	($FFFFC900).w, a1		; set destination
		moveq	#0, d1				; use $FF as ending of the list

		lea	(OpText_SoundTest).l, a2	; set text location
		moveq	#0, d2

		jsr	Options_Write			; write text
		move.b	#$0D, -3(a1)			; write < before the ID
		move.b	#$0E, 2(a1)			; write > after the ID

		move.b	#$FF, 3(a1)			; write end marker

		; write the sound test ID ($FFFFFF84) at offset -1(a1)
		moveq	#0, d0
		move.b	($FFFFFF84).w, d0		; get sound test ID
		lsr.b	#4, d0				; swap first and second short
		andi.b	#$0F, d0			; clear first short
		cmpi.b	#9, d0				; is result greater than 9?
		ble.s	@SkipSpecialCharacters1		; if not, branch
		addi.b	#5, d0				; skip the special chars (!, ?, etc.)

@SkipSpecialCharacters1:
		move.b	d0, -1(a1)			; set result to first digit ("8" 1)

		move.b	($FFFFFF84).w, d0		; get sound test ID
		andi.b	#$0F, d0			; clear first short
		cmpi.b	#9, d0				; is result greater than 9?
		ble.s	@SkipSpecialCharacters2		; if not, branch
		addi.b	#5, d0				; skip the special chars (!, ?, etc.)

@SkipSpecialCharacters2:
		move.b	d0, 0(a1)			; set result to second digit (8 "1")

		VBlank_SetMusicOnly
		
		; send to VDP
		lea	($C00000).l, a6
		move.l	#$66100003, 4(a6)	; screen position (text)
		lea	($FFFFC900).w, a1	; get preloaded text buffer	
		bsr	SoundTest_WriteLine

		VBlank_UnsetMusicOnly		
		rts	

; ===========================================================================

SoundTest_WriteLine:
		moveq	#0, d0
		move.b	(a1)+, d0		; load next char
		bmi.s	@End			; if end, exit

		addi.w	#Options_VRAM, d0	; apply VRAM settings to tile mapping
		move.w	d0, (a6)		; write mapping to VDP
		bra.s	SoundTest_WriteLine	; loop

@End:
		rts

; ===========================================================================

;│Screen position format: #$6YXX 0003
;│Base screen position:   #$6120 0003
;│Xは2で割り切れる, モゲ!
;└───ｖ──────────────────────────────────────────────────────────────────────
;.　∧,,∧
; （＾o＾）
;.（　　）

SoundTest_UpdatePianoRoll:
		VBlank_SetMusicOnly
		
		lea 	NotePositionBuffer, a2	; note pos buffer -> a2

		lea	($C00000).l, a6
		move.l	#$61120003, 4(a6)	; screen position
		lea	(OpText_Blank).l, a1	; graphics

		move.w 	#$28/2, d4

@ClearLine:
		move.w	#SoundTest_Tile, (a6)	; write mapping to VDP
		dbf 	d4, @ClearLine

		lea 	FM_Notes, a5		; load base note location
		moveq 	#9, d6			; number of channels -> d6

@LoopChannels:
		move.w	#SoundTest_Tile+1, d3	; VRAM setting

		moveq 	#0, d0			; clear d0
		moveq	#0, d1			; ..d1

		move.b 	(a5)+, d0		; load note
		move.w 	d0, d1			; make copy of note into d1 for X position
		divs.w 	#2, d1			; divide it by 2
		bset 	#14, d1			; set right bit

		; test bit 0 on note to determine left or right (odd or even) and then divide it by 2
		; get the tile id on that coordinate and modify accordingly
		; red = psg
		; blue = fm

		btst	#0, d0			; is the note even?
		beq.s 	@EvenNote		; if so, branch

		bset 	#15, d1			; note is odd, set left bit
		bclr 	#14, d1			; ...and clear right bit
		; illegal

@EvenNote:
		andi.b	#$FE, d0		; make d0 even
		swap 	d0			; swap note value into x position
		add.l 	#$61120003, d0		; add base

		move.w 	d1, (a2)+

		move.l	d0, 4(a6)		; tile -> vram
		move.w	d3, (a6)		; settings -> vram

		dbf 	d6, @LoopChannels

		VBlank_UnsetMusicOnly
		rts

; ===========================================================================

OpText_SoundTest:
		dc.b	'SOUND TEST           ', $FF
		even

OpText_Blank:
		rept	320/8
		dc.b	0
		endr
		dc.b	$FF
		even

; ---------------------------------------------------------------------------

ArtKospM_Keyboard:
		incbin	"Screens/SoundTestScreen/KeyboardTiles.kospm"
		even

