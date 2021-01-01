#ifndef _MIDI_COMM_H
#define _MIDI_COMM_H

#define MIDI_COMM_CMD_ENA_INP 0x01
#define MIDI_COMM_CMD_DIS_INP 0x02
#define MIDI_COMM_CMD_ENA_OUT 0x03
#define MIDI_COMM_CMD_DIS_OUT 0x04
#define MIDI_COMM_CMD_NVM_CLR 0x05
#define MIDI_COMM_CMD_NVM_WRR 0x06
#define MIDI_COMM_CMD_NVM_RDB 0x07
#define MIDI_COMM_CMD_LAST    0x07

typedef struct MidiCmdTag MidiCmd;
struct MidiCmdTag {
	uint8_t uCmd;
	void (*pFcn)(MidiComm *pSelf);
};

typedef struct MidiCommTag MidiComm;
struct MidiCommTag {
	Comm super;
	MidiCmd vCommandList[MIDI_COMM_CMD_LAST];
};

void MidiComm_Ctor(MidiComm *pSelf);
void MidiComm_SetCommand(MidiComm *pSelf, uint8_t uCmd, void (*pFcn)(MidiComm *pSelf));
void MidiComm_RxIsr(MidiComm *pSelf, uint8_t uRx);

#endif /* _MIDI_COMM_H */
