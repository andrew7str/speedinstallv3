@echo off
pushd "%~dp0"

REM Set path untuk direktori file PowerISO
set "powerisoDir=%~dp0Files"

REM Periksa apakah PowerISOSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\PowerISO\PowerISOSetup.exe" goto RUN_SETUP

REM Ekstrak file PowerISO jika belum ada
if not exist "%powerisoDir%\PowerISO8.9.7z" (
    echo File "%powerisoDir%\PowerISO8.9.7z" tidak ditemukan.
    exit /b
)

REM Periksa apakah 7z.exe ada untuk ekstraksi
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

REM Ekstrak file PowerISO8.9.7z ke direktori sementara
"%~dp0\7z.exe" x -o"%temp%\utility\PowerISO" -y "%powerisoDir%\PowerISO8.9.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan PowerISOSetup.exe dengan parameter silent install yang sesuai
:RUN_SETUP
start "" /D"%temp%\utility\PowerISO" "PowerISOSetup.exe" /verysilent /norestart
exit
