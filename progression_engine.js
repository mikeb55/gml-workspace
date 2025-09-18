// BULLETPROOF Long-form Progression Engine for Extended Compositions
class ProgressionEngine {
    constructor() {
        // Common progressions by style period
        this.progressionBank = {
            // Classical progressions (major/minor)
            classical: {
                major: [
                    ['I', 'IV', 'V', 'I'],
                    ['I', 'V', 'vi', 'IV'],
                    ['I', 'vi', 'IV', 'V'],
                    ['I', 'ii', 'V', 'I'],
                    ['I', 'IV', 'ii', 'V', 'I'],
                    ['I', 'V/V', 'V', 'I'],
                    ['I', 'vi', 'ii', 'V', 'I']
                ],
                minor: [
                    ['i', 'iv', 'V', 'i'],
                    ['i', 'VI', 'III', 'VII'],
                    ['i', 'ii°', 'V', 'i'],
                    ['i', 'iv', 'VII', 'III', 'VI', 'ii°', 'V', 'i']
                ]
            },
            // Romantic progressions
            romantic: {
                major: [
                    ['I', 'V/vi', 'vi', 'IV', 'V', 'I'],
                    ['I', 'bII', 'V', 'I'],
                    ['I', 'III', 'IV', 'V', 'I'],
                    ['I', 'vi', 'iii', 'IV', 'ii', 'V', 'I']
                ],
                chromatic: [
                    ['I', 'I+', 'IV', 'iv', 'I'],
                    ['I', 'bVI', 'bII', 'V', 'I'],
                    ['I', '#iv°7', 'V', 'I']
                ]
            },
            // Jazz/Modern
            jazz: [
                ['IMaj7', 'vi7', 'ii7', 'V7'],
                ['IMaj7', 'I7', 'IVMaj7', '#iv°7', 'IMaj7', 'V/ii', 'ii7', 'V7'],
                ['IMaj7', 'VIMaj7', 'IIMaj7', 'V7', 'IMaj7'],
                ['ii7', 'V7', 'IMaj7', 'VIMaj7']
            ],
            // Modal progressions
            modal: {
                dorian: ['i', 'IV', 'i', 'VII'],
                lydian: ['I', 'II', 'I', 'vii'],
                mixolydian: ['I', 'VII', 'IV', 'I'],
                phrygian: ['i', 'bII', 'i', 'vii']
            }
        };
        
        // Modulation patterns
        this.modulationPatterns = {
            dominant: ['I', 'V/V', 'V'],
            subdominant: ['I', 'IV', 'ii/IV', 'V/IV'],
            relative: ['I', 'vi', 'ii/vi', 'V/vi'],
            chromatic: ['I', 'bVI', 'bII', 'V/newkey'],
            sequential: ['I', 'V', 'V/V', 'V/V/V']
        };
        
        // Cadence formulas
        this.cadences = {
            authentic: ['V', 'I'],
            plagal: ['IV', 'I'],
            deceptive: ['V', 'vi'],
            half: ['I', 'V'],
            phrygian: ['iv6', 'V']
        };
    }
    
    generateLongformProgression(bars = 150, style = 'classical', key = 'C') {
        const progression = [];
        let currentBar = 0;
        const sectionLength = 8; // 8-bar phrases
        
        // Build structure
        const sections = Math.floor(bars / sectionLength);
        
        for (let section = 0; section < sections; section++) {
            const isLastSection = section === sections - 1;
            const isModulation = section % 4 === 3 && !isLastSection;
            
            if (isModulation) {
                // Add modulation
                progression.push(...this.createModulation(style));
            } else if (isLastSection) {
                // Add final cadence
                progression.push(...this.createFinalCadence(style));
            } else {
                // Add normal progression
                progression.push(...this.selectProgression(style, section));
            }
        }
        
        return this.expandToChords(progression, key);
    }
    
    selectProgression(style, sectionIndex) {
        let progressionSet;
        
        if (style === 'classical') {
            progressionSet = this.progressionBank.classical.major;
        } else if (style === 'romantic') {
            progressionSet = [...this.progressionBank.romantic.major, ...this.progressionBank.romantic.chromatic];
        } else if (style === 'jazz') {
            progressionSet = this.progressionBank.jazz;
        } else if (style === 'modal') {
            const modes = Object.values(this.progressionBank.modal);
            progressionSet = modes;
        } else {
            progressionSet = this.progressionBank.classical.major;
        }
        
        // Select based on section for variety
        const index = sectionIndex % progressionSet.length;
        return Array.isArray(progressionSet[index]) ? progressionSet[index] : progressionSet[0];
    }
    
    createModulation(style) {
        const patterns = Object.values(this.modulationPatterns);
        const pattern = patterns[Math.floor(Math.random() * patterns.length)];
        return pattern;
    }
    
    createFinalCadence(style) {
        if (style === 'classical') {
            return ['ii', 'V7', 'I'];
        } else if (style === 'romantic') {
            return ['iv', 'bII', 'V7', 'I'];
        } else if (style === 'jazz') {
            return ['ii7', 'V7alt', 'IMaj7'];
        }
        return ['V', 'I'];
    }
    
    expandToChords(romanNumerals, key = 'C') {
        const keyMap = {
            'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11
        };
        
        const root = keyMap[key] || 0;
        const majorScale = [0, 2, 4, 5, 7, 9, 11];
        
        return romanNumerals.map(numeral => {
            const chord = this.parseRomanNumeral(numeral, majorScale, root);
            return {
                symbol: numeral,
                notes: chord.notes,
                duration: 4, // bars
                quality: chord.quality
            };
        });
    }
    
    parseRomanNumeral(numeral, scale, root) {
        const numeralMap = {
            'I': 0, 'II': 1, 'III': 2, 'IV': 3, 'V': 4, 'VI': 5, 'VII': 6,
            'i': 0, 'ii': 1, 'iii': 2, 'iv': 3, 'v': 4, 'vi': 5, 'vii': 6
        };
        
        // Extract base numeral
        let baseNumeral = numeral.replace(/[^IVvi]/g, '');
        const isMinor = baseNumeral === baseNumeral.toLowerCase();
        const scaleDegree = numeralMap[baseNumeral.toUpperCase()] || 0;
        
        // Calculate root note
        const chordRoot = 60 + root + scale[scaleDegree];
        
        // Determine chord quality and build
        let notes;
        if (numeral.includes('°')) {
            notes = [chordRoot, chordRoot + 3, chordRoot + 6]; // diminished
        } else if (numeral.includes('+')) {
            notes = [chordRoot, chordRoot + 4, chordRoot + 8]; // augmented
        } else if (numeral.includes('7')) {
            if (isMinor) {
                notes = [chordRoot, chordRoot + 3, chordRoot + 7, chordRoot + 10]; // minor 7
            } else if (numeral.includes('Maj7')) {
                notes = [chordRoot, chordRoot + 4, chordRoot + 7, chordRoot + 11]; // major 7
            } else {
                notes = [chordRoot, chordRoot + 4, chordRoot + 7, chordRoot + 10]; // dominant 7
            }
        } else {
            if (isMinor) {
                notes = [chordRoot, chordRoot + 3, chordRoot + 7]; // minor triad
            } else {
                notes = [chordRoot, chordRoot + 4, chordRoot + 7]; // major triad
            }
        }
        
        return {
            notes: notes,
            quality: isMinor ? 'minor' : 'major'
        };
    }
    
    // Generate progression for specific form
    generateFormProgression(form, bars) {
        const progressions = [];
        
        switch(form) {
            case 'sonata':
                progressions.push(...this.generateSonataProgression(bars));
                break;
            case 'rondo':
                progressions.push(...this.generateRondoProgression(bars));
                break;
            case 'variations':
                progressions.push(...this.generateVariationProgression(bars));
                break;
            default:
                progressions.push(...this.generateLongformProgression(bars));
        }
        
        return progressions;
    }
    
    generateSonataProgression(bars) {
        const exposition = this.generateLongformProgression(bars * 0.35, 'classical');
        const development = this.generateLongformProgression(bars * 0.3, 'romantic');
        const recapitulation = this.generateLongformProgression(bars * 0.35, 'classical');
        
        return [...exposition, ...development, ...recapitulation];
    }
    
    generateRondoProgression(bars) {
        const a = this.generateLongformProgression(bars * 0.2, 'classical');
        const b = this.generateLongformProgression(bars * 0.15, 'romantic');
        const c = this.generateLongformProgression(bars * 0.15, 'modal');
        
        return [...a, ...b, ...a, ...c, ...a];
    }
    
    generateVariationProgression(bars) {
        const theme = this.selectProgression('classical', 0);
        const variations = [];
        const numVariations = 5;
        
        for (let i = 0; i < numVariations; i++) {
            variations.push(...this.varyProgression(theme, i));
        }
        
        return this.expandToChords(variations, 'C');
    }
    
    varyProgression(theme, variationNumber) {
        // Apply different variation techniques
        switch(variationNumber) {
            case 0: return theme; // Original
            case 1: return theme.map(chord => chord.includes('I') ? 'vi' : chord); // Substitution
            case 2: return [...theme, ...theme]; // Extension
            case 3: return theme.map(chord => chord + '7'); // Add sevenths
            case 4: return theme.reverse(); // Retrograde
            default: return theme;
        }
    }
}

// Export
if (typeof module !== 'undefined') {
    module.exports = ProgressionEngine;
}
if (typeof window !== 'undefined') {
    window.ProgressionEngine = ProgressionEngine;
}
