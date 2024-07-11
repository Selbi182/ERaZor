@echo off

REM Run the just_build.bat file
call just_build.bat

REM Get the current date in YYYY-MM-DD format
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set currentDate=%year%-%month%-%day%

REM Delete any previous "Sonic ERaZor - Test Build *.bin" files
del "Sonic ERaZor 7 - Test Build *.bin"

REM Rename the output file
set outputFile="Sonic ERaZor 7 - Test Build [%currentDate%].bin"
ren s1erz.bin %outputFile%
