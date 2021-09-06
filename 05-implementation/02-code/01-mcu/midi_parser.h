#ifndef MIDI_PARSER_H
#define MIDI_PARSER_H

#include <stdint.h>
#include "queue.h"

#define MIDI_PARSER_SIZE 16U
#define MIDI_STATUS_MASK 0x80U
#define MIDI_REALTIME_MASK 0xF8U

/* messages with two data bytes */
#define MIDI_NOTE_OFF_MASK 0x80U
#define MIDI_NOTE_ON_MASK 0x90U
#define MIDI_POLY_PRESSURE_MASK 0xA0U
#define MIDI_CTRL_CHANGE_MASK 0xB0U
#define MIDI_PITCH_BEND_MASK 0xE0U
#define MIDI_SONG_POSITION_MASK 0xF2U

/* messages with one data byte */
#define MIDI_PGM_CHANGE_MASK 0xC0U
#define MIDI_CHNL_PRESSURE_MASK 0xD0U
#define MIDI_TIME_CODE_MASK 0xF1U
#define MIDI_SONG_SELECT_MASK 0xF3U

/* system exclusive */
#define MIDI_SYSEX_START 0xF0U
#define MIDI_SYSEX_STOP  0xF7U

/* MIDI spec constants */
// #define MIDI_REALTIME_MASK 0xF8U
#define MIDI_TUNE_REQ  0xF6U
#define MIDI_3B_STAGE1 0xC0U
#define MIDI_2B_STAGE1 0xE0U
#define MIDI_3B_STAGE2 0xF0U
#define MIDI_ST_STAGE1 0xF2U
#define MIDI_ST_STAGE2 0xF0U
#define MIDI_ST_STAGE3 0xF1U
#define MIDI_ST_STAGE4 0xF3U
#define MIDI_ST_FLAG2  0x01U
#define MIDI_ST_FLAG3  0x02U

typedef enum eTagMidiParserState eMidiParserState;
enum eTagMidiParserState {
    STATE_INIT_RX,
    STATE_DISPATCH,
    STATE_DATA2_RX1,
    STATE_DATA2_RX2,
    STATE_DATA1_RX1
};

typedef enum eTagMidiParserCmd eMidiParserCmd;
enum eTagMidiParserCmd {
    CMD_BUFFER,
    CMD_SEND,
    CMD_CLEAR
};

typedef struct MidiParserTag MidiParser;
struct MidiParserTag {
    uint8_t uChannel;
    // uint8_t uData[MIDI_PARSER_SIZE];
    eMidiParserState eState;
    uint8_t uMessageLength;
    uint8_t uMessageCnt;
    uint8_t uStatus;
    uint8_t uRunningStatus;
    uint8_t uFlags;
    Queue queue;
};

void MidiParser_Ctor(MidiParser *pSelf, uint8_t uChannel);
void MidiParser_RxIsr(MidiParser *pSelf, uint8_t uRx);
void MidiParser_Parse(MidiParser *pSelf);

void MidiParser_Push(MidiParser *pSelf, uint8_t uRx);
void MidiParser_PushIsr(MidiParser *pSelf, uint8_t uRx);
uint8_t MidiParser_Pop(MidiParser *pSelf, uint8_t *uRx);
uint8_t MidiParser_PopIsr(MidiParser *pSelf, uint8_t *uRx);

#endif /* MIDI_PARSER_H */

