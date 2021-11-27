LAB 3 Part 2 - BUILD AND EXECUTE 

Introduction:
The building and execute and testing is comprised of two main components.
An automated test and an interactive test. To being, there is the automated 
test which conducts 6 main tests for the lab.

1. To begin, the testing runs on the host system, not QEMU. This is because the
   shell (autodiffproctest.sh) contains long echos that creasteed inconsistent results that didn't separate commands. As a result, the shell runs make QEMU at the end. 

   BEGIN BY RUNNING IN THE HOST SYSTEM NOT QEMU: ./autodiffproctest.sh

   It will take a few seconds, but the 6 tests will run conducting these tests successfully:

   Test Case 1 - run getSharedPage for a single process with the same key to confirm that getSharedPage can perform as expected at all.
   Test Case 2 - run getSharedPage on a single process with different keys to confirm that each key will access a different location in memory
   Test Case 3 - run getFreePage for a single single process with the same key to make sure getFreePage performs as expected with in one process
   Test Case 4 - run getFreePage for a single process with different keys to confirm that each key will free a different location in memory.
   Test Case 5 - run getSharedPage with multiple processes using both the same key and different key to confirm that the pages can be shared across processes but won’t affect different shared pages.
   Test Case 6 - run getFreePage with multiple processes using the same same key and different key to confirm that the pages that were shared across processes can be released and that their release won’t affect other shared pages.

   TestCase.pdf will contain more information regarding the breakdown of these tests.


2. After completing this automation portion of the program, there is an
   interactive portion that will allow you to create memory allocations and deallocations. 

   memtest will run memory allocations, with you entering the key and number of pages, respectively

   memtest2 will run memory deallocations, with you entering the key and number of pages, respectively

   Example commands: memtest 3 5
                     memtest2 3 5

   Interactively, memory allocations can be run in the background with the & command to test multiple processes.

   Example command: memtest 3 5 & 