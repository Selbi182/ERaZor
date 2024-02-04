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
GSS_ClrObjRam:	move.l	d0,(a1)+
		dbf	d1,GSS_ClrObjRam
		
		move.l	#$40000000,($C00004).l		; load art
		lea	($C00000).l,a6
		lea	(Art_Difficulty).l,a1
		move.w	#$8A,d1
		jsr	LoadTiles

		lea	(Map_Difficulty).l,a1		; load maps
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		lea	(Pal_Difficulty).l,a1		; load palette
		lea	($FFFFFB80).w,a2
		move.b	#7,d0
GSS_PalLoopOHD:	move.l	(a1)+,(a2)+
		dbf	d0,GSS_PalLoopOHD

		jsr	Pal_FadeTo			; fade in

; ===========================================================================
; ---------------------------------------------------------------------------

GSS_MainLoop:
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		andi.b	#$80,($FFFFF605).w	; is Start button pressed?
		beq.s	GSS_MainLoop		; if not, branch

GSS_Exit:
		move.w	#$400,($FFFFFE10).w	; set level to FZ
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
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
