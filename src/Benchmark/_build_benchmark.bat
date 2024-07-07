@echo off
cd ..

asm68k /e __BENCHMARK__=1 /q /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ /p sonic1.asm, Benchmark\s1erz-benchmark.bin, Debugger\Generated\s1erz-benchmark.sym, Debugger\Generated\s1erz-benchmark.lst
if exist Benchmark\s1erz-benchmark.bin (
	Debugger\convsym.exe Debugger\Generated\s1erz.sym Benchmark\s1erz-benchmark.bin -a
) else (
	echo !!! BENCHMARK ROM BUILD FAILED !!!
)
pause
start Benchmark\s1erz-benchmark.bin