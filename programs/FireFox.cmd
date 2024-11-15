@echo off
set "FireFoxDir=%~dp0Files"
pushd "%~dp0"

REM Periksa apakah sistem adalah 64-bit atau 32-bit
if exist %SystemRoot%\SysWOW64\wdscore.dll goto x64

:x86
REM Periksa apakah Firefox sudah ada di lokasi sementara
if exist "%temp%\utility\Firefox\FirefoxSetup.exe" goto a
7z.exe x -o"%temp%\utility\Firefox" -y "%FireFoxDir%\FirefoxSetupx32.7z"
start "" /B /D"%temp%\utility\Firefox" "FirefoxSetup.exe" /S /I
exit

:x64
REM Periksa apakah Firefox sudah ada di lokasi sementara
if exist "%temp%\utility\Firefox\FirefoxSetup.exe" goto a
7z.exe x -o"%temp%\utility\Firefox" -y "%FireFoxDir%\FirefoxSetupx64.7z"
start "" /B /D"%temp%\utility\Firefox" "FirefoxSetup.exe" /S /I
exit

:a
REM Jalankan installer Firefox jika sudah ada
start "" /B /D"%temp%\utility\Firefox" "FirefoxSetup.exe" /S /I
exit
