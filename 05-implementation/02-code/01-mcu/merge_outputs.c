#include "hal.h"
#include "merge_outputs.h"
#include "spi-ctrl.h"

void MergeOutput_Ctor(MergeOutput *pSelf)
{
    Queue_Ctor(&(pSelf->queue));
    pSelf->uBusy = 0U;
}

void MergeOutput_SendByte(MergeOutput *pSelf, uint8_t uTx)
{
    Hal_IrqDisable();
    MergeOutput_SendByteIsr(pSelf, uTx);
    Hal_IrqEnable();
}

void MergeOutput_SendByteIsr(MergeOutput *pSelf, uint8_t uTx)
{
#if 0
    /* 2021-07-29: attempting a dumb echo */
    //SpiCtrl_SendDataIsr(&g_SpiCtrl, uTx);
    if (pSelf->uBusy > 0U)
    {
        Queue_PushIsr(&(pSelf->queue), uTx);
    }
    else
    {
        SpiCtrl_SendDataIsr(&g_SpiCtrl, uTx);
#if 0
        pSelf->uBusy = 1U;
        Hal_Timer3Clear();
        Hal_Timer3Restart();
#endif
    }
#endif
    if (pSelf->uBusy > 0U)
    {
        Queue_PushIsr(&(pSelf->queue), uTx);
    }
    else
    {
        Hal_Uart4SetDataByte(uTx);
        pSelf->uBusy = 1U;
    }
}

void MergeOutput_TxIsr(MergeOutput *pSelf)
{
    uint8_t uTx;

    if (Queue_PopIsr(&(pSelf->queue), &uTx) == 1U)
    {
        Hal_Uart4SetDataByte(uTx);
    }
    else
    {
        pSelf->uBusy = 0U;
    }
}

void MergeOutput_TickIsr(MergeOutput *pSelf)
{
#if 0
    uint8_t uTx;

    if (Queue_PopIsr(&(pSelf->queue), &uTx) == 1U)
    {
        SpiCtrl_SendDataIsr(&g_SpiCtrl, uTx);
    }
    else
    {
        pSelf->uBusy = 0U;
    }
#endif
}
