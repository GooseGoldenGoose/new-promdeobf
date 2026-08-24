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
set "normalPath=output\%outputName%.lua"
set "betaPath=output\%outputName%.beta.lua"
set "cfPath=output\%outputName%.beta.cf.lua"

if not exist "%inputPath%" (
    echo [ERROR] "%inputPath%" not found.
    exit /b 1
)

if not exist "output" mkdir "output"

echo.
echo [1] Normal
echo [2] Beta
echo [3] CF
set "mode=%~2"
if not defined mode set /p "mode=Select deobf mode [normal/beta/cf]: "
if /i "%mode%"=="1" set "mode=normal"
if /i "%mode%"=="2" set "mode=beta"
if /i "%mode%"=="3" set "mode=cf"

echo.
echo Input: "%inputPath%"

node main.js "%inputPath%" "%normalPath%"
if errorlevel 1 goto :failed

if /i "%mode%"=="normal" (
    echo.
    echo Done: "%normalPath%"
    exit /b 0
)

if /i "%mode%"=="beta" (
    node tools\beta-register-versions.js "%normalPath%" "%betaPath%"
    if errorlevel 1 goto :failed
    echo.
    echo Done: "%betaPath%"
    exit /b 0
)

if /i "%mode%"=="cf" (
    node tools\beta-control-flow.js "%normalPath%" "%cfPath%"
    if errorlevel 1 goto :failed
    echo.
    echo Done: "%cfPath%"
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
