@echo off
setlocal EnableExtensions

cd /d "%~dp0"
chcp 65001 >nul
title Create New Blog Post

echo.
set "POST_NAME="
set /p "POST_NAME=Markdown file name (the .md extension is optional): "

if not defined POST_NAME (
  echo.
  echo ERROR: The file name cannot be empty.
  goto :failed
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\new-post.ps1" -Name "%POST_NAME%"
if errorlevel 1 goto :failed

echo.
echo Done. You can start writing now.
echo.
pause
exit /b 0

:failed
echo.
echo Creation failed. No existing post was overwritten.
echo.
pause
exit /b 1
