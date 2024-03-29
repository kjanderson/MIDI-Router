#include <stdint.h>
#include <xc.h>

#include "app.h"
#include "hal.h"
#include "spi-ctrl.h"
#include "globals.h"

#include "fpga.h"

/* private functions */
static void _Hal_InitGpio(uint8_t uMode);
static void _Hal_InitSpiForFpga(void);
static void _Hal_InitSpi(void);
static void _Hal_InitClock(void);
static void _Hal_InitCore(void);
static void _Hal_InitWatchdog(void);
static void _Hal_InitTimer(void);

// PIC24FJ128GB204 Configuration Bit Settings

// 'C' source line config statements

// CONFIG4
#pragma config DSWDTPS = DSWDTPS1F      // Deep Sleep Watchdog Timer Postscale Select bits (1:68719476736 (25.7 Days))
#pragma config DSWDTOSC = LPRC          // DSWDT Reference Clock Select (DSWDT uses LPRC as reference clock)
#pragma config DSBOREN = OFF            // Deep Sleep BOR Enable bit (DSBOR Disabled)
#pragma config DSWDTEN = OFF            // Deep Sleep Watchdog Timer Enable (DSWDT Disabled)
#pragma config DSSWEN = OFF             // DSEN Bit Enable (Deep Sleep operation is always disabled)
#pragma config PLLDIV = DIVIDE2         // USB 96 MHz PLL Prescaler Select bits (Oscillator input divided by 2 (8 MHz input))
#pragma config I2C1SEL = DISABLE        // Alternate I2C1 enable bit (I2C1 uses SCL1 and SDA1 pins)
#pragma config IOL1WAY = OFF            // PPS IOLOCK Set Only Once Enable bit (The IOLOCK bit can be set and cleared using the unlock sequence)

// CONFIG3
#pragma config WPFP = WPFP127           // Write Protection Flash Page Segment Boundary (Page 127 (0x1FC00))
#pragma config SOSCSEL = OFF            // SOSC Selection bits (Digital (SCLKI) mode)
#pragma config WDTWIN = PS25_0          // Window Mode Watchdog Timer Window Width Select (Watch Dog Timer Window Width is 25 percent)
#pragma config PLLSS = PLL_FRC          // PLL Secondary Selection Configuration bit (PLL is fed by the on-chip Fast RC (FRC) oscillator)
#pragma config BOREN = ON               // Brown-out Reset Enable (Brown-out Reset Enable)
#pragma config WPDIS = WPDIS            // Segment Write Protection Disable (Disabled)
#pragma config WPCFG = WPCFGDIS         // Write Protect Configuration Page Select (Disabled)
#pragma config WPEND = WPENDMEM         // Segment Write Protection End Page Select (Write Protect from WPFP to the last page of memory)

// CONFIG2
#pragma config POSCMD = NONE            // Primary Oscillator Select (Primary Oscillator Disabled)
#pragma config WDTCLK = LPRC            // WDT Clock Source Select bits (WDT uses LPRC)
#pragma config OSCIOFCN = ON            // OSCO Pin Configuration (OSCO/CLKO/RA3 functions as port I/O (RA3))
#pragma config FCKSM = CSDCMD           // Clock Switching and Fail-Safe Clock Monitor Configuration bits (Clock switching and Fail-Safe Clock Monitor are disabled)
#pragma config FNOSC = FRCPLL           // Initial Oscillator Select (Fast RC Oscillator with PLL module (FRCPLL))
#pragma config ALTRB6 = APPEND          // Alternate RB6 pin function enable bit (Append the RP6/ASCL1/PMPD6 functions of RB6 to RA1 pin functions)
#pragma config ALTCMPI = CxINC_RB       // Alternate Comparator Input bit (C1INC is on RB13, C2INC is on RB9 and C3INC is on RA0)
#pragma config WDTCMX = WDTCLK          // WDT Clock Source Select bits (WDT clock source is determined by the WDTCLK Configuration bits)
#pragma config IESO = OFF               // Internal External Switchover (Disabled)

// CONFIG1
#pragma config WDTPS = PS32768          // Watchdog Timer Postscaler Select (1:32,768)
#pragma config FWPSA = PR128            // WDT Prescaler Ratio Select (1:128)
#pragma config WINDIS = OFF             // Windowed WDT Disable (Standard Watchdog Timer)
#pragma config FWDTEN = SWON            // Watchdog Timer Enable (WDT controlled with the SWDTEN bit)
#pragma config ICS = PGx3               // Emulator Pin Placement Select bits (Emulator functions are shared with PGEC3/PGED3)
#pragma config LPCFG = OFF              // Low power regulator control (Disabled - regardless of RETEN)
#pragma config GWRP = OFF               // General Segment Write Protect (Write to program memory allowed)
#pragma config GCP = OFF                // General Segment Code Protect (Code protection is disabled)
#pragma config JTAGEN = OFF             // JTAG Port Enable (Disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

/**********************************************************************
 * _Hal_InitGpio
 *
 * Description
 * This function initializes the GPIO module, including the
 * peripheral crossbar and clock output.
 *
 * Notes
 *  GP Inputs:
 *  GP Outputs: LED Mode (RB4)
 *  CRESET:     FPGA reset (RA4)
 *  GP Outputs: SPI #SS  (RC3)
 *  SPI ports:  SPI MOSI
 *              SPI MISO
 *              SPI SCK
 *  Core frequency: 32 MHz
 *  Core clock: 16 MHz
 *  Clk Output: REFO (250 KHz) (RB13)
 *********************************************************************/
static void _Hal_InitGpio(uint8_t uMode)
{
    /* enable outputs */
    TRISA = 0xFFFF;
    TRISB = 0xFFFF;
    TRISC = 0xFFFF;
    /* disable analog function on pin 1 */
    ANSBbits.ANSB9 = 0;
    // Hal_GpioEnableOutputSpiSs();
    // Hal_GpioClrCfgSpiSs();
    Hal_GpioEnableOutputMode();
    Hal_GpioEnableOutputReset();
    
    Hal_GpioSetReset();
    Hal_LedModeOff();
    
    /* configure PPS registers */
    __builtin_write_OSCCONL(OSCCON & ~(0x40));
    /* SPI1:
     *  SCK  on RP20, pin 37 (function 8)
     *  MOSI on RP21, pin 38 (function 7)
     *  SS   on GPIO RC3
     *  MISO on RP7, pin 43
     *  OC1  on RP13, pin 11 */
    if (uMode == 0U)
    {
        RPOR10bits.RP20R = 8;
        RPOR10bits.RP21R = 7;
        RPOR6bits.RP13R = 13;
        RPINR20bits.SDI1R = 7;
    }

    /* UART U1: RP9 */
    RPINR18bits.U1RXR = 9;
    /* UART U2: RP22 */
    RPINR19bits.U2RXR = 22;
    /* UART U3: RP23 */
    RPINR17bits.U3RXR = 23;
    /* UART U4: RP24 */
    RPINR27bits.U4RXR = 24;
    
    /* set RP23 to UART4 TX */
    //RPOR11bits.RP23R = 21U;
    /* set RP24 to UART4 TX */
    //RPOR12bits.RP24R = 21U;
    if (uMode == 1U)
    {
        /* set RP21 to UART4 TX */
        RPOR10bits.RP21R = 21U;
    }
    
    __builtin_write_OSCCONL(OSCCON |   0x40);
    
    REFOCONL = 0x9000U;
    REFOCONH = 0x001FU;
}

/**********************************************************************
 * _Hal_InitSpiForFpga
 * 
 * Description
 * This function initializes hardware to configure the FPGA.
 * The FPGA expects the following for configuration:
 *   data sampled during SCK rising edge (CKE=0, CKP=1)
 *   data bytes are sent MSb first
 *   SCK frequency shall be between 1 MHz and 25 MHz
 *   choose 2 MHz: primary prescale 4:1, secondary prescale 2:1
 * 
 * TODO:
 *   set these settings from the datasheet
 *********************************************************************/
static void _Hal_InitSpiForFpga(void)
{
    /* clear the interrupts */
    IFS0 &= ~(_IFS0_SPI1IF_MASK);
    IFS0 &= ~(_IFS0_SPI1TXIF_MASK);
    IFS3 &= ~(_IFS3_SPI1RXIF_MASK);
    /* disable the interrupt */
    IEC0 &= ~(_IEC0_SPI1IE_MASK);
    IEC0 &= ~(_IEC0_SPI1TXIE_MASK);
    IEC3 &= ~(_IEC3_SPI1RXIE_MASK);
    
    /* SPI1CON1 settings
     *  8-bit data
     *  SS pin controlled as GPIO
     *  CKE = 0
     *  CKP = 1
     *  master mode
     */
    SPI1CON1L = 0x0060U;
    /* ignore receiver overflow
     * ignore transmit underrun
     */
    SPI1CON1H = 0x3000U;
    /* SPI1CON2 settings */
    
    SPI1CON2 = 0U;
    SPI1CON2L = 0U;
    /* SPI1CON3 settings */
    SPI1CON3 = 0U;
    /* SPI1STAT settings */
    SPI1STATL = 0U;
    SPI1STATH = 0U;
    /* SPI1MSK settings */
    SPI1IMSKL = 0U;
    SPI1IMSKH = 0U;
    /* baud rate settings */
    SPI1BRGL = 0U;
    /* enable the module */
    SPI1CON1Lbits.SPIEN = 1U;
    
    /* polling mode for FPGA configuration, so don't turn on interrupts */
}


/**********************************************************************
 * _Hal_InitSpi
 * 
 * Description
 * This function initializes the SPI port for application use.
 * 
 * SCK frequency is 16 MHz
 *   data sampled during SCK falling edge (CKE=1, CKP=1)
 *   data bytes are sent MSb first
 *   SCK frequency shall be 125 kHz
 *   choose 125 kHz: primary prescale 4:1, secondary prescale 2:1
 *********************************************************************/
static void _Hal_InitSpi(void)
{
    /* disable and reset the module */
    SPI1CON1L = 0x0000U;
    SPI1CON1H = 0x0000U;
    
    /* clear the interrupt flags */
    IFS0 &= ~(_IFS0_SPI1IF_MASK);
    IFS0 &= ~(_IFS0_SPI1TXIF_MASK);
    IFS3 &= ~(_IFS3_SPI1RXIF_MASK);
    /* disable the interrupts */
    IEC0 &= ~(_IEC0_SPI1IE_MASK);
    IEC0 &= ~(_IEC0_SPI1TXIE_MASK);
    IEC3 &= ~(_IEC3_SPI1RXIE_MASK);
    
    /* SPI1CON2 settings */
    SPI1CON2 = 0U;
    SPI1CON2L = 0U;
    /* SPI1CON3 settings */
    SPI1CON3 = 0U;
    
    /* clear the interrupt flags */
    IFS0 &= ~(_IFS0_SPI1IF_MASK);
    IFS0 &= ~(_IFS0_SPI1TXIF_MASK);
    IFS3 &= ~(_IFS3_SPI1RXIF_MASK);
    
    /* set interrupt priority */
    IPC14bits.SPI1RXIP = 4;
    
    /* turn on RXIF interrupt */
    IEC3 |= _IEC3_SPI1RXIE_MASK;
    
    /* baud rate settings
         - 8 MHz peripheral clock
         - 125 kHz SPI clock
     */
    SPI1BRGL = 0x1FU;
    
    /* SPI1STAT settings
     *   clear SPIROV flag
     *   clear all the other flags
     */
    SPI1STATL = 0U;
    SPI1STATH = 0U;
    
    /* SPI1MSK settings
     *   see page 55 of 70005136a.pdf */
    SPI1IMSKLbits.SPIRBFEN = 1;
    // SPI1IMSKLbits.SPIRBFEN = 1;
    SPI1IMSKH = 0U;
    
    /* SPI1CON1 settings
     *  8-bit data
     *  SS pin controlled as GPIO
     *  CKE = 1
     *  CKP = 1
     *  master mode
     */
    SPI1CON1L = 0x0160U;
    /* ignore receiver overflow
     * ignore transmit underrun
     */
    SPI1CON1H = 0x3000U;
    
    /* enable the module */
    SPI1CON1Lbits.SPIEN = 1U;
    
    /* turn on interrupts */
}

/**********************************************************************
 * _Hal_InitClock
 * 
 * Description
 * This function initializes the oscillator and any affected functions.
 * 
 * Notes
 * The USB OTG module requires:
 *   48 MHz USB clock
 *   FRC self tune feature (to maintain required clock accuracy)
 *   FRC self tuning feature set by OSCTUN register (STEN=1, STSRC=1)
 * 
 * Settings
 * The following settings apply:
 *   Input clock (FRC) is 8 MHz
 *   PLLMODE (div by 2) set to 0001 to select 4 MHz PLL input (required)
 *   CPDIV set to 00 to select 32 MHz system clock
 *
 * Update
 * The following settings apply:
 *   Input clock (FRCDIV) is 500 kHz
 *   CPDIV set to 00 to select 500 kHz system clock
 *********************************************************************/
static void _Hal_InitClock(void)
{
    /* this is the default value, so I probably don't need to set this */
    CLKDIVbits.CPDIV = 0U;
    
    /* turn on FRC self tuning
     *  enable self tuning
     *  stop in idle mode
     *  use USB clock as reference
     */
#if 0
    OSCTUNbits.STEN = 1U;
    OSCTUNbits.STSIDL = 1U;
    OSCTUNbits.STSRC = 1U;
#endif
}

/**********************************************************************
 * _Hal_InitCore
 * 
 * Description
 * Initialize any core-specific registers, if any.
 *********************************************************************/
static void _Hal_InitCore(void)
{
}

/**********************************************************************
 * _Hal_InitWatchdog
 * 
 * Description
 * Start the watchdog timer.
 *********************************************************************/
static void _Hal_InitWatchdog(void)
{
    Hal_WatchdogEnable();
}

/**********************************************************************
 * _Hal_InitTimer
 * 
 * Description
 * Initialize timer 1 for 1 1-msec overflow time.
 *********************************************************************/
static void _Hal_InitTimer(void)
{
    T1CON = 0U;
    PR1 = 16000U;
    T1CON = 0x8000U;
    
    /* 1 byte time of the 125 KHz SPI clock */
    T2CON = 0U;
    PR2 = 640U;
    T2CON = 0x8000U;
    
    /* 320 usec: 1 UART byte time */
    T3CON = 0U;
    // PR3 = 2560U;
    PR3 = 4000U;
    T3CON = 0x8000U;
}

static void _Hal_InitUart(void)
{
    U1MODE = 0U;
    U1BRG = 15U;
    U1MODEbits.UARTEN = 1;
    U1STA = 0U;
    U1STAbits.URXEN = 1;
    
    U2MODE = 0U;
    U2BRG = 15U;
    U2MODEbits.UARTEN = 1;
    U2STA = 0U;
    U2STAbits.URXEN = 1;
    
    U3MODE = 0U;
    U3BRG = 15U;
    U3MODEbits.UARTEN = 1;
    U3STA = 0U;
    U3STAbits.URXEN = 1;
    
    U4MODE = 0U;
    U4BRG = 15U;
    U4MODEbits.UARTEN = 1;
    U4STA = 0U;
    U4STAbits.URXEN = 1;
    U4STAbits.UTXEN = 1;
}

/**********************************************************************
 * Hal_InitFpga
 * 
 * Description
 * Initialize minimum peripherals to support FPGA configuration.
 * 
 * Requirements
 *   SCK between 1 MHz and 25 MHz
 *   CKE=0
 *   CKP=1
 *   Timer1 configured to support timing of SPI frames and reset
 *   Reset configured as an output
 *********************************************************************/
uint8_t Hal_InitFpga(void)
{
    _Hal_InitClock();
    _Hal_InitCore();
    _Hal_InitTimer();
    _Hal_InitGpio(0U);
    _Hal_InitSpiForFpga();
    
    return Fpga_Configure();
}

/**********************************************************************
 * Hal_InitPeripherals
 * 
 * Description
 * Final initialization of MCU peripherals.
 *********************************************************************/
void Hal_InitPeripherals(void)
{
    _Hal_InitClock();
    _Hal_InitCore();
    _Hal_InitTimer();
    _Hal_InitGpio(1U);
    // _Hal_InitSpi();
    _Hal_InitTimer();
    _Hal_InitUart();
    _Hal_InitWatchdog();
}


/**********************************************************************
 * Hal_InitInterrupts
 * 
 * Description
 * Initialize interrupts for the application.
 *********************************************************************/
void Hal_InitInterrupts(void)
{
    /* clear Timer1 interrupt */
    IFS0 &= ~(_IFS0_T1IF_MASK);
    /* turn on Timer1 interrupt */
    IEC0 |= _IEC0_T1IE_MASK;
    
    /* clear Timer2 interrupt */
    // IFS0 &= ~(_IFS0_T2IF_MASK);
    /* turn on Timer2 interrupt */
    // IEC0 |= _IEC0_T2IE_MASK;
    
    /* clear Timer3 interrupt */
    // IFS0 &= ~(_IFS0_T3IF_MASK);
    /* turn on Timer3 interrupt */
    // IEC0 |= _IEC0_T3IE_MASK;
    
    /* turn on UART interrupts: U1RX, U2RX, U3RX, U4TX */
    IFS0 &= ~(_IFS0_U1RXIF_MASK);
    IEC0 |= _IEC0_U1RXIE_MASK;
    IFS0 &= ~(_IFS1_U2RXIF_MASK);
    IEC1 |= _IEC1_U2RXIE_MASK;
    IFS5 &= ~(_IFS5_U3RXIF_MASK);
    IEC5 |= _IEC5_U3RXIE_MASK;
    IFS5 &= ~(_IFS5_U4TXIF_MASK);
    IEC5 |= _IEC5_U4TXIE_MASK;
    IFS5 &= ~(_IFS5_U4RXIF_MASK);
    IEC5 |= _IEC5_U4RXIE_MASK;
    
    /* interrupt for SPI1 was turned on during initialization */
}

void Hal_InitSpiForFpga(void)
{
    _Hal_InitSpiForFpga();
}

void Hal_SpiSetTxData(uint8_t uData)
{
    SPI1BUFL = (uint16_t)uData;
    SPI1BUFH = (uint16_t)0;
}

void Hal_Timer1Config(uint16_t uTicks, uint8_t uOptions)
{
    (void)uOptions;
    
    T1CON = 0U;
    PR1 = uTicks;
    T1CON = 0x8000U;
}

void Hal_Timer2Config(uint16_t uTicks, uint8_t uOptions)
{
    (void)uOptions;
    
    T2CON = 0U;
    PR2 = uTicks;
    T2CON = 0x8000U;
}

/* candidate for removal, since this was added to support device-specific
 * USB functions */
void Hal_IdleTasks(void)
{
}

/**********************************************************************
 * Hal_EraseFlashSector
 * 
 * Description
 * Erase the Flash sector that contains the specified address.
 *********************************************************************/
void Hal_EraseFlashSector(uint32_t uBaseAddress)
{
    uint32_t progAddr;
    uint16_t offset;
    
    progAddr = uBaseAddress & ~(HAL_BYTES_PER_SECTOR - 1U);
    
    TBLPAG = progAddr >> 16;
    offset = (uint16_t)(progAddr & (uint32_t)0xFFFF);
    __builtin_tblwtl(offset, 0x0000);
    /* NVMCON:
     *   WREN = 1
     *   ERASE = 1
     *   NVMOP = 0010
     */
    NVMCON = 0x4042;
    __builtin_disi(0x0005);
    __builtin_write_NVM();
}

/**********************************************************************
 * Hal_WriteFlashPage
 * 
 * Description
 * Write data to the specified flash page.
 *********************************************************************/
void Hal_WriteFlashPage(uint32_t uBaseAddress, uint8_t *vuData)
{
    uint32_t progAddr;
    uint16_t offset;
    uint16_t progDataL;
    uint8_t progDataH;
    uint16_t uCnt;
    uint32_t insnIndex;
    
    progAddr = uBaseAddress & ~(HAL_BYTES_PER_SECTOR - 1U);
    
    /* NVMCON:
     *   WREN = 1
     *   ERASE = 0
     *   NVMOP = 0001
     */
    NVMCON = 0x4001;
    /*
    TBLPAG = progAddr >> 16;
    offset = (uint16_t)(progAddr & (uint32_t)0xFFFF);
    __builtin_tblwtl(offset, progDataL);
    __builtin_tblwth(offset, progDataH);
     */
    TBLPAG = progAddr >> 16;
    for (uCnt = 0U; uCnt < (uint16_t)(HAL_INSNS_PER_PAGE); uCnt++)
    {
        insnIndex = (uint32_t)uCnt;
        offset = (uint16_t)((progAddr + insnIndex) & (uint32_t)0xFFFF);
        progDataL = vuData[uCnt];
        progDataH = 0;
        __builtin_tblwtl(offset, progDataL);
        __builtin_tblwth(offset, progDataH);
    }
    
    __builtin_disi(0x0005);
    __builtin_write_NVM();
}

/**********************************************************************
 **********************************************************************
 * TRAPS
 **********************************************************************
 *********************************************************************/

void __attribute__((__interrupt__, auto_psv)) _OscillatorFail(void)
{
    for(;;)
    {
        Hal_WatchdogReset();
    }
}

void __attribute__((__interrupt__, auto_psv)) _AddressError(void)
{
    for(;;)
    {
        Hal_WatchdogReset();
    }
}

void __attribute__((__interrupt__, auto_psv)) _StackError(void)
{
    for(;;)
    {
        Hal_WatchdogReset();
    }
}

void __attribute__((__interrupt__, auto_psv)) _MathError(void)
{
    for(;;)
    {
        Hal_WatchdogReset();
    }
}

/**********************************************************************
 **********************************************************************
 * ISR's, if applicable
 **********************************************************************
 *********************************************************************/

void __attribute__((__interrupt__, auto_psv)) _T1Interrupt(void)
{
    App_TickIsr();
    
    /* clear the interrupt to receive more timer interrupts */
    IFS0 &= ~(_IFS0_T1IF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _T2Interrupt(void)
{
    // SpiCtrl_TickIsr(&g_SpiCtrl);
    
    /* clear the interrupt to receive more timer interrupts */
    IFS0 &= ~(_IFS0_T2IF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _T3Interrupt(void)
{
    // MergeOutput_TickIsr(&g_MergeOutput);
    
    /* clear the interrupt to receive more timer interrupts */
    IFS0 &= ~(_IFS0_T3IF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _SPI1RXInterrupt(void)
{
    // SpiCtrl_RxIsr(&g_SpiCtrl, SPI1BUFL);
    
    IFS3 &= ~(_IFS3_SPI1RXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U1RXInterrupt(void)
{
    uint8_t uRx;
    
    uRx = U1RXREG;
    MidiParser_RxIsr(&g_MidiParser1, uRx);
    
    IFS0 &= ~(_IFS0_U1RXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void)
{
    uint8_t uRx;
    
    uRx = U2RXREG;
    MidiParser_RxIsr(&g_MidiParser2, uRx);
    
    IFS1 &= ~(_IFS1_U2RXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U3RXInterrupt(void)
{
    uint8_t uRx;
    
    uRx = U3RXREG;
    MidiParser_RxIsr(&g_MidiParser3, uRx);
    
    IFS5 &= ~(_IFS5_U3RXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U4RXInterrupt(void)
{
    uint8_t uRx;
    
    uRx = U4RXREG;
    MidiParser_RxIsr(&g_MidiParser4, uRx);
    
    IFS5 &= ~(_IFS5_U4RXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U1TXInterrupt(void)
{
    IFS0 &= ~(_IFS0_U1TXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U2TXInterrupt(void)
{
    IFS1 &= ~(_IFS1_U2TXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U3TXInterrupt(void)
{
    IFS5 &= ~(_IFS5_U3TXIF_MASK);
}

void __attribute__((__interrupt__, auto_psv)) _U4TXInterrupt(void)
{
    MergeOutput_TxIsr(&g_MergeOutput);
    IFS5 &= ~(_IFS5_U4TXIF_MASK);
}
