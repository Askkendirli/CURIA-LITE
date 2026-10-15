@echo off
setlocal
cd /d "%~dp0"
set PYTHONUTF8=1
where py >nul 2>nul
if errorlevel 1 goto python_fallback
py -3.12 -c "import sys" >nul 2>nul
if not errorlevel 1 (py -3.12 scripts\bootstrap.py %* & goto finish)
py -3.13 -c "import sys" >nul 2>nul
if not errorlevel 1 (py -3.13 scripts\bootstrap.py %* & goto finish)
py -3.11 -c "import sys" >nul 2>nul
if not errorlevel 1 (py -3.11 scripts\bootstrap.py %* & goto finish)
:python_fallback
python scripts\bootstrap.py %*
:finish
set code=%errorlevel%
if not "%code%"=="0" echo Setup did not complete. The error above must be resolved before starting.
pause
exit /b %code%
