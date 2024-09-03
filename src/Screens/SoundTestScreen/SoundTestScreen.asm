; ---------------------------------------------------------------------------
; Sound Test Screen
; ---------------------------------------------------------------------------

	include	"Screens/SoundTestScreen/Macros.asm"

; ---------------------------------------------------------------------------
SoundTest_PlaneA_VRAM:		equ	$A000	; FG
SoundTest_PlaneB_VRAM:		equ	$C000	; BG
SoundTest_PlaneC_VRAM:		equ	$B000	; reserved for Piano Sheet / Visualizer

SoundTest_Visualizer_Width:		equ	35	; tiles
SoundTest_Visualizer_Height:		equ	16	; tiles
SoundTest_Visualizer_MaxWriteRequests:	equ	7*12+2

	if SoundTest_Visualizer_Height % 16
		inform 2, "SoundTest_Visualizer_Height must be multiple of 16" ; because it wraps around a 32x64 plane
	endif

; ---------------------------------------------------------------------------

				rsset	$20
SoundTest_Visualizer_VRAM:	rs.b	SoundTest_Visualizer_Width*SoundTest_Visualizer_Height*$20
SoundTest_Piano_VRAM:		rs.b	filesize("Screens/SoundTestScreen/Data/BasePiano_Tiles.bin")
SoundTest_BG_VRAM:		rs.b	filesize("Screens/SoundTestScreen/Data/BG2_Tiles.bin")
	
	if __rs > $A000
		infrom 2, "Out of VRAM for graphics!"
	endif

; ---------------------------------------------------------------------------

SoundTest_RAM:	equ	$FFFF8000

					rsset	SoundTest_RAM
SoundTest_VRAMBufferPoolPtr:		rs.w	1
SoundTest_VisualizerPos_TilePtr:	rs.w	1
SoundTest_VisualizerPos_TileOffset:	rs.w	1
SoundTest_Visualizer_PixelBuffer:	rs.b	SoundTest_Visualizer_Width*4
SoundTest_VisualizerBufferPtr:		rs.w	1
SoundTest_VisualizerBufferDest:		rs.l	1	; VDP command
SoundTest_VisualizerWriteRequests:	rs.b	6*SoundTest_Visualizer_MaxWriteRequests
SoundTest_VisualizerWriteRequests_End:	equ	__rs
SoundTest_VisualizerWriteRequestsPos:	rs.w	1
SoundTest_DummyXPos:			rs.w	1

; ---------------------------------------------------------------------------
SoundTestScreen:
	moveq	#$FFFFFFE4, d0
	jsr	PlaySound_Special ; stop music
	jsr	PLC_ClearQueue
	jsr	Pal_FadeFrom
	jsr	DrawBuffer_Clear

	display_disable
	VBlank_SetMusicOnly

	; VDP setup
	lea	($C00004).l, a6
	move.w	#$8004, (a6)
	move.w	#$8200|(SoundTest_PlaneA_VRAM/$400), (a6)
	move.w	#$8400|(SoundTest_PlaneB_VRAM/$2000), (a6)
	move.w	#$8C81+8, (a6)		; enable S&H
	move.w	#$9011, (a6)		; set plane size to 64x64
	move.w	#$9200, (a6)
	move.w	#$8B03, (a6)
	move.w	#$8720, (a6)
	clr.b	($FFFFF64E).w
	jsr	ClearScreen

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

	; Load screen palette
	lea	Pal_Target, a0
	lea 	SoundTest_Palette(pc), a1
	rept 128/4
		move.l	(a1)+, (a0)+
	endr

	; ### Dummy Highlight ####
	;vram	SoundTest_DummyHL_VRAM, VDP_Ctrl
	;move.l	#$EEEEEEEE, d0
	;moveq	#4*4*$20/4-1, d1
;
	;@loop:
	;	move.l	d0, VDP_Data
	;	dbf	d1, @loop

	; ### Dummy Plane A highlight ###
	vram	SoundTest_PlaneA_VRAM+$280, d3
	move.l	#$80<<16, d2
	moveq	#SoundTest_Visualizer_Height-1, d0
	@row:
		move.l	d3, VDP_Ctrl
		moveq	#SoundTest_Visualizer_Width-1, d1
		@col:	move.w	#$8000, VDP_Data
			dbf	d1, @col
		add.l	d2, d3
		dbf	d0, @row

	;SoundTest_CreateObject #SoundTest_Obj_DummyHL
	SoundTest_CreateObject #SoundTest_Obj_PianoSheet
	SoundTest_CreateObject #SoundTest_Obj_NoteEmitter

	; Load BG
	vram	SoundTest_BG_VRAM, VDP_Ctrl
	lea	SoundTest_BG2_TilesKospM, a0
	jsr	KosPlusMDec_VRAM

	lea	SoundTest_BG2_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#$2000|(SoundTest_BG_VRAM/$20), d0
	jsr	EniDec

	vramWrite $FF0000, $2000, SoundTest_PlaneB_VRAM

	; Load piano keys
	vram	SoundTest_Piano_VRAM, VDP_Ctrl
	lea	SoundTest_Piano_TilesKospM, a0
	jsr	KosPlusMDec_VRAM

	lea	SoundTest_Piano_MapEni(pc), a0
	lea	$FF0000, a1
	move.w	#$8000|$6000|(SoundTest_Piano_VRAM/$20), d0
	jsr	EniDec

	vram	SoundTest_PlaneA_VRAM+$A80, d0
	lea	$FF0000, a1
	moveq	#36-1, d1
	moveq	#3-1, d2
	jsr	ShowVDPGraphics

	SoundTest_ResetVRAMBufferPool

	; Screen init
	jsr	SoundTest_Visualizer_Init
	jsr	ObjectsLoad
	jsr	BuildSprites

	display_enable
	VBlank_UnsetMusicOnly
	jsr	Pal_FadeTo

	assert.b VBlank_MusicOnly, eq

; ---------------------------------------------------------------------------
SoundTest_MainLoop:
	move.l	#@FlushVRAMBuffer, VBlankCallback
	move.b	#2, VBlankRoutine	
	jsr	DelayProgram

	assert.w SoundTest_VRAMBufferPoolPtr, eq, #Art_Buffer		; VRAM buffer pool should be reset by the beginning of the frame
	SoundTest_InitWriteRequests

	jsr	ObjectsLoad
	jsr	BuildSprites
	jsr	PLC_Execute

	SoundTest_FinalizeWriteRequests a0

	jsr	SoundTest_Visualizer_Update
	jsr	@Deform

	bra	SoundTest_MainLoop

; ---------------------------------------------------------------------------
@FlushVRAMBuffer:
	move.w	SoundTest_VisualizerBufferPtr, d0	; do we have a pixel buffer to flush?
	beq.s	@0
	movea.w	d0, a0
	move.l	SoundTest_VisualizerBufferDest, d0
	moveq	#0, d1
	move.w	d1, SoundTest_VisualizerBufferPtr
	move.l	d1, SoundTest_VisualizerBufferDest
	jsr	SoundTest_Visualizer_TransferPixelBufferToVRAM

@0:	SoundTest_ResetVRAMBufferPool
	rts

; ---------------------------------------------------------------------------
@Deform:
	move.w	CamYpos2, ($FFFFF618).w	; update plane B vs-ram
	
	addq.w	#1, CamYpos2
	;addq.w	#1, CamXPos2

	lea	HSRAM_Buffer, a1

	moveq	#0, d0
	move.w	CamXPos2, d0
	neg.w	d0

	moveq	#240/16-1, d1		; repeat to cover the entire 240-pixel screen
	jmp	DeformScreen_SendBlocks
	rts

; ===========================================================================

SoundTest_Exit:
	jmp	Exit_SoundTestScreen

; ---------------------------------------------------------------------------

	;include	"Screens/SoundTestScreen/Objects/DummyHL.asm"

	include	"Screens/SoundTestScreen/Objects/NoteEmitters.asm"

	include	"Screens/SoundTestScreen/Objects/PianoSheet.asm"


; ===========================================================================
; ---------------------------------------------------------------------------
; Initializes the visualizer
; ---------------------------------------------------------------------------

SoundTest_Visualizer_Init:

	; Init variables
	moveq	#0, d0
	move.w	d0, SoundTest_VisualizerPos_TilePtr
	move.w	d0, SoundTest_VisualizerPos_TileOffset
	move.w	d0, SoundTest_VisualizerBufferPtr
	move.l	d0, SoundTest_VisualizerBufferDest
	move.w	d0, SoundTest_DummyXPos ; ###

	@vdp_ctrl:	equr	a5
	@vdp_data:	equr	a6

	assert.b VBlank_MusicOnly, ne

	lea	VDP_Data, @vdp_data
	lea	VDP_Ctrl-VDP_Data(@vdp_data), @vdp_ctrl

	; Generate tiles (DMA fill)
	@dma_len: = SoundTest_Visualizer_Width*SoundTest_Visualizer_Height*$20 ; bytes
	@dma_dest: = SoundTest_Visualizer_VRAM

	vram	SoundTest_Visualizer_VRAM, (@vdp_ctrl)
	move.l	#(($9400+((@dma_len-1)>>8))<<16)|($9300+((@dma_len-1)&$FF)), (@vdp_ctrl)
	move.l	#(($9700+$80)<<16)|$8F01, (@vdp_ctrl)
	move.l	#($40000000+(((@dma_dest)&$3FFF)<<16)+(((@dma_dest)&$C000)>>14))|$80, (@vdp_ctrl)
	move.w	#$1111, (@vdp_data)

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
	@pixel_data_half1:	equr	d2
	@pixel_data_half2:	equr	d3

	; ----------------------------------------------
	; Initially draw an empty line in pixel buffer
	; ----------------------------------------------

	lea	SoundTest_Visualizer_PixelBuffer, @pixel_buffer
	lea	(@pixel_buffer), @pixel_buffer_half1
	lea	@pixel_buffer_half_size(@pixel_buffer), @pixel_buffer_half2

	move.l	#$EEEEEEEE, @pixel_data_half1
	move.l	#$EEEEEEEE, @pixel_data_half2

	rept @pixel_buffer_size/8
		move.l	@pixel_data_half1, (@pixel_buffer_half1)+
		move.l	@pixel_data_half2, (@pixel_buffer_half2)+
	endr
	if (@pixel_buffer_size % 8) = 4
		swap	@pixel_data_half1
		move.w	@pixel_data_half1, (@pixel_buffer_half1)+
		swap	@pixel_data_half2
		move.w	@pixel_data_half2, (@pixel_buffer_half2)+
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


@Dummy_PixelData:
	dc.w	1 ; pixels

@even:	dc.b	$60
@odd:	dc.b	$06
	even

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
	assert.l @pixel_buffer, hi, #$FF0000 ; buffer should be in RAM (so DMA's high byte is $FF/2 = $7F)

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
SoundTest_Palette:
	; Line 0
	dc.w	$0000, $0222, $0444, $0666, $0888, $0AAA, $0CCC, $0EEE
	dc.w	$0042, $0262, $0284, $04A6, $06A6, $06C8, $08C8, $08EA

	; Line 1: Background
	dc.w	$0E0E, $0220, $0440, $0660, $0880, $0AA0, $0CC0, $0EE0
	dc.w	$0CC0, $0AA0, $0880, $0660, $0440, $0220, $0000, $0E0E

	; Line 2: Background (unused)
	dc.w	$0000, $0020, $0220, $0240, $0242, $0462, $0464, $0684
	dc.w	$0686, $08A6, $08A8, $0AC8, $0ACA, $0CEA, $0CEC, $0EEE

	; Line 3: Piano
	dc.w	$0E0E, $0000, $0888, $0CCC, $0EEE, $0240, $0480, $0E0E
	dc.w	$0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E, $0E0E
