; ===========================================================================
; ---------------------------------------------------------------------------
; Credits Routine
; ---------------------------------------------------------------------------

NumberOfCreditsPages = 12

CreditsJest:
		jsr	Pal_FadeFrom				; fade palette out
		moveq	#$00,d0					; clear d0
		move.l	d0,($FFFFF616).w			; reset Y scroll positions
		move.l	d0,($FFFFFFAC).w			; reset rumble positions
		move.l	d0,($FFFFFFA0).w			; reset scroll positions
		move	#$2700,sr				; set IRQ's (disable interrupts)
		jsr	ClearScreen				; clear the screen

		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		
		move.w	#120,d0
	@delay:
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		dbf	d0,@delay

		move.l	#$40000000,($C00004).l			; set VDP to V-Ram write mode with address
		lea	(Art_Credits).l,a0			; load address of compressed art
		jsr	NemDec					; decompress and dump

		lea	($00FF0000).l,a1			; set destination
		lea	(Map_Credits).l,a0			; set mappings location
		move.w	#(295*NumberOfCreditsPages)+11,d1	; set number of loops

CJ_MapsLoop:
		move.b	(a0)+,(a1)+				; load data
		dbf	d1,CJ_MapsLoop				; loop

		lea	($FFFFFB80).w,a1			; load address of storage buffer
		lea	(Pal_Credits).l,a0			; load address of palette data
		moveq	#$07,d1					; set repeat times

CJ_RepPal:
		move.l	(a0)+,(a1)+				; dump palette
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		dbf	d1,CJ_RepPal				; repeat til palette is dumped

		clr.b	($FFFFFF91).w

	;	move.b	#$97,d0					; prepare Credits music ID
	;	jsr	PlaySound				; play music ID
		jsr	Pal_FadeTo				; fade palette in

; ---------------------------------------------------------------------------
; Credits Main Loop
; ---------------------------------------------------------------------------

CreditsJest_Loop:
		move.b	#$04,($FFFFF62A).w			; set V-Blank routine to run
		jsr	DelayProgram				; hult main program to run V-Blank
		bsr	CJ_ScrollMappings			; run scrolling/deformation
		bsr	CJ_MapLetters				; run mapping
		bra	CreditsJest_Loop			; loop screen

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Scrolling
; ---------------------------------------------------------------------------

CJ_ScrollMappings:
		lea	($FFFFCC00).w,a1			; load scroll buffer address
		moveq	#$00,d0					; clear d0
		move.w	($FFFFFFA0).w,d0			; load X scroll position
		neg.w	d0					; negate direction
		swap	d0					; send left
		move.w	#$003F,d1				; set repeat times

CJSM_Repeat:
		move.l	d0,(a1)+				; dump to scroll buffer
		dbf	d1,CJSM_Repeat				; repeat til all scanlines are written to
		swap	d0					; send right
		neg.w	d0					; negate direction
		swap	d0					; send left
		move.w	#$009F,d1				; set repeat times

CJSM_Repeat2:
		move.l	d0,(a1)+				; dump to scroll buffer
		dbf	d1,CJSM_Repeat2				; repeat til all scanlines are written to

		lea	(CJSM_FO_Array).l,a2	; load base address for the check array
@FOL_FixOddLoop:
		moveq	#0,d1			; clear d1
		moveq	#0,d2			; clear d2
		moveq	#0,d3			; clear d3

		move.b	(a2),d1			; get current page ID
		cmp.b	($FFFFFF91).w,d1	; does it match with the current page ID?
		bne.s	@FOL_ReLoop		; if not branch
		move.b	1(a2),d2		; get current Row ID
		lsl.w	#6,d2			; multiply it by $40
		lea	($FFFFCC00).w,a1	; load scroll buffer address
		add.w	d2,a1			; add it to the SBA
		move.w	#$000F,d3		; repeat 16 times
@FOL_Loop:	addi.l	#$00080000,(a1)+	; move a tad to the right
		dbf	d3,@FOL_Loop		; loop
@FOL_ReLoop:
		addq.w	#2,a2			; go to next check
		tst.b	(a2)			; end of list reached?
		bpl.s	@FOL_FixOddLoop		; if not, repeat
		rts				; otherwise, return

; ===========================================================================
; ---------------------------------------------------------------------------
CJSM_FO_Array:
; Used to properly horizontally center lines that have an odd number of characters
; These rows will be shifted one tile to the right
; Usage: Page (1-based), Row (0-based)
		dc.b	 1, 8
		
		dc.b	 2, 1
		dc.b	 2, 3
		
		dc.b	 4, 1
		dc.b	 4, 9
		
		dc.b	 5, 8
		
		dc.b	 6, 1
		dc.b	 6, 7
		
		dc.b	 7, 3
		dc.b	 7, 9
		
		dc.b	 8, 1
		dc.b	 8, 9
		
		dc.b	 9, 9
	
		dc.b	10, 9
		dc.b	10,13
		
		dc.b	11, 1
		
		dc.b	12, 1
		dc.b	12, 3
		dc.b	12, 6
		dc.b	12, 8
		
		dc.b	$FF, $FF
		even
; ---------------------------------------------------------------------------
; ===========================================================================


; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Mapping

MoveOffSpeed = $0020
OffScreenPos = $0040
; ---------------------------------------------------------------------------

CJ_MapLetters:
		sub.w	#MoveOffSpeed,($FFFFFFA0).w		; decrease X scroll position left
		move.w	($FFFFFFA0).w,d0			; load scroll position
		andi.w	#$01FF,d0				; keep within the X line
		cmp.w	#OffScreenPos*4,d0			; has it reached out of screen?
		ble	CJML_WriteMappings			; if so, load the next page
		rts						; return


CJML_WriteMappings:
		lea	($00FF0004).l,a0			; load address of mappings
		move.l	(a0),d0					; load that address
		cmp.l	($00FF0008).l,d0			; is it the end address?
		beq	CJML_End				; if so, branch

		addq.b	#1,($FFFFFF91).w

		lea	($C00000).l,a1				; load VDP data port address to a1
		move.l	#$40000003,d3				; prepare V-Ram address
		move.l	d3,d6					; load V-Ram address
		move.l	#$00800000,d5				; prepare value for increase lines
		move.l	#$007C0000,d4				; prepare value for decrease lines
		movea.l	d0,a0					; set as new address
		moveq	#$00,d7					; clear d7
		move.b	(a0)+,d7				; load repeat times
CJML_NextCharacter:
		moveq	#$00,d0					; clear d0
		move.b	(a0)+,d0				; load character
		bpl	CJML_CheckCharacter			; if it's not negative, branch
		add.l	d5,d3					; increase to next line
		add.l	d5,d3					; ''
		move.l	d3,d6					; load V-Ram address
		dbf	d7,CJML_NextCharacter			; repeat til all lines are done
		move.l	a0,($00FF0004).l			; update address of mappings
		bra	CJML_ScrollIn				; continue

CJML_CheckCharacter:
		cmp.b	#$20,d0					; is it the space character?
		bne	CJML_RunLetter				; if not, branch
		moveq	#$40,d0					; set to use null

CJML_RunLetter:
		sub.b	#$40,d0					; minus 40
		add.w	d0,d0					; multiply by...
		add.w	d0,d0					; ...4
		addq.w	#$01,d0					; plus 1
		move.l	d6,$04(a1)				; set VDP
		
		cmpi.b	#8,d7			; use the second palette set for lower part (where the names are)
		bge.s	@nosecondpalset
		addi.w	#$4000,d0		; start on palette row 3
@nosecondpalset:
		move.w	d0,(a1)					; save
		addq.w	#$02,d0					; increase by 2
		move.w	d0,(a1)					; save
		subq.w	#$01,d0					; decrease by 1
		add.l	d5,d6					; increase to next line
		move.l	d6,$04(a1)				; set VDP
		
		addi.w	#$2000,d0		; use next palette row
		move.w	d0,(a1)					; save
		addq.w	#$02,d0					; increase by 2
		move.w	d0,(a1)					; save
		sub.l	d4,d6					; decrease to previous line
		bra	CJML_NextCharacter			; repeat
; ---------------------------------------------------------------------------

CJML_ScrollIn:
		cmpi.b	#NumberOfCreditsPages,($FFFFFF91).w	; is this the final screen? (return to sega screen)
		bne.s	CJML_NormalScreen			; if not, branch

CJML_FinalLoop:
		addq.b	#1,($FFFFFE04).w			; increase frame counter

		move.w	($FFFFFFA0).w,d0			; load scroll position
		andi.w	#$01FF,d0				; keep within the X line
		tst.w	d0				; is it at the center of the screen?
		bne	CJML_FinalScreenScroll			; if not, branch (keep scrolling)
		bra	CJML_FinalLoop2				; if so, branch

CJML_FinalScreenScroll:
		move.b	#$04,($FFFFF62A).w			; set V-Blank routine to run
		jsr	DelayProgram				; hult main program to run V-Blank
		subi.w	#$10,($FFFFFFA0).w			; decrease X scroll position left
		bsr	CJ_ScrollMappings			; run scrolling/deformation
		bra	CJML_FinalLoop				; loop

CJML_FinalLoop2:
		move.b	#$04,($FFFFF62A).w
		jsr	DelayProgram
		tst.b	($FFFFF605).w				; test button input
		bmi.s	CJML_End				; is start pressed? if yes, branch
		bra	CJML_FinalLoop2

CJML_NormalScreen:
		subi.w	#MoveOffSpeed,($FFFFFFA0).w		; decrease X scroll position left
		move.b	#$60,($FFFFFF90).w			; set slow display time to $60 frames
		move.w	($FFFFFFA0).w,d0			; load scroll position
		andi.w	#$01FF,d0				; keep within the X line
		cmp.w	#OffScreenPos,d0			; has it reached in screen?
		bmi	CJML_ScrollSlow				; if so, branch
		move.b	#$04,($FFFFF62A).w			; set V-Blank routine to run
		jsr	DelayProgram				; hult main program to run V-Blank
		bsr	CJ_ScrollMappings			; run scrolling/deformation
		bra	CJML_ScrollIn				; loop

CJML_ScrollSlow:
		addq.b	#1,($FFFFFE04).w			; increase frame counter
		btst	#1,($FFFFFE04).w
		beq.s	xcont
		btst	#0,($FFFFFE04).w
		bne.s	xcont
		subq.w	#$0001,($FFFFFFA0).w			; decrease X scroll position left
		subq.b	#$0001,($FFFFFF90).w			; is slow display time over?
		beq	CJML_FinishUp				; if so, branch

xcont:
		move.b	#$04,($FFFFF62A).w			; set V-Blank routine to run
		jsr	DelayProgram				; hult main program to run V-Blank
		bsr	CJ_ScrollMappings			; run scrolling/deformation
		bra	CJML_ScrollSlow				; loop

CJML_FinishUp:
		clr.b	($FFFFFE04).w
		move.w	($00FF0000).l,($00FF0002).l		; reset timer
		rts						; return

; ---------------------------------------------------------------------------

CJML_End:
		move.b	#$00,($FFFFF600).w
		jmp	MainGameLoop

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Data
; ---------------------------------------------------------------------------

Pal_Credits:
		dc.w	$0000,$0000,$0444,$0EEE,$0AAA,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		
		dc.w	$0000,$0000,$0400,$0EAA,$0A66,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		
		dc.w	$0000,$0000,$0444,$0EEE,$0AAA,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		
		dc.w	$0000,$0000,$0444,$0EEE,$0AAA,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Art Data
; ---------------------------------------------------------------------------

Art_Credits:	incbin	"Screens/CreditsScreen/Art.bin"
		even

; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------
; Map Data
; ---------------------------------------------------------------------------

Map_Credits:	include	"Screens/CreditsScreen/Maps.asm"
		even

; ---------------------------------------------------------------------------
; ===========================================================================