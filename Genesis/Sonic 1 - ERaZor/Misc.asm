; Macros
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


ints_enable	macro
		move	#$2300,sr
		endm

ints_disable	macro
		move	#$2700,sr
		endm



; Object variables
obRender:	equ 1	; bitfield for x/y flip, display mode
obGfx:		equ 2	; palette line & VRAM setting (2 bytes)
obMap:		equ 4	; mappings address (4 bytes)
obX:		equ 8	; x-axis position (2-4 bytes)
obScreenY:	equ $A	; y-axis position for screen-fixed items (2 bytes)
obY:		equ $C	; y-axis position (2-4 bytes)
obVelX:		equ $10	; x-axis velocity (2 bytes)
obVelY:		equ $12	; y-axis velocity (2 bytes)
obInertia:	equ $14	; potential speed (2 bytes)
obHeight:	equ $16	; height/2
obWidth:	equ $17	; width/2
obPriority:	equ $18	; sprite stack priority -- 0 is front
obActWid:	equ $19	; action width
obFrame:	equ $1A	; current frame displayed
obAniFrame:	equ $1B	; current frame in animation script
obAnim:		equ $1C	; current animation
obNextAni:	equ $1D	; next animation
obTimeFrame:	equ $1E	; time to next frame
obDelayAni:	equ $1F	; time to delay animation
obColType:	equ $20	; collision response type
obColProp:	equ $21	; collision extra property
obStatus:	equ $22	; orientation or mode
obRespawnNo:	equ $23	; respawn list index number
obRoutine:	equ $24	; routine number
ob2ndRout:	equ $25	; secondary routine number
obAngle:	equ $26	; angle
obSubtype:	equ $28	; object subtype
obSolid:	equ ob2ndRout ; solid status flag



BlackBars.Height:	equ		$FFFFF5F6				; w		Height of black bars in pixels
BlackBars.FirstHCnt:	equ		$FFFFF5F8				; w		$8Axx VDP register value for the first HInt
BlackBars.SecondHCnt:	equ		$FFFFF5FA				; w		$8Axx VDP register value for the second HInt
HBlankHndl:		equ		$FFFFF5FC				; l/w	Jump code for HInt
HBlankSubW:		equ		$FFFFF5FE				; w		Word offset for HInt routine 

; ---------------------------------------------------------------
; System Ports
; ---------------------------------------------------------------

VDP_Data				equ 	$C00000 		;		VDP Data Port
VDP_Ctrl				equ 	$C00004 		;		VDP Control Port
