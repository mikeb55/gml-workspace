# Quartal Engine - Dummies Guide

## What is the Quartal Engine?

The Quartal Engine is a powerful tool that generates **quartal harmony** (chords built in fourths) for guitar. Instead of traditional triads (built in thirds), quartal harmony creates a modern, open sound perfect for jazz, fusion, and contemporary music.

### Key Features

- Generates 3-note and 4-note quartal chords
- Supports all major modes (major, minor, dorian, mixolydian, lydian, phrygian, locrian)
- Works with any root note (C, C#, D, Eb, E, F, F#, G, Ab, A, Bb, B)
- Multiple note durations (half, quarter, eighth, sixteenth notes)
- Guitar-friendly voicings (playable positions, 5-fret max reach)
- Outputs MusicXML files that open directly in Sibelius, Finale, Guitar Pro 8, MuseScore, and Cubase

---

## Basic Command Structure

```
Generate [ROOT] [SCALE] quartals, [BARS] bars, [DURATION]
```

**Example:**
```
Generate C major quartals, 4 bars, quarter notes
```

---

## 20+ Command Examples

### 3-Note Quartals (Triads)

#### Quarter Notes (Standard Tempo)

1. **C Major - 4 Bars**
   ```
   Generate C major quartals, 4 bars, quarter notes
   ```
   *Result: 4 bars, 12 notes (3-note quartal stacks)*

2. **D Dorian - 8 Bars**
   ```
   Generate D dorian quartals, 8 bars, quarter notes
   ```
   *Result: 8 bars, 24 notes*

3. **E Minor - Full Scale (7 Bars)**
   ```
   Generate a musicxml of the E minor scale harmonised as quartals
   ```
   *Result: 7 bars, 21 notes (one quartal per scale degree)*

4. **F Lydian - 4 Bars**
   ```
   Generate F lydian quartals, 4 bars, quarter notes
   ```
   *Result: 4 bars, 12 notes*

5. **G Mixolydian - 6 Bars**
   ```
   Generate G mixolydian quartals, 6 bars, quarter notes
   ```
   *Result: 6 bars, 18 notes*

#### Half Notes (Slow, Sustained)

6. **A Minor - 4 Bars**
   ```
   Generate A minor quartals, 4 bars, half notes
   ```
   *Result: 4 bars, 12 notes, half-note duration (slow, sustained)*

7. **Bb Major - Full Scale**
   ```
   Generate a musicxml of the Bb major scale harmonised as quartals, half notes
   ```
   *Result: 7 bars, 21 notes, half-note duration*

8. **C# Locrian - 4 Bars**
   ```
   Generate C# locrian quartals, 4 bars, half notes
   ```
   *Result: 4 bars, 12 notes, half-note duration*

#### Eighth Notes (Fast, Rhythmic)

9. **D Dorian - 8 Bars**
   ```
   Generate D dorian quartals, 8 bars, eighth notes
   ```
   *Result: 8 bars, 24 notes, eighth-note duration (fast, rhythmic)*

10. **E Phrygian - 4 Bars**
    ```
    Generate E phrygian quartals, 4 bars, eighth notes
    ```
    *Result: 4 bars, 12 notes, eighth-note duration*

11. **F# Lydian - 12 Bars**
    ```
    Generate F# lydian quartals, 12 bars, eighth notes
    ```
    *Result: 12 bars, 36 notes, eighth-note duration*

#### Sixteenth Notes (Very Fast, Dense)

12. **G Mixolydian - 4 Bars**
    ```
    Generate G mixolydian quartals, 4 bars, sixteenth notes
    ```
    *Result: 4 bars, 12 notes, sixteenth-note duration (very fast, dense)*

13. **A Minor - 8 Bars**
    ```
    Generate A minor quartals, 8 bars, 16th notes
    ```
    *Result: 8 bars, 24 notes, sixteenth-note duration*

### 4-Note Quartals (Extended Chords)

#### Quarter Notes

14. **C Major - 4 Bars**
    ```
    Generate C major 4-note quartals, 4 bars, quarter notes
    ```
    *Result: 4 bars, 16 notes (4-note quartal stacks)*

15. **D Dorian - Full Scale**
    ```
    Generate a musicxml of the D dorian scale harmonised as 4-note quartals
    ```
    *Result: 7 bars, 28 notes (one 4-note quartal per scale degree)*

16. **E Minor - 8 Bars**
    ```
    Generate E minor 4-note quartals, 8 bars, quarter notes
    ```
    *Result: 8 bars, 32 notes*

#### Half Notes

17. **F Lydian - 4 Bars**
    ```
    Generate F lydian 4-note quartals, 4 bars, half notes
    ```
    *Result: 4 bars, 16 notes, half-note duration*

18. **G Mixolydian - Full Scale**
    ```
    Generate a musicxml of the G mixolydian scale harmonised as 4-note quartals, half notes
    ```
    *Result: 7 bars, 28 notes, half-note duration*

#### Eighth Notes

19. **A Minor - 4 Bars**
    ```
    Generate A minor 4-note quartals, 4 bars, eighth notes
    ```
    *Result: 4 bars, 16 notes, eighth-note duration*

20. **Bb Major - 8 Bars**
    ```
    Generate Bb major 4-note quartals, 8 bars, eighth notes
    ```
    *Result: 8 bars, 32 notes, eighth-note duration*

#### Sixteenth Notes

21. **C# Locrian - 4 Bars**
    ```
    Generate C# locrian 4-note quartals, 4 bars, 16th notes
    ```
    *Result: 4 bars, 16 notes, sixteenth-note duration*

22. **D Dorian - 8 Bars**
    ```
    Generate D dorian 4-note quartals, 8 bars, sixteenth notes
    ```
    *Result: 8 bars, 32 notes, sixteenth-note duration*

---

## Understanding the Output

### File Naming

Files are automatically named with descriptive information:
- Format: `{root}-{scale}-quartal-{stackType}-{bars}bars{fullscale}-{timestamp}.MusicXML`
- Example: `D-dorian-quartal-3note-4bars-1234567890.MusicXML`

### What You Get

Each generated file contains:
- **Voice 1** (top voice) = Highest note - can be used as melody
- **Voice 2, 3, 4** = Lower harmony voices (quartal support)
- All notes play **simultaneously as chords** (not arpeggios)
- Guitar-friendly voicings (playable positions)

### Opening the Files

The `.MusicXML` files open directly in:
- Sibelius
- Finale
- Guitar Pro 8
- MuseScore
- Cubase
- Any MusicXML-compatible software

---

## Practical Application: Creating a 3-Chorus Solo

### Overview

A **3-chorus solo** is a common jazz structure where you play three complete cycles (choruses) over a chord progression, each with increasing intensity and complexity.

### Step-by-Step Workflow

#### Chorus 1: Establish the Harmony

**Goal:** Create a foundation with clear quartal harmony

1. **Generate the base progression**
   ```
   Generate D dorian quartals, 4 bars, half notes
   ```
   - Slow, sustained chords
   - Establishes the harmonic foundation
   - Use Voice 1 (top voice) as your starting melody line

2. **Copy to your DAW/notation software**
   - Import the MusicXML into Sibelius/Finale
   - This becomes your first chorus foundation

#### Chorus 2: Add Movement

**Goal:** Increase rhythmic activity while maintaining harmony

3. **Generate faster harmonic rhythm**
   ```
   Generate D dorian quartals, 4 bars, quarter notes
   ```
   - Medium tempo
   - More movement than Chorus 1
   - Develop melodic ideas using Voice 1

4. **Optional: Add 4-note quartals for richness**
   ```
   Generate D dorian 4-note quartals, 4 bars, quarter notes
   ```
   - Richer harmonic texture
   - More notes to work with melodically

#### Chorus 3: Maximum Intensity

**Goal:** Fast, dense, complex harmonic rhythm

5. **Generate fast harmonic rhythm**
   ```
   Generate D dorian quartals, 4 bars, eighth notes
   ```
   - Fast, rhythmic
   - Creates intensity and forward motion

6. **Or use sixteenth notes for maximum density**
   ```
   Generate D dorian quartals, 4 bars, sixteenth notes
   ```
   - Very fast, dense texture
   - Maximum intensity

### Complete 3-Chorus Solo Example

**Song: "So What" (D Dorian)**

**Chorus 1 (Establishment):**
```
Generate D dorian quartals, 8 bars, half notes
```
- Slow, sustained
- Clear harmonic foundation
- Use top voice as melody guide

**Chorus 2 (Development):**
```
Generate D dorian quartals, 8 bars, quarter notes
```
- Medium tempo
- More rhythmic activity
- Develop melodic ideas

**Chorus 3 (Climax):**
```
Generate D dorian quartals, 8 bars, eighth notes
```
- Fast, intense
- Maximum rhythmic density
- Build to climax

### Advanced: Mixing 3-Note and 4-Note Quartals

**Chorus 1:**
```
Generate D dorian quartals, 8 bars, half notes
```
(3-note quartals - open, clear)

**Chorus 2:**
```
Generate D dorian 4-note quartals, 8 bars, quarter notes
```
(4-note quartals - richer texture)

**Chorus 3:**
```
Generate D dorian quartals, 8 bars, eighth notes
```
(3-note quartals - fast, clear)

### Using Different Scales for Variation

**Chorus 1: D Dorian**
```
Generate D dorian quartals, 8 bars, half notes
```

**Chorus 2: D Minor (Aeolian)**
```
Generate D minor quartals, 8 bars, quarter notes
```
(Slight harmonic variation)

**Chorus 3: D Dorian (Return)**
```
Generate D dorian quartals, 8 bars, eighth notes
```
(Return to original, but faster)

---

## Tips for Using Quartal Harmony in Solos

### 1. Use the Top Voice as Melody

- **Voice 1** (highest note) naturally serves as a melody line
- Develop melodic phrases from these top notes
- The quartal harmony below provides modern, open support

### 2. Mix Durations for Interest

- Start slow (half notes) → Build to fast (eighth/sixteenth notes)
- Creates natural intensity curve
- Mimics how real solos develop

### 3. Combine 3-Note and 4-Note Quartals

- 3-note quartals = Open, clear, less dense
- 4-note quartals = Richer, more complex, denser
- Use 3-note for clarity, 4-note for richness

### 4. Use Full Scale Harmonization

- Command: `Generate a musicxml of the [ROOT] [SCALE] scale harmonised as quartals`
- Gets all 7 scale degrees
- Perfect for exploring the entire scale harmonically

### 5. Experiment with Different Modes

- Same root, different mode = Different harmonic color
- D Dorian vs D Minor = Subtle but important differences
- Great for creating variation in multi-chorus solos

---

## Common Use Cases

### 1. Chord Progressions for Practice

Generate quartal harmony for any scale/mode to practice:
```
Generate C major quartals, 4 bars, quarter notes
```

### 2. Composition Foundation

Use quartal harmony as a starting point for compositions:
```
Generate a musicxml of the E minor scale harmonised as quartals
```

### 3. Jazz Solo Preparation

Create harmonic frameworks for improvisation:
```
Generate G mixolydian quartals, 8 bars, quarter notes
```

### 4. Modern Sound Exploration

Experiment with quartal harmony's unique sound:
```
Generate F# lydian 4-note quartals, 4 bars, half notes
```

---

## Quick Reference

### Duration Keywords

- `half` or `half notes` = Slow, sustained
- `quarter` or `quarter notes` = Standard tempo (default)
- `eighth`, `8th`, `eighth notes`, `8th notes` = Fast, rhythmic
- `sixteenth`, `16th`, `sixteenth notes`, `16th notes` = Very fast, dense

### Stack Types

- **3-note quartals** = Default (just say "quartals")
- **4-note quartals** = Say "4-note quartals" or "4-note stacks"

### Full Scale Harmonization

- Add: `Generate a musicxml of the [ROOT] [SCALE] scale harmonised as quartals`
- Automatically generates 7 bars (one per scale degree)

### Supported Scales/Modes

- Major (Ionian)
- Minor (Aeolian)
- Dorian
- Mixolydian
- Lydian
- Phrygian
- Locrian

### Supported Roots

C, C#, Db, D, D#, Eb, E, F, F#, Gb, G, G#, Ab, A, A#, Bb, B

---

## Troubleshooting

### Notes Playing as Arpeggios Instead of Chords?

**Fixed!** The engine now generates proper chord notation. All notes are in voice 1 with `<chord/>` tags, so they play simultaneously.

### File Won't Open?

- Ensure the file has `.MusicXML` extension
- Try opening in MuseScore (free, excellent MusicXML support)
- Check that your software supports MusicXML 3.1

### Wrong Scale/Mode?

- Check spelling: "dorian" not "dorian mode"
- Root note must come before scale name: "D dorian" not "dorian D"
- Use: `Generate [ROOT] [SCALE] quartals, [BARS] bars`

---

## Summary

The Quartal Engine is a powerful tool for generating modern quartal harmony. With 20+ command examples covering different durations, stack types, and scales, you can create harmonic foundations for:

- Practice exercises
- Composition
- Jazz solo preparation
- Modern harmony exploration
- **3-chorus solo development** (slow → medium → fast)

Remember: The top voice (Voice 1) is your melody guide, and the quartal harmony below provides modern, open-sounding support. Experiment with different durations, stack types, and scales to find the perfect sound for your music!

---

## Getting Started

1. Open the Quartal Engine CLI: `node quartal-cli.js`
2. Type a command: `Generate D dorian quartals, 4 bars, quarter notes`
3. Open the generated `.MusicXML` file in your notation software
4. Use Voice 1 as melody, Voices 2-4 as harmony
5. Experiment and create!

**Happy quartal harmonizing!**


