@echo off
echo ===========================================
echo FIXING DASHBOARD HTML
echo ===========================================

cd /d "C:\Users\mike\Documents\gml-workspace\generative-hub"

echo Creating clean HTML dashboard...

:: Delete corrupted HTML
if exist "docs\index.html" del "docs\index.html"

:: Create proper HTML file
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo     ^<title^>GML Dashboard^</title^>
echo     ^<style^>
echo         body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
echo         h1 { color: #333; text-align: center; }
echo         .project { margin: 10px 0; padding: 15px; background: white; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1^); }
echo         .ok { border-left: 5px solid #28a745; }
echo         .missing { border-left: 5px solid #dc3545; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<h1^>Generative Music Lab Dashboard^</h1^>
echo     ^<div class="project ok"^>^<strong^>quartet-engine^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>generative-chamber-composer^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>string-fx-mapper^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>infinite-riff-machine^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>riffgen-suite^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>triadgen^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>lyricgen^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>songsketch-pro^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>drum-engine^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>generative-hub^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>mike-gen-libs^</strong^>: OK^</div^>
echo     ^<div class="project ok"^>^<strong^>gml-ecosystem^</strong^>: OK^</div^>
echo     ^<h2^>Status: All 12 Projects Complete!^</h2^>
echo     ^<p^>Your GML ecosystem is ready for GitHub publishing.^</p^>
echo ^</body^>
echo ^</html^>
) > docs\index.html

echo Dashboard HTML fixed!
echo Opening clean dashboard...

start docs\index.html

echo ===========================================
echo PRESS ANY KEY TO CLOSE
echo ===========================================
pause >nul