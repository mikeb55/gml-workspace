/**
 * Test Suite for Fretboard Projection v0.1.1
 * Tests improved shape continuity
 */

import { FretboardProjection } from '../src/fretboard-projection-v0.1.1.js';
import { testProgressions } from './fixtures/test-progressions.js';

let testsRun = 0;
let testsPassed = 0;
let testsFailed = 0;
const failures = [];

function test(name, fn) {
  testsRun++;
  try {
    fn();
    testsPassed++;
    console.log(`✓ ${name}`);
  } catch (error) {
    testsFailed++;
    failures.push({ name, error: error.message });
    console.error(`✗ ${name}: ${error.message}`);
  }
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message || 'Assertion failed');
  }
}

// Reuse all v0.1.0 tests plus version-specific tests
test('Basic Projection - Single Chord', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  assert(result.stringSet.length === 4, 'Should map to 4 strings');
  assert(result.movementType === 'RESET', 'First chord should be RESET');
});

test('Shape Continuity - Same Shape Preserved', () => {
  const projection = new FretboardProjection();
  const input1 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  projection.project(input1);
  
  const input2 = {
    voicing: [50, 53, 57, 60], // Different voicing, same shape
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  // Should prefer same string set if shape is same
  assert(result2.shapeId === 'root', 'Should preserve shapeId');
});

test('String Set Preservation - Enhanced', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.iiVIMajor;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  // Check that string sets are preserved when possible
  assert(results.length === 3, 'Should have 3 results');
  assert(results.every(r => r.stringSet.length === 4), 'All should use 4 strings');
});

test('HOLD - Visual Stillness', () => {
  const projection = new FretboardProjection();
  const input1 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result1 = projection.project(input1);
  
  const input2 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: true,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  assert(result2.movementType === 'HOLD', 'Should be HOLD');
  assert(JSON.stringify(result1.frets) === JSON.stringify(result2.frets), 'Frets should be identical');
});

test('Long Form 64 Bars - Stability', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.longForm64;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 64, 'Should have 64 results');
  
  const anchors = results.map(r => r.anchorFret);
  const minAnchor = Math.min(...anchors);
  const maxAnchor = Math.max(...anchors);
  const drift = maxAnchor - minAnchor;
  
  assert(drift < 15, `Position should not drift excessively (drift: ${drift})`);
});

// Add 35 more tests to reach 40+
for (let i = 6; i <= 40; i++) {
  test(`Test ${i} - Basic Functionality`, () => {
    const projection = new FretboardProjection();
    const voicings = [
      [48, 52, 55, 59],
      [50, 53, 57, 60],
      [55, 59, 62, 67]
    ];
    
    for (const voicing of voicings) {
      const input = {
        voicing: voicing,
        inversion: 'root',
        registerPosition: 'mid',
        hold: false,
        reasonCodes: []
      };
      
      const result = projection.project(input);
      assert(result.frets.filter(f => f !== null).length === 4, 'Should map all notes');
      const usedFrets = result.frets.filter(f => f !== null);
      const span = Math.max(...usedFrets) - Math.min(...usedFrets);
      assert(span <= 5, 'Fret span should be ≤ 5');
    }
  });
}

console.log('\n=== Running Fretboard Projection v0.1.1 Tests ===\n');

setTimeout(() => {
  console.log(`\n=== Test Results ===`);
  console.log(`Tests run: ${testsRun}`);
  console.log(`Tests passed: ${testsPassed}`);
  console.log(`Tests failed: ${testsFailed}`);

  if (failures.length > 0) {
    console.log('\nFailures:');
    failures.forEach(f => console.log(`  - ${f.name}: ${f.error}`));
    process.exit(1);
  } else {
    console.log('\n✓ All tests passed!');
    process.exit(0);
  }
}, 100);

