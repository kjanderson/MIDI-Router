#include <stdio.h>
#include "hal.h"
#include "mccomm.h"

McComm gMcComm;

static uint16_t McComm_Crc16(uint16_t iInitValue, uint8_t iData);
static uint8_t McComm_GetFrameLength(McComm *pSelf);
static void McComm_SetFrameLength(McComm *pSelf, uint8_t iDataLength);
static uint8_t McComm_GetFrameType(McComm *pSelf);
static void McComm_SetFrameType(McComm *pSelf, uint8_t iFrameType);
static void McComm_RxMsg(McComm *pSelf);
static void McComm_Send(McComm *pSelf, uint8_t iDataLength);

const static uint16_t viCrc16[] = {
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50A5, 0x60C6, 0x70E7,
    0x8108, 0x9129, 0xA14A, 0xB16B, 0xC18C, 0xD1AD, 0xE1CE, 0xF1EF,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52B5, 0x4294, 0x72F7, 0x62D6,
    0x9339, 0x8318, 0xB37B, 0xA35A, 0xD3BD, 0xC39C, 0xF3FF, 0xE3DE,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64E6, 0x74C7, 0x44A4, 0x5485,
    0xA56A, 0xB54B, 0x8528, 0x9509, 0xE5EE, 0xF5CF, 0xC5AC, 0xD58D,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76D7, 0x66F6, 0x5695, 0x46B4,
    0xB75B, 0xA77A, 0x9719, 0x8738, 0xF7DF, 0xE7FE, 0xD79D, 0xC7BC,
    0x48C4, 0x58E5, 0x6886, 0x78A7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xC9CC, 0xD9ED, 0xE98E, 0xF9AF, 0x8948, 0x9969, 0xA90A, 0xB92B,
    0x5AF5, 0x4AD4, 0x7AB7, 0x6A96, 0x1A71, 0x0A50, 0x3A33, 0x2A12,
    0xDBFD, 0xCBDC, 0xFBBF, 0xEB9E, 0x9B79, 0x8B58, 0xBB3B, 0xAB1A,
    0x6CA6, 0x7C87, 0x4CE4, 0x5CC5, 0x2C22, 0x3C03, 0x0C60, 0x1C41,
    0xEDAE, 0xFD8F, 0xCDEC, 0xDDCD, 0xAD2A, 0xBD0B, 0x8D68, 0x9D49,
    0x7E97, 0x6EB6, 0x5ED5, 0x4EF4, 0x3E13, 0x2E32, 0x1E51, 0x0E70,
    0xFF9F, 0xEFBE, 0xDFDD, 0xCFFC, 0xBF1B, 0xAF3A, 0x9F59, 0x8F78,
    0x9188, 0x81A9, 0xB1CA, 0xA1EB, 0xD10C, 0xC12D, 0xF14E, 0xE16F,
    0x1080, 0x00A1, 0x30C2, 0x20E3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83B9, 0x9398, 0xA3FB, 0xB3DA, 0xC33D, 0xD31C, 0xE37F, 0xF35E,
    0x02B1, 0x1290, 0x22F3, 0x32D2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xB5EA, 0xA5CB, 0x95A8, 0x8589, 0xF56E, 0xE54F, 0xD52C, 0xC50D,
    0x34E2, 0x24C3, 0x14A0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xA7DB, 0xB7FA, 0x8799, 0x97B8, 0xE75F, 0xF77E, 0xC71D, 0xD73C,
    0x26D3, 0x36F2, 0x0691, 0x16B0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xD94C, 0xC96D, 0xF90E, 0xE92F, 0x99C8, 0x89E9, 0xB98A, 0xA9AB,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18C0, 0x08E1, 0x3882, 0x28A3,
    0xCB7D, 0xDB5C, 0xEB3F, 0xFB1E, 0x8BF9, 0x9BD8, 0xABBB, 0xBB9A,
    0x4A75, 0x5A54, 0x6A37, 0x7A16, 0x0AF1, 0x1AD0, 0x2AB3, 0x3A92,
    0xFD2E, 0xED0F, 0xDD6C, 0xCD4D, 0xBDAA, 0xAD8B, 0x9DE8, 0x8DC9,
    0x7C26, 0x6C07, 0x5C64, 0x4C45, 0x3CA2, 0x2C83, 0x1CE0, 0x0CC1,
    0xEF1F, 0xFF3E, 0xCF5D, 0xDF7C, 0xAF9B, 0xBFBA, 0x8FD9, 0x9FF8,
    0x6E17, 0x7E36, 0x4E55, 0x5E74, 0x2E93, 0x3EB2, 0x0ED1, 0x1EF0
};

/**********************************************************************
 * McComm_Crc16()
 *
 * Inputs:  crc
 *          data
 * Outputs: crc
 *
 * Functional description:
 * This function computes the CRC16-CCITT using the table above.
 *
 * Notes:
 * The CRC16-CCITT uses the following CRC polynomial:
 *  x^16 + x^12 + x^5 + 1
 *********************************************************************/
static uint16_t McComm_Crc16(uint16_t iCrc, uint8_t iData)
{
    uint16_t iResult;

    iResult = (uint16_t) ((uint32_t) iCrc << 8) ^ viCrc16[(iCrc >> 8) ^ iData];

    return iResult;
}

/**********************************************************************
 * McComm_Ctor()
 *
 * Inputs:  pointer to object
 * Outputs: none
 *
 * Functional description:
 * This constructor initializes the motor control object.
 *********************************************************************/
void McComm_Ctor(McComm *pSelf)
{
    uint16_t iCnt;

    for (iCnt = 0U; iCnt < MCCOMM_RX_BUF_SIZE; iCnt++)
    {
        pSelf->iRxBuf[iCnt] = 0U;
    }
    for (iCnt = 0U; iCnt < MCCOMM_TX_BUF_SIZE; iCnt++)
    {
        pSelf->iTxBuf[iCnt] = 0U;
    }
    pSelf->iTxIdx = (uint8_t)0;
}

/**********************************************************************
 * McComm_RxIsr()
 *
 * Inputs:  pointer to object
 *          received byte
 * Outputs: none
 *
 * Functional description:
 * This function runs the state machine that eventually posts
 * messages to the communication message delivery system.
 *
 * Notes:
 * This communication protocol sets up a general-purpose addressing
 * system and a streaming mechanism.
 *
 * The streaming request from the host issues a request to deliver
 * a block of stream data.
 *
 * The mailbox requests read and write data from the storage table.
 *
 * Format:
 *  read register(s):
 *   <STX> <READ> <number of registers> <starting address> <CRC16>
 *  read register response:
 *   <STX> <READ> <number of registers> <data> <CRC16>
 * 
 *  write register(s):
 *   <STX> <WRITE> <number of registers> <starting address> <data> <CRC16>
 *  write register response:
 *   <STX> <WRITE> <number of registers> <starting address> <CRC16>
 *
 *  configure block transfer:
 *   <STX> <BLOCK CFG> <number of registers> <addr 0> <addr 1> <addr 2> <addr 3> <CRC16>
 *  configure block transfer response:
 *   <STX> <BLOCK CFG> <number of registers> <addr 0> <addr 1> <addr 2> <addr 3> <CRC16>
 * 
 *  initiate block transfer:
 *   <STX> <BLOCK READ> <buffer count> <sparsing> <CRC16>
 *  block transfer response:
 *   <STX> <BLOCK READ> <buffer count> <sparsing> <CRC16>
 *   <STX> <BLOCK DATA> <record length> <data 0> <data 1> <data 2> <data 3> <CRC16>
 *********************************************************************/
void McComm_RxIsr(McComm *pSelf, uint8_t iRx)
{
    static eState eCurrentState = MCCOMM_STATE_SYNC;
    static uint16_t iCrc;
    static uint8_t iRxCnt;
    static uint8_t iDataLength;

    switch (eCurrentState)
    {
    case MCCOMM_STATE_SYNC:
        if (iRx == MCCOMM_STX)
        {
            eCurrentState = MCCOMM_STATE_HEADER;
            iCrc = (uint16_t) 0;
            iRxCnt = (uint16_t) 0;
            iDataLength = (uint8_t)0;
        }
        break;
    case MCCOMM_STATE_HEADER:
        pSelf->iRxBuf[iRxCnt] = iRx;
        iRxCnt++;
        iCrc = McComm_Crc16(iCrc, iRx);
        if (iRxCnt >= MCCOMM_HEADER_SIZE)
        {
            eCurrentState = MCCOMM_STATE_DATA;
        }
        break;
    case MCCOMM_STATE_DATA:
        pSelf->iRxBuf[iRxCnt] = iRx;
        iRxCnt++;
        iCrc = McComm_Crc16(iCrc, iRx);
        switch (McComm_GetFrameType(pSelf))
        {
        case MCCOMM_RD:
            /* a read request contains:
             *  | Header        || Data          |
             *  | STX | RD | N  || Start address | */
            iDataLength = (uint8_t) 1;
            break;
        case MCCOMM_WR:
            /* a write request contains (note each data item is two bytes):
             * | Header        || Data                                  |
             * | STX | WR | N  || Start address | data 0 | ... | data N-1 | */
            iDataLength = (uint8_t) 1 + (uint8_t) (McComm_GetFrameLength(pSelf) << (uint8_t) 1);
            break;
        case MCCOMM_CFG_BLOCK:
            /* a config block request contains a variable number of addresses */
            iDataLength = McComm_GetFrameLength(pSelf);
            break;
        case MCCOMM_RD_BLOCK:
            /* a read block request contains the sparsing indicator */
            iDataLength = (uint8_t) 1;
            break;
        default:
            iDataLength = (uint8_t) 0;
            break;
        }
        if (iRxCnt >= MCCOMM_HEADER_SIZE + iDataLength)
        {
            eCurrentState = MCCOMM_STATE_CRC;
        }
        break;
    case MCCOMM_STATE_CRC:
        pSelf->iRxBuf[iRxCnt] = iRx;
        iRxCnt++;
        if(iRxCnt >= MCCOMM_HEADER_SIZE + iDataLength + 2)
        {
            /* construct the 16-bit CRC field and compare it
             * to the computed CRC */
            if ((((uint16_t)pSelf->iRxBuf[iRxCnt-2] << (uint8_t)8)
                | (uint16_t)pSelf->iRxBuf[iRxCnt-1]) == iCrc)
            {
                /* process completed frame */
                McComm_RxMsg(pSelf);
                eCurrentState = MCCOMM_STATE_SYNC;
            }
            else
            {
                /* discard the frame */
                eCurrentState = MCCOMM_STATE_SYNC;
            }
        }
        break;
    default:
        /* discard the frame */
        eCurrentState = MCCOMM_STATE_SYNC;
        break;
    }
}

/**********************************************************************
 * McComm_RxIsr()
 *
 * Inputs:  pointer to object
 * Outputs: none
 *
 * Functional description:
 * This function processes a received message.
 *********************************************************************/
static void McComm_RxMsg(McComm *pSelf)
{
    switch (McComm_GetFrameType(pSelf))
    {
        /* received a request to read one or more data items */
    case MCCOMM_RD:
    {
        uint8_t iRegisterCnt;
        uint8_t iRegisterStart;
        uint8_t iCnt;

        /* a read request contains:
         *  | Header        || Data          |
         *  | STX | RD | N  || Start address |
         *  |     | 0  | 1  || 2             | */
        iRegisterCnt = pSelf->iRxBuf[(uint8_t)1];
        iRegisterStart = pSelf->iRxBuf[MCCOMM_HEADER_SIZE];
        /* a read response contains:
         *  | Header
         *  | STX | RD | N  || Start Addr | Data 0 | ... | Data N-1 |
         *  |     | 0  | 1  || 2          | 3-4    | ... | 2*N + 3+1| */
        McComm_SetFrameType(pSelf, MCCOMM_RD);
        pSelf->iTxBuf[(uint8_t)1] = iRegisterCnt;
        /* populate the message length below */
        pSelf->iTxBuf[MCCOMM_HEADER_SIZE] = iRegisterStart;
        for (iCnt = (uint8_t) 0; iCnt < iRegisterCnt; iCnt++)
        {
            if((iRegisterStart + iCnt) < MCCOMM_PARAMETER_CNT)
            {
                pSelf->iTxBuf[MCCOMM_HEADER_SIZE + (uint8_t)1 + iCnt*(uint8_t)2] = (uint8_t)(pSelf->viParameters[iRegisterStart + iCnt] >> (uint8_t) 8);
                pSelf->iTxBuf[MCCOMM_HEADER_SIZE + (uint8_t)1 + iCnt*(uint8_t)2 + (uint8_t)1] = (uint8_t)pSelf->viParameters[iRegisterStart + iCnt];
            }
        }
        McComm_Send(pSelf, iRegisterCnt*(uint8_t)2 + (uint8_t)1);
    }
        break;
    case MCCOMM_WR:
        break;
    case MCCOMM_CFG_BLOCK:
        break;
    case MCCOMM_RD_BLOCK:
        break;
    case MCCOMM_DAT_BLOCK:
        break;
    default:
        break;
    }
}

/**********************************************************************
 * McComm_Send()
 *
 * Inputs:  pointer to object
 * Outputs: none
 *
 * Functional description:
 * This function completes and sends a partially framed message.
 *
 * Notes:
 * This function populates the following fields:
 *  length
 *  CRC
 *********************************************************************/
static void McComm_Send(McComm *pSelf, uint8_t iDataLength)
{
    uint8_t iCnt;
    uint16_t iCrc;
    
    McComm_SetFrameLength(pSelf, iDataLength);
    iCrc = (uint16_t)0;
    for(iCnt=(uint8_t)0; iCnt<(MCCOMM_HEADER_SIZE + iDataLength); iCnt++)
    {
        iCrc = McComm_Crc16(iCrc, pSelf->iTxBuf[iCnt]);
    }
    /* add the CRC to the data frame */
    pSelf->iTxBuf[iCnt] = (uint8_t)(iCrc >> (uint8_t)8);
    iCnt++;
    pSelf->iTxBuf[iCnt] = (uint8_t)iCrc;

    /* mark the first byte as sent */
    pSelf->iTxIdx = (uint8_t)1;
    Hal_Uart1SendByte(pSelf->iTxBuf[(uint8_t)0]);
}

/**********************************************************************
 * McComm_TxIsr()
 *
 * Inputs:  pointer to object
 * Outputs: none
 *
 * Functional description:
 * This function keeps sending until the frame has been completely sent.
 *********************************************************************/
void McComm_TxIsr(McComm *pSelf)
{
    if(pSelf->iTxIdx < (MCCOMM_HEADER_SIZE + (uint8_t)1 + pSelf->iTxBuf[MCCOMM_HEADER_SIZE]*(uint8_t)2))
    {
        Hal_Uart1SendByte(pSelf->iTxBuf[pSelf->iTxIdx]);
        (pSelf->iTxIdx)++;
    }
}

static uint8_t McComm_GetFrameLength(McComm *pSelf)
{
    return pSelf->iRxBuf[MCCOMM_OFFSET_LENGTH];
}

static void McComm_SetFrameLength(McComm *pSelf, uint8_t iDataLength)
{
    pSelf->iTxBuf[MCCOMM_OFFSET_LENGTH] = iDataLength;
}

static uint8_t McComm_GetFrameType(McComm *pSelf)
{
    return pSelf->iRxBuf[MCCOMM_OFFSET_FRAME_TYPE];
}

static void McComm_SetFrameType(McComm *pSelf, uint8_t iFrameType)
{
    pSelf->iTxBuf[MCCOMM_OFFSET_FRAME_TYPE] = iFrameType;
}
