#include <stdio.h>
#include <stdint.h>
#include "event-queue.h"
#include <hal.h>

void EventQueue_Init(EventQueue *pSelf)
{
    uint8_t uCnt;
    
    pSelf->bEmpty = 1U;
    pSelf->bFull = 0U;
    pSelf->uHead = 0U;
    pSelf->uTail = 0U;
    for (uCnt = 0U; uCnt < EVENT_QUEUE_SIZE; uCnt++)
    {
        pSelf->events[uCnt].e = (QEvent)0;
        pSelf->events[uCnt].data = (uint16_t)0;
    }
}

void EventQueue_PushIsr(EventQueue *pSelf, QEvent e, uint16_t uParam)
{
    pSelf->bEmpty = 0U;
    
    if (pSelf->bFull == 0U)
    {
        pSelf->events[pSelf->uHead].e = e;
        pSelf->events[pSelf->uHead].data = uParam;
        
        pSelf->uHead = pSelf->uHead + 1U;
        if (pSelf->uHead >= EVENT_QUEUE_SIZE)
        {
            pSelf->uHead = 0U;
        }
        if (pSelf->uHead == pSelf->uTail)
        {
            pSelf->bFull = 1U;
        }
    }
}

void EventQueue_Push(EventQueue *pSelf, QEvent e, uint16_t uParam)
{
    Hal_IrqDisable();
    EventQueue_PushIsr(pSelf, e, uParam);
    Hal_IrqEnable();
}

Event * EventQueue_PopIsr(EventQueue *pSelf)
{
    Event *result;
    
    result = (Event*)NULL;
    
    pSelf->bFull = 0U;
    if (pSelf->bEmpty == 0U)
    {
        result = (Event*)&(pSelf->events[pSelf->uTail]);
        pSelf->uTail = pSelf->uTail + 1U;
        if (pSelf->uTail >= EVENT_QUEUE_SIZE)
        {
            pSelf->uTail = 0U;
        }
        if (pSelf->uHead == pSelf->uTail)
        {
            pSelf->bEmpty = 1U;
        }
    }
    
    return result;
}

Event * EventQueue_Pop(EventQueue *pSelf)
{
    Event *result;
    
    Hal_IrqDisable();
    result = EventQueue_PopIsr(pSelf);
    Hal_IrqEnable();
    
    return result;
}

