; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------

OptionsScreen:				; XREF: GameModeArray
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	ClearPLC
		jsr	Pal_FadeFrom
		move	#$2700,sr
		jsr	SoundDriverLoad
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

Options_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,Options_ClrObjRam ; fill object RAM ($D000-$EFFF) with $0

		lea	($C00000).l,a6
		move.l	#$6E000002,4(a6)
		lea	(Options_TextArt).l,a5
		move.w	#$59F,d1		; Original: $28F

Options_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Options_LoadText ; load uncompressed text patterns

		move.l	#$64000002,($C00004).l
		lea	(Nem_ERaZor).l,a0
		jsr	NemDec

		jsr	Pal_FadeFrom

; ---------------------------------------------------------------------------
		move.b	#$02,($FFFFD100).w	; load ERaZor banner object
		move.w	#$BD,($FFFFD108).w	; set X-position
		move.w	#$81,($FFFFD10A).w	; set Y-position

		move.b	#$02,($FFFFD140).w	; load ERaZor banner object
		move.w	#$182,($FFFFD148).w	; set X-position
		move.w	#$81,($FFFFD14A).w	; set Y-position

		move.b	#$02,($FFFFD180).w	; load ERaZor banner object
		move.w	#$BD,($FFFFD188).w	; set X-position
		move.w	#$142,($FFFFD18A).w	; set Y-position

		move.b	#$02,($FFFFD1C0).w	; load ERaZor banner object
		move.w	#$182,($FFFFD1C8).w	; set X-position
		move.w	#$142,($FFFFD1CA).w	; set Y-position

		jsr	ObjectsLoad
		jsr	BuildSprites
; ---------------------------------------------------------------------------

		moveq	#2,d0		; load Options screen pallet
		jsr	PalLoad1
		move.b	#$86,d0		; play Options screen music
		jsr	PlaySound_Special

		movem.l	d0-a2,-(sp)		; backup d0 to a2
		lea	(Pal_Sonic).l,a1	; set Sonic'S palette pointer
		lea	($FFFFFBA0).l,a2	; set palette location
		moveq	#7,d0			; set number of loops to 7

Options_SonPalLoop:
		move.l	(a1)+,(a2)+		; load 2 colours (4 bytes)
		dbf	d0,Options_SonPalLoop	; loop
		movem.l	(sp)+,d0-a2		; restore d0 to a2
		
		moveq	#0,d0
		lea	($FFFFCA00).w,a1	; set location for the text
		move.b	#$F0,d0			; put over $F0s
		move.w	#503,d1			; do it for all 504 chars

Options_MakeF0s:
		move.b	d0,(a1)+		; put $FF into current spot
		dbf	d1,Options_MakeF0s	; loop
		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.b	($FFFFFF98).w
	;	clr.w	($FFFFFF9A).w
		move.w	#21,($FFFFFF9A).w
		clr.w	($FFFFFF9C).w
		
		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

Options_ClrScroll:
		move.l	d0,(a1)+
		dbf	d1,Options_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	($C00000).l,a6
		move.l	#$60000003,($C00004).l
		move.w	#$3FF,d1

Options_ClrVram:
		move.l	d0,(a6)
		dbf	d1,Options_ClrVram ; fill	VRAM with 0
		move.w	#19,($FFFFFF82).w	; set position to 4

		jsr	Pal_FadeTo
		bra.s	OptionsScreen_MainLoop

; ===========================================================================

Options_PalCycle:

PalLocationO = $FFFFFB20

		move.w	($FFFFF614).w,d0			; load remaining time into d0
		andi.w	#3,d0					; mask it against 3
		bne.s	O_PalSkip_1				; if result isn't 0, branch
		move.w	(PalLocationO+$04).w,d0			; load first blue colour of sonic's palette into d0
		moveq	#7,d1					; set loop counter to 7
		lea	(PalLocationO+$06).w,a1			; load second blue colour into a1

O_PalLoop:
		move.w	(a1),-2(a1)				; move colour to last spot
		adda.l	#2,a1					; increase location pointer
		dbf	d1,O_PalLoop				; loop
		move.w	d0,(PalLocationO+$12).w			; move first colour to last one

O_PalSkip_1:
		move.w	($FFFFF614).w,d0			; load remaining time into d0
		andi.w	#7,d0					; mask it against 7
		bne.s	O_PalSkip_2				; if result isn't 0, branch
		move.w	(PalLocationO+$18).w,d0			; backup first colour of the red
		move.w	(PalLocationO+$1A).w,(PalLocationO+$18).w	; move second colour to first one
		move.w	(PalLocationO+$1C).w,(PalLocationO+$1A).w	; move third colour to second one
		move.w	d0,(PalLocationO+$1C).w			; load first colour into third one

O_PalSkip_2:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Options Screen - Main Loop
; ---------------------------------------------------------------------------

; LevelSelect:
OptionsScreen_MainLoop:
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram

		tst.w	($FFFFF614).w		; is timer empty?
		bne.s	O_DontResetTimer	; if not, branch
		move.w	#$618,($FFFFF614).w	; otherwise, reset it

O_DontResetTimer:
		jsr	OptionsControls
		jsr	RunPLC_RAM
		
		bsr.s	Options_PalCycle

		tst.l	($FFFFF680).w
		bne.s	OptionsScreen_MainLoop

		tst.b	($FFFFFF9C).w		; is building-up-sequence done?
		bne.s	Options_NoTextChange	; if yes, branch

		tst.b	($FFFFF605).w
		beq.s	Options_NoStart
		move.b	#1,($FFFFFF9C).w
		jsr	OptionsTextLoad		; update text
		bra.s	OptionsScreen_MainLoop	; if not, branch

Options_NoStart:
		move.w	($FFFFF614).w,d0	; get timer
		cmpi.b	#6,($FFFFFF98).w	; check if ON/OFF are being written now
		blt.s	Options_NoSlowDown	; if not, branch
		cmpi.b	#$E,($FFFFFF98).w	; check if ON/OFF are being written now
		bgt.s	Options_NoSlowDown	; if not, branch
		andi.w	#7,d0			; and by 6
		bne.s	Options_NoTextChange	; if result ain't 0, don't write text
		bra.s	Options_StartUpWrite

Options_NoSlowDown:
		andi.w	#0,d0			; and by 0
		bne.s	Options_NoTextChange	; if result ain't 0, don't write text

Options_StartUpWrite:
		jsr	OptionsTextLoad		; update text
		tst.b	($FFFFFF9C).w	; is routine counter at $12 (Options_NoMore)?
		bne.s	Options_NoTextChange	; if yes, branch
		bra.s	OptionsScreen_MainLoop
; ---------------------------------------------------------------------------

Options_NoTextChange:
		move.b	($FFFFF605).w,d1	; get button presses
		cmpi.w	#19,($FFFFFF82).w	; is selected line EXIT?
		beq.s	Options_NoLR		; if yes, don't check for Left/Right buttons
		andi.b	#$C,d1			; is left/right	pressed?
		bne.s	Options_OK		; if yes, branch

Options_NoLR:
		andi.b	#$F0,d1			; is A, B, C or Start pressed?
		beq.w	OptionsScreen_MainLoop	; if not, branch

Options_OK:
		move.w	#$D9,d0
		jsr	PlaySound_Special
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
; ===========================================================================

Options_Check4:
		cmpi.w	#4,d0		; have you selected item 4 (AIR MOVE ON B)?
		bne.s	Options_Not4	; if not, check for next numbers
		bchg	#0,($FFFFFFBC).w	; enable/disable air move
		jsr	OptionsTextLoad
		bra.w	OptionsScreen_MainLoop
; ===========================================================================

Options_Not4:
		cmpi.w	#7,d0		; have you selected item 7 (EXTENDED CAMERA)?
		bne.s	Options_Not7	; if not, check for next numbers
		bchg	#0,($FFFFFF93).w	; enable/disable extended camera
		jsr	OptionsTextLoad
		bra.w	OptionsScreen_MainLoop
; ===========================================================================

Options_Not7:
		cmpi.w	#10,d0		; have you selected item 10 (SONIC ART)?
		bne.s	Options_Not10	; if not, check for next numbers
		bchg	#0,($FFFFFF94).w	; change art style flag
		jsr	OptionsTextLoad
		bra.w	OptionsScreen_MainLoop
; ===========================================================================

Options_Not10:
		cmpi.w	#13,d0		; have you selected item 13 (FOURTH OPTION)?
		bne.s	Options_Not13	; if not, check for next numbers
		bchg	#0,($FFFFFF92).w	; enable/disable fourth option
		jsr	OptionsTextLoad
		bra.w	OptionsScreen_MainLoop
; ===========================================================================

Options_Not13:
		cmpi.w	#16,d0		; have you selected item 16 (SOUND TEST)?
		bne.s	Options_Not16	; if not, check for next numbers
	;	move.b	#$28,($FFFFF600).w	; set game mode to sound test (doesn't exist yet)
		bra.w	OptionsScreen_MainLoop
; ===========================================================================

Options_Not16:
		cmpi.w	#19,d0		; have you selected item 19 (EXIT)?
		bne.s	Options_Error	; if not, something went wrong

		clr.b	($FFFFFF95).w
		clr.w	($FFFFFF96).w
		clr.w	($FFFFFF98).w
		clr.b	($FFFFFF9A).w
		clr.w	($FFFFFF9C).w

		moveq	#0,d0			; clear d0
		move.b	#1,($A130F1).l		; enable SRAM
		lea	($200000).l,a1		; base of SRAM
		move.b	#$FF,$1(a1)		; make sure SRAM will be created
		move.b	($FFFFFFBC).w,$3(a1)	; backup air move flag
		move.b	($FFFFFF92).w,$5(a1)	; backup invin time flag
		move.b	($FFFFFFFB).w,$7(a1)	; backup debug flag
		move.b	($FFFFFF93).w,$9(a1)	; backup extended camera flag
		move.b	($FFFFFF94).w,$B(a1)	; backup art style flag
		move.b	#$FF,$1B(a1)		; make sure SRAM will be created at the correct size
		move.b	#0,($A130F1).l		; disable SRAM

		tst.b	($FFFFFF9E).w
		beq.s	Options_NoSYZ1
		jsr	Pal_FadeOut		; fade out palette
		move.w	#$400,($FFFFFE10).w
		move.b	#$C,($FFFFF600).w	; set screen mode to level ($C)
		rts				; return

Options_NoSYZ1:
		jsr	Pal_FadeOut		; fade out palette
		move.b	#$28,($FFFFF600).w	; set screen mode to chapter screen ($28)
		rts				; return
; ===========================================================================

Options_Error:
		rts			; return
; ===========================================================================

; ---------------------------------------------------------------------------
; Subroutine to	change what you're selecting in the level select
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


OptionsControls:				; XREF: OptionsScreen_MainLoop
		tst.b	($FFFFFF9C).w	; is routine counter at $12 (Options_NoMore)?
		bne.s	Options_AllowControl	; if yes, branch
		rts

Options_AllowControl:
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
		subq.w	#3,d0		; move up 1 selection
		cmpi.w	#4,d0
		bcc.s	Options_Down
		moveq	#$13,d0		; if selection moves below 0, jump to selection	$14

Options_Down:
		btst	#1,d1		; is down pressed?
		beq.s	Options_Refresh	; if not, branch
		addq.w	#3,d0		; move down 1 selection
		cmpi.w	#$14,d0
		bcs.s	Options_Refresh
		moveq	#4,d0		; if selection moves above $14,	jump to	selection 0

Options_Refresh:
		move.w	d0,($FFFFFF82).w ; set new selection
		jsr	OptionsTextLoad	; refresh text
		rts
; ===========================================================================

Options_SndTest:				; XREF: OptionsControls
		move.b	($FFFFF605).w,d1
		andi.b	#$C,d1		; is left/right	pressed?
		beq.s	Options_NoMove	; if not, branch
		jsr	OptionsTextLoad	; refresh text

Options_NoMove:
		rts	
; End of function OptionsControls

; ---------------------------------------------------------------------------
; Subroutine to load level select text
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


OptionsTextLoad:				; XREF: TitleScreen
		jsr	GetOptionsText
		lea	($FFFFCA00).w,a1		
		lea	($C00000).l,a6
		move.l	#$62100003,d4	; screen position (text)
		move.w	#$E570,d3	; VRAM setting
		moveq	#$14,d1		; number of lines of text

loc2_34FE:				; XREF: OptionsTextLoad+26j
		move.l	d4,4(a6)
		jsr	Options_ChgLine
		addi.l	#$800000,d4
		dbf	d1,loc2_34FE
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
		move.w	d0,d1
		move.l	#$62100003,d4
		lsl.w	#7,d0
		swap	d0
		add.l	d0,d4
		lea	($FFFFCA00).w,a1
		lsl.w	#3,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		adda.w	d1,a1
		move.w	#$C570,d3
		move.l	d4,4(a6)

Options_SetCorrectLocation:
		tst.b	($FFFFFF9C).w		; is routine counter at $12 (Options_NoMore)?
		bne.s	Options_Finished	; if yes, branch
		move.w	#$E570,d3

Options_Finished:
		lea	($FFFFCA00).w,a1	; set location
		move.w	($FFFFFF82).w,d5	; get current selection
		mulu.w	#24,d5			; multiply it by 24 (number of characters per line)
		adda.w	d5,a1			; add result to pointer
		
		jsr	Options_ChgLine
		move.w	#$E570,d3
		cmpi.w	#$14,($FFFFFF82).w
		bne.s	loc2_3550
		move.w	#$C570,d3

loc2_3550:
		rts	
; End of function OptionsTextLoad

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Options_ChgLine:				; XREF: OptionsTextLoad
		moveq	#$17,d2		; number of characters per line

loc2_3588:
		moveq	#0,d0
		move.b	(a1)+,d0
		bpl.s	loc2_3598
		move.w	#0,(a6)
		dbf	d2,loc2_3588
		rts	
; ===========================================================================

loc2_3598:				; XREF: Options_ChgLine
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc2_3588
		rts	
; End of function Options_ChgLine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the options text.
; ---------------------------------------------------------------------------

GetOptionsText:
		tst.b	($FFFFFF9C).w			; has start been pressed?
		beq.w	GOT_StartUpWrite		; if not, continue start-up-sequence
; ---------------------------------------------------------------------------

		lea	($FFFFCA00).w,a1		; set destination
		moveq	#0,d1				; use $FF as ending of the list

		lea	(OpText_Header1).l,a2		; set text location
		bsr.w	OW_Loop				; write text
		lea	(OpText_Header2).l,a2		; set text location
		bsr.w	OW_Loop				; write text
		lea	(OpText_Header1).l,a2		; set text location
		bsr.w	OW_Loop				; write text

		adda.w	#(1*24),a1			; make one empty line

		lea	(OpText_AirMove).l,a2		; set text location
		bsr.w	OW_Loop				; write text
		moveq	#1,d2				; set d2 to 1
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	OW_Loop				; write text

		adda.w	#(2*24),a1			; make two empty lines

		lea	(OpText_Extended).l,a2		; set text location
		bsr.w	OW_Loop				; write text
		moveq	#2,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	OW_Loop				; write text

		adda.w	#(2*24),a1			; make two empty lines

		lea	(OpText_SonicArt).l,a2		; set text location
		bsr.w	OW_Loop				; write text
		moveq	#3,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	OW_Loop				; write text

		adda.w	#(2*24),a1			; make two empty lines

		lea	(OpText_FourthOption).l,a2	; set text location
		bsr.w	OW_Loop				; write text
		moveq	#4,d2				; set d2 to 4
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		bsr.w	OW_Loop				; write text

		adda.w	#(2*24),a1			; make two empty lines

		lea	(OpText_SoundTest).l,a2		; set text location
		bsr.w	OW_Loop				; write text

		adda.w	#(2*24),a1			; make two empty lines

		lea	(OpText_Exit).l,a2		; set text location
		bsr.w	OW_Loop				; write text

		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to do the start up writing sequence.
; ---------------------------------------------------------------------------

GOT_StartUpWrite:
		moveq	#0,d0				; clear d0
		move.b	($FFFFFF98).w,d0		; move routine counter to d0
		move.w	GOTSUP_Index(pc,d0.w),d1	; move the index to d1
		jmp	GOTSUP_Index(pc,d1.w)		; find out the current position in the index

; ===========================================================================
GOTSUP_Index:	dc.w	GOTSUP_Header1-GOTSUP_Index	; [$0] "=" Headers
		dc.w	GOTSUP_Header2-GOTSUP_Index	; [$2] "SONIC ERAZOR" Header
		dc.w	GOTSUP_Options-GOTSUP_Index	; [$4] The 4 options itself
		dc.w	GOTSUP_ONOFF1-GOTSUP_Index	; [$6] Write "ON" or "OFF" text for Air Move on B
		dc.w	GOTSUP_ONOFF2-GOTSUP_Index	; [$8] Write "ON" or "OFF" text for Extended Camera
		dc.w	GOTSUP_ONOFF3-GOTSUP_Index	; [$A] Write "S2B" or "S3" text for Sonic Art
		dc.w	GOTSUP_ONOFF4-GOTSUP_Index	; [$C] Write "ON" or "OFF" text for Fourh Option
		dc.w	GOTSUP_ONOFF4-GOTSUP_Index	; [$E] Twice to give a little delay
		dc.w	GOTSUP_SoundExit-GOTSUP_Index	; [$10] "SOUND TEST" and "EXIT OPTIONS"
; ===========================================================================

GOTSUP_Header1:
		lea	($FFFFCA00+(0*24)).w,a1		; set destination
		lea	(OpText_Header1).l,a2		; set text location
		bsr.w	Options_Write			; write text
		lea	($FFFFCA00+(2*24)).w,a1		; set destination
		move.b	($FFFFFF96).w,d1		; write length counter into d1
		lea	(OpText_Header1).l,a2		; set text location
		bsr.w	OW_NoIncrease			; write text

		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return
; ---------------------------------------------------------------------------

GOTSUP_Header2:
		lea	($FFFFCA00+(1*24)).w,a1		; set destination
		lea	(OpText_Header2).l,a2		; set text location
		bsr.w	Options_Write			; write text

		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return
; ---------------------------------------------------------------------------

GOTSUP_Options:
		lea	($FFFFCA00+(4*24)).w,a1		; set destination
		adda.w	($FFFFFF9A).w,a1
		lea	(OpText_AirMove).l,a2		; set text location
		bsr.w	Options_Write			; write text

		lea	($FFFFCA00+(7*24)).w,a1		; set destination
		adda.w	($FFFFFF9A).w,a1
		lea	(OpText_Extended).l,a2		; set text location
		bsr.w	OW_NoIncrease			; write text

		lea	($FFFFCA00+(10*24)).w,a1	; set destination
		adda.w	($FFFFFF9A).w,a1
		lea	(OpText_SonicArt).l,a2		; set text location
		bsr.w	OW_NoIncrease			; write text

		lea	($FFFFCA00+(13*24)).w,a1	; set destination
		adda.w	($FFFFFF9A).w,a1
		lea	(OpText_FourthOption).l,a2	; set text location
		bsr.w	OW_NoIncrease			; write text
		
		subq.w	#1,($FFFFFF9A).w

		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return
; ---------------------------------------------------------------------------

GOTSUP_ONOFF1:
		moveq	#0,d1				; clear d1
		moveq	#1,d2				; set d2 to 1
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		lea	($FFFFCA00+(4*24)+21).w,a1	; set destination
		bsr.w	OW_Loop				; write text
		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return

GOTSUP_ONOFF2:
		moveq	#0,d1				; clear d1
		moveq	#2,d2				; set d2 to 2
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		lea	($FFFFCA00+(7*24)+21).w,a1	; set destination
		bsr.w	OW_Loop				; write text
		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return

GOTSUP_ONOFF3:
		moveq	#0,d1				; clear d1
		moveq	#3,d2				; set d2 to 3
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		lea	($FFFFCA00+(10*24)+21).w,a1	; set destination
		bsr.w	OW_Loop				; write text
		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return

GOTSUP_ONOFF4:
		moveq	#0,d1				; clear d1
		moveq	#4,d2				; set d2 to 4
		bsr.w	GOT_ChkOption			; check if option is ON or OFF
		lea	($FFFFCA00+(13*24)+21).w,a1	; set destination
		bsr.w	OW_Loop				; write text
		bsr.w	GOTSUP_CheckEnd			; check if we reached the end
		rts					; return
; ---------------------------------------------------------------------------

GOTSUP_SoundExit:
		lea	($FFFFCA00+(16*24)).w,a1	; set destination
		lea	(OpText_SoundTest).l,a2		; set text location
		bsr.w	Options_Write			; write text

		lea	($FFFFCA00+(19*24)).w,a1	; set destination
		lea	(OpText_Exit).l,a2		; set text location
		bsr.w	OW_NoIncrease			; write text

		tst.b	-1(a2)				; is current entry $FF?
		bpl.s	GOTSUPE_Return			; if not, branch
		move.b	#1,($FFFFFF9C).w		; set to "building-up-sequence" done
		jsr	OptionsTextLoad			; update text

GOTSUPE_Return:
		rts					; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if the end of the list has been reached ($FF).
; ---------------------------------------------------------------------------

GOTSUP_CheckEnd:
		tst.b	-1(a2)			; is current entry $FF?
		bpl.s	GOTSUPCE_Return		; if not, branch
		clr.b	($FFFFFF96).w		; clear counter
		addq.b	#2,($FFFFFF98).w	; increase pointer

GOTSUPCE_Return:
		rts				; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the text given in the input (a2), into the given
; location (a1). Write until $FF, unless a value has been given (d1).
; ---------------------------------------------------------------------------

Options_Write:
		addq.b	#1,($FFFFFF96).w	; increase length counter

OW_NoIncrease:
		move.b	($FFFFFF96).w,d1	; write length counter into d1

OW_Loop:
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
		cmpi.b	#$20,d0			; is current character a space?
		bne.s	OW_NotSpace		; if not, branch
		cmpi.b	#4,($FFFFFF98).w	; are the options being written now?
		bne.s	OW_SpaceLoop		; if not, branch
		move.b	#$F0,d0			; set correct value for space
		bra.s	OW_DoWrite		; skip

OW_SpaceLoop:
		move.b	#$F0,(a1)+		; write a space char to a1
		cmpi.b	#$20,(a2)+		; is next character a space as well?
		beq.s	OW_SpaceLoop		; if yes, loop until not anymore
		suba.w	#1,a2			; sub 1 from a2
		bra.s	OW_Loop			; loop

OW_NotSpace:
		cmpi.b	#$3D,d0			; is current character a "="?
		bne.s	OW_NotEqual		; if not, branch
		move.b	#$0C,d0			; set correct value for "="
		bra.s	OW_DoWrite		; skip

OW_NotEqual:
		subi.b	#50,d0			; otherwise it's a letter and has to be set to the correct value
		cmpi.b	#9,d0			; is result a number?
		bgt.s	OW_DoWrite		; if not, branch
		addq.b	#2,d0			; otherwise add 2 again

OW_DoWrite:
		move.b	d0,(a1)+		; write output to a1
		moveq	#0,d0			; clear d0

		bra.s	OW_Loop			; loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if an option is ON or OFF and set result to a2.
; ---------------------------------------------------------------------------

GOT_ChkOption:
		cmpi.b	#1,d2				; is d2 set to 1?
		bne.s	GOTCO_ChkExtCam			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		tst.b	($FFFFFFBC).w			; is Air Move on B enabled?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkExtCam:
		cmpi.b	#2,d2				; is d2 set to 2?
		bne.s	GOTCO_ChkSonArt			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		tst.b	($FFFFFF93).w			; is Extended Camera disabled?
		bne.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkSonArt:
		cmpi.b	#3,d2				; is d2 set to 3?
		bne.s	GOTCO_ChkFourthOption		; if not, branch
		lea	(OpText_S2B).l,a2		; use "S2B" text
		tst.b	($FFFFFF94).w			; is art set to S3?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_S3).l,a2		; otherwise use "ON" text
		rts					; return
; ---------------------------------------------------------------------------

GOTCO_ChkFourthOption:
		cmpi.b	#4,d2				; is d2 set to 4?
		bne.s	GOTCO_Return			; if not, branch
		lea	(OpText_OFF).l,a2		; use "OFF" text
		tst.b	($FFFFFF92).w			; is flag set?
		beq.s	GOTCO_Return			; if not, branch
		lea	(OpText_ON).l,a2		; otherwise use "ON" text

GOTCO_Return:
		rts					; return
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Options Text
; ---------------------------------------------------------------------------

OpText_Header1:
		dc.b	"========================", $FF
		even

OpText_Header2:
		dc.b	"      SONIC ERAZOR      ", $FF
		even
; ---------------------------------------------------------------------------

OpText_AirMove:
		dc.b	"AIR MOVE ON B        ", $FF
		even

OpText_Extended:
		dc.b	"EXTENDED CAMERA      ", $FF
		even

OpText_SonicArt:
		dc.b	"SONIC ART            ", $FF
		even

OpText_FourthOption:
		dc.b	"XXXXXXXXXXXXXXXXXXX  ", $FF
		even
; ---------------------------------------------------------------------------

OpText_SoundTest:
		dc.b	"       SOUND TEST       ", $FF
		even
; ---------------------------------------------------------------------------

OpText_Exit:	dc.b	"      EXIT OPTIONS      ", $FF
		even
; ---------------------------------------------------------------------------

OpText_ON:	dc.b	" ON", $FF
OpText_OFF:	dc.b	"OFF", $FF
OpText_S2B:	dc.b	"S2B", $FF
OpText_S3:	dc.b	" S3", $FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
Options_TextArt:
		incbin	Screens\OptionsScreen\Options_TextArt.bin
		even
; ---------------------------------------------------------------------------
; ===========================================================================