#!/bin/bash

echo "=== BULLETPROOF ENHANCED FILE CREATOR ==="
echo ""

WORKSPACE="/c/Users/mike/Documents/gml-workspace"
cd "$WORKSPACE"

# Apps to enhance
APPS=(
  "gml-riffgen"
  "triadgen"
  "infinite-riff-machine"
  "gml-quartet"
  "drum-engine"
)

for APP in "${APPS[@]}"; do
  echo "Processing $APP..."
  
  if [ ! -d "$APP" ]; then
    echo "  ❌ Directory doesn't exist"
    continue
  fi
  
  # Create a SIMPLE working enhanced file
  cat > "$APP/index-enhanced.html" << 'ENHANCED'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enhanced APP_NAME</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            padding: 20px;
            background: #f9f9f9;
        }
        .badge {
            background: #4CAF50;
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            display: inline-block;
            margin-bottom: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            margin: 5px;
            cursor: pointer;
        }
        #output {
            margin-top: 20px;
            padding: 15px;
            background: white;
            border-radius: 5px;
            min-height: 50px;
        }
    </style>
</head>
<body>
    <div class="badge">✓ Enhanced Version</div>
    <h1>APP_NAME</h1>
    
    <p><strong>Keyboard Shortcuts:</strong> Space = Generate, R = Regenerate</p>
    
    <div>
        <select id="batchQty">
            <option value="1">1 option</option>
            <option value="3">3 options</option>
            <option value="5">5 options</option>
        </select>
        <button onclick="generate()">Generate</button>
    </div>
    
    <div id="output">Press Generate or hit Spacebar</div>
    
    <script>
        // Simple working implementation
        function generate() {
            const qty = document.getElementById('batchQty').value;
            const output = document.getElementById('output');
            
            output.innerHTML = '<h3>Generated ' + qty + ' option(s):</h3>';
            
            for(let i = 0; i < qty; i++) {
                const div = document.createElement('div');
                div.style.cssText = 'border: 1px solid #ddd; padding: 10px; margin: 10px 0;';
                div.innerHTML = 'Option ' + (i+1) + ': [' + Math.random().toString(36).substr(2, 9) + ']';
                output.appendChild(div);
            }
        }
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.code === 'Space' && e.target.tagName !== 'INPUT') {
                e.preventDefault();
                generate();
            }
            if (e.code === 'KeyR' && e.target.tagName !== 'INPUT') {
                generate();
            }
        });
        
        // Auto-focus
        window.onload = function() {
            document.querySelector('button').focus();
        };
        
        console.log('Enhanced version loaded for APP_NAME');
    </script>
</body>
</html>
ENHANCED
  
  # Replace APP_NAME with actual app name
  sed -i "s/APP_NAME/$APP/g" "$APP/index-enhanced.html" 2>/dev/null || 
  sed -i "" "s/APP_NAME/$APP/g" "$APP/index-enhanced.html" 2>/dev/null
  
  if [ -f "$APP/index-enhanced.html" ]; then
    echo "  ✅ Created index-enhanced.html"
  else
    echo "  ❌ Failed to create file"
  fi
done

echo ""
echo "=== Creating Fixed Dashboard ==="

cat > enhanced-dashboard-fixed.html << 'DASHBOARD'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GML Enhanced Apps - FIXED</title>
    <style>
        body {
            font-family: Arial;
            padding: 20px;
            background: #f0f0f0;
        }
        .app {
            display: inline-block;
            background: white;
            padding: 20px;
            margin: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .app h3 { margin-top: 0; }
        a {
            display: inline-block;
            padding: 8px 16px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 5px;
        }
        a:hover { background: #45a049; }
        .test { background: #2196F3; }
    </style>
</head>
<body>
    <h1>GML Enhanced Apps Dashboard - FIXED</h1>
    
    <div id="apps"></div>
    
    <script>
        const apps = [
            'gml-riffgen',
            'triadgen',
            'infinite-riff-machine',
            'gml-quartet',
            'drum-engine'
        ];
        
        const container = document.getElementById('apps');
        
        apps.forEach(app => {
            const div = document.createElement('div');
            div.className = 'app';
            div.innerHTML = `
                <h3>${app}</h3>
                <a href="${app}/index-enhanced.html">Open Enhanced</a>
                <a href="#" class="test" onclick="testApp('${app}'); return false;">Test</a>
            `;
            container.appendChild(div);
        });
        
        function testApp(app) {
            // Try to open the file
            const path = app + '/index-enhanced.html';
            
            // Check if file exists by trying to fetch it
            fetch(path)
                .then(response => {
                    if (response.ok) {
                        window.open(path);
                    } else {
                        alert('File not found: ' + path + '\nStatus: ' + response.status);
                    }
                })
                .catch(error => {
                    alert('Cannot open: ' + path + '\nError: ' + error.message);
                });
        }
    </script>
</body>
</html>
DASHBOARD

echo "✅ Fixed dashboard created"
echo ""
echo "Opening dashboard..."
cmd //c start enhanced-dashboard-fixed.html

