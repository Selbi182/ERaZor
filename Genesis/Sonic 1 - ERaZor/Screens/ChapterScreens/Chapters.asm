; ===========================================================================
; ---------------------------------------------------------------------------
; Chapter Screens
; ---------------------------------------------------------------------------
; $FFFFFFA7
; 1: Run To The Hills
; 2: Special Frustration
; 3: Inhuman Through The Ruins
; 4: Wet Pit Of Death
; 5: Hover Into Your Frustration
; 6: SLZ
; 7: In The End
; ---------------------------------------------------------------------------
; ===========================================================================

ChapterScreen:
		move.b	#$E0,d0
		jsr	PlaySound_Special		; fade out music
		jsr	ClearPLC			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette
	;	jsr	ClearVRAM
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
		jsr	ClearScreen			; Clear screen

		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

CS_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,CS_ClrObjRam
		
		cmpi.w	#$501,($FFFFFE10).w		; is this the tutorial?
		beq.s	CS_LoadIntroCutscene		; if yes, branch

		tst.b	($FFFFFFA7).w			; is chapter ID 0 (first start)?
		bne.s	CS_NotOHDIGHZ			; if not, branch

CS_LoadIntroCutscene:
		move.l	#$40000000,($C00004).l		; Load art
		lea	($C00000).l,a6
		lea	(Art_OHDIGHZ).l,a1		; load art
		move.w	#$8A,d1				; load $8A tiles
		jsr	LoadTiles			; load tiles

		lea	(Map_OHDIGHZ).l,a1		; load chapter header
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		lea	(Pal_OHDIGHZ).l,a1		; load chapter 3 stuff instead
		lea	($FFFFFB80).w,a2
		move.b	#7,d0				; 16 colours
CS_PalLoopOHD:
		move.l	(a1)+,(a2)+
		dbf	d0,CS_PalLoopOHD

		jsr	Pal_FadeTo

		bra.w	CS_SetUpLoop			; skip

; ===========================================================================
; ---------------------------------------------------------------------------

CS_NotOHDIGHZ:
		btst	#1,($FFFFFF92).w		; are story text screens enabled?
		beq.w	CS_EndLoop			; if not, auto-skip
		
		move.l	#$40000000,($C00004).l		; Load art
		lea	($C00000).l,a6
		lea	(Art_ChapterHeader).l,a1	; load chapter header
		move.w	#$2B,d1				; load 43 tiles
		jsr	LoadTiles			; load tiles

		lea	(Map_ChapterHeader).l,a1	; load chapter header
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$09,d2
		jsr	ShowVDPGraphics

		lea	(Pal_ChapterHeader).l,a1	; load chapter 3 stuff instead
		lea	($FFFFFB80).w,a2
		move.b	#7,d0				; 16 colours
CS_PalLoop1:
		move.l	(a1)+,(a2)+
		dbf	d0,CS_PalLoop1

; ---------------------------------------------------------------------------

		move.l	#$60000000,($C00004).l
		lea	($C00000).l,a6
		lea	(Art_Numbers).l,a1
		move.w	#$E,d1
		jsr	LoadTiles

		move.b	#4,($FFFFD000).w

		jsr	ObjectsLoad
		jsr	BuildSprites

; ---------------------------------------------------------------------------

		moveq	#0,d0
		move.b	($FFFFFFA7).w,d0
		subq	#1,d0
		add.b	d0,d0
		move.w	CS_Tiles_Index(pc,d0.w),d1
		jmp	CS_Tiles_Index(pc,d1.w)
; ===========================================================================
CS_Tiles_Index:	dc.w CS_Tiles1-CS_Tiles_Index
		dc.w CS_Tiles2-CS_Tiles_Index
		dc.w CS_Tiles3-CS_Tiles_Index
		dc.w CS_Tiles4-CS_Tiles_Index
		dc.w CS_Tiles5-CS_Tiles_Index
		dc.w CS_Tiles6-CS_Tiles_Index
		dc.w CS_Tiles7-CS_Tiles_Index
; ===========================================================================

CS_Tiles1:
		lea	(Art_Chapter1).l,a1		; load chapter 1
		bra.s	CS_Tiles_Load
CS_Tiles2:
		lea	(Art_Chapter2).l,a1		; load chapter 2
		bra.s	CS_Tiles_Load
CS_Tiles3:
		lea	(Art_Chapter3).l,a1		; load chapter 3
		bra.s	CS_Tiles_Load
CS_Tiles4:
		lea	(Art_Chapter4).l,a1		; load chapter 4
		bra.s	CS_Tiles_Load
CS_Tiles5:
		lea	(Art_Chapter5).l,a1		; load chapter 5
		bra.s	CS_Tiles_Load
CS_Tiles6:
		lea	(Art_Chapter6).l,a1		; load chapter 6
		bra.s	CS_Tiles_Load
CS_Tiles7:
		lea	(Art_Chapter7).l,a1		; load chapter 7

CS_Tiles_Load:
		move.l	#$45A00000,($C00004).l		; Load art
		lea	($C00000).l,a6
		move.w	#$7C,d1				; load $7C tiles
		jsr	LoadTiles			; load tiles

		lea	(Map_Chapter1).l,a1		; load chapter 1
		moveq	#0,d0				; clear d0
		move.b	($FFFFFFA7).w,d0		; get chapter ID
		subq	#1,d0
		mulu.w	#1520,d0			; multiply it by 1520 bytes
		adda.w	d0,a1				; add result to a1
		move.l	#$44800003,d0
		moveq	#$27,d1
		moveq	#$12,d2
		bsr	ShowVDPGraphics2

		lea	(Pal_Chapter1).l,a1		; load chapter 1 palette
		moveq	#0,d0				; clear d0
		move.b	($FFFFFFA7).w,d0		; get chapter ID
		subq	#1,d0
		mulu.w	#32,d0				; multiply it by 32 bytes
		adda.w	d0,a1				; add result to a1
		lea	($FFFFFBA0).w,a2
		move.b	#7,d0				; 16 colours
CS_PalLoop2:
		move.l	(a1)+,(a2)+
		dbf	d0,CS_PalLoop2
; ---------------------------------------------------------------------------

		move.w	#$000F,($FFFFF626).w		; start at palette line 1, 16 colours ($F + 1)
		jsr	Pal_FadeTo2
		move.w	#$200F,($FFFFF626).w		; start at palette line 2, 16 colours ($F + 1)
		jsr	Pal_FadeTo2
		move.w	#$003F,($FFFFF626).w		; fix a really bad bug

; ---------------------------------------------------------------------------
; ===========================================================================

CS_SetUpLoop:
		move.w	#$C0,($FFFFF614).w	; set wait time
		cmpi.w	#$501,($FFFFFE10).w	; is this the tutorial?
		beq.w	CS_Loop_OHDIGHZ		; if yes, go to a different loop

; ---------------------------------------------------------------------------
CS_Loop:
		jsr	ObjectsLoad
		jsr	BuildSprites
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		btst	#7,($FFFFF605).w	; is Start button pressed?
		bne.s	CS_EndLoop		; if yes, branch
		tst.w	($FFFFF614).w		; test wait time
		bne.s	CS_Loop			; if it isn't over, loop
; ---------------------------------------------------------------------------

CS_EndLoop:
		cmpi.w	#$001,($FFFFFE10).w	; is this the intro cutscene?
		bne.s	CS_NotIntro		; if not, branch
		move.w	#$400,($FFFFFE10).w	; set level to SYZ1
		bra.s 	CS_PlayLevel
		
CS_NotIntro:
		move.w	#$400,($FFFFFE10).w	; set level to SYZ1
		tst.b	($FFFFFF7D).w		; has chapters screen been entered through a giant ring SYZ?
		beq.s	CS_PlayLevel		; if not, branch

		cmpi.b	#2,($FFFFFFA7).w	; is this chapter 2?
		bne.s	CS_ChkChapter3		; if not, branch
		move.w	#$300,($FFFFFE10).w	; use correct stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts

CS_ChkChapter3:
		cmpi.b	#3,($FFFFFFA7).w	; is this chapter 3?
		bne.s	CS_ChkChapter4		; if not, branch
		move.w	#$200,($FFFFFE10).w	; set level to MZ1
		bra.s 	CS_PlayLevel

CS_ChkChapter4:
		cmpi.b	#4,($FFFFFFA7).w	; is this chapter 4?
		bne.s	CS_ChkChapter5		; if not, branch
		move.w	#$101,($FFFFFE10).w	; set level to LZ2
		bra.s 	CS_PlayLevel

CS_ChkChapter5:
		cmpi.b	#5,($FFFFFFA7).w	; is this chapter 5?
		bne.s	CS_ChkChapter6		; if not, branch
		move.w	#$401,($FFFFFE10).w	; use correct stage
		move.b	#$10,($FFFFF600).w	; set to special stage
		rts
CS_ChkChapter6:
		cmpi.b	#6,($FFFFFFA7).w	; is this chapter 6?
		bne.s	CS_ChkChapter7		; if not, branch
		move.w	#$500,($FFFFFE10).w	; set level to SBZ1
		bra.s 	CS_PlayLevel

CS_ChkChapter7:
		cmpi.b	#7,($FFFFFFA7).w	; is this chapter 7?
		bne.s	CS_PlayLevel		; if not, branch
		move.w	#$502,($FFFFFE10).w	; set level to FZ

CS_PlayLevel:
		move.b	#$C,($FFFFF600).w	; set to level
		move.w	#1,($FFFFFE02).w	; restart level
		rts
; ---------------------------------------------------------------------------
; ===========================================================================

CS_Loop_OHDIGHZ:
		cmpi.w	#$30,($FFFFF614).w	; wait $30 frames before starting the intro cutscene music
		bne.s	@nottutorial
@ohdighzstart:
		move.b	#$95,d0			; play intro cutscene music
		jsr	PlaySound
		move.w	#$001,($FFFFFE10).w	; load intro cutscene
		bra.w	CS_PlayLevel

@nottutorial:
		jsr	ObjectsLoad
		jsr	BuildSprites
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		btst	#7,($FFFFF605).w	; is Start button pressed?
		bne.s	@ohdighzstart		; if yes, branch
		tst.w	($FFFFF614).w		; test wait time
		bne.s	CS_Loop_OHDIGHZ		; if it isn't over, loop
		bra.s	@ohdighzstart
		
; ===========================================================================
; ---------------------------------------------------------------------------
; Object 04 - Chapter Numbers
; ---------------------------------------------------------------------------

Obj04:
		moveq	#0,d0			; clear d0
		move.b	$24(a0),d0		; move routine counter to d0
		move.w	Obj04_Index(pc,d0.w),d1 ; move the index to d1
		jmp	Obj04_Index(pc,d1.w)	; find out the current position in the index
; ===========================================================================
Obj04_Index:	dc.w Obj04_Setup-Obj04_Index	; Set up the object (art etc.)	[$0]
		dc.w Obj04_Display-Obj04_Index	; Display Sprite		[$2]
; ===========================================================================

Obj04_Setup:
		addq.b	#2,$24(a0)		; set to "Obj04_Display"
		move.l	#Map_Obj04,4(a0)	; load mappings
		move.b	#0,$18(a0)		; set priority
		move.b	#0,1(a0)		; set render flag
		move.w	#$0100,2(a0)		; set art tile, use first palette line
		move.w	#$123,8(a0)		; set X-position
		move.w	#$C5,$A(a0)		; set Y-position
		move.b	($FFFFFFA7).w,d0	; set chapter number to frame
		subq	#1,d0
		move.b	d0,$1A(a0)

Obj04_Display:
		jmp	DisplaySprite		; jump to DisplaySprite
; ===========================================================================

; ---------------------------------------------------------------------------
; Sprite mappings - Chapter Numbers
; ---------------------------------------------------------------------------

Map_Obj04:
		include	"Screens/ChapterScreens/Maps_Numbers.asm"
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
; Modifyed version of ShowVDPGraphics which writes to second palette row
; and goes $2D tiles further.
; ---------------------------------------------------------------------------

ShowVDPGraphics2:
		lea	($C00000).l,a6		; load VDP data port address to a6
		lea	($C00004).l,a4		; load VDP address port address to a4
		move.l	#$800000,d4		; prepare line add value

MapScreen2_Row:
		move.l	d0,(a4)			; set VDP to VRam write mode
		move.w	d1,d3			; reload number of columns

MapScreen2_Column:
		move.w	(a1)+,d6		; get data
		addi.w	#$202D,d6		; increase it by $202D
		move.w	d6,(a6)			; dump map to VDP map slot
		dbf	d3,MapScreen2_Column	; repeat til columns have dumped
		add.l	d4,d0			; increae to next row on VRam
		dbf	d2,MapScreen2_Row	; repeat til all rows have dumped
		rts				; return
; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------
Art_ChapterHeader:	incbin	"Screens/ChapterScreens/Tiles_ChapterHeader.bin"
			even
Map_ChapterHeader:	incbin	"Screens/ChapterScreens/Maps_ChapterHeader.bin"
			even
Pal_ChapterHeader:	incbin	"Screens/ChapterScreens/Palette_ChapterHeader.bin"
			even
; ---------------------------------------------------------------------------
Art_Chapter1:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter1.bin"
		even
Art_Chapter2:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter2.bin"
		even
Art_Chapter3:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter3.bin"
		even
Art_Chapter4:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter4.bin"
		even
Art_Chapter5:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter5.bin"
		even
Art_Chapter6:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter6.bin"
		even
Art_Chapter7:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter7.bin"
		even
; ---------------------------------------------------------------------------
Map_Chapter1:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter1.bin"
		even
Map_Chapter2:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter2.bin"
		even
Map_Chapter3:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter3.bin"
		even
Map_Chapter4:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter4.bin"
		even
Map_Chapter5:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter5.bin"
		even
Map_Chapter6:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter6.bin"
		even
Map_Chapter7:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter7.bin"
		even
; ---------------------------------------------------------------------------
Pal_Chapter1:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter1.bin"
		even
Pal_Chapter2:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter2.bin"
		even
Pal_Chapter3:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter3.bin"
		even
Pal_Chapter4:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter4.bin"
		even
Pal_Chapter5:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter5.bin"
		even
Pal_Chapter6:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter6.bin"
		even
Pal_Chapter7:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter7.bin"
		even
; ---------------------------------------------------------------------------
Art_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_OHDIGHZ.bin"
		even
Map_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_OHDIGHZ.bin"
		even
Pal_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_OHDIGHZ.bin"
		even
; ---------------------------------------------------------------------------
Art_Numbers:	incbin	"Screens/ChapterScreens/Art_Numbers.bin"
		even
; ===========================================================================