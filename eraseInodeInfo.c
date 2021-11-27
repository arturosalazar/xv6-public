#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"



// x/y/z

struct twoNames{
    char* dirName;
    char* fileName;
};

struct twoNames parser(char* path){
    struct twoNames twoNames = {malloc(sizeof(strlen(path))), malloc(sizeof(strlen(path)))};
    char* pathHead = path;
    char* endPath = path + strlen(path) - 1;

    while(endPath != pathHead){
        if(*endPath == '/'){  
            memmove(twoNames.dirName, path, endPath - pathHead);
            printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
            memmove(twoNames.fileName, endPath + 1, strlen(endPath)-1);
            printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);
            twoNames.dirName[endPath - pathHead] = 0;
            return twoNames;
        }
        endPath--;
    }

    memmove(twoNames.dirName, path, endPath - pathHead);
    memmove(twoNames.fileName, endPath, strlen(endPath));
    
    return twoNames;
}

void eraseInodeInfo(char* path, int corruptNum){
    char buf[512] = {0};
    int fd;
    //struct dirent de;
    struct stat st;
    int parentOpen;
    struct stat parentOpenSt;
    struct superblock sb;
    uchar dataBuffer[BSIZE];

    printf(1, "DEBUG PATH: %s\n", path);

    if((fd = open(path, 0)) < 0){
        printf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }
    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    struct twoNames twoNames = parser(path);

    if(strcmp(twoNames.dirName, "") == 0){
        twoNames.dirName[0] = '.';
        twoNames.dirName[1] = 0;
    }

    printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
    printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);


    if((parentOpen = open(twoNames.dirName, O_RDONLY)) < 0){
        printf(1, "OPEN RETURN\n");
        return;
    }

    if(fstat(parentOpen, &parentOpenSt) < 0){
        printf(2, "ls: cannot parentOpenStat %s\n", "/");
        close(parentOpen);
        return;
    }

    callSBRead(st.dev, &sb);
    //printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);
    
    callBRead(st.dev, (parentOpenSt.ino /IPB) + sb.inodestart, dataBuffer);
    //printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (parentOpenSt.ino % IPB);
    struct dinode dinode = *dinodePtr;

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
    }

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "INODE %d, ADDR %d\n\n", parentOpenSt.ino, dinode.addrs[i]);
        printf(1, "i: %d, ADDREESS PTR %p\n\n", i, dinode.addrs);
        if(dinode.addrs[i] == 0) break;
        
        callBRead(st.dev, dinode.addrs[i], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
            printf(1, "ALL DE READS: %s \n\n", ptr->name);
            if(strcmp(ptr->name, twoNames.fileName) == 0){
                printf(1, "DE INODE: %d\n\n", ptr->inum);
                printf(1, "DE NAME: %s, TWONAMES NAME %s\n\n", ptr->name, twoNames.fileName);
            
                ptr->inum = corruptNum;
                printf(1, "BEFORE WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);
                printf(1, "ADDR BEFORE BWRITE %d\n", dinode.addrs[1]);
                callBWrite(st.dev, dinode.addrs[i], dataBuffer);
                printf(1, "ADDR AFTER BWRITE %d\n", dinode.addrs[1]);
                //printf(1, "RETURN VALUE FOR WRITE: %d\n\n");
                printf(1, "AFTER WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);

            }
            printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    }   
    
}


int
main(int argc, char *argv[])
{
  eraseInodeInfo(argv[1], 32234);
  exit();
}