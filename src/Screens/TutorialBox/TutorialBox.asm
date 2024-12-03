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

_DH_BG_Pattern_2	= $B			;
_DH_VRAM_Base		= $5800			; base VRAM address for display window
_DH_VRAM_Border		= $5700			; VRAM address for window border
_DH_WindowObj		= $FFFFD400		; address for window object        
_DH_WindowObj_Art	= _DH_VRAM_Border/$20	; art pointer for window object
_DH_WindowFill_NumParts = 4			; number of chunks fill art is split into

_DH_WithOwnBG:		equ	$FFFFFF80	; add to "TutorialBoxId" to enable own background
_DH_WithBGFuzz:		equ	$40		; add to "TutorialBoxId" to enable fuzzy BG effect

TutDim_Min	= 7
TutDim_Max	= $10

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

Queue_TutorialBox_Display:
		move.b	d0, TutorialBoxId
		rts

TutorialBox_Display:
		move.b	d0, TutorialBoxId
		; fallthrough

; ----------------------------------------------------------------
TutorialBox:
		assert.b TutorialBoxId, ne	; we should have a requested ID when we get there

		movem.l	a5-a6,-(sp)

		; Make sure "TutorialBox_Display" wasn't called from within the object.
		; It must be called when the current frame is finished rendering.
		; The following DEBUG-only code checks if BuildSprites layers were flushed to
		; avoid visual gliches when entering and leaving the screen.
		if def(__DEBUG__)
			moveq	#0, d0
			@current_queue_ptr: = Sprites_Queue
			rept 8
				or.w	@current_queue_ptr, d0
				@current_queue_ptr: = @current_queue_ptr + $80
			endr
			assert.w d0, eq	; all layers should be empty
		endif

		; Init objects
		lea	_DH_WindowObj,a0
		jsr	ClearObjectSlot
		move.l	#DH_OWindow_Init,obj(a0)

		lea	Hints_List,a1
		moveq	#$3F, d0
		and.b	TutorialBoxId, d0
		andi.w	#$FF,d0
		add.w	d0,d0
		add.w	d0,d0
		move.l	-4(a1,d0.w),char_pos(a0)	; load hint text
		
		tst.b	(PlacePlacePlace).w		; PLACE PLACE PLACE?
		beq.s	@noeaster			; if not, branch
		move.l	#Hint_Place,char_pos(a0)	; PLACE PLACE PLACE!
@noeaster:
		
		; Init hint window gfx
		move.b	#8,VBlankRoutine
		move.l	#DH_LoadArt, VBlankCallback
		jsr	DelayProgram			; perform vsync before operation

		tst.b	TutorialBoxId			; is "own background" bit set?
		bpl.s	DH_MainLoop			; if not, branch
		jsr	BackgroundEffects_Setup

; ---------------------------------------------------------------
; Display Hint Main Loop
; ---------------------------------------------------------------

DH_MainLoop:
		move.b	#4,VBlankRoutine
		jsr	DelayProgram

		; Apply BG effects if respective bits are set
		move.b	TutorialBoxId, d0	; is "own background" bit set?
		bpl.s	@0			; if not, branch
		jsr	BackgroundEffects_Update
		move.b	TutorialBoxId, d0	; d0 was probably corrupted, so reload it anyways

@0:		add.b	d0, d0			; is "with BG fuzz" bit set?
		bpl.s	DH_Continue		; if not, don't do fuzz
		jsr	Fuzz_TutBox		; do cinematic screen fuzz if applicable

DH_Continue:
		; Run window object code
		lea	_DH_WindowObj,a0
		lea	VDP_Ctrl, a6
		lea	VDP_Data, a5
		movea.l	obj(a0),a1
		jsr	(a1)			; run window object

		; Display other objects
		lea	Objects,a0
		moveq	#$7F,d7
		bsr	DH_DisplayObjects
		jsr	BuildSprites
		jsr	PalCycle_Load

		; palette cycle to highlight letters
		move.w	($FFFFFE0E).w,d0
		lsl.w	#4,d0
		btst	#7,(OptionsBits).w	; photosensitive mode?
		beq.s	@normal			; if not, branch
		lsr.w	#1,d0			; reduce flashing speed
@normal:
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
		andi.w	#$CCE,d0
		move.w	d0,($FFFFFB34).w
		
		; Check if it's over
		tst.b	_DH_WindowObj	; object window dead?
		bne.w	DH_MainLoop	; if not, branch
		; fallthrough

; ---------------------------------------------------------------
; Return to the game
; ---------------------------------------------------------------

DH_Quit:
		movem.l	(sp)+, a5-a6
		clr.b	TutorialBoxId			; unset text ID
		rts

; ---------------------------------------------------------------
; Loads tutorial box art during VBlank
; ---------------------------------------------------------------

DH_LoadArt:
		bsr	DH_ClearWindow			; draw window

		lea	Art_DH_WindowBorder,a1		; load border art
		lea	VDP_Data, a5
		lea	VDP_Ctrl, a6

		vram	_DH_VRAM_Border,(a6)
		moveq	#8-1,d0				; transfer 8 tiles
@0		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		dbf	d0,@0
		rts

; ---------------------------------------------------------------
; Displays in-level objects (if any)
; ---------------------------------------------------------------

DH_DisplayObjects:
		moveq	#0,d0
		tst.b	obRender(a0)
		bpl.s	@Skip
		jsr	DisplaySprite

@Skip:		lea	$40(a0),a0
		dbf	d7, DH_DisplayObjects
		rts

; ---------------------------------------------------------------
; Clear/Redraw text window
; ---------------------------------------------------------------

DH_ClearWindow:
		@base_vram: = _DH_VRAM_Base
		@size: = ($A0*$20/_DH_WindowFill_NumParts)

		rept _DH_WindowFill_NumParts
			QueueStaticDMA Art_DH_WindowFill, @size, @base_vram

			@base_vram: = @base_vram + @size
		endr
		rts

; ---------------------------------------------------------------
; Draw Character in the window
; ---------------------------------------------------------------
; INPUT:
;	d0.w	= Char
; ---------------------------------------------------------------
DH_CharOffset = $36

DH_DrawChar:
		lea	(Art_DH_Font).l,a2	; load current char
		cmpi.b	#_font2,d0		; is it a flag to make the next char have the second font?
		bne.s	@notsecondfont		; if not, branch
		lea	(Art_DH_Font2).l,a2	; use second font instead
		move.b	(a1)+,d0		; skip this flag char
		addq.l	#1,char_pos(a0)		; increase char pos
@notsecondfont:
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

@0		or.b	d4,d0			; replace transparent pixel with BG color
		ror.l	#4,d0			; rotate 1 px
		dbf	d2,@CheckPixel		; repeat for 8 pixels

@1		move.l	d0,(a5)			; send 8 px line to VRAM
		dbf	d5,@DrawLine		; repeat for 8 lines
		
		rts


; ===============================================================
; ---------------------------------------------------------------
; Object: Hint Window
; ---------------------------------------------------------------

xpos	= 8
ypos	= $A
xpos2	= $14

	if SCREEN_WIDTH=320
_StartVel = $1400
	else
_StartVel = $1540
	endif
_Accel = $B8

DH_OWindow_Init:
		st.b	(a0)				; mark slot busy
		move.b	#$80,render(a0)			; set on-screen coords, force display
		move.w	#(_DH_WindowObj_Art)+pri+tutpal1,art(a0)
		move.l	#DH_WindowObj_Map,maps(a0)
		moveq	#4,d0
		swap	d0
		move.l	d0,xpos2(a0)			; xpos
		move.w	#$80+SCREEN_HEIGHT/2,ypos(a0)	; ypos
		move.w	#_StartVel,xvel(a0)		; xvel
		move.l	#DH_OWindow_Appear,obj(a0)
		
		; backup palette, used for the fading
		lea	Pal_Active,a1
		lea	($FFFFFB80).w,a2
		moveq	#$20-1,d0
@backup:
		move.l	(a1)+,(a2)+
		dbf	d0,@backup

; ---------------------------------------------------------------

DH_OWindow_Appear:
		move.w	xvel(a0),d0		; load xvel
		sub.w	#_Accel,xvel(a0)	; decrease it
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,xpos2(a0)		; calc new xpos
		move.w	xpos2(a0),xpos(a0)	; update actual xpos
		move.w	#$80+SCREEN_WIDTH/2,d0
		cmp.w	xpos(a0),d0		; have we reaches screen center?
		ble.s	@GotoProcess		; if yes, branch

		; darken palette as box fades in
		move.b	TutorialBoxId, d0	; get tutorial id
		add.b	d0, d0			; is "with BG fuzz" bit set?
		bpl.s	@nah			; if not, branch

		move.w	#$80+SCREEN_WIDTH/2,d0	; target X pos when the tut box is centered
		sub.w	xpos(a0),d0 		; subtract current tut box X pos
		lsr.w	#4,d0			; reduce

		cmpi.b	#TutDim_Min,d0		; is result below the min value?
		bhs.s	@0			; if not, branch
		moveq	#TutDim_Min,d0		; set minimum value
@0:		cmpi.b	#TutDim_Max,d0		; is result above the max value?
		bls.s	@fadeout		; if not, branch
		moveq	#TutDim_Max,d0		; set maximum value

@fadeout:
		lea	($FFFFFB80).w,a1
		lea	Pal_Active,a2
		moveq	#$10-1,d6
		jsr	Pal_FadeAlpha_Black	; fade out first part
		; colors for the actual textbox are in between these two
		lea	($FFFFFB80+$40-8).w,a1
		lea	($FFFFFB00+$40-8).w,a2
		moveq	#$20+4-1,d6
		jsr	Pal_FadeAlpha_Black	; fade out second part

@nah:
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
@FF:		addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
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

@0		addi.w	#4*$20,vram_pos(a0)	; set pointer for next char (+4 tiles)
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
		bne.w	@ClearWindow		; if yes, make _frantic act like _cls
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
		cmpi.b	#A+Start,Joypad|Held	; exactly A+Start held?
		beq.w	@GotoDisappear		; if yes, quick quit

		move.b	Joypad|Press,d0
		andi.b	#A+B+C+Start,d0		; A/B/C/Start pressed?
		beq.s	@Return			; if not, branch
		move.l	#@ProcessChar,obj(a0)	; set main routine
		move.w	#_CooldownVal,cooldown(a0) ; set cooldown between screens
		rts

; ---------------------------------------------------------------
@ClearWindow:
		moveq	#$FFFFFFD9,d0
		jsr	PlaySound

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
		moveq	#$FFFFFFD9,d0
		jsr	PlaySound

		move.l	#DH_OWindow_Disappear,obj(a0)
		move.w	#0,xvel(a0)

; ---------------------------------------------------------------

DH_OWindow_Disappear:
		; brighten palette as box fades out
		move.b	TutorialBoxId, d0	; get tutorial id
		add.b	d0, d0			; is "with BG fuzz" bit set?
		bpl.s	@nah			; if not, branch

		move.w	xpos(a0),d0 		; get current tut box X pos (which is starting at $120 here)
		subi.w	#$120,d0		; subtract $120
		lsr.w	#2,d0			; reduce
		cmpi.b	#TutDim_Min,d0		; is result below the min value?
		bhs.s	@0			; if not, branch
		moveq	#TutDim_Min,d0		; set minimum value
@0:		cmpi.b	#TutDim_Max,d0		; is result above the max value?
		bls.s	@fadein			; if not, branch
		moveq	#TutDim_Max,d0		; set maximum value

@fadein:
		lea	($FFFFFB80).w,a1
		lea	Pal_Active,a2
		moveq	#$10-1,d6
		jsr	Pal_FadeAlpha_Black	; fade out first part
		; colors for the actual textbox are in between these two
		lea	($FFFFFB80+$40-8).w,a1
		lea	($FFFFFB00+$40-8).w,a2
		moveq	#$20+4-1,d6
		jsr	Pal_FadeAlpha_Black	; fade out second part	

@nah:
		move.w	xvel(a0),d0		; load xvel
		add.w	#_Accel,xvel(a0)	; increase it
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,xpos2(a0)		; calc new xpos
		move.w	xpos2(a0),xpos(a0)	; update actual xpos
		move.w	#$80+SCREEN_WIDTH+$50,d0
		cmp.w	xpos(a0),d0		; have we passed screen?
		ble.s	DH_KillWindow		; if yes, branch
		rts
; ---------------------------------------------------------------

DH_KillWindow:
		clr.w	(a0)			; kill windows

		; restore backed-up palette
		move.b	TutorialBoxId, d0	; get tutorial id
		add.b	d0, d0			; is "with BG fuzz" bit set?
		bpl.s	@nah			; if not, branch
		lea	($FFFFFB80).w,a1
		lea	Pal_Active,a2
		moveq	#$20-1,d0
@restore:
		move.l	(a1)+,(a2)+
		dbf	d0,@restore
@nah:
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

@0		;	 Y-pos	     WWHH	 Tile	  X-pos
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

Art_DH_WindowFill:
		dcb.b	$A0*$20/_DH_WindowFill_NumParts, (_DH_BG_Pattern_2<<4)|(_DH_BG_Pattern_2)
		even

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

Hints_List:	; note: these IDs are 1-based
		dc.l	Hint_1				; $01
		dc.l	Hint_2				; $02
		dc.l	Hint_3				; $03
		dc.l	Hint_4				; $04
		dc.l	Hint_FZEscape			; $05
		dc.l	Hint_6				; $06
		dc.l	Hint_7				; $07
		dc.l	Hint_8				; $08
		dc.l	Hint_9				; $09
		dc.l	Hint_Pre			; $0A
		dc.l	Hint_Easter_Tutorial		; $0B
		dc.l	Hint_Easter_SLZ			; $0C
		dc.l	Hint_TutorialConclusion		; $0D
		dc.l	Hint_Easter_Tutorial_Escape	; $0E
		dc.l	Hint_End_AfterCasual		; $0F
		dc.l	Hint_End_AfterFrantic		; $10
		dc.l	Hint_LP_BlackBars		; $11
		dc.l	Hint_End_BlackoutTeaser		; $12
		dc.l	Hint_Options_FranticTutorial		; $13
		dc.l	Hint_End_CinematicUnlock	; $14
		dc.l	Hint_End_MotionBlurUnlock	; $15
		dc.l	Hint_End_NonstopInhumanUnlock	; $16
		dc.l	Hint_9SequenceBreak		; $17
		dc.l	Hint_Options_CountAllMistakes	; $18

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
		elseif \char = '\'
			dc.b	_font2, $8+DH_CharOffset
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
		elseif \char = '%'
			dc.b	_font2, $28+DH_CharOffset
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
		boxtxt	"AN ACTION MOVIE..."
		boxtxt_line
		boxtxt	"WICKED CHALLENGES,"
		boxtxt	"SPEEDY MOVEMENT,"
		boxtxt	"AND explosions!"
		boxtxt_next

		boxtxt	"THE FOLLOWING STAGE"
		boxtxt	"EXPLAINS SOME OF"
		boxtxt	"THIS HACK'S UNIQUE"
		boxtxt	"GAME MECHANICS."
		boxtxt_line
		boxtxt	"PRESS a TO ACTIVATE"
		boxtxt	"AN INFO MONITOR."
		boxtxt	"read them all!"
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

		boxtxt	"CONTROLS - standing"
		boxtxt_pause
		boxtxt	" SPIN DASH"
		boxtxt	" ~ + a/b/c"
		boxtxt_line
		boxtxt	" ULTRA PEEL OUT"
		boxtxt	" ^ + a"
		boxtxt_next

		boxtxt	"AND TO JUMP, YOU"
		boxtxt	"HAVE TO PRESS-"
		boxtxt_pause
		boxtxt	"...UHH..."
		boxtxt_pause
		boxtxt	"...I FORGOT."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"    UNRELATED TO"
		boxtxt	"  CONTROLS, BUT AS"
		boxtxt	" YOU ARE PLAYING IN"
		boxtxt	"   FRANTIC, A FEW"
		boxtxt	" MONITORS WILL TELL"
		boxtxt	"    BONUS HINTS!"
		boxtxt_next
		
		boxtxt	"   FOR EXAMPLE..."
		boxtxt_pause
		boxtxt	" AFTER YOU FINISH A"
		boxtxt	"   FRANTIC STAGE,"
		boxtxt	" YOUR RINGS WILL BE"
		boxtxt	"   RESET TO zero!"
		boxtxt_end

;		 --------------------
Hint_2:
		boxtxt	"CONTROLS - airborne"
		boxtxt_pause
		boxtxt	" c - JUMP DASH"
		boxtxt_line
		boxtxt	" b - DOUBLE JUMP"
		boxtxt_pause
		boxtxt	"THESE WILL BE YOUR"
		boxtxt	"BREAD AND BUTTER!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"  TIME TICKS THREE"
		boxtxt	"   TIMES AS FAST!"
		boxtxt_pause
		boxtxt	"   THAT'S ROUGHLY"
		boxtxt	"    five minutes"
		boxtxt	"  UNTIL TIME OVER."
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
		boxtxt	" THE FLOOR IS LAVA!"
		dc.b	_pause
		boxtxt	"  WELL, SOMETIMES."
		boxtxt_pause
		boxtxt	" IN CERTAIN LEVELS,"
		boxtxt	" DON'T STAND ON THE"
		boxtxt	"  GROUND TOO MUCH!"
		boxtxt_end

;		 --------------------
Hint_4:
		boxtxt	"0Adw193q4HG5!'%q)/%4"
		boxtxt	"8ETRqZ91/D')we03()a)"
		boxtxt	"8%4mh/vq%cio!7e$cr/("
		boxtxt	"()B)f=)A=2h3401)?!G("
		boxtxt	"#x))2)aEd0a..oh mY g"
		boxtxt	"Od wHat HavE yOu Don"
		boxtxt	"e eVERythIng iS rUin"
		boxtxt	"ED Now::.2938)295)34"
		boxtxt_next

		boxtxt	"BUT HEY, YOU'VE MADE"
		boxtxt	"IT THIS FAR, SO YOU"
		boxtxt	"CLEARLY CAN'T GET"
		boxtxt	"ENOUGH OF ERAZOR!"
		boxtxt_pause
		boxtxt	"WELL, LUCKY FOR YOU,"
		boxtxt	"YOU'VE COME TO"
		boxtxt	"THE RIGHT PLACE!"
		boxtxt_next
		
		boxtxt	"   WELCOME TO THE"
		boxtxt	"easter egg info dump"
		boxtxt_pause
		boxtxt	"...BECAUSE OTHERWISE"
		boxtxt	"THERE'S NO CHANCE"
		boxtxt	"IN HELL YOU'D EVER"
		boxtxt	"KNOW THESE WERE IN"
		boxtxt	"THE GAME."
		boxtxt_next

		boxtxt	"FIRST OF ALL, HERE'S"
		boxtxt	"A LINK FOR THE FULL"
		boxtxt	"HACK SOURCE CODE."
		boxtxt_line
		boxtxt	"erazor:selbi:club"
		boxtxt_pause
		boxtxt	"NEXT, SOME SECRETS"
		boxtxt	"AND CHEATS!"
		boxtxt_next


		boxtxt	"true_bs mode"
		boxtxt_pause
		boxtxt	"HOLD abc AT ONCE"
		boxtxt	"WHILE ENTERING THE"
		boxtxt	"OPTIONS MENU! THIS"
		boxtxt	"MODE HAS NO RINGS,"
		boxtxt	"NO CHECKPOINTS, AND"
		boxtxt	"OTHER STUPID BS."
		boxtxt_next

		boxtxt	"adjust black bars"
		boxtxt_pause
		boxtxt	"GO TO THE BLACK BARS"
		boxtxt	"SETUP SCREEN AND"
		boxtxt	"HOLD b + up/down TO"
		boxtxt	"ADJUST THE HEIGHT!"
		boxtxt	"TO RESET, HOLD b AND"
		boxtxt	"THEN PRESS start."
		boxtxt_next

		boxtxt	"drunk special stages"
		boxtxt_pause
		boxtxt	"ENABLE motion blur"
		boxtxt	"AND HOLD a + up/down"
		boxtxt	"TO ROTATE A SPECIAL"
		boxtxt	"STAGE AROUND WITHOUT"
		boxtxt	"AFFECTING GRAVITY."
		boxtxt	"RIVETING VERTIGO!"
		boxtxt_next

		boxtxt	"debug mode"
		boxtxt_pause
		boxtxt	"WHEN YOU'RE IN THE"
		boxtxt	"FINAL PHASE OF THE"
		boxtxt	"SELBI SCREEN, MASH"
		boxtxt	"THE abc BUTTONS"
		boxtxt	"TWENTY TIMES!"
		boxtxt_next

		boxtxt	"level select"
		boxtxt_pause
		boxtxt	"HOLD a + start ON"
		boxtxt	"THE TITLE SCREEN"
		boxtxt	"AFTER YOU'VE ENABLED"
		boxtxt	"DEBUG MODE! PRESS a"
		boxtxt	"IN THERE TO TOGGLE"
		boxtxt	"CASUAL/FRANTIC."
		boxtxt_next


		boxtxt	"AND LASTLY, FIVE"
		boxtxt	"TIME-SAVING TRICKS"
		boxtxt	"FOR SPEEDRUNS, OR"
		boxtxt	"IF YOU EVER WANT"
		boxtxt	"TO REPLAY ERAZOR"
		boxtxt	"AND JUMP RIGHT IN!"
		boxtxt_next

		boxtxt	"speedrun pro-tip A"
		boxtxt_pause
		boxtxt	"WHILE STARTING A NEW"
		boxtxt	"GAME, HOLD a IN THE"
		boxtxt	"CASUAL/FRANTIC MENU"
		boxtxt	"TO ENABLE AUTOSKIP"
		boxtxt	"AND JUMP RIGHT INTO"
		boxtxt	"night hill place!"
		boxtxt_next

		boxtxt	"speedrun pro-tip B"
		boxtxt_pause
		boxtxt	"PRESS start TO"
		boxtxt	"SKIP THE ANIMATION"
		boxtxt	"WHEN YOU JUMP INTO"
		boxtxt	"A GIANT RING!"
		boxtxt_next

		boxtxt	"speedrun pro-tip C"
		boxtxt_pause
		boxtxt	"HOLD a + b + c TO"
		boxtxt	"SKIP LONG CUTSCENES!"
		boxtxt	"THIS INCLUDES THE"
		boxtxt	"NUKE, AS WELL AS THE"
		boxtxt	"WALKING BOMB AND"
		boxtxt	"CRABMEAT BOSSES."
		boxtxt_next
	
		boxtxt	"speedrun pro-tip D"		
		boxtxt_pause
		boxtxt	"IN CASUAL MODE, YOU"
		boxtxt	"CAN INSTANTLY SKIP"
		boxtxt	"ANY SPECIAL STAGE"
		boxtxt	"WITH a + b + c"
		boxtxt	"HELD AT ONCE!"
		boxtxt_next

		boxtxt	"speedrun pro-tip E"
		boxtxt_pause
		boxtxt	"GETTING TIRED OF ME?"
		boxtxt_pause
		boxtxt	"YOU CAN SKIP THESE"
		boxtxt	"SMALL ON-SCREEN"
		boxtxt	"TEXTBOXES BY HOLDING"
		boxtxt	"a AND THEN start!"
		boxtxt_next


		boxtxt	"AND THAT WRAPS UP"
		boxtxt	"THE INFO DUMP."
		boxtxt_line
		boxtxt	"ENJOY THESE RANDOM"
		boxtxt	"BONUS FEATURES!"
		boxtxt_pause
		boxtxt	"THERE IS JUST"
		boxtxt	"ONE LAST THING..."
		boxtxt_next

		boxtxt	" THE LEVEL IS STILL"
		boxtxt	"  A COMPLETE MESS."
		boxtxt_pause
		boxtxt	"     YES, I WAS"
		boxtxt	"      TOO LAZY"
		boxtxt	"     TO FIX IT."
		boxtxt_pause
		boxtxt	"      bite me:"
		boxtxt_end

;		 --------------------
Hint_FZEscape:
		boxtxt	"HI, AND WELCOME TO"
		boxtxt	"THE tutorial!"
		boxtxt_pause
		boxtxt	"WE'LL TAKE IT EASY,"
		boxtxt	"SINCE THERE IS"
		boxtxt	"ABSOLUTELY-"
		boxtxt_next

		boxtxt	"..."
		boxtxt_pause
		boxtxt	"UHH..."
		boxtxt_pause
		boxtxt	"YOU BETTER GET OUT"
		boxtxt	"OF HERE BEFORE THIS"
		boxtxt	"WHOLE PLACE BLOWS"
		boxtxt	"THE HELL UP."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt_line
		boxtxt	"   ...THIS GOES"
		boxtxt	"       triple"
		boxtxt	"     FOR YOU..."
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
		boxtxt	"~ + a"
		boxtxt_line
		boxtxt	"IN FRONT OF THIS"
		boxtxt	"DEVICE TO SKIP IT!"
		boxtxt_next

		boxtxt	" but remember this1"
		boxtxt_pause
		boxtxt	"     IN CASUAL,"
		boxtxt	" HARD PART SKIPPERS"
		boxtxt	"    ARE FRIENDS."
		boxtxt_pause
		boxtxt	"  IN FRANTIC, THEY"
		boxtxt	"   WANT YOU DEAD."
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"    PSSSST, HEY,"
		boxtxt	"     PRO-TIP..."
		boxtxt_line
		boxtxt	"DID YOU KNOW YOU CAN"
		boxtxt	" jumpdash downwards"
		boxtxt	"  AS WELL?! CRAZY!"
		boxtxt_end

;		 --------------------
Hint_7:
		boxtxt	"dying sucks"
		boxtxt_pause
		boxtxt	"SOME TRIAL AND ERROR"
		boxtxt	"MIGHT BE NECESSARY."
		boxtxt_line
		boxtxt	"HOWEVER, THERE ARE"
		boxtxt	"no lives ANYWHERE"
		boxtxt	"IN THIS GAME!"
		boxtxt_next

		boxtxt	"YOU WILL ALSO ONLY"
		boxtxt	"LOSE twenty rings"
		boxtxt	"ON HIT INSTEAD OF"
		boxtxt	"THE WHOLE BUNCH!"
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
		boxtxt	"   WE ADDED TAXES"
		boxtxt	"  FOR TELEPORTING!"
		boxtxt_pause
		boxtxt	" GETTING TELEPORTED"
		boxtxt	" WILL MAKE YOU LOSE"
		boxtxt	"    A FEW RINGS."
		boxtxt_next

		boxtxt_line
		boxtxt_line
		boxtxt	"     CAN'T PAY?"
		boxtxt_pause
		boxtxt_line
		boxtxt	"      YOU DIE."
		boxtxt_end

;		 --------------------
Hint_8:
		boxtxt	"hedgehog space golf"
		boxtxt_pause
		boxtxt	"MASH THE c BUTTON"
		boxtxt	"AND CONTROL YOUR"
		boxtxt	"DIRECTION WITH THE"
		boxtxt	"d_pad TO HOP AND"
		boxtxt	"DASH IN MID-AIR LIKE"
		boxtxt	"A GOLF BALL!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"  THIS IS AWKWARD."
		boxtxt	" I RAN OUT OF BONUS"
		boxtxt	"    TIPS. UHM..."
		boxtxt_pause
		boxtxt	"DID YOU KNOW THAT..."
		dc.b	_pause
		boxtxt	"   SONIC IS BLUE?"
		boxtxt_end

;		 --------------------
Hint_9:
		boxtxt	"og anti-gravity"
		boxtxt_pause
		boxtxt	"HEDGEHOG SPACE GOLF"
		boxtxt	"ISN'T YOUR THING?"
		boxtxt_line
		boxtxt	"TRY HOLDING a TO"
		boxtxt	"INVERT GRAVITY LIKE"
		boxtxt	"IN THE GOOD DAYS!"
		boxtxt_pause

		dc.b	_frantic
		boxtxt	"    frantic mode"
		boxtxt_pause
		boxtxt	"  YUP, STILL BLUE."
		boxtxt_end

Hint_9SequenceBreak:
		boxtxt	"AH. YEAH. COOL."
		boxtxt_pause
		boxtxt	"WALTZ RIGHT PAST THE"
		boxtxt	"HEDGEHOG SPACE GOLF"
		boxtxt	"BUTTON AND RUIN"
		boxtxt	"THE WHOLE TUTORIAL."
		boxtxt_pause
		boxtxt	"POOPYHEAD."
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
		boxtxt	"  AREN'T THE TRUE"
		boxtxt_line
		boxtxt	"    EASTER EGGS"
		boxtxt_line
		boxtxt	"    THE FRIENDS"
		boxtxt	"      WE MADE"
		boxtxt	"   ALONG THE WAY?"
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
		boxtxt_line
		boxtxt	"WERE YOU EXPECTING"
		boxtxt_line
		boxtxt	"ANYTHING NAUGHTY"
		boxtxt_line
		boxtxt	"UP HERE?"
		boxtxt_next

		boxtxt	"YOU ARE"
		boxtxt_line
		boxtxt_pause
		boxtxt	"CATEGORICALLY"
		boxtxt_line
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

		boxtxt	"ONE FINAL TIP..."
		boxtxt_line
		boxtxt	"YOU CAN RETURN TO"
		boxtxt	"UBERHUB PLACE"
		boxtxt	"AT ANY TIME BY"
		boxtxt	"PRESSING a WHILE"
		boxtxt	"THE GAME IS paused!"
		boxtxt_next

		boxtxt	"NOW GO OUT THERE AND"
		boxtxt	"HAVE FUN WITH"
		boxtxt_line
		boxtxt	"    SONIC erAzOR"
		boxtxt_line
		boxtxt	"I HOPE YOU'LL HAVE"
		boxtxt	"AS MUCH FUN AS I HAD"
		boxtxt	"CREATING IT!"
		boxtxt_next

		boxtxt	"  CREATED BY selbi"
		boxtxt_pause
		boxtxt	"  THEY CALL ME THE"
		boxtxt	"    michael  bay"
		boxtxt	"   OF SONIC GAMES."
		boxtxt_pause
		boxtxt	"    AND IN A BIT"
		boxtxt	"  YOU'LL KNOW WHY."
		boxtxt_end

;		 --------------------
Hint_Easter_Tutorial_Escape:
		boxtxt	"IF IT SAVES YOU THE"
		boxtxt	"TROUBLE OF COMING"
		boxtxt	"UP HERE AGAIN"
		boxtxt_pause
		boxtxt	"YOU ARE STILL"
		boxtxt	"A LOSER."
		boxtxt_end

;		 --------------------
Hint_End_AfterCasual:
		boxtxt	"CONGRATULATIONS FOR"
		boxtxt	"BEATING THE GAME IN"
		boxtxt	"casual mode!"
		boxtxt_pause
		boxtxt	"MAYBE YOU'D LIKE TO"
		boxtxt	"TRY frantic NEXT?"
		boxtxt_pause
		boxtxt	"SPEAKING OF..."
		boxtxt_NEXT

		boxtxt	"IF YOU SAW ANYTHING"
		boxtxt	"WEIRD NEAR THE END"
		boxtxt	"OF uberhub place..."
		boxtxt_pause
		boxtxt	"IGNORE IT."
		boxtxt_next

		boxtxt	"THE HORRORS BEHIND"
		boxtxt	"THAT DOOR HAVE BEEN"
		boxtxt	"SEALED AWAY FOR"
		boxtxt	"casual PLAYERS."
		boxtxt_pause
		boxtxt	"YOU MUST PROVE"
		boxtxt	"YOURSELF worthy IF"
		boxtxt	"YOU WISH TO ENTER."
		boxtxt_end

;		 --------------------
Hint_End_AfterFrantic:
		boxtxt	"CONGRATULATIONS FOR"
		boxtxt	"BEATING THE GAME IN"
		boxtxt	"frantic mode!"
		boxtxt_next

		boxtxt	"IF YOU MADE IT HERE,"
		boxtxt	"YOU'VE GOT MY"
		boxtxt	"UTMOST RESPECT."
		boxtxt_line
		boxtxt	"I'M SORRY FOR ANY"
		boxtxt	"BRAIN CELLS YOU"
		boxtxt	"MIGHT HAVE LOST"
		boxtxt	"ALONG THE WAY."
		boxtxt_end

;		 --------------------
Hint_End_BlackoutTeaser:
		boxtxt	"THE HORRORS OF"
		boxtxt	"uberhub#s end"
		boxtxt	"HAVE BEEN UNSEALED."
		boxtxt_pause
		boxtxt	"THERE IS NO ONE TO"
		boxtxt	"HELP YOU ANYMORE."
		boxtxt_pause
		boxtxt	"GOOD LUCK."
		boxtxt_end

;		 --------------------
Hint_Options_CountAllMistakes:
		boxtxt	"GETTING TELEPORTED"
		boxtxt	"OR HURT WILL GET"
		boxtxt	"TRACKED IN THE DEATH"
		boxtxt	"COUNTER AS WELL."
		boxtxt_line
		boxtxt	"DON'T WORRY, THIS IS"
		boxtxt	"COSMETIC-ONLY TO SEE"
		boxtxt	"HOW YOU'RE DOING!"
		boxtxt_next

		; TODO text for autoskip
		boxtxt	"GO STRAIGHT TO THE"
		boxtxt	"NEXT LEVEL AFTER"
		boxtxt	"BEATING ONE INSTEAD"
		boxtxt	"OF RETURNING TO"
		boxtxt	"UBERHUB PLACE."
		boxtxt_line
		boxtxt	"GREAT FOR SPEEDRUNS"
		boxtxt	"OR REPLAYS!"
		boxtxt_next

		; TODO text for flashy lights
		boxtxt	"DO NOTE THAT"
		boxtxt	"photosensitive ALSO"
		boxtxt	"DISABLES VARIOUS"
		boxtxt	"OTHER EFFECTS!"
		boxtxt_end

;		 --------------------
Hint_Options_FranticTutorial:
		boxtxt	"RESPECT FOR GOING"
		boxtxt	"WITH frantic mode!"
		boxtxt_line
		boxtxt	"SOME STUFF DIFFERS"
		boxtxt	"IN HERE, SO YOU MAY"
		boxtxt	"WANT TO REVISIT"
		boxtxt	"THE TUTORIAL."
		boxtxt_end

;		 --------------------
Hint_LP_BlackBars:
		boxtxt	"HI. SO, UH..."
		boxtxt_line
		boxtxt	"THE BLACK BARS"
		boxtxt	"DO not WORK IN"
		boxtxt	"LABYRINTHY PLACE"
		boxtxt	"FOR WATER REASONS."
		boxtxt_line
		boxtxt	"SORRY 'BOUT THAT."
		boxtxt_end

;		 --------------------
Hint_Place:
		boxtxt	"PLACE PLACE PLACE."
		boxtxt_pause
		boxtxt	"PLACE? PLACE!"
		boxtxt	"PLACE, PLACE PLACE"
		boxtxt	"PLACE PLACE PLACE?"
		boxtxt	"PLACE... PLACE!"
		boxtxt_pause
		boxtxt	"PLACE? PLACE."
		boxtxt_end

;		 --------------------
Hint_End_CinematicUnlock:
		boxtxt	"e FOR EPIC"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"cinematic mode!"
		boxtxt_pause
		boxtxt	"THE ULTIMATE FUN"
		boxtxt	"WITH A THIRD OF THE"
		boxtxt	"SCREEN IN BLACK!"
		boxtxt_end

;		 --------------------
Hint_End_MotionBlurUnlock:
		boxtxt	"r FOR RADICAL"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"visual fx!"
		boxtxt_pause
		boxtxt	"OR, AS THE MOVIE"
		boxtxt	"INDUSTRY WOULD SAY,"
		boxtxt	"DEFINITELY HD!"
		boxtxt_end

;		 --------------------
Hint_End_NonstopInhumanUnlock:
		boxtxt	"z FOR ZENITH"
		boxtxt_line
		boxtxt	"YOU HAVE UNLOCKED"
		boxtxt	"erAzOR powers!"
		boxtxt_pause
		boxtxt	"ALL HAIL OUR NEW"
		boxtxt	"OVERLORD! MAY THE"
		boxtxt	"GODS HAVE MERCY."
		boxtxt_end

; ---------------------------------------------------------------
		even