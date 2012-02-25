; =====================================================================================================================
; Selbi Splash Screen - Code made by Marc - Sonic ERaZor
; =====================================================================================================================
SelbiSplash_MusicID		EQU	$B7		; Music to play
SelbiSplash_NxtScr		EQU	$04		; Screen mode to go to next (Title Screen)
SelbiSplash_Wait		EQU	$30		; Time to wait ($100)
SelbiSplash_PalChgSpeed		EQU	$200		; Speed for the palette to be changed ($200)

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash:
		move.b	#$E4,d0
		jsr	PlaySound_Special		; Stop music
		jsr	ClearPLC			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette
		move	#$2700,sr

SelbiSplash_VDP:
		lea	($C00004).l,a6			; Setup VDP
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen			; Clear screen
		
SelbiSplash_Art:
		move.l	#$40000000,($C00004).l		; Load art
		lea	(Art_SelbiSplash).l,a0
		jsr	NemDec
		
SelbiSplash_Mappings:
		lea	($FF0000).l,a1			; Load screen mappings
		lea	(Map3_SelbiSplash).l,a0
		move.w	#0,d0
		jsr	EniDec
		
SelbiSplash_ShowOnVDP:
		lea	($FF0000).l,a1			; Show screen
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics		
		
SelbiSplash_Palette:
		lea	(Pal_SelbiSplash).l,a1		; Load palette
		lea	($FFFFFB80).w,a2
		move.b	#$40,d0
SelbiSplash_PalLoop:
		move.l	(a1)+,(a2)+
		tst.w	d0
		beq.s	SelbiSplash_Music
		sub.w	#1,d0
		bra.s	SelbiSplash_PalLoop
		
SelbiSplash_Music:
	;	move.w	#SelbiSplash_MusicID,d0		; Play music
	;	jsr	PlaySound
		
SelbiSplash_SetWait:
		move.w	#SelbiSplash_Wait,($FFFFF614).w	; Wait time
		jsr	Pal_FadeTo			; Fade palette in
	;	move.b	#SelbiSplash_MusicID,d0		; Play music
	;	jsr	PlaySound
		
		move.l	#$4E400001,($FFFFFF7A).w
		move.w	#0,($FFFFFF7E).w
		bra.s	SelbiSplash_Loop
; ---------------------------------------------------------------------------------------------------------------------

SelbiSplash_Sounds:
		dc.b	$BD
		dc.b	$B5
		dc.b	$BC
		dc.b	$A6
		dc.b	$C4
		even

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash_Loop:
		cmpi.l	#$4EE00001,($FFFFFF7A).w
		beq.w	@cont
		cmpi.w	#$20,($FFFFF614).w		; is time less than $40?
		bpl	SelbiSplash_ChangePal	; if yes, branch

		lea	($C00000).l,a5			; load VDP data port address to a5
		lea	($C00004).l,a6			; load VDP address port address to a6
		move.l	($FFFFFF7A).w,(a6)		; set VDP address to write to
		move.l	#$44444444,d2
		move.l	d2,(a5)			; dump art to V-Ram
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		move.l	d2,(a5)			; ''
		addi.l	#$00200000,($FFFFFF7A).w

		lea	(SelbiSplash_Sounds).l,a1
		move.w	($FFFFFF7E).w,d3
		move.b	(a1,d3.w),d0
		jsr	PlaySound_Special
		addi.w	#1,($FFFFFF7E).w

		cmpi.l	#$4EE00001,($FFFFFF7A).w
		beq.s	@cont2
		add.w	#$20,($FFFFF614).w

		bra	SelbiSplash_ChangePal
@cont2:
		move.w	#$D0,($FFFFF614).w
		lea	($C00000).l,a5
		lea	$04(a5),a6
		move.w	#$8B00,(a6)
		move.l	#$40000010,(a6)
		move.w	#$0008,(a5)
@cont:
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB04)
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB06)
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB08)
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0A)
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0C)
		sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0E)
		cmpi.w	#$90,($FFFFF614).w		; is time less than $40?
		bmi.s	SelbiSplash_DontChangePal	; if yes, branch
		cmpi.w	#$D0,($FFFFF614).w		; is time more than $70?
		bpl.w	SelbiSplash_ChangePal		; if yes, branch

		move.b	($FFFFFE0F).w,d0
		andi.b	#3,d0
		bne.w	SelbiSplash_ChangePal
		jsr	Pal_ToWhite

		lea	($C00000).l,a5
		lea	$04(a5),a6
		move.w	#$8B00,(a6)
		move.l	#$40000010,(a6)
		move.w	#$0008,(a5)


		move.b	($FFFFFE0F).w,d0
		andi.b	#5,d0
		beq.s	SelbiSplash_ChangePal

		move.b	(SelbiSplash_Sounds+4),d0
		jsr	PlaySound_Special
		bra.s	SelbiSplash_ChangePal

SelbiSplash_DontChangePal:
		tst.b	($FFFFFFAF).w
		bne.s	SelbiSplash_ChangePal
		move.b	#$B9,d0			; play giant ring sound
		jsr	PlaySound		
		movem.l	d0-a6,-(sp)

SelbiSplash_LoadPRESENTS:
		lea	($FF0000).l,a1			; Load screen mappings
		lea	(Map2_SelbiSplash).l,a0
		move.w	#0,d0
		jsr	EniDec
		lea	($FF0000).l,a1			; Show screen
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

SelbiSplash_PalLoop2:
		move.l	(a1)+,(a2)+
		tst.w	d0
		beq.s	SelbiSplash_PL2Passed
		sub.w	#1,d0
		bra.s	SelbiSplash_PalLoop2

SelbiSplash_PL2Passed:	
		jsr	Pal_MakeWhite
		movem.l (sp)+,d0-a6
		move.b	#1,($FFFFFFAF).w

SelbiSplash_ChangePal:
		move.b	#2,($FFFFF62A).w		; Function 2 in vInt
		jsr	DelayProgram			; Run delay program
		tst.w	($FFFFF614).w			; Test wait time
		beq.s	SelbiSplash_Next		; is it over? branch
		andi.b	#$80,($FFFFF605).w		; is Start button pressed?
		beq.w	SelbiSplash_Loop		; if not, loop

SelbiSplash_Next:
		clr.b	($FFFFFFAF).w
		clr.l	($FFFFFF7A).w
	;	jmp	TongaraSplash
		move.b	#SelbiSplash_NxtScr,($FFFFF600).w ; go to next screen
		rts	
		
; ---------------------------------------------------------------------------------------------------------------------
Art_SelbiSplash:	incbin	"Screens/SelbiSplash/Tiles.bin"
			even
;Map_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_NoPRESENTS.bin"
;			even
Map2_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_WithPRESENTS.bin"
			even
Map3_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_SoftSelbi.bin"
			even
Pal_SelbiSplash:	incbin	"Screens/SelbiSplash/Palette.bin"
			even 