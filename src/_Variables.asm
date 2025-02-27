
ChunksArray:	 	equ 	$FF0000 			;	256x256 chunks table (0000-A400)

SS_PositionMatrix:	equ	$FFFF8000			;	Sprites positions matrix for SS
SS_SpritesQueue:	equ	$FFFF9000			;	Sprites queue for the special stage

LevelLayout_RAM:	equ	$FFFFA400
LevelLayout_FG:		equ 	LevelLayout_RAM			;	FG level layout (A400-A5FF)
LevelLayout_BG:		equ 	LevelLayout_RAM+$200		;	BG level layout (A600-A7FF)

DrawBuffer_RAM:		equ	$FFFFA800			;	draw buffer RAM (A800-AB7F)
LevelRend_RAM:		equ	$FFFFAB80			;	level renderer RAM (AB80-AB98)
SRAMCache_RAM:		equ	$FFFFAB98			;	SRAM cache RAM (AB98-AC00)
SRAMCache_RAM_End:	equ	$FFFFAC00			;

Sprites_Queue:		equ	$FFFFAC00			;	object sprites queued for display (AC00-AFFF)
Art_Buffer: 		equ 	$FFFFB000			;	Art buffer, used for decompression and transfers (B000-C000)
Art_Buffer_End:		equ	$FFFFC000			;	WARNING! Buffer should be at least $1000 bytes for PLC system to work
*			equ	$FFFFC000			;	<<<FOR SALE>> (C000-C700)
DeleteQueue:		equ	$FFFFC700			;	Delete queue
DeleteQueue_End:	equ	$FFFFC7FE
DeleteQueue_Ptr:	equ	$FFFFC7FE			;	Delete objects queue pointer
DMAQueue:		equ	$FFFFC800			;
DMAQueuePos:		equ	$FFFFC8FC			; .w	DMA queue position pointer
*			equ	$FFFFC8FE			; .w	<<<FREE>>>
PalCache_PauseEffect:	equ	$FFFFC900			;	Palette cache for pause effect (C900-C9FF)
PalCache_FlashEffect:	equ	$FFFFCA00			;	Palette cache for flash effect (CA00-CAFF)
Sonic_PosArray:		equ	$FFFFCB00			;	Sonic's previous positions array (CB00-CBFF)
HSRAM_Buffer:		equ	$FFFFCC00			;	Horizontal scroll RAM buffer
HSRAM_Buffer_End:	equ	HSRAM_Buffer+240*4
ScrollBlocks_Buffer:	equ	$FFFFCFC0			;	Buffer for scrolling 16x16 blocks ($20 blocks)
ScrollBlocks_Buffer_End:equ	$FFFFD000

Objects:		equ	$FFFFD000			;	Objects RAM (D000-EFFF)
Objects_End:		equ	$FFFFF000			;	End of Objects RAM

SoundDriverRAM:		equ	$FFFFF000			;	SMPS RAM
SoundDriverRAM_End:	equ	$FFFFF5C0			;	End of SMPS RAM

VBlankHndl:		equ	$FFFFF5C8			; l/w	Jump code for VInt
VBlankSubW:		equ	$FFFFF5CA			; w	Word offset for VInt routine 
*			equ	$FFFFF5CC			; b	<<FREE>>
VDPDebugPortSet:	equ	$FFFFF5CD			; b	Set if VDP Debug port was tampered with
BlackBars.Handler:	equ	$FFFFF5CE			; w	Pointer to Black Bars handler routines (depending on `BlackBars.HandlerId`)
*			equ	$FFFFF5D0			; b	"Signpost patterns have been loaded" flag
DyingFlag:		equ	$FFFFF5D1			; b	Flag set while Sonic is currently dying
BlackBars.HandlerId:	equ	$FFFFF5D2			; b	Black Bars handler id (also sets `BlackBars.Handler`)
RedrawEverything:	equ	$FFFFF5D3			; b	Flag used to redraw the entire screen after teleporting
FranticDrain:		equ	$FFFFF5D4			; w	Rings to be drained in frantic mode
BGThemeColor:		equ	$FFFFF5D6			; w	Background color used for the BG effects for the story screens, etc.
*			equ	$FFFFF5D8			; b	<<FREE>>
VBlank_MusicOnly:	equ	$FFFFF5D9			; b		
VBlank_NonLagFrameCounter:	equ	$FFFFF5DC		; l	
VSyncWaitTicks_64bit:	equ	$FFFFF5E0			; 2l	Full 64-bit version of: Ticks counter for VSync loop (`DelayProgram`)
VSyncWaitTicks:		equ	$FFFFF5E4			; l	Ticks counter for VSync loop (`DelayProgram`)
VBlankCallback:		equ	$FFFFF5E8			; l	One-time callback routine pointer for VBlank
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

GameMode:		equ	$FFFFF600			; b	Current game mode
CarryOverData:		equ	$FFFFF601			; b	custom data carried over multiple game modes
SonicControl:		equ	$FFFFF602			; w
Joypad:			equ	$FFFFF604			; w
SMPS_PAL_Timer:		equ	$FFFFF608			; b	Timer for SMPS PAL optimization

DemoTimer:		equ	$FFFFF614			; w	Timer for demos, decremented by certain VBlank routines until zero
VSRAM_Buffer:		equ	$FFFFF616			;	Verical Scroll RAM (VSRAM) buffer
VSRAM_PlaneA:		equ	VSRAM_Buffer+0			; w
VSRAM_PlaneB:		equ	VSRAM_Buffer+2			; w

VBlankRoutine:		equ	$FFFFF62A			; b	VBlank routine id

RandomSeed:		equ	$FFFFF636			; l	Seed used by `RandomNumber` subroutine

RingFrame:		equ	$FFFFF640			; b	current synchronized smooth ring frame
RingFrame_Timer:	equ	$FFFFF641			; b	time until next smooth ring frame change
RingFrame2:		equ	$FFFFF642			; b	current synchronized smooth ring frame for lost rings (no timer; updates every frame)

*			equ	$FFFFF644			; w	<<FOR SALE>>

SMPS_Running:		equ	$FFFFF64F			; b	"SMPS running flag"

PLC_RAM:		equ	$FFFFF680			;	PLC system variables (F680-F69E)

; == WARNING! F700 - F7FF is cleared upon Level initialization! ==
Camera_RAM:		equ	$FFFFF700
Camera_FG:		equ 	$FFFFF700
CamXpos: 		equ 	$FFFFF700			; l 	Camera X position (FG)
CamYpos: 		equ 	$FFFFF704			; l 	Camera Y position (FG)
Camera_BG:		equ 	$FFFFF708
CamXpos2:		equ 	$FFFFF708			; l 	Camera X position (BG1)
CamYpos2:		equ 	$FFFFF70C			; l 	Camera Y position (BG1)
CamXpos3:		equ 	$FFFFF710			; l 	Camera X position (BG2)
CamYpos3:		equ 	$FFFFF714			; l 	Camera Y position (BG2)
CamXpos4:		equ 	$FFFFF718			; l 	Camera X position (BG3)
CamYpos4:		equ 	$FFFFF71C			; l 	Camera Y position (BG3)
CamXpos5:		equ	$FFFFF720			; l	Camera X position (BG4)
Camera_RAM_Size:	equ	$FFFFF724-Camera_RAM

CamXShift:		equ	$FFFFF73A			; w	Camera X shift from the previous frame (FG, 8.8 fixed)
CamYShift:		equ	$FFFFF73C			; w	Camera Y shift from the previous frame (FG, 8.8 fixed)

SonicLookUpDownTimer:	equ	$FFFFF778			; b	Timer for camera delay when looking up/down
*Credits_Page:		equ	$FFFFF779			; b 	See `CreditsScreen.asm`
*			equ	$FFFFF77A			; b 	<<FREE>>
*			equ	$FFFFF77B			; b 	<<FREE>>
*			equ	$FFFFF77C			; l	<<FREE>>

AniArt_Slot_RAM:	equ	$FFFFF7B0
AniArt_Slot0_Frame:	equ	$FFFFF7B0			; b	Slot 0 : Art frame
AniArt_Slot0_Timer:	equ	$FFFFF7B1			; b	Slot 0 : Timer value 
AniArt_Slot1_Frame:	equ	$FFFFF7B2			; b	Slot 1 : Art frame
AniArt_Slot1_Timer:	equ	$FFFFF7B3			; b	Slot 1 : Timer value
AniArt_Slot2_Frame:	equ	$FFFFF7B4			; b	Slot 2 : Art frame
AniArt_Slot2_Timer:	equ	$FFFFF7B5			; b	Slot 2 : Timer value
AniArt_Slot3_Frame:	equ	$FFFFF7B6			; b	Slot 3 : Art frame
AniArt_Slot3_Timer:	equ	$FFFFF7B7			; b	Slot 3 : Timer value
AniArt_Slot4_Frame:	equ	$FFFFF7B8			; b	Slot 4 : Art frame	-- WARNING! Occupies higher byte of "AniArt_UpdateProc"!
AniArt_UpdateProc:	equ	$FFFFF7B8			; l	Update procedure pointer

Sprite_Buffer:		equ	$FFFFF800			;	VDP sprites buffer
Sprite_Buffer_End:	equ	$FFFFFA80

Pal_Water_Active:	equ	$FFFFFA80			; ~	Active underwater palette
Pal_Active:		equ	$FFFFFB00			; ~	Active palette
Pal_Target:		equ	$FFFFFB80			; ~	Target palette for fading

ObjectSpawnTable:	equ	$FFFFFC00			;	Object respawn status table
ObjectSpawnTable_End:	equ	$FFFFFD00			;

GameFrame:		equ	$FFFFFE04			; w

VBlank_FrameCounter:	equ	$FFFFFE0C			; l	Global frame counter for VBlank (includes lag frames)

CurrentLevel:		equ	$FFFFFE10			; w	Current level ID
CurrentZone:		equ	CurrentLevel+0			; b	Current zone index
CurrentAct:		equ	CurrentLevel+1			; b	Current zone act (0..3)

Deaths:			equ	$FFFFFE12			; w	Deaths

Rings:			equ	$FFFFFE20			; w	Rings counter

Score:			equ	$FFFFFE26			; l	Score


FZEscape:		equ	$FFFFFEA0			; b	flag set during the Finalor Place escape
FZFlashTimer:		equ	$FFFFFEA2			; b	timer for updating the FP palette during escape
FZFlashColor:		equ	$FFFFFEA4			; w	FP palette increment counter


Blackout:		equ	$FFFFFF5F			; b	flag when Blackout Challenge is currently active

CameraShake:		equ	$FFFFFF60			; b	duration timer for the camera shake, 0 implies no active cam shake
CameraShake_Intensity:	equ	$FFFFFF61			; b	maximum cam shake offset distance, in pixels
CameraShake_XOffset:	equ	$FFFFFF62			; w	current camera shake X offset 
CameraShake_YOffset:	equ	$FFFFFF64			; w	current camera shake Y offset

HUD_BossHealth:		equ	$FFFFFF68			; b	current health of a boss to be displayed instead of the HUD deaths counter

TutorialBoxId:		equ	$FFFFFF6E			; b	requested tutorial box id

BossHealth:		equ	$FFFFFF75			; b	current health of a boss (not used by all bosses!)

SpaceGolf:		equ	$FFFFFF77			; b	space golf / antigrav in Star Agony Place

Options_FirstStartFlag:	equ	$FFFFFF84			; b	flag set when the options menu is accessed from a new save slot

Doors:			equ	$FFFFFF8A			; w	bit field for beaten levels
Doors_Casual:		equ	Doors+0				; b	bit field for beaten levels in casual
Doors_Frantic:		equ	Doors+1				; b	bit field for beaten levels in frantic

SlotProgress:		equ	$FFFFFF90			; b	bit field for save slot-local game progress
SlotOptions:		equ	$FFFFFF91			; b	bit field for the save slot options
SlotOptions2:		equ	$FFFFFF92			; b	bit field for secondary slot options (screen fuzz, arcade mode)
GlobalProgress:		equ	$FFFFFF93			; b	bit field for overall game progress
GlobalOptions:		equ	$FFFFFF94			; b	bit field for overall game options

StoryTextID:		equ	$FFFFFF9E			; b	current story text ID
CurrentChapter:		equ	$FFFFFFA7			; b	current chapter ID

WhiteFlashCounter:	equ	$FFFFFFB1			; b	number of remaining frames a white flash is still in progress

RelativeDeaths:		equ	$FFFFFFCA			; w	number of deaths since the player started the current level

ExtCamShift:		equ	$FFFFFFCE			; w	current signed pixel offset for the extended camera

Inhuman:		equ	$FFFFFFE7			; b	flag when Inhuman Mode is enabled

*			equ	$FFFFFFE9			; b	Fade out in progress flag
	if def(__MD_REPLAY__)
; WARNING! MD Replay conflicts with SMPS RAM, but SMPS is disabled when `__MD_REPLAY__` is set
; __MD_REPLAY__ = 'rec'
MDReplay_RecPtr:	equ	$FFFFF100			; l
MDReplay_RLECount:	equ	$FFFFF100			; b
; __MD_REPLAY__ = 'play'
MDReplay_PlayPtr:	equ	$FFFFF100			; l
	endif
