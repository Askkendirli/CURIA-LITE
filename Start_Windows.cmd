@echo off
setlocal
cd /d "%~dp0"
set PYTHONUTF8=1
if not exist ".venv\Scripts\python.exe" (
  echo Run Setup_Windows.cmd to create the application environment.
  pause
  exit /b 2
)
".venv\Scripts\python.exe" -m curia_lite %*
set code=%errorlevel%
if not "%code%"=="0" pause
exit /b %code%
