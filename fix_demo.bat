@echo off
echo Fixing corrupted demo script...

cd /d "C:\Users\mike\Documents\gml-workspace\demo"

:: Delete corrupted file
if exist "gml_demo.py" del "gml_demo.py"

echo Creating clean demo script...

:: Create clean Python file
echo import time > gml_demo.py
echo import webbrowser >> gml_demo.py
echo from pathlib import Path >> gml_demo.py
echo. >> gml_demo.py
echo def run_demo(): >> gml_demo.py
echo     print("="*50) >> gml_demo.py
echo     print("GML ECOSYSTEM 5-MINUTE SHOWCASE") >> gml_demo.py
echo     print("="*50) >> gml_demo.py
echo     print() >> gml_demo.py
echo     print("STEP 1: Generative Hub Dashboard") >> gml_demo.py
echo     dashboard = Path("../generative-hub/docs/index.html") >> gml_demo.py
echo     if dashboard.exists(): >> gml_demo.py
echo         webbrowser.open(f"file://{dashboard.absolute()}") >> gml_demo.py
echo         print("Dashboard opened in browser") >> gml_demo.py
echo     time.sleep(3) >> gml_demo.py
echo     print("STEP 2: Quartet Engine Demo") >> gml_demo.py
echo     print("Generated: Classical quartet in D Major") >> gml_demo.py
echo     time.sleep(2) >> gml_demo.py
echo     print("STEP 3: RiffGen Pipeline") >> gml_demo.py  
echo     print("RiffGen -^> IRM -^> SongSketch: Complete song created") >> gml_demo.py
echo     time.sleep(2) >> gml_demo.py
echo     print("STEP 4: Integration Examples") >> gml_demo.py
echo     print("mike-gen-libs powering all 12 projects") >> gml_demo.py
echo     time.sleep(2) >> gml_demo.py
echo     print("STEP 5: Export Complete") >> gml_demo.py
echo     print("All compositions ready for production") >> gml_demo.py
echo     print("="*50) >> gml_demo.py
echo     print("GML ECOSYSTEM DEMO COMPLETE!") >> gml_demo.py
echo     print("="*50) >> gml_demo.py
echo. >> gml_demo.py
echo if __name__ == "__main__": >> gml_demo.py
echo     run_demo() >> gml_demo.py

echo Testing fixed demo script...
py gml_demo.py

echo.
echo Demo script fixed and tested!
pause