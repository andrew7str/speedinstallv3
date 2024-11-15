@echo off
pushd "%~dp0"
if exist %SystemRoot%\SysWOW64\wdscore.dll goto x64

:x86
if exist "%temp%\utility\Brave\setup.exe" goto a
7z.exe x -o"%temp%\utility\Brave" -y Files\Brave.Browser32x.1.64.122.7z
start "" /B /D"%temp%\utility\Brave" "setup.exe"
exit

:x64
if exist "%temp%\utility\Brave\setup.exe" goto a
7z.exe x -o"%temp%\utility\Brave" -y Files\Brave.Browser64x.1.64.122.7z
start "" /B /D"%temp%\utility\Brave" "setup.exe"
exit

:a
start "" /B /D"%temp%\utility\Brave" "setup.exe"
exit