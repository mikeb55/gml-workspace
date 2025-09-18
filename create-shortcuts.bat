echo Creating Windows shortcuts for mike-gen-libs...

REM Create Desktop shortcut
powershell "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\mike-gen-libs.lnk'); $Shortcut.TargetPath = '%CD%\mike-gen-libs'; $Shortcut.IconLocation = 'shell32.dll,3'; $Shortcut.Description = 'GML Universal Export System'; $Shortcut.Save()"

REM Create Start Menu shortcut to folder
powershell "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs.lnk'); $Shortcut.TargetPath = '%CD%\mike-gen-libs'; $Shortcut.IconLocation = 'shell32.dll,3'; $Shortcut.Description = 'GML Universal Export System'; $Shortcut.Save()"

REM Create VS Code launcher in Start Menu
echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs VS Code.bat"
echo cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs VS Code.bat"
echo code . >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs VS Code.bat"

REM Create Test Runner in Start Menu
echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs Test.bat"
echo cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs Test.bat"
echo node tests/test_export_system.js >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs Test.bat"
echo pause >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\mike-gen-libs Test.bat"

REM Pin to Quick Access (Windows 10/11)
powershell "$shell = New-Object -ComObject Shell.Application; $folder = $shell.Namespace('%CD%\mike-gen-libs'); $folder.Self.InvokeVerb('pintohome')"

REM Create a Quick Launch batch file
echo @echo off > "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo ======================================== >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo    MIKE-GEN-LIBS QUICK LAUNCHER >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo ======================================== >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo. >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo 1. Open Folder >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo 2. Open in VS Code >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo 3. Run Tests >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo 4. Open Git Bash Here >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo echo. >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo set /p choice="Enter choice (1-4): " >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo. >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo if "%%choice%%"=="1" explorer "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo if "%%choice%%"=="2" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" ^&^& code . >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo if "%%choice%%"=="3" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" ^&^& node tests/test_export_system.js ^&^& pause >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"
echo if "%%choice%%"=="4" cd /d "C:\Users\mike\Documents\gml-workspace\mike-gen-libs" ^&^& "C:\Program Files\Git\git-bash.exe" >> "C:\Users\mike\Documents\gml-workspace\OPEN-MIKE-GEN-LIBS.bat"

echo.
echo ========================================
echo SHORTCUTS CREATED:
echo ========================================
echo [Desktop] mike-gen-libs shortcut
echo [Start Menu] mike-gen-libs folder
echo [Start Menu] mike-gen-libs VS Code
echo [Start Menu] mike-gen-libs Test
echo [Quick Access] mike-gen-libs pinned
echo [Workspace] OPEN-MIKE-GEN-LIBS.bat launcher
echo ========================================
echo.
echo You can now:
echo 1. Type "mike-gen-libs" in Windows Start
echo 2. Click desktop shortcut
echo 3. Find in Quick Access
echo 4. Run OPEN-MIKE-GEN-LIBS.bat for menu
echo ========================================
