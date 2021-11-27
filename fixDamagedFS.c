#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"


struct inodes{
    int inum;
    char* name;
    int valid;
};

struct twoNames{
    char* dirName;
    char* fileName;
};


struct inodes *allInodes;

int allInodesCounter = 0;

struct twoNames parser(char* path){
    struct twoNames twoNames = {malloc(sizeof(strlen(path))), malloc(sizeof(strlen(path)))};
    char* pathHead = path;
    char* endPath = path + strlen(path) - 1;

    while(endPath >= pathHead){
        if(*endPath == '/'){  
            memmove(twoNames.dirName, path, endPath - pathHead);
            //printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
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

void writeInReplacement(char* path,int correctInum){
    char buf[512] = {0};
    //struct dirent de;
    int parentOpen;
    struct stat parentOpenSt;
    struct superblock sb;
    uchar dataBuffer[BSIZE];

    //printf(1, "DEBUG PATH: %s\n", path);

    printf(1, "INTO WIR");

    printf(1, "AFTER OPEN");
    
    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    printf(1, "BEFORE PARSER");
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

    callSBRead(parentOpenSt.dev, &sb);
    printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", parentOpenSt.dev, sb.ninodes);
    
    callBRead(parentOpenSt.dev, (parentOpenSt.ino /IPB) + sb.inodestart, dataBuffer);
    printf(1, "after in loop CallBRead: %d, bufStructPtr: %p\n", parentOpenSt.dev, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (parentOpenSt.ino % IPB);
    struct dinode dinode = *dinodePtr;

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
    }

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "INODE %d, ADDR %d\n\n", parentOpenSt.ino, dinode.addrs[i]);
        //printf(1, "i: %d, ADDREESS PTR %p\n\n", i, dinode.addrs);
        if(dinode.addrs[i] == 0) break;
        
        callBRead(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
            printf(1, "ALL DE READS: %s \n\n", ptr->name);
            if(strcmp(ptr->name, twoNames.fileName) == 0){
                printf(1, "DE INODE: %d\n\n", ptr->inum);
                //printf(1, "DE NAME: %s, TWONAMES NAME %s\n\n", ptr->name, twoNames.fileName);
            
                ptr->inum = correctInum;
                //printf(1, "BEFORE WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);
                printf(1, "ADDR BEFORE BWRITE %d\n", dinode.addrs[i]);
                callBWrite(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
                //printf(1, "ADDR AFTER BWRITE %d\n", dinode.addrs[1]);
                //printf(1, "RETURN VALUE FOR WRITE: %d\n\n");
                //printf(1, "AFTER WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);

            }
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    }   
    
}


void candidatePlacement(int *inumsNotFound, int notFoundIdx, struct stat st, struct superblock sb, struct inodes *allInodes){

    printf(1, "CP before SBREAD");
    callSBRead(st.dev, &sb);
    //printf(1, "sbninodes in CP: %p\n\n", sb.ninodes);

    //outside range inode)
    for(int i = 0; i < allInodesCounter; i++){
        if((allInodes[i].inum < 0 || allInodes[i].inum >= sb.ninodes) || allInodes[i].valid == 0){
            printf(1, "CP inum replacement happening : %d\n\n", allInodes[i].inum);
            printf(1, "NOTFOUNDIDX %d\n\n", notFoundIdx);
            if(notFoundIdx == 1){
                printf(1, "BEFORE WIR\n\n");
                writeInReplacement(allInodes[i].name, inumsNotFound[0]);
            }
        }
    }
    

    //refers to inode not allocated);
}


void inodeTBWalkerFix(){
    struct stat st;
    int fd;
    struct superblock sb; 
    uchar dataBuffer[BSIZE];
    
    //printf(1, "NODETBWALKER");

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
    int *inumsNotFound = malloc(sizeof(int) * sb.ninodes);
    int notFoundIdx = 0;
    for(int numB = 0; numB < (sb.ninodes/IPB); numB++){
        //printf(1, "NUMB TRACE %d", numB);
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        
        for(int i = 0; i < IPB; i++){  
            int inodeNum = (numB * IPB) + i; 
            int foundIt = 0;
            //printf(1, "FOUND IT: %d\n\n", foundIt);
            for(int i = 0; i < allInodesCounter; i++){
                if(inodeNum == allInodes[i].inum){
                    foundIt = 1;
                    if(dinodePtr->type != 0){
                        allInodes[i].valid = 1;
                    }
                    break;
                } 
                
            }

            if(foundIt == 0 && dinodePtr->type != 0){
                //candidate for placement
                printf(1, "inode inum not found in present in file system: %d\n\n", 
                inodeNum);
                inumsNotFound[notFoundIdx] = inodeNum;
                notFoundIdx++;

            }

            //for(int i = 0; i < NDIRECT+1; i++){
                //printf(1, "%d, ", dinodePtr->addrs[i]);

            //} 
            dinodePtr++;
        }

    
    }

    printf(1, "BEFORE CANDIDATE PLACEMENT");
    
    if(notFoundIdx > 0){
        candidatePlacement(inumsNotFound, notFoundIdx, st, sb, allInodes);
        
    }  

    printf(1, "END OF FUNCTION TB WALKER");

        

}



void directoryWalkerFix(char* path, int dev, int ino){
    char buf[512] = {0};
    char *p;
    //int fd;
    //struct dirent de;
    struct superblock sb;
    uchar dataBuffer[BSIZE];

    //printf(1, "DEBUG PATH: %s\n", path);


    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }
    
    callSBRead(dev, &sb);
    //printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);

    if((ino < 0) || (ino >= sb.ninodes)) return;
    //printf(1, "BLOCKNO: %d\n\n", (ino /IPB) + sb.inodestart);

    callBRead(dev, (ino /IPB) + sb.inodestart, dataBuffer);
    //printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (ino % IPB);
    //printf(1, "DINODE PTR: %p\n\n", dinodePtr);
    struct dinode dinode = *dinodePtr;

    if(dinode.type != T_DIR){
        printf(1, "Filename: %s \n inode number: %d\n", path, ino);
        return;
    }

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
    }

    strcpy(buf, path);
    p = buf+strlen(buf);
    //printf(1, "buf: %d buf len: %d\n\n", buf, strlen(buf));
    //printf(1, "p how far: %d", p - buf);
    *p++ = '/';
    for(int k = 0; k < NDIRECT+1; k++){
        //printf(1, "INODE %d, ADDR %d\n\n", ino, dinode.addrs[k]);
        //printf(1, "k: %d, ADDREESS PTR %p\n\n", k, dinode.addrs);
        if(dinode.addrs[k] == 0) break;

        //printf(1, "BLOCKNO IN LOOP: %d\n\n", dinode.addrs[k]);
        callBRead(dev, dinode.addrs[k], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
            //printf(1, "DIRENT PTR: %p\n\n", ptr);
            printf(1, "ALL DE READS: %s AND %d\n\n", ptr->name, ptr->inum);
                if(ptr->inum == 0)
                    continue;

                char* temp = malloc(strlen(buf)+1);


                
                //printf(1, "AFTER STRCPY: %s & %s", temp, ptr->name);

                allInodes[allInodesCounter].inum = ptr->inum;
                allInodes[allInodesCounter].name = temp;
            
                allInodesCounter++;
                
                memmove(p, ptr->name, DIRSIZ);
                p[DIRSIZ] = 0;
                strcpy(temp, buf);

                if(strcmp(ptr->name, ".") == 0 || strcmp(ptr->name, "..") == 0) continue;

                //printf(1, "AFTER MEMMOVE: %d & %s", p, ptr->name);

                //printf(1, "PP: %d\n\n", p - buf);
                directoryWalkerFix(buf, dev, ptr->inum);
                //p[DIRSIZ] = 0;
                //printf(1, "inum: %d\ndir name: %s\n", ptr->inum, buf);

                //printf(1, "DINODE ADDRES BEFORE BWRITE: %d\n\n", dinode.addrs[k]);
                //callBWrite(dev, dinode.addrs[k], dataBuffer);
                


            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    } 
    printf(1, "END OF THE FUNCTION");

}

int
main(int argc, char *argv[])
{
    int fd;
    struct stat st;
    int dev;
    int ino;

    if((fd = open("/", 0)) < 0){
        printf(2, "ls: cannot open %s\n", "/");
        return -1;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", "/");
        close(fd);
        return -1;
    }

    dev = st.dev;
    ino = st.ino;

    allInodes = malloc((sizeof(struct inodes) * 10000));
    memset(allInodes, 0, (sizeof(struct inodes) * 10000));
    
  directoryWalkerFix("", dev, ino);
  printf(1, "BEFORE TBWALKER");
  inodeTBWalkerFix();
  
  exit();
}