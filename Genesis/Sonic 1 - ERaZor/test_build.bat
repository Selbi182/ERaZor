@echo off
echo ============================================
echo Sonic ERaZor is building...
echo ============================================

if not exist Debugger\Generated mkdir Debugger\Generated
asm68k /k /m /o ws+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /o ae- /o v+ /p sonic1.asm, s1erz.bin, Debugger\Generated\s1erz.sym, Debugger\Generated\s1erz.lst

if exist s1erz.bin (
	Debugger\convsym.exe Debugger\Generated\s1erz.sym s1erz.bin -a

	echo.
	echo ============================================
	echo Built, press any button to play!
	echo ============================================
	pause
	@echo on
	start s1erz.bin
) else (
	echo.
	echo ============================================
	echo !!! BUILD FAILED !!!
	echo ============================================
	pause
)

