#include <stdint.h>
#include "midi_comm.h"

void MidiComm_Ctor(MidiComm *pSelf)
{
}

void MidiComm_SetCommand(MidiComm *pSelf, uint8_t uCmd, void (*pFcn)(MidiComm *pSelf))
{
}

void MidiComm_RxIsr(MidiComm *pSelf, uint8_t uRx)
{
}

