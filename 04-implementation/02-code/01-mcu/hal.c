#include <xc.h>

#include "app.h"
#include "hal.h"

#include "system.h"

#include "app_device_cdc_basic.h"
#include "app_led_usb_status.h"

#include "usb.h"
#include "usb_device.h"
#include "usb_device_cdc.h"

#include "fpga.h"

/* private functions */
static void _Hal_InitGpio(void);
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
#pragma config DSBOREN = ON             // Deep Sleep BOR Enable bit (DSBOR Enabled)
#pragma config DSWDTEN = ON             // Deep Sleep Watchdog Timer Enable (DSWDT Enabled)
#pragma config DSSWEN = ON              // DSEN Bit Enable (Deep Sleep is controlled by the register bit DSEN)
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
#pragma config WDTCLK = SYSCLK          // WDT Clock Source Select bits (WDT uses system clock when active, LPRC while in Sleep mode)
#pragma config OSCIOFCN = ON            // OSCO Pin Configuration (OSCO/CLKO/RA3 functions as port I/O (RA3))
#pragma config FCKSM = CSDCMD           // Clock Switching and Fail-Safe Clock Monitor Configuration bits (Clock switching and Fail-Safe Clock Monitor are disabled)
#pragma config FNOSC = FRCPLL           // Initial Oscillator Select (Fast RC Oscillator with PLL module (FRCPLL))
#pragma config ALTRB6 = APPEND          // Alternate RB6 pin function enable bit (Append the RP6/ASCL1/PMPD6 functions of RB6 to RA1 pin functions)
#pragma config ALTCMPI = CxINC_RB       // Alternate Comparator Input bit (C1INC is on RB13, C2INC is on RB9 and C3INC is on RA0)
#pragma config WDTCMX = WDTCLK          // WDT Clock Source Select bits (WDT clock source is determined by the WDTCLK Configuration bits)
#pragma config IESO = ON                // Internal External Switchover (Enabled)

// CONFIG1
#pragma config WDTPS = PS32768          // Watchdog Timer Postscaler Select (1:32,768)
#pragma config FWPSA = PR128            // WDT Prescaler Ratio Select (1:128)
#pragma config WINDIS = OFF             // Windowed WDT Disable (Standard Watchdog Timer)
#pragma config FWDTEN = ON              // Watchdog Timer Enable (WDT enabled in hardware)
#pragma config ICS = PGx3               // Emulator Pin Placement Select bits (Emulator functions are shared with PGEC3/PGED3)
#pragma config LPCFG = OFF              // Low power regulator control (Disabled - regardless of RETEN)
#pragma config GWRP = OFF               // General Segment Write Protect (Write to program memory allowed)
#pragma config GCP = OFF                // General Segment Code Protect (Code protection is disabled)
#pragma config JTAGEN = ON              // JTAG Port Enable (Enabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

static void _Hal_InitGpio(void)
{
    /* test functions */
    TRISA = 0xFFFF;
    TRISB = 0xFFFF;
    TRISC = 0xFFFF;
    
    Hal_GpioSetReset();
    Hal_GpioClrReset();
    (void)Hal_GpioGetDone();
    (void)Hal_GpioGetFbin0();
    (void)Hal_GpioGetFbin1();
    (void)Hal_GpioGetFbin2();
    (void)Hal_GpioGetFbin3();
    (void)Hal_SpiGetRxData();
    Hal_GpioSetMode();
    Hal_GpioClrMode();
    Hal_LedModeOn();
    Hal_LedModeOff();
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
    /* clear the interrupt */
    IFS0 &= ~(_IFS0_SPI1IF_MASK);
    /* disable the interrupt */
    IEC0 &= ~(_IEC0_SPI1IE_MASK);
    
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
 *********************************************************************/
static void _Hal_InitSpi(void)
{
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
    OSCTUNbits.STEN = 1U;
    OSCTUNbits.STSIDL = 1U;
    OSCTUNbits.STSRC = 1U;
}

static void _Hal_InitCore(void)
{
}

static void _Hal_InitWatchdog(void)
{
}

static void _Hal_InitTimer(void)
{
}

uint8_t Hal_InitFpga(void)
{
    _Hal_InitClock();
    _Hal_InitCore();
    _Hal_InitTimer();
    _Hal_InitGpio();
    _Hal_InitSpiForFpga();
    
    return Fpga_Configure();
}

void Hal_InitPeripherals(void)
{
    SYSTEM_Initialize(SYSTEM_STATE_USB_START);

    USBDeviceInit();
    USBDeviceAttach();

    _Hal_InitClock();
    _Hal_InitCore();
    _Hal_InitTimer();
    _Hal_InitGpio();
    _Hal_InitSpiForFpga();
    _Hal_InitSpi();
    _Hal_InitTimer();
    _Hal_InitWatchdog();
}

void Hal_InitInterrupts(void)
{
}

void Hal_InitSpiForFpga(void)
{
    _Hal_InitSpiForFpga();
}

void Hal_Timer1Config(uint16_t uTime, uint8_t uOptions)
{
    (void)uTime;
    (void)uOptions;
}

void Hal_IdleTasks(void)
{
    SYSTEM_Tasks();

#if defined(USB_POLLING)
    USBDeviceTasks();
#endif

    //Application specific tasks
    APP_DeviceCDCBasicDemoTasks();
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
    IFS0 &= _IFS0_T1IF_MASK;
}
