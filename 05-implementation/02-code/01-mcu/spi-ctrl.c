#include <stdint.h>
#include "hal.h"
#include "spi-ctrl.h"

void SpiCtrl_Ctor(SpiCtrl *pSelf)
{
    pSelf->uReady = 1U;
}

void SpiCtrl_RxIsr(SpiCtrl *pSelf, uint8_t uData)
{
    /* write only interface, so don't do anything with the data */
    (void)pSelf;
    (void)uData;
    Hal_GpioClrCfgSpiSs();
    
#if 0
    Hal_Timer2Clear();
    Hal_Timer2Restart();
#endif
}

void SpiCtrl_TickIsr(SpiCtrl *pSelf)
{
    pSelf->uReady = 1U;
}

void SpiCtrl_SendData(SpiCtrl *pSelf, uint8_t uData)
{
    Hal_IrqDisable();
    SpiCtrl_SendDataIsr(pSelf, uData);
    Hal_IrqEnable();
}

void SpiCtrl_SendDataIsr(SpiCtrl *pSelf, uint8_t uData)
{
    (void)pSelf;
    
    while(Hal_SpiTxReady() == 0)
    {
    }
    Hal_GpioSetCfgSpiSs();
    Hal_SpiSetTxData(uData);
#if 0
    if ((pSelf->uReady == 1U) && Hal_SpiTxReady())
    {
        Hal_GpioSetCfgSpiSs();
        pSelf->uReady = 0U;
        Hal_SpiSetTxData(uData);
    }
    else
    {
        /* drop data */
    }
#endif
}
