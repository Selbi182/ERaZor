@echo off
call just_build.bat
if exist s1erz.bin (
	start s1erz.bin
)