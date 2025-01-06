; ------------------------------------------------------
; Macros
; ------------------------------------------------------

; align macro for ASM68k
align	macro
	cnop 0,\1
	endm

; even variant for RS-based allocators
rseven	macro
	if __rs & 1
		rs.b	1
	endif
	endm


; reserves memory determined by the file size, fails if file doesn't exist
rsfile	macro *, filename
	__rsfilesise: = filesize(\filename)
	if __rsfilesise = -1
		inform 3, "File \filename not found!"
	endif
\*:	rs.b	__rsfilesise
	endm

; Enable/display display
display_enable	macro
	move.w	($FFFFF60C).w,d0	; enable screen output
	ori.b	#$40,d0
	move.w	d0,VDP_Ctrl
	endm

display_disable	macro
	move.w	($FFFFF60C).w,d0	; disable screen output
	andi.b	#$BF,d0
	move.w	d0,VDP_Ctrl
	endm

; Enable/disable interrupts
ints_enable	macro
	move	#$2300,sr
	endm
ints_disable	macro
	move	#$2700,sr
	endm

ints_push	macro
	move.w	sr,-(sp)
	ints_disable
	endm

ints_pop	macro
	move.w	(sp)+,sr
	endm

; DMA copy data from 68K (ROM/RAM) to the VRAM
vramWrite:	macro source, len, dest
	lea	VDP_Ctrl, a5
	move.l	#$94000000+((((\len)>>1)&$FF00)<<8)+$9300+(((\len)>>1)&$FF),(a5)
	move.l	#$96000000+((((\source)>>1)&$FF00)<<8)+$9500+(((\source)>>1)&$FF),(a5)
	move.w	#$9700+(((((\source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#$4000+((\dest)&$3FFF),(a5)
	move.w	#$80+(((\dest)&$C000)>>14), -(sp)
	move.w	(sp)+, (a5)
	endm

; Set VDP to VRAM write
vram	macro	offset,operand
	if (narg=1)
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),VDP_Ctrl
	else
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),\operand
	endc
	endm
	
; VRAM write access constant
dcVram	macro	offset
	dc.l	($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14))
	endm

; VRAM screen position (raw)
dcScreenPos: macros	baseVRAMAddress, row, column
	dc.w	(\baseVRAMAddress)+(\row)*$80+(\column)*2

; Test if Frantic Mode is enabled in the gameplay style options
frantic: macro
	btst	#SlotState_Difficulty, SlotProgress	; 0 = casual // 1 = frantic
	endm

; Diable VBlank, update sound driver only
VBlank_SetMusicOnly:	macro
	addq.b	#1, VBlank_MusicOnly
	move.w	#$4E73, HBlankHndl		; override HBlank handler with `rte`
	endm

VBlank_UnsetMusicOnly:	macro
	subq.b	#1, VBlank_MusicOnly
	bne.s	@done\@
	move.w	#$4EF8, HBlankHndl		; restore HBlank handler (`jmp xxx.w`)
@done\@:
	assert.b VBlank_MusicOnly, pl		; shouldn't underflow
	endm

; Decorator for unimplemented routines
_unimplemented:	macro *
\*:
	RaiseError "Not Implemented"
	endm
