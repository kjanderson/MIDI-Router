#ifndef SPI_CTRL_H
#define SPI_CTRL_H

#include <stdint.h>

typedef enum _SpiState SpiState;
enum _SpiState
{
    SPI_ST_ECHO,
    SPI_ST_RESPONSE
};

typedef struct _SpiCtrl SpiCtrl;
struct _SpiCtrl
{
    SpiState eState;
    uint8_t uTxCnt;
    uint8_t uTxLength;
    uint8_t uRxCnt;
    uint8_t uRxLength;
    uint8_t txData[2];
    uint8_t rxData[2];
};

extern SpiCtrl g_SpiCtrl;

void SpiCtrl_Init(SpiCtrl *pSelf);
void SpiCtrl_RxIsr(SpiCtrl *pSelf, uint8_t uData);
void SpiCtrl_SendData(SpiCtrl *pSelf, uint8_t uData);

#endif /* SPI_CTRL_H */
