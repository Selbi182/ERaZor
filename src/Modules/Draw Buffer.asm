
			rsset	DrawBuffer_RAM
DrawBufferPos:		rs.w    1
DrawBuffer:		rs.b    $380-4  
DrawBuffer_End:		= __rs-4		; last 4 bytes should always be zeroed

; Check declared RAM size against limits
DrawBuffer_RAM_Size     equ     __rs-DrawBuffer_RAM
	if (DrawBuffer_RAM_Size > $380)
		inform 3, 'Draw buffer RAM structure takes too much memory (>$200 bytes)'
	endif

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to execute draw requests
; ---------------------------------------------------------------

ExecuteDrawRequests:
    if def(__DEBUG__)
	jsr     DrawBuffer_CheckOverflow(pc)
    endif

	movea.w DrawBufferPos, a1           ; Finalize buffer
	moveq   #0, d0                      ; ''
	move.l  d0, (a1)                    ; ''

	lea     DrawBuffer, a1
	lea     VDP_Ctrl, a5
	lea     -4(a5), a6

	move.l  (a1)+, d0
	beq.s   @entries_done

    @entry_loop:
	    moveq   #$1C,d1
	    and.b   (a1)+, d1               ; d1 = Request type
	    jsr     DrawBuffer_ReqOffsets(pc, d1)
	    move.l  (a1)+, d0               ; d0 = VDP Req command
	    bne.s   @entry_loop

    @entries_done:

    if def(__DEBUG__)
	subq.w  #4, a1
	cmp.w   DrawBufferPos, a1
	beq.s   @execution_ok
	RaiseError 'Draw buffer execution error', DrawBuffer_Debugger

    @execution_ok:

    endif

; ---------------------------------------------------------------
DrawBuffer_Clear:
	move.w  #DrawBuffer, DrawBufferPos
	moveq   #0, d0
	move.l  d0, DrawBuffer
	rts

; ---------------------------------------------------------------
_DR_DrawScrHoriz        equ     $00
_DR_DrawScrVert         equ     $04

DrawBuffer_ReqOffsets:
	bra.w	Draw_ScreenHoriz	; $00
	;bra.w	Draw_ScreenVertical	; $04
	;fallthrough

; ---------------------------------------------------------------
; Draws vertical line on the screen
; ---------------------------------------------------------------

Draw_ScreenVertical:
	move.w  #$8F80,(a5)             ; VDP => Set auto-increment to $80
	move.l  d0,(a5)                 ; setup start address

	lea     Draw_TransferTiles(pc),a2
	swap    d0
	move.w  d0,d1
	and.w   #$F80,d1                ; d1 = YTile * $80
	lsr.w   #7,d1                   ; d1 = YTile
	sub.w   #$20,d1                 ; d1 = YTile - $20
	neg.w   d1                      ; d1 = ($20 - YTile) = TilesSafe  -- tiles before end of col
	moveq   #0,d2
	move.b  (a1)+,d2                ; d2 = Tiles
	cmp.w   d1,d2                   ; Tiles <= TilesSafe?
	bls.s   @allsafe
	sub.w   d1,d2                   ; account for transferred tiles (d2 = Tiles -= TilesSafe)

	; Transfer safe tiles first
*@safe:
	asr.w	#1, d1			; d1 = -TilesSafe/2
	bcc.s	@safe_even		; if transfer can fit in LONGWORDS, branch
	move.w	(a1)+, (a6)		; manually transfer an extra WORD	
@safe_even:
	neg.w	d1			; d1 = -TilesSafe/2
	add.w	d1, d1			; d1 = -TilesSafe/2 * 2
	jsr	(a2,d1)			; transfer tiles

	; Set redraw position
	and.w   #$E07E,d0
	swap    d0                      ; d0 = Redraw position
	move.l  d0,(a5)                 ; VDP => set redraw location

	; Transfer the rest of the tiles
@allsafe:
	asr.w	#1, d2			; d2 = (Tiles-TilesSafe)/2
	bcc.s	@allsafe_even		; if transfer can fit in LONGWORDS, branch
	move.w	(a1)+, (a6)		; manually transfer an extra WORD
@allsafe_even:
	neg.w	d2                      ; d2 = -(Tiles-TilesSafe)/2
	add.w	d2, d2			; d2 = -(Tiles-TilesSafe)/2 * 2
	jsr	(a2,d2)
	move.w  #$8F02,(a5)             ; VDP => Set auto-increment to $02
	rts


; ---------------------------------------------------------------
; Draws horizontal line on the screen
; ---------------------------------------------------------------

Draw_ScreenHoriz:
	move.l  d0,(a5)                 ; setup start address
	lea     Draw_TransferTiles(pc),a2
	moveq   #-$80,d3
	swap    d0
	move.w  d0,d1
	and.w   #$7E,d1                 ; d1 = XTile * 2
	add.w   d3,d1                   ; d1 = XTile * 2 - $80
	neg.w   d1                      ; d1 = ($40 - XTile) * 2 = TilesSafe*2  -- tiles before end of row
	asr.w	#1, d1			; d1 = ($40 - XTile) = TilesSafe
	moveq   #0,d2
	move.b  (a1)+,d2                ; d2 = Tiles
	cmp.w   d1,d2                   ; Tiles <= TilesSafe?
	bls.s   @allsafe
	sub.w   d1,d2                   ; account for transferred tiles (d2 = Tiles -= TilesSafe)

	; Transfer safe tiles first
*@safe:
	asr.w	#1, d1			; d1 = -TilesSafe/2
	bcc.s	@safe_even		; if transfer can fit in LONGWORDS, branch
	move.w	(a1)+, (a6)		; manually transfer an extra WORD	
@safe_even:
	neg.w	d1			; d1 = -TilesSafe/2
	add.w	d1, d1			; d1 = -TilesSafe/2 * 2
	jsr	(a2,d1)			; transfer tiles

	; Set redraw position
	and.w   d3,d0
	swap    d0                      ; d0 = Redraw position
	move.l  d0,(a5)                 ; VDP => set redraw location

	; Transfer the rest of the tiles
@allsafe:
	asr.w	#1, d2			; d2 = (Tiles-TilesSafe)/2
	bcc.s	@allsafe_even		; if transfer can fit in LONGWORDS, branch
	move.w	(a1)+, (a6)		; manually transfer an extra WORD
@allsafe_even:
	neg.w	d2                      ; d2 = -(Tiles-TilesSafe)/2
	add.w	d2, d2			; d2 = -(Tiles-TilesSafe)/2 * 2
	jmp     (a2,d2)

; ---------------------------------------------------------------
; Transfer tiles stream
; ---------------------------------------------------------------

	rept 64/2
		move.l  (a1)+, (a6)
	endr

Draw_TransferTiles:
	rts


; ===============================================================
; ---------------------------------------------------------------
; Debugger routine to check buffer overflow
; ---------------------------------------------------------------

    if def(__DEBUG__)
DrawBuffer_CheckOverflow:

	; Check if pointer within bounds
	cmp.w   #DrawBuffer, DrawBufferPos
	blo.s   @out_of_bounds
	cmp.w   #DrawBuffer_End, DrawBufferPos
	bhi.s   @out_of_bounds
	rts

    @out_of_bounds:
	RaiseError 'Draw out of bounds', DrawBuffer_Debugger
    endif


; ===============================================================
; ---------------------------------------------------------------
; Debugger program
; ---------------------------------------------------------------

    if def(__DEBUG__)
DrawBuffer_Debugger:
	Console.Write "%<pal1>DrawBufferPos%<pal0>: %<pal2>%<.w DrawBufferPos>%<endl,pal1>DrawBuffer:%<endl,pal0,setx,2>"

	;bra.s  @AnalyzeBuffer
	; The code continues below ...

; ---------------------------------------------------------------
; Subroutine to analyze buffer entries
; ---------------------------------------------------------------

@readLong_safe  macro a_reg, d_reg
	subq.w  #4, sp
	move.b  (\a_reg)+, (sp)
	move.b  (\a_reg)+, 1(sp)
	move.b  (\a_reg)+, 2(sp)
	move.b  (\a_reg)+, 3(sp)
	move.l  (sp)+, \d_reg
    endm

; ---------------------------------------------------------------
@AnalyzeBuffer:
	lea     DrawBuffer, a0

@analyze_loop:
	Console.Write "%<pal2>%<.w a0>%<pal0>: "
	@readLong_safe a0, d0
	Console.Write "%<.l d0> "
	beq     @analyze_halt
	moveq   #4, d1
	and.b   (a0)+, d1                       ; d1 = Command
	cmpa.w  #DrawBuffer_End, a0
	bhs     @analyze_overflow
	jmp     @ReqOffsets(pc, d1)
    
; ---------------------------------------------------------------
@ReqOffsets:
	bra.w   @analyze_Draw_ScreenHoriz               ; $00
	bra.w   @analyze_Draw_ScreenVertical            ; $04

; ---------------------------------------------------------------
@analyze_Draw_ScreenVertical:
	moveq   #0, d0
	move.b  (a0)+, d0
	Console.WriteLine "ScrVert(n=%<.b d0>, data=...)"
	add.w   d0, d0
	adda.w  d0, a0
	bra     @analyze_loop

; ---------------------------------------------------------------
@analyze_Draw_ScreenHoriz:
	moveq   #0, d0
	move.b  (a0)+, d0
	add.w   d0, d0
	adda.w  d0, a0
	Console.WriteLine "ScrHoriz(n=%<.b d0>, data=...)"
	bra     @analyze_loop

; ---------------------------------------------------------------
@analyze_overflow:
	Console.WriteLine   "<overflow>"
	rts

; ---------------------------------------------------------------
@analyze_illegal:
	Console.WriteLine   "<illegal>"
	rts
    
; ---------------------------------------------------------------
@analyze_halt:
	rts



; ---------------------------------------------------------------
; Subroutine to display buffer
; ---------------------------------------------------------------
; INPUT:
;       d0  .w  Number of words to draw - 1
; ---------------------------------------------------------------

@DisplayBuffer:
	lea     DrawBuffer, a0
	moveq   #8-1, d1                        ; words per line

	@loop:
	    Console.Write "%<pal0>%<.w a0>%<pal0>: "

	    @line_loop:
		cmp.w   DrawBufferPos, a0
		blo.s   @0
		Console.Write "%<pal2>%<.w (a0)+>"
		dbf     d0, @line_ok
		rts

	    @0: Console.Write "%<pal3>%<.w (a0)+>"
		dbf     d0, @line_ok
		rts

	    @line_ok:
		dbf     d1, @line_loop
		moveq   #8-1, d1                        ; words per line
		Console.BreakLine
		bra     @loop

    endif

