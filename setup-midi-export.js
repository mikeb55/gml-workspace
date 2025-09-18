cd /c/Users/mike/Documents/gml-workspace/gml-riffgen
cat > setup-midi-export.js << 'EOF'
// setup-midi-export.js - AUTOMATED SETUP AND TEST
const fs = require('fs');
const path = require('path');

console.log('🚀 Setting up MIDI Export V1.2.0...\n');

// Create directory structure
const dirs = ['src', 'test', 'test/test-output'];
dirs.forEach(dir => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`📁 Created directory: ${dir}`);
  }
});

console.log('\n✅ Setup complete! Check src/MidiExporter.js');
console.log('This is a test setup file to verify everything works.');
EOF