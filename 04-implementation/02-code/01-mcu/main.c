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
 *   PMP.D7:   this FPGA output is tested after configuration
 *   PMP.D6:   this FPGA output is tested after configuration
 *   PMP.D5:   this FPGA output is tested after configuration
 *   PMP.D4:   this FPGA output is tested after configuration
 *   PMP.D3:   this FPGA output is tested after configuration
 *   PMP.D2:   this FPGA output is tested after configuration
 *   PMP.D1:   this FPGA output is tested after configuration
 *   PMP.D0:   this FPGA output is tested after configuration
 *   PMP.BE0:  this FPGA output is tested after configuration
 *   PMP.BE1:  this FPGA output is tested after configuration
 *   PMP.RD:   this FPGA output is tested after configuration
 *   PMP.WR:   this FPGA output is tested after configuration
 *   PMP.ACK:  this FPGA output is tested after configuration
 *   PMP.ALL:  this FPGA output is tested after configuration
 *   PMP.ALH:  this FPGA output is tested after configuration
 *   PMP.CS1:  this FPGA output is tested after configuration
 *   FBIN.1:   this FPGA output is tested after configuration
 *   FBIN.2:   this FPGA output is tested after configuration
 *   FBIN.3:   this FPGA output is tested after configuration
 *   MODE:     this MCU output is tested after configuration
 * TODO:
 *  1. verify configuration bits
 *  2. setup LED mode logic
 *********************************************************************/

#include "hal.h"

int main(void)
{
    uint8_t uFpgaResult;
    uFpgaResult = Hal_InitFpga();
    
    Hal_InitPeripherals();
    Hal_InitInterrupts();
    
    for(;;)
    {
        Hal_WatchdogReset();
        Hal_IdleTasks();
    }
    
    return (int)0;
}
