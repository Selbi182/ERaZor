@echo off
echo ============================================
echo Sonic ERaZor (WIDESCREEN) is building...
echo ============================================

if not exist Debugger\Generated mkdir Debugger\Generated
asm68k /e __WIDESCREEN__=1 /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ /p sonic1.asm, s1erz_wide.bin, Debugger\Generated\s1erz_wide.sym, Debugger\Generated\s1erz_wide.lst

echo.
echo ============================================
if exist s1erz_wide.bin (
	Debugger\convsym.exe Debugger/Generated/s1erz_wide.sym - -inopt "/processLocals-" -out log >Debugger/Generated/s1erz_wide.symbols.log
	Debugger\convsym.exe _Variables.asm - -in txt -out log -inopt "/fmt='%%[A-z0-9_.]: equ $%%X'" -exclude -filter ".+_End" -range FF8000 FFFFFF >>Debugger/Generated/s1erz_wide.symbols.log
	Debugger\convsym.exe Debugger/Generated/s1erz_wide.symbols.log s1erz_wide.bin -in log -a -range 0 FFFFFF

	echo Successfully built!
) else (
	echo !!! BUILD FAILED !!!
)
echo ============================================
