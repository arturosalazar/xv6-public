#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"
#include "traps.h"
#include "spinlock.h"


int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm); 

pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc);

static char* samePage = 0;

static struct pairs* keysToPage = 0;

static int keysSize = 0;

static int keyToCountSize = 0;

static struct pairsKC* keysToCount = 0;

static struct sharedMapping* procKeyToAddr = 0;

static int procKeyToAddrSize = 0;

struct spinlock lock = {0, "locks", 0, {0}};



struct pairsKC {
    int key;
    int count;
};

struct pairs {
    int key;
    void* page;
};

struct sharedMapping {
    int pid;
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(key == keysToCount[i].key){
            keysToCount[i].count++;
            //cprintf("Shared page count %d \n", keysToCount[i].count);
            return;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    keysToCount[keyToCountSize].key = key;
    keysToCount[keyToCountSize++].count = 1;
}





int sys_getSharedPage(void){
    acquire(&lock);
    int key;
    struct proc *curproc = myproc();
    int numOfPages;

    if(keysToCount == 0){
        keysToCount = (struct pairsKC*) kalloc();
    }

    if(keysToPage == 0){
        keysToPage = (struct pairs*) kalloc();
    }
    
    if(procKeyToAddr == 0){
        procKeyToAddr = (struct sharedMapping*) kalloc();
    }

    

    uint a;

    a = PGROUNDUP(curproc -> sz);
    cprintf("Before argint\n");

    if(argint(0, &key) < 0){
        //cprintf("after 1st argint\n");
        return -1;
    } 

    incrementRoughCount(key);

    if(argint(1, &numOfPages) < 0){
        //cprintf("after 2nd argint\n");
        return -1;
    }

    samePage = 0;

    int counter = 0;
    for(int i = 0; i < keysSize; i++){
        if(key == keysToPage[i].key){
            samePage = keysToPage[i].page;
            counter++;
        } 
    }


    while(counter < numOfPages){
        samePage = kalloc(); 
        keysToPage[keysSize].key = key;
        keysToPage[keysSize].page = samePage;
        memset(samePage, 0, PGSIZE); 
        keysSize++; 
        counter++;
    }

    //cprintf("after kalloc\n");
    int counter1 = 0;
    for(int i = 0; i < keysSize; i++){
        if(key == keysToPage[i].key){
            cprintf("Virtual address: %p ", a + counter1 * PGSIZE);
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
            mappages(curproc -> pgdir, (char*)a + counter1 * PGSIZE, PGSIZE, V2P(keysToPage[i].page), PTE_W|PTE_U|PTE_S);
            procKeyToAddr[procKeyToAddrSize].pid = curproc -> pid;
            cprintf("keyToPages pid %d\n", curproc -> pid);
            procKeyToAddr[procKeyToAddrSize].key = key;
            procKeyToAddr[procKeyToAddrSize].vAddr = a + counter1 * PGSIZE;
            cprintf("Virtual address: %p ", procKeyToAddr[procKeyToAddrSize].vAddr);
            procKeyToAddrSize++;
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
            counter1++;
        }
    }
    //cprintf("After mappages\n");

    curproc->sz = a + counter1 * PGSIZE;
    switchuvm(curproc);
    release(&lock);
    return a;
}




void unmapping(pde_t *pgdir, uint oldsz, uint newsz){
    pte_t *pte;
    uint a;

    //if(newsz >= oldsz)
    //    return oldsz;

    a = PGROUNDUP(newsz);
    for(; a  < oldsz; a += PGSIZE){
        pte = walkpgdir(pgdir, (char*)a, 0);
        if(!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if((*pte & PTE_P) != 0){
            *pte = 0;
        }
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key) return keysToCount[i].count;
    }

    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
        if(keysToPage[i].key == key){
            count++;
        }
    }

    return count;
}

void keysToCountDecrease(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key){
            keysToCount[i].count--;
        }

        if(keysToCount[i].count == 0){
            keysToCount[i].key = -1;
        }
    }

}

void unmapSharedMappings(struct proc* p, int key){
    int pid = p -> pid;
    pde_t *pgdir = p -> pgdir;
    
    for(int i = 0; i < procKeyToAddrSize; i++){
        if(procKeyToAddr[i].key == key && procKeyToAddr[i].pid == pid){
            uint a = procKeyToAddr[i].vAddr;
            pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
            if(!pte)
                a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
                //cprintf("Didn't find corresponding table address.");
            else if((*pte & PTE_P) != 0){
                *pte = 0;
            }
            procKeyToAddr[i].key = -1;
            procKeyToAddr[i].vAddr = 0;
            procKeyToAddr[i]. pid = -1;
        }
    }
}



void releaseByKey(int key){
     acquire(&lock);
    struct proc *curproc = myproc();
     
     int refCounts = refCount(key);
     int pageCounts = pageCount(key);
     
    //cprintf("refCount and key: %d and %d \n", refCounts, key);
   

     unmapSharedMappings(curproc, key);

    curproc->sz = (curproc -> sz) - (PGSIZE * pageCounts);
    

    
     if(refCounts == 1){
         //cprintf("refCounts = 1 \n");
         for(int i = 0; i < keysSize; i++){
             if(keysToPage[i].key == key){
                kfree(keysToPage[i].page);
                keysToPage[i].key = -1; 
                keysToPage[i].page = 0;
             }   
         }
     }
     keysToCountDecrease(key);
    switchuvm(curproc);
    release(&lock);
}

void procCleanup(int pid){

    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
        //cprintf("in loop pid %d \n", pid);
        if(procKeyToAddr[i].pid == pid){
            //cprintf("in loop key: %d \n", procKeyToAddr[i].key);
            releaseByKey(procKeyToAddr[i].key);
            break;
        }
    }
    
}

int sys_freeSharedPage(void){
     int key;
     
     if(argint(0, &key) < 0){
        //cprintf("after 1st argint\n");
        return -1;
     } 

    releaseByKey(key);
     
    return 0;
}