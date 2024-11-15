@echo off
pushd "%~dp0"

REM Deteksi arsitektur sistem
if exist %SystemRoot%\SysWOW64\wdscore.dll (
    set ARCH=x64
) else (
    set ARCH=x86
)

REM Periksa apakah 7z.exe sudah ada
if exist "%temp%\utility\7z\7z.exe" goto RUN7Z

REM Ekstrak 7z.exe berdasarkan arsitektur
if "%ARCH%"=="x64" (
    if not exist "Files\7zx64.7z" (
        echo File "Files\7zx64.7z" tidak ditemukan.
        exit /b
    )
    "%~dp0\7z.exe" x -o"%temp%\utility\7z" -y "Files\7zx64.7z"
) else (
    if not exist "Files\7zx32.7z" (
        echo File "Files\7zx32.7z" tidak ditemukan.
        exit /b
    )
    "%~dp0\7z.exe" x -o"%temp%\utility\7z" -y "Files\7zx32.7z"
)

REM Jalankan 7z.exe
:RUN7Z
start "" /B "%temp%\utility\7z\7z.exe"
exit
