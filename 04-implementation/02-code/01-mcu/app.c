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
    uint8_t vuBuffer[64];
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

static EventQueue fg_eq;

void EventQueue_Init(void)
{
    uint8_t uCnt;
    
    fg_eq.bEmpty = 1U;
    fg_eq.bFull = 0U;
    fg_eq.uHead = 0U;
    fg_eq.uTail = 0U;
    for (uCnt = 0U; uCnt < EVENT_QUEUE_SIZE; uCnt++)
    {
        fg_eq.events[uCnt].e = (QEvent)0;
        fg_eq.events[uCnt].data = (uint16_t)0;
    }
}

void EventQueue_PushIsr(QEvent e, uint16_t uParam)
{
    fg_eq.bEmpty = 0U;
    
    if (fg_eq.bFull == 0U)
    {
        fg_eq.events[fg_eq.uHead].e = e;
        fg_eq.events[fg_eq.uHead].data = uParam;
        
        fg_eq.uHead = fg_eq.uHead + 1U;
        if (fg_eq.uHead >= EVENT_QUEUE_SIZE)
        {
            fg_eq.uHead = 0U;
        }
        if (fg_eq.uHead == fg_eq.uTail)
        {
            fg_eq.bFull = 1U;
        }
    }
}

void EventQueue_Push(QEvent e, uint16_t uParam)
{
    Hal_IrqDisable();
    EventQueue_PushIsr(e, uParam);
    Hal_IrqEnable();
}

Event * EventQueue_PopIsr(void)
{
    Event *result;
    
    result = (Event*)NULL;
    
    fg_eq.bFull = 0U;
    if (fg_eq.bEmpty == 0U)
    {
        result = (Event*)&(fg_eq.events[fg_eq.uTail]);
        fg_eq.uTail = fg_eq.uTail + 1U;
        if (fg_eq.uTail >= EVENT_QUEUE_SIZE)
        {
            fg_eq.uTail = 0U;
        }
        if (fg_eq.uHead == fg_eq.uTail)
        {
            fg_eq.bEmpty = 1U;
        }
    }
    
    return result;
}

Event * App_QueuePop(void)
{
    Event *result;
    
    Hal_IrqDisable();
    result = EventQueue_PopIsr();
    Hal_IrqEnable();
    
    return result;
}
