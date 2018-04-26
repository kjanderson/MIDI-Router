# MIDI-Router
PIC24/FPGA code to route MIDI data on prototype hardware.

The objective of this project is to build a prototype that is able to route MIDI
signals from source to destination automatically.

The hardware provides 4 MIDI inputs, 4 MIDI thru's, and 4 MIDI outputs.
This software project implements the routing of the inputs to the outputs.

Notes
 - USB is copied from the MLA USB Framework
 - USB-app is copied from the application example in the MLA
 - USB-bsp is copied from the application example in the MLA

![System Diagram]("/01-requirements/system specification figures/system drawing.png")
