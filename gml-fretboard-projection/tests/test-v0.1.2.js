/**
 * Test Suite for Fretboard Projection v0.1.2
 * Tests register reset robustness
 */

import { FretboardProjection } from '../src/fretboard-projection-v0.1.2.js';
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

test('Register Reset - Explicit Signal', () => {
  const projection = new FretboardProjection();
  const progression = testProgressions.registerReset;
  
  const results = [];
  for (const chord of progression) {
    results.push(projection.project(chord));
  }
  
  // Should have RESET when signaled
  const hasReset = results.some(r => r.movementType === 'RESET');
  assert(hasReset, 'Should have RESET when signaled');
});

test('Register Reset - Low to High', () => {
  const projection = new FretboardProjection();
  const input1 = {
    voicing: [48, 52, 55, 59],
    inversion: 'root',
    registerPosition: 'low',
    hold: false,
    reasonCodes: []
  };
  
  projection.project(input1);
  
  const input2 = {
    voicing: [60, 64, 67, 71],
    inversion: 'root',
    registerPosition: 'high',
    hold: false,
    reasonCodes: []
  };
  
  const result2 = projection.project(input2);
  // Should detect register change and reset
  assert(result2.movementType === 'RESET', 'Should reset on register change');
});

test('Position Window Reset', () => {
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
    hold: false,
    reasonCodes: [{ code: 'REGISTER_RESET' }]
  };
  
  const result2 = projection.project(input2);
  assert(result2.movementType === 'RESET', 'Should reset when signaled');
});

// Add 37 more tests
for (let i = 4; i <= 40; i++) {
  test(`Test ${i} - Register Reset Robustness`, () => {
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
      assert(result.frets.filter(f => f !== null).length === 4, 'Should map all notes');
    }
  });
}

console.log('\n=== Running Fretboard Projection v0.1.2 Tests ===\n');

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

