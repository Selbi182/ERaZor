
; ===============================================================
; ---------------------------------------------------------------
; MD Debugger and Error Handler v.2.6
;
;
; Documentation, references and source code are available at:
; - https://github.com/vladikcomper/md-modules
;
; (c) 2016-2024, Vladikcomper
; ---------------------------------------------------------------
; Debugger definitions
; ---------------------------------------------------------------

; ---------------------------------------------------------------
; Debugger customization
; ---------------------------------------------------------------

; Enable debugger extensions
; Pressing A/B/C on the exception screen can open other debuggers
; Pressing Start or unmapped button returns to the exception
DEBUGGER__EXTENSIONS__ENABLE:			equ		1		; 0 = OFF, 1 = ON (default)

; Whether to show SR and USP registers in exception handler
DEBUGGER__SHOW_SR_USP:					equ		0		; 0 = OFF (default), 1 = ON

; Debuggers mapped to pressing A/B/C on the exception screen
; Use 0 to disable button, use debugger's entry point otherwise.
DEBUGGER__EXTENSIONS__BTN_A_DEBUGGER:	equ		MDDBG__Debugger_AddressRegisters	; display address register symbols
DEBUGGER__EXTENSIONS__BTN_B_DEBUGGER:	equ		MDDBG__Debugger_Backtrace			; display exception backtrace
DEBUGGER__EXTENSIONS__BTN_C_DEBUGGER:	equ		0		; disabled

; Selects between 24-bit (compact) and 32-bit (full) offset format.
; This affects offset format next to the symbols in the exception screen header.
; M68K bus is limited to 24 bits anyways, so not displaying unused bits saves screen space.
; Possible values:
; - MDDBG__Str_OffsetLocation_24bit (example: 001C04 SomeLoc+4)
; - MDDBG__Str_OffsetLocation_32bit (example: 00001C04 SomeLoc+4)
DEBUGGER__STR_OFFSET_SELECTOR:			equ		MDDBG__Str_OffsetLocation_24bit



; ===============================================================
; ---------------------------------------------------------------
; Constants
; ---------------------------------------------------------------

; ----------------------------
; Arguments formatting flags
; ----------------------------

; General arguments format flags
hex		equ		$80				; flag to display as hexadecimal number
dec		equ		$90				; flag to display as decimal number
bin		equ		$A0				; flag to display as binary number
sym		equ		$B0				; flag to display as symbol (treat as offset, decode into symbol +displacement, if present)
symdisp	equ		$C0				; flag to display as symbol's displacement alone (DO NOT USE, unless complex formatting is required, see notes below)
str		equ		$D0				; flag to display as string (treat as offset, insert string from that offset)

; NOTES:
;	* By default, the "sym" flag displays both symbol and displacement (e.g.: "Map_Sonic+$2E")
;		In case, you need a different formatting for the displacement part (different text color and such),
;		use "sym|split", so the displacement won't be displayed until symdisp is met
;	* The "symdisp" can only be used after the "sym|split" instance, which decodes offset, otherwise, it'll
;		display a garbage offset.
;	* No other argument format flags (hex, dec, bin, str) are allowed between "sym|split" and "symdisp",
;		otherwise, the "symdisp" results are undefined.
;	* When using "str" flag, the argument should point to string offset that will be inserted.
;		Arguments format flags CAN NOT be used in the string (as no arguments are meant to be here),
;		only console control flags (see below).


; Additional flags ...
; ... for number formatters (hex, dec, bin)
signed	equ		8				; treat number as signed (display + or - before the number depending on sign)

; ... for symbol formatter (sym)
split	equ		8				; DO NOT write displacement (if present), skip and wait for "symdisp" flag to write it later (optional)
forced	equ		4				; display "<unknown>" if symbol was not found, otherwise, plain offset is displayed by the displacement formatter

; ... for symbol displacement formatter (symdisp)
weak	equ		8				; DO NOT write plain offset if symbol is displayed as "<unknown>"

; Argument type flags:
; - DO NOT USE in formatted strings processed by macros, as these are included automatically
; - ONLY USE when writting down strings manually with DC.B
byte	equ		0
word	equ		1
long	equ		3

; -----------------------
; Console control flags
; -----------------------

; Plain control flags: no arguments following
endl	equ		$E0				; "End of line": flag for line break
cr		equ		$E6				; "Carriage return": jump to the beginning of the line
pal0	equ		$E8				; use palette line #0
pal1	equ		$EA				; use palette line #1
pal2	equ		$EC				; use palette line #2
pal3	equ		$EE				; use palette line #3

; Parametrized control flags: followed by 1-byte argument
setw	equ		$F0				; set line width: number of characters before automatic line break
setoff	equ		$F4				; set tile offset: lower byte of base pattern, which points to tile index of ASCII character 00
setpat	equ		$F8				; set tile pattern: high byte of base pattern, which determines palette flags and $100-tile section id
setx	equ		$FA				; set x-position

; -----------------------------
; Error handler control flags
; -----------------------------

; Screen appearence flags
_eh_address_error	equ	$01		; use for address and bus errors only (tells error handler to display additional "Address" field)
_eh_show_sr_usp		equ	$02		; displays SR and USP registers content on error screen
_eh_hide_caller		equ	$04		; don't guess and print caller in the header (in SGDK and C/C++ projects naive caller detection isn't reliable)

; Advanced execution flags
; WARNING! For experts only, DO NOT USE them unless you know what you're doing
_eh_return			equ	$20
_eh_enter_console	equ	$40
_eh_align_offset	equ	$80



; ===============================================================
; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------


	; Debugger macros will be semi-broken if whitespace isn't supported.
	; Since version 2.6, MD Debugger recommends projects to set "/o ws+" option to avoid
	; cryptic errors raised by assembler failing to register spaces between arguments.
	if 1 &0
		; This shows a warning currently. This may be changed to an error in future versions.
		inform 1,"Please set /o ws+ assembly option in your build script to use MD Debugger macros"
	endif

; ---------------------------------------------------------------
; Creates assertions for debugging
; ---------------------------------------------------------------
; EXAMPLES:
;	assert.b	d0, eq, #1		; d0 must be $01, or else crash
;	assert.w	d5, pl			; d5 must be positive
;	assert.l	a1, hi, a0		; assert a1 > a0, or else crash
;	assert.b	(MemFlag).w, ne	; MemFlag must be set (non-zero)
;	assert.l	a0, eq, #Obj_Player, MyObjectsDebugger
;
; NOTICE:
;	All "assert" saves and restores CCR so it's fully safe
;	to use in-between any instructions.
;	Use "_assert" instead if you deliberatly want to disbale
;	this behavior and safe a few cycles.
; ---------------------------------------------------------------

assert:	macro	src, cond, dest, console_program
	; Assertions only work in DEBUG builds
	if def(__DEBUG__)
		move.w	sr, -(sp)
		_assert.\0	<\src>, <\cond>, <\dest>, <\console_program>
		move.w	(sp)+, sr
	endif
	endm

; Same as "assert", but doesn't save/restore CCR (can be used to save a few cycles)
_assert:	macro	src, cond, dest, console_program
	; Assertions only work in DEBUG builds
	if def(__DEBUG__)
	if strlen("\dest")
		cmp.\0	\dest, \src
	else
		tst.\0	\src
	endif
	pusho
	opt l-
		b\cond\		@skip\@
	popo
	if strlen("\dest")
		RaiseError	"Assertion failed:%<endl,pal2>> assert.\0 %<pal0>\src,%<pal2>\cond%<pal0>,\dest%<endl,pal1>Got: %<.\0 \src>", \console_program
	else
		RaiseError	"Assertion failed:%<endl,pal2>> assert.\0 %<pal0>\src,%<pal2>\cond%<endl,pal1>Got: %<.\0 \src>", \console_program
	endif
	pusho
	opt l-
	@skip\@:
	popo
	endif
	endm

; ---------------------------------------------------------------
; Raises an error with the given message
; ---------------------------------------------------------------
; EXAMPLES:
;	RaiseError	"Something is wrong"
;	RaiseError	"Your D0 value is BAD: %<.w d0>"
;	RaiseError	"Module crashed! Extra info:", YourMod_Debugger
; ---------------------------------------------------------------

RaiseError:	macro	string, console_program, opts
	pea		*(pc)				; this simulates M68K exception
	move.w	sr, -(sp)			; ...
	__FSTRING_GenerateArgumentsCode \string

	jsr		MDDBG__ErrorHandler

	__FSTRING_GenerateDecodedString \string
	if strlen("\console_program")			; if console program offset is specified ...
		dc.b	\opts+_eh_enter_console|(((*&1)^1)*_eh_align_offset)	; add flag "_eh_align_offset" if the next byte is at odd offset ...
		even															; ... to tell Error handler to skip this byte, so it'll jump to ...
		if DEBUGGER__EXTENSIONS__ENABLE
			jsr		\console_program										; ... an aligned "jsr" instruction that calls console program itself
			jmp		MDDBG__ErrorHandler_PagesController
		else
			jmp		\console_program										; ... an aligned "jmp" instruction that calls console program itself
		endif
	else
		if DEBUGGER__EXTENSIONS__ENABLE
			dc.b	\opts+_eh_return|(((*&1)^1)*_eh_align_offset)			; add flag "_eh_align_offset" if the next byte is at odd offset ...
			even															; ... to tell Error handler to skip this byte, so it'll jump to ...
			jmp		MDDBG__ErrorHandler_PagesController
		else
			dc.b	\opts+0						; otherwise, just specify \opts for error handler, +0 will generate dc.b 0 ...
			even								; ... in case \opts argument is empty or skipped
		endif
	endif
	even

	endm

; ---------------------------------------------------------------
; Console interface
; ---------------------------------------------------------------
; EXAMPLES:
;	Console.Run	YourConsoleProgram
;	Console.Write "Hello "
;	Console.WriteLine "...world!"
;	Console.WriteLine "Your data is %<.b d0>"
;	Console.WriteLine "%<pal0>Your code pointer: %<.l a0 sym>"
;	Console.SetXY #1, #4
;	Console.SetXY d0, d1
;	Console.Sleep #60 ; sleep for 1 second
;	Console.Pause
;
; NOTICE:
;	All "Console.*" calls save and restore CCR so they are fully
;	safe to use in-between any instructions.
;	Use "_Console.*" instead if you deliberatly want to disbale
;	this behavior and safe a few cycles.
; ---------------------------------------------------------------

Console:	macro
	; "Console.Run" doesn't have to save/restore CCR, because it's a no-return
	if strcmp("\0","run")|strcmp("\0","Run")
		_Console.\0	<\1>, <\2>

	; Other Console calls do save/restore CCR
	else
		move.w	sr, -(sp)
		_Console.\0	<\1>, <\2>
		move.w	(sp)+, sr
	endif
	endm

; Same as "Console", but doesn't save/restore CCR (can be used to save a few cycles)
_Console	macro
	if strcmp("\0","write")|strcmp("\0","writeline")|strcmp("\0","Write")|strcmp("\0","WriteLine")
		__FSTRING_GenerateArgumentsCode \1

		pusho
		opt l-

		; If we have any arguments in string, use formatted string function ...
		if (__sp>0)
			movem.l	a0-a2/d7, -(sp)
			lea		4*4(sp), a2
			lea		@str\@(pc), a1
			jsr		MDDBG__Console_\0\_Formatted
			movem.l	(sp)+, a0-a2/d7
			if (__sp>8)
				lea		__sp(sp), sp
			else
				addq.w	#__sp, sp
			endif

		; ... Otherwise, use direct write as an optimization
		else
			move.l	a0, -(sp)
			lea		@str\@(pc), a0
			jsr		MDDBG__Console_\0
			move.l	(sp)+, a0
		endif

		bra.w	@instr_end\@
	@str\@:
		__FSTRING_GenerateDecodedString \1
		even
	@instr_end\@:
		popo	

	elseif strcmp("\0","run")|strcmp("\0","Run")
		jsr		MDDBG__ErrorHandler_ConsoleOnly
		jsr		\1
		bra.s	*

	elseif strcmp("\0","clear")|strcmp("\0","Clear")
		jsr		MDDBG__ErrorHandler_ClearConsole

	elseif strcmp("\0","pause")|strcmp("\0","Pause")
		jsr		MDDBG__ErrorHandler_PauseConsole

	elseif strcmp("\0","sleep")|strcmp("\0","Sleep")
		move.w	d0, -(sp)
		move.l	a0, -(sp)
		move.w	\1, d0

		pusho
		opt l-
		subq.w	#1, d0
		bcs.s	@sleep_done\@
		@sleep_loop\@:
			jsr		MDDBG__VSync
			dbf		d0, @sleep_loop\@

	@sleep_done\@:
		popo

		move.l	(sp)+, a0
		move.w	(sp)+, d0

	elseif strcmp("\0","setxy")|strcmp("\0","SetXY")
		movem.l	d0-d1, -(sp)
		move.w	\2, -(sp)
		move.w	\1, -(sp)
		jsr		MDDBG__Console_SetPosAsXY_Stack
		addq.w	#4, sp
		movem.l	(sp)+, d0-d1

	elseif strcmp("\0","breakline")|strcmp("\0","BreakLine")
		jsr		MDDBG__Console_StartNewLine

	else
		inform	2,"""\0"" isn't a member of ""Console"""

	endif
	endm

; ---------------------------------------------------------------
; KDebug integration interface
; ---------------------------------------------------------------
; EXAMPLES:
;	KDebug.WriteLine "Look in your debug console!"
;	KDebug.WriteLine "Your D0 is %<.w d0>"
;	KDebug.BreakPoint
;	KDebug.StartTimer
;	KDebug.EndTimer
;
; NOTICE:
;	All "KDebug.*" calls save and restore CCR so they are fully
;	safe to use in-between any instructions.
;	Use "_KDebug.*" instead if you deliberatly want to disbale
;	this behavior and safe a few cycles.
; ---------------------------------------------------------------

KDebug:	macro
	if def(__DEBUG__)	; KDebug interface is only available in DEBUG builds
		move.w	sr, -(sp)
		_KDebug.\0	<\1>
		move.w	(sp)+, sr
	endif
	endm

; Same as "KDebug", but doesn't save/restore CCR (can be used to save a few cycles)
_KDebug:	macro
	if def(__DEBUG__)	; KDebug interface is only available in DEBUG builds
	if strcmp("\0","write")|strcmp("\0","writeline")|strcmp("\0","Write")|strcmp("\0","WriteLine")
		__FSTRING_GenerateArgumentsCode \1

		pusho
		opt l-

		; If we have any arguments in string, use formatted string function ...
		if (__sp>0)
			movem.l	a0-a2/d7, -(sp)
			lea		4*4(sp), a2
			lea		@str\@(pc), a1
			jsr		MDDBG__KDebug_\0\_Formatted
			movem.l	(sp)+, a0-a2/d7
			if (__sp>8)
				lea		__sp(sp), sp
			elseif (__sp>0)
				addq.w	#__sp, sp
			endif

		; ... Otherwise, use direct write as an optimization
		else
			move.l	a0, -(sp)
			lea		@str\@(pc), a0
			jsr		MDDBG__KDebug_\0
			move.l	(sp)+, a0
		endif

		bra.w	@instr_end\@
	@str\@:
		__FSTRING_GenerateDecodedString \1
		even
	@instr_end\@:
		popo	

	elseif strcmp("\0","breakline")|strcmp("\0","BreakLine")
		jsr		MDDBG__KDebug_FlushLine

	elseif strcmp("\0","starttimer")|strcmp("\0","StartTimer")
		move.w	#$9FC0, ($C00004).l

	elseif strcmp("\0","endtimer")|strcmp("\0","EndTimer")
		move.w	#$9F00, ($C00004).l

	elseif strcmp("\0","breakpoint")|strcmp("\0","BreakPoint")
		move.w	#$9D00, ($C00004).l

	else
		inform	2,"""\0"" isn't a member of ""KDebug"""

	endif
	endif
	endm

; ---------------------------------------------------------------
__ErrorMessage:	macro	string, opts
		__FSTRING_GenerateArgumentsCode \string
		jsr		MDDBG__ErrorHandler
		__FSTRING_GenerateDecodedString \string
		if DEBUGGER__EXTENSIONS__ENABLE
			dc.b	\opts+_eh_return|(((*&1)^1)*_eh_align_offset)	; add flag "_eh_align_offset" if the next byte is at odd offset ...
			even													; ... to tell Error handler to skip this byte, so it'll jump to ...
			jmp		MDDBG__ErrorHandler_PagesController				; ... extensions controller
		else
			dc.b	\opts+0
			even
		endif
	endm

; ---------------------------------------------------------------
__FSTRING_GenerateArgumentsCode:	macro string

	__pos:	= instr(\string,'%<')		; token position
	__stack:= 0						; size of actual stack
	__sp:	= 0						; stack displacement

	pusho
	opt	ae-		; make sure "automatic even" is disabled as this disrupts string generation

	; Parse string itself
	while (__pos)

		; Retrive expression in brackets following % char
    	__endpos:	= instr(__pos+1,\string,'>')
    	if __endpos=0
			inform 3,'Missing a closing bracket after %<'
    	endif
    	__midpos:	= instr(__pos+5,\string,' ')
    	if (__midpos<1)|(__midpos>__endpos)
			__midpos: = __endpos
    	endif
		__substr:	substr	__pos+1+1,__endpos-1,\string			; .type ea param
		__type:		substr	__pos+1+1,__pos+1+1+1,\string			; .type

		; Expression is an effective address (e.g. %(.w d0 hex) )
		if "\__type">>8="."
			__operand:	substr	__pos+1+1,__midpos-1,\string			; .type ea
			__param:	substr	__midpos+1,__endpos-1,\string			; param

			if instr("\__operand","(sp)")|instr("\__operand","(SP)")
				; Referring to (SP) may get unexpected results because stack is already shifted at this point
				; Using -(SP) and (SP)+ will crash because of stack corruption.
				inform 3,'Cannot use (SP) in a formatted string'
			endif

			if "\__type"=".b"
				pushp	"move\__operand\,1(sp)"
				pushp	"subq.w	#2, sp"
				__stack: = __stack+2
				__sp: = __sp+2

			elseif "\__type"=".w"
				pushp	"move\__operand\,-(sp)"
				__stack: = __stack+1
				__sp: = __sp+2

			elseif "\__type"=".l"
				pushp	"move\__operand\,-(sp)"
				__stack: = __stack+1
				__sp: = __sp+4

			else
				inform 3,'Unrecognized type in string operand: %<\__substr>'
			endif
		endif

		__pos:	= instr(__pos+1,\string,'%<')
	endw

	; Generate stack code
	rept __stack
		popp	__command
		\__command
	endr

	popo	; restore previous options

	endm

; ---------------------------------------------------------------
__FSTRING_GenerateDecodedString:	macro string

	__lpos:	= 1							; start position
	__pos:	= instr(\string,'%<')		; token position

	while (__pos)

		; Write part of string before % token
		__substr:	substr	__lpos,__pos-1,\string
		dc.b	"\__substr"

		; Retrive expression in brakets following % char
    	__endpos:	= instr(__pos+1,\string,'>')
    	__midpos:	= instr(__pos+5,\string,' ')
    	if (__midpos<1)|(__midpos>__endpos)
			__midpos: = __endpos
    	endif
		__type:		substr	__pos+1+1,__pos+1+1+1,\string			; .type

		; Expression is an effective address (e.g. %<.w d0 hex> )
		if "\__type">>8="."    
			__param:	substr	__midpos+1,__endpos-1,\string			; param
			
			; Validate format setting ("param")
			if strlen("\__param")<1
				__param: substr ,,"hex"			; if param is ommited, set it to "hex"
			elseif strcmp("\__param","signed")
				__param: substr ,,"hex+signed"	; if param is "signed", correct it to "hex+signed"
			endif

			if (\__param < $80)
				inform	2,"Illegal operand format setting: ""\__param\"". Expected ""hex"", ""dec"", ""bin"", ""sym"", ""str"" or their derivatives."
			endif

			if "\__type"=".b"
				dc.b	\__param
			elseif "\__type"=".w"
				dc.b	\__param|1
			else
				dc.b	\__param|3
			endif

		; Expression is an inline constant (e.g. %<endl> )
		else
			__substr:	substr	__pos+1+1,__endpos-1,\string
			dc.b	\__substr
		endif

		__lpos:	= __endpos+1
		__pos:	= instr(__pos+1,\string,'%<')
	endw

	; Write part of string before the end
	__substr:	substr	__lpos,,\string
	dc.b	"\__substr"
	dc.b	0

	endm

; ---------------------------------------------------------------
; MIT License
; 
; Copyright (c) 2016-2024 Vladikcomper
; 
; Permission is hereby granted, free of charge, to any person
; obtaining a copy ; of this software and associated
; documentation files (the "Software"), to deal in the Software 
; without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense,
; and/or sell copies of the Software, and to permit persons to
; whom the Software is furnished to do so, subject to the
; following conditions:
; 
; The above copyright notice and this permission notice shall be
; included in all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
; OTHER DEALINGS IN THE SOFTWARE.
; ---------------------------------------------------------------
