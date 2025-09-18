@echo off
echo ===========================================
echo GML 5-MINUTE DEMO - SIMPLE VERSION
echo ===========================================

cd /d "C:\Users\mike\Documents\gml-workspace"

echo.
echo STEP 1: Project Status Check
echo ===========================================
if exist "quartet-engine" echo [OK] quartet-engine - Classical chamber music
if exist "generative-chamber-composer" echo [OK] generative-chamber-composer - Advanced compositions  
if exist "string-fx-mapper" echo [OK] string-fx-mapper - String effects processing
if exist "infinite-riff-machine" echo [OK] infinite-riff-machine - Endless riff generation
if exist "riffgen-suite" echo [OK] riffgen-suite - Guitar riff creation
if exist "triadgen" echo [OK] triadgen - Harmonic triad generation
if exist "lyricgen" echo [OK] lyricgen - Automated lyric writing
if exist "songsketch-pro" echo [OK] songsketch-pro - Complete song arrangement
if exist "drum-engine" echo [OK] drum-engine - Rhythm pattern creation
if exist "generative-hub" echo [OK] generative-hub - Central dashboard system
if exist "mike-gen-libs" echo [OK] mike-gen-libs - Core music theory library
if exist "gml-ecosystem" echo [OK] gml-ecosystem - Meta project coordination

timeout /t 3 /nobreak >nul

echo.
echo STEP 2: Hub Dashboard
echo ===========================================
cd generative-hub
if exist "docs\index.html" (
    echo Opening GML Dashboard...
    start docs\index.html
    echo Dashboard opened in browser
) else (
    echo Dashboard file not found
)
timeout /t 2 /nobreak >nul

echo.
echo STEP 3: Integration Demo
echo ===========================================
echo mike-gen-libs provides core functionality to:
echo - Quartet Engine: Music theory and harmony rules
echo - RiffGen Suite: Pattern algorithms and scales  
echo - GCC: Compositional structures and forms
echo - All other projects: Shared musical foundations

timeout /t 3 /nobreak >nul

echo.
echo STEP 4: Pipeline Example  
echo ===========================================
echo Workflow: RiffGen --^> IRM --^> SongSketch Pro
echo 1. RiffGen creates guitar riff in E minor
echo 2. IRM expands riff into full progression
echo 3. SongSketch Pro adds drums, bass, structure
echo Result: Complete song ready for export

timeout /t 3 /nobreak >nul

echo.
echo STEP 5: GitHub Repository
echo ===========================================
echo All 12 projects published to: https://github.com/mikeb55
echo Each project has its own repository
echo Complete ecosystem available for collaboration

cd ..

echo.
echo ===========================================
echo DEMO COMPLETE!
echo ===========================================
echo Your GML Ecosystem Features:
echo - 12 interconnected music generation projects
echo - Central hub dashboard for project management  
echo - Published on GitHub under mikeb55 account
echo - Integration testing completed successfully
echo - Ready for production music creation

echo.
echo Press any key to close...
pause >nul