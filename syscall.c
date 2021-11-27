#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"
#include "traps.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "buf.h"
#include "file.h"

// User code makes a system call with INT T_SYSCALL.
// System call number in %eax.
// Arguments on the stack, from the user call to the C
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
}

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}

// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}

extern int sys_chdir(void);
extern int sys_close(void);
extern int sys_dup(void);
extern int sys_exec(void);
extern int sys_exit(void);
extern int sys_fork(void);
extern int sys_fstat(void);
extern int sys_getpid(void);
extern int sys_kill(void);
extern int sys_link(void);
extern int sys_mkdir(void);
extern int sys_mknod(void);
extern int sys_open(void);
extern int sys_pipe(void);
extern int sys_read(void);
extern int sys_sbrk(void);
extern int sys_sleep(void);
extern int sys_unlink(void);
extern int sys_wait(void);
extern int sys_write(void);
extern int sys_uptime(void);
extern int sys_countTrap(void);
extern int sys_getSharedPage(void);
extern int sys_freeSharedPage(void);
extern int sys_callBRead(void);
extern int sys_callSBRead(void);
extern int sys_seek(void);
extern int sys_callBWrite(void);

static int (*syscalls[])(void) = {
[SYS_fork]    sys_fork,
[SYS_exit]    sys_exit,
[SYS_wait]    sys_wait,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
[SYS_kill]    sys_kill,
[SYS_exec]    sys_exec,
[SYS_fstat]   sys_fstat,
[SYS_chdir]   sys_chdir,
[SYS_dup]     sys_dup,
[SYS_getpid]  sys_getpid,
[SYS_sbrk]    sys_sbrk,
[SYS_sleep]   sys_sleep,
[SYS_uptime]  sys_uptime,
[SYS_open]    sys_open,
[SYS_write]   sys_write,
[SYS_mknod]   sys_mknod,
[SYS_unlink]  sys_unlink,
[SYS_link]    sys_link,
[SYS_mkdir]   sys_mkdir,
[SYS_close]   sys_close,
[SYS_countTrap] sys_countTrap,
[SYS_getSharedPage] sys_getSharedPage,
[SYS_freeSharedPage] sys_freeSharedPage,
[SYS_callBRead] sys_callBRead,
[SYS_callSBRead] sys_callSBRead,
[SYS_seek] sys_seek,
[SYS_callBWrite] sys_callBWrite,
};

int countSys = 0;
int syscallsValCounters[NELEM(syscalls)] = {0};
extern int countTrap;
extern int unkownTrap;
extern int trapValCounters[256];


int sys_callBWrite(void){
  int devices;
  int blockno;
  char* dataBuffer;

  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argint(1, &blockno) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(2, &dataBuffer, BSIZE) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  struct buf* p = bread(devices, blockno);
  memmove(p->data, dataBuffer, BSIZE);
  bwrite(p);

  brelse(p);

  return 0;
}

int sys_callBRead(void){
  int devices;
  int blockno;
  char* dataBuffer;
  
  
  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argint(1, &blockno) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(2, &dataBuffer, BSIZE) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  

  struct buf* p = bread(devices, blockno);
  memmove(dataBuffer, p->data, BSIZE);
  brelse(p);

  return 0;
  
}

int sys_callSBRead(void){
  int devices;
  struct superblock* sb;

  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(1, (void*)&sb, sizeof(*sb)) < 0)
    return -1;

  readsb(devices, sb);

  return 0;
}



int sys_countTrap(void){
  cprintf("Count: %d \n", countSys);
  for(int i = 0; i < NELEM(syscalls); i++){
    cprintf("Syscall %d, count: %d \n", i, syscallsValCounters[i]);
  }

  // cprintf("T_DIVIDE, count: %d \n",  trapValCounters[T_DIVIDE]);             // divide error
  // cprintf("T_DEBUG, count: %d \n",  trapValCounters[T_DEBUG]);       // debug exception
  // cprintf("T_NMI, count: %d \n",  trapValCounters[T_NMI]);
  // cprintf("T_BRKPT, count: %d \n",  trapValCounters[T_BRKPT]);
  // cprintf("T_OFLOW , count: %d \n",  trapValCounters[T_OFLOW]);
  // cprintf("T_BOUND , count: %d \n",  trapValCounters[T_BOUND]);
  // cprintf("T_ILLOP, count: %d \n",  trapValCounters[T_ILLOP]);
  // cprintf("T_DEVICE, count: %d \n",  trapValCounters[T_DEVICE]);
  // cprintf("T_DBLFLT, count: %d \n",  trapValCounters[T_DBLFLT]);
  // // #define T_COPROC      9      // reserved (not used since 486)
  // cprintf("T_TSS, count: %d \n",  trapValCounters[T_TSS]);
  // cprintf("T_SEGNP, count: %d \n",  trapValCounters[T_SEGNP]);
  // cprintf("T_STACK, count: %d \n",  trapValCounters[T_STACK]);
  // cprintf("T_GPFLT, count: %d \n",  trapValCounters[T_GPFLT]);
  // cprintf("T_PGFLT, count: %d \n",  trapValCounters[T_PGFLT]);
  // // #define T_RES        15      // reserved
  // cprintf("T_FPERR, count: %d \n",  trapValCounters[T_FPERR]);
  // cprintf("T_ALIGN, count: %d \n",  trapValCounters[T_ALIGN]);
  // cprintf("T_MCHK, count: %d \n",  trapValCounters[T_MCHK]);
  // cprintf("T_SIMDERR, count: %d \n",  trapValCounters[T_SIMDERR]);

  // // These are arbitrarily chosen, but with care not to overlap
  // // processor defined exceptions or interrupt vectors.
  // cprintf("T_SYSCALL, count: %d \n",  trapValCounters[T_SYSCALL]);
  // cprintf("T_DEFAULT, count: %d \n",  unkownTrap);

  // cprintf("T_IRQ0, count: %d \n",  trapValCounters[T_IRQ0]);

  // cprintf("IRQ_TIMER, count: %d \n",  trapValCounters[T_IRQ0+IRQ_TIMER]);
  // cprintf("IRQ_KBD, count: %d \n",  trapValCounters[T_IRQ0+IRQ_KBD]);
  // cprintf("IRQ_COM1, count: %d \n",  trapValCounters[T_IRQ0+IRQ_COM1]);
  // cprintf("IRQ_IDE, count: %d \n",  trapValCounters[T_IRQ0+IRQ_IDE]);
  // cprintf("IRQ_ERROR, count: %d \n",  trapValCounters[T_IRQ0+IRQ_ERROR]);
  // cprintf("IRQ_SPURIOUS, count: %d \n",  trapValCounters[T_IRQ0+IRQ_SPURIOUS]);

  

  return 0;
}

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
    syscallsValCounters[num]++;
    countSys++;
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
