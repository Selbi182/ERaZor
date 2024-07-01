; ------------------------------------------------------
; Macros
; ------------------------------------------------------

; align macro for ASM68k
align	macro
	cnop 0,\1
	endm

; Enable/display display
display_enable	macro
	move.w	($FFFFF60C).w,d0	; enable screen output
	ori.b	#$40,d0
	move.w	d0,($C00004).l
	endm

display_disable	macro
	move.w	($FFFFF60C).w,d0	; disable screen output
	andi.b	#$BF,d0
	move.w	d0,($C00004).l
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

; Set VDP to VRAM write
vram	macro	offset,operand
	if (narg=1)
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),($C00004).l
	else
		move.l	#($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14)),\operand
	endc
	endm
	
; VRAM write access constant
DCvram	macro	offset
	dc.l	($40000000+(((\offset)&$3FFF)<<16)+(((\offset)&$C000)>>14))
	endm

; Test if Frantic Mode is enabled in the gameplay style options
frantic macro
	btst	#5,($FFFFFF92).w	; 0 = casual // 1 = frantic
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
