/*
 *  Unit tests for the module EventQueue.
 *
 */

#include <stdio.h>
#include <string.h>
#include "CUnit/CUnit.h"
#include "CUnit/Basic.h"
#include "../event-queue.h"
#include "../spi-ctrl.h"

/* Pointer to the file used by the tests. */
static FILE* temp_file = NULL;
static EventQueue fg_eq;
static SpiCtrl fg_spi;

/**********************************************************************
 * test suite for EventQueue
 *********************************************************************/

/* The suite initialization function.
 * Returns zero on success, non-zero otherwise.
 */
int init_suite1(void)
{
    EventQueue_Init(&fg_eq);
    return 0;
}

/* The suite cleanup function.
 * Returns zero on success, non-zero otherwise.
 */
int clean_suite1(void)
{
    return 0;
}

void test_eventqueue_push(void)
{
   uint8_t uCnt;

   CU_ASSERT(1 == fg_eq.bEmpty);
   CU_ASSERT(0 == fg_eq.bFull);

   for (uCnt = 0; uCnt < 15; uCnt++)
   {
      EventQueue_Push(&fg_eq, (QEvent)0, (uint16_t)uCnt);
      CU_ASSERT(0 == fg_eq.bEmpty);
      CU_ASSERT(0 == fg_eq.bFull);
   }

   EventQueue_Push(&fg_eq, (QEvent)0, (uint16_t)15);
   CU_ASSERT(0 == fg_eq.bEmpty);
   CU_ASSERT(1 == fg_eq.bFull);

   EventQueue_Push(&fg_eq, (QEvent)0, (uint16_t)16);
   CU_ASSERT(0 == fg_eq.bEmpty);
   CU_ASSERT(1 == fg_eq.bFull);
}

void test_eventqueue_pop(void)
{
   Event *pEvt;
   uint8_t uCnt;

   for (uCnt = 0; uCnt < 15; uCnt++)
   {
      pEvt = EventQueue_Pop(&fg_eq);
      CU_ASSERT(pEvt != NULL);
      CU_ASSERT(uCnt == pEvt->data);
      CU_ASSERT(0 == fg_eq.bEmpty);
      CU_ASSERT(0 == fg_eq.bFull);
   }

   pEvt = EventQueue_Pop(&fg_eq);
   CU_ASSERT(pEvt != NULL);
   CU_ASSERT(15 == pEvt->data);
   CU_ASSERT(1 == fg_eq.bEmpty);
   CU_ASSERT(0 == fg_eq.bFull);

   pEvt = EventQueue_Pop(&fg_eq);
   CU_ASSERT(pEvt == NULL);
}

void test_eventqueue_full(void)
{
}

void test_eventqueue_empty(void)
{
}

/**********************************************************************
 * test suite for SPI
 *********************************************************************/
int init_suite2(void)
{
    SpiCtrl_Init(&fg_spi);
    return 0;
}

int clean_suite2(void)
{
    return 0;
}

void test_spi(void)
{
    /* setup transfer */
    SpiCtrl_SendData(&fg_spi, (uint8_t)0xD5);
    CU_ASSERT(2 == fg_spi.uTxLength);
    CU_ASSERT(1 == fg_spi.uTxCnt);
    CU_ASSERT(0 == fg_spi.uRxCnt);
    /* verify the first byte gets received correctly
     * expected result:
     *   increment TxCnt by 1 (2)
     *   increment RxCnt by 1 (2)
     */
    SpiCtrl_RxIsr(&fg_spi, (uint8_t)0x01U);
    CU_ASSERT(2 == fg_spi.uTxLength);
    CU_ASSERT(2 == fg_spi.uTxCnt);
    CU_ASSERT(1 == fg_spi.uRxCnt);
    /* verify the second (last) byte gets received correctly
     * expected result:
     *   TxCnt remains at 2
     *   increment RxCnt by 1 (2)
     */
    SpiCtrl_RxIsr(&fg_spi, (uint8_t)0x00U);
    CU_ASSERT(2 == fg_spi.uTxLength);
    CU_ASSERT(2 == fg_spi.uTxCnt);
    CU_ASSERT(2 == fg_spi.uRxCnt);
}

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite pQueueSuite = NULL;
   CU_pSuite pSpiSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pQueueSuite = CU_add_suite("Event Queue", init_suite1, clean_suite1);
   if (NULL == pQueueSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   /* NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf() */
   if ((NULL == CU_add_test(pQueueSuite, "test push", test_eventqueue_push)) ||
       (NULL == CU_add_test(pQueueSuite, "test pop", test_eventqueue_pop)) ||
       (NULL == CU_add_test(pQueueSuite, "test full", test_eventqueue_full)) ||
       (NULL == CU_add_test(pQueueSuite, "test empty", test_eventqueue_empty)))
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   pSpiSuite = CU_add_suite("SPI Suite", init_suite2, clean_suite2);

   /* add the tests to the suite */
   /* NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf() */
   if ((NULL == CU_add_test(pSpiSuite, "test SPI", test_spi)))
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}

