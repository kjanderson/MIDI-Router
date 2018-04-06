#include <xc.h>

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
static void _Hal_InitPmp(void);
static void _Hal_InitClock(void);
static void _Hal_InitCore(void);
static void _Hal_InitWatchdog(void);
static void _Hal_InitTimer(void);

/* configuration bits are defined in system.c */
/* TODO: prune it from system.c later */
// PIC24FJ128GB610 Configuration Bit Settings

// 'C' source line config statements

#if 0
// FSEC
#pragma config BWRP = OFF               // Boot Segment Write-Protect bit (Boot Segment may be written)
#pragma config BSS = DISABLED           // Boot Segment Code-Protect Level bits (No Protection (other than BWRP))
#pragma config BSEN = OFF               // Boot Segment Control bit (No Boot Segment)
#pragma config GWRP = OFF               // General Segment Write-Protect bit (General Segment may be written)
#pragma config GSS = DISABLED           // General Segment Code-Protect Level bits (No Protection (other than GWRP))
#pragma config CWRP = OFF               // Configuration Segment Write-Protect bit (Configuration Segment may be written)
#pragma config CSS = DISABLED           // Configuration Segment Code-Protect Level bits (No Protection (other than CWRP))
#pragma config AIVTDIS = OFF            // Alternate Interrupt Vector Table bit (Disabled AIVT)

//_FBSLIM(0x1FFF)
// FBSLIM
//#pragma config BSLIM = 0x1FFF           // Boot Segment Flash Page Address Limit bits (Boot Segment Flash page address  limit)

// FSIGN

// FOSCSEL
#pragma config FNOSC = FRCPLL           // Oscillator Source Selection (Fast RC Oscillator with divide-by-N with PLL module (FRCPLL) )
#pragma config PLLMODE = PLL96DIV2      // PLL Mode Selection (96 MHz PLL. (8 MHz input))
#pragma config IESO = OFF               // Two-speed Oscillator Start-up Enable bit (Start up with user-selected oscillator source)

// FOSC
#pragma config POSCMD = HS              // Primary Oscillator Mode Select bits (HS Crystal Oscillator Mode)
#pragma config OSCIOFCN = ON            // OSC2 Pin Function bit (OSC2 is general purpose digital I/O pin)
#pragma config SOSCSEL = OFF            // SOSC Power Selection Configuration bits (Digital (SCLKI) mode)
#pragma config PLLSS = PLL_FRC          // PLL Secondary Selection Configuration bit (PLL is fed by the on-chip Fast RC (FRC) oscillator)
#pragma config IOL1WAY = ON             // Peripheral pin select configuration bit (Allow only one reconfiguration)
#pragma config FCKSM = CSECMD           // Clock Switching Mode bits (Clock switching is enabled,Fail-safe Clock Monitor is disabled)

// FWDT
#pragma config WDTPS = PS32768          // Watchdog Timer Postscaler bits (1:32,768)
#pragma config FWPSA = PR128            // Watchdog Timer Prescaler bit (1:128)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable bits (WDT and SWDTEN disabled)
#pragma config WINDIS = OFF             // Watchdog Timer Window Enable bit (Watchdog Timer in Non-Window mode)
#pragma config WDTWIN = WIN25           // Watchdog Timer Window Select bits (WDT Window is 25% of WDT period)
#pragma config WDTCMX = WDTCLK          // WDT MUX Source Select bits (WDT clock source is determined by the WDTCLK Configuration bits)
#pragma config WDTCLK = LPRC            // WDT Clock Source Select bits (WDT uses LPRC)

// FPOR
#pragma config BOREN = ON               // Brown Out Enable bit (Brown Out Enable Bit)
#pragma config LPCFG = OFF              // Low power regulator control (No Retention Sleep)
#pragma config DNVPEN = ENABLE          // Downside Voltage Protection Enable bit (Downside protection enabled using ZPBOR when BOR is inactive)

// FICD
#pragma config ICS = PGD2               // ICD Communication Channel Select bits (Communicate on PGEC2 and PGED2)
#pragma config JTAGEN = OFF             // JTAG Enable bit (JTAG is disabled)
#pragma config BTSWP = OFF              // BOOTSWP Disable (BOOTSWP instruction disabled)

// FDEVOPT1
#pragma config ALTCMPI = DISABLE        // Alternate Comparator Input Enable bit (C1INC, C2INC, and C3INC are on their standard pin locations)
#pragma config TMPRPIN = OFF            // Tamper Pin Enable bit (TMPRN pin function is disabled)
#pragma config SOSCHP = ON              // SOSC High Power Enable bit (valid only when SOSCSEL = 1 (Enable SOSC high power mode (default))
#pragma config ALTVREF = ALTVREFDIS     // Alternate Voltage Reference Location Enable bit (VREF+ and CVREF+ on RB0, VREF- and CVREF- on RB1)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.
#endif /* 0 */

static void _Hal_InitGpio(void)
{
    /* test functions */
    TRISA = 0xFFFF;
    TRISB = 0xFFFF;
    TRISC = 0xFFFF;
    TRISD = 0xFFFF;
    TRISE = 0xFFFF;
    TRISG = 0xFFFF;
    
    Hal_GpioSetReset();
    Hal_GpioClrReset();
    (void)Hal_GpioGetDone();
    (void)Hal_GpioGetPmpD7();
    (void)Hal_GpioGetPmpD6();
    (void)Hal_GpioGetPmpD5();
    (void)Hal_GpioGetPmpD4();
    (void)Hal_GpioGetPmpD3();
    (void)Hal_GpioGetPmpD2();
    (void)Hal_GpioGetPmpD1();
    (void)Hal_GpioGetPmpD0();
    (void)Hal_GpioGetPmpRd();
    (void)Hal_GpioGetPmpWr();
    (void)Hal_GpioGetPmpBe0();
    (void)Hal_GpioGetPmpAck();
    (void)Hal_GpioGetPmpCs1();
    (void)Hal_GpioGetPmpBe1();
    (void)Hal_GpioGetPmpAll();
    (void)Hal_GpioGetPmpAlh();
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

static void _Hal_InitPmp(void)
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

void Hal_InitFpga(void)
{
    _Hal_InitClock();
    _Hal_InitCore();
    _Hal_InitTimer();
    _Hal_InitGpio();
    _Hal_InitSpiForFpga();
    
    Fpga_Configure();
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
    _Hal_InitPmp();
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
