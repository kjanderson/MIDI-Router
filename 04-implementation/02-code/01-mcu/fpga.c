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
 * The following sequence applies:
 *  application processor sets active #reset for at least 200 nsec
 *  application processor sets inactive #reset for at least 800 usec
 *  application processor begins clocking in data, MSb first
 *  configuration image always starts with 0x7EAA997E synchronization word
 *  FPGA sets active done
 *  application processor clocks 49 dummy bits to FPGA
 *  SPI pins are available to FPGA configuration for user to use
 *********************************************************************/
void Fpga_Configure(void)
{
    uint16_t iCnt;
    volatile uint8_t iRx;
    
    /* 200 ns @ 34.01 MHz */
    /* const uint16_t iResetTime = 7; */
    /* 200 ns @ 69 MHz */
    const uint16_t iResetTime = (uint16_t)14;
    /* 800 us @ 34.01 MHz */
    /* const uint16_t iFpgaInitTime = 27210; */
    /* 800 us @ 69 MHz */
    const uint16_t iFpgaInitTime = (uint16_t)55275;

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
