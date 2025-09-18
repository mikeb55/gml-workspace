@echo off
cd "C:\Users\mike\Documents\gml-workspace"

echo Checking for Python...

:: Try py command first (Windows Python Launcher)
py --version >nul 2>&1
if %errorlevel% == 0 (
    echo Found Python via 'py' command
    py check_status.py
    goto :end
)

:: Try python3 command
python3 --version >nul 2>&1
if %errorlevel% == 0 (
    echo Found Python via 'python3' command
    python3 check_status.py
    goto :end
)

:: Try python command
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo Found Python via 'python' command
    python check_status.py
    goto :end
)

:: No Python found - install it
echo Python not found. Opening Microsoft Store to install Python...
start ms-windows-store://pdp/?ProductId=9NRWMJP3717K
echo.
echo After installing Python from the store, run this batch file again.
echo Press any key to exit...
pause