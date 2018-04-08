#include <stdio.h>
#include <stdint.h>
#include "hal.h"
#include "app.h"

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
