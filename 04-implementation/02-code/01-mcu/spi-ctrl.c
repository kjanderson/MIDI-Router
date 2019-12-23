#include <stdio.h>
#include <stdint.h>
#include <hal.h>
#include "spi-ctrl.h"

void SpiCtrl_Init(SpiCtrl *pSelf)
{
    uint8_t uCnt;
    
    pSelf->eState = SPI_ST_ECHO;
    
    pSelf->uRxCnt = 0U;
    pSelf->uRxLength = 0U;
    pSelf->uTxCnt = 0U;
    pSelf->uTxLength = 0U;
    
    for (uCnt=0; uCnt<2; uCnt++)
    {
        pSelf->rxData[uCnt] = 0U;
        pSelf->txData[uCnt] = 0U;
    }
}

void SpiCtrl_RxIsr(SpiCtrl *pSelf, uint8_t uData)
{
    if (pSelf->uRxCnt < HAL_DIM(pSelf->rxData))
    {
        pSelf->rxData[pSelf->uRxCnt] = uData;
        pSelf->uRxCnt = pSelf->uRxCnt + 1U;
        
        if (pSelf->uTxCnt == pSelf->uTxLength)
        {
            /* send message to process the data frame */
        }
    }
    
    if (pSelf->uTxCnt < HAL_DIM(pSelf->txData) &&
        pSelf->uTxCnt < (pSelf->uTxLength))
    {
        Hal_SpiSetTxData(pSelf->txData[pSelf->uTxCnt]);
        pSelf->uTxCnt = pSelf->uTxCnt + 1U;
    }
}

void SpiCtrl_SendData(SpiCtrl *pSelf, uint8_t uData)
{
    Hal_IrqDisable();
    pSelf->txData[0U] = uData;
    pSelf->txData[1U] = 0U;
    pSelf->uTxLength = 2U;
    pSelf->uRxCnt = 0U;
    pSelf->uTxCnt = 1U;
    Hal_IrqEnable();
    if (Hal_SpiTxReady())
    {
        Hal_SpiSetTxData(pSelf->txData[0U]);
    }
}
