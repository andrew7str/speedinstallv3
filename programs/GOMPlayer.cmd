@echo off
pushd "%~dp0"

REM Periksa apakah GOMPlayerPlusSetup.exe sudah ada di lokasi sementara
if exist "%temp%\utility\GOMPlayer\GOMPlayerPlusSetup.exe" goto RUN_INSTALL

REM Ekstrak file GOMPlayerPlusSetup.7z jika belum ada
if not exist "Files\GOMPlayerPlusSetup.7z" (
    echo File "Files\GOMPlayerPlusSetup.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\GOMPlayer" -y "Files\GOMPlayerPlusSetup.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:RUN_INSTALL
REM Jalankan GOMPlayerPlusSetup.exe dengan parameter silent
start "" /D"%temp%\utility\GOMPlayer" "GOMPlayerPlusSetup.exe" /S
exit
