
_directoryWalker:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bb 01 00 00 00       	mov    $0x1,%ebx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 1f                	jle    42 <main+0x42>
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    directoryWalker(".");
    exit();
  }
  for(i=1; i<argc; i++)
    directoryWalker(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	pushl  (%edi,%ebx,4)

  if(argc < 2){
    directoryWalker(".");
    exit();
  }
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    directoryWalker(argv[i]);
  31:	e8 2a 00 00 00       	call   60 <directoryWalker>

  if(argc < 2){
    directoryWalker(".");
    exit();
  }
  for(i=1; i<argc; i++)
  36:	83 c4 10             	add    $0x10,%esp
  39:	39 de                	cmp    %ebx,%esi
  3b:	75 eb                	jne    28 <main+0x28>
    directoryWalker(argv[i]);
  
  exit();
  3d:	e8 40 04 00 00       	call   482 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    directoryWalker(".");
  42:	83 ec 0c             	sub    $0xc,%esp
  45:	68 6c 09 00 00       	push   $0x96c
  4a:	e8 11 00 00 00       	call   60 <directoryWalker>
    exit();
  4f:	e8 2e 04 00 00       	call   482 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <directoryWalker>:
#include "user.h"
#include "fs.h"



void directoryWalker(char* path){
  60:	55                   	push   %ebp
    char buf[512] = {0};
  61:	31 c0                	xor    %eax,%eax
  63:	b9 80 00 00 00       	mov    $0x80,%ecx
#include "user.h"
#include "fs.h"



void directoryWalker(char* path){
  68:	89 e5                	mov    %esp,%ebp
  6a:	57                   	push   %edi
  6b:	56                   	push   %esi
  6c:	53                   	push   %ebx
    char buf[512] = {0};
  6d:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
#include "user.h"
#include "fs.h"



void directoryWalker(char* path){
  73:	81 ec 60 02 00 00    	sub    $0x260,%esp
  79:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char buf[512] = {0};
  7c:	89 f7                	mov    %esi,%edi
  7e:	f3 ab                	rep stos %eax,%es:(%edi)
    char *p;
    int fd;
    struct dirent de;
    struct stat st;

    printf(1, "DEBUG PATH: %s\n", path);
  80:	53                   	push   %ebx
  81:	68 20 09 00 00       	push   $0x920
  86:	6a 01                	push   $0x1
  88:	e8 73 05 00 00       	call   600 <printf>

    if((fd = open(path, 0)) < 0){
  8d:	58                   	pop    %eax
  8e:	5a                   	pop    %edx
  8f:	6a 00                	push   $0x0
  91:	53                   	push   %ebx
  92:	e8 2b 04 00 00       	call   4c2 <open>
  97:	83 c4 10             	add    $0x10,%esp
  9a:	85 c0                	test   %eax,%eax
  9c:	78 52                	js     f0 <directoryWalker+0x90>
  9e:	89 c7                	mov    %eax,%edi
        printf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
  a0:	8d 85 b4 fd ff ff    	lea    -0x24c(%ebp),%eax
  a6:	83 ec 08             	sub    $0x8,%esp
  a9:	50                   	push   %eax
  aa:	57                   	push   %edi
  ab:	e8 2a 04 00 00       	call   4da <fstat>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	85 c0                	test   %eax,%eax
  b5:	0f 88 45 01 00 00    	js     200 <directoryWalker+0x1a0>
        printf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    if(st.type != T_DIR){
  bb:	66 83 bd b4 fd ff ff 	cmpw   $0x1,-0x24c(%ebp)
  c2:	01 
  c3:	74 4b                	je     110 <directoryWalker+0xb0>
        printf(1, "Filename: %s \n inode number: %d\n", path, st.ino);
  c5:	ff b5 bc fd ff ff    	pushl  -0x244(%ebp)
  cb:	53                   	push   %ebx
  cc:	68 88 09 00 00       	push   $0x988
  d1:	6a 01                	push   $0x1
  d3:	e8 28 05 00 00       	call   600 <printf>
        close(fd);
  d8:	89 3c 24             	mov    %edi,(%esp)
  db:	e8 ca 03 00 00       	call   4aa <close>
        return;
  e0:	83 c4 10             	add    $0x10,%esp
        directoryWalker(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}
  e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  e6:	5b                   	pop    %ebx
  e7:	5e                   	pop    %esi
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct stat st;

    printf(1, "DEBUG PATH: %s\n", path);

    if((fd = open(path, 0)) < 0){
        printf(2, "ls: cannot open %s\n", path);
  f0:	83 ec 04             	sub    $0x4,%esp
  f3:	53                   	push   %ebx
  f4:	68 30 09 00 00       	push   $0x930
  f9:	6a 02                	push   $0x2
  fb:	e8 00 05 00 00       	call   600 <printf>
        return;
 100:	83 c4 10             	add    $0x10,%esp
        directoryWalker(buf);
        p[DIRSIZ] = 0;
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
    }
    
}
 103:	8d 65 f4             	lea    -0xc(%ebp),%esp
 106:	5b                   	pop    %ebx
 107:	5e                   	pop    %esi
 108:	5f                   	pop    %edi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	90                   	nop
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return;
    }
    

    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 110:	83 ec 0c             	sub    $0xc,%esp
 113:	53                   	push   %ebx
 114:	e8 a7 01 00 00       	call   2c0 <strlen>
 119:	83 c0 20             	add    $0x20,%eax
 11c:	83 c4 10             	add    $0x10,%esp
 11f:	3d 00 02 00 00       	cmp    $0x200,%eax
 124:	0f 87 f6 00 00 00    	ja     220 <directoryWalker+0x1c0>
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
 12a:	83 ec 08             	sub    $0x8,%esp
 12d:	53                   	push   %ebx
 12e:	56                   	push   %esi
 12f:	8d 9d c8 fd ff ff    	lea    -0x238(%ebp),%ebx
 135:	e8 06 01 00 00       	call   240 <strcpy>
    p = buf+strlen(buf);
 13a:	89 34 24             	mov    %esi,(%esp)
 13d:	e8 7e 01 00 00       	call   2c0 <strlen>
 142:	8d 14 06             	lea    (%esi,%eax,1),%edx
    *p++ = '/';
 145:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 149:	83 c4 10             	add    $0x10,%esp
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
    }

    strcpy(buf, path);
    p = buf+strlen(buf);
 14c:	89 95 a4 fd ff ff    	mov    %edx,-0x25c(%ebp)
    *p++ = '/';
 152:	89 85 a0 fd ff ff    	mov    %eax,-0x260(%ebp)
 158:	c6 02 2f             	movb   $0x2f,(%edx)
 15b:	90                   	nop
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 20                	push   $0x20
 165:	53                   	push   %ebx
 166:	57                   	push   %edi
 167:	e8 2e 03 00 00       	call   49a <read>
 16c:	83 c4 10             	add    $0x10,%esp
 16f:	83 f8 20             	cmp    $0x20,%eax
 172:	0f 85 6b ff ff ff    	jne    e3 <directoryWalker+0x83>
        if(de.inum == 0)
 178:	66 83 bd c8 fd ff ff 	cmpw   $0x0,-0x238(%ebp)
 17f:	00 
 180:	74 de                	je     160 <directoryWalker+0x100>
            continue;

        if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;
 182:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 188:	83 ec 08             	sub    $0x8,%esp
 18b:	68 6c 09 00 00       	push   $0x96c
 190:	50                   	push   %eax
 191:	e8 da 00 00 00       	call   270 <strcmp>
 196:	83 c4 10             	add    $0x10,%esp
 199:	85 c0                	test   %eax,%eax
 19b:	74 c3                	je     160 <directoryWalker+0x100>
 19d:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 1a3:	83 ec 08             	sub    $0x8,%esp
 1a6:	68 6b 09 00 00       	push   $0x96b
 1ab:	50                   	push   %eax
 1ac:	e8 bf 00 00 00       	call   270 <strcmp>
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	85 c0                	test   %eax,%eax
 1b6:	74 a8                	je     160 <directoryWalker+0x100>

        memmove(p, de.name, DIRSIZ);
 1b8:	8d 85 ca fd ff ff    	lea    -0x236(%ebp),%eax
 1be:	83 ec 04             	sub    $0x4,%esp
 1c1:	6a 1e                	push   $0x1e
 1c3:	50                   	push   %eax
 1c4:	ff b5 a0 fd ff ff    	pushl  -0x260(%ebp)
 1ca:	e8 81 02 00 00       	call   450 <memmove>
        directoryWalker(buf);
 1cf:	89 34 24             	mov    %esi,(%esp)
 1d2:	e8 89 fe ff ff       	call   60 <directoryWalker>
        p[DIRSIZ] = 0;
 1d7:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 1dd:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
        printf(1, "inum: %d\ndir name: %s\n", de.inum, buf);
 1e1:	0f b7 85 c8 fd ff ff 	movzwl -0x238(%ebp),%eax
 1e8:	56                   	push   %esi
 1e9:	50                   	push   %eax
 1ea:	68 6e 09 00 00       	push   $0x96e
 1ef:	6a 01                	push   $0x1
 1f1:	e8 0a 04 00 00       	call   600 <printf>
 1f6:	83 c4 20             	add    $0x20,%esp
 1f9:	e9 62 ff ff ff       	jmp    160 <directoryWalker+0x100>
 1fe:	66 90                	xchg   %ax,%ax
        printf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        printf(2, "ls: cannot stat %s\n", path);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	53                   	push   %ebx
 204:	68 44 09 00 00       	push   $0x944
 209:	6a 02                	push   $0x2
 20b:	e8 f0 03 00 00       	call   600 <printf>
        close(fd);
 210:	89 3c 24             	mov    %edi,(%esp)
 213:	e8 92 02 00 00       	call   4aa <close>
        return;
 218:	83 c4 10             	add    $0x10,%esp
 21b:	e9 c3 fe ff ff       	jmp    e3 <directoryWalker+0x83>
    }
    

    
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf(1, "ls: path too long\n");
 220:	83 ec 08             	sub    $0x8,%esp
 223:	68 58 09 00 00       	push   $0x958
 228:	6a 01                	push   $0x1
 22a:	e8 d1 03 00 00       	call   600 <printf>
 22f:	83 c4 10             	add    $0x10,%esp
 232:	e9 f3 fe ff ff       	jmp    12a <directoryWalker+0xca>
 237:	66 90                	xchg   %ax,%ax
 239:	66 90                	xchg   %ax,%ax
 23b:	66 90                	xchg   %ax,%ax
 23d:	66 90                	xchg   %ax,%ax
 23f:	90                   	nop

00000240 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 24a:	89 c2                	mov    %eax,%edx
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 250:	83 c1 01             	add    $0x1,%ecx
 253:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 257:	83 c2 01             	add    $0x1,%edx
 25a:	84 db                	test   %bl,%bl
 25c:	88 5a ff             	mov    %bl,-0x1(%edx)
 25f:	75 ef                	jne    250 <strcpy+0x10>
    ;
  return os;
}
 261:	5b                   	pop    %ebx
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	8b 55 08             	mov    0x8(%ebp),%edx
 278:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 27b:	0f b6 02             	movzbl (%edx),%eax
 27e:	0f b6 19             	movzbl (%ecx),%ebx
 281:	84 c0                	test   %al,%al
 283:	75 1e                	jne    2a3 <strcmp+0x33>
 285:	eb 29                	jmp    2b0 <strcmp+0x40>
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 290:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 293:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 296:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 299:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 29d:	84 c0                	test   %al,%al
 29f:	74 0f                	je     2b0 <strcmp+0x40>
 2a1:	89 f1                	mov    %esi,%ecx
 2a3:	38 d8                	cmp    %bl,%al
 2a5:	74 e9                	je     290 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2a7:	29 d8                	sub    %ebx,%eax
}
 2a9:	5b                   	pop    %ebx
 2aa:	5e                   	pop    %esi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2b2:	29 d8                	sub    %ebx,%eax
}
 2b4:	5b                   	pop    %ebx
 2b5:	5e                   	pop    %esi
 2b6:	5d                   	pop    %ebp
 2b7:	c3                   	ret    
 2b8:	90                   	nop
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strlen>:

uint
strlen(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2c6:	80 39 00             	cmpb   $0x0,(%ecx)
 2c9:	74 12                	je     2dd <strlen+0x1d>
 2cb:	31 d2                	xor    %edx,%edx
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2d7:	89 d0                	mov    %edx,%eax
 2d9:	75 f5                	jne    2d0 <strlen+0x10>
    ;
  return n;
}
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 2dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 2df:	5d                   	pop    %ebp
 2e0:	c3                   	ret    
 2e1:	eb 0d                	jmp    2f0 <memset>
 2e3:	90                   	nop
 2e4:	90                   	nop
 2e5:	90                   	nop
 2e6:	90                   	nop
 2e7:	90                   	nop
 2e8:	90                   	nop
 2e9:	90                   	nop
 2ea:	90                   	nop
 2eb:	90                   	nop
 2ec:	90                   	nop
 2ed:	90                   	nop
 2ee:	90                   	nop
 2ef:	90                   	nop

000002f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fd:	89 d7                	mov    %edx,%edi
 2ff:	fc                   	cld    
 300:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 302:	89 d0                	mov    %edx,%eax
 304:	5f                   	pop    %edi
 305:	5d                   	pop    %ebp
 306:	c3                   	ret    
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <strchr>:

char*
strchr(const char *s, char c)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	53                   	push   %ebx
 314:	8b 45 08             	mov    0x8(%ebp),%eax
 317:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 31a:	0f b6 10             	movzbl (%eax),%edx
 31d:	84 d2                	test   %dl,%dl
 31f:	74 1d                	je     33e <strchr+0x2e>
    if(*s == c)
 321:	38 d3                	cmp    %dl,%bl
 323:	89 d9                	mov    %ebx,%ecx
 325:	75 0d                	jne    334 <strchr+0x24>
 327:	eb 17                	jmp    340 <strchr+0x30>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 330:	38 ca                	cmp    %cl,%dl
 332:	74 0c                	je     340 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 334:	83 c0 01             	add    $0x1,%eax
 337:	0f b6 10             	movzbl (%eax),%edx
 33a:	84 d2                	test   %dl,%dl
 33c:	75 f2                	jne    330 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 33e:	31 c0                	xor    %eax,%eax
}
 340:	5b                   	pop    %ebx
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
 343:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <gets>:

char*
gets(char *buf, int max)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 356:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 358:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 35b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35e:	eb 29                	jmp    389 <gets+0x39>
    cc = read(0, &c, 1);
 360:	83 ec 04             	sub    $0x4,%esp
 363:	6a 01                	push   $0x1
 365:	57                   	push   %edi
 366:	6a 00                	push   $0x0
 368:	e8 2d 01 00 00       	call   49a <read>
    if(cc < 1)
 36d:	83 c4 10             	add    $0x10,%esp
 370:	85 c0                	test   %eax,%eax
 372:	7e 1d                	jle    391 <gets+0x41>
      break;
    buf[i++] = c;
 374:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 378:	8b 55 08             	mov    0x8(%ebp),%edx
 37b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 37d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 37f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 383:	74 1b                	je     3a0 <gets+0x50>
 385:	3c 0d                	cmp    $0xd,%al
 387:	74 17                	je     3a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 389:	8d 5e 01             	lea    0x1(%esi),%ebx
 38c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 38f:	7c cf                	jl     360 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 391:	8b 45 08             	mov    0x8(%ebp),%eax
 394:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 398:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39b:	5b                   	pop    %ebx
 39c:	5e                   	pop    %esi
 39d:	5f                   	pop    %edi
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    
 3b1:	eb 0d                	jmp    3c0 <stat>
 3b3:	90                   	nop
 3b4:	90                   	nop
 3b5:	90                   	nop
 3b6:	90                   	nop
 3b7:	90                   	nop
 3b8:	90                   	nop
 3b9:	90                   	nop
 3ba:	90                   	nop
 3bb:	90                   	nop
 3bc:	90                   	nop
 3bd:	90                   	nop
 3be:	90                   	nop
 3bf:	90                   	nop

000003c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c5:	83 ec 08             	sub    $0x8,%esp
 3c8:	6a 00                	push   $0x0
 3ca:	ff 75 08             	pushl  0x8(%ebp)
 3cd:	e8 f0 00 00 00       	call   4c2 <open>
  if(fd < 0)
 3d2:	83 c4 10             	add    $0x10,%esp
 3d5:	85 c0                	test   %eax,%eax
 3d7:	78 27                	js     400 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3d9:	83 ec 08             	sub    $0x8,%esp
 3dc:	ff 75 0c             	pushl  0xc(%ebp)
 3df:	89 c3                	mov    %eax,%ebx
 3e1:	50                   	push   %eax
 3e2:	e8 f3 00 00 00       	call   4da <fstat>
 3e7:	89 c6                	mov    %eax,%esi
  close(fd);
 3e9:	89 1c 24             	mov    %ebx,(%esp)
 3ec:	e8 b9 00 00 00       	call   4aa <close>
  return r;
 3f1:	83 c4 10             	add    $0x10,%esp
 3f4:	89 f0                	mov    %esi,%eax
}
 3f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3f9:	5b                   	pop    %ebx
 3fa:	5e                   	pop    %esi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 405:	eb ef                	jmp    3f6 <stat+0x36>
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 417:	0f be 11             	movsbl (%ecx),%edx
 41a:	8d 42 d0             	lea    -0x30(%edx),%eax
 41d:	3c 09                	cmp    $0x9,%al
 41f:	b8 00 00 00 00       	mov    $0x0,%eax
 424:	77 1f                	ja     445 <atoi+0x35>
 426:	8d 76 00             	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 430:	8d 04 80             	lea    (%eax,%eax,4),%eax
 433:	83 c1 01             	add    $0x1,%ecx
 436:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43a:	0f be 11             	movsbl (%ecx),%edx
 43d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 440:	80 fb 09             	cmp    $0x9,%bl
 443:	76 eb                	jbe    430 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 445:	5b                   	pop    %ebx
 446:	5d                   	pop    %ebp
 447:	c3                   	ret    
 448:	90                   	nop
 449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000450 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
 455:	8b 5d 10             	mov    0x10(%ebp),%ebx
 458:	8b 45 08             	mov    0x8(%ebp),%eax
 45b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 45e:	85 db                	test   %ebx,%ebx
 460:	7e 14                	jle    476 <memmove+0x26>
 462:	31 d2                	xor    %edx,%edx
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 468:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 46c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 46f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 472:	39 da                	cmp    %ebx,%edx
 474:	75 f2                	jne    468 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 476:	5b                   	pop    %ebx
 477:	5e                   	pop    %esi
 478:	5d                   	pop    %ebp
 479:	c3                   	ret    

0000047a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 47a:	b8 01 00 00 00       	mov    $0x1,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <exit>:
SYSCALL(exit)
 482:	b8 02 00 00 00       	mov    $0x2,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <wait>:
SYSCALL(wait)
 48a:	b8 03 00 00 00       	mov    $0x3,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <pipe>:
SYSCALL(pipe)
 492:	b8 04 00 00 00       	mov    $0x4,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <read>:
SYSCALL(read)
 49a:	b8 05 00 00 00       	mov    $0x5,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <write>:
SYSCALL(write)
 4a2:	b8 10 00 00 00       	mov    $0x10,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <close>:
SYSCALL(close)
 4aa:	b8 15 00 00 00       	mov    $0x15,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <kill>:
SYSCALL(kill)
 4b2:	b8 06 00 00 00       	mov    $0x6,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <exec>:
SYSCALL(exec)
 4ba:	b8 07 00 00 00       	mov    $0x7,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <open>:
SYSCALL(open)
 4c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <mknod>:
SYSCALL(mknod)
 4ca:	b8 11 00 00 00       	mov    $0x11,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <unlink>:
SYSCALL(unlink)
 4d2:	b8 12 00 00 00       	mov    $0x12,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <fstat>:
SYSCALL(fstat)
 4da:	b8 08 00 00 00       	mov    $0x8,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <link>:
SYSCALL(link)
 4e2:	b8 13 00 00 00       	mov    $0x13,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <mkdir>:
SYSCALL(mkdir)
 4ea:	b8 14 00 00 00       	mov    $0x14,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <chdir>:
SYSCALL(chdir)
 4f2:	b8 09 00 00 00       	mov    $0x9,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <dup>:
SYSCALL(dup)
 4fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <getpid>:
SYSCALL(getpid)
 502:	b8 0b 00 00 00       	mov    $0xb,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <sbrk>:
SYSCALL(sbrk)
 50a:	b8 0c 00 00 00       	mov    $0xc,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <sleep>:
SYSCALL(sleep)
 512:	b8 0d 00 00 00       	mov    $0xd,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <uptime>:
SYSCALL(uptime)
 51a:	b8 0e 00 00 00       	mov    $0xe,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <countTrap>:
SYSCALL(countTrap)
 522:	b8 16 00 00 00       	mov    $0x16,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <getSharedPage>:
SYSCALL(getSharedPage)
 52a:	b8 17 00 00 00       	mov    $0x17,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <freeSharedPage>:
SYSCALL(freeSharedPage)
 532:	b8 18 00 00 00       	mov    $0x18,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <callBRead>:
SYSCALL(callBRead)
 53a:	b8 19 00 00 00       	mov    $0x19,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <callSBRead>:
SYSCALL(callSBRead)
 542:	b8 1a 00 00 00       	mov    $0x1a,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <seek>:
SYSCALL(seek)
 54a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <callBWrite>:
 552:	b8 1c 00 00 00       	mov    $0x1c,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    
 55a:	66 90                	xchg   %ax,%ax
 55c:	66 90                	xchg   %ax,%ax
 55e:	66 90                	xchg   %ax,%ax

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	89 c6                	mov    %eax,%esi
 568:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 56b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 56e:	85 db                	test   %ebx,%ebx
 570:	74 7e                	je     5f0 <printint+0x90>
 572:	89 d0                	mov    %edx,%eax
 574:	c1 e8 1f             	shr    $0x1f,%eax
 577:	84 c0                	test   %al,%al
 579:	74 75                	je     5f0 <printint+0x90>
    neg = 1;
    x = -xx;
 57b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 57d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 584:	f7 d8                	neg    %eax
 586:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 589:	31 ff                	xor    %edi,%edi
 58b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 58e:	89 ce                	mov    %ecx,%esi
 590:	eb 08                	jmp    59a <printint+0x3a>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 598:	89 cf                	mov    %ecx,%edi
 59a:	31 d2                	xor    %edx,%edx
 59c:	8d 4f 01             	lea    0x1(%edi),%ecx
 59f:	f7 f6                	div    %esi
 5a1:	0f b6 92 b4 09 00 00 	movzbl 0x9b4(%edx),%edx
  }while((x /= base) != 0);
 5a8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5ad:	75 e9                	jne    598 <printint+0x38>
  if(neg)
 5af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5b5:	85 c0                	test   %eax,%eax
 5b7:	74 08                	je     5c1 <printint+0x61>
    buf[i++] = '-';
 5b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5be:	8d 4f 02             	lea    0x2(%edi),%ecx
 5c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
 5c8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	83 ef 01             	sub    $0x1,%edi
 5d1:	6a 01                	push   $0x1
 5d3:	53                   	push   %ebx
 5d4:	56                   	push   %esi
 5d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 5d8:	e8 c5 fe ff ff       	call   4a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	39 df                	cmp    %ebx,%edi
 5e2:	75 e4                	jne    5c8 <printint+0x68>
    putc(fd, buf[i]);
}
 5e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e7:	5b                   	pop    %ebx
 5e8:	5e                   	pop    %esi
 5e9:	5f                   	pop    %edi
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5f9:	eb 8b                	jmp    586 <printint+0x26>
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 606:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 609:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 60c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 60f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 612:	89 45 d0             	mov    %eax,-0x30(%ebp)
 615:	0f b6 1e             	movzbl (%esi),%ebx
 618:	83 c6 01             	add    $0x1,%esi
 61b:	84 db                	test   %bl,%bl
 61d:	0f 84 b0 00 00 00    	je     6d3 <printf+0xd3>
 623:	31 d2                	xor    %edx,%edx
 625:	eb 39                	jmp    660 <printf+0x60>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 630:	83 f8 25             	cmp    $0x25,%eax
 633:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 636:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 63b:	74 18                	je     655 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 646:	6a 01                	push   $0x1
 648:	50                   	push   %eax
 649:	57                   	push   %edi
 64a:	e8 53 fe ff ff       	call   4a2 <write>
 64f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 652:	83 c4 10             	add    $0x10,%esp
 655:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 658:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 65c:	84 db                	test   %bl,%bl
 65e:	74 73                	je     6d3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 660:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 662:	0f be cb             	movsbl %bl,%ecx
 665:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 668:	74 c6                	je     630 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 66a:	83 fa 25             	cmp    $0x25,%edx
 66d:	75 e6                	jne    655 <printf+0x55>
      if(c == 'd'){
 66f:	83 f8 64             	cmp    $0x64,%eax
 672:	0f 84 f8 00 00 00    	je     770 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 678:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 67e:	83 f9 70             	cmp    $0x70,%ecx
 681:	74 5d                	je     6e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 683:	83 f8 73             	cmp    $0x73,%eax
 686:	0f 84 84 00 00 00    	je     710 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 68c:	83 f8 63             	cmp    $0x63,%eax
 68f:	0f 84 ea 00 00 00    	je     77f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 695:	83 f8 25             	cmp    $0x25,%eax
 698:	0f 84 c2 00 00 00    	je     760 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6a1:	83 ec 04             	sub    $0x4,%esp
 6a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6a8:	6a 01                	push   $0x1
 6aa:	50                   	push   %eax
 6ab:	57                   	push   %edi
 6ac:	e8 f1 fd ff ff       	call   4a2 <write>
 6b1:	83 c4 0c             	add    $0xc,%esp
 6b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ba:	6a 01                	push   $0x1
 6bc:	50                   	push   %eax
 6bd:	57                   	push   %edi
 6be:	83 c6 01             	add    $0x1,%esi
 6c1:	e8 dc fd ff ff       	call   4a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6cd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6cf:	84 db                	test   %bl,%bl
 6d1:	75 8d                	jne    660 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d6:	5b                   	pop    %ebx
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6e8:	6a 00                	push   $0x0
 6ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6ed:	89 f8                	mov    %edi,%eax
 6ef:	8b 13                	mov    (%ebx),%edx
 6f1:	e8 6a fe ff ff       	call   560 <printint>
        ap++;
 6f6:	89 d8                	mov    %ebx,%eax
 6f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 d0             	mov    %eax,-0x30(%ebp)
 703:	e9 4d ff ff ff       	jmp    655 <printf+0x55>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 710:	8b 45 d0             	mov    -0x30(%ebp),%eax
 713:	8b 18                	mov    (%eax),%ebx
        ap++;
 715:	83 c0 04             	add    $0x4,%eax
 718:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 71b:	b8 ac 09 00 00       	mov    $0x9ac,%eax
 720:	85 db                	test   %ebx,%ebx
 722:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 725:	0f b6 03             	movzbl (%ebx),%eax
 728:	84 c0                	test   %al,%al
 72a:	74 23                	je     74f <printf+0x14f>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 730:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 733:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 736:	83 ec 04             	sub    $0x4,%esp
 739:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 73b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73e:	50                   	push   %eax
 73f:	57                   	push   %edi
 740:	e8 5d fd ff ff       	call   4a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 745:	0f b6 03             	movzbl (%ebx),%eax
 748:	83 c4 10             	add    $0x10,%esp
 74b:	84 c0                	test   %al,%al
 74d:	75 e1                	jne    730 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74f:	31 d2                	xor    %edx,%edx
 751:	e9 ff fe ff ff       	jmp    655 <printf+0x55>
 756:	8d 76 00             	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
 763:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 766:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 769:	6a 01                	push   $0x1
 76b:	e9 4c ff ff ff       	jmp    6bc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 770:	83 ec 0c             	sub    $0xc,%esp
 773:	b9 0a 00 00 00       	mov    $0xa,%ecx
 778:	6a 01                	push   $0x1
 77a:	e9 6b ff ff ff       	jmp    6ea <printf+0xea>
 77f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 782:	83 ec 04             	sub    $0x4,%esp
 785:	8b 03                	mov    (%ebx),%eax
 787:	6a 01                	push   $0x1
 789:	88 45 e4             	mov    %al,-0x1c(%ebp)
 78c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 78f:	50                   	push   %eax
 790:	57                   	push   %edi
 791:	e8 0c fd ff ff       	call   4a2 <write>
 796:	e9 5b ff ff ff       	jmp    6f6 <printf+0xf6>
 79b:	66 90                	xchg   %ax,%ax
 79d:	66 90                	xchg   %ax,%ax
 79f:	90                   	nop

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 98 0c 00 00       	mov    0xc98,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 c8                	cmp    %ecx,%eax
 7b5:	73 19                	jae    7d0 <free+0x30>
 7b7:	89 f6                	mov    %esi,%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7c0:	39 d1                	cmp    %edx,%ecx
 7c2:	72 1c                	jb     7e0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	39 d0                	cmp    %edx,%eax
 7c6:	73 18                	jae    7e0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	72 f0                	jb     7c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 d0                	cmp    %edx,%eax
 7d2:	72 f4                	jb     7c8 <free+0x28>
 7d4:	39 d1                	cmp    %edx,%ecx
 7d6:	73 f0                	jae    7c8 <free+0x28>
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7e6:	39 d7                	cmp    %edx,%edi
 7e8:	74 19                	je     803 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	74 23                	je     81a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7f9:	a3 98 0c 00 00       	mov    %eax,0xc98
}
 7fe:	5b                   	pop    %ebx
 7ff:	5e                   	pop    %esi
 800:	5f                   	pop    %edi
 801:	5d                   	pop    %ebp
 802:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 803:	03 72 04             	add    0x4(%edx),%esi
 806:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 809:	8b 10                	mov    (%eax),%edx
 80b:	8b 12                	mov    (%edx),%edx
 80d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 816:	39 f1                	cmp    %esi,%ecx
 818:	75 dd                	jne    7f7 <free+0x57>
    p->s.size += bp->s.size;
 81a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 81d:	a3 98 0c 00 00       	mov    %eax,0xc98
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 822:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 825:	8b 53 f8             	mov    -0x8(%ebx),%edx
 828:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 82a:	5b                   	pop    %ebx
 82b:	5e                   	pop    %esi
 82c:	5f                   	pop    %edi
 82d:	5d                   	pop    %ebp
 82e:	c3                   	ret    
 82f:	90                   	nop

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 15 98 0c 00 00    	mov    0xc98,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	8d 78 07             	lea    0x7(%eax),%edi
 845:	c1 ef 03             	shr    $0x3,%edi
 848:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 84b:	85 d2                	test   %edx,%edx
 84d:	0f 84 a3 00 00 00    	je     8f6 <malloc+0xc6>
 853:	8b 02                	mov    (%edx),%eax
 855:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 858:	39 cf                	cmp    %ecx,%edi
 85a:	76 74                	jbe    8d0 <malloc+0xa0>
 85c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 862:	be 00 10 00 00       	mov    $0x1000,%esi
 867:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 86e:	0f 43 f7             	cmovae %edi,%esi
 871:	ba 00 80 00 00       	mov    $0x8000,%edx
 876:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 87c:	0f 46 da             	cmovbe %edx,%ebx
 87f:	eb 10                	jmp    891 <malloc+0x61>
 881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 88a:	8b 48 04             	mov    0x4(%eax),%ecx
 88d:	39 cf                	cmp    %ecx,%edi
 88f:	76 3f                	jbe    8d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	39 05 98 0c 00 00    	cmp    %eax,0xc98
 897:	89 c2                	mov    %eax,%edx
 899:	75 ed                	jne    888 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 89b:	83 ec 0c             	sub    $0xc,%esp
 89e:	53                   	push   %ebx
 89f:	e8 66 fc ff ff       	call   50a <sbrk>
  if(p == (char*)-1)
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8aa:	74 1c                	je     8c8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8ac:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8af:	83 ec 0c             	sub    $0xc,%esp
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	50                   	push   %eax
 8b6:	e8 e5 fe ff ff       	call   7a0 <free>
  return freep;
 8bb:	8b 15 98 0c 00 00    	mov    0xc98,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8c1:	83 c4 10             	add    $0x10,%esp
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 c0                	jne    888 <malloc+0x58>
        return 0;
 8c8:	31 c0                	xor    %eax,%eax
 8ca:	eb 1c                	jmp    8e8 <malloc+0xb8>
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 8d0:	39 cf                	cmp    %ecx,%edi
 8d2:	74 1c                	je     8f0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8d4:	29 f9                	sub    %edi,%ecx
 8d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8dc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 8df:	89 15 98 0c 00 00    	mov    %edx,0xc98
      return (void*)(p + 1);
 8e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8eb:	5b                   	pop    %ebx
 8ec:	5e                   	pop    %esi
 8ed:	5f                   	pop    %edi
 8ee:	5d                   	pop    %ebp
 8ef:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb e9                	jmp    8df <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8f6:	c7 05 98 0c 00 00 9c 	movl   $0xc9c,0xc98
 8fd:	0c 00 00 
 900:	c7 05 9c 0c 00 00 9c 	movl   $0xc9c,0xc9c
 907:	0c 00 00 
    base.s.size = 0;
 90a:	b8 9c 0c 00 00       	mov    $0xc9c,%eax
 90f:	c7 05 a0 0c 00 00 00 	movl   $0x0,0xca0
 916:	00 00 00 
 919:	e9 3e ff ff ff       	jmp    85c <malloc+0x2c>
