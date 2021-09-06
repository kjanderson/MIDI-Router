/* 
 * File:   queue.h
 * Author: kand4
 *
 * Created on July 29, 2021, 12:12 PM
 */

#ifndef QUEUE_H
#define	QUEUE_H

#include <stdint.h>

#define QUEUE_SIZE 32U

typedef struct _TagQueue Queue;
struct _TagQueue
{
    uint8_t uHead;
    uint8_t uTail;
    uint8_t uFull;
    uint8_t uEmpty;
    uint8_t uData[QUEUE_SIZE];
};

void Queue_Ctor(Queue *pSelf);
void Queue_PushIsr(Queue *pSelf, uint8_t uItem);
void Queue_Push(Queue *pSelf, uint8_t uItem);
uint8_t Queue_PopIsr(Queue *pSelf, uint8_t *pItem);
uint8_t Queue_Pop(Queue *pSelf, uint8_t *pItem);

#endif	/* QUEUE_H */

