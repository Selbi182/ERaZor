
_ST_TYPE_FM:	equ 0
_ST_TYPE_PSG:	equ 4

obSTNoteAddr:		equ $20	; .w
obSTNoteType:		equ $22	; .w
obSTNoteValue:		equ $24 ; .b
obSTPixelDataFrame: 	equ $25	; .b
obSTPixelDataX:		equ $26 ; .w

; ---------------------------------------------------------------------------
; Subroutine to create note emitter objects
; ---------------------------------------------------------------------------

SoundTest_CreateNoteEmitters:

	@note_type:	equr	d5
	@loop_cnt:	equr	d6
	@note_addr:	equr	a3

	; FM emitters
	lea	(SoundDriverRAM+v_music_fm_tracks+TrackNote).w, @note_addr
	moveq	#_ST_TYPE_FM, @note_type
	moveq	#6-1, @loop_cnt

	@create_fm_emitters_loop:
		SoundTest_CreateObject #SoundTest_Obj_NoteEmitter
		move.w	@note_type, obSTNoteType(a1)
		move.w	@note_addr, obSTNoteAddr(a1)
		lea	TrackSz(@note_addr), @note_addr

		dbf	@loop_cnt, @create_fm_emitters_loop

	; PSG emitters
	lea	(SoundDriverRAM+v_music_psg_tracks+TrackNote).w, @note_addr
	moveq	#_ST_TYPE_PSG, @note_type
	moveq	#3-1, @loop_cnt

	@create_psg_emitters_loop:
		SoundTest_CreateObject #SoundTest_Obj_NoteEmitter
		move.w	@note_type, obSTNoteType(a1)
		move.w	@note_addr, obSTNoteAddr(a1)
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
	bra.s	@SetupNoteValue

; ---------------------------------------------------------------------------
@ObjRoutine_WaitNextNote:
	movea.w	obSTNoteAddr(a0), @source_note
	move.b	(@source_note), d0
	cmp.b	obSTNoteValue(a0), d0			; has note value changed?
	bne.s	@SetupNoteValue				; if yes, branch
@ret:	rts

@SetupNoteValue:
	move.b	d0, obSTNoteValue(a0)			; set new note value
	bmi.s	@ret					; if note is empty, branch

	sub.b	#12+1, d0				; octave 1 is not displayed
	bmi.s	@ret					; ''
	cmp.b	#SoundTest_Visualizer_NumOctaves*12, d0
	bhs.s	@ret

	@setup_data:	equr	a4

	lea	SoundTest_NoteEmitter_NoteIndexToSetupData(pc), @setup_data
	andi.w	#$7F, d0
	move.w	d0, d1
	add.w	d0, d0					; d0 = 2X
	add.w	d1, d0					; d0 = 3X
	add.w	d0, d0					; d0 = 6X
	adda.w	d0, @setup_data

	; Setup note for rendering
	move.w	(@setup_data)+, d0
	move.w	d0, obSTPixelDataX(a0)
	add.w	#$80+(320-SoundTest_Visualizer_Width*8)/2, d0
	move.w	d0, obX(a0)

	move.w	(@setup_data)+, obGfx(a0)
	move.b	(@setup_data)+, obFrame(a0)
	move.b	(@setup_data)+, d0
	add.w	obSTNoteType(a0), d0
	move.b	d0, obSTPixelDataFrame(a0)

	move.l	#@ObjRoutine_RenderNote, obCodePtr(a0)
	bra.s	@RenderNote

; ---------------------------------------------------------------------------
@ObjRoutine_RenderNote:
	movea.w	obSTNoteAddr(a0), @source_note
	move.b	(@source_note), d0
	cmp.b	obSTNoteValue(a0), d0			; has note value changed?
	bne	@SetupNoteValue				; if yes, branch

@RenderNote:
	@pixel_data:	equr	a2

	moveq	#0, d0
	move.b	obSTPixelDataFrame(a0), d0
	lea	SoundTest_NoteEmitter_PixelDataFrames(pc), @pixel_data
	adda.w	(@pixel_data, d0), @pixel_data

	SoundTest_AddWriteRequest obSTPixelDataX(a0), @pixel_data, a4

	jmp	DisplaySprite


; ---------------------------------------------------------------------------
; Pixel data for piano sheet
; ---------------------------------------------------------------------------

SoundTest_NoteEmitter_PixelDataFrames:
@Index:
	dc.w	@PixelData_Note_FM_Wide-@Index		; $00
	dc.w	@PixelData_Note_FM_Narrow-@Index	; $02

	dc.w	@PixelData_Note_PSG_Wide-@Index		; $04
	dc.w	@PixelData_Note_PSG_Narrow-@Index	; $06

@PixelData_Note_FM_Wide:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$56, $65	; normal pixel data (even nibble start)
	dc.b	$05, $66, $50	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_FM_Narrow:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$56, $50	; normal pixel data (even nibble start)
	dc.b	$05, $65	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Wide:
	dc.w	4		; number of pixels (nibbles)
	dc.b	$78, $87	; normal pixel data (even nibble start)
	dc.b	$07, $88, $70	; shifted pixel data (odd nibble start)
	even

@PixelData_Note_PSG_Narrow:
	dc.w	3		; number of pixels (nibbles)
	dc.b	$78, $70	; normal pixel data (even nibble start)
	dc.b	$07, $87	; shifted pixel data (odd nibble start)
	even

; ---------------------------------------------------------------------------
; Setup data (X-pos, pattern, frame etc) for each note
; ---------------------------------------------------------------------------

SoundTest_NoteEmitter_NoteIndexToSetupData:

	@pat_base: = (SoundTest_PianoOverlays_VRAM/$20)|$6000|$8000
	@pat_wideL: = @pat_base+0
	@pat_wideC: = @pat_base+72/8
	@pat_wideR: = @pat_base+144/8
	@pat_narrow: = @pat_base+216/8

	@frame_wide: = $00
	@frame_narrow: = $02

	@pixel_frame_wide: = 0
	@pixel_frame_narrow: = 2

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
	; "_ST_TYPE_FM" frames
	dc.w	@Note_Wide_Highlight-@Index	; $00
	dc.w	@Note_Wide_FM-@Index		; $01

	dc.w	@Note_Narrow_Highlight-@Index	; $02
	dc.w	@Note_Narrow_FM-@Index		; $03

	; "_ST_TYPE_PSG" frames
	dc.w	@Note_Wide_Highlight-@Index	; $04
	dc.w	@Note_Wide_PSG-@Index		; $05

	dc.w	@Note_Narrow_Highlight-@Index	; $06
	dc.w	@Note_Narrow_PSG-@Index		; $07

; ---------------------------------------------------------------------------
@Note_Wide_Highlight:
	dc.b	1
	dc.b	1, %0010, 0, 0, -1

@Note_Wide_FM:
	dc.b	1
	dc.b	1, %0010, 0, 3, -1

@Note_Wide_PSG:
	dc.b	1
	dc.b	1, %0010, 0, 6, -1

@Note_Narrow_Highlight:
	dc.b	1
	dc.b	1, %0001, 0, 0, 0

@Note_Narrow_FM:
	dc.b	1
	dc.b	1, %0001, 0, 2, 0

@Note_Narrow_PSG:
	dc.b	1
	dc.b	1, %0001, 0, 4, 0
