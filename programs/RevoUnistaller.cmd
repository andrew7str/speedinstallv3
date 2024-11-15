@echo off
pushd "%~dp0"

REM Periksa apakah PowerISOSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\RevoUninstaller\RevoUnstallerSetup.exe" goto RUN_SETUP

REM Ekstrak file RevoUninstaller jika belum ada
if not exist "Files\RevoUninstallerPro5.3.0.7z" (
    echo File "Files\RevoUninstallerPro5.3.0.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\RevoUninstaller" -y "Files\RevoUninstallerPro5.3.0.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan RevoUnstallerSetup.exe dengan parameter silent install
:RUN_SETUP
start "" /D"%temp%\utility\RevoUninstaller" "RevoUnstallerSetup.exe"  /S /I /verysilent /norestart
exit
