
; ==============================================================
; --------------------------------------------------------------
; Animated art subroutines
; --------------------------------------------------------------

AnimatedArt_Init:  

	; Clear animated art slot RAM
	lea	AniArt_Slot_RAM, a1
	moveq	#0, d0
	move.l	d0, (a1)+
	move.l	d0, (a1)+

	; Setup animated art update pointer
	move.b	CurrentZone, d0				; d0 = zone
	lsl.w	#3, d0					; d0 = zone * 8
	lea	AniArt_RoutineTable(pc,d0), a0
	movea.l	(a0)+, a1				; a1 = "initial draw" routine
	move.l	(a0)+, AniArt_UpdateProc		; set "update" routine
	jmp	(a1)					; run "initial draw" routine

; --------------------------------------------------------------
; Subroutine to update animated art during gameplay
; --------------------------------------------------------------

AnimatedArt_Update:
	assert.l AniArt_UpdateProc, ne
	movea.l	AniArt_UpdateProc, a0
	jmp	(a0)

	 
; ==============================================================
; --------------------------------------------------------------
; Procedures table for animated art
; --------------------------------------------------------------
	
AniArt_RoutineTable:
	dc.l	AniArt_GHZ_InitialDraw,		AniArt_GHZ			; GHZ
	dc.l	@nullsub,			@nullsub			; LZ 
	dc.l	AniArt_MZ_InitialDraw,		AniArt_MZ			; MZ  
	dc.l	@nullsub,			@nullsub			; SLZ 
	dc.l	@nullsub,			@nullsub			; SYZ 
	dc.l	@nullsub,			@nullsub			; SBZ
	dc.l	AniArt_Ending_InitialDraw,	AniArt_Ending			; Ending
	
@nullsub:
	rts

; ==============================================================








; ==============================================================
; --------------------------------------------------------------
; Animated art routines : GHZ
; --------------------------------------------------------------

AniArt_GHZ:
	add.b	#$2A, AniArt_Slot0_Timer
	bcs.s	AniArt_GHZ_Waterfall

	add.b	#$10, AniArt_Slot1_Timer
	bcs.s	AniArt_GHZ_Flower1

	add.b	#$20, AniArt_Slot2_Timer  
	bcs.s	AniArt_GHZ_Flower2
	rts
	  
; --------------------------------------------------------------
AniArt_GHZ_Waterfall:
	eor.b	#1, AniArt_Slot0_Frame
	
AniArt_GHZ_Waterfall_Draw:
	move.w	AniArt_Slot0_Frame, d0
	clr.b	d0
	lea	Art_GhzWater, a0
	adda.w	d0, a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$6F00, d2					; d2 = transfer destintation
	move.w	#$100/2, d3					; d3 = transfer size (words)
	jmp	QueueDMATransfer
@water_ok:

; --------------------------------------------------------------
AniArt_GHZ_Flower1:
	eor.b	#2, AniArt_Slot1_Frame  

AniArt_GHZ_Flower1_Draw:
	move.w	AniArt_Slot1_Frame, d0
	clr.b	d0   
	lea	Art_GhzFlower1, a0
	adda.w	d0, a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$6B80, d2					; d2 = transfer destination
	move.w	#$200/2, d3					; d3 = transfer size (words)
	jmp	QueueDMATransfer

; --------------------------------------------------------------    
AniArt_GHZ_InitialDraw:   
	bsr.s	AniArt_GHZ_Waterfall_Draw   
	bsr.s	AniArt_GHZ_Flower1_Draw
	;bra.s	AniArt_GHZ_Flower2_Draw

; --------------------------------------------------------------    
AniArt_GHZ_Flower2_Draw:
	moveq	#32*2-1, d0
	and.b	AniArt_Slot2_Frame, d0
	move.w	AniArt_GHZ_Flower2_FrameOffsets(pc,d0), d0
	and.w	#$7FFF, d0
	bra.s	AniArt_GHZ_Flower2_Render	
		  
; --------------------------------------------------------------
AniArt_GHZ_Flower2:
	addq.b	#2, AniArt_Slot2_Frame
	moveq	#32*2-1, d0
	and.b	AniArt_Slot2_Frame, d0
	move.w	AniArt_GHZ_Flower2_FrameOffsets(pc,d0), d0
	bmi.s	AniArt_GHZ_Flower2_Skip				; if frame is the same as the previous one, skip

AniArt_GHZ_Flower2_Render:
	lea 	Art_GhzFlower2, a0
	adda.w	d0, a0	
	move.l	a0, d1
	move.w	#$6D80, d2
	move.w	#$180/2, d3
	jmp	QueueDMATransfer	

AniArt_GHZ_Flower2_Skip:
	rts
					
; --------------------------------------------------------------
AniArt_GHZ_Flower2_FrameOffsets:
	dc.w 	$0000, $8000, $8000, $8000
	dc.w	$8000, $8000, $8000, $8000
	dc.w	$8000, $8000, $8000, $8000
	dc.w	$8000, $8000, $8000

	dc.w	$0180, $0300, $8300, $8300
	dc.w	$8300, $8300, $8300, $8300
	dc.w	$8300, $8300, $8300, $8300
	dc.w	$8300, $8300, $8300, $8300

	dc.w	$0180

; ==============================================================







	
; ==============================================================
; --------------------------------------------------------------
; Animated art routines : MZ
; --------------------------------------------------------------

AniArt_MZ:
	subq.b	#1, AniArt_Slot0_Timer
	bpl.s	@lava_surface_done
	move.b	#$13, AniArt_Slot0_Timer
	bra.s	AniArt_MZ_LavaSurface
@lava_surface_done:

	add.b	#$80, AniArt_Slot1_Timer
	bcs.s	AniArt_MZ_LavaMain

	add.b	#$20, AniArt_Slot2_Timer 
	bcs.w	AniArt_MZ_Torch	
	rts
	
; --------------------------------------------------------------
AniArt_MZ_InitialDraw:
	bsr.s	AniArt_MZ_LavaSurface_Draw
	bsr.s	AniArt_MZ_LavaMain	
	bra.s	AniArt_MZ_Torch_Draw	
		
; --------------------------------------------------------------
AniArt_MZ_LavaSurface:
	addq.b	#1, AniArt_Slot0_Frame
	cmp.b	#3, AniArt_Slot0_Frame
	blo.s	AniArt_MZ_LavaSurface_Draw
	clr.b	AniArt_Slot0_Frame	
	
AniArt_MZ_LavaSurface_Draw:
	move.w	AniArt_Slot0_Frame, d0
	andi.w	#$300, d0
	lea	Art_MzLava1, a0
	adda.w	d0, a0
	move.l	a0, d1
	move.w	#$5C40, d2
	move.w	#$100/2, d3
	jmp	QueueDMATransfer
	
; --------------------------------------------------------------
AniArt_MZ_LavaMain:
	move.w	AniArt_Slot0_Frame, d0
	lea 	Art_MzLava2, a4			; a4 = lava 16x32 blocks base offset
	lea	$FFFFA200, a0			; a0 = art buffer (WARNING! Overlaps with the end of chunks data, but it should be unused in MZ)
	add.w	d0, d0
	andi.w	#$600, d0
	adda.w	d0, a4
	moveq	#0, d3
	move.b	$FFFFFE68, d3
	moveq	#4-1, d2

	@render_loop:
		moveq	#$F, d0
		and.w	d3, d0
		add.w	d0, d0                                  
		lea 	AniArt_MZ_LavaRenderers(pc), a3
		add.w	(a3, d0), a3                        
		movea.l a4, a1				; a1 = art ptr
		jsr 	(a3)
		addq.w	#4, d3				; do next 8 pixels
		dbf 	d2, @render_loop

	move.l	#$FFA200, d1			; d1 = art buffer (WARNING! Overlaps with the end of chunks data, but it should be unused in MZ)
	move.w	#$5A40, d2
	move.w	#$200/2, d3
	jmp	QueueDMATransfer

; --------------------------------------------------------------
AniArt_MZ_Torch:
	addq.b	#1, AniArt_Slot3_Frame
	
AniArt_MZ_Torch_Draw:
	lea	Art_MzTorch, a0
	move.w	AniArt_Slot3_Frame, d0
	and.w	#$300, d0
	move.w	d0, d1
	lsr.w	#2, d1
	sub.w	d1, d0
	adda.w	d0, a0
	move.l	a0, d1
	move.w	#$5E40, d2
	move.w	#$C0/2, d3
	jmp	QueueDMATransfer
	
; --------------------------------------------------------------
; MZ lava renderers
; --------------------------------------------------------------

AniArt_MZ_LavaRenderers:
@table_base = *
	dc.w	@render_offset_0 - @table_base		; pixel offset: 0
	dc.w	@render_offset_2 - @table_base		; pixel offset: 2  
	dc.w	@render_offset_4 - @table_base		; pixel offset: 4   
	dc.w	@render_offset_6 - @table_base		; pixel offset: 6     
	dc.w	@render_offset_8 - @table_base		; pixel offset: 8     
	dc.w	@render_offset_10 - @table_base		; pixel offset: 10   
	dc.w	@render_offset_12 - @table_base		; pixel offset: 12
	dc.w	@render_offset_14 - @table_base		; pixel offset: 14   
	dc.w	@render_offset_16 - @table_base		; pixel offset: 16     
	dc.w	@render_offset_18 - @table_base		; pixel offset: 18    
	dc.w	@render_offset_20 - @table_base		; pixel offset: 20    
	dc.w	@render_offset_22 - @table_base		; pixel offset: 22  
	dc.w	@render_offset_24 - @table_base		; pixel offset: 24  
	dc.w	@render_offset_26 - @table_base		; pixel offset: 26  
	dc.w	@render_offset_28 - @table_base		; pixel offset: 28  
	dc.w	@render_offset_30 - @table_base		; pixel offset: 30

; --------------------------------------------------------------
@render_offset_28:
	rept	$20
		move.w	$E(a1), (a0)+
		move.w	(a1), (a0)+
		lea	$10(a1), a1
	endr
	rts

; --------------------------------------------------------------
@render_offset_24:
	lea	$C(a1), a1     
	bra.s	@render_transfer_direct

; --------------------------------------------------------------
@render_offset_20:
	addq.w	#2, a1

@render_offset_16:
	addq.w	#8, a1
	bra.s	@render_transfer_direct	
	
; --------------------------------------------------------------
@render_offset_12:
	addq.w	#2, a1

@render_offset_8:
	addq.w	#2, a1

@render_offset_4:
	addq.w	#2, a1

@render_offset_0:    
@render_transfer_direct:
	rept	$20
		move.l	(a1), (a0)+
		lea	$10(a1), a1
	endr
	rts	

; --------------------------------------------------------------   
@render_offset_30:   	
	rept $20
		move.b	$F(a1), (a0)+
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		lea	$10-3(a1), a1
	endr
	rts
	
; --------------------------------------------------------------   
@render_offset_26:
	lea	$D(a1), a1
	
	rept $20
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		move.b	-$10(a1), (a0)+
		lea	$10-3(a1), a1
	endr
	rts

; --------------------------------------------------------------   
@render_offset_22:
	lea	$B(a1), a1     
	bra.s	@render_transfer_direct_odd	
	
; --------------------------------------------------------------   
@render_offset_18:
	addq.w	#2, a1
	
@render_offset_14:
	addq.w	#7, a1  
	bra.s	@render_transfer_direct_odd
		 
; --------------------------------------------------------------
@render_offset_10:
	addq.w	#2, a1
	
@render_offset_6:
	addq.w	#2, a1

@render_offset_2:
	addq.w	#1, a1
		 
@render_transfer_direct_odd:
	rept	$20
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		move.b	(a1)+, (a0)+
		lea	$C(a1), a1
	endr  
	rts	
		 
; ==============================================================







; ==============================================================
; --------------------------------------------------------------
; Animated art routines : Ending
; --------------------------------------------------------------

AniArt_Ending:
	add.b	#$20, AniArt_Slot0_Timer
	bcs.s	AniArt_Ending_Flower1

	add.b	#$20, AniArt_Slot1_Timer
	bcs.s	AniArt_Ending_Flower2

	add.b	#$11, AniArt_Slot2_Timer
	bcs.w	AniArt_Ending_Flower3

	add.b	#$15, AniArt_Slot3_Timer
	bcs.w	AniArt_Ending_Flower4
	rts

; --------------------------------------------------------------
AniArt_Ending_Flower1:
	eor.b	#2, AniArt_Slot1_Frame

AniArt_Ending_Flower1_Draw:
	move.w	AniArt_Slot1_Frame, d0
	clr.b	d0
	lea 	Art_GhzFlower1, a0
	adda.w	d0, a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$6B80, d2					; d2 = VRAM address
	move.w	#$200/2, d3					; d3 = transfer size (words)
	jsr	QueueDMATransfer

	move.l	#$FF9400+$200, d1				; d1 = transfer source
	move.w	#$7200, d2					; d2 = VRAM address
	move.w	#$200, d3					; d3 = transfer size (words)
	jmp	QueueDMATransfer

; --------------------------------------------------------------
AniArt_Ending_Flower2:
	addq.b	#2, AniArt_Slot2_Frame

AniArt_Ending_Flower2_Draw:
	lea 	Art_GhzFlower2, a0
	moveq	#%1110, d0
	and.b	AniArt_Slot2_Frame, d0
	add.w	AniArt_Ending_Flower2_FrameOffsets(pc,d0), a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$6D80, d2					; d2 = VRAM address
	move.w	#$200/2, d3					; d3 = transfer size (words)
	jmp	QueueDMATransfer

; --------------------------------------------------------------
AniArt_Ending_Flower2_FrameOffsets:
	dc.w	$0000, $0000, $0000, $0180
	dc.w	$0300, $0300, $0300, $0180

; --------------------------------------------------------------
AniArt_Ending_InitialDraw:
	bsr.s	AniArt_Ending_Flower1_Draw
	bsr.s	AniArt_Ending_Flower2_Draw
	bsr.s	AniArt_Ending_Flower4_Draw
	bra.s	AniArt_Ending_Flower3_Draw

; --------------------------------------------------------------
AniArt_Ending_Flower3:
	addq.b	#2, AniArt_Slot3_Frame

AniArt_Ending_Flower3_Draw:
	lea	$FF9800, a0
	moveq	#%110, d0
	and.b	AniArt_Slot3_Frame, d0
	add.w	AniArt_Ending_Flower3_FrameOffsets(pc,d0), a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$7000, d2					; d2 = VRAM address
	move.w	#$200/2, d3					; d3 = transfer size
	jmp	QueueDMATransfer

; --------------------------------------------------------------
AniArt_Ending_Flower3_FrameOffsets:
	dc.w	$0000, $0200, $0400, $0200

; --------------------------------------------------------------
AniArt_Ending_Flower4:
	addq.b	#2, AniArt_Slot4_Frame		; frame = [0, 2, 4, 6]

AniArt_Ending_Flower4_Draw:
	lea	$FF9E00, a0
	moveq	#%110, d0
	and.b	AniArt_Slot3_Frame, d0
	add.w	AniArt_Ending_Flower3_FrameOffsets(pc,d0), a0
	move.l	a0, d1						; d1 = transfer source
	move.w	#$6800, d2					; d2 = VRAM address
	move.w	#$200/2, d3					; d3 = transfer size (words)
	jmp	QueueDMATransfer
