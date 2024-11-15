@echo off
pushd "%~dp0"

REM Periksa apakah BandicamSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\Bandicam\BandicamSetup.exe" goto RUN_SETUP

REM Ekstrak file Bandicam jika belum ada
if not exist "Files\Bandicam7.1.0.2151.7z" (
    echo File "Files\Bandicam7.1.0.2151.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\Bandicam" -y "Files\Bandicam7.1.0.2151.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan BandicamSetup.exe setelah ekstraksi
:RUN_SETUP
start "" /D"%temp%\utility\Bandicam" "BandicamSetup.exe" /VERYSILENT /I
exit
