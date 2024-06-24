; =====================================================================================================================
; Selbi Splash Screen - Code made by Marc - Sonic ERaZor
; =====================================================================================================================
SelbiSplash_MusicID		EQU	$B7		; Music to play
SelbiSplash_Wait		EQU	$30		; Time to wait ($100)
SelbiSplash_PalChgSpeed		EQU	$200		; Speed for the palette to be changed ($200)

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash:
		move.b	#$E4,d0
		jsr	PlaySound_Special		; Stop music
		jsr	PLC_ClearQueue			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette
		move	#$2700,sr

SelbiSplash_VDP:
		lea	($C00004).l,a6			; Setup VDP
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen			; Clear screen
		
SelbiSplash_Art:
		move.l	#$40000000,($C00004).l		; Load art
		lea	(ArtKospM_SelbiSplash).l,a0
		jsr	KosPlusMDec_VRAM
		
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
		moveq	#7,d0
SelbiSplash_PalLoop:
		move.l	(a1)+,(a2)+
		dbf	d0,SelbiSplash_PalLoop
		
SelbiSplash_SetWait:
		move.w	#SelbiSplash_Wait,($FFFFF614).w	; Wait time
		jsr	Pal_FadeTo			; Fade palette in
		
		vram	$4E40, ($FFFFFF7A).w
		move.w	#0,($FFFFFF7E).w
		move.w	#6,($FFFFF5B0).w
		display_enable
		bra.s	SelbiSplash_Loop
; ---------------------------------------------------------------------------------------------------------------------

SelbiSplash_Sounds:
		dc.b	$BD	; S
		dc.b	$B5	; E
		dc.b	$BC	; L
		dc.b	$A6	; B
		dc.b	$C4	; I (explosion sounds)
		even

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash_Loop:
		move.b	#2,VBlankRoutine		; Function 2 in vInt
		jsr	DelayProgram			; Run delay program
		tst.w	($FFFFF614).w			; Test wait time
		beq.w	SelbiSplash_Next		; is it over? branch

		cmpi.l	#$4EE00001,($FFFFFF7A).w	; vram=$4EE0
		beq.w	@cont
		cmpi.w	#$20,($FFFFF614).w		; is time less than $20?
		bpl	SelbiSplash_ChangePal		; if not, branch

		VBlank_SetMusicOnly
		lea	($C00000).l,a5			; load VDP data port address to a5
		lea	($C00004).l,a6			; load VDP address port address to a6
		move.l	($FFFFFF7A).w,(a6)		; set VDP address to write to
		move.l	#$44444444,d2
		move.l	d2,(a5)				; dump art to V-Ram
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		move.l	d2,(a5)				; ''
		addi.l	#$00200000,($FFFFFF7A).w	; select next tile
		VBlank_UnsetMusicOnly

		lea	(SelbiSplash_Sounds).l,a1
		move.w	($FFFFFF7E).w,d3
		move.b	(a1,d3.w),d0
		jsr	PlaySound_Special
		addi.w	#1,($FFFFFF7E).w

		cmpi.l	#$4EE00001,($FFFFFF7A).w
		beq.s	@cont2
		addi.w	#$20,($FFFFF614).w

		bra	SelbiSplash_ChangePal
@cont2:
		move.w	#$D0,($FFFFF614).w
		lea	($C00000).l,a5
		lea	$04(a5),a6
	;	move.w	#$8B00,(a6)
		move.l	#$40000010,(a6)
		move.w	#$0008,(a5)
@cont:
		; palette flashing effect
		; (this is a terrible way of doing this lol)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB04)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB06)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB08)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0A)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0C)
	;	sub.w	#SelbiSplash_PalChgSpeed,($FFFFFB0E)
		
		btst	#0,($FFFFFE0F).w
		bne.s	@0
		lea	($FFFFFB04),a1
		move.w	#6-1,d4
@boost:		jsr	SineWavePalette
		andi.w	#$00E,d0
		move.w	d0,(a1)
		dbf	d4,@boost


		cmpi.w	#$90,($FFFFF614).w		; is time less than $90?
		bpl.w	@0
		move.w	#$8B07,($C00004).l
		moveq	#8,d0
		jsr	Options_BGDeformation2

@0:
		cmpi.w	#$90,($FFFFF614).w		; is time less than $90?
		bmi.w	SelbiSplash_DontChangePal	; if yes, branch
		cmpi.w	#$D0,($FFFFF614).w		; is time more than $D0?
		bpl.w	SelbiSplash_ChangePal		; if yes, branch

		; screen shake Y
		move.w	($FFFFF5B0).w,d0
		lsr.w	#2,d0
		move.b	($FFFFFE0F).w,d1
		andi.b	#1,d1
		beq.s	@cont1x
		neg.w	d0
@cont1x:
		VBlank_SetMusicOnly
		lea	($C00000).l,a5
		lea	$04(a5),a6
		move.w	#$8B00,(a6)
		move.l	#$40000010,(a6)
		move.w	d0,(a5)

		; screen shake X
		move.w	($FFFFF5B0).w,d0
		lsr.w	#3,d0
		move.b	($FFFFFE0F).w,d1
		andi.w	#2,d1
		beq.s	@cont2x
		neg.w	d0
@cont2x:
		lea	($C00000).l,a5
		lea	$04(a5),a6
		move.w	#$8B00,(a6)
		move.l	#$7C000003,(a6)
		move.w	d0,(a5)
		VBlank_UnsetMusicOnly

		move.b	($FFFFFE0F).w,d0
		andi.b	#1,d0
		bne.s	@cont3x
		moveq	#1,d1	; increase screen shake
		add.w	d1,($FFFFF5B0).w
@cont3x:
	
		move.b	($FFFFFE0F).w,d0
		andi.b	#3,d0
		bne.w	SelbiSplash_ChangePal

		jsr	Pal_ToWhite	; increase brightness


		move.b	($FFFFFE0F).w,d0
		andi.b	#5,d0
		beq.w	SelbiSplash_ChangePal

		move.b	(SelbiSplash_Sounds+4),d0
		jsr	PlaySound_Special
		bra	SelbiSplash_ChangePal

SelbiSplash_DontChangePal:
		tst.b	($FFFFFFAF).w			; has final screen already been loaded?
		bne.w	SelbiSplash_ChangePal		; if yes, branch
		move.b	#$B9,d0				; play massive explosion sound
		jsr	PlaySound		

SelbiSplash_LoadPRESENTS:
		lea	($FF0000).l,a1			; Load screen mappings
		lea	(Map2_SelbiSplash).l,a0
		moveq	#0,d0
		jsr	EniDec

		move.b	#2,VBlankRoutine
		jsr	DelayProgram			; VSync so gfx loading below isn't terribly out of VBlank
		VBlank_SetMusicOnly
		lea	($FF0000).l,a1			; Show screen
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics
		VBlank_UnsetMusicOnly

SelbiSplash_PL2Passed:
		lea	(Pal_SelbiSplash).l,a1		; Load palette
		lea	($FFFFFB00).w,a2
		rept 8
			move.l	(a1)+,(a2)+
		endr

	;	jsr	Pal_MakeWhite			; white flash
		move.b	#1,($FFFFFFAF).w		; set flag that we are in the final phase of the screen

SelbiSplash_ChangePal:
		
		; hidden debug mode cheat
		tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
		beq.s	SelbiSplash_LoopEnd		; if not, branch
		tst.b	($FFFFF605).w			; get any button press
		beq.s	SelbiSplash_LoopEnd		; if none are pressed, skip
		addq.w	#1,($FFFFFFE4).w		; increase counter
		cmpi.w	#10,($FFFFFFE4).w		; check if 10 buttons have been pressed
		bne.s	SelbiSplash_LoopEnd		; if not, branch
		
		; cheat here
		move.b	#%01111111,($FFFFFF8B).w	; unlock all doors
		move.b	#1,($FFFFFF93).w		; mark game as beaten
		
		tst.w	($FFFFFFFA).w			; was debug mode already enabled?
		bne.s	SelbiSplash_DisableDebug	; if yes, disable it
		move.w	#1,($FFFFFFFA).w	 	; enable debug mode
		move.b	#$A8,d0				; set enter SS sound
		jsr	PlaySound_Special		; play it

SelbiSplash_LoopEnd:
		move.b	($FFFFF605).w,d0
		andi.b	#$F0,d0				; is A, B, C, or Start pressed?
		tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
		beq.s	@cont				; if not, branch
		andi.b	#$80,d0
@cont:
		tst.b	d0
		beq.w	SelbiSplash_Loop		; if not, loop
		
SelbiSplash_Next:
		clr.b	($FFFFFFAF).w
		clr.l	($FFFFFF7A).w
	
	if QuickLevelSelect=1
		move.b	#4,($FFFFF600).w		; go to title screen
		rts
	endif

		tst.b	($FFFFFFA7).w			; is this the first time the game is being played?
		beq.s	SelbiSplash_FirstTime		; if yes, branch
		move.b	#4,($FFFFF600).w		; otherwise go to title screen
		rts	

SelbiSplash_FirstTime:
	;	move.b	#$E0,d0			; fade out music
	;	jsr	PlaySound
	;	jsr	Pal_MakeWhite		; Fade out previous palette
	;	bsr.s	ERZ_FadeOut
		move.b	#$30,($FFFFF600).w	; set to GameplayStyleScreen
		rts

SelbiSplash_DisableDebug:
		move.w	#0,($FFFFFFFA).w	 	; disable debug mode
		move.b	#$A4,d0				; set skidding sound
		jsr	PlaySound_Special		; play it
		bra.s	SelbiSplash_LoopEnd

; ---------------------------------------------------------------------------------------------------------------------
ArtKospM_SelbiSplash:	incbin	"Screens/SelbiSplash/Tiles.kospm"
			even
;Map_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_NoPRESENTS.bin"
;			even
Map2_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_WithPRESENTS.bin"
			even
Map3_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_SoftSelbi.bin"
			even
Pal_SelbiSplash:	incbin	"Screens/SelbiSplash/Palette.bin"
			even 