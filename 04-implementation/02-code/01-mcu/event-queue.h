#ifndef EVENT_QUEUE_H
#define EVENT_QUEUE_H

#include <stdint.h>

#define EVENT_QUEUE_SIZE 16

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

void EventQueue_Init(EventQueue *pSelf);
void EventQueue_Push(EventQueue *pSelf, QEvent e, uint16_t uData);
void EventQueue_PushIsr(EventQueue *pSelf, QEvent e, uint16_t uData);
Event * EventQueue_Pop(EventQueue *pSelf);
Event * EventQueue_PopIsr(EventQueue *pSelf);

#endif /* EVENT_QUEUE_H */

