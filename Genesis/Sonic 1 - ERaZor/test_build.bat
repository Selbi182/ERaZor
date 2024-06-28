@echo off
call just_build.bat
pause
if exist s1erz.bin (
	start s1erz.bin
)