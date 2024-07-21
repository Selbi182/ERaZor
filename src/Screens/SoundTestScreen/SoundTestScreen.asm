; ---------------------------------------------------------------------------
; Sound Test Screen
; ---------------------------------------------------------------------------
SoundTest_Min = $80
SoundTest_Max = $DF
SoundTest_AStep = $10
; ---------------------------------------------------------------------------

SoundTestScreen:
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	PLC_ClearQueue
		jsr	Pal_FadeFrom
		VBlank_SetMusicOnly

		; VDP setup
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

		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F
@loadtextart:	move.w	(a5)+,(a6)
		dbf	d1,@loadtextart ; load uncompressed text patterns
		VBlank_UnsetMusicOnly
		
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@clearobjram:	move.l	d0,(a1)+
		dbf	d1,@clearobjram ; fill object RAM ($D000-$EFFF) with $0

		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1
@clearscroll:	move.l	d0,(a1)+
		dbf	d1,@clearscroll ; fill scroll data with 0
		move.l	d0,($FFFFF616).w

  		move.b	#Options_Blank,d2
		jsr	Options_ClearBuffer

		jsr	BackgroundEffects_Setup

		bsr	Options_LoadPal
		move.b	#9,($FFFFFF9E).w ; BG pal

 		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
		clr.w	($FFFFFFB8).w
		move.w	#21,($FFFFFF9A).w
		move.b	#$81,($FFFFFF84).w

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
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	PLC_Execute

		jsr	BackgroundEffects_Update
		jsr	SoundTest_UpdatePianoRoll

		move.b	($FFFFF605).w,d1	; get button presses
		beq.s	SoundTest_MainLoop	; was anything at all pressed this frame? if not, loop

		btst	#7,d1			; is Start pressed?
		bne.w	SoundTest_Exit		; if yes, exit sound test screen

		move.w	#$80,d0			; default sound (null)
		move.b	($FFFFFF84).w,d2	; move current sound test ID to d2

@soundtest_checkL:
		btst	#2,d1			; has left been pressed?
		beq.s	@soundtest_checkR	; if not, branch
		subq.b	#1,d2			; decrease sound test ID by 1
		cmpi.b	#SoundTest_Min-1,d2	; is ID below the minimum now?
		bne.w	@soundtest_end		; if not, branch
		move.b	#SoundTest_Max,d2	; reset ID to max
		bra.w	@soundtest_end		; branch

@soundtest_checkR:
		btst	#3,d1			; has right been pressed?
		beq.s	@soundtest_checkA	; if not, branch
		addq.b	#1,d2			; increase sound test ID by 1
		cmpi.b	#SoundTest_Max+1,d2	; is ID above the maximum now?
		bne.w	@soundtest_end		; if not, branch
		move.b	#SoundTest_Min,d2	; reset ID to min
		bra.w	@soundtest_end		; branch

@soundtest_checkA:
		btst	#6,d1			; has A been pressed?
		beq.s	@soundtest_chkb		; if not, branch
		addi.b	#SoundTest_AStep,d2	; increase sound test ID by $10
		cmpi.b	#SoundTest_Max+1,d2	; is ID above the maximum now?
		blt.w	@soundtest_end		; if not, branch
		subi.b	#SoundTest_Max-SoundTest_Min+1,d2 ; restart on the other side
		bra.w	@soundtest_end		; branch

@soundtest_chkb:
		btst	#4,d1			; is button B pressed?
		beq.s	@soundtest_chkplay	; if not, branch
		move.b	#$E4,d0			; set to stop all sound
		bra.s	@soundtest_play		; branch

@soundtest_chkplay:
		btst	#5,d1			; is C pressed?
		beq.s	@soundtest_end		; if not, branch
		move.b	d2,d0			; set to play the selected sound
		cmpi.b	#$80,d2			; is current song selection ID $80?
		bne.s	@soundtest_play		; if not, branch
		move.b	#$E4,d0			; set to stop all sound (for convenience)

@soundtest_play:
		jsr	PlaySound_Special	; play selected sound

@soundtest_end:
		move.b	d2,($FFFFFF84).w	; update ID
		bsr	SoundTest_TextLoad

SoundTest_Return:
		bra.w	SoundTest_MainLoop	; return

; ===========================================================================

SoundTest_Exit:
		jmp	Exit_SoundTestScreen

; ===========================================================================

SoundTest_TextLoad:
		lea	($FFFFC900).w,a1		; set destination
		moveq	#0,d1				; use $FF as ending of the list

		lea	(OpText_SoundTest).l,a2		; set text location
		moveq	#0,d2

		jsr	Options_Write			; write text
		move.b	#$0D,-3(a1)			; write < before the ID
		move.b	#$0E,2(a1)			; write > after the ID

		move.b	#$FF,3(a1)			; write end marker

		; write the sound test ID ($FFFFFF84) at offset -1(a1)
		moveq	#0,d0
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

		; send to VDP
		VBlank_SetMusicOnly
		lea	($C00000).l,a6
		move.l	#$66100003,4(a6)	; screen position (text)
		lea	($FFFFC900).w,a1	; get preloaded text buffer	
		bsr	STS_WriteLine
		VBlank_UnsetMusicOnly		
		rts	

; ===========================================================================

STS_WriteLine:
		moveq	#0,d0
		move.b	(a1)+,d0		; load next char
		bmi.s	@end			; if end, exit

		addi.w	#Options_VRAM,d0	; apply VRAM settings to tile mapping
		move.w	d0,(a6)			; write mapping to VDP
		bra.s	STS_WriteLine		; loop
@end:
		rts
; End of function STS_WriteLine


; ===========================================================================
; ---------------------------------------------------------------------------

;│Screen position format: #$6YXX 0003
;│Base screen position:   #$6110 0003
;└───ｖ──────────────────────────────────────────────────────────────────────
;.　∧,,∧
; （＾o＾）
;.（　　）

SoundTest_UpdatePianoRoll:
		VBlank_SetMusicOnly
		
		lea	($C00000).l, a6
		move.l	#$63000003, 4(a6)	; screen position
		lea	(OpText_Blank).l, a1	; graphics
		bsr	STS_WriteLine		; clear line

		lea 	FM_Notes, a5		; load base note location

		moveq 	#9, d6

@LoopChannels:
		move.w	#Options_VRAM_Red, d3	; VRAM setting
		
		moveq 	#0, d0
		move.b 	(a5)+, d0		; load note
		andi.b	#$FE, d0		; AND %11111110

		swap 	d0			; swap note value into x position
		add.l 	#$63000003, d0		; add base

		move.l	d0, 4(a6)		; tile -> vram
		move.w	d3, (a6)		; settings -> vram

		dbf 	d6, @LoopChannels

		VBlank_UnsetMusicOnly
		rts

; ---------------------------------------------------------------------------

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

; ===========================================================================