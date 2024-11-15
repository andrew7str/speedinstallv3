@echo off
pushd "%~dp0"

REM Periksa apakah sistem 64-bit atau 32-bit
if exist %SystemRoot%\SysWOW64\wdscore.dll goto x64

:x86
REM Periksa apakah VLC sudah diinstal di lokasi sementara
if exist "%temp%\utility\vlc\vlcsetup.exe" goto RUN_SETUP

REM Ekstrak installer VLC 32-bit
if not exist "Files\vlcsetup32.7z" (
    echo File "Files\vlcsetup32.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\vlc" -y "Files\vlcsetup32.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)
goto RUN_SETUP

:x64
REM Periksa apakah VLC sudah diinstal di lokasi sementara
if exist "%temp%\utility\vlc\vlcsetup.exe" goto RUN_SETUP

REM Ekstrak installer VLC 64-bit
if not exist "Files\vlcsetup64.7z" (
    echo File "Files\vlcsetup64.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\vlc" -y "Files\vlcsetup64.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:RUN_SETUP
REM Jalankan installer VLC dengan parameter silent
start "" /D"%temp%\utility\vlc" "vlcsetup.exe" /S
exit
