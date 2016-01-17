@echo off
pushd "%~dp0"
PowerShell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File .\install.ps1
popd
pause