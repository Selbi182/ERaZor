@echo off
echo ============================================
echo Sonic ERaZor is building...
echo ============================================

if not exist Debugger\Generated mkdir Debugger\Generated
asm68k /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ /p sonic1.asm, s1erz.bin, Debugger\Generated\s1erz.sym, Debugger\Generated\s1erz.lst


echo.
echo ============================================
if exist s1erz.bin (
	REM build with debug symbols
	REM Debugger\convsym.exe Debugger\Generated\s1erz.sym s1erz.bin -a

	REM build WITHOUT debug symbols
	Debugger\convsym.exe Debugger/Generated/s1erz.sym s1erz.bin -tolower -inopt "/processLocals-" -a
	echo Successfully built!
) else (
	echo !!! BUILD FAILED !!!
)
echo ============================================
