@echo off
setlocal EnableExtensions

cd /d "%~dp0"
title Publish Xing Zhou Zhi Shui

where git >nul 2>nul
if errorlevel 1 (
  echo ERROR: Git was not found. Please install Git or add it to PATH.
  goto :failed
)

git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 (
  echo ERROR: This file is not inside a Git repository.
  goto :failed
)

for /f "delims=" %%I in ('git branch --show-current') do set "CURRENT_BRANCH=%%I"
if /I not "%CURRENT_BRANCH%"=="main" (
  echo ERROR: Current branch is "%CURRENT_BRANCH%", but GitHub Pages deploys from "main".
  goto :failed
)

echo Staging saved changes...
git add --all
if errorlevel 1 goto :failed

git diff --cached --quiet
if not errorlevel 1 (
  echo.
  echo No saved changes were found. Nothing was published.
  goto :success
)

for /f "delims=" %%I in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set "PUBLISH_TIME=%%I"

echo Creating commit...
git commit -m "Update blog %PUBLISH_TIME%"
if errorlevel 1 goto :failed

echo Pushing to GitHub...
git push origin main
if errorlevel 1 goto :failed

echo.
echo Push completed successfully.
echo GitHub Actions is now building: https://github.com/mihouta/mihouta.github.io/actions
echo Blog: https://mihouta.github.io/

:success
echo.
pause
exit /b 0

:failed
echo.
echo Publish failed. Review the error above; your local files have not been deleted.
echo.
pause
exit /b 1
