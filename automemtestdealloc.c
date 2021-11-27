#include "user.h"
#include "types.h"

int main(int argc, char** argv){

    //getFree once, doesn't seg fault
    getSharedPage(1, 2);
    getSharedPage(1, 4);
    freeSharedPage(1);

    //same process, different keys
    char* c = getSharedPage(3, 5);
    char* d = getSharedPage(7, 2);

    int* j = (int*) c;
    *j = 4;
    //write in value 
    int* k = (int*) d;
    *k = 23;
    //write in value
    freeSharedPage(3);
    printf(1, "address: %p ---- int at pointer d: %d \n", d, (int*) d);
    *k = 64;
    //still writable
    printf(1, "address: %p ---- int at pointer d: %d \n", d, (int*) d);
    //we can still read and write from d

    sleep(2);
   
    exit();

}