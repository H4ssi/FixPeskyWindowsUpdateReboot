@echo off
pushd "%~dp0"
PowerShell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File .\uninstall.ps1
popd
pause