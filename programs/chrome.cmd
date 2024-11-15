@echo off
:: Script untuk mendeteksi jenis Windows dan menjalankan file installer yang sesuai.

set "chromeDir=%~dp0Files"

title Chrome Installer For Windows By : Mr.exe
:: Ambil versi Windows
for /f "tokens=4-5 delims=[.] " %%a in ('ver') do (
    set major=%%a
    set minor=%%b
)

:: Cek jenis Windows berdasarkan versi
if "%major%"=="5" (
    if "%minor%"=="1" (
        echo Detected: Windows XP
        ping 127.0.0.1 -n 2 > nul
        start "" "%chromeDir%\chromeWXP.cmd"
        goto end
    )
) else if "%major%"=="6" (
    if "%minor%"=="1" (
        echo Detected: Windows 7
        ping 127.0.0.1 -n 2 > nul
        start "" "%chromeDir%\chromeW7.cmd"
        goto end
    ) else if "%minor%"=="2" (
        echo Detected: Windows 8
        ping 127.0.0.1 -n 2 > nul
        start "" "%chromeDir%\chromeW8.cmd"
        goto end
    ) else if "%minor%"=="3" (
        echo Detected: Windows 8.1
        ping 127.0.0.1 -n 2 > nul
        start "" "%chromeDir%\chromeW8.cmd"
        goto end
    )
) else if "%major%"=="10" (
    echo Detected: Windows 10 or Windows 11
    ping 127.0.0.1 -n 2 > nul
    :: Tambahkan logika tambahan untuk Windows 11 jika diperlukan
    start "" "%chromeDir%\chromeW10.cmd"
    goto end
)

echo Windows version not recognized.
goto end

:end
ping 127.0.0.1 -n 5 > nul
