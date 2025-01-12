
; -----------------------------------------------------------------------------
; Starfield effect
;
; (c) 2025, Vladikcomper
; -----------------------------------------------------------------------------

__Screen_StarField_WithObVars:	macro
	@obBaseGfx:	equ	$2E	; .w	base art pointer
	@obXRaw:	equ	$30	; .w	raw X-position (3D-space)
	@obYRaw:	equ	$32	; .w	raw Y-position (3D-space)
	@obZRaw:	equ	$34	; .w	raw Z-position (3D-space)
	@obZVel:	equ	$36	; .w	Z-velocity
	endm

__Screen_StarField_WithConsts:	macro
	@MAX_Z_POS:	equ	$600
	@MIN_Z_POS:	equ	$100
	@INV_Z_RES:	equ	2	; inverse Z table step resolution (bits)
	@FRM_Z_RES:	equ	4	; Z-to-frame table step resolution (bits)
	endm

; -----------------------------------------------------------------------------
; Subroutine to generate starfield objects
; -----------------------------------------------------------------------------

Screen_GenerateStarfieldObjects:

	__Screen_StarField_WithObVars	; define @obXRaw, @obYRaw etc in this scope
	__Screen_StarField_WithConsts

	; ---------
	; INPUT
	; ---------

	@val_gfx:	equr	d4	; .w	Art pointer
	@obj_cnt:	equr	d6	; .w	Num stars to generate - 1

	; -----------------
	; USED REGISTERS
	; -----------------

	@xpos_base:	equr	d2
	@ypos_base:	equr	d3
	@val_render:	equr	d5

	@random:	equr	a3
	@val_maps:	equr	a4
	@obj_ptr:	equr	a5


	_assert.w @obj_cnt, ls, #78-1	; shouldn't generate more than 78 sprites

	moveq	#$20, @val_render
	move.w	#SCREEN_WIDTH/2, @xpos_base
	moveq	#SCREEN_HEIGHT/2, @ypos_base
	lea	RandomNumber, @random
	lea	Screen_Obj_StarFieldStar(pc), @obj_ptr
	lea	Screen_Obj_StarField_Sprite(pc), @val_maps

	@generate_stars_loop:
		Screen_CreateObject @obj_ptr

		move.b	@val_render, obRender(a1)
		move.w	@val_gfx, @obBaseGfx(a1)
		move.l	@val_maps, obMap(a1)

		; Generate random raw X-position within -SCREEN_WIDTH/2 .. SCREEN_WIDTH/2
		jsr	(@random)
		swap	d0
		clr.w	d0
		swap	d0
		divu.w	#SCREEN_WIDTH, d0
		ifdebug	trapv
		swap	d0			; X = rand() % SCREEN_WIDTH
		sub.w	@xpos_base, d0		; X = rand() % SCREEN_WIDTH - SCREEN_WIDTH/2
		move.w	d0, @obXRaw(a1)

		; Generate random raw Y-position within: -SCREEN_HEIGHT/2 .. SCREEN_HEIGHT/2
		jsr	(@random)
		swap	d0
		clr.w	d0
		swap	d0
		divu.w	#SCREEN_HEIGHT, d0
		ifdebug	trapv
		swap	d0			; Y = rand() % SCREEN_HEIGHT
		sub.w	@ypos_base, d0		; Y = rand() % SCREEN_HEIGHT - SCREEN_HEIGHT/2
		move.w	d0, @obYRaw(a1)

		; Generate random raw Z-position within $100..$600
		jsr	(@random)
		swap	d0
		clr.w	d0
		swap	d0
		divu.w	#@MAX_Z_POS-@MIN_Z_POS, d0
		ifdebug	trapv
		swap	d0
		add.w	#@MIN_Z_POS, d0
		_assert.w d0, lo, #@MAX_Z_POS
		move.w	d0, @obZRaw(a1)

		; Generate series of Z-velocities: 4, 8, 12, 16
		moveq	#3, d0
		and.w	@obj_cnt, d0
		addq.w	#1, d0
		lsl.w	#2, d0
		move.w	d0, @obZVel(a1)

		dbf	@obj_cnt, @generate_stars_loop
 
	rts

; =============================================================================
; -----------------------------------------------------------------------------
; Startfield star object
; -----------------------------------------------------------------------------

Screen_Obj_StarFieldStar:

	__Screen_StarField_WithObVars	; define @obXRaw, @obYRaw etc in this scope
	__Screen_StarField_WithConsts

	@var0:		equr	d0
	@var1:		equr	d1
	@inv_z:		equr	d5
	@inv_z_getter:	equr	a4
	@frm_z_getter:	equr	a5

	; Calculate 1/Z
	lea	Screen_Obj_StarField_GetInverseZ(pc), @inv_z_getter
	moveq	#-(1<<(@INV_Z_RES+1)), @var0
	and.w	@obZRaw(a0), @var0
	if @INV_Z_RES-1
		lsr.w	#@INV_Z_RES-1, @var0
	endif
	move.w	(@inv_z_getter, @var0), @inv_z

	; Get frame and priority data
	if @INV_Z_RES=@FRM_Z_RES
		inform 2, "Same table resolutions aren't supported"
	endif
	moveq	#-(1<<(@FRM_Z_RES-@INV_Z_RES+1)), @var1
	and.w	@var0, @var1
	lsr.w	#@FRM_Z_RES-@INV_Z_RES, @var1
	lea	Screen_Obj_StarField_GetFrameAndPriority(pc, @var1), @frm_z_getter

	; Project raw Y-position in 3D space to on-screen coordinates
	move.w	@obYRaw(a0), @var0
	muls.w	@inv_z, @var0			; @var0 = X / Z (24.8 FIXED)
	asl.l	#8, @var0			; @var0 = X / Z (16.16 FIXED)
	swap	@var0				; @var0 = X / Z (INTEGER)
	add.w	#SCREEN_HEIGHT/2, @var0
	cmp.w	#SCREEN_HEIGHT, @var0
	bhi.s	@sprite_offscreen
	add.w	#$80, @var0
	move.w	@var0, obScreenY(a0)

	; Project raw X-position in 3D space to on-screen coordinates
	move.w	@obXRaw(a0), @var0
	muls.w	@inv_z, @var0			; @var0 = X / Z (24.8 FIXED)
	asl.l	#8, @var0			; @var0 = X / Z (16.16 FIXED)
	swap	@var0				; @var0 = X / Z (INTEGER)
	add.w	#SCREEN_WIDTH/2, @var0
	cmp.w	#SCREEN_WIDTH, @var0
	bhi.s	@sprite_offscreen
	add.w	#$80, @var0
	move.w	@var0, obX(a0)

	; Reduce Z-coordinate to make sprite move towards camera
	move.w	@obZVel(a0), @var0
	sub.w	@var0, @obZRaw(a0)
	cmp.w	#8, @obZRaw(a0)
	bls.s	@sprite_offscreen

	; Set sprite layer and frame
	move.w	@obBaseGfx(a0), @var0
	add.b	(@frm_z_getter)+, @var0
	ifdebug bcs.s	@illegal ; relocate your art pointer (`add.b` above overflows!)
	move.w	@var0, obGfx(a0)
	move.b	(@frm_z_getter)+, obPriority(a0)
	jmp	DisplaySprite

@sprite_offscreen: ;illegal
	move.l	#Screen_Obj_StarFieldStar_Reset, obCodePtr(a0)
	rts

@illegal: ifdebug illegal

; -----------------------------------------------------------------------------
; High-level function to convert Z to sprite frame and priority
; -----------------------------------------------------------------------------

Screen_Obj_StarField_GetFrameAndPriority:
	__Screen_StarField_WithConsts	; define @MAX_Z_POS etc in this scope
	
	@return: macros frame, priority		; defines return type
		dc.b	\frame, \priority

	@Z: = 0

	while @Z <= @MAX_Z_POS
		@frame: = ((7*(@Z<<8))/@MAX_Z_POS)>>8
		@priority: = 7 - @frame

		@return @frame, @priority

		@Z: = @Z + 1<<@FRM_Z_RES
	endw	
Screen_Obj_StarField_GetFrameAndPriority_End:
	dc.w	0

; -----------------------------------------------------------------------------
; High-level function to calculate 1/Z (8.8 FIXED) given Z (8.8 FIXED)
; -----------------------------------------------------------------------------

Screen_Obj_StarField_GetInverseZ:
	__Screen_StarField_WithConsts	; define @MAX_Z_POS etc in this scope

	@return: macros val	; defines return type
		dc.w	\val

	@Z: = 0
	@return -1		; special case: Z = 0

	while @Z < @MAX_Z_POS
		@Z: = @Z + 1<<@INV_Z_RES
		@invZ: = (((1<<24)/@Z)>>8)

		@return @invZ
	endw

Screen_Obj_StarField_GetInverseZ_End:
	dc.w	0

; -----------------------------------------------------------------------------
; Subroutine to reset starfield star object
; -----------------------------------------------------------------------------

Screen_Obj_StarFieldStar_Reset:
	
	__Screen_StarField_WithObVars	; define @obXRaw, @obYRaw etc in this scope
	__Screen_StarField_WithConsts

	; Generate random raw X-position within -SCREEN_WIDTH/2 .. SCREEN_WIDTH/2
	jsr	RandomNumber
	swap	d0
	clr.w	d0
	swap	d0
	divu.w	#SCREEN_WIDTH, d0
	ifdebug	trapv
	swap	d0			; X = rand() % SCREEN_WIDTH
	sub.w	#SCREEN_WIDTH/2, d0	; X = rand() % SCREEN_WIDTH - SCREEN_WIDTH/2
	move.w	d0, @obXRaw(a0)

	; Generate random raw Y-position within: -SCREEN_HEIGHT/2 .. SCREEN_HEIGHT/2
	jsr	RandomNumber
	swap	d0
	clr.w	d0
	swap	d0
	divu.w	#SCREEN_HEIGHT, d0
	ifdebug	trapv
	swap	d0			; Y = rand() % SCREEN_HEIGHT
	sub.w	#SCREEN_HEIGHT/2, d0	; Y = rand() % SCREEN_HEIGHT - SCREEN_HEIGHT/2
	move.w	d0, @obYRaw(a0)

	; Reset Z-position
	move.w	#@MAX_Z_POS, @obZRaw(a0)

	move.l	#Screen_Obj_StarFieldStar, obCodePtr(a0)	; back to main routine
	rts

; -----------------------------------------------------------------------------
Screen_Obj_StarField_Sprite:
	dc.b -4, %00, 0, 0, -4
	even
