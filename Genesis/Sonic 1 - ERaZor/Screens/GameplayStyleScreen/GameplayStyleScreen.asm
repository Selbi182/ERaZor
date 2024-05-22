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
		moveq	#(128/4)-1,d0
		
@PalLoopOHD:
		move.l	(a1)+,(a2)+
		dbf	d0,@PalLoopOHD
		
		bsr	GSS_SetColor
		jsr	Pal_FadeTo			; fade in

		jsr	SingleObjLoad
		bne.s 	GSS_MainLoop			; load star object
		move.b	#$8B,0(a1)
		bra.s	GSS_MainLoop

; ===========================================================================
; ---------------------------------------------------------------------------
GSS_SetColor:
		moveq	#0,d2
		moveq	#0,d3
		move.w	#$0EEE,d2
		move.w	#$0666,d3
		btst 	#5,($FFFFFF92).w 
		beq.s	@cont
		exg.l	d2,d3
@cont:
		move.w 	d2,($FFFFFB06).w ; line 0:3 white
		move.w 	d2,($FFFFFB86).w ; line 0:3 white
		move.w 	d3,($FFFFFB08).w ; line 0:4 gray
		move.w 	d3,($FFFFFB88).w ; line 0:4 gray
		rts
; ---------------------------------------------------------------------------

; I HATE THIS CODE SO MUCH
GSS_MainLoop:
		move.b	#$4,($FFFFF62A).w
		jsr	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites

		move.b	($FFFFF605).w,d1	; get button presses
	 	andi.b	#$7F,d1			; is anything but start pressed?
		beq.s	@NoUpdate		; if not, branch
		bchg 	#5,($FFFFFF92).w 	; toggle casual/frantic flag
		bsr	GSS_SetColor
		move.w	#$D8,d0
		jsr	(PlaySound_Special).l	; play "blip" sound

@NoUpdate:
		andi.b	#$80,($FFFFF605).w	; is Start button pressed?
		beq.s	GSS_MainLoop		; if not, branch

; ---------------------------------------------------------------------------

@Exit:
		move.w	#$C3,d0			; set giant ring sound
		jsr	PlaySound_Special	; play giant ring sound
		jsr 	WhiteFlash2
		jsr 	Pal_FadeFrom

		move.w  #$20, ($FFFFF614).w

@Wait:
		move.b	#$4, ($FFFFF62A).w
		jsr	DelayProgram

		tst.w 	($FFFFF614).w
		bne.s 	@Wait
		
		cmpi.w	#3,($FFFFFF82).w	; did we come from the options menu?
		bne.s	@StartTutorial		; if not, start tutorial
		move.b	#$24,($FFFFF600).w	; otherwise return to options menu
		rts

@StartTutorial:
		move.w	#$501,($FFFFFE10).w	; set level to FZ
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level

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
