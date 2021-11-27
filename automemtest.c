#include "user.h"
#include "types.h"

int main(int argc, char** argv){

    //getShared once
    char* b = getSharedPage(2, 4);

    for(int i = 0; i < 4; i++){
        printf(1, "Test 1, simple getShared call\n");
        printf(1, "address: %p ---- string at pointer b: %s \n", b, b);
        strcpy(b, "string copy");
        //those bytes can be written and read from
        printf(1, "Proof pointer works above with strcpy\n");
        b+= 4096;
        //multiple times same key, choose different key (key 7, different pages (unique) [share w only intended process])
    }

    //getShared same process, different keys
    char* c = getSharedPage(3, 5);
    char* d = getSharedPage(23, 3);

    for(int i = 0; i < 5; i++){
        printf(1, "Test 2, getShared same process, different keys\n");
        printf(1, "address: %p ---- int at pointer c: %d \n", c, (int*) c);
        int* j = (int*) c;
        *j = 3;

        //those bytes can be written and read from
        printf(1, "Proof pointer works above with strcpy\n");
        c+= 4096;
    }

    for(int i = 0; i < 3; i++){
        printf(1, "Test 2, getShared same process, different keys\n");
        printf(1, "address: %p ---- int at pointer d: %d \n", d, (int*) d);
        int* k = (int*) d;
        *k = 23;
        
        //those bytes can be written and read from
        printf(1, "Proof pointer works above with strcpy\n");
        d+= 4096;
    }

    for(int i = 0; i < 3; i++){
        printf(1, "Test 2, simple getShared call\n");
        printf(1, "address: %p ---- int at pointer c: %d \n", c, (int*) c);
    
        c+= 4096;
    }

    sleep(2);

    exit();
}