#ifndef _FLASH_H
#define _FLASH_H

#include <stdint.h>
#include "hal.h"

void Flash_EraseSector(uint16_t uBaseAddress);
void Flash_WritePage(uint16_t uBaseAddress, uint8_t *vuData, uint16_t uLen);

#endif /* _FLASH_H */
