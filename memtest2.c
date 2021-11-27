#include "user.h"
#include "types.h"

int main(int argc, char** argv){
    //printf(1, "before call\n");
    //void* a = getSharedPage(0, 1);
    //printf(1, "after call\n");
    //printf(1, "%p, ", a);
    //printf(1, "%s, ", (char*) a);
    
    //strcpy((char*) a, "abcs");
    //char buffer = 'a';
    //read(0, &buffer,1);
    //printf(1, "after pointer\n");

    int key = atoi (argv[1]);
    int numOfPages = atoi(argv[2]);


    char* b = getSharedPage(key, numOfPages);
    //char* firstB = b;

    for(int i = 0; i < numOfPages; i++){
        printf(1, "address: %p ---- string at pointer b: %s \n", b, b);
        strcpy(b, "string copy (doesnt clean)");
        b+= 4096;
        //multiple times same key, choose different key (key 7, different pages (unique) [share w only intended process])
    }
    //char buffer = 'a';
    //read(0, &buffer,1);

    

    exit();
}