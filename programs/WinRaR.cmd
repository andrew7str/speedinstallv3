@echo off
pushd "%~dp0"

REM Periksa apakah WinRAR sudah ada di lokasi sementara
if exist "%temp%\utility\WinRaR\WinRAR.6.22.exe" goto a

REM Ekstrak file WinRAR.7z jika belum ada
if not exist "Files\WinRAR.7z" (
    echo File "Files\WinRAR.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\WinRaR" -y "Files\WinRAR.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:a
REM Jalankan WinRAR dengan parameter silent
start "" /D"%temp%\utility\WinRaR" "WinRAR.6.22.exe" /VERYSILENT /I /EN
exit
