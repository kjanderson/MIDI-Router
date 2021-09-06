#ifndef SPI_CTRL_H
#define SPI_CTRL_H

#include <stdint.h>

typedef struct _SpiCtrl SpiCtrl;
struct _SpiCtrl
{
    uint8_t uReady;
};

extern SpiCtrl g_SpiCtrl;

void SpiCtrl_Ctor(SpiCtrl *pSelf);
void SpiCtrl_RxIsr(SpiCtrl *pSelf, uint8_t uData);
void SpiCtrl_TickIsr(SpiCtrl *pSelf);
void SpiCtrl_SendData(SpiCtrl *pSelf, uint8_t uData);
void SpiCtrl_SendDataIsr(SpiCtrl *pSelf, uint8_t uData);

#endif /* SPI_CTRL_H */
