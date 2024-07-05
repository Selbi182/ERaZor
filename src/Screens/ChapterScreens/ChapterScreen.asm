; ===========================================================================
; ---------------------------------------------------------------------------
; Chapter Screens
; ---------------------------------------------------------------------------
; $FFFFFFA7
; 0: first launch of the game
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
		jsr	PLC_ClearQueue			; Clear PLCs
		jsr	Pal_FadeFrom			; Fade out previous palette
		VBlank_SetMusicOnly

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
CS_ClrObjRam:	move.l	d0,(a1)+
		dbf	d1,CS_ClrObjRam
		VBlank_UnsetMusicOnly

		cmpi.w	#$001,($FFFFFE10).w		; is this the intro cutscene?
		beq.w	CS_OHDIGHZ			; if yes, go to alternate code

		; load top half
		VBlank_SetMusicOnly
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
@palloop:	move.l	(a1)+,(a2)+
		dbf	d0,@palloop

		move.l	#$60000000,($C00004).l
		lea	($C00000).l,a6
		lea	(Art_Numbers).l,a1
		move.w	#$E,d1
		jsr	LoadTiles
		VBlank_UnsetMusicOnly

		; load bottom half
		moveq	#0,d0
		move.b	($FFFFFFA7).w,d0		; get set chapter ID
		beq.s	@invalid			; first start of the game
		bmi.s	@invalid			; corrupted
		cmpi.b	#7,d0				; is ID for some reason set beyond the limit?
		bhi.s	@invalid			; if yes, it's corrupted
		bra.s	@valid				; all good
@invalid:
		moveq	#1,d0				; ID is either corrupted or simply the first start. set number for chapter to 1
		move.b	d0,($FFFFFFA7).w		; also update it in RAM

@valid:
		subq.b	#1,d0				; adjust for 0-based indexing
		add.w	d0,d0				; convert to long...
		add.w	d0,d0				; ...so that d0 now holds the index for the current chapter screen

		VBlank_SetMusicOnly
		bsr	CS_LoadChapterArt		; load art
		bsr	CS_LoadChapterMaps		; load maps
		bsr	CS_LoadChapterPal		; load palette
		VBlank_UnsetMusicOnly

		; load chapter number object
		move.b	#4,($FFFFD000).w		; load chapter numbers object (<-- past Selbi, why the fuck did you make this an object???)
		jsr	ObjectsLoad
		jsr	BuildSprites

		; double fade-in
		move.w	#$000F,($FFFFF626).w		; start at palette line 1, 16 colours ($F + 1)
		jsr	Pal_FadeTo2			; fade in upper part

		move.w	#$200F,($FFFFF626).w		; start at palette line 2, 16 colours ($F + 1)
		jsr	Pal_FadeTo2			; fade in lower part

		move.w	#$003F,($FFFFF626).w		; fix a really bad bug (<-- whatever that means, past Selbi)
		bra.w	CS_SetupEndLoop			; go to end wait loop

; ===========================================================================
; ---------------------------------------------------------------------------

CS_LoadChapterArt:
		movea.l	CS_ChapterArt(pc,d0.w),a1
		move.l	#$45A00000,($C00004).l		; Load art
		lea	($C00000).l,a6
		move.w	#$7C,d1				; load $7C tiles
		move.l	d0,-(sp)
		jsr	LoadTiles			; load tiles
		move.l	(sp)+,d0
		rts

CS_ChapterArt:
		dc.l	Art_Chapter1
		dc.l	Art_Chapter2
		dc.l	Art_Chapter3
		dc.l	Art_Chapter4
		dc.l	Art_Chapter5
		dc.l	Art_Chapter6
		dc.l	Art_Chapter7
; ===========================================================================

CS_LoadChapterMaps:
		movea.l	CS_ChapterMaps(pc,d0.w),a1
		move.l	d0,-(sp)
		move.l	#$44800003,d0
		moveq	#$27,d1
		moveq	#$12,d2
		bsr	ShowVDPGraphics2
		move.l	(sp)+,d0
		rts

CS_ChapterMaps:
		dc.l	Map_Chapter1
		dc.l	Map_Chapter2
		dc.l	Map_Chapter3
		dc.l	Map_Chapter4
		dc.l	Map_Chapter5
		dc.l	Map_Chapter6
		dc.l	Map_Chapter7
; ===========================================================================
		
CS_LoadChapterPal:
		movea.l	CS_ChapterPal(pc,d0.w),a1
		lea	($FFFFFBA0).w,a2
		rept	8
		move.l	(a1)+,(a2)+
		endr
		rts

CS_ChapterPal:
		dc.l	Pal_Chapter1
		dc.l	Pal_Chapter2
		dc.l	Pal_Chapter3
		dc.l	Pal_Chapter4
		dc.l	Pal_Chapter5
		dc.l	Pal_Chapter6
		dc.l	Pal_Chapter7

; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------

CS_OHDIGHZ:
		VBlank_SetMusicOnly
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
		VBlank_UnsetMusicOnly

		lea	(Pal_OHDIGHZ).l,a1		; load palette
		lea	($FFFFFB80).w,a2
		move.b	#7,d0				; 16 colours
CS_PalLoopOHD:	move.l	(a1)+,(a2)+
		dbf	d0,CS_PalLoopOHD

		jsr	Pal_FadeTo

; ---------------------------------------------------------------------------

CS_SetupEndLoop:	
		move.w	#$C0,($FFFFF614).w	; set wait time

		cmpi.w	#$001,($FFFFFE10).w	; is this the intro cutscene?
		beq.w	CS_Loop_OHDIGHZ		; if yes, go to a different loop
CS_Loop:
		jsr	ObjectsLoad
		jsr	BuildSprites
		move.b	#4,VBlankRoutine
		jsr	DelayProgram
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		bne.s	CS_Exit			; if yes, branch
		tst.w	($FFFFF614).w		; test wait time
		bne.s	CS_Loop			; if it isn't over, loop
; ---------------------------------------------------------------------------

CS_Exit:
		jmp	Exit_ChapterScreen	; return to main source
; ---------------------------------------------------------------------------
; ===========================================================================
; ---------------------------------------------------------------------------

CS_Loop_OHDIGHZ:
		cmpi.w	#$30,($FFFFF614).w	; wait $30 frames before starting the intro cutscene music
		beq.s	@ohdexit		; if time has passed, start intro

		jsr	ObjectsLoad
		jsr	BuildSprites
		move.b	#4,VBlankRoutine
		jsr	DelayProgram
		tst.w	($FFFFF614).w		; test wait time
		beq.s	@ohdexit		; if it it's over, exit
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$E0,d1			; is A, B, C, or start pressed?
		beq.s	CS_Loop_OHDIGHZ		; if not, loop
@ohdexit:
		jmp	Exit_OneHotDay		; start intro cutscene in main source

; ---------------------------------------------------------------------------
; ===========================================================================

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
; Modified version of ShowVDPGraphics which writes to the second palette row
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
; ---------------------------------------------------------------------------
; ===========================================================================