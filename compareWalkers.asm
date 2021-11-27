
_compareWalkers:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:



int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 10             	sub    $0x10,%esp
  directoryWalkerComparison("/");
  11:	68 40 0c 00 00       	push   $0xc40
  16:	e8 c5 02 00 00       	call   2e0 <directoryWalkerComparison>
  inodeTBWalkerComparison();
  1b:	e8 10 00 00 00       	call   30 <inodeTBWalkerComparison>

  exit();
  20:	e8 7d 07 00 00       	call   7a2 <exit>
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <inodeTBWalkerComparison>:
};

struct dirSummary dirWalker[4000];
int dirWalkerSize = 0;

void inodeTBWalkerComparison(){
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	57                   	push   %edi
  34:	56                   	push   %esi
  35:	53                   	push   %ebx
  36:	81 ec 54 02 00 00    	sub    $0x254,%esp
    struct stat st;
    int fd;
    struct superblock sb; 
    uchar dataBuffer[BSIZE];

    if((fd = open("/", 0)) < 0){
  3c:	6a 00                	push   $0x0
  3e:	68 40 0c 00 00       	push   $0xc40
  43:	e8 9a 07 00 00       	call   7e2 <open>
  48:	83 c4 10             	add    $0x10,%esp
  4b:	85 c0                	test   %eax,%eax
  4d:	0f 88 e2 01 00 00    	js     235 <inodeTBWalkerComparison+0x205>
  53:	89 c3                	mov    %eax,%ebx
        printf(2, "ls: cannot open %s\n", "/");
        return;
    }

    if(fstat(fd, &st) < 0){
  55:	8d 85 b8 fd ff ff    	lea    -0x248(%ebp),%eax
  5b:	83 ec 08             	sub    $0x8,%esp
  5e:	50                   	push   %eax
  5f:	53                   	push   %ebx
  60:	e8 95 07 00 00       	call   7fa <fstat>
  65:	83 c4 10             	add    $0x10,%esp
  68:	85 c0                	test   %eax,%eax
  6a:	0f 88 e4 01 00 00    	js     254 <inodeTBWalkerComparison+0x224>
        printf(2, "ls: cannot stat %s\n", "/");
        close(fd);
        return;
    }

    callSBRead(st.dev, &sb);
  70:	8d 85 cc fd ff ff    	lea    -0x234(%ebp),%eax
  76:	83 ec 08             	sub    $0x8,%esp
  79:	50                   	push   %eax
  7a:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
  80:	e8 dd 07 00 00       	call   862 <callSBRead>

    printf(1, "Contents of sb: inodes - %d, size - %d, nblocks - %d, inodestart - %d\n", 
  85:	5a                   	pop    %edx
  86:	59                   	pop    %ecx
  87:	ff b5 e0 fd ff ff    	pushl  -0x220(%ebp)
  8d:	ff b5 d0 fd ff ff    	pushl  -0x230(%ebp)
  93:	ff b5 cc fd ff ff    	pushl  -0x234(%ebp)
  99:	ff b5 d4 fd ff ff    	pushl  -0x22c(%ebp)
  9f:	68 bc 0c 00 00       	push   $0xcbc
  a4:	6a 01                	push   $0x1
  a6:	e8 75 08 00 00       	call   920 <printf>
    sb.ninodes, sb.size, sb.nblocks, sb.inodestart);
    for(int numB = 0; numB < sb.ninodes / IPB; numB++){
  ab:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
  b1:	83 c4 20             	add    $0x20,%esp
  b4:	c7 85 b0 fd ff ff 00 	movl   $0x0,-0x250(%ebp)
  bb:	00 00 00 
  be:	c1 e8 03             	shr    $0x3,%eax
  c1:	85 c0                	test   %eax,%eax
  c3:	0f 84 3e 01 00 00    	je     207 <inodeTBWalkerComparison+0x1d7>
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
  c9:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
  cf:	83 ec 04             	sub    $0x4,%esp
  d2:	8b bd b0 fd ff ff    	mov    -0x250(%ebp),%edi
  d8:	50                   	push   %eax
  d9:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
  df:	01 f8                	add    %edi,%eax
  e1:	50                   	push   %eax
  e2:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
  e8:	e8 6d 07 00 00       	call   85a <callBRead>
  ed:	89 f8                	mov    %edi,%eax
  ef:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
  f5:	83 c4 10             	add    $0x10,%esp
  f8:	c1 e0 03             	shl    $0x3,%eax
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        for(int i = 0; i < IPB; i++){    
            int tbWalkerInodeNum = i + (numB * IPB);
            //printf(1, "type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n", 
            //dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
            printf(1, "DIRWALKERSIZE: %d, inode ith: %d\n\n", dirWalkerSize, tbWalkerInodeNum);
 100:	50                   	push   %eax
 101:	ff 35 80 11 00 00    	pushl  0x1180
 107:	68 04 0d 00 00       	push   $0xd04
 10c:	6a 01                	push   $0x1
 10e:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 114:	e8 07 08 00 00       	call   920 <printf>
            
            for(int j = 0; j < dirWalkerSize; j++){
 119:	a1 80 11 00 00       	mov    0x1180,%eax
 11e:	83 c4 10             	add    $0x10,%esp
 121:	85 c0                	test   %eax,%eax
 123:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 129:	0f 8e a9 00 00 00    	jle    1d8 <inodeTBWalkerComparison+0x1a8>
 12f:	bb a0 11 00 00       	mov    $0x11a0,%ebx
 134:	31 f6                	xor    %esi,%esi
 136:	eb 1a                	jmp    152 <inodeTBWalkerComparison+0x122>
 138:	90                   	nop
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	83 c6 01             	add    $0x1,%esi
 143:	83 c3 10             	add    $0x10,%ebx
 146:	39 35 80 11 00 00    	cmp    %esi,0x1180
 14c:	0f 8e 86 00 00 00    	jle    1d8 <inodeTBWalkerComparison+0x1a8>
                
                if(dirWalker[j].inode == tbWalkerInodeNum){
 152:	3b 03                	cmp    (%ebx),%eax
 154:	75 ea                	jne    140 <inodeTBWalkerComparison+0x110>
                    printf(1, "dirWalker jth %d\n\n", j);
 156:	83 ec 04             	sub    $0x4,%esp
 159:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 15f:	56                   	push   %esi
 160:	68 6a 0c 00 00       	push   $0xc6a
 165:	6a 01                	push   $0x1
 167:	e8 b4 07 00 00       	call   920 <printf>
                    if(dirWalker[j].inodesCount != dinodePtr->nlink){
 16c:	0f bf 4f 06          	movswl 0x6(%edi),%ecx
 170:	8b 53 04             	mov    0x4(%ebx),%edx
 173:	83 c4 10             	add    $0x10,%esp
 176:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 17c:	39 ca                	cmp    %ecx,%edx
 17e:	0f 84 8c 00 00 00    	je     210 <inodeTBWalkerComparison+0x1e0>
                        printf(1, "DIFFERENCE for inode %d ---- DirectoryWalker Count: %d, inodeTBWalker Count: %d\n\n", 
 184:	83 ec 0c             	sub    $0xc,%esp
            int tbWalkerInodeNum = i + (numB * IPB);
            //printf(1, "type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n", 
            //dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
            printf(1, "DIRWALKERSIZE: %d, inode ith: %d\n\n", dirWalkerSize, tbWalkerInodeNum);
            
            for(int j = 0; j < dirWalkerSize; j++){
 187:	83 c6 01             	add    $0x1,%esi
 18a:	83 c3 10             	add    $0x10,%ebx
                
                if(dirWalker[j].inode == tbWalkerInodeNum){
                    printf(1, "dirWalker jth %d\n\n", j);
                    if(dirWalker[j].inodesCount != dinodePtr->nlink){
                        printf(1, "DIFFERENCE for inode %d ---- DirectoryWalker Count: %d, inodeTBWalker Count: %d\n\n", 
 18d:	51                   	push   %ecx
 18e:	52                   	push   %edx
 18f:	50                   	push   %eax
 190:	68 28 0d 00 00       	push   $0xd28
 195:	6a 01                	push   $0x1
 197:	e8 84 07 00 00       	call   920 <printf>
                        tbWalkerInodeNum, dirWalker[j].inodesCount, dinodePtr->nlink);

                        printf(1, "inode SUMMARY --- type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n\n\n\n", 
 19c:	83 c4 1c             	add    $0x1c,%esp
 19f:	ff 77 08             	pushl  0x8(%edi)
 1a2:	0f bf 57 06          	movswl 0x6(%edi),%edx
 1a6:	52                   	push   %edx
 1a7:	0f bf 57 04          	movswl 0x4(%edi),%edx
 1ab:	52                   	push   %edx
 1ac:	0f bf 57 02          	movswl 0x2(%edi),%edx
 1b0:	52                   	push   %edx
 1b1:	0f bf 17             	movswl (%edi),%edx
 1b4:	52                   	push   %edx
 1b5:	68 7c 0d 00 00       	push   $0xd7c
 1ba:	6a 01                	push   $0x1
 1bc:	e8 5f 07 00 00       	call   920 <printf>
 1c1:	83 c4 20             	add    $0x20,%esp
            int tbWalkerInodeNum = i + (numB * IPB);
            //printf(1, "type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n", 
            //dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
            printf(1, "DIRWALKERSIZE: %d, inode ith: %d\n\n", dirWalkerSize, tbWalkerInodeNum);
            
            for(int j = 0; j < dirWalkerSize; j++){
 1c4:	39 35 80 11 00 00    	cmp    %esi,0x1180
 1ca:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 1d0:	7f 80                	jg     152 <inodeTBWalkerComparison+0x122>
 1d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "Contents of sb: inodes - %d, size - %d, nblocks - %d, inodestart - %d\n", 
    sb.ninodes, sb.size, sb.nblocks, sb.inodestart);
    for(int numB = 0; numB < sb.ninodes / IPB; numB++){
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        for(int i = 0; i < IPB; i++){    
 1d8:	8d 4d e8             	lea    -0x18(%ebp),%ecx

            for(int i = 0; i < NDIRECT+1; i++){
                //printf(1, "%d, ", dinodePtr->addrs[i]);

            } 
            dinodePtr++;
 1db:	83 c7 40             	add    $0x40,%edi
 1de:	83 c0 01             	add    $0x1,%eax
    printf(1, "Contents of sb: inodes - %d, size - %d, nblocks - %d, inodestart - %d\n", 
    sb.ninodes, sb.size, sb.nblocks, sb.inodestart);
    for(int numB = 0; numB < sb.ninodes / IPB; numB++){
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        for(int i = 0; i < IPB; i++){    
 1e1:	39 cf                	cmp    %ecx,%edi
 1e3:	0f 85 17 ff ff ff    	jne    100 <inodeTBWalkerComparison+0xd0>

    callSBRead(st.dev, &sb);

    printf(1, "Contents of sb: inodes - %d, size - %d, nblocks - %d, inodestart - %d\n", 
    sb.ninodes, sb.size, sb.nblocks, sb.inodestart);
    for(int numB = 0; numB < sb.ninodes / IPB; numB++){
 1e9:	83 85 b0 fd ff ff 01 	addl   $0x1,-0x250(%ebp)
 1f0:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 1f6:	8b 8d b0 fd ff ff    	mov    -0x250(%ebp),%ecx
 1fc:	c1 e8 03             	shr    $0x3,%eax
 1ff:	39 c8                	cmp    %ecx,%eax
 201:	0f 87 c2 fe ff ff    	ja     c9 <inodeTBWalkerComparison+0x99>
        
        
    }


}
 207:	8d 65 f4             	lea    -0xc(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5f                   	pop    %edi
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop
                        tbWalkerInodeNum, dirWalker[j].inodesCount, dinodePtr->nlink);

                        printf(1, "inode SUMMARY --- type: %d,major: %d,minor: %d,nlink: %d,size: %d,size: %d\n\n\n\n", 
                                dinodePtr->type, dinodePtr->major, dinodePtr->minor, dinodePtr->nlink, dinodePtr->size);
                    } else {
                        printf(1, "inode %d count matches, verified\n\n\n\n", dirWalker[j].inode);
 210:	83 ec 04             	sub    $0x4,%esp
 213:	ff 33                	pushl  (%ebx)
 215:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 21b:	68 cc 0d 00 00       	push   $0xdcc
 220:	6a 01                	push   $0x1
 222:	e8 f9 06 00 00       	call   920 <printf>
 227:	83 c4 10             	add    $0x10,%esp
 22a:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 230:	e9 0b ff ff ff       	jmp    140 <inodeTBWalkerComparison+0x110>
    int fd;
    struct superblock sb; 
    uchar dataBuffer[BSIZE];

    if((fd = open("/", 0)) < 0){
        printf(2, "ls: cannot open %s\n", "/");
 235:	83 ec 04             	sub    $0x4,%esp
 238:	68 40 0c 00 00       	push   $0xc40
 23d:	68 42 0c 00 00       	push   $0xc42
 242:	6a 02                	push   $0x2
 244:	e8 d7 06 00 00       	call   920 <printf>
        return;
 249:	83 c4 10             	add    $0x10,%esp
        
        
    }


}
 24c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24f:	5b                   	pop    %ebx
 250:	5e                   	pop    %esi
 251:	5f                   	pop    %edi
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
        printf(2, "ls: cannot open %s\n", "/");
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", "/");
 254:	83 ec 04             	sub    $0x4,%esp
 257:	68 40 0c 00 00       	push   $0xc40
 25c:	68 56 0c 00 00       	push   $0xc56
 261:	6a 02                	push   $0x2
 263:	e8 b8 06 00 00       	call   920 <printf>
        close(fd);
 268:	89 1c 24             	mov    %ebx,(%esp)
 26b:	e8 5a 05 00 00       	call   7ca <close>
        return;
 270:	83 c4 10             	add    $0x10,%esp
        
        
    }


}
 273:	8d 65 f4             	lea    -0xc(%ebp),%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <incrementRefCount>:

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
 285:	8b 45 0c             	mov    0xc(%ebp),%eax
 288:	53                   	push   %ebx
 289:	8b 7d 08             	mov    0x8(%ebp),%edi
 28c:	0f b7 5d 10          	movzwl 0x10(%ebp),%ebx
    for(int i = 0; i < dirWalkerSize; i++){
 290:	85 c0                	test   %eax,%eax
 292:	7e 1d                	jle    2b1 <incrementRefCount+0x31>
        if(dirWalker[i].inode == de.inum){
 294:	31 c9                	xor    %ecx,%ecx
 296:	3b 1f                	cmp    (%edi),%ebx
 298:	8d 57 10             	lea    0x10(%edi),%edx
 29b:	75 0d                	jne    2aa <incrementRefCount+0x2a>
 29d:	eb 2a                	jmp    2c9 <incrementRefCount+0x49>
 29f:	90                   	nop
 2a0:	89 d6                	mov    %edx,%esi
 2a2:	83 c2 10             	add    $0x10,%edx
 2a5:	39 5a f0             	cmp    %ebx,-0x10(%edx)
 2a8:	74 21                	je     2cb <incrementRefCount+0x4b>


}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
 2aa:	83 c1 01             	add    $0x1,%ecx
 2ad:	39 c8                	cmp    %ecx,%eax
 2af:	75 ef                	jne    2a0 <incrementRefCount+0x20>
            return dirWalkerSize;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
 2b1:	89 c2                	mov    %eax,%edx
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
 2b3:	83 c0 01             	add    $0x1,%eax
            return dirWalkerSize;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
 2b6:	c1 e2 04             	shl    $0x4,%edx
 2b9:	01 d7                	add    %edx,%edi
 2bb:	89 1f                	mov    %ebx,(%edi)
    dirWalker[dirWalkerSize].inodesCount = 1;
 2bd:	c7 47 04 01 00 00 00 	movl   $0x1,0x4(%edi)
    return dirWalkerSize + 1;
}
 2c4:	5b                   	pop    %ebx
 2c5:	5e                   	pop    %esi
 2c6:	5f                   	pop    %edi
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    

}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
        if(dirWalker[i].inode == de.inum){
 2c9:	89 fe                	mov    %edi,%esi
            dirWalker[i].inodesCount++;
 2cb:	83 46 04 01          	addl   $0x1,0x4(%esi)

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
}
 2cf:	5b                   	pop    %ebx
 2d0:	5e                   	pop    %esi
 2d1:	5f                   	pop    %edi
 2d2:	5d                   	pop    %ebp
 2d3:	c3                   	ret    
 2d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002e0 <directoryWalkerComparison>:

void directoryWalkerComparison(char* path){
 2e0:	55                   	push   %ebp
    char buf[512] = {0};
 2e1:	31 c0                	xor    %eax,%eax
 2e3:	b9 80 00 00 00       	mov    $0x80,%ecx
    dirWalker[dirWalkerSize].inode = de.inum;
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
}

void directoryWalkerComparison(char* path){
 2e8:	89 e5                	mov    %esp,%ebp
 2ea:	57                   	push   %edi
 2eb:	56                   	push   %esi
 2ec:	53                   	push   %ebx
    char buf[512] = {0};
 2ed:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    dirWalker[dirWalkerSize].inode = de.inum;
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
}

void directoryWalkerComparison(char* path){
 2f3:	81 ec 60 02 00 00    	sub    $0x260,%esp
 2f9:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512] = {0};
 2fc:	f3 ab                	rep stos %eax,%es:(%edi)
    int fd;
    struct dirent de;
    struct stat st;

   
    printf(1, "DEBUG PATH: %s\n", path);
 2fe:	56                   	push   %esi
 2ff:	68 7d 0c 00 00       	push   $0xc7d
 304:	6a 01                	push   $0x1
 306:	e8 15 06 00 00       	call   920 <printf>

    if((fd = open(path, 0)) < 0){
 30b:	58                   	pop    %eax
 30c:	5a                   	pop    %edx
 30d:	6a 00                	push   $0x0
 30f:	56                   	push   %esi
 310:	e8 cd 04 00 00       	call   7e2 <open>
 315:	83 c4 10             	add    $0x10,%esp
 318:	85 c0                	test   %eax,%eax
 31a:	78 54                	js     370 <directoryWalkerComparison+0x90>
 31c:	89 c3                	mov    %eax,%ebx
        printf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
 31e:	8d 85 b4 fd ff ff    	lea    -0x24c(%ebp),%eax
 324:	83 ec 08             	sub    $0x8,%esp
 327:	50                   	push   %eax
 328:	53                   	push   %ebx
 329:	e8 cc 04 00 00       	call   7fa <fstat>
 32e:	83 c4 10             	add    $0x10,%esp
 331:	85 c0                	test   %eax,%eax
 333:	0f 88 e7 01 00 00    	js     520 <directoryWalkerComparison+0x240>
        printf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    if(st.type != T_DIR){
 339:	66 83 bd b4 fd ff ff 	cmpw   $0x1,-0x24c(%ebp)
 340:	01 
 341:	74 4d                	je     390 <directoryWalkerComparison+0xb0>
        printf(1, "Filename: %s \n inode number: %d\n", path, st.ino);
 343:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
 349:	56                   	push   %esi
 34a:	68 f4 0d 00 00       	push   $0xdf4
 34f:	6a 01                	push   $0x1
 351:	e8 ca 05 00 00       	call   920 <printf>
        close(fd);
 356:	89 1c 24             	mov    %ebx,(%esp)
 359:	e8 6c 04 00 00       	call   7ca <close>
        return;
 35e:	83 c4 10             	add    $0x10,%esp
        directoryWalkerComparison(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}
 361:	8d 65 f4             	lea    -0xc(%ebp),%esp
 364:	5b                   	pop    %ebx
 365:	5e                   	pop    %esi
 366:	5f                   	pop    %edi
 367:	5d                   	pop    %ebp
 368:	c3                   	ret    
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

   
    printf(1, "DEBUG PATH: %s\n", path);

    if((fd = open(path, 0)) < 0){
        printf(2, "ls: cannot open %s\n", path);
 370:	83 ec 04             	sub    $0x4,%esp
 373:	56                   	push   %esi
 374:	68 42 0c 00 00       	push   $0xc42
 379:	6a 02                	push   $0x2
 37b:	e8 a0 05 00 00       	call   920 <printf>
        return;
 380:	83 c4 10             	add    $0x10,%esp
        directoryWalkerComparison(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}
 383:	8d 65 f4             	lea    -0xc(%ebp),%esp
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret    
 38b:	90                   	nop
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return;
    }
    

    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 390:	83 ec 0c             	sub    $0xc,%esp
 393:	56                   	push   %esi
 394:	e8 47 02 00 00       	call   5e0 <strlen>
 399:	83 c0 20             	add    $0x20,%eax
 39c:	83 c4 10             	add    $0x10,%esp
 39f:	3d 00 02 00 00       	cmp    $0x200,%eax
 3a4:	0f 87 96 01 00 00    	ja     540 <directoryWalkerComparison+0x260>
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
 3aa:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 3b0:	83 ec 08             	sub    $0x8,%esp
    p = buf+strlen(buf);
 3b3:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
 3b9:	56                   	push   %esi
 3ba:	50                   	push   %eax
 3bb:	e8 a0 01 00 00       	call   560 <strcpy>
    p = buf+strlen(buf);
 3c0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 3c6:	89 04 24             	mov    %eax,(%esp)
 3c9:	e8 12 02 00 00       	call   5e0 <strlen>
 3ce:	01 c7                	add    %eax,%edi
    *p++ = '/';
 3d0:	8d 84 05 e9 fd ff ff 	lea    -0x217(%ebp,%eax,1),%eax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 3d7:	83 c4 10             	add    $0x10,%esp
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
    p = buf+strlen(buf);
 3da:	89 bd a4 fd ff ff    	mov    %edi,-0x25c(%ebp)
    *p++ = '/';
 3e0:	c6 07 2f             	movb   $0x2f,(%edi)
 3e3:	89 85 a0 fd ff ff    	mov    %eax,-0x260(%ebp)
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 3f0:	8d 85 c8 fd ff ff    	lea    -0x238(%ebp),%eax
 3f6:	83 ec 04             	sub    $0x4,%esp
 3f9:	6a 20                	push   $0x20
 3fb:	50                   	push   %eax
 3fc:	53                   	push   %ebx
 3fd:	e8 b8 03 00 00       	call   7ba <read>
 402:	83 c4 10             	add    $0x10,%esp
 405:	83 f8 20             	cmp    $0x20,%eax
 408:	0f 85 53 ff ff ff    	jne    361 <directoryWalkerComparison+0x81>
        if(de.inum == 0)
 40e:	0f b7 8d c8 fd ff ff 	movzwl -0x238(%ebp),%ecx
 415:	66 85 c9             	test   %cx,%cx
 418:	74 d6                	je     3f0 <directoryWalkerComparison+0x110>
            continue;


        dirWalkerSize = incrementRefCount(dirWalker, dirWalkerSize, de);
 41a:	8b 35 80 11 00 00    	mov    0x1180,%esi


}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
 420:	85 f6                	test   %esi,%esi
 422:	7e 31                	jle    455 <directoryWalkerComparison+0x175>
        if(dirWalker[i].inode == de.inum){
 424:	31 d2                	xor    %edx,%edx
 426:	3b 0d a0 11 00 00    	cmp    0x11a0,%ecx
 42c:	b8 b0 11 00 00       	mov    $0x11b0,%eax
 431:	75 1b                	jne    44e <directoryWalkerComparison+0x16e>
 433:	e9 cb 00 00 00       	jmp    503 <directoryWalkerComparison+0x223>
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 440:	89 c7                	mov    %eax,%edi
 442:	83 c0 10             	add    $0x10,%eax
 445:	39 48 f0             	cmp    %ecx,-0x10(%eax)
 448:	0f 84 c2 00 00 00    	je     510 <directoryWalkerComparison+0x230>


}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
 44e:	83 c2 01             	add    $0x1,%edx
 451:	39 d6                	cmp    %edx,%esi
 453:	75 eb                	jne    440 <directoryWalkerComparison+0x160>
            return dirWalkerSize;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
 455:	89 f0                	mov    %esi,%eax
    dirWalker[dirWalkerSize].inodesCount = 1;
    return dirWalkerSize + 1;
 457:	83 c6 01             	add    $0x1,%esi
            return dirWalkerSize;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    dirWalker[dirWalkerSize].inode = de.inum;
 45a:	c1 e0 04             	shl    $0x4,%eax
 45d:	89 88 a0 11 00 00    	mov    %ecx,0x11a0(%eax)
    dirWalker[dirWalkerSize].inodesCount = 1;
 463:	c7 80 a4 11 00 00 01 	movl   $0x1,0x11a4(%eax)
 46a:	00 00 00 

        dirWalkerSize = incrementRefCount(dirWalker, dirWalkerSize, de);

        

        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;
 46d:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 473:	83 ec 08             	sub    $0x8,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if(de.inum == 0)
            continue;


        dirWalkerSize = incrementRefCount(dirWalker, dirWalkerSize, de);
 476:	89 35 80 11 00 00    	mov    %esi,0x1180

        

        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;
 47c:	68 a1 0c 00 00       	push   $0xca1
 481:	50                   	push   %eax
 482:	e8 09 01 00 00       	call   590 <strcmp>
 487:	83 c4 10             	add    $0x10,%esp
 48a:	85 c0                	test   %eax,%eax
 48c:	0f 84 5e ff ff ff    	je     3f0 <directoryWalkerComparison+0x110>
 492:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 498:	83 ec 08             	sub    $0x8,%esp
 49b:	68 a0 0c 00 00       	push   $0xca0
 4a0:	50                   	push   %eax
 4a1:	e8 ea 00 00 00       	call   590 <strcmp>
 4a6:	83 c4 10             	add    $0x10,%esp
 4a9:	85 c0                	test   %eax,%eax
 4ab:	0f 84 3f ff ff ff    	je     3f0 <directoryWalkerComparison+0x110>

        memmove(p, de.name, DIRSIZ);
 4b1:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 4b7:	83 ec 04             	sub    $0x4,%esp
 4ba:	6a 1e                	push   $0x1e
 4bc:	50                   	push   %eax
 4bd:	ff b5 a0 fd ff ff    	pushl  -0x260(%ebp)
 4c3:	e8 a8 02 00 00       	call   770 <memmove>
        directoryWalkerComparison(buf);
 4c8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 4ce:	89 04 24             	mov    %eax,(%esp)
 4d1:	e8 0a fe ff ff       	call   2e0 <directoryWalkerComparison>
        p[DIRSIZ] = 0;
 4d6:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 4dc:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
 4e0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 4e6:	50                   	push   %eax
 4e7:	0f b7 85 c8 fd ff ff 	movzwl -0x238(%ebp),%eax
 4ee:	50                   	push   %eax
 4ef:	68 a3 0c 00 00       	push   $0xca3
 4f4:	6a 01                	push   $0x1
 4f6:	e8 25 04 00 00       	call   920 <printf>
 4fb:	83 c4 20             	add    $0x20,%esp
 4fe:	e9 ed fe ff ff       	jmp    3f0 <directoryWalkerComparison+0x110>

}

int incrementRefCount(struct dirSummary *dirWalker, int dirWalkerSize, struct dirent de){
    for(int i = 0; i < dirWalkerSize; i++){
        if(dirWalker[i].inode == de.inum){
 503:	bf a0 11 00 00       	mov    $0x11a0,%edi
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            dirWalker[i].inodesCount++;
 510:	83 47 04 01          	addl   $0x1,0x4(%edi)
 514:	e9 54 ff ff ff       	jmp    46d <directoryWalkerComparison+0x18d>
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", path);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	56                   	push   %esi
 524:	68 56 0c 00 00       	push   $0xc56
 529:	6a 02                	push   $0x2
 52b:	e8 f0 03 00 00       	call   920 <printf>
        close(fd);
 530:	89 1c 24             	mov    %ebx,(%esp)
 533:	e8 92 02 00 00       	call   7ca <close>
        return;
 538:	83 c4 10             	add    $0x10,%esp
 53b:	e9 21 fe ff ff       	jmp    361 <directoryWalkerComparison+0x81>
    }
    

    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
 540:	83 ec 08             	sub    $0x8,%esp
 543:	68 8d 0c 00 00       	push   $0xc8d
 548:	6a 01                	push   $0x1
 54a:	e8 d1 03 00 00       	call   920 <printf>
 54f:	83 c4 10             	add    $0x10,%esp
 552:	e9 53 fe ff ff       	jmp    3aa <directoryWalkerComparison+0xca>
 557:	66 90                	xchg   %ax,%ax
 559:	66 90                	xchg   %ax,%ax
 55b:	66 90                	xchg   %ax,%ax
 55d:	66 90                	xchg   %ax,%ax
 55f:	90                   	nop

00000560 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	8b 45 08             	mov    0x8(%ebp),%eax
 567:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 56a:	89 c2                	mov    %eax,%edx
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	83 c1 01             	add    $0x1,%ecx
 573:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 577:	83 c2 01             	add    $0x1,%edx
 57a:	84 db                	test   %bl,%bl
 57c:	88 5a ff             	mov    %bl,-0x1(%edx)
 57f:	75 ef                	jne    570 <strcpy+0x10>
    ;
  return os;
}
 581:	5b                   	pop    %ebx
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 58a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000590 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	56                   	push   %esi
 594:	53                   	push   %ebx
 595:	8b 55 08             	mov    0x8(%ebp),%edx
 598:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 59b:	0f b6 02             	movzbl (%edx),%eax
 59e:	0f b6 19             	movzbl (%ecx),%ebx
 5a1:	84 c0                	test   %al,%al
 5a3:	75 1e                	jne    5c3 <strcmp+0x33>
 5a5:	eb 29                	jmp    5d0 <strcmp+0x40>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 5b0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5b6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5b9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 5bd:	84 c0                	test   %al,%al
 5bf:	74 0f                	je     5d0 <strcmp+0x40>
 5c1:	89 f1                	mov    %esi,%ecx
 5c3:	38 d8                	cmp    %bl,%al
 5c5:	74 e9                	je     5b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 5c7:	29 d8                	sub    %ebx,%eax
}
 5c9:	5b                   	pop    %ebx
 5ca:	5e                   	pop    %esi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret    
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5d0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 5d2:	29 d8                	sub    %ebx,%eax
}
 5d4:	5b                   	pop    %ebx
 5d5:	5e                   	pop    %esi
 5d6:	5d                   	pop    %ebp
 5d7:	c3                   	ret    
 5d8:	90                   	nop
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <strlen>:

uint
strlen(const char *s)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 5e6:	80 39 00             	cmpb   $0x0,(%ecx)
 5e9:	74 12                	je     5fd <strlen+0x1d>
 5eb:	31 d2                	xor    %edx,%edx
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
 5f0:	83 c2 01             	add    $0x1,%edx
 5f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 5f7:	89 d0                	mov    %edx,%eax
 5f9:	75 f5                	jne    5f0 <strlen+0x10>
    ;
  return n;
}
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 5fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 5ff:	5d                   	pop    %ebp
 600:	c3                   	ret    
 601:	eb 0d                	jmp    610 <memset>
 603:	90                   	nop
 604:	90                   	nop
 605:	90                   	nop
 606:	90                   	nop
 607:	90                   	nop
 608:	90                   	nop
 609:	90                   	nop
 60a:	90                   	nop
 60b:	90                   	nop
 60c:	90                   	nop
 60d:	90                   	nop
 60e:	90                   	nop
 60f:	90                   	nop

00000610 <memset>:

void*
memset(void *dst, int c, uint n)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 617:	8b 4d 10             	mov    0x10(%ebp),%ecx
 61a:	8b 45 0c             	mov    0xc(%ebp),%eax
 61d:	89 d7                	mov    %edx,%edi
 61f:	fc                   	cld    
 620:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 622:	89 d0                	mov    %edx,%eax
 624:	5f                   	pop    %edi
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <strchr>:

char*
strchr(const char *s, char c)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	53                   	push   %ebx
 634:	8b 45 08             	mov    0x8(%ebp),%eax
 637:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 63a:	0f b6 10             	movzbl (%eax),%edx
 63d:	84 d2                	test   %dl,%dl
 63f:	74 1d                	je     65e <strchr+0x2e>
    if(*s == c)
 641:	38 d3                	cmp    %dl,%bl
 643:	89 d9                	mov    %ebx,%ecx
 645:	75 0d                	jne    654 <strchr+0x24>
 647:	eb 17                	jmp    660 <strchr+0x30>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 650:	38 ca                	cmp    %cl,%dl
 652:	74 0c                	je     660 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 654:	83 c0 01             	add    $0x1,%eax
 657:	0f b6 10             	movzbl (%eax),%edx
 65a:	84 d2                	test   %dl,%dl
 65c:	75 f2                	jne    650 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 65e:	31 c0                	xor    %eax,%eax
}
 660:	5b                   	pop    %ebx
 661:	5d                   	pop    %ebp
 662:	c3                   	ret    
 663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <gets>:

char*
gets(char *buf, int max)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 676:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 678:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 67b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 67e:	eb 29                	jmp    6a9 <gets+0x39>
    cc = read(0, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	6a 01                	push   $0x1
 685:	57                   	push   %edi
 686:	6a 00                	push   $0x0
 688:	e8 2d 01 00 00       	call   7ba <read>
    if(cc < 1)
 68d:	83 c4 10             	add    $0x10,%esp
 690:	85 c0                	test   %eax,%eax
 692:	7e 1d                	jle    6b1 <gets+0x41>
      break;
    buf[i++] = c;
 694:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 698:	8b 55 08             	mov    0x8(%ebp),%edx
 69b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 69d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 69f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6a3:	74 1b                	je     6c0 <gets+0x50>
 6a5:	3c 0d                	cmp    $0xd,%al
 6a7:	74 17                	je     6c0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6a9:	8d 5e 01             	lea    0x1(%esi),%ebx
 6ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6af:	7c cf                	jl     680 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6b1:	8b 45 08             	mov    0x8(%ebp),%eax
 6b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6bb:	5b                   	pop    %ebx
 6bc:	5e                   	pop    %esi
 6bd:	5f                   	pop    %edi
 6be:	5d                   	pop    %ebp
 6bf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 6c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6cc:	5b                   	pop    %ebx
 6cd:	5e                   	pop    %esi
 6ce:	5f                   	pop    %edi
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	eb 0d                	jmp    6e0 <stat>
 6d3:	90                   	nop
 6d4:	90                   	nop
 6d5:	90                   	nop
 6d6:	90                   	nop
 6d7:	90                   	nop
 6d8:	90                   	nop
 6d9:	90                   	nop
 6da:	90                   	nop
 6db:	90                   	nop
 6dc:	90                   	nop
 6dd:	90                   	nop
 6de:	90                   	nop
 6df:	90                   	nop

000006e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	56                   	push   %esi
 6e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6e5:	83 ec 08             	sub    $0x8,%esp
 6e8:	6a 00                	push   $0x0
 6ea:	ff 75 08             	pushl  0x8(%ebp)
 6ed:	e8 f0 00 00 00       	call   7e2 <open>
  if(fd < 0)
 6f2:	83 c4 10             	add    $0x10,%esp
 6f5:	85 c0                	test   %eax,%eax
 6f7:	78 27                	js     720 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6f9:	83 ec 08             	sub    $0x8,%esp
 6fc:	ff 75 0c             	pushl  0xc(%ebp)
 6ff:	89 c3                	mov    %eax,%ebx
 701:	50                   	push   %eax
 702:	e8 f3 00 00 00       	call   7fa <fstat>
 707:	89 c6                	mov    %eax,%esi
  close(fd);
 709:	89 1c 24             	mov    %ebx,(%esp)
 70c:	e8 b9 00 00 00       	call   7ca <close>
  return r;
 711:	83 c4 10             	add    $0x10,%esp
 714:	89 f0                	mov    %esi,%eax
}
 716:	8d 65 f8             	lea    -0x8(%ebp),%esp
 719:	5b                   	pop    %ebx
 71a:	5e                   	pop    %esi
 71b:	5d                   	pop    %ebp
 71c:	c3                   	ret    
 71d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 720:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 725:	eb ef                	jmp    716 <stat+0x36>
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	53                   	push   %ebx
 734:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 737:	0f be 11             	movsbl (%ecx),%edx
 73a:	8d 42 d0             	lea    -0x30(%edx),%eax
 73d:	3c 09                	cmp    $0x9,%al
 73f:	b8 00 00 00 00       	mov    $0x0,%eax
 744:	77 1f                	ja     765 <atoi+0x35>
 746:	8d 76 00             	lea    0x0(%esi),%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 750:	8d 04 80             	lea    (%eax,%eax,4),%eax
 753:	83 c1 01             	add    $0x1,%ecx
 756:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 75a:	0f be 11             	movsbl (%ecx),%edx
 75d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 760:	80 fb 09             	cmp    $0x9,%bl
 763:	76 eb                	jbe    750 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 765:	5b                   	pop    %ebx
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000770 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	56                   	push   %esi
 774:	53                   	push   %ebx
 775:	8b 5d 10             	mov    0x10(%ebp),%ebx
 778:	8b 45 08             	mov    0x8(%ebp),%eax
 77b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 77e:	85 db                	test   %ebx,%ebx
 780:	7e 14                	jle    796 <memmove+0x26>
 782:	31 d2                	xor    %edx,%edx
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 788:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 78c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 78f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 792:	39 da                	cmp    %ebx,%edx
 794:	75 f2                	jne    788 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 796:	5b                   	pop    %ebx
 797:	5e                   	pop    %esi
 798:	5d                   	pop    %ebp
 799:	c3                   	ret    

0000079a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 79a:	b8 01 00 00 00       	mov    $0x1,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret    

000007a2 <exit>:
SYSCALL(exit)
 7a2:	b8 02 00 00 00       	mov    $0x2,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret    

000007aa <wait>:
SYSCALL(wait)
 7aa:	b8 03 00 00 00       	mov    $0x3,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <pipe>:
SYSCALL(pipe)
 7b2:	b8 04 00 00 00       	mov    $0x4,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <read>:
SYSCALL(read)
 7ba:	b8 05 00 00 00       	mov    $0x5,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <write>:
SYSCALL(write)
 7c2:	b8 10 00 00 00       	mov    $0x10,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <close>:
SYSCALL(close)
 7ca:	b8 15 00 00 00       	mov    $0x15,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <kill>:
SYSCALL(kill)
 7d2:	b8 06 00 00 00       	mov    $0x6,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <exec>:
SYSCALL(exec)
 7da:	b8 07 00 00 00       	mov    $0x7,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <open>:
SYSCALL(open)
 7e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <mknod>:
SYSCALL(mknod)
 7ea:	b8 11 00 00 00       	mov    $0x11,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <unlink>:
SYSCALL(unlink)
 7f2:	b8 12 00 00 00       	mov    $0x12,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <fstat>:
SYSCALL(fstat)
 7fa:	b8 08 00 00 00       	mov    $0x8,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <link>:
SYSCALL(link)
 802:	b8 13 00 00 00       	mov    $0x13,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <mkdir>:
SYSCALL(mkdir)
 80a:	b8 14 00 00 00       	mov    $0x14,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <chdir>:
SYSCALL(chdir)
 812:	b8 09 00 00 00       	mov    $0x9,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <dup>:
SYSCALL(dup)
 81a:	b8 0a 00 00 00       	mov    $0xa,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <getpid>:
SYSCALL(getpid)
 822:	b8 0b 00 00 00       	mov    $0xb,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <sbrk>:
SYSCALL(sbrk)
 82a:	b8 0c 00 00 00       	mov    $0xc,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <sleep>:
SYSCALL(sleep)
 832:	b8 0d 00 00 00       	mov    $0xd,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <uptime>:
SYSCALL(uptime)
 83a:	b8 0e 00 00 00       	mov    $0xe,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <countTrap>:
SYSCALL(countTrap)
 842:	b8 16 00 00 00       	mov    $0x16,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <getSharedPage>:
SYSCALL(getSharedPage)
 84a:	b8 17 00 00 00       	mov    $0x17,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <freeSharedPage>:
SYSCALL(freeSharedPage)
 852:	b8 18 00 00 00       	mov    $0x18,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <callBRead>:
SYSCALL(callBRead)
 85a:	b8 19 00 00 00       	mov    $0x19,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <callSBRead>:
SYSCALL(callSBRead)
 862:	b8 1a 00 00 00       	mov    $0x1a,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <seek>:
SYSCALL(seek)
 86a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <callBWrite>:
 872:	b8 1c 00 00 00       	mov    $0x1c,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	89 c6                	mov    %eax,%esi
 888:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 88e:	85 db                	test   %ebx,%ebx
 890:	74 7e                	je     910 <printint+0x90>
 892:	89 d0                	mov    %edx,%eax
 894:	c1 e8 1f             	shr    $0x1f,%eax
 897:	84 c0                	test   %al,%al
 899:	74 75                	je     910 <printint+0x90>
    neg = 1;
    x = -xx;
 89b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 89d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 8a4:	f7 d8                	neg    %eax
 8a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 8a9:	31 ff                	xor    %edi,%edi
 8ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8ae:	89 ce                	mov    %ecx,%esi
 8b0:	eb 08                	jmp    8ba <printint+0x3a>
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 8b8:	89 cf                	mov    %ecx,%edi
 8ba:	31 d2                	xor    %edx,%edx
 8bc:	8d 4f 01             	lea    0x1(%edi),%ecx
 8bf:	f7 f6                	div    %esi
 8c1:	0f b6 92 20 0e 00 00 	movzbl 0xe20(%edx),%edx
  }while((x /= base) != 0);
 8c8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 8ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8cd:	75 e9                	jne    8b8 <printint+0x38>
  if(neg)
 8cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 8d5:	85 c0                	test   %eax,%eax
 8d7:	74 08                	je     8e1 <printint+0x61>
    buf[i++] = '-';
 8d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 8de:	8d 4f 02             	lea    0x2(%edi),%ecx
 8e1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 8e5:	8d 76 00             	lea    0x0(%esi),%esi
 8e8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8eb:	83 ec 04             	sub    $0x4,%esp
 8ee:	83 ef 01             	sub    $0x1,%edi
 8f1:	6a 01                	push   $0x1
 8f3:	53                   	push   %ebx
 8f4:	56                   	push   %esi
 8f5:	88 45 d7             	mov    %al,-0x29(%ebp)
 8f8:	e8 c5 fe ff ff       	call   7c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 8fd:	83 c4 10             	add    $0x10,%esp
 900:	39 df                	cmp    %ebx,%edi
 902:	75 e4                	jne    8e8 <printint+0x68>
    putc(fd, buf[i]);
}
 904:	8d 65 f4             	lea    -0xc(%ebp),%esp
 907:	5b                   	pop    %ebx
 908:	5e                   	pop    %esi
 909:	5f                   	pop    %edi
 90a:	5d                   	pop    %ebp
 90b:	c3                   	ret    
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 910:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 912:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 919:	eb 8b                	jmp    8a6 <printint+0x26>
 91b:	90                   	nop
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000920 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 926:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 929:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 92c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 92f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 932:	89 45 d0             	mov    %eax,-0x30(%ebp)
 935:	0f b6 1e             	movzbl (%esi),%ebx
 938:	83 c6 01             	add    $0x1,%esi
 93b:	84 db                	test   %bl,%bl
 93d:	0f 84 b0 00 00 00    	je     9f3 <printf+0xd3>
 943:	31 d2                	xor    %edx,%edx
 945:	eb 39                	jmp    980 <printf+0x60>
 947:	89 f6                	mov    %esi,%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 950:	83 f8 25             	cmp    $0x25,%eax
 953:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 956:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 95b:	74 18                	je     975 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 95d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 960:	83 ec 04             	sub    $0x4,%esp
 963:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 966:	6a 01                	push   $0x1
 968:	50                   	push   %eax
 969:	57                   	push   %edi
 96a:	e8 53 fe ff ff       	call   7c2 <write>
 96f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 972:	83 c4 10             	add    $0x10,%esp
 975:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 978:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 97c:	84 db                	test   %bl,%bl
 97e:	74 73                	je     9f3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 980:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 982:	0f be cb             	movsbl %bl,%ecx
 985:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 988:	74 c6                	je     950 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 98a:	83 fa 25             	cmp    $0x25,%edx
 98d:	75 e6                	jne    975 <printf+0x55>
      if(c == 'd'){
 98f:	83 f8 64             	cmp    $0x64,%eax
 992:	0f 84 f8 00 00 00    	je     a90 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 998:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 99e:	83 f9 70             	cmp    $0x70,%ecx
 9a1:	74 5d                	je     a00 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 9a3:	83 f8 73             	cmp    $0x73,%eax
 9a6:	0f 84 84 00 00 00    	je     a30 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9ac:	83 f8 63             	cmp    $0x63,%eax
 9af:	0f 84 ea 00 00 00    	je     a9f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9b5:	83 f8 25             	cmp    $0x25,%eax
 9b8:	0f 84 c2 00 00 00    	je     a80 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9c1:	83 ec 04             	sub    $0x4,%esp
 9c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9c8:	6a 01                	push   $0x1
 9ca:	50                   	push   %eax
 9cb:	57                   	push   %edi
 9cc:	e8 f1 fd ff ff       	call   7c2 <write>
 9d1:	83 c4 0c             	add    $0xc,%esp
 9d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9da:	6a 01                	push   $0x1
 9dc:	50                   	push   %eax
 9dd:	57                   	push   %edi
 9de:	83 c6 01             	add    $0x1,%esi
 9e1:	e8 dc fd ff ff       	call   7c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9ed:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9ef:	84 db                	test   %bl,%bl
 9f1:	75 8d                	jne    980 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 9f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9f6:	5b                   	pop    %ebx
 9f7:	5e                   	pop    %esi
 9f8:	5f                   	pop    %edi
 9f9:	5d                   	pop    %ebp
 9fa:	c3                   	ret    
 9fb:	90                   	nop
 9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a00:	83 ec 0c             	sub    $0xc,%esp
 a03:	b9 10 00 00 00       	mov    $0x10,%ecx
 a08:	6a 00                	push   $0x0
 a0a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a0d:	89 f8                	mov    %edi,%eax
 a0f:	8b 13                	mov    (%ebx),%edx
 a11:	e8 6a fe ff ff       	call   880 <printint>
        ap++;
 a16:	89 d8                	mov    %ebx,%eax
 a18:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a1b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 a1d:	83 c0 04             	add    $0x4,%eax
 a20:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a23:	e9 4d ff ff ff       	jmp    975 <printf+0x55>
 a28:	90                   	nop
 a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 a30:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a33:	8b 18                	mov    (%eax),%ebx
        ap++;
 a35:	83 c0 04             	add    $0x4,%eax
 a38:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 a3b:	b8 18 0e 00 00       	mov    $0xe18,%eax
 a40:	85 db                	test   %ebx,%ebx
 a42:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 a45:	0f b6 03             	movzbl (%ebx),%eax
 a48:	84 c0                	test   %al,%al
 a4a:	74 23                	je     a6f <printf+0x14f>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a50:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a53:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 a56:	83 ec 04             	sub    $0x4,%esp
 a59:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 a5b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a5e:	50                   	push   %eax
 a5f:	57                   	push   %edi
 a60:	e8 5d fd ff ff       	call   7c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a65:	0f b6 03             	movzbl (%ebx),%eax
 a68:	83 c4 10             	add    $0x10,%esp
 a6b:	84 c0                	test   %al,%al
 a6d:	75 e1                	jne    a50 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a6f:	31 d2                	xor    %edx,%edx
 a71:	e9 ff fe ff ff       	jmp    975 <printf+0x55>
 a76:	8d 76 00             	lea    0x0(%esi),%esi
 a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a80:	83 ec 04             	sub    $0x4,%esp
 a83:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a86:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a89:	6a 01                	push   $0x1
 a8b:	e9 4c ff ff ff       	jmp    9dc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 a90:	83 ec 0c             	sub    $0xc,%esp
 a93:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a98:	6a 01                	push   $0x1
 a9a:	e9 6b ff ff ff       	jmp    a0a <printf+0xea>
 a9f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 aa2:	83 ec 04             	sub    $0x4,%esp
 aa5:	8b 03                	mov    (%ebx),%eax
 aa7:	6a 01                	push   $0x1
 aa9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 aac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 aaf:	50                   	push   %eax
 ab0:	57                   	push   %edi
 ab1:	e8 0c fd ff ff       	call   7c2 <write>
 ab6:	e9 5b ff ff ff       	jmp    a16 <printf+0xf6>
 abb:	66 90                	xchg   %ax,%ax
 abd:	66 90                	xchg   %ax,%ax
 abf:	90                   	nop

00000ac0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac1:	a1 84 11 00 00       	mov    0x1184,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac6:	89 e5                	mov    %esp,%ebp
 ac8:	57                   	push   %edi
 ac9:	56                   	push   %esi
 aca:	53                   	push   %ebx
 acb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ace:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad3:	39 c8                	cmp    %ecx,%eax
 ad5:	73 19                	jae    af0 <free+0x30>
 ad7:	89 f6                	mov    %esi,%esi
 ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 ae0:	39 d1                	cmp    %edx,%ecx
 ae2:	72 1c                	jb     b00 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae4:	39 d0                	cmp    %edx,%eax
 ae6:	73 18                	jae    b00 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aee:	72 f0                	jb     ae0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af0:	39 d0                	cmp    %edx,%eax
 af2:	72 f4                	jb     ae8 <free+0x28>
 af4:	39 d1                	cmp    %edx,%ecx
 af6:	73 f0                	jae    ae8 <free+0x28>
 af8:	90                   	nop
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 b00:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b03:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b06:	39 d7                	cmp    %edx,%edi
 b08:	74 19                	je     b23 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b0d:	8b 50 04             	mov    0x4(%eax),%edx
 b10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b13:	39 f1                	cmp    %esi,%ecx
 b15:	74 23                	je     b3a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b17:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b19:	a3 84 11 00 00       	mov    %eax,0x1184
}
 b1e:	5b                   	pop    %ebx
 b1f:	5e                   	pop    %esi
 b20:	5f                   	pop    %edi
 b21:	5d                   	pop    %ebp
 b22:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b23:	03 72 04             	add    0x4(%edx),%esi
 b26:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b29:	8b 10                	mov    (%eax),%edx
 b2b:	8b 12                	mov    (%edx),%edx
 b2d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b30:	8b 50 04             	mov    0x4(%eax),%edx
 b33:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b36:	39 f1                	cmp    %esi,%ecx
 b38:	75 dd                	jne    b17 <free+0x57>
    p->s.size += bp->s.size;
 b3a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 b3d:	a3 84 11 00 00       	mov    %eax,0x1184
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b42:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b45:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b48:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b4a:	5b                   	pop    %ebx
 b4b:	5e                   	pop    %esi
 b4c:	5f                   	pop    %edi
 b4d:	5d                   	pop    %ebp
 b4e:	c3                   	ret    
 b4f:	90                   	nop

00000b50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b5c:	8b 15 84 11 00 00    	mov    0x1184,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b62:	8d 78 07             	lea    0x7(%eax),%edi
 b65:	c1 ef 03             	shr    $0x3,%edi
 b68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b6b:	85 d2                	test   %edx,%edx
 b6d:	0f 84 a3 00 00 00    	je     c16 <malloc+0xc6>
 b73:	8b 02                	mov    (%edx),%eax
 b75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b78:	39 cf                	cmp    %ecx,%edi
 b7a:	76 74                	jbe    bf0 <malloc+0xa0>
 b7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b82:	be 00 10 00 00       	mov    $0x1000,%esi
 b87:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 b8e:	0f 43 f7             	cmovae %edi,%esi
 b91:	ba 00 80 00 00       	mov    $0x8000,%edx
 b96:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 b9c:	0f 46 da             	cmovbe %edx,%ebx
 b9f:	eb 10                	jmp    bb1 <malloc+0x61>
 ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 baa:	8b 48 04             	mov    0x4(%eax),%ecx
 bad:	39 cf                	cmp    %ecx,%edi
 baf:	76 3f                	jbe    bf0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bb1:	39 05 84 11 00 00    	cmp    %eax,0x1184
 bb7:	89 c2                	mov    %eax,%edx
 bb9:	75 ed                	jne    ba8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 bbb:	83 ec 0c             	sub    $0xc,%esp
 bbe:	53                   	push   %ebx
 bbf:	e8 66 fc ff ff       	call   82a <sbrk>
  if(p == (char*)-1)
 bc4:	83 c4 10             	add    $0x10,%esp
 bc7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bca:	74 1c                	je     be8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 bcc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 bcf:	83 ec 0c             	sub    $0xc,%esp
 bd2:	83 c0 08             	add    $0x8,%eax
 bd5:	50                   	push   %eax
 bd6:	e8 e5 fe ff ff       	call   ac0 <free>
  return freep;
 bdb:	8b 15 84 11 00 00    	mov    0x1184,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 be1:	83 c4 10             	add    $0x10,%esp
 be4:	85 d2                	test   %edx,%edx
 be6:	75 c0                	jne    ba8 <malloc+0x58>
        return 0;
 be8:	31 c0                	xor    %eax,%eax
 bea:	eb 1c                	jmp    c08 <malloc+0xb8>
 bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 bf0:	39 cf                	cmp    %ecx,%edi
 bf2:	74 1c                	je     c10 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 bf4:	29 f9                	sub    %edi,%ecx
 bf6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bf9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bfc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 bff:	89 15 84 11 00 00    	mov    %edx,0x1184
      return (void*)(p + 1);
 c05:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c0b:	5b                   	pop    %ebx
 c0c:	5e                   	pop    %esi
 c0d:	5f                   	pop    %edi
 c0e:	5d                   	pop    %ebp
 c0f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c10:	8b 08                	mov    (%eax),%ecx
 c12:	89 0a                	mov    %ecx,(%edx)
 c14:	eb e9                	jmp    bff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c16:	c7 05 84 11 00 00 88 	movl   $0x1188,0x1184
 c1d:	11 00 00 
 c20:	c7 05 88 11 00 00 88 	movl   $0x1188,0x1188
 c27:	11 00 00 
    base.s.size = 0;
 c2a:	b8 88 11 00 00       	mov    $0x1188,%eax
 c2f:	c7 05 8c 11 00 00 00 	movl   $0x0,0x118c
 c36:	00 00 00 
 c39:	e9 3e ff ff ff       	jmp    b7c <malloc+0x2c>
