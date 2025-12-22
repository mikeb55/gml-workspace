# Quartal Harmonic Engine

A deterministic MusicXML output engine for generating quartal harmony on guitar.

## Overview

This engine generates MusicXML files containing quartal harmony (4th-based stacking) for guitar. MusicXML is the source of truth - any future visualizers must be derived from MusicXML outputs, not replace them.

## Versions

- **v1.0**: Core quartal harmony generator from scale/mode input
- **v1.1**: MusicXML melody harmonizer (melody unchanged, harmony added below)
- **v1.2**: Taste-control switches (density, tritone policy, register, string set)
- **v2.0**: Quintile Engine (not yet implemented)

## Quick Start

### Desktop Access
**Double-click the "Quartal Engine" shortcut on your desktop** to open the natural language CLI.

### Natural Language Interface

Simply type commands in plain English:

```
Quartal Engine> Generate a musicxml of the C major scale harmonised as quartals
Quartal Engine> Generate D dorian quartals, 4 bars
Quartal Engine> Generate F# lydian 4-note stacks, 8 bars
```

The CLI will:
1. Parse your command
2. Generate MusicXML directly
3. Save it to `output/generated/`
4. Show you the file path

**No JSON files required!** Just natural language commands.

### Installation
```bash
cd quartal-engine
npm install
```

### Running Tests
```bash
npm test
```

### Command Line Usage

**Interactive Mode:**
```bash
node quartal-cli.js
```

**Direct Command (one-shot):**
```bash
echo "Generate C major quartals" | node quartal-cli.js
```

### Legacy JSON-Based Generators (for testing)

**v1.0:**
```bash
node generate_v1.0.js tests/fixtures/fixture_a_v1.0.json
```

**v1.1:**
```bash
node generate_v1.1.js tests/fixtures/fixture_c_v1.1.json
```

**v1.2:**
```bash
node generate_v1.2.js tests/fixtures/fixture_e_v1.2.json
```

## Test Command

```bash
node tests/runners/run_all_tests.js
```

## PASS Summary

✅ **ALL TESTS PASSING**
- v1.0: 2/2 passed
- v1.1: 2/2 passed  
- v1.2: 2/2 passed
- **Total: 6/6 passed**

## File Structure

See `STATUS.md` for complete file tree and documentation.

## Version Lock Policy

All versions (v1.0, v1.1, v1.2) are LOCKED - no breaking changes allowed. New versions are separate systems.

