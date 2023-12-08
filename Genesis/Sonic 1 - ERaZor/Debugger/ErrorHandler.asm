
; ===============================================================
; ---------------------------------------------------------------
; Error handling and debugging modules
;
; (c) 2016-2023, Vladikcomper
; ---------------------------------------------------------------
; Error handler functions and calls
; ---------------------------------------------------------------

; ---------------------------------------------------------------
; Error handler control flags
; ---------------------------------------------------------------

; Screen appearence flags
_eh_address_error	equ	$01		; use for address and bus errors only (tells error handler to display additional "Address" field)
_eh_show_sr_usp		equ	$02		; displays SR and USP registers content on error screen

; Advanced execution flags
; WARNING! For experts only, DO NOT USES them unless you know what you're doing
_eh_return			equ	$20
_eh_enter_console	equ	$40
_eh_align_offset	equ	$80

; ---------------------------------------------------------------
; Errors vector table
; ---------------------------------------------------------------

; Default screen configuration
_eh_default			equ	0 ;_eh_show_sr_usp

; ---------------------------------------------------------------

BusError:
	__ErrorMessage "BUS ERROR", _eh_default|_eh_address_error

AddressError:
	__ErrorMessage "ADDRESS ERROR", _eh_default|_eh_address_error

IllegalInstr:
	__ErrorMessage "ILLEGAL INSTRUCTION", _eh_default

ZeroDivide:
	__ErrorMessage "ZERO DIVIDE", _eh_default

ChkInstr:
	__ErrorMessage "CHK INSTRUCTION", _eh_default

TrapvInstr:
	__ErrorMessage "TRAPV INSTRUCTION", _eh_default

PrivilegeViol:
	__ErrorMessage "PRIVILEGE VIOLATION", _eh_default

Trace:
	__ErrorMessage "TRACE", _eh_default

Line1010Emu:
	__ErrorMessage "LINE 1010 EMULATOR", _eh_default

Line1111Emu:
	__ErrorMessage "LINE 1111 EMULATOR", _eh_default

ErrorExcept:
	__ErrorMessage "ERROR EXCEPTION", _eh_default


; ---------------------------------------------------------------
; Import error handler global functions
; ---------------------------------------------------------------

; Debugger extension functions
__global__ErrorHandler_ConsoleOnly: equ DebuggerExtensions+$0
__global__ErrorHandler_ClearConsole: equ DebuggerExtensions+$26
__global__KDebug_WriteLine_Formatted: equ DebuggerExtensions+$50
__global__KDebug_Write_Formatted: equ DebuggerExtensions+$54
__global__KDebug_FlushLine: equ DebuggerExtensions+$AA
__global__ErrorHandler_PauseConsole: equ DebuggerExtensions+$C2
__global__ErrorHandler_PagesController: equ DebuggerExtensions+$F8
__global__VSync: equ DebuggerExtensions+$158

; Error handler & core functions
__global__ErrorHandler: equ ErrorHandler+$0
__global__Error_IdleLoop: equ ErrorHandler+$122
__global__Error_InitConsole: equ ErrorHandler+$13C
__global__Error_MaskStackBoundaries: equ ErrorHandler+$148
__global__Error_DrawOffsetLocation: equ ErrorHandler+$1B2
__global__Error_DrawOffsetLocation2: equ ErrorHandler+$1B6
__global__ErrorHandler_SetupVDP: equ ErrorHandler+$23C
__global__ErrorHandler_VDPConfig: equ ErrorHandler+$274
__global__ErrorHandler_VDPConfig_Nametables: equ ErrorHandler+$28A
__global__ErrorHandler_ConsoleConfig_Initial: equ ErrorHandler+$2C6
__global__ErrorHandler_ConsoleConfig_Shared: equ ErrorHandler+$2CA
__global__Art1bpp_Font: equ ErrorHandler+$336
__global__FormatString: equ ErrorHandler+$946
__global__Console_Init: equ ErrorHandler+$A1C
__global__Console_Reset: equ ErrorHandler+$A5E
__global__Console_InitShared: equ ErrorHandler+$A60
__global__Console_SetPosAsXY_Stack: equ ErrorHandler+$A9C
__global__Console_SetPosAsXY: equ ErrorHandler+$AA2
__global__Console_GetPosAsXY: equ ErrorHandler+$AD0
__global__Console_StartNewLine: equ ErrorHandler+$AF2
__global__Console_SetBasePattern: equ ErrorHandler+$B1A
__global__Console_SetWidth: equ ErrorHandler+$B2E
__global__Console_WriteLine_WithPattern: equ ErrorHandler+$B44
__global__Console_WriteLine: equ ErrorHandler+$B46
__global__Console_Write: equ ErrorHandler+$B4A
__global__Console_WriteLine_Formatted: equ ErrorHandler+$BF6
__global__Console_Write_Formatted: equ ErrorHandler+$BFA
__global__Decomp1bpp: equ ErrorHandler+$C2A

; ---------------------------------------------------------------
; Built-in debuggers
; ---------------------------------------------------------------

Debugger_AddressRegisters:

	dc.l	$48E700FE, $41FA002A
	jsr		__global__Console_Write(pc)
	dc.l	$49D77C06, $3F3C2000, $2F3CE861, $303A41D7
	dc.w	$221C
	jsr		__global__Error_DrawOffsetLocation(pc)
	dc.l	$522F0002, $51CEFFF2, $4FEF0022, $4E75E0FA, $01F026EA, $41646472, $65737320, $52656769
	dc.l	$73746572, $733AE0E0
	dc.w	$0000

Debugger_Backtrace:

	dc.l	$41FA0088
	jsr		__global__Console_Write(pc)
	dc.l	$22780000, $598945D7
	jsr		__global__Error_MaskStackBoundaries(pc)
	dc.l	$B3CA6570, $0C520040, $64642012, $67602040, $02400001, $66581220, $10200C00, $00616604
	dc.l	$4A01663A, $0C00004E, $660A0201, $00F80C01, $0090672A, $30200C40, $61006722, $12004200
	dc.l	$0C404E00, $66120C01, $00A8650C, $0C0100BB, $62060C01, $00B96606, $0C604EB9, $66102F0A
	dc.l	$2F092208
	jsr		__global__Error_DrawOffsetLocation2(pc)
	dc.l	$225F245F, $548A548A, $B3CA6490, $4E75E0FA, $01F026EA, $4261636B, $74726163, $653AE0E0
	dc.w	$0000

; ---------------------------------------------------------------
; Debugger extensions
; ---------------------------------------------------------------

DebuggerExtensions:

	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $47EF003C
	jsr		__global__ErrorHandler_SetupVDP(pc)
	jsr		__global__Error_InitConsole(pc)
	dc.l	$4CDF7FFF
	pea		__global__Error_IdleLoop(pc)
	dc.l	$2F2F0012, $4E752F0B, $4E6B0C2B, $005D000C, $661A48E7, $C4464BF9, $00C00004, $4DEDFFFC
	lea		__global__ErrorHandler_ConsoleConfig_Initial(pc), a1
	jsr		__global__Console_Reset(pc)
	dc.l	$4CDF6223, $265F4E75, $487A0058, $4E680C28, $005D000C, $67182F0C, $49FA0016, $4FEFFFF0
	dc.l	$41D77E0E
	jsr		__global__FormatString(pc)
	dc.l	$4FEF0010, $285F4E75, $42184447, $0647000F, $90C72F08, $2F0D4BF9, $00C00004, $3E3C9E00
	dc.l	$60023A87, $1E186EFA, $67080407, $00E067F2, $60F22A5F, $205F7E0E, $4E752F08, $4E680C28
	dc.l	$005D000C, $670833FC, $9E0000C0, $0004205F, $4E7548E7, $C0D04E6B, $0C2B005D, $000C660C
	dc.l	$3F3C0000, $610C610A, $67FC544F, $4CDF0B03, $4E756174, $41EF0004, $43F900A1, $00036178
	dc.l	$70F0C02F, $00054E75, $48E7FFFE, $3F3C0000, $61E04BF9, $00C00004, $4DEDFFFC, $61D467F2
	dc.l	$6B4041FA, $00765888, $D00064FA, $20106F32, $20404FEF
	dc.w	$FFF2
	lea		__global__ErrorHandler_ConsoleConfig_Shared(pc), a1
	dc.l	$47D72A3C, $40000003
	jsr		__global__Console_InitShared(pc)
	dc.l	$2ABC8230, $84062A85, $487A000C, $48504CEF, $7FFF0014, $4E754FEF, $000E60B0
	move.l	__global__ErrorHandler_VDPConfig_Nametables(pc), (a5)
	dc.l	$60AA41F9, $00C00004, $44D06BFC, $44D06AFC, $4E7512BC, $00004E71, $72C01011, $E50812BC
	dc.l	$00404E71, $C0011211, $0201003F, $80014600, $1210B101, $10C0C200, $10C14E75

; WARNING! Don't move! This must be placed directly below "DebuggerExtensions"
DebuggerExtensions_ExtraDebuggerList:
	dc.l	DEBUGGER__EXTENSIONS__BTN_A_DEBUGGER	; for button A
	dc.l	DEBUGGER__EXTENSIONS__BTN_C_DEBUGGER	; for button C (not B)
	dc.l	DEBUGGER__EXTENSIONS__BTN_B_DEBUGGER	; for button B (not C)

; ---------------------------------------------------------------
; Error handler blob
; ---------------------------------------------------------------

ErrorHandler:

	dc.l	$46FC2700, $4FEFFFF2, $48E7FFFE, $4EBA022E, $49EF004A, $4E682F08, $47EF0040, $4EBA011E
	dc.l	$41FA02B2, $4EBA0B24, $225C45D4, $4EBA0BC8, $4EBA0AC0, $49D21C19, $6A025249, $47D10806
	dc.l	$0000670E, $41FA0295, $222C0002, $4EBA0164, $504C41FA, $0292222C, $00024EBA, $01562278
	dc.l	$000045EC, $00064EBA, $01AE41FA, $02844EBA, $01424EBA, $0A7E0806, $00066600, $00AA45EF
	dc.l	$00044EBA, $0A4C3F01, $70034EBA, $0A16303C, $64307A07, $4EBA0132, $321F7011, $4EBA0A04
	dc.l	$303C6130, $7A064EBA, $0120303C, $73707A00, $2F0C45D7, $4EBA0112, $584F0806, $00016714
	dc.l	$43FA0241, $45D74EBA, $0B3243FA, $024245D4, $4EBA0B24, $584F4EBA, $09F85241, $70014EBA
	dc.l	$09C22038, $007841FA, $02304EBA, $010A2038, $007041FA, $022C4EBA, $00FE4EBA, $09F62278
	dc.l	$000045D4, $53896140, $4EBA09C6, $7A199A41, $6B0A6148, $4EBA005A, $51CDFFFA, $08060005
	dc.l	$660A4E71, $60FC7200, $4EBA09F0, $2ECB4CDF, $7FFF487A, $FFEE2F2F, $FFC44E75, $43FA0152
	dc.l	$45FA01F4, $4EFA08D6, $223C00FF, $FFFF2409, $C4812242, $240AC481, $24424E75, $4FEFFFD0
	dc.l	$41D77EFF, $20FC2853, $502930FC, $3A206018, $4FEFFFD0, $41D77EFF, $30FC202B, $320A924C
	dc.l	$4EBA05A6, $30FC3A20, $700572EC, $B5C96502, $72EE10C1, $321A4EBA, $05AE10FC, $002051C8
	dc.l	$FFEA4218, $41D77200, $4EBA099A, $4FEF0030, $4E754EBA, $09962F01, $2F0145D7, $43FA013C
	dc.l	$4EBA0A34, $504F4E75, $4FEFFFF0, $7EFF41D7, $30C030FC, $3A2010FC, $00EC221A, $4EBA0560
	dc.l	$421841D7, $72004EBA, $095C5240, $51CDFFE0, $4FEF0010, $4E752200, $48414601, $66F62440
	dc.l	$0C5A4EF9, $66042212, $60A84EBA, $093E41FA, $01184EFA, $09325989, $4EBAFF2E, $B3CA650C
	dc.l	$0C520040, $650A548A, $B3CA64F4, $72004E75, $221267F2, $08010000, $66EC4E75, $4BF900C0
	dc.l	$00044DED, $FFFC4A55, $44D569FC, $41FA0026, $30186A04, $3A8060F8, $70002ABC, $40000000
	dc.l	$2C802ABC, $40000010, $2C802ABC, $C0000000, $3C804E75, $80048134, $85008700, $8B008C81
	dc.l	$8D008F02, $90119100, $92008220, $84040000, $44000000, $00000001, $00100011, $01000101
	dc.l	$01100111, $10001001, $10101011, $11001101, $11101111, $FFFF0EEE, $FFF200CE, $FFF20EEA
	dc.l	$FFF20E86, $FFF24000, $00020028, $00280000, $008000FF, $EAE0FA01, $F02600EA, $41646472
	dc.l	$6573733A, $2000EA4F, $66667365, $743A2000, $EA43616C, $6C65723A, $2000EC80, $8120E8BF
	dc.l	$ECC800FA, $10E87573, $703A20EC, $8300FA03, $E873723A, $20EC8100, $EA56496E, $743A2000
	dc.l	$EA48496E, $743A2000, $E83C756E, $64656669, $6E65643E, $000002F7, $00000000, $00000000
	dc.l	$183C3C18, $18001800, $6C6C6C00, $00000000, $6C6CFE6C, $FE6C6C00, $187EC07C, $06FC1800
	dc.l	$00C60C18, $3060C600, $386C3876, $CCCC7600, $18183000, $00000000, $18306060, $60301800
	dc.l	$60301818, $18306000, $00EE7CFE, $7CEE0000, $0018187E, $18180000, $00000000, $18183000
	dc.l	$000000FE, $00000000, $00000000, $00383800, $060C1830, $60C08000, $7CC6CEDE, $F6E67C00
	dc.l	$18781818, $18187E00, $7CC60C18, $3066FE00, $7CC6063C, $06C67C00, $0C1C3C6C, $FE0C0C00
	dc.l	$FEC0FC06, $06C67C00, $7CC6C0FC, $C6C67C00, $FEC6060C, $18181800, $7CC6C67C, $C6C67C00
	dc.l	$7CC6C67E, $06C67C00, $001C1C00, $001C1C00, $00181800, $00181830, $0C183060, $30180C00
	dc.l	$0000FE00, $00FE0000, $6030180C, $18306000, $7CC6060C, $18001800, $7CC6C6DE, $DCC07E00
	dc.l	$386CC6C6, $FEC6C600, $FC66667C, $6666FC00, $3C66C0C0, $C0663C00, $F86C6666, $666CF800
	dc.l	$FEC2C0F8, $C0C2FE00, $FE62607C, $6060F000, $7CC6C0C0, $DEC67C00, $C6C6C6FE, $C6C6C600
	dc.l	$3C181818, $18183C00, $3C181818, $D8D87000, $C6CCD8F0, $D8CCC600, $F0606060, $6062FE00
	dc.l	$C6EEFED6, $D6C6C600, $C6E6E6F6, $DECEC600, $7CC6C6C6, $C6C67C00, $FC66667C, $6060F000
	dc.l	$7CC6C6C6, $C6D67C06, $FCC6C6FC, $D8CCC600, $7CC6C07C, $06C67C00, $7E5A1818, $18183C00
	dc.l	$C6C6C6C6, $C6C67C00, $C6C6C6C6, $6C381000, $C6C6D6D6, $FEEEC600, $C66C3838, $386CC600
	dc.l	$6666663C, $18183C00, $FE860C18, $3062FE00, $7C606060, $60607C00, $C0603018, $0C060200
	dc.l	$7C0C0C0C, $0C0C7C00, $10386CC6, $00000000, $00000000, $000000FF, $30301800, $00000000
	dc.l	$0000780C, $7CCC7E00, $E0607C66, $6666FC00, $00007CC6, $C0C67C00, $1C0C7CCC, $CCCC7E00
	dc.l	$00007CC6, $FEC07C00, $1C3630FC, $30307800, $000076CE, $C67E067C, $E0607C66, $6666E600
	dc.l	$18003818, $18183C00, $0C001C0C, $0C0CCC78, $E060666C, $786CE600, $18181818, $18181C00
	dc.l	$00006CFE, $D6D6C600, $0000DC66, $66666600, $00007CC6, $C6C67C00, $0000DC66, $667C60F0
	dc.l	$000076CC, $CC7C0C1E, $0000DC66, $6060F000, $00007CC0, $7C067C00, $3030FC30, $30361C00
	dc.l	$0000CCCC, $CCCC7600, $0000C6C6, $6C381000, $0000C6C6, $D6FE6C00, $0000C66C, $386CC600
	dc.l	$0000C6C6, $CE76067C, $0000FC98, $3064FC00, $0E181870, $18180E00, $18181800, $18181800
	dc.l	$7018180E, $18187000, $76DC0000, $00000000, $43FA0614, $0C59DEB2, $667270FE, $D05974FC
	dc.l	$76004841, $024100FF, $D241D241, $B240625C, $675E2031, $10006758, $47F10800, $48417000
	dc.l	$301BB253, $654C43F3, $08FE45E9, $FFFCE248, $C042B273, $00006514, $6204D6C0, $601A47F3
	dc.l	$0004200A, $908B6AE6, $594B600C, $45F300FC, $200A908B, $6AD847D2, $925B7400, $341BD3C2
	dc.l	$48414241, $4841D283, $70004E75, $70FF4E75, $48417000, $3001D680, $5283323C, $FFFF4841
	dc.l	$59416A8E, $70FF4E75, $47FA057C, $0C5BDEB2, $664AD6D3, $78007200, $740045D3, $51CC0006
	dc.l	$16197807, $D603D341, $5242B252, $620A65EC, $B42A0002, $671265E4, $584AB252, $62FA65DC
	dc.l	$B42A0002, $65D666F0, $10EA0003, $670A51CF, $FFC64E94, $64C04E75, $53484E75, $70004E75
	dc.l	$4EFA0024, $4EFA0018, $760F3401, $E84AC443, $10FB205C, $51CF004A, $4E946444, $4E754841
	dc.l	$61046548, $4841E959, $780FC841, $10FB4040, $51CF0006, $4E946534, $E959780F, $C84110FB
	dc.l	$402E51CF, $00064E94, $6522E959, $780FC841, $10FB401C, $51CF0006, $4E946510, $E959760F
	dc.l	$C24310FB, $100A51CF, $00044ED4, $4E753031, $32333435, $36373839, $41424344, $45464841
	dc.l	$67066106, $65E6609C, $4841E959, $780FC841, $670E10FB, $40DA51CF, $FFA04E94, $649A4E75
	dc.l	$E959780F, $C841670E, $10FB40C4, $51CFFF9C, $4E946496, $4E75E959, $780FC841, $679E10FB
	dc.l	$40AE51CF, $FF984E94, $64924E75, $4EFA0026, $4EFA001A, $74077018, $D201D100, $10C051CF
	dc.l	$00064E94, $650451CA, $FFEE4E75, $48416104, $65184841, $740F7018, $D241D100, $10C051CF
	dc.l	$00064E94, $650451CA, $FFEE4E75, $4EFA0010, $4EFA0048, $47FA009A, $024100FF, $600447FA
	dc.l	$008C4200, $7609381B, $34039244, $55CAFFFC, $D2449443, $44428002, $670E0602, $003010C2
	dc.l	$51CF0006, $4E946510, $381B6ADC, $06010030, $10C151CF, $00044ED4, $4E7547FA, $002E4200
	dc.l	$7609281B, $34039284, $55CAFFFC, $D2849443, $44428002, $670E0602, $003010C2, $51CF0006
	dc.l	$4E9465D4, $281B6ADC, $609E3B9A, $CA0005F5, $E1000098, $9680000F, $42400001, $86A00000
	dc.l	$2710FFFF, $03E80064, $000AFFFF, $271003E8, $0064000A, $FFFF48C1, $60084EFA, $00064881
	dc.l	$48C148E7, $50604EBA, $FD486618, $2E814EBA, $FDD84CDF, $060A650A, $08030003, $66044EFA
	dc.l	$00B64E75, $4CDF060A, $08030002, $670847FA, $000A4EFA, $00B470FF, $60DE3C75, $6E6B6E6F
	dc.l	$776E3E00, $10FC002B, $51CF0006, $4E9465D2, $48414A41, $6700FE72, $6000FE68, $08030003
	dc.l	$66C04EFA, $FDFA48E7, $F81010D9, $5FCFFFFC, $6E146718, $16207470, $C4034EBB, $201A64EA
	dc.l	$4CDF081F, $4E754E94, $64E060F4, $53484E94, $4CDF081F, $4E7547FA, $FDA8B702, $D4024EFB
	dc.l	$205A4E71, $4E7147FA, $FEA4B702, $D4024EFB, $204A4E71, $4E7147FA, $FE54B702, $D4024EFB
	dc.l	$203A5348, $4E7547FA, $FF2E7403, $C403D442, $4EFB2028, $4E714A40, $6B084A81, $67164EFA
	dc.l	$FF644EFA, $FF78265A, $10DB57CF, $FFFC67D2, $4E9464F4, $4E755248, $603C504B, $321A4ED3
	dc.l	$584B221A, $4ED35248, $6022504B, $321A6004, $584B221A, $6A084481, $10FC002D, $600410FC
	dc.l	$002B51CF, $00064E94, $65CA4ED3, $51CF0006, $4E9465C0, $10D951CF, $FFBC4ED4, $4BF900C0
	dc.l	$00044DED, $FFFC4A51, $6B102A99, $41D23818, $4EBA01F8, $43E90020, $60EC5449, $41FA0048
	dc.l	$2ABCC000, $00007000, $76033C80, $34193C82, $34196AFA, $72004EB0, $201051CB, $FFEE2A19
	dc.l	$4E6326C5, $26D926D9, $36FC5D00, $2A857000, $32196112, $2ABC4000, $00007200, $61083ABC
	dc.l	$81742A85, $4E752C80, $2C802C80, $2C802C80, $2C802C80, $2C8051C9, $FFEE4E75, $4CAF0003
	dc.l	$000448E7, $60104E6B, $0C2B005D, $000C661A, $34130242, $E000C2EB, $000AD441, $D440D440
	dc.l	$368223DB, $00C00004, $36DB4CDF, $08064E75, $2F0B4E6B, $0C2B005D, $000C6612, $72003213
	dc.l	$02411FFF, $82EB000A, $20014840, $E248265F, $4E752F0B, $4E6B0C2B, $005D000C, $66183F00
	dc.l	$3013D06B, $000A0240, $5FFF3680, $23DB00C0, $000436DB, $301F265F, $4E752F0B, $4E6B0C2B
	dc.l	$005D000C, $66043741, $0008265F, $4E752F0B, $4E6B0C2B, $005D000C, $6606584B, $36C136C1
	dc.l	$265F4E75, $61D4487A, $FFAA48E7, $7E124E6B, $0C2B005D, $000C661C, $2A1B4C93, $005C4846
	dc.l	$4DF900C0, $00007200, $12186E0E, $6B284893, $001C2705, $4CDF487E, $4E7551CB, $000ED642
	dc.l	$DA860885, $001D2D45, $0004D244, $3C817200, $12186EE6, $67D80241, $001E4EFB, $1002DA86
	dc.l	$721D0385, $60206026, $602A6032, $603A1418, $60141818, $60D86036, $1218D241, $76804843
	dc.l	$CA834841, $8A813602, $2D450004, $60C00244, $07FF60BA, $024407FF, $00442000, $60B00244
	dc.l	$07FF0044, $400060A6, $00446000, $60A03F04, $1E98381F, $6098487A, $FEFA2F0C, $49FA0016
	dc.l	$4FEFFFF0, $41D77E0E, $4EBAFD3C, $4FEF0010, $285F4E75, $42184447, $0647000F, $90C72F08
	dc.l	$4EBAFF28, $205F7E0E, $4E75741E, $10181200, $E609C242, $3CB11000, $D000C042, $3CB10000
	dc.l	$51CCFFEA
	dc.w	$4E75

; ---------------------------------------------------------------
; WARNING!
;	DO NOT put any data from now on! DO NOT use ROM padding!
;	Symbol data should be appended here after ROM is compiled
;	by ConvSym utility, otherwise debugger modules won't be able
;	to resolve symbol names.
; ---------------------------------------------------------------
