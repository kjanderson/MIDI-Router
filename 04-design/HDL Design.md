# State Machine
See https://learn.sparkfun.com/tutorials/midi-tutorial/all for a description of how a simple FSM can be used to parse MIDI messages.

For the purpose of this project, I divide MIDI messages by status bytes. A status byte followed by any number of data bytes is grouped together. This is accomplished by using a set of FIFOs for each input port.