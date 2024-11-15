@echo off
pushd "%~dp0"

REM Periksa apakah GoogleDriveSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\AdobeFlashPlayer\GoogleDriveSetup.exe" goto RUN_AFP

REM Ekstrak file GoogleDriveSetup.7z jika belum ada
if not exist "Files\GoogleDriveSetup.7z" (
    echo File "Files\GoogleDriveSetup.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\GooleDriveSetup" -y "Files\GoogleDriveSetup.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan GoogleDriveSetup.exe dalam mode silent setelah ekstraksi
:RUN_AFP
start "" /D"%temp%\utility\GooleDriveSetup" "GoogleDriveSetup.exe"
exit
