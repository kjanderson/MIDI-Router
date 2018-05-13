/**********************************************************************
 * main.c
 * 
 * Description
 * This program implements a test interface to determine if the electrical
 * interface between the MCU and FPGA was established correctly.
 * 
 * I/O
 *   SPI.MISO: this FPGA output is tested after configuration
 *   SPI.MOSI: this FPGA input is tested during configuration
 *   SPI.SCK:  this FPGA input is tested during configuration
 *   SPI.SS:   this FPGA input is tested during configuration
 *   FBIN.0:   this FPGA output is tested after configuration
 *   FBIN.1:   this FPGA output is tested after configuration
 *   FBIN.2:   this FPGA output is tested after configuration
 *   FBIN.3:   this FPGA output is tested after configuration
 *   MODE:     this MCU output is tested after configuration
 * TODO:
 *  1. troubleshoot REFO clock reference
 *********************************************************************/

#include "app.h"
#include "hal.h"

int main(void)
{
    uint8_t uFpgaResult;
    
    App_Init();
    
    uFpgaResult = Hal_InitFpga();
    App_SetFpgaMode(uFpgaResult);
    
    Hal_InitPeripherals();
    Hal_InitInterrupts();
    
    Hal_LedModeOn();
    
    for(;;)
    {
        Hal_WatchdogReset();
        Hal_IdleTasks();
        App_IdleTasks();
    }
    
    return (int)0;
}
