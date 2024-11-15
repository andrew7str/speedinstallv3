@echo off
pushd "%~dp0"

REM Periksa apakah XamppSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\RevoUninstaller\xamppsetup.exe" goto RUN_SETUP

REM Ekstrak file XamppSetup jika belum ada
if not exist "Files\xampp64-8.0.28-0-VS16.7z" (
    echo File "Files\xampp64-8.0.28-0-VS16.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\xampp" -y "Files\xampp64-8.0.28-0-VS16.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan xamppsetup.exe dengan parameter silent install
:RUN_SETUP
start "" /D"%temp%\utility\xampp" "xamppsetup.exe"
exit
