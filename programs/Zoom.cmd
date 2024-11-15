@echo off
pushd "%~dp0"

REM Periksa apakah sistem 64-bit atau 32-bit
if exist %SystemRoot%\SysWOW64\wdscore.dll goto x64

:x86
REM Periksa apakah Zoom sudah diinstal di lokasi sementara
if exist "%temp%\utility\zoom\ZoomInstaller.exe" goto RUN_SETUP

REM Ekstrak installer Zoom 32-bit
if not exist "Files\ZoomInstallerFull32.7z" (
    echo File "Files\ZoomInstallerFull32.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\zoom" -y "Files\ZoomInstallerFull32.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)
goto RUN_SETUP

:x64
REM Periksa apakah Zoom sudah diinstal di lokasi sementara
if exist "%temp%\utility\zoom\ZoomInstaller.exe" goto RUN_SETUP

REM Ekstrak installer Zoom 64-bit
if not exist "Files\ZoomInstallerFull64.7z" (
    echo File "Files\ZoomInstallerFull64.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\zoom" -y "Files\ZoomInstallerFull64.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:RUN_SETUP
REM Jalankan ZoomInstaller.exe dengan parameter silent dan auto-update ON
start "" /D"%temp%\utility\zoom" "ZoomInstaller.exe" /quiet /silent /EnableAutoUpdate=1
exit
