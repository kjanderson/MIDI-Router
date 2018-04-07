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
/* CRESET is active low */
#define Hal_GpioSetReset() (LATA &= ~(_LATA_LATA4_MASK))
#define Hal_GpioClrReset() (LATA |= _LATA_LATA4_MASK)
/* CDONE is active high */
#define Hal_GpioGetDone() (PORTA & _LATA_LATA9_MASK)
/* SPI_SS is active low */
#define Hal_GpioSetCfgSpiSs() (PORTC &= ~(_LATC_LATC3_MASK))
#define Hal_GpioClrCfgSpiSs() (PORTC |= _LATC_LATC3_MASK)
#define Hal_GpioGetFbin0() (PORTB & _LATB_LATB9_MASK)
#define Hal_GpioGetFbin1() (PORTC & _LATC_LATC6_MASK)
#define Hal_GpioGetFbin2() (PORTC & _LATC_LATC7_MASK)
#define Hal_GpioGetFbin3() (PORTC & _LATC_LATC8_MASK)
/* LED is active low */
#define Hal_GpioSetMode() (PORTB &= ~(_LATB_LATB4_MASK))
#define Hal_GpioClrMode() (PORTB |= _LATB_LATB4_MASK)
#define Hal_LedModeOn()   (PORTB &= ~(_LATB_LATB4_MASK))
#define Hal_LedModeOff()  (PORTB |= _LATB_LATB4_MASK)

/* Timer interface */
#define Hal_Timer1Disable()
#define Hal_Timer1Restart()
#define Hal_Timer1Enable()
#define Hal_Timer1IsExpired() (1U)
#define Hal_Timer1Clear()

/* SPI interface */
#define Hal_Spi1TxBusy() (SPI1STATL & _SPI1STATL_SPIBUSY_MASK)
#define Hal_SpiSetTxData(x) (SPI1BUFL = (x))
#define Hal_SpiGetRxData() (SPI1BUFL)
#define Hal_Spi1ClrInt()

/* USB interface */
#define Hal_UsbDisableVbusPort() (TRISB |= _TRISB_TRISB7_MASK)

uint8_t Hal_InitFpga(void);
void Hal_InitPeripherals(void);
void Hal_InitInterrupts(void);
void Hal_SpiInitForFpga(void);
void Hal_Timer1Config(uint16_t uTime, uint8_t uFlags);
void Hal_IdleTasks(void);

#endif /* HAL_H */
