@echo off
chcp 65001 >nul

title 图片转PDF工具


if "%~1"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0图片转PDF.ps1" -menu
    pause
    exit
)


powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0图片转PDF.ps1" %*

pause