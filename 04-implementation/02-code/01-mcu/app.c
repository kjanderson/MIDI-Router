#include <stdio.h>
#include <stdint.h>
#include "hal.h"
#include "app.h"

#include "system.h"
#include "usb.h"
#include "usb_device_cdc.h"

static uint8_t fg_uFpgaMode;
static uint16_t fg_uLedPeriod;
static uint16_t fg_uLedDuty;
static uint16_t fg_uLedCnt;

/**********************************************************************
 * App_Init
 * 
 * Description
 * Initialization function for application.
 *********************************************************************/
void App_Init(void)
{
    fg_uFpgaMode = 0U;
    /* ticks in msec (depends on timer 1 configuration) */
    fg_uLedPeriod = 1000U;
    fg_uLedDuty = 500U;
    fg_uLedCnt = fg_uLedPeriod;
}

/**********************************************************************
 * App_SetFpgaMode
 * 
 * Description
 * Access function for FPGA mode.
 *********************************************************************/
void App_SetFpgaMode(uint8_t uValue)
{
    Hal_IrqDisable();
    fg_uFpgaMode = uValue;
    Hal_IrqEnable();
}

/**********************************************************************
 * App_TickIsr
 * 
 * Description
 * This function is invoked from the timer interrupt, so anything it
 * modifies needs to be protected by disabling interrupts.
 *********************************************************************/
void App_TickIsr(void)
{
    /* when the router is implemented,
     * code here will start an SPI transaction */
    
    /* blink the LED according to the application state */
    if (fg_uFpgaMode > 0U)
    {
        fg_uLedDuty = 500U;
    }
    else
    {
        fg_uLedDuty = 100U;
    }
    if (fg_uLedCnt > 0U)
    {
        fg_uLedCnt = fg_uLedCnt - 1U;
        
        /* disable LED control for testing */
        if (fg_uLedCnt > fg_uLedDuty)
        {
            Hal_LedModeOn();
        }
        else
        {
            Hal_LedModeOff();
        }
        
        if (fg_uLedCnt == 0U)
        {
            fg_uLedCnt = fg_uLedPeriod;
        }
    }
}

/**********************************************************************
 * App_IdleTasks
 * 
 * Description
 * This function is invoked from the main application loop.
 * The task for this function is to remove queued items.
 * The application is designed so that USB activity occurs when the unit
 * is not operating, so there should not be any real-time servicing needs.
 *********************************************************************/
void App_IdleTasks(void)
{
    /* when the router is implemented,
     * code here will retrieve data from the FIFO for processing */
    
    /* implement a UART echo device for now */
    uint8_t uBytesRead;
    uint8_t vuBuffer[CDC_COMM_IN_EP_SIZE];
    static uint8_t uState = 0U;
    
    uBytesRead = 0U;
    switch(uState)
    {
        case 0:
            uBytesRead = getsUSBUSART(&(vuBuffer[0]), sizeof(vuBuffer));
            if (uBytesRead > 0U)
            {
                if (USBUSARTIsTxTrfReady())
                {
                    uState = 1U;
                }
            }
            break;
            
        case 1:
            putUSBUSART(vuBuffer, uBytesRead);
            break;
            
        default:
            break;
    }
    
}
