
; ---------------------------------------------------------------------------
SoundTest_PlaneA_VRAM:		equ	$A000	; FG
SoundTest_PlaneB_VRAM:		equ	$C000	; BG
SoundTest_PlaneC_VRAM:		equ	$B000	; reserved for Piano Sheet / Visualizer

SoundTest_Visualizer_Width:		equ	35	; tiles
SoundTest_Visualizer_Height:		equ	16	; tiles
SoundTest_Visualizer_NumOctaves:	equ	7
SoundTest_Visualizer_MaxWriteRequests:	equ	SoundTest_Visualizer_NumOctaves*12+2

SoundTest_StringBufferSize:	equ	52+1

	if SoundTest_Visualizer_Height % 16
		inform 2, "SoundTest_Visualizer_Height must be multiple of 16" ; because it wraps around a 32x64 plane
	endif

; ---------------------------------------------------------------------------

				rsset	$20
SoundTest_Visualizer_VRAM:	rs.b	SoundTest_Visualizer_Width*SoundTest_Visualizer_Height*$20
SoundTest_Piano_VRAM:		rs.b	filesize("Screens/SoundTestScreen/Data/BasePiano_Tiles.bin")
SoundTest_PianoOverlays_VRAM:	rs.b	filesize("Screens/SoundTestScreen/Data/BasePiano_KeyOverlays_Tiles.bin")
SoundTest_BG_VRAM:		rs.b	filesize("Screens/SoundTestScreen/Data/BG2_Tiles.bin")
SoundTest_Font_VRAM:		rs.b	filesize("Screens/SoundTestScreen/Data/Font.bin")
SoundTest_HeaderFont_VRAM:	rs.b	filesize("artkosp/LevelSigns.unc")
SoundTest_DummyHL_VRAM:		rs.b	4*4*$20
	if __rs > $A000
		infrom 2, "Out of VRAM for graphics!"
	endif

; ---------------------------------------------------------------------------

SoundTest_RAM:	equ	$FFFF8000

					rsset	SoundTest_RAM

SoundTest_VScrollBuffer1:		rs.w	224+2	; entries 0..223 = Plane B, 224 = Plane C position, 225 = Plane A position
SoundTest_VScrollBuffer2:		rs.w	224+2	; entries 0..223 = Plane B, 224 = Plane C position, 225 = Plane A position
SoundTest_VScrollBufferPtrSwapper:	rs.w	2
SoundTest_NextVScrollBufferPtr:		equ	SoundTest_VScrollBufferPtrSwapper+0
SoundTest_ActiveVScrollBufferPtr:	equ	SoundTest_VScrollBufferPtrSwapper+2

SoundTest_HScrollBuffer:		rs.w	28	; H-Scroll buffer (per tile)

SoundTest_VRAMBufferPoolPtr:		rs.w	1

SoundTest_VisualizerPos:		rs.w	1
SoundTest_VisualizerPos_TilePtr:	rs.w	1
SoundTest_VisualizerPos_TileOffset:	rs.w	1
SoundTest_Visualizer_PixelBuffer:	rs.b	SoundTest_Visualizer_Width*4
SoundTest_VisualizerBufferPtr:		rs.w	1
SoundTest_VisualizerBufferDest:		rs.l	1	; VDP command
SoundTest_VisualizerWriteRequests:	rs.b	6*SoundTest_Visualizer_MaxWriteRequests
SoundTest_VisualizerWriteRequests_End:	equ	__rs
SoundTest_VisualizerWriteRequestsPos:	rs.w	1

SoundTest_CurrentTextStartScreenPos:	rs.w	1
SoundTest_StringBuffer:			rs.b	SoundTest_StringBufferSize
					rseven

