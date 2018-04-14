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
#define Hal_GpioEnableOutputReset() (TRISA &= ~(_TRISA_TRISA4_MASK))
#define Hal_GpioDisableOutputReset() (TRISA |= (_TRISA_TRISA4_MASK))
/* CDONE is active high */
#define Hal_GpioGetDone() (PORTA & _LATA_LATA9_MASK)
#define Hal_GpioDisableOutputDone() (TRISA |= (_TRISA_TRISA9_MASK))
/* SPI_SS is active low */
#define Hal_GpioSetCfgSpiSs() (PORTC &= ~(_LATC_LATC3_MASK))
#define Hal_GpioClrCfgSpiSs() (PORTC |= _LATC_LATC3_MASK)
#define Hal_GpioEnableOutputSpiSs() (TRISC &= ~(_TRISC_TRISC3_MASK))
#define Hal_GpioDisableOutputSpiSs() (TRISC |= (_TRISC_TRISC3_MASK))
/* FBIN0 */
#define Hal_GpioGetFbin0() (PORTB & _LATB_LATB9_MASK)
#define Hal_GpioEnableOutputFbin0() (TRISB &= ~(_TRISB_TRISB9_MASK))
#define Hal_GpioDisableOutputFbin0() (TRISB |= (_TRISB_TRISB9_MASK))
/* FBIN1 */
#define Hal_GpioGetFbin1() (PORTC & _LATC_LATC6_MASK)
#define Hal_GpioEnableOutputFbin1() (TRISC &= ~(_TRISC_TRISC6_MASK))
#define Hal_GpioDisableOutputFbin1() (TRISC |= (_TRISC_TRISC6_MASK))
/* FBIN2 */
#define Hal_GpioGetFbin2() (PORTC & _LATC_LATC7_MASK)
#define Hal_GpioEnableOutputFbin2() (TRISC &= ~(_TRISC_TRISC7_MASK))
#define Hal_GpioDisableOutputFbin2() (TRISC |= (_TRISC_TRISC7_MASK))
/* FBIN3 */
#define Hal_GpioGetFbin3() (PORTC & _LATC_LATC8_MASK)
#define Hal_GpioEnableOutputFbin3() (TRISC &= ~(_TRISC_TRISC8_MASK))
#define Hal_GpioDisableOutputFbin3() (TRISC |= (_TRISC_TRISC8_MASK))
/* LED is active low */
#define Hal_GpioSetMode() (PORTB &= ~(_LATB_LATB4_MASK))
#define Hal_GpioClrMode() (PORTB |= _LATB_LATB4_MASK)
#define Hal_LedModeOn()   (PORTB &= ~(_LATB_LATB4_MASK))
#define Hal_LedModeOff()  (PORTB |= _LATB_LATB4_MASK)
#define Hal_GpioEnableOutputMode() (TRISB &= ~(_TRISB_TRISB4_MASK))
#define Hal_GpioDisableOutputMode() (TRISB |= (_TRISB_TRISB4_MASK))

/* Timer interface */
#define Hal_Timer1Disable() (T1CON &= ~(_T1CON_TON_MASK))
#define Hal_Timer1Enable() (T1CON |= _T1CON_TON_MASK)
#define Hal_Timer1IsExpired() (IFS0 & _IFS0_T1IF_MASK)
#define Hal_Timer1Clear() (IFS0 &= ~(_IFS0_T1IF_MASK))
#define Hal_Timer1Restart() (TMR1 = 0)

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
void Hal_Timer1Config(uint16_t uTicks, uint8_t uFlags);
void Hal_IdleTasks(void);

#endif /* HAL_H */
