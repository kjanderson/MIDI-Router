#include <stdint.h>
#include <xc.h>
#include "hal.h"
#include "fpga.h"
#include "fpga_image.h"

/**********************************************************************
 * Fpga_Configure()
 *
 * Inputs:  none
 * Outputs: none
 *
 * Functional description:
 * This function configures the FPGA. It relinquishes the device from
 * reset and waits for the configuration to complete.
 *
 * Notes:
 * In order to configure the iCE40 device, the #SS line must be inactive
 * before #reset is set inactive.
 *
 * The following sequence applies (set means active state):
 *  set #reset
 *  set SPI_SS = 0, SPI_SCK = 1
 *  wait at least 200 nsec
 *  release #reset (or clear #reset)
 *  wait at least 300 usec to clear internal configuration memory
 *  Send configuration serially on SPI_MOSI, MSb first, on falling edge of SPI_SCK.
 *  if CDONE
 *    Send at least 49 additional dummy bits with dummy clock pulses
 *    FPGA is ready to use, including SPI configuration pins
 *  else
 *    error
 *    reset and try again, if desired
 *********************************************************************/
void Fpga_Configure(void)
{
    uint16_t iCnt;
    volatile uint8_t iRx;
    
    /* 200 ns @ 16 MHz = 3.2 clock cycles */
    const uint16_t iResetTime = (uint16_t)4;
    /* 800 us @ 16 MHz = 12,800 clock cycles */
    const uint16_t iFpgaInitTime = (uint16_t)12800;

    Hal_GpioSetReset();
    //Hal_SpiInitForFpga();
    
    /* initialize timer to setup timing on reset output */
    Hal_GpioClrCfgSpiSs();
    Hal_GpioClrReset();
    Hal_Timer1Disable();
    /* configure timer to expire after 200 ns */
    Hal_Timer1Config(iResetTime, 0);
    Hal_Timer1Restart();
    Hal_Timer1Enable();
    while(!Hal_Timer1IsExpired())
    {
    }
    Hal_Timer1Clear();

    /* configure timer to expire after 800 us */
    Hal_GpioSetReset();
    Hal_Timer1Config(iFpgaInitTime, 0);
    Hal_Timer1Restart();
    Hal_Timer1Enable();
    while(!Hal_Timer1IsExpired())
    {
    }
    Hal_Timer1Clear();

    /* release SS */
    /* Hal_GpioClrCfgSpiSs(); */

    /* prime the SPI slave with a byte of dummy data */
    SPI1BUFL = (uint8_t)0;
    while(Hal_Spi1TxBusy())
    {
    }
    iRx = SPI1BUFL;
    Hal_Spi1ClrInt();

    for(iCnt=(uint16_t)0; iCnt<HAL_DIM(vuFpgaImage); iCnt++)
    {
        /* send the current byte */
        SPI1BUFL = vuFpgaImage[iCnt];
        while(Hal_Spi1TxBusy())
        {
        }
        iRx = SPI1BUFL;
        Hal_Spi1ClrInt();
    }
    /* after the last data byte is sent, make sure the clock is active
     * for at least 100 clock cycles (13 bytes = 104 clock cycles) */
    for(iCnt=(uint16_t)0; iCnt<(uint16_t)13; iCnt++)
    {
        /* send dummy data */
        SPI1BUFL = (uint8_t)0;
        while(Hal_Spi1TxBusy())
        {
        }
        iRx = SPI1BUFL;
        Hal_Spi1ClrInt();
    }
    Hal_GpioSetCfgSpiSs();
}
