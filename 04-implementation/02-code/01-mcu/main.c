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
 *  3. test flash erase/read/write functionality
 * 
 * Notes
 * flash addressing is a bit strange, at least compared to the datasheet.
 * Need to test with data in the high-byte.
 * program memory reports the following:
 * 08000 0000FF 00614C 007474 006369
 * tblrdl(0x8000) reads 00FF
 * tblrdl(0x8001) reads FF00
 * tblrdl(0x8002) reads 614C
 * tblrdl(0x8003) reads 4C61
 * tblrdl(0x8004) reads 7474
 *********************************************************************/

#include "app.h"
#include "hal.h"

const uint8_t vuData[64] = {
    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
    0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
    0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
    0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
    0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F
};

int main(void)
{
    uint8_t uFpgaResult;
    /*
    uint16_t uData;

    TBLPAG = 0;
    uData = __builtin_tblrdl(0x8004);
    
    Hal_EraseFlashSector(0x00008000);
    TBLPAG = 0;
    uData = __builtin_tblrdl(0x8004);
    // Hal_WriteFlashPage(0x00008000, (uint8_t*)vuData);
     */
    
    App_Init();
    
    uFpgaResult = Hal_InitFpga();
    App_SetFpgaMode(uFpgaResult);
    
    Hal_InitPeripherals();
    Hal_InitInterrupts();
    
    /* attempt sending a byte and reading the inputs */
    Hal_SpiSetTxData(0xD5U);
    Hal_GpioGetFbin0();
    Hal_GpioGetFbin1();
    Hal_GpioGetFbin2();
    Hal_GpioGetFbin3();
    
    Hal_LedModeOn();
    
    for(;;)
    {
        Hal_WatchdogReset();
        Hal_IdleTasks();
        App_IdleTasks();
    }
    
    return (int)0;
}
