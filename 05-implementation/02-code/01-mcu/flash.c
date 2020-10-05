/**********************************************************************
 * flash.c
 *
 * Description
 * This file implements functions needed to access flash memory.
 *
 * History
 * Date       Revision Notes
 * 2019-08-24 0.1      Development version
 *
 * Notes
 * All flash write operations halt the CPU until they are complete.
 * In order to continue receiving data over the USB CDC connection,
 * the USB subsystem needs to be serviced between flash write operations.
 *********************************************************************/

#include <stdint.h>
#include "flash.h"
#include "hal.h"

void Flash_EraseSector(uint16_t uBaseAddress)
{
}

void Flash_WritePage(uint16_t uBaseAddress, uint8_t *vuData, uint16_t uLen)
{
}

/**********************************************************************
 * Flash_EventLoop
 *
 * Description
 * This function implements an event loop to service USB events from
 * the flash update sector while the firmware image is being written.
 *********************************************************************/
void Flash_EventLoop(void)
{
}

