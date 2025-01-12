
			rsset 0
Credits_VRAM_Font:	rsfile	'Screens/CreditsScreen/Credits_FontArt.unc'
Credits_VRAM_Stars:	rsfile	'Screens/_common/Data/Stars_Tiles.unc'


Credits_Page equ $FFFFF779 ; b
Credits_Scroll equ $FFFFFFA0 ; w

Credits_Pages = 12
Credits_Lines = 14
Credits_LineLength = 20
StartDelay = 150

Credits_ScrollTime = $1C0
Credits_FastThreshold = $60
Credits_SpeedSlow = 1
Credits_SpeedFast = 32

Credits_InvertDirection = 1
