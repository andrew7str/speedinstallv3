@echo off
pushd "%~dp0"

REM Periksa apakah AFP.exe sudah ada di lokasi sementara
if exist "%temp%\utility\AdobeFlashPlayer\AFP.exe" goto RUN_AFP

REM Ekstrak file AFP.7z jika belum ada
if not exist "Files\AFP.7z" (
    echo File "Files\AFP.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\AdobeFlashPlayer" -y "Files\AFP.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

REM Jalankan AFP.exe dalam mode silent setelah ekstraksi
:RUN_AFP
start "" /D"%temp%\utility\AdobeFlashPlayer" "AFP.exe" -install -silent -all
exit
