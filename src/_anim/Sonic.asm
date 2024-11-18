; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------
		dc.w SonAni_Walk-SonicAniData		; 0
		dc.w SonAni_Run-SonicAniData		; 1
		dc.w SonAni_Roll-SonicAniData		; 2
		dc.w SonAni_Roll2-SonicAniData		; 3
		dc.w SonAni_Push-SonicAniData		; 4
		dc.w SonAni_Wait-SonicAniData		; 5
		dc.w SonAni_Balance-SonicAniData 	; 6
		dc.w SonAni_LookUp-SonicAniData		; 7
		dc.w SonAni_Duck-SonicAniData		; 8
		dc.w SonAni_Warp1-SonicAniData		; 9
		dc.w SonAni_Warp2-SonicAniData		; $A
		dc.w SonAni_Warp3-SonicAniData		; $B
		dc.w SonAni_Warp4-SonicAniData		; $C
		dc.w SonAni_Stop-SonicAniData		; $D
		dc.w SonAni_Float1-SonicAniData		; $E
		dc.w SonAni_Float2-SonicAniData		; $F
		dc.w SonAni_Spring-SonicAniData		; $10
		dc.w SonAni_LZHang-SonicAniData		; $11
		dc.w SonAni_Leap1-SonicAniData		; $12
		dc.w SonAni_Leap2-SonicAniData		; $13
		dc.w SonAni_Surf-SonicAniData		; $14
		dc.w SonAni_Bubble-SonicAniData		; $15
		dc.w SonAni_Death1-SonicAniData		; $16
		dc.w SonAni_Drown-SonicAniData		; $17
		dc.w SonAni_Death2-SonicAniData		; $18
		dc.w SonAni_Shrink-SonicAniData		; $19
		dc.w SonAni_Hurt-SonicAniData		; $1A
		dc.w SonAni_LZSlide-SonicAniData	; $1B
		dc.w SonAni_Blank-SonicAniData		; $1C
		dc.w SonAni_Float3-SonicAniData		; $1D
		dc.w SonAni_Float4-SonicAniData		; $1E
		dc.w SonAni_Spindash-SonicAniData	; $1F
		dc.w SonAni_SPO-SonicAniData		; $20
		dc.w SonAni_FastRunning-SonicAniData	; $21
		dc.w SonAni_Null1-SonicAniData		; $22
		dc.w SonAni_Null2-SonicAniData		; $23
		dc.w SonAni_Null3-SonicAniData		; $24
		dc.w SonAni_Death_New-SonicAniData	; $25
		dc.w SonAni_Running_SPO-SonicAniData	; $26		
		dc.w SonAni_Sprinting_SPO-SonicAniData	; $27
		dc.w SonAni_HomeRoll-SonicAniData	; $28	
		dc.w SonAni_DownDash-SonicAniData	; $29
		dc.w SonAni_EXTREME-SonicAniData	; $2A
		dc.w SonAni_DeathGrnd-SonicAniData	; $2B
		dc.w SonAni_Drown2-SonicAniData		; $2C
SonAni_Walk:	dc.b $FF, 8, 9,	$A, $B,	6, 7, $FF
SonAni_Run:	dc.b $FF, $1E, $1F, $20, $21, $FF, $FF,	$FF
SonAni_Roll:	dc.b $FE, $2E, $2F, $30, $31, $32, $FF,	$FF
SonAni_Roll2:	dc.b $FE, $2E, $2F, $32, $30, $31, $32,	$FF
SonAni_Push:	dc.b $FD, $45, $46, $47, $48, $FF, $FF,	$FF
;SonAni_Wait:	dc.b $17, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 2, $FE, 1 ;2, 2, 3, 4, $FE, 2, 0

SonAni_Wait:	dc.b 6
		dc.b 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 
		dc.b 4
		dc.b 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
		dc.b 3 ; omg he can blink
		dc.b $FE, 12*4+1

SonAni_Balance:	dc.b $1F, $3A, $3B, $FF
SonAni_LookUp:	dc.b $3F, 5, $FF, 0
SonAni_Duck:	dc.b $3F, $39, $FF, 0
SonAni_Warp1:	dc.b 0, $36, $35, $34, $33, $FF, 0
SonAni_Warp2:	dc.b $3F, $34, $FF, 0
SonAni_Warp3:	dc.b $3F, $35, $FF, 0
SonAni_Warp4:	dc.b $3F, $36, $FF, 0
SonAni_Stop:	dc.b 7,	$37, $38, $FF
SonAni_Float1:	dc.b 7,	$3C, $3F, $FF
SonAni_Float2:	dc.b 7,	$3C, $3D, $53, $3E, $54, $FF, 0
SonAni_Spring:	dc.b $2F, $40, $FF ;$FD, 2
SonAni_LZHang:	dc.b 4,	$41, $42, $FF
SonAni_Leap1:	dc.b $F, $43, $43, $43,	$FE, 1
SonAni_Leap2:	dc.b $F, $43, $44, $FE,	1, 0
SonAni_Surf:	dc.b $3F, $49, $FF, 0
SonAni_Bubble:	dc.b $B, $56, $56, $A, $B, $FD,	0, 0
SonAni_Death1:	dc.b $20, $4B, $FF, 0
SonAni_Drown:	dc.b $2F, $4C, $FF, 0
SonAni_Death2:	dc.b 1, $74, $73, $72, $71, $70, $6F, $6E, $FF, 0
SonAni_Shrink:	dc.b 3,	$4E, $4F, $50, $51, $52, 0, $FE, 1, 0
SonAni_Hurt:	dc.b 3,	$57, $FF, 0 ;$55
SonAni_LZSlide:	dc.b 7, $55, $57, $FF
SonAni_Blank:	dc.b $77, 0, $FD, 0
SonAni_Float3:	dc.b 3,	$3C, $3D, $53, $3E, $54, $FF, 0
SonAni_Float4:	dc.b 3,	$3C, $FD, 0
SonAni_Spindash:	dc.b 0, $58, $59, $58, $5A, $58, $5B, $58, $5C, $58, $5D, $FF
SonAni_SPO:		dc.b 1, 8, 8, 9, 9, $A, $A, $B, $B, $FD, $26
SonAni_FastRunning:	dc.b $FF, $5E, $5F, $60, $61, $FF, $FF, $FF, $FF, $FF
SonAni_Null1:		dc.b 0
SonAni_Null2:		dc.b 0
SonAni_Null3:		dc.b 0
SonAni_Death_New:	dc.b 0, $74, $73, $72, $71, $70, $6F, $6E, $FF, 0
SonAni_Running_SPO:	dc.b 1, $1E, $1F, $20, $21, $1E, $1F, $1E, $1F, $20, $21, $FD, $27
SonAni_Sprinting_SPO:	dc.b 0, $5E, $5F, $60, $61, $FF
SonAni_HomeRoll:	dc.b 0, $2E, $2F, $32, $30, $31, $32, $FF
SonAni_DownDash:	dc.b 0, $35, $75, $FF
SonAni_EXTREME:		dc.b 0,0,1,2,3,4,5,6,7,8,9,$A,$B,$C,$D,$E,$F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$FF
SonAni_DeathGrnd:	dc.b $2F, $54, $FF, 0
SonAni_Drown2:		dc.b 5, $54, $FD, $17
		even