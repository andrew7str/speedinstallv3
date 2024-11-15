@echo off
pushd "%~dp0"
if exist "%temp%\utility\idmsetup\idman642build21.exe" goto a
7z.exe x -o"%temp%\utility\idmsetup" -y Files\idman642build21.7z
start "" /D"%temp%\utility\idmsetup" "idman642build21.exe"
exit
:a
start "" /D"%temp%\utility\idmsetup" "idman642build21.exe"
exit