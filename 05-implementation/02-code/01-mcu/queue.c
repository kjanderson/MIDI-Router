#include <stdint.h>
#include "queue.h"
#include "hal.h"

void Queue_Ctor(Queue *pSelf)
{
    uint8_t uIndex;
    
    for (uIndex=0U; uIndex<QUEUE_SIZE; uIndex++) {
        pSelf->uData[uIndex] = 0U;
    }
    pSelf->uHead = 0U;
    pSelf->uTail = 0U;
    pSelf->uEmpty = 1U;
    pSelf->uFull = 0U;
}

void Queue_Push(Queue *pSelf, uint8_t uItem)
{
    Hal_IrqDisable();
    Queue_PushIsr(pSelf, uItem);
    Hal_IrqEnable();
}

void Queue_PushIsr(Queue *pSelf, uint8_t uItem)
{
    if (pSelf->uFull == 0U)
    {
        pSelf->uData[pSelf->uHead] = uItem;
        pSelf->uHead = pSelf->uHead + 1U;
        if (pSelf->uHead >= QUEUE_SIZE)
        {
            pSelf->uHead = 0U;
        }
        
        pSelf->uEmpty = 0U;
        
        if (pSelf->uHead == pSelf->uTail)
        {
            pSelf->uFull = 1U;
        }
    }
}

uint8_t Queue_Pop(Queue *pSelf, uint8_t *pItem)
{
    uint8_t uResult;
    
    Hal_IrqDisable();
    uResult = Queue_PopIsr(pSelf, pItem);
    Hal_IrqEnable();
    
    return uResult;
}

uint8_t Queue_PopIsr(Queue *pSelf, uint8_t *pItem)
{
    uint8_t uResult;
    
    uResult = 0U;
    
    if (pSelf->uEmpty == 0U)
    {
        *pItem = pSelf->uData[pSelf->uTail];
        pSelf->uTail = pSelf->uTail + 1U;
        if (pSelf->uTail >= QUEUE_SIZE)
        {
            pSelf->uTail = 0U;
        }
        
        pSelf->uFull = 0U;
        
        if (pSelf->uHead == pSelf->uTail)
        {
            pSelf->uEmpty = 1U;
        }
        uResult = 1U;
    }
    
    return uResult;
}
