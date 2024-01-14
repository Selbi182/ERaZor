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


; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

; Set VDP to VRAM write
vram	macro	offset,operand
	if (narg=1)
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),VDP_Ctrl
	else
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),\operand
	endc
	endm
	
; VRAM write access constant
DCvram	macro	offset
	dc.l	($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14))
	endm

; ===============================================================

Tutorial_DisplayHint:
	movem.l	a5-a6,-(sp)

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
	
	; hacky fix required because the cropped borders objects lead to trouble
	sf.b	(Objects+$3C1).w		; fix Selbi's bad object
	sf.b	(Objects+$381).w		; fix Selbi's bad object

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

	; Check if it's over
	tst.b	_DH_WindowObj	; object window dead?
	bne.s	DH_MainLoop	; if not, branch

; ---------------------------------------------------------------
; Return to the game
; ---------------------------------------------------------------

DH_Quit:
	move.b	#2,VBlankSub
	jsr	DelayProgram
	movem.l	(sp)+,a5-a6
	addq.w	#4,sp				; return controls to the game
	cmp.b	#$99,($FFFFFFDE).w		; are we in the opening text screen?
	bne.s	@cont				; if not, branch
	subq.w	#4,sp
@cont:
	jmp	ObjectsLoad			; reload objects

; ---------------------------------------------------------------
; Clear/Redraw text window
; ---------------------------------------------------------------

DH_ClearWindow:
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

	rts

; ---------------------------------------------------------------
; Draw Character in the window
; ---------------------------------------------------------------
; INPUT:
;	d0.w	= Char
; ---------------------------------------------------------------

DH_DrawChar:
	lea	Art_DH_Font,a1

	cmpi.b	#'\',d0
	bne.s	@NoAccent
	move.b	#$2+$36,d0
@NoAccent:
	cmpi.b	#'.',d0
	bne.s	@NoDot
	move.b	#$26+$36,d0
@NoDot:
	cmpi.b	#':',d0
	bne.s	@NoYDot
	move.b	#$26+$36,d0
	lea	Art_DH_FontY,a1
@NoYDot:
	cmpi.b	#',',d0
	bne.s	@NoComma
	move.b	#$27+$36,d0
@NoComma:
	cmpi.b	#';',d0
	bne.s	@NoYComma
	move.b	#$27+$36,d0
	lea	Art_DH_FontY,a1
@NoYComma:
	cmpi.b	#'!',d0
	bne.s	@NoExclemation
	move.b	#$A+$36,d0
@NoExclemation:
	cmpi.b	#'1',d0
	bne.s	@NoYExclemation
	move.b	#$A+$36,d0
	lea	Art_DH_FontY,a1
@NoYExclemation:
	cmpi.b	#'-',d0
	bne.s	@NoHyphen
	move.b	#$25+$36,d0
@NoHyphen:
	cmpi.b	#'_',d0
	bne.s	@NoYHyphen
	lea	Art_DH_FontY,a1
	move.b	#$25+$36,d0
@NoYHyphen:
	cmpi.b	#'+',d0
	bne.s	@NoPlus
	move.b	#$29+$36,d0
@NoPlus:
	cmpi.b	#'~',d0
	bne.s	@NoTilde
	move.b	#$1+$36,d0
	lea	Art_DH_FontY,a1
@NoTilde:
	cmpi.b	#'^',d0
	bne.s	@NoCircumflex
	move.b	#$5+$36,d0
	lea	Art_DH_FontY,a1
@NoCircumflex:
	cmpi.b	#'a',d0
	blt.s	@NoYellow
	cmpi.b	#'z',d0
	bgt.s	@NoYellow
	lea	Art_DH_FontY,a1
	subi.b	#$20,d0
@NoYellow:
	cmpi.b	#'?',d0
	bne.s	@NoQuestion
	move.b	#$28+$36,d0
@NoQuestion:
	
	subi.b	#$36,d0
	lsl.w	#5,d0			; d0 = Char*$20
	lea	(a1,d0.w),a1		; load this char's art 

InitDraw:  
	moveq	#$F,d3			; d3 = Pixel Mask
	moveq	#_DH_BG_Pattern_2,d4	; d4 = BG color
	moveq	#7,d5

@DrawLine:
	moveq	#7,d2
	move.l	(a1)+,d0		; load 8 px

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
	movea.l	char_pos(a0),a2		; load last position in text

@InstantWrite_Loop:
	moveq	#0,d0
	move.b	(a2)+,d0		; get a char
	beq.s	@Call_LoadNextRow	; --
	bmi.s	@InstantWrite_Flags	; --
	cmpi.b	#' ',d0			; --
	beq.s	@FF			; --
	move.l	vram_pos(a0),(a6)	; setup VDP access
	bsr	DH_DrawChar		; draw da char
@FF	addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
	bra.s	@InstantWrite_Loop

@InstantWrite_Flags:
	cmpi.b	#$FC,d0
	beq.s	@InstantWrite_SkipDelay	; if flag = '_delay', branch
	cmpi.b	#$FD,d0
	bne.s	@InstantWrite_Loop	; if flag != '_pause', ignore
	subq.w	#1,a2			; position of '_pause' flag
	move.l	a2,char_pos(a0)		; remember position
	rts				; finish loop
	
@InstantWrite_SkipDelay:
	addq.w	#1,a2			; skip delay value
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
	andi.b	#A+B+C,d0		; A/B/C held?
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

	lea	(Art_DH_Font+$120).l,a1
	vram	_DH_VRAM_Base+$13E0,(a6)
	bsr	InitDraw
	move.b	#$20,$32(a0)
	move.b	#0,$33(a0)
@PauseLoop:
	subq.b	#1,$32(a0)
	bpl.s	@cont
	move.b	#$20,$32(a0)
	lea	(Art_DH_Font).l,a1
	bchg	#0,$33(a0)
	beq.s	@cont2
	adda.w	#$120,a1
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
	incbin	'Screens\TutorialBox\TutorialBox_Art.bin'

Art_DH_Font:
	incbin	'Screens\TutorialBox\TutorialBox_Font.bin'

Art_DH_FontY:
	incbin	'Screens\TutorialBox\TutorialBox_FontYellow.bin'

; ===============================================================
; ---------------------------------------------------------------
; Hints Pointer List
; ---------------------------------------------------------------

Hints_List:
	dc.l	Hint_1
	dc.l	Hint_2
	dc.l	Hint_3
	dc.l	Hint_4
	dc.l	Hint_5
	dc.l	Hint_6
	dc.l	Hint_7
	dc.l	Hint_8
	dc.l	Hint_9
	dc.l	Hint_Pre
	dc.l	Hint_Easter_Tutorial
	dc.l	Hint_Easter_SLZ

; ---------------------------------------------------------------
; Hints Scripts
; ---------------------------------------------------------------

; You can use these flags to make it cooler:

_br	= $00	; line break flags
_delay	= $FC	; set delay (given in the next byte)
_pause	= $FD	; wait player to press A/B/C button
_cls	= $FE	; clear window
_end	= $FF	; finish hint

;		 --------------------
Hint_Pre:
	dc.b	'HELLO AND WELCOME TO',_br
	dc.b	                    '',_br
	dc.b	'    sonic erazor',_br
	dc.b	                    '',_delay,10,_br
	dc.b	'THE CRAZIEST JOURNEY',_br
	dc.b	'YOU\LL EVER TAKE',_br
	dc.b	'WITH YOUR FAVORITE',_br
	dc.b	'BLUE HEDGEHOG!',_br
	dc.b	_pause,_cls
	
	dc.b	'YOU\LL FACE SOME',_br
	dc.b	'OF THE MOST RAGE',_br
	dc.b	'INDUCING, UNIQUE,',_br
	dc.b	'AND EXPLOSIVE',_br
	dc.b	'CHALLENGES EVER',_br
	dc.b	'CREATED FOR A SONIC',_br
	dc.b	'GAME!',_br
	dc.b	_pause,_cls

	dc.b	'BECAUSE TEARS OF',_br
	dc.b	'FRUSTRATION SHOULD',_br
	dc.b	'BE KEPT TO A MINIMUM',_br
	dc.b	'THE FOLLOWING LEVEL',_br
	dc.b	'WILL TEACH YOU SOME',_br
	dc.b	'OF THE BASICS YOU\LL',_br
	dc.b	'NEED TO KNOW LATER',_br
	dc.b	'IN THE GAME.',_br
	dc.b	_pause,_cls

	dc.b	_br,_br
	dc.b	'   ALRIGHT THEN,',_br
	dc.b	_delay,10,_br
	dc.b	_br
	dc.b	'   let us begin1',_br
	dc.b	_pause,_end

;		 --------------------
Hint_1:
	dc.b	'YOU SHOULDN\T BE',_br
	dc.b	'ABLE TO READ THIS',_br
	dc.b	'LOL',_br
	dc.b	_pause,_end

;		 --------------------
Hint_2:
	dc.b	'controls',_br
	dc.b	_br
	dc.b	'  c OR b - JUMP',_br
	dc.b	'       a - SPECIAL',_br
	dc.b	'           POWER  ',_br
	dc.b	'~ + jump - SPINDASH',_br
	dc.b	'^ + jump - PEELOUT',_br
	dc.b	_pause,_cls
	
	dc.b	'while in the air',_br
	dc.b	_br
	dc.b	'c - HOMING ATTACK',_br
	dc.b	'b - DOUBLE JUMP',_br
	dc.b	'a - SPECIAL POWER',_br
	dc.b	_br
	dc.b	'd_pad + jump -',_br
	dc.b    '  DIRECTIONAL JUMP',_br
	dc.b	_pause,_end

;		 --------------------
Hint_3:
	dc.b	'inhuman mode',_br
	dc.b	_br
	dc.b	'YOU CAN\T DIE,',_br
	dc.b	'EVEN TO BOTTOMLESS',_br
	dc.b	'PITS OR BEING',_br
	dc.b	'CRUSHED TO DEATH!',_br
	dc.b	_pause,_cls

	dc.b	'a + d_pad',_br
	dc.b	_br
	dc.b	'SHOOTS A MISSILE',_br
	dc.b	'YOU CAN PROPEL',_br
	dc.b	'YOURSELF IN THE AIR',_br
	dc.b	'WITH!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_4:
	dc.b	'YOU SHOULDN\T BE',_br
	dc.b	'ABLE TO READ THIS',_br
	dc.b	'LOL',_br
	dc.b	_pause,_end

;		 --------------------
Hint_5:
	dc.b	'MOST CHALLENGES IN',_br
	dc.b	'THIS GAME WILL',_br
	dc.b	'INSTANTLY TELEPORT',_br
	dc.b	'YOU BACK TO THEIR',_br
	dc.b	'START, RATHER THAN',_br
	dc.b	'SIMPLY KILLING YOU!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_6:
	dc.b	'hard part skipper',_br
	dc.b	_br
	dc.b	'PRESS a + b + c',_br
	dc.b	'TO SKIP CHALLENGES',_br
	dc.b	'THAT ARE SIMPLY TOO',_br
	dc.b	'HARD FOR YOU.',_br
	dc.b	'NO HARD FEELINGS!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_7:
	dc.b	'trial and error',_br
	dc.b	_br
	dc.b	'SOME CHALLENGES',_br
	dc.b	'SIMPLY CAN\T BE',_br
	dc.b	'COMPLETED WITHOUT',_br
	dc.b	'TRIAL AND ERROR.',_br
	dc.b	_pause,_cls

	dc.b	'DON\T WORRY THOUGH,',_br
	dc.b	'THERE ARE NO LIVES,',_br
	dc.b	'SO FEEL FREE TO BE',_br
	dc.b	'A MANIAC!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_8:
	dc.b	'alternative gravity',_br
	dc.b	_br
	dc.b	'HOLD a WHILE IN AIR',_br
	dc.b	'AND USE THE d_pad',_br
	dc.b	'TO CONTROL THE',_br
	dc.b	'MOVEMENT OF SONIC!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_9:
	dc.b	'AND THAT CONCLUDES',_br
	dc.b	'THE TUTORIAL!',_br
	dc.b	_br
	dc.b	'YOU SHOULD BE ABLE',_br
	dc.b	'TO FIGURE OUT THE',_br
	dc.b	'REST ON YOUR OWN.',_br
	dc.b	_pause,_cls

	dc.b	'JUST ONE WORD OF',_br
	dc.b	'ADVICE, YOU CAN',_br
	dc.b	'ALWAYS RETURN TO',_br
	dc.b	'THE HUB WORLD BY',_br
	dc.b	'PRESSING a WHILE',_br
	dc.b	'THE GAME IS PAUSED.',_br
	dc.b	_pause,_cls

	dc.b	'NOW GO OUT THERE AND',_br
	dc.b	'HAVE FUN WITH',_br
	dc.b	_br
	dc.b	'    sonic erazor',_br
	dc.b	_br
	dc.b	'I HOPE YOU\LL HAVE',_br
	dc.b	'AS MUCH FUN AS I HAD',_br
	dc.b	'CREATING IT!',_br
	dc.b	_pause,_cls

	dc.b	'      BY selbi',_br
	dc.b	_br,_delay,60
	dc.b	'  THEY CALL ME THE',_br
	dc.b	'    MICHAEL  BAY',_br
	dc.b	'   OF SONIC GAMES.',_br
	dc.b	_br,_delay,90
	dc.b	' AND VERY SOON YOU',_br
	dc.b	' WILL ALSO SEE WHY.',_br
	dc.b	_pause,_end

;		 --------------------
Hint_Easter_Tutorial:
	dc.b	'YOU THINK YOU\RE',_br
	dc.b	'PRETTY CLEVER, HUH?',_br
	dc.b	_pause,_cls
	dc.b	'GET IN THE RING,',_br
	dc.b	'LOSER!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_Easter_SLZ:
	dc.b	'AREN\T THE TRUE',_br
	dc.b	_br
	dc.b	'easter eggs',_br
	dc.b	_br
	dc.b	'THE FRIENDS WE',_br
	dc.b	'MADE ALONG THE',_br
	dc.b	'WAY?',_br
	dc.b	_pause,_cls
	dc.b	'...',_br
	dc.b	_br,_delay,60
	dc.b	'...',_br
	dc.b	_br,_delay,60
	dc.b	'...',_br
	dc.b	_pause,_cls
	dc.b	'WHAT?',_br
	dc.b	_br,_delay,60
	dc.b	'WERE YOU EXPECTING',_br
	dc.b	'ANYTHING NAUGHTY',_br
	dc.b	'UP HERE?',_br
	dc.b	_pause,_end
	
; ---------------------------------------------------------------