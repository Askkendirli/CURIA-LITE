@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo Run Setup_Windows.cmd first.
  pause
  exit /b 1
)
set PYTHONUTF8=1
".venv\Scripts\python.exe" -m curia_lite %* test-keywords
if errorlevel 1 echo A keyword check failed. Details are in the data folder under diagnostics\keyword-check.json.
pause
