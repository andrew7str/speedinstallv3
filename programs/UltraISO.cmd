@echo off
pushd "%~dp0"

REM Periksa apakah PowerISOSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\UltraISO\UltraISOSetup.exe" goto RUN_SETUP

REM Ekstrak file UltraISO jika belum ada
if not exist "Files\UltraISO.9.7.6.3860.7z" (
    echo File "Files\UltraISO.9.7.6.3860.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\UltraISO" -y "Files\UltraISO.9.7.6.3860.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan UltraISOSetup.exe dengan parameter silent install
:RUN_SETUP
start "" /D"%temp%\utility\UltraISO" "UltraISOSetup.exe" /verysilent /norestart
exit
