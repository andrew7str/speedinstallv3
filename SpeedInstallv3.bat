��&cls::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCuDJEG05k06LRhAcDeSOW6+RpwS+/z64+a7rkIaW6w2e4C7
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAjk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQIme1UEAlXi
::ZQ05rAF9IBncCkqN+0xwdVtCH0rScjra
::ZQ05rAF9IAHYFVzEqQIDOB5RSESrMniuB7kQqP6or9+rlmQwddYaGA==
::eg0/rx1wNQPfEVWB+kM9LVsJDDeSOW6+RpwS+/z64+bHtB59
::fBEirQZwNQPfEVWB+kM9LVsJDDeSOW6+RpwS+/z64+bn
::cRolqwZ3JBvQF1fEqQIdDTZkaTavCU+bLvU4ycTawqq3h2M6cdAVWa71ug==
::dhA7uBVwLU+EWHGF90lwGxRYWReWNWS0Zg==
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE1G8iZh5MSWQ=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRmn5kcxPB4Ubh3CZiuXFPsZ8O2b
::Zh4grVQjdCuDJEG05k06LRhAcBeSOW6+D7sP/On34/zUnn4NUec7UYHIzrWCLPZApBOwO5M10xo=
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
@echo off
:: Periksa apakah ANSICON sudah aktif
if not defined ANSICON (
    if exist "%~dp0\bin\ansi\x86\ansicon.exe" (
        "%~dp0\bin\ansi\x64\ansicon.exe" -p
    ) else if exist "%~dp0\bin\ansi\x64\ansicon.exe" (
        "%~dp0\bin\ansi\x86\ansicon.exe" -p
    )
)

echo off
cls

del "SpeedInstallv3_backup.exe"

@echo off
@echo off

:::::::::::::::CHECK RUN AS ADMINISTRATOR:::::::::::::::;;
REM Periksa apakah skrip dijalankan sebagai administrator
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Running as Administrator...
) ELSE (
mode 90,20
Title WARNING...!!!
echo off
cls
echo.
echo [1;91m    _/          _/    _/_/    _/_/_/    _/      _/  _/_/_/  _/      _/    _/_/_/ [0m  
echo [1;91m   _/          _/  _/    _/  _/    _/  _/_/    _/    _/    _/_/    _/  _/       [0m   
echo [1;91m  _/    _/    _/  _/_/_/_/  _/_/_/    _/  _/  _/    _/    _/  _/  _/  _/  _/_/ [0m    
echo [1;91m   _/  _/  _/    _/    _/  _/    _/  _/    _/_/    _/    _/    _/_/  _/    _/ [0m     
echo [1;91m    _/  _/      _/    _/  _/    _/  _/      _/  _/_/_/  _/      _/    _/_/_/ [0m      
echo [1;91m ID : Tolong Jalankan Tool Run As Administrator [0m
echo [1;91m EN : Please run this script as Administrator [0m
echo [1;91m Klik Kanan Lalu RUN As Administrator [0m
echo [1;91m Exiting/Keluar... [0m
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
cscript programs\warning.vbs > nul
ping 127.0.0.1 -n 6 > nul
exit
)

@echo off
title Pemeriksaan Ketersediaan WMIC
mode 50,5

:: Periksa apakah WMIC tersedia
where wmic >nul 2>&1
if %errorlevel%==0 (
    echo WMIC tersedia di sistem.
    goto lisenswmic
) else (
    echo WMIC tidak ditemukan di sistem.
    goto lisennotwmic
)


::::::::::::::::::::::::::::LISENSI PRO WMIC ON:::::::::::::::::::::::
:lisenswmic
@echo off
title (N)MASUKKAN LISENSI SPEED INSTALL
mode 50,5
setlocal

:: Meminta input ID pengguna
set /p id_user="Masukkan ID Pengguna: "
if "%id_user%"=="" (
    echo ID Pengguna tidak boleh kosong.
    pause
    goto lisenswmic
)

:: Meminta input token
set /p input_token="Masukkan Token: "
if "%input_token%"=="" (
    echo Token tidak boleh kosong.
    pause
    goto lisenswmic
)

:: Dekripsi token menggunakan PowerShell dan AES
set secret_key=astagadrag0nw0ij
for /f "delims=" %%i in ('powershell -Command ^
    "try {" ^
    "    $key = [System.Text.Encoding]::UTF8.GetBytes('%secret_key%');" ^
    "    $aes = New-Object System.Security.Cryptography.AesManaged;" ^
    "    $aes.Key = $key;" ^
    "    $aes.IV = $key[0..15];" ^
    "    $encrypted_token = [System.Convert]::FromBase64String('%input_token%');" ^
    "    $decryptor = $aes.CreateDecryptor();" ^
    "    $decrypted_token = $decryptor.TransformFinalBlock($encrypted_token, 0, $encrypted_token.Length);" ^
    "    [System.Text.Encoding]::UTF8.GetString($decrypted_token);" ^
    "} catch {" ^
    "    Write-Output 'ERROR: ' + $_;" ^
    "    exit 1;" ^
    "}"') do set token=%%i

:: Periksa apakah dekripsi berhasil
echo %token% | findstr /i "ERROR:" >nul
if %errorlevel% equ 0 (
    echo Terjadi kesalahan saat dekripsi. Pastikan token benar.
    pause
    goto lisenswmic
)

:: Memastikan token memiliki format yang benar
echo %token% | findstr /r "^.*:.*:.*:.*$" >nul
if errorlevel 1 (
    echo Token tidak valid. Pastikan token yang Anda masukkan benar.
    pause
    goto lisenswmic
)

:: Pisahkan ID pengguna, Email, No HP, dan tanggal kedaluwarsa
for /f "tokens=1-4 delims=:" %%A in ("%token%") do (
    set id_from_token=%%A
    set email=%%B
    set no_hp=%%C
    set expiration=%%D
)

:: Memastikan ID dari token sesuai dengan ID yang diinput oleh pengguna
if /i not "%id_user%"=="%id_from_token%" (
    echo ID Pengguna tidak cocok dengan token.
    pause
    goto lisenswmic
)

:: Mendapatkan tanggal saat ini (kompatibel dengan Windows 7)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set current_date=%datetime:~0,4%%datetime:~4,2%%datetime:~6,2%

:: Mengonversi tanggal kedaluwarsa ke format numerik yang sama (YYYYMMDD)
set expiration_date_numerical=%expiration:~0,4%%expiration:~5,2%%expiration:~8,2%

:: Debugging: Menampilkan tanggal saat ini dan tanggal kedaluwarsa untuk verifikasi
echo Current Date (YYYYMMDD): %current_date%
echo Expiration Date (YYYYMMDD): %expiration_date_numerical%

:: Bandingkan tanggal saat ini dengan tanggal kedaluwarsa
:: Menggunakan perbandingan numerik dengan format YYYYMMDD
if %current_date% gtr %expiration_date_numerical% (
    echo Token sudah kedaluwarsa.
    echo Masa berlaku telah berakhir pada %expiration%.
    pause
    goto lisenswmic
) else (
    echo Token masih berlaku untuk ID Pengguna: %id_user%.
    echo Token berlaku sampai dengan: %expiration%.
    
    :: Membuat file VBScript sementara untuk pesan pop-up dengan baris baru
    echo MsgBox "ID: %id_user%" ^& vbCrLf ^& "Email: %email%" ^& vbCrLf ^& "No. HP: %no_hp%" ^& vbCrLf ^& "Berlaku hingga: %expiration%" ^& vbCrLf ^& "Terima Kasih sudah berlangganan." ^& vbCrLf ^& "By: Mr.exe" ^, 0, "Lisensi v3 Unlimited" > message.vbs
    cscript //nologo message.vbs
    del message.vbs
)
goto inivar


::::::::::::::::::::::::::::LISENSI PRO TANPA WMIC:::::::::::::::::::::::
:lisennotwmic
title (F)MASUKKAN LISENSI TANPA WMIC
mode 100,20
setlocal

:: Meminta input ID pengguna
set /p id_user="Masukkan ID Pengguna: "
if "%id_user%"=="" (
    echo ID Pengguna tidak boleh kosong.
    pause
    goto lisennotwmic
)

:: Meminta input token
set /p input_token="Masukkan Token: "
if "%input_token%"=="" (
    echo Token tidak boleh kosong.
    pause
    goto lisennotwmic
)

:: Dekripsi token menggunakan PowerShell
set secret_key=astagadrag0nw0ij
for /f "delims=" %%i in ('powershell -Command ^
    "try {" ^
    "    $key = [System.Text.Encoding]::UTF8.GetBytes('%secret_key%');" ^
    "    $aes = New-Object System.Security.Cryptography.AesManaged;" ^
    "    $aes.Key = $key;" ^
    "    $aes.IV = $key[0..15];" ^
    "    $encrypted_token = [System.Convert]::FromBase64String('%input_token%');" ^
    "    $decryptor = $aes.CreateDecryptor();" ^
    "    $decrypted_token = $decryptor.TransformFinalBlock($encrypted_token, 0, $encrypted_token.Length);" ^
    "    [System.Text.Encoding]::UTF8.GetString($decrypted_token);" ^
    "} catch {" ^
    "    Write-Output 'ERROR: ' + $_;" ^
    "    exit 1;" ^
    "}"') do set token=%%i

:: Validasi token hasil dekripsi
echo %token% | findstr /i "ERROR:" >nul
if %errorlevel% equ 0 (
    echo Dekripsi gagal. Token tidak valid.
    pause
    goto lisennotwmic
)

:: Debugging: Menampilkan token
echo Token hasil dekripsi: %token%

:: Memastikan token memiliki format yang benar
echo %token% | findstr /r "^.*:.*:.*:.*$" >nul
if %errorlevel% neq 0 (
    echo Token tidak valid. Pastikan formatnya benar.
    pause
    goto lisennotwmic
)

:: Pisahkan informasi token
for /f "tokens=1-4 delims=:" %%A in ("%token%") do (
    set id_from_token=%%A
    set email=%%B
    set no_hp=%%C
    set expiration=%%D
)

:: Validasi ID Pengguna
if /i not "%id_user%"=="%id_from_token%" (
    echo ID Pengguna tidak cocok.
    pause
    goto lisennotwmic
)

:: Mendapatkan tanggal saat ini menggunakan PowerShell
for /f %%I in ('powershell -Command "(Get-Date).ToString(\'yyyyMMdd\')"') do set current_date=%%I
set expiration_date_numerical=%expiration:~0,4%%expiration:~5,2%%expiration:~8,2%

:: Debugging: Menampilkan tanggal
echo Current Date (YYYYMMDD): %current_date%
echo Expiration Date (YYYYMMDD): %expiration_date_numerical%

:: Validasi tanggal
if %current_date% gtr %expiration_date_numerical% (
    echo Token sudah kedaluwarsa.
    echo Berlaku hingga: %expiration%.
    pause
    goto lisennotwmic
)
goto inivar













:inivar
setlocal enabledelayedexpansion
:: =================== Bagian: Inisialisasi Variabel ====================
set SPEED_INSTALL_DIR=%~dp0
set USERNAME=
set COMPUTERNAME=
set OS_VER=
set OS_BUILD=
set OS_ARCH=
set CPU=
set RAM=
set TIMEZONE=
set FNETFX4=
set GARC=v3Ultimate
set PWRPLAN1=High Performance
set PWRPLAN2=Plugged in
set Edition=Pro
set MANUFACTURER=
set MODEL=

:: =================== Bagian: Deteksi Versi Windows ===================
for /f "tokens=4-5 delims=[.] " %%i in ('ver') do (
    set VERSION_MAJOR=%%i
    set VERSION_MINOR=%%j
)

set WIN_VER=
if "%VERSION_MAJOR%"=="5" (
    if "%VERSION_MINOR%"=="1" set WIN_VER=XP
    if "%VERSION_MINOR%"=="2" set WIN_VER=Server2003
)
if "%VERSION_MAJOR%"=="6" (
    if "%VERSION_MINOR%"=="0" set WIN_VER=Vista
    if "%VERSION_MINOR%"=="1" set WIN_VER=Win7
    if "%VERSION_MINOR%"=="2" set WIN_VER=Win8
    if "%VERSION_MINOR%"=="3" set WIN_VER=Win8.1
)
if "%VERSION_MAJOR%"=="10" set WIN_VER=Win10
if "%VERSION_MAJOR%"=="11" set WIN_VER=Win11

echo Detected Windows Version: %WIN_VER%

:: =================== Bagian: Deteksi Sistem Berdasarkan Versi ===================
cls
title TUNGGU BENTAR NGAB
mode 30,15
rem Set jumlah logo yang ada
set maxLogos=6
rem Pilih logo secara acak antara 1 hingga jumlah logo
set /a randomLogo=%random% %% maxLogos + 1
call :Logo%randomLogo%
echo WAIT THE MOMENT...
echo TUNGGU SEBENTAR...

if "%WIN_VER%"=="XP" (
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get username /value') do set USERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get name /value') do set COMPUTERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set LOCALDATETIME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get caption /value') do set OSNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get version /value') do set OSVERSION=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get buildnumber /value') do set OSBUILD=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get osarchitecture /value') do set OSARCH=%%i
    for /f "tokens=2 delims==" %%i in ('wmic timezone get caption /value') do set TIMEZONE=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get vendor /value') do set MANUFACTURER=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get name /value') do set MODEL=%%i
) else if "%WIN_VER%"=="Vista" (
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get username /value') do set USERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get name /value') do set COMPUTERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set LOCALDATETIME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get caption /value') do set OSNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get version /value') do set OSVERSION=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get buildnumber /value') do set OSBUILD=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get osarchitecture /value') do set OSARCH=%%i
    for /f "tokens=2 delims==" %%i in ('wmic timezone get caption /value') do set TIMEZONE=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get vendor /value') do set MANUFACTURER=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get name /value') do set MODEL=%%i
) else if "%WIN_VER%"=="Win7" (
    for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version') do set FNETFX4=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get username /value') do set USERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get name /value') do set COMPUTERNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set LOCALDATETIME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get caption /value') do set OSNAME=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get version /value') do set OSVERSION=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get buildnumber /value') do set OSBUILD=%%i
    for /f "tokens=2 delims==" %%i in ('wmic os get osarchitecture /value') do set OSARCH=%%i
    for /f "tokens=2 delims==" %%i in ('wmic timezone get caption /value') do set TIMEZONE=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_Processor).Name"') do set CPU=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB"') do set RAM=%%i
    for /f "tokens=2 delims==" %%i in ('wmic timezone get caption /value') do set TIMEZONE=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get vendor /value') do set MANUFACTURER=%%i
    for /f "tokens=2 delims==" %%i in ('wmic csproduct get name /value') do set MODEL=%%i
) else (
    for /f "tokens=*" %%i in ('powershell -command "(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Version).Version"') do set FNETFX4=%%i
    for /f "tokens=*" %%i in ('powershell -command "[System.Security.Principal.WindowsIdentity]::GetCurrent().Name"') do set USERNAME=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_ComputerSystem).Name"') do set COMPUTERNAME=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_OperatingSystem).LocalDateTime"') do set LOCALDATETIME=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_OperatingSystem).Caption"') do set OSNAME=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_OperatingSystem).Version"') do set OSVERSION=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_OperatingSystem).BuildNumber"') do set OSBUILD=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture"') do set OSARCH=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_TimeZone).Caption"') do set TIMEZONE=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_Processor).Name"') do set CPU=%%i
    for /f "tokens=*" %%i in ('powershell -command "(Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB"') do set RAM=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get manufacturer /value') do set MANUFACTURER=%%i
    for /f "tokens=2 delims==" %%i in ('wmic computersystem get model /value') do set MODEL=%%i
)


:: =================== Bagian: Mengecek Koneksi Internet ===================
setlocal enabledelayedexpansion
echo Mengecek koneksi internet...
ping -n 1 google.com > nul 2>&1

if %errorlevel% equ 0 (
    set INTERNET_STATUS=Connected internet
) else (
    set INTERNET_STATUS=Disconnect internet
)


:::::::::::::::: Periksa apakah ANSICON sudah aktif ::::::::::::::::::;;
:: Periksa apakah ANSICON sudah aktif
if not defined ANSICON (
    if exist "%~dp0\bin\ansi\x86\ansicon.exe" (
        "%~dp0\bin\ansi\x64\ansicon.exe" -p
    ) else if exist "%~dp0\bin\ansi\x64\ansicon.exe" (
        "%~dp0\bin\ansi\x86\ansicon.exe" -p
    )
)

echo off
cls





setlocal disableDelayedExpansion
set q=^"

:menusi
title Speed Install V3 Ultimate
cls
mode 120,30
echo [93m ���������[0m[1;91m ������ۻ�����ۻ ������ۻ������ۻ�����ۻ     �ۻ��ۻ   �ۻ������ۻ�������ۻ ����ۻ �ۻ     �ۻ[0m      [93m���������[0m
echo [93m ���������[0m[1;91m ������ͼ������ۻ������ͼ������ͼ������ۻ    �ۺ���ۻ  �ۺ������ͼ�������ͼ������ۻ�ۺ     �ۺ[0m      [93m���������[0m
echo [93m �[0m[1;91m   [1;91m ������ۻ������ɼ����ۻ  ����ۻ  �ۺ  �ۺ    �ۺ����ۻ �ۺ������ۻ   �ۺ   ������ۺ�ۺ     �ۺ[0mV3      [97m[1;91m [0m[93m�[0m
echo [93m �[0m[1;91m [0m  [97m ������ۺ�����ͼ ����ͼ  ����ͼ  �ۺ  �ۺ    �ۺ�ۺ��ۻ�ۺ������ۺ   �ۺ   ������ۺ�ۺ     �ۺ[0mULTIMATE[1;91m [0m[93m�[0m
echo [93m ���������[0m[97m[0m[97m ������ۺ�ۺ     ������ۻ������ۻ������ɼ    �ۺ�ۺ ����ۺ������ۺ   �ۺ   �ۺ  �ۺ������ۻ������ۻ[0m [93m���������[0m
echo [93m �� ��[0m    [97m ������ͼ�ͼ     ������ͼ������ͼ�����ͼ     �ͼ�ͼ  ���ͼ������ͼ   �ͼ   �ͼ  �ͼ������ͼ������ͼ[0m [93m    �� ��[0m
echo [97m������������������������������������������������������������������������������������������������������������������������[0m
echo [97m[97mUSER:[0m[93m%USERNAME%[93m[97m�COMPUTERNAME:[0m[93m%COMPUTERNAME%[0m[97m�[0m[96mSELAMAT DATANG : %id_user%[97m�[0mExp:%expiration_date_numerical%[0m[97m�[0m
echo [0m[97mCURRENT OS:[0m[1;92m%OSNAME%[0m[97m�[0m[1;92mVER:%OSVERSION%[0m[97m�[0m[1;92mBUILD:%OSBUILD%[0m[97m�[0m[1;92mARCH:%OSARCH%[0m[97m�NETFX4:[0m[93m%FNETFX4%[0m
echo [97mSPESIFIKASI:[0m[1;92mCPU:%CPU%[0m[97m�[0m[1;92mRAM:%RAM%[0m[97m�[0m[93mKoneksi Internet:[0m [93m%INTERNET_STATUS%[0m
echo [97mTIME ZONE:[0m[1;91m%TIMEZONE%[0m[97m�[0m[95mManufacturer:[0m[97m%MANUFACTURER%[0m[97m�[0m[95mModel:[0m[97m%MODEL%[0m
echo [95mCreateBy:[0m[96mMr.exe[0m[97m�[0m[1;92mGitHub : andrew7str[0m[97m�[0m
echo [97m������������������������������������������������������������������������������������������������������������������������[0m
echo          [93m ���Ķ[0m[1;91mMenu[0m[93m����������������������������Ŀ[0m                 �������������������
echo          [93m �[0m[96m 1. Auto Install [0m [93m                   �[0m                 �                 �
echo          [93m �[0m[96m 2. Pilih yang perlu di install [0m [93m    �[0m                 �    -._ _-_      �
echo          [93m �[0m[96m 3. Update Speed Install [0m [93m           �[0m                 �    -._�[41m [0m�[42m [0m�     �
echo          [93m �[0m[96m 4. Aktivasi [0m [93m                       �[0m                 �    -._�[48;5;129m-[0m�[48;5;46m-[0m�     �
echo          [93m �[0m[96m 5. Install Ms.OFFICE [0m [93m              �[0m                 �    -._�[44m_[0m�[43m_[0m�     �
echo          [93m �[0m[96m 6. Install Driver [0m [93m                 �[0m                 �                 �
echo          [93m �[0m[96m 7. Network [0m [93m                        �[0m                 �������������������
echo          [93m �[0m[96m 8. Utilites [0m [93m                       �[0m                 /.-.-.-.-.-.-.-.-.\
echo          [93m �[0m[96m 9. GAMING MODE [0m [93m                    �[0m                /.-.-.-.-.-.-.-.-.-.\
echo          [93m �[0m[96m a. About ME [0m [93m                       �[0m              /______/__________\___o_\
echo          [93m �[0m[96m 0. Keluar [0m [93m                         �[0m              \_______________________/
echo          [93m ���������������������������������������[0m
echo           [97m���[0m([92m %username%[0m@[95m%computername%[0m)
set /p pilihanmenu=" %BS% [97m          ���>[0m "
if "%pilihanmenu%"=="1" goto pilmen1
if "%pilihanmenu%"=="2" goto pilmen2
if "%pilihanmenu%"=="3" goto pilmen3
if "%pilihanmenu%"=="4" goto pilmen4
if "%pilihanmenu%"=="5" goto pilmen5
if "%pilihanmenu%"=="6" goto pilmen6
if "%pilihanmenu%"=="7" goto pilmen7
if "%pilihanmenu%"=="8" goto pilmen8
if "%pilihanmenu%"=="9" goto pilmen9
if "%pilihanmenu%"=="a" goto pilmen10
if "%pilihanmenu%"=="0" exit
goto menusi




:::::::::::::::AUTO INSTALL:::::::::::::::::::
:pilmen1

setlocal enabledelayedexpansion
set "programsDir=%~dp0Programs"
cls
title Fast Auto Install Programs All In One
mode 50,8

IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
    set "arch=x32"
    goto :bit32
  )
)

set "arch=x64"
goto :bit64


:bit32
mode 50,15
echo Auto Detect By : 
  echo [0;36;40m         �˻�Ŀ �ͻͻ ��ͻ[0m
echo [0;1;36;40m         ������ �� ��˼�� [0m
  echo [0;36;40m         � ������ͼ� ���ͼ[0m
echo Your Windows Detect : 32-bit
echo Install Programs AIO
call :InstallPrograms
goto :Sukses

:bit64
mode 50,30
echo Auto Detect By : 
  echo [0;36;40m         �˻�Ŀ �ͻͻ ��ͻ[0m
echo [0;1;36;40m         ������ �� ��˼�� [0m
  echo [0;36;40m         � ������ͼ� ���ͼ[0m
echo Your Windows Detect : 64-bit
echo Install Programs AIO
call :InstallPrograms
goto :Sukses

:InstallPrograms
cscript programs\install.vbs > nul
echo Install Winrar...
start "" "%programsDir%\WinRaR.cmd"
echo install MozilaFireFox...
start "" "%programsDir%\FireFox.cmd"
echo install VLC...
start "" "%programsDir%\VLC.cmd"
echo install Zoom...
start "" "%programsDir%\Zoom.cmd"
echo install Google Chrome...
start "" "%programsDir%\chrome.cmd"
echo install AdobeReader...
"%programsDir%\AdbeRdr11007.exe" /sAll /msi EULA_ACCEPT=YES

goto :eof

:Sukses
title Finish...!!!
cls
mode 85,20
echo off
echo.
echo         ::::::::  :::::::::: :::        :::::::::: ::::::::      :::     ::::::::::: 
echo       :+:    :+: :+:        :+:        :+:       :+:    :+:   :+: :+:       :+:     
echo      +:+        +:+        +:+        +:+       +:+         +:+   +:+      +:+    
echo     +#++:++#++ +#++:++#   +#+        +#++:++#  +#++:++#++ +#++:++#++:     +#+    
echo           +#+ +#+        +#+        +#+              +#+ +#+     +#+     +#+    
echo   #+#    #+# #+#        #+#        #+#       #+#    #+# #+#     #+#     #+#     
echo   ########  ########## ########## ########## ########  ###     ### ###########   
echo Programs All In One Telah terinstall...!!!
echo Create Script By : Andrew Malsar Sianturi
cscript programs\Done.vbs > nul
ping 127.0.0.1 -n 6 > nul
goto menusi



:::::::::::::::::::::::Pilih yang perlu di install:::::::::::::::::::::::::
:pilmen2
cls
setlocal enabledelayedexpansion
set NetFw=All
set "programDir=%~dp0programs"
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set arch=x64) else (set arch=x86)

mode 34,33
cls
title Install Software
  echo [0;36;40m    ����ͻ�����ͻ ��ͻ����ͻ [0m
echo [0;1;36;40m    �ͻ� �̹  � ����͹�˼��  [0m
  echo [0;36;40m    �ͼ��ʼ   � ��ʼ ȼ���ͼ [0m
echo [93m ����[0m[1;91mProgram yang tersedia[0m[93m����ͻ[0m
echo [93m �����[0m[95mMenu[0m[93m�������������������Ŀ�[0m
echo [93m ��[0m[96m 1. WinRAR                 [0m[93m��[0m
echo [93m ��[0m[96m 2. 7zip                   [0m[93m��[0m
echo [93m ��[0m[96m 3. Google Chrome          [0m[93m��[0m
echo [93m ��[0m[96m 4. Mozilla Firefox        [0m[93m��[0m
echo [93m ��[0m[96m 5. VLC Media Player       [0m[93m��[0m
echo [93m ��[0m[96m 6. Zoom                   [0m[93m��[0m
echo [93m ��[0m[96m 7. Adobe Reader           [0m[93m��[0m
echo [93m ��[0m[96m 8. Brave                  [0m[93m��[0m
echo [93m ��[0m[96m 9. Opera                  [0m[93m��[0m
echo [93m ��[0m[96m 10.XAMPP                  [0m[93m��[0m
echo [93m ��[0m[96m 11.Googe Drive            [0m[93m��[0m
echo [93m ��[0m[96m 12.Adobe Flash Player     [0m[93m��[0m
echo [93m ��[0m[96m 13.Power ISO              [0m[93m��[0m
echo [93m ��[0m[96m 14.Bandicam 7.1.0.2151    [0m[93m��[0m
echo [93m ��[0m[96m 15.Ultra ISO              [0m[93m��[0m
echo [93m ��[0m[96m 16.IDM 642build21         [0m[93m��[0m
echo [93m ��[0m[96m 17.Nitro PDF Pro 13.70    [0m[93m��[0m
echo [93m ��[0m[96m 18.GOM Player Plus        [0m[93m��[0m
echo [93m ��[0m[96m 19.Winamp                 [0m[93m��[0m
echo [93m ��[0m[96m 20.Revo Uninstaller       [0m[93m��[0m
echo [93m ��[0m[96m vcr.Visual C Runtime ALl  [0m[93m��[0m
echo [93m ��[0m[96m net.NetFramework All      [0m[93m��[0m
echo [93m ��[0m[96m 0. Kembali                [0m[93m��[0m
echo [93m �����������������������������ٺ[0m
echo [93m �����������������������������ͼ[0m
echo  [97m���[0m([92m %username%[0m@[95m%computername%[0m)
set /p menprog=" %BS% [97m ���>[0m "
if "%menprog%"=="1" start "" "%programDir%\WinRaR.cmd"
if "%menprog%"=="2" start "" "%programDir%\7zz.cmd"
if "%menprog%"=="3" start "" "%programDir%\chrome.cmd"
if "%menprog%"=="4" start "" "%programDir%\FireFox.cmd"
if "%menprog%"=="5" start "" "%programDir%\VLC.cmd"
if "%menprog%"=="6" start "" "%programDir%\Zoom.cmd"
if "%menprog%"=="7" start "" "%programDir%\AdobeReader.cmd"
if "%menprog%"=="8" start "" "%programDir%\Brave.cmd"
if "%menprog%"=="9" start "" "%programDir%\Opera.cmd"
if "%menprog%"=="10" start "" "%programDir%\xampp.cmd"
if "%menprog%"=="11" start "" "%programDir%\GoogleDrive.cmd"
if "%menprog%"=="12" start "" "%programDir%\AdobeFlashPlayer.cmd"
if "%menprog%"=="13" start "" "%programDir%\PowerISO.cmd"
if "%menprog%"=="14" start "" "%programDir%\Bandicam.cmd"
if "%menprog%"=="15" start "" "%programDir%\UltraISO.cmd"
if "%menprog%"=="16" start "" "%programDir%\idm.cmd"
if "%menprog%"=="17" start "" "%programDir%\NitroPro.cmd"
if "%menprog%"=="18" (
    :: Menjalankan installer GOM Player Plus dan menunggu hingga selesai
    start "" "%programDir%\GOMPlayer.cmd"
    echo Meng-install GOM Player Pluss
    ping 127.0.0.1 -n 10 > nul
    :: Mengekstrak file patcher dari arsip .7z langsung ke folder instalasi
    start "" "%programDir%\utility\GOMPatcherInstaller.cmd"
    goto pilmen2
)

if "%menprog%"=="19" start "" "%programDir%\Winamp.cmd"
if "%menprog%"=="20" start "" "%programDir%\RevoUnistaller.cmd"
if "%menprog%"=="vcr" goto vcrall
if "%menprog%"=="net" goto pilnetframework
if "%menprog%"=="0" goto menusi
goto pilmen2


::::::::::::VCR MENU:::::::::::
:vcrall
title Visual-C-Runtimes-All-in-One - SPEED INSTALLv3 ULTIMATE
mode 34,27
cls
setlocal
@echo off
CD /d %~dp0programs

  echo [0;36;40m    ���   ��� ������� ������� [0m
  echo [0;36;40m    ���   ���������ͼ ����Ͱ��[0m
echo [0;1;36;40m    ���   ������      ������ɼ[0m
echo [0;1;36;40m    Ȱ�� ��ɼ���      ����Ͱ��[0m
  echo [0;36;40m     Ȱ���ɼ Ȱ������ ���  ���[0m
  echo [0;36;40m      ���ͼ   �����ͼ[0;1;36;40m�[0m[0;36;40m�ͼ  �ͼ[0m

:: Cek arsitektur
set IS_X64=0 && if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set IS_X64=1) else (if "%PROCESSOR_ARCHITEW6432%"=="AMD64" (set IS_X64=1))

if "%IS_X64%" == "1" goto X64

:: Instalasi x86
echo 2005...
start /wait vcredist2005_x86.exe /q

echo 2008...
start /wait vcredist2008_x86.exe /qb

echo 2010...
start /wait vcredist2010_x86.exe /passive /norestart

echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart

echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart

echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart

goto END

:X64
:: Instalasi x64 dan x86
echo 2005...
start /wait vcredist2005_x86.exe /q
start /wait vcredist2005_x64.exe /q

echo 2008...
start /wait vcredist2008_x86.exe /qb
start /wait vcredist2008_x64.exe /qb

echo 2010...
start /wait vcredist2010_x86.exe /passive /norestart
start /wait vcredist2010_x64.exe /passive /norestart

echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart
start /wait vcredist2012_x64.exe /passive /norestart

echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart
start /wait vcredist2013_x64.exe /passive /norestart

echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait vcredist2015_2017_2019_2022_x64.exe /passive /norestart

:END
echo.
echo Done!
pause
goto pilmen2

:pilnetframework
@echo off
mode 40,20
set "prognfDir=%~dp0programs\netframework\"
cls
echo =======================================
  echo [0;36;40m ɻ��ͻ�˻  �ͻ�ͻ�ͻ�˻�ͻ� ��ͻ�ͻ���[0m
echo [0;1;36;40m �����  �   ̹ �˼�͹����� ���� ��˼�ʻ[0m
  echo [0;36;40m �ȼ�ͼ � [0;1;36;40m�[0m [0;36;40m�  ���� �� ��ͼ�ʼ�ͼ���� �[0m
echo =======================================
echo 1. NET Framework 1.1 - 3.5
echo 2. NET Framework 4.0
echo 3. NET Framework 4.8
echo 4. NET Framework 5.0
echo 5. NET Framework 6.0
echo 6. NET Framework 7.0
echo 7. Semua Versi NET Framework (All)
echo 0. Kembali
echo =======================================
echo  [97m���[0m([92m %username%[0m@[95m%computername%[0m)
set /p pilnf=" %BS% [97m ���>[0m "

if "%pilnf%"=="1" goto NetFw11_35
if "%pilnf%"=="2" goto NetFw40
if "%pilnf%"=="3" goto NetFw48
if "%pilnf%"=="4" goto Net50
if "%pilnf%"=="5" goto Net60
if "%pilnf%"=="6" goto Net70
if "%pilnf%"=="7" goto NetAll
if "%pilnf%"=="0" goto pilmen2
goto pilnetframework

:NetFw11_35
echo Menginstal .NET Framework 1.1 - 3.5...
"%prognfDir%setup.exe" /NetFw11_35 /VERYSILENT
goto selesainf

:NetFw40
echo Menginstal .NET Framework 4.0...
"%prognfDir%setup.exe" /NetFw40 /VERYSILENT
goto selesainf

:NetFw48
echo Menginstal .NET Framework 4.8...
"%prognfDir%setup.exe" /NetFw48 /VERYSILENT
goto selesainf

:Net50
echo Menginstal .NET Framework 5.0...
"%prognfDir%setup.exe" /Net50 /VERYSILENT
goto selesainf

:Net60
echo Menginstal .NET Framework 6.0...
"%prognfDir%setup.exe" /Net60 /VERYSILENT
goto selesainf

:Net70
echo Menginstal .NET Framework 7.0...
"%prognfDir%setup.exe" /Net70 /VERYSILENT
goto selesainf

:NetAll
echo Menginstal Semua Versi .NET Framework (1.1 - 7.0)...
"%prognfDir%setup.exe" /NetFw11_35 /VERYSILENT
"%prognfDir%setup.exe" /NetFw40 /VERYSILENT
"%prognfDir%setup.exe" /NetFw48 /VERYSILENT
"%prognfDir%setup.exe" /Net50 /VERYSILENT
"%prognfDir%setup.exe" /Net60 /VERYSILENT
"%prognfDir%setup.exe" /Net70 /VERYSILENT
goto selesainf


:selesainf
echo Instalasi selesai!
pause
goto pilnetframework



::::::::::::::::UPDATE SPEED INSTALL::::::::::::::::;
:pilmen3
title Update Speed Install
cls
@echo off
setlocal enabledelayedexpansion

echo [1;91m�ۻ   �ۻ�����ۻ �����ۻ  ����ۻ �������ۻ������ۻ [0m
echo [1;91m�ۺ   �ۺ������ۻ������ۻ������ۻ�������ͼ������ͼ [0m
echo [1;91m�ۺ   �ۺ������ɼ�ۺ  �ۺ������ۺ   �ۺ   ����ۻ [0m
  echo [97m�ۺ   �ۺ�����ͼ �ۺ  �ۺ������ۺ   �ۺ   ����ͼ [0m
  echo [97m�������ɼ�ۺ     ������ɼ�ۺ  �ۺ   �ۺ   ������ۻ [0m
  echo [97m�����ͼ �ͼ     �����ͼ �ͼ  �ͼ   �ͼ   ������ͼ [0m

@echo off

:: Folder tujuan adalah direktori saat ini (tempat skrip batch berada)
set "FOLDER=%~dp0"

:: Path ke wget
set "WGET_PATH=%~dp0wget\wget.exe"

:: URL file SpeedInstallv3.exe di GitHub
set "REPO_URL=https://raw.githubusercontent.com/andrew7str/speedinstallv3/main/SpeedInstallv3.exe"

echo Checking internet connection...

:: Cek koneksi internet dengan ping ke Google
ping -n 1 google.com >nul 2>&1
if errorlevel 1 (
    echo No internet connection. Returning to menu...
    goto :menusi
)

echo Internet connected. Checking for updates...

:: Unduh versi terbaru SpeedInstallv3.exe dari GitHub
"%WGET_PATH%" -O "%FOLDER%temp_SpeedInstallv3.exe" "%REPO_URL%" --no-check-certificate

:: Cek jika download berhasil
if exist "%FOLDER%temp_SpeedInstallv3.exe" (
    echo Update found. Updating...

    :: Backup file lama jika dibutuhkan
    if exist "%FOLDER%SpeedInstallv3.exe" (
        if exist "%FOLDER%SpeedInstallv3_backup.exe" del "%FOLDER%SpeedInstallv3_backup.exe"
        rename "%FOLDER%SpeedInstallv3.exe" "SpeedInstallv3_backup.exe"
    )

    :: Ganti dengan file terbaru
    rename "%FOLDER%temp_SpeedInstallv3.exe" "SpeedInstallv3.exe"
    echo Update complete. Restarting...

    :: Hapus file backup setelah update selesai
    if exist "%FOLDER%SpeedInstallv3_backup.exe" del "%FOLDER%SpeedInstallv3_backup.exe"

    :: Jalankan file yang baru saja diupdate
    start "" "%FOLDER%SpeedInstallv3.exe"
    exit
) else (
    echo No update found or failed to download update. Returning to menu...
    goto :menusi
)


:::::::::::::::::AKTIVASI:::::::::::::::
:pilmen4
mode 40,20
title Aktivasi
set "programacDir=%~dp0programs\tools"
set "progutilDir=%~dp0programs\utility"
cls
  echo [0;36;40m �ͻ  ���  �˻  �  �ͻ  �ͻ  �ͻ  � [0m
echo [0;1;36;40m �͹  �ʻ   �   �  ̹   �͹  �ͻ  � [0m
  echo [0;36;40m � �  � �   �   �  �    � �  �ͼ  � [0m
rem Tambahkan perintah aktivasi di sini
echo [93m ���Ķ[0m[95mMenu[0m[93m��������������������������Ŀ[0m
echo [93m �[0m[96m 1.  KMS VL ALL                    [0m[93m�[0m
echo [93m �[0m[96m 2.  KMS v9.1                      [0m[93m�[0m
echo [93m �[0m[96m 3.  IDM Activator                 [0m[93m�[0m
echo [93m �[0m[96m 4.  Re-LoaderRa1n                 [0m[93m�[0m
echo [93m �[0m[96m 5.  MAS 2.7 AIO                   [0m[93m�[0m
echo [93m �[0m[96m 6.  Chew-WGA (For Windows7)       [0m[93m�[0m
echo [93m �[0m[96m 7.  RemoveWAT (For Windows7       [0m[93m�[0m
echo [93m �[0m[96m 8.  WindowsLoader2.2 (Windows7)   [0m[93m�[0m
echo [93m �[0m[96m 9.  GOM Patcher                   [0m[93m�[0m
echo [93m �[0m[96m 10. SolidWork Activator           [0m[93m�[0m
echo [93m �[0m[96m 11. HEU Activator                 [0m[93m�[0m
echo [93m �[0m[96m 0.  kembali                       [0m[93m�[0m
echo [93m �������������������������������������[0m
echo  [97m���[0m([92m %username%[0m@[95m%computername%[0m)
set /p progact=" %BS% [97m ���>[0m "
if "%progact%"=="1" start "" "%progutilDir%\KMS_VL_ALL_AIO.cmd"
if "%progact%"=="2" start "" "%progutilDir%\KMS_Suite.v9.1.EN.bat"
if "%progact%"=="3" start "" "%progutilDir%\IDM.cmd"
if "%progact%"=="4" goto Reloader
if "%progact%"=="5" start "" "%progutilDir%\MAS_2.7.AIO.cmd"
if "%progact%"=="6" start "" "%progutilDir%\CW.cmd"
if "%progact%"=="7" start "" "%progutilDir%\RemoveWAT.cmd"
if "%progact%"=="8" start "" "%progutilDir%\WindowsLoader.cmd"
if "%progact%"=="9" start "" "%progutilDir%\GOMPatcherInstaller.cmd"
if "%progact%"=="10" goto swact
if "%progact%"=="11" start "" "%progutilDir%\HEUKMS.cmd"
if "%progact%"=="0" goto menusi
goto pilmen4

:Reloader
set "progutilDir=%~dp0programs\utility"

:: Tampilkan MsgBox menggunakan VBScript dengan tombol Yes/No yang disesuaikan
echo Set objWshShell = CreateObject("WScript.Shell") > reloader.vbs
echo intResult = objWshShell.Popup("Mau yang mana? GUI Klik YES atau Console klik NO?", 0, "Re-Loader By Mr.exe", 4 + 32) >> reloader.vbs
echo WScript.Echo intResult >> reloader.vbs

:: Jalankan VBScript dan simpan hasilnya ke variabel
for /f "delims=" %%i in ('cscript //nologo reloader.vbs') do set result=%%i

:: Hapus file VBScript sementara
del reloader.vbs

:: Cek tombol yang ditekan (6=Yes, 7=No)
if "%result%"=="6" (
    :: Jika Yes ditekan, buka aplikasi GUI
    start "" "%progutilDir%\ReloaderG.cmd"
) else (
    :: Jika No ditekan, buka aplikasi Console
    start "" "%progutilDir%\ReloaderC.cmd"
)
goto pilmen4

:swact
cls
mode 75,15
set "programswDir=%~dp0programs\tools"
title Solid Work Activator
echo [95m�������� ������� ���     ���������� ���    ��� ������� ������� ���  ���[0m
echo [95m������ͼ�����ͱ�����     �������ͱ�����    ��������ͱ������ͱ����� ��ɼ[0m
echo [95m�����������   ������     ������  ������ �� ������   ���������ɼ�����ɼ [0m
echo [95m����ͱ�����   ������     ������  ����������������   �������ͱ�����ͱ�� [0m
echo [95m��������ȱ�����ɼ�����������������ɼȱ��ɱ��ɼȱ�����ɼ���  ������  ���[0m
echo [95m������ͼ �����ͼ ������ͼ�ͼ�����ͼ  ��ͼ��ͼ  �����ͼ �ͼ  �ͼ�ͼ  �ͼ[0m
echo [93m ���͹[0m[95mMenu[0m[93m������������������������������ͻ[0m
echo [93m � [0m [96m 1. SolidWork Activator 2010-2013    [0m[93m�[0m
echo [93m � [0m [96m 2. SolidWork Activator 2010-2015    [0m[93m�[0m
echo [93m � [0m [96m 3. SolidWork Activator 2010-2016    [0m[93m�[0m
echo [93m � [0m [96m 0. Kembali [0m                         [93m�[0m
echo [93m ���������������������������������������ͼ[0m
echo  [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p pilihanact=" %BS% [97m  ���>[0m "
if "%pilihanact%"=="1" start "" "%programswDir%\SW2010-2013.Activator.SSQ.exe"
if "%pilihanact%"=="2" start "" "%programswDir%\SW2010-2015.Activator.GUI.SSQ.exe"
if "%pilihanact%"=="3" start "" "%programswDir%\SW2010-2016.Activator.GUI.SSQ.exe"
if "%pilihanact%"=="0" goto pilmen4
goto swact



:::::::::::::MS.OFFICE:::::::::::::
:pilmen5
cls
set "progoffDir=%~dp0programs\office"
set "progutilDir=%~dp0programs\utility"
mode 45,15
title Ms.OFFFICE
  echo [0;36;40m  �˻�ͻ     �ͻ�ͻ�ͻ��ͻ�ͻ [0m
echo [0;1;36;40m  ����ͻ     � �̹ ̹ ��  �� [0m
  echo [0;36;40m  � ��ͼ  o  �ͼ�  �  ��ͼ�ͼ [0m
echo [93m ���Ķ[0m[95mMenu[0m[93m�������������������������������Ŀ[0m
echo [93m �[0m[96m 1. Microsoft Office 2007               [0m[93m�[0m
echo [93m �[0m[96m 2. Microsoft Office 2010               [0m[93m�[0m
echo [93m �[0m[96m 3. Microsoft Office 2013               [0m[93m�[0m
echo [93m �[0m[96m 4. Microsoft Office 2016-2021          [0m[93m�[0m
echo [93m �[0m[96m 5. Ms.Office 2019 (Support Win7-Win11) [0m[93m�[0m
echo [93m �[0m[96m 6. Microsoft Office 2024               [0m[93m�[0m
echo [93m �[0m[96m 7. Uninstall Clean Office              [0m[93m�[0m
echo [93m �[0m[96m 0. kembali                             [0m[93m�[0m
echo [93m ������������������������������������������[0m
echo  [97m���[0m([92m %username%[0m@[95m%computername%[0m)
set /p pilihanofc="%BS% [97m ���>[0m "
if "%pilihanofc%"=="1" (
    start "" "%progoffDir%\2007\Serial.txt"
    start "" "%progoffDir%\2007\setup.exe"
)
if "%pilihanofc%"=="2" start "" "%progoffDir%\2010\AUTORUN.exe"
if "%pilihanofc%"=="3" start "" "%progoffDir%\2013\AUTORUN.exe"
if "%pilihanofc%"=="4" start "" "%progoffDir%\2016-2021\OInstall.exe"
if "%pilihanofc%"=="5" start "" "%progoffDir%\2019\AUTORUN.exe"
if "%pilihanofc%"=="6" start "" "%progoffDir%\2024\AUTORUN.exe"
if "%pilihanofc%"=="7" start "" "%progutilDir%\OfficeUninstall.cmd"
if "%pilihanofc%"=="0" goto menusi
goto pilmen5


::::::::::::::::::DRIVER:::::::::::::::::
:pilmen6
cls
title Driver Installer
mode 45,15
echo [95m ������  ������  �� ��    �� ������� ������  [0m
echo [95m ��   �� ��   �� �� ��    �� ��      ��   �� [0m
echo [95m ��   �� ������  �� ��    �� �����   ������  [0m
echo [95m ��   �� ��   �� ��  ��  ��  ��      ��   �� [0m
echo [95m ������  ��   �� ��   ����   ������� ��   �� [0m
echo [93m ���͹[0m[95mMenu[0m[93m������������������������������ͻ[0m
echo [93m � [0m [96m 1. Snappy Manual Install           [0m [93m� [0m
echo [93m � [0m [96m 2. Snappy Auto Install             [0m [93m� [0m
echo [93m � [0m [96m 3. Driver Pack Online              [0m [93m� [0m
echo [93m � [0m [96m 4. Doble Driver (Backup � Restore) [0m [93m� [0m
echo [93m � [0m [96m 0. Kembali                         [0m [93m� [0m
echo [93m ���������������������������������������ͼ[0m
echo  [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p pilihandriver=" %BS% [97m  ���>[0m "
if "%pilihandriver%"=="1" goto pildrev1
if "%pilihandriver%"=="2" goto pildrev2
if "%pilihandriver%"=="3" goto pildrev3
if "%pilihandriver%"=="4" goto pildrev4
if "%pilihandriver%"=="0" goto menusi
goto pilmen6

::::::::::::::MANUAL INSTALL DRIVER:::::::::::::::::
:pildrev1
cls
echo [46m Membuka Snappy Driver [0m
ping 127.0.0.1 -n 3 > nul
@echo off
rem 32-bit version of SDI works BOTH on 32-bit and 64-bit Windows.
rem 64-bit version of SDI works ONLY on 64-bit Windows.
rem EXECEPTION: 32-bit version of SDI cannot run on Windows PE x64.
rem 64-bit version is faster and doesn't have the 2GB RAM per process limitation.

title=Start Snappy Driver Installer

IF %PROCESSOR_ARCHITECTURE% == x86 (IF NOT DEFINED PROCESSOR_ARCHITEW6432 goto bit32)
goto bit64
:bit32
echo 32-bit
set xOS=R
goto cont
:bit64
echo 64-bit
set xOS=x64_R
:cont

for /f "tokens=*" %%a in ('dir /b /od "%~dp0\SnappyDriver\SDI_%xOS%*.exe"') do set "SDIEXE=%%a"
if exist "%~dp0\SnappyDriver\%SDIEXE%" (
 start "Snappy Driver Installer" /d"%~dp0\SnappyDriver" "%~dp0\SnappyDriver\%SDIEXE%" %1 %2 %3 %4 %5 %6 %7 %8 %9
 goto ex
) else (
 echo.
 echo  Not found 'Snappy Driver Installer'!
 echo.
 ping 127.0.0.1 -n 3 > nul
 goto menusi
)
:ex
rem Tambahkan perintah untuk install Driver di sini
goto pilmen6



:::::::::::::: AUTOMATIC INSTALL MISSING DRIVERS :::::::::::::::::::::
:pildrev_auto
cls
echo Membuka Snappy Driver Installer untuk menginstal driver yang belum terpasang...
ping 127.0.0.1 -n 3 > nul

:: Deteksi arsitektur sistem
title Start Snappy Driver Installer (Silent Mode)
IF %PROCESSOR_ARCHITECTURE% == x86 (IF NOT DEFINED PROCESSOR_ARCHITEW6432 goto bit32_auto)
goto bit64_auto
:bit32_auto
echo 32-bit
set xOS=R
goto cont_auto
:bit64_auto
echo 64-bit
set xOS=x64_R
:cont_auto

:: Menjalankan Snappy Driver Installer versi yang sesuai untuk instalasi otomatis "Driver Belum Terpasang"
for /f "tokens=*" %%a in ('dir /b /od "%~dp0\SnappyDriver\SDI_%xOS%*.exe"') do set "SDIEXE=%%a"
if exist "%~dp0\SnappyDriver\%SDIEXE%" (
    echo Menjalankan instalasi otomatis dengan: %SDIEXE%
    start "" /d"%~dp0\SnappyDriver" "%~dp0\SnappyDriver\%SDIEXE%" /autoinstall /autoclose /noupdates /nokernel /silent /log
    if "%errorlevel%"=="0" (
        echo Driver yang belum terpasang berhasil diinstal. Restart sistem secara manual jika diperlukan.
    ) else (
        echo Gagal menginstal driver.
    )
    goto :pilmen6
) else (
    echo.
    echo Snappy Driver Installer tidak ditemukan!
    echo.
    timeout 6
)
goto pilmen6


:pildrev3
set "progutilDir=%~dp0programs\utility"
start "" "%progutilDir%\DriverPackOnline.cmd"
goto pilmen6


:pildrev4
set "progutilDir=%~dp0programs\utility"
start "" "%progutilDir%\DoubleDriver.cmd"
goto pilmen6


:::::::::::::::NETWORK::::::::::::
:pilmen7
mode 60,13
cls
title NETWORK - SPEED INSTALLv3 ULTIMATE
  echo [0;36;40m               ɻ��ͻ�˻� ��ͻ�ͻ��� [0m
echo [0;1;36;40m               �����  � ���� ��˼�ʻ [0m
  echo [0;36;40m               �ȼ�ͼ � �ʼ�ͼ���� � [0m
echo [93m ���͹[0m[95mMenu[0m[93m������������������������������������������ͻ [0m
echo [93m �[0m[96m[1] Cek IP      [5] Netstat             [9] FAB[0m[93m    � [0m
echo [93m �[0m[96m[2] Telnet      [6] Tracert             [i] Info[0m[93m   � [0m
echo [93m �[0m[96m[3] Net Config  [7] Netsh                      [0m[93m    � [0m
echo [93m �[0m[96m[4] Buka Drive  [8] Jalankan Aplikasi   [0] Kembali[0m[93m� [0m
echo [93m ���������������������������������������������������ͼ[0m
echo  [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p pl=" %BS% [97m  ���>[0m "
if %pl%==1 goto ip
if %pl%==4 goto drive
if %pl%==2 goto tlnet
if %pl%==3 goto netview
if %pl%==5 goto netstat
if %pl%==6 goto Tracert
if %pl%==7 goto Netsh
if %pl%==8 goto aplikasi
if %pl%==9 goto fabfire
if %pl%==i goto inets
if %pl%==0 goto menusi
goto pilmen7

:ip
mode 60,22
title Menu Chek IP
cls
echo                   Chek IP
echo                _----------_,
echo              ,'__         _-:, 
echo             /    ''--_--''...:\
echo            /         �.........\
echo           /          �..........\
echo          /,         _'_........./:
echo          ! -,    _-"   "-_... ,;;:
echo          \   -_-"         "-_/;;;;
echo           \   \             /;;;;
echo            \   \           /;;;;
echo             '.  \         /;;;'
echo               '-_\_______/;;'
echo.
echo [93m ���͹[0m[95mMenu[0m[93m��������������������������������������������ͻ [0m
echo [93m �[0m[96m[1] Cek IP local [2] Cek IP komputer Lain [0].Kembali[0m[93m� [0m
echo [93m �[0m[96m[3] Add IP       [4] Hapus IP                        [0m[93m� [0m
echo [93m �����������������������������������������������������ͼ[0m
echo  [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p ipc=" %BS% [97m  ���>[0m
if %ipc%==1 goto ip1
if %ipc%==2 goto ip2
if %ipc%==3 goto ip3
if %ipc%==4 goto ip4
if %ipc%==0 goto pilmen7
goto ip

:ip1
cls
ipconfig
arp -a
pause
goto ip

:ip2
cls
set /p ip2=" %BS% [97m Masukan IP Tujuan���>[0m
echo.
echo IP yang anda Ping: %ip2%
echo.
echo ===============================================
echo Hasil:
ping %ip2%
pause
goto ip

:ip3
cls
echo.
set/p ip=Masukan IP       :
set/p subnet=Masukan Net Mask :
echo.
echo Hasil Perubahan IP :
echo ==================================================
netsh int ip add address "Local Area Connection" %ip% %subnet%
netsh int ip show address
echo.
pause
goto ip

:ip4
cls
echo.
set/p ip=Masukan IP yang akan dihapus :
netsh interface ip delete address "Local Area Connection" addr=%ip% gateway=all
echo.
pause
goto ip

:Drive
cls
set/p drive=Masukan Drive Yang akan dibuka!:
%drive%:
dir
pause
cls
goto pilmen7

:tlnet
echo Masukan IP yang akan di hubungi beserta portnya!
echo Misal: -> 192.168.16.20 80
set/p "tnet=Input IP :"
telnet %tnet%
pause
goto pilmen7

:netview
echo Masukan Option !:[View], [user], [computer], [share],[account],[config],[Start],dll
set/p "opt=Option:"
net %opt%
pause
goto pilmen7

:netstat
echo Masukan Option eg: NETSTAT [-a] [-b] [-e] [-n] [-o] [-p proto] [-r] [-s] [-v] [interval]
set/p "ip=IP     : "
set/p "opt=Option : "
netstat %opt% %ip%
pause
goto pilmen7

:Tracert
echo masukan Option : [-d , -h maximum, -j host-list, -w timeout ]
echo.
echo -------------------------------------------------------
set/p "ip=IP      :"
set/p "opt=Option  :"
tracert %opt% %ip%
pause
goto pilmen7

:netsh
echo Masukan Option: add, bridge, delete, diag , dump, winsock,
echo                 firewall, help, interface, ras, routing, set, show,exec
echo.
echo -------------------------------------------------------
netsh
pause
goto pilmen7

:aplikasi
echo Ketikan Aplikasi yang akan anda jalankan! Misal :cmd.exe
echo.
set/p "input=Jalankan :"
start %input%
pause
goto pilmen7

:inets
mode 40,30
cls
title Informasi Tentang Jaringan Anda
@echo off
echo Menampilkan Informasi Jaringan...

:: Menampilkan IP Address
echo IP Address:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4"') do echo %%a
echo.

:: Menampilkan MAC Address
echo MAC Address:
for /f "tokens=2 delims=:" %%a in ('ipconfig /all ^| find "Physical"') do echo %%a
echo.

:: Memeriksa apakah komputer terhubung ke internet
echo Status Koneksi Internet:
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo Tidak Terhubung ke Internet
) else (
    echo Terhubung ke Internet
)
echo.

:: Menampilkan jenis koneksi (Wi-Fi atau LAN)
echo Jenis Koneksi:
netsh interface show interface | findstr /i "Wi-Fi" >nul
if %errorlevel%==0 (
    echo Terhubung ke Wi-Fi
) else (
    echo Terhubung ke LAN
)
echo.
pause
goto pilmen7



::::::UTILITES::::::::::::::::
:pilmen8
mode 38,20
title UTILITES - SPEED INSTALLv3 ULTIMATE
set "progutilDir=%~dp0programs\utility"
cls
  echo  [0;36;40m � �  �˻  �  �    �  �˻  �ͻ  �ͻ [0m
echo  [0;1;36;40m � �   �   �  �    �   �   ��   �ͻ [0m
  echo  [0;36;40m �ͼ   �   �  �ͼ  �   �   �ͼ  �ͼ [0m
echo  [93m��Ĺ[0m[95mMenu[0m[93m��������������������������Ŀ[0m
echo  [93m�[0m[96m1. Ganti Waktu                    [0m[93m�[0m
echo  [93m�[0m[96m2. Install Microsoft Store Online [0m[93m�[0m
echo  [93m�[0m[96m3. Print Spoiler                  [0m[93m�[0m
echo  [93m�[0m[96m4. De-CMOS                        [0m[93m�[0m
echo  [93m�[0m[96m5. Reset Settingan Network        [0m[93m�[0m 
echo  [93m�[0m[96m6. Battery Info View              [0m[93m�[0m
echo  [93m�[0m[96m7. HardDisk Sentinel              [0m[93m�[0m
echo  [93m�[0m[96m8. Battery Monitor                [0m[93m�[0m
echo  [93m�[0m[96m9. Disk Getor Data Recovery       [0m[93m�[0m
echo  [93m�[0m[96m10.CCleaner                       [0m[93m�[0m
echo  [93m�[0m[96m11.Keyboard Tester                [0m[93m�[0m
echo  [93m�[0m[96m12.CPU-Z                          [0m[93m�[0m
echo  [93m�[0m[96m13.HardWare Info                  [0m[93m�[0m
echo  [93m�[0m[96m0. Kembali                        [0m[93m�[0m
echo  [93m������������������������������������ [0m
echo   [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p pilihanuti=" %BS%  [97m   ���>[0m "
if "%pilihanuti%"=="1" goto meu1
if "%pilihanuti%"=="2" start "" "%progutilDir%\MsStore.cmd"
if "%pilihanuti%"=="3" start "" "%progutilDir%\PrintSpoiller.bat"
if "%pilihanuti%"=="4" start "" "%progutilDir%\DeCMOS.cmd"
if "%pilihanuti%"=="5" goto meu5
if "%pilihanuti%"=="6" start "" "%progutilDir%\BatteryInfoView.cmd"
if "%pilihanuti%"=="7" start "" "%progutilDir%\HDSentinel.cmd"
if "%pilihanuti%"=="8" start "" "%progutilDir%\BatteryMon.cmd"
if "%pilihanuti%"=="9" start "" "%progutilDir%\DiskgetorDataRecovery.cmd"
if "%pilihanuti%"=="10" start "" "%progutilDir%\CCleaner.cmd"
if "%pilihanuti%"=="11" start "" "%progutilDir%\KeyboardTester.cmd"
if "%pilihanuti%"=="12" start "" "%progutilDir%\CPUZ.cmd"
if "%pilihanuti%"=="13" start "" "%progutilDir%\HWiNFO.cmd"
if "%pilihanuti%"=="0" goto menusi
goto pilmen8

:::::::::::::::::TIME ZONE:::::::::
:meu1
cls
@echo off
title Time Zone Changer
echo Pilih zona waktu yang diinginkan:
echo 1. WIB - Jakarta (UTC+07:00)
echo 2. Bangkok, Hanoi (UTC+07:00)
echo 3. Krasnoyarsk (UTC+07:00)
echo 4. WITA - Bali, Makassar (UTC+08:00)
echo 5. China Standard Time - Beijing (UTC+08:00)
echo 6. WIT - Ambon, Papua (UTC+09:00)
echo 7. Tokyo (UTC+09:00)
echo 8. UTC (UTC+00:00)
echo 9. Eastern Time (US - Canada) (UTC-05:00)
echo 10. Pacific Time (US - Canada) (UTC-08:00)
echo 11. GANTI WAKTU YANG DI INGINKAN
echo 0. Kembali
echo Masukkan pilihan Anda(0-11)
echo   [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p zone=" %BS%  [97m   ���>[0m "

if "%zone%"=="0" (
    goto pilmen8
) else if "%zone%"=="1" (
    tzutil /s "SE Asia Standard Time"
    echo Zona waktu telah diubah ke WIB - Jakarta (UTC+07:00)
    pause
    goto :meu1
) else if "%zone%"=="2" (
    tzutil /s "SE Asia Standard Time"
    echo Zona waktu telah diubah ke Bangkok, Hanoi (UTC+07:00)
    pause
    goto :meu1
) else if "%zone%"=="3" (
    tzutil /s "North Asia Standard Time"
    echo Zona waktu telah diubah ke Krasnoyarsk (UTC+07:00)
    pause
    goto :meu1
) else if "%zone%"=="4" (
    tzutil /s "Singapore Standard Time"
    echo Zona waktu telah diubah ke WITA - Bali, Makassar (UTC+08:00)
    pause
    goto :meu1
) else if "%zone%"=="5" (
    tzutil /s "China Standard Time"
    echo Zona waktu telah diubah ke China Standard Time - Beijing (UTC+08:00)
    pause
    goto :meu1
) else if "%zone%"=="6" (
    tzutil /s "Tokyo Standard Time"
    echo Zona waktu telah diubah ke WIT - Ambon, Papua (UTC+09:00)
    pause
    goto :meu1
) else if "%zone%"=="7" (
    tzutil /s "Tokyo Standard Time"
    echo Zona waktu telah diubah ke Tokyo (UTC+09:00)
    pause
    goto :meu1
) else if "%zone%"=="8" (
    tzutil /s "UTC"
    echo Zona waktu telah diubah ke UTC (UTC+00:00)
    pause
    goto :meu1
) else if "%zone%"=="9" (
    tzutil /s "Eastern Standard Time"
    echo Zona waktu telah diubah ke Eastern Time (US & Canada) (UTC-05:00)
    pause
    goto :meu1
) else if "%zone%"=="10" (
    tzutil /s "Pacific Standard Time"
    echo Zona waktu telah diubah ke Pacific Time (US & Canada) (UTC-08:00)
    goto :eof
) else if "%zone%"=="11" (
    set /p time="Masukkan waktu baru (HH:MM:SS): "
    time %time%
    echo Waktu berhasil diubah.
    pause
    goto :meu1
) else (
    echo Pilihan tidak valid.
    pause
    goto :meu1
)

pause
goto meu1



:::::::RESET NETWORK:::::::::::::
:meu5
cls
title ResetNet
@echo off
echo Resetting network settings...

echo Flushing DNS...
ipconfig /flushdns

echo Releasing IP address...
ipconfig /release

echo Renewing IP address...
ipconfig /renew

echo Resetting Winsock...
netsh winsock reset

echo Resetting IP stack...
netsh int ip reset

echo Resetting IPv4 TCP/IP stack...
netsh int ipv4 reset

echo Resetting IPv6 TCP/IP stack...
netsh int ipv6 reset

echo Resetting the network adapter...
netsh interface set interface name="Wi-Fi" admin=disable
netsh interface set interface name="Wi-Fi" admin=enable

echo Network settings reset complete.
ping 127.0.0.1 -n 3 > nul
goto pilmen8

::::::::::::::GAMING MOMDE::::::::::::::::::::
:pilmen9
title GAMING MODE For W10 - SPEED INSTALLv3 ULTIMATE
mode 120,35
cls
echo [96m                                         �ͻ�ͻ�˻�ɻ��ͻ  �˻�ͻ�˻�ͻ [0m
echo [96m                                         � ��͹�������� �  ���� � ����  [0m
echo [96m                                         �ͼ� �� �ʼȼ�ͼ  � ��ͼ�ʼ�ͼ [0m
echo [1;91m                                           Tweaking for Gaming / Etc [0m
echo [97m ��������������������������������������������������������������������������������������������������������������������Ŀ [0m
echo [97m � 1 � HPET (High Precision Event Timer)                                                                              � [0m
echo [97m ��������������������������������������������������������������������������������������������������������������������Ĵ [0m
echo [97m � 2 � Disable System Visual Effects (For Performance)                                                                � [0m
echo [97m � 3 � Restore Default Visual Effects                                                                                 � [0m
echo [97m ��������������������������������������������������������������������������������������������������������������������Ĵ [0m
echo [97m � 4 � Disable Unnecessary Services (Boost Performance)                                                               � [0m
echo [97m � 5 � Restore Default Services                                                                                       � [0m
echo [97m ��������������������������������������������������������������������������������������������������������������������Ĵ [0m
echo [97m � 0 � Kembali                                                                                                        � [0m
echo [97m ���������������������������������������������������������������������������������������������������������������������� [0m
echo  [97m ���[0m([92m%username%[0m@[95m%computername%[0m)
set /p firstindex=" %BS% [97m  ���>[0m "
if "%firstindex%"=="1" goto HPET
if "%firstindex%"=="2" goto DisableEffects
if "%firstindex%"=="3" goto EnableEffects
if "%firstindex%"=="4" goto DisableServices
if "%firstindex%"=="5" goto EnableServices
if "%firstindex%"=="0" goto menusi
goto pilmen9

:HPET
cls
echo Disabling HPET...
bcdedit /set useplatformclock false
timeout /t 2 >nul
goto pilmen9

:DisableEffects
cls
echo Disabling Visual Effects for better performance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
timeout /t 2 >nul
goto pilmen9

:EnableEffects
cls
echo Restoring Default Visual Effects...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /f
timeout /t 2 >nul
goto pilmen9

:DisableServices
cls
echo Disabling Unnecessary Services for better performance...
sc config "SysMain" start= disabled
sc config "DiagTrack" start= disabled
sc config "WSearch" start= disabled
timeout /t 2 >nul
goto pilmen9

:EnableServices
cls
echo Restoring Default Services...
sc config "SysMain" start= auto
sc config "DiagTrack" start= auto
sc config "WSearch" start= auto
timeout /t 2 >nul
goto pilmen9



:::::::::::::::::ABOUT ME:::::::::::::::::
:pilmen10
mode 70,15
cls
title ABOUT ME-SPEED INSTALLv3 ULTIMATE
echo [95m  ����ۻ �����ۻ  �����ۻ �ۻ   �ۻ�������ۻ    ��ۻ   ��ۻ������ۻ [0m
echo [95m ������ۻ������ۻ�������ۻ�ۺ   �ۺ�������ͼ    ���ۻ ���ۺ������ͼ [0m
echo [95m ������ۺ������ɼ�ۺ   �ۺ�ۺ   �ۺ   �ۺ       ���������ۺ����ۻ [0m
echo [95m ������ۺ������ۻ�ۺ   �ۺ�ۺ   �ۺ   �ۺ       �ۺ���ɼ�ۺ����ͼ [0m
echo [95m �ۺ  �ۺ������ɼ�������ɼ�������ɼ   �ۺ       �ۺ �ͼ �ۺ������ۻ [0m
echo [95m �ͼ  �ͼ�����ͼ  �����ͼ  �����ͼ    �ͼ       �ͼ     �ͼ������ͼ [0m
echo Create By                : Mr.exe
echo Follow Instagram         : @andrew.sianturi
echo Follow Fanspage Facebook : Andrew Malsar Sianturi
echo Website Official         : https://andrew-exe.blogspot.com/
echo GitHub                   : https://github.com/andrew7str
echo Traktir Makan/Minum XD   : https://saweria.co/andrewsianturi
echo Traktir Makan/Minum XD   : https://saweria.co/speedinstall
pause /b
goto menusi




::::::::::::::::::::::RANDOM LOGO:::::::::::::::::

:Logo1
echo     .--.              .--.
echo    : /\ `. _......_ .` /\ :
echo     '.    `        `    .'
echo      /'   _        _   `\
echo     /     0}      {0     \
echo    �       /      \       �
echo    �     /'        `\     �
echo     \   � .  .==.  . �   /
echo      '._ \.' \__/ './ _.'
echo      /  ``'._-''-_.'``  \        
goto :eof

:Logo2
echo       __________
echo      / ___  ___ \
echo     / / @ \/ @ \ \
echo     \ \___/\___/ /\
echo      \____\/____/��
echo      /     /\\\\\//
echo     �     �\\\\\\
echo      \      \\\\\\
echo        \______/\\\\
echo         _��_��_             
goto :eof

:Logo3
echo     ��������� ���������
echo     ��������� ���������
echo     �       �
echo     �                 �
echo     �       �
echo     ��������� ���������
echo     �� ��         �� ��
goto :eof

:Logo4
echo       _____  
echo   �..�     \9
echo   (oo)_____/ 
echo      WW  WW
goto :eof

:Logo5
echo     .            ,
echo              .:/
echo     .      ,,///;,   ,;/
echo       .   o:::::::;;///
echo          z::::::::;;\\\
echo            ''\\\\\'" ';\
echo               ';\         
goto :eof

:Logo6
echo     ��������� /���������
echo     ��������� /���������
echo     �[1;91m    [0m[1;91m/   [0m�
echo     �[1;91m    [0m[1;91m/   [0m�
echo     ��������� /���������
echo     �� ��         �� ��
goto :eof







:: COLOR MODE ON FOR WINDOWS 7
:c
setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b
