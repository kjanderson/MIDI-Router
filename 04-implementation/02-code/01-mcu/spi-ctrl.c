#include <stdio.h>
#include <stdint.h>
#include <hal.h>
#include "spi-ctrl.h"

void SpiCtrl_Init(SpiCtrl *pSelf)
{
    uint8_t uCnt;
    
    pSelf->eState = SPI_ST_ECHO;
    
    for (uCnt=0; uCnt<2; uCnt++)
    {
        pSelf->rxData[uCnt] = 0U;
        pSelf->txData[uCnt] = 0U;
    }
}

void SpiCtrl_RxIsr(SpiCtrl *pSelf, uint8_t uData)
{
    switch (pSelf->eState)
    {
    case SPI_ST_ECHO:
        pSelf->eState = SPI_ST_RESPONSE;
        pSelf->rxData[0U] = uData;
        break;
    case SPI_ST_RESPONSE:
        pSelf->eState = SPI_ST_ECHO;
        break;
    default:
        pSelf->eState = SPI_ST_ECHO;
        break;
    }
}

void SpiCtrl_SendData(SpiCtrl *pSelf, uint8_t uData)
{
    pSelf->txData[0U] = uData;
    pSelf->txData[1U] = 0U;
    Hal_SpiSetTxData(pSelf->txData[0U]);
}
