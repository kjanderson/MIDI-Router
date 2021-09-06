#ifndef MERGE_OUTPUT_H
#define MERGE_OUTPUT_H

#include <stdint.h>
#include "queue.h"

typedef struct TagMergeOutput MergeOutput;
struct TagMergeOutput
{
    uint8_t uBusy;
    Queue queue;
};

void MergeOutput_Ctor(MergeOutput *pSelf);
void MergeOutput_TxIsr(MergeOutput *pSelf);
void MergeOutput_SendByte(MergeOutput *pSelf, uint8_t uTx);
void MergeOutput_SendByteIsr(MergeOutput *pSelf, uint8_t uTx);
void MergeOutput_TickIsr(MergeOutput *pSelf);

#endif /* MERGE_OUTPUT_H */
