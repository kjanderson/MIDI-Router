#ifndef HAL_H
#define HAL_H

#define Hal_IrqDisable()
#define Hal_IrqEnable()

#define HAL_DIM(x) (sizeof((x)) / sizeof((x[0])))

#define Hal_SpiSetTxData(x)
#define Hal_SpiTxReady() (1)

#endif /* HAL_H */

