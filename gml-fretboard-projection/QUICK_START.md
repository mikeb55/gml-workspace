# Quick Start & Testing Reminder

## 🎯 Project Aim

**Fretboard Projection Layer** - Maps harmonic engine voicings onto guitar strings and frets.

**What it does:**
- Takes voicings (MIDI notes) from `gml-harmonic-engine`
- Decides WHERE notes appear on the fretboard (which string, which fret)
- Creates calm, intentional, guitarist-realistic movement

**What it does NOT do:**
- ❌ Never decides harmony
- ❌ Never alters voicings
- ❌ Only decides WHERE, never WHAT

**Visual Philosophy:** Labyrinth-style calm
- HOLD = visual stillness (no movement)
- STEP = minimal movement (one finger, slight shift)
- RESET = single intentional jump (no gradual drift)

---

## 🧪 Testing Commands

When you return, run these tests:

```bash
# Test all versions
npm test

# Test specific versions
npm run test:v0.1.0
npm run test:v0.1.1
npm run test:v0.1.2
npm run test:v0.1.3
```

**Expected:** All tests should pass (40+ tests per version)

---

## 📁 Key Files

- **Source:** `src/fretboard-projection-v0.1.3.js` (latest version)
- **Tests:** `tests/test-v0.1.3.js` (40+ test cycles)
- **Docs:** `README.md` (full explanation)
- **History:** `CHANGELOG.md` (version changes)

---

## ✅ Success Criteria (All Met)

- ✅ All 4 versions exist (v0.1.0 → v0.1.3)
- ✅ 40+ tests per version (all passing)
- ✅ README.md and CHANGELOG.md exist
- ✅ HOLD, STEP, RESET behaviors implemented
- ✅ Position window, shape continuity, register reset all working
- ✅ No linting errors

---

## 🔗 Dependencies

- Consumes: `../gml-harmonic-engine` (relative path import)
- Output: Fretboard mappings (stringSet, frets, positionWindow, anchorFret, movementType)

---

**Status:** ✅ Complete and ready for testing

