
_ST_TYPE_FM:	equ 0
_ST_TYPE_PSG:	equ 8

obSTNoteAddr:		equ $20	; .w
obSTNoteType:		equ $22	; .w
obSTNoteBasePalette:	equ $24 ; .w
obSTNoteValue:		equ $26 ; .b
obSTPixelDataFrame: 	equ $27	; .b
obSTPixelDataX:		equ $28 ; .w

; ---------------------------------------------------------------------------
; Subroutine to create note emitter objects
; ---------------------------------------------------------------------------

SoundTest_CreateNoteEmitters:

	@note_type:	equr	d4
	@note_pal:	equr	d5
	@loop_cnt:	equr	d6
	@note_addr:	equr	a3

	; FM emitters
	lea	(SoundDriverRAM+v_music_fm_tracks+TrackNoteOutput).w, @note_addr
	moveq	#_ST_TYPE_FM, @note_type
	moveq	#0, @note_pal	; use palette line #0
	moveq	#6-1, @loop_cnt

	@create_fm_emitters_loop:
		SoundTest_CreateObject #SoundTest_Obj_NoteEmitter
		move.w	@note_addr, obSTNoteAddr(a1)
		move.w	@note_type, obSTNoteType(a1)
		move.w	@note_pal, obSTNoteBasePalette(a1)
		lea	TrackSz(@note_addr), @note_addr

		dbf	@loop_cnt, @create_fm_emitters_loop

	; PSG emitters
	lea	(SoundDriverRAM+v_music_psg_tracks+TrackNoteOutput).w, @note_addr
	moveq	#_ST_TYPE_PSG, @note_type
	move.w	#$2000, @note_pal	; use palette line #1
	moveq	#3-1, @loop_cnt

	@create_psg_emitters_loop:
		SoundTest_CreateObject #SoundTest_Obj_NoteEmitter
		move.w	@note_addr, obSTNoteAddr(a1)
		move.w	@note_type, obSTNoteType(a1)
		move.w	@note_pal, obSTNoteBasePalette(a1)
		lea	TrackSz(@note_addr), @note_addr

		dbf	@loop_cnt, @create_psg_emitters_loop

	rts

; ---------------------------------------------------------------------------
; Note emitter instance
; ---------------------------------------------------------------------------

SoundTest_Obj_NoteEmitter:

	@base_y_pos: = $80+32+SoundTest_Visualizer_Height*8

	@source_note:	equr	a3

	; Initialize properties
	move.l	#SoundTest_ObjMap_NoteEmitter, obMap(a0)
	move.w	#@base_y_pos, obScreenY(a0)

	move.l	#@ObjRoutine_WaitNextNote, obCodePtr(a0)

	movea.w	obSTNoteAddr(a0), @source_note
	move.b	(@source_note), d0

	if def(__DEBUG__)
		bsr	@SetupNewNoteValue
		assert.l obCodePtr(a0), ne, #SoundTest_Obj_NoteEmitter ; `@SetupNoteValue` should update object pointer
		rts
	else
		bra.s	@SetupNewNoteValue
	endif

; ---------------------------------------------------------------------------
@ObjRoutine_WaitNextNote:
	movea.w	obSTNoteAddr(a0), @source_note
	move.b	(@source_note), d0			; d0 = $00 - rest, $01..$5F - pressed, $81..$DF - held
	cmp.b	obSTNoteValue(a0), d0			; has note value changed?
	bne.s	@SetupNewNoteValue			; if yes, branch
@ret:	rts

; ---------------------------------------------------------------------------
@ToWaitNextNote:
	move.b	d0, obSTNoteValue(a0)
	move.l	#@ObjRoutine_WaitNextNote, obCodePtr(a0)
	rts

; ---------------------------------------------------------------------------
@SetupNewNoteValue:
	move.b	d0, d1					; is note at rest?
	beq.s	@ToWaitNextNote				; if yes, branch
	ori.b	#$80, d0				; mark note as held
	move.b	d0, (@source_note)			; ''
	move.b	d0, obSTNoteValue(a0)			; set new note value

	subq.b	#1, d1					; skip rest note
	bmi.s	@ToWaitNextNote				; ''
	cmp.b	#SoundTest_Visualizer_NumOctaves*12, d1
	bhs.s	@ToWaitNextNote

	@setup_data:	equr	a4

	lea	SoundTest_NoteEmitter_NoteIndexToSetupData(pc), @setup_data
	andi.w	#$7F, d1
	move.w	d1, d0
	add.w	d1, d1					; d1 = 2X
	add.w	d0, d1					; d1 = 3X
	add.w	d1, d1					; d1 = 6X
	adda.w	d1, @setup_data

	; Setup note for rendering
	move.w	(@setup_data)+, d0
	move.w	d0, obSTPixelDataX(a0)
	add.w	#$80+(320-SoundTest_Visualizer_Width*8)/2, d0
	move.w	d0, obX(a0)

	move.w	(@setup_data)+, d0
	or.w	obSTNoteBasePalette(a0), d0
	move.w	d0, obGfx(a0)

	move.b	(@setup_data)+, obFrame(a0)
	move.b	#2, obTimeFrame(a0)			; set delay for the initial "key on" frame
	
	move.b	(@setup_data)+, d0
	add.w	obSTNoteType(a0), d0
	move.b	d0, obSTPixelDataFrame(a0)

*@ToRenderNote:
	move.l	#@ObjRoutine_RenderNote, obCodePtr(a0)
	bra	@RenderNoteEdge

; ---------------------------------------------------------------------------
@ObjRoutine_RenderNote:
	; Switches from "key on" to "key held" frame when timer expires
	subq.b	#1, obTimeFrame(a0)
	bne.s	@RenderNote
	addq.b	#1, obFrame(a0)
	move.l	#@RenderNote, obCodePtr(a0)

@RenderNote:
	movea.w	obSTNoteAddr(a0), @source_note
	move.b	(@source_note), d0
	cmp.b	obSTNoteValue(a0), d0			; has note value changed?
	bne	@RenderNoteEdge_And_SetupNewNoteValue	; if yes, branch (TODO: Ignore `DisplaySprite`?)

	moveq	#0, d0
	move.b	obSTPixelDataFrame(a0), d0

@RenderNote2:
	@pixel_data:	equr	a2

	lea	SoundTest_NoteEmitter_PixelDataFrames(pc), @pixel_data
	adda.w	(@pixel_data, d0), @pixel_data

	SoundTest_AddWriteRequest obSTPixelDataX(a0), @pixel_data, a4

	jmp	DisplaySprite

; ---------------------------------------------------------------------------
@RenderNoteEdge:
	moveq	#2, d0
	add.b	obSTPixelDataFrame(a0), d0
	bra	@RenderNote2

; ---------------------------------------------------------------------------
@RenderNoteEdge_And_SetupNewNoteValue:
	addq.b	#1, obFrame(a0) 	; use fade out frame (TODO: generate a separate sprite)
	bsr	@RenderNoteEdge
	bra	@SetupNewNoteValue

; ---------------------------------------------------------------------------
; Pixel data for piano sheet
; ---------------------------------------------------------------------------

SoundTest_NoteEmitter_PixelDataFrames:
@Index:
	dc.w	@PixelData_Note_FM_Wide-@Index		; $00
	dc.w	@PixelData_Note_FM_Wide_Edge-@Index	; $02
	dc.w	@PixelData_Note_FM_Narrow-@Index	; $04
	dc.w	@PixelData_Note_FM_Narrow_Edge-@Index	; $06

	dc.w	@PixelData_Note_PSG_Wide-@Index		; $08
	dc.w	@PixelData_Note_PSG_Wide_Edge-@Index	; $0A
	dc.w	@PixelData_Note_PSG_Narrow-@Index	; $0C
	dc.w	@PixelData_Note_PSG_Narrow_Edge-@Index	; $0E

@PixelData_Note_FM_Wide:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$56, $65	; normal pixel data (even nibble start)
	dc.b	$05, $66, $50	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_FM_Wide_Edge:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$55, $55	; normal pixel data (even nibble start)
	dc.b	$05, $55, $50	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_FM_Narrow:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$56, $50	; normal pixel data (even nibble start)
	dc.b	$05, $65	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_FM_Narrow_Edge:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$55, $50	; normal pixel data (even nibble start)
	dc.b	$05, $55	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Wide:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$78, $87	; normal pixel data (even nibble start)
	dc.b	$07, $88, $70	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Wide_Edge:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$77, $77	; normal pixel data (even nibble start)
	dc.b	$07, $77, $70	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Narrow:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$78, $70	; normal pixel data (even nibble start)
	dc.b	$07, $87	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Narrow_Edge:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$77, $70	; normal pixel data (even nibble start)
	dc.b	$07, $77	; shifted pixel data (odd nibble start)
	even

; ---------------------------------------------------------------------------
; Setup data (X-pos, pattern, frame etc) for each note
; ---------------------------------------------------------------------------

SoundTest_NoteEmitter_NoteIndexToSetupData:

	@pat_base: = (SoundTest_PianoOverlays_VRAM/$20)|$8000
	@pat_wideL: = @pat_base+0
	@pat_wideC: = @pat_base+(72+8*3)/8
	@pat_wideR: = @pat_base+(144+8*3*2)/8
	@pat_narrow: = @pat_base+(216+8*3*3)/8

	@frame_wide: = $00
	@frame_narrow: = $04

	@pixel_frame_wide: = 0
	@pixel_frame_narrow: = 4

	@start_x: = 1

	rept SoundTest_Visualizer_NumOctaves
		dc.w	@start_x			; start X-position
		dc.w	@pat_wideL			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

		dc.w	@start_x+3			; start X-position
		dc.w	@pat_narrow			; art pointer
		dc.b	@frame_narrow			; base frame
		dc.b	@pixel_frame_narrow		; pixel data frame

		dc.w	@start_x+6			; start X-position
		dc.w	@pat_wideC			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

		dc.w	@start_x+9			; start X-position
		dc.w	@pat_narrow			; art pointer
		dc.b	@frame_narrow			; base frame
		dc.b	@pixel_frame_narrow		; pixel data frame

		dc.w	@start_x+12			; start X-position
		dc.w	@pat_wideR			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

	@start_x: = @start_x + 17

		dc.w	@start_x			; start X-position
		dc.w	@pat_wideL			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

		dc.w	@start_x+3			; start X-position
		dc.w	@pat_narrow			; art pointer
		dc.b	@frame_narrow			; base frame
		dc.b	@pixel_frame_narrow		; pixel data frame

		dc.w	@start_x+6			; start X-position
		dc.w	@pat_wideC			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

		dc.w	@start_x+9			; start X-position
		dc.w	@pat_narrow			; art pointer
		dc.b	@frame_narrow			; base frame
		dc.b	@pixel_frame_narrow		; pixel data frame

		dc.w	@start_x+12			; start X-position
		dc.w	@pat_wideC			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

		dc.w	@start_x+15			; start X-position
		dc.w	@pat_narrow			; art pointer
		dc.b	@frame_narrow			; base frame
		dc.b	@pixel_frame_narrow		; pixel data frame

		dc.w	@start_x+18			; start X-position
		dc.w	@pat_wideR			; art pointer
		dc.b	@frame_wide			; base frame
		dc.b	@pixel_frame_wide		; pixel data frame

	@start_x: = @start_x + 23
	endr

	if * <> SoundTest_NoteEmitter_NoteIndexToSetupData + SoundTest_Visualizer_NumOctaves*12*6
		inform 2, "Data generation error"
	endif


; ---------------------------------------------------------------------------
; Sprite mappings for key overlays
; ---------------------------------------------------------------------------

SoundTest_ObjMap_NoteEmitter:

@Index:
	dc.w	@Note_Wide_KeyOn-@Index		; $00
	dc.w	@Note_Wide_Held-@Index		; $01
	dc.w	@Note_Wide_Fade1-@Index		; $02
	dc.w	@Note_Wide_Fade2-@Index		; $03

	dc.w	@Note_Narrow_KeyOn-@Index	; $04
	dc.w	@Note_Narrow_Held-@Index	; $05
	dc.w	@Note_Narrow_Fade1-@Index	; $06
	dc.w	@Note_Narrow_Fade2-@Index	; $07

; ---------------------------------------------------------------------------
@Note_Wide_KeyOn:
	dc.b	1
	dc.b	1, %0010, 0, 0, -1

@Note_Wide_Held:
	dc.b	1
	dc.b	1, %0010, 0, 3, -1

@Note_Wide_Fade1:
	dc.b	1
	dc.b	1, %0010, 0, 6, -1

@Note_Wide_Fade2:
	dc.b	1
	dc.b	1, %0010, 0, 9, -1

@Note_Narrow_KeyOn:
	dc.b	1
	dc.b	1, %0001, 0, 0, 0

@Note_Narrow_Held:
	dc.b	1
	dc.b	1, %0001, 0, 2, 0

@Note_Narrow_Fade1:
	dc.b	1
	dc.b	1, %0001, 0, 4, 0

@Note_Narrow_Fade2:
	dc.b	1
	dc.b	1, %0001, 0, 6, 0
