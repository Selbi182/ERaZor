
; ===============================================================
; ---------------------------------------------------------------
; Sonic Warped
; Custom Level Renderer v.2.8
; ---------------------------------------------------------------
; (c) 2016-2017, 2020, 2024 Vladikcomper
; ---------------------------------------------------------------

VRAM_PlaneA     = $C000
VRAM_PlaneB     = $E000

				rsset   LevelRend_RAM
LevelRend_BaseVRAMOffset        rs.l    1				; Used for direct-to-VDP rendering
LevelRend_RowRedrawPos          rs.w    1				; Used for direct-to-VDP rendering
LevelRend_TransferRoutine       equ     LevelRend_BaseVRAMOffset	; Replaces "LevelRend_BaseVRAMOffset" for buffered rendering
LevelRend_TransferCommand       equ     LevelRend_RowRedrawPos		; Replaces "LevelRend_RowRedrawPos" for buffered rendering

LevelRend_LayerRAM_FG           rs.w    1+1				; FG plane RAM
LevelRend_LayerRAM_FG_End       equ     __RS				; ''

LevelRend_LayerRAM_BG           rs.w    1+4				; BG plane RAM (supports up to 4 X-layers)
LevelRend_LayerRAM_BG_End       equ     __RS				; ''

LevelRend_BG_Config		rs.l	1				; l	Points to the configuration of current level's background

LevelRend_RAM_Size              equ     __RS-LevelRend_RAM

; Check declared RAM size against limits
    if (LevelRend_RAM_Size > $18)
	inform 3, 'Level renderer RAM structure takes too much memory (>$18 bytes)'
    endif

; Make sure global constants are sane
    if SCREEN_WIDTH % 8
	inform 3, 'SCREEN_WIDTH must be multiple of 8 (Got \#SCREEN_WIDTH)'
    endif

; ---------------------------------------------------------------
; Level renderer default configurations
; ---------------------------------------------------------------
; WARNING!
;   In the (X-)layers list of each configuration, the last layer
;   should end at position no less than $0800 (Sonic 1).
;   Breaking this rule would cause crashes when attempting
;   to render at Y-position ($0000..$07FF) where no X-layer is
;   defined.
; ---------------------------------------------------------------

_LR_Layer_Normal = 0
_LR_Layer_Static = 1<<15

LevelRenderer_Config_FG:
	dcvram  VRAM_PlaneA                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYPos                         ; $0A - Camera Y-pos address
	dc.w    LevelLayout_FG                  ; $0C - Level layout address

@Layers:
	; X-layer #0
	dc.w    $7FF8                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXpos                         ; $06 - Camera X-position address

	dc.w    $0000                           ; finish layers list ...

; ---------------------------------------------------------------
LevelRenderer_DefaultConfig_BG:
	dcvram  VRAM_PlaneB                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYPos2                        ; $0A - Camera Y-pos address
	dc.w    LevelLayout_BG                  ; $0C - Level layout address

@Layers:
	; X-layer #0
	dc.w    $0800                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    512/8-1 | _LR_Layer_Static      ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	dc.w    $0000                           ; finish layers list ...

; ---------------------------------------------------------------
LevelRenderer_Config_BG_GHZ:
	dcvram  VRAM_PlaneB                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYpos2                        ; $0A - Camera Y-pos address
	dc.w    LevelLayout_BG                  ; $0C - Level layout address

@Layers:
	; X-layer #0 - Clouds
	dc.w    $0040                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	; X-layer #1 - Montains (rear)
	dc.w    $0070                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos4                        ; $06 - Camera X-position

	; X-layer #2 - Montains (near)
	dc.w    $0098                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos3                        ; $06 - Camera X-position

	; X-layer #3 - Waterfalls
	dc.w    $0800                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	dc.w    $0000                           ; finish layers list ...

; ---------------------------------------------------------------
LevelRenderer_Config_BG_MZ:
	dcvram  VRAM_PlaneB                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYpos2                        ; $0A - Camera Y-pos address
	dc.w    LevelLayout_BG                  ; $0C - Level layout address

@Layers:
	; X-layer #0 - Clouds           (Y = $200 .. $250)
	dc.w    $0250                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	; X-layer #1 - Montains         (Y = $250 .. $270)
	dc.w    $0270                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos4                        ; $06 - Camera X-position

	; X-layer #2 - Bushes
	dc.w    $0300                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos3                        ; $06 - Camera X-position

	; X-layer #3 - Interior
	dc.w    $0800                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXpos2                        ; $06 - Camera X-position

	dc.w    $0000                           ; finish layers list ...

; ---------------------------------------------------------------
LevelRenderer_Config_BG_SYZ:
	dcvram  VRAM_PlaneB                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYpos2                        ; $0A - Camera Y-pos address
	dc.w    LevelLayout_BG                  ; $0C - Level layout address

@Layers:
	; X-layer #0 - Clouds           (Y = 0 .. $80)
	dc.w    $0080                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	; X-layer #1 - Montains         (Y = $80 .. $D0)
	dc.w    $00D0                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos2                        ; $06 - Camera X-position

	; X-layer #2 - Buildings        (Y = $D0 .. $130)
	dc.w    $0130                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos3                        ; $06 - Camera X-position

	; X-layer #2 - Bushes
	dc.w    $0800                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	dc.w    $0000                           ; finish layers list ...

; ---------------------------------------------------------------
LevelRenderer_Config_BG_SBZ1:
	dcvram  VRAM_PlaneB                     ; $00 - Base VRAM address
	dc.w    0                               ; $04 - Y-displacement of rendering area (relative to camera Y-pos)
	dc.w    240/8+1-1                       ; $06 - "Height - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamYpos2                        ; $0A - Camera Y-pos address
	dc.w    LevelLayout_BG                  ; $0C - Level layout address

@Layers:
	; X-layer #0 - Clouds           (Y = 0 .. $40)
	dc.w    $0040                           ; $00 - Y-position at which this layer ends
	dc.w    0                               ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (512/8-1) | _LR_Layer_Static    ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    $0000                           ; $06 - Camera X-position

	; X-layer #1 - Brown buildings  (Y = $40 .. $E0)
	dc.w    $00E0                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos2                        ; $06 - Camera X-position

	; X-layer #2 - Buildings        (Y = $E0 .. $150)
	dc.w    $0150                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos4                        ; $06 - Camera X-position

	; X-layer #2 - Buildings (near)
	dc.w    $0800                           ; $00 - Y-position at which this layer ends
	dc.w    -$10                            ; $02 - X-displacement of rendering area (relative to camera X-pos)
	dc.w    (SCREEN_WIDTH/8+5-1) | _LR_Layer_Normal  ; $04 - "Width - 1" (in tiles) of rendering area (relative to the displacement)
	dc.w    CamXPos3                        ; $06 - Camera X-position

	dc.w    $0000                           ; finish layers list ...

; ===============================================================









; ===============================================================
; ---------------------------------------------------------------
; Subroutine to initially render level layout from start (FG)
; ---------------------------------------------------------------

LevelRenderer_DrawLayout_FG:
	lea     LevelRend_LayerRAM_FG, a1
	lea     LevelRenderer_Config_FG(pc), a0

    if def(__DEBUG__)
	bsr     LevelRenderer_DrawLayout
	cmp.w   #LevelRend_LayerRAM_FG_End, a1
	bne.w   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_DrawLayout
    endif

; ---------------------------------------------------------------
LevelRenderer_DrawLayout_FG_RAMBuffered:
	lea     LevelRend_LayerRAM_FG, a1
	lea     LevelRenderer_Config_FG(pc), a0

    if def(__DEBUG__)
	bsr     LevelRenderer_DrawLayout_RAMBuffered
	cmp.w   #LevelRend_LayerRAM_FG_End, a1
	bne.s   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_DrawLayout_RAMBuffered
    endif

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to initially render level layout from start (BG)
; ---------------------------------------------------------------

LevelRenderer_DrawLayout_BG:

LevelRenderer_DrawLayout_BG_2:	equ	@draw_direct

	cmp.w   #$0500, CurrentLevel        ; is level SBZ1?
	beq.s   @draw_bg_sbz1               ; if yes, branch

	moveq   #7, d0
	and.b   CurrentZone, d0
	add.w   d0, d0
	add.w   d0, d0
    @0: movea.l LevelRenderer_BG_Configs(pc, d0), a0

@draw_direct:
	lea     LevelRend_LayerRAM_BG, a1
	move.l  a0, LevelRend_BG_Config     ; save background configuration

    if def(__DEBUG__)
	bsr     LevelRenderer_DrawLayout
	cmp.w   #LevelRend_LayerRAM_BG_End, a1
	bhi.s   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_DrawLayout
    endif

; ---------------------------------------------------------------
@draw_bg_sbz1:
	moveq   #LevelRenderer_BG_Config_SBZ1-LevelRenderer_BG_Configs, d0
	bra.s   @0

; ---------------------------------------------------------------
; Rendering configurations for backgrounds
; ---------------------------------------------------------------

LevelRenderer_BG_Configs:
	dc.l    LevelRenderer_Config_BG_GHZ         ; $00 - GHZ
	dc.l    LevelRenderer_DefaultConfig_BG      ; $01 - LZ
	dc.l    LevelRenderer_Config_BG_MZ          ; $02 - MZ
	dc.l    LevelRenderer_DefaultConfig_BG      ; $03 - SLZ
	dc.l    LevelRenderer_Config_BG_SYZ         ; $04 - SYZ
	dc.l    LevelRenderer_DefaultConfig_BG      ; $05 - SBZ2 and FZ
	dc.l    LevelRenderer_Config_BG_GHZ         ; $06 - Ending
	
LevelRenderer_BG_Config_SBZ1:
	dc.l    LevelRenderer_Config_BG_SBZ1        ; SBZ1 special case

; ---------------------------------------------------------------

LevelRenderer_DrawLayout_BG_RAMBuffered:

LevelRenderer_DrawLayout_BG_RAMBuffered_2:	equ	@draw_direct

	cmp.w   #$0500, CurrentLevel        ; is level SBZ1?
	beq.s   @draw_bg_sbz1               ; if yes, branch

	moveq   #7, d0
	and.b   CurrentZone, d0
	add.w   d0, d0
	add.w   d0, d0
    @0: movea.l LevelRenderer_BG_Configs(pc, d0), a0

@draw_direct:
	lea     LevelRend_LayerRAM_BG, a1
	move.l  a0, LevelRend_BG_Config     ; save background configuration

    if def(__DEBUG__)
	bsr     LevelRenderer_DrawLayout_RAMBuffered
	cmp.w   #LevelRend_LayerRAM_BG_End, a1
	bhi.s   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_DrawLayout_RAMBuffered
    endif

; ---------------------------------------------------------------
@draw_bg_sbz1:
	moveq   #LevelRenderer_BG_Config_SBZ1-LevelRenderer_BG_Configs, d0
	bra.s   @0

; ===============================================================




; ===============================================================
; ---------------------------------------------------------------
; Debugger routine to raise RAM error
; ---------------------------------------------------------------

    if def(__DEBUG__)
LevelRenderer_RAM_Error:
	RaiseError  "Plane RAM pointer error%<endl>Pointer: %<pal2>%<.w a1>"
    endif

; ---------------------------------------------------------------




; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update level rendering (FG)
; ---------------------------------------------------------------

LevelRenderer_Update_FG:
	lea     LevelRend_LayerRAM_FG, a1
	lea     LevelRenderer_Config_FG, a0
    if def(__DEBUG__)
	bsr     LevelRenderer_UpdateLayout
	cmp.w   #LevelRend_LayerRAM_FG_End, a1
	bne.s   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_UpdateLayout
    endif


; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update level rendering (BG)
; ---------------------------------------------------------------

LevelRenderer_Update_BG:
	lea     LevelRend_LayerRAM_BG, a1
	movea.l LevelRend_BG_Config, a0

    if def(__DEBUG__)
	bsr     LevelRenderer_UpdateLayout
	cmp.w   #LevelRend_LayerRAM_BG_End, a1
	bhi.s   LevelRenderer_RAM_Error
	rts
    else
	bra     LevelRenderer_UpdateLayout
    endif

; ===============================================================












; ===============================================================
; ---------------------------------------------------------------
; Subroutine to initially render level layout
; ---------------------------------------------------------------
; INPUT:
;       a1      Pointer to "LevelRend_RAM"
;       a0      Layout configuration
;
; OUTPUT:
;       a1      Next slot in "LevelRend_RAM"
; ---------------------------------------------------------------

LevelRenderer_DrawLayout:
	; ERZ-specific assertions:
	assert.b VBlank_MusicOnly, ne	; a trap for naughty boys who don't respect VBlank

	lea     VDP_Data, a6

	move.l  (a0)+, LevelRend_BaseVRAMOffset     ; setup base VRAM offset for rendering
	movem.w (a0)+, d1/d6/a2-a3                  ; d1 = Y-displacement of rendering area (relative to camera Y-pos)
						    ; d6 = "Height - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a2 = Camera Y-pos address
						    ; a3 = Layout address

						    ; a0 = Layers list

	; Calculate Y-position to render from
	move.w  (a2), d5                            ; d5 = "Camera Y-pos"
	and.w   #$7F8, d5
	move.w  d5, (a1)+                           ; LevelRend_RAM => Save last camera position
	add.w   d1, d5                              ; d5 = ("Camera Y-pos" & $7F8) + "Y-displacement"

	lea     (a0), a2                            ; a2 = Pointer to the first X-layer in the list
						    ; a1 = Pointer to the first slot in Layer RAM
	;bra.s  @Process_X_Layers

; ---------------------------------------------------------------
; Subroutine to render layer
; ---------------------------------------------------------------
; INPUT:
;       a1      Layer RAM
;       a2      Layer data
;       a3      Layout address
;       d5 .w   Start Y-position
;       d6 .w   "Height - 1", number of rows available to draw
;
; OUTPUT:
;       a1      End of Layer RAM
;       a2      Next layer data
;       d5 .w   End Y-position
;       d6 .w   "Height - 1", number of rows available to draw
;
; USES:
;       d0-d4, a3-a4
; ---------------------------------------------------------------

@Process_X_Layers:
	tst.w   (a2)                                ; is layer empty?
	beq     @Process_Layers_Done

	movem.w (a2), d1-d2/d4/a4                   ; d1 = Y-position at which this layer ends
						    ; d2 = X-displacement of rendering area (relative to camera X-pos)
						    ; d4 = "Width - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a4 = Camera X-position address

	; Setup layer X-redraw position
	bclr    #15, d4                             ; this MSB is set if layer is "STATIC"
	bne.s   @xpos_static
	move.w  (a4), a4                            ; get X-pos from RAM
@xpos_static:
	move.w  a4, d0
	and.w   #-8, d0
	move.w  d0, (a1)+                           ; LevelRend_RAM => Save last camera position

	tst.w   d6                                  ; do we have tiles to draw?
	bmi.s   @layer_done                         ; if not, branch

	; Calculate number of rows to render within this layer ...
	sub.w   d5, d1                              ; d1 = Y-end - Y-start = Draw height
	bmi.s   @layer_done_cont                    ; if "Draw height" < 0, branch
	lsr.w   #3, d1                              ; d1 = Number of rows to draw
	subq.w  #1, d1                              ; d1 = Number of rows to draw - 1
	cmp.w   d6, d1                              ; d1 = Min("Number of rows to draw - 1", "Height - 1")
	bls.s   @0                                  ; ''
	move.w  d6, d1                              ; ''
@0:     sub.w   d1, d6                              ; account for rows we're about to render in the global counter
	subq.w  #1, d6  
	swap    d6                                  ; backup "global" rows counter
	move.w  d1, d6

	; Calculate start XY-position for rendering
	add.w   d0, d2                              ; d2 = "Camera X-pos" + "X-displacement"
	and.w   #-8, d2                             ; d2 = "Camera X-pos" + "X-displacement" & $FFF8
	move.w  d2, d0                              ; d0 = Start X-pos
	move.w  d5, d1                              ; d1 = Start Y-pos

	movem.l a0-a3, -(sp)
	lea     (a3), a0                            ; a0 = Layout

	; Set in-VRAM XY position for drawing ...
	lsr.w   #3-1, d2                            ; divide by 8 to get tile, multiply by 2
	and.w   #$7E, d2                            ; d2 = Xtile*2 % $80 -- in-VRAM X-disp
	move.w  d5, d3
	lsl.w   #7-3, d3                            ; divide by 8 to get tile, multiply by $80
	and.w   #$F80, d3                           ; d3 = Ytile*$80 % $1000 -- in-VRAM Y-disp
	
	; Loop for drawing layer row
	@draw_layer_row:
		bsr.w   LevelRenderer_SetDrawPosition
		movem.w d0-d4, -(sp)                        ; remember drawing position

		move.w  #$80,d7
		sub.w   d2, d7                              ; d7 = ($40 - Xtile)*2
		lsr.w   d7                                  ; d7 = ($40 - Xtile)
		subq.w  #1, d7                              ; d7 = number of tiles before updating position

		move.w  d4, d5                              ; set cols counter ...

		bsr.w   ChunkStream_Init_Horizontal         ; takes a0, d0-d1 (see above), sets d2-d3 and a2-a4

		@draw_layer_row_loop:
			jsr     (a4)                            ; STREAM =>     d0 = tile
			move.w  d0, (a6)
			dbf     d7, @noupd
			bsr     LevelRenderer_UpdateDrawPosition
		@noupd: dbf     d5, @draw_layer_row_loop

		movem.w (sp)+, d0-d4                    ; load current draw position
		addq.w  #8, d1                          ; add 8 pixels to current y-pos
		add.w   #$80, d3                        ;
		and.w   #$F80, d3                       ; d3 = Ytile*$80 % $1000 -- in VRAM Y-disp
		dbf     d6, @draw_layer_row

	swap    d6                                  ; restore "global" rows counter
	movem.l (sp)+, a0-a3

    @layer_done:
	move.w  (a2), d5                            ; set position at which this layer ends as new start position ...

    @layer_done_cont:
	addq.w  #8, a2                              ; next layer data
	bra     @Process_X_Layers

; ---------------------------------------------------------------
@Process_Layers_Done:
	rts

; ===============================================================






; ===============================================================
; ---------------------------------------------------------------
; Subroutine to initially render level using a RAM buffer
; ---------------------------------------------------------------
; NOTE: Unlike "LevelRenderer_DrawLayout" this routine renders
; layout to a 4 KiB RAM buffer and adds a request to flush it
; at the end of the frame.
;
; WARNING! This only should be called once per frame!
; ---------------------------------------------------------------
; INPUT:
;       a1      Pointer to "LevelRend_RAM"
;       a0      Layout configuration
;
; OUTPUT:
;       a1      Next slot in "LevelRend_RAM"
; ---------------------------------------------------------------

LevelRenderer_DrawLayout_RAMBuffered:
	; ERZ-specific assertions
	assert.l PLC_Pointer, eq		; we can only use it if it's not used by PLC system
	;assert.w DMAQueuePos, eq, #DMAQueue	; (optinal, but recommended) make sure no one requested DMAs this frame
	;					; this also guards from calling this routine twice per frame

	move.l  (a0)+, LevelRend_BaseVRAMOffset     ; setup base VRAM offset for rendering
	movem.w (a0)+, d1/d6/a2-a3                  ; d1 = Y-displacement of rendering area (relative to camera Y-pos)
						    ; d6 = "Height - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a2 = Camera Y-pos address
						    ; a3 = Layout address

						    ; a0 = Layers list

	; Calculate Y-position to render from
	move.w  (a2), d5                            ; d5 = "Camera Y-pos"
	and.w   #$7F8, d5
	move.w  d5, (a1)+                           ; LevelRend_RAM => Save last camera position
	add.w   d1, d5                              ; d5 = ("Camera Y-pos" & $7F8) + "Y-displacement"

	lea     (a0), a2                            ; a2 = Pointer to the first X-layer in the list
						    ; a1 = Pointer to the first slot in Layer RAM
	;bra.s  @Process_X_Layers

; ---------------------------------------------------------------
; Subroutine to render layer
; ---------------------------------------------------------------
; INPUT:
;       a1      Layer RAM
;       a2      Layer data
;       a3      Layout address
;       d5 .w   Start Y-position
;       d6 .w   "Height - 1", number of rows available to draw
;	a6	Base RAM buffer to render to (4 KiB)
;
; OUTPUT:
;       a1      End of Layer RAM
;       a2      Next layer data
;       d5 .w   End Y-position
;       d6 .w   "Height - 1", number of rows available to draw
;
; USES:
;       d0-d4, a3-a4
; ---------------------------------------------------------------

@Process_X_Layers:
	tst.w   (a2)                                ; is layer empty?
	beq     @Process_Layers_Done

	movem.w (a2), d1-d2/d4/a4                   ; d1 = Y-position at which this layer ends
						    ; d2 = X-displacement of rendering area (relative to camera X-pos)
						    ; d4 = "Width - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a4 = Camera X-position address

	; Setup layer X-redraw position
	bclr    #15, d4                             ; this MSB is set if layer is "STATIC"
	bne.s   @xpos_static
	move.w  (a4), a4                            ; get X-pos from RAM
@xpos_static:
	move.w  a4, d0
	and.w   #-8, d0
	move.w  d0, (a1)+                           ; LevelRend_RAM => Save last camera position

	tst.w   d6                                  ; do we have tiles to draw?
	bmi.w   @layer_done                         ; if not, branch

	; Calculate number of rows to render within this layer ...
	sub.w   d5, d1                              ; d1 = Y-end - Y-start = Draw height
	bmi.w   @layer_done_cont                    ; if "Draw height" < 0, branch
	lsr.w   #3, d1                              ; d1 = Number of rows to draw
	subq.w  #1, d1                              ; d1 = Number of rows to draw - 1
	cmp.w   d6, d1                              ; d1 = Min("Number of rows to draw - 1", "Height - 1")
	bls.s   @0                                  ; ''
	move.w  d6, d1                              ; ''
@0:     sub.w   d1, d6                              ; account for rows we're about to render in the global counter
	subq.w  #1, d6  
	swap    d6                                  ; backup "global" rows counter
	move.w  d1, d6

	; Calculate start XY-position for rendering
	add.w   d0, d2                              ; d2 = "Camera X-pos" + "X-displacement"
	and.w   #-8, d2                             ; d2 = "Camera X-pos" + "X-displacement" & $FFF8
	move.w  d2, d0                              ; d0 = Start X-pos
	move.w  d5, d1                              ; d1 = Start Y-pos

	movem.l a0-a3, -(sp)
	lea     (a3), a0                            ; a0 = Layout

	; Set in-RAM XY position for drawing ...
	lsr.w   #3-1, d2                            ; divide by 8 to get tile, multiply by 2
	and.w   #$7E, d2                            ; d2 = Xtile*2 % $80 -- in-VRAM X-disp
	move.w  d5, d3
	lsl.w   #7-3, d3                            ; divide by 8 to get tile, multiply by $80
	and.w   #$F80, d3                           ; d3 = Ytile*$80 % $1000 -- in-VRAM Y-disp

	; Loop for drawing layer row
	@draw_layer_row:
		; Setup initial drawing position
		move.w  d3, LevelRend_RowRedrawPos
		move.w	d3, d7
		add.w	d2, d7
		assert.w d7, lo, #$1000
		add.w	#Art_Buffer, d7
		movea.w	d7, a6				    ; a6 = draw possition in-buffer

		movem.w d0-d4, -(sp)                        ; remember drawing position

		move.w  #$80, d7
		sub.w   d2, d7                              ; d7 = ($40 - Xtile)*2
		lsr.w   d7                                  ; d7 = ($40 - Xtile)
		subq.w  #1, d7                              ; d7 = number of tiles before updating position

		move.w  d4, d5                              ; set cols counter ...

		bsr.w   ChunkStream_Init_Horizontal         ; takes a0, d0-d1 (see above), sets d2-d3 and a2-a4

		@draw_layer_row_loop:
			jsr     (a4)                            ; STREAM =>     d0 = tile
			move.w  d0, (a6)+
			dbf     d7, @noupd

			; Reset drawing position
			move.w	#Art_Buffer, d7
			add.w	LevelRend_RowRedrawPos, d7
			movea.w	d7, a6
		@noupd: dbf     d5, @draw_layer_row_loop

		movem.w (sp)+, d0-d4                    ; load current draw position
		addq.w  #8, d1                          ; add 8 pixels to current y-pos
		add.w   #$80, d3                        ;
		and.w   #$F80, d3                       ; d3 = Ytile*$80 % $1000 -- in VRAM Y-disp
		dbf     d6, @draw_layer_row

	swap    d6                                  ; restore "global" rows counter
	movem.l (sp)+, a0-a3

    @layer_done:
	move.w  (a2), d5                            ; set position at which this layer ends as new start position ...

    @layer_done_cont:
	addq.w  #8, a2                              ; next layer data
	bra     @Process_X_Layers

; ---------------------------------------------------------------
@Process_Layers_Done:
	if def(__DEBUG__)
		move.w	a1, -(sp)
	endif
	@vdp_dma_cmd: equr d7

	move.l	LevelRend_BaseVRAMOffset, @vdp_dma_cmd	    ; wa're based
	add.w	#$80, @vdp_dma_cmd			    ; we're DMA
	QueueStaticDMA Art_Buffer, $1000, @vdp_dma_cmd

	if def(__DEBUG__)
		move.w	(sp)+, a1
	endif
	rts

; ===============================================================







; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update layout map as the camera moves
; ---------------------------------------------------------------
; INPUT:
;       a1      Pointer to "LevelRend_RAM"
;       a0      Layout configuration
;
; OUTPUT:
;       a1      Next slot in "LevelRend_RAM"
; ---------------------------------------------------------------

_DrawLimitX = 8*2
_DrawLimitY = 8*2
_DrawWarpY = $800

LevelRenderer_UpdateLayout:
	movea.w DrawBufferPos, a6                   ; a6 = Draw buffer

    if def(__DEBUG__)
	pea     DrawBuffer_CheckOverflow            ; if DEBUG builds, also check for buffer overflow when finished
    endif
	
	move.l  (a0)+, d7                           ; d7 = base VRAM offset for rendering
	movem.w (a0)+, d1/d6/a2-a3                  ; d1 = Y-displacement of rendering area (relative to camera Y-pos)
						    ; d6 = "Height - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a2 = Camera Y-pos address
						    ; a3 = Layout address

	lsl.w   #3, d6                              ; d6 = Draw height - 8
						    ; a0 = Layers list

; ---------------------------------------------------------------

	; Update Y-direction
	move.w  (a1), d5                            ; d5 = LastCamYPos
	move.w  (a2), d4                            ; d4 = CamYPos
	and.w   #$7F8, d4                           ; d4 = CamYPos (aligned)
	sub.w   d5, d4                              ; d4 = CamYPos - LastCamYPos
	beq.s   @y_draw_done                        ; if position hasn't changed, branch
	bpl.s   @y_draw_chk_bottom
	
    if (_DrawWarpY)
	cmp.w   #-_DrawWarpY/2, d4
	ble.s   @y_draw_bottom_warp
    endif

@y_draw_top:
	add.w   d1, d5                              ; d5 = LastCamYPos + Y-displacement
	cmp.w   #-_DrawLimitY, d4
	bhs.s   @y_draw_top_loop
	moveq   #-_DrawLimitY, d4

    @y_draw_top_loop:
	    subq.w  #8, d5                              ; d5 = Y-position to draw at ...
	    movem.w d4-d6, -(sp)
	    bsr.s   LevelRenderer_UpdateLayout_DrawHorizontal
	    movem.w (sp)+, d4-d6
	    addq.w  #8, d4
	    bmi.s   @y_draw_top_loop
	    bra.s   @y_draw_updatepos

; ---------------------------------------------------------------
    if (_DrawWarpY)
@y_draw_top_warp:
	sub.w   #_DrawWarpY, d4
	bra.s   @y_draw_top

; ---------------------------------------------------------------
@y_draw_bottom_warp:
	add.w   #_DrawWarpY, d4
	;illegal
	bra.s   @y_draw_bottom
    endif

@y_draw_chk_bottom:
    if (_DrawWarpY)
	cmp.w   #_DrawWarpY/2, d4
	bge.s   @y_draw_top_warp
    endif

@y_draw_bottom:
	add.w   d1, d5                              ; d5 = LastCamYPos + Y-displacement
	cmp.w   #_DrawLimitY, d4
	bls.s   @y_draw_bottom_loop
	moveq   #_DrawLimitY, d4

    @y_draw_bottom_loop:
	    addq.w  #8, d5                              ; d5 = Y-position to draw at ...
	    movem.w d4-d6, -(sp)
	    add.w   d6, d5                              ; add "Draw height - 8" to the Y-position
	    bsr.s   LevelRenderer_UpdateLayout_DrawHorizontal
	    movem.w (sp)+, d4-d6
	    subq.w  #8, d4
	    bgt.s   @y_draw_bottom_loop

@y_draw_updatepos:
	move.w  d5, d0                              ; d0 = Last Camera Y-pos (w/ displacement)
	sub.w   -8(a0), d0                          ; d0 = Last Camera Y-pos (w/o displacement)
	and.w   #$7FF, d0
	move.w  d0, (a1)                            ; LevelRend_RAM => Update last camera position

@y_draw_done:

; ---------------------------------------------------------------

	; Update X-direction
	addq.w  #8, d6                              ; d6 = Draw Height
						    ; d5 = Start Y-position for drawing (with displacement)

	lea     (a0), a2                            ; a2 = Layers config
	addq.w  #2, a1                              ; next slot in "LevelRend_RAM"
	jsr     LeverRenderer_UpdateLayout_ProcessXLayers(pc)

; ---------------------------------------------------------------

	; Finalize drawing buffer
	move.w  a6, DrawBufferPos
	rts

; ===============================================================
; ---------------------------------------------------------------
; 
; ---------------------------------------------------------------
; INPUT:
;       a0      Layers list
;       a1      LevelRend RAM (saves last positions of layers)
;       a3      Level layout address
;       d5  .w  Start Y-position
;       d7  .l  Base VRAM offset
;
; USES:
;       d0-d4, a4
; ---------------------------------------------------------------

LevelRenderer_UpdateLayout_DrawHorizontal:

	movem.l a0-a3, -(sp)
	lea     -8(a0), a2

	and.w   #$7FF, d5

	; Find layer which handles the line we're about to render ...
	@find_layer:
	    addq.w  #2, a1                              ; next slot in "LevelRend_RAM"
	    addq.w  #8, a2                              ; next Layer
	    cmp.w   (a2), d5                            ; Y-start >= Y-end for this layer?
	    bhs.s   @find_layer                         ; if yes, try the next layer

	; Do not render empty layers
	tst.w   (a2)+                               ; is layer empty?
	beq.s   @done                               ; if yes, branch

	; Load layer data
	movem.w (a2), d2/d4/a4                      ; d2 = X-displacement of rendering area (relative to camera X-pos)
						    ; d4 = "Width - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a4 = Camera X-position address or immediate value

	; Calculate start X-position
	bclr    #15, d4                             ; this MSB is set if layer is "STATIC"
	bne.s   @xpos_static
	move.w  (a4), a4

@xpos_static:
	add.w   a4, d2                              ; d2 = "Camera X-pos" + "X-displacement"
	and.w   #-8, d2                             ; d2 = "Camera X-pos" + "X-displacement" & $FFF8
	move.w  d2, d0                              ; d0 = Start X-pos
	move.w  d5, d1                              ; d1 = Start Y-pos

	; Add draw request to render tiles ...
	bsr.w   LevelRenderer_CalcVRAMAddr          ; d3 = VRAM address
	move.l  d3, (a6)+                           ; BUFFER => Send start VRAM address
	move.w  d4, d2
	add.w   #(_DR_DrawScrHoriz<<8)+1, d2        ; d2 = Number of tiles to transfer
	move.w  d2, (a6)+                           ; BUFFER => Send request type and length

	if def(__DEBUG__)
	    and.w   #$FF, d2
	    add.w   d2, d2
	    add.w   a6, d2
	    move.w  d2, -(sp)
	endif

	move.w  d4, -(sp)
	lea     (a3), a0                            ; a0 = Layout
	bsr.w   ChunkStream_Init_Horizontal         ; takes a0, d0-d1 (see above), sets d2-d3 and a2-a4
	move.w  (sp)+, d4

	lea     LevelRenderer_TransferTiles(pc), a1
	sub.w   #64-1, d4                           ; d4 = "Width - 1" - 63 = "Width - 64"
	neg.w   d4                                  ; d4 = 64 - Width

    if def(__DEBUG__)
	bmi.s   @h_transfer_too_large
    endif

	add.w   d4, d4
	add.w   d4, d4                              ; d4 = 4 * (64 - Width)
	jsr     (a1, d4)                            ; transfer tiles

    if def(__DEBUG__)
	move.w  (sp)+, d2
	cmp.w   d2, a6
	bne     @draw_buffer_error
    endif

@done:
	movem.l (sp)+, a0-a3
	rts

; ---------------------------------------------------------------
@h_transfer_too_large:
    if def(__DEBUG__)
	addq.w  #2, sp                              ; skip 2 bytes that store pre-calculated draw buffer end pointer
	movem.l (sp)+, a0-a3
	RaiseError  "Horizontal transfer too large"
    endif

; ---------------------------------------------------------------
@draw_buffer_error:
    if def(__DEBUG__)
	RaiseError "Draw Buffer error (horz)"
    endif


; ===============================================================
; ---------------------------------------------------------------
; Subroutine to repeatedly process and update all X-layers
; ---------------------------------------------------------------
; INPUT:
;       a0      Layers list
;       a1      LevelRend RAM (saves last positions of layers)
;       a2      Layer data
;       a3      Level layout address
;       d5  .w  Start Y-position
;       d6  .w  Draw Height
;       d7  .l  Base VRAM offset
;
; OUTPUT:
;       a1      Next LevelRend RAM slot
;       a2      Next Layer data
;       d5  .w  Start Y-position (next)
;       d6  .w  Draw Height (remaining)
;
; USES:
;       
; ---------------------------------------------------------------

LeverRenderer_UpdateLayout_ProcessXLayers:

@process_layer_loop:
	move.w  (a2)+, d4                           ; Layer end Y-pos
	beq.w   @layers_done                        ; if layer is empty, branch

	; Get layer data ...        
	movem.w (a2)+, d2-d3/a4                     ; d2 = X-displacement of rendering area (relative to camera X-pos)
						    ; d3 = "Width - 1" (in tiles) of rendering area (relative to the displacement)
						    ; a4 = Camera X-position address

	; Calculate layer draw height on the rendering area
	sub.w   d5, d4                              ; d4 = "End Y-pos" - "Start Y-pos" = Layer draw height
	ble.s   @layer_off_screen                   ; if layer is off-screen (height <= 0), just update it
	tst.w   d6                                  ; do we have pixels to draw?
	bgt.s   @draw_layer                         ; if yes (draw height > 0), branch

@layer_off_screen:
	; If layer is off-screen, just keep it in sync with camera pos
	bclr    #15, d3                             ; this MSB is set if layer is "STATIC"
	bne.w   @skip_layer                         ; if this layer is "STATIC", don't updating it ...
	move.w  (a4), d0                            ; d0 = CamXPos
	and.w   #-8, d0                             ; d0 = CamXPos (aligned)
	move.w  d0, (a1)                            ; save the updated LastCamXPos

@skip_layer:
	addq.w  #2, a1                              ; next slot in LevelRend_RAM
	bra.s   @process_layer_loop                 ; process the next layer

; ---------------------------------------------------------------

	; Account layer height in the amount of pixels drawn;
	; Crop height if it goes off the rendering area
@draw_layer:
	cmp.w   d6, d4
	bls.s   @0
	move.w  d6, d4                              ; if "layer draw height" > "draw height", limit drawing height
@0:     sub.w   d4, d6                              ; account this layer's height in draw height ...

    if def(__DEBUG__)
	tst.w   d4
	ble.w   @illegal_draw_height
	moveq   #7, d0
	and.w   d4, d0
	bne.w   @illegal_draw_height
    endif

	; Check if this layer is static ...
	bclr    #15, d3                             ; this MSB is set if layer is "STATIC"
	bne.w   @done                               ; if this layer is "STATIC", don't bother drawing it ...

	move.w  d5, d1                              ; d1 = Start Y-position for drawing

	move.w  (a1), d0                            ; d0 = LastCamXPos (aligned)
	move.w  (a4), d5                            ; d5 = CamXPos
	and.w   #-8, d5                             ; d5 = CamXPos (aligned)
	sub.w   d0, d5                              ; d5 = CamXPos - LastCamXPos
	beq.w   @done                               ; if there's nothing to draw, branch

	; Initialize drawing from now on ...
	movem.l a0-a3, -(sp)

	swap    d6
	move.w  d3, d6
	lsl.w   #3, d6                              ; d6 = (Width - 1) * 8

	; Calculate "transfer routine" pointer
	lsr.w   #1, d4                              ; d4 = Height * 4
	move.w  d4, d3
	sub.w   #4*64, d4                           ; d4 = 4 * (Height - 64)
	neg.w   d4                                  ; d4 = 4 * (64 - Height)

    if def(__DEBUG__)
	bmi.w   @v_transfer_too_large
    endif

	lea     LevelRenderer_TransferTiles(pc), a1
	adda.w  d4, a1
	move.l  a1, LevelRend_TransferRoutine       ; save pointer to tiles transfer routine

	; Set "transfer command" (id and length)
	lsr.w   #2, d3                              ; d3 = Height
	or.w    #(_DR_DrawScrVert<<8), d3
	move.w  d3, LevelRend_TransferCommand       ; remember transfer command and length

	lea     (a3), a0                            ; a0 = Layout

	add.w   d2, d0                              ; d0 = LastCamXPos + displacement
	tst.w   d5
	bpl.s   @x_draw_right

@x_draw_left:
	cmp.w   #-_DrawLimitX, d5
	bge.s   @x_draw_left_loop
	moveq   #-_DrawLimitX, d5

    @x_draw_left_loop:
	    subq.w  #8, d0                              ; d0 = Start X-pos
							; d1 = Start Y-pos
	    movem.w d0-d2/d5, -(sp)

	    bsr.w   LevelRenderer_CalcVRAMAddr          ; d3 = VRAM address
	    move.l  d3, (a6)+                           ; BUFFER => Send start VRAM address
	    move.w  LevelRend_TransferCommand, (a6)+    ; BUFFER => Send request type and length

	    if def(__DEBUG__)
		moveq   #0, d3
		move.b  LevelRend_TransferCommand+1, d3 ; d3 = Tiles to transfer
		add.w   d3, d3
		add.w   a6, d3                          ; d3 = exprected draw buffer ptr
		move.w  d3, -(sp)
	    endif

	    bsr.w   ChunkStream_Init_Vertical           ; takes d0-d1 (see above), sets d2-d3 and a3-a4

	    movea.l LevelRend_TransferRoutine, a1
	    jsr     (a1)                                ; transfer tiles

	    if def(__DEBUG__)
		move.w  (sp)+, d3
		cmp.w   d3, a6
		bne     @draw_buffer_error
	    endif

	    movem.w (sp)+, d0-d2/d5

	    addq.w  #8, d5
	    bne.s   @x_draw_left_loop
	    bra.s   @x_draw_finalize

; ---------------------------------------------------------------
@x_draw_right:
	cmp.w   #_DrawLimitX, d5
	ble.s   @x_draw_right_loop
	moveq   #_DrawLimitX, d5

    @x_draw_right_loop:
	    addq.w  #8, d0                              ; d0 = Start X-pos
							; d1 = Start Y-pos
	    movem.w d0-d2/d5, -(sp)
	    add.w   d6, d0                              ; d0 = Start X-pos + (Draw width - 8)

	    bsr.w   LevelRenderer_CalcVRAMAddr          ; d3 = VRAM address
	    move.l  d3, (a6)+                           ; BUFFER => Send start VRAM address
	    move.w  LevelRend_TransferCommand, (a6)+    ; BUFFER => Send request type and length

	    if def(__DEBUG__)
		moveq   #0, d3
		move.b  LevelRend_TransferCommand+1, d3 ; d3 = Tiles to transfer
		add.w   d3, d3
		add.w   a6, d3                          ; d3 = exprected draw buffer ptr
		move.w  d3, -(sp)
	    endif

	    bsr.w   ChunkStream_Init_Vertical           ; takes d0-d1 (see above), sets d2-d3 and a3-a4

	    movea.l LevelRend_TransferRoutine, a1
	    jsr     (a1)                                ; transfer tiles

	    if def(__DEBUG__)
		move.w  (sp)+, d3
		cmp.w   d3, a6
		bne     @draw_buffer_error
	    endif

	    movem.w (sp)+, d0-d2/d5

	    subq.w  #8, d5
	    bne.s   @x_draw_right_loop

; ---------------------------------------------------------------
@x_draw_finalize:
	movem.l (sp)+, a0-a3
	swap    d6                                  ; restore draw height
	sub.w   d2, d0                              ; d0 = LastCamXPos (w/o displacement)
	move.w  d0, (a1)                            ; save the updated LastCamXPos

@done:  
	move.w  -8(a2), d5                          ; d5 = Start Y-pos for the next layer
	addq.w  #2, a1                              ; next slot in LevelRend_RAM
	bra     @process_layer_loop                 ; process the next layer

; ---------------------------------------------------------------
@layers_done:
	subq.w  #2, a2                              ; reset pointer to the start of this layer
	moveq   #0, d6                              ; cancel all drawing
	rts

; ---------------------------------------------------------------
@v_transfer_too_large:
    if def(__DEBUG__)
	RaiseError  "Vertical transfer too large", LevelRenderer_Debug
    endif

@draw_buffer_error:
    if def(__DEBUG__)
	RaiseError  "Draw buffer error (vert)"
    endif

; ---------------------------------------------------------------
    if def(__DEBUG__)
@illegal_draw_height:
	RaiseError  "Illegal draw height (%<.w d4 signed>)", LevelRenderer_Debug
    endif



; ===============================================================
; ---------------------------------------------------------------
; Subroutine to setup draw position
; ---------------------------------------------------------------
; INPUT:
;       d2  .w  In-VRAM X-displacement
;       d3  .w  In-VRAM Y-displacement
;
; OUTPUT:
;       d7  .l  VDP request at the specified position
; ---------------------------------------------------------------

LevelRenderer_SetDrawPosition:
	move.w  d3,LevelRend_RowRedrawPos
	move.w  d3,d7
	add.w   d2,d7
	swap    d7
	clr.w   d7
	add.l   LevelRend_BaseVRAMOffset,d7     ; d0 = VDP request to draw at desired screen position
	move.l  d7,4(a6)                        ; send request
	rts

; ---------------------------------------------------------------
; Subroutine to update redraw position on overflow
; ---------------------------------------------------------------
; WARING!
;	Don't touch D0 here!
; ---------------------------------------------------------------

LevelRenderer_UpdateDrawPosition:
	move.l  LevelRend_BaseVRAMOffset,d1
	swap    d1
	add.w   LevelRend_RowRedrawPos,d1
	swap    d1
	move.l  d1,4(a6)
	rts

; ===============================================================















; ===============================================================
; ---------------------------------------------------------------
; Subroutine to calculate VRAM address to start drawing from
; ---------------------------------------------------------------
; INPUT:
;       d0      .w      Start X-coordinate
;       d1      .w      Start Y-coordinate
;
; OUTPUT:
;       d3      .l      Target VRAM address request
; ---------------------------------------------------------------

LevelRenderer_CalcVRAMAddr:
	move.w  d0,d2
	move.w  d1,d3
	lsr.w   #3-1,d2                 ; divide X-coordinate by 8 to get tile number, multiply by 2
	and.w   #$7E,d2                 ; d2 = XTile * 2 % $80 -- X-component of VRAM location
	lsl.w   #7-3,d3                 ; divide Y-cooridnate by 8 to get tile number, multiply by $80
	and.w   #$F80,d3                ; d3 = YTile * $80 % $1000 -- Y-component of VRAM location
	add.w   d2,d3                   ; d3 = (YTile*$80 + XTile*2) -- nametable-relative VRAM offset of the desired tile
	swap    d3
	clr.w   d3
	add.l   d7,d3                   ; d3 = target VRAM address request
	rts

; ===============================================================











; ===============================================================
; ---------------------------------------------------------------
; Subroutine to transfer streamed tiles to draw buffer
; ---------------------------------------------------------------

    if def(__DEBUG__)
	rept 64*2
	    illegal
	endr
    endif

; ---------------------------------------------------------------
LevelRenderer_TransferTiles:
	rept 64         ; expects maximum of 64 tiles to cover the entire 512 pixel plane
		jsr     (a4)                    ; STREAM =>     d0 = tile
		move.w  d0, (a6)+
	endr
	rts

; ---------------------------------------------------------------
    if def(__DEBUG__)
	rept 64*2
	    illegal
	endr
    endif

; ===============================================================














; ===============================================================
; ---------------------------------------------------------------
; Subroutines to initialize chunk stream
; ---------------------------------------------------------------
; INPUT:
;       d0      .w      Start X-pos
;       d1      .w      Start Y-pos
;       a0              Level layout
;
; OUTPUT:
;       d2      .w      In-layout offset
;       d3      .w      In-chunk offset
;       a3              Blocks table
;       a4              Block fetch stream
;
; USES:
;	d4	.w
; ---------------------------------------------------------------

ChunkStream_Init_Horizontal:

	; Calculate in-chunk offset
	move.w  d0,d2
	lsr.w   #3,d2
	and.w   #$1E,d2                         ; d2 = (XBlock * 2) % $20
	move.w  d1,d3
	add.w   d3,d3                           ; d3 = (YBlock * $20)
	and.w   #$1E0,d3                        ; d3 = (YBlock * $20) % $200
	add.w   d2,d3                           ; d3 = (YBlock*$20 + XBlock*2) -- in-chunk offset

	; Load "GetBlock" stream handler depending on XTile
	lea     ChunkStream_GetBlock_Horizontal(pc), a4
	moveq	#8, d4
	and.w	d0, d4				; d4 = 0 if XTile even, 8 otherwise
	beq.s	@xfix_done
	lea     ChunkStream_GetBlock_Horizontal_OddStart(pc), a4
@xfix_done:
	lsl.w   #3, d2				; d2 = XBlock * $10
	adda.w	d2, a4				; a4 = start position inside "GetBlock" stream

	; Load "GetBlockTile" handler depending on YTile
	movea.l BlocksAddress, a3                ; a3 = Blocks array
	lea     ChunkStream_GetBlockTile_EvenRow(pc), a5
	moveq	#8, d4
	and.w	d1, d4                      	; d4 = 0 if YTile even, 8 otherwise
	beq.s   @yfix_done
	lea     ChunkStream_GetBlockTile_OddRow(pc), a5
@yfix_done:
	bra.s   ChunkStream_Load

; ---------------------------------------------------------------
ChunkStream_Init_Vertical:

	; Calculate in-chunk offset
	move.w  d0,d2
	lsr.w   #3,d2
	and.w   #$1E,d2                         ; d2 = (XBlock * 2) % $20
	move.w  d1,d3
	add.w   d3,d3
	and.w   #$1E0,d3                        ; d3 = (YBlock * $20) % $200
	move.w  d3,d4
	add.w   d2,d3                           ; d3 = (YBlock*$20 + XBlock*2) -- in-chunk offset

	; Load "GetBlock" stream handler depending on YTile
	lea     ChunkStream_GetBlock_Vertical(pc), a4
	moveq	#8, d2
	and.w	d1, d2                      	; d2 = 0 if YTile even, 8 otherwise
	beq.s	@yfix_done
	lea     ChunkStream_GetBlock_Vertical_OddStart(pc), a4
@yfix_done:
	lsr.w	#1, d4				; d4 = YBlock * $10
	move.w  d4, d2				; d2 = YBlock * $10
	lsr.w	#3, d2				; d2 = YBlock * 2
	add.w	d2, d4				; d4 = YBlock * $12
	adda.w  d4, a4				; a4 = start position inside "GetBlock" stream

	; Load "GetBlockTile" handler depending on XTile
	movea.l BlocksAddress, a3		; a3 = Blocks array
	lea     ChunkStream_GetBlockTile_EvenCol(pc), a5
	moveq	#8, d4
	and.w	d0, d4				; d4 = 0 if XTile even, 8 otherwise
	beq.s   @xfix_done
	lea     ChunkStream_GetBlockTile_OddCol(pc), a5
@xfix_done:

; ---------------------------------------------------------------
ChunkStream_Load:

	; Calculate in-layout offset
	moveq   #-1,d2                          ; WARNING: Chunks array base address should be $FF0000!
	andi.w	#$3FFF,d0			; d0 = Xpos % $4000
	asr.w   #7-1,d0                         ; d0 = Xpos/$40
	andi.w  #$700,d1                        ; d1 = Ypos % $100
	add.w   d0,d1                           ; d1 = in-layout offset
	asr.w   #2, d1                          ; d1 = (Ypos/$100 * $40) + Xpos/$100
	bmi.s   @GetNullChunk                   ; if it's out of layout, branch

	; Read desired chunk from the layout
	moveq   #$7F,d0
	and.b   (a0,d1),d0                      ; get chunk
	beq.s   @GetNullChunk
	add.w   d0,d0
	move.w  GetChunkOffset-2(pc,d0),d2

@chunk_received:
	add.w   d3,d2                           ; get current position in chunk
	movea.l d2,a2                           ; a2 = chunk offset

	; Save in-chunk and in-layout offsets for later use
						; save in-chunk offset to d3
	move.w  d1,d2                           ; save in-layout offset to d2
	rts

; ---------------------------------------------------------------
@GetNullChunk:
	move.l  #NullChunk, d2
	bra.s   @chunk_received


; ===============================================================
; ---------------------------------------------------------------
; Following routines reload chunk stream when the current chunk
; is finished
; ---------------------------------------------------------------
; INPUT:
;       d2      .w      In-layout offset
;       d3      .w      In-chunk offset
; ---------------------------------------------------------------

ChunkStream_Reload_Horizontal:
	moveq   #-1,d1                          ; WARNING: Chunks array base address should be $FF0000!
	add.w	d2,d2
	add.w	d2,d2
	addq.b  #1<<2,d2
	asr.w	#2,d2				; next in-layout offset (wraps every $40 chunks on X-axis)
	bmi.s   @GetNullChunk
	moveq   #$7F,d0
	and.b   (a0,d2),d0                      ; d0 = chunk
	beq.s   @GetNullChunk
	add.w   d0,d0
	move.w  GetChunkOffset-2(pc,d0),d1

@chunk_received:
	and.w   #$1E0,d3                        ; clear out X-displacement
	add.w   d3,d1                           ; add to chunk offset
	movea.l d1,a2                           ; a2 = chunk offset

	lea     ChunkStream_GetBlock_Horizontal(pc),a4
	jmp     (a4)

; ---------------------------------------------------------------
@GetNullChunk:
	move.l  #NullChunk, d1
	bra.s   @chunk_received

; ===============================================================
ChunkStream_Reload_Vertical:
	moveq   #-1,d1                          ; WARNING: Chunks array base address should be $FF0000!
	add.w   #$40,d2                         ; next in-layout offset
	and.w   #$1FF,d2
	bmi.s   @GetNullChunk
	moveq   #$7F,d0
	and.b   (a0,d2),d0                      ; d0 = chunk
	beq.s   @GetNullChunk
	add.w   d0,d0
	move.w  GetChunkOffset-2(pc,d0),d1

@chunk_received:
	and.w   #$1E,d3                         ; clear out Y-displacement
	add.w   d3,d1                           ; add to chunk offset
	movea.l d1,a2                           ; a2 = chunk offset

	lea     ChunkStream_GetBlock_Vertical(pc),a4
	jmp     (a4)

; ---------------------------------------------------------------
@GetNullChunk:
	move.l  #NullChunk, d1
	bra.s   @chunk_received

; ===============================================================
; ---------------------------------------------------------------
; Linear function: Returns chunk offset depending on chunk id
; ---------------------------------------------------------------

GetChunkOffset:
@disp = 0
	while @disp<$A400
		dc.w    @disp, @disp+$200
@disp = @disp + $400
	endw

; ---------------------------------------------------------------
NullChunk:
    rept $20
	dc.l    0, 0, 0, 0
    endr

; ===============================================================
; ---------------------------------------------------------------
; Handles horizontal tile streaming
; ---------------------------------------------------------------
; INPUT:
;	a2	In-block pointer
;	a4	Current position in stream code
;	a5	Get block tile base pointer:
;			= ChunkStream_GetBlockTile_EvenRow
;			= ChunkStream_GetBlockTile_OddRow
; ---------------------------------------------------------------

ChunkStream_GetBlock_Horizontal:

	rept 16
		; Blocks 0, 2, 4, 6, ...
		move.w  (a2)+,d0			; +$00	; d0 = blockId with flags
		lea	8(a4), a4			; +$02	; next stream position
		jmp	(a5)				; +$06	; use "EverRow" or "OddRow" 2 tiles handler

		; Blocks 1, 3, 5, 7, ...
		swap	d0				; +$08	; WARNING! This assumes D0 wasn't touched since the last call
		lea	8(a4), a4			; +$0A	; next stream position
		rts					; +$0E
		; Total getter size: $10 bytes
	endr

	jmp     ChunkStream_Reload_Horizontal(pc)	; reload stream when finished

; ---------------------------------------------------------------
ChunkStream_GetBlock_Horizontal_OddStart:

@GetNextEvenBlock:	equ	ChunkStream_GetBlock_Horizontal-ChunkStream_GetBlock_Horizontal_OddStart+$10
@GetRightTile:		equ	ChunkStream_GetBlockTile_TopRight-ChunkStream_GetBlockTile_EvenRow

	rept 16
		; Blocks 1, 3, 5, 7, ...
		move.w	(a2)+,d0			; +$00	; d0 = blockId with flags
		lea	@GetNextEvenBlock(a4), a4	; +$02	; jump to "ChunkStream_GetBlock_Horizontal" for the next block
		jmp	@GetRightTile(a5)		; +$06	; use "TopRight" or "BottomRight" tile handler

		; Padding to keep getter size at $10 bytes (same as "ChunkStream_GetBlock_Horizontal")
		if def(__DEBUG__)
			illegal				; +$0A
			illegal				; +$0C
			illegal				; +$0E
		else
			; Failsafe in case we reach unreachable code
			nop				; +$0A
			nop				; +$0C
			nop				; +$0E
		endif
		; Total getter size: $10 bytes
	endr

	if def(__DEBUG__)
		illegal
	else
		; Failsafe in case we reach unreachable code
		jmp     ChunkStream_Reload_Horizontal(pc)	; reload stream when finished
	endif



; ---------------------------------------------------------------
; Handles vertical tile streaming
; ---------------------------------------------------------------
; INPUT:
;	a2	In-block pointer
;	a4	Current position in stream code
;	a5	Get block tile base pointer:
;			= ChunkStream_GetBlockTile_EvenCol
;			= ChunkStream_GetBlockTile_OddCol
; ---------------------------------------------------------------

ChunkStream_GetBlock_Vertical:

	rept 16
		; Blocks 0, 2, 4, 6, ...
		move.w  (a2), d0			; +$00	; d0 = blockId with flags
		lea     $20(a2), a2			; +$02
		lea	$C(a4), a4			; +$06	; next stream position
		jmp     (a5)				; +$0A	; call block handler

		; Blocks 1, 3, 5, 7, ...
		swap	d0				; +$0C	; WARNING! This assumes D0 wasn't touched since the last call
		addq.w	#6, a4				; +$0E	; next stream position
		rts					; +$10
		; Total getter size: $12 bytes
	endr

	jmp     ChunkStream_Reload_Vertical(pc)		; reload stream when finished

; ---------------------------------------------------------------
ChunkStream_GetBlock_Vertical_OddStart:

@GetNextEvenBlock:	equ	ChunkStream_GetBlock_Vertical-ChunkStream_GetBlock_Vertical_OddStart+$12
@GetBottomTile:		equ	ChunkStream_GetBlockTile_BottomLeft-ChunkStream_GetBlockTile_EvenCol

	rept 16
		; Blocks 1, 3, 5, 7, 9, ...
		move.w  (a2),d0                         ; +$00	; d0 = blockId with flags
		lea     $20(a2),a2			; +$02
		lea     @GetNextEvenBlock(a4),a4	; +$06	; next stream position
		jmp     @GetBottomTile(a5)		; +$0A	; call block handler

		; Padding to keep getter size at $12 bytes (same as "ChunkStream_GetBlock_Vertical")
		if def(__DEBUG__)
			illegal				; +$0E
			illegal				; +$10
		else
			nop				; +$0E
			nop				; +$10
		endif
		; Total getter size: $12 bytes		
	endr

	if def(__DEBUG__)
		illegal
	else
		; Failsafe in case we reach unreachable code
		jmp     ChunkStream_Reload_Vertical(pc)	; reload stream when finished
	endif



; ===============================================================
; ---------------------------------------------------------------
; Get block tile functions for horiszontal streaming
; ---------------------------------------------------------------

ChunkStream_GetBlockTile_EvenRow:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.l	(a3,d4),d0		; d0 = 2 tiles with flags
	swap	d0			; first tile should be in the lower word
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.l	4(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l	#$10001000,d0		; apply Y-flipping
	swap	d0			; first tile should be in the lower word
	rts

@FlipX: and.w	#$3FF8,d4		; d4 = blockId*8 (clear XY bits)
	move.l	(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l	#$08000800,d0		; apply X-flipping
	rts

@FlipXY:
	move.l	4(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l   #$18001800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_TopRight:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w  2(a3,d4),d0             ; d0 = tile with flags
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w  6(a3,d4),d0             ; d1 = tile with flags
	eor.w   #$1000,d0               ; apply Y-flipping
	rts

@FlipX: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	move.w  (a3,d4),d0		; d0 = tile with flags
	eor.w   #$800,d0                ; apply X-flipping
	rts

@FlipXY:
	move.w  4(a3,d4),d0		; d0 = tile with flags
	eor.w   #$1800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_OddRow:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.l	4(a3,d4),d0		; d0 = 2 tiles with flags
	swap	d0			; first tile should be in the lower word
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.l	(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l	#$10001000,d0		; apply Y-flipping
	swap	d0			; first tile should be in the lower word
	rts

@FlipX: and.w	#$3FF8,d4		; d4 = blockId*8 (clear XY bits)
	move.l	4(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l	#$8000800,d0		; apply X-flipping
	rts

@FlipXY:
	move.l	(a3,d4),d0		; d0 = 2 tiles with flags
	eor.l   #$18001800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_BottomRight:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w  6(a3,d4),d0		; d0 = tile with flags
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w	2(a3,d4),d0		; d1 = tile with flags
	eor.w   #$1000,d0               ; apply Y-flipping
	rts

@FlipX: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	move.w  4(a3,d4),d0		; d0 = tile with flags
	eor.w   #$800,d0                ; apply X-flipping
	rts

@FlipXY:
	move.w	(a3,d4),d0		; d0 = tile with flags
	eor.w	#$1800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------

@TR2:	equ	ChunkStream_GetBlockTile_EvenRow
@TR:	equ	ChunkStream_GetBlockTile_TopRight
@BR2:	equ	ChunkStream_GetBlockTile_OddRow
@BR:	equ	ChunkStream_GetBlockTile_BottomRight

	if (@TR-@TR2<>@BR-@BR2)
		; This means jump table tricks for seamlessly
		; switching between functions won't work
		inform 2, "Horizontal block tile function locations or sizes are inconsistent"
	endif

; ---------------------------------------------------------------



; ===============================================================
; ---------------------------------------------------------------
; Get block tile functions (2 tiles at once)
; ---------------------------------------------------------------

ChunkStream_GetBlockTile_EvenCol:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w	4(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	(a3,d4),d0
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w	(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	4(a3,d4),d0
	eor.l	#$10001000,d0		; apply Y-flipping
	rts

@FlipX: and.w	#$3FF8,d4		; d4 = blockId*8 (clear XY bits)
	move.w	6(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	2(a3,d4),d0
	eor.l	#$8000800,d0		; apply X-flipping
	rts

@FlipXY:
	move.w	2(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	6(a3,d4),d0
	eor.l   #$18001800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_BottomLeft:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w  4(a3,d4),d0		; d0 = tile with flags
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w	(a3,d4),d0		; d1 = tile with flags
	eor.w   #$1000,d0               ; apply Y-flipping
	rts

@FlipX: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	move.w  6(a3,d4),d0		; d0 = tile with flags
	eor.w   #$800,d0                ; apply X-flipping
	rts

@FlipXY:
	move.w	2(a3,d4),d0		; d0 = tile with flags
	eor.w	#$1800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_OddCol:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w	6(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	2(a3,d4),d0
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w	2(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	6(a3,d4),d0
	eor.l	#$10001000,d0		; apply Y-flipping
	rts

@FlipX: and.w	#$3FF8,d4		; d4 = blockId*8 (clear XY bits)
	move.w	4(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	(a3,d4),d0
	eor.l	#$8000800,d0		; apply X-flipping
	rts

@FlipXY:
	move.w	(a3,d4),d0
	swap	d0			; first tile should be in the lower word
	move.w	4(a3,d4),d0
	eor.l   #$18001800,d0		; apply XY-flipping
	rts

; ---------------------------------------------------------------
ChunkStream_GetBlockTile_BottomRight2:
	lsl.w   #3,d0                   ; d0 = blockId*8 with flags
	move.w  d0,d4
	bmi.s	@FlipY			; MSB=1 means FlipY=1
	add.w   d0,d0
	bmi.s   @FlipX			; MSB=1 means FlipX=1
	move.w  6(a3,d4),d0		; d0 = tile with flags
	rts

@FlipY: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	add.w   d0,d0
	bmi.s   @FlipXY			; MSB=1 means FlipX=1
	move.w	2(a3,d4),d0		; d1 = tile with flags
	eor.w   #$1000,d0               ; apply Y-flipping
	rts

@FlipX: and.w   #$3FF8,d4               ; d4 = blockId*8 (clear XY bits)
	move.w  4(a3,d4),d0		; d0 = tile with flags
	eor.w   #$800,d0                ; apply X-flipping
	rts

@FlipXY:
	move.w	(a3,d4),d0		; d0 = tile with flags
	eor.w	#$1800,d0		; apply XY-flipping
	rts	

; ---------------------------------------------------------------

@BL2:	equ	ChunkStream_GetBlockTile_EvenCol
@BL:	equ	ChunkStream_GetBlockTile_BottomLeft
@BR2:	equ	ChunkStream_GetBlockTile_OddCol
@BR:	equ	ChunkStream_GetBlockTile_BottomRight2

	if (@BL-@BL2<>@BR-@BR2)
		; This means jump table tricks for seamlessly
		; switching between functions won't work
		inform 2, "Vertical block tile function locations or sizes are inconsistent"
	endif


; ===============================================================










; ===============================================================
; ---------------------------------------------------------------
; Debugger program
; ---------------------------------------------------------------

    if def(__DEBUG__)

LevelRenderer_Debug2:
	RaiseError  "Level Renderer Debuger Trap", LevelRenderer_Debug

LevelRenderer_Debug:
	Console.Write   "BaseVRAMOffset = %<.l LevelRend_BaseVRAMOffset>%<endl>"
	Console.Write   "RowRedrawPos   = %<.w LevelRend_RowRedrawPos>%<endl>"
	Console.Write   "LayerRAM_FG:   = %<.w LevelRend_LayerRAM_FG> %<.w LevelRend_LayerRAM_FG+2>%<endl>"
	Console.Write   "LayerRAM_BG:   = %<.w LevelRend_LayerRAM_BG> %<.w LevelRend_LayerRAM_BG+2> %<.w LevelRend_LayerRAM_BG+4> %<.w LevelRend_LayerRAM_BG+6>%<endl>"

	Console.Write   "%<endl>DrawBuffer:%<endl>"

	lea     DrawBuffer, a0
	moveq   #8, d0

	@loop:
	    Console.Write   "%<.l (a0)+> %<.l (a0)+> %<.l (a0)+> %<.l (a0)+>%<endl>"
	    dbf     d0, @loop

	rts

    endif
