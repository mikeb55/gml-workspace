@echo off
echo ===========================================
echo GML STATUS CHECK - SINGLE FILE
echo ===========================================
echo.

cd /d "C:\Users\mike\Documents\gml-workspace" 2>nul
if not exist "C:\Users\mike\Documents\gml-workspace" (
    mkdir "C:\Users\mike\Documents\gml-workspace"
    cd /d "C:\Users\mike\Documents\gml-workspace"
)

echo Current directory: %cd%
echo.

:: Check for Python
py --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python not installed. Opening Microsoft Store...
    start ms-windows-store://pdp/?ProductId=9NRWMJP3717K
    echo Install Python from the store, then run this again.
    pause
    exit /b 1
)

echo Python found. Running status check...
echo.

:: Check projects directly with batch commands
echo PROJECT STATUS:
set /a count=0

if exist "quartet-engine" (echo    OK  quartet-engine && set /a count+=1) else echo    --  quartet-engine
if exist "generative-chamber-composer" (echo    OK  generative-chamber-composer && set /a count+=1) else echo    --  generative-chamber-composer  
if exist "string-fx-mapper" (echo    OK  string-fx-mapper && set /a count+=1) else echo    --  string-fx-mapper
if exist "infinite-riff-machine" (echo    OK  infinite-riff-machine && set /a count+=1) else echo    --  infinite-riff-machine
if exist "riffgen-suite" (echo    OK  riffgen-suite && set /a count+=1) else echo    --  riffgen-suite
if exist "triadgen" (echo    OK  triadgen && set /a count+=1) else echo    --  triadgen
if exist "lyricgen" (echo    OK  lyricgen && set /a count+=1) else echo    --  lyricgen
if exist "songsketch-pro" (echo    OK  songsketch-pro && set /a count+=1) else echo    --  songsketch-pro
if exist "drum-engine" (echo    OK  drum-engine && set /a count+=1) else echo    --  drum-engine
if exist "generative-hub" (echo    OK  generative-hub && set /a count+=1) else echo    --  generative-hub
if exist "mike-gen-libs" (echo    OK  mike-gen-libs && set /a count+=1) else echo    --  mike-gen-libs  
if exist "gml-ecosystem" (echo    OK  gml-ecosystem && set /a count+=1) else echo    --  gml-ecosystem

echo.
echo SUMMARY: %count%/12 projects found
echo.

:: Check Generative Hub details
if not exist "generative-hub" (
    echo GENERATIVE HUB: Not found
    echo NEXT ACTION: Create generative-hub directory structure
    goto :next_steps
)

echo GENERATIVE HUB DETAILS:
if exist "generative-hub\docs\index.html" (echo    OK  Dashboard HTML) else echo    --  Dashboard HTML
if exist "generative-hub\hub\__init__.py" (echo    OK  Hub Python module) else echo    --  Hub Python module  
if exist "generative-hub\hub\build.py" (echo    OK  Build script) else echo    --  Build script
if exist "generative-hub\README.md" (echo    OK  Project README) else echo    --  Project README
if exist "generative-hub\Meta\MIGRATION_LOG.md" (echo    OK  Migration log) else echo    --  Migration log

:: Test hub build command
if exist "generative-hub\hub\build.py" (
    echo.
    echo Testing hub build command...
    cd generative-hub
    py -m hub.build >nul 2>&1
    if %errorlevel% == 0 (
        echo    OK  hub.build command works
    ) else (
        echo    --  hub.build command fails
    )
    cd ..
)

:next_steps
echo.
echo ===========================================
echo NEXT ACTIONS:
echo ===========================================

if %count% lss 12 (
    echo 1. Create missing project directories
    echo 2. Set up project structure for each missing project
)

if not exist "generative-hub" (
    echo 3. Create generative-hub directory: mkdir generative-hub
    echo 4. Set up hub structure with docs/, hub/, Meta/ folders
) else (
    if not exist "generative-hub\hub\build.py" (
        echo 3. Create hub\build.py script in generative-hub
        echo 4. Set up dashboard generation system
    ) else (
        echo 3. All projects ready for GitHub publishing
        echo 4. Run: python -m gml.publish --target mikeb55 --all-projects
    )
)

echo.
echo ===========================================  
echo PRESS ANY KEY TO CLOSE
echo ===========================================
pause >nul