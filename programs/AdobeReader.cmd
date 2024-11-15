@echo off
pushd "%~dp0"

REM Periksa apakah AdbeRdr11007.exe sudah ada di lokasi sementara
if exist "%temp%\utility\adr\AdbeRdr11007.exe" goto RUN_INSTALL

REM Ekstrak file AdbeRdr11007.7z jika belum ada
if not exist "Files\AdbeRdr11007.7z" (
    echo File "Files\AdbeRdr11007.7z" tidak ditemukan.
    exit /b
)
if not exist "%~dp0\7z.exe" (
    echo File "7z.exe" tidak ditemukan untuk ekstraksi.
    exit /b
)

"%~dp0\7z.exe" x -o"%temp%\utility\adr" -y "Files\AdbeRdr11007.7z"
if errorlevel 1 (
    echo Ekstraksi gagal. Periksa file dan direktori.
    exit /b
)

:RUN_INSTALL
REM Jalankan installer dengan parameter silent dan auto-update off
start "" /D"%temp%\utility\adr" "AdbeRdr11007.exe" /sAll /msi EULA_ACCEPT=YES ADDLOCAL=ALL DISABLE_UPDATE=1
exit
