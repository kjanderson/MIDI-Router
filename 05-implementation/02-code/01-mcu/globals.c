#include "globals.h"

EventQueue g_EventQueue;
MidiParser g_MidiParser1;
MidiParser g_MidiParser2;
MidiParser g_MidiParser3;
MidiParser g_MidiParser4;
SpiCtrl g_SpiCtrl;
MergeOutput g_MergeOutput;

void InitGlobals(void)
{
    EventQueue_Init(&g_EventQueue);
    MidiParser_Ctor(&g_MidiParser1, 1U);
    MidiParser_Ctor(&g_MidiParser2, 2U);
    MidiParser_Ctor(&g_MidiParser3, 3U);
    MidiParser_Ctor(&g_MidiParser4, 4U);
    SpiCtrl_Ctor(&g_SpiCtrl);
    MergeOutput_Ctor(&g_MergeOutput);
}
