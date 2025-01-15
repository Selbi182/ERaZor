
; -----------------------------------------------------------------------------

SaveSelect_Music:		equ	$99
SaveSelect_BG_C_FrameSize:	equ	4*4*2*$20

				rsset	$20
SaveSelect_VRAM_BG_B:		rsfile	'Screens/SaveSelectScreen/Data/BG_B_Tiles.unc'
SaveSelect_VRAM_BG_C:		rs.b	SaveSelect_BG_C_FrameSize
SaveSelect_VRAM_Font:		rsfile	'Screens/_common/Data/MenuFont.unc'
SaveSelect_VRAM_UIElements:	rsfile	'Screens/SaveSelectScreen/Data/ScreenUI_Tiles.unc'
SaveSelect_VRAM_SH_Shadow:	rsfile	'Screens/_common/Data/SH_Shadow_Tiles.unc'

SaveSelect_VRAM_PlaneA:		equ	$C000
SaveSelect_VRAM_PlaneB:		equ	$E000

; -----------------------------------------------------------------------------
SaveSelect_Pat_BG_B:		equ	$6000|(SaveSelect_VRAM_BG_B/$20)
SaveSelect_Pat_Font:		equ	(SaveSelect_VRAM_Font/$20)-('!'-1)
SaveSelect_Pat_UIElements:	equ	$8000|$6000|(SaveSelect_VRAM_UIElements/$20)

; -----------------------------------------------------------------------------
SaveSelect_StringBufferSize = 40+1
SaveSelect_CanaryValue = $F00D

; -----------------------------------------------------------------------------
SaveSelectScreen_BG_C_Buffer:	equ	$FF0000		; 32 kb

SaveSelectScreen_RAM:		equ	$FFFF8000

				rsset	SaveSelectScreen_RAM
SaveSelect_StringBuffer:	rs.b	SaveSelect_StringBufferSize+(SaveSelect_StringBufferSize&1)
SaveSelect_StringBufferCanary:	rs.w	1
SaveSelect_StringScreenPos:	rs.w	1
SaveSelect_VRAMBufferPoolPtr:	rs.w	1
SaveSelect_BG_C_PrevFrame:	rs.w	1
SaveSelect_SelectedSlotId:	rs.b	1
SaveSelect_ExitFlag:		rs.b	1
SaveSelectScreen_RAM.Size:	equ	__rs-SaveSelectScreen_RAM

