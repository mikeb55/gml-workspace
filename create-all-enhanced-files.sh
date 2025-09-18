#!/bin/bash

echo "=== CREATING ALL ENHANCED FILES ==="
echo ""

WORKSPACE="/c/Users/mike/Documents/gml-workspace"
cd "$WORKSPACE"

# Create enhanced file for EACH app
APPS=(
  "triadgen"
  "gml-riffgen"
  "infinite-riff-machine"
  "gml-quartet"
  "drum-engine"
  "songsketch-pro"
  "generative-chamber-composer"
  "quintet-composer"
  "gml-ace"
)

for APP in "${APPS[@]}"; do
  echo "Creating $APP/index-enhanced.html..."
  
  # Create directory if it doesn't exist
  mkdir -p "$APP"
  
  # Create the actual enhanced HTML file
  cat > "$APP/index-enhanced.html" << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>APP_NAME Enhanced</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-top: 0;
        }
        .badge {
            display: inline-block;
            background: #4CAF50;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            margin-bottom: 20px;
        }
        .controls {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }
        button {
            padding: 12px 24px;
            font-size: 16px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }
        button:hover {
            background: #45a049;
        }
        select {
            padding: 10px;
            font-size: 16px;
            margin: 0 10px;
        }
        .output {
            margin-top: 20px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
            min-height: 100px;
        }
        .shortcut-help {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .result-item {
            background: white;
            border: 2px solid #ddd;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .result-item.selected {
            border-color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="badge">✨ ENHANCED VERSION</div>
        
        <h1>🎵 APP_NAME</h1>
        
        <div class="shortcut-help">
            <strong>Keyboard Shortcuts:</strong><br>
            • <kbd>Space</kbd> = Generate<br>
            • <kbd>R</kbd> = Regenerate<br>
            • <kbd>1-5</kbd> = Select quantity
        </div>
        
        <div class="controls">
            <label>Generate:</label>
            <select id="quantity">
                <option value="1">1 option</option>
                <option value="3">3 options</option>
                <option value="5">5 options</option>
                <option value="10">10 options</option>
            </select>
            <button id="generateBtn" onclick="generate()">Generate</button>
        </div>
        
        <div class="output" id="output">
            Ready to generate. Press Space or click Generate.
        </div>
    </div>
    
    <script>
        const APP_NAME = 'APP_NAME';
        
        function generate() {
            const qty = document.getElementById('quantity').value;
            const output = document.getElementById('output');
            
            output.innerHTML = '<h3>Generating ' + qty + ' options...</h3>';
            
            setTimeout(() => {
                output.innerHTML = '';
                for(let i = 0; i < qty; i++) {
                    const div = document.createElement('div');
                    div.className = 'result-item';
                    div.innerHTML = `
                        <h4>Option ${i + 1}</h4>
                        <p>Generated content for ${APP_NAME}</p>
                        <p>Random ID: ${Math.random().toString(36).substr(2, 9)}</p>
                        <button onclick="selectOption(${i})">Use This</button>
                    `;
                    output.appendChild(div);
                }
            }, 500);
        }
        
        function selectOption(index) {
            document.querySelectorAll('.result-item').forEach(el => {
                el.classList.remove('selected');
            });
            document.querySelectorAll('.result-item')[index].classList.add('selected');
            
            // Save to cross-app memory
            if (typeof localStorage !== 'undefined') {
                localStorage.setItem('gmlLastExport', JSON.stringify({
                    app: APP_NAME,
                    option: index,
                    timestamp: new Date().toISOString()
                }));
                alert('Option ' + (index + 1) + ' selected and saved to memory!');
            }
        }
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
            
            if (e.code === 'Space') {
                e.preventDefault();
                generate();
            } else if (e.code === 'KeyR') {
                generate();
            } else if (e.key >= '1' && e.key <= '5') {
                const values = [1, 3, 5, 10];
                const index = parseInt(e.key) - 1;
                if (index < values.length) {
                    document.getElementById('quantity').value = values[index];
                }
            }
        });
        
        // Auto-focus on load
        window.onload = function() {
            document.getElementById('generateBtn').focus();
            console.log(APP_NAME + ' Enhanced loaded successfully!');
        };
    </script>
</body>
</html>
HTML

  # Replace APP_NAME with actual app name
  sed -i "s/APP_NAME/$APP/g" "$APP/index-enhanced.html" 2>/dev/null
  
  # Verify file was created
  if [ -f "$APP/index-enhanced.html" ]; then
    echo "  ✅ Created successfully"
  else
    echo "  ❌ Failed to create"
  fi
done

echo ""
echo "=== All files created! ==="
echo ""
echo "Files created at:"
for APP in "${APPS[@]}"; do
  echo "  $WORKSPACE/$APP/index-enhanced.html"
done

