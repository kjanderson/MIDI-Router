/* 
 * File:   app.h
 * Author: Korwinula
 *
 * Created on April 7, 2018, 4:37 PM
 */

#ifndef APP_H
#define	APP_H

#include <stdint.h>

void App_Init(void);
void App_SetFpgaMode(uint8_t uValue);

void App_TickIsr(void);
void App_IdleTasks(void);

#endif	/* APP_H */
