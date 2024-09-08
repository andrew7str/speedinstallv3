@echo off
setlocal enabledelayedexpansion

rem Check if wmic is available
if exist "%SystemRoot%\System32\wbem\wmic.exe" (
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get username /value') do set USERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get name /value') do set COMPUTERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set LOCALDATETIME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get caption /value') do set OSNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get version /value') do set OSVERSION=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get buildnumber /value') do set OSBUILD=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get osarchitecture /value') do set OSARCH=%%i
    for /f "tokens=2 delims==" %%i in ('wmic timezone get caption /value') do set TIMEZONE=%%i
    
    rem Get CPU and RAM info
    for /f "tokens=2 delims==" %%i in ('wmic cpu get name /value') do set CPU=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get totalphysicalmemory /value') do (
        set /a RAMMB=%%i/1024/1024
        set RAM=!RAMMB!
    )
) else (
    echo WMIC not found or not working on this system.
    set USERNAME=%USERNAME%
    set COMPUTERNAME=%COMPUTERNAME%
    set OSNAME=Unknown OS
    set OSVERSION=Unknown Version
    set OSBUILD=Unknown Build
    set OSARCH=Unknown Architecture
    set TIMEZONE=Unknown Timezone
    set CPU=Unknown CPU
    set RAM=Unknown RAM
)

:infodev
cls
mode 100,30
title CEK DEVICES
echo ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
echo SPEED INSTALL Û v3Ultimate Û v3Ultimate Û USER: %USERNAME% Û COMPUTERNAME: %COMPUTERNAME% Û NETFX4: %FNETFX4% 
echo CURRENT OS: %OSNAME% Û VER: %OSVERSION% Û BUILD: %OSBUILD% Û ARCH: %OSARCH% 
echo SPESIFIKASI: CPU: %CPU% Û RAM: %RAM% GB 
echo TIME ZONE: %TIMEZONE%
echo ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
pause
