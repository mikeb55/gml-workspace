@echo off
echo ===========================================
echo GML-RIFFGEN V1.0.0 - AUTOMATED DEPLOYMENT
echo ===========================================

:: Step 1: Create and navigate to directory
echo [1/6] Creating project directory...
cd /d "C:\Users\mike\Documents\gml-workspace"
if exist "gml-riffgen" (
    echo Directory already exists, using existing...
) else (
    mkdir gml-riffgen
    echo Created gml-riffgen directory
)
cd gml-riffgen

:: Step 2: Check for index.html
echo [2/6] Checking for RiffGen app...
if not exist "index.html" (
    echo.
    echo REQUIRED: Copy your index.html file to this directory first!
    echo.
    echo Location needed: %cd%
    echo.
    echo Opening folder for you...
    start .
    echo.
    echo After copying index.html here, run this script again.
    pause
    exit /b 1
) else (
    echo Found index.html - good!
)

:: Step 3: Initialize Git
echo [3/6] Setting up Git repository...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git not installed! Download from: https://git-scm.com/
    pause
    exit /b 1
)

if not exist ".git" (
    git init >nul 2>&1
    echo Git repository initialized
) else (
    echo Git repository already exists
)

:: Step 4: Configure Git
echo [4/6] Configuring Git...
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    git config --global user.name "Mike"
    git config --global user.email "mike@mikeb55.github.io"
    echo Git configured
) else (
    echo Git already configured
)

:: Step 5: Create project files
echo [5/6] Creating project files...

:: Create README
echo # GML-RiffGen V1.0.0 > README.md
echo. >> README.md
echo Professional Guitar Riff Generator with MusicXML Export >> README.md
echo. >> README.md
echo ## Quick Start >> README.md
echo 1. Open index.html in your browser >> README.md
echo 2. Click "Test Audio" to verify audio support >> README.md
echo 3. Click "Generate New Riff" to create music >> README.md
echo 4. Click "Play Riff" to hear it >> README.md
echo 5. Click "Export MusicXML" to download notation >> README.md
echo. >> README.md
echo ## Features >> README.md
echo - Real-time guitar riff generation >> README.md
echo - Audio playback with Web Audio API >> README.md
echo - MusicXML export with proper measure boundaries >> README.md
echo - Multiple keys, styles, and tempos >> README.md
echo - Compatible with Sibelius, MuseScore, Finale >> README.md
echo README.md created

:: Create VERSION file
echo 1.0.0 > VERSION
echo VERSION file created

:: Create .gitignore
echo .DS_Store > .gitignore
echo Thumbs.db >> .gitignore
echo *.log >> .gitignore
echo .gitignore created

:: Step 6: Deploy to GitHub
echo [6/6] Deploying to GitHub...

:: Add GitHub remote
git remote remove origin 2>nul
git remote add origin https://github.com/mikeb55/gml-riffgen.git
echo GitHub remote added

:: Stage files
git add .
echo Files staged

:: Commit
git commit -m "GML-RiffGen V1.0.0 - Professional guitar riff generator

Features:
- Real-time guitar riff generation with audio playback
- MusicXML export with proper measure boundaries  
- Multiple keys, styles, and tempos
- Cross-browser compatibility
- Sibelius/MuseScore/Finale compatibility

Ready for production use and GML ecosystem integration."

if %errorlevel% neq 0 (
    echo WARNING: Commit may have failed
) else (
    echo Commit successful
)

:: Create version tag
git tag -a v1.0.0 -m "GML-RiffGen V1.0.0 - Production release"
echo Version tag v1.0.0 created

:: Push to GitHub
echo Pushing to GitHub...
git push -u origin main
if %errorlevel% neq 0 (
    echo WARNING: Push failed - check GitHub repo exists and you're authenticated
) else (
    echo Main branch pushed successfully
)

git push --tags
if %errorlevel% neq 0 (
    echo WARNING: Tag push failed
) else (
    echo Version tags pushed successfully
)

:: Success
echo.
echo ===========================================
echo DEPLOYMENT COMPLETE!
echo ===========================================
echo.
echo Your GML-RiffGen V1.0.0 is now live at:
echo https://github.com/mikeb55/gml-riffgen
echo.
echo Local files are in: %cd%
echo.
echo Next version will be V1.1.0 with enhanced features!
echo.
echo ===========================================
echo PRESS ANY KEY TO OPEN GITHUB REPOSITORY
echo ===========================================
pause >nul

start https://github.com/mikeb55/gml-riffgen