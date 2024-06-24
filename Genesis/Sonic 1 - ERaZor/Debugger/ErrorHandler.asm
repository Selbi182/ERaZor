
; ===============================================================
; ---------------------------------------------------------------
; MD Debugger and Error Handler v.2.6
;
; (c) 2016-2024, Vladikcomper
; ---------------------------------------------------------------
; Debugger and Error handler blob
; ---------------------------------------------------------------


; ---------------------------------------------------------------
; Exception vectors
; ---------------------------------------------------------------

	if DEBUGGER__SHOW_SR_USP
_eh_default:	equ	_eh_show_sr_usp
	else
_eh_default:	equ	0
	endif

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
; MD Debugger blob
; ---------------------------------------------------------------

ErrorHandler:

	dc.l	$46FC2700, $4FEFFFEE, $48E7FFFE, $4EBA023C, $49EF004E, $4E682F08, $47EF0040, $4EBA011E
	dc.l	$41FA02BE, $4EBA0B3E, $225C45D4, $4EBA0BF8, $4EBA0AD8, $49D21C19, $6A025249, $47D10806
	dc.l	$0000670E, $41FA02A1, $222C0002, $4EBA0164, $504C41FA, $029E222C, $00024EBA, $01562278
	dc.l	$000045EC, $00064EBA, $01BC41FA, $02904EBA, $01424EBA, $0A960806, $00066600, $00AA45EF
	dc.l	$00044EBA, $0A643F01, $70034EBA, $0A2C303C, $64307A07, $4EBA0132, $321F7011, $4EBA0A1A
	dc.l	$303C6130, $7A064EBA, $0120303C, $73707A00, $2F0C45D7, $4EBA0112, $584F0806, $00016714
	dc.l	$43FA0255, $45D74EBA, $0B6243FA, $025645D4, $4EBA0B54, $584F4EBA, $0A105241, $70014EBA
	dc.l	$09D82038, $007841FA, $02444EBA, $010A2038, $007041FA, $02404EBA, $00FE4EBA, $0A0E2278
	dc.l	$000045D4, $53896140, $4EBA09DE, $7A199A41, $6B0A6148, $4EBA005A, $51CDFFFA, $08060005
	dc.l	$660A4E71, $60FC7200, $4EBA0A0A, $2ECB4CDF, $7FFF487A, $FFEE2F2F, $FFC44E75, $43FA015E
	dc.l	$45FA0208, $4EFA08EE, $223C00FF, $FFFF2409, $C4812242, $240AC481, $24424E75, $4FEFFFD0
	dc.l	$41D77EFF, $20FC2853, $502930FC, $3A206018, $4FEFFFD0, $41D77EFF, $30FC202B, $320A924C
	dc.l	$4EBA05BA, $30FC3A20, $700572EC, $B5C96502, $72EE10C1, $321A4EBA, $05C210FC, $002051C8
	dc.l	$FFEA4218, $41D77200, $4EBA09B4, $4FEF0030, $4E754EBA, $09B02F01, $2F0145D7
	dc.w	$43FA, DEBUGGER__STR_OFFSET_SELECTOR-MDDBG__Error_DrawOffsetLocation__inj-2
	dc.l	$4EBA0A64, $504F4E75, $4FEFFFF0, $7EFF41D7, $30C030FC, $3A2010FC, $00EC221A, $4EBA0574
	dc.l	$421841D7, $72004EBA, $09765240, $51CDFFE0, $4FEF0010, $4E752200, $48414601, $66F62440
	dc.l	$0C5A4EF9, $66042212, $60A80C6A, $4EF8FFFE, $66063212, $48C1609A, $4EBA094A, $41FA011E
	dc.l	$4EFA093E, $59894EBA, $FF20B3CA, $650C0C52, $0040650A, $548AB3CA, $64F47200, $4E752212
	dc.l	$67F20801, $000066EC, $4E754BF9, $00C00004, $4DEDFFFC, $44D569FC, $41FA0026, $30186A04
	dc.l	$3A8060F8, $70002ABC, $40000000, $2C802ABC, $40000010, $2C802ABC, $C0000000, $3C804E75
	dc.l	$80048134, $85008700, $8B008C81, $8D008F02, $90119100, $92008220, $84040000, $44000000
	dc.l	$00000001, $00100011, $01000101, $01100111, $10001001, $10101011, $11001101, $11101111
	dc.l	$FFFF0EEE, $FFF200CE, $FFF20EEA, $FFF20E86, $FFF24000, $00020028, $00280000, $008000FF
	dc.l	$EAE0FA01, $F02600EA, $41646472, $6573733A, $2000EA4F, $66667365, $743A2000, $EA43616C
	dc.l	$6C65723A, $2000EC80, $8120E8BF, $ECC800EC, $8320E8BF, $ECC800FA, $10E87573, $703A20EC
	dc.l	$8300FA03, $E873723A, $20EC8100, $EA56496E, $743A2000, $EA48496E, $743A2000, $E83C756E
	dc.l	$64656669, $6E65643E, $000002F7, $00000000, $00000000, $183C3C18, $18001800, $6C6C6C00
	dc.l	$00000000, $6C6CFE6C, $FE6C6C00, $187EC07C, $06FC1800, $00C60C18, $3060C600, $386C3876
	dc.l	$CCCC7600, $18183000, $00000000, $18306060, $60301800, $60301818, $18306000, $00EE7CFE
	dc.l	$7CEE0000, $0018187E, $18180000, $00000000, $18183000, $000000FE, $00000000, $00000000
	dc.l	$00383800, $060C1830, $60C08000, $7CC6CEDE, $F6E67C00, $18781818, $18187E00, $7CC60C18
	dc.l	$3066FE00, $7CC6063C, $06C67C00, $0C1C3C6C, $FE0C0C00, $FEC0FC06, $06C67C00, $7CC6C0FC
	dc.l	$C6C67C00, $FEC6060C, $18181800, $7CC6C67C, $C6C67C00, $7CC6C67E, $06C67C00, $001C1C00
	dc.l	$001C1C00, $00181800, $00181830, $0C183060, $30180C00, $0000FE00, $00FE0000, $6030180C
	dc.l	$18306000, $7CC6060C, $18001800, $7CC6C6DE, $DCC07E00, $386CC6C6, $FEC6C600, $FC66667C
	dc.l	$6666FC00, $3C66C0C0, $C0663C00, $F86C6666, $666CF800, $FEC2C0F8, $C0C2FE00, $FE62607C
	dc.l	$6060F000, $7CC6C0C0, $DEC67C00, $C6C6C6FE, $C6C6C600, $3C181818, $18183C00, $3C181818
	dc.l	$D8D87000, $C6CCD8F0, $D8CCC600, $F0606060, $6062FE00, $C6EEFED6, $D6C6C600, $C6E6E6F6
	dc.l	$DECEC600, $7CC6C6C6, $C6C67C00, $FC66667C, $6060F000, $7CC6C6C6, $C6D67C06, $FCC6C6FC
	dc.l	$D8CCC600, $7CC6C07C, $06C67C00, $7E5A1818, $18183C00, $C6C6C6C6, $C6C67C00, $C6C6C6C6
	dc.l	$6C381000, $C6C6D6D6, $FEEEC600, $C66C3838, $386CC600, $6666663C, $18183C00, $FE860C18
	dc.l	$3062FE00, $7C606060, $60607C00, $C0603018, $0C060200, $7C0C0C0C, $0C0C7C00, $10386CC6
	dc.l	$00000000, $00000000, $000000FF, $30301800, $00000000, $0000780C, $7CCC7E00, $E0607C66
	dc.l	$6666FC00, $00007CC6, $C0C67C00, $1C0C7CCC, $CCCC7E00, $00007CC6, $FEC07C00, $1C3630FC
	dc.l	$30307800, $000076CE, $C67E067C, $E0607C66, $6666E600, $18003818, $18183C00, $0C001C0C
	dc.l	$0C0CCC78, $E060666C, $786CE600, $18181818, $18181C00, $00006CFE, $D6D6C600, $0000DC66
	dc.l	$66666600, $00007CC6, $C6C67C00, $0000DC66, $667C60F0, $000076CC, $CC7C0C1E, $0000DC66
	dc.l	$6060F000, $00007CC0, $7C067C00, $3030FC30, $30361C00, $0000CCCC, $CCCC7600, $0000C6C6
	dc.l	$6C381000, $0000C6C6, $D6FE6C00, $0000C66C, $386CC600, $0000C6C6, $CE76067C, $0000FC98
	dc.l	$3064FC00, $0E181870, $18180E00, $18181800, $18181800, $7018180E, $18187000, $76DC0000
	dc.l	$00000000, $43FA08DA, $0C59DEB2, $667270FE, $D05974FC, $76004841, $024100FF, $D241D241
	dc.l	$B240625C, $675E2031, $10006758, $47F10800, $48417000, $301BB253, $654C43F3, $08FE45E9
	dc.l	$FFFCE248, $C042B273, $00006514, $6204D6C0, $601A47F3, $0004200A, $908B6AE6, $594B600C
	dc.l	$45F300FC, $200A908B, $6AD847D2, $925B7400, $341BD3C2, $48414241, $4841D283, $70004E75
	dc.l	$70FF4E75, $48417000, $3001D680, $5283323C, $FFFF4841, $59416A8E, $70FF4E75, $47FA0842
	dc.l	$0C5BDEB2, $664AD6D3, $78007200, $740045D3, $51CC0006, $16197807, $D603D341, $5242B252
	dc.l	$620A65EC, $B42A0002, $671265E4, $584AB252, $62FA65DC, $B42A0002, $65D666F0, $10EA0003
	dc.l	$670A51CF, $FFC64E94, $64C04E75, $53484E75, $70004E75, $4EFA0024, $4EFA0018, $760F3401
	dc.l	$E84AC443, $10FB205C, $51CF004A, $4E946444, $4E754841, $61046548, $4841E959, $780FC841
	dc.l	$10FB4040, $51CF0006, $4E946534, $E959780F, $C84110FB, $402E51CF, $00064E94, $6522E959
	dc.l	$780FC841, $10FB401C, $51CF0006, $4E946510, $E959760F, $C24310FB, $100A51CF, $00044ED4
	dc.l	$4E753031, $32333435, $36373839, $41424344, $45464841, $67066106, $65E6609C, $4841E959
	dc.l	$780FC841, $670E10FB, $40DA51CF, $FFA04E94, $649A4E75, $E959780F, $C841670E, $10FB40C4
	dc.l	$51CFFF9C, $4E946496, $4E75E959, $780FC841, $679E10FB, $40AE51CF, $FF984E94, $64924E75
	dc.l	$4EFA0026, $4EFA001A, $74077018, $D201D100, $10C051CF, $00064E94, $650451CA, $FFEE4E75
	dc.l	$48416104, $65184841, $740F7018, $D241D100, $10C051CF, $00064E94, $650451CA, $FFEE4E75
	dc.l	$4EFA0010, $4EFA0048, $47FA009A, $024100FF, $600447FA, $008C4200, $7609381B, $34039244
	dc.l	$55CAFFFC, $D2449443, $44428002, $670E0602, $003010C2, $51CF0006, $4E946510, $381B6ADC
	dc.l	$06010030, $10C151CF, $00044ED4, $4E7547FA, $002E4200, $7609281B, $34039284, $55CAFFFC
	dc.l	$D2849443, $44428002, $670E0602, $003010C2, $51CF0006, $4E9465D4, $281B6ADC, $609E3B9A
	dc.l	$CA0005F5, $E1000098, $9680000F, $42400001, $86A00000, $2710FFFF, $03E80064, $000AFFFF
	dc.l	$271003E8, $0064000A, $FFFF48C1, $60084EFA, $00064881, $48C148E7, $50604EBA, $FD486618
	dc.l	$2E814EBA, $FDD84CDF, $060A650A, $08030003, $66044EFA, $00B64E75, $4CDF060A, $08030002
	dc.l	$670847FA, $000A4EFA, $00B470FF, $60DE3C75, $6E6B6E6F, $776E3E00, $10FC002B, $51CF0006
	dc.l	$4E9465D2, $48414A41, $6700FE72, $6000FE68, $08030003, $66C04EFA, $FDFA48E7, $F81010D9
	dc.l	$5FCFFFFC, $6E146718, $16207470, $C4034EBB, $201A64EA, $4CDF081F, $4E754E94, $64E060F4
	dc.l	$53484E94, $4CDF081F, $4E7547FA, $FDA8B702, $D4024EFB, $205A4E71, $4E7147FA, $FEA4B702
	dc.l	$D4024EFB, $204A4E71, $4E7147FA, $FE54B702, $D4024EFB, $203A5348, $4E7547FA, $FF2E7403
	dc.l	$C403D442, $4EFB2028, $4E714A40, $6B084A81, $67164EFA, $FF644EFA, $FF78265A, $10DB57CF
	dc.l	$FFFC67D2, $4E9464F4, $4E755248, $6032504B, $321A4ED3, $584B221A, $4ED35547, $6028504B
	dc.l	$321A6004, $584B221A, $6A084481, $10FC002D, $600410FC, $002B51CF, $00064E94, $65CA4ED3
	dc.l	$51CFFFC6, $4ED46506, $524810D9, $4E755447, $53494ED4, $4BF900C0, $00044DED, $FFFC4A51
	dc.l	$6B102A99, $41D23818, $4EBA0210, $43E90020, $60EC5449, $2ABCC000, $00007000, $76033C80
	dc.l	$34193C82, $34196AFA, $72004EBB, $204051CB, $FFEE2A19, $4E6326C5, $26C526D9, $26D936FC
	dc.l	$5D002A85, $70003219, $61122ABC, $40000000, $72006108, $3ABC8174, $2A854E75, $2C802C80
	dc.l	$2C802C80, $2C802C80, $2C802C80, $51C9FFEE, $4E754CAF, $00030004, $48E76010, $4E6B0C2B
	dc.l	$005D0010, $661C342B, $00040242, $E000C2EB, $000ED441, $D440D440, $36823742, $0004504B
	dc.l	$36DB4CDF, $08064E75, $2F0B4E6B, $0C2B005D, $00106612, $72003213, $02411FFF, $82EB000E
	dc.l	$20014840, $E248265F, $4E752F0B, $4E6B0C2B, $005D0010, $661A3F00, $302B0004, $D06B000E
	dc.l	$02405FFF, $36803740, $0004504B, $36DB301F, $265F4E75, $2F0B4E6B, $0C2B005D, $00106604
	dc.l	$3741000C, $265F4E75, $2F0B4E6B, $0C2B005D, $00106606, $504B36C1, $36C1265F, $4E7561D4
	dc.l	$487AFFA8, $48E77F12, $4E6B0C2B, $005D0010, $66284CDB, $00A04C93, $005C4846, $4DF900C0
	dc.l	$00002D45, $00044845, $72001218, $6E126B32, $4893001C, $484548E3, $05004CDF, $48FE4E75
	dc.l	$51CB0012, $D642DE86, $0887001D, $2D470004, $2A074845, $D2443C81, $54457200, $12186EE0
	dc.l	$67CE0241, $001E4EFB, $1002DE86, $721D0387, $6020602A, $602E6036, $603E1418, $60141818
	dc.l	$60D8603A, $1218D241, $76804843, $CE834841, $8E813602, $2D470004, $2A074845, $60BC0244
	dc.l	$07FF60B6, $024407FF, $00442000, $60AC0244, $07FF0044, $400060A2, $00446000, $609C3F04
	dc.l	$1E98381F, $6094487A, $FEE22F0C, $49FA0016, $4FEFFFF0, $41D77E0E, $4EBAFD20, $4FEF0010
	dc.l	$285F4E75, $42184447, $0647000F, $90C72F08, $4EBAFF12, $205F7E0E, $4E75741E, $10181200
	dc.l	$E609C242, $3CB11000, $D000C042, $3CB10000, $51CCFFEA, $4E75487A, $00562F0C, $49FA0016
	dc.l	$4FEFFFF0, $41D77E0E, $4EBAFCD0, $4FEF0010, $285F4E75, $42184447, $0647000F, $90C72F08
	dc.l	$2F0D4BF9, $00C00004, $3E3C9E00, $60023A87, $1E186EFA, $67100407, $00E067F2, $0C070010
	dc.l	$6DEE5248, $60EA2A5F, $205F7E0E, $4E7533FC, $9E0000C0, $00044E75, $487AFFF4, $3F072F0D
	dc.l	$4BF900C0, $00043E3C, $9E006002, $3A871E18, $6EFA6710, $040700E0, $67F20C07, $00106DEE
	dc.l	$524860EA, $2A5F3E1F, $4E7546FC, $27004FEF, $FFEE48E7, $FFFE47EF, $003C4EBA, $F52E4EBA
	dc.l	$F41C4CDF, $7FFF487A, $F3FA2F2F, $00164E75, $2F0B4E6B, $0C2B005D, $0010661A, $48E7C446
	dc.l	$4BF900C0, $00044DED, $FFFC43FA, $F5864EBA, $FD224CDF, $6223265F, $4E7548E7, $C0D04E6B
	dc.l	$0C2B005D, $0010660C, $3F3C0000, $610C610A, $67FC544F, $4CDF0B03, $4E756174, $41EF0004
	dc.l	$43F900A1, $00036178, $70F0C02F, $00054E75, $48E7FFFE, $3F3C0000, $61E04BF9, $00C00004
	dc.l	$4DEDFFFC, $61D467F2, $6B4041FA, $00765888, $D00064FA, $20106F32, $20404FEF, $FFEE43FA
	dc.l	$F51647D7, $2A3C4000, $00034EBA, $FCA82ABC, $82308406, $2A85487A, $000C4850, $4CEF7FFF
	dc.l	$00184E75, $4FEF0012, $60B02ABA, $F4AA60AA, $41F900C0, $000444D0, $6BFC44D0, $6AFC4E75
	dc.l	$12BC0000, $4E7172C0, $1011E508, $12BC0040, $4E71C001, $12110201, $003F8001, $46001210
	dc.l	$B10110C0, $C20010C1
	dc.w	$4E75
	dc.l	DEBUGGER__EXTENSIONS__BTN_A_DEBUGGER, DEBUGGER__EXTENSIONS__BTN_C_DEBUGGER, DEBUGGER__EXTENSIONS__BTN_B_DEBUGGER, $48E700FE, $41FA002A, $4EBAFD24, $49D77C06, $3F3C2000
	dc.l	$2F3CE861, $303A41D7, $221C4EBA, $F35C522F, $000251CE, $FFF24FEF, $00224E75, $E0FA01F0
	dc.l	$26EA4164, $64726573, $73205265, $67697374, $6572733A, $E0E00000, $41FA0088, $4EBAFCDC
	dc.l	$22780000, $598945D7, $4EBAF2B4, $B3CA6570, $0C520040, $64642012, $67602040, $02400001
	dc.l	$66581220, $10200C00, $00616604, $4A01663A, $0C00004E, $660A0201, $00F80C01, $0090672A
	dc.l	$30200C40, $61006722, $12004200, $0C404E00, $66120C01, $00A8650C, $0C0100BB, $62060C01
	dc.l	$00B96606, $0C604EB9, $66102F0A, $2F092208, $4EBAF2BA, $225F245F, $548A548A, $B3CA6490
	dc.l	$4E75E0FA, $01F026EA, $4261636B, $74726163, $653AE0E0
	dc.w	$0000

; ---------------------------------------------------------------
; MD Debugger's exported symbols
; ---------------------------------------------------------------

MDDBG__ErrorHandler: equ ErrorHandler+$0
MDDBG__Error_IdleLoop: equ ErrorHandler+$122
MDDBG__Error_InitConsole: equ ErrorHandler+$13C
MDDBG__Error_MaskStackBoundaries: equ ErrorHandler+$148
MDDBG__Error_DrawOffsetLocation: equ ErrorHandler+$1B2
MDDBG__Error_DrawOffsetLocation2: equ ErrorHandler+$1B6
MDDBG__Error_DrawOffsetLocation__inj: equ ErrorHandler+$1BC
MDDBG__ErrorHandler_SetupVDP: equ ErrorHandler+$24A
MDDBG__ErrorHandler_VDPConfig: equ ErrorHandler+$280
MDDBG__ErrorHandler_VDPConfig_Nametables: equ ErrorHandler+$296
MDDBG__ErrorHandler_ConsoleConfig_Initial: equ ErrorHandler+$2D2
MDDBG__ErrorHandler_ConsoleConfig_Shared: equ ErrorHandler+$2D6
MDDBG__Str_OffsetLocation_24bit: equ ErrorHandler+$306
MDDBG__Str_OffsetLocation_32bit: equ ErrorHandler+$30F
MDDBG__Art1bpp_Font: equ ErrorHandler+$34A
MDDBG__FormatString: equ ErrorHandler+$95A
MDDBG__Console_Init: equ ErrorHandler+$A34
MDDBG__Console_Reset: equ ErrorHandler+$A72
MDDBG__Console_InitShared: equ ErrorHandler+$A74
MDDBG__Console_SetPosAsXY_Stack: equ ErrorHandler+$AB2
MDDBG__Console_SetPosAsXY: equ ErrorHandler+$AB8
MDDBG__Console_GetPosAsXY: equ ErrorHandler+$AE8
MDDBG__Console_StartNewLine: equ ErrorHandler+$B0A
MDDBG__Console_SetBasePattern: equ ErrorHandler+$B34
MDDBG__Console_SetWidth: equ ErrorHandler+$B48
MDDBG__Console_WriteLine_WithPattern: equ ErrorHandler+$B5E
MDDBG__Console_WriteLine: equ ErrorHandler+$B60
MDDBG__Console_Write: equ ErrorHandler+$B64
MDDBG__Console_WriteLine_Formatted: equ ErrorHandler+$C26
MDDBG__Console_Write_Formatted: equ ErrorHandler+$C2A
MDDBG__Decomp1bpp: equ ErrorHandler+$C5A
MDDBG__KDebug_WriteLine_Formatted: equ ErrorHandler+$C76
MDDBG__KDebug_Write_Formatted: equ ErrorHandler+$C7A
MDDBG__KDebug_FlushLine: equ ErrorHandler+$CCE
MDDBG__KDebug_WriteLine: equ ErrorHandler+$CD8
MDDBG__KDebug_Write: equ ErrorHandler+$CDC
MDDBG__ErrorHandler_ConsoleOnly: equ ErrorHandler+$D0A
MDDBG__ErrorHandler_ClearConsole: equ ErrorHandler+$D30
MDDBG__ErrorHandler_PauseConsole: equ ErrorHandler+$D5A
MDDBG__ErrorHandler_PagesController: equ ErrorHandler+$D90
MDDBG__VSync: equ ErrorHandler+$DF0
MDDBG__ErrorHandler_ExtraDebuggerList: equ ErrorHandler+$E2A
MDDBG__Debugger_AddressRegisters: equ ErrorHandler+$E36
MDDBG__Debugger_Backtrace: equ ErrorHandler+$E82

; ---------------------------------------------------------------
; WARNING!
;	DO NOT put any data from now on! DO NOT use ROM padding!
;	Symbol data should be appended here after ROM is compiled
;	by ConvSym utility, otherwise debugger modules won't be able
;	to resolve symbol names.
; ---------------------------------------------------------------
