@echo off
call build.bat
pause
if exist s1erz.bin (
	start s1erz.bin
)