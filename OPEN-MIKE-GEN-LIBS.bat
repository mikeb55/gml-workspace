@echo off 
echo ======================================== 
echo    MIKE-GEN-LIBS QUICK LAUNCHER 
echo ======================================== 
echo. 
echo 1. Open Folder 
echo 2. Open in VS Code 
echo 3. Run Tests 
echo 4. Open Git Bash Here 
echo. 
set /p choice="Enter choice (1-4): " 
 
if "%choice%"=="1" explorer "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" 
if "%choice%"=="2" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" && code . 
if "%choice%"=="3" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" && node tests/test_export_system.js && pause 
if "%choice%"=="4" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" && "C:\Program Files\Git\git-bash.exe" 
