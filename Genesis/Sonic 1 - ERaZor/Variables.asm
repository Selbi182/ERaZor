
BlackBars.Height:		equ		$FFFFF5F6				; w		Height of black bars in pixels
BlackBars.FirstHCnt:	equ		$FFFFF5F8				; w		$8Axx VDP register value for the first HInt
BlackBars.SecondHCnt:	equ		$FFFFF5FA				; w		$8Axx VDP register value for the second HInt
HBlankHndl:				equ		$FFFFF5FC				; l/w	Jump code for HInt
HBlankSubW:				equ		$FFFFF5FE				; w		Word offset for HInt routine 

; ---------------------------------------------------------------
; System Ports
; ---------------------------------------------------------------

VDP_Data				equ 	$C00000 		;		VDP Data Port
VDP_Ctrl				equ 	$C00004 		;		VDP Control Port
