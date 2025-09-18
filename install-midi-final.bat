@echo off
cd C:\Users\mike\Documents\gml-workspace\gml-riffgen

echo Creating final-midi-fix.js...

(
echo const fs = require^('fs'^);
echo const path = require^('path'^);
echo.
echo // Ensure directories
echo ['src', 'test', 'test/test-output'].forEach^(dir =^> {
echo   if ^(!fs.existsSync^(path.join^(__dirname, dir^)^)^) {
echo     fs.mkdirSync^(path.join^(__dirname, dir^), { recursive: true }^);
echo   }
echo }^);
echo.
echo // Write MidiExporter
echo const code = `// MidiExporter.js
echo class MidiExporter {
echo   constructor^(^) { this.ticksPerQuarter = 480; }
echo   exportToMidi^(comp^) {
echo     const b = [];
echo     // MIDI header
echo     b.push^(0x4D,0x54,0x68,0x64,0,0,0,6,0,1,0,2^);
echo     b.push^(^(480^>^>8^)^&0xFF,480^&0xFF^);
echo     // Tempo track
echo     b.push^(0x4D,0x54,0x72,0x6B,0,0,0,14^);
echo     b.push^(0,0xFF,0x51,3,7,161,32^); // 120bpm
echo     b.push^(0,0xFF,0x58,4,4,2,24,8^); // 4/4
echo     b.push^(0,0xFF,0x2F,0^);
echo     // Note track
echo     b.push^(0x4D,0x54,0x72,0x6B,0,0,0,19^);
echo     b.push^(0,0xC0,40^); // Violin
echo     b.push^(0,0x90,60,80^); // C note on
echo     b.push^(0x83,0x60,0x80,60,0^); // Note off after 480 ticks
echo     b.push^(0,0xFF,0x2F,0^);
echo     return Buffer.from^(b^);
echo   }
echo   saveMidiFile^(data, filename^) {
echo     fs.writeFileSync^(filename, data^);
echo     console.log^('Saved: ' + filename^);
echo   }
echo }
echo module.exports = MidiExporter;
echo `;
echo.
echo fs.writeFileSync^('src/MidiExporter.js', code^);
echo console.log^('MidiExporter.js created'^);
echo.
echo // Test it
echo const MidiExporter = require^('./src/MidiExporter'^);
echo const exp = new MidiExporter^(^);
echo const midi = exp.exportToMidi^({}^);
echo exp.saveMidiFile^(midi, 'test/test-output/final.mid'^);
echo console.log^('SUCCESS! File size: ' + midi.length + ' bytes'^);
echo console.log^('Open test/test-output/final.mid in your DAW'^);
) > final-midi-fix.js

echo Running test...
node final-midi-fix.js

echo.
echo DONE! Check test\test-output\final.mid
pause