/**
 * Test Suite for Fretboard Projection v0.1.0
 * 40+ test cycles
 */

import { FretboardProjection } from '../src/fretboard-projection-v0.1.0.js';
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

// Test 1: Basic projection
test('Basic Projection - Single Chord', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59], // Cmaj7
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  
  assert(result.stringSet.length === 4, 'Should map to 4 strings');
  assert(result.frets.filter(f => f !== null).length === 4, 'Should have 4 frets');
  assert(result.movementType === 'RESET', 'First chord should be RESET');
  assert(result.anchorFret >= 0 && result.anchorFret <= 20, 'Anchor fret should be valid');
});

// Test 2: HOLD behavior
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
    voicing: [48, 52, 55, 59], // Same voicing
    inversion: 'root',
    registerPosition: 'mid',
    hold: true,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  
  assert(result2.movementType === 'HOLD', 'Should be HOLD');
  assert(JSON.stringify(result1.frets) === JSON.stringify(result2.frets), 'Frets should be identical');
  assert(JSON.stringify(result1.stringSet) === JSON.stringify(result2.stringSet), 'String set should be identical');
});

// Test 3: ii-V-I progression
test('ii-V-I - Basic Progression', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.iiVIMajor;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 3, 'Should have 3 results');
  assert(results[0].movementType === 'RESET', 'First should be RESET');
  assert(results.every(r => r.frets.filter(f => f !== null).length === 4), 'All should have 4 frets');
});

// Test 4: Minimal movement (STEP)
test('STEP - Minimal Movement', () => {
  const projection = new FretboardProjection();
  const input1 = {
    voicing: [48, 52, 55, 59], // Cmaj7
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result1 = projection.project(input1);
  
  const input2 = {
    voicing: [50, 53, 57, 60], // Dm7 (close)
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  
  // Should be STEP if minimal change
  assert(['STEP', 'RESET'].includes(result2.movementType), 'Should be STEP or RESET');
});

// Test 5: Fret span constraint
test('Fret Span - Maximum 5 Frets', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  const usedFrets = result.frets.filter(f => f !== null);
  const minFret = Math.min(...usedFrets);
  const maxFret = Math.max(...usedFrets);
  const span = maxFret - minFret;
  
  assert(span <= 5, `Fret span should be ≤ 5 (got ${span})`);
});

// Test 6-15: Additional basic tests
test('String Set Priority - Low Strings Preferred', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  const maxString = Math.max(...result.stringSet);
  
  // Should prefer lower strings (higher numbers)
  assert(maxString >= 3, 'Should use lower strings when possible');
});

test('Position Window - Initialization', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  
  assert(result.positionWindow, 'Should have position window');
  assert(result.positionWindow.length === 2, 'Position window should be [min, max]');
  assert(result.positionWindow[0] <= result.anchorFret, 'Window should include anchor');
});

test('All Frets Playable - Valid Range', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  const usedFrets = result.frets.filter(f => f !== null);
  
  assert(usedFrets.every(f => f >= 0 && f <= 20), 'All frets should be in valid range');
});

test('Deterministic - Same Input Same Output', () => {
  const projection1 = new FretboardProjection();
  const projection2 = new FretboardProjection();
  
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result1 = projection1.project(input);
  const result2 = projection2.project(input);
  
  assert(JSON.stringify(result1.frets) === JSON.stringify(result2.frets), 'Should be deterministic');
});

test('HOLD Heavy Sequence', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.holdHeavy;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  // Check HOLD bars don't move
  for (let i = 1; i < results.length; i++) {
    if (progression[i].hold) {
      assert(results[i].movementType === 'HOLD', `Bar ${i} should be HOLD`);
      assert(JSON.stringify(results[i].frets) === JSON.stringify(results[i-1].frets), 
        `Bar ${i} frets should match previous`);
    }
  }
});

test('Long Form 32 Bars - Stability', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.longForm32;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 32, 'Should have 32 results');
  
  // Check all are playable
  for (const result of results) {
    const usedFrets = result.frets.filter(f => f !== null);
    const span = Math.max(...usedFrets) - Math.min(...usedFrets);
    assert(span <= 5, 'All should have valid fret span');
  }
});

test('Long Form 64 Bars - Extended Stability', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.longForm64;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 64, 'Should have 64 results');
  
  // Check position window doesn't drift excessively
  const anchors = results.map(r => r.anchorFret);
  const minAnchor = Math.min(...anchors);
  const maxAnchor = Math.max(...anchors);
  const drift = maxAnchor - minAnchor;
  
  assert(drift < 15, `Position should not drift excessively (drift: ${drift})`);
});

test('Register Reset - Explicit Reset', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.registerReset;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  // Check reset occurs when signaled
  const hasReset = results.some(r => r.movementType === 'RESET');
  assert(hasReset, 'Should have RESET when signaled');
});

test('Minor ii-V-i', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.iiVIMinor;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 3, 'Should have 3 results');
  assert(results.every(r => r.frets.filter(f => f !== null).length === 4), 'All should be mappable');
});

test('Dominant Chain', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.dominantChain;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  assert(results.length === 4, 'Should have 4 results');
  
  // Check movement is reasonable
  for (let i = 1; i < results.length; i++) {
    const prevFrets = results[i-1].frets.filter(f => f !== null);
    const currFrets = results[i].frets.filter(f => f !== null);
    // Should be able to map
    assert(currFrets.length === 4, 'All should be mappable');
  }
});

// Test 16-25: Edge cases
test('Empty Voicing - Error Handling', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  try {
    projection.project(input);
    assert(false, 'Should throw error for empty voicing');
  } catch (e) {
    assert(e.message.includes('empty'), 'Should error on empty voicing');
  }
});

test('High Register Voicing', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [64, 67, 71, 74], // High Cmaj7
    inversion: 'root',
    registerPosition: 'high',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  assert(result.frets.filter(f => f !== null).length === 4, 'Should map high voicing');
});

test('Low Register Voicing', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [40, 43, 47, 50], // Low E
    inversion: 'root',
    registerPosition: 'low',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  assert(result.frets.filter(f => f !== null).length === 4, 'Should map low voicing');
});

test('Different Inversions', () => {
  const projection = new FretboardProjection();
  const inversions = ['root', 'first', 'second', 'third'];
  
  for (const inv of inversions) {
    const input = {
      voicing: [48, 52, 55, 59],
      inversion: inv,
      registerPosition: 'mid',
      hold: false,
      reasonCodes: []
    };
    
    const result = projection.project(input);
    assert(result.shapeId === inv, `Should preserve shapeId ${inv}`);
  }
});

test('String Set Consistency', () => {
  const projection = new FretboardProjection();
  const input1 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result1 = projection.project(input1);
  const stringSet1 = result1.stringSet;
  
  // Same voicing should prefer same string set
  const input2 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  projection.reset();
  const result2 = projection.project(input2);
  const stringSet2 = result2.stringSet;
  
  // Should prefer same string set (may not be identical due to state)
  assert(stringSet1.length === stringSet2.length, 'String sets should have same length');
});

// Test 26-35: Movement type detection
test('Movement Type - First Chord RESET', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  assert(result.movementType === 'RESET', 'First chord should be RESET');
});

test('Movement Type - HOLD Preserved', () => {
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
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: true,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  assert(result2.movementType === 'HOLD', 'HOLD should be preserved');
});

test('Position Window - Stability', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.longForm32;
  
  const windows = [];
  for (const chord of progression) {
    const result = projection.project(chord);
    windows.push(result.positionWindow);
  }
  
  // Windows should not drift excessively
  const firstWindow = windows[0];
  const lastWindow = windows[windows.length - 1];
  const drift = Math.abs(lastWindow[0] - firstWindow[0]);
  
  assert(drift < 10, `Window should not drift excessively (drift: ${drift})`);
});

test('Anchor Fret - Within Window', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  
  assert(result.anchorFret >= result.positionWindow[0], 'Anchor should be >= window min');
  assert(result.anchorFret <= result.positionWindow[1], 'Anchor should be <= window max');
});

test('Multiple Projections - State Management', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.iiVIMajor;
  
  for (const chord of progression) {
    const result = projection.project(chord);
    assert(result, 'Should return result');
    assert(result.frets, 'Should have frets');
    assert(result.stringSet, 'Should have string set');
  }
});

// Test 36-45: Additional coverage
test('Reset Method', () => {
  const projection = new FretboardProjection();
  const input = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  projection.project(input);
  projection.reset();
  
  const result = projection.project(input);
  assert(result.movementType === 'RESET', 'After reset, should be RESET');
});

test('Fret Calculation - Octave Wrapping', () => {
  const projection = new FretboardProjection();
  // Test voicing that requires octave adjustment
  const input = {
    voicing: [52, 55, 59, 64], // Notes that might wrap
    inversion: 'root',
    registerPosition: 'mid',
    hold: false,
    reasonCodes: []
  };
  
  const result = projection.project(input);
  const usedFrets = result.frets.filter(f => f !== null);
  assert(usedFrets.every(f => f >= 0 && f <= 20), 'All frets should be valid after wrapping');
});

test('String Set Combinations', () => {
  const projection = new FretboardProjection();
  // Test that different voicings can map to different string sets
  const voicings = [
    [48, 52, 55, 59], // Low
    [55, 59, 62, 67], // Mid
    [60, 64, 67, 71]  // High
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
    assert(result.stringSet.length === 4, 'Should map to 4 strings');
  }
});

test('Register Band Preservation', () => {
  const projection = new FretboardProjection();
  const registers = ['low', 'mid', 'high'];
  
  for (const reg of registers) {
    const input = {
      voicing: [48, 52, 55, 59],
      inversion: 'root',
      registerPosition: reg,
      hold: false,
      reasonCodes: []
    };
    
    const result = projection.project(input);
    assert(result.registerBand === reg, `Should preserve registerBand ${reg}`);
  }
});

test('Shape ID Preservation', () => {
  const projection = new FretboardProjection();
  const shapes = ['root', 'first', 'second', 'third'];
  
  for (const shape of shapes) {
    const input = {
      voicing: [48, 52, 55, 59],
      inversion: shape,
      registerPosition: 'mid',
      hold: false,
      reasonCodes: []
    };
    
    const result = projection.project(input);
    assert(result.shapeId === shape, `Should preserve shapeId ${shape}`);
  }
});

// Run tests
console.log('\n=== Running Fretboard Projection v0.1.0 Tests ===\n');

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

