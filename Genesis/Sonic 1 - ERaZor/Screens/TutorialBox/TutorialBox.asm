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

; Joypad Buttons

Held	equ	0		; Bitfield ids
Press	equ	1

iStart	equ 	7		; Button Indexes
iA	equ 	6
iC	equ 	5
iB	equ 	4
iRight	equ 	3
iLeft	equ 	2
iDown	equ 	1
iUp	equ 	0

Start	equ 	1<<iStart	; Button values
A	equ 	1<<iA
C	equ 	1<<iC
B	equ 	1<<iB
Right	equ 	1<<iRight
Left	equ 	1<<iLeft
Down	equ 	1<<iDown
Up	equ 	1<<iUp

SonicControl	equ	$FFFFF602
Joypad		equ	$FFFFF604

Held		equ	0
Press		equ	1

; VRAM flags

pri	equ	$8000
tutpal0	equ	0
tutpal1	equ	1<<13
tutpal2	equ	2<<13
tutpal3	equ	3<<13

; IO Ports

VDP_Data	equ	$C00000
VDP_Ctrl	equ	$C00004

; Game RAM

Objects		equ	$FFFFD000	; ~	Objects RAM
Pal_Active	equ	$FFFFFB00	; ~	Active palette
Pal_Target	equ	$FFFFFB80	; ~	Target palette for fading
VBlankSub	equ	$FFFFF62A	; b	VBlank routine id

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


; You can use these flags to make it cooler:
_br	= $00	; line break flags
_font2	= $01	; will make the next character use palette line 2 for the font
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
	move.b	#8,VBlankSub
	jsr	DelayProgram			; perform vsync before operation, fix Sonic's DPCL
	move	#$2700,sr			; disable interrupts
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

; ---------------------------------------------------------------
; Display Hint Main Loop
; ---------------------------------------------------------------

DH_MainLoop:
	move.b	#2,VBlankSub
	jsr	DelayProgram

	;cmpi.b	#10,($FFFFFF6E).w	; is this the introduction text?
	;bne.s	@notintro		; if not, branch
	;lea	($FFFFFB40).w,a1
	;jsr	SineWavePalette		; sinewave background color
@notintro:
		; background deformation
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

	; red palette cycle
	cmpi.b	#5,($FFFFFE10).w
	bne.s	@notsbz
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
	
@notsbz:
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
	move	#$2700,sr
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
	move	#$2300,sr
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
	move	#$2700,sr		; we *must* disable interrupts
	movea.l	char_pos(a0),a1		; load last position in text

@InstantWrite_Loop:
	moveq	#0,d0
	move.b	(a1)+,d0		; get a char
	beq.s	@Call_LoadNextRow	; --
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
	rts				; finish loop
	
@InstantWrite_SkipDelay:
	addq.w	#1,a1			; skip delay value
	bra.s	@InstantWrite_Loop

@Call_LoadNextRow:
	pea	@InstantWrite_Loop
	bra.w	@LoadNextRow

; ---------------------------------------------------------------
@ProcessChar:
	move.b	Joypad|Press,d0
	andi.b	#A+B+C+START,d0		; A/B/C/START pressed?
	beq.s	@ContinueChar		; if not, branch
	tst.w	cooldown(a0)		; is cooldown over?
	beq.s	@InstantWrite		; if yes, immediately write the whole screen

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
	beq.s	@0			; -- if yes, don't draw, don't play sound
	move.l	vram_pos(a0),(a6)	; setup VDP access
	bsr	DH_DrawChar		; draw da char
	moveq	#$FFFFFFD8,d0
	jsr	PlaySound
	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	rts

@0	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	bra.s	@Retry

@CheckFlags:
	addq.b	#1,d0
	beq.w	@GotoDisappear		; if flag = '_end', branch
	addq.b	#1,d0
	beq.w	@ClearWindow		; if flag = '_cls', branch
	addq.b	#1,d0
	beq.s	@DoPause		; if flag = '_pause', branch
					; assume it's flag '_delay' then
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
	dc.l	Hint_Null
	dc.l	Hint_2
	dc.l	Hint_3
	dc.l	Hint_4
	dc.l	Hint_Null
	dc.l	Hint_6
	dc.l	Hint_7
	dc.l	Hint_8
	dc.l	Hint_9
	dc.l	Hint_Pre
	dc.l	Hint_Easter_Tutorial
	dc.l	Hint_Easter_SLZ
	dc.l	Hint_TutorialConclusion

; ---------------------------------------------------------------
; Hints Scripts
; ---------------------------------------------------------------

; Macro to preprocess and output a character to its correct mapping
mapchar macro char
	if     \char = "'"
		dc.b	$2+DH_CharOffset
	elseif \char = "#"
		dc.b	_font2, $2+DH_CharOffset
	elseif \char = '.'
		dc.b	$26+DH_CharOffset
	elseif \char = ':'
		dc.b	_font2, $26+DH_CharOffset
	elseif \char = ','
		dc.b	$27+DH_CharOffset
	elseif \char = ';'
		dc.b	_font2, $27+DH_CharOffset
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

;		 --------------------

Hint_Null:
	boxtxt	"you shouldn#t be"
	boxtxt	"able to read this"
	boxtxt	"lol"
	dc.b	_br,_pause,_end


Hint_Pre:
	boxtxt	"HELLO AND WELCOME TO"
	dc.b	_br
	boxtxt	"    sonic erazor"
	dc.b	_br,_delay,10
	boxtxt	"THE CRAZIEST JOURNEY"
	boxtxt	"YOU'LL EVER TAKE"
	boxtxt	"WITH YOUR FAVORITE"
	boxtxt	"BLUE HEDGEHOG!"
	dc.b	_br,_pause,_cls
	
	boxtxt	"YOU WILL REVISIT"
	boxtxt	"THE FIRST SONIC GAME"
	boxtxt	"THROUGH THE LENS OF"
	boxtxt	"AN ACTION MOVIE."
	dc.b	_br
	boxtxt	"FAST MOVEMENT,"
	boxtxt	"TOUGH CHALLENGES,"
	boxtxt	"AND explosions."
	dc.b	_br,_pause,_cls

	boxtxt	"BECAUSE TEARS OF"
	boxtxt	"FRUSTRATION SHOULD"
	boxtxt	"BE KEPT TO A MINIMUM"
	boxtxt	"AT ALL TIMES, THE"
	boxtxt	"FOLLOWING STAGE WILL"
	boxtxt	"TEACH YOU SOME OF"
	boxtxt	"THIS GAME'S"
	boxtxt	"REQUIRED BASICS."
	dc.b	_br,_pause,_cls

	boxtxt	"POSITION YOURSELF"
	boxtxt	"IN FRONT OF THE"
	boxtxt	"INFORMATION MONITORS"
	boxtxt	"AND PRESS a TO BRING"
	boxtxt	"UP USEFUL TIPS!"
	dc.b	_br,_pause,_cls

	dc.b	_br
	boxtxt	"   ALRIGHT THEN,"
	dc.b	_br,_delay,10
	dc.b	_br
	boxtxt	"     let#s go1"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_2:
	boxtxt	"controls"
	dc.b	_br
	boxtxt	"  c OR b - JUMP"
	boxtxt	"       a - SPECIAL"
	boxtxt	"           POWER  "
	boxtxt	"~ + jump - SPINDASH"
	boxtxt	"^ + jump - PEELOUT"
	dc.b	_br,_pause,_cls
	
	boxtxt	"while in the air"
	dc.b	_br
	boxtxt	"c - HOMING ATTACK"
	boxtxt	"b - DOUBLE JUMP"
	boxtxt	"a - SPECIAL POWER"
	dc.b	_br
	boxtxt	"d_pad + jump -"
	boxtxt    "  DIRECTIONAL JUMP"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_3:
	boxtxt	"inhuman mode"
	dc.b	_br
	boxtxt	"PRESS a TO FIRE AN"
	boxtxt	"EXPLODING BULLET"
	boxtxt	"YOU CAN PROPEL"
	boxtxt	"YOURSELF IN THE AIR"
	boxtxt	"WITH!"
	dc.b	_br,_pause,_cls

	boxtxt	"ALSO, YOU ARE FULLY"
	boxtxt	"INVINCIBLE TO"
	boxtxt	"EVERYTHING!"
	dc.b	_br,_pause
	boxtxt	"...EXCEPT SPIKES."
	dc.b	_br,_pause,_end

;		 --------------------
Hint_4:
	boxtxt	"0Adw193q4HG5!'%q6/%4"
	boxtxt	"8ETRqZ91/D' we03()a)"
	boxtxt	"( B)f=)A=2h3401`?!G "
	boxtxt	"#D )26aEd0a..oh my g"
	boxtxt	"od what have you don"
	boxtxt	"e everything is ruin"
	boxtxt	"ed now.:."
	dc.b	_br,_pause,_cls
	boxtxt	"but hey, seeing"
	boxtxt	"that you've made it"
	boxtxt	"here, exploring"
	boxtxt	"seems to be just"
	boxtxt	"your thing."
	dc.b	_br,_pause,_cls
	boxtxt	"so tell ya what,"
	boxtxt	"if you want to"
	boxtxt	"explore even more"
	boxtxt	"here's the link to"
	boxtxt	"the source code"
	boxtxt	"of sonic erazor!"
	dc.b	_br,_pause,_cls
	boxtxt	"HTTPS0//"
	boxtxt	"ERAZOR:SELBI:CLUB"
	dc.b	_br	
	boxtxt	"i hope you can"	
	boxtxt	"decipher that link."	
	boxtxt	"i was too lazy to"	
	boxtxt	"add colons and"
	boxtxt	"slashes to the font."
	dc.b	_br,_pause,_cls
	boxtxt	"have fun! and oh yea"
	boxtxt	"the level is still a"
	boxtxt	"complete mess."
	dc.b	_pause
	boxtxt	"YES, I WAS TOO LAZY"
	boxtxt	"TO FIX THAT TOO."
	dc.b	_br,_pause
	boxtxt	"BITE ME."
	dc.b	_br,_pause,_end

;		 --------------------
Hint_6:
	boxtxt	"hard part skippers"
	dc.b	_br
	boxtxt	"PRESS a + b + c"
	boxtxt	"TO SKIP CHALLENGES"
	boxtxt	"THAT ARE SIMPLY TOO"
	boxtxt	"TOUGH FOR YOU."
	boxtxt	"NO HARD FEELINGS!"
	dc.b	_br,_pause,_cls
	boxtxt	"DO NOTE THAT"
	boxtxt	"HARD PART SKIPPERS"
	boxtxt	"MUST ONLY BE USED"
	boxtxt	"IN casual mode!"
	boxtxt	"OR ELSE..."
	dc.b	_br,_pause,_end

;		 --------------------
Hint_7:
	boxtxt	"dying sucks"
	dc.b	_br
	boxtxt	"DON'T WORRY THOUGH,"
	boxtxt	"THERE ARE no lives,"
	boxtxt	"IN THIS GAME. SO,"
	boxtxt	"FEEL FREE TO GO"
	boxtxt	"ABSOLUTELY CRAZY!"
	dc.b	_br,_pause,_cls
	boxtxt	"FURTHERMORE, TO NOT"
	boxtxt	"WASTE YOUR TIME,"
	boxtxt	"MOST CHALLENGES"	
	boxtxt	"WILL INSTANTLY"
	boxtxt	"TELEPORT YOU BACK,"
	boxtxt	"RATHER THAN OUTRIGHT"
	boxtxt	"KILLING YOU!"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_8:
	boxtxt	"alternative gravity"
	dc.b	_br
	boxtxt	"PRESS c REPEATEDLY"
	boxtxt	"WHILE IN AIR AND USE"
	boxtxt	"THE d_pad TO HOP AND"
	boxtxt	"DASH IN WHATEVER"
	boxtxt	"DIRECTION YOU WANT!"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_9:
	boxtxt	"HEDGEHOG SPACE GOLF"
	boxtxt	"ISN'T YOUR THING?"
	boxtxt	"TRY HOLDING a TO"
	boxtxt	"INVERT GRAVITY!"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_Easter_Tutorial:
	boxtxt	"YOU THINK YOU'RE"
	boxtxt	"PRETTY CLEVER, HUH?"
	dc.b	_br,_pause,_cls
	boxtxt	"GET IN THE RING,"
	boxtxt	"LOSER!"
	dc.b	_br,_pause,_end

;		 --------------------
Hint_Easter_SLZ:
	boxtxt	"AREN'T THE TRUE"
	dc.b	_br
	boxtxt	"EASTER EGGS"
	dc.b	_br
	boxtxt	"THE FRIENDS WE"
	boxtxt	"MADE ALONG THE"
	boxtxt	"WAY?"
	dc.b	_br,_pause,_cls
	boxtxt	"..."
	dc.b	_br,_delay,60
	boxtxt	"..."
	dc.b	_br,_delay,60
	boxtxt	"..."
	dc.b	_br,_pause,_cls
	boxtxt	"WHAT?"
	dc.b	_br,_delay,60
	boxtxt	"WERE YOU EXPECTING"
	boxtxt	"ANYTHING NAUGHTY"
	boxtxt	"UP HERE?"
	dc.b	_br,_pause,_cls
	boxtxt	"YOU ARE"
	dc.b	_br
	boxtxt	"CATEGORICALLY"
	boxtxt	"DISGUSTING."
	dc.b	_br,_pause,_end

;		 --------------------
Hint_TutorialConclusion:
	boxtxt	"AND THAT CONCLUDES"
	boxtxt	"THE TUTORIAL!"
	dc.b	_br
	boxtxt	"YOU SHOULD BE ABLE"
	boxtxt	"TO FIGURE OUT THE"
	boxtxt	"REST ON YOUR OWN."
	dc.b	_br,_pause,_cls

	boxtxt	"TWO MORE QUICK tips"
	dc.b	_br
	boxtxt	"- EXIT A STAGE AT"
	boxtxt	"  ANY TIME WITH"
	boxtxt	"  pause + a"
	dc.b	_br
	boxtxt	"- BE SURE TO CHECK"
	boxtxt	"  OUT THE options!"
	dc.b	_br,_pause,_cls

	boxtxt	"NOW GO OUT THERE AND"
	boxtxt	"HAVE FUN WITH"
	dc.b	_br
	boxtxt	"    sonic erazor"
	dc.b	_br
	boxtxt	"I HOPE YOU'LL HAVE"
	boxtxt	"AS MUCH FUN AS I HAD"
	boxtxt	"CREATING IT!"
	dc.b	_br,_pause,_cls

	boxtxt	"      BY selbi"
	dc.b	_br,_delay,60
	boxtxt	"  THEY CALL ME THE"
	boxtxt	"    MICHAEL  BAY"
	boxtxt	"   OF SONIC GAMES."
	dc.b	_br,_delay,90
	boxtxt	" AND VERY SOON YOU"
	boxtxt	" WILL ALSO SEE WHY."
	dc.b	_br,_pause,_end
	even
; ---------------------------------------------------------------