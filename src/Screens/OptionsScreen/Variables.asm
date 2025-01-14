
Options_Music = $91

Options_DeleteSRAMInitialCount = 5

Options_VRAM = $8570
Options_StringBufferSize = 40+1

	if def(__DEBUG__)
Options_CanaryValue = $BEEF
	endif

Options_RAM:	equ	$FFFF8000

	rsset	Options_RAM
Options_StringBuffer:		rs.b	Options_StringBufferSize+(Options_StringBufferSize&1)
	if def(__DEBUG__)
Options_StringBufferCanary:	rs.w	1			; DEBUG builds only
	endif
Options_VRAMStartScreenPos:	rs.w	1
Options_VRAMBufferPoolPtr:	rs.w	1
Options_DeleteSRAMCounter:	rs.b	1
Options_RedrawCurrentItem:	rs.b	1
Options_Exiting:		rs.b	1
Options_HasAHint:		rs.b	1
Options_IndentTimer:		rs.w	1

; ---------------------------------------------------------------------------
; Global options bitfield
; RAM location: `GlobalOptions`
; Bits:
	GlobalOptions_DisableBGM:		equ 	0
	GlobalOptions_DisableSFX:		equ	1
	GlobalOptions_CameraShake_Weak:		equ	2
	GlobalOptions_CameraShake_Intense:	equ	3
	GlobalOptions_ExtendedCamera:		equ	4
	GlobalOptions_PeeloutStyle:	 	equ	5
	GlobalOptions_ScreenFlash_Intense:	equ	6
	GlobalOptions_ScreenFlash_Weak:		equ	7

; ---------------------------------------------------------------------------
; Slot-specific options bitfield
; RAM location: `SlotOptions`
; Bits:
*	SlotOptions_Unused:			equ	0
	SlotOptions_NewPalettes:		equ	1
	SlotOptions_NoHUD:			equ	2
	SlotOptions_CinematicBlackBars:		equ	3
	SlotOptions_NonstopInhuman:		equ	4
	SlotOptions_SpaceGolf:			equ	5
	SlotOptions_AltHUD_ShowSeconds: 	equ	6
	SlotOptions_AltHUD_ShowErrors:		equ	7

; ---------------------------------------------------------------------------
; Slot-specific options bitfield (secondary)
; RAM location: `SlotOptions2`
; Bits:
	SlotOptions2_MotionBlur:		equ	0
	SlotOptions2_PissFilter:		equ	1
	SlotOptions2_MotionBlurTemp:		equ	2
	SlotOptions2_ArcadeMode:		equ	3
	SlotOptions2_NoStory:			equ	4
	SlotOptions2_PlacePlacePlace:		equ	5
*	SlotOptions2_Unused:			equ	6
*	SlotOptions2_Unused:			equ	7

; Default options when starting the game for the first time
	if def(__WIDESCREEN__)
Default_GlobalOptions:	equbits	; no extended camera by default in widescreen
Default_SlotOptions:	equbits	SlotOptions_NewPalettes
	else
Default_GlobalOptions:	equbits	GlobalOptions_ExtendedCamera
Default_SlotOptions:	equbits	SlotOptions_NewPalettes
	endif
