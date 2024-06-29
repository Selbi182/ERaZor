; ===============================================================
; ---------------------------------------------------------------
; Program to display hints in tutorial zone
; (c) 2012, Vladikcomper
; ---------------------------------------------------------------
; INPUT:
;	d0	- Hint ID
; ---------------------------------------------------------------

; ---------------------------------------------------------------
; Program Setup
; ---------------------------------------------------------------

_DH_BG_Pattern		= $BBBBBBBB		; tile pattern for hint's BG
_DH_BG_Pattern_2	= $B			;
_DH_VRAM_Base		= $5800			; base VRAM address for display window
_DH_VRAM_Border		= $5700			; VRAM address for window border
_DH_WindowObj		= $FFFFD400		; address for window object        
_DH_WindowObj_Art	= _DH_VRAM_Border/$20	; art pointer for window object

; ---------------------------------------------------------------
; Constants
; ---------------------------------------------------------------

; Objects

render		equ	1
art		equ	2
maps		equ	4
Xvel		equ	$10
Yvel		equ	$12
height		equ	$16
width		equ	$17
layer		equ	$18
visible_width	equ	$19
frame		equ	$1A
anim		equ	$1C
obj		equ	$3C	; Object code offset

; VRAM flags
pri	equ	$8000
tutpal0	equ	0
tutpal1	equ	1<<13
tutpal2	equ	2<<13
tutpal3	equ	3<<13

; You can use these flags to make it cooler:
_br	= $00	; line break flags
_font2	= $01	; will make the next character use palette line 2 for the font
_frantic = $FB	; will act as _end in casual and _pause in frantic
_delay	= $FC	; set delay (given in the next byte)
_pause	= $FD	; wait player to press A/B/C button
_cls	= $FE	; clear window
_end	= $FF	; finish hint

; ===============================================================

Tutorial_DisplayHint:
	movem.l	a0/a5-a6,-(sp)
	move.b	d0,($FFFFFF6E).w
	
	; Setup registers for constant use
	lea	VDP_Ctrl,a6           
	lea	VDP_Data,a5

	; Init objects
 	lea	_DH_WindowObj,a0
 	move.w	d0,-(sp)
	jsr	DeleteObject			; clear slot
	move.w	(sp)+,d0
	move.l	#DH_OWindow_Init,obj(a0)
	lea	Hints_List,a1
	andi.w	#$FF,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-4(a1,d0.w),char_pos(a0)	; load hint text

	; Init hint window gfx
	move.b	#8,VBlankRoutine
	jsr	DelayProgram			; perform vsync before operation, fix Sonic's DPCL
	VBlank_SetMusicOnly			; disable interrupts
	ints_push
	bsr	DH_ClearWindow			; draw window
	lea	Art_DH_WindowBorder,a1		; load border art
	vram	_DH_VRAM_Border,(a6)
	moveq	#7,d0				; transfer 8 tiles
@0	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
   	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	dbf	d0,@0
	ints_pop
	VBlank_UnsetMusicOnly

	cmpi.b	#10,($FFFFFF6E).w	; is this the introduction text?
	bne.s	DH_MainLoop		; if not, branch
	jsr	BGDeformation_Setup
	lea	VDP_Ctrl,a6   
	lea	VDP_Data,a5

; ---------------------------------------------------------------
; Display Hint Main Loop
; ---------------------------------------------------------------

DH_MainLoop:
	move.b	#2,VBlankRoutine
	jsr	DelayProgram

	cmpi.b	#10,($FFFFFF6E).w	; is this the introduction text?
	bne.s	DH_NormalDeform		; if not, branch
	jsr	Options_BackgroundEffects
	bra.w	DH_Continue

DH_NormalDeform:
	; background deformation during a level
	lea	($FFFFCC00).w,a1
	move.w	#(224/1)-1,d3
	jsr	RandomNumber
@scroll:
	ror.l	#1,d1
	move.l	d1,d2
	andi.l	#$00070000,d2
	
	moveq	#0,d0
	moveq	#0,d4
	move.w	($FFFFFE0E).w,d0	; get timer
	swap	d0
	btst	#0,d3
	beq.s	@1
	neg.l	d0
@1:
	andi.l	#$0000FFFF,d0
	swap	d0
	add.w	($FFFFFE0E).w,d0 ; scroll everything to the right
	btst	#0,d5
	beq.s	@3
	sub.w	($FFFFFE0E).w,d0 ; scroll everything to the right

@3:
	move.w	d0,d4		; copy scroll
	add.w	d3,d4		; add line index
	subi.w	#224/2,d4
	movem.l	d0/d1,-(sp)
	move.w	d4,d0
	jsr	CalcSine
	
	move.w	d3,d5
	add.w	($FFFFFE0E).w,d5
	btst	#7,d5
;	beq.s	@2
	neg.w	d0
@2:
	move.w	d0,d4
	
	movem.l	(sp)+,d0/d1
	add.w	d4,d0
	swap	d0
	or.l	d0,d2
	move.l	d2,d4
	swap	d4
	add.l	d4,d2
	move.l	d2,(a1)+
	dbf	d3,@scroll ; fill scroll data with 0

DH_Continue:
	; Run window object code
	lea	_DH_WindowObj,a0
	movea.l	obj(a0),a1
	jsr	(a1)		; run window object

	; Display other objects
	lea	Objects,a0
	moveq	#$7F,d7
	jsr	loc_D368
	jsr	BuildSprites
	jsr	PalCycle_Load

	; palette cycle to highlight letters
	cmpi.b	#4,($FFFFFE10).w	; are we in uberhub?
	beq.s	@noletterflashing	; if yes, branch
	move.w	($FFFFFE0E).w,d0
	lsl.w	#4,d0
	jsr	CalcSine
	cmpi.w	#$100,d0
	bne.s	@contff
	subq.w	#1,d0		
@contff:
	addi.w	#$100,d0
	lsr.w	#6,d0
	andi.w	#$00E,d0
	move.w	d0,d1
	rol.w	#4,d1
	or.w	d1,d0
	rol.w	#4,d1
	or.w	d1,d0
	move.w	d0,(a1)
	move.w	d0,($FFFFFB34).w
	
@noletterflashing:
	; Check if it's over
	tst.b	_DH_WindowObj	; object window dead?
	bne.w	DH_MainLoop	; if not, branch

; ---------------------------------------------------------------
; Return to the game
; ---------------------------------------------------------------

DH_Quit:
	movem.l	(sp)+,a0/a5-a6
	clr.b	($FFFFFF6E).w
	
	; Display objects one final time
	lea	Objects,a0
	moveq	#$7F,d7
	jsr	loc_D368
	moveq	#0, d7				; short circuit ObjectsLoad if we're there
	rts

; ---------------------------------------------------------------
; Clear/Redraw text window
; ---------------------------------------------------------------

DH_ClearWindow:
	VBlank_SetMusicOnly
	vram	_DH_VRAM_Base,(a6)
	move.l	#_DH_BG_Pattern,d0
	move.w	#$A0-1,d1	; do $A0 tiles

@DrawTile:
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	dbf	d1,@DrawTile
	VBlank_UnsetMusicOnly
	rts

; ---------------------------------------------------------------
; Draw Character in the window
; ---------------------------------------------------------------
; INPUT:
;	d0.w	= Char
; ---------------------------------------------------------------
DH_CharOffset = $36

DH_DrawChar:
	lea	(Art_DH_Font).l,a2
	cmpi.b	#_font2,d0
	bne.s	@0
	lea	(Art_DH_Font2).l,a2
	move.b	(a1)+,d0		; skip char
	addq.l	#1,char_pos(a0)		; increase it
@0:
	subi.b	#DH_CharOffset,d0
	lsl.w	#5,d0			; d0 = Char*$20
	lea	(a2,d0.w),a2		; load this char's art 

InitDraw:  
	moveq	#$F,d3			; d3 = Pixel Mask
	moveq	#_DH_BG_Pattern_2,d4	; d4 = BG color
	moveq	#7,d5

@DrawLine:
	moveq	#7,d2
	move.l	(a2)+,d0		; load 8 px

@CheckPixel:
	move.b	d0,d1			; load line pattern
	and.b	d3,d1			; check out first pixel
	beq.s	@0			; if it's transparent, branch
	ror.l	#4,d0			; rotate 1 px
	dbf	d2,@CheckPixel		; repeat for 8 pixels
	bra.s	@1

@0	or.b	d4,d0			; replace transparent pixel with BG color
	ror.l	#4,d0			; rotate 1 px
	dbf	d2,@CheckPixel		; repeat for 8 pixels

@1	move.l	d0,(a5)			; send 8 px line to VRAM
	dbf	d5,@DrawLine		; repeat for 8 lines
	
	rts


; ===============================================================
; ---------------------------------------------------------------
; Object: Hint Window
; ---------------------------------------------------------------

xpos	= 8
ypos	= $A
xpos2	= $14

_StartVel = $1400
_Accel = $B8

DH_OWindow_Init:
	st.b	(a0)				; mark slot busy
	move.b	#$80,render(a0)			; set on-screen coords, force disp
	move.w	#(_DH_WindowObj_Art)+pri+tutpal1,art(a0)
	move.l	#DH_WindowObj_Map,maps(a0)
	moveq	#4,d0
	swap	d0
	move.l	d0,xpos2(a0)			; xpos
	move.w	#$80+224/2,ypos(a0)		; ypos
	move.w	#_StartVel,xvel(a0)		; xvel
	move.l	#DH_OWindow_Appear,obj(a0)

; ---------------------------------------------------------------

DH_OWindow_Appear:
	move.w	xvel(a0),d0		; load xvel
	sub.w	#_Accel,xvel(a0)	; decrease it
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,xpos2(a0)		; calc new xpos
	move.w	xpos2(a0),xpos(a0)	; update actual xpos
	move.w	#$80+320/2,d0
	cmp.w	xpos(a0),d0		; have we reaches screen center?
	ble.s	@GotoProcess		; if yes, branch
	rts
	
@GotoProcess:
	move.w	d0,xpos(a0)		; fix x-pos
	move.l	#DH_OWindow_Process,obj(a0)

; ---------------------------------------------------------------
; Hint window processing code
; ---------------------------------------------------------------
; INPUT:
;	a4	= Hint Text Data
; ---------------------------------------------------------------

DH_OWindow_Process:


vram_pos	equ	$20	; l
row		equ	$24	; w
delay		equ	$26	; w
char_pos	equ	$28	; l
cooldown	equ	$30	; w

_DelayVal	= 0
_DelayVal_Sh	= 0
_CooldownVal	= 2

	move.l	#@ProcessChar,obj(a0)	; set main routine
	move.w	#_DelayVal,delay(a0)	; set delay
	move.w	#0,row(a0)		; start from the first row
	move.w	#_CooldownVal,cooldown(a0) ; set cooldown between screens
	bra.w	@LoadRow

; ---------------------------------------------------------------
@InstantWrite:
	VBlank_SetMusicOnly		; we *must* disable interrupts
	movea.l	char_pos(a0),a1		; load last position in text

@InstantWrite_Loop:
	moveq	#0,d0
	move.b	(a1)+,d0		; get a char
	beq	@Call_LoadNextRow	; --
	bmi.s	@InstantWrite_Flags	; --
	cmpi.b	#' ',d0			; --
	beq.s	@FF			; --
	move.l	vram_pos(a0),(a6)	; setup VDP access
	bsr	DH_DrawChar		; draw da char
@FF	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	bra.s	@InstantWrite_Loop

@InstantWrite_Flags:
	cmpi.b	#_delay,d0
	beq.s	@InstantWrite_SkipDelay	; if flag = '_delay', branch
	cmpi.b	#_pause,d0
	bne.s	@InstantWrite_Loop	; if flag != '_pause', ignore
	subq.w	#1,a1			; position of '_pause' flag
	move.l	a1,char_pos(a0)		; remember position
	VBlank_UnsetMusicOnly
	rts				; finish loop
	
@InstantWrite_SkipDelay:
	addq.w	#1,a1			; skip delay value
	bra	@InstantWrite_Loop

@Call_LoadNextRow:
	pea	@InstantWrite_Loop
	bra.w	@LoadNextRow

; ---------------------------------------------------------------
@ProcessChar:
	move.b	Joypad|Press,d0
	andi.b	#A+B+C+START,d0		; A/B/C/START pressed?
	beq.s	@ContinueChar		; if not, branch
	tst.w	cooldown(a0)		; is cooldown over?
	beq	@InstantWrite		; if yes, immediately write the whole screen

@ContinueChar:
	tst.w	cooldown(a0)		; is cooldown over?
	beq.s	@CooldownEmpty		; if yes, branch
	subq.w	#1,cooldown(a0)		; reduce 1 from cooldown
	
@CooldownEmpty:
	subq.w	#1,delay(a0)		; decrease delay counter
	bpl.w	@Return			; if time remains, branch

	move.w	#_DelayVal,delay(a0)	; restore delay
	move.b	Joypad|Held,d0
	andi.b	#A+B+C+Start,d0		; A/B/C/Start held?
	beq.s	@Retry			; if not, branch
	move.w	#_DelayVal_Sh,delay(a0)	; restore short delay

@Retry:
	movea.l	char_pos(a0),a1		; load last position in text
	addq.l	#1,char_pos(a0)		; increase it
	moveq	#0,d0
	move.b	(a1)+,d0		; load char
	beq	@LoadNextRow		; -- if line break flag, branch
	bmi	@CheckFlags		; -- if special flag, branch
	cmpi.b	#' ',d0			; -- is it a space?
	beq	@0			; -- if yes, don't draw, don't play sound
	VBlank_SetMusicOnly
	move.l	vram_pos(a0),(a6)	; setup VDP access
	bsr	DH_DrawChar		; draw da char
	VBlank_UnsetMusicOnly
	moveq	#$FFFFFFD8,d0
	jsr	PlaySound
	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	rts

@0	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	bra	@Retry

@CheckFlags:
	addq.b	#1,d0
	beq.w	@GotoDisappear		; if flag = '_end', branch
	addq.b	#1,d0
	beq.w	@ClearWindow		; if flag = '_cls', branch
	addq.b	#1,d0
	beq.s	@DoPause		; if flag = '_pause', branch
	addq.b	#1,d0
	beq.s	@DoDelay		; if flag = '_delay', branch
					; assume it's flag '_frantic' then

@FranticTextCheck:
	frantic				; is frantic mode enabled?
	bne.s	@ClearWindow		; if yes, make _frantic act like _cls
	bra.w	@GotoDisappear		; in casual, make it act like _end

; ---------------------------------------------------------------
@DoDelay:
	move.b	(a1),d0
	move.w	d0,delay(a0)		; setup new delay
	addq.l	#1,char_pos(a0)		; skip a char
	rts

; ---------------------------------------------------------------
@DoPause:
	move.l	#@PauseLoop,obj(a0)

	; blinking cursor in bottom right while screen is waiting for input
	lea	(Art_DH_Font+$120).l,a2
	vram	_DH_VRAM_Base+$13E0,(a6)
	bsr	InitDraw
	move.b	#$20,$32(a0)
	move.b	#0,$33(a0)
@PauseLoop:
	subq.b	#1,$32(a0)
	bpl.s	@cont
	move.b	#$20,$32(a0)
	lea	(Art_DH_Font).l,a2
	bchg	#0,$33(a0)
	beq.s	@cont2
	adda.w	#$120,a2
@cont2:
	vram	_DH_VRAM_Base+$13E0,(a6)
	bsr	InitDraw

@cont:
	move.b	Joypad|Press,d0
	andi.b	#A+B+C+Start,d0		; A/B/C/Start pressed?
	beq.s	@Return			; if not, branch
	move.l	#@ProcessChar,obj(a0)	; set main routine
	move.w	#_CooldownVal,cooldown(a0) ; set cooldown between screens
	moveq	#$FFFFFFD9,d0
	jmp	PlaySound

; ---------------------------------------------------------------
@ClearWindow:
	jsr	DH_ClearWindow
	move.w	#0,row(a0)		; reset row
	bra.s	@LoadRow		; reload row

@LoadNextRow:
	addq.w	#4,row(a0)

@LoadRow:
	move.w	row(a0),d0
	move.l	@RowPointers(pc,d0.w),vram_pos(a0)

@Return:
	rts

; ---------------------------------------------------------------
@RowPointers:
	DCvram	(_DH_VRAM_Base+$0000)	; $00
	DCvram	(_DH_VRAM_Base+$0020)	; $04
	DCvram	(_DH_VRAM_Base+$0040)	; $08
	DCvram	(_DH_VRAM_Base+$0060)	; $0C
	DCvram	(_DH_VRAM_Base+$0A00)	; $10
	DCvram	(_DH_VRAM_Base+$0A20)	; $14
	DCvram	(_DH_VRAM_Base+$0A40)	; $18
	DCvram	(_DH_VRAM_Base+$0A60)	; $1C

; ---------------------------------------------------------------

@GotoDisappear:
	move.l	#DH_OWindow_Disappear,obj(a0)
	move.w	#0,xvel(a0)

; ---------------------------------------------------------------

DH_OWindow_Disappear:
	move.w	xvel(a0),d0		; load xvel
	add.w	#_Accel,xvel(a0)	; increase it
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,xpos2(a0)		; calc new xpos
	move.w	xpos2(a0),xpos(a0)	; update actual xpos
	move.w	#$80+320+$50,d0
	cmp.w	xpos(a0),d0		; have we passed screen?
	bgt.s	@NoKill			; if not, branch
	sf.b	(a0)			; kill windows

@NoKill:
	rts



; ===============================================================

DH_WindowObj_Map:
	dc.w	2

_TT	= $08	; window base tile index
_Xdisp	= -$50	; x displacement
_Ydisp 	= -$20	; y displacement
fh	= 1<<3
fv	= 2<<3
fhv	= 3<<3

	dc.b	(@1-@0)/5

@0	;	 Y-pos	     WWHH	 Tile	  X-pos
	dc.b	_Ydisp+$00, %1111, $00, _TT+$00, _Xdisp+$00	; r0
	dc.b	_Ydisp+$00, %1111, $00, _TT+$10, _Xdisp+$20
	dc.b	_Ydisp+$00, %1111, $00, _TT+$20, _Xdisp+$40
	dc.b	_Ydisp+$00, %1111, $00, _TT+$30, _Xdisp+$60
	dc.b	_Ydisp+$00, %1111, $00, _TT+$40, _Xdisp+$80
	dc.b	_Ydisp+$20, %1111, $00, _TT+$50, _Xdisp+$00	; r1
	dc.b	_Ydisp+$20, %1111, $00, _TT+$60, _Xdisp+$20
	dc.b	_Ydisp+$20, %1111, $00, _TT+$70, _Xdisp+$40
	dc.b	_Ydisp+$20, %1111, $00, _TT+$80, _Xdisp+$60
	dc.b	_Ydisp+$20, %1111, $00, _TT+$90, _Xdisp+$80
	dc.b	_Ydisp-$08, %0011, $00, $00,	 _Xdisp-$08	; b-left
	dc.b	_Ydisp+$18, %0001, $00, $01,	 _Xdisp-$08
	dc.b	_Ydisp+$28, %0011, fv,	$00,	 _Xdisp-$08
	dc.b	_Ydisp-$08, %1100, $00, $04,	 _Xdisp+$00	; b-top
	dc.b	_Ydisp-$08, %1100, $00,	$04,	 _Xdisp+$20
	dc.b	_Ydisp-$08, %1100, $00,	$04,	 _Xdisp+$40
	dc.b	_Ydisp-$08, %1100, $00,	$04,	 _Xdisp+$60
	dc.b	_Ydisp-$08, %1100, $00,	$04,	 _Xdisp+$80
	dc.b	_Ydisp-$08, %0011, fh,	$00,	 _Xdisp+$A0	; b-right
	dc.b	_Ydisp+$18, %0001, fh,	$01,	 _Xdisp+$A0
	dc.b	_Ydisp+$28, %0011, fhv,	$00,	 _Xdisp+$A0
	dc.b	_Ydisp+$40, %1100, fv,	$04,	 _Xdisp+$00	; b-bot
	dc.b	_Ydisp+$40, %1100, fv,	$04,	 _Xdisp+$20
	dc.b	_Ydisp+$40, %1100, fv,	$04,	 _Xdisp+$40
	dc.b	_Ydisp+$40, %1100, fv,	$04,	 _Xdisp+$60
	dc.b	_Ydisp+$40, %1100, fv,	$04,	 _Xdisp+$80
@1

	even

; ===============================================================

Art_DH_WindowBorder:
	incbin	'Screens/TutorialBox/TutorialBox_Art.bin'

Art_DH_Font:
	incbin	'Screens/TutorialBox/TutorialBox_Font.bin'

Art_DH_Font2:
	incbin	'Screens/TutorialBox/TutorialBox_Font2.bin'

; ===============================================================
; ---------------------------------------------------------------
; Hints Pointer List
; ---------------------------------------------------------------

Hints_List:
	dc.l	Hint_1
	dc.l	Hint_2
	dc.l	Hint_3
	dc.l	Hint_4
	dc.l	Hint_FZEscape
	dc.l	Hint_6
	dc.l	Hint_7
	dc.l	Hint_8
	dc.l	Hint_9
	dc.l	Hint_Pre
	dc.l	Hint_Easter_Tutorial
	dc.l	Hint_Easter_SLZ
	dc.l	Hint_TutorialConclusion
	dc.l	Hint_Easter_Tutorial_Escape
	dc.l	Hint_End_AfterCasual
	dc.l	Hint_End_AfterFrantic
	dc.l	Hint_End_CinematicUnlock
	dc.l	Hint_End_BlackoutTeaser

; ---------------------------------------------------------------
; Hints Scripts
; ---------------------------------------------------------------

; Macro to preprocess and output a character to its correct mapping
mapchar macro char
	if     \char = "'"
		dc.b	$2+DH_CharOffset
	elseif \char = '#'
		dc.b	_font2, $2+DH_CharOffset
	elseif \char = '.'
		dc.b	$26+DH_CharOffset
	elseif \char = ':'
		dc.b	_font2, $26+DH_CharOffset
	elseif \char = ','
		dc.b	$27+DH_CharOffset
	elseif \char = ';'
		dc.b	_font2, $27+DH_CharOffset
	elseif \char = '/'
		dc.b	$8+DH_CharOffset
	elseif \char = '!'
		dc.b	$A+DH_CharOffset
	elseif \char = '1'
		dc.b	_font2, $A+DH_CharOffset
	elseif \char = '-'
		dc.b	$25+DH_CharOffset
	elseif \char = '_'
		dc.b	_font2, $25+DH_CharOffset
	elseif \char = '&'
		dc.b	_font2, $29+DH_CharOffset
	elseif \char = '+'
		dc.b	$29+DH_CharOffset
	elseif \char = '~'
		dc.b	_font2, $1+DH_CharOffset
	elseif \char = '^'
		dc.b	_font2, $5+DH_CharOffset
	elseif (\char >= 'a') & (\char <= 'z')
		dc.b	_font2, \char-$20
	elseif \char = '?'
		dc.b	$28+DH_CharOffset
	else
		dc.b	\char
	endif
	endm
 
boxtxt macro string
	i:   = 1
	len: = strlen(\string)
	if (len>20)
		inform 1, 'line too long'
	endif

	while (i<=len)
		char:	substr i,i,\string
		mapchar '\char'
		i: = i+1
	endw
	
	dc.b _br
	endm

boxtxt_line macro
	dc.b	_br
	endm
boxtxt_pause macro
	dc.b	_br,_pause
	endm
boxtxt_next macro
	dc.b	_pause,_cls
	endm
boxtxt_end macro
	dc.b	_pause,_end
	endm

; ---------------------------------------------------------------
Hint_Null:
	boxtxt	"you shouldn#t be"
	boxtxt	"able to read this"
	boxtxt	"lol"
	boxtxt_end

;		 --------------------
Hint_Pre:
	boxtxt	"HELLO AND WELCOME TO"
	boxtxt_line
	boxtxt	"    sonic erazor"
	boxtxt_line
	dc.b	_delay,10
	boxtxt	"THE WILDEST JOURNEY"
	boxtxt	"YOU'LL EVER TAKE"
	boxtxt	"WITH YOUR FAVORITE"
	boxtxt	"BLUE HEDGEHOG!"
	boxtxt_next
	
	boxtxt	"YOU WILL REVISIT"
	boxtxt	"THE FIRST SONIC GAME"
	boxtxt	"THROUGH THE LENS OF"
	boxtxt	"AN ACTION MOVIE."
	boxtxt_line
	boxtxt	"FAST MOVEMENT,"
	boxtxt	"TOUGH CHALLENGES,"
	boxtxt	"AND explosions."
	boxtxt_next

	boxtxt	"BECAUSE TEARS OF"
	boxtxt	"FRUSTRATION SHOULD"
	boxtxt	"BE KEPT TO A MINIMUM"
	boxtxt	"AT ALL TIMES, THE"
	boxtxt	"FOLLOWING STAGE WILL"
	boxtxt	"TEACH YOU SOME OF"
	boxtxt	"THIS GAME'S"
	boxtxt	"REQUIRED BASICS."
	boxtxt_next

	boxtxt	"POSITION YOURSELF"
	boxtxt	"IN FRONT OF THE"
	boxtxt	"INFORMATION MONITORS"
	boxtxt	"AND PRESS a TO BRING"
	boxtxt	"UP USEFUL TIPS!"
	boxtxt_next

	boxtxt_line
	boxtxt_line
	boxtxt	"   ALRIGHT THEN,"
	dc.b	_delay,10
	boxtxt_line
	boxtxt_line
	boxtxt	"     let#s go1"
	boxtxt_end

;		 --------------------
Hint_1:
	boxtxt	"HI, AND WELCOME TO"
	boxtxt	"THE tutorial!"
	boxtxt_pause
	boxtxt	"WE'LL TAKE IT EASY,"
	boxtxt	"SINCE THERE IS"
	boxtxt	"ABSOLUTELY"
	boxtxt	"NO RUSH AT ALL."
	boxtxt_next

	boxtxt	"CONTROLS - grounded"
	boxtxt_pause
	boxtxt	" SPIN DASH"
	boxtxt	" ~ + a/b/c"
	boxtxt_line
	boxtxt	" SUPER PEEL OUT"
	boxtxt	" ^ + a"
	boxtxt_next

	boxtxt	"AND TO JUMP, YOU"
	boxtxt	"HAVE TO PRESS-"
	boxtxt_pause
	boxtxt	"...NEVER MIND."
	boxtxt_end

;		 --------------------
Hint_2:
	boxtxt	"CONTROLS - airborne"
	boxtxt_pause
	boxtxt	" c - JUMP DASH"
	boxtxt	"     HOMING ATTACK"
	boxtxt_line
	boxtxt	" b - DOUBLE JUMP"
	boxtxt_pause
	boxtxt	" a - YOU'LL SEE..."
	boxtxt_end

;		 --------------------
Hint_3:
	boxtxt	"inhuman mode"
	boxtxt_pause
	boxtxt	"PRESS a TO FIRE AN"
	boxtxt	"EXPLODING BULLET"
	boxtxt	"YOU CAN PROPEL"
	boxtxt	"YOURSELF IN THE AIR"
	boxtxt	"WITH!"
	boxtxt_next

	boxtxt	"ALSO, YOU ARE FULLY"
	boxtxt	"INVINCIBLE TO"
	boxtxt	"EVERYTHING!"
	boxtxt_pause
	boxtxt	"...EXCEPT SPIKES."
	boxtxt_pause

	dc.b	_frantic
	boxtxt	"    frantic mode"
	boxtxt_pause
	boxtxt	" THE FLOOR IS LAVA! "
	boxtxt_pause
	boxtxt	"AND THE LAVA HUNGERS"
	boxtxt	"FOR YOUR RINGS UNTIL"
	boxtxt	"      YOU DIE.      "
	boxtxt_end

;		 --------------------
Hint_4:
	boxtxt	"0Adw193q4HG5!'%q6/%4"
	boxtxt	"8ETRqZ91/D' we03()a)"
	boxtxt	"( B)f=)A=2h3401`?!G "
	boxtxt	"#D )26aEd0a..oh my g"
	boxtxt	"od what have you don"
	boxtxt	"e everything is ruin"
	boxtxt	"ed now.:."
	boxtxt_next

	boxtxt	"but hey, seeing"
	boxtxt	"that you've made it"
	boxtxt	"here, exploring"
	boxtxt	"seems to be just"
	boxtxt	"your thing."
	boxtxt_next

	boxtxt	"so tell ya what,"
	boxtxt	"if you want to"
	boxtxt	"explore even more"
	boxtxt	"here's the link to"
	boxtxt	"the source code"
	boxtxt	"of sonic erazor!"
	boxtxt_next

	boxtxt	"HTTPS0//"
	boxtxt	"ERAZOR.SELBI.CLUB"
	boxtxt_line	
	boxtxt	"i hope you can"	
	boxtxt	"decipher that link."	
	boxtxt	"i was too lazy to"	
	boxtxt	"add colons."
	boxtxt_next
	
	boxtxt "and, as a little"
	boxtxt "bonus on top, here's"
	boxtxt "how you can enable"
	boxtxt "debug mode1"
	boxtxt_next
	boxtxt "when you are in the"
	boxtxt "final phase of the"
	boxtxt "SELBI screen, mash"
	boxtxt "the ABC buttons"
	boxtxt "ten times1"
	boxtxt_next

	boxtxt	"have fun! and oh yea"
	boxtxt	"the level is still a"
	boxtxt	"complete mess."
	boxtxt_pause
	boxtxt	"YES, I WAS TOO LAZY"
	boxtxt	"TO FIX THAT TOO."
	boxtxt_pause
	boxtxt	"BITE ME."
	boxtxt_end

;		 --------------------
Hint_FZEscape:
	boxtxt	"HI, AND WELCOME TO"
	boxtxt	"THE tutorial!"
	boxtxt_pause
	boxtxt	"WE'LL TAKE IT EASY,"
	boxtxt	"SINCE THERE IS"
	boxtxt	"ABSOLUTELY NO RUSH."
	boxtxt_next

	boxtxt	"..."
	boxtxt_pause
	boxtxt	"UHH..."
	boxtxt_pause
	boxtxt	"YOU BETTER GET OUT"
	boxtxt	"OF HERE BEFORE THIS"
	boxtxt	"WHOLE PLACE BLOWS"
	boxtxt	"THE HELL UP."
	boxtxt_end	
;		 --------------------
Hint_6:
	boxtxt	"hard part skipper"
	boxtxt_pause
	boxtxt	"THIS IS A HARD PART"
	boxtxt	"SKIPPER."
	boxtxt_pause
	boxtxt	"IT SKIPS PARTS THAT"
	boxtxt	"ARE HARD."
	boxtxt_next

	boxtxt	"IF A CHALLENGE IS"
	boxtxt	"ASKING TOO MUCH FROM"
	boxtxt	"YOU, SIMPLY PRESS"
	boxtxt_line
	boxtxt	"a + b + c"
	boxtxt_line
	boxtxt	"IN FRONT OF THIS"
	boxtxt	"DEVICE TO SKIP IT!"
	boxtxt_next
	
	boxtxt	"THIS ALSO WORKS IN"
	boxtxt	"SPECIAL STAGES,"
	boxtxt	"AT ANY TIME!"
	boxtxt_pause

	dc.b	_frantic
	boxtxt	"    frantic mode"
	boxtxt_pause
	boxtxt	"  UNFORTUNATELY..."
	boxtxt	" HARD PART SKIPPERS"
	boxtxt	" ARE ONLY AVAILABLE"
	boxtxt	" IN CASUAL MODE AND"
	boxtxt	"  MUST not BE USED"
	boxtxt	"  IN FRANTIC MODE!"
	boxtxt_end

;		 --------------------
Hint_7:
	boxtxt	"dying sucks"
	boxtxt_pause
	boxtxt	"SOME TRIAL AND ERROR"
	boxtxt	"MIGHT BE NECESSARY."
	boxtxt	"THERE ARE ABSOLUTELY"
	boxtxt	"no lives ANYWHERE IN"
	boxtxt	"IN THIS GAME THOUGH!"
	boxtxt_next

	boxtxt	"FURTHERMORE, TO NOT"
	boxtxt	"WASTE YOUR TIME,"
	boxtxt	"MOST CHALLENGES"	
	boxtxt	"WILL INSTANTLY"
	boxtxt	"TELEPORT YOU BACK,"
	boxtxt	"RATHER THAN OUTRIGHT"
	boxtxt	"KILLING YOU!"
	boxtxt_pause

	dc.b	_frantic
	boxtxt	"    frantic mode"
	boxtxt_pause
	boxtxt	"  MIND YOUR RINGS!"
	boxtxt_line
	boxtxt	"  IN FRANTIC MODE,"
	boxtxt	"  REPEATED FAILURE"
	boxtxt	"  COSTS YOU RINGS."
	boxtxt_next

	boxtxt_line
	boxtxt_line
	boxtxt	"   OUT OF RINGS?!"
	boxtxt_pause
	boxtxt	"      YOU DIE."
	boxtxt_end

;		 --------------------
Hint_8:
	boxtxt	"alternative gravity"
	boxtxt_pause
	boxtxt	"PRESS c REPEATEDLY"
	boxtxt	"WHILE IN AIR AND USE"
	boxtxt	"THE d_pad TO HOP AND"
	boxtxt	"DASH IN WHATEVER"
	boxtxt	"DIRECTION YOU WANT!"
	boxtxt_end

;		 --------------------
Hint_9:
	boxtxt	"HEDGEHOG SPACE GOLF"
	boxtxt	"ISN'T YOUR THING?"
	boxtxt_pause
	boxtxt	"TRY HOLDING a TO"
	boxtxt	"INVERT GRAVITY!"
	boxtxt_end

;		 --------------------
Hint_Easter_Tutorial:
	boxtxt	"YOU THINK YOU'RE"
	boxtxt	"PRETTY CLEVER, HUH?"
	boxtxt_pause
	boxtxt	"GET IN THE RING,"
	boxtxt	"LOSER!"
	boxtxt_end

;		 --------------------
Hint_Easter_SLZ:
	boxtxt	"  AREN'T THE TRUE   "
	boxtxt_line
	boxtxt	"    EASTER EGGS     "
	boxtxt_line
	boxtxt	"    THE FRIENDS     "
	boxtxt	"      WE MADE       "
	boxtxt	"   ALONG THE WAY?   "
	boxtxt_next

	boxtxt	"..."
	boxtxt_pause
	boxtxt_line
	boxtxt	"..."
	boxtxt_pause
	boxtxt_line
	boxtxt	"..."
	boxtxt_next

	boxtxt	"WHAT?"
	boxtxt_pause
	boxtxt	"WERE YOU EXPECTING"
	boxtxt	"ANYTHING NAUGHTY?"
	boxtxt_next

	boxtxt	"YOU ARE"
	boxtxt_line
	boxtxt_pause
	boxtxt	"CATEGORICALLY"
	boxtxt_pause
	boxtxt	"DISGUSTING."
	boxtxt_end

;		 --------------------
Hint_TutorialConclusion:
	boxtxt	"AND THAT CONCLUDES"
	boxtxt	"THE TUTORIAL!"
	boxtxt_line
	boxtxt	"YOU SHOULD BE ABLE"
	boxtxt	"TO FIGURE OUT THE"
	boxtxt	"REST ON YOUR OWN."
	boxtxt_next

	boxtxt	"TWO MORE QUICK tips"
	boxtxt_pause
	boxtxt	"- EXIT A STAGE AT"
	boxtxt	"  ANY TIME WITH"
	boxtxt	"  pause + a"
	boxtxt_pause
	boxtxt	"- BE SURE TO CHECK"
	boxtxt	"  OUT THE options!"
	boxtxt_next

	boxtxt	"NOW GO OUT THERE AND"
	boxtxt	"HAVE FUN WITH"
	boxtxt_line
	boxtxt	"    sonic erazor"
	boxtxt_line
	boxtxt	"I HOPE YOU'LL HAVE"
	boxtxt	"AS MUCH FUN AS I HAD"
	boxtxt	"CREATING IT!"
	boxtxt_next

	boxtxt	"      BY selbi"
	boxtxt_pause
	boxtxt	"  THEY CALL ME THE"
	boxtxt	"    michael  bay"
	boxtxt	"   OF SONIC GAMES."
	boxtxt_pause
	boxtxt	" AND VERY SOON YOU"
	boxtxt	" WILL ALSO SEE WHY."
	boxtxt_end

;		 --------------------
Hint_Easter_Tutorial_Escape:
	boxtxt	"IF IT SAVES YOU THE"
	boxtxt	"EFFORT OF COMING"
	boxtxt	"UP HERE AGAIN,"
	boxtxt_pause
	boxtxt	"YOU ARE STILL"
	boxtxt	"A LOSER."
	boxtxt_end

;		 --------------------
Hint_End_AfterCasual:
	boxtxt	"CONGRATULATIONS FOR"
	boxtxt	"BEATING THE GAME IN"
	boxtxt	"casual mode!"
	boxtxt_next

	boxtxt	"TRY TO GIVE THE GAME"
	boxtxt	"ANOTHER SPIN IN"
	boxtxt	"frantic mode!"
	boxtxt_pause
	boxtxt	"IF YOU DO, BE SURE"
	boxtxt	"TO REVISIT THE"
	boxtxt	"TUTORIAL, AS SOME"
	boxtxt	"STUFF IS DIFFERENT."
	boxtxt_end

;		 --------------------
Hint_End_AfterFrantic:
	boxtxt	"CONGRATULATIONS FOR"
	boxtxt	"BEATING THE GAME IN"
	boxtxt	"frantic mode!"
	boxtxt_next

	boxtxt	"IF YOU MADE IT HERE,"
	boxtxt	"YOU HAVE MY UTMOST"
	boxtxt	"RESPECT. I'M SORRY"
	boxtxt	"ANY BRAIN CELLS LOST"
	boxtxt	"ALONG THE WAY."
	boxtxt_end

;		 --------------------
Hint_End_CinematicUnlock:
	boxtxt	"YOU HAVE UNLOCKED"
	boxtxt	"cinematic mode!"
	boxtxt_pause	
	boxtxt	"IT'S COMPLETELY"
	boxtxt	"USELESS! BUT KINDA"
	boxtxt	"COOL, I GUESS."
	boxtxt_end

;		 --------------------
Hint_End_BlackoutTeaser:
	boxtxt	"AND ONE LAST THING."
	boxtxt_pause
	boxtxt	"IF YOU SAW ANYTHING"
	boxtxt	"WEIRD IN uberhub..."
	boxtxt_pause
	boxtxt	"IGNORE IT."
	boxtxt_next

	boxtxt	"OR... DON'T."
	boxtxt_pause
	boxtxt	"HONESTLY, I DON'T"
	boxtxt	"REALLY CARE. JUST"
	boxtxt	"DON'T SAY THAT"
	boxtxt	"I DIDN'T WARN YOU."
	boxtxt_end

; ---------------------------------------------------------------
	even