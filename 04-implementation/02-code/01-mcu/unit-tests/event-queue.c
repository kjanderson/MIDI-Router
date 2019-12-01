/*
 *  Unit tests for the module EventQueue.
 *
 */

#include <stdio.h>
#include <string.h>
#include "CUnit/CUnit.h"
#include "CUnit/Basic.h"
#include "../event-queue.h"

/* Pointer to the file used by the tests. */
static FILE* temp_file = NULL;
static EventQueue fg_eq;

/* The suite initialization function.
 * Opens the temporary file used by the tests.
 * Returns zero on success, non-zero otherwise.
 */
int init_suite1(void)
{
   if (NULL == (temp_file = fopen("event-queue.log", "w"))) {
      return -1;
   }
   else {
      EventQueue_Init(&fg_eq);
      return 0;
   }
}

/* The suite cleanup function.
 * Closes the temporary file used by the tests.
 * Returns zero on success, non-zero otherwise.
 */
int clean_suite1(void)
{
   if (0 != fclose(temp_file)) {
      return -1;
   }
   else {
      temp_file = NULL;
      return 0;
   }
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

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite pSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite("Event Queue", init_suite1, clean_suite1);
   if (NULL == pSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   /* NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf() */
   if ((NULL == CU_add_test(pSuite, "test push", test_eventqueue_push)) ||
       (NULL == CU_add_test(pSuite, "test pop", test_eventqueue_pop)) ||
       (NULL == CU_add_test(pSuite, "test full", test_eventqueue_full)) ||
       (NULL == CU_add_test(pSuite, "test empty", test_eventqueue_empty)))
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

