#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"



void directoryWalker(char* path){
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

        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;

        memmove(p, de.name, DIRSIZ);
        directoryWalker(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}

int
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    directoryWalker(".");
    exit();
  }
  for(i=1; i<argc; i++)
    directoryWalker(argv[i]);
  
  exit();
}
