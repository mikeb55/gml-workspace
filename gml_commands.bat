@echo off
echo ===========================================
echo FIXING HUB BUILD SCRIPT
echo ===========================================

cd /d "C:\Users\mike\Documents\gml-workspace\generative-hub"

echo Creating clean hub/build.py...

:: Delete corrupted file
if exist "hub\build.py" del "hub\build.py"

:: Create clean Python file
echo import os > hub\build.py
echo from pathlib import Path >> hub\build.py
echo. >> hub\build.py
echo def build_dashboard(): >> hub\build.py
echo     print("Building GML Dashboard...") >> hub\build.py
echo     projects = [ >> hub\build.py
echo         "quartet-engine", "generative-chamber-composer", "string-fx-mapper", >> hub\build.py
echo         "infinite-riff-machine", "riffgen-suite", "triadgen", "lyricgen", >> hub\build.py
echo         "songsketch-pro", "drum-engine", "generative-hub", "mike-gen-libs", >> hub\build.py
echo         "gml-ecosystem" >> hub\build.py
echo     ] >> hub\build.py
echo     html = "^<!DOCTYPE html^>^<html^>^<head^>^<title^>GML Dashboard^</title^>^</head^>^<body^>^<h1^>GML Dashboard^</h1^>" >> hub\build.py
echo     for project in projects: >> hub\build.py
echo         status = "OK" if Path("../" + project).exists() else "MISSING" >> hub\build.py
echo         html += f"^<p^>{project}: {status}^</p^>" >> hub\build.py
echo     html += "^</body^>^</html^>" >> hub\build.py
echo     Path("docs/index.html").write_text(html) >> hub\build.py
echo     print("Dashboard created: docs/index.html") >> hub\build.py
echo. >> hub\build.py
echo if __name__ == "__main__": >> hub\build.py
echo     build_dashboard() >> hub\build.py

echo Testing the fixed build script...
py -m hub.build

if %errorlevel% == 0 (
    echo SUCCESS: Hub build now works!
    echo Dashboard created at: docs\index.html
) else (
    echo ERROR: Still not working
)

echo ===========================================
echo PRESS ANY KEY TO CLOSE
echo ===========================================
pause >nul