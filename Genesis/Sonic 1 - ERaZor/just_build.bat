@echo off
echo ============================================
echo Sonic ERaZor is building...
echo ============================================

if not exist Debugger\Generated mkdir Debugger\Generated
asm68k /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ /p sonic1.asm, s1erz.bin, Debugger\Generated\s1erz.sym, Debugger\Generated\s1erz.lst


echo.
echo ============================================
if exist s1erz.bin (
	Debugger\convsym.exe Debugger\Generated\s1erz.sym s1erz.bin -a

	asm68k /e __BENCHMARK__=1 /q /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ /p sonic1.asm, s1erz-bench.bin, Debugger\Generated\s1erz-bench.sym, Debugger\Generated\s1erz-bench.lst

	if exist s1erz-bench.bin (
		Debugger\convsym.exe Debugger\Generated\s1erz.sym s1erz-bench.bin -a
	) else (
		echo !!! BENCHMARK ROM BUILD FAILED !!!
	)
	echo Successfully built!
) else (
	echo !!! BUILD FAILED !!!
)
echo ============================================
pause
