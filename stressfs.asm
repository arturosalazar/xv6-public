
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   c:	ff 71 fc             	pushl  -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  16:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi

  for(i = 0; i < 4; i++)
  1c:	31 db                	xor    %ebx,%ebx
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  2b:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  32:	74 72 65 
  char data[512];

  printf(1, "stressfs starting\n");
  35:	68 20 08 00 00       	push   $0x820
  3a:	6a 01                	push   $0x1

int
main(int argc, char *argv[])
{
  int fd, i;
  char path[] = "stressfs0";
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  char data[512];

  printf(1, "stressfs starting\n");
  46:	e8 b5 04 00 00       	call   500 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 95 01 00 00       	call   1f0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
    if(fork() > 0)
  5e:	e8 17 03 00 00       	call   37a <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx
  7c:	68 33 08 00 00       	push   $0x833

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  81:	bb 14 00 00 00       	mov    $0x14,%ebx

  for(i = 0; i < 4; i++)
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  86:	6a 01                	push   $0x1
  88:	e8 73 04 00 00       	call   500 <printf>

  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  8f:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	5f                   	pop    %edi
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 1a 03 00 00       	call   3c2 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 e3 02 00 00       	call   3a2 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 da 02 00 00       	call   3aa <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 3d 08 00 00       	push   $0x83d
  d7:	6a 01                	push   $0x1
  d9:	e8 22 04 00 00       	call   500 <printf>

  fd = open(path, O_RDONLY);
  de:	59                   	pop    %ecx
  df:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	50                   	push   %eax
  e9:	bb 14 00 00 00       	mov    $0x14,%ebx
  ee:	e8 cf 02 00 00       	call   3c2 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 8b 02 00 00       	call   39a <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
    read(fd, data, sizeof(data));
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 8a 02 00 00       	call   3aa <close>

  wait();
 120:	e8 65 02 00 00       	call   38a <wait>

  exit();
 125:	e8 58 02 00 00       	call   382 <exit>
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 55 08             	mov    0x8(%ebp),%edx
 178:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17b:	0f b6 02             	movzbl (%edx),%eax
 17e:	0f b6 19             	movzbl (%ecx),%ebx
 181:	84 c0                	test   %al,%al
 183:	75 1e                	jne    1a3 <strcmp+0x33>
 185:	eb 29                	jmp    1b0 <strcmp+0x40>
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 190:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 193:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 196:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 199:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 19d:	84 c0                	test   %al,%al
 19f:	74 0f                	je     1b0 <strcmp+0x40>
 1a1:	89 f1                	mov    %esi,%ecx
 1a3:	38 d8                	cmp    %bl,%al
 1a5:	74 e9                	je     190 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a7:	29 d8                	sub    %ebx,%eax
}
 1a9:	5b                   	pop    %ebx
 1aa:	5e                   	pop    %esi
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1b2:	29 d8                	sub    %ebx,%eax
}
 1b4:	5b                   	pop    %ebx
 1b5:	5e                   	pop    %esi
 1b6:	5d                   	pop    %ebp
 1b7:	c3                   	ret    
 1b8:	90                   	nop
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 12                	je     1dd <strlen+0x1d>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    
 1e1:	eb 0d                	jmp    1f0 <memset>
 1e3:	90                   	nop
 1e4:	90                   	nop
 1e5:	90                   	nop
 1e6:	90                   	nop
 1e7:	90                   	nop
 1e8:	90                   	nop
 1e9:	90                   	nop
 1ea:	90                   	nop
 1eb:	90                   	nop
 1ec:	90                   	nop
 1ed:	90                   	nop
 1ee:	90                   	nop
 1ef:	90                   	nop

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
    if(*s == c)
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 258:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 25b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25e:	eb 29                	jmp    289 <gets+0x39>
    cc = read(0, &c, 1);
 260:	83 ec 04             	sub    $0x4,%esp
 263:	6a 01                	push   $0x1
 265:	57                   	push   %edi
 266:	6a 00                	push   $0x0
 268:	e8 2d 01 00 00       	call   39a <read>
    if(cc < 1)
 26d:	83 c4 10             	add    $0x10,%esp
 270:	85 c0                	test   %eax,%eax
 272:	7e 1d                	jle    291 <gets+0x41>
      break;
    buf[i++] = c;
 274:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 27d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 27f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 283:	74 1b                	je     2a0 <gets+0x50>
 285:	3c 0d                	cmp    $0xd,%al
 287:	74 17                	je     2a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 289:	8d 5e 01             	lea    0x1(%esi),%ebx
 28c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 28f:	7c cf                	jl     260 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 298:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29b:	5b                   	pop    %ebx
 29c:	5e                   	pop    %esi
 29d:	5f                   	pop    %edi
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ac:	5b                   	pop    %ebx
 2ad:	5e                   	pop    %esi
 2ae:	5f                   	pop    %edi
 2af:	5d                   	pop    %ebp
 2b0:	c3                   	ret    
 2b1:	eb 0d                	jmp    2c0 <stat>
 2b3:	90                   	nop
 2b4:	90                   	nop
 2b5:	90                   	nop
 2b6:	90                   	nop
 2b7:	90                   	nop
 2b8:	90                   	nop
 2b9:	90                   	nop
 2ba:	90                   	nop
 2bb:	90                   	nop
 2bc:	90                   	nop
 2bd:	90                   	nop
 2be:	90                   	nop
 2bf:	90                   	nop

000002c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	56                   	push   %esi
 2c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c5:	83 ec 08             	sub    $0x8,%esp
 2c8:	6a 00                	push   $0x0
 2ca:	ff 75 08             	pushl  0x8(%ebp)
 2cd:	e8 f0 00 00 00       	call   3c2 <open>
  if(fd < 0)
 2d2:	83 c4 10             	add    $0x10,%esp
 2d5:	85 c0                	test   %eax,%eax
 2d7:	78 27                	js     300 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2d9:	83 ec 08             	sub    $0x8,%esp
 2dc:	ff 75 0c             	pushl  0xc(%ebp)
 2df:	89 c3                	mov    %eax,%ebx
 2e1:	50                   	push   %eax
 2e2:	e8 f3 00 00 00       	call   3da <fstat>
 2e7:	89 c6                	mov    %eax,%esi
  close(fd);
 2e9:	89 1c 24             	mov    %ebx,(%esp)
 2ec:	e8 b9 00 00 00       	call   3aa <close>
  return r;
 2f1:	83 c4 10             	add    $0x10,%esp
 2f4:	89 f0                	mov    %esi,%eax
}
 2f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2f9:	5b                   	pop    %ebx
 2fa:	5e                   	pop    %esi
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 305:	eb ef                	jmp    2f6 <stat+0x36>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	53                   	push   %ebx
 314:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 317:	0f be 11             	movsbl (%ecx),%edx
 31a:	8d 42 d0             	lea    -0x30(%edx),%eax
 31d:	3c 09                	cmp    $0x9,%al
 31f:	b8 00 00 00 00       	mov    $0x0,%eax
 324:	77 1f                	ja     345 <atoi+0x35>
 326:	8d 76 00             	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 330:	8d 04 80             	lea    (%eax,%eax,4),%eax
 333:	83 c1 01             	add    $0x1,%ecx
 336:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 33a:	0f be 11             	movsbl (%ecx),%edx
 33d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 340:	80 fb 09             	cmp    $0x9,%bl
 343:	76 eb                	jbe    330 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 345:	5b                   	pop    %ebx
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    
 348:	90                   	nop
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000350 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 5d 10             	mov    0x10(%ebp),%ebx
 358:	8b 45 08             	mov    0x8(%ebp),%eax
 35b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	85 db                	test   %ebx,%ebx
 360:	7e 14                	jle    376 <memmove+0x26>
 362:	31 d2                	xor    %edx,%edx
 364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 368:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 36c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 36f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 372:	39 da                	cmp    %ebx,%edx
 374:	75 f2                	jne    368 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 376:	5b                   	pop    %ebx
 377:	5e                   	pop    %esi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    

0000037a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37a:	b8 01 00 00 00       	mov    $0x1,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <exit>:
SYSCALL(exit)
 382:	b8 02 00 00 00       	mov    $0x2,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <wait>:
SYSCALL(wait)
 38a:	b8 03 00 00 00       	mov    $0x3,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <pipe>:
SYSCALL(pipe)
 392:	b8 04 00 00 00       	mov    $0x4,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <read>:
SYSCALL(read)
 39a:	b8 05 00 00 00       	mov    $0x5,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <write>:
SYSCALL(write)
 3a2:	b8 10 00 00 00       	mov    $0x10,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <close>:
SYSCALL(close)
 3aa:	b8 15 00 00 00       	mov    $0x15,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <kill>:
SYSCALL(kill)
 3b2:	b8 06 00 00 00       	mov    $0x6,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <exec>:
SYSCALL(exec)
 3ba:	b8 07 00 00 00       	mov    $0x7,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <open>:
SYSCALL(open)
 3c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mknod>:
SYSCALL(mknod)
 3ca:	b8 11 00 00 00       	mov    $0x11,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <unlink>:
SYSCALL(unlink)
 3d2:	b8 12 00 00 00       	mov    $0x12,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <fstat>:
SYSCALL(fstat)
 3da:	b8 08 00 00 00       	mov    $0x8,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <link>:
SYSCALL(link)
 3e2:	b8 13 00 00 00       	mov    $0x13,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mkdir>:
SYSCALL(mkdir)
 3ea:	b8 14 00 00 00       	mov    $0x14,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <chdir>:
SYSCALL(chdir)
 3f2:	b8 09 00 00 00       	mov    $0x9,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <dup>:
SYSCALL(dup)
 3fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <getpid>:
SYSCALL(getpid)
 402:	b8 0b 00 00 00       	mov    $0xb,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <sbrk>:
SYSCALL(sbrk)
 40a:	b8 0c 00 00 00       	mov    $0xc,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <sleep>:
SYSCALL(sleep)
 412:	b8 0d 00 00 00       	mov    $0xd,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <uptime>:
SYSCALL(uptime)
 41a:	b8 0e 00 00 00       	mov    $0xe,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <countTrap>:
SYSCALL(countTrap)
 422:	b8 16 00 00 00       	mov    $0x16,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <getSharedPage>:
SYSCALL(getSharedPage)
 42a:	b8 17 00 00 00       	mov    $0x17,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <freeSharedPage>:
SYSCALL(freeSharedPage)
 432:	b8 18 00 00 00       	mov    $0x18,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <callBRead>:
SYSCALL(callBRead)
 43a:	b8 19 00 00 00       	mov    $0x19,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <callSBRead>:
SYSCALL(callSBRead)
 442:	b8 1a 00 00 00       	mov    $0x1a,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <seek>:
SYSCALL(seek)
 44a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <callBWrite>:
 452:	b8 1c 00 00 00       	mov    $0x1c,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    
 45a:	66 90                	xchg   %ax,%ax
 45c:	66 90                	xchg   %ax,%ax
 45e:	66 90                	xchg   %ax,%ax

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	89 c6                	mov    %eax,%esi
 468:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 46e:	85 db                	test   %ebx,%ebx
 470:	74 7e                	je     4f0 <printint+0x90>
 472:	89 d0                	mov    %edx,%eax
 474:	c1 e8 1f             	shr    $0x1f,%eax
 477:	84 c0                	test   %al,%al
 479:	74 75                	je     4f0 <printint+0x90>
    neg = 1;
    x = -xx;
 47b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 47d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 484:	f7 d8                	neg    %eax
 486:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 489:	31 ff                	xor    %edi,%edi
 48b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 48e:	89 ce                	mov    %ecx,%esi
 490:	eb 08                	jmp    49a <printint+0x3a>
 492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 498:	89 cf                	mov    %ecx,%edi
 49a:	31 d2                	xor    %edx,%edx
 49c:	8d 4f 01             	lea    0x1(%edi),%ecx
 49f:	f7 f6                	div    %esi
 4a1:	0f b6 92 4c 08 00 00 	movzbl 0x84c(%edx),%edx
  }while((x /= base) != 0);
 4a8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4ad:	75 e9                	jne    498 <printint+0x38>
  if(neg)
 4af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4b5:	85 c0                	test   %eax,%eax
 4b7:	74 08                	je     4c1 <printint+0x61>
    buf[i++] = '-';
 4b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 4be:	8d 4f 02             	lea    0x2(%edi),%ecx
 4c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
 4c8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4cb:	83 ec 04             	sub    $0x4,%esp
 4ce:	83 ef 01             	sub    $0x1,%edi
 4d1:	6a 01                	push   $0x1
 4d3:	53                   	push   %ebx
 4d4:	56                   	push   %esi
 4d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 4d8:	e8 c5 fe ff ff       	call   3a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	39 df                	cmp    %ebx,%edi
 4e2:	75 e4                	jne    4c8 <printint+0x68>
    putc(fd, buf[i]);
}
 4e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e7:	5b                   	pop    %ebx
 4e8:	5e                   	pop    %esi
 4e9:	5f                   	pop    %edi
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret    
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4f9:	eb 8b                	jmp    486 <printint+0x26>
 4fb:	90                   	nop
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000500 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 506:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 509:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 50f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 512:	89 45 d0             	mov    %eax,-0x30(%ebp)
 515:	0f b6 1e             	movzbl (%esi),%ebx
 518:	83 c6 01             	add    $0x1,%esi
 51b:	84 db                	test   %bl,%bl
 51d:	0f 84 b0 00 00 00    	je     5d3 <printf+0xd3>
 523:	31 d2                	xor    %edx,%edx
 525:	eb 39                	jmp    560 <printf+0x60>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 530:	83 f8 25             	cmp    $0x25,%eax
 533:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 536:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 53b:	74 18                	je     555 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 53d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 540:	83 ec 04             	sub    $0x4,%esp
 543:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 546:	6a 01                	push   $0x1
 548:	50                   	push   %eax
 549:	57                   	push   %edi
 54a:	e8 53 fe ff ff       	call   3a2 <write>
 54f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 552:	83 c4 10             	add    $0x10,%esp
 555:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 558:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 55c:	84 db                	test   %bl,%bl
 55e:	74 73                	je     5d3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 560:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 562:	0f be cb             	movsbl %bl,%ecx
 565:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 568:	74 c6                	je     530 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 56a:	83 fa 25             	cmp    $0x25,%edx
 56d:	75 e6                	jne    555 <printf+0x55>
      if(c == 'd'){
 56f:	83 f8 64             	cmp    $0x64,%eax
 572:	0f 84 f8 00 00 00    	je     670 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 578:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 57e:	83 f9 70             	cmp    $0x70,%ecx
 581:	74 5d                	je     5e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 583:	83 f8 73             	cmp    $0x73,%eax
 586:	0f 84 84 00 00 00    	je     610 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 58c:	83 f8 63             	cmp    $0x63,%eax
 58f:	0f 84 ea 00 00 00    	je     67f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 595:	83 f8 25             	cmp    $0x25,%eax
 598:	0f 84 c2 00 00 00    	je     660 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5a1:	83 ec 04             	sub    $0x4,%esp
 5a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5a8:	6a 01                	push   $0x1
 5aa:	50                   	push   %eax
 5ab:	57                   	push   %edi
 5ac:	e8 f1 fd ff ff       	call   3a2 <write>
 5b1:	83 c4 0c             	add    $0xc,%esp
 5b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5ba:	6a 01                	push   $0x1
 5bc:	50                   	push   %eax
 5bd:	57                   	push   %edi
 5be:	83 c6 01             	add    $0x1,%esi
 5c1:	e8 dc fd ff ff       	call   3a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5cd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cf:	84 db                	test   %bl,%bl
 5d1:	75 8d                	jne    560 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d6:	5b                   	pop    %ebx
 5d7:	5e                   	pop    %esi
 5d8:	5f                   	pop    %edi
 5d9:	5d                   	pop    %ebp
 5da:	c3                   	ret    
 5db:	90                   	nop
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e0:	83 ec 0c             	sub    $0xc,%esp
 5e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5e8:	6a 00                	push   $0x0
 5ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ed:	89 f8                	mov    %edi,%eax
 5ef:	8b 13                	mov    (%ebx),%edx
 5f1:	e8 6a fe ff ff       	call   460 <printint>
        ap++;
 5f6:	89 d8                	mov    %ebx,%eax
 5f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5fb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 5fd:	83 c0 04             	add    $0x4,%eax
 600:	89 45 d0             	mov    %eax,-0x30(%ebp)
 603:	e9 4d ff ff ff       	jmp    555 <printf+0x55>
 608:	90                   	nop
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 610:	8b 45 d0             	mov    -0x30(%ebp),%eax
 613:	8b 18                	mov    (%eax),%ebx
        ap++;
 615:	83 c0 04             	add    $0x4,%eax
 618:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 61b:	b8 43 08 00 00       	mov    $0x843,%eax
 620:	85 db                	test   %ebx,%ebx
 622:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 625:	0f b6 03             	movzbl (%ebx),%eax
 628:	84 c0                	test   %al,%al
 62a:	74 23                	je     64f <printf+0x14f>
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 630:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 633:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 636:	83 ec 04             	sub    $0x4,%esp
 639:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 63b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63e:	50                   	push   %eax
 63f:	57                   	push   %edi
 640:	e8 5d fd ff ff       	call   3a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 645:	0f b6 03             	movzbl (%ebx),%eax
 648:	83 c4 10             	add    $0x10,%esp
 64b:	84 c0                	test   %al,%al
 64d:	75 e1                	jne    630 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 ff fe ff ff       	jmp    555 <printf+0x55>
 656:	8d 76 00             	lea    0x0(%esi),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 666:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 669:	6a 01                	push   $0x1
 66b:	e9 4c ff ff ff       	jmp    5bc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 670:	83 ec 0c             	sub    $0xc,%esp
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	6a 01                	push   $0x1
 67a:	e9 6b ff ff ff       	jmp    5ea <printf+0xea>
 67f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 682:	83 ec 04             	sub    $0x4,%esp
 685:	8b 03                	mov    (%ebx),%eax
 687:	6a 01                	push   $0x1
 689:	88 45 e4             	mov    %al,-0x1c(%ebp)
 68c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 68f:	50                   	push   %eax
 690:	57                   	push   %edi
 691:	e8 0c fd ff ff       	call   3a2 <write>
 696:	e9 5b ff ff ff       	jmp    5f6 <printf+0xf6>
 69b:	66 90                	xchg   %ax,%ax
 69d:	66 90                	xchg   %ax,%ax
 69f:	90                   	nop

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 f0 0a 00 00       	mov    0xaf0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ae:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b3:	39 c8                	cmp    %ecx,%eax
 6b5:	73 19                	jae    6d0 <free+0x30>
 6b7:	89 f6                	mov    %esi,%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6c0:	39 d1                	cmp    %edx,%ecx
 6c2:	72 1c                	jb     6e0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	39 d0                	cmp    %edx,%eax
 6c6:	73 18                	jae    6e0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ca:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ce:	72 f0                	jb     6c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 f4                	jb     6c8 <free+0x28>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	73 f0                	jae    6c8 <free+0x28>
 6d8:	90                   	nop
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6e6:	39 d7                	cmp    %edx,%edi
 6e8:	74 19                	je     703 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	74 23                	je     71a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6f9:	a3 f0 0a 00 00       	mov    %eax,0xaf0
}
 6fe:	5b                   	pop    %ebx
 6ff:	5e                   	pop    %esi
 700:	5f                   	pop    %edi
 701:	5d                   	pop    %ebp
 702:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 703:	03 72 04             	add    0x4(%edx),%esi
 706:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 709:	8b 10                	mov    (%eax),%edx
 70b:	8b 12                	mov    (%edx),%edx
 70d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 710:	8b 50 04             	mov    0x4(%eax),%edx
 713:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 716:	39 f1                	cmp    %esi,%ecx
 718:	75 dd                	jne    6f7 <free+0x57>
    p->s.size += bp->s.size;
 71a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 71d:	a3 f0 0a 00 00       	mov    %eax,0xaf0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 722:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 725:	8b 53 f8             	mov    -0x8(%ebx),%edx
 728:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 72a:	5b                   	pop    %ebx
 72b:	5e                   	pop    %esi
 72c:	5f                   	pop    %edi
 72d:	5d                   	pop    %ebp
 72e:	c3                   	ret    
 72f:	90                   	nop

00000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 15 f0 0a 00 00    	mov    0xaf0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 78 07             	lea    0x7(%eax),%edi
 745:	c1 ef 03             	shr    $0x3,%edi
 748:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 74b:	85 d2                	test   %edx,%edx
 74d:	0f 84 a3 00 00 00    	je     7f6 <malloc+0xc6>
 753:	8b 02                	mov    (%edx),%eax
 755:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 758:	39 cf                	cmp    %ecx,%edi
 75a:	76 74                	jbe    7d0 <malloc+0xa0>
 75c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 762:	be 00 10 00 00       	mov    $0x1000,%esi
 767:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 76e:	0f 43 f7             	cmovae %edi,%esi
 771:	ba 00 80 00 00       	mov    $0x8000,%edx
 776:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 77c:	0f 46 da             	cmovbe %edx,%ebx
 77f:	eb 10                	jmp    791 <malloc+0x61>
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 788:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 78a:	8b 48 04             	mov    0x4(%eax),%ecx
 78d:	39 cf                	cmp    %ecx,%edi
 78f:	76 3f                	jbe    7d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 791:	39 05 f0 0a 00 00    	cmp    %eax,0xaf0
 797:	89 c2                	mov    %eax,%edx
 799:	75 ed                	jne    788 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	53                   	push   %ebx
 79f:	e8 66 fc ff ff       	call   40a <sbrk>
  if(p == (char*)-1)
 7a4:	83 c4 10             	add    $0x10,%esp
 7a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7aa:	74 1c                	je     7c8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7ac:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7af:	83 ec 0c             	sub    $0xc,%esp
 7b2:	83 c0 08             	add    $0x8,%eax
 7b5:	50                   	push   %eax
 7b6:	e8 e5 fe ff ff       	call   6a0 <free>
  return freep;
 7bb:	8b 15 f0 0a 00 00    	mov    0xaf0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7c1:	83 c4 10             	add    $0x10,%esp
 7c4:	85 d2                	test   %edx,%edx
 7c6:	75 c0                	jne    788 <malloc+0x58>
        return 0;
 7c8:	31 c0                	xor    %eax,%eax
 7ca:	eb 1c                	jmp    7e8 <malloc+0xb8>
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7d0:	39 cf                	cmp    %ecx,%edi
 7d2:	74 1c                	je     7f0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7d4:	29 f9                	sub    %edi,%ecx
 7d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7dc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7df:	89 15 f0 0a 00 00    	mov    %edx,0xaf0
      return (void*)(p + 1);
 7e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7eb:	5b                   	pop    %ebx
 7ec:	5e                   	pop    %esi
 7ed:	5f                   	pop    %edi
 7ee:	5d                   	pop    %ebp
 7ef:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb e9                	jmp    7df <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7f6:	c7 05 f0 0a 00 00 f4 	movl   $0xaf4,0xaf0
 7fd:	0a 00 00 
 800:	c7 05 f4 0a 00 00 f4 	movl   $0xaf4,0xaf4
 807:	0a 00 00 
    base.s.size = 0;
 80a:	b8 f4 0a 00 00       	mov    $0xaf4,%eax
 80f:	c7 05 f8 0a 00 00 00 	movl   $0x0,0xaf8
 816:	00 00 00 
 819:	e9 3e ff ff ff       	jmp    75c <malloc+0x2c>
