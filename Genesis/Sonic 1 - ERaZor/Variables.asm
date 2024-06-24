
ChunksArray:	 	equ 	$FF0000 			;	256x256 chunks table (0000-A400)

LevelLayout:	 	equ 	$FFFFA400			;	level layout (A400-A7FF)

; <<FOR SALE>>							;	<<FOR SALE / $20,000>> (A800-AFFF)

Art_Buffer: 		equ 	$FFFFB000			;	Art buffer, used for decompression and transfers (B000-CAFF)
Art_Buffer_End:		equ	$FFFFC000			;	WARNING! Buffer should be at least $1000 bytes for PLC system to work


; 

SoundDriverRAM:		equ	$FFFFF000			;	SMPS RAM

VBlank_NonLagFrameCounter:	equ	$FFFFF5DC		; l	

VSyncWaitTicks_64bit:	equ	$FFFFF5E0			; 2l	Full 64-bit version of: Ticks counter for VSync loop (`DelayProgram`)
VSyncWaitTicks:		equ	$FFFFF5E4			; l	Ticks counter for VSync loop (`DelayProgram`)

VBlank_MusicOnly:	equ	$FFFFF5EB			; b		

BlocksAddress:		equ	$FFFFF5EC			; l 	Address for level 16x16 blocks (uncompressed)

BlackBars.GHPTimer:	equ	$FFFFF5F0			; b
BlackBars.GHPTimerReset:equ	$FFFFF5F1			; b
BlackBars.BaseHeight:	equ	$FFFFF5F2			; w	Base height of black bars in pixels
BlackBars.TargetHeight:	equ	$FFFFF5F4			; w	Target height of black bars in pixels
BlackBars.Height:	equ	$FFFFF5F6			; w	Current height of black bars in pixels
BlackBars.FirstHCnt:	equ	$FFFFF5F8			; w	$8Axx VDP register value for the first HInt
BlackBars.SecondHCnt:	equ	$FFFFF5FA			; w	$8Axx VDP register value for the second HInt
HBlankHndl:		equ	$FFFFF5FC			; l/w	Jump code for HInt
HBlankSubW:		equ	$FFFFF5FE			; w	Word offset for HInt routine 

VBlankRoutine:		equ	$FFFFF62A			; b	VBlank routine id

PLC_RAM:		equ	$FFFFF680			;	PLC system variables (F680-F69E)

VBlank_FrameCounter:	equ	$FFFFFE0C			; l	Global frame counter for VBlank (includes lag frames)


	if def(__MD_REPLAY__)
; __MD_REPLAY__ = 'rec'
MDReplay_RecPtr:	equ		$FFFFF000			; l
MDReplay_RLECount:	equ		$FFFFF000			; b
; __MD_REPLAY__ = 'play'
MDReplay_PlayPtr:	equ		$FFFFF000			; l
	endif
