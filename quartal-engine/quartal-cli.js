/**
 * Quartal Engine CLI - Natural Language Interface
 * Accepts commands like "Generate a musicxml of the C major scale harmonised as quartals"
 */

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { generateMusicXML, parseCommand } = require('./quartal-cli-core');

/**
 * Generate a descriptive filename for the generated MusicXML
 * Format: {root}-{scale}-quartal-{stackType}-{bars}bars-{timestamp}.musicxml
 * Examples:
 *   - C-major-quartal-3note-7bars-fullscale-1234567890.musicxml
 *   - D-dorian-quartal-3note-4bars-1234567890.musicxml
 *   - F#-lydian-quartal-4note-1bars-1234567890.musicxml
 */
function generateFilename(params) {
  // Sanitize root note (replace # with sharp, b with flat for filename safety)
  const root = params.root.replace(/#/g, 'sharp').replace(/b/g, 'flat');
  
  // Get scale name
  const scale = params.scale;
  
  // Get stack type (3note or 4note)
  const stackType = params.stackType === '3-note' ? '3note' : '4note';
  
  // Get bar count
  const bars = params.bars;
  
  // Add "fullscale" indicator if it's a full 7-bar harmonization
  const fullscale = bars === 7 ? '-fullscale' : '';
  
  // Get timestamp for uniqueness
  const timestamp = Date.now();
  
  // Build filename - use lowercase .musicxml extension for compatibility with Sibelius, Guitar Pro 8, etc.
  const filename = `${root}-${scale}-quartal-${stackType}-${bars}bars${fullscale}-${timestamp}.musicxml`;
  
  return filename;
}

function saveMusicXML(xml, filename) {
  const outputDir = path.join(__dirname, 'output', 'generated');
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  const filepath = path.join(outputDir, filename);
  fs.writeFileSync(filepath, xml, 'utf8');
  return filepath;
}

// Interactive CLI
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function prompt() {
  rl.question('\nQuartal Engine> ', (command) => {
    if (command.toLowerCase().trim() === 'exit' || command.toLowerCase().trim() === 'quit') {
      console.log('\nGoodbye!');
      rl.close();
      return;
    }
    
    if (command.toLowerCase().trim() === 'help') {
      console.log(`
Commands:
  Generate a musicxml of [ROOT] [SCALE] scale harmonised as quartals
  Examples:
    - "Generate a musicxml of the C major scale harmonised as quartals"
    - "Generate D dorian quartals, 4 bars"
    - "Generate F# lydian 4-note stacks, 8 bars"
    - "help" - Show this help
    - "exit" - Quit
      `);
      prompt();
      return;
    }
    
    try {
      const params = parseCommand(command);
      console.log(`\nGenerating: ${params.root} ${params.scale}, ${params.stackType} stacks, ${params.bars} bar(s)...`);
      
      const xml = generateMusicXML(params);
      const filename = generateFilename(params);
      const filepath = saveMusicXML(xml, filename);
      
      console.log(`\n✅ MusicXML generated successfully!`);
      console.log(`📁 Saved to: ${filepath}`);
      console.log(`\nYou can open this file in Guitar Pro 8, Sibelius or any MusicXML-compatible software.`);
    } catch (error) {
      console.error(`\n❌ Error: ${error.message}`);
    }
    
    prompt();
  });
}

// Main
console.log(`
╔═══════════════════════════════════════════════════════╗
║     GML Quartal Harmonic Engine - CLI Interface      ║
╚═══════════════════════════════════════════════════════╝

Type your command or "help" for examples.
`);

prompt();
