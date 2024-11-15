@echo off
pushd "%~dp0"

REM Set path untuk direktori file Winamp
set "winampDir=%~dp0Files"

REM Periksa apakah WinampSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\WinampSetup\WinampSetup.exe" goto RUN_SETUP

REM Ekstrak file WinampSetup jika belum ada
if not exist "%winampDir%\WinampSetup.7z" (
    echo File "%winampDir%\WinampSetup.7z" tidak ditemukan.
    exit /b
)

REM Periksa apakah 7z.exe ada untuk ekstraksi
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

REM Ekstrak file WinampSetup.7z ke direktori sementara
"%~dp0\7z.exe" x -o"%temp%\utility\WinampSetup" -y "%winampDir%\WinampSetup.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan WinampSetup.exe dengan parameter silent install
:RUN_SETUP
start "" /D"%temp%\utility\WinampSetup" "WinampSetup.exe" /S /I
exit
