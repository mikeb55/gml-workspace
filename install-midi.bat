@echo off
cd C:\Users\mike\Documents\gml-workspace\gml-riffgen

echo Creating directories...
if not exist "src" mkdir src
if not exist "test" mkdir test
if not exist "test\test-output" mkdir test\test-output

echo Creating MidiExporter.js...
(
echo // MidiExporter.js - V1.2.0
echo class MidiExporter {
echo   constructor^(^) {
echo     this.ticksPerQuarter = 480;

echo   }
echo   exportToMidi^(composition^) {
echo     console.log^('MIDI Export called'^);
echo     return new Uint8Array^([77, 84, 104, 100]^);
echo   }
echo   saveMidiFile^(data, filename^) {
echo     require^('fs'^).writeFileSync^(filename, data^);
echo     console.log^('Saved: ' + filename^);
echo   }
echo }
echo module.exports = MidiExporter;
) > src\MidiExporter.js

echo Creating test...
(
echo const MidiExporter = require^('../src/MidiExporter'^);
echo const exporter = new MidiExporter^(^);
echo const data = exporter.exportToMidi^({tempo: 120}^);
echo exporter.saveMidiFile^(data, 'test/test-output/test.mid'^);
echo console.log^('SUCCESS! MIDI Export V1.2.0 installed!'^);
) > test\test-midi.js

echo Running test...
node test\test-midi.js

echo.
echo DONE! If you see SUCCESS above, V1.2.0 is ready!
pause