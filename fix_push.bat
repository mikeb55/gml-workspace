@echo off
echo ===========================================
echo FIXING GITHUB PUSH - GML-RIFFGEN V1.0.0
echo ===========================================

cd /d "C:\Users\mike\Documents\gml-workspace\gml-riffgen"

echo Current directory: %cd%
echo.

echo Checking files...
dir /b
echo.

echo Checking git status...
git status
echo.

echo Adding all files...
git add .

echo Creating clean commit...
git commit -m "GML-RiffGen V1.0.0 - Guitar riff generator with MusicXML export"

echo Checking what branch we're on...
git branch

echo Creating main branch if needed...
git branch -M main

echo Pushing to GitHub...
git push -u origin main

echo.
echo ===========================================
echo SHOULD BE FIXED NOW!
echo ===========================================
echo.
echo Check: https://github.com/mikeb55/gml-riffgen
echo.
pause