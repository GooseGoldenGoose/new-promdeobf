@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "sampleName=%~1"
if not defined sampleName set /p "sampleName=Sample file name (example: 52 or spacial.txt): "
if not defined sampleName goto :invalid_input

for %%F in ("%sampleName%") do (
    set "inputFile=%%~nxF"
    set "outputName=%%~nF"
    set "inputExt=%%~xF"
)

if not defined inputExt set "inputFile=%inputFile%.txt"
set "inputPath=sample\%inputFile%"
set "normalPath=output\%outputName%.normal.lua"
set "productionPath=output\%outputName%.lua"

if not exist "%inputPath%" (
    echo [ERROR] "%inputPath%" not found.
    exit /b 1
)

if not exist "output" mkdir "output"

echo.
echo [1] Normal intermediate
echo [2] Production
set "mode=%~2"
if not defined mode set /p "mode=Select deobf mode [normal/production]: "
if /i "%mode%"=="1" set "mode=normal"
if /i "%mode%"=="2" set "mode=production"
if /i "%mode%"=="prod" set "mode=production"
if /i "%mode%"=="cf" set "mode=production"
echo Input: "%inputPath%"

echo.
if /i "%mode%"=="normal" (
    node main.js "%inputPath%" "%normalPath%"
    if errorlevel 1 goto :failed
    echo.
    echo Done: "%normalPath%"
    exit /b 0
)

if /i "%mode%"=="production" (
    node tools\deobfuscate.js "%inputPath%" "%productionPath%"
    if errorlevel 1 goto :failed
    echo.
    echo Done: "%productionPath%"
    exit /b 0
)

goto :invalid_mode

:invalid_input
echo [ERROR] Enter a sample filename.
exit /b 1

:invalid_mode
echo [ERROR] Invalid mode.
exit /b 1

:failed
echo.
echo [ERROR] Deobfuscation failed.
exit /b 1