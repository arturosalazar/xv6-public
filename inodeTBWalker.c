#include "types.h"
#include "fs.h"
#include "stat.h"
#include "user.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "buf.h"

void readsb(int dev, struct superblock *sb);

struct buf* bread(uint dev, uint blockno);


void inodeTBWalker(){
    struct stat st;
    int fd;
    struct superblock sb; 
    uchar dataBuffer[BSIZE];

    if((fd = open("/", 0)) < 0){
        printf(2, "ls: cannot open %s\n", "/");
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", "/");
        close(fd);
        return;
    }

    callSBRead(st.dev, &sb);
    printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);
    for(int numB = 0; numB < sb.nblocks; numB++){
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        printf(1, "after idinode: %p\n", dataBuffer);
        for(int i = 0; i < IPB; i++){  
            int inodeNum = (numB * IPB) + i;  
            printf(1, "inode number: %d, type: %d,major: %d,minor: %d,nlink: %d,size: %d\n", 
            inodeNum, dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
            printf(1, "address: ");
            for(int i = 0; i < NDIRECT+1; i++){
                printf(1, "%d, ", dinodePtr->addrs[i]);

            } 
            printf(1, "\n");
            dinodePtr++;
        }
        
        
    }


}

int
main(int argc, char *argv[])
{
  inodeTBWalker();
  
  exit();
}