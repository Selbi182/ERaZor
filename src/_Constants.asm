
; ------------------------------------------------------
; Object variables
; ------------------------------------------------------
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
obSolid:	equ $25 ; solid status flag

; Joypad Buttons

Held	equ	0		; Bitfield ids
Press	equ	1

iStart	equ 	7		; Button Indexes
iA	equ 	6
iC	equ 	5
iB	equ 	4
iRight	equ 	3
iLeft	equ 	2
iDown	equ 	1
iUp	equ 	0

Start	equ 	1<<iStart	; Button values
A	equ 	1<<iA
C	equ 	1<<iC
B	equ 	1<<iB
Right	equ 	1<<iRight
Left	equ 	1<<iLeft
Down	equ 	1<<iDown
Up	equ 	1<<iUp

Held		equ	0
Press		equ	1


; IO Ports

VDP_Data	equ	$C00000
VDP_Ctrl	equ	$C00004