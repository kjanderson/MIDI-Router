/*
 *  Unit tests for the module MergeOutputs.
 *
 */

#include <stdio.h>
#include <string.h>
#include "CUnit/CUnit.h"
#include "CUnit/Basic.h"
#include "../merge_outputs.h"

/* Pointer to the file used by the tests. */
static FILE* temp_file = NULL;
static MergeOutput fg_uut;

/**********************************************************************
 * test suite for EventQueue
 *********************************************************************/

/* The suite initialization function.
 * Returns zero on success, non-zero otherwise.
 */
int init_suite1(void)
{
    MergeOutput_Ctor(&fg_uut);
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

   CU_ASSERT(1 == fg_uut.uEmpty);
   CU_ASSERT(0 == fg_uut.uFull);

   for (uCnt = 0; uCnt < OUTPUT_BUFSIZE-1U; uCnt++)
   {
      MergeOutput_Push(&fg_uut, uCnt);
      CU_ASSERT(0 == fg_uut.uEmpty);
      CU_ASSERT(0 == fg_uut.uFull);
   }

   MergeOutput_Push(&fg_uut, OUTPUT_BUFSIZE-1U);
   CU_ASSERT(0 == fg_uut.uEmpty);
   CU_ASSERT(1 == fg_uut.uFull);

   MergeOutput_Push(&fg_uut, OUTPUT_BUFSIZE-1U);
   CU_ASSERT(0 == fg_uut.uEmpty);
   CU_ASSERT(1 == fg_uut.uFull);
}

void test_eventqueue_pop(void)
{
   uint8_t uStatus;
   uint8_t uData;
   uint8_t uCnt;

   for (uCnt = 0; uCnt < OUTPUT_BUFSIZE-1U; uCnt++)
   {
      uStatus = MergeOutput_Pop(&fg_uut, &uData);
      CU_ASSERT(uStatus == 1U);
      CU_ASSERT(uCnt == uData);
      CU_ASSERT(0 == fg_uut.uEmpty);
      CU_ASSERT(0 == fg_uut.uFull);
   }

   uStatus = MergeOutput_Pop(&fg_uut, &uData);
   CU_ASSERT(uStatus == 1U);
   CU_ASSERT(OUTPUT_BUFSIZE-1U == uData);
   CU_ASSERT(1 == fg_uut.uEmpty);
   CU_ASSERT(0 == fg_uut.uFull);

   uStatus = MergeOutput_Pop(&fg_uut, &uData);
   CU_ASSERT(uStatus == 0U);
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
   CU_pSuite pQueueSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pQueueSuite = CU_add_suite("Output Queue", init_suite1, clean_suite1);
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

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}

