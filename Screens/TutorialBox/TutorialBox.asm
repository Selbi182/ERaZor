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

_DH_BG_Pattern		= $77777777		; tile pattern for hint's BG
_DH_BG_Pattern_2	= 7			;
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
pal0	equ	0
pal1	equ	1<<13
pal2	equ	2<<13
pal3	equ	3<<13

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

	cmpi.b	#'.',d0
	bne.s	@NoDot
	move.b	#$26+$36,d0

@NoDot:
	cmpi.b	#',',d0
	bne.s	@NoComma
	move.b	#$27+$36,d0

@NoComma:
	cmpi.b	#'!',d0
	bne.s	@NoExclemation
	move.b	#$A+$36,d0

@NoExclemation:
	cmpi.b	#'-',d0
	bne.s	@NoHyphen
	move.b	#$28+$36,d0

@NoHyphen:
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
	move.w	#(_DH_WindowObj_Art)+pri+pal1,art(a0)
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

_DelayVal	= 3
_DelayVal_Sh	= 1

	move.l	#@ProcessChar,obj(a0)	; set main routine
	move.w	#_DelayVal,delay(a0)	; set delay
	move.w	#0,row(a0)		; start from the first row
	bra.w	@LoadRow

; ---------------------------------------------------------------
@ProcessChar:
	subq.w	#1,delay(a0)		; decrease delay counter
	bne.w	@Return			; if time remains, branch

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
Hint_1:
	dc.b	'HELLO AND WELCOME TO',_br
	dc.b	                    '',_br
	dc.b	'    SONIC ERAZOR    ',_br
	dc.b	                    '',_delay,10,_br
	dc.b	'THE CRAZIEST JOURNEY',_br
	dc.b	'YOU WILL EVER TAKE  ',_br
	dc.b	'WITH YOUR FAVORITE  ',_br
	dc.b	'BLUE HEDGEHOG!      ',_br
	dc.b	_pause,_cls

	dc.b	'I KNOW YOU WANT TO  ',_br
	dc.b	'DIVE RIGHT INTO THE ',_br
	dc.b	'ACTION AND GET YOUR ',_br
	dc.b	'BRAIN SLAIN APART BY',_br
	dc.b	'BY INSANITY AND     ',_br
	dc.b	'EXPLOSIVE MADNESS.  ',_br
	dc.b	_pause,_cls
	
	dc.b	'BUT, FOR YOUR OWN   ',_br
	dc.b	'SAFETY, THERE ARE A ',_br
	dc.b	'FEW THINGS YOU      ',_br
	dc.b	'SHOULD GET YOURSELF ',_br
	dc.b	'COMFORTABLE WITH    ',_br
	dc.b	'FIRST.              ',_br
	dc.b	_pause,_cls

	dc.b	'FIRST OFF, THIS GAME',_br
	dc.b	'REQUIRES MORE THAN  ',_br
	dc.b	'HOLDING RIGHT AND   ',_br
	dc.b	'JUMPING FROM TIME TO',_br
	dc.b	'TIME.               ',_br
	dc.b	_pause,_cls
	
	dc.b	'YOU WILL FACE SOME  ',_br
	dc.b	'OF THE MOST RAGE    ',_br
	dc.b	'INDUCING, UNIQUE,   ',_br
	dc.b	'AND EXPLOSIVE       ',_br
	dc.b	'CHALLANGES EVER     ',_br
	dc.b	'CREATED FOR A SONIC ',_br
	dc.b	'GAME!               ',_br
	dc.b	_pause,_cls

	dc.b	'BECAUSE TEARS OF    ',_br
	dc.b	'FRUSTRATION SHOULD  ',_br
	dc.b	'BE KEPT AT A        ',_br
	dc.b	'MINIMUM, THIS LEVEL ',_br
	dc.b	'WILL TEACH YOU THE  ',_br
	dc.b	'BASICS FOR SOME OF  ',_br
	dc.b	'THE CHALLANGES YOU  ',_br
	dc.b	'WILL FACE.          ',_br
	dc.b	_pause,_cls

	dc.b	'IF YOU FEEL LIKE YOU',_br
	dc.b	'ALREADY ARE GOOD TO ',_br
	dc.b	'GO WITHOUT THIS     ',_br
	dc.b	'TUTORIAL THOUGH,    ',_br
	dc.b	'JUST JUMP INTO THE  ',_br
	dc.b	'RING TO YOUR LEFT   ',_br
	dc.b	'AND UNLEASH THE     ',_br
	dc.b	'ULTIMATE INSANITY!  ',_br
	dc.b	_pause,_cls
	
	dc.b	'     OTHERWISE,     ',_br
	dc.b	                    '',_delay,10,_br
	dc.b	                    '',_br
	dc.b	                    '',_br
	dc.b	'   LET US BEGIN !   ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_2:
	dc.b	'AHEAD OF YOU IS A   ',_br
	dc.b	'SMALL OBSTACLE      ',_br
	dc.b	'COURSE WHICH WILL   ',_br
	dc.b	'REQUIRE SOME OF THE ',_br
	dc.b	'ABILITIES I AM ABOUT',_br
	dc.b	'TO EXPLAIN.         ',_br
	dc.b	_pause,_cls

	dc.b	'YOU CAN ONLY JUMP   ',_br
	dc.b	'WITH B AND C, AS A  ',_br
	dc.b	'IS REQUIRED FOR SOME',_br
	dc.b	'MISCELLANEOUS       ',_br
	dc.b	'ABILITIES, I WILL   ',_br
	dc.b	'EXPLAIN LATER.      ',_br
	dc.b	_pause,_cls

	dc.b	'ON THE GROUND YOU   ',_br
	dc.b	'CAN PERFORM BOTH A  ',_br
	dc.b	'SPIN DASH BY        ',_br
	dc.b	'PRESSING DOWN AND B ',_br
	dc.b	'OR C.               ',_br
	dc.b	_pause,_cls
	
	dc.b	'THE SAME RULES APPLY',_br
	dc.b	'TO THE SUPER PEEL   ',_br
	dc.b	'OUT, WHICH CAN BE   ',_br
	dc.b	'BE PERFORMED BY     ',_br
	dc.b	'PRESSING UP AND B OR',_br
	dc.b	'C.                  ',_br
	dc.b	_pause,_cls

	dc.b	'WHILE JUMPING YOU CAN',_br
	dc.b	'DASH FORWARD AND     ',_br
	dc.b	'PERFORM A HOMING     ',_br
	dc.b	'ATTACK BY PRESSING  ',_br
	dc.b	'THE C BUTTON.       ',_br
	dc.b	_pause,_cls

	dc.b	'BUT MORE IMPORTANT  ',_br
	dc.b	'THAN FORWARD DASHING',_br
	dc.b	'IS DOUBLE JUMPING,  ',_br
	dc.b	'WHICH CAN BE USED BY',_br
	dc.b	'PRESSING C AND UP   ',_br
	dc.b	'WHILE IN AIR OR     ',_br
	dc.b	'SIMPLY BY PRESSING  ',_br
	dc.b	'THE B BUTTON.       ',_br
	dc.b	_pause,_cls
	
	dc.b	'YOU MAY ALSO DASH   ',_br
	dc.b	'DOWNWARDS BY HOLDING',_br
	dc.b	'THE DOWN BUTTON     ',_br
	dc.b	'WHILE JUMPING WITH  ',_br
	dc.b	'THE B OR C BUTTONS. ',_br
	dc.b	_pause,_cls
	
	dc.b	_br,_br
	dc.b	'EXPERIMENT WITH     ',_br
	dc.b	'THESE ABILITIES TO  ',_br
	dc.b	'REACH THE NEXT ROOM!',_br
	dc.b	_pause,_end

;		 --------------------
Hint_3:
	dc.b	'DESTROYING THIS     ',_br
	dc.b	'MONITOR MAKES SONIC ',_br
	dc.b	'ENTER THE SO-CALLED ',_br,_br
	dc.b	'    INHUMAN MODE    ',_br
	dc.b	_pause,_cls

	dc.b	'IT WILL MAKE YOU    ',_br
	dc.b	'TOTALLY INVINCIBLE, ',_br
	dc.b	'EVEN FROM BOTTOMLESS',_br
	dc.b	'PITS AND BEING      ',_br
	dc.b	'CRUSHED!            ',_br
	dc.b	_pause,_cls

	dc.b	'ADDITIONALLY, BY    ',_br
	dc.b	'PRESSING A YOU CAN  ',_br
	dc.b	'SHOOT A SMALL BULLET',_br
	dc.b	'WHICH, IF YOU TOUCH ',_br
	dc.b	'IT, WILL PROPEL YOU ',_br
	dc.b	'IN THE AIR. YOU CAN ',_br
	dc.b	'CHANGE THE DIRECTION',_br
	dc.b	'WITH YOUR D-PAD.    ',_br
	dc.b	_pause,_cls

	dc.b	_br
	dc.b	'HAVE A LITTLE FLY   ',_br
	dc.b	'AROUND AND FIND     ',_br
	dc.b	'ANOTHER S-MONITOR   ',_br
	dc.b	'IN THE UPPER PART OF',_br
	dc.b	'THIS ROOM TO        ',_br
	dc.b	'CONTINUE!           ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_4:
	dc.b	'THIS S-MONITOR IS   ',_br
	dc.b	'DIFFERENT. IT WILL  ',_br
	dc.b	'STILL MAKE YOU      ',_br
	dc.b	'INVINCIBLE AND YOU  ',_br
	dc.b	'CAN STILL SHOOT     ',_br
	dc.b	'BULLETS, BUT YOU    ',_br
	dc.b	'WILL LOSE ALL OF    ',_br
	dc.b	'OTHER ABILITIES.    ',_br
	dc.b	_pause,_cls

	dc.b	'BUT MORE IMPORTANT  ',_br
	dc.b	'IS THE FACT, THAT   ',_br
	dc.b	'YOU WILL SLOWLY LOSE',_br
	dc.b	'RINGS OVER TIME AND ',_br
	dc.b	'VERY FAST WHEN YOU  ',_br
	dc.b	'ARE STANDING ON THE ',_br
	dc.b	'GROUND UNTIL YOU    ',_br
	dc.b	'REACH ZERO AND DIE! ',_br
	dc.b	_pause,_cls

	dc.b	'THESE ARE VERY RARE ',_br
	dc.b	'AND YOU SHOULD ONLY ',_br
	dc.b	'FIND THEM IN VERY,  ',_br
	dc.b	'VERY OLD AND RUINED ',_br
	dc.b	'PLACES.             ',_br
	dc.b	_pause,_cls

	dc.b	'GET THROUGH THAT    ',_br
	dc.b	'NARROW SPOT TO      ',_br
	dc.b	'CONTINUE! NORMALLY  ',_br
	dc.b	'YOU WOULD NEED TO   ',_br
	dc.b	'HURRY UP BEFORE YOUR',_br
	dc.b	'RINGS RUN OUT, BUT  ',_br
	dc.b	'WE WILL CUT THAT OUT',_br
	dc.b	'FOR NOW.            ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_5:
	dc.b	'TOUCHING SPIKES     ',_br
	dc.b	'DURING THIS SPECIAL ',_br
	dc.b	'INHUMAN MODE WILL   ',_br
	dc.b	'TELEPORT YOU BACK TO',_br
	dc.b	'WHERE YOU STARTED   ',_br
	dc.b	'AND REMOVE A FEW    ',_br
	dc.b	'RINGS, SO YOU SHOULD',_br
	dc.b	'COLLECT MANY!       ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_6:
	dc.b	'THIS DEVICE IS A    ',_br
	dc.b	'SO-CALLED           ',_br,_br
	dc.b	' HARD PART SKIPPER  ',_br
	dc.b	_pause,_cls

	dc.b	'IF A CHALLENGE IS   ',_br
	dc.b	'WAY TOO HARD FOR    ',_br
	dc.b	'YOU, BUT YOU DO NOT ',_br
	dc.b	'WANT TO USE CHEAT   ',_br
	dc.b	'CODES, YOU CAN USE  ',_br
	dc.b	'THIS DEVICE INSTEAD!',_br
	dc.b	_pause,_cls

	dc.b	'ONCE YOU HAVE MADE  ',_br
	dc.b	'YOUR DECISION, JUST ',_br
	dc.b	'POSITION YOURSELF IN',_br
	dc.b	'FRONT OF ONE AND    ',_br
	dc.b	'PRESS THE A, B, AND ',_br
	dc.b	'C BUTTONS AT THE    ',_br
	dc.b	'SAME TIME.          ',_br
	dc.b	_pause,_cls

	dc.b	'KEEP IN MIND THAT   ',_br
	dc.b	'YOU WILL LOSE ALL OF',_br
	dc.b	'YOUR RINGS, SHIELDS,',_br
	dc.b	'OR INVINCIBILIES IN ',_br
	dc.b	'THE PROCESS!        ',_br
	dc.b	_pause,_cls

	dc.b	_br
	dc.b	_br
	dc.b	' COME ON, TRY IT ON ',_br
	dc.b	' THIS IMPOSSIBLE    ',_br
	dc.b	' SPIKED TUBE!       ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_7:
	dc.b	'IT SOUNDS EVIL, BUT ',_br
	dc.b	'SOME CHALLENGES     ',_br
	dc.b	'SIMPLY CANNOT BE    ',_br
	dc.b	'COMPLETED WITHOUT   ',_br
	dc.b	'TRIAL AND ERROR AND ',_br
	dc.b	'TAKING ANY RISKS IN ',_br
	dc.b	'ORDER TO SUCCEED.   ',_br
	dc.b	_pause,_cls

	dc.b	'DO NOT WORRY THOUGH,',_br
	dc.b	'REAL GAME OVERS DO  ',_br
	dc.b	'NOT EXIST ANYWHERE  ',_br
	dc.b	'IN THIS GAME, SO DO ',_br
	dc.b	'NOT BE AFRAID TO BE ',_br
	dc.b	'MANIAC!             ',_br
	dc.b	_pause,_cls

	dc.b	_br
	dc.b	_br
	dc.b	' FIND A WAY THROUGH ',_br
	dc.b	' THIS ROOM TO       ',_br
	dc.b	' CONTINUE!          ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_8:
	dc.b	'AT SOME POINT IN    ',_br
	dc.b	'THIS GAME IT WILL BE',_br
	dc.b	'POSSIBLE TO CONTROL ',_br
	dc.b	'THE GRAVITY OF SONIC',_br
	dc.b	'AND THUS HIS FALLING',_br
	dc.b	'DIRECTION.          ',_br
	dc.b	_pause,_cls

	dc.b	'THIS CAN BE DONE BY ',_br
	dc.b	'HOLDING DOWN THE A  ',_br
	dc.b	'BUTTON WHILE BEING  ',_br
	dc.b	'IN AIR.             ',_br
	dc.b	_pause,_cls

	dc.b	_br
	dc.b	_br
	dc.b	'FLY UPWARDS TO FIND ',_br
	dc.b	'THE LAST MONITOR AND',_br
	dc.b	'FINALLY FINISH THIS ',_br
	dc.b	'TUTORIAL!           ',_br
	dc.b	_pause,_end

;		 --------------------
Hint_9:
	dc.b	'AND THAT CONCLUDES  ',_br
	dc.b	'THE TUTORIAL. YOU   ',_br
	dc.b	'SHOULD NOW BE ABLE  ',_br
	dc.b	'TO FIGURE OUT THE   ',_br
	dc.b	'REST ON YOUR OWN.   ',_br
	dc.b	_pause,_cls

	dc.b	'NOW GO OUT THERE AND',_br
	dc.b	'HAVE FUN WITH THIS  ',_br
	dc.b	'GAME, SONIC ERAZOR! ',_br
	dc.b	_br,_delay,30
	dc.b	'I HOPE YOU WILL HAVE',_br
	dc.b	'AS MUCH FUN AS I HAD',_br
	dc.b	'CREATING IT!        ',_br
	dc.b	_pause,_cls

	dc.b	_br,_br
	dc.b	'  CREATED BY SELBI  ',_br
	dc.b	_br,_br,_delay,60
	dc.b	'  THEY CALL ME THE  ',_br
	dc.b	'    MICHAEL  BAY    ',_br
	dc.b	'   OF SONIC GAMES   ',_br
	dc.b	_pause,_end