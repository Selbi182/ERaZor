; ===========================================================================
; ---------------------------------------------------------------------------
; Chapter Screens
; ---------------------------------------------------------------------------
; $FFFFFFA7
; 0: invalid / first launch of the game
; 1: Run To The Hills
; 2: Special Frustration
; 3: Inhuman Through The Ruins
; 4: Wet Pit Of Death
; 5: Something Underneath
; 6: Hover Into Your Frustration
; 7: Watch The Night Explode
; 8: In The End
; ---------------------------------------------------------------------------
Chapters_Total = 8
Chapters_TestAll = 0
; ---------------------------------------------------------------------------
; ===========================================================================

ChapterScreen:
		move.b	#$E0,d0
		jsr	PlaySound_Special		; fade out music

		jsr	PLC_ClearQueue			; Clear PLCs
		jsr	DrawBuffer_Clear
		jsr	Pal_FadeFrom			; Fade out previous palette
		VBlank_SetMusicOnly

		lea	VDP_Ctrl,a6			; Setup VDP
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen			; Clear screen
		display_disable

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
		move.l	#$40200000, VDP_Ctrl
		lea	ArtKospM_ChapterHeader, a0
		jsr	KosPlusMDec_VRAM

		lea	MapEni_ChapterHeader(pc), a0	; load chapter header
		lea	$FF0000, a1
		moveq	#1, d0
		jsr	EniDec
		lea	$FF0000,a1
		move.l	#$40000003,d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	ShowVDPGraphics

	; widescreen-only line extensions
	if def(__WIDESCREEN__)
		CS_LineChar: = $2C  ; mapping ID of the line - tipped versions are right before and after

		lea	VDP_Data,a6
		lea	VDP_Ctrl,a4
		move.l	#$407A0003|($800000*7),(a4)
		moveq	#2,d3
@lbonusline:	move.w	#CS_LineChar,(a6)
		dbf	d3,@lbonusline
		move.l	#$40000003|($800000*7),(a4) ; screen wrap happened, go one line up
		moveq	#2,d3
@lbonuslinex:	move.w	#CS_LineChar,(a6)
		dbf	d3,@lbonuslinex

		move.l	#$40480003|($800000*7),(a4)
		moveq	#6,d3
@rbonusline:	move.w	#CS_LineChar,(a6)
		dbf	d3,@rbonusline

		; final touches at the tips
		move.l	#$407A0003|($800000*7),(a4)
		move.w	#CS_LineChar-1,(a6)
		
		move.l	#$40540003|($800000*7),(a4)
		move.w	#CS_LineChar+1,(a6)
	endif

		lea	(Pal_ChapterHeader).l,a1	; load chapter 3 stuff instead
		lea	($FFFFFB80).w,a2
		move.b	#8-1,d0				; 16 colours
@palloop:	move.l	(a1)+,(a2)+
		dbf	d0,@palloop

		move.l	#$60000000, VDP_Ctrl
		lea	ArtKospM_Numbers, a0
		jsr	KosPlusMDec_VRAM
		VBlank_UnsetMusicOnly

		; load bottom half
		moveq	#0,d0
		move.b	(CurrentChapter).w,d0		; get set chapter ID
		beq.s	@invalid			; first start of the game
		bmi.s	@invalid			; corrupted
		cmpi.b	#Chapters_Total,d0		; is ID for some reason set beyond the limit?
		bhi.s	@invalid			; if yes, it's corrupted
		bra.s	@valid				; all good
@invalid:
		moveq	#1,d0				; ID is either corrupted or simply the first start. set number for chapter to 1
		move.b	d0,(CurrentChapter).w		; also update it in RAM

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
		move.b	#0,($FFFFD000+obRoutine).w	; set to init routine
		move.b	(CurrentChapter).w,($FFFFD000+obFrame).w ; set chapter number to frame (first frame in maps is duplicated)
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute

		display_enable

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
		move.l	#$45C00000, VDP_Ctrl
		movea.l	CS_ChapterArt(pc,d0.w), a0
		move.l	d0, -(sp)
		jsr	KosPlusMDec_VRAM
		move.l	(sp)+, d0
		rts

CS_ChapterArt:
		dc.l	ArtKospM_Chapter1
		dc.l	ArtKospM_Chapter2
		dc.l	ArtKospM_Chapter3
		dc.l	ArtKospM_Chapter4
		dc.l	ArtKospM_Chapter5
		dc.l	ArtKospM_Chapter6
		dc.l	ArtKospM_Chapter7
		dc.l	ArtKospM_Chapter8
; ===========================================================================

CS_LoadChapterMaps:
		move.l	d0,-(sp)
		movea.l	CS_ChapterMaps(pc,d0.w), a0
		lea	$FF0000, a1
		moveq	#1, d0
		jsr	EniDec
		lea	$FF0000, a1
		move.l	#$45800003, d0
		moveq	#40-1, d1
		moveq	#13-1, d2
		bsr	ShowVDPGraphics2
		move.l	(sp)+, d0
		rts

CS_ChapterMaps:
		dc.l	MapEni_Chapter1
		dc.l	MapEni_Chapter2
		dc.l	MapEni_Chapter3
		dc.l	MapEni_Chapter4
		dc.l	MapEni_Chapter5
		dc.l	MapEni_Chapter6
		dc.l	MapEni_Chapter7
		dc.l	MapEni_Chapter8
; ===========================================================================
		
CS_LoadChapterPal:
		movea.l	CS_ChapterPal(pc,d0.w),a1
		lea	($FFFFFBA0).w,a2
		rept	8
			move.l	(a1)+, (a2)+
		endr
		move.l	#0, d1
		rept	8*3
			move.l	d1, (a2)+
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
		dc.l	Pal_Chapter8

; ---------------------------------------------------------------------------
; ===========================================================================


; ===========================================================================
; ---------------------------------------------------------------------------

CS_OHDIGHZ:
		VBlank_SetMusicOnly
		move.l	#$40200000, VDP_Ctrl
		lea	ArtKospM_OHDIGHZ, a0
		jsr	KosPlusMDec_VRAM

		lea	MapEni_OHDIGHZ(pc), a0		; load chapter header
		lea	$FF0000, a1
		moveq	#1, d0
		jsr	EniDec
		lea	$FF0000, a1
		move.l	#$40000003,d0
		moveq	#40-1,d1
		moveq	#28-1,d2
		jsr	ShowVDPGraphics
		VBlank_UnsetMusicOnly

		lea	Pal_OHDIGHZ(pc), a1		; load palette
		lea	($FFFFFB80).w,a2
		moveq	#8-1,d0				; 16 colours
CS_PalLoopOHD:	move.l	(a1)+,(a2)+
		dbf	d0,CS_PalLoopOHD

		moveq	#8*3-1,d0
		moveq	#0,d1
CS_PalLoop1HD:	move.l	d1, (a2)+			; clear the rest of palette
		dbf	d0, CS_PalLoop1HD

		display_enable
		jsr	Pal_FadeTo

; ---------------------------------------------------------------------------

CS_SetupEndLoop:	
		move.w	#180,($FFFFF614).w	; set end wait time
CS_Loop:
		DeleteQueue_Init
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	DeleteQueue_Execute
		move.b	#2,VBlankRoutine
		jsr	DelayProgram
		tst.b	($FFFFF604).w		; is start HELD?
		bmi.s	CS_Exit			; if yes, immediately exit
		move.b	($FFFFF605).w,d1	; get button presses
		andi.b	#$70,d1			; is A, B, or C pressed?
		bne.s	CS_Exit			; if yes, branch
		tst.w	($FFFFF614).w		; test wait time
		bne.s	CS_Loop			; if it isn't over, loop
; ---------------------------------------------------------------------------

CS_Exit:
	if Chapters_TestAll=1
		addq.b	#1,(CurrentChapter).w	; go to next chapter ID
		jmp	ChapterScreen		; reload chapter screen
	endif
		jmp	Exit_ChapterScreen	; exit chapter screen

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
		move.w	#$80+SCREEN_WIDTH/2+3, obX(a0)	; set X-position
		move.w	#$D3, obScreenY(a0)		; set Y-position

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
		lea	VDP_Data,a6		; load VDP data port address to a6
		lea	VDP_Ctrl,a4		; load VDP control port address to a4
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
ArtKospM_ChapterHeader:	incbin	"Screens/ChapterScreens/Tiles_ChapterHeader.kospm"
			even
MapEni_ChapterHeader:	incbin	"Screens/ChapterScreens/Maps_ChapterHeader.eni"
			even
Pal_ChapterHeader:	incbin	"Screens/ChapterScreens/Palette_ChapterHeader.bin"
			even
; ---------------------------------------------------------------------------
ArtKospM_Chapter1:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter1.kospm"
		even
ArtKospM_Chapter2:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter2.kospm"
		even
ArtKospM_Chapter3:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter3.kospm"
		even
ArtKospM_Chapter4:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter4.kospm"
		even
ArtKospM_Chapter5:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter5.kospm"
		even
ArtKospM_Chapter6:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter6.kospm"
		even
ArtKospM_Chapter7:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter7.kospm"
		even
ArtKospM_Chapter8:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_Chapter8.kospm"
		even
; ---------------------------------------------------------------------------
MapEni_Chapter1:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter1.eni"
		even
MapEni_Chapter2:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter2.eni"
		even
MapEni_Chapter3:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter3.eni"
		even
MapEni_Chapter4:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter4.eni"
		even
MapEni_Chapter5:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter5.eni"
		even
MapEni_Chapter6:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter6.eni"
		even
MapEni_Chapter7:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter7.eni"
		even
MapEni_Chapter8:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_Chapter8.eni"
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
Pal_Chapter8:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_Chapter8.bin"
		even
; ---------------------------------------------------------------------------
ArtKospM_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Tiles_OHDIGHZ.kospm"
		even
MapEni_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Maps_OHDIGHZ.eni"
		even
Pal_OHDIGHZ:	incbin	"Screens/ChapterScreens/ChapterFiles/Palette_OHDIGHZ.bin"
		even
; ---------------------------------------------------------------------------
ArtKospM_Numbers:	incbin	"Screens/ChapterScreens/Art_Numbers.kospm"
		even
; ---------------------------------------------------------------------------
; ===========================================================================