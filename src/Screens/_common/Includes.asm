
; -----------------------------------------------------------------------------
; Common Objects
; -----------------------------------------------------------------------------

	include	'Screens/_common/Objects/StarField.asm'

; -----------------------------------------------------------------------------
; Common Data (e.g. graphics)
; -----------------------------------------------------------------------------

Screens_Stars_ArtKospM:
	incbin	'Screens/_common/Data/Stars_Tiles.kospm'
	even

Screens_SH_Shadow_ArtKospM:
	incbin	'Screens/_common/Data/SH_Shadow_Tiles.kospm'
	even

Screens_MenuFont_ArtKospM:
	incbin	'Screens/_common/Data/MenuFont.kospm'
	even
