@echo off
pushd "%~dp0"

REM Periksa apakah sistem 64-bit atau 32-bit
if exist %SystemRoot%\SysWOW64\wdscore.dll goto x64

:x86
REM Periksa apakah OperaSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\Opera\OperaSetup.exe" goto a
7z.exe x -o"%temp%\utility\Opera" -y "%~dp0Files\OperaSetupx32.7z"
start "" /B /D"%temp%\utility\Opera" "OperaSetup.exe"
exit

:x64
REM Periksa apakah OperaSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\Opera\OperaSetup.exe" goto a
7z.exe x -o"%temp%\utility\Opera" -y "%~dp0Files\OperaSetupx64.7z"
start "" /B /D"%temp%\utility\Opera" "OperaSetup.exe"
exit

:a
REM Jalankan OperaSetup.exe jika sudah ada di lokasi sementara
start "" /B /D"%temp%\utility\Opera" "OperaSetup.exe"
exit
