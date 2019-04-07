/**********************************************************************
 * File:   mccomm.h
 * Author: korwin
 *
 * Created on October 23, 2013, 6:53 PM
 *********************************************************************/

#ifndef MCCOMM_H
#define	MCCOMM_H

#include <stdint.h>
#include "hal.h"

#define MCCOMM_RX_BUF_SIZE 16
#define MCCOMM_TX_BUF_SIZE 16

/* header format: frame type | message length */
#define MCCOMM_HEADER_SIZE 2
#define MCCOMM_OFFSET_FRAME_TYPE 0
#define MCCOMM_OFFSET_LENGTH 1

/* data format: read command: read count | start address */
#define MCCOMM_OFFSET_RD_CNT 0
#define MCCOMM_OFFSET_RD_ADDR 1

#define MCCOMM_STX 0x55
#define MCCOMM_RD 0x01
#define MCCOMM_WR 0x02
#define MCCOMM_CFG_BLOCK 0x04
#define MCCOMM_RD_BLOCK 0x08
#define MCCOMM_DAT_BLOCK 0x10

#define MCCOMM_PARAMETER_CNT 10

typedef struct McCommTag McComm;
struct McCommTag
{
    uint8_t iRxBuf[MCCOMM_RX_BUF_SIZE];
    uint8_t iTxBuf[MCCOMM_TX_BUF_SIZE];
    uint8_t iTxIdx;

    uint16_t viParameters[MCCOMM_PARAMETER_CNT];
};

typedef enum eStateTag eState;
enum eStateTag
{
    MCCOMM_STATE_SYNC = 1,
    MCCOMM_STATE_HEADER,
    MCCOMM_STATE_DATA,
    MCCOMM_STATE_CRC
};

extern McComm gMcComm;

void McComm_Ctor(McComm *pSelf);

void McComm_RxIsr(McComm *pSelf, uint8_t iRx);
void McComm_TxIsr(McComm *pSelf);

#endif	/* MCCOMM_H */

