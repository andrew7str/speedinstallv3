@echo off
pushd "%~dp0"

REM Periksa apakah NitroPro13Setup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\NitroPro\NitroProSetup.exe" goto RUN_INSTALL

REM Ekstrak file NitroPro13.70.4.50.7z jika belum ada
if not exist "Files\NitroPro13.70.4.50.7z" (
    echo File "Files\NitroPro13.70.4.50.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\NitroPro" -y "Files\NitroPro13.70.4.50.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:RUN_INSTALL
REM Jalankan NitroPro13Setup.exe dengan parameter silent
start "" /D"%temp%\utility\NitroPro" "NitroProSetup.exe" /SILENT /norestart
exit
