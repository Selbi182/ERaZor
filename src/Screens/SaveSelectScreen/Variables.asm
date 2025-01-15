
; -----------------------------------------------------------------------------

SaveSelect_Music:		equ	$99

				rsset	$20
SaveSelect_VRAM_BG:		rsfile	'Screens/SaveSelectScreen/Data/BG_B_Tiles.unc'
				rs.b	(4*4+8)*$20 ; ###
SaveSelect_VRAM_Font:		rsfile	'Screens/BlackBarsConfigScreen/Font.unc'
SaveSelect_VRAM_UIElements:	rsfile	'Screens/SaveSelectScreen/Data/ScreenUI_Tiles.unc'
SaveSelect_VRAM_SH_Shadow:	rsfile	'Screens/_common/Data/SH_Shadow_Tiles.unc'

SaveSelect_VRAM_FG:		equ	$C000
SaveSelect_VRAM_BGPlane:	equ	$E000

; -----------------------------------------------------------------------------
SaveSelect_Pat_Font:		equ	$8000|(SaveSelect_VRAM_Font/$20)-('!'-1)

; -----------------------------------------------------------------------------
SaveSelect_StringBufferSize = 40+1
SaveSelect_CanaryValue = $F00D

; -----------------------------------------------------------------------------
SaveSelectScreen_RAM:		equ	$FFFF8000

				rsset	SaveSelectScreen_RAM
SaveSelect_StringBuffer:	rs.b	SaveSelect_StringBufferSize+(SaveSelect_StringBufferSize&1)
SaveSelect_StringBufferCanary:	rs.w	1
SaveSelect_StringScreenPos:	rs.w	1
SaveSelect_VRAMBufferPoolPtr:	rs.w	1
SaveSelect_SelectedSlotId:	rs.b	1
SaveSelect_ExitFlag:		rs.b	1
SaveSelectScreen_RAM.Size:	equ	__rs-SaveSelectScreen_RAM

