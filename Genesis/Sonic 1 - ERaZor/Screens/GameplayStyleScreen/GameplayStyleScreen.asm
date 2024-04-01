; ===========================================================================
; ---------------------------------------------------------------------------
; Gameplay Style Screen (Casual Mode / Frantic Mode)
; ---------------------------------------------------------------------------
; ===========================================================================

GameplayStyleScreen:

		move.b	#$E0,d0
		jsr	PlaySound_Special		; fade out music
		jsr	ClearPLC			; clear PLCs
		jsr	Pal_FadeFrom			; fade out previous palette
		move	#$2700,sr

		lea	($C00004).l,a6			; Setup VDP
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

@ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1, @ClrObjRam
		
		move.l	#$40000000,($C00004).l		; load art
		lea	($C00000).l,a6
		lea	(Art_Difficulty).l,a0
		jsr	NemDec

		lea	(Map_Difficulty).l,a1		; load maps
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		lea	(Pal_Difficulty).l,a1		; load palette
		lea	($FFFFFB80).w,a2
		move.b	#8,d0
		
@PalLoopOHD:
		move.l	(a1)+,(a2)+
		dbf	d0,@PalLoopOHD

		jsr	Pal_FadeTo			; fade in

; ===========================================================================
; ---------------------------------------------------------------------------

; I HATE THIS CODE SO MUCH
GSS_MainLoop:
		move.b	#$4,($FFFFF62A).w
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

		jsr	SingleObjLoad
		bne.s 	@NoObject

		move.b	#$8B, 0(a1)
		move.w 	#$150, obX(a1)
		move.w 	#$A0, obScreenY(a1)

@NoObject:
		btst 	#0, ($FFFFF605).w	; is up being held?
		bne.s 	@PressedUp		; branch

		move.b 	#1, d0 				; frantic mode
		btst 	#1, ($FFFFF605).w	; is down being held?
		bne.s 	@PressedDown		; branch

		andi.b	#$80,($FFFFF605).w	; is Start button pressed?
		beq.s	GSS_MainLoop		; if not, branch
		
		bra.w 	@Exit
; ---------------------------------------------------------------------------

@PressedUp:
		btst 	#5, ($FFFFFF92).w 	; already pissbaby mode?
		beq.s 	@NoUpdateUp			; don't update

		move.w	#$D8, d0
		jsr		(PlaySound_Special).l ;	play "blip" sound

		move.w 	#$0EEE, ($FFFFFB06).w ; line 0:3 white
		move.w 	#$0666, ($FFFFFB08).w ; line 0:4 gray
		
		bclr 	#5, ($FFFFFF92).w 	; set to pissbaby mode

@NoUpdateUp:
		andi.b	#$80,($FFFFF605).w	; is Start button pressed?
		beq.s	GSS_MainLoop		; if not, branch

; ---------------------------------------------------------------------------

@PressedDown:
		btst 	#5, ($FFFFFF92).w 	; already frantic mode?
		bne.s 	@NoUpdateDown			; don't update

		move.w	#$D8, d0
		jsr		(PlaySound_Special).l ;	play "blip" sound
		
		move.w 	#$0666, ($FFFFFB06).w ; line 0:3 gray
		move.w 	#$0EEE, ($FFFFFB08).w ; line 0:4 white

		bset 	#5, ($FFFFFF92).w	; set to frantic mode

@NoUpdateDown:
		andi.b	#$80,($FFFFF605).w	; is Start button pressed?
		beq.w	GSS_MainLoop		; if not, branch

; ---------------------------------------------------------------------------

@Exit:
		move.w	#$C3,d0			; set giant ring sound
		jsr		PlaySound_Special	; play giant ring sound
		jsr 	WhiteFlash2
		jsr 	Pal_FadeFrom

		move.w  #$20, ($FFFFF614).w

@Wait:
		move.b	#$4, ($FFFFF62A).w
		jsr		DelayProgram

		tst.w 	($FFFFF614).w
		bne.s 	@Wait

		move.w	#$501,($FFFFFE10).w	; set level to FZ
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts

@rts:
	rts

; ---------------------------------------------------------------------------
; ===========================================================================

; ===========================================================================
Art_Difficulty:	incbin	"Screens/GameplayStyleScreen/Tiles_Difficulty.bin"
		even
Map_Difficulty:	incbin	"Screens/GameplayStyleScreen/Maps_Difficulty.bin"
		even
Pal_Difficulty:	incbin	"Screens/GameplayStyleScreen/Pal_Difficulty.bin"
		even
; ===========================================================================
