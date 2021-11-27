
_fixDamagedFS:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	56                   	push   %esi
       e:	53                   	push   %ebx
       f:	51                   	push   %ecx
      10:	83 ec 34             	sub    $0x34,%esp
    int fd;
    struct stat st;
    int dev;
    int ino;

    if((fd = open("/", 0)) < 0){
      13:	6a 00                	push   $0x0
      15:	68 cb 12 00 00       	push   $0x12cb
      1a:	e8 e3 0d 00 00       	call   e02 <open>
      1f:	83 c4 10             	add    $0x10,%esp
      22:	85 c0                	test   %eax,%eax
      24:	78 45                	js     6b <main+0x6b>
      26:	89 c3                	mov    %eax,%ebx
        printf(2, "ls: cannot open %s\n", "/");
        return -1;
    }

    if(fstat(fd, &st) < 0){
      28:	8d 45 d4             	lea    -0x2c(%ebp),%eax
      2b:	83 ec 08             	sub    $0x8,%esp
      2e:	50                   	push   %eax
      2f:	53                   	push   %ebx
      30:	e8 e5 0d 00 00       	call   e1a <fstat>
      35:	83 c4 10             	add    $0x10,%esp
      38:	85 c0                	test   %eax,%eax
      3a:	79 46                	jns    82 <main+0x82>
        printf(2, "ls: cannot stat %s\n", "/");
      3c:	83 ec 04             	sub    $0x4,%esp
      3f:	68 cb 12 00 00       	push   $0x12cb
      44:	68 81 13 00 00       	push   $0x1381
      49:	6a 02                	push   $0x2
      4b:	e8 f0 0e 00 00       	call   f40 <printf>
        close(fd);
      50:	89 1c 24             	mov    %ebx,(%esp)
      53:	e8 92 0d 00 00       	call   dea <close>
        return -1;
      58:	83 c4 10             	add    $0x10,%esp
  directoryWalkerFix("", dev, ino);
  printf(1, "BEFORE TBWALKER");
  inodeTBWalkerFix();
  
  exit();
      5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      63:	59                   	pop    %ecx
      64:	5b                   	pop    %ebx
      65:	5e                   	pop    %esi
      66:	5d                   	pop    %ebp
      67:	8d 61 fc             	lea    -0x4(%ecx),%esp
      6a:	c3                   	ret    
    struct stat st;
    int dev;
    int ino;

    if((fd = open("/", 0)) < 0){
        printf(2, "ls: cannot open %s\n", "/");
      6b:	51                   	push   %ecx
      6c:	68 cb 12 00 00       	push   $0x12cb
      71:	68 6d 13 00 00       	push   $0x136d
      76:	6a 02                	push   $0x2
      78:	e8 c3 0e 00 00       	call   f40 <printf>
        return -1;
      7d:	83 c4 10             	add    $0x10,%esp
      80:	eb d9                	jmp    5b <main+0x5b>
    }

    dev = st.dev;
    ino = st.ino;

    allInodes = malloc((sizeof(struct inodes) * 10000));
      82:	83 ec 0c             	sub    $0xc,%esp
        printf(2, "ls: cannot stat %s\n", "/");
        close(fd);
        return -1;
    }

    dev = st.dev;
      85:	8b 5d d8             	mov    -0x28(%ebp),%ebx
    ino = st.ino;
      88:	8b 75 dc             	mov    -0x24(%ebp),%esi

    allInodes = malloc((sizeof(struct inodes) * 10000));
      8b:	68 c0 d4 01 00       	push   $0x1d4c0
      90:	e8 db 10 00 00       	call   1170 <malloc>
    memset(allInodes, 0, (sizeof(struct inodes) * 10000));
      95:	83 c4 0c             	add    $0xc,%esp
    }

    dev = st.dev;
    ino = st.ino;

    allInodes = malloc((sizeof(struct inodes) * 10000));
      98:	a3 fc 18 00 00       	mov    %eax,0x18fc
    memset(allInodes, 0, (sizeof(struct inodes) * 10000));
      9d:	68 c0 d4 01 00       	push   $0x1d4c0
      a2:	6a 00                	push   $0x0
      a4:	50                   	push   %eax
      a5:	e8 86 0b 00 00       	call   c30 <memset>
    
  directoryWalkerFix("", dev, ino);
      aa:	83 c4 0c             	add    $0xc,%esp
      ad:	56                   	push   %esi
      ae:	53                   	push   %ebx
      af:	68 17 13 00 00       	push   $0x1317
      b4:	e8 b7 07 00 00       	call   870 <directoryWalkerFix>
  printf(1, "BEFORE TBWALKER");
      b9:	58                   	pop    %eax
      ba:	5a                   	pop    %edx
      bb:	68 fb 13 00 00       	push   $0x13fb
      c0:	6a 01                	push   $0x1
      c2:	e8 79 0e 00 00       	call   f40 <printf>
  inodeTBWalkerFix();
      c7:	e8 24 05 00 00       	call   5f0 <inodeTBWalkerFix>
  
  exit();
      cc:	e8 f1 0c 00 00       	call   dc2 <exit>
      d1:	66 90                	xchg   %ax,%ax
      d3:	66 90                	xchg   %ax,%ax
      d5:	66 90                	xchg   %ax,%ax
      d7:	66 90                	xchg   %ax,%ax
      d9:	66 90                	xchg   %ax,%ax
      db:	66 90                	xchg   %ax,%ax
      dd:	66 90                	xchg   %ax,%ax
      df:	90                   	nop

000000e0 <parser>:

struct inodes *allInodes;

int allInodesCounter = 0;

struct twoNames parser(char* path){
      e0:	55                   	push   %ebp
      e1:	89 e5                	mov    %esp,%ebp
      e3:	57                   	push   %edi
      e4:	56                   	push   %esi
      e5:	53                   	push   %ebx
      e6:	83 ec 28             	sub    $0x28,%esp
      e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    struct twoNames twoNames = {malloc(sizeof(strlen(path))), malloc(sizeof(strlen(path)))};
      ec:	6a 04                	push   $0x4
      ee:	e8 7d 10 00 00       	call   1170 <malloc>
      f3:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
      fa:	89 c7                	mov    %eax,%edi
      fc:	e8 6f 10 00 00       	call   1170 <malloc>
    char* pathHead = path;
    char* endPath = path + strlen(path) - 1;
     101:	89 34 24             	mov    %esi,(%esp)
struct inodes *allInodes;

int allInodesCounter = 0;

struct twoNames parser(char* path){
    struct twoNames twoNames = {malloc(sizeof(strlen(path))), malloc(sizeof(strlen(path)))};
     104:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    char* pathHead = path;
    char* endPath = path + strlen(path) - 1;
     107:	e8 f4 0a 00 00       	call   c00 <strlen>
     10c:	8d 5c 06 ff          	lea    -0x1(%esi,%eax,1),%ebx

    while(endPath >= pathHead){
     110:	83 c4 10             	add    $0x10,%esp
     113:	39 de                	cmp    %ebx,%esi
     115:	76 10                	jbe    127 <parser+0x47>
     117:	eb 5f                	jmp    178 <parser+0x98>
     119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            memmove(twoNames.fileName, endPath + 1, strlen(endPath)-1);
            printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);
            twoNames.dirName[endPath - pathHead] = 0;
            return twoNames;
        }
        endPath--;
     120:	83 eb 01             	sub    $0x1,%ebx
struct twoNames parser(char* path){
    struct twoNames twoNames = {malloc(sizeof(strlen(path))), malloc(sizeof(strlen(path)))};
    char* pathHead = path;
    char* endPath = path + strlen(path) - 1;

    while(endPath >= pathHead){
     123:	39 de                	cmp    %ebx,%esi
     125:	77 51                	ja     178 <parser+0x98>
        if(*endPath == '/'){  
     127:	80 3b 2f             	cmpb   $0x2f,(%ebx)
     12a:	75 f4                	jne    120 <parser+0x40>
            memmove(twoNames.dirName, path, endPath - pathHead);
     12c:	89 d9                	mov    %ebx,%ecx
     12e:	83 ec 04             	sub    $0x4,%esp
     131:	29 f1                	sub    %esi,%ecx
     133:	51                   	push   %ecx
     134:	56                   	push   %esi
     135:	57                   	push   %edi
     136:	89 4d e0             	mov    %ecx,-0x20(%ebp)
     139:	e8 52 0c 00 00       	call   d90 <memmove>
            //printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
            memmove(twoNames.fileName, endPath + 1, strlen(endPath)-1);
     13e:	89 1c 24             	mov    %ebx,(%esp)
     141:	e8 ba 0a 00 00       	call   c00 <strlen>
     146:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     149:	8d 53 01             	lea    0x1(%ebx),%edx
     14c:	83 c4 0c             	add    $0xc,%esp
     14f:	83 e8 01             	sub    $0x1,%eax
     152:	50                   	push   %eax
     153:	52                   	push   %edx
     154:	56                   	push   %esi
     155:	e8 36 0c 00 00       	call   d90 <memmove>
            printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);
     15a:	83 c4 0c             	add    $0xc,%esp
     15d:	56                   	push   %esi
     15e:	68 60 12 00 00       	push   $0x1260
     163:	6a 01                	push   $0x1
     165:	e8 d6 0d 00 00       	call   f40 <printf>
            twoNames.dirName[endPath - pathHead] = 0;
     16a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     16d:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
     171:	eb 2a                	jmp    19d <parser+0xbd>
     173:	90                   	nop
     174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            return twoNames;
        }
        endPath--;
    }

    memmove(twoNames.dirName, path, endPath - pathHead);
     178:	89 d8                	mov    %ebx,%eax
     17a:	83 ec 04             	sub    $0x4,%esp
     17d:	29 f0                	sub    %esi,%eax
     17f:	50                   	push   %eax
     180:	56                   	push   %esi
     181:	57                   	push   %edi
     182:	e8 09 0c 00 00       	call   d90 <memmove>
    memmove(twoNames.fileName, endPath, strlen(endPath));
     187:	89 1c 24             	mov    %ebx,(%esp)
     18a:	e8 71 0a 00 00       	call   c00 <strlen>
     18f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     192:	83 c4 0c             	add    $0xc,%esp
     195:	50                   	push   %eax
     196:	53                   	push   %ebx
     197:	56                   	push   %esi
     198:	e8 f3 0b 00 00       	call   d90 <memmove>
    
    return twoNames;
     19d:	8b 45 08             	mov    0x8(%ebp),%eax
     1a0:	83 c4 10             	add    $0x10,%esp
     1a3:	89 c2                	mov    %eax,%edx
     1a5:	89 38                	mov    %edi,(%eax)
}
     1a7:	8b 45 08             	mov    0x8(%ebp),%eax
    }

    memmove(twoNames.dirName, path, endPath - pathHead);
    memmove(twoNames.fileName, endPath, strlen(endPath));
    
    return twoNames;
     1aa:	89 72 04             	mov    %esi,0x4(%edx)
}
     1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
     1b0:	5b                   	pop    %ebx
     1b1:	5e                   	pop    %esi
     1b2:	5f                   	pop    %edi
     1b3:	5d                   	pop    %ebp
     1b4:	c2 04 00             	ret    $0x4
     1b7:	89 f6                	mov    %esi,%esi
     1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <writeInReplacement>:

void writeInReplacement(char* path,int correctInum){
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	57                   	push   %edi
     1c4:	56                   	push   %esi
     1c5:	53                   	push   %ebx
     1c6:	81 ec 94 02 00 00    	sub    $0x294,%esp
     1cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct superblock sb;
    uchar dataBuffer[BSIZE];

    //printf(1, "DEBUG PATH: %s\n", path);

    printf(1, "INTO WIR");
     1cf:	68 75 12 00 00       	push   $0x1275
     1d4:	6a 01                	push   $0x1
     1d6:	e8 65 0d 00 00       	call   f40 <printf>

    printf(1, "AFTER OPEN");
     1db:	5e                   	pop    %esi
     1dc:	5f                   	pop    %edi
     1dd:	68 7e 12 00 00       	push   $0x127e
     1e2:	6a 01                	push   $0x1
     1e4:	e8 57 0d 00 00       	call   f40 <printf>
    
    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1e9:	89 1c 24             	mov    %ebx,(%esp)
     1ec:	e8 0f 0a 00 00       	call   c00 <strlen>
     1f1:	83 c0 20             	add    $0x20,%eax
     1f4:	83 c4 10             	add    $0x10,%esp
     1f7:	3d 00 02 00 00       	cmp    $0x200,%eax
     1fc:	0f 87 ca 02 00 00    	ja     4cc <writeInReplacement+0x30c>
        printf(1, "ls: path too long\n");
    }

    printf(1, "BEFORE PARSER");
     202:	83 ec 08             	sub    $0x8,%esp
     205:	68 9c 12 00 00       	push   $0x129c
     20a:	6a 01                	push   $0x1
     20c:	e8 2f 0d 00 00       	call   f40 <printf>
    struct twoNames twoNames = parser(path);
     211:	5a                   	pop    %edx
     212:	8d 85 70 fd ff ff    	lea    -0x290(%ebp),%eax
     218:	59                   	pop    %ecx
     219:	53                   	push   %ebx
     21a:	50                   	push   %eax
     21b:	e8 c0 fe ff ff       	call   e0 <parser>
     220:	8b 9d 70 fd ff ff    	mov    -0x290(%ebp),%ebx

    if(strcmp(twoNames.dirName, "") == 0){
     226:	83 ec 0c             	sub    $0xc,%esp
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    printf(1, "BEFORE PARSER");
    struct twoNames twoNames = parser(path);
     229:	8b b5 74 fd ff ff    	mov    -0x28c(%ebp),%esi

    if(strcmp(twoNames.dirName, "") == 0){
     22f:	68 17 13 00 00       	push   $0x1317
     234:	53                   	push   %ebx
     235:	e8 76 09 00 00       	call   bb0 <strcmp>
     23a:	83 c4 20             	add    $0x20,%esp
     23d:	85 c0                	test   %eax,%eax
     23f:	75 07                	jne    248 <writeInReplacement+0x88>
        twoNames.dirName[0] = '.';
     241:	c6 03 2e             	movb   $0x2e,(%ebx)
        twoNames.dirName[1] = 0;
     244:	c6 43 01 00          	movb   $0x0,0x1(%ebx)
    }

    printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
     248:	83 ec 04             	sub    $0x4,%esp
     24b:	53                   	push   %ebx
     24c:	68 aa 12 00 00       	push   $0x12aa
     251:	6a 01                	push   $0x1
     253:	e8 e8 0c 00 00       	call   f40 <printf>
    printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);
     258:	83 c4 0c             	add    $0xc,%esp
     25b:	56                   	push   %esi
     25c:	68 60 12 00 00       	push   $0x1260
     261:	6a 01                	push   $0x1
     263:	e8 d8 0c 00 00       	call   f40 <printf>


    if((parentOpen = open(twoNames.dirName, O_RDONLY)) < 0){
     268:	59                   	pop    %ecx
     269:	5f                   	pop    %edi
     26a:	6a 00                	push   $0x0
     26c:	53                   	push   %ebx
     26d:	e8 90 0b 00 00       	call   e02 <open>
     272:	83 c4 10             	add    $0x10,%esp
     275:	85 c0                	test   %eax,%eax
     277:	89 c3                	mov    %eax,%ebx
     279:	0f 88 64 02 00 00    	js     4e3 <writeInReplacement+0x323>
        printf(1, "OPEN RETURN\n");
        return;
    }

    if(fstat(parentOpen, &parentOpenSt) < 0){
     27f:	8d 85 78 fd ff ff    	lea    -0x288(%ebp),%eax
     285:	83 ec 08             	sub    $0x8,%esp
     288:	50                   	push   %eax
     289:	53                   	push   %ebx
     28a:	e8 8b 0b 00 00       	call   e1a <fstat>
     28f:	83 c4 10             	add    $0x10,%esp
     292:	85 c0                	test   %eax,%eax
     294:	0f 88 63 02 00 00    	js     4fd <writeInReplacement+0x33d>
        printf(2, "ls: cannot parentOpenStat %s\n", "/");
        close(parentOpen);
        return;
    }

    callSBRead(parentOpenSt.dev, &sb);
     29a:	8d 85 8c fd ff ff    	lea    -0x274(%ebp),%eax
     2a0:	83 ec 08             	sub    $0x8,%esp
     2a3:	50                   	push   %eax
     2a4:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     2aa:	e8 d3 0b 00 00       	call   e82 <callSBRead>
    printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", parentOpenSt.dev, sb.ninodes);
     2af:	ff b5 94 fd ff ff    	pushl  -0x26c(%ebp)
     2b5:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     2bb:	68 0c 14 00 00       	push   $0x140c
     2c0:	6a 01                	push   $0x1
     2c2:	e8 79 0c 00 00       	call   f40 <printf>
    
    callBRead(parentOpenSt.dev, (parentOpenSt.ino /IPB) + sb.inodestart, dataBuffer);
     2c7:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     2cd:	83 c4 1c             	add    $0x1c,%esp
     2d0:	50                   	push   %eax
     2d1:	8b 85 80 fd ff ff    	mov    -0x280(%ebp),%eax
     2d7:	c1 e8 03             	shr    $0x3,%eax
     2da:	03 85 a0 fd ff ff    	add    -0x260(%ebp),%eax
     2e0:	50                   	push   %eax
     2e1:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     2e7:	e8 8e 0b 00 00       	call   e7a <callBRead>
    printf(1, "after in loop CallBRead: %d, bufStructPtr: %p\n", parentOpenSt.dev, dataBuffer);
     2ec:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     2f2:	50                   	push   %eax
     2f3:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     2f9:	68 3c 14 00 00       	push   $0x143c
     2fe:	6a 01                	push   $0x1
     300:	e8 3b 0c 00 00       	call   f40 <printf>
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (parentOpenSt.ino % IPB);
    struct dinode dinode = *dinodePtr;
     305:	8b 95 80 fd ff ff    	mov    -0x280(%ebp),%edx
     30b:	83 c4 20             	add    $0x20,%esp
     30e:	83 e2 07             	and    $0x7,%edx
     311:	c1 e2 06             	shl    $0x6,%edx
     314:	8d 84 15 e8 fd ff ff 	lea    -0x218(%ebp,%edx,1),%eax
     31b:	8b 94 15 e8 fd ff ff 	mov    -0x218(%ebp,%edx,1),%edx
     322:	89 95 a8 fd ff ff    	mov    %edx,-0x258(%ebp)
     328:	8b 50 04             	mov    0x4(%eax),%edx
     32b:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
     331:	8b 50 08             	mov    0x8(%eax),%edx
     334:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
     33a:	8b 50 0c             	mov    0xc(%eax),%edx
     33d:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
     343:	8b 50 10             	mov    0x10(%eax),%edx
     346:	89 95 b8 fd ff ff    	mov    %edx,-0x248(%ebp)
     34c:	8b 50 14             	mov    0x14(%eax),%edx
     34f:	89 95 bc fd ff ff    	mov    %edx,-0x244(%ebp)
     355:	8b 50 18             	mov    0x18(%eax),%edx
     358:	89 95 c0 fd ff ff    	mov    %edx,-0x240(%ebp)
     35e:	8b 50 1c             	mov    0x1c(%eax),%edx
     361:	89 95 c4 fd ff ff    	mov    %edx,-0x23c(%ebp)
     367:	8b 50 20             	mov    0x20(%eax),%edx
     36a:	89 95 c8 fd ff ff    	mov    %edx,-0x238(%ebp)
     370:	8b 50 24             	mov    0x24(%eax),%edx
     373:	89 95 cc fd ff ff    	mov    %edx,-0x234(%ebp)
     379:	8b 50 28             	mov    0x28(%eax),%edx
     37c:	89 95 d0 fd ff ff    	mov    %edx,-0x230(%ebp)
     382:	8b 50 2c             	mov    0x2c(%eax),%edx
     385:	89 95 d4 fd ff ff    	mov    %edx,-0x22c(%ebp)
     38b:	8b 50 30             	mov    0x30(%eax),%edx
     38e:	89 95 d8 fd ff ff    	mov    %edx,-0x228(%ebp)
     394:	8b 50 34             	mov    0x34(%eax),%edx
     397:	89 95 dc fd ff ff    	mov    %edx,-0x224(%ebp)
     39d:	8b 50 38             	mov    0x38(%eax),%edx
     3a0:	8b 40 3c             	mov    0x3c(%eax),%eax
     3a3:	89 95 e0 fd ff ff    	mov    %edx,-0x220(%ebp)
     3a9:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
     3af:	8d 85 b4 fd ff ff    	lea    -0x24c(%ebp),%eax
     3b5:	89 85 6c fd ff ff    	mov    %eax,-0x294(%ebp)
     3bb:	89 c3                	mov    %eax,%ebx
     3bd:	8d 76 00             	lea    0x0(%esi),%esi

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
     3c0:	83 ec 04             	sub    $0x4,%esp
     3c3:	ff 33                	pushl  (%ebx)
     3c5:	83 c3 04             	add    $0x4,%ebx
     3c8:	68 eb 12 00 00       	push   $0x12eb
     3cd:	6a 01                	push   $0x1
     3cf:	e8 6c 0b 00 00       	call   f40 <printf>

        
    dinodePtr = dinodePtr + (parentOpenSt.ino % IPB);
    struct dinode dinode = *dinodePtr;

    for(int i = 0; i < NDIRECT+1; i++){
     3d4:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     3da:	83 c4 10             	add    $0x10,%esp
     3dd:	39 c3                	cmp    %eax,%ebx
     3df:	75 df                	jne    3c0 <writeInReplacement+0x200>
     3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "%d, ", dinode.addrs[i]);
    }

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "INODE %d, ADDR %d\n\n", parentOpenSt.ino, dinode.addrs[i]);
     3e8:	8b 85 6c fd ff ff    	mov    -0x294(%ebp),%eax
     3ee:	8b 38                	mov    (%eax),%edi
     3f0:	57                   	push   %edi
     3f1:	ff b5 80 fd ff ff    	pushl  -0x280(%ebp)
     3f7:	68 f0 12 00 00       	push   $0x12f0
     3fc:	6a 01                	push   $0x1
     3fe:	e8 3d 0b 00 00       	call   f40 <printf>
        //printf(1, "i: %d, ADDREESS PTR %p\n\n", i, dinode.addrs);
        if(dinode.addrs[i] == 0) break;
     403:	83 c4 10             	add    $0x10,%esp
     406:	85 ff                	test   %edi,%edi
     408:	0f 84 b6 00 00 00    	je     4c4 <writeInReplacement+0x304>
        
        callBRead(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
     40e:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     414:	83 ec 04             	sub    $0x4,%esp
     417:	8d 9d ea fd ff ff    	lea    -0x216(%ebp),%ebx
     41d:	50                   	push   %eax
     41e:	57                   	push   %edi
     41f:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     425:	e8 50 0a 00 00       	call   e7a <callBRead>
     42a:	83 c4 10             	add    $0x10,%esp
     42d:	eb 0b                	jmp    43a <writeInReplacement+0x27a>
     42f:	90                   	nop
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
     430:	8d 45 ea             	lea    -0x16(%ebp),%eax
     433:	83 c3 20             	add    $0x20,%ebx
     436:	39 c3                	cmp    %eax,%ebx
     438:	74 6f                	je     4a9 <writeInReplacement+0x2e9>
            printf(1, "ALL DE READS: %s \n\n", ptr->name);
     43a:	83 ec 04             	sub    $0x4,%esp
     43d:	53                   	push   %ebx
     43e:	68 04 13 00 00       	push   $0x1304
     443:	6a 01                	push   $0x1
     445:	e8 f6 0a 00 00       	call   f40 <printf>
            if(strcmp(ptr->name, twoNames.fileName) == 0){
     44a:	58                   	pop    %eax
     44b:	5a                   	pop    %edx
     44c:	56                   	push   %esi
     44d:	53                   	push   %ebx
     44e:	e8 5d 07 00 00       	call   bb0 <strcmp>
     453:	83 c4 10             	add    $0x10,%esp
     456:	85 c0                	test   %eax,%eax
     458:	75 d6                	jne    430 <writeInReplacement+0x270>
                printf(1, "DE INODE: %d\n\n", ptr->inum);
     45a:	0f b7 43 fe          	movzwl -0x2(%ebx),%eax
     45e:	83 ec 04             	sub    $0x4,%esp
     461:	83 c3 20             	add    $0x20,%ebx
     464:	50                   	push   %eax
     465:	68 18 13 00 00       	push   $0x1318
     46a:	6a 01                	push   $0x1
     46c:	e8 cf 0a 00 00       	call   f40 <printf>
                //printf(1, "DE NAME: %s, TWONAMES NAME %s\n\n", ptr->name, twoNames.fileName);
            
                ptr->inum = correctInum;
     471:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
                //printf(1, "BEFORE WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);
                printf(1, "ADDR BEFORE BWRITE %d\n", dinode.addrs[i]);
     475:	83 c4 0c             	add    $0xc,%esp
            printf(1, "ALL DE READS: %s \n\n", ptr->name);
            if(strcmp(ptr->name, twoNames.fileName) == 0){
                printf(1, "DE INODE: %d\n\n", ptr->inum);
                //printf(1, "DE NAME: %s, TWONAMES NAME %s\n\n", ptr->name, twoNames.fileName);
            
                ptr->inum = correctInum;
     478:	66 89 43 de          	mov    %ax,-0x22(%ebx)
                //printf(1, "BEFORE WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);
                printf(1, "ADDR BEFORE BWRITE %d\n", dinode.addrs[i]);
     47c:	57                   	push   %edi
     47d:	68 27 13 00 00       	push   $0x1327
     482:	6a 01                	push   $0x1
     484:	e8 b7 0a 00 00       	call   f40 <printf>
                callBWrite(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
     489:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     48f:	83 c4 0c             	add    $0xc,%esp
     492:	50                   	push   %eax
     493:	57                   	push   %edi
     494:	ff b5 7c fd ff ff    	pushl  -0x284(%ebp)
     49a:	e8 f3 09 00 00       	call   e92 <callBWrite>
        //printf(1, "i: %d, ADDREESS PTR %p\n\n", i, dinode.addrs);
        if(dinode.addrs[i] == 0) break;
        
        callBRead(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
     49f:	8d 45 ea             	lea    -0x16(%ebp),%eax
                //printf(1, "DE NAME: %s, TWONAMES NAME %s\n\n", ptr->name, twoNames.fileName);
            
                ptr->inum = correctInum;
                //printf(1, "BEFORE WRITE-- parentOpen: %d de.inum: %d\n", parentOpen, ptr->inum);
                printf(1, "ADDR BEFORE BWRITE %d\n", dinode.addrs[i]);
                callBWrite(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
     4a2:	83 c4 10             	add    $0x10,%esp
        //printf(1, "i: %d, ADDREESS PTR %p\n\n", i, dinode.addrs);
        if(dinode.addrs[i] == 0) break;
        
        callBRead(parentOpenSt.dev, dinode.addrs[i], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
     4a5:	39 c3                	cmp    %eax,%ebx
     4a7:	75 91                	jne    43a <writeInReplacement+0x27a>
     4a9:	83 85 6c fd ff ff 04 	addl   $0x4,-0x294(%ebp)

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
    }

    for(int i = 0; i < NDIRECT+1; i++){
     4b0:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
     4b6:	8b 85 6c fd ff ff    	mov    -0x294(%ebp),%eax
     4bc:	39 c8                	cmp    %ecx,%eax
     4be:	0f 85 24 ff ff ff    	jne    3e8 <writeInReplacement+0x228>
            }
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    }   
    
}
     4c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4c7:	5b                   	pop    %ebx
     4c8:	5e                   	pop    %esi
     4c9:	5f                   	pop    %edi
     4ca:	5d                   	pop    %ebp
     4cb:	c3                   	ret    

    printf(1, "AFTER OPEN");
    
    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
     4cc:	83 ec 08             	sub    $0x8,%esp
     4cf:	68 89 12 00 00       	push   $0x1289
     4d4:	6a 01                	push   $0x1
     4d6:	e8 65 0a 00 00       	call   f40 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	e9 1f fd ff ff       	jmp    202 <writeInReplacement+0x42>
    printf(1, "PARSER DIRNAME %s\n\n", twoNames.dirName);
    printf(1, "PARSER FILENAME %s\n\n", twoNames.fileName);


    if((parentOpen = open(twoNames.dirName, O_RDONLY)) < 0){
        printf(1, "OPEN RETURN\n");
     4e3:	83 ec 08             	sub    $0x8,%esp
     4e6:	68 be 12 00 00       	push   $0x12be
     4eb:	6a 01                	push   $0x1
     4ed:	e8 4e 0a 00 00       	call   f40 <printf>
        return;
     4f2:	83 c4 10             	add    $0x10,%esp
            }
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    }   
    
}
     4f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4f8:	5b                   	pop    %ebx
     4f9:	5e                   	pop    %esi
     4fa:	5f                   	pop    %edi
     4fb:	5d                   	pop    %ebp
     4fc:	c3                   	ret    
        printf(1, "OPEN RETURN\n");
        return;
    }

    if(fstat(parentOpen, &parentOpenSt) < 0){
        printf(2, "ls: cannot parentOpenStat %s\n", "/");
     4fd:	83 ec 04             	sub    $0x4,%esp
     500:	68 cb 12 00 00       	push   $0x12cb
     505:	68 cd 12 00 00       	push   $0x12cd
     50a:	6a 02                	push   $0x2
     50c:	e8 2f 0a 00 00       	call   f40 <printf>
        close(parentOpen);
     511:	89 1c 24             	mov    %ebx,(%esp)
     514:	e8 d1 08 00 00       	call   dea <close>
        return;
     519:	83 c4 10             	add    $0x10,%esp
            }
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    }   
    
}
     51c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     51f:	5b                   	pop    %ebx
     520:	5e                   	pop    %esi
     521:	5f                   	pop    %edi
     522:	5d                   	pop    %ebp
     523:	c3                   	ret    
     524:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     52a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000530 <candidatePlacement>:


void candidatePlacement(int *inumsNotFound, int notFoundIdx, struct stat st, struct superblock sb, struct inodes *allInodes){
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	57                   	push   %edi
     534:	56                   	push   %esi
     535:	53                   	push   %ebx
     536:	83 ec 14             	sub    $0x14,%esp
     539:	8b 5d 0c             	mov    0xc(%ebp),%ebx

    printf(1, "CP before SBREAD");
     53c:	68 3e 13 00 00       	push   $0x133e
     541:	6a 01                	push   $0x1
     543:	e8 f8 09 00 00       	call   f40 <printf>
    callSBRead(st.dev, &sb);
     548:	5e                   	pop    %esi
     549:	8d 45 24             	lea    0x24(%ebp),%eax
     54c:	5f                   	pop    %edi
     54d:	50                   	push   %eax
     54e:	ff 75 14             	pushl  0x14(%ebp)
     551:	e8 2c 09 00 00       	call   e82 <callSBRead>
    //printf(1, "sbninodes in CP: %p\n\n", sb.ninodes);

    //outside range inode)
    for(int i = 0; i < allInodesCounter; i++){
     556:	a1 ec 18 00 00       	mov    0x18ec,%eax
     55b:	83 c4 10             	add    $0x10,%esp
     55e:	8b 7d 40             	mov    0x40(%ebp),%edi
     561:	85 c0                	test   %eax,%eax
     563:	0f 8e 7e 00 00 00    	jle    5e7 <candidatePlacement+0xb7>
     569:	31 f6                	xor    %esi,%esi
     56b:	eb 11                	jmp    57e <candidatePlacement+0x4e>
     56d:	8d 76 00             	lea    0x0(%esi),%esi
     570:	83 c6 01             	add    $0x1,%esi
     573:	83 c7 0c             	add    $0xc,%edi
     576:	39 35 ec 18 00 00    	cmp    %esi,0x18ec
     57c:	7e 69                	jle    5e7 <candidatePlacement+0xb7>
        if((allInodes[i].inum < 0 || allInodes[i].inum >= sb.ninodes) || allInodes[i].valid == 0){
     57e:	8b 07                	mov    (%edi),%eax
     580:	85 c0                	test   %eax,%eax
     582:	78 0c                	js     590 <candidatePlacement+0x60>
     584:	3b 45 2c             	cmp    0x2c(%ebp),%eax
     587:	73 07                	jae    590 <candidatePlacement+0x60>
     589:	8b 4f 08             	mov    0x8(%edi),%ecx
     58c:	85 c9                	test   %ecx,%ecx
     58e:	75 e0                	jne    570 <candidatePlacement+0x40>
            printf(1, "CP inum replacement happening : %d\n\n", allInodes[i].inum);
     590:	83 ec 04             	sub    $0x4,%esp
     593:	50                   	push   %eax
     594:	68 6c 14 00 00       	push   $0x146c
     599:	6a 01                	push   $0x1
     59b:	e8 a0 09 00 00       	call   f40 <printf>
            printf(1, "NOTFOUNDIDX %d\n\n", notFoundIdx);
     5a0:	83 c4 0c             	add    $0xc,%esp
     5a3:	53                   	push   %ebx
     5a4:	68 4f 13 00 00       	push   $0x134f
     5a9:	6a 01                	push   $0x1
     5ab:	e8 90 09 00 00       	call   f40 <printf>
            if(notFoundIdx == 1){
     5b0:	83 c4 10             	add    $0x10,%esp
     5b3:	83 fb 01             	cmp    $0x1,%ebx
     5b6:	75 b8                	jne    570 <candidatePlacement+0x40>
                printf(1, "BEFORE WIR\n\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
    printf(1, "CP before SBREAD");
    callSBRead(st.dev, &sb);
    //printf(1, "sbninodes in CP: %p\n\n", sb.ninodes);

    //outside range inode)
    for(int i = 0; i < allInodesCounter; i++){
     5bb:	83 c6 01             	add    $0x1,%esi
     5be:	83 c7 0c             	add    $0xc,%edi
        if((allInodes[i].inum < 0 || allInodes[i].inum >= sb.ninodes) || allInodes[i].valid == 0){
            printf(1, "CP inum replacement happening : %d\n\n", allInodes[i].inum);
            printf(1, "NOTFOUNDIDX %d\n\n", notFoundIdx);
            if(notFoundIdx == 1){
                printf(1, "BEFORE WIR\n\n");
     5c1:	68 60 13 00 00       	push   $0x1360
     5c6:	6a 01                	push   $0x1
     5c8:	e8 73 09 00 00       	call   f40 <printf>
                writeInReplacement(allInodes[i].name, inumsNotFound[0]);
     5cd:	58                   	pop    %eax
     5ce:	8b 45 08             	mov    0x8(%ebp),%eax
     5d1:	5a                   	pop    %edx
     5d2:	ff 30                	pushl  (%eax)
     5d4:	ff 77 f8             	pushl  -0x8(%edi)
     5d7:	e8 e4 fb ff ff       	call   1c0 <writeInReplacement>
     5dc:	83 c4 10             	add    $0x10,%esp
    printf(1, "CP before SBREAD");
    callSBRead(st.dev, &sb);
    //printf(1, "sbninodes in CP: %p\n\n", sb.ninodes);

    //outside range inode)
    for(int i = 0; i < allInodesCounter; i++){
     5df:	39 35 ec 18 00 00    	cmp    %esi,0x18ec
     5e5:	7f 97                	jg     57e <candidatePlacement+0x4e>
        }
    }
    

    //refers to inode not allocated);
}
     5e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5ea:	5b                   	pop    %ebx
     5eb:	5e                   	pop    %esi
     5ec:	5f                   	pop    %edi
     5ed:	5d                   	pop    %ebp
     5ee:	c3                   	ret    
     5ef:	90                   	nop

000005f0 <inodeTBWalkerFix>:


void inodeTBWalkerFix(){
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	57                   	push   %edi
     5f4:	56                   	push   %esi
     5f5:	53                   	push   %ebx
     5f6:	81 ec 54 02 00 00    	sub    $0x254,%esp
    struct superblock sb; 
    uchar dataBuffer[BSIZE];
    
    //printf(1, "NODETBWALKER");

    if((fd = open("/", 0)) < 0){
     5fc:	6a 00                	push   $0x0
     5fe:	68 cb 12 00 00       	push   $0x12cb
     603:	e8 fa 07 00 00       	call   e02 <open>
     608:	83 c4 10             	add    $0x10,%esp
     60b:	85 c0                	test   %eax,%eax
     60d:	0f 88 fd 01 00 00    	js     810 <inodeTBWalkerFix+0x220>
     613:	89 c3                	mov    %eax,%ebx
        printf(2, "ls: cannot open %s\n", "/");
        return;
    }

    if(fstat(fd, &st) < 0){
     615:	8d 85 b8 fd ff ff    	lea    -0x248(%ebp),%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	53                   	push   %ebx
     620:	e8 f5 07 00 00       	call   e1a <fstat>
     625:	83 c4 10             	add    $0x10,%esp
     628:	85 c0                	test   %eax,%eax
     62a:	0f 88 ff 01 00 00    	js     82f <inodeTBWalkerFix+0x23f>
        printf(2, "ls: cannot stat %s\n", "/");
        close(fd);
        return;
    }

    callSBRead(st.dev, &sb);
     630:	8d 85 cc fd ff ff    	lea    -0x234(%ebp),%eax
     636:	83 ec 08             	sub    $0x8,%esp
     639:	50                   	push   %eax
     63a:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
     640:	e8 3d 08 00 00       	call   e82 <callSBRead>
    int *inumsNotFound = malloc(sizeof(int) * sb.ninodes);
     645:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
     64b:	c1 e0 02             	shl    $0x2,%eax
     64e:	89 04 24             	mov    %eax,(%esp)
     651:	e8 1a 0b 00 00       	call   1170 <malloc>
     656:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
    int notFoundIdx = 0;
    for(int numB = 0; numB < (sb.ninodes/IPB); numB++){
     65c:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
     662:	83 c4 10             	add    $0x10,%esp
     665:	c1 e8 03             	shr    $0x3,%eax
     668:	85 c0                	test   %eax,%eax
     66a:	0f 84 e6 01 00 00    	je     856 <inodeTBWalkerFix+0x266>
     670:	c7 85 b4 fd ff ff 00 	movl   $0x0,-0x24c(%ebp)
     677:	00 00 00 
     67a:	c7 85 b0 fd ff ff 00 	movl   $0x0,-0x250(%ebp)
     681:	00 00 00 
     684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        //printf(1, "NUMB TRACE %d", numB);
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
     688:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     68e:	83 ec 04             	sub    $0x4,%esp
     691:	8b bd b4 fd ff ff    	mov    -0x24c(%ebp),%edi
     697:	50                   	push   %eax
     698:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
     69e:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
     6a5:	01 f8                	add    %edi,%eax
     6a7:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
     6ad:	50                   	push   %eax
     6ae:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
     6b4:	e8 c1 07 00 00       	call   e7a <callBRead>
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        
        for(int i = 0; i < IPB; i++){  
            int inodeNum = (numB * IPB) + i; 
            int foundIt = 0;
            //printf(1, "FOUND IT: %d\n\n", foundIt);
            for(int i = 0; i < allInodesCounter; i++){
     6c0:	8b 35 ec 18 00 00    	mov    0x18ec,%esi
     6c6:	85 f6                	test   %esi,%esi
     6c8:	7e 2b                	jle    6f5 <inodeTBWalkerFix+0x105>
                if(inodeNum == allInodes[i].inum){
     6ca:	8b 0d fc 18 00 00    	mov    0x18fc,%ecx
     6d0:	31 d2                	xor    %edx,%edx
     6d2:	3b 19                	cmp    (%ecx),%ebx
     6d4:	8d 41 0c             	lea    0xc(%ecx),%eax
     6d7:	75 15                	jne    6ee <inodeTBWalkerFix+0xfe>
     6d9:	e9 e2 00 00 00       	jmp    7c0 <inodeTBWalkerFix+0x1d0>
     6de:	66 90                	xchg   %ax,%ax
     6e0:	89 c1                	mov    %eax,%ecx
     6e2:	83 c0 0c             	add    $0xc,%eax
     6e5:	3b 58 f4             	cmp    -0xc(%eax),%ebx
     6e8:	0f 84 d2 00 00 00    	je     7c0 <inodeTBWalkerFix+0x1d0>
        
        for(int i = 0; i < IPB; i++){  
            int inodeNum = (numB * IPB) + i; 
            int foundIt = 0;
            //printf(1, "FOUND IT: %d\n\n", foundIt);
            for(int i = 0; i < allInodesCounter; i++){
     6ee:	83 c2 01             	add    $0x1,%edx
     6f1:	39 f2                	cmp    %esi,%edx
     6f3:	75 eb                	jne    6e0 <inodeTBWalkerFix+0xf0>
                    break;
                } 
                
            }

            if(foundIt == 0 && dinodePtr->type != 0){
     6f5:	66 83 3f 00          	cmpw   $0x0,(%edi)
     6f9:	0f 85 e1 00 00 00    	jne    7e0 <inodeTBWalkerFix+0x1f0>
    for(int numB = 0; numB < (sb.ninodes/IPB); numB++){
        //printf(1, "NUMB TRACE %d", numB);
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        
        for(int i = 0; i < IPB; i++){  
     6ff:	8d 45 e8             	lea    -0x18(%ebp),%eax

            //for(int i = 0; i < NDIRECT+1; i++){
                //printf(1, "%d, ", dinodePtr->addrs[i]);

            //} 
            dinodePtr++;
     702:	83 c7 40             	add    $0x40,%edi
     705:	83 c3 01             	add    $0x1,%ebx
    for(int numB = 0; numB < (sb.ninodes/IPB); numB++){
        //printf(1, "NUMB TRACE %d", numB);
        callBRead(st.dev, (numB + sb.inodestart), dataBuffer);
        struct dinode* dinodePtr = (struct dinode*) dataBuffer;
        
        for(int i = 0; i < IPB; i++){  
     708:	39 c7                	cmp    %eax,%edi
     70a:	75 b4                	jne    6c0 <inodeTBWalkerFix+0xd0>
    }

    callSBRead(st.dev, &sb);
    int *inumsNotFound = malloc(sizeof(int) * sb.ninodes);
    int notFoundIdx = 0;
    for(int numB = 0; numB < (sb.ninodes/IPB); numB++){
     70c:	83 85 b4 fd ff ff 01 	addl   $0x1,-0x24c(%ebp)
     713:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
     719:	8b bd b4 fd ff ff    	mov    -0x24c(%ebp),%edi
     71f:	c1 e8 03             	shr    $0x3,%eax
     722:	39 f8                	cmp    %edi,%eax
     724:	0f 87 5e ff ff ff    	ja     688 <inodeTBWalkerFix+0x98>
        }

    
    }

    printf(1, "BEFORE CANDIDATE PLACEMENT");
     72a:	83 ec 08             	sub    $0x8,%esp
     72d:	68 95 13 00 00       	push   $0x1395
     732:	6a 01                	push   $0x1
     734:	e8 07 08 00 00       	call   f40 <printf>
    
    if(notFoundIdx > 0){
     739:	8b 85 b0 fd ff ff    	mov    -0x250(%ebp),%eax
     73f:	83 c4 10             	add    $0x10,%esp
     742:	85 c0                	test   %eax,%eax
     744:	74 60                	je     7a6 <inodeTBWalkerFix+0x1b6>
        candidatePlacement(inumsNotFound, notFoundIdx, st, sb, allInodes);
     746:	83 ec 04             	sub    $0x4,%esp
     749:	ff 35 fc 18 00 00    	pushl  0x18fc
     74f:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
     755:	ff b5 e0 fd ff ff    	pushl  -0x220(%ebp)
     75b:	ff b5 dc fd ff ff    	pushl  -0x224(%ebp)
     761:	ff b5 d8 fd ff ff    	pushl  -0x228(%ebp)
     767:	ff b5 d4 fd ff ff    	pushl  -0x22c(%ebp)
     76d:	ff b5 d0 fd ff ff    	pushl  -0x230(%ebp)
     773:	ff b5 cc fd ff ff    	pushl  -0x234(%ebp)
     779:	ff b5 c8 fd ff ff    	pushl  -0x238(%ebp)
     77f:	ff b5 c4 fd ff ff    	pushl  -0x23c(%ebp)
     785:	ff b5 c0 fd ff ff    	pushl  -0x240(%ebp)
     78b:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
     791:	ff b5 b8 fd ff ff    	pushl  -0x248(%ebp)
     797:	50                   	push   %eax
     798:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
     79e:	e8 8d fd ff ff       	call   530 <candidatePlacement>
     7a3:	83 c4 40             	add    $0x40,%esp
        
    }  

    printf(1, "END OF FUNCTION TB WALKER");
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	68 b0 13 00 00       	push   $0x13b0
     7ae:	6a 01                	push   $0x1
     7b0:	e8 8b 07 00 00       	call   f40 <printf>
     7b5:	83 c4 10             	add    $0x10,%esp

        

}
     7b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7bb:	5b                   	pop    %ebx
     7bc:	5e                   	pop    %esi
     7bd:	5f                   	pop    %edi
     7be:	5d                   	pop    %ebp
     7bf:	c3                   	ret    
            int foundIt = 0;
            //printf(1, "FOUND IT: %d\n\n", foundIt);
            for(int i = 0; i < allInodesCounter; i++){
                if(inodeNum == allInodes[i].inum){
                    foundIt = 1;
                    if(dinodePtr->type != 0){
     7c0:	66 83 3f 00          	cmpw   $0x0,(%edi)
     7c4:	0f 84 35 ff ff ff    	je     6ff <inodeTBWalkerFix+0x10f>
                        allInodes[i].valid = 1;
     7ca:	c7 41 08 01 00 00 00 	movl   $0x1,0x8(%ecx)
     7d1:	e9 29 ff ff ff       	jmp    6ff <inodeTBWalkerFix+0x10f>
     7d6:	8d 76 00             	lea    0x0(%esi),%esi
     7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                
            }

            if(foundIt == 0 && dinodePtr->type != 0){
                //candidate for placement
                printf(1, "inode inum not found in present in file system: %d\n\n", 
     7e0:	83 ec 04             	sub    $0x4,%esp
     7e3:	53                   	push   %ebx
     7e4:	68 94 14 00 00       	push   $0x1494
     7e9:	6a 01                	push   $0x1
     7eb:	e8 50 07 00 00       	call   f40 <printf>
                inodeNum);
                inumsNotFound[notFoundIdx] = inodeNum;
     7f0:	8b 85 b0 fd ff ff    	mov    -0x250(%ebp),%eax
     7f6:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
                notFoundIdx++;
     7fc:	83 c4 10             	add    $0x10,%esp

            if(foundIt == 0 && dinodePtr->type != 0){
                //candidate for placement
                printf(1, "inode inum not found in present in file system: %d\n\n", 
                inodeNum);
                inumsNotFound[notFoundIdx] = inodeNum;
     7ff:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
                notFoundIdx++;
     802:	83 c0 01             	add    $0x1,%eax
     805:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
     80b:	e9 ef fe ff ff       	jmp    6ff <inodeTBWalkerFix+0x10f>
    uchar dataBuffer[BSIZE];
    
    //printf(1, "NODETBWALKER");

    if((fd = open("/", 0)) < 0){
        printf(2, "ls: cannot open %s\n", "/");
     810:	83 ec 04             	sub    $0x4,%esp
     813:	68 cb 12 00 00       	push   $0x12cb
     818:	68 6d 13 00 00       	push   $0x136d
     81d:	6a 02                	push   $0x2
     81f:	e8 1c 07 00 00       	call   f40 <printf>
        return;
     824:	83 c4 10             	add    $0x10,%esp

    printf(1, "END OF FUNCTION TB WALKER");

        

}
     827:	8d 65 f4             	lea    -0xc(%ebp),%esp
     82a:	5b                   	pop    %ebx
     82b:	5e                   	pop    %esi
     82c:	5f                   	pop    %edi
     82d:	5d                   	pop    %ebp
     82e:	c3                   	ret    
        printf(2, "ls: cannot open %s\n", "/");
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", "/");
     82f:	83 ec 04             	sub    $0x4,%esp
     832:	68 cb 12 00 00       	push   $0x12cb
     837:	68 81 13 00 00       	push   $0x1381
     83c:	6a 02                	push   $0x2
     83e:	e8 fd 06 00 00       	call   f40 <printf>
        close(fd);
     843:	89 1c 24             	mov    %ebx,(%esp)
     846:	e8 9f 05 00 00       	call   dea <close>
        return;
     84b:	83 c4 10             	add    $0x10,%esp

    printf(1, "END OF FUNCTION TB WALKER");

        

}
     84e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     851:	5b                   	pop    %ebx
     852:	5e                   	pop    %esi
     853:	5f                   	pop    %edi
     854:	5d                   	pop    %ebp
     855:	c3                   	ret    
        }

    
    }

    printf(1, "BEFORE CANDIDATE PLACEMENT");
     856:	83 ec 08             	sub    $0x8,%esp
     859:	68 95 13 00 00       	push   $0x1395
     85e:	6a 01                	push   $0x1
     860:	e8 db 06 00 00       	call   f40 <printf>
     865:	83 c4 10             	add    $0x10,%esp
     868:	e9 39 ff ff ff       	jmp    7a6 <inodeTBWalkerFix+0x1b6>
     86d:	8d 76 00             	lea    0x0(%esi),%esi

00000870 <directoryWalkerFix>:

}



void directoryWalkerFix(char* path, int dev, int ino){
     870:	55                   	push   %ebp
    char buf[512] = {0};
     871:	31 c0                	xor    %eax,%eax
     873:	b9 80 00 00 00       	mov    $0x80,%ecx

}



void directoryWalkerFix(char* path, int dev, int ino){
     878:	89 e5                	mov    %esp,%ebp
     87a:	57                   	push   %edi
     87b:	56                   	push   %esi
    char buf[512] = {0};
     87c:	8d b5 e8 fb ff ff    	lea    -0x418(%ebp),%esi

}



void directoryWalkerFix(char* path, int dev, int ino){
     882:	53                   	push   %ebx
    char buf[512] = {0};
     883:	89 f7                	mov    %esi,%edi

}



void directoryWalkerFix(char* path, int dev, int ino){
     885:	81 ec 88 04 00 00    	sub    $0x488,%esp
     88b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    char buf[512] = {0};
     88e:	f3 ab                	rep stos %eax,%es:(%edi)

    //printf(1, "DEBUG PATH: %s\n", path);


    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     890:	ff 75 08             	pushl  0x8(%ebp)
     893:	e8 68 03 00 00       	call   c00 <strlen>
     898:	83 c0 20             	add    $0x20,%eax
     89b:	83 c4 10             	add    $0x10,%esp
     89e:	3d 00 02 00 00       	cmp    $0x200,%eax
     8a3:	77 2b                	ja     8d0 <directoryWalkerFix+0x60>
        printf(1, "ls: path too long\n");
    }
    
    callSBRead(dev, &sb);
     8a5:	8d 85 8c fb ff ff    	lea    -0x474(%ebp),%eax
     8ab:	83 ec 08             	sub    $0x8,%esp
     8ae:	50                   	push   %eax
     8af:	ff 75 0c             	pushl  0xc(%ebp)
     8b2:	e8 cb 05 00 00       	call   e82 <callSBRead>
    //printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);

    if((ino < 0) || (ino >= sb.ninodes)) return;
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	85 db                	test   %ebx,%ebx
     8bc:	78 08                	js     8c6 <directoryWalkerFix+0x56>
     8be:	39 9d 94 fb ff ff    	cmp    %ebx,-0x46c(%ebp)
     8c4:	77 22                	ja     8e8 <directoryWalkerFix+0x78>
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    } 
    printf(1, "END OF THE FUNCTION");

}
     8c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8c9:	5b                   	pop    %ebx
     8ca:	5e                   	pop    %esi
     8cb:	5f                   	pop    %edi
     8cc:	5d                   	pop    %ebp
     8cd:	c3                   	ret    
     8ce:	66 90                	xchg   %ax,%ax
    //printf(1, "DEBUG PATH: %s\n", path);


    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
     8d0:	83 ec 08             	sub    $0x8,%esp
     8d3:	68 89 12 00 00       	push   $0x1289
     8d8:	6a 01                	push   $0x1
     8da:	e8 61 06 00 00       	call   f40 <printf>
     8df:	83 c4 10             	add    $0x10,%esp
     8e2:	eb c1                	jmp    8a5 <directoryWalkerFix+0x35>
     8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    //printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);

    if((ino < 0) || (ino >= sb.ninodes)) return;
    //printf(1, "BLOCKNO: %d\n\n", (ino /IPB) + sb.inodestart);

    callBRead(dev, (ino /IPB) + sb.inodestart, dataBuffer);
     8e8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     8ee:	83 ec 04             	sub    $0x4,%esp
    //printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (ino % IPB);
     8f1:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
    //printf(1, "after CallSBRead: %d, Superblock inodes: %d\n", st.dev, sb.ninodes);

    if((ino < 0) || (ino >= sb.ninodes)) return;
    //printf(1, "BLOCKNO: %d\n\n", (ino /IPB) + sb.inodestart);

    callBRead(dev, (ino /IPB) + sb.inodestart, dataBuffer);
     8f7:	50                   	push   %eax
     8f8:	89 d8                	mov    %ebx,%eax
     8fa:	c1 e8 03             	shr    $0x3,%eax
     8fd:	03 85 a0 fb ff ff    	add    -0x460(%ebp),%eax
     903:	50                   	push   %eax
     904:	ff 75 0c             	pushl  0xc(%ebp)
     907:	e8 6e 05 00 00       	call   e7a <callBRead>
    //printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (ino % IPB);
     90c:	89 d8                	mov    %ebx,%eax
    //printf(1, "DINODE PTR: %p\n\n", dinodePtr);
    struct dinode dinode = *dinodePtr;

    if(dinode.type != T_DIR){
     90e:	83 c4 10             	add    $0x10,%esp
    callBRead(dev, (ino /IPB) + sb.inodestart, dataBuffer);
    //printf(1, "after in loop CallBRead: %d, NumB: %d, bufStructPtr: %p\n", st.dev, numB, dataBuffer);
    struct dinode* dinodePtr = (struct dinode*) dataBuffer;

        
    dinodePtr = dinodePtr + (ino % IPB);
     911:	83 e0 07             	and    $0x7,%eax
     914:	c1 e0 06             	shl    $0x6,%eax
     917:	01 f8                	add    %edi,%eax
    //printf(1, "DINODE PTR: %p\n\n", dinodePtr);
    struct dinode dinode = *dinodePtr;
     919:	8b 10                	mov    (%eax),%edx
     91b:	89 95 a8 fb ff ff    	mov    %edx,-0x458(%ebp)
     921:	8b 50 04             	mov    0x4(%eax),%edx
     924:	89 95 ac fb ff ff    	mov    %edx,-0x454(%ebp)
     92a:	8b 50 08             	mov    0x8(%eax),%edx
     92d:	89 95 b0 fb ff ff    	mov    %edx,-0x450(%ebp)
     933:	8b 50 0c             	mov    0xc(%eax),%edx
     936:	89 95 b4 fb ff ff    	mov    %edx,-0x44c(%ebp)
     93c:	8b 50 10             	mov    0x10(%eax),%edx
     93f:	89 95 b8 fb ff ff    	mov    %edx,-0x448(%ebp)
     945:	8b 50 14             	mov    0x14(%eax),%edx
     948:	89 95 bc fb ff ff    	mov    %edx,-0x444(%ebp)
     94e:	8b 50 18             	mov    0x18(%eax),%edx
     951:	89 95 c0 fb ff ff    	mov    %edx,-0x440(%ebp)
     957:	8b 50 1c             	mov    0x1c(%eax),%edx
     95a:	89 95 c4 fb ff ff    	mov    %edx,-0x43c(%ebp)
     960:	8b 50 20             	mov    0x20(%eax),%edx
     963:	89 95 c8 fb ff ff    	mov    %edx,-0x438(%ebp)
     969:	8b 50 24             	mov    0x24(%eax),%edx
     96c:	89 95 cc fb ff ff    	mov    %edx,-0x434(%ebp)
     972:	8b 50 28             	mov    0x28(%eax),%edx
     975:	89 95 d0 fb ff ff    	mov    %edx,-0x430(%ebp)
     97b:	8b 50 2c             	mov    0x2c(%eax),%edx
     97e:	89 95 d4 fb ff ff    	mov    %edx,-0x42c(%ebp)
     984:	8b 50 30             	mov    0x30(%eax),%edx
     987:	89 95 d8 fb ff ff    	mov    %edx,-0x428(%ebp)
     98d:	8b 50 34             	mov    0x34(%eax),%edx
     990:	89 95 dc fb ff ff    	mov    %edx,-0x424(%ebp)
     996:	8b 50 38             	mov    0x38(%eax),%edx
     999:	89 95 e0 fb ff ff    	mov    %edx,-0x420(%ebp)
     99f:	8b 50 3c             	mov    0x3c(%eax),%edx
     9a2:	89 95 e4 fb ff ff    	mov    %edx,-0x41c(%ebp)

    if(dinode.type != T_DIR){
     9a8:	66 83 38 01          	cmpw   $0x1,(%eax)
     9ac:	74 1b                	je     9c9 <directoryWalkerFix+0x159>
        printf(1, "Filename: %s \n inode number: %d\n", path, ino);
     9ae:	53                   	push   %ebx
     9af:	ff 75 08             	pushl  0x8(%ebp)
     9b2:	68 cc 14 00 00       	push   $0x14cc
     9b7:	6a 01                	push   $0x1
     9b9:	e8 82 05 00 00       	call   f40 <printf>
        return;
     9be:	83 c4 10             	add    $0x10,%esp
            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    } 
    printf(1, "END OF THE FUNCTION");

}
     9c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c4:	5b                   	pop    %ebx
     9c5:	5e                   	pop    %esi
     9c6:	5f                   	pop    %edi
     9c7:	5d                   	pop    %ebp
     9c8:	c3                   	ret    
     9c9:	8d 85 b4 fb ff ff    	lea    -0x44c(%ebp),%eax
     9cf:	89 85 78 fb ff ff    	mov    %eax,-0x488(%ebp)
        
    dinodePtr = dinodePtr + (ino % IPB);
    //printf(1, "DINODE PTR: %p\n\n", dinodePtr);
    struct dinode dinode = *dinodePtr;

    if(dinode.type != T_DIR){
     9d5:	89 c3                	mov    %eax,%ebx
     9d7:	89 f6                	mov    %esi,%esi
     9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        printf(1, "Filename: %s \n inode number: %d\n", path, ino);
        return;
    }

    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
     9e0:	83 ec 04             	sub    $0x4,%esp
     9e3:	ff 33                	pushl  (%ebx)
     9e5:	83 c3 04             	add    $0x4,%ebx
     9e8:	68 eb 12 00 00       	push   $0x12eb
     9ed:	6a 01                	push   $0x1
     9ef:	e8 4c 05 00 00       	call   f40 <printf>
    if(dinode.type != T_DIR){
        printf(1, "Filename: %s \n inode number: %d\n", path, ino);
        return;
    }

    for(int i = 0; i < NDIRECT+1; i++){
     9f4:	83 c4 10             	add    $0x10,%esp
     9f7:	39 f3                	cmp    %esi,%ebx
     9f9:	75 e5                	jne    9e0 <directoryWalkerFix+0x170>
        printf(1, "%d, ", dinode.addrs[i]);
    }

    strcpy(buf, path);
     9fb:	83 ec 08             	sub    $0x8,%esp
     9fe:	ff 75 08             	pushl  0x8(%ebp)
     a01:	56                   	push   %esi
     a02:	e8 79 01 00 00       	call   b80 <strcpy>
    p = buf+strlen(buf);
     a07:	89 34 24             	mov    %esi,(%esp)
     a0a:	e8 f1 01 00 00       	call   c00 <strlen>
     a0f:	8d 3c 06             	lea    (%esi,%eax,1),%edi
    //printf(1, "buf: %d buf len: %d\n\n", buf, strlen(buf));
    //printf(1, "p how far: %d", p - buf);
    *p++ = '/';
     a12:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
     a16:	83 c4 10             	add    $0x10,%esp
    for(int i = 0; i < NDIRECT+1; i++){
        printf(1, "%d, ", dinode.addrs[i]);
    }

    strcpy(buf, path);
    p = buf+strlen(buf);
     a19:	89 bd 80 fb ff ff    	mov    %edi,-0x480(%ebp)
    //printf(1, "buf: %d buf len: %d\n\n", buf, strlen(buf));
    //printf(1, "p how far: %d", p - buf);
    *p++ = '/';
     a1f:	c6 07 2f             	movb   $0x2f,(%edi)
     a22:	8d 7d ea             	lea    -0x16(%ebp),%edi
     a25:	89 85 7c fb ff ff    	mov    %eax,-0x484(%ebp)
     a2b:	90                   	nop
     a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(int k = 0; k < NDIRECT+1; k++){
        //printf(1, "INODE %d, ADDR %d\n\n", ino, dinode.addrs[k]);
        //printf(1, "k: %d, ADDREESS PTR %p\n\n", k, dinode.addrs);
        if(dinode.addrs[k] == 0) break;
     a30:	8b 85 78 fb ff ff    	mov    -0x488(%ebp),%eax
     a36:	8b 00                	mov    (%eax),%eax
     a38:	85 c0                	test   %eax,%eax
     a3a:	0f 84 25 01 00 00    	je     b65 <directoryWalkerFix+0x2f5>

        //printf(1, "BLOCKNO IN LOOP: %d\n\n", dinode.addrs[k]);
        callBRead(dev, dinode.addrs[k], dataBuffer);
     a40:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
     a46:	83 ec 04             	sub    $0x4,%esp
     a49:	8d 9d ea fd ff ff    	lea    -0x216(%ebp),%ebx
     a4f:	52                   	push   %edx
     a50:	50                   	push   %eax
     a51:	ff 75 0c             	pushl  0xc(%ebp)
     a54:	e8 21 04 00 00       	call   e7a <callBRead>
     a59:	83 c4 10             	add    $0x10,%esp
     a5c:	eb 0d                	jmp    a6b <directoryWalkerFix+0x1fb>
     a5e:	66 90                	xchg   %ax,%ax
     a60:	83 c3 20             	add    $0x20,%ebx
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
     a63:	39 fb                	cmp    %edi,%ebx
     a65:	0f 84 e5 00 00 00    	je     b50 <directoryWalkerFix+0x2e0>
            //printf(1, "DIRENT PTR: %p\n\n", ptr);
            printf(1, "ALL DE READS: %s AND %d\n\n", ptr->name, ptr->inum);
     a6b:	0f b7 43 fe          	movzwl -0x2(%ebx),%eax
     a6f:	50                   	push   %eax
     a70:	53                   	push   %ebx
     a71:	68 de 13 00 00       	push   $0x13de
     a76:	6a 01                	push   $0x1
     a78:	e8 c3 04 00 00       	call   f40 <printf>
                if(ptr->inum == 0)
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	66 83 7b fe 00       	cmpw   $0x0,-0x2(%ebx)
     a85:	74 d9                	je     a60 <directoryWalkerFix+0x1f0>
                    continue;

                char* temp = malloc(strlen(buf)+1);
     a87:	83 ec 0c             	sub    $0xc,%esp
     a8a:	56                   	push   %esi
     a8b:	e8 70 01 00 00       	call   c00 <strlen>
     a90:	83 c0 01             	add    $0x1,%eax
     a93:	89 04 24             	mov    %eax,(%esp)
     a96:	e8 d5 06 00 00       	call   1170 <malloc>
     a9b:	89 c2                	mov    %eax,%edx


                
                //printf(1, "AFTER STRCPY: %s & %s", temp, ptr->name);

                allInodes[allInodesCounter].inum = ptr->inum;
     a9d:	a1 ec 18 00 00       	mov    0x18ec,%eax
     aa2:	8b 0d fc 18 00 00    	mov    0x18fc,%ecx
                allInodes[allInodesCounter].name = temp;
            
                allInodesCounter++;
                
                memmove(p, ptr->name, DIRSIZ);
     aa8:	83 c4 0c             	add    $0xc,%esp

                
                //printf(1, "AFTER STRCPY: %s & %s", temp, ptr->name);

                allInodes[allInodesCounter].inum = ptr->inum;
                allInodes[allInodesCounter].name = temp;
     aab:	89 95 84 fb ff ff    	mov    %edx,-0x47c(%ebp)


                
                //printf(1, "AFTER STRCPY: %s & %s", temp, ptr->name);

                allInodes[allInodesCounter].inum = ptr->inum;
     ab1:	8d 04 40             	lea    (%eax,%eax,2),%eax
     ab4:	8d 04 81             	lea    (%ecx,%eax,4),%eax
     ab7:	0f b7 4b fe          	movzwl -0x2(%ebx),%ecx
     abb:	89 08                	mov    %ecx,(%eax)
                allInodes[allInodesCounter].name = temp;
     abd:	a1 ec 18 00 00       	mov    0x18ec,%eax
     ac2:	8d 0c 40             	lea    (%eax,%eax,2),%ecx
            
                allInodesCounter++;
     ac5:	83 c0 01             	add    $0x1,%eax
     ac8:	a3 ec 18 00 00       	mov    %eax,0x18ec

                
                //printf(1, "AFTER STRCPY: %s & %s", temp, ptr->name);

                allInodes[allInodesCounter].inum = ptr->inum;
                allInodes[allInodesCounter].name = temp;
     acd:	c1 e1 02             	shl    $0x2,%ecx
     ad0:	03 0d fc 18 00 00    	add    0x18fc,%ecx
     ad6:	89 51 04             	mov    %edx,0x4(%ecx)
            
                allInodesCounter++;
                
                memmove(p, ptr->name, DIRSIZ);
     ad9:	6a 1e                	push   $0x1e
     adb:	53                   	push   %ebx
     adc:	ff b5 7c fb ff ff    	pushl  -0x484(%ebp)
     ae2:	e8 a9 02 00 00       	call   d90 <memmove>
                p[DIRSIZ] = 0;
     ae7:	8b 85 80 fb ff ff    	mov    -0x480(%ebp),%eax
     aed:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
                strcpy(temp, buf);
     af1:	58                   	pop    %eax
     af2:	5a                   	pop    %edx
     af3:	8b 95 84 fb ff ff    	mov    -0x47c(%ebp),%edx
     af9:	56                   	push   %esi
     afa:	52                   	push   %edx
     afb:	e8 80 00 00 00       	call   b80 <strcpy>

                if(strcmp(ptr->name, ".") == 0 || strcmp(ptr->name, "..") == 0) continue;
     b00:	59                   	pop    %ecx
     b01:	58                   	pop    %eax
     b02:	68 f9 13 00 00       	push   $0x13f9
     b07:	53                   	push   %ebx
     b08:	e8 a3 00 00 00       	call   bb0 <strcmp>
     b0d:	83 c4 10             	add    $0x10,%esp
     b10:	85 c0                	test   %eax,%eax
     b12:	0f 84 48 ff ff ff    	je     a60 <directoryWalkerFix+0x1f0>
     b18:	83 ec 08             	sub    $0x8,%esp
     b1b:	68 f8 13 00 00       	push   $0x13f8
     b20:	53                   	push   %ebx
     b21:	e8 8a 00 00 00       	call   bb0 <strcmp>
     b26:	83 c4 10             	add    $0x10,%esp
     b29:	85 c0                	test   %eax,%eax
     b2b:	0f 84 2f ff ff ff    	je     a60 <directoryWalkerFix+0x1f0>

                //printf(1, "AFTER MEMMOVE: %d & %s", p, ptr->name);

                //printf(1, "PP: %d\n\n", p - buf);
                directoryWalkerFix(buf, dev, ptr->inum);
     b31:	0f b7 43 fe          	movzwl -0x2(%ebx),%eax
     b35:	83 ec 04             	sub    $0x4,%esp
     b38:	83 c3 20             	add    $0x20,%ebx
     b3b:	50                   	push   %eax
     b3c:	ff 75 0c             	pushl  0xc(%ebp)
     b3f:	56                   	push   %esi
     b40:	e8 2b fd ff ff       	call   870 <directoryWalkerFix>
     b45:	83 c4 10             	add    $0x10,%esp
        if(dinode.addrs[k] == 0) break;

        //printf(1, "BLOCKNO IN LOOP: %d\n\n", dinode.addrs[k]);
        callBRead(dev, dinode.addrs[k], dataBuffer);
        
        for(struct dirent *ptr = (struct dirent*) dataBuffer; ptr < (struct dirent*) (dataBuffer + BSIZE); ptr++){
     b48:	39 fb                	cmp    %edi,%ebx
     b4a:	0f 85 1b ff ff ff    	jne    a6b <directoryWalkerFix+0x1fb>
     b50:	83 85 78 fb ff ff 04 	addl   $0x4,-0x488(%ebp)
     b57:	8b 85 78 fb ff ff    	mov    -0x488(%ebp),%eax
    strcpy(buf, path);
    p = buf+strlen(buf);
    //printf(1, "buf: %d buf len: %d\n\n", buf, strlen(buf));
    //printf(1, "p how far: %d", p - buf);
    *p++ = '/';
    for(int k = 0; k < NDIRECT+1; k++){
     b5d:	39 f0                	cmp    %esi,%eax
     b5f:	0f 85 cb fe ff ff    	jne    a30 <directoryWalkerFix+0x1c0>


            //printf(1, "inum %d, name %s\n\n", ptr->inum, ptr->name);
        }
    } 
    printf(1, "END OF THE FUNCTION");
     b65:	83 ec 08             	sub    $0x8,%esp
     b68:	68 ca 13 00 00       	push   $0x13ca
     b6d:	6a 01                	push   $0x1
     b6f:	e8 cc 03 00 00       	call   f40 <printf>
     b74:	83 c4 10             	add    $0x10,%esp

}
     b77:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b7a:	5b                   	pop    %ebx
     b7b:	5e                   	pop    %esi
     b7c:	5f                   	pop    %edi
     b7d:	5d                   	pop    %ebp
     b7e:	c3                   	ret    
     b7f:	90                   	nop

00000b80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	53                   	push   %ebx
     b84:	8b 45 08             	mov    0x8(%ebp),%eax
     b87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b8a:	89 c2                	mov    %eax,%edx
     b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b90:	83 c1 01             	add    $0x1,%ecx
     b93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     b97:	83 c2 01             	add    $0x1,%edx
     b9a:	84 db                	test   %bl,%bl
     b9c:	88 5a ff             	mov    %bl,-0x1(%edx)
     b9f:	75 ef                	jne    b90 <strcpy+0x10>
    ;
  return os;
}
     ba1:	5b                   	pop    %ebx
     ba2:	5d                   	pop    %ebp
     ba3:	c3                   	ret    
     ba4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     baa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000bb0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	56                   	push   %esi
     bb4:	53                   	push   %ebx
     bb5:	8b 55 08             	mov    0x8(%ebp),%edx
     bb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     bbb:	0f b6 02             	movzbl (%edx),%eax
     bbe:	0f b6 19             	movzbl (%ecx),%ebx
     bc1:	84 c0                	test   %al,%al
     bc3:	75 1e                	jne    be3 <strcmp+0x33>
     bc5:	eb 29                	jmp    bf0 <strcmp+0x40>
     bc7:	89 f6                	mov    %esi,%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     bd0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     bd3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     bd6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     bd9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     bdd:	84 c0                	test   %al,%al
     bdf:	74 0f                	je     bf0 <strcmp+0x40>
     be1:	89 f1                	mov    %esi,%ecx
     be3:	38 d8                	cmp    %bl,%al
     be5:	74 e9                	je     bd0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     be7:	29 d8                	sub    %ebx,%eax
}
     be9:	5b                   	pop    %ebx
     bea:	5e                   	pop    %esi
     beb:	5d                   	pop    %ebp
     bec:	c3                   	ret    
     bed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     bf0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     bf2:	29 d8                	sub    %ebx,%eax
}
     bf4:	5b                   	pop    %ebx
     bf5:	5e                   	pop    %esi
     bf6:	5d                   	pop    %ebp
     bf7:	c3                   	ret    
     bf8:	90                   	nop
     bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c00 <strlen>:

uint
strlen(const char *s)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     c06:	80 39 00             	cmpb   $0x0,(%ecx)
     c09:	74 12                	je     c1d <strlen+0x1d>
     c0b:	31 d2                	xor    %edx,%edx
     c0d:	8d 76 00             	lea    0x0(%esi),%esi
     c10:	83 c2 01             	add    $0x1,%edx
     c13:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c17:	89 d0                	mov    %edx,%eax
     c19:	75 f5                	jne    c10 <strlen+0x10>
    ;
  return n;
}
     c1b:	5d                   	pop    %ebp
     c1c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     c1d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     c1f:	5d                   	pop    %ebp
     c20:	c3                   	ret    
     c21:	eb 0d                	jmp    c30 <memset>
     c23:	90                   	nop
     c24:	90                   	nop
     c25:	90                   	nop
     c26:	90                   	nop
     c27:	90                   	nop
     c28:	90                   	nop
     c29:	90                   	nop
     c2a:	90                   	nop
     c2b:	90                   	nop
     c2c:	90                   	nop
     c2d:	90                   	nop
     c2e:	90                   	nop
     c2f:	90                   	nop

00000c30 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	57                   	push   %edi
     c34:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     c37:	8b 4d 10             	mov    0x10(%ebp),%ecx
     c3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3d:	89 d7                	mov    %edx,%edi
     c3f:	fc                   	cld    
     c40:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     c42:	89 d0                	mov    %edx,%eax
     c44:	5f                   	pop    %edi
     c45:	5d                   	pop    %ebp
     c46:	c3                   	ret    
     c47:	89 f6                	mov    %esi,%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <strchr>:

char*
strchr(const char *s, char c)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	53                   	push   %ebx
     c54:	8b 45 08             	mov    0x8(%ebp),%eax
     c57:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     c5a:	0f b6 10             	movzbl (%eax),%edx
     c5d:	84 d2                	test   %dl,%dl
     c5f:	74 1d                	je     c7e <strchr+0x2e>
    if(*s == c)
     c61:	38 d3                	cmp    %dl,%bl
     c63:	89 d9                	mov    %ebx,%ecx
     c65:	75 0d                	jne    c74 <strchr+0x24>
     c67:	eb 17                	jmp    c80 <strchr+0x30>
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c70:	38 ca                	cmp    %cl,%dl
     c72:	74 0c                	je     c80 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     c74:	83 c0 01             	add    $0x1,%eax
     c77:	0f b6 10             	movzbl (%eax),%edx
     c7a:	84 d2                	test   %dl,%dl
     c7c:	75 f2                	jne    c70 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
     c7e:	31 c0                	xor    %eax,%eax
}
     c80:	5b                   	pop    %ebx
     c81:	5d                   	pop    %ebp
     c82:	c3                   	ret    
     c83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c90 <gets>:

char*
gets(char *buf, int max)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	57                   	push   %edi
     c94:	56                   	push   %esi
     c95:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c96:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     c98:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     c9b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c9e:	eb 29                	jmp    cc9 <gets+0x39>
    cc = read(0, &c, 1);
     ca0:	83 ec 04             	sub    $0x4,%esp
     ca3:	6a 01                	push   $0x1
     ca5:	57                   	push   %edi
     ca6:	6a 00                	push   $0x0
     ca8:	e8 2d 01 00 00       	call   dda <read>
    if(cc < 1)
     cad:	83 c4 10             	add    $0x10,%esp
     cb0:	85 c0                	test   %eax,%eax
     cb2:	7e 1d                	jle    cd1 <gets+0x41>
      break;
    buf[i++] = c;
     cb4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     cb8:	8b 55 08             	mov    0x8(%ebp),%edx
     cbb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     cbd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     cbf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     cc3:	74 1b                	je     ce0 <gets+0x50>
     cc5:	3c 0d                	cmp    $0xd,%al
     cc7:	74 17                	je     ce0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cc9:	8d 5e 01             	lea    0x1(%esi),%ebx
     ccc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     ccf:	7c cf                	jl     ca0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cdb:	5b                   	pop    %ebx
     cdc:	5e                   	pop    %esi
     cdd:	5f                   	pop    %edi
     cde:	5d                   	pop    %ebp
     cdf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ce0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ce3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ce5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ce9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cec:	5b                   	pop    %ebx
     ced:	5e                   	pop    %esi
     cee:	5f                   	pop    %edi
     cef:	5d                   	pop    %ebp
     cf0:	c3                   	ret    
     cf1:	eb 0d                	jmp    d00 <stat>
     cf3:	90                   	nop
     cf4:	90                   	nop
     cf5:	90                   	nop
     cf6:	90                   	nop
     cf7:	90                   	nop
     cf8:	90                   	nop
     cf9:	90                   	nop
     cfa:	90                   	nop
     cfb:	90                   	nop
     cfc:	90                   	nop
     cfd:	90                   	nop
     cfe:	90                   	nop
     cff:	90                   	nop

00000d00 <stat>:

int
stat(const char *n, struct stat *st)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	56                   	push   %esi
     d04:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d05:	83 ec 08             	sub    $0x8,%esp
     d08:	6a 00                	push   $0x0
     d0a:	ff 75 08             	pushl  0x8(%ebp)
     d0d:	e8 f0 00 00 00       	call   e02 <open>
  if(fd < 0)
     d12:	83 c4 10             	add    $0x10,%esp
     d15:	85 c0                	test   %eax,%eax
     d17:	78 27                	js     d40 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     d19:	83 ec 08             	sub    $0x8,%esp
     d1c:	ff 75 0c             	pushl  0xc(%ebp)
     d1f:	89 c3                	mov    %eax,%ebx
     d21:	50                   	push   %eax
     d22:	e8 f3 00 00 00       	call   e1a <fstat>
     d27:	89 c6                	mov    %eax,%esi
  close(fd);
     d29:	89 1c 24             	mov    %ebx,(%esp)
     d2c:	e8 b9 00 00 00       	call   dea <close>
  return r;
     d31:	83 c4 10             	add    $0x10,%esp
     d34:	89 f0                	mov    %esi,%eax
}
     d36:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d39:	5b                   	pop    %ebx
     d3a:	5e                   	pop    %esi
     d3b:	5d                   	pop    %ebp
     d3c:	c3                   	ret    
     d3d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d45:	eb ef                	jmp    d36 <stat+0x36>
     d47:	89 f6                	mov    %esi,%esi
     d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d50 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	53                   	push   %ebx
     d54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d57:	0f be 11             	movsbl (%ecx),%edx
     d5a:	8d 42 d0             	lea    -0x30(%edx),%eax
     d5d:	3c 09                	cmp    $0x9,%al
     d5f:	b8 00 00 00 00       	mov    $0x0,%eax
     d64:	77 1f                	ja     d85 <atoi+0x35>
     d66:	8d 76 00             	lea    0x0(%esi),%esi
     d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     d70:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d73:	83 c1 01             	add    $0x1,%ecx
     d76:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d7a:	0f be 11             	movsbl (%ecx),%edx
     d7d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d80:	80 fb 09             	cmp    $0x9,%bl
     d83:	76 eb                	jbe    d70 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
     d85:	5b                   	pop    %ebx
     d86:	5d                   	pop    %ebp
     d87:	c3                   	ret    
     d88:	90                   	nop
     d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d90 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	53                   	push   %ebx
     d95:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d98:	8b 45 08             	mov    0x8(%ebp),%eax
     d9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d9e:	85 db                	test   %ebx,%ebx
     da0:	7e 14                	jle    db6 <memmove+0x26>
     da2:	31 d2                	xor    %edx,%edx
     da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     da8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     daf:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     db2:	39 da                	cmp    %ebx,%edx
     db4:	75 f2                	jne    da8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     db6:	5b                   	pop    %ebx
     db7:	5e                   	pop    %esi
     db8:	5d                   	pop    %ebp
     db9:	c3                   	ret    

00000dba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     dba:	b8 01 00 00 00       	mov    $0x1,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <exit>:
SYSCALL(exit)
     dc2:	b8 02 00 00 00       	mov    $0x2,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <wait>:
SYSCALL(wait)
     dca:	b8 03 00 00 00       	mov    $0x3,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <pipe>:
SYSCALL(pipe)
     dd2:	b8 04 00 00 00       	mov    $0x4,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <read>:
SYSCALL(read)
     dda:	b8 05 00 00 00       	mov    $0x5,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <write>:
SYSCALL(write)
     de2:	b8 10 00 00 00       	mov    $0x10,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <close>:
SYSCALL(close)
     dea:	b8 15 00 00 00       	mov    $0x15,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <kill>:
SYSCALL(kill)
     df2:	b8 06 00 00 00       	mov    $0x6,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    

00000dfa <exec>:
SYSCALL(exec)
     dfa:	b8 07 00 00 00       	mov    $0x7,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <open>:
SYSCALL(open)
     e02:	b8 0f 00 00 00       	mov    $0xf,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <mknod>:
SYSCALL(mknod)
     e0a:	b8 11 00 00 00       	mov    $0x11,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <unlink>:
SYSCALL(unlink)
     e12:	b8 12 00 00 00       	mov    $0x12,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <fstat>:
SYSCALL(fstat)
     e1a:	b8 08 00 00 00       	mov    $0x8,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <link>:
SYSCALL(link)
     e22:	b8 13 00 00 00       	mov    $0x13,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <mkdir>:
SYSCALL(mkdir)
     e2a:	b8 14 00 00 00       	mov    $0x14,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <chdir>:
SYSCALL(chdir)
     e32:	b8 09 00 00 00       	mov    $0x9,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <dup>:
SYSCALL(dup)
     e3a:	b8 0a 00 00 00       	mov    $0xa,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <getpid>:
SYSCALL(getpid)
     e42:	b8 0b 00 00 00       	mov    $0xb,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <sbrk>:
SYSCALL(sbrk)
     e4a:	b8 0c 00 00 00       	mov    $0xc,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    

00000e52 <sleep>:
SYSCALL(sleep)
     e52:	b8 0d 00 00 00       	mov    $0xd,%eax
     e57:	cd 40                	int    $0x40
     e59:	c3                   	ret    

00000e5a <uptime>:
SYSCALL(uptime)
     e5a:	b8 0e 00 00 00       	mov    $0xe,%eax
     e5f:	cd 40                	int    $0x40
     e61:	c3                   	ret    

00000e62 <countTrap>:
SYSCALL(countTrap)
     e62:	b8 16 00 00 00       	mov    $0x16,%eax
     e67:	cd 40                	int    $0x40
     e69:	c3                   	ret    

00000e6a <getSharedPage>:
SYSCALL(getSharedPage)
     e6a:	b8 17 00 00 00       	mov    $0x17,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <freeSharedPage>:
SYSCALL(freeSharedPage)
     e72:	b8 18 00 00 00       	mov    $0x18,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <callBRead>:
SYSCALL(callBRead)
     e7a:	b8 19 00 00 00       	mov    $0x19,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <callSBRead>:
SYSCALL(callSBRead)
     e82:	b8 1a 00 00 00       	mov    $0x1a,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <seek>:
SYSCALL(seek)
     e8a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <callBWrite>:
     e92:	b8 1c 00 00 00       	mov    $0x1c,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    
     e9a:	66 90                	xchg   %ax,%ax
     e9c:	66 90                	xchg   %ax,%ax
     e9e:	66 90                	xchg   %ax,%ax

00000ea0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	89 c6                	mov    %eax,%esi
     ea8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     eab:	8b 5d 08             	mov    0x8(%ebp),%ebx
     eae:	85 db                	test   %ebx,%ebx
     eb0:	74 7e                	je     f30 <printint+0x90>
     eb2:	89 d0                	mov    %edx,%eax
     eb4:	c1 e8 1f             	shr    $0x1f,%eax
     eb7:	84 c0                	test   %al,%al
     eb9:	74 75                	je     f30 <printint+0x90>
    neg = 1;
    x = -xx;
     ebb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     ebd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
     ec4:	f7 d8                	neg    %eax
     ec6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     ec9:	31 ff                	xor    %edi,%edi
     ecb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     ece:	89 ce                	mov    %ecx,%esi
     ed0:	eb 08                	jmp    eda <printint+0x3a>
     ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     ed8:	89 cf                	mov    %ecx,%edi
     eda:	31 d2                	xor    %edx,%edx
     edc:	8d 4f 01             	lea    0x1(%edi),%ecx
     edf:	f7 f6                	div    %esi
     ee1:	0f b6 92 f8 14 00 00 	movzbl 0x14f8(%edx),%edx
  }while((x /= base) != 0);
     ee8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     eea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     eed:	75 e9                	jne    ed8 <printint+0x38>
  if(neg)
     eef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     ef2:	8b 75 c0             	mov    -0x40(%ebp),%esi
     ef5:	85 c0                	test   %eax,%eax
     ef7:	74 08                	je     f01 <printint+0x61>
    buf[i++] = '-';
     ef9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     efe:	8d 4f 02             	lea    0x2(%edi),%ecx
     f01:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
     f05:	8d 76 00             	lea    0x0(%esi),%esi
     f08:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f0b:	83 ec 04             	sub    $0x4,%esp
     f0e:	83 ef 01             	sub    $0x1,%edi
     f11:	6a 01                	push   $0x1
     f13:	53                   	push   %ebx
     f14:	56                   	push   %esi
     f15:	88 45 d7             	mov    %al,-0x29(%ebp)
     f18:	e8 c5 fe ff ff       	call   de2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     f1d:	83 c4 10             	add    $0x10,%esp
     f20:	39 df                	cmp    %ebx,%edi
     f22:	75 e4                	jne    f08 <printint+0x68>
    putc(fd, buf[i]);
}
     f24:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f27:	5b                   	pop    %ebx
     f28:	5e                   	pop    %esi
     f29:	5f                   	pop    %edi
     f2a:	5d                   	pop    %ebp
     f2b:	c3                   	ret    
     f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f30:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f32:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     f39:	eb 8b                	jmp    ec6 <printint+0x26>
     f3b:	90                   	nop
     f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f40 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	56                   	push   %esi
     f45:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f46:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f49:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f4f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f52:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f55:	0f b6 1e             	movzbl (%esi),%ebx
     f58:	83 c6 01             	add    $0x1,%esi
     f5b:	84 db                	test   %bl,%bl
     f5d:	0f 84 b0 00 00 00    	je     1013 <printf+0xd3>
     f63:	31 d2                	xor    %edx,%edx
     f65:	eb 39                	jmp    fa0 <printf+0x60>
     f67:	89 f6                	mov    %esi,%esi
     f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f70:	83 f8 25             	cmp    $0x25,%eax
     f73:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     f76:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f7b:	74 18                	je     f95 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f7d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f80:	83 ec 04             	sub    $0x4,%esp
     f83:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     f86:	6a 01                	push   $0x1
     f88:	50                   	push   %eax
     f89:	57                   	push   %edi
     f8a:	e8 53 fe ff ff       	call   de2 <write>
     f8f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f92:	83 c4 10             	add    $0x10,%esp
     f95:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f98:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f9c:	84 db                	test   %bl,%bl
     f9e:	74 73                	je     1013 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
     fa0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
     fa2:	0f be cb             	movsbl %bl,%ecx
     fa5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     fa8:	74 c6                	je     f70 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     faa:	83 fa 25             	cmp    $0x25,%edx
     fad:	75 e6                	jne    f95 <printf+0x55>
      if(c == 'd'){
     faf:	83 f8 64             	cmp    $0x64,%eax
     fb2:	0f 84 f8 00 00 00    	je     10b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     fb8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     fbe:	83 f9 70             	cmp    $0x70,%ecx
     fc1:	74 5d                	je     1020 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     fc3:	83 f8 73             	cmp    $0x73,%eax
     fc6:	0f 84 84 00 00 00    	je     1050 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     fcc:	83 f8 63             	cmp    $0x63,%eax
     fcf:	0f 84 ea 00 00 00    	je     10bf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     fd5:	83 f8 25             	cmp    $0x25,%eax
     fd8:	0f 84 c2 00 00 00    	je     10a0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     fde:	8d 45 e7             	lea    -0x19(%ebp),%eax
     fe1:	83 ec 04             	sub    $0x4,%esp
     fe4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     fe8:	6a 01                	push   $0x1
     fea:	50                   	push   %eax
     feb:	57                   	push   %edi
     fec:	e8 f1 fd ff ff       	call   de2 <write>
     ff1:	83 c4 0c             	add    $0xc,%esp
     ff4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ff7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     ffa:	6a 01                	push   $0x1
     ffc:	50                   	push   %eax
     ffd:	57                   	push   %edi
     ffe:	83 c6 01             	add    $0x1,%esi
    1001:	e8 dc fd ff ff       	call   de2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1006:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    100a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    100d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    100f:	84 db                	test   %bl,%bl
    1011:	75 8d                	jne    fa0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1013:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1016:	5b                   	pop    %ebx
    1017:	5e                   	pop    %esi
    1018:	5f                   	pop    %edi
    1019:	5d                   	pop    %ebp
    101a:	c3                   	ret    
    101b:	90                   	nop
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1020:	83 ec 0c             	sub    $0xc,%esp
    1023:	b9 10 00 00 00       	mov    $0x10,%ecx
    1028:	6a 00                	push   $0x0
    102a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    102d:	89 f8                	mov    %edi,%eax
    102f:	8b 13                	mov    (%ebx),%edx
    1031:	e8 6a fe ff ff       	call   ea0 <printint>
        ap++;
    1036:	89 d8                	mov    %ebx,%eax
    1038:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    103b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    103d:	83 c0 04             	add    $0x4,%eax
    1040:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1043:	e9 4d ff ff ff       	jmp    f95 <printf+0x55>
    1048:	90                   	nop
    1049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1050:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1053:	8b 18                	mov    (%eax),%ebx
        ap++;
    1055:	83 c0 04             	add    $0x4,%eax
    1058:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    105b:	b8 f0 14 00 00       	mov    $0x14f0,%eax
    1060:	85 db                	test   %ebx,%ebx
    1062:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1065:	0f b6 03             	movzbl (%ebx),%eax
    1068:	84 c0                	test   %al,%al
    106a:	74 23                	je     108f <printf+0x14f>
    106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1070:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1073:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1076:	83 ec 04             	sub    $0x4,%esp
    1079:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    107b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    107e:	50                   	push   %eax
    107f:	57                   	push   %edi
    1080:	e8 5d fd ff ff       	call   de2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1085:	0f b6 03             	movzbl (%ebx),%eax
    1088:	83 c4 10             	add    $0x10,%esp
    108b:	84 c0                	test   %al,%al
    108d:	75 e1                	jne    1070 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    108f:	31 d2                	xor    %edx,%edx
    1091:	e9 ff fe ff ff       	jmp    f95 <printf+0x55>
    1096:	8d 76 00             	lea    0x0(%esi),%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    10a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    10a9:	6a 01                	push   $0x1
    10ab:	e9 4c ff ff ff       	jmp    ffc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    10b0:	83 ec 0c             	sub    $0xc,%esp
    10b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    10b8:	6a 01                	push   $0x1
    10ba:	e9 6b ff ff ff       	jmp    102a <printf+0xea>
    10bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10c2:	83 ec 04             	sub    $0x4,%esp
    10c5:	8b 03                	mov    (%ebx),%eax
    10c7:	6a 01                	push   $0x1
    10c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    10cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    10cf:	50                   	push   %eax
    10d0:	57                   	push   %edi
    10d1:	e8 0c fd ff ff       	call   de2 <write>
    10d6:	e9 5b ff ff ff       	jmp    1036 <printf+0xf6>
    10db:	66 90                	xchg   %ax,%ax
    10dd:	66 90                	xchg   %ax,%ax
    10df:	90                   	nop

000010e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10e1:	a1 f0 18 00 00       	mov    0x18f0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    10e6:	89 e5                	mov    %esp,%ebp
    10e8:	57                   	push   %edi
    10e9:	56                   	push   %esi
    10ea:	53                   	push   %ebx
    10eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10ee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    10f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10f3:	39 c8                	cmp    %ecx,%eax
    10f5:	73 19                	jae    1110 <free+0x30>
    10f7:	89 f6                	mov    %esi,%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1100:	39 d1                	cmp    %edx,%ecx
    1102:	72 1c                	jb     1120 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1104:	39 d0                	cmp    %edx,%eax
    1106:	73 18                	jae    1120 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1108:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    110a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    110c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    110e:	72 f0                	jb     1100 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1110:	39 d0                	cmp    %edx,%eax
    1112:	72 f4                	jb     1108 <free+0x28>
    1114:	39 d1                	cmp    %edx,%ecx
    1116:	73 f0                	jae    1108 <free+0x28>
    1118:	90                   	nop
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1120:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1123:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1126:	39 d7                	cmp    %edx,%edi
    1128:	74 19                	je     1143 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    112a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    112d:	8b 50 04             	mov    0x4(%eax),%edx
    1130:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1133:	39 f1                	cmp    %esi,%ecx
    1135:	74 23                	je     115a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1137:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1139:	a3 f0 18 00 00       	mov    %eax,0x18f0
}
    113e:	5b                   	pop    %ebx
    113f:	5e                   	pop    %esi
    1140:	5f                   	pop    %edi
    1141:	5d                   	pop    %ebp
    1142:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1143:	03 72 04             	add    0x4(%edx),%esi
    1146:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1149:	8b 10                	mov    (%eax),%edx
    114b:	8b 12                	mov    (%edx),%edx
    114d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1150:	8b 50 04             	mov    0x4(%eax),%edx
    1153:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1156:	39 f1                	cmp    %esi,%ecx
    1158:	75 dd                	jne    1137 <free+0x57>
    p->s.size += bp->s.size;
    115a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    115d:	a3 f0 18 00 00       	mov    %eax,0x18f0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1162:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1165:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1168:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    116a:	5b                   	pop    %ebx
    116b:	5e                   	pop    %esi
    116c:	5f                   	pop    %edi
    116d:	5d                   	pop    %ebp
    116e:	c3                   	ret    
    116f:	90                   	nop

00001170 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	57                   	push   %edi
    1174:	56                   	push   %esi
    1175:	53                   	push   %ebx
    1176:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    117c:	8b 15 f0 18 00 00    	mov    0x18f0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1182:	8d 78 07             	lea    0x7(%eax),%edi
    1185:	c1 ef 03             	shr    $0x3,%edi
    1188:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    118b:	85 d2                	test   %edx,%edx
    118d:	0f 84 a3 00 00 00    	je     1236 <malloc+0xc6>
    1193:	8b 02                	mov    (%edx),%eax
    1195:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1198:	39 cf                	cmp    %ecx,%edi
    119a:	76 74                	jbe    1210 <malloc+0xa0>
    119c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    11a2:	be 00 10 00 00       	mov    $0x1000,%esi
    11a7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    11ae:	0f 43 f7             	cmovae %edi,%esi
    11b1:	ba 00 80 00 00       	mov    $0x8000,%edx
    11b6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    11bc:	0f 46 da             	cmovbe %edx,%ebx
    11bf:	eb 10                	jmp    11d1 <malloc+0x61>
    11c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    11ca:	8b 48 04             	mov    0x4(%eax),%ecx
    11cd:	39 cf                	cmp    %ecx,%edi
    11cf:	76 3f                	jbe    1210 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11d1:	39 05 f0 18 00 00    	cmp    %eax,0x18f0
    11d7:	89 c2                	mov    %eax,%edx
    11d9:	75 ed                	jne    11c8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    11db:	83 ec 0c             	sub    $0xc,%esp
    11de:	53                   	push   %ebx
    11df:	e8 66 fc ff ff       	call   e4a <sbrk>
  if(p == (char*)-1)
    11e4:	83 c4 10             	add    $0x10,%esp
    11e7:	83 f8 ff             	cmp    $0xffffffff,%eax
    11ea:	74 1c                	je     1208 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    11ec:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    11ef:	83 ec 0c             	sub    $0xc,%esp
    11f2:	83 c0 08             	add    $0x8,%eax
    11f5:	50                   	push   %eax
    11f6:	e8 e5 fe ff ff       	call   10e0 <free>
  return freep;
    11fb:	8b 15 f0 18 00 00    	mov    0x18f0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1201:	83 c4 10             	add    $0x10,%esp
    1204:	85 d2                	test   %edx,%edx
    1206:	75 c0                	jne    11c8 <malloc+0x58>
        return 0;
    1208:	31 c0                	xor    %eax,%eax
    120a:	eb 1c                	jmp    1228 <malloc+0xb8>
    120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1210:	39 cf                	cmp    %ecx,%edi
    1212:	74 1c                	je     1230 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1214:	29 f9                	sub    %edi,%ecx
    1216:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1219:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    121c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    121f:	89 15 f0 18 00 00    	mov    %edx,0x18f0
      return (void*)(p + 1);
    1225:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1228:	8d 65 f4             	lea    -0xc(%ebp),%esp
    122b:	5b                   	pop    %ebx
    122c:	5e                   	pop    %esi
    122d:	5f                   	pop    %edi
    122e:	5d                   	pop    %ebp
    122f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1230:	8b 08                	mov    (%eax),%ecx
    1232:	89 0a                	mov    %ecx,(%edx)
    1234:	eb e9                	jmp    121f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1236:	c7 05 f0 18 00 00 f4 	movl   $0x18f4,0x18f0
    123d:	18 00 00 
    1240:	c7 05 f4 18 00 00 f4 	movl   $0x18f4,0x18f4
    1247:	18 00 00 
    base.s.size = 0;
    124a:	b8 f4 18 00 00       	mov    $0x18f4,%eax
    124f:	c7 05 f8 18 00 00 00 	movl   $0x0,0x18f8
    1256:	00 00 00 
    1259:	e9 3e ff ff ff       	jmp    119c <malloc+0x2c>
