// MidiExporter.js - FULL VERSION V1.2.0
class MidiExporter {
  constructor() {
    this.HEADER_CHUNK_TYPE = [0x4D, 0x54, 0x68, 0x64];
    this.TRACK_CHUNK_TYPE = [0x4D, 0x54, 0x72, 0x6B];
    this.instrumentMap = {
      guitar: 24, violinI: 40, violinII: 40, viola: 41, cello: 42
    };
    this.ticksPerQuarter = 480;
  }
  
  exportToMidi(composition) {
    const midiData = {
      format: 1,
      ticksPerQuarter: this.ticksPerQuarter,
      tracks: []
    };
    
    midiData.tracks.push(this.createTempoTrack(composition));
    
    ['guitar', 'violinI', 'violinII', 'viola', 'cello'].forEach((inst, idx) => {
      if (composition[inst]) {
        midiData.tracks.push(this.createInstrumentTrack(composition[inst], inst, idx));
      }
    });
    
    return this.encodeMidiFile(midiData);
  }
  
  createTempoTrack(comp) {
    return [
      {deltaTime: 0, type: 'meta', subtype: 'trackName', text: 'Tempo'},
      {deltaTime: 0, type: 'meta', subtype: 'setTempo', microsecondsPerQuarter: Math.round(60000000/(comp.tempo||120))},
      {deltaTime: 0, type: 'meta', subtype: 'endOfTrack'}
    ];
  }
  
  createInstrumentTrack(part, name, channel) {
    const events = [];
    let absoluteTime = 0;
    
    events.push({absoluteTime: 0, type: 'meta', subtype: 'trackName', text: name});
    events.push({absoluteTime: 0, type: 'channel', subtype: 'programChange', channel: channel, program: this.instrumentMap[name]||0});
    
    if (part.measures) {
      part.measures.forEach((measure, idx) => {
        const measureStart = idx * 4 * this.ticksPerQuarter;
        if (measure && measure.notes) {
          measure.notes.forEach(note => {
            const start = measureStart + this.beatToTicks(note.beat||0);
            const duration = this.beatToTicks(note.duration||1);
            const pitch = this.pitchToMidiNumber(note.pitch);
            const vel = this.dynamicToVelocity(note.dynamic);
            
            events.push({absoluteTime: start, type: 'channel', subtype: 'noteOn', channel: channel, note: pitch, velocity: vel});
            events.push({absoluteTime: start + duration, type: 'channel', subtype: 'noteOff', channel: channel, note: pitch, velocity: 0});
          });
        }
      });
    }
    
    events.sort((a, b) => a.absoluteTime - b.absoluteTime);
    
    let lastTime = 0;
    events.forEach(e => {
      e.deltaTime = e.absoluteTime - lastTime;
      lastTime = e.absoluteTime;
      delete e.absoluteTime;
    });
    
    events.push({deltaTime: 0, type: 'meta', subtype: 'endOfTrack'});
    return events;
  }
  
  beatToTicks(beats) { return Math.round(beats * this.ticksPerQuarter); }
  
  pitchToMidiNumber(pitch) {
    const notes = {C:0,D:2,E:4,F:5,G:7,A:9,B:11};
    if (typeof pitch === 'number') return pitch;
    if (typeof pitch === 'string') {
      const m = pitch.match(/([A-G])([#b]?)(\d+)/);
      if (m) {
        let num = 12 + (parseInt(m[3]) * 12) + notes[m[1]];
        if (m[2] === '#') num++;
        if (m[2] === 'b') num--;
        return num;
      }
    }
    return 60;
  }
  
  dynamicToVelocity(d) {
    const map = {ppp:16,pp:33,p:49,mp:64,mf:80,f:96,ff:112,fff:127};
    return map[d] || 80;
  }
  
  encodeMidiFile(data) {
    const buffer = [];
    buffer.push(...this.HEADER_CHUNK_TYPE);
    buffer.push(...this.int32ToBytes(6));
    buffer.push(...this.int16ToBytes(data.format));
    buffer.push(...this.int16ToBytes(data.tracks.length));
    buffer.push(...this.int16ToBytes(data.ticksPerQuarter));
    
    data.tracks.forEach(track => {
      const trackData = this.encodeTrack(track);
      buffer.push(...this.TRACK_CHUNK_TYPE);
      buffer.push(...this.int32ToBytes(trackData.length));
      buffer.push(...trackData);
    });
    
    return new Uint8Array(buffer);
  }
  
  encodeTrack(track) {
    const buffer = [];
    track.forEach(event => {
      buffer.push(...this.encodeVariableLength(event.deltaTime || 0));
      if (event.type === 'meta') {
        buffer.push(0xFF);
        buffer.push(...this.encodeMetaEvent(event));
      } else if (event.type === 'channel') {
        buffer.push(...this.encodeChannelEvent(event));
      }
    });
    return buffer;
  }
  
  encodeVariableLength(v) {
    if (v === 0) return [0];
    const buffer = [];
    while (v > 0) {
      buffer.unshift(v & 0x7F);
      v >>= 7;
    }
    for (let i = 0; i < buffer.length - 1; i++) buffer[i] |= 0x80;
    return buffer;
  }
  
  encodeMetaEvent(e) {
    const buffer = [];
    const types = {trackName:0x03,setTempo:0x51,endOfTrack:0x2F};
    buffer.push(types[e.subtype]||0);
    
    if (e.subtype === 'trackName') {
      const bytes = Array.from(e.text).map(c => c.charCodeAt(0));
      buffer.push(...this.encodeVariableLength(bytes.length));
      buffer.push(...bytes);
    } else if (e.subtype === 'setTempo') {
      buffer.push(3);
      buffer.push(...this.int24ToBytes(e.microsecondsPerQuarter));
    } else if (e.subtype === 'endOfTrack') {
      buffer.push(0);
    }
    return buffer;
  }
  
  encodeChannelEvent(e) {
    const buffer = [];
    const types = {noteOn:0x90,noteOff:0x80,programChange:0xC0};
    buffer.push(types[e.subtype] | (e.channel & 0x0F));
    
    if (e.subtype === 'noteOn' || e.subtype === 'noteOff') {
      buffer.push(e.note & 0x7F);
      buffer.push(e.velocity & 0x7F);
    } else if (e.subtype === 'programChange') {
      buffer.push(e.program & 0x7F);
    }
    return buffer;
  }
  
  int16ToBytes(v) { return [(v>>8)&0xFF, v&0xFF]; }
  int24ToBytes(v) { return [(v>>16)&0xFF, (v>>8)&0xFF, v&0xFF]; }
  int32ToBytes(v) { return [(v>>24)&0xFF, (v>>16)&0xFF, (v>>8)&0xFF, v&0xFF]; }
  
  saveMidiFile(data, filename) {
    require('fs').writeFileSync(filename, Buffer.from(data));
    console.log('MIDI saved: ' + filename);
  }
}

module.exports = MidiExporter;