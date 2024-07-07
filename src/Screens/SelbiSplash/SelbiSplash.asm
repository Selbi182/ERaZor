; =====================================================================================================================
; Selbi Splash Screen - Code made by Marc - Sonic ERaZor
; =====================================================================================================================
SelbiSplash_MusicID		EQU	$B7		; Music to play
SelbiSplash_Wait		EQU	$30		; Time to wait ($100)
SelbiSplash_PalChgSpeed		EQU	$200		; Speed for the palette to be changed ($200)
Selbi_DebugCheat		EQU	20		; Inputs required to unlock debug cheat
; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash:
		move.b	#$E4,d0
		jsr	PlaySound_Special		; Stop music
		jsr	PLC_ClearQueue			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette
		move	#$2700,sr

SelbiSplash_VDP:
		lea	($C00004).l,a6			; Setup VDP
		move.w	#$8014,(a6)			; enable h-ints for the black bars
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
		move.w	#Selbi_DebugCheat,($FFFFFFE4).w		; set up to inputs required to unlock debug mode
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
		tst.b	($FFFFFFAF).w
		beq.s	@Normal
		move.b	#$1A,VBlankRoutine		; Function 2 in vInt
		jsr	DelayProgram			; Run delay program
		bra.s	@Special

	@Normal:
		move.b	#2,VBlankRoutine		; Function 2 in vInt
		jsr	DelayProgram			; Run delay program

	@Special:
		tst.w	($FFFFF614).w			; Test wait time
		beq.w	SelbiSplash_Next		; is it over? branch

		cmpi.l	#$4EE00001,($FFFFFF7A).w	; vram=$4EE0
		beq.w	@cont
		cmpi.w	#$20,($FFFFF614).w		; is time less than $20?
		bpl	SelbiSplash_WaitEnd		; if not, branch

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

		bra	SelbiSplash_WaitEnd
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


		btst	#1,($FFFFFE0F).w
		bne.w	@0
		lea	@PalFlicker(pc),a4
		moveq	#(@PalFlicker_End-@PalFlicker)-1,d4
	lea	(0).w,a1



		tst.b	($FFFFFFAF).w
		bne.s	@FlashList
		moveq	#$00,d4
		lea	($FFFFFB04).w,a1
		move.w	$80(a1),d2
		bra.s	@NoQuality

	@FlashList:
		addq.l	#$01,($FFFFFE0C).w
	moveq	#$03,d0
	and.b	($FFFFFE0F).w,d0
	bne.s	@NoHalfSpeed
	addq.l	#$01,($FFFFFE0C).w

	@NoHalfSpeed:
		moveq	#$00,d2
		move.b	(a4)+,d2

		lea	($FFFFFB00).w,a1
		lea	Pal_Quality(pc),a0
		adda.w	d2,a1
		adda.w	d2,a0
		move.w	(a0),d1

	@NoQuality:
		moveq	#$0E,d3
		and.w	d2,d3
		sub.w	d3,d2

		move.w	d4,d0
		add.b	($FFFFFE0F).w,d0
		jsr	CalcSine
		asr.w	#$05,d0
		addq.b	#$01,d0
		andi.w	#$000E,d0

		add.w	d0,d3
		cmpi.w	#$000E,d3
		blo.s	@NoMaxRed
		moveq	#$0E,d3

	@NoMaxRed:
		tst.w	d3
		bpl.s	@NoMinRed
		moveq	#$00,d3

	@NoMinRed:
		or.w	d3,d2

	add.w	d0,d0
	andi.w	#$00E0,d0
	move.w	d2,d3
	andi.w	#$00E0,d3
	sub.w	d3,d2
	add.w	d0,d3
		cmpi.w	#$0E0,d3
		blo.s	@NoMaxGreen
		move.w	#$0E0,d3

	@NoMaxGreen:
		tst.w	d3
		bpl.s	@NoMinGreen
		moveq	#$00,d3

	@NoMinGreen:
		or.w	d3,d2

	
		move.w	d2,(a1)
		dbf	d4,@FlashList

	;	btst	#0,($FFFFFE0F).w
	;	bne.s	@0
	;	lea	($FFFFFB04),a1
	;	move.w	#6-1,d4
@boost:	;	jsr	SineWavePalette
	;	andi.w	#$00E,d0
	;	move.w	d0,(a1)
	;	dbf	d4,@boost

		cmpi.w	#$90,($FFFFF614).w		; is time less than $90?
		bpl.w	@0
	tst.b	($FFFFFFAF).w
	bne.w	@NoFaffing
		move.w	#$8B07,($C00004).l
	@NoFaffing:
		moveq	#8,d0

		move.w	($FFFFFE0E).w,d6	; get timer

	bra.s	@0

	@PalFlicker:
		dc.b	$08,$0A,$0C,$0E, $12,$14,$16,$18,$1A,$1C
		dc.b	$22,$24,$26, $2C,$2E,$30, $3C,$3E
	@PalFlicker_End:
		even

		lea	($FFFFCC00).w,a1
		move.l	#1,d0
		move.w	#223,d1
		btst	#1,($FFFFFE0F).w
		beq.s	@scrollshitfuckass
		neg.l	d0

@scrollshitfuckass:
		move.l	d0,(a1)+
		neg.l	d0
		dbf	d1,@scrollshitfuckass

@0:
		cmpi.w	#$90,($FFFFF614).w		; is time less than $90?
		bmi.w	SelbiSplash_DontChangePal	; if yes, branch
		cmpi.w	#$D0,($FFFFF614).w		; is time more than $D0?
		bpl.w	SelbiSplash_WaitEnd		; if yes, branch

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
		bne.w	SelbiSplash_WaitEnd

	;	jsr	Pal_ToWhite	; increase brightness
		bsr	Pal_ToWhiteYellow
		move.w	#$000,($FFFFFB02).w	; force black bars to stay black

		move.b	($FFFFFE0F).w,d0
		andi.b	#5,d0
		beq.w	SelbiSplash_WaitEnd

		move.b	(SelbiSplash_Sounds+4),d0
		jsr	PlaySound_Special
		bra	SelbiSplash_WaitEnd

SelbiSplash_DontChangePal:
		tst.b	($FFFFFFAF).w			; has final screen already been loaded?
		bne.w	SelbiSplash_WaitEnd		; if yes, branch
		move.b	#$B9,d0				; play massive explosion sound
		jsr	PlaySound		

SelbiSplash_LoadPRESENTS:
		move.b	#2,VBlankRoutine
		jsr	DelayProgram			; VSync so gfx loading below isn't terribly out of VBlank

		VBlank_SetMusicOnly
		move.w	sr,-(sp)
		move.w	#$2700,sr

		lea	($C00004).l,a6

		lea	VDP_Quality(pc),a0
		move.w	#$8000,d0
		move.w	#$0100,d1
		moveq	#$12-1,d2

	@LoadVDP:
		move.b	(a0)+,d0
		move.w	d0,(a6)
		add.w	d1,d0
		dbf	d2,@LoadVDP

		move.w	#$8100|%00010100,(a6)		; $81	; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.l	#$94809300,(a6)
		move.l	#$96009500|(((Art_Quality/2)&$FF00)<<8)|((Art_Quality/2)&$FF),(a6)
		move.l	#$97004000|((Art_Quality/2)&$7F0000),(a6)
		move.w	#$0080,-(sp)
		move.w	(sp)+,(a6)

		move.w	#$8100|%01110100,(a6)		; $81	; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)

	;	lea	($FF0000).l,a1			; Load screen mappings
	;	lea	(Map2_SelbiSplash).l,a0
	;	moveq	#0,d0
	;	jsr	EniDec
		VBlank_UnsetMusicOnly

	;	move.b	#2,VBlankRoutine
	;	jsr	DelayProgram			; VSync so gfx loading below isn't terribly out of VBlank
	;	VBlank_SetMusicOnly
	;	lea	($FF0000).l,a1			; Show screen
	;	move.l	#$40000003,d0
	;	moveq	#$27,d1
	;	moveq	#$1B,d2
	;	jsr	ShowVDPGraphics
	;	VBlank_UnsetMusicOnly

		lea	(Pal_Quality).l,a1		; Load palette
		lea	($FFFFFB00).w,a2
		moveq	#($80/4)-1,d0

	@LoadCRAM:
		move.l	(a1)+,(a2)+
		dbf	d0,@LoadCRAM

	move.w	(sp)+,sr
	;	jsr	Pal_MakeWhite			; white flash
		move.b	#1,($FFFFFFAF).w		; set flag that we are in the final phase of the screen

SelbiSplash_WaitEnd:
		; hidden debug mode cheat
		tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
		beq.s	SelbiSplash_LoopEnd		; if not, branch
		moveq	#0,d0				; clear d0
		move.b	($FFFFF605).w,d0		; get button press
		andi.b	#$70,d0				; filter ABC only
		beq.s	SelbiSplash_LoopEnd		; if none were pressed, skip

		subq.w	#1,($FFFFFFE4).w		; sub 1 from button presses remaining
		beq.s	@firecheat			; if we reached 0, activate cheat
		bmi.s	SelbiSplash_LoopEnd		; for any further than the set input presses, don't do anything

		tst.b	($FFFFF601).w			; is this the first time the game is being played?
		beq.s	SelbiSplash_LoopEnd		; if yes, avoid newbies accidentally discovering debug mode immediately lol
		move.b	#$A9,d0				; set blip sound
		jsr	PlaySound_Special		; play it
		bra.s	SelbiSplash_LoopEnd		; skip

@firecheat:
		move.b	#%01111111,d0			; unlock all doors...
		move.b	d0,($FFFFFF8A).w		; ...in casual...
		move.b	d0,($FFFFFF8B).w		; ...and frantic
		move.b	#%1111,($FFFFFF93).w		; set full game beaten state
		jsr	SRAM_SaveNow			; save
		
		tst.w	($FFFFFFFA).w			; was debug mode already enabled?
		bne.s	SelbiSplash_DisableDebug	; if yes, disable it
		move.w	#1,($FFFFFFFA).w	 	; enable debug mode
		move.w	#$90,($FFFFF614).w		; reset ending timer
		jsr	Pal_MakeWhite			; white flash
		move.b	#$A8,d0				; set enter SS sound
		jsr	PlaySound_Special		; play it

SelbiSplash_LoopEnd:
		move.b	($FFFFF605).w,d0		; get button presses
		andi.b	#$F0,d0				; filter A, B, C, or Start
		tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
		beq.s	@notfinal			; if not, branch
		andi.b	#$80,d0				; filter only Start
@notfinal:
		tst.b	d0				; was anything pressed?
		beq.w	SelbiSplash_Loop		; if not, loop
		
SelbiSplash_Next:
		clr.b	($FFFFFFAF).w
		clr.l	($FFFFFF7A).w

		move.w	#$3F,($FFFFF626).w
		moveq	#$07,d4					; MJ: set repeat times
		moveq	#$00,d6					; MJ: clear d6

	@FadePrivate:
		jsr	PLC_Execute
		move.b	#$1A,VBlankRoutine
		jsr	DelayProgram
		bchg	#$00,d6					; MJ: change delay counter
		beq	@FadePrivate				; MJ: if null, delay a frame
		jsr	Pal_FadeOut
		cmpi.w	#$03,d4					; MJ: have we reached a point where shadow/highlight can been hidden?
		bne.s	@NoStopShadow				; MJ: if not, continue normally
		move.w	#$8C00|%11110111,d0			; MJ: $8C	; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		and.b	VDP_Quality+$0C(pc),d0			; MJ: remove shadow/highlight
		move.w	d0,($C00004).l				; MJ: ''

	@NoStopShadow:
		dbf	d4,@FadePrivate

		jsr	VDPSetupGame

		jmp	Exit_SelbiSplash

SelbiSplash_DisableDebug:
		move.w	#0,($FFFFFFFA).w	 	; disable debug mode
		move.b	#$A4,d0				; set skidding sound
		jsr	PlaySound_Special		; play it
		bra.s	SelbiSplash_LoopEnd

; ---------------------------------------------------------------------------------------------------------------------

; the original to-white code cause it looks better with the yellow tint here
Pal_ToWhiteYellow:				; XREF: Pal_MakeFlash
		moveq	#0,d0
		lea	($FFFFFB00).w,a0
		move.b	($FFFFF626).w,d0
		adda.w	d0,a0
		move.b	($FFFFF627).w,d0

@loc_1FAC:
		bsr.s	Pal_AddColor2_Yellow
		dbf	d0,@loc_1FAC
		moveq	#0,d0
		lea	($FFFFFA80).w,a0
		move.b	($FFFFF626).w,d0
		adda.w	d0,a0
		move.b	($FFFFF627).w,d0

@loc_1FC2:
		bsr.s	Pal_AddColor2_Yellow
		dbf	d0,@loc_1FC2
		rts	

Pal_AddColor2_Yellow:				; XREF: Pal_ToWhite
		move.w	(a0),d2
		cmpi.w	#$EEE,d2
		beq.s	@loc_2006
		move.w	d2,d1
		andi.w	#$E,d1
		cmpi.w	#$E,d1
		beq.s	@loc_1FE2
		addq.w	#2,(a0)+	; increase red value
		rts	

@loc_1FE2:				; XREF: Pal_AddColor2
		move.w	d2,d1
		andi.w	#$E0,d1
		cmpi.w	#$E0,d1
		beq.s	@loc_1FF4
		addi.w	#$20,(a0)+	; increase green value
		rts	

@loc_1FF4:				; XREF: @loc_1FE2
		move.w	d2,d1
		andi.w	#$E00,d1
		cmpi.w	#$E00,d1
		beq.s	@loc_2006
		addi.w	#$200,(a0)+	; increase blue	value
		rts	

@loc_2006:				; XREF: Pal_AddColor2
		addq.w	#2,a0
		rts	
; End of function Pal_MakeFlash

; ---------------------------------------------------------------------------------------------------------------------
ArtKospM_SelbiSplash:	incbin	"Screens/SelbiSplash/Tiles.kospm"
			even
;Map_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_NoPRESENTS.bin"
;			even
;Map2_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_WithPRESENTS.bin"
;			even
Map3_SelbiSplash:	incbin	"Screens/SelbiSplash/Maps_SoftSelbi.bin"
			even
Pal_SelbiSplash:	incbin	"Screens/SelbiSplash/Palette.bin"
			even 

VDP_Quality:		incbin	"Screens\SelbiSplash\selbiv2k\VDP.bin"
			even
Pal_Quality:		incbin	"Screens\SelbiSplash\selbiv2k\CRAM.bin"
			even
	align	$10000
Art_Quality:		incbin	"Screens\SelbiSplash\selbiv2k\VRAM.bin"
			even
