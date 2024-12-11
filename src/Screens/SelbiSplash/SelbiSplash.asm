; =====================================================================================================================
; Selbi Splash Screen
; =====================================================================================================================
; Dear reader,
; the code in this file is a heavily bastardized cripple of a splash screen, initially crafted in 2009 and steadily
; grown upon as the years went by. It should've been put to rest long ago and replaced with something more properly
; coded, but this never happened and instead this beast kept on mutating.
; I shall not be responsible for any eyesore along the way.
; =====================================================================================================================
SelbiSplash_MusicID		EQU	$B7		; Music to play
SelbiSplash_Wait		EQU	$30		; Time to wait ($100)
SelbiSplash_PalChgSpeed		EQU	$200		; Speed for the palette to be changed ($200)
Selbi_DebugCheat		EQU	20		; Inputs required to unlock debug cheat

_VRAM_SelbiArt:		equ	$F400

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash:
		move.b	#$E4,d0
		jsr	PlaySound_Special		; Stop music
		jsr	PLC_ClearQueue			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette

		display_disable
		VBlank_SetMusicOnly

		lea	VDP_Ctrl,a6			; Setup VDP
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B07,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen			; Clear screen
		
		; Load art
		vram	_VRAM_SelbiArt
		lea	ArtKospM_SelbiSplash, a0
		jsr	KosPlusMDec_VRAM

		; Load mappings
		lea	$FF0000, a1
		lea	MapEni_SelbiSplash, a0
		move.w	#_VRAM_SelbiArt/$20, d0
		jsr	EniDec
		lea	$FF0000, a1
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		; Clear the palette
		moveq	#0, d0
		lea	Pal_Active, a2
		moveq	#$80/$10-1, d1

	@ClearPal:
		rept 4
			move.l	d0, (a2)+
		endr
		dbf	d1, @ClearPal

		; Preload Part 1 of Bitmap MD image to VRAM (we can do it because we don't touch this area)
		vram	$0000
		lea	BitmapMD_VRAM_Part1, a0
		jsr	KosPlusMDec_VRAM
		VBlank_UnsetMusicOnly	

		; Preload Part 2 of Bitmap MD image to RAM (so we can transfer it later)
		lea	BitmapMD_VRAM_Part2, a0
		lea	$FF0000, a1
		jsr	KosPlusDec

SelbiSplash_SetWait:
		move.w	#SelbiSplash_Wait,($FFFFF614).w	; Wait time

		move.w	#Pal_Active+$10, ($FFFFFF7A).w
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
		move.b	#2,VBlankRoutine		; Function 2 in vInt
		jsr	DelayProgram			; Run delay program

		tst.w	($FFFFF614).w			; Test wait time
		beq.w	SelbiSplash_Next		; is it over? branch

		cmpi.w	#Pal_Active+$10+2*5,($FFFFFF7A).w
		beq.w	@cont
		cmpi.w	#$20,($FFFFF614).w		; is time less than $20?
		bpl	SelbiSplash_WaitEnd		; if not, branch

		movea.w	($FFFFFF7A).w, a1
		move.w	#$EEE, (a1)+			; display letter
		move.w	a1, ($FFFFFF7A).w		; select next letter

		move.w	($FFFFFF7E).w,d3
		move.b	SelbiSplash_Sounds(pc,d3.w), d0
		jsr	PlaySound_Special
		addq.w	#1,($FFFFFF7E).w

		cmpi.w	#Pal_Active+$10+2*5,($FFFFFF7A).w
		beq.s	@cont2
		addi.w	#$20,($FFFFF614).w

		bra	SelbiSplash_WaitEnd
@cont2:
		move.w	#$D0,($FFFFF614).w
		VBlank_SetMusicOnly
		lea	VDP_Data,a5
		lea	$04(a5),a6
		move.w	#$8014,(a6)			; enable h-ints for the black bars
		move.l	#$40000010,(a6)
		move.w	#$0008,(a5)
		VBlank_UnsetMusicOnly

@cont:
		; new flashing effect
		cmpi.w	#$90,($FFFFF614).w
		bge.w	SelbiSplash_EffectsEnd
		bsr	SelbiSplash_UpdateEndPal
		bra.w	SelbiSplash_EffectsEnd
; ---------------------------------------------------------------------------

SelbiSplash_UpdateEndPal:
		moveq	#0,d0
		move.w	($FFFFF614).w,d0
		move.w	d0,d1
		lsr.w	#4+1,d0
		mulu.w	d1,d0
		andi.w	#$1F,d0
		move.w	d0,d1
		andi.w	#$10,d1
		beq.s	@notreverse
		subq.w	#2,d1
		andi.w	#$E,d0
		sub.w	d0,d1
		move.w	d1,d0
@notreverse:
		andi.w	#$E,d0
		move.w	d0,d4
@gopal:
		lea	BitmapMD_CRAM, a1	; Load palette
		lea	Pal_Active, a2
		moveq	#($160/4)-1,d6
@LoadCRAM:	move.w	(a1)+,d0
		bsr	SelbiPissFilter
		move.w	d0,(a2)+
		dbf	d6,@LoadCRAM
		rts
; ---------------------------------------------------------------------------
SelbiPissFilter:
		move.w	d0,d1			; copy color

		ror.w	#4,d1			; get green color
		move.w	d1,d2			; copy to d2
		andi.w	#$00E,d2		; limit to one channel

		cmp.w	d4,d2			; are we at or avobe the minimum value?
		bge.s	@decreaseG		; if yes, decrease
		moveq	#0,d2			; otherwise, set green 0
		bra.s	@applyG			; skip
@decreaseG:	sub.w	d4,d2			; decrease green value

@applyG:
		ror.w	#4,d1			; get blue color
		move.w	d1,d3			; copy to d3
		andi.w	#$00E,d3		; limit to one channel
		
		cmp.w	d4,d3			; are we at or avobe the minimum value?
		bge.s	@decrease		; if yes, decrease
		moveq	#0,d3			; otherwise, set blue 0
		bra.s	@apply			; skip
@decrease:	sub.w	d4,d3			; decrease blue value

@apply:
		rol.w	#4,d2			; prepare for merge
		rol.w	#8,d3			; prepare for merge
		or.w	d2,d3			; merge green and blue channel
		andi.w	#$000E,d0		; clear the previous upper byte of the previous color
		or.w	d3,d0			; merge with new red value
		rts
; ---------------------------------------------------------------------------

SelbiSplash_EffectsEnd:
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
		lea	VDP_Data,a5
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
		lea	VDP_Data,a5
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
		jsr	Pal_CutToBlack

		move.b	#2,VBlankRoutine
		jsr	DelayProgram			; VSync so gfx loading below isn't terribly out of VBlank
		jsr	BlackBars.Reset

		move.l	#SelbiSplash_DisplayBitmapMD, VBlankCallback
		move.b	#2,VBlankRoutine
		jsr	DelayProgram

		bsr	SelbiSplash_UpdateEndPal

		move.b	#1,($FFFFFFAF).w		; set flag that we are in the final phase of the screen

SelbiSplash_WaitEnd:
		; hidden debug mode cheat
		tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
		beq	SelbiSplash_LoopEnd		; if not, branch
		moveq	#0,d0				; clear d0
		move.b	($FFFFF605).w,d0		; get button press
		andi.b	#$70,d0				; filter ABC only
		beq	SelbiSplash_LoopEnd		; if none were pressed, skip

		subq.w	#1,($FFFFFFE4).w		; sub 1 from button presses remaining
		beq.s	@firecheat			; if we reached 0, activate cheat
		bmi	SelbiSplash_LoopEnd		; for any further than the set input presses, don't do anything
		move.b	#$A9,d0				; set blip sound
		jsr	PlaySound_Special		; play it
		bra	SelbiSplash_LoopEnd		; skip

@firecheat:
		move.w	#$90,($FFFFF614).w		; reset ending timer

		tst.w	($FFFFFFFA).w			; was debug mode already enabled?
		bne.w	SelbiSplash_DisableDebug	; if yes, disable it
		move.w	#1,($FFFFFFFA).w	 	; enable debug mode
		move.b	#$A8,d0				; set enter SS sound
		jsr	PlaySound_Special		; play it

SelbiSplash_LoopEnd:
		move.b	($FFFFF605).w,d0		; get button presses
		andi.b	#$F0,d0				; filter A, B, C, or Start

		cmpi.w	#5,($FFFFFF7E).w		; did we make it to the "I" yet?
		blo.s	@notfinal			; if not, branch
	;	tst.b	($FFFFFFAF).w			; are we in the final phase of the screen?
	;	beq.s	@notfinal			; if not, branch
		andi.b	#$80,d0				; filter only Start
@notfinal:
		tst.b	d0				; was anything pressed?
		beq.w	SelbiSplash_Loop		; if not, loop
		
SelbiSplash_Next:
		clr.b	($FFFFFFAF).w
		clr.w	($FFFFFF7A).w

		move.w	#$3F,($FFFFF626).w
		moveq	#$07,d4					; MJ: set repeat times
		moveq	#$00,d6					; MJ: clear d6

	@FadePrivate:
		jsr	PLC_Execute
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		bchg	#$00,d6					; MJ: change delay counter
		beq	@FadePrivate				; MJ: if null, delay a frame
		jsr	Pal_FadeOut
		cmpi.w	#$03,d4					; MJ: have we reached a point where shadow/highlight can been hidden?
		bne.s	@NoStopShadow				; MJ: if not, continue normally
		move.w	#$8C00|%11110111,d0			; MJ: $8C	; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		and.b	BitmapMD_VDP+$0C(pc),d0			; MJ: remove shadow/highlight
		move.w	d0,VDP_Ctrl				; MJ: ''

	@NoStopShadow:
		dbf	d4,@FadePrivate

		VBlank_SetMusicOnly
		jsr	VDPSetupGame
		VBlank_UnsetMusicOnly

		jmp	Exit_SelbiSplash

SelbiSplash_DisableDebug:
		jsr	UnlockEverything		; unlock all doors (in casual and frantic) and all bonus options
		
		move.w	#0,($FFFFFFFA).w	 	; disable debug mode
		move.b	#$A4,d0				; set skidding sound
		jsr	PlaySound_Special		; play it
		bra.w	SelbiSplash_LoopEnd

; ---------------------------------------------------------------------------------------------------------------------
SelbiSplash_DisplayBitmapMD:
		lea	VDP_Ctrl,a6
		lea	BitmapMD_VDP(pc),a0
		move.w	#$8000,d0
		move.w	#$0100,d1
		moveq	#$12-1,d2
	@LoadVDP:
		move.b	(a0)+,d0
		move.w	d0,(a6)
		add.w	d1,d0
		dbf	d2,@LoadVDP

		vramWrite $FF0000, $4000, $C000		; load Bitmap MD VRAM Part 2 (this one actually displays shit now)

		move.w	#$8100|%01110100,(a6)		; $81	; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		rts

; ---------------------------------------------------------------------------------------------------------------------

; the original to-white code cause it looks better with the yellow tint here
Pal_ToWhiteYellow:				; XREF: Pal_MakeFlash
		moveq	#0,d0
		lea	Pal_Active,a0
		move.b	($FFFFF626).w,d0
		adda.w	d0,a0
		move.b	($FFFFF627).w,d0

@loc_1FAC:
		bsr.s	Pal_AddColor2_Yellow
		dbf	d0,@loc_1FAC
		moveq	#0,d0
		lea	Pal_Water_Active,a0
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
MapEni_SelbiSplash:	incbin	"Screens/SelbiSplash/Map_Selbi.eni"
			even
ArtKospM_SelbiSplash:	incbin	"Screens/SelbiSplash/Art_Selbi.kospm"
			even

BitmapMD_VDP:		incbin	"Screens/SelbiSplash/BitmapMD_VDP.bin"
BitmapMD_CRAM:		incbin	"Screens/SelbiSplash/BitmapMD_CRAM.bin"
BitmapMD_VRAM_Part1:	incbin	"Screens/SelbiSplash/BitmapMD_VRAM_Part1.kospm"
BitmapMD_VRAM_Part2:	incbin	"Screens/SelbiSplash/BitmapMD_VRAM_Part2.kosp"
			even
