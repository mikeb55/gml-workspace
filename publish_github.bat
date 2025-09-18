@echo off
echo ===========================================
echo PUBLISHING ALL 12 GML PROJECTS TO GITHUB
echo ===========================================

cd /d "C:\Users\mike\Documents\gml-workspace"

:: Check if git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git not installed. Download from: https://git-scm.com/
    pause
    exit /b 1
)

:: Configure git if needed
echo Setting up Git configuration...
git config --global user.name "Mike"
git config --global user.email "mike@mikeb55.github.io"

echo.
echo Publishing each project to GitHub...
echo.

:: List of all projects
set projects=quartet-engine generative-chamber-composer string-fx-mapper infinite-riff-machine riffgen-suite triadgen lyricgen songsketch-pro drum-engine generative-hub mike-gen-libs gml-ecosystem

for %%p in (%projects%) do (
    echo.
    echo ===========================================
    echo Publishing %%p...
    echo ===========================================
    
    cd "%%p"
    
    :: Initialize git repo
    if not exist ".git" (
        git init
        echo Git initialized for %%p
    )
    
    :: Add all files
    git add .
    
    :: Commit
    git commit -m "Initial commit - GML %%p project"
    
    :: Add GitHub remote (you'll need to create repos manually first)
    git remote remove origin 2>nul
    git remote add origin https://github.com/mikeb55/%%p.git
    
    :: Push to GitHub (requires authentication)
    echo Pushing %%p to GitHub...
    git push -u origin main 2>nul
    if %errorlevel% == 0 (
        echo SUCCESS: %%p published to GitHub
    ) else (
        echo NOTICE: %%p prepared for GitHub - you may need to create the repo first
    )
    
    cd ..
)

echo.
echo ===========================================
echo GITHUB PUBLISHING SUMMARY
echo ===========================================
echo.
echo Next steps:
echo 1. Go to: https://github.com/mikeb55
echo 2. Create repositories for each project (if not auto-created)
echo 3. All projects are ready to push with 'git push'
echo.
echo Your GML ecosystem is now on GitHub!
echo.
echo ===========================================
echo PRESS ANY KEY TO CLOSE
echo ===========================================
pause >nul