@echo off
echo ===========================================
echo GML AUTO-SETUP - CREATING EVERYTHING
echo ===========================================
echo.

cd /d "C:\Users\mike\Documents\gml-workspace" 2>nul
if not exist "C:\Users\mike\Documents\gml-workspace" (
    echo Creating workspace directory...
    mkdir "C:\Users\mike\Documents\gml-workspace"
    cd /d "C:\Users\mike\Documents\gml-workspace"
)

echo Working in: %cd%
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

echo Creating all 12 GML projects...
echo.

:: Create all project directories
set projects=quartet-engine generative-chamber-composer string-fx-mapper infinite-riff-machine riffgen-suite triadgen lyricgen songsketch-pro drum-engine generative-hub mike-gen-libs gml-ecosystem

for %%p in (%projects%) do (
    if not exist "%%p" (
        echo Creating %%p...
        mkdir "%%p"
        echo # %%p > "%%p\README.md"
        echo Project created: %%p
    ) else (
        echo Already exists: %%p
    )
)

echo.
echo Setting up Generative Hub structure...

:: Create Generative Hub directories
if not exist "generative-hub\docs" mkdir "generative-hub\docs"
if not exist "generative-hub\hub" mkdir "generative-hub\hub" 
if not exist "generative-hub\Meta" mkdir "generative-hub\Meta"

:: Create hub/__init__.py
if not exist "generative-hub\hub\__init__.py" (
    echo # Generative Hub Module > "generative-hub\hub\__init__.py"
    echo Created: hub/__init__.py
)

:: Create hub/build.py
if not exist "generative-hub\hub\build.py" (
    (
    echo import os
    echo from pathlib import Path
    echo.
    echo def build_dashboard^(^):
    echo     """Build the GML dashboard"""
    echo     print^("Building GML Dashboard..."^)
    echo     
    echo     projects = [
    echo         "quartet-engine", "generative-chamber-composer", "string-fx-mapper",
    echo         "infinite-riff-machine", "riffgen-suite", "triadgen", "lyricgen",
    echo         "songsketch-pro", "drum-engine", "generative-hub", "mike-gen-libs", 
    echo         "gml-ecosystem"
    echo     ]
    echo     
    echo     html_content = """^<!DOCTYPE html^>
    echo ^<html^>
    echo ^<head^>
    echo     ^<title^>GML Dashboard^</title^>
    echo     ^<style^>
    echo         body { font-family: Arial, sans-serif; margin: 40px; }
    echo         .project { margin: 10px 0; padding: 10px; border: 1px solid #ddd; }
    echo         .status-ok { background: #d4edda; }
    echo         .status-missing { background: #f8d7da; }
    echo     ^</style^>
    echo ^</head^>
    echo ^<body^>
    echo     ^<h1^>Generative Music Lab Dashboard^</h1^>
    echo     ^<h2^>Project Status^</h2^>"""
    echo     
    echo     for project in projects:
    echo         project_path = Path^(".."^) / project
    echo         if project_path.exists^(^):
    echo             status = "OK"
    echo             css_class = "status-ok"
    echo         else:
    echo             status = "MISSING" 
    echo             css_class = "status-missing"
    echo         
    echo         html_content += f"""
    echo     ^<div class="project {css_class}"^>
    echo         ^<strong^>{project}^</strong^> - {status}
    echo     ^</div^>"""
    echo     
    echo     html_content += """
    echo ^</body^>
    echo ^</html^>"""
    echo     
    echo     # Write dashboard
    echo     dashboard_path = Path^("docs"^) / "index.html"
    echo     dashboard_path.write_text^(html_content^)
    echo     print^(f"Dashboard created: {dashboard_path}"^)
    echo.
    echo if __name__ == "__main__":
    echo     build_dashboard^(^)
    ) > "generative-hub\hub\build.py"
    echo Created: hub/build.py
)

:: Create docs/index.html
if not exist "generative-hub\docs\index.html" (
    cd generative-hub
    py -m hub.build
    cd ..
    echo Created: docs/index.html dashboard
)

:: Create Meta/MIGRATION_LOG.md
if not exist "generative-hub\Meta\MIGRATION_LOG.md" (
    (
    echo # GML Migration Log
    echo.
    echo ## %date% %time%
    echo - Auto-created all 12 GML project directories
    echo - Set up Generative Hub structure
    echo - Created initial dashboard
    echo - Ready for development
    ) > "generative-hub\Meta\MIGRATION_LOG.md"
    echo Created: Meta/MIGRATION_LOG.md
)

echo.
echo ===========================================
echo SETUP COMPLETE - ALL 12 PROJECTS READY!
echo ===========================================

:: Final status check
echo.
echo Final project status: 	
set /a count=0
for %%p in (%projects%) do (
    if exist "%%p" (
        echo    ✓ %%p 
        set /a count+=1
    ) else (
        echo    ✗ %%p
    )
)

echo.
echo SUCCESS: %count%/12 projects created
echo Generative Hub dashboard: generative-hub\docs\index.html
echo.
echo READY FOR: python -m gml.publish --target mikeb55 --all-projects
echo.
echo ===========================================
echo PRESS ANY KEY TO CLOSE  
echo ===========================================
pause >nul