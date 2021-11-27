#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"


void readsb(int dev, struct superblock *sb);

struct buf* bread(uint dev, uint blockno);

//Summary: count inodes in directory, count of blocks


struct dirSummary{
    int inode;
    int inodesCount;
    char* fileName;
    char* block;
};

struct dirSummary dirWalker[4000];
int dirWalkerSize = 0;

void inodeTBWalkerComparison(){
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

    printf(1, "Contents of sb: inodes - %d, size - %d, nblocks - %d, inodestart - %d\n", 
    sb.ninodes, sb.size, sb.nblocks, sb.inodestart);
    for(int numB = 0; numB < sb.ninodes / IPB; numB++){
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        for(int i = 0; i < IPB; i++){    
            int tbWalkerInodeNum = i + (numB * IPB);
            //printf(1, "type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n", 
            //dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
            printf(1, "DIRWALKERSIZE: %d, inode ith: %d\n\n", dirWalkerSize, tbWalkerInodeNum);
            
            for(int j = 0; j < dirWalkerSize; j++){
                
                if(dirWalker[j].inode == tbWalkerInodeNum){
                    printf(1, "dirWalker jth %d\n\n", j);
                    if(dirWalker[j].inodesCount != dinodePtr->nlink){
                        printf(1, "DIFFERENCE for inode %d ---- DirectoryWalker Count: %d, inodeTBWalker Count: %d\n\n", 
                        tbWalkerInodeNum, dirWalker[j].inodesCount, dinodePtr->nlink);

                        printf(1, "inode SUMMARY --- type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n\n\n\n", 
                                dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
                    } else {
                        printf(1, "inode %d count matches, verified\n\n\n\n", dirWalker[j].inode);
                    }
                }
            }

            for(int i = 0; i < NDIRECT+1; i++){
                //printf(1, "%d, ", dinodePtr->addrs[i]);

            } 
            dinodePtr++;
        }
        
        
    }


}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
        if(dirWalker[i].inode == de.inum){
            dirWalker[i].inodesCount++;
            //cprintf("Shared page count %d \n", keysToCount[i].count);
            return dirWalkerSize;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
}

void directoryWalkerComparison(char* path){
    char buf[512] = {0};
    char *p;
    int fd;
    struct dirent de;
    struct stat st;

   
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

    if(st.type != T_DIR){
        printf(1, "Filename: %s \n inode number: %d\n", path, st.ino);
        close(fd);
        return;
    }
    

    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if(de.inum == 0)
            continue;


        dirWalkerSize = incrementRefCount(dirWalker, dirWalkerSize, de);

        

        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;

        memmove(p, de.name, DIRSIZ);
        directoryWalkerComparison(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}




int
main(int argc, char *argv[])
{
  directoryWalkerComparison("/");
  inodeTBWalkerComparison();

  exit();
}