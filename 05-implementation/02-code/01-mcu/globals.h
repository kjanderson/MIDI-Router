#ifndef GLOBALS_H
#define GLOBALS_H

#include "event-queue.h"
#include "midi_parser.h"
#include "spi-ctrl.h"
#include "merge_outputs.h"

extern EventQueue g_EventQueue;
extern MidiParser g_MidiParser1;
extern MidiParser g_MidiParser2;
extern MidiParser g_MidiParser3;
extern MidiParser g_MidiParser4;
extern SpiCtrl g_SpiCtrl;
extern MergeOutput g_MergeOutput;

void InitGlobals(void);

#endif /* GLOBALS_H */
