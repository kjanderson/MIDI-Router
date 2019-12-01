/* 
 * File:   app.h
 * Author: Korwinula
 *
 * Created on April 7, 2018, 4:37 PM
 */

#ifndef APP_H
#define	APP_H

#include <stdint.h>

#define EVENT_QUEUE_SIZE 16

void App_Init(void);
void App_SetFpgaMode(uint8_t uValue);

void App_TickIsr(void);
void App_IdleTasks(void);

void App_SpiRxIsr(uint8_t uData);

typedef enum _QEvent QEvent;
enum _QEvent {
    EV_SPI_DATA
};

typedef struct _Event Event;
struct _Event
{
    enum _QEvent e;
    uint16_t data;
};

typedef struct _EventQueue EventQueue;
struct _EventQueue
{
    uint8_t uHead;
    uint8_t uTail;
    uint8_t bEmpty;
    uint8_t bFull;
    Event events[EVENT_QUEUE_SIZE];
};

void EventQueue_Init(void);
void EventQueue_Uush(QEvent e, uint16_t uData);
void EventQueue_PushIsr(QEvent e, uint16_t uData);
Event * EventQueue_Pop(void);
Event * EventQueue_PopIsr(void);

#endif	/* APP_H */
