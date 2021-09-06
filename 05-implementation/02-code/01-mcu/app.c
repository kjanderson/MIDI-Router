#include <stdio.h>
#include <stdint.h>
#include "hal.h"
#include "app.h"
//#include "spi-ctrl.h"

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
    
    //SpiCtrl_Init(&g_SpiCtrl);
}

/**********************************************************************
 * App_SetFpgaMode
 * 
 * Description
 * Access function for FPGA mode.
 * 
 * Notes
 * This function is only called from main(), and before interrupts
 * are enabled. No need to protect fg_uFpgaMode.
 *********************************************************************/
void App_SetFpgaMode(uint8_t uValue)
{
    fg_uFpgaMode = uValue;
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
     * code here will start an SPI transaction in response to buttons */
    //SpiCtrl_SendData(&g_SpiCtrl, 0xDE);
    
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
}

/**********************************************************************
 * App_SpiRxIsr
 * 
 * Description
 * This ISR callback function posts data to the ready queue for processing
 * by the application's event queue.
 * Any data that is ready to send can get queued up immediately.
 *********************************************************************/
void App_SpiRxIsr(uint8_t uData)
{
    (void)uData;
}

