/* 2-byte messages */
`define MIDI_NOTE_OFF      4'h8
`define MIDI_NOTE_ON       4'h9
`define MIDI_POLY_PRESSURE 4'hA
`define MIDI_CTRL_CHANGE   4'hB
`define MIDI_PITCH_BEND    4'hE

/* 3-byte messages */
`define MIDI_PGM_CHANGE    4'hC
`define MIDI_CHNL_PRESSURE 4'hD

/* realtime messages */
`define MIDI_REALTIME_MASK 8'hF8

