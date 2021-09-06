#include <stdint.h>
#include "midi_parser.h"
#include "event-queue.h"
#include "globals.h"
#include "merge_outputs.h"
#include "hal.h"

static void _MidiParser_HandleStateIsr(MidiParser *pSelf, uint8_t uRx);
static void _MidiParser_HandleRxDataIsr(MidiParser *pSelf, uint8_t uRx, eMidiParserCmd eCmd);
static eMidiParserState _MidiParser_DecodeStatusIsr(MidiParser *pSelf, uint8_t uRx);

static void _MidiParser_HandleStateIsr(MidiParser *pSelf, uint8_t uRx)
{
    switch (pSelf->eState)
    {
        case STATE_INIT_RX:
            if ((uRx & MIDI_STATUS_MASK) > 0U)
            {
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                pSelf->eState = _MidiParser_DecodeStatusIsr(pSelf, uRx);
            }
            else
            {
                /* discard data bytes during initialization */
            }
            break;
        case STATE_DATA2_RX1:
            /* with normal input, this is a data byte, but check for
             * status just in case */
            if ((uRx & MIDI_STATUS_MASK) > 0U)
            {
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_CLEAR);
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                pSelf->eState = _MidiParser_DecodeStatusIsr(pSelf, uRx);
            }
            else
            {
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                pSelf->eState = STATE_DATA2_RX2;
            }
            break;
        case STATE_DATA2_RX2:
            if ((uRx & MIDI_STATUS_MASK) > 0U)
            {
                /* shouldn't need to send any data, but just to make sure */
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_SEND);
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                pSelf->eState = _MidiParser_DecodeStatusIsr(pSelf, uRx);
            }
            else
            {
                /* no status byte yet, send buffered data (including this byte) */
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_SEND);
            }
            break;
        case STATE_DATA1_RX1:
            if ((uRx & MIDI_STATUS_MASK) > 0U)
            {
                /* shouldn't need to send any data, but just to make sure */
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_SEND);
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                pSelf->eState = _MidiParser_DecodeStatusIsr(pSelf, uRx);
            }
            else
            {
                /* no status byte yet, send buffered data (including this byte) */
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_BUFFER);
                _MidiParser_HandleRxDataIsr(pSelf, uRx, CMD_SEND);
            }
            break;
        default:
            break;
    }
}

static eMidiParserState _MidiParser_DecodeStatusIsr(MidiParser *pSelf, uint8_t uRx)
{
    eMidiParserState eState;
    (void)pSelf;
    
    if (((uRx & MIDI_NOTE_OFF_MASK) == MIDI_NOTE_OFF_MASK) ||
        ((uRx & MIDI_NOTE_ON_MASK) == MIDI_NOTE_ON_MASK) ||
        ((uRx & MIDI_POLY_PRESSURE_MASK) == MIDI_POLY_PRESSURE_MASK) ||
        ((uRx & MIDI_CTRL_CHANGE_MASK) == MIDI_CTRL_CHANGE_MASK) ||
        ((uRx & MIDI_PITCH_BEND_MASK) == MIDI_PITCH_BEND_MASK))
    {
        eState = STATE_DATA2_RX1;
    }
    else if (((uRx & MIDI_PGM_CHANGE_MASK) == MIDI_PGM_CHANGE_MASK) ||
             ((uRx & MIDI_CHNL_PRESSURE_MASK) == MIDI_CHNL_PRESSURE_MASK))
    {
        eState = STATE_DATA1_RX1;
    }
    else
    {
        eState = STATE_INIT_RX;
    }
    
    return eState;
}

void _MidiParser_HandleRxDataIsr(MidiParser *pSelf, uint8_t uRx, eMidiParserCmd eCmd)
{
    uint8_t uTx;
    
    if (eCmd == CMD_BUFFER)
    {
        Queue_PushIsr(&(pSelf->queue), uRx);
    }
    else if (eCmd == CMD_SEND)
    {
        while (Queue_PopIsr(&(pSelf->queue), &uTx) > 0U)
        {
            MergeOutput_SendByteIsr(&g_MergeOutput, uTx);
        }
    }
    else if (eCmd == CMD_CLEAR)
    {
        while (Queue_PopIsr(&(pSelf->queue), &uTx) > 0U)
        {
            /* on a clear command, empty the queue */
        }
    }
    else
    {
        /* invalid command, nothing to do */
    }
}

static void _MidiParser_FlowChartAction1Isr(MidiParser *pSelf, uint8_t uRx)
{
    // real time message
    (void)pSelf;
    MergeOutput_SendByteIsr(&g_MergeOutput, uRx);
}

static void _MidiParser_FlowChartAction2Isr(MidiParser *pSelf, uint8_t uRx)
{
    // store running status in buffer
    pSelf->uStatus = uRx;
    pSelf->uRunningStatus = uRx;
    // clear third byte flag
    pSelf->uFlags &= ~(MIDI_ST_FLAG3);

}

static void _MidiParser_FlowChartAction3Isr(MidiParser *pSelf, uint8_t uRx)
{
    // tune request
    // store it in FIFO
    // increment pointer by 1
    MergeOutput_SendByteIsr(&g_MergeOutput, uRx);
}

static void _MidiParser_FlowChartAction4Isr(MidiParser *pSelf, uint8_t uRx)
{
    // do not increment pointer
}

static void _MidiParser_FlowChartAction5Isr(MidiParser *pSelf, uint8_t uRx)
{
    uint8_t uTx;
    
    // clear third byte flag
    pSelf->uFlags &= ~(MIDI_ST_FLAG3);
    // store third byte into FIFO
    Queue_PushIsr(&(pSelf->queue), uRx);
    // increment pointer by 3
    while (Queue_PopIsr(&(pSelf->queue), &uTx) > 0U)
    {
        MergeOutput_SendByteIsr(&g_MergeOutput, uTx);
    }
}

static void _MidiParser_FlowChartAction6Isr(MidiParser *pSelf, uint8_t uRx)
{
    // ignore data byte
}

static void _MidiParser_FlowChartAction7Isr(MidiParser *pSelf, uint8_t uRx)
{
    // set third byte flag
    pSelf->uFlags |= MIDI_ST_FLAG3;
    // store status into FIFO
    Queue_PushIsr(&(pSelf->queue), pSelf->uStatus);
    // store data byte in FIFO
    Queue_PushIsr(&(pSelf->queue), uRx);
    // do not increment pointer here
}

static void _MidiParser_FlowChartAction8Isr(MidiParser *pSelf, uint8_t uRx)
{
    // clear running status buffer
    pSelf->uRunningStatus = 0U;
}

static void _MidiParser_FlowChartAction9Isr(MidiParser *pSelf, uint8_t uRx)
{
    // clear running status buffer
    pSelf->uRunningStatus = 0U;
}

static void _MidiParser_FlowChartAction10Isr(MidiParser *pSelf, uint8_t uRx)
{
    uint8_t uTx;
    
    // store status into FIFO
    Queue_PushIsr(&(pSelf->queue), pSelf->uStatus);
    // store data byte into FIFO
    Queue_PushIsr(&(pSelf->queue), uRx);
    // increment pointer by 2
    while (Queue_PopIsr(&(pSelf->queue), &uTx) > 0U)
    {
        MergeOutput_SendByteIsr(&g_MergeOutput, uTx);
    }
}

static void _MidiParser_FlowChartAction11Isr(MidiParser *pSelf, uint8_t uRx)
{
    // clear running status buffer
    pSelf->uRunningStatus = 0U;
    // ignore status
}


void MidiParser_Ctor(MidiParser *pSelf, uint8_t uChannel)
{
    pSelf->uChannel = uChannel;
    pSelf->uMessageLength = 0U;
    pSelf->uMessageCnt = 0U;
    Queue_Ctor(&(pSelf->queue));
    pSelf->eState = STATE_INIT_RX;
    pSelf->uStatus = 0U;
    pSelf->uRunningStatus = 0U;
    pSelf->uFlags = 0U;
}

/**********************************************************************
 * MidiParser_RxIsr
 * 
 * Description
 * This function processes a received byte from the UART.
 * 
 * Notes
 * Apply the following algorithm:
 *   if byte = status byte
 *     copy buffered data to output
 *     buffer status byte
 *   else if byte = system realtime
 *     copy data to output
 *   else
 *     buffer data
 * 
 * I can't tell from the flowchart the following:
 *   1. What's the difference between status and running status?
 *   2. When do I commit each transaction?
 *********************************************************************/
void MidiParser_RxIsr(MidiParser *pSelf, uint8_t uRx)
{
#if 0
    uint8_t uQueueItem;
    uint16_t uMessage;
#endif
    
    // 2021-08-27: trying the flowchart in the MIDI spec
    if ((uRx & MIDI_STATUS_MASK) > 0)
    {
        if ((uRx & MIDI_REALTIME_MASK) == MIDI_REALTIME_MASK)
        {
            _MidiParser_FlowChartAction1Isr(pSelf, uRx);
        }
        else
        {
            _MidiParser_FlowChartAction2Isr(pSelf, uRx);
            if (uRx == MIDI_TUNE_REQ)
            {
                _MidiParser_FlowChartAction3Isr(pSelf, uRx);
            }
            else
            {
                _MidiParser_FlowChartAction4Isr(pSelf, uRx);
            }
        }
    }
    else
    {
        // third-byte flag set
        if ((pSelf->uFlags & MIDI_ST_FLAG3) > 0)
        {
            _MidiParser_FlowChartAction5Isr(pSelf, uRx);
        }
        else if (pSelf->uRunningStatus == 0U)
        {
            _MidiParser_FlowChartAction6Isr(pSelf, uRx);
        }
        else if (pSelf->uRunningStatus < MIDI_3B_STAGE1)
        {
            _MidiParser_FlowChartAction7Isr(pSelf, uRx);
        }
        else if (pSelf->uRunningStatus < MIDI_2B_STAGE1)
        {
            _MidiParser_FlowChartAction10Isr(pSelf, uRx);
        }
        else if (pSelf->uRunningStatus < MIDI_3B_STAGE2)
        {
            _MidiParser_FlowChartAction7Isr(pSelf, uRx);
        }
        else
        {
            if (pSelf->uRunningStatus == MIDI_ST_STAGE1)
            {
                _MidiParser_FlowChartAction8Isr(pSelf, uRx);
                _MidiParser_FlowChartAction7Isr(pSelf, uRx);
            }
            else if ((pSelf->uRunningStatus == MIDI_ST_STAGE3) ||
                     (pSelf->uRunningStatus == MIDI_ST_STAGE4))
            {
                _MidiParser_FlowChartAction9Isr(pSelf, uRx);
                _MidiParser_FlowChartAction10Isr(pSelf, uRx);
            }
            else
            {
                _MidiParser_FlowChartAction11Isr(pSelf, uRx);
            }
        }
    }

#if 0
    // 2021-07-29: trying out a simple echo for now
    // MergeOutput_SendByteIsr(&g_MergeOutput, uRx);
    if ((uRx & MIDI_REALTIME_MASK) == MIDI_REALTIME_MASK)
    {
        MergeOutput_SendByteIsr(&g_MergeOutput, uRx);
    }
    else
    {
        if ((uRx & MIDI_STATUS_MASK) > 0U)
        {
            /* there shouldn't be anything in the queue, but if there is
             * send it out */
            while (Queue_PopIsr(&(pSelf->queue), &uQueueItem) > 0U)
            {
                MergeOutput_SendByteIsr(&g_MergeOutput, uQueueItem);
            }
            Queue_PushIsr(&(pSelf->queue), uRx);
            
            if (((uRx & MIDI_NOTE_OFF_MASK) == MIDI_NOTE_OFF_MASK) ||
                ((uRx & MIDI_NOTE_ON_MASK) == MIDI_NOTE_ON_MASK) ||
                ((uRx & MIDI_POLY_PRESSURE_MASK) == MIDI_POLY_PRESSURE_MASK) ||
                ((uRx & MIDI_CTRL_CHANGE_MASK) == MIDI_CTRL_CHANGE_MASK) ||
                ((uRx & MIDI_PITCH_BEND_MASK) == MIDI_PITCH_BEND_MASK))
            {
                pSelf->uMessageLength = 3U;
                pSelf->uMessageCnt = 1U;
            }
            else if (((uRx & MIDI_PGM_CHANGE_MASK) == MIDI_PGM_CHANGE_MASK) ||
                     ((uRx & MIDI_CHNL_PRESSURE_MASK) == MIDI_CHNL_PRESSURE_MASK))
            {
                pSelf->uMessageLength = 2U;
                pSelf->uMessageCnt = 1U;
            }
            else
            {
                pSelf->uMessageLength = 1U;
                pSelf->uMessageCnt = 1U;
            }
        }
        else
        {
            /* compare the data to the message type and send as needed */
            pSelf->uMessageCnt = pSelf->uMessageCnt + 1U;
            if (pSelf->uMessageCnt >= pSelf->uMessageLength)
            {
                while (Queue_PopIsr(&(pSelf->queue), &uQueueItem) > 0U)
                {
                    MergeOutput_SendByteIsr(&g_MergeOutput, uQueueItem);
                }
                /* I shouldn't have an extra data byte, queue for sending */
                Queue_PushIsr(&(pSelf->queue), uRx);
            }
            else
            {
                Queue_PushIsr(&(pSelf->queue), uRx);
            }
        }
        // _MidiParser_HandleStateIsr(pSelf, uRx);
    }
        // pSelf->uData = uRx;
#endif /* if 0 */

#if 0
        Hal_IrqDisable();
        uMessage = (uint16_t)pSelf->uChannel;
        Hal_IrqEnable();
        EventQueue_PushIsr(&g_EventQueue, EV_MIDI_DATA, uMessage);
#endif
}

/**********************************************************************
 * MidiParser_Parse
 *
 * Notes
 * FSM to try out, based on SparkFun tutorial:
 *  if data is status
 *    if data is SysRealtime, pass data on
 *    else copy buffered data
 *  else
 *    buffer data
 *********************************************************************/
void MidiParser_Parse(MidiParser *pSelf)
{
    (void)pSelf;
#if 0
    uint8_t uTx;
#endif
    
    /* data is already buffered */
    /* how to pull all the items off when we see a status byte? */
#if 0
    if (MidiParser_Pop(pSelf, &uTx) > 0U)
    {
        MergeOutput_SendByte(&g_MergeOutput, uTx);
    }
#endif
}
