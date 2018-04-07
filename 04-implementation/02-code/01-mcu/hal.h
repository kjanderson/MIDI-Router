#ifndef HAL_H
#define HAL_H

#include <xc.h>
#include <stdint.h>

/* utility functions */
#define HAL_DIM(x) (sizeof((x))/sizeof((x[0])))

/* interrupt interface */
#define Hal_IrqDisable() __builtin_disi(0x3FFF)
#define Hal_IrqEnable() __builtin_disi(0x0000)

/* watchdog interface */
#define Hal_WatchdogReset() ClrWdt()

/* GPIO interface */
#define Hal_GpioSetReset() (LATC |= _LATC_LATC13_MASK)
#define Hal_GpioClrReset() (LATC &= ~(_LATC_LATC13_MASK))
#define Hal_GpioGetDone() (PORTC & _LATC_LATC14_MASK)
#define Hal_GpioClrCfgSpiSs() (PORTD &= ~(_LATD_LATD14_MASK))
#define Hal_GpioSetCfgSpiSs() (PORTD |= _LATD_LATD14_MASK)
#define Hal_GpioGetFbin0() (PORTG & _LATG_LATG6_MASK)
#define Hal_GpioGetFbin1() (PORTG & _LATG_LATG7_MASK)
#define Hal_GpioGetFbin2() (PORTG & _LATG_LATG8_MASK)
#define Hal_GpioGetFbin3() (PORTG & _LATG_LATG9_MASK)
#define Hal_GpioSetMode() (PORTF |= _LATF_LATF13_MASK)
#define Hal_GpioClrMode() (PORTF &= ~(_LATF_LATF13_MASK))
#define Hal_LedModeOn() (PORTF &= ~(_LATF_LATF13_MASK))
#define Hal_LedModeOff() (PORTF |= ~(_LATF_LATF13_MASK))

/* Timer interface */
#define Hal_Timer1Disable()
#define Hal_Timer1Restart()
#define Hal_Timer1Enable()
#define Hal_Timer1IsExpired() (1U)
#define Hal_Timer1Clear()

/* SPI interface */
#define Hal_Spi1TxBusy() (0U)
#define Hal_SpiSetTxData(x)
#define Hal_SpiGetRxData() (SPI1BUFL)
#define Hal_Spi1ClrInt()

void Hal_InitFpga(void);
void Hal_InitPeripherals(void);
void Hal_InitInterrupts(void);
void Hal_SpiInitForFpga(void);
void Hal_Timer1Config(uint16_t uTime, uint8_t uFlags);
void Hal_IdleTasks(void);

#endif /* HAL_H */
