; ---------------------------------------------------------------------------
; Sound Test Screen
; ---------------------------------------------------------------------------

SoundTestScreen:
	; Obligatory part to clean up after previous game mode
	moveq	#$FFFFFFE4, d0
	jsr	PlaySound_Special ; stop music
	jsr	PLC_ClearQueue
	jsr	Pal_FadeFrom
	jsr	DrawBuffer_Clear

	move.w	#NullInt, VBlankSubW
	ints_disable			; we can do it since music is stopped
	display_disable

	jsr	BlackBars.Reset		; Black bars aren't supported
	jsr	BlackBars.VBlankUpdate	; make Black bars restore VDP settings

	bsr	SoundTest_SetupVDP

	; Clear object RAM
	lea	Objects, a1
	moveq	#0, d0
	move.w	#(Objects_End-Objects)/$40-1, d1

	@clear_obj_ram_loop:
		rept $40/4
			move.l	d0, (a1)+
		endr
		dbf	d1, @clear_obj_ram_loop

	assert.w a1, eq, #Objects_End

	; Init HScroll buffer
	@hscroll_value: = (320-SoundTest_Visualizer_Width*8)/2

	lea	SoundTest_HScrollBuffer, a1
	moveq	#28/2-1, d1
	move.l	#(@hscroll_value<<16)|(@hscroll_value), d0

	@init_hscroll_buffer_loop:
		move.l	d0, (a1)+
		dbf	d1, @init_hscroll_buffer_loop

	; Load screen palette
	lea	Pal_Target, a0
	lea 	SoundTest_Palette(pc), a1
	rept 128/4
		move.l	(a1)+, (a0)+
	endr

	lea	Pal_Active, a0		; fill current palette with black
	moveq	#0, d0
	rept 128/4
		move.l	d0, (a0)+
	endr

	; Load all compressed graphics
	lea	SoundTest_PLC_List(pc), a1
	jsr	LoadPLC_Direct
	jsr	PLC_ExecuteOnce_Direct

	SoundTest_CreateObject #SoundTest_Obj_TrackSelector
	SoundTest_CreateObject #SoundTest_Obj_Header
	SoundTest_CreateObject #SoundTest_Obj_BGPaletteEffect
	SoundTest_CreateObject #SoundTest_Obj_DummyHL
	jsr	SoundTest_CreateNoteEmitters

	; Load/render Plane B
	lea	SoundTest_BG2_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#(SoundTest_BG_VRAM/$20), d0
	jsr	EniDec
	vramWrite $FF0000, $2000, SoundTest_PlaneB_VRAM

	; Load piano mappings
	lea	SoundTest_Piano_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#$8000|$6000|(SoundTest_Piano_VRAM/$20), d0
	jsr	EniDec

	vram	SoundTest_PlaneA_VRAM+$A00, d0
	lea	$FF0000, a1
	moveq	#36-1, d1
	moveq	#3-1, d2
	jsr	ShowVDPGraphics

	; Draw top separator
	@pat_1:	= (SoundTest_UIBorderOverlay_VRAM/$20+4*17)|$8000|$6000
	@pat_2:	= (SoundTest_UIBorderOverlay_VRAM/$20+4*17+1)|$8000|$6000

	@fill_value:	equr	d0
	@vdp_ctrl:	equr	a5
	@vdp_data:	equr	a6

	lea	VDP_Ctrl, @vdp_ctrl
	lea	VDP_Data-VDP_Ctrl(@vdp_ctrl), @vdp_data
	vram	SoundTest_PlaneA_VRAM+$180, (@vdp_ctrl)

	move.l	#(@pat_1<<16)|(@pat_1), @fill_value
	move.w	#@pat_2, (@vdp_data)
	rept (SoundTest_Visualizer_Width-1) / 2
		move.l	@fill_value, (@vdp_data)
	endr
	if (SoundTest_Visualizer_Width-1) % 2
		move.w	@fill_value, (@vdp_data)
	endif
	move.w	#@pat_2, (@vdp_data)

	move.b	#$10, SoundTest_FadeCounter		; prepare fade in

	; Screen init
	SoundTest_ResetVRAMBufferPool
	sf.b	SoundTest_ExitFlag
	jsr	SoundTest_VDeform_Init
	jsr	SoundTest_Visualizer_Init
	jsr	ObjectsLoad
	jsr	BuildSprites

	display_enable
	move.w	#SoundTest_VBlank, VBlankSubW

; ---------------------------------------------------------------------------
SoundTest_MainLoop:
	st.b	VBlankRoutine
	jsr	DelayProgram
	bsr	SoundTest_VDeform_Update
	assert.w SoundTest_VRAMBufferPoolPtr, eq, #Art_Buffer		; VRAM buffer pool should be reset by the beginning of the frame
	SoundTest_InitWriteRequests
	jsr	ObjectsLoad
	jsr	BuildSprites
	SoundTest_FinalizeWriteRequests a0
	bsr	SoundTest_Visualizer_Update
	bsr	SoundTest_UpdateFading

	tst.b	SoundTest_ExitFlag			; exit flag set?
	beq	SoundTest_MainLoop			; if not, branch
	tst.b	SoundTest_FadeCounter			; faded out?
	bne	SoundTest_MainLoop			; if not, branch
	; fallthrough

; ---------------------------------------------------------------------------
SoundTest_Exit:
	move.w	#$8C81, VDP_Ctrl		; disable S&H
	move.w	#VBlank, VBlankSubW		; restore Sonic 1's VBlank
	jmp	Exit_SoundTestScreen

; ---------------------------------------------------------------------------
; Controls screen fade in/out sequences
; ---------------------------------------------------------------------------

SoundTest_UpdateFading:
	move.b	SoundTest_FadeCounter, d0	; is fading requested?
	beq.s	@ret				; if not, branch
	bmi.s	@fade_out
	subq.b	#1, d0
	move.b	d0, SoundTest_FadeCounter
	jmp	SoundTest_SingleFadeTo

@fade_out:
	addq.b	#1, d0
	move.b	d0, SoundTest_FadeCounter
	jmp	SoundTest_SingleFadeFrom

@ret:	rts

; ---------------------------------------------------------------------------
SoundTest_SingleFadeTo:
	; INPUT:
	;	d0.w	Fade factor ($F = max, $0 = no fading)

	lea	Pal_Active, a0
	lea	Pal_Target, a1
	moveq	#$40-1, d5		; d5 -> Fade length
	andi.b	#$E, d0			; make sure fade factor is correct
	move.b	d0, d1
	lsl.b	#4, d1			; d1 -> Fade Factor (2nd channel)

	@ParseColors:
		move.b	(a1)+,d2		; d2 -> B
		sub.b	d0,d2			; d2 -> B' (faded)
		bcc.s	@outB
		moveq	#0, d2
	@outB:	move.b	d2,(a0)+		; output B'

		move.b	(a1)+, d2		; d2 -> GR
		move.b	d2, d3
		andi.b	#$E0, d3		; d3 -> G0
		sub.b	d1, d3			; d3 -> G'0
		bcc.s	@endG
		moveq	#0, d3
	@endG:
		andi.b	#$E, d2			; d2 -> R
		sub.b	d0, d2			; d2 -> R'
		bcc.s	@endR
		moveq	#0, d2
	@endR:
		or.b	d2, d3			; d3 -> G'R'
		move.b	d3, (a0)+		; output G'R'
		
		dbf	d5, @ParseColors

	assert.w a0, eq, #Pal_Active+$80
	rts

; ---------------------------------------------------------------------------
SoundTest_SingleFadeFrom:
	lea	Pal_Active, a0
	moveq	#$40-1, d5		; d5 -> Fade length

	@ParseColors:
		tst.b	(a0)+			; is B zero?
		beq.s	@Green			; if yes, branch
		subq.b	#2,-1(a0)		; decrease B

	@Green: move.b	(a0),d2			; d2 -> GR
		move.b	d2,d3
		andi.b	#$E0,d2			; d2 -> G0
		beq.s	@Red
		subi.b	#$20,d2

	@Red:	andi.b	#$E,d3			; d3 -> 0R
		beq.s	@GRout
		subq.b	#2,d3

	@GRout: or.b	d2,d3
		move.b	d3,(a0)+
		dbf	d5, @ParseColors

	assert.w a0, eq, #Pal_Active+$80
	rts

; ---------------------------------------------------------------------------
; Screen objects/controllers
; ---------------------------------------------------------------------------

	include	"Screens/SoundTestScreen/Objects/Header.asm"

	include	"Screens/SoundTestScreen/Objects/NoteEmitters.asm"

	include	"Screens/SoundTestScreen/Objects/DummyHL.asm"

	include	"Screens/SoundTestScreen/Objects/TrackSelector.asm"

	include	"Screens/SoundTestScreen/Objects/BGPaletteEffect.asm"

; ---------------------------------------------------------------------------
; Pattern load cues list for all Sound Test screen graphics
; ---------------------------------------------------------------------------

SoundTest_PLC_List:
	dc.l	SoundTest_BG2_TilesKospM
	dc.w	SoundTest_BG_VRAM

	dc.l	SoundTest_Piano_TilesKospM
	dc.w	SoundTest_Piano_VRAM

	dc.l	SoundTest_PianoOverlays_TilesKospM
	dc.w	SoundTest_PianoOverlays_VRAM

	dc.l	SoundTest_Font_KospM
	dc.w	SoundTest_Font_VRAM

	dc.l	ArtKospM_LevelSigns
	dc.w	SoundTest_HeaderFont_VRAM

	dc.l	SoundTest_UIBorderOverlay_Tiles_KospM
	dc.w	SoundTest_UIBorderOverlay_VRAM

	dc.w	-1	; end marker

; ---------------------------------------------------------------------------
; Sound Test Screen
; ---------------------------------------------------------------------------

SoundTest_SetupVDP:

	@vdp_ctrl:	equr	a5
	@vdp_data:	equr	a6

	lea	VDP_Ctrl, @vdp_ctrl
	lea	VDP_Data-VDP_Ctrl(@vdp_ctrl), @vdp_data

	; Setup VDP registers
	@loop_cnt:	equr	d6
	@vdp_regs:	equr	a2

	lea	@VDPRegistersList(pc), @vdp_regs
	moveq	#@VDPRegistersList.Size-1, @loop_cnt

	@setup_vdp_loop:
		move.w	(@vdp_regs)+, (@vdp_ctrl)
		dbf	@loop_cnt, @setup_vdp_loop

	; Clear-fill Plane A (the logical one)
	@fill_value:	equr	d0

	vram	SoundTest_PlaneA_VRAM, (@vdp_ctrl)
	move.l	#$80008000, @fill_value
	move.w	#$1000/$20-1, @loop_cnt
	
	@clear_plane_a_loop:
		rept $20/4
			move.l	@fill_value, (@vdp_data)
		endr
		dbf	@loop_cnt, @clear_plane_a_loop

	; Init HScroll buffer
	@hscroll_value: = (320-SoundTest_Visualizer_Width*8)/2

	move.l	#(@hscroll_value<<16)|(@hscroll_value), d0
	move.w	#$8F20, (@vdp_ctrl)

	vram	$FC00, (@vdp_ctrl)
	moveq	#28/2-1, d1
	@fill_plane_a_hscroll:
		move.l	d0, (@vdp_data)
		dbf	d1, @fill_plane_a_hscroll

	vram	$FC02, (@vdp_ctrl)
	moveq	#28/2-1, d1
	@fill_plane_b_hscroll:
		move.l	d0, (@vdp_data)
		dbf	d1, @fill_plane_b_hscroll

	move.w	#$8F02, (@vdp_ctrl)

	rts

; ---------------------------------------------------------------------------
@VDPRegistersList:
	dc.w	$8004
	dc.w	$8200|(SoundTest_PlaneB_VRAM/$400)	; Plane A address
	dc.w	$8400|(SoundTest_PlaneA_VRAM/$2000)	; Plane B address
	dc.w	$8C81+8		; enable S&H
	dc.w	$9011		; set plane size to 64x64
	dc.w	$8B02		; VScroll: full, HScroll: 1-tile
	dc.w	$8700

@VDPRegistersList.Size:	equ (*-@VDPRegistersList)/2


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine for Vertical deformation effects
; ---------------------------------------------------------------------------

SoundTest_VDeform_Init:
	move.l	#(SoundTest_VScrollBuffer1<<16)|(SoundTest_VScrollBuffer2&$FFFF), SoundTest_VScrollBufferPtrSwapper
	; fallthrough

; ---------------------------------------------------------------------------
SoundTest_VDeform_Update:

	@var0:			equr	d0
	@vscroll_value:		equr	d3
	@plane_height:		equr	d4
	@scanline:		equr	d5

	@vscroll_buffer:	equr	a0
	@distort_stream:	equr	a1

	movea.w	SoundTest_NextVScrollBufferPtr,  @vscroll_buffer	; load buffer for the next frame

	lea	Sine_Data-2, @distort_stream
	addi.l	#$C000, CamYPos3
	move.w	#$FF, @var0
	and.w	CamYPos3, @var0
	add.w	@var0, @var0
	adda.w	@var0, @distort_stream

	move.w	#$100, @plane_height

	; TODO: Optimize out "rept", use DBF, 2 scanlines in a loop (for easy interlaced BG effect)
	@current_scanline: = 0
	rept 224
		if @current_scanline < 128
			moveq	#@current_scanline, @scanline
		else
			moveq	#$FFFFFF00|@current_scanline, @scanline
		endif

		; Render highlighted BG between scanlines 32 .. 32+SoundTest_Visualizer_Height*8
		if (@current_scanline >= 32) & (@current_scanline < (32 + SoundTest_Visualizer_Height*8 + 8*3))
			moveq	#0, @vscroll_value
			move.l	(@distort_stream)+, @var0
			asr.w	#2, @var0
			if @current_scanline % 2
				add.b	@var0, @vscroll_value
			else
				sub.b	@var0, @vscroll_value
			endif
			add.b	@vscroll_value, @scanline
			bcs.s	@scanline_\#@current_scanline\_ok
			add.w	@plane_height, @vscroll_value
		@scanline_\#@current_scanline\_ok:
			move.w	@vscroll_value, (@vscroll_buffer)+

		; Render normal BG otherwise
		else
			moveq	#0, @vscroll_value
			move.l	(@distort_stream)+, @var0
			asr.w	#2, @var0
			if @current_scanline % 2
				add.b	@var0, @vscroll_value
			else
				sub.b	@var0, @vscroll_value
			endif
			add.b	@vscroll_value, @scanline
			bcc.s	@scanline_\#@current_scanline\_ok
			sub.w	@plane_height, @vscroll_value
		@scanline_\#@current_scanline\_ok:
			move.w	@vscroll_value, (@vscroll_buffer)+
		endif

		@current_scanline: = @current_scanline + 1
	endr

	; VScroll buffer special entry #224: Plane C position
	moveq	#$7F, @vscroll_value
	and.w	SoundTest_VisualizerPos, @vscroll_value
	add.w	#$100-32+1, @vscroll_value
	move.w	@vscroll_value, (@vscroll_buffer)+

	; VScroll buffer special entry #225: Plane A position
	move.w	#0, (@vscroll_buffer)+
	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; Initializes the visualizer
; ---------------------------------------------------------------------------

SoundTest_Visualizer_Init:

	; Init variables
	moveq	#0, d0
	move.w	d0, SoundTest_VisualizerPos
	move.w	d0, SoundTest_VisualizerPos_TilePtr
	move.w	d0, SoundTest_VisualizerPos_TileOffset
	move.w	d0, SoundTest_VisualizerBufferPtr
	move.l	d0, SoundTest_VisualizerBufferDest

	@vdp_ctrl:	equr	a5
	@vdp_data:	equr	a6

	lea	VDP_Data, @vdp_data
	lea	VDP_Ctrl-VDP_Data(@vdp_data), @vdp_ctrl

	; Generate tiles (DMA fill)
	@dma_len: = SoundTest_Visualizer_Width*SoundTest_Visualizer_Height*$20 ; bytes
	@dma_dest: = SoundTest_Visualizer_VRAM

	move.l	#(($9400+((@dma_len-1)>>8))<<16)|($9300+((@dma_len-1)&$FF)), (@vdp_ctrl)
	move.l	#(($9700+$80)<<16)|$8F01, (@vdp_ctrl)
	move.l	#($40000000+(((@dma_dest)&$3FFF)<<16)+(((@dma_dest)&$C000)>>14))|$80, (@vdp_ctrl)
	move.w	#$0000, (@vdp_data)

	; Decompress plane mappings
	move.l	@vdp_ctrl, -(sp)
	lea	SoundTest_PianoSheet_MapKosp(pc), a0
	lea	$FF0000, a1
	jsr	KosPlusDec
	move.l	(sp)+, @vdp_ctrl

	assert.l a1, eq, #$FF0000+$1000

	; Wait for generate tiles DMA to finish (it was running in parallel!)
	@wait_dma:
		move.w	(@vdp_ctrl), ccr
		bvs.s	@wait_dma

	move.w	#$8F02, (@vdp_ctrl)

	; Send plane mappings
	vramWrite $FF0000, $1000, SoundTest_PlaneC_VRAM

	rts

; ---------------------------------------------------------------------------
; Updates the visualizer
; ---------------------------------------------------------------------------

SoundTest_Visualizer_Update:

	@pixel_buffer_size: = SoundTest_Visualizer_Width*4
	@pixel_buffer_half_size: = SoundTest_Visualizer_Width*4/2

	; USES:
	@var0:			equr	d0
	@pixel_buffer:		equr	a0
	@pixel_buffer_half1:	equr	a1
	@pixel_buffer_half2:	equr	a2

	@pixel_data_half1_p1:	equr	d2
	@pixel_data_half1_p2:	equr	d3
	@pixel_data_half1_p3:	equr	d4
	@pixel_data_half1_p4:	equr	d5
	@pixel_data_half1_p5:	equr	d6
	@pixel_data_half2:	equr	d7

	; ----------------------------------------------
	; Initially draw an empty line in pixel buffer
	; ----------------------------------------------

	lea	SoundTest_Visualizer_PixelBuffer, @pixel_buffer
	lea	(@pixel_buffer), @pixel_buffer_half1
	lea	@pixel_buffer_half_size(@pixel_buffer), @pixel_buffer_half2

	movem.l	@PianoSeparatorData(pc), @pixel_data_half1_p1-@pixel_data_half1_p5
	moveq	#0, @pixel_data_half2

	rept @pixel_buffer_size/(8*5)
		move.l	@pixel_data_half1_p1, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		move.l	@pixel_data_half1_p2, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		move.l	@pixel_data_half1_p3, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		move.l	@pixel_data_half1_p4, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		move.l	@pixel_data_half1_p5, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
	endr
	@remaining_buffer: = (@pixel_buffer_size % (8*5))
	if @remaining_buffer = 20
		move.l	@pixel_data_half1_p1, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		move.l	@pixel_data_half1_p2, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
		swap	@pixel_data_half1_p3
		move.w	@pixel_data_half1_p3, (@pixel_buffer_half1)+
		swap	@pixel_data_half2
		move.w	@pixel_data_half2, (@pixel_buffer_half2)+
	else
		inform 3, "Bad remaining buffer: \#@remaining_buffer"
	endif

	; -----------------------------
	; Render shapes on the buffer
	; -----------------------------

	@write_request:	equr	a0

	lea	SoundTest_VisualizerWriteRequests, @write_request
	tst.w	(@write_request)
	bmi.s	@write_requests_done

	@write_request_loop:
		bsr	SoundTest_Visualizer_WritePixelsToPixelBuffer
		tst.w	(@write_request)
		bpl.s	@write_request_loop

@write_requests_done:

	; -------------
	; Send buffer
	; -------------

	move.w	#SoundTest_Visualizer_PixelBuffer, SoundTest_VisualizerBufferPtr

	; Calculate start position
	moveq	#0, @var0
	move.w	#SoundTest_Visualizer_VRAM, @var0
	add.w	SoundTest_VisualizerPos_TilePtr, @var0
	add.w	SoundTest_VisualizerPos_TileOffset, @var0

	lsl.l	#2, @var0
	lsr.w	#2, @var0
	swap	@var0
	ori.l	#$40000080, @var0
 	move.l	@var0, SoundTest_VisualizerBufferDest

	; Advance visualizer position for the next call
	addq.w	#1, SoundTest_VisualizerPos
	addq.w	#4, SoundTest_VisualizerPos_TileOffset
	cmp.w	#$20*4, SoundTest_VisualizerPos_TileOffset
	blo.s	@pos_ok
	move.w	#0, SoundTest_VisualizerPos_TileOffset
	add.w	#SoundTest_Visualizer_Width*$20*4, SoundTest_VisualizerPos_TilePtr
	cmp.w	#SoundTest_Visualizer_Height*SoundTest_Visualizer_Width*$20, SoundTest_VisualizerPos_TilePtr
	blo.s	@pos_ok
	move.w	#0, SoundTest_VisualizerPos_TilePtr
@pos_ok:
	rts

; ---------------------------------------------------------------------------
@PianoSeparatorData:
	@i: = 0;$F

	dc.w	$1000*@i, $0000, $0100*@i, $0000, $0000, $1000*@i, $0000, $0100*@i, $0000, $0000


; ---------------------------------------------------------------------------
; Writes given pixel data to the pixel data
; ---------------------------------------------------------------------------
; WRITE REQUEST FORMAT:
;	$00	.w	Start X-pixel
;	$04	.l	Pixel data pointer
;
; PIXEL DATA FORMAT:
;	$00	.w	(NN) Number of pixels
;	$02	...	Raw pixel data, even positioning
;	$02+(NN+1)/2...	Raw pixel data, odd positioning (shifted by 4 bits)
; ---------------------------------------------------------------------------

SoundTest_Visualizer_WritePixelsToPixelBuffer:

	; INPUT:
	@write_request:		equr	a0

	; USES:
	@xpos:			equr	d0
	@var0:			equr	d1
	@var1:			equr	d2
	@pixel_cnt:		equr	d5
	@pixel_data:		equr	a1
	@buffer_offset_stream:	equr	a2
	@pixel_buffer_ptr:	equr	a3


	move.w	(@write_request)+, @xpos
	movea.l	(@write_request)+, @pixel_data
	move.w	(@pixel_data)+, @pixel_cnt
	bclr	#0, @xpos
	lea	@XOffsetToBufferOffset(pc, @xpos), @buffer_offset_stream	; initialize buffer offset stream
	beq.s	@xpos_even			; if we're on even pixel, branch

	move.w	@pixel_cnt, @var0
	addq.w	#1, @var0
	lsr.w	@var0				; @var0 = Number of pixels / 2
	adda.w	@var0, @pixel_data		; use "odd start" pixel data

	; If X-pos was odd, write the first pixel to the first nibble
	movea.w	(@buffer_offset_stream)+, @pixel_buffer_ptr
	moveq	#$FFFFFFF0, @var0
	and.b	(@pixel_buffer_ptr), @var0
	or.b	(@pixel_data)+, @var0
	move.b	@var0, (@pixel_buffer_ptr)

	subq.w	#1, @pixel_cnt			; mark pixel as written
	beq.s	@done				; if no pixels remain, branch

@xpos_even:
	lsr.w	@pixel_cnt
	beq.s	@push_to_last_nibble
	bcc.s	@pixel_counter_even
	pea	@push_to_last_nibble(pc)	; also push to the last nibble once we're done

@pixel_counter_even:
	subq.w	#1, @pixel_cnt

	@stream_pixels:
		movea.w	(@buffer_offset_stream)+, @pixel_buffer_ptr
		move.b	(@pixel_data)+, (@pixel_buffer_ptr)
		dbf	@pixel_cnt, @stream_pixels

@done:	rts

; ---------------------------------------------------------------------------
@push_to_last_nibble:
	; If number of pixels was odd, push the last pixel
	move.w	(@buffer_offset_stream)+, @pixel_buffer_ptr
	moveq	#$F, @var0
	and.b	(@pixel_buffer_ptr), @var0
	or.b	(@pixel_data)+, @var0
	move.b	@var0, (@pixel_buffer_ptr)
	rts

; ---------------------------------------------------------------------------
@XOffsetToBufferOffset:

	@x_offset: = 0
	@half1_offset: = SoundTest_Visualizer_PixelBuffer
	@half2_offset: = SoundTest_Visualizer_PixelBuffer + SoundTest_Visualizer_Width*4/2

	rept SoundTest_Visualizer_Width*4
		if @x_offset & 2
			dc.w @half2_offset
			@half2_offset: = @half2_offset + 1
		else
			dc.w  @half1_offset
			@half1_offset: = @half1_offset + 1
		endif

		@x_offset: = @x_offset + 1
	endr


; ---------------------------------------------------------------------------
; Transfers pixel buffer to VRAM during VBlank
; ---------------------------------------------------------------------------

SoundTest_Visualizer_TransferPixelBufferToVRAM:
	
	; INPUT REGISTERS:
	@pixel_buffer:	equr	a0
	@write_dest:	equr	d0

	; USES:
	@dma_src:	equr	d2
	@dma_size_regs:	equr	d3
	@vdp_ctrl:	equr	a5


	assert.l @write_dest, ne
	assert.l @pixel_buffer, hs, #$FF0000 ; buffer should be in RAM (so DMA's high byte is $FF/2 = $7F)

	lea	VDP_Ctrl, @vdp_ctrl

	@pixel_buffer_size: = SoundTest_Visualizer_Width*4/2 ; words

	move.w	@pixel_buffer, @dma_src
	lsr.w	#1, @dma_src

	move.l	#(($9400+((@pixel_buffer_size/2)>>8))<<16)|($9300+((@pixel_buffer_size/2)&$FF)), @dma_size_regs
	move.w	@write_dest, -(sp)		; Stack => DMA destination command (low word)
	move.l	#$96009500, -(sp)		; Stack => DMA source address registers (mid and low bytes)
	swap	@write_dest

	move.w	#$8F80, (@vdp_ctrl)		; DMA advances every other tile ($80 bytes)

	move.l	@dma_size_regs, (@vdp_ctrl)	; VDP => DMA size regs
	movep.w	@dma_src, 1(sp)
	move.w	#$977F, (@vdp_ctrl)		; VDP => DMA's source high byte
	move.l	(sp), (@vdp_ctrl)		; VDP => DMA's source mid and low byte
	move.w	@write_dest, (@vdp_ctrl)	; VDP => DMA destination command (high word)
	move.w	4(sp), (@vdp_ctrl)		; VPD => DMA destination command (low word)

	addq.w	#2, @write_dest
	add.w	#@pixel_buffer_size/2, @dma_src

	move.l	@dma_size_regs, (@vdp_ctrl)	; VDP => DMA size regs
	movep.w	@dma_src, 1(sp)
	move.w	#$977F, (@vdp_ctrl)		; VDP => DMA's source high byte
	move.l	(sp), (@vdp_ctrl)		; VDP => DMA's source mid and low byte
	move.w	@write_dest, (@vdp_ctrl)	; VDP => DMA destination command (high word)
	move.w	4(sp), (@vdp_ctrl)		; VPD => DMA destination command (low word)

	move.w	#$8F02, (@vdp_ctrl)
	addq.w	#6, sp
	rts


; ===========================================================================
; ---------------------------------------------------------------------------
; String flush functions for MDDBG__FormatString; pipe string to VRAM buffer
; ---------------------------------------------------------------------------
; INPUT:
;	a0		Last buffer position
;	d7	.w	Number of characters remaining in buffer - 1
;
; WARNING: Must return Carry=1 to terminate buffer! Otherwise it will crash
; further flushes because some registers are trashed.
; ---------------------------------------------------------------------------

SoundTest_DrawText:
	clr.b	(a0)+					; finalize buffer

	lea	SoundTest_StringBuffer, a0
	SoundTest_AllocateInVRAMBufferPool a1, #SoundTest_StringBufferSize*2
	move.l	a1, -(sp)

	moveq	#0, d7
	move.b	(a0)+, d7				; d7 = char
	beq.s	@done

	@loop:
		add.w	d7, d7
		move.w	SoundTest_CharToTile-$20*2(pc, d7), (a1)+
		moveq	#0, d7
		move.b	(a0)+, d7				; d7 = char
		bne.s	@loop

	move.l	(sp)+, d1				; d1 = source pointer
	andi.l	#$FFFFFF, d1
	move.w	SoundTest_CurrentTextStartScreenPos, d2	; d2 = destination VRAM
	move.l	d1, d3
	sub.l	a1, d3
	neg.w	d3					; d3 = transfer size
	lsr.w	d3					; d3 = transfer size (words)
	jsr	QueueDMATransfer

@done:
	moveq	#0, d7
	subq.w	#1, d7					; return C=1
	rts


; ---------------------------------------------------------------------------
; High-level char to tile converter (100% high-level programming)
; ---------------------------------------------------------------------------

SoundTest_CharToTile:

@base_pat: = SoundTest_Font_VRAM/$20

; Defines function return type
@return: macros value
	dc.w \value

	@char:	= $20	; ignore ASCII codes $00..$1F, those are control character we'll never use
	while (@char < $80)
		if @char = ' '
			@return $8000|$4000

		elseif @char = '!'
			@return (@base_pat + $A) | $8000|$4000
		elseif @char = '='
			@return (@base_pat + $B) | $8000|$4000
		elseif @char = '&'
			@return (@base_pat + $C) | $8000|$4000
		elseif @char = '<'
			@return (@base_pat + $D) | $8000|$4000
		elseif @char = '>'
			@return (@base_pat + $E) | $8000|$4000

		elseif @char = '-'
			@return (@base_pat + $29) | $8000|$4000
		elseif @char = '.'
			@return (@base_pat + $2A) | $8000|$4000
		elseif @char = ','
			@return (@base_pat + $2B) | $8000|$4000
		elseif @char = '?'
			@return (@base_pat + $2C) | $8000|$4000
		elseif @char = ':'
			@return (@base_pat + $2D) | $8000|$4000
		elseif @char = "'"
			@return (@base_pat + $2E) | $8000|$4000
		elseif @char = '"'
			@return (@base_pat + $2F) | $8000|$4000
		elseif @char = '/'
			@return (@base_pat + $30) | $8000|$4000
	
		elseif (@char >= '0') & (@char <= '9')
			@return (@base_pat + (@char-$30)) | $8000|$4000
		else
			@return	(@base_pat + (@char-$41) + 10+5) | $8000|$4000
		endif
		@char: = @char + 1
	endw


; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Data
; ---------------------------------------------------------------------------

; WARNING! This was pre-compiled for `SoundTest_Visualizer_VRAM = $20`
SoundTest_PianoSheet_MapKosp:
	incbin	"Screens/SoundTestScreen/Data/PianoSheet_Map.kosp"
	even

; ---------------------------------------------------------------------------
SoundTest_BG1_MapEni:
	incbin	"Screens/SoundTestScreen/Data/BG1_Map.eni"
	even

; ---------------------------------------------------------------------------
SoundTest_BG1_TilesKospM:
	incbin	"Screens/SoundTestScreen/Data/BG1_Tiles.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_BG2_MapEni:
	incbin	"Screens/SoundTestScreen/Data/BG2_Map.eni"
	even

; ---------------------------------------------------------------------------
SoundTest_BG2_TilesKospM:
	incbin	"Screens/SoundTestScreen/Data/BG2_Tiles.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_Piano_MapEni:
	incbin	"Screens/SoundTestScreen/Data/BasePiano_Map.eni"
	even

; ---------------------------------------------------------------------------
SoundTest_Piano_TilesKospM:
	incbin	"Screens/SoundTestScreen/Data/BasePiano_Tiles.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_PianoOverlays_TilesKospM:
	incbin	"Screens/SoundTestScreen/Data/BasePiano_KeyOverlays_Tiles.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_Font_KospM:
	incbin	"Screens/SoundTestScreen/Data/Font.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_UIBorderOverlay_Tiles_KospM:
	incbin	"Screens/SoundTestScreen/Data/UIBorderOverlay_Tiles.kospm"
	even

; ---------------------------------------------------------------------------
SoundTest_Palette:
	; Line 0: Background | FM piano key overlay
	dc.w	$0000, $0A2C, $0A28, $088E, $0A2A, $0806, $082C, $0A6C
	dc.w	$086E, $00EE, $00E2, $08E8, $0CEC, $00E2, $0282, $0242

	; Line 1: Background (highlighted) | PSG piano key overlay
	dc.w	$0000, $0E6E, $0E6C, $0CCE, $0E6E, $0C4A, $0C6E, $0EAE
	dc.w	$0CCE, $008E, $0E2E, $0E8E, $0ECE, $0E2E, $0828, $0424

	; Line 2: Text & stuff | SFX piano key overlay
	dc.w	$0000, $0222, $0444, $0666, $0EEE, $0EEE, $0EEE, $0AAA
	dc.w	$0042, $008E, $002E, $048E, $08CE, $002E, $0028, $0024

	; Line 3: Piano & Visualizer pixel colors
	dc.w	$0E0E, $0000, $0888, $0CCC, $0EEE, $0240, $0480, $0406
	dc.w	$060C, $0004, $000C, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E
