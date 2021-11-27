
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 ca 10 80       	mov    $0x8010cad0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 2e 10 80       	mov    $0x80102eb0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 cb 10 80       	mov    $0x8010cb14,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 20 79 10 80       	push   $0x80107920
80100051:	68 e0 ca 10 80       	push   $0x8010cae0
80100056:	e8 c5 41 00 00       	call   80104220 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c 12 11 80 dc 	movl   $0x801111dc,0x8011122c
80100062:	11 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 12 11 80 dc 	movl   $0x801111dc,0x80111230
8010006c:	11 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc 11 11 80       	mov    $0x801111dc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc 11 11 80 	movl   $0x801111dc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 79 10 80       	push   $0x80107927
80100097:	50                   	push   %eax
80100098:	e8 53 40 00 00       	call   801040f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 12 11 80       	mov    0x80111230,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 30 12 11 80    	mov    %ebx,0x80111230

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc 11 11 80       	cmp    $0x801111dc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 e0 ca 10 80       	push   $0x8010cae0
801000e4:	e8 97 42 00 00       	call   80104380 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 12 11 80    	mov    0x80111230,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc 11 11 80    	cmp    $0x801111dc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 11 11 80    	cmp    $0x801111dc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c 12 11 80    	mov    0x8011122c,%ebx
80100126:	81 fb dc 11 11 80    	cmp    $0x801111dc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 11 11 80    	cmp    $0x801111dc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 ca 10 80       	push   $0x8010cae0
80100162:	e8 c9 42 00 00       	call   80104430 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 3f 00 00       	call   80104130 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 2e 79 10 80       	push   $0x8010792e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 1d 40 00 00       	call   801041d0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 3f 79 10 80       	push   $0x8010793f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 dc 3f 00 00       	call   801041d0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 3f 00 00       	call   80104190 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 ca 10 80 	movl   $0x8010cae0,(%esp)
8010020b:	e8 70 41 00 00       	call   80104380 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 12 11 80       	mov    0x80111230,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc 11 11 80 	movl   $0x801111dc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 30 12 11 80       	mov    0x80111230,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 12 11 80    	mov    %ebx,0x80111230
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 ca 10 80 	movl   $0x8010cae0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 cf 41 00 00       	jmp    80104430 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 79 10 80       	push   $0x80107946
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 1b 15 00 00       	call   801017a0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010028c:	e8 ef 40 00 00       	call   80104380 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 c0 14 11 80       	mov    0x801114c0,%eax
801002a6:	3b 05 c4 14 11 80    	cmp    0x801114c4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 60 b5 10 80       	push   $0x8010b560
801002b8:	68 c0 14 11 80       	push   $0x801114c0
801002bd:	e8 be 3a 00 00       	call   80103d80 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 c0 14 11 80       	mov    0x801114c0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 c4 14 11 80    	cmp    0x801114c4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 f9 34 00 00       	call   801037d0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 60 b5 10 80       	push   $0x8010b560
801002e6:	e8 45 41 00 00       	call   80104430 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 cd 13 00 00       	call   801016c0 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 c0 14 11 80    	mov    %edx,0x801114c0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 40 14 11 80 	movsbl -0x7feeebc0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 60 b5 10 80       	push   $0x8010b560
80100346:	e8 e5 40 00 00       	call   80104430 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 6d 13 00 00       	call   801016c0 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 c0 14 11 80       	mov    %eax,0x801114c0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 b2 23 00 00       	call   80102740 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 4d 79 10 80       	push   $0x8010794d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 fb 7f 10 80 	movl   $0x80107ffb,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 83 3e 00 00       	call   80104240 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 61 79 10 80       	push   $0x80107961
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 41 60 00 00       	call   80106460 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 88 5f 00 00       	call   80106460 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 7c 5f 00 00       	call   80106460 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 70 5f 00 00       	call   80106460 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 17 40 00 00       	call   80104530 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 52 3f 00 00       	call   80104480 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 65 79 10 80       	push   $0x80107965
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 90 79 10 80 	movzbl -0x7fef8670(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 8c 11 00 00       	call   801017a0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010061b:	e8 60 3d 00 00       	call   80104380 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 60 b5 10 80       	push   $0x8010b560
80100647:	e8 e4 3d 00 00       	call   80104430 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 6b 10 00 00       	call   801016c0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 94 b5 10 80       	mov    0x8010b594,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 60 b5 10 80       	push   $0x8010b560
8010070d:	e8 1e 3d 00 00       	call   80104430 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 78 79 10 80       	mov    $0x80107978,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 60 b5 10 80       	push   $0x8010b560
801007c8:	e8 b3 3b 00 00       	call   80104380 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 7f 79 10 80       	push   $0x8010797f
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 60 b5 10 80       	push   $0x8010b560
80100803:	e8 78 3b 00 00       	call   80104380 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 c8 14 11 80       	mov    0x801114c8,%eax
80100836:	3b 05 c4 14 11 80    	cmp    0x801114c4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 c8 14 11 80       	mov    %eax,0x801114c8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 60 b5 10 80       	push   $0x8010b560
80100868:	e8 c3 3b 00 00       	call   80104430 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 c8 14 11 80       	mov    0x801114c8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 c0 14 11 80    	sub    0x801114c0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 c8 14 11 80    	mov    %edx,0x801114c8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 40 14 11 80    	mov    %cl,-0x7feeebc0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 c0 14 11 80       	mov    0x801114c0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 c8 14 11 80    	cmp    %eax,0x801114c8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 c4 14 11 80       	mov    %eax,0x801114c4
          wakeup(&input.r);
801008f1:	68 c0 14 11 80       	push   $0x801114c0
801008f6:	e8 45 36 00 00       	call   80103f40 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 c8 14 11 80       	mov    0x801114c8,%eax
8010090d:	39 05 c4 14 11 80    	cmp    %eax,0x801114c4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 c8 14 11 80       	mov    %eax,0x801114c8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 c8 14 11 80       	mov    0x801114c8,%eax
80100934:	3b 05 c4 14 11 80    	cmp    0x801114c4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 40 14 11 80 0a 	cmpb   $0xa,-0x7feeebc0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 b4 36 00 00       	jmp    80104030 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 40 14 11 80 0a 	movb   $0xa,-0x7feeebc0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 c8 14 11 80       	mov    0x801114c8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 88 79 10 80       	push   $0x80107988
801009ab:	68 60 b5 10 80       	push   $0x8010b560
801009b0:	e8 6b 38 00 00       	call   80104220 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 8c 1e 11 80 00 	movl   $0x80100600,0x80111e8c
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 88 1e 11 80 70 	movl   $0x80100270,0x80111e88
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 12 19 00 00       	call   801022f0 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 cf 2d 00 00       	call   801037d0 <myproc>
80100a01:	89 c6                	mov    %eax,%esi

  begin_op();
80100a03:	e8 98 21 00 00       	call   80102ba0 <begin_op>

  if((ip = namei(path)) == 0){
80100a08:	83 ec 0c             	sub    $0xc,%esp
80100a0b:	ff 75 08             	pushl  0x8(%ebp)
80100a0e:	e8 fd 14 00 00       	call   80101f10 <namei>
80100a13:	83 c4 10             	add    $0x10,%esp
80100a16:	85 c0                	test   %eax,%eax
80100a18:	0f 84 de 01 00 00    	je     80100bfc <exec+0x20c>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a1e:	83 ec 0c             	sub    $0xc,%esp
80100a21:	89 c3                	mov    %eax,%ebx
80100a23:	50                   	push   %eax
80100a24:	e8 97 0c 00 00       	call   801016c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a29:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a2f:	6a 34                	push   $0x34
80100a31:	6a 00                	push   $0x0
80100a33:	50                   	push   %eax
80100a34:	53                   	push   %ebx
80100a35:	e8 66 0f 00 00       	call   801019a0 <readi>
80100a3a:	83 c4 20             	add    $0x20,%esp
80100a3d:	83 f8 34             	cmp    $0x34,%eax
80100a40:	74 2e                	je     80100a70 <exec+0x80>
  return 0;

 bad:
  if(pgdir)
  cprintf("exec in bad");
    freevm(pgdir, curproc -> pid);
80100a42:	83 ec 08             	sub    $0x8,%esp
80100a45:	ff 76 10             	pushl  0x10(%esi)
80100a48:	6a 00                	push   $0x0
80100a4a:	e8 51 6b 00 00       	call   801075a0 <freevm>
80100a4f:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
80100a52:	83 ec 0c             	sub    $0xc,%esp
80100a55:	53                   	push   %ebx
80100a56:	e8 f5 0e 00 00       	call   80101950 <iunlockput>
    end_op();
80100a5b:	e8 b0 21 00 00       	call   80102c10 <end_op>
80100a60:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a6b:	5b                   	pop    %ebx
80100a6c:	5e                   	pop    %esi
80100a6d:	5f                   	pop    %edi
80100a6e:	5d                   	pop    %ebp
80100a6f:	c3                   	ret    
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a70:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a77:	45 4c 46 
80100a7a:	75 c6                	jne    80100a42 <exec+0x52>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a7c:	e8 9f 6b 00 00       	call   80107620 <setupkvm>
80100a81:	85 c0                	test   %eax,%eax
80100a83:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a89:	74 b7                	je     80100a42 <exec+0x52>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a8b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a92:	00 
80100a93:	8b bd 40 ff ff ff    	mov    -0xc0(%ebp),%edi
80100a99:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100aa0:	00 00 00 
80100aa3:	0f 84 e8 00 00 00    	je     80100b91 <exec+0x1a1>
80100aa9:	31 c0                	xor    %eax,%eax
80100aab:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100ab1:	89 c6                	mov    %eax,%esi
80100ab3:	eb 18                	jmp    80100acd <exec+0xdd>
80100ab5:	8d 76 00             	lea    0x0(%esi),%esi
80100ab8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100abf:	83 c6 01             	add    $0x1,%esi
80100ac2:	83 c7 20             	add    $0x20,%edi
80100ac5:	39 f0                	cmp    %esi,%eax
80100ac7:	0f 8e be 00 00 00    	jle    80100b8b <exec+0x19b>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100acd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ad3:	6a 20                	push   $0x20
80100ad5:	57                   	push   %edi
80100ad6:	50                   	push   %eax
80100ad7:	53                   	push   %ebx
80100ad8:	e8 c3 0e 00 00       	call   801019a0 <readi>
80100add:	83 c4 10             	add    $0x10,%esp
80100ae0:	83 f8 20             	cmp    $0x20,%eax
80100ae3:	75 7b                	jne    80100b60 <exec+0x170>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ae5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aec:	75 ca                	jne    80100ab8 <exec+0xc8>
      continue;
    if(ph.memsz < ph.filesz)
80100aee:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100af4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100afa:	72 64                	jb     80100b60 <exec+0x170>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100afc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b02:	72 5c                	jb     80100b60 <exec+0x170>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b04:	83 ec 04             	sub    $0x4,%esp
80100b07:	50                   	push   %eax
80100b08:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b0e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b14:	e8 57 69 00 00       	call   80107470 <allocuvm>
80100b19:	83 c4 10             	add    $0x10,%esp
80100b1c:	85 c0                	test   %eax,%eax
80100b1e:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b24:	74 3a                	je     80100b60 <exec+0x170>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b26:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b2c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b31:	75 2d                	jne    80100b60 <exec+0x170>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b33:	83 ec 0c             	sub    $0xc,%esp
80100b36:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b3c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b42:	53                   	push   %ebx
80100b43:	50                   	push   %eax
80100b44:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b4a:	e8 61 68 00 00       	call   801073b0 <loaduvm>
80100b4f:	83 c4 20             	add    $0x20,%esp
80100b52:	85 c0                	test   %eax,%eax
80100b54:	0f 89 5e ff ff ff    	jns    80100ab8 <exec+0xc8>
80100b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir,  curproc-> pid);
  return 0;

 bad:
  if(pgdir)
  cprintf("exec in bad");
80100b60:	83 ec 0c             	sub    $0xc,%esp
80100b63:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100b69:	68 ad 79 10 80       	push   $0x801079ad
80100b6e:	e8 ed fa ff ff       	call   80100660 <cprintf>
    freevm(pgdir, curproc -> pid);
80100b73:	58                   	pop    %eax
80100b74:	5a                   	pop    %edx
80100b75:	ff 76 10             	pushl  0x10(%esi)
80100b78:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b7e:	e8 1d 6a 00 00       	call   801075a0 <freevm>
80100b83:	83 c4 10             	add    $0x10,%esp
80100b86:	e9 c7 fe ff ff       	jmp    80100a52 <exec+0x62>
80100b8b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 b6 0d 00 00       	call   80101950 <iunlockput>
  end_op();
80100b9a:	e8 71 20 00 00       	call   80102c10 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b9f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ba5:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ba8:	05 ff 0f 00 00       	add    $0xfff,%eax
80100bad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100bb2:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100bb8:	52                   	push   %edx
80100bb9:	50                   	push   %eax
80100bba:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bc0:	e8 ab 68 00 00       	call   80107470 <allocuvm>
80100bc5:	83 c4 10             	add    $0x10,%esp
80100bc8:	85 c0                	test   %eax,%eax
80100bca:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bd0:	75 49                	jne    80100c1b <exec+0x22b>
  freevm(oldpgdir,  curproc-> pid);
  return 0;

 bad:
  if(pgdir)
  cprintf("exec in bad");
80100bd2:	83 ec 0c             	sub    $0xc,%esp
80100bd5:	68 ad 79 10 80       	push   $0x801079ad
80100bda:	e8 81 fa ff ff       	call   80100660 <cprintf>
    freevm(pgdir, curproc -> pid);
80100bdf:	58                   	pop    %eax
80100be0:	5a                   	pop    %edx
80100be1:	ff 76 10             	pushl  0x10(%esi)
80100be4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bea:	e8 b1 69 00 00       	call   801075a0 <freevm>
80100bef:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bf7:	e9 6c fe ff ff       	jmp    80100a68 <exec+0x78>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bfc:	e8 0f 20 00 00       	call   80102c10 <end_op>
    cprintf("exec: fail\n");
80100c01:	83 ec 0c             	sub    $0xc,%esp
80100c04:	68 a1 79 10 80       	push   $0x801079a1
80100c09:	e8 52 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c16:	e9 4d fe ff ff       	jmp    80100a68 <exec+0x78>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c1b:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100c21:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c24:	31 ff                	xor    %edi,%edi
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c26:	89 d8                	mov    %ebx,%eax
80100c28:	2d 00 20 00 00       	sub    $0x2000,%eax
80100c2d:	50                   	push   %eax
80100c2e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c34:	e8 a7 6a 00 00       	call   801076e0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c39:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3c:	83 c4 10             	add    $0x10,%esp
80100c3f:	8b 00                	mov    (%eax),%eax
80100c41:	85 c0                	test   %eax,%eax
80100c43:	0f 84 54 01 00 00    	je     80100d9d <exec+0x3ad>
80100c49:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c4f:	89 fe                	mov    %edi,%esi
80100c51:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c57:	eb 26                	jmp    80100c7f <exec+0x28f>
80100c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c60:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c63:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6a:	83 c6 01             	add    $0x1,%esi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6d:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c73:	8b 04 b0             	mov    (%eax,%esi,4),%eax
80100c76:	85 c0                	test   %eax,%eax
80100c78:	74 44                	je     80100cbe <exec+0x2ce>
    if(argc >= MAXARG)
80100c7a:	83 fe 20             	cmp    $0x20,%esi
80100c7d:	74 34                	je     80100cb3 <exec+0x2c3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c7f:	83 ec 0c             	sub    $0xc,%esp
80100c82:	50                   	push   %eax
80100c83:	e8 38 3a 00 00       	call   801046c0 <strlen>
80100c88:	f7 d0                	not    %eax
80100c8a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c8c:	58                   	pop    %eax
80100c8d:	8b 45 0c             	mov    0xc(%ebp),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c90:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c93:	ff 34 b0             	pushl  (%eax,%esi,4)
80100c96:	e8 25 3a 00 00       	call   801046c0 <strlen>
80100c9b:	83 c0 01             	add    $0x1,%eax
80100c9e:	50                   	push   %eax
80100c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ca2:	ff 34 b0             	pushl  (%eax,%esi,4)
80100ca5:	53                   	push   %ebx
80100ca6:	57                   	push   %edi
80100ca7:	e8 d4 6b 00 00       	call   80107880 <copyout>
80100cac:	83 c4 20             	add    $0x20,%esp
80100caf:	85 c0                	test   %eax,%eax
80100cb1:	79 ad                	jns    80100c60 <exec+0x270>
80100cb3:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100cb9:	e9 14 ff ff ff       	jmp    80100bd2 <exec+0x1e2>
80100cbe:	89 f7                	mov    %esi,%edi
80100cc0:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc6:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100ccd:	89 da                	mov    %ebx,%edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100ccf:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cd6:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100cda:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ce1:	ff ff ff 
  ustack[1] = argc;
80100ce4:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cea:	29 c2                	sub    %eax,%edx

  sp -= (3+argc+1) * 4;
80100cec:	83 c0 0c             	add    $0xc,%eax
80100cef:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cf1:	50                   	push   %eax
80100cf2:	51                   	push   %ecx
80100cf3:	53                   	push   %ebx
80100cf4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cfa:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d00:	e8 7b 6b 00 00       	call   80107880 <copyout>
80100d05:	83 c4 10             	add    $0x10,%esp
80100d08:	85 c0                	test   %eax,%eax
80100d0a:	0f 88 c2 fe ff ff    	js     80100bd2 <exec+0x1e2>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d10:	8b 45 08             	mov    0x8(%ebp),%eax
80100d13:	0f b6 10             	movzbl (%eax),%edx
80100d16:	84 d2                	test   %dl,%dl
80100d18:	74 19                	je     80100d33 <exec+0x343>
80100d1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d1d:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100d20:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d23:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100d26:	0f 44 c8             	cmove  %eax,%ecx
80100d29:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d2c:	84 d2                	test   %dl,%dl
80100d2e:	75 f0                	jne    80100d20 <exec+0x330>
80100d30:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d33:	8d 46 6c             	lea    0x6c(%esi),%eax
80100d36:	51                   	push   %ecx
80100d37:	6a 10                	push   $0x10
80100d39:	ff 75 08             	pushl  0x8(%ebp)
80100d3c:	50                   	push   %eax
80100d3d:	e8 3e 39 00 00       	call   80104680 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d42:	8b 46 04             	mov    0x4(%esi),%eax
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d45:	8b 56 18             	mov    0x18(%esi),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d48:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
80100d4e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d54:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80100d57:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d5d:	89 06                	mov    %eax,(%esi)
  curproc->tf->eip = elf.entry;  // main
80100d5f:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d65:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80100d68:	8b 56 18             	mov    0x18(%esi),%edx
80100d6b:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(curproc);
80100d6e:	89 34 24             	mov    %esi,(%esp)
80100d71:	e8 aa 64 00 00       	call   80107220 <switchuvm>
  cprintf("exec before switchvm");
80100d76:	c7 04 24 b9 79 10 80 	movl   $0x801079b9,(%esp)
80100d7d:	e8 de f8 ff ff       	call   80100660 <cprintf>
  freevm(oldpgdir,  curproc-> pid);
80100d82:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100d88:	5b                   	pop    %ebx
80100d89:	5f                   	pop    %edi
80100d8a:	ff 76 10             	pushl  0x10(%esi)
80100d8d:	50                   	push   %eax
80100d8e:	e8 0d 68 00 00       	call   801075a0 <freevm>
  return 0;
80100d93:	83 c4 10             	add    $0x10,%esp
80100d96:	31 c0                	xor    %eax,%eax
80100d98:	e9 cb fc ff ff       	jmp    80100a68 <exec+0x78>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d9d:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100da3:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100da9:	e9 18 ff ff ff       	jmp    80100cc6 <exec+0x2d6>
80100dae:	66 90                	xchg   %ax,%ax

80100db0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100db0:	55                   	push   %ebp
80100db1:	89 e5                	mov    %esp,%ebp
80100db3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100db6:	68 ce 79 10 80       	push   $0x801079ce
80100dbb:	68 e0 14 11 80       	push   $0x801114e0
80100dc0:	e8 5b 34 00 00       	call   80104220 <initlock>
}
80100dc5:	83 c4 10             	add    $0x10,%esp
80100dc8:	c9                   	leave  
80100dc9:	c3                   	ret    
80100dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100dd0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dd4:	bb 14 15 11 80       	mov    $0x80111514,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dd9:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100ddc:	68 e0 14 11 80       	push   $0x801114e0
80100de1:	e8 9a 35 00 00       	call   80104380 <acquire>
80100de6:	83 c4 10             	add    $0x10,%esp
80100de9:	eb 10                	jmp    80100dfb <filealloc+0x2b>
80100deb:	90                   	nop
80100dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100df0:	83 c3 18             	add    $0x18,%ebx
80100df3:	81 fb 74 1e 11 80    	cmp    $0x80111e74,%ebx
80100df9:	74 25                	je     80100e20 <filealloc+0x50>
    if(f->ref == 0){
80100dfb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dfe:	85 c0                	test   %eax,%eax
80100e00:	75 ee                	jne    80100df0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e02:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100e05:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e0c:	68 e0 14 11 80       	push   $0x801114e0
80100e11:	e8 1a 36 00 00       	call   80104430 <release>
      return f;
80100e16:	89 d8                	mov    %ebx,%eax
80100e18:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e1e:	c9                   	leave  
80100e1f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100e20:	83 ec 0c             	sub    $0xc,%esp
80100e23:	68 e0 14 11 80       	push   $0x801114e0
80100e28:	e8 03 36 00 00       	call   80104430 <release>
  return 0;
80100e2d:	83 c4 10             	add    $0x10,%esp
80100e30:	31 c0                	xor    %eax,%eax
}
80100e32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e35:	c9                   	leave  
80100e36:	c3                   	ret    
80100e37:	89 f6                	mov    %esi,%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
80100e44:	83 ec 10             	sub    $0x10,%esp
80100e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e4a:	68 e0 14 11 80       	push   $0x801114e0
80100e4f:	e8 2c 35 00 00       	call   80104380 <acquire>
  if(f->ref < 1)
80100e54:	8b 43 04             	mov    0x4(%ebx),%eax
80100e57:	83 c4 10             	add    $0x10,%esp
80100e5a:	85 c0                	test   %eax,%eax
80100e5c:	7e 1a                	jle    80100e78 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e5e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e61:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e64:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e67:	68 e0 14 11 80       	push   $0x801114e0
80100e6c:	e8 bf 35 00 00       	call   80104430 <release>
  return f;
}
80100e71:	89 d8                	mov    %ebx,%eax
80100e73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e76:	c9                   	leave  
80100e77:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e78:	83 ec 0c             	sub    $0xc,%esp
80100e7b:	68 d5 79 10 80       	push   $0x801079d5
80100e80:	e8 eb f4 ff ff       	call   80100370 <panic>
80100e85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e90 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e90:	55                   	push   %ebp
80100e91:	89 e5                	mov    %esp,%ebp
80100e93:	57                   	push   %edi
80100e94:	56                   	push   %esi
80100e95:	53                   	push   %ebx
80100e96:	83 ec 28             	sub    $0x28,%esp
80100e99:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e9c:	68 e0 14 11 80       	push   $0x801114e0
80100ea1:	e8 da 34 00 00       	call   80104380 <acquire>
  if(f->ref < 1)
80100ea6:	8b 47 04             	mov    0x4(%edi),%eax
80100ea9:	83 c4 10             	add    $0x10,%esp
80100eac:	85 c0                	test   %eax,%eax
80100eae:	0f 8e 9b 00 00 00    	jle    80100f4f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100eb4:	83 e8 01             	sub    $0x1,%eax
80100eb7:	85 c0                	test   %eax,%eax
80100eb9:	89 47 04             	mov    %eax,0x4(%edi)
80100ebc:	74 1a                	je     80100ed8 <fileclose+0x48>
    release(&ftable.lock);
80100ebe:	c7 45 08 e0 14 11 80 	movl   $0x801114e0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100ec5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec8:	5b                   	pop    %ebx
80100ec9:	5e                   	pop    %esi
80100eca:	5f                   	pop    %edi
80100ecb:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100ecc:	e9 5f 35 00 00       	jmp    80104430 <release>
80100ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100ed8:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100edc:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ede:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ee1:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100ee4:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100eea:	88 45 e7             	mov    %al,-0x19(%ebp)
80100eed:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ef0:	68 e0 14 11 80       	push   $0x801114e0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ef5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ef8:	e8 33 35 00 00       	call   80104430 <release>

  if(ff.type == FD_PIPE)
80100efd:	83 c4 10             	add    $0x10,%esp
80100f00:	83 fb 01             	cmp    $0x1,%ebx
80100f03:	74 13                	je     80100f18 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f05:	83 fb 02             	cmp    $0x2,%ebx
80100f08:	74 26                	je     80100f30 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f0d:	5b                   	pop    %ebx
80100f0e:	5e                   	pop    %esi
80100f0f:	5f                   	pop    %edi
80100f10:	5d                   	pop    %ebp
80100f11:	c3                   	ret    
80100f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100f18:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f1c:	83 ec 08             	sub    $0x8,%esp
80100f1f:	53                   	push   %ebx
80100f20:	56                   	push   %esi
80100f21:	e8 1a 24 00 00       	call   80103340 <pipeclose>
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	eb df                	jmp    80100f0a <fileclose+0x7a>
80100f2b:	90                   	nop
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100f30:	e8 6b 1c 00 00       	call   80102ba0 <begin_op>
    iput(ff.ip);
80100f35:	83 ec 0c             	sub    $0xc,%esp
80100f38:	ff 75 e0             	pushl  -0x20(%ebp)
80100f3b:	e8 b0 08 00 00       	call   801017f0 <iput>
    end_op();
80100f40:	83 c4 10             	add    $0x10,%esp
  }
}
80100f43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f46:	5b                   	pop    %ebx
80100f47:	5e                   	pop    %esi
80100f48:	5f                   	pop    %edi
80100f49:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100f4a:	e9 c1 1c 00 00       	jmp    80102c10 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100f4f:	83 ec 0c             	sub    $0xc,%esp
80100f52:	68 dd 79 10 80       	push   $0x801079dd
80100f57:	e8 14 f4 ff ff       	call   80100370 <panic>
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f60 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	53                   	push   %ebx
80100f64:	83 ec 04             	sub    $0x4,%esp
80100f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f6a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f6d:	75 31                	jne    80100fa0 <filestat+0x40>
    ilock(f->ip);
80100f6f:	83 ec 0c             	sub    $0xc,%esp
80100f72:	ff 73 10             	pushl  0x10(%ebx)
80100f75:	e8 46 07 00 00       	call   801016c0 <ilock>
    stati(f->ip, st);
80100f7a:	58                   	pop    %eax
80100f7b:	5a                   	pop    %edx
80100f7c:	ff 75 0c             	pushl  0xc(%ebp)
80100f7f:	ff 73 10             	pushl  0x10(%ebx)
80100f82:	e8 e9 09 00 00       	call   80101970 <stati>
    iunlock(f->ip);
80100f87:	59                   	pop    %ecx
80100f88:	ff 73 10             	pushl  0x10(%ebx)
80100f8b:	e8 10 08 00 00       	call   801017a0 <iunlock>
    return 0;
80100f90:	83 c4 10             	add    $0x10,%esp
80100f93:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fa8:	c9                   	leave  
80100fa9:	c3                   	ret    
80100faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fb0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	57                   	push   %edi
80100fb4:	56                   	push   %esi
80100fb5:	53                   	push   %ebx
80100fb6:	83 ec 0c             	sub    $0xc,%esp
80100fb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fbc:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fbf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fc2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fc6:	74 60                	je     80101028 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fc8:	8b 03                	mov    (%ebx),%eax
80100fca:	83 f8 01             	cmp    $0x1,%eax
80100fcd:	74 41                	je     80101010 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fcf:	83 f8 02             	cmp    $0x2,%eax
80100fd2:	75 5b                	jne    8010102f <fileread+0x7f>
    ilock(f->ip);
80100fd4:	83 ec 0c             	sub    $0xc,%esp
80100fd7:	ff 73 10             	pushl  0x10(%ebx)
80100fda:	e8 e1 06 00 00       	call   801016c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fdf:	57                   	push   %edi
80100fe0:	ff 73 14             	pushl  0x14(%ebx)
80100fe3:	56                   	push   %esi
80100fe4:	ff 73 10             	pushl  0x10(%ebx)
80100fe7:	e8 b4 09 00 00       	call   801019a0 <readi>
80100fec:	83 c4 20             	add    $0x20,%esp
80100fef:	85 c0                	test   %eax,%eax
80100ff1:	89 c6                	mov    %eax,%esi
80100ff3:	7e 03                	jle    80100ff8 <fileread+0x48>
      f->off += r;
80100ff5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100ff8:	83 ec 0c             	sub    $0xc,%esp
80100ffb:	ff 73 10             	pushl  0x10(%ebx)
80100ffe:	e8 9d 07 00 00       	call   801017a0 <iunlock>
    return r;
80101003:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101006:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010100b:	5b                   	pop    %ebx
8010100c:	5e                   	pop    %esi
8010100d:	5f                   	pop    %edi
8010100e:	5d                   	pop    %ebp
8010100f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101010:	8b 43 0c             	mov    0xc(%ebx),%eax
80101013:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101016:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101019:	5b                   	pop    %ebx
8010101a:	5e                   	pop    %esi
8010101b:	5f                   	pop    %edi
8010101c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
8010101d:	e9 be 24 00 00       	jmp    801034e0 <piperead>
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010102d:	eb d9                	jmp    80101008 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	68 e7 79 10 80       	push   $0x801079e7
80101037:	e8 34 f3 ff ff       	call   80100370 <panic>
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101040 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	57                   	push   %edi
80101044:	56                   	push   %esi
80101045:	53                   	push   %ebx
80101046:	83 ec 1c             	sub    $0x1c,%esp
80101049:	8b 75 08             	mov    0x8(%ebp),%esi
8010104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010104f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101053:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101056:	8b 45 10             	mov    0x10(%ebp),%eax
80101059:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010105c:	0f 84 aa 00 00 00    	je     8010110c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101062:	8b 06                	mov    (%esi),%eax
80101064:	83 f8 01             	cmp    $0x1,%eax
80101067:	0f 84 c2 00 00 00    	je     8010112f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010106d:	83 f8 02             	cmp    $0x2,%eax
80101070:	0f 85 d8 00 00 00    	jne    8010114e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101076:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101079:	31 ff                	xor    %edi,%edi
8010107b:	85 c0                	test   %eax,%eax
8010107d:	7f 34                	jg     801010b3 <filewrite+0x73>
8010107f:	e9 9c 00 00 00       	jmp    80101120 <filewrite+0xe0>
80101084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101088:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010108b:	83 ec 0c             	sub    $0xc,%esp
8010108e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101091:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101094:	e8 07 07 00 00       	call   801017a0 <iunlock>
      end_op();
80101099:	e8 72 1b 00 00       	call   80102c10 <end_op>
8010109e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801010a4:	39 d8                	cmp    %ebx,%eax
801010a6:	0f 85 95 00 00 00    	jne    80101141 <filewrite+0x101>
        panic("short filewrite");
      i += r;
801010ac:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010ae:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010b1:	7e 6d                	jle    80101120 <filewrite+0xe0>
      int n1 = n - i;
801010b3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010b6:	b8 00 06 00 00       	mov    $0x600,%eax
801010bb:	29 fb                	sub    %edi,%ebx
801010bd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010c3:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
801010c6:	e8 d5 1a 00 00       	call   80102ba0 <begin_op>
      ilock(f->ip);
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	ff 76 10             	pushl  0x10(%esi)
801010d1:	e8 ea 05 00 00       	call   801016c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010d9:	53                   	push   %ebx
801010da:	ff 76 14             	pushl  0x14(%esi)
801010dd:	01 f8                	add    %edi,%eax
801010df:	50                   	push   %eax
801010e0:	ff 76 10             	pushl  0x10(%esi)
801010e3:	e8 b8 09 00 00       	call   80101aa0 <writei>
801010e8:	83 c4 20             	add    $0x20,%esp
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 99                	jg     80101088 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	ff 76 10             	pushl  0x10(%esi)
801010f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010f8:	e8 a3 06 00 00       	call   801017a0 <iunlock>
      end_op();
801010fd:	e8 0e 1b 00 00       	call   80102c10 <end_op>

      if(r < 0)
80101102:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101105:	83 c4 10             	add    $0x10,%esp
80101108:	85 c0                	test   %eax,%eax
8010110a:	74 98                	je     801010a4 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010110c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010110f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101114:	5b                   	pop    %ebx
80101115:	5e                   	pop    %esi
80101116:	5f                   	pop    %edi
80101117:	5d                   	pop    %ebp
80101118:	c3                   	ret    
80101119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101120:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101123:	75 e7                	jne    8010110c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101125:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101128:	89 f8                	mov    %edi,%eax
8010112a:	5b                   	pop    %ebx
8010112b:	5e                   	pop    %esi
8010112c:	5f                   	pop    %edi
8010112d:	5d                   	pop    %ebp
8010112e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010112f:	8b 46 0c             	mov    0xc(%esi),%eax
80101132:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101135:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101138:	5b                   	pop    %ebx
80101139:	5e                   	pop    %esi
8010113a:	5f                   	pop    %edi
8010113b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010113c:	e9 9f 22 00 00       	jmp    801033e0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101141:	83 ec 0c             	sub    $0xc,%esp
80101144:	68 f0 79 10 80       	push   $0x801079f0
80101149:	e8 22 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010114e:	83 ec 0c             	sub    $0xc,%esp
80101151:	68 f6 79 10 80       	push   $0x801079f6
80101156:	e8 15 f2 ff ff       	call   80100370 <panic>
8010115b:	66 90                	xchg   %ax,%ax
8010115d:	66 90                	xchg   %ax,%ax
8010115f:	90                   	nop

80101160 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	56                   	push   %esi
80101164:	53                   	push   %ebx
80101165:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101167:	c1 ea 0c             	shr    $0xc,%edx
8010116a:	03 15 f8 1e 11 80    	add    0x80111ef8,%edx
80101170:	83 ec 08             	sub    $0x8,%esp
80101173:	52                   	push   %edx
80101174:	50                   	push   %eax
80101175:	e8 56 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010117a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010117c:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101182:	ba 01 00 00 00       	mov    $0x1,%edx
80101187:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010118a:	c1 fb 03             	sar    $0x3,%ebx
8010118d:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101190:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101192:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101197:	85 d1                	test   %edx,%ecx
80101199:	74 27                	je     801011c2 <bfree+0x62>
8010119b:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010119d:	f7 d2                	not    %edx
8010119f:	89 c8                	mov    %ecx,%eax
  log_write(bp);
801011a1:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801011a4:	21 d0                	and    %edx,%eax
801011a6:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801011aa:	56                   	push   %esi
801011ab:	e8 d0 1b 00 00       	call   80102d80 <log_write>
  brelse(bp);
801011b0:	89 34 24             	mov    %esi,(%esp)
801011b3:	e8 28 f0 ff ff       	call   801001e0 <brelse>
}
801011b8:	83 c4 10             	add    $0x10,%esp
801011bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801011be:	5b                   	pop    %ebx
801011bf:	5e                   	pop    %esi
801011c0:	5d                   	pop    %ebp
801011c1:	c3                   	ret    

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801011c2:	83 ec 0c             	sub    $0xc,%esp
801011c5:	68 00 7a 10 80       	push   $0x80107a00
801011ca:	e8 a1 f1 ff ff       	call   80100370 <panic>
801011cf:	90                   	nop

801011d0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	57                   	push   %edi
801011d4:	56                   	push   %esi
801011d5:	53                   	push   %ebx
801011d6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011d9:	8b 0d e0 1e 11 80    	mov    0x80111ee0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011e2:	85 c9                	test   %ecx,%ecx
801011e4:	0f 84 85 00 00 00    	je     8010126f <balloc+0x9f>
801011ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011f4:	83 ec 08             	sub    $0x8,%esp
801011f7:	89 f0                	mov    %esi,%eax
801011f9:	c1 f8 0c             	sar    $0xc,%eax
801011fc:	03 05 f8 1e 11 80    	add    0x80111ef8,%eax
80101202:	50                   	push   %eax
80101203:	ff 75 d8             	pushl  -0x28(%ebp)
80101206:	e8 c5 ee ff ff       	call   801000d0 <bread>
8010120b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010120e:	a1 e0 1e 11 80       	mov    0x80111ee0,%eax
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101219:	31 c0                	xor    %eax,%eax
8010121b:	eb 2d                	jmp    8010124a <balloc+0x7a>
8010121d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101220:	89 c1                	mov    %eax,%ecx
80101222:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101227:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010122a:	83 e1 07             	and    $0x7,%ecx
8010122d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010122f:	89 c1                	mov    %eax,%ecx
80101231:	c1 f9 03             	sar    $0x3,%ecx
80101234:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101239:	85 d7                	test   %edx,%edi
8010123b:	74 43                	je     80101280 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010123d:	83 c0 01             	add    $0x1,%eax
80101240:	83 c6 01             	add    $0x1,%esi
80101243:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101248:	74 05                	je     8010124f <balloc+0x7f>
8010124a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010124d:	72 d1                	jb     80101220 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010124f:	83 ec 0c             	sub    $0xc,%esp
80101252:	ff 75 e4             	pushl  -0x1c(%ebp)
80101255:	e8 86 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010125a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101261:	83 c4 10             	add    $0x10,%esp
80101264:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101267:	39 05 e0 1e 11 80    	cmp    %eax,0x80111ee0
8010126d:	77 82                	ja     801011f1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010126f:	83 ec 0c             	sub    $0xc,%esp
80101272:	68 13 7a 10 80       	push   $0x80107a13
80101277:	e8 f4 f0 ff ff       	call   80100370 <panic>
8010127c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101280:	09 fa                	or     %edi,%edx
80101282:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101285:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101288:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010128c:	57                   	push   %edi
8010128d:	e8 ee 1a 00 00       	call   80102d80 <log_write>
        brelse(bp);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 46 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010129a:	58                   	pop    %eax
8010129b:	5a                   	pop    %edx
8010129c:	56                   	push   %esi
8010129d:	ff 75 d8             	pushl  -0x28(%ebp)
801012a0:	e8 2b ee ff ff       	call   801000d0 <bread>
801012a5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012aa:	83 c4 0c             	add    $0xc,%esp
801012ad:	68 00 02 00 00       	push   $0x200
801012b2:	6a 00                	push   $0x0
801012b4:	50                   	push   %eax
801012b5:	e8 c6 31 00 00       	call   80104480 <memset>
  log_write(bp);
801012ba:	89 1c 24             	mov    %ebx,(%esp)
801012bd:	e8 be 1a 00 00       	call   80102d80 <log_write>
  brelse(bp);
801012c2:	89 1c 24             	mov    %ebx,(%esp)
801012c5:	e8 16 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801012ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012cd:	89 f0                	mov    %esi,%eax
801012cf:	5b                   	pop    %ebx
801012d0:	5e                   	pop    %esi
801012d1:	5f                   	pop    %edi
801012d2:	5d                   	pop    %ebp
801012d3:	c3                   	ret    
801012d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012e8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ea:	bb 34 1f 11 80       	mov    $0x80111f34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012ef:	83 ec 28             	sub    $0x28,%esp
801012f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801012f5:	68 00 1f 11 80       	push   $0x80111f00
801012fa:	e8 81 30 00 00       	call   80104380 <acquire>
801012ff:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101302:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101305:	eb 1b                	jmp    80101322 <iget+0x42>
80101307:	89 f6                	mov    %esi,%esi
80101309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101310:	85 f6                	test   %esi,%esi
80101312:	74 44                	je     80101358 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101314:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010131a:	81 fb 54 3b 11 80    	cmp    $0x80113b54,%ebx
80101320:	74 4e                	je     80101370 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101322:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101325:	85 c9                	test   %ecx,%ecx
80101327:	7e e7                	jle    80101310 <iget+0x30>
80101329:	39 3b                	cmp    %edi,(%ebx)
8010132b:	75 e3                	jne    80101310 <iget+0x30>
8010132d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101330:	75 de                	jne    80101310 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101332:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101335:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101338:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010133a:	68 00 1f 11 80       	push   $0x80111f00

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010133f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101342:	e8 e9 30 00 00       	call   80104430 <release>
      return ip;
80101347:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134d:	89 f0                	mov    %esi,%eax
8010134f:	5b                   	pop    %ebx
80101350:	5e                   	pop    %esi
80101351:	5f                   	pop    %edi
80101352:	5d                   	pop    %ebp
80101353:	c3                   	ret    
80101354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101358:	85 c9                	test   %ecx,%ecx
8010135a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101363:	81 fb 54 3b 11 80    	cmp    $0x80113b54,%ebx
80101369:	75 b7                	jne    80101322 <iget+0x42>
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101370:	85 f6                	test   %esi,%esi
80101372:	74 2d                	je     801013a1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101374:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101377:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101379:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010137c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101383:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010138a:	68 00 1f 11 80       	push   $0x80111f00
8010138f:	e8 9c 30 00 00       	call   80104430 <release>

  return ip;
80101394:	83 c4 10             	add    $0x10,%esp
}
80101397:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010139a:	89 f0                	mov    %esi,%eax
8010139c:	5b                   	pop    %ebx
8010139d:	5e                   	pop    %esi
8010139e:	5f                   	pop    %edi
8010139f:	5d                   	pop    %ebp
801013a0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801013a1:	83 ec 0c             	sub    $0xc,%esp
801013a4:	68 29 7a 10 80       	push   $0x80107a29
801013a9:	e8 c2 ef ff ff       	call   80100370 <panic>
801013ae:	66 90                	xchg   %ax,%ax

801013b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	89 c6                	mov    %eax,%esi
801013b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013bb:	83 fa 0b             	cmp    $0xb,%edx
801013be:	77 18                	ja     801013d8 <bmap+0x28>
801013c0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801013c3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801013c6:	85 c0                	test   %eax,%eax
801013c8:	74 76                	je     80101440 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013cd:	5b                   	pop    %ebx
801013ce:	5e                   	pop    %esi
801013cf:	5f                   	pop    %edi
801013d0:	5d                   	pop    %ebp
801013d1:	c3                   	ret    
801013d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801013d8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801013db:	83 fb 7f             	cmp    $0x7f,%ebx
801013de:	0f 87 83 00 00 00    	ja     80101467 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801013e4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801013ea:	85 c0                	test   %eax,%eax
801013ec:	74 6a                	je     80101458 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013ee:	83 ec 08             	sub    $0x8,%esp
801013f1:	50                   	push   %eax
801013f2:	ff 36                	pushl  (%esi)
801013f4:	e8 d7 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013f9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013fd:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101400:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101402:	8b 1a                	mov    (%edx),%ebx
80101404:	85 db                	test   %ebx,%ebx
80101406:	75 1d                	jne    80101425 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101408:	8b 06                	mov    (%esi),%eax
8010140a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010140d:	e8 be fd ff ff       	call   801011d0 <balloc>
80101412:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101415:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101418:	89 c3                	mov    %eax,%ebx
8010141a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010141c:	57                   	push   %edi
8010141d:	e8 5e 19 00 00       	call   80102d80 <log_write>
80101422:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101425:	83 ec 0c             	sub    $0xc,%esp
80101428:	57                   	push   %edi
80101429:	e8 b2 ed ff ff       	call   801001e0 <brelse>
8010142e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101431:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101434:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101436:	5b                   	pop    %ebx
80101437:	5e                   	pop    %esi
80101438:	5f                   	pop    %edi
80101439:	5d                   	pop    %ebp
8010143a:	c3                   	ret    
8010143b:	90                   	nop
8010143c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101440:	8b 06                	mov    (%esi),%eax
80101442:	e8 89 fd ff ff       	call   801011d0 <balloc>
80101447:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010144a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144d:	5b                   	pop    %ebx
8010144e:	5e                   	pop    %esi
8010144f:	5f                   	pop    %edi
80101450:	5d                   	pop    %ebp
80101451:	c3                   	ret    
80101452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101458:	8b 06                	mov    (%esi),%eax
8010145a:	e8 71 fd ff ff       	call   801011d0 <balloc>
8010145f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101465:	eb 87                	jmp    801013ee <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101467:	83 ec 0c             	sub    $0xc,%esp
8010146a:	68 39 7a 10 80       	push   $0x80107a39
8010146f:	e8 fc ee ff ff       	call   80100370 <panic>
80101474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010147a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101480 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	56                   	push   %esi
80101484:	53                   	push   %ebx
80101485:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101488:	83 ec 08             	sub    $0x8,%esp
8010148b:	6a 01                	push   $0x1
8010148d:	ff 75 08             	pushl  0x8(%ebp)
80101490:	e8 3b ec ff ff       	call   801000d0 <bread>
80101495:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101497:	8d 40 5c             	lea    0x5c(%eax),%eax
8010149a:	83 c4 0c             	add    $0xc,%esp
8010149d:	6a 1c                	push   $0x1c
8010149f:	50                   	push   %eax
801014a0:	56                   	push   %esi
801014a1:	e8 8a 30 00 00       	call   80104530 <memmove>
  brelse(bp);
801014a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014a9:	83 c4 10             	add    $0x10,%esp
}
801014ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014af:	5b                   	pop    %ebx
801014b0:	5e                   	pop    %esi
801014b1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801014b2:	e9 29 ed ff ff       	jmp    801001e0 <brelse>
801014b7:	89 f6                	mov    %esi,%esi
801014b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014c0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	53                   	push   %ebx
801014c4:	bb 40 1f 11 80       	mov    $0x80111f40,%ebx
801014c9:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801014cc:	68 4c 7a 10 80       	push   $0x80107a4c
801014d1:	68 00 1f 11 80       	push   $0x80111f00
801014d6:	e8 45 2d 00 00       	call   80104220 <initlock>
801014db:	83 c4 10             	add    $0x10,%esp
801014de:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801014e0:	83 ec 08             	sub    $0x8,%esp
801014e3:	68 53 7a 10 80       	push   $0x80107a53
801014e8:	53                   	push   %ebx
801014e9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ef:	e8 fc 2b 00 00       	call   801040f0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	81 fb 60 3b 11 80    	cmp    $0x80113b60,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014ff:	83 ec 08             	sub    $0x8,%esp
80101502:	68 e0 1e 11 80       	push   $0x80111ee0
80101507:	ff 75 08             	pushl  0x8(%ebp)
8010150a:	e8 71 ff ff ff       	call   80101480 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010150f:	ff 35 f8 1e 11 80    	pushl  0x80111ef8
80101515:	ff 35 f4 1e 11 80    	pushl  0x80111ef4
8010151b:	ff 35 f0 1e 11 80    	pushl  0x80111ef0
80101521:	ff 35 ec 1e 11 80    	pushl  0x80111eec
80101527:	ff 35 e8 1e 11 80    	pushl  0x80111ee8
8010152d:	ff 35 e4 1e 11 80    	pushl  0x80111ee4
80101533:	ff 35 e0 1e 11 80    	pushl  0x80111ee0
80101539:	68 b8 7a 10 80       	push   $0x80107ab8
8010153e:	e8 1d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101543:	83 c4 30             	add    $0x30,%esp
80101546:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101549:	c9                   	leave  
8010154a:	c3                   	ret    
8010154b:	90                   	nop
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101550 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101559:	83 3d e8 1e 11 80 01 	cmpl   $0x1,0x80111ee8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101560:	8b 45 0c             	mov    0xc(%ebp),%eax
80101563:	8b 75 08             	mov    0x8(%ebp),%esi
80101566:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101569:	0f 86 91 00 00 00    	jbe    80101600 <ialloc+0xb0>
8010156f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101574:	eb 21                	jmp    80101597 <ialloc+0x47>
80101576:	8d 76 00             	lea    0x0(%esi),%esi
80101579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101580:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101583:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101586:	57                   	push   %edi
80101587:	e8 54 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010158c:	83 c4 10             	add    $0x10,%esp
8010158f:	39 1d e8 1e 11 80    	cmp    %ebx,0x80111ee8
80101595:	76 69                	jbe    80101600 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101597:	89 d8                	mov    %ebx,%eax
80101599:	83 ec 08             	sub    $0x8,%esp
8010159c:	c1 e8 03             	shr    $0x3,%eax
8010159f:	03 05 f4 1e 11 80    	add    0x80111ef4,%eax
801015a5:	50                   	push   %eax
801015a6:	56                   	push   %esi
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
801015ac:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015ae:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801015b0:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
801015b3:	83 e0 07             	and    $0x7,%eax
801015b6:	c1 e0 06             	shl    $0x6,%eax
801015b9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015bd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015c1:	75 bd                	jne    80101580 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015c3:	83 ec 04             	sub    $0x4,%esp
801015c6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015c9:	6a 40                	push   $0x40
801015cb:	6a 00                	push   $0x0
801015cd:	51                   	push   %ecx
801015ce:	e8 ad 2e 00 00       	call   80104480 <memset>
      dip->type = type;
801015d3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015d7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015da:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015dd:	89 3c 24             	mov    %edi,(%esp)
801015e0:	e8 9b 17 00 00       	call   80102d80 <log_write>
      brelse(bp);
801015e5:	89 3c 24             	mov    %edi,(%esp)
801015e8:	e8 f3 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ed:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015f3:	89 da                	mov    %ebx,%edx
801015f5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015f7:	5b                   	pop    %ebx
801015f8:	5e                   	pop    %esi
801015f9:	5f                   	pop    %edi
801015fa:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015fb:	e9 e0 fc ff ff       	jmp    801012e0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101600:	83 ec 0c             	sub    $0xc,%esp
80101603:	68 59 7a 10 80       	push   $0x80107a59
80101608:	e8 63 ed ff ff       	call   80100370 <panic>
8010160d:	8d 76 00             	lea    0x0(%esi),%esi

80101610 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	56                   	push   %esi
80101614:	53                   	push   %ebx
80101615:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101618:	83 ec 08             	sub    $0x8,%esp
8010161b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101621:	c1 e8 03             	shr    $0x3,%eax
80101624:	03 05 f4 1e 11 80    	add    0x80111ef4,%eax
8010162a:	50                   	push   %eax
8010162b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010162e:	e8 9d ea ff ff       	call   801000d0 <bread>
80101633:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101635:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101638:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163c:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010163f:	83 e0 07             	and    $0x7,%eax
80101642:	c1 e0 06             	shl    $0x6,%eax
80101645:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101649:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010164c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101650:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101653:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101657:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010165b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010165f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101663:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101667:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010166a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010166d:	6a 34                	push   $0x34
8010166f:	53                   	push   %ebx
80101670:	50                   	push   %eax
80101671:	e8 ba 2e 00 00       	call   80104530 <memmove>
  log_write(bp);
80101676:	89 34 24             	mov    %esi,(%esp)
80101679:	e8 02 17 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010167e:	89 75 08             	mov    %esi,0x8(%ebp)
80101681:	83 c4 10             	add    $0x10,%esp
}
80101684:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101687:	5b                   	pop    %ebx
80101688:	5e                   	pop    %esi
80101689:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010168a:	e9 51 eb ff ff       	jmp    801001e0 <brelse>
8010168f:	90                   	nop

80101690 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	53                   	push   %ebx
80101694:	83 ec 10             	sub    $0x10,%esp
80101697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010169a:	68 00 1f 11 80       	push   $0x80111f00
8010169f:	e8 dc 2c 00 00       	call   80104380 <acquire>
  ip->ref++;
801016a4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016a8:	c7 04 24 00 1f 11 80 	movl   $0x80111f00,(%esp)
801016af:	e8 7c 2d 00 00       	call   80104430 <release>
  return ip;
}
801016b4:	89 d8                	mov    %ebx,%eax
801016b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016b9:	c9                   	leave  
801016ba:	c3                   	ret    
801016bb:	90                   	nop
801016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016c0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	56                   	push   %esi
801016c4:	53                   	push   %ebx
801016c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801016c8:	85 db                	test   %ebx,%ebx
801016ca:	0f 84 b7 00 00 00    	je     80101787 <ilock+0xc7>
801016d0:	8b 53 08             	mov    0x8(%ebx),%edx
801016d3:	85 d2                	test   %edx,%edx
801016d5:	0f 8e ac 00 00 00    	jle    80101787 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
801016db:	8d 43 0c             	lea    0xc(%ebx),%eax
801016de:	83 ec 0c             	sub    $0xc,%esp
801016e1:	50                   	push   %eax
801016e2:	e8 49 2a 00 00       	call   80104130 <acquiresleep>

  if(ip->valid == 0){
801016e7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ea:	83 c4 10             	add    $0x10,%esp
801016ed:	85 c0                	test   %eax,%eax
801016ef:	74 0f                	je     80101700 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016f4:	5b                   	pop    %ebx
801016f5:	5e                   	pop    %esi
801016f6:	5d                   	pop    %ebp
801016f7:	c3                   	ret    
801016f8:	90                   	nop
801016f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101700:	8b 43 04             	mov    0x4(%ebx),%eax
80101703:	83 ec 08             	sub    $0x8,%esp
80101706:	c1 e8 03             	shr    $0x3,%eax
80101709:	03 05 f4 1e 11 80    	add    0x80111ef4,%eax
8010170f:	50                   	push   %eax
80101710:	ff 33                	pushl  (%ebx)
80101712:	e8 b9 e9 ff ff       	call   801000d0 <bread>
80101717:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101719:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010171c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010171f:	83 e0 07             	and    $0x7,%eax
80101722:	c1 e0 06             	shl    $0x6,%eax
80101725:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101729:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010172c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
8010172f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101733:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101737:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010173b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010173f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101743:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101747:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010174b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010174e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101751:	6a 34                	push   $0x34
80101753:	50                   	push   %eax
80101754:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101757:	50                   	push   %eax
80101758:	e8 d3 2d 00 00       	call   80104530 <memmove>
    brelse(bp);
8010175d:	89 34 24             	mov    %esi,(%esp)
80101760:	e8 7b ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101765:	83 c4 10             	add    $0x10,%esp
80101768:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010176d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101774:	0f 85 77 ff ff ff    	jne    801016f1 <ilock+0x31>
      panic("ilock: no type");
8010177a:	83 ec 0c             	sub    $0xc,%esp
8010177d:	68 71 7a 10 80       	push   $0x80107a71
80101782:	e8 e9 eb ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101787:	83 ec 0c             	sub    $0xc,%esp
8010178a:	68 6b 7a 10 80       	push   $0x80107a6b
8010178f:	e8 dc eb ff ff       	call   80100370 <panic>
80101794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010179a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017a0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	56                   	push   %esi
801017a4:	53                   	push   %ebx
801017a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017a8:	85 db                	test   %ebx,%ebx
801017aa:	74 28                	je     801017d4 <iunlock+0x34>
801017ac:	8d 73 0c             	lea    0xc(%ebx),%esi
801017af:	83 ec 0c             	sub    $0xc,%esp
801017b2:	56                   	push   %esi
801017b3:	e8 18 2a 00 00       	call   801041d0 <holdingsleep>
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 c0                	test   %eax,%eax
801017bd:	74 15                	je     801017d4 <iunlock+0x34>
801017bf:	8b 43 08             	mov    0x8(%ebx),%eax
801017c2:	85 c0                	test   %eax,%eax
801017c4:	7e 0e                	jle    801017d4 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
801017c6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017cc:	5b                   	pop    %ebx
801017cd:	5e                   	pop    %esi
801017ce:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801017cf:	e9 bc 29 00 00       	jmp    80104190 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801017d4:	83 ec 0c             	sub    $0xc,%esp
801017d7:	68 80 7a 10 80       	push   $0x80107a80
801017dc:	e8 8f eb ff ff       	call   80100370 <panic>
801017e1:	eb 0d                	jmp    801017f0 <iput>
801017e3:	90                   	nop
801017e4:	90                   	nop
801017e5:	90                   	nop
801017e6:	90                   	nop
801017e7:	90                   	nop
801017e8:	90                   	nop
801017e9:	90                   	nop
801017ea:	90                   	nop
801017eb:	90                   	nop
801017ec:	90                   	nop
801017ed:	90                   	nop
801017ee:	90                   	nop
801017ef:	90                   	nop

801017f0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 28             	sub    $0x28,%esp
801017f9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017fc:	8d 7e 0c             	lea    0xc(%esi),%edi
801017ff:	57                   	push   %edi
80101800:	e8 2b 29 00 00       	call   80104130 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101805:	8b 56 4c             	mov    0x4c(%esi),%edx
80101808:	83 c4 10             	add    $0x10,%esp
8010180b:	85 d2                	test   %edx,%edx
8010180d:	74 07                	je     80101816 <iput+0x26>
8010180f:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101814:	74 32                	je     80101848 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101816:	83 ec 0c             	sub    $0xc,%esp
80101819:	57                   	push   %edi
8010181a:	e8 71 29 00 00       	call   80104190 <releasesleep>

  acquire(&icache.lock);
8010181f:	c7 04 24 00 1f 11 80 	movl   $0x80111f00,(%esp)
80101826:	e8 55 2b 00 00       	call   80104380 <acquire>
  ip->ref--;
8010182b:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010182f:	83 c4 10             	add    $0x10,%esp
80101832:	c7 45 08 00 1f 11 80 	movl   $0x80111f00,0x8(%ebp)
}
80101839:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183c:	5b                   	pop    %ebx
8010183d:	5e                   	pop    %esi
8010183e:	5f                   	pop    %edi
8010183f:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101840:	e9 eb 2b 00 00       	jmp    80104430 <release>
80101845:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101848:	83 ec 0c             	sub    $0xc,%esp
8010184b:	68 00 1f 11 80       	push   $0x80111f00
80101850:	e8 2b 2b 00 00       	call   80104380 <acquire>
    int r = ip->ref;
80101855:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101858:	c7 04 24 00 1f 11 80 	movl   $0x80111f00,(%esp)
8010185f:	e8 cc 2b 00 00       	call   80104430 <release>
    if(r == 1){
80101864:	83 c4 10             	add    $0x10,%esp
80101867:	83 fb 01             	cmp    $0x1,%ebx
8010186a:	75 aa                	jne    80101816 <iput+0x26>
8010186c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101872:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101875:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101878:	89 cf                	mov    %ecx,%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x97>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101883:	39 fb                	cmp    %edi,%ebx
80101885:	74 19                	je     801018a0 <iput+0xb0>
    if(ip->addrs[i]){
80101887:	8b 13                	mov    (%ebx),%edx
80101889:	85 d2                	test   %edx,%edx
8010188b:	74 f3                	je     80101880 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010188d:	8b 06                	mov    (%esi),%eax
8010188f:	e8 cc f8 ff ff       	call   80101160 <bfree>
      ip->addrs[i] = 0;
80101894:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010189a:	eb e4                	jmp    80101880 <iput+0x90>
8010189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018a0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801018a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018a9:	85 c0                	test   %eax,%eax
801018ab:	75 33                	jne    801018e0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801018ad:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018b0:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801018b7:	56                   	push   %esi
801018b8:	e8 53 fd ff ff       	call   80101610 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801018bd:	31 c0                	xor    %eax,%eax
801018bf:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
801018c3:	89 34 24             	mov    %esi,(%esp)
801018c6:	e8 45 fd ff ff       	call   80101610 <iupdate>
      ip->valid = 0;
801018cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018d2:	83 c4 10             	add    $0x10,%esp
801018d5:	e9 3c ff ff ff       	jmp    80101816 <iput+0x26>
801018da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	83 ec 08             	sub    $0x8,%esp
801018e3:	50                   	push   %eax
801018e4:	ff 36                	pushl  (%esi)
801018e6:	e8 e5 e7 ff ff       	call   801000d0 <bread>
801018eb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018f1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018f7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018fa:	83 c4 10             	add    $0x10,%esp
801018fd:	89 cf                	mov    %ecx,%edi
801018ff:	eb 0e                	jmp    8010190f <iput+0x11f>
80101901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101908:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
8010190b:	39 fb                	cmp    %edi,%ebx
8010190d:	74 0f                	je     8010191e <iput+0x12e>
      if(a[j])
8010190f:	8b 13                	mov    (%ebx),%edx
80101911:	85 d2                	test   %edx,%edx
80101913:	74 f3                	je     80101908 <iput+0x118>
        bfree(ip->dev, a[j]);
80101915:	8b 06                	mov    (%esi),%eax
80101917:	e8 44 f8 ff ff       	call   80101160 <bfree>
8010191c:	eb ea                	jmp    80101908 <iput+0x118>
    }
    brelse(bp);
8010191e:	83 ec 0c             	sub    $0xc,%esp
80101921:	ff 75 e4             	pushl  -0x1c(%ebp)
80101924:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101927:	e8 b4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010192c:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101932:	8b 06                	mov    (%esi),%eax
80101934:	e8 27 f8 ff ff       	call   80101160 <bfree>
    ip->addrs[NDIRECT] = 0;
80101939:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101940:	00 00 00 
80101943:	83 c4 10             	add    $0x10,%esp
80101946:	e9 62 ff ff ff       	jmp    801018ad <iput+0xbd>
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	53                   	push   %ebx
80101954:	83 ec 10             	sub    $0x10,%esp
80101957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010195a:	53                   	push   %ebx
8010195b:	e8 40 fe ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101960:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101963:	83 c4 10             	add    $0x10,%esp
}
80101966:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101969:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010196a:	e9 81 fe ff ff       	jmp    801017f0 <iput>
8010196f:	90                   	nop

80101970 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	8b 55 08             	mov    0x8(%ebp),%edx
80101976:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101979:	8b 0a                	mov    (%edx),%ecx
8010197b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010197e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101981:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101984:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101988:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010198b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010198f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101993:	8b 52 58             	mov    0x58(%edx),%edx
80101996:	89 50 10             	mov    %edx,0x10(%eax)
}
80101999:	5d                   	pop    %ebp
8010199a:	c3                   	ret    
8010199b:	90                   	nop
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 1c             	sub    $0x1c,%esp
801019a9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
801019af:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019b2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019b7:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019ba:	8b 7d 14             	mov    0x14(%ebp),%edi
801019bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019c0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019c3:	0f 84 a7 00 00 00    	je     80101a70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019cc:	8b 40 58             	mov    0x58(%eax),%eax
801019cf:	39 f0                	cmp    %esi,%eax
801019d1:	0f 82 c1 00 00 00    	jb     80101a98 <readi+0xf8>
801019d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019da:	89 fa                	mov    %edi,%edx
801019dc:	01 f2                	add    %esi,%edx
801019de:	0f 82 b4 00 00 00    	jb     80101a98 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019e4:	89 c1                	mov    %eax,%ecx
801019e6:	29 f1                	sub    %esi,%ecx
801019e8:	39 d0                	cmp    %edx,%eax
801019ea:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ed:	31 ff                	xor    %edi,%edi
801019ef:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019f1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f4:	74 6d                	je     80101a63 <readi+0xc3>
801019f6:	8d 76 00             	lea    0x0(%esi),%esi
801019f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a03:	89 f2                	mov    %esi,%edx
80101a05:	c1 ea 09             	shr    $0x9,%edx
80101a08:	89 d8                	mov    %ebx,%eax
80101a0a:	e8 a1 f9 ff ff       	call   801013b0 <bmap>
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	50                   	push   %eax
80101a13:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a15:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a1a:	e8 b1 e6 ff ff       	call   801000d0 <bread>
80101a1f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a24:	89 f1                	mov    %esi,%ecx
80101a26:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101a2c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101a2f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a32:	29 cb                	sub    %ecx,%ebx
80101a34:	29 f8                	sub    %edi,%eax
80101a36:	39 c3                	cmp    %eax,%ebx
80101a38:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a3b:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101a3f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a40:	01 df                	add    %ebx,%edi
80101a42:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a44:	50                   	push   %eax
80101a45:	ff 75 e0             	pushl  -0x20(%ebp)
80101a48:	e8 e3 2a 00 00       	call   80104530 <memmove>
    brelse(bp);
80101a4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a50:	89 14 24             	mov    %edx,(%esp)
80101a53:	e8 88 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a58:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a5b:	83 c4 10             	add    $0x10,%esp
80101a5e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a61:	77 9d                	ja     80101a00 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a69:	5b                   	pop    %ebx
80101a6a:	5e                   	pop    %esi
80101a6b:	5f                   	pop    %edi
80101a6c:	5d                   	pop    %ebp
80101a6d:	c3                   	ret    
80101a6e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a74:	66 83 f8 09          	cmp    $0x9,%ax
80101a78:	77 1e                	ja     80101a98 <readi+0xf8>
80101a7a:	8b 04 c5 80 1e 11 80 	mov    -0x7feee180(,%eax,8),%eax
80101a81:	85 c0                	test   %eax,%eax
80101a83:	74 13                	je     80101a98 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a85:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a8b:	5b                   	pop    %ebx
80101a8c:	5e                   	pop    %esi
80101a8d:	5f                   	pop    %edi
80101a8e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a8f:	ff e0                	jmp    *%eax
80101a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a9d:	eb c7                	jmp    80101a66 <readi+0xc6>
80101a9f:	90                   	nop

80101aa0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aaf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ab7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101abd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ac0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ac3:	0f 84 b7 00 00 00    	je     80101b80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	39 70 58             	cmp    %esi,0x58(%eax)
80101acf:	0f 82 eb 00 00 00    	jb     80101bc0 <writei+0x120>
80101ad5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101adc:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ae1:	0f 87 d9 00 00 00    	ja     80101bc0 <writei+0x120>
80101ae7:	39 c6                	cmp    %eax,%esi
80101ae9:	0f 87 d1 00 00 00    	ja     80101bc0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aef:	85 ff                	test   %edi,%edi
80101af1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101af8:	74 78                	je     80101b72 <writei+0xd2>
80101afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b03:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b05:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b0a:	c1 ea 09             	shr    $0x9,%edx
80101b0d:	89 f8                	mov    %edi,%eax
80101b0f:	e8 9c f8 ff ff       	call   801013b0 <bmap>
80101b14:	83 ec 08             	sub    $0x8,%esp
80101b17:	50                   	push   %eax
80101b18:	ff 37                	pushl  (%edi)
80101b1a:	e8 b1 e5 ff ff       	call   801000d0 <bread>
80101b1f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b24:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101b27:	89 f1                	mov    %esi,%ecx
80101b29:	83 c4 0c             	add    $0xc,%esp
80101b2c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101b32:	29 cb                	sub    %ecx,%ebx
80101b34:	39 c3                	cmp    %eax,%ebx
80101b36:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b39:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101b3d:	53                   	push   %ebx
80101b3e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b41:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101b43:	50                   	push   %eax
80101b44:	e8 e7 29 00 00       	call   80104530 <memmove>
    log_write(bp);
80101b49:	89 3c 24             	mov    %edi,(%esp)
80101b4c:	e8 2f 12 00 00       	call   80102d80 <log_write>
    brelse(bp);
80101b51:	89 3c 24             	mov    %edi,(%esp)
80101b54:	e8 87 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b59:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b5c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b5f:	83 c4 10             	add    $0x10,%esp
80101b62:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b65:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b68:	77 96                	ja     80101b00 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b6a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b70:	77 36                	ja     80101ba8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b72:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b78:	5b                   	pop    %ebx
80101b79:	5e                   	pop    %esi
80101b7a:	5f                   	pop    %edi
80101b7b:	5d                   	pop    %ebp
80101b7c:	c3                   	ret    
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b84:	66 83 f8 09          	cmp    $0x9,%ax
80101b88:	77 36                	ja     80101bc0 <writei+0x120>
80101b8a:	8b 04 c5 84 1e 11 80 	mov    -0x7feee17c(,%eax,8),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 2b                	je     80101bc0 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b95:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9b:	5b                   	pop    %ebx
80101b9c:	5e                   	pop    %esi
80101b9d:	5f                   	pop    %edi
80101b9e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b9f:	ff e0                	jmp    *%eax
80101ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101bab:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101bae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101bb1:	50                   	push   %eax
80101bb2:	e8 59 fa ff ff       	call   80101610 <iupdate>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	eb b6                	jmp    80101b72 <writei+0xd2>
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc5:	eb ae                	jmp    80101b75 <writei+0xd5>
80101bc7:	89 f6                	mov    %esi,%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bd6:	6a 1e                	push   $0x1e
80101bd8:	ff 75 0c             	pushl  0xc(%ebp)
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 cd 29 00 00       	call   801045b0 <strncmp>
}
80101be3:	c9                   	leave  
80101be4:	c3                   	ret    
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 2c             	sub    $0x2c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c01:	0f 85 80 00 00 00    	jne    80101c87 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 58             	mov    0x58(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 c8             	lea    -0x38(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	75 0d                	jne    80101c20 <dirlookup+0x30>
80101c13:	eb 5b                	jmp    80101c70 <dirlookup+0x80>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
80101c18:	83 c7 20             	add    $0x20,%edi
80101c1b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c1e:	76 50                	jbe    80101c70 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c20:	6a 20                	push   $0x20
80101c22:	57                   	push   %edi
80101c23:	56                   	push   %esi
80101c24:	53                   	push   %ebx
80101c25:	e8 76 fd ff ff       	call   801019a0 <readi>
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	83 f8 20             	cmp    $0x20,%eax
80101c30:	75 48                	jne    80101c7a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101c32:	66 83 7d c8 00       	cmpw   $0x0,-0x38(%ebp)
80101c37:	74 df                	je     80101c18 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101c39:	8d 45 ca             	lea    -0x36(%ebp),%eax
80101c3c:	83 ec 04             	sub    $0x4,%esp
80101c3f:	6a 1e                	push   $0x1e
80101c41:	50                   	push   %eax
80101c42:	ff 75 0c             	pushl  0xc(%ebp)
80101c45:	e8 66 29 00 00       	call   801045b0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101c4a:	83 c4 10             	add    $0x10,%esp
80101c4d:	85 c0                	test   %eax,%eax
80101c4f:	75 c7                	jne    80101c18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c51:	8b 45 10             	mov    0x10(%ebp),%eax
80101c54:	85 c0                	test   %eax,%eax
80101c56:	74 05                	je     80101c5d <dirlookup+0x6d>
        *poff = off;
80101c58:	8b 45 10             	mov    0x10(%ebp),%eax
80101c5b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c5d:	0f b7 55 c8          	movzwl -0x38(%ebp),%edx
80101c61:	8b 03                	mov    (%ebx),%eax
80101c63:	e8 78 f6 ff ff       	call   801012e0 <iget>
    }
  }

  return 0;
}
80101c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
80101c6f:	c3                   	ret    
80101c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c73:	31 c0                	xor    %eax,%eax
}
80101c75:	5b                   	pop    %ebx
80101c76:	5e                   	pop    %esi
80101c77:	5f                   	pop    %edi
80101c78:	5d                   	pop    %ebp
80101c79:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c7a:	83 ec 0c             	sub    $0xc,%esp
80101c7d:	68 9a 7a 10 80       	push   $0x80107a9a
80101c82:	e8 e9 e6 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c87:	83 ec 0c             	sub    $0xc,%esp
80101c8a:	68 88 7a 10 80       	push   $0x80107a88
80101c8f:	e8 dc e6 ff ff       	call   80100370 <panic>
80101c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101ca0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	89 cf                	mov    %ecx,%edi
80101ca8:	89 c3                	mov    %eax,%ebx
80101caa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cad:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101cb3:	0f 84 53 01 00 00    	je     80101e0c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cb9:	e8 12 1b 00 00       	call   801037d0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cbe:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cc1:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cc4:	68 00 1f 11 80       	push   $0x80111f00
80101cc9:	e8 b2 26 00 00       	call   80104380 <acquire>
  ip->ref++;
80101cce:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cd2:	c7 04 24 00 1f 11 80 	movl   $0x80111f00,(%esp)
80101cd9:	e8 52 27 00 00       	call   80104430 <release>
80101cde:	83 c4 10             	add    $0x10,%esp
80101ce1:	eb 08                	jmp    80101ceb <namex+0x4b>
80101ce3:	90                   	nop
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101ce8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101ceb:	0f b6 03             	movzbl (%ebx),%eax
80101cee:	3c 2f                	cmp    $0x2f,%al
80101cf0:	74 f6                	je     80101ce8 <namex+0x48>
    path++;
  if(*path == 0)
80101cf2:	84 c0                	test   %al,%al
80101cf4:	0f 84 e3 00 00 00    	je     80101ddd <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cfa:	0f b6 03             	movzbl (%ebx),%eax
80101cfd:	89 da                	mov    %ebx,%edx
80101cff:	84 c0                	test   %al,%al
80101d01:	0f 84 ac 00 00 00    	je     80101db3 <namex+0x113>
80101d07:	3c 2f                	cmp    $0x2f,%al
80101d09:	75 09                	jne    80101d14 <namex+0x74>
80101d0b:	e9 a3 00 00 00       	jmp    80101db3 <namex+0x113>
80101d10:	84 c0                	test   %al,%al
80101d12:	74 0a                	je     80101d1e <namex+0x7e>
    path++;
80101d14:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d17:	0f b6 02             	movzbl (%edx),%eax
80101d1a:	3c 2f                	cmp    $0x2f,%al
80101d1c:	75 f2                	jne    80101d10 <namex+0x70>
80101d1e:	89 d1                	mov    %edx,%ecx
80101d20:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d22:	83 f9 1d             	cmp    $0x1d,%ecx
80101d25:	0f 8e 8d 00 00 00    	jle    80101db8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d2b:	83 ec 04             	sub    $0x4,%esp
80101d2e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d31:	6a 1e                	push   $0x1e
80101d33:	53                   	push   %ebx
80101d34:	57                   	push   %edi
80101d35:	e8 f6 27 00 00       	call   80104530 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101d3d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d40:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d42:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d45:	75 11                	jne    80101d58 <namex+0xb8>
80101d47:	89 f6                	mov    %esi,%esi
80101d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d50:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d56:	74 f8                	je     80101d50 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d58:	83 ec 0c             	sub    $0xc,%esp
80101d5b:	56                   	push   %esi
80101d5c:	e8 5f f9 ff ff       	call   801016c0 <ilock>
    if(ip->type != T_DIR){
80101d61:	83 c4 10             	add    $0x10,%esp
80101d64:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d69:	0f 85 7f 00 00 00    	jne    80101dee <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d72:	85 d2                	test   %edx,%edx
80101d74:	74 09                	je     80101d7f <namex+0xdf>
80101d76:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d79:	0f 84 a3 00 00 00    	je     80101e22 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d7f:	83 ec 04             	sub    $0x4,%esp
80101d82:	6a 00                	push   $0x0
80101d84:	57                   	push   %edi
80101d85:	56                   	push   %esi
80101d86:	e8 65 fe ff ff       	call   80101bf0 <dirlookup>
80101d8b:	83 c4 10             	add    $0x10,%esp
80101d8e:	85 c0                	test   %eax,%eax
80101d90:	74 5c                	je     80101dee <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d92:	83 ec 0c             	sub    $0xc,%esp
80101d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d98:	56                   	push   %esi
80101d99:	e8 02 fa ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101d9e:	89 34 24             	mov    %esi,(%esp)
80101da1:	e8 4a fa ff ff       	call   801017f0 <iput>
80101da6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101da9:	83 c4 10             	add    $0x10,%esp
80101dac:	89 c6                	mov    %eax,%esi
80101dae:	e9 38 ff ff ff       	jmp    80101ceb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101db3:	31 c9                	xor    %ecx,%ecx
80101db5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101db8:	83 ec 04             	sub    $0x4,%esp
80101dbb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dbe:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dc1:	51                   	push   %ecx
80101dc2:	53                   	push   %ebx
80101dc3:	57                   	push   %edi
80101dc4:	e8 67 27 00 00       	call   80104530 <memmove>
    name[len] = 0;
80101dc9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dd6:	89 d3                	mov    %edx,%ebx
80101dd8:	e9 65 ff ff ff       	jmp    80101d42 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ddd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101de0:	85 c0                	test   %eax,%eax
80101de2:	75 54                	jne    80101e38 <namex+0x198>
80101de4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	5b                   	pop    %ebx
80101dea:	5e                   	pop    %esi
80101deb:	5f                   	pop    %edi
80101dec:	5d                   	pop    %ebp
80101ded:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dee:	83 ec 0c             	sub    $0xc,%esp
80101df1:	56                   	push   %esi
80101df2:	e8 a9 f9 ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101df7:	89 34 24             	mov    %esi,(%esp)
80101dfa:	e8 f1 f9 ff ff       	call   801017f0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101dff:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101e05:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e0c:	ba 01 00 00 00       	mov    $0x1,%edx
80101e11:	b8 01 00 00 00       	mov    $0x1,%eax
80101e16:	e8 c5 f4 ff ff       	call   801012e0 <iget>
80101e1b:	89 c6                	mov    %eax,%esi
80101e1d:	e9 c9 fe ff ff       	jmp    80101ceb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e22:	83 ec 0c             	sub    $0xc,%esp
80101e25:	56                   	push   %esi
80101e26:	e8 75 f9 ff ff       	call   801017a0 <iunlock>
      return ip;
80101e2b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e31:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e33:	5b                   	pop    %ebx
80101e34:	5e                   	pop    %esi
80101e35:	5f                   	pop    %edi
80101e36:	5d                   	pop    %ebp
80101e37:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e38:	83 ec 0c             	sub    $0xc,%esp
80101e3b:	56                   	push   %esi
80101e3c:	e8 af f9 ff ff       	call   801017f0 <iput>
    return 0;
80101e41:	83 c4 10             	add    $0x10,%esp
80101e44:	31 c0                	xor    %eax,%eax
80101e46:	eb 9e                	jmp    80101de6 <namex+0x146>
80101e48:	90                   	nop
80101e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e50 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 30             	sub    $0x30,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	6a 00                	push   $0x0
80101e5e:	ff 75 0c             	pushl  0xc(%ebp)
80101e61:	53                   	push   %ebx
80101e62:	e8 89 fd ff ff       	call   80101bf0 <dirlookup>
80101e67:	83 c4 10             	add    $0x10,%esp
80101e6a:	85 c0                	test   %eax,%eax
80101e6c:	75 67                	jne    80101ed5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e6e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e71:	8d 75 c8             	lea    -0x38(%ebp),%esi
80101e74:	85 ff                	test   %edi,%edi
80101e76:	74 29                	je     80101ea1 <dirlink+0x51>
80101e78:	31 ff                	xor    %edi,%edi
80101e7a:	8d 75 c8             	lea    -0x38(%ebp),%esi
80101e7d:	eb 09                	jmp    80101e88 <dirlink+0x38>
80101e7f:	90                   	nop
80101e80:	83 c7 20             	add    $0x20,%edi
80101e83:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e86:	76 19                	jbe    80101ea1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e88:	6a 20                	push   $0x20
80101e8a:	57                   	push   %edi
80101e8b:	56                   	push   %esi
80101e8c:	53                   	push   %ebx
80101e8d:	e8 0e fb ff ff       	call   801019a0 <readi>
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	83 f8 20             	cmp    $0x20,%eax
80101e98:	75 4e                	jne    80101ee8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e9a:	66 83 7d c8 00       	cmpw   $0x0,-0x38(%ebp)
80101e9f:	75 df                	jne    80101e80 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101ea1:	8d 45 ca             	lea    -0x36(%ebp),%eax
80101ea4:	83 ec 04             	sub    $0x4,%esp
80101ea7:	6a 1e                	push   $0x1e
80101ea9:	ff 75 0c             	pushl  0xc(%ebp)
80101eac:	50                   	push   %eax
80101ead:	e8 6e 27 00 00       	call   80104620 <strncpy>
  de.inum = inum;
80101eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eb5:	6a 20                	push   $0x20
80101eb7:	57                   	push   %edi
80101eb8:	56                   	push   %esi
80101eb9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101eba:	66 89 45 c8          	mov    %ax,-0x38(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ebe:	e8 dd fb ff ff       	call   80101aa0 <writei>
80101ec3:	83 c4 20             	add    $0x20,%esp
80101ec6:	83 f8 20             	cmp    $0x20,%eax
80101ec9:	75 2a                	jne    80101ef5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101ecb:	31 c0                	xor    %eax,%eax
}
80101ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed0:	5b                   	pop    %ebx
80101ed1:	5e                   	pop    %esi
80101ed2:	5f                   	pop    %edi
80101ed3:	5d                   	pop    %ebp
80101ed4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	50                   	push   %eax
80101ed9:	e8 12 f9 ff ff       	call   801017f0 <iput>
    return -1;
80101ede:	83 c4 10             	add    $0x10,%esp
80101ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee6:	eb e5                	jmp    80101ecd <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101ee8:	83 ec 0c             	sub    $0xc,%esp
80101eeb:	68 a9 7a 10 80       	push   $0x80107aa9
80101ef0:	e8 7b e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 da 80 10 80       	push   $0x801080da
80101efd:	e8 6e e4 ff ff       	call   80100370 <panic>
80101f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f10:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f11:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f13:	89 e5                	mov    %esp,%ebp
80101f15:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f18:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1b:	8d 4d da             	lea    -0x26(%ebp),%ecx
80101f1e:	e8 7d fd ff ff       	call   80101ca0 <namex>
}
80101f23:	c9                   	leave  
80101f24:	c3                   	ret    
80101f25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f30 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f30:	55                   	push   %ebp
  return namex(path, 1, name);
80101f31:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f36:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f3e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f3f:	e9 5c fd ff ff       	jmp    80101ca0 <namex>
80101f44:	66 90                	xchg   %ax,%ax
80101f46:	66 90                	xchg   %ax,%ax
80101f48:	66 90                	xchg   %ax,%ax
80101f4a:	66 90                	xchg   %ax,%ax
80101f4c:	66 90                	xchg   %ax,%ax
80101f4e:	66 90                	xchg   %ax,%ax

80101f50 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f50:	55                   	push   %ebp
  if(b == 0)
80101f51:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f53:	89 e5                	mov    %esp,%ebp
80101f55:	56                   	push   %esi
80101f56:	53                   	push   %ebx
  if(b == 0)
80101f57:	0f 84 ad 00 00 00    	je     8010200a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f5d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f60:	89 c1                	mov    %eax,%ecx
80101f62:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f68:	0f 87 8f 00 00 00    	ja     80101ffd <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f6e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f73:	90                   	nop
80101f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f78:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f79:	83 e0 c0             	and    $0xffffffc0,%eax
80101f7c:	3c 40                	cmp    $0x40,%al
80101f7e:	75 f8                	jne    80101f78 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f80:	31 f6                	xor    %esi,%esi
80101f82:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f87:	89 f0                	mov    %esi,%eax
80101f89:	ee                   	out    %al,(%dx)
80101f8a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f94:	ee                   	out    %al,(%dx)
80101f95:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f9a:	89 d8                	mov    %ebx,%eax
80101f9c:	ee                   	out    %al,(%dx)
80101f9d:	89 d8                	mov    %ebx,%eax
80101f9f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fa4:	c1 f8 08             	sar    $0x8,%eax
80101fa7:	ee                   	out    %al,(%dx)
80101fa8:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fad:	89 f0                	mov    %esi,%eax
80101faf:	ee                   	out    %al,(%dx)
80101fb0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101fb4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb9:	83 e0 01             	and    $0x1,%eax
80101fbc:	c1 e0 04             	shl    $0x4,%eax
80101fbf:	83 c8 e0             	or     $0xffffffe0,%eax
80101fc2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101fc3:	f6 01 04             	testb  $0x4,(%ecx)
80101fc6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fcb:	75 13                	jne    80101fe0 <idestart+0x90>
80101fcd:	b8 20 00 00 00       	mov    $0x20,%eax
80101fd2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fd6:	5b                   	pop    %ebx
80101fd7:	5e                   	pop    %esi
80101fd8:	5d                   	pop    %ebp
80101fd9:	c3                   	ret    
80101fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fe0:	b8 30 00 00 00       	mov    $0x30,%eax
80101fe5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101fe6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101feb:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101fee:	b9 80 00 00 00       	mov    $0x80,%ecx
80101ff3:	fc                   	cld    
80101ff4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101ff6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ff9:	5b                   	pop    %ebx
80101ffa:	5e                   	pop    %esi
80101ffb:	5d                   	pop    %ebp
80101ffc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101ffd:	83 ec 0c             	sub    $0xc,%esp
80102000:	68 14 7b 10 80       	push   $0x80107b14
80102005:	e8 66 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010200a:	83 ec 0c             	sub    $0xc,%esp
8010200d:	68 0b 7b 10 80       	push   $0x80107b0b
80102012:	e8 59 e3 ff ff       	call   80100370 <panic>
80102017:	89 f6                	mov    %esi,%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102026:	68 26 7b 10 80       	push   $0x80107b26
8010202b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102030:	e8 eb 21 00 00       	call   80104220 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 20 42 11 80       	mov    0x80114220,%eax
8010203b:	5a                   	pop    %edx
8010203c:	83 e8 01             	sub    $0x1,%eax
8010203f:	50                   	push   %eax
80102040:	6a 0e                	push   $0xe
80102042:	e8 a9 02 00 00       	call   801022f0 <ioapicenable>
80102047:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204f:	90                   	nop
80102050:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010205d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x55>
8010206f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x64>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x50>
      havedisk1 = 1;
8010207a:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80102081:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102089:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010208e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 c0 b5 10 80       	push   $0x8010b5c0
801020ae:	e8 cd 22 00 00       	call   80104380 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 34                	je     801020f4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 33                	mov    (%ebx),%esi
801020ca:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020d0:	74 3e                	je     80102110 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020d2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801020d5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020d8:	83 ce 02             	or     $0x2,%esi
801020db:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020dd:	53                   	push   %ebx
801020de:	e8 5d 1e 00 00       	call   80103f40 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020e3:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
801020e8:	83 c4 10             	add    $0x10,%esp
801020eb:	85 c0                	test   %eax,%eax
801020ed:	74 05                	je     801020f4 <ideintr+0x54>
    idestart(idequeue);
801020ef:	e8 5c fe ff ff       	call   80101f50 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	68 c0 b5 10 80       	push   $0x8010b5c0
801020fc:	e8 2f 23 00 00       	call   80104430 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102101:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102104:	5b                   	pop    %ebx
80102105:	5e                   	pop    %esi
80102106:	5f                   	pop    %edi
80102107:	5d                   	pop    %ebp
80102108:	c3                   	ret    
80102109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102110:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102115:	8d 76 00             	lea    0x0(%esi),%esi
80102118:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102119:	89 c1                	mov    %eax,%ecx
8010211b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010211e:	80 f9 40             	cmp    $0x40,%cl
80102121:	75 f5                	jne    80102118 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102123:	a8 21                	test   $0x21,%al
80102125:	75 ab                	jne    801020d2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102127:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010212a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010212f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102134:	fc                   	cld    
80102135:	f3 6d                	rep insl (%dx),%es:(%edi)
80102137:	8b 33                	mov    (%ebx),%esi
80102139:	eb 97                	jmp    801020d2 <ideintr+0x32>
8010213b:	90                   	nop
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 7d 20 00 00       	call   801041d0 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 ad 00 00 00    	je     8010220b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 b9 00 00 00    	je     80102225 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 98 00 00 00    	je     80102218 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 c0 b5 10 80       	push   $0x8010b5c0
80102188:	e8 f3 21 00 00       	call   80104380 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
80102193:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 58                	jmp    801021fb <iderw+0xbb>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	3b 1d a4 b5 10 80    	cmp    0x8010b5a4,%ebx
801021bc:	74 44                	je     80102202 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 c0 b5 10 80       	push   $0x8010b5c0
801021d8:	53                   	push   %ebx
801021d9:	e8 a2 1b 00 00       	call   80103d80 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801021eb:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801021f6:	e9 35 22 00 00       	jmp    80104430 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021fb:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
80102200:	eb b2                	jmp    801021b4 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102202:	89 d8                	mov    %ebx,%eax
80102204:	e8 47 fd ff ff       	call   80101f50 <idestart>
80102209:	eb b3                	jmp    801021be <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010220b:	83 ec 0c             	sub    $0xc,%esp
8010220e:	68 2a 7b 10 80       	push   $0x80107b2a
80102213:	e8 58 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 55 7b 10 80       	push   $0x80107b55
80102220:	e8 4b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	68 40 7b 10 80       	push   $0x80107b40
8010222d:	e8 3e e1 ff ff       	call   80100370 <panic>
80102232:	66 90                	xchg   %ax,%ax
80102234:	66 90                	xchg   %ax,%ax
80102236:	66 90                	xchg   %ax,%ax
80102238:	66 90                	xchg   %ax,%ax
8010223a:	66 90                	xchg   %ax,%ax
8010223c:	66 90                	xchg   %ax,%ax
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102241:	c7 05 54 3b 11 80 00 	movl   $0xfec00000,0x80113b54
80102248:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	8b 15 54 3b 11 80    	mov    0x80113b54,%edx
8010225f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102262:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102268:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226e:	0f b6 15 80 3c 11 80 	movzbl 0x80113c80,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102275:	89 f0                	mov    %esi,%eax
80102277:	c1 e8 10             	shr    $0x10,%eax
8010227a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010227d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102280:	c1 e8 18             	shr    $0x18,%eax
80102283:	39 d0                	cmp    %edx,%eax
80102285:	74 16                	je     8010229d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102287:	83 ec 0c             	sub    $0xc,%esp
8010228a:	68 74 7b 10 80       	push   $0x80107b74
8010228f:	e8 cc e3 ff ff       	call   80100660 <cprintf>
80102294:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
8010229a:	83 c4 10             	add    $0x10,%esp
8010229d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022a0:	ba 10 00 00 00       	mov    $0x10,%edx
801022a5:	b8 20 00 00 00       	mov    $0x20,%eax
801022aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022b2:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022b8:	89 c3                	mov    %eax,%ebx
801022ba:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801022c0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022c3:	89 59 10             	mov    %ebx,0x10(%ecx)
801022c6:	8d 5a 01             	lea    0x1(%edx),%ebx
801022c9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022cc:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ce:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801022d0:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
801022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022dd:	75 d1                	jne    801022b0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e2:	5b                   	pop    %ebx
801022e3:	5e                   	pop    %esi
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022f0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022f1:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022fc:	8d 50 20             	lea    0x20(%eax),%edx
801022ff:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102303:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102305:	8b 0d 54 3b 11 80    	mov    0x80113b54,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 54 3b 11 80       	mov    0x80113b54,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010231e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102321:	5d                   	pop    %ebp
80102322:	c3                   	ret    
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 04             	sub    $0x4,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 70                	jne    801023b2 <kfree+0x82>
80102342:	81 fb c8 69 11 80    	cmp    $0x801169c8,%ebx
80102348:	72 68                	jb     801023b2 <kfree+0x82>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 5b                	ja     801023b2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	68 00 10 00 00       	push   $0x1000
8010235f:	6a 01                	push   $0x1
80102361:	53                   	push   %ebx
80102362:	e8 19 21 00 00       	call   80104480 <memset>

  if(kmem.use_lock)
80102367:	8b 15 94 3b 11 80    	mov    0x80113b94,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 98 3b 11 80       	mov    0x80113b98,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 94 3b 11 80       	mov    0x80113b94,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102380:	89 1d 98 3b 11 80    	mov    %ebx,0x80113b98
  if(kmem.use_lock)
80102386:	85 c0                	test   %eax,%eax
80102388:	75 06                	jne    80102390 <kfree+0x60>
    release(&kmem.lock);
}
8010238a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    
8010238f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102390:	c7 45 08 60 3b 11 80 	movl   $0x80113b60,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010239b:	e9 90 20 00 00       	jmp    80104430 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 60 3b 11 80       	push   $0x80113b60
801023a8:	e8 d3 1f 00 00       	call   80104380 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 a6 7b 10 80       	push   $0x80107ba6
801023ba:	e8 b1 df ff ff       	call   80100370 <panic>
801023bf:	90                   	nop

801023c0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 33 ff ff ff       	call   80102330 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
    kfree(p);
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 ac 7b 10 80       	push   $0x80107bac
80102420:	68 60 3b 11 80       	push   $0x80113b60
80102425:	e8 f6 1d 00 00       	call   80104220 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102430:	c7 05 94 3b 11 80 00 	movl   $0x0,0x80113b94
80102437:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 1c                	jb     8010246c <kinit1+0x5c>
    kfree(p);
80102450:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102456:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102459:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010245f:	50                   	push   %eax
80102460:	e8 cb fe ff ff       	call   80102330 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	39 de                	cmp    %ebx,%esi
8010246a:	73 e4                	jae    80102450 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010246c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246f:	5b                   	pop    %ebx
80102470:	5e                   	pop    %esi
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102488:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <kinit2+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 73 fe ff ff       	call   80102330 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 e4                	jae    801024a8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024c4:	c7 05 94 3b 11 80 01 	movl   $0x1,0x80113b94
801024cb:	00 00 00 
}
801024ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d1:	5b                   	pop    %ebx
801024d2:	5e                   	pop    %esi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024e0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	53                   	push   %ebx
801024e4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801024e7:	a1 94 3b 11 80       	mov    0x80113b94,%eax
801024ec:	85 c0                	test   %eax,%eax
801024ee:	75 30                	jne    80102520 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024f0:	8b 1d 98 3b 11 80    	mov    0x80113b98,%ebx
  if(r)
801024f6:	85 db                	test   %ebx,%ebx
801024f8:	74 1c                	je     80102516 <kalloc+0x36>
    kmem.freelist = r->next;
801024fa:	8b 13                	mov    (%ebx),%edx
801024fc:	89 15 98 3b 11 80    	mov    %edx,0x80113b98
  if(kmem.use_lock)
80102502:	85 c0                	test   %eax,%eax
80102504:	74 10                	je     80102516 <kalloc+0x36>
    release(&kmem.lock);
80102506:	83 ec 0c             	sub    $0xc,%esp
80102509:	68 60 3b 11 80       	push   $0x80113b60
8010250e:	e8 1d 1f 00 00       	call   80104430 <release>
80102513:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102516:	89 d8                	mov    %ebx,%eax
80102518:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251b:	c9                   	leave  
8010251c:	c3                   	ret    
8010251d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 60 3b 11 80       	push   $0x80113b60
80102528:	e8 53 1e 00 00       	call   80104380 <acquire>
  r = kmem.freelist;
8010252d:	8b 1d 98 3b 11 80    	mov    0x80113b98,%ebx
  if(r)
80102533:	83 c4 10             	add    $0x10,%esp
80102536:	a1 94 3b 11 80       	mov    0x80113b94,%eax
8010253b:	85 db                	test   %ebx,%ebx
8010253d:	75 bb                	jne    801024fa <kalloc+0x1a>
8010253f:	eb c1                	jmp    80102502 <kalloc+0x22>
80102541:	66 90                	xchg   %ax,%ax
80102543:	66 90                	xchg   %ax,%ax
80102545:	66 90                	xchg   %ax,%ax
80102547:	66 90                	xchg   %ax,%ax
80102549:	66 90                	xchg   %ax,%ax
8010254b:	66 90                	xchg   %ax,%ax
8010254d:	66 90                	xchg   %ax,%ax
8010254f:	90                   	nop

80102550 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102550:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102551:	ba 64 00 00 00       	mov    $0x64,%edx
80102556:	89 e5                	mov    %esp,%ebp
80102558:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102559:	a8 01                	test   $0x1,%al
8010255b:	0f 84 af 00 00 00    	je     80102610 <kbdgetc+0xc0>
80102561:	ba 60 00 00 00       	mov    $0x60,%edx
80102566:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102567:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010256a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102570:	74 7e                	je     801025f0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102572:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102574:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010257a:	79 24                	jns    801025a0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010257c:	f6 c1 40             	test   $0x40,%cl
8010257f:	75 05                	jne    80102586 <kbdgetc+0x36>
80102581:	89 c2                	mov    %eax,%edx
80102583:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102586:	0f b6 82 e0 7c 10 80 	movzbl -0x7fef8320(%edx),%eax
8010258d:	83 c8 40             	or     $0x40,%eax
80102590:	0f b6 c0             	movzbl %al,%eax
80102593:	f7 d0                	not    %eax
80102595:	21 c8                	and    %ecx,%eax
80102597:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
    return 0;
8010259c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010259e:	5d                   	pop    %ebp
8010259f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801025a0:	f6 c1 40             	test   $0x40,%cl
801025a3:	74 09                	je     801025ae <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025a5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801025a8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025ab:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025ae:	0f b6 82 e0 7c 10 80 	movzbl -0x7fef8320(%edx),%eax
801025b5:	09 c1                	or     %eax,%ecx
801025b7:	0f b6 82 e0 7b 10 80 	movzbl -0x7fef8420(%edx),%eax
801025be:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025c0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025c2:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
801025c8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025cb:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025ce:	8b 04 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%eax
801025d5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025d9:	74 c3                	je     8010259e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801025db:	8d 50 9f             	lea    -0x61(%eax),%edx
801025de:	83 fa 19             	cmp    $0x19,%edx
801025e1:	77 1d                	ja     80102600 <kbdgetc+0xb0>
      c += 'A' - 'a';
801025e3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025e6:	5d                   	pop    %ebp
801025e7:	c3                   	ret    
801025e8:	90                   	nop
801025e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801025f0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025f2:	83 0d f4 b5 10 80 40 	orl    $0x40,0x8010b5f4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025f9:	5d                   	pop    %ebp
801025fa:	c3                   	ret    
801025fb:	90                   	nop
801025fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102600:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102603:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102606:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102607:	83 f9 19             	cmp    $0x19,%ecx
8010260a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010260d:	c3                   	ret    
8010260e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	89 f6                	mov    %esi,%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kbdintr>:

void
kbdintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102626:	68 50 25 10 80       	push   $0x80102550
8010262b:	e8 c0 e1 ff ff       	call   801007f0 <consoleintr>
}
80102630:	83 c4 10             	add    $0x10,%esp
80102633:	c9                   	leave  
80102634:	c3                   	ret    
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102640:	a1 9c 3b 11 80       	mov    0x80113b9c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102645:	55                   	push   %ebp
80102646:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 c8 00 00 00    	je     80102718 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102650:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102657:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010265d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102664:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102667:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010266a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102671:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102674:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102677:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010267e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102681:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102684:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010268b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102691:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269e:	8b 50 30             	mov    0x30(%eax),%edx
801026a1:	c1 ea 10             	shr    $0x10,%edx
801026a4:	80 fa 03             	cmp    $0x3,%dl
801026a7:	77 77                	ja     80102720 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b3:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026cd:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102700:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102706:	80 e6 10             	and    $0x10,%dh
80102709:	75 f5                	jne    80102700 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102712:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102715:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102718:	5d                   	pop    %ebp
80102719:	c3                   	ret    
8010271a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102720:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102727:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
8010272d:	e9 77 ff ff ff       	jmp    801026a9 <lapicinit+0x69>
80102732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102740:	a1 9c 3b 11 80       	mov    0x80113b9c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102745:	55                   	push   %ebp
80102746:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102748:	85 c0                	test   %eax,%eax
8010274a:	74 0c                	je     80102758 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010274c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010274f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102750:	c1 e8 18             	shr    $0x18,%eax
}
80102753:	c3                   	ret    
80102754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102758:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010275a:	5d                   	pop    %ebp
8010275b:	c3                   	ret    
8010275c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102760 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102760:	a1 9c 3b 11 80       	mov    0x80113b9c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0d                	je     80102779 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102773:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102776:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102779:	5d                   	pop    %ebp
8010277a:	c3                   	ret    
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
}
80102783:	5d                   	pop    %ebp
80102784:	c3                   	ret    
80102785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102790:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102791:	ba 70 00 00 00       	mov    $0x70,%edx
80102796:	b8 0f 00 00 00       	mov    $0xf,%eax
8010279b:	89 e5                	mov    %esp,%ebp
8010279d:	53                   	push   %ebx
8010279e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027a4:	ee                   	out    %al,(%dx)
801027a5:	ba 71 00 00 00       	mov    $0x71,%edx
801027aa:	b8 0a 00 00 00       	mov    $0xa,%eax
801027af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b0:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b2:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027bd:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027c0:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027c5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ce:	a1 9c 3b 11 80       	mov    0x80113b9c,%eax
801027d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102805:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102808:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102811:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010281a:	5b                   	pop    %ebx
8010281b:	5d                   	pop    %ebp
8010281c:	c3                   	ret    
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102820:	55                   	push   %ebp
80102821:	ba 70 00 00 00       	mov    $0x70,%edx
80102826:	b8 0b 00 00 00       	mov    $0xb,%eax
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	57                   	push   %edi
8010282e:	56                   	push   %esi
8010282f:	53                   	push   %ebx
80102830:	83 ec 4c             	sub    $0x4c,%esp
80102833:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	ba 71 00 00 00       	mov    $0x71,%edx
80102839:	ec                   	in     (%dx),%al
8010283a:	83 e0 04             	and    $0x4,%eax
8010283d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102840:	31 db                	xor    %ebx,%ebx
80102842:	88 45 b7             	mov    %al,-0x49(%ebp)
80102845:	bf 70 00 00 00       	mov    $0x70,%edi
8010284a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102850:	89 d8                	mov    %ebx,%eax
80102852:	89 fa                	mov    %edi,%edx
80102854:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102855:	b9 71 00 00 00       	mov    $0x71,%ecx
8010285a:	89 ca                	mov    %ecx,%edx
8010285c:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010285d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102860:	89 fa                	mov    %edi,%edx
80102862:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102865:	b8 02 00 00 00       	mov    $0x2,%eax
8010286a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286b:	89 ca                	mov    %ecx,%edx
8010286d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010286e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102871:	89 fa                	mov    %edi,%edx
80102873:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102876:	b8 04 00 00 00       	mov    $0x4,%eax
8010287b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	89 ca                	mov    %ecx,%edx
8010287e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010287f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102882:	89 fa                	mov    %edi,%edx
80102884:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102887:	b8 07 00 00 00       	mov    $0x7,%eax
8010288c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288d:	89 ca                	mov    %ecx,%edx
8010288f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102890:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102893:	89 fa                	mov    %edi,%edx
80102895:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102898:	b8 08 00 00 00       	mov    $0x8,%eax
8010289d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289e:	89 ca                	mov    %ecx,%edx
801028a0:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028a1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a4:	89 fa                	mov    %edi,%edx
801028a6:	89 45 c8             	mov    %eax,-0x38(%ebp)
801028a9:	b8 09 00 00 00       	mov    $0x9,%eax
801028ae:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028af:	89 ca                	mov    %ecx,%edx
801028b1:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028b2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b5:	89 fa                	mov    %edi,%edx
801028b7:	89 45 cc             	mov    %eax,-0x34(%ebp)
801028ba:	b8 0a 00 00 00       	mov    $0xa,%eax
801028bf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c0:	89 ca                	mov    %ecx,%edx
801028c2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028c3:	84 c0                	test   %al,%al
801028c5:	78 89                	js     80102850 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c7:	89 d8                	mov    %ebx,%eax
801028c9:	89 fa                	mov    %edi,%edx
801028cb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cc:	89 ca                	mov    %ecx,%edx
801028ce:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028cf:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d2:	89 fa                	mov    %edi,%edx
801028d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028d7:	b8 02 00 00 00       	mov    $0x2,%eax
801028dc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dd:	89 ca                	mov    %ecx,%edx
801028df:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028e0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e3:	89 fa                	mov    %edi,%edx
801028e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028e8:	b8 04 00 00 00       	mov    $0x4,%eax
801028ed:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ee:	89 ca                	mov    %ecx,%edx
801028f0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801028f1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f4:	89 fa                	mov    %edi,%edx
801028f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028f9:	b8 07 00 00 00       	mov    $0x7,%eax
801028fe:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ff:	89 ca                	mov    %ecx,%edx
80102901:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102902:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102905:	89 fa                	mov    %edi,%edx
80102907:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010290a:	b8 08 00 00 00       	mov    $0x8,%eax
8010290f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	89 ca                	mov    %ecx,%edx
80102912:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102913:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102916:	89 fa                	mov    %edi,%edx
80102918:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010291b:	b8 09 00 00 00       	mov    $0x9,%eax
80102920:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	89 ca                	mov    %ecx,%edx
80102923:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102924:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102927:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
8010292a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010292d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102930:	6a 18                	push   $0x18
80102932:	56                   	push   %esi
80102933:	50                   	push   %eax
80102934:	e8 97 1b 00 00       	call   801044d0 <memcmp>
80102939:	83 c4 10             	add    $0x10,%esp
8010293c:	85 c0                	test   %eax,%eax
8010293e:	0f 85 0c ff ff ff    	jne    80102850 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102944:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102948:	75 78                	jne    801029c2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010294a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010294d:	89 c2                	mov    %eax,%edx
8010294f:	83 e0 0f             	and    $0xf,%eax
80102952:	c1 ea 04             	shr    $0x4,%edx
80102955:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102958:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010295e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102961:	89 c2                	mov    %eax,%edx
80102963:	83 e0 0f             	and    $0xf,%eax
80102966:	c1 ea 04             	shr    $0x4,%edx
80102969:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102972:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102975:	89 c2                	mov    %eax,%edx
80102977:	83 e0 0f             	and    $0xf,%eax
8010297a:	c1 ea 04             	shr    $0x4,%edx
8010297d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102980:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102983:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102986:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102989:	89 c2                	mov    %eax,%edx
8010298b:	83 e0 0f             	and    $0xf,%eax
8010298e:	c1 ea 04             	shr    $0x4,%edx
80102991:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102994:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102997:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010299a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010299d:	89 c2                	mov    %eax,%edx
8010299f:	83 e0 0f             	and    $0xf,%eax
801029a2:	c1 ea 04             	shr    $0x4,%edx
801029a5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ab:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029ae:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b1:	89 c2                	mov    %eax,%edx
801029b3:	83 e0 0f             	and    $0xf,%eax
801029b6:	c1 ea 04             	shr    $0x4,%edx
801029b9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029bf:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029c2:	8b 75 08             	mov    0x8(%ebp),%esi
801029c5:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029c8:	89 06                	mov    %eax,(%esi)
801029ca:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029cd:	89 46 04             	mov    %eax,0x4(%esi)
801029d0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029d3:	89 46 08             	mov    %eax,0x8(%esi)
801029d6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029d9:	89 46 0c             	mov    %eax,0xc(%esi)
801029dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029df:	89 46 10             	mov    %eax,0x10(%esi)
801029e2:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029e8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029f2:	5b                   	pop    %ebx
801029f3:	5e                   	pop    %esi
801029f4:	5f                   	pop    %edi
801029f5:	5d                   	pop    %ebp
801029f6:	c3                   	ret    
801029f7:	66 90                	xchg   %ax,%ax
801029f9:	66 90                	xchg   %ax,%ax
801029fb:	66 90                	xchg   %ax,%ax
801029fd:	66 90                	xchg   %ax,%ax
801029ff:	90                   	nop

80102a00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a00:	8b 0d e8 3b 11 80    	mov    0x80113be8,%ecx
80102a06:	85 c9                	test   %ecx,%ecx
80102a08:	0f 8e 85 00 00 00    	jle    80102a93 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a0e:	55                   	push   %ebp
80102a0f:	89 e5                	mov    %esp,%ebp
80102a11:	57                   	push   %edi
80102a12:	56                   	push   %esi
80102a13:	53                   	push   %ebx
80102a14:	31 db                	xor    %ebx,%ebx
80102a16:	83 ec 0c             	sub    $0xc,%esp
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a20:	a1 d4 3b 11 80       	mov    0x80113bd4,%eax
80102a25:	83 ec 08             	sub    $0x8,%esp
80102a28:	01 d8                	add    %ebx,%eax
80102a2a:	83 c0 01             	add    $0x1,%eax
80102a2d:	50                   	push   %eax
80102a2e:	ff 35 e4 3b 11 80    	pushl  0x80113be4
80102a34:	e8 97 d6 ff ff       	call   801000d0 <bread>
80102a39:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a3b:	58                   	pop    %eax
80102a3c:	5a                   	pop    %edx
80102a3d:	ff 34 9d ec 3b 11 80 	pushl  -0x7feec414(,%ebx,4)
80102a44:	ff 35 e4 3b 11 80    	pushl  0x80113be4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4d:	e8 7e d6 ff ff       	call   801000d0 <bread>
80102a52:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a54:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a57:	83 c4 0c             	add    $0xc,%esp
80102a5a:	68 00 02 00 00       	push   $0x200
80102a5f:	50                   	push   %eax
80102a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a63:	50                   	push   %eax
80102a64:	e8 c7 1a 00 00       	call   80104530 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a69:	89 34 24             	mov    %esi,(%esp)
80102a6c:	e8 2f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a71:	89 3c 24             	mov    %edi,(%esp)
80102a74:	e8 67 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 5f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a81:	83 c4 10             	add    $0x10,%esp
80102a84:	39 1d e8 3b 11 80    	cmp    %ebx,0x80113be8
80102a8a:	7f 94                	jg     80102a20 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a8f:	5b                   	pop    %ebx
80102a90:	5e                   	pop    %esi
80102a91:	5f                   	pop    %edi
80102a92:	5d                   	pop    %ebp
80102a93:	f3 c3                	repz ret 
80102a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102aa0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	53                   	push   %ebx
80102aa4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102aa7:	ff 35 d4 3b 11 80    	pushl  0x80113bd4
80102aad:	ff 35 e4 3b 11 80    	pushl  0x80113be4
80102ab3:	e8 18 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ab8:	8b 0d e8 3b 11 80    	mov    0x80113be8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102abe:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ac1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ac3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ac5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ac8:	7e 1f                	jle    80102ae9 <write_head+0x49>
80102aca:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102ad1:	31 d2                	xor    %edx,%edx
80102ad3:	90                   	nop
80102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102ad8:	8b 8a ec 3b 11 80    	mov    -0x7feec414(%edx),%ecx
80102ade:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ae2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ae5:	39 c2                	cmp    %eax,%edx
80102ae7:	75 ef                	jne    80102ad8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102ae9:	83 ec 0c             	sub    $0xc,%esp
80102aec:	53                   	push   %ebx
80102aed:	e8 ae d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102af2:	89 1c 24             	mov    %ebx,(%esp)
80102af5:	e8 e6 d6 ff ff       	call   801001e0 <brelse>
}
80102afa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102afd:	c9                   	leave  
80102afe:	c3                   	ret    
80102aff:	90                   	nop

80102b00 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
80102b03:	53                   	push   %ebx
80102b04:	83 ec 2c             	sub    $0x2c,%esp
80102b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b0a:	68 e0 7d 10 80       	push   $0x80107de0
80102b0f:	68 a0 3b 11 80       	push   $0x80113ba0
80102b14:	e8 07 17 00 00       	call   80104220 <initlock>
  readsb(dev, &sb);
80102b19:	58                   	pop    %eax
80102b1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b1d:	5a                   	pop    %edx
80102b1e:	50                   	push   %eax
80102b1f:	53                   	push   %ebx
80102b20:	e8 5b e9 ff ff       	call   80101480 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b25:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b28:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b2b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b2c:	89 1d e4 3b 11 80    	mov    %ebx,0x80113be4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b32:	89 15 d8 3b 11 80    	mov    %edx,0x80113bd8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b38:	a3 d4 3b 11 80       	mov    %eax,0x80113bd4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b45:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b48:	83 c4 10             	add    $0x10,%esp
80102b4b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b4d:	89 0d e8 3b 11 80    	mov    %ecx,0x80113be8
  for (i = 0; i < log.lh.n; i++) {
80102b53:	7e 1c                	jle    80102b71 <initlog+0x71>
80102b55:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b5c:	31 d2                	xor    %edx,%edx
80102b5e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b64:	83 c2 04             	add    $0x4,%edx
80102b67:	89 8a e8 3b 11 80    	mov    %ecx,-0x7feec418(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b6d:	39 da                	cmp    %ebx,%edx
80102b6f:	75 ef                	jne    80102b60 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b71:	83 ec 0c             	sub    $0xc,%esp
80102b74:	50                   	push   %eax
80102b75:	e8 66 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b7a:	e8 81 fe ff ff       	call   80102a00 <install_trans>
  log.lh.n = 0;
80102b7f:	c7 05 e8 3b 11 80 00 	movl   $0x0,0x80113be8
80102b86:	00 00 00 
  write_head(); // clear the log
80102b89:	e8 12 ff ff ff       	call   80102aa0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b91:	c9                   	leave  
80102b92:	c3                   	ret    
80102b93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ba6:	68 a0 3b 11 80       	push   $0x80113ba0
80102bab:	e8 d0 17 00 00       	call   80104380 <acquire>
80102bb0:	83 c4 10             	add    $0x10,%esp
80102bb3:	eb 18                	jmp    80102bcd <begin_op+0x2d>
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bb8:	83 ec 08             	sub    $0x8,%esp
80102bbb:	68 a0 3b 11 80       	push   $0x80113ba0
80102bc0:	68 a0 3b 11 80       	push   $0x80113ba0
80102bc5:	e8 b6 11 00 00       	call   80103d80 <sleep>
80102bca:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102bcd:	a1 e0 3b 11 80       	mov    0x80113be0,%eax
80102bd2:	85 c0                	test   %eax,%eax
80102bd4:	75 e2                	jne    80102bb8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bd6:	a1 dc 3b 11 80       	mov    0x80113bdc,%eax
80102bdb:	8b 15 e8 3b 11 80    	mov    0x80113be8,%edx
80102be1:	83 c0 01             	add    $0x1,%eax
80102be4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102be7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bea:	83 fa 1e             	cmp    $0x1e,%edx
80102bed:	7f c9                	jg     80102bb8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bef:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bf2:	a3 dc 3b 11 80       	mov    %eax,0x80113bdc
      release(&log.lock);
80102bf7:	68 a0 3b 11 80       	push   $0x80113ba0
80102bfc:	e8 2f 18 00 00       	call   80104430 <release>
      break;
    }
  }
}
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	c9                   	leave  
80102c05:	c3                   	ret    
80102c06:	8d 76 00             	lea    0x0(%esi),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	57                   	push   %edi
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c19:	68 a0 3b 11 80       	push   $0x80113ba0
80102c1e:	e8 5d 17 00 00       	call   80104380 <acquire>
  log.outstanding -= 1;
80102c23:	a1 dc 3b 11 80       	mov    0x80113bdc,%eax
  if(log.committing)
80102c28:	8b 1d e0 3b 11 80    	mov    0x80113be0,%ebx
80102c2e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c31:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c34:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c36:	a3 dc 3b 11 80       	mov    %eax,0x80113bdc
  if(log.committing)
80102c3b:	0f 85 23 01 00 00    	jne    80102d64 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c41:	85 c0                	test   %eax,%eax
80102c43:	0f 85 f7 00 00 00    	jne    80102d40 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c49:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c4c:	c7 05 e0 3b 11 80 01 	movl   $0x1,0x80113be0
80102c53:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c56:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c58:	68 a0 3b 11 80       	push   $0x80113ba0
80102c5d:	e8 ce 17 00 00       	call   80104430 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c62:	8b 0d e8 3b 11 80    	mov    0x80113be8,%ecx
80102c68:	83 c4 10             	add    $0x10,%esp
80102c6b:	85 c9                	test   %ecx,%ecx
80102c6d:	0f 8e 8a 00 00 00    	jle    80102cfd <end_op+0xed>
80102c73:	90                   	nop
80102c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c78:	a1 d4 3b 11 80       	mov    0x80113bd4,%eax
80102c7d:	83 ec 08             	sub    $0x8,%esp
80102c80:	01 d8                	add    %ebx,%eax
80102c82:	83 c0 01             	add    $0x1,%eax
80102c85:	50                   	push   %eax
80102c86:	ff 35 e4 3b 11 80    	pushl  0x80113be4
80102c8c:	e8 3f d4 ff ff       	call   801000d0 <bread>
80102c91:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c93:	58                   	pop    %eax
80102c94:	5a                   	pop    %edx
80102c95:	ff 34 9d ec 3b 11 80 	pushl  -0x7feec414(,%ebx,4)
80102c9c:	ff 35 e4 3b 11 80    	pushl  0x80113be4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ca2:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ca5:	e8 26 d4 ff ff       	call   801000d0 <bread>
80102caa:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cac:	8d 40 5c             	lea    0x5c(%eax),%eax
80102caf:	83 c4 0c             	add    $0xc,%esp
80102cb2:	68 00 02 00 00       	push   $0x200
80102cb7:	50                   	push   %eax
80102cb8:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cbb:	50                   	push   %eax
80102cbc:	e8 6f 18 00 00       	call   80104530 <memmove>
    bwrite(to);  // write the log
80102cc1:	89 34 24             	mov    %esi,(%esp)
80102cc4:	e8 d7 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cc9:	89 3c 24             	mov    %edi,(%esp)
80102ccc:	e8 0f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cd1:	89 34 24             	mov    %esi,(%esp)
80102cd4:	e8 07 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cd9:	83 c4 10             	add    $0x10,%esp
80102cdc:	3b 1d e8 3b 11 80    	cmp    0x80113be8,%ebx
80102ce2:	7c 94                	jl     80102c78 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ce4:	e8 b7 fd ff ff       	call   80102aa0 <write_head>
    install_trans(); // Now install writes to home locations
80102ce9:	e8 12 fd ff ff       	call   80102a00 <install_trans>
    log.lh.n = 0;
80102cee:	c7 05 e8 3b 11 80 00 	movl   $0x0,0x80113be8
80102cf5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cf8:	e8 a3 fd ff ff       	call   80102aa0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102cfd:	83 ec 0c             	sub    $0xc,%esp
80102d00:	68 a0 3b 11 80       	push   $0x80113ba0
80102d05:	e8 76 16 00 00       	call   80104380 <acquire>
    log.committing = 0;
    wakeup(&log);
80102d0a:	c7 04 24 a0 3b 11 80 	movl   $0x80113ba0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102d11:	c7 05 e0 3b 11 80 00 	movl   $0x0,0x80113be0
80102d18:	00 00 00 
    wakeup(&log);
80102d1b:	e8 20 12 00 00       	call   80103f40 <wakeup>
    release(&log.lock);
80102d20:	c7 04 24 a0 3b 11 80 	movl   $0x80113ba0,(%esp)
80102d27:	e8 04 17 00 00       	call   80104430 <release>
80102d2c:	83 c4 10             	add    $0x10,%esp
  }
}
80102d2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d32:	5b                   	pop    %ebx
80102d33:	5e                   	pop    %esi
80102d34:	5f                   	pop    %edi
80102d35:	5d                   	pop    %ebp
80102d36:	c3                   	ret    
80102d37:	89 f6                	mov    %esi,%esi
80102d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102d40:	83 ec 0c             	sub    $0xc,%esp
80102d43:	68 a0 3b 11 80       	push   $0x80113ba0
80102d48:	e8 f3 11 00 00       	call   80103f40 <wakeup>
  }
  release(&log.lock);
80102d4d:	c7 04 24 a0 3b 11 80 	movl   $0x80113ba0,(%esp)
80102d54:	e8 d7 16 00 00       	call   80104430 <release>
80102d59:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d5f:	5b                   	pop    %ebx
80102d60:	5e                   	pop    %esi
80102d61:	5f                   	pop    %edi
80102d62:	5d                   	pop    %ebp
80102d63:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d64:	83 ec 0c             	sub    $0xc,%esp
80102d67:	68 e4 7d 10 80       	push   $0x80107de4
80102d6c:	e8 ff d5 ff ff       	call   80100370 <panic>
80102d71:	eb 0d                	jmp    80102d80 <log_write>
80102d73:	90                   	nop
80102d74:	90                   	nop
80102d75:	90                   	nop
80102d76:	90                   	nop
80102d77:	90                   	nop
80102d78:	90                   	nop
80102d79:	90                   	nop
80102d7a:	90                   	nop
80102d7b:	90                   	nop
80102d7c:	90                   	nop
80102d7d:	90                   	nop
80102d7e:	90                   	nop
80102d7f:	90                   	nop

80102d80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d87:	8b 15 e8 3b 11 80    	mov    0x80113be8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d90:	83 fa 1d             	cmp    $0x1d,%edx
80102d93:	0f 8f 97 00 00 00    	jg     80102e30 <log_write+0xb0>
80102d99:	a1 d8 3b 11 80       	mov    0x80113bd8,%eax
80102d9e:	83 e8 01             	sub    $0x1,%eax
80102da1:	39 c2                	cmp    %eax,%edx
80102da3:	0f 8d 87 00 00 00    	jge    80102e30 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102da9:	a1 dc 3b 11 80       	mov    0x80113bdc,%eax
80102dae:	85 c0                	test   %eax,%eax
80102db0:	0f 8e 87 00 00 00    	jle    80102e3d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102db6:	83 ec 0c             	sub    $0xc,%esp
80102db9:	68 a0 3b 11 80       	push   $0x80113ba0
80102dbe:	e8 bd 15 00 00       	call   80104380 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dc3:	8b 15 e8 3b 11 80    	mov    0x80113be8,%edx
80102dc9:	83 c4 10             	add    $0x10,%esp
80102dcc:	83 fa 00             	cmp    $0x0,%edx
80102dcf:	7e 50                	jle    80102e21 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102dd4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd6:	3b 0d ec 3b 11 80    	cmp    0x80113bec,%ecx
80102ddc:	75 0b                	jne    80102de9 <log_write+0x69>
80102dde:	eb 38                	jmp    80102e18 <log_write+0x98>
80102de0:	39 0c 85 ec 3b 11 80 	cmp    %ecx,-0x7feec414(,%eax,4)
80102de7:	74 2f                	je     80102e18 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102de9:	83 c0 01             	add    $0x1,%eax
80102dec:	39 d0                	cmp    %edx,%eax
80102dee:	75 f0                	jne    80102de0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102df0:	89 0c 95 ec 3b 11 80 	mov    %ecx,-0x7feec414(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102df7:	83 c2 01             	add    $0x1,%edx
80102dfa:	89 15 e8 3b 11 80    	mov    %edx,0x80113be8
  b->flags |= B_DIRTY; // prevent eviction
80102e00:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e03:	c7 45 08 a0 3b 11 80 	movl   $0x80113ba0,0x8(%ebp)
}
80102e0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e0d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e0e:	e9 1d 16 00 00       	jmp    80104430 <release>
80102e13:	90                   	nop
80102e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e18:	89 0c 85 ec 3b 11 80 	mov    %ecx,-0x7feec414(,%eax,4)
80102e1f:	eb df                	jmp    80102e00 <log_write+0x80>
80102e21:	8b 43 08             	mov    0x8(%ebx),%eax
80102e24:	a3 ec 3b 11 80       	mov    %eax,0x80113bec
  if (i == log.lh.n)
80102e29:	75 d5                	jne    80102e00 <log_write+0x80>
80102e2b:	eb ca                	jmp    80102df7 <log_write+0x77>
80102e2d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e30:	83 ec 0c             	sub    $0xc,%esp
80102e33:	68 f3 7d 10 80       	push   $0x80107df3
80102e38:	e8 33 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e3d:	83 ec 0c             	sub    $0xc,%esp
80102e40:	68 09 7e 10 80       	push   $0x80107e09
80102e45:	e8 26 d5 ff ff       	call   80100370 <panic>
80102e4a:	66 90                	xchg   %ax,%ax
80102e4c:	66 90                	xchg   %ax,%ax
80102e4e:	66 90                	xchg   %ax,%ax

80102e50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e57:	e8 54 09 00 00       	call   801037b0 <cpuid>
80102e5c:	89 c3                	mov    %eax,%ebx
80102e5e:	e8 4d 09 00 00       	call   801037b0 <cpuid>
80102e63:	83 ec 04             	sub    $0x4,%esp
80102e66:	53                   	push   %ebx
80102e67:	50                   	push   %eax
80102e68:	68 24 7e 10 80       	push   $0x80107e24
80102e6d:	e8 ee d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e72:	e8 29 32 00 00       	call   801060a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e77:	e8 b4 08 00 00       	call   80103730 <mycpu>
80102e7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e7e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e83:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e8a:	e8 01 0c 00 00       	call   80103a90 <scheduler>
80102e8f:	90                   	nop

80102e90 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e96:	e8 65 43 00 00       	call   80107200 <switchkvm>
  seginit();
80102e9b:	e8 80 40 00 00       	call   80106f20 <seginit>
  lapicinit();
80102ea0:	e8 9b f7 ff ff       	call   80102640 <lapicinit>
  mpmain();
80102ea5:	e8 a6 ff ff ff       	call   80102e50 <mpmain>
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102eb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102eb4:	83 e4 f0             	and    $0xfffffff0,%esp
80102eb7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eba:	55                   	push   %ebp
80102ebb:	89 e5                	mov    %esp,%ebp
80102ebd:	53                   	push   %ebx
80102ebe:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102ebf:	bb a0 3c 11 80       	mov    $0x80113ca0,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ec4:	83 ec 08             	sub    $0x8,%esp
80102ec7:	68 00 00 40 80       	push   $0x80400000
80102ecc:	68 c8 69 11 80       	push   $0x801169c8
80102ed1:	e8 3a f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ed6:	e8 e5 47 00 00       	call   801076c0 <kvmalloc>
  mpinit();        // detect other processors
80102edb:	e8 70 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102ee0:	e8 5b f7 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102ee5:	e8 36 40 00 00       	call   80106f20 <seginit>
  picinit();       // disable pic
80102eea:	e8 31 03 00 00       	call   80103220 <picinit>
  ioapicinit();    // another interrupt controller
80102eef:	e8 4c f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102ef4:	e8 a7 da ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102ef9:	e8 a2 34 00 00       	call   801063a0 <uartinit>
  pinit();         // process table
80102efe:	e8 0d 08 00 00       	call   80103710 <pinit>
  tvinit();        // trap vectors
80102f03:	e8 f8 30 00 00       	call   80106000 <tvinit>
  binit();         // buffer cache
80102f08:	e8 33 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f0d:	e8 9e de ff ff       	call   80100db0 <fileinit>
  ideinit();       // disk 
80102f12:	e8 09 f1 ff ff       	call   80102020 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f17:	83 c4 0c             	add    $0xc,%esp
80102f1a:	68 8a 00 00 00       	push   $0x8a
80102f1f:	68 cc b4 10 80       	push   $0x8010b4cc
80102f24:	68 00 70 00 80       	push   $0x80007000
80102f29:	e8 02 16 00 00       	call   80104530 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f2e:	69 05 20 42 11 80 b0 	imul   $0xb0,0x80114220,%eax
80102f35:	00 00 00 
80102f38:	83 c4 10             	add    $0x10,%esp
80102f3b:	05 a0 3c 11 80       	add    $0x80113ca0,%eax
80102f40:	39 d8                	cmp    %ebx,%eax
80102f42:	76 6f                	jbe    80102fb3 <main+0x103>
80102f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f48:	e8 e3 07 00 00       	call   80103730 <mycpu>
80102f4d:	39 d8                	cmp    %ebx,%eax
80102f4f:	74 49                	je     80102f9a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f51:	e8 8a f5 ff ff       	call   801024e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f56:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f5b:	c7 05 f8 6f 00 80 90 	movl   $0x80102e90,0x80006ff8
80102f62:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f65:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f6c:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f6f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f74:	0f b6 03             	movzbl (%ebx),%eax
80102f77:	83 ec 08             	sub    $0x8,%esp
80102f7a:	68 00 70 00 00       	push   $0x7000
80102f7f:	50                   	push   %eax
80102f80:	e8 0b f8 ff ff       	call   80102790 <lapicstartap>
80102f85:	83 c4 10             	add    $0x10,%esp
80102f88:	90                   	nop
80102f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f96:	85 c0                	test   %eax,%eax
80102f98:	74 f6                	je     80102f90 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f9a:	69 05 20 42 11 80 b0 	imul   $0xb0,0x80114220,%eax
80102fa1:	00 00 00 
80102fa4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102faa:	05 a0 3c 11 80       	add    $0x80113ca0,%eax
80102faf:	39 c3                	cmp    %eax,%ebx
80102fb1:	72 95                	jb     80102f48 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fb3:	83 ec 08             	sub    $0x8,%esp
80102fb6:	68 00 00 00 8e       	push   $0x8e000000
80102fbb:	68 00 00 40 80       	push   $0x80400000
80102fc0:	e8 bb f4 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102fc5:	e8 36 08 00 00       	call   80103800 <userinit>
  mpmain();        // finish this processor's setup
80102fca:	e8 81 fe ff ff       	call   80102e50 <mpmain>
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	73 48                	jae    8010302e <mpsearch1+0x5e>
80102fe6:	8d 76 00             	lea    0x0(%esi),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff0:	83 ec 04             	sub    $0x4,%esp
80102ff3:	8d 7e 10             	lea    0x10(%esi),%edi
80102ff6:	6a 04                	push   $0x4
80102ff8:	68 38 7e 10 80       	push   $0x80107e38
80102ffd:	56                   	push   %esi
80102ffe:	e8 cd 14 00 00       	call   801044d0 <memcmp>
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	85 c0                	test   %eax,%eax
80103008:	75 1e                	jne    80103028 <mpsearch1+0x58>
8010300a:	8d 7e 10             	lea    0x10(%esi),%edi
8010300d:	89 f2                	mov    %esi,%edx
8010300f:	31 c9                	xor    %ecx,%ecx
80103011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103018:	0f b6 02             	movzbl (%edx),%eax
8010301b:	83 c2 01             	add    $0x1,%edx
8010301e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103020:	39 fa                	cmp    %edi,%edx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c9                	test   %cl,%cl
80103026:	74 10                	je     80103038 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103028:	39 fb                	cmp    %edi,%ebx
8010302a:	89 fe                	mov    %edi,%esi
8010302c:	77 c2                	ja     80102ff0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010302e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103031:	31 c0                	xor    %eax,%eax
}
80103033:	5b                   	pop    %ebx
80103034:	5e                   	pop    %esi
80103035:	5f                   	pop    %edi
80103036:	5d                   	pop    %ebp
80103037:	c3                   	ret    
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010309d:	0f 84 37 01 00 00    	je     801031da <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030a6:	8b 58 04             	mov    0x4(%eax),%ebx
801030a9:	85 db                	test   %ebx,%ebx
801030ab:	0f 84 43 01 00 00    	je     801031f4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030b7:	83 ec 04             	sub    $0x4,%esp
801030ba:	6a 04                	push   $0x4
801030bc:	68 3d 7e 10 80       	push   $0x80107e3d
801030c1:	56                   	push   %esi
801030c2:	e8 09 14 00 00       	call   801044d0 <memcmp>
801030c7:	83 c4 10             	add    $0x10,%esp
801030ca:	85 c0                	test   %eax,%eax
801030cc:	0f 85 22 01 00 00    	jne    801031f4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030d9:	3c 01                	cmp    $0x1,%al
801030db:	74 08                	je     801030e5 <mpinit+0x95>
801030dd:	3c 04                	cmp    $0x4,%al
801030df:	0f 85 0f 01 00 00    	jne    801031f4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030e5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030ec:	85 ff                	test   %edi,%edi
801030ee:	74 21                	je     80103111 <mpinit+0xc1>
801030f0:	31 d2                	xor    %edx,%edx
801030f2:	31 c0                	xor    %eax,%eax
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030f8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801030ff:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103100:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103103:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103105:	39 c7                	cmp    %eax,%edi
80103107:	75 ef                	jne    801030f8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103109:	84 d2                	test   %dl,%dl
8010310b:	0f 85 e3 00 00 00    	jne    801031f4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103111:	85 f6                	test   %esi,%esi
80103113:	0f 84 db 00 00 00    	je     801031f4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103119:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010311f:	a3 9c 3b 11 80       	mov    %eax,0x80113b9c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103124:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010312b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103131:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103136:	01 d6                	add    %edx,%esi
80103138:	90                   	nop
80103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103140:	39 c6                	cmp    %eax,%esi
80103142:	76 23                	jbe    80103167 <mpinit+0x117>
80103144:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103147:	80 fa 04             	cmp    $0x4,%dl
8010314a:	0f 87 c0 00 00 00    	ja     80103210 <mpinit+0x1c0>
80103150:	ff 24 95 7c 7e 10 80 	jmp    *-0x7fef8184(,%edx,4)
80103157:	89 f6                	mov    %esi,%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103160:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103163:	39 c6                	cmp    %eax,%esi
80103165:	77 dd                	ja     80103144 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103167:	85 db                	test   %ebx,%ebx
80103169:	0f 84 92 00 00 00    	je     80103201 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010316f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103172:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103176:	74 15                	je     8010318d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103178:	ba 22 00 00 00       	mov    $0x22,%edx
8010317d:	b8 70 00 00 00       	mov    $0x70,%eax
80103182:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103183:	ba 23 00 00 00       	mov    $0x23,%edx
80103188:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103189:	83 c8 01             	or     $0x1,%eax
8010318c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010318d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103190:	5b                   	pop    %ebx
80103191:	5e                   	pop    %esi
80103192:	5f                   	pop    %edi
80103193:	5d                   	pop    %ebp
80103194:	c3                   	ret    
80103195:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103198:	8b 0d 20 42 11 80    	mov    0x80114220,%ecx
8010319e:	83 f9 07             	cmp    $0x7,%ecx
801031a1:	7f 19                	jg     801031bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031ad:	83 c1 01             	add    $0x1,%ecx
801031b0:	89 0d 20 42 11 80    	mov    %ecx,0x80114220
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b6:	88 97 a0 3c 11 80    	mov    %dl,-0x7feec360(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801031bc:	83 c0 14             	add    $0x14,%eax
      continue;
801031bf:	e9 7c ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031cc:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031cf:	88 15 80 3c 11 80    	mov    %dl,0x80113c80
      p += sizeof(struct mpioapic);
      continue;
801031d5:	e9 66 ff ff ff       	jmp    80103140 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031da:	ba 00 00 01 00       	mov    $0x10000,%edx
801031df:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031e4:	e8 e7 fd ff ff       	call   80102fd0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031e9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ee:	0f 85 af fe ff ff    	jne    801030a3 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801031f4:	83 ec 0c             	sub    $0xc,%esp
801031f7:	68 42 7e 10 80       	push   $0x80107e42
801031fc:	e8 6f d1 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80103201:	83 ec 0c             	sub    $0xc,%esp
80103204:	68 5c 7e 10 80       	push   $0x80107e5c
80103209:	e8 62 d1 ff ff       	call   80100370 <panic>
8010320e:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103210:	31 db                	xor    %ebx,%ebx
80103212:	e9 30 ff ff ff       	jmp    80103147 <mpinit+0xf7>
80103217:	66 90                	xchg   %ax,%ax
80103219:	66 90                	xchg   %ax,%ax
8010321b:	66 90                	xchg   %ax,%ax
8010321d:	66 90                	xchg   %ax,%ax
8010321f:	90                   	nop

80103220 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103220:	55                   	push   %ebp
80103221:	ba 21 00 00 00       	mov    $0x21,%edx
80103226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010322b:	89 e5                	mov    %esp,%ebp
8010322d:	ee                   	out    %al,(%dx)
8010322e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103233:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103234:	5d                   	pop    %ebp
80103235:	c3                   	ret    
80103236:	66 90                	xchg   %ax,%ax
80103238:	66 90                	xchg   %ax,%ax
8010323a:	66 90                	xchg   %ax,%ax
8010323c:	66 90                	xchg   %ax,%ax
8010323e:	66 90                	xchg   %ax,%ax

80103240 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	57                   	push   %edi
80103244:	56                   	push   %esi
80103245:	53                   	push   %ebx
80103246:	83 ec 0c             	sub    $0xc,%esp
80103249:	8b 75 08             	mov    0x8(%ebp),%esi
8010324c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010324f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103255:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010325b:	e8 70 db ff ff       	call   80100dd0 <filealloc>
80103260:	85 c0                	test   %eax,%eax
80103262:	89 06                	mov    %eax,(%esi)
80103264:	0f 84 a8 00 00 00    	je     80103312 <pipealloc+0xd2>
8010326a:	e8 61 db ff ff       	call   80100dd0 <filealloc>
8010326f:	85 c0                	test   %eax,%eax
80103271:	89 03                	mov    %eax,(%ebx)
80103273:	0f 84 87 00 00 00    	je     80103300 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103279:	e8 62 f2 ff ff       	call   801024e0 <kalloc>
8010327e:	85 c0                	test   %eax,%eax
80103280:	89 c7                	mov    %eax,%edi
80103282:	0f 84 b0 00 00 00    	je     80103338 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103288:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010328b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103292:	00 00 00 
  p->writeopen = 1;
80103295:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010329c:	00 00 00 
  p->nwrite = 0;
8010329f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032a6:	00 00 00 
  p->nread = 0;
801032a9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032b0:	00 00 00 
  initlock(&p->lock, "pipe");
801032b3:	68 90 7e 10 80       	push   $0x80107e90
801032b8:	50                   	push   %eax
801032b9:	e8 62 0f 00 00       	call   80104220 <initlock>
  (*f0)->type = FD_PIPE;
801032be:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801032c0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801032c3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801032c9:	8b 06                	mov    (%esi),%eax
801032cb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801032cf:	8b 06                	mov    (%esi),%eax
801032d1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801032d5:	8b 06                	mov    (%esi),%eax
801032d7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801032da:	8b 03                	mov    (%ebx),%eax
801032dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801032e2:	8b 03                	mov    (%ebx),%eax
801032e4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032e8:	8b 03                	mov    (%ebx),%eax
801032ea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032ee:	8b 03                	mov    (%ebx),%eax
801032f0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801032f6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032f8:	5b                   	pop    %ebx
801032f9:	5e                   	pop    %esi
801032fa:	5f                   	pop    %edi
801032fb:	5d                   	pop    %ebp
801032fc:	c3                   	ret    
801032fd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103300:	8b 06                	mov    (%esi),%eax
80103302:	85 c0                	test   %eax,%eax
80103304:	74 1e                	je     80103324 <pipealloc+0xe4>
    fileclose(*f0);
80103306:	83 ec 0c             	sub    $0xc,%esp
80103309:	50                   	push   %eax
8010330a:	e8 81 db ff ff       	call   80100e90 <fileclose>
8010330f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103312:	8b 03                	mov    (%ebx),%eax
80103314:	85 c0                	test   %eax,%eax
80103316:	74 0c                	je     80103324 <pipealloc+0xe4>
    fileclose(*f1);
80103318:	83 ec 0c             	sub    $0xc,%esp
8010331b:	50                   	push   %eax
8010331c:	e8 6f db ff ff       	call   80100e90 <fileclose>
80103321:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103324:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010332c:	5b                   	pop    %ebx
8010332d:	5e                   	pop    %esi
8010332e:	5f                   	pop    %edi
8010332f:	5d                   	pop    %ebp
80103330:	c3                   	ret    
80103331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103338:	8b 06                	mov    (%esi),%eax
8010333a:	85 c0                	test   %eax,%eax
8010333c:	75 c8                	jne    80103306 <pipealloc+0xc6>
8010333e:	eb d2                	jmp    80103312 <pipealloc+0xd2>

80103340 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	56                   	push   %esi
80103344:	53                   	push   %ebx
80103345:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103348:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010334b:	83 ec 0c             	sub    $0xc,%esp
8010334e:	53                   	push   %ebx
8010334f:	e8 2c 10 00 00       	call   80104380 <acquire>
  if(writable){
80103354:	83 c4 10             	add    $0x10,%esp
80103357:	85 f6                	test   %esi,%esi
80103359:	74 45                	je     801033a0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010335b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103361:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103364:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010336b:	00 00 00 
    wakeup(&p->nread);
8010336e:	50                   	push   %eax
8010336f:	e8 cc 0b 00 00       	call   80103f40 <wakeup>
80103374:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103377:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010337d:	85 d2                	test   %edx,%edx
8010337f:	75 0a                	jne    8010338b <pipeclose+0x4b>
80103381:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103387:	85 c0                	test   %eax,%eax
80103389:	74 35                	je     801033c0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010338b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010338e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103391:	5b                   	pop    %ebx
80103392:	5e                   	pop    %esi
80103393:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103394:	e9 97 10 00 00       	jmp    80104430 <release>
80103399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
801033a0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033a6:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801033a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033b0:	00 00 00 
    wakeup(&p->nwrite);
801033b3:	50                   	push   %eax
801033b4:	e8 87 0b 00 00       	call   80103f40 <wakeup>
801033b9:	83 c4 10             	add    $0x10,%esp
801033bc:	eb b9                	jmp    80103377 <pipeclose+0x37>
801033be:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	53                   	push   %ebx
801033c4:	e8 67 10 00 00       	call   80104430 <release>
    kfree((char*)p);
801033c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033cc:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801033cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d2:	5b                   	pop    %ebx
801033d3:	5e                   	pop    %esi
801033d4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801033d5:	e9 56 ef ff ff       	jmp    80102330 <kfree>
801033da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033e0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 28             	sub    $0x28,%esp
801033e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033ec:	53                   	push   %ebx
801033ed:	e8 8e 0f 00 00       	call   80104380 <acquire>
  for(i = 0; i < n; i++){
801033f2:	8b 45 10             	mov    0x10(%ebp),%eax
801033f5:	83 c4 10             	add    $0x10,%esp
801033f8:	85 c0                	test   %eax,%eax
801033fa:	0f 8e b9 00 00 00    	jle    801034b9 <pipewrite+0xd9>
80103400:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103403:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103409:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010340f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103415:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103418:	03 4d 10             	add    0x10(%ebp),%ecx
8010341b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010341e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103424:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010342a:	39 d0                	cmp    %edx,%eax
8010342c:	74 38                	je     80103466 <pipewrite+0x86>
8010342e:	eb 59                	jmp    80103489 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103430:	e8 9b 03 00 00       	call   801037d0 <myproc>
80103435:	8b 48 24             	mov    0x24(%eax),%ecx
80103438:	85 c9                	test   %ecx,%ecx
8010343a:	75 34                	jne    80103470 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010343c:	83 ec 0c             	sub    $0xc,%esp
8010343f:	57                   	push   %edi
80103440:	e8 fb 0a 00 00       	call   80103f40 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103445:	58                   	pop    %eax
80103446:	5a                   	pop    %edx
80103447:	53                   	push   %ebx
80103448:	56                   	push   %esi
80103449:	e8 32 09 00 00       	call   80103d80 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010344e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103454:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010345a:	83 c4 10             	add    $0x10,%esp
8010345d:	05 00 02 00 00       	add    $0x200,%eax
80103462:	39 c2                	cmp    %eax,%edx
80103464:	75 2a                	jne    80103490 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103466:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010346c:	85 c0                	test   %eax,%eax
8010346e:	75 c0                	jne    80103430 <pipewrite+0x50>
        release(&p->lock);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	53                   	push   %ebx
80103474:	e8 b7 0f 00 00       	call   80104430 <release>
        return -1;
80103479:	83 c4 10             	add    $0x10,%esp
8010347c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103481:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103484:	5b                   	pop    %ebx
80103485:	5e                   	pop    %esi
80103486:	5f                   	pop    %edi
80103487:	5d                   	pop    %ebp
80103488:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103489:	89 c2                	mov    %eax,%edx
8010348b:	90                   	nop
8010348c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103490:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103493:	8d 42 01             	lea    0x1(%edx),%eax
80103496:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010349a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034a0:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034a6:	0f b6 09             	movzbl (%ecx),%ecx
801034a9:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
801034ad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801034b0:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801034b3:	0f 85 65 ff ff ff    	jne    8010341e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034b9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034bf:	83 ec 0c             	sub    $0xc,%esp
801034c2:	50                   	push   %eax
801034c3:	e8 78 0a 00 00       	call   80103f40 <wakeup>
  release(&p->lock);
801034c8:	89 1c 24             	mov    %ebx,(%esp)
801034cb:	e8 60 0f 00 00       	call   80104430 <release>
  return n;
801034d0:	83 c4 10             	add    $0x10,%esp
801034d3:	8b 45 10             	mov    0x10(%ebp),%eax
801034d6:	eb a9                	jmp    80103481 <pipewrite+0xa1>
801034d8:	90                   	nop
801034d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034e0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	57                   	push   %edi
801034e4:	56                   	push   %esi
801034e5:	53                   	push   %ebx
801034e6:	83 ec 18             	sub    $0x18,%esp
801034e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034ef:	53                   	push   %ebx
801034f0:	e8 8b 0e 00 00       	call   80104380 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034f5:	83 c4 10             	add    $0x10,%esp
801034f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801034fe:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103504:	75 6a                	jne    80103570 <piperead+0x90>
80103506:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010350c:	85 f6                	test   %esi,%esi
8010350e:	0f 84 cc 00 00 00    	je     801035e0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103514:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010351a:	eb 2d                	jmp    80103549 <piperead+0x69>
8010351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103520:	83 ec 08             	sub    $0x8,%esp
80103523:	53                   	push   %ebx
80103524:	56                   	push   %esi
80103525:	e8 56 08 00 00       	call   80103d80 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010352a:	83 c4 10             	add    $0x10,%esp
8010352d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103533:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103539:	75 35                	jne    80103570 <piperead+0x90>
8010353b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103541:	85 d2                	test   %edx,%edx
80103543:	0f 84 97 00 00 00    	je     801035e0 <piperead+0x100>
    if(myproc()->killed){
80103549:	e8 82 02 00 00       	call   801037d0 <myproc>
8010354e:	8b 48 24             	mov    0x24(%eax),%ecx
80103551:	85 c9                	test   %ecx,%ecx
80103553:	74 cb                	je     80103520 <piperead+0x40>
      release(&p->lock);
80103555:	83 ec 0c             	sub    $0xc,%esp
80103558:	53                   	push   %ebx
80103559:	e8 d2 0e 00 00       	call   80104430 <release>
      return -1;
8010355e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103561:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103569:	5b                   	pop    %ebx
8010356a:	5e                   	pop    %esi
8010356b:	5f                   	pop    %edi
8010356c:	5d                   	pop    %ebp
8010356d:	c3                   	ret    
8010356e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103570:	8b 45 10             	mov    0x10(%ebp),%eax
80103573:	85 c0                	test   %eax,%eax
80103575:	7e 69                	jle    801035e0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103577:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010357d:	31 c9                	xor    %ecx,%ecx
8010357f:	eb 15                	jmp    80103596 <piperead+0xb6>
80103581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103588:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010358e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103594:	74 5a                	je     801035f0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103596:	8d 70 01             	lea    0x1(%eax),%esi
80103599:	25 ff 01 00 00       	and    $0x1ff,%eax
8010359e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801035a4:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
801035a9:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035ac:	83 c1 01             	add    $0x1,%ecx
801035af:	39 4d 10             	cmp    %ecx,0x10(%ebp)
801035b2:	75 d4                	jne    80103588 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035b4:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035ba:	83 ec 0c             	sub    $0xc,%esp
801035bd:	50                   	push   %eax
801035be:	e8 7d 09 00 00       	call   80103f40 <wakeup>
  release(&p->lock);
801035c3:	89 1c 24             	mov    %ebx,(%esp)
801035c6:	e8 65 0e 00 00       	call   80104430 <release>
  return i;
801035cb:	8b 45 10             	mov    0x10(%ebp),%eax
801035ce:	83 c4 10             	add    $0x10,%esp
}
801035d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035d4:	5b                   	pop    %ebx
801035d5:	5e                   	pop    %esi
801035d6:	5f                   	pop    %edi
801035d7:	5d                   	pop    %ebp
801035d8:	c3                   	ret    
801035d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035e0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801035e7:	eb cb                	jmp    801035b4 <piperead+0xd4>
801035e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801035f3:	eb bf                	jmp    801035b4 <piperead+0xd4>
801035f5:	66 90                	xchg   %ax,%ax
801035f7:	66 90                	xchg   %ax,%ax
801035f9:	66 90                	xchg   %ax,%ax
801035fb:	66 90                	xchg   %ax,%ax
801035fd:	66 90                	xchg   %ax,%ax
801035ff:	90                   	nop

80103600 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103604:	bb 74 42 11 80       	mov    $0x80114274,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103609:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010360c:	68 40 42 11 80       	push   $0x80114240
80103611:	e8 6a 0d 00 00       	call   80104380 <acquire>
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	eb 10                	jmp    8010362b <allocproc+0x2b>
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103620:	83 c3 7c             	add    $0x7c,%ebx
80103623:	81 fb 74 61 11 80    	cmp    $0x80116174,%ebx
80103629:	74 75                	je     801036a0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010362b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010362e:	85 c0                	test   %eax,%eax
80103630:	75 ee                	jne    80103620 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103632:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103637:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010363a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103641:	68 40 42 11 80       	push   $0x80114240
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103646:	8d 50 01             	lea    0x1(%eax),%edx
80103649:	89 43 10             	mov    %eax,0x10(%ebx)
8010364c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80103652:	e8 d9 0d 00 00       	call   80104430 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103657:	e8 84 ee ff ff       	call   801024e0 <kalloc>
8010365c:	83 c4 10             	add    $0x10,%esp
8010365f:	85 c0                	test   %eax,%eax
80103661:	89 43 08             	mov    %eax,0x8(%ebx)
80103664:	74 51                	je     801036b7 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103666:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010366c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010366f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103674:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103677:	c7 40 14 f2 5f 10 80 	movl   $0x80105ff2,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010367e:	6a 14                	push   $0x14
80103680:	6a 00                	push   $0x0
80103682:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103683:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103686:	e8 f5 0d 00 00       	call   80104480 <memset>
  p->context->eip = (uint)forkret;
8010368b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010368e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103691:	c7 40 10 c0 36 10 80 	movl   $0x801036c0,0x10(%eax)

  return p;
80103698:	89 d8                	mov    %ebx,%eax
}
8010369a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010369d:	c9                   	leave  
8010369e:	c3                   	ret    
8010369f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	68 40 42 11 80       	push   $0x80114240
801036a8:	e8 83 0d 00 00       	call   80104430 <release>
  return 0;
801036ad:	83 c4 10             	add    $0x10,%esp
801036b0:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801036b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036b5:	c9                   	leave  
801036b6:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801036b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036be:	eb da                	jmp    8010369a <allocproc+0x9a>

801036c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036c6:	68 40 42 11 80       	push   $0x80114240
801036cb:	e8 60 0d 00 00       	call   80104430 <release>

  if (first) {
801036d0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801036d5:	83 c4 10             	add    $0x10,%esp
801036d8:	85 c0                	test   %eax,%eax
801036da:	75 04                	jne    801036e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036dc:	c9                   	leave  
801036dd:	c3                   	ret    
801036de:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801036e0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801036e3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801036ea:	00 00 00 
    iinit(ROOTDEV);
801036ed:	6a 01                	push   $0x1
801036ef:	e8 cc dd ff ff       	call   801014c0 <iinit>
    initlog(ROOTDEV);
801036f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036fb:	e8 00 f4 ff ff       	call   80102b00 <initlog>
80103700:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103703:	c9                   	leave  
80103704:	c3                   	ret    
80103705:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103710 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103716:	68 95 7e 10 80       	push   $0x80107e95
8010371b:	68 40 42 11 80       	push   $0x80114240
80103720:	e8 fb 0a 00 00       	call   80104220 <initlock>
}
80103725:	83 c4 10             	add    $0x10,%esp
80103728:	c9                   	leave  
80103729:	c3                   	ret    
8010372a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103730 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	56                   	push   %esi
80103734:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103735:	9c                   	pushf  
80103736:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103737:	f6 c4 02             	test   $0x2,%ah
8010373a:	75 5b                	jne    80103797 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010373c:	e8 ff ef ff ff       	call   80102740 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103741:	8b 35 20 42 11 80    	mov    0x80114220,%esi
80103747:	85 f6                	test   %esi,%esi
80103749:	7e 3f                	jle    8010378a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010374b:	0f b6 15 a0 3c 11 80 	movzbl 0x80113ca0,%edx
80103752:	39 d0                	cmp    %edx,%eax
80103754:	74 30                	je     80103786 <mycpu+0x56>
80103756:	b9 50 3d 11 80       	mov    $0x80113d50,%ecx
8010375b:	31 d2                	xor    %edx,%edx
8010375d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103760:	83 c2 01             	add    $0x1,%edx
80103763:	39 f2                	cmp    %esi,%edx
80103765:	74 23                	je     8010378a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103767:	0f b6 19             	movzbl (%ecx),%ebx
8010376a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103770:	39 d8                	cmp    %ebx,%eax
80103772:	75 ec                	jne    80103760 <mycpu+0x30>
      return &cpus[i];
80103774:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010377a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010377d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010377e:	05 a0 3c 11 80       	add    $0x80113ca0,%eax
  }
  panic("unknown apicid\n");
}
80103783:	5e                   	pop    %esi
80103784:	5d                   	pop    %ebp
80103785:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103786:	31 d2                	xor    %edx,%edx
80103788:	eb ea                	jmp    80103774 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010378a:	83 ec 0c             	sub    $0xc,%esp
8010378d:	68 9c 7e 10 80       	push   $0x80107e9c
80103792:	e8 d9 cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103797:	83 ec 0c             	sub    $0xc,%esp
8010379a:	68 78 7f 10 80       	push   $0x80107f78
8010379f:	e8 cc cb ff ff       	call   80100370 <panic>
801037a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037b0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037b6:	e8 75 ff ff ff       	call   80103730 <mycpu>
801037bb:	2d a0 3c 11 80       	sub    $0x80113ca0,%eax
}
801037c0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037c1:	c1 f8 04             	sar    $0x4,%eax
801037c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ca:	c3                   	ret    
801037cb:	90                   	nop
801037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037d0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	53                   	push   %ebx
801037d4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801037d7:	e8 c4 0a 00 00       	call   801042a0 <pushcli>
  c = mycpu();
801037dc:	e8 4f ff ff ff       	call   80103730 <mycpu>
  p = c->proc;
801037e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037e7:	e8 f4 0a 00 00       	call   801042e0 <popcli>
  return p;
}
801037ec:	83 c4 04             	add    $0x4,%esp
801037ef:	89 d8                	mov    %ebx,%eax
801037f1:	5b                   	pop    %ebx
801037f2:	5d                   	pop    %ebp
801037f3:	c3                   	ret    
801037f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103800 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103807:	e8 f4 fd ff ff       	call   80103600 <allocproc>
8010380c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010380e:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
80103813:	e8 08 3e 00 00       	call   80107620 <setupkvm>
80103818:	85 c0                	test   %eax,%eax
8010381a:	89 43 04             	mov    %eax,0x4(%ebx)
8010381d:	0f 84 bd 00 00 00    	je     801038e0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103823:	83 ec 04             	sub    $0x4,%esp
80103826:	68 2c 00 00 00       	push   $0x2c
8010382b:	68 a0 b4 10 80       	push   $0x8010b4a0
80103830:	50                   	push   %eax
80103831:	e8 fa 3a 00 00       	call   80107330 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103836:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103839:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010383f:	6a 4c                	push   $0x4c
80103841:	6a 00                	push   $0x0
80103843:	ff 73 18             	pushl  0x18(%ebx)
80103846:	e8 35 0c 00 00       	call   80104480 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010384b:	8b 43 18             	mov    0x18(%ebx),%eax
8010384e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103853:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103858:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010385b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010385f:	8b 43 18             	mov    0x18(%ebx),%eax
80103862:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103866:	8b 43 18             	mov    0x18(%ebx),%eax
80103869:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010386d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103871:	8b 43 18             	mov    0x18(%ebx),%eax
80103874:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103878:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010387c:	8b 43 18             	mov    0x18(%ebx),%eax
8010387f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103886:	8b 43 18             	mov    0x18(%ebx),%eax
80103889:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103890:	8b 43 18             	mov    0x18(%ebx),%eax
80103893:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010389a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010389d:	6a 10                	push   $0x10
8010389f:	68 c5 7e 10 80       	push   $0x80107ec5
801038a4:	50                   	push   %eax
801038a5:	e8 d6 0d 00 00       	call   80104680 <safestrcpy>
  p->cwd = namei("/");
801038aa:	c7 04 24 ce 7e 10 80 	movl   $0x80107ece,(%esp)
801038b1:	e8 5a e6 ff ff       	call   80101f10 <namei>
801038b6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801038b9:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
801038c0:	e8 bb 0a 00 00       	call   80104380 <acquire>

  p->state = RUNNABLE;
801038c5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801038cc:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
801038d3:	e8 58 0b 00 00       	call   80104430 <release>
}
801038d8:	83 c4 10             	add    $0x10,%esp
801038db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038de:	c9                   	leave  
801038df:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801038e0:	83 ec 0c             	sub    $0xc,%esp
801038e3:	68 ac 7e 10 80       	push   $0x80107eac
801038e8:	e8 83 ca ff ff       	call   80100370 <panic>
801038ed:	8d 76 00             	lea    0x0(%esi),%esi

801038f0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	56                   	push   %esi
801038f4:	53                   	push   %ebx
801038f5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801038f8:	e8 a3 09 00 00       	call   801042a0 <pushcli>
  c = mycpu();
801038fd:	e8 2e fe ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103902:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103908:	e8 d3 09 00 00       	call   801042e0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
8010390d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103910:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103912:	7e 34                	jle    80103948 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103914:	83 ec 04             	sub    $0x4,%esp
80103917:	01 c6                	add    %eax,%esi
80103919:	56                   	push   %esi
8010391a:	50                   	push   %eax
8010391b:	ff 73 04             	pushl  0x4(%ebx)
8010391e:	e8 4d 3b 00 00       	call   80107470 <allocuvm>
80103923:	83 c4 10             	add    $0x10,%esp
80103926:	85 c0                	test   %eax,%eax
80103928:	74 36                	je     80103960 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
8010392a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
8010392d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010392f:	53                   	push   %ebx
80103930:	e8 eb 38 00 00       	call   80107220 <switchuvm>
  return 0;
80103935:	83 c4 10             	add    $0x10,%esp
80103938:	31 c0                	xor    %eax,%eax
}
8010393a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010393d:	5b                   	pop    %ebx
8010393e:	5e                   	pop    %esi
8010393f:	5d                   	pop    %ebp
80103940:	c3                   	ret    
80103941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103948:	74 e0                	je     8010392a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010394a:	83 ec 04             	sub    $0x4,%esp
8010394d:	01 c6                	add    %eax,%esi
8010394f:	56                   	push   %esi
80103950:	50                   	push   %eax
80103951:	ff 73 04             	pushl  0x4(%ebx)
80103954:	e8 17 3c 00 00       	call   80107570 <deallocuvm>
80103959:	83 c4 10             	add    $0x10,%esp
8010395c:	85 c0                	test   %eax,%eax
8010395e:	75 ca                	jne    8010392a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103965:	eb d3                	jmp    8010393a <growproc+0x4a>
80103967:	89 f6                	mov    %esi,%esi
80103969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103970 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	57                   	push   %edi
80103974:	56                   	push   %esi
80103975:	53                   	push   %ebx
80103976:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103979:	e8 22 09 00 00       	call   801042a0 <pushcli>
  c = mycpu();
8010397e:	e8 ad fd ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103983:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103989:	e8 52 09 00 00       	call   801042e0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
8010398e:	e8 6d fc ff ff       	call   80103600 <allocproc>
80103993:	85 c0                	test   %eax,%eax
80103995:	89 c7                	mov    %eax,%edi
80103997:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010399a:	0f 84 b5 00 00 00    	je     80103a55 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039a0:	83 ec 08             	sub    $0x8,%esp
801039a3:	ff 33                	pushl  (%ebx)
801039a5:	ff 73 04             	pushl  0x4(%ebx)
801039a8:	e8 63 3d 00 00       	call   80107710 <copyuvm>
801039ad:	83 c4 10             	add    $0x10,%esp
801039b0:	85 c0                	test   %eax,%eax
801039b2:	89 47 04             	mov    %eax,0x4(%edi)
801039b5:	0f 84 a1 00 00 00    	je     80103a5c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
801039bb:	8b 03                	mov    (%ebx),%eax
801039bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039c0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039c2:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801039c5:	89 c8                	mov    %ecx,%eax
801039c7:	8b 79 18             	mov    0x18(%ecx),%edi
801039ca:	8b 73 18             	mov    0x18(%ebx),%esi
801039cd:	b9 13 00 00 00       	mov    $0x13,%ecx
801039d2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039d4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801039d6:	8b 40 18             	mov    0x18(%eax),%eax
801039d9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
801039e0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039e4:	85 c0                	test   %eax,%eax
801039e6:	74 13                	je     801039fb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039e8:	83 ec 0c             	sub    $0xc,%esp
801039eb:	50                   	push   %eax
801039ec:	e8 4f d4 ff ff       	call   80100e40 <filedup>
801039f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039f4:	83 c4 10             	add    $0x10,%esp
801039f7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039fb:	83 c6 01             	add    $0x1,%esi
801039fe:	83 fe 10             	cmp    $0x10,%esi
80103a01:	75 dd                	jne    801039e0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a03:	83 ec 0c             	sub    $0xc,%esp
80103a06:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a09:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a0c:	e8 7f dc ff ff       	call   80101690 <idup>
80103a11:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a14:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a17:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a1a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a1d:	6a 10                	push   $0x10
80103a1f:	53                   	push   %ebx
80103a20:	50                   	push   %eax
80103a21:	e8 5a 0c 00 00       	call   80104680 <safestrcpy>

  pid = np->pid;
80103a26:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103a29:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103a30:	e8 4b 09 00 00       	call   80104380 <acquire>

  np->state = RUNNABLE;
80103a35:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103a3c:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103a43:	e8 e8 09 00 00       	call   80104430 <release>

  return pid;
80103a48:	83 c4 10             	add    $0x10,%esp
80103a4b:	89 d8                	mov    %ebx,%eax
}
80103a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a50:	5b                   	pop    %ebx
80103a51:	5e                   	pop    %esi
80103a52:	5f                   	pop    %edi
80103a53:	5d                   	pop    %ebp
80103a54:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a5a:	eb f1                	jmp    80103a4d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a5c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a5f:	83 ec 0c             	sub    $0xc,%esp
80103a62:	ff 77 08             	pushl  0x8(%edi)
80103a65:	e8 c6 e8 ff ff       	call   80102330 <kfree>
    np->kstack = 0;
80103a6a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a71:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a78:	83 c4 10             	add    $0x10,%esp
80103a7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a80:	eb cb                	jmp    80103a4d <fork+0xdd>
80103a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a90 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	57                   	push   %edi
80103a94:	56                   	push   %esi
80103a95:	53                   	push   %ebx
80103a96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103a99:	e8 92 fc ff ff       	call   80103730 <mycpu>
80103a9e:	8d 78 04             	lea    0x4(%eax),%edi
80103aa1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103aa3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103aaa:	00 00 00 
80103aad:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ab0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ab1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ab4:	bb 74 42 11 80       	mov    $0x80114274,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ab9:	68 40 42 11 80       	push   $0x80114240
80103abe:	e8 bd 08 00 00       	call   80104380 <acquire>
80103ac3:	83 c4 10             	add    $0x10,%esp
80103ac6:	eb 13                	jmp    80103adb <scheduler+0x4b>
80103ac8:	90                   	nop
80103ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ad0:	83 c3 7c             	add    $0x7c,%ebx
80103ad3:	81 fb 74 61 11 80    	cmp    $0x80116174,%ebx
80103ad9:	74 45                	je     80103b20 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103adb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103adf:	75 ef                	jne    80103ad0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103ae1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103ae4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103aea:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103aeb:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103aee:	e8 2d 37 00 00       	call   80107220 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103af3:	58                   	pop    %eax
80103af4:	5a                   	pop    %edx
80103af5:	ff 73 a0             	pushl  -0x60(%ebx)
80103af8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103af9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103b00:	e8 d6 0b 00 00       	call   801046db <swtch>
      switchkvm();
80103b05:	e8 f6 36 00 00       	call   80107200 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103b0a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b0d:	81 fb 74 61 11 80    	cmp    $0x80116174,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103b13:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b1a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b1d:	75 bc                	jne    80103adb <scheduler+0x4b>
80103b1f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103b20:	83 ec 0c             	sub    $0xc,%esp
80103b23:	68 40 42 11 80       	push   $0x80114240
80103b28:	e8 03 09 00 00       	call   80104430 <release>

  }
80103b2d:	83 c4 10             	add    $0x10,%esp
80103b30:	e9 7b ff ff ff       	jmp    80103ab0 <scheduler+0x20>
80103b35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b40 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	56                   	push   %esi
80103b44:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103b45:	e8 56 07 00 00       	call   801042a0 <pushcli>
  c = mycpu();
80103b4a:	e8 e1 fb ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103b4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b55:	e8 86 07 00 00       	call   801042e0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	68 40 42 11 80       	push   $0x80114240
80103b62:	e8 e9 07 00 00       	call   80104350 <holding>
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c0                	test   %eax,%eax
80103b6c:	74 4f                	je     80103bbd <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103b6e:	e8 bd fb ff ff       	call   80103730 <mycpu>
80103b73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b7a:	75 68                	jne    80103be4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103b7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b80:	74 55                	je     80103bd7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b82:	9c                   	pushf  
80103b83:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103b84:	f6 c4 02             	test   $0x2,%ah
80103b87:	75 41                	jne    80103bca <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b89:	e8 a2 fb ff ff       	call   80103730 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b8e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b97:	e8 94 fb ff ff       	call   80103730 <mycpu>
80103b9c:	83 ec 08             	sub    $0x8,%esp
80103b9f:	ff 70 04             	pushl  0x4(%eax)
80103ba2:	53                   	push   %ebx
80103ba3:	e8 33 0b 00 00       	call   801046db <swtch>
  mycpu()->intena = intena;
80103ba8:	e8 83 fb ff ff       	call   80103730 <mycpu>
}
80103bad:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103bb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bb9:	5b                   	pop    %ebx
80103bba:	5e                   	pop    %esi
80103bbb:	5d                   	pop    %ebp
80103bbc:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103bbd:	83 ec 0c             	sub    $0xc,%esp
80103bc0:	68 d0 7e 10 80       	push   $0x80107ed0
80103bc5:	e8 a6 c7 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103bca:	83 ec 0c             	sub    $0xc,%esp
80103bcd:	68 fc 7e 10 80       	push   $0x80107efc
80103bd2:	e8 99 c7 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103bd7:	83 ec 0c             	sub    $0xc,%esp
80103bda:	68 ee 7e 10 80       	push   $0x80107eee
80103bdf:	e8 8c c7 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103be4:	83 ec 0c             	sub    $0xc,%esp
80103be7:	68 e2 7e 10 80       	push   $0x80107ee2
80103bec:	e8 7f c7 ff ff       	call   80100370 <panic>
80103bf1:	eb 0d                	jmp    80103c00 <exit>
80103bf3:	90                   	nop
80103bf4:	90                   	nop
80103bf5:	90                   	nop
80103bf6:	90                   	nop
80103bf7:	90                   	nop
80103bf8:	90                   	nop
80103bf9:	90                   	nop
80103bfa:	90                   	nop
80103bfb:	90                   	nop
80103bfc:	90                   	nop
80103bfd:	90                   	nop
80103bfe:	90                   	nop
80103bff:	90                   	nop

80103c00 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c09:	e8 92 06 00 00       	call   801042a0 <pushcli>
  c = mycpu();
80103c0e:	e8 1d fb ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103c13:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c19:	e8 c2 06 00 00       	call   801042e0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c1e:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80103c24:	8d 5e 28             	lea    0x28(%esi),%ebx
80103c27:	8d 7e 68             	lea    0x68(%esi),%edi
80103c2a:	0f 84 e7 00 00 00    	je     80103d17 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103c30:	8b 03                	mov    (%ebx),%eax
80103c32:	85 c0                	test   %eax,%eax
80103c34:	74 12                	je     80103c48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103c36:	83 ec 0c             	sub    $0xc,%esp
80103c39:	50                   	push   %eax
80103c3a:	e8 51 d2 ff ff       	call   80100e90 <fileclose>
      curproc->ofile[fd] = 0;
80103c3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c45:	83 c4 10             	add    $0x10,%esp
80103c48:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c4b:	39 df                	cmp    %ebx,%edi
80103c4d:	75 e1                	jne    80103c30 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c4f:	e8 4c ef ff ff       	call   80102ba0 <begin_op>
  iput(curproc->cwd);
80103c54:	83 ec 0c             	sub    $0xc,%esp
80103c57:	ff 76 68             	pushl  0x68(%esi)
80103c5a:	e8 91 db ff ff       	call   801017f0 <iput>
  end_op();
80103c5f:	e8 ac ef ff ff       	call   80102c10 <end_op>
  curproc->cwd = 0;
80103c64:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103c6b:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103c72:	e8 09 07 00 00       	call   80104380 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103c77:	8b 56 14             	mov    0x14(%esi),%edx
80103c7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c7d:	b8 74 42 11 80       	mov    $0x80114274,%eax
80103c82:	eb 0e                	jmp    80103c92 <exit+0x92>
80103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c88:	83 c0 7c             	add    $0x7c,%eax
80103c8b:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103c90:	74 1c                	je     80103cae <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103c92:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c96:	75 f0                	jne    80103c88 <exit+0x88>
80103c98:	3b 50 20             	cmp    0x20(%eax),%edx
80103c9b:	75 eb                	jne    80103c88 <exit+0x88>
      p->state = RUNNABLE;
80103c9d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca4:	83 c0 7c             	add    $0x7c,%eax
80103ca7:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103cac:	75 e4                	jne    80103c92 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103cae:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
80103cb4:	ba 74 42 11 80       	mov    $0x80114274,%edx
80103cb9:	eb 10                	jmp    80103ccb <exit+0xcb>
80103cbb:	90                   	nop
80103cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cc0:	83 c2 7c             	add    $0x7c,%edx
80103cc3:	81 fa 74 61 11 80    	cmp    $0x80116174,%edx
80103cc9:	74 33                	je     80103cfe <exit+0xfe>
    if(p->parent == curproc){
80103ccb:	39 72 14             	cmp    %esi,0x14(%edx)
80103cce:	75 f0                	jne    80103cc0 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103cd0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103cd4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103cd7:	75 e7                	jne    80103cc0 <exit+0xc0>
80103cd9:	b8 74 42 11 80       	mov    $0x80114274,%eax
80103cde:	eb 0a                	jmp    80103cea <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ce0:	83 c0 7c             	add    $0x7c,%eax
80103ce3:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103ce8:	74 d6                	je     80103cc0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103cea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cee:	75 f0                	jne    80103ce0 <exit+0xe0>
80103cf0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103cf3:	75 eb                	jne    80103ce0 <exit+0xe0>
      p->state = RUNNABLE;
80103cf5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103cfc:	eb e2                	jmp    80103ce0 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103cfe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103d05:	e8 36 fe ff ff       	call   80103b40 <sched>
  panic("zombie exit");
80103d0a:	83 ec 0c             	sub    $0xc,%esp
80103d0d:	68 1d 7f 10 80       	push   $0x80107f1d
80103d12:	e8 59 c6 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103d17:	83 ec 0c             	sub    $0xc,%esp
80103d1a:	68 10 7f 10 80       	push   $0x80107f10
80103d1f:	e8 4c c6 ff ff       	call   80100370 <panic>
80103d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d30 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	53                   	push   %ebx
80103d34:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d37:	68 40 42 11 80       	push   $0x80114240
80103d3c:	e8 3f 06 00 00       	call   80104380 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d41:	e8 5a 05 00 00       	call   801042a0 <pushcli>
  c = mycpu();
80103d46:	e8 e5 f9 ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103d4b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d51:	e8 8a 05 00 00       	call   801042e0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103d56:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d5d:	e8 de fd ff ff       	call   80103b40 <sched>
  release(&ptable.lock);
80103d62:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103d69:	e8 c2 06 00 00       	call   80104430 <release>
}
80103d6e:	83 c4 10             	add    $0x10,%esp
80103d71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d74:	c9                   	leave  
80103d75:	c3                   	ret    
80103d76:	8d 76 00             	lea    0x0(%esi),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d80 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d8c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d8f:	e8 0c 05 00 00       	call   801042a0 <pushcli>
  c = mycpu();
80103d94:	e8 97 f9 ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103d99:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d9f:	e8 3c 05 00 00       	call   801042e0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103da4:	85 db                	test   %ebx,%ebx
80103da6:	0f 84 87 00 00 00    	je     80103e33 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103dac:	85 f6                	test   %esi,%esi
80103dae:	74 76                	je     80103e26 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103db0:	81 fe 40 42 11 80    	cmp    $0x80114240,%esi
80103db6:	74 50                	je     80103e08 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103db8:	83 ec 0c             	sub    $0xc,%esp
80103dbb:	68 40 42 11 80       	push   $0x80114240
80103dc0:	e8 bb 05 00 00       	call   80104380 <acquire>
    release(lk);
80103dc5:	89 34 24             	mov    %esi,(%esp)
80103dc8:	e8 63 06 00 00       	call   80104430 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103dcd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103dd0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103dd7:	e8 64 fd ff ff       	call   80103b40 <sched>

  // Tidy up.
  p->chan = 0;
80103ddc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103de3:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103dea:	e8 41 06 00 00       	call   80104430 <release>
    acquire(lk);
80103def:	89 75 08             	mov    %esi,0x8(%ebp)
80103df2:	83 c4 10             	add    $0x10,%esp
  }
}
80103df5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103df8:	5b                   	pop    %ebx
80103df9:	5e                   	pop    %esi
80103dfa:	5f                   	pop    %edi
80103dfb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103dfc:	e9 7f 05 00 00       	jmp    80104380 <acquire>
80103e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103e08:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e0b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103e12:	e8 29 fd ff ff       	call   80103b40 <sched>

  // Tidy up.
  p->chan = 0;
80103e17:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e21:	5b                   	pop    %ebx
80103e22:	5e                   	pop    %esi
80103e23:	5f                   	pop    %edi
80103e24:	5d                   	pop    %ebp
80103e25:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103e26:	83 ec 0c             	sub    $0xc,%esp
80103e29:	68 2f 7f 10 80       	push   $0x80107f2f
80103e2e:	e8 3d c5 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103e33:	83 ec 0c             	sub    $0xc,%esp
80103e36:	68 29 7f 10 80       	push   $0x80107f29
80103e3b:	e8 30 c5 ff ff       	call   80100370 <panic>

80103e40 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	56                   	push   %esi
80103e44:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e45:	e8 56 04 00 00       	call   801042a0 <pushcli>
  c = mycpu();
80103e4a:	e8 e1 f8 ff ff       	call   80103730 <mycpu>
  p = c->proc;
80103e4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e55:	e8 86 04 00 00       	call   801042e0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 40 42 11 80       	push   $0x80114240
80103e62:	e8 19 05 00 00       	call   80104380 <acquire>
80103e67:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103e6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e6c:	bb 74 42 11 80       	mov    $0x80114274,%ebx
80103e71:	eb 10                	jmp    80103e83 <wait+0x43>
80103e73:	90                   	nop
80103e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e78:	83 c3 7c             	add    $0x7c,%ebx
80103e7b:	81 fb 74 61 11 80    	cmp    $0x80116174,%ebx
80103e81:	74 1d                	je     80103ea0 <wait+0x60>
      if(p->parent != curproc)
80103e83:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e86:	75 f0                	jne    80103e78 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e88:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e8c:	74 30                	je     80103ebe <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e8e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103e91:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e96:	81 fb 74 61 11 80    	cmp    $0x80116174,%ebx
80103e9c:	75 e5                	jne    80103e83 <wait+0x43>
80103e9e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103ea0:	85 c0                	test   %eax,%eax
80103ea2:	74 72                	je     80103f16 <wait+0xd6>
80103ea4:	8b 46 24             	mov    0x24(%esi),%eax
80103ea7:	85 c0                	test   %eax,%eax
80103ea9:	75 6b                	jne    80103f16 <wait+0xd6>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103eab:	83 ec 08             	sub    $0x8,%esp
80103eae:	68 40 42 11 80       	push   $0x80114240
80103eb3:	56                   	push   %esi
80103eb4:	e8 c7 fe ff ff       	call   80103d80 <sleep>
  }
80103eb9:	83 c4 10             	add    $0x10,%esp
80103ebc:	eb ac                	jmp    80103e6a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103ebe:	83 ec 0c             	sub    $0xc,%esp
80103ec1:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103ec4:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ec7:	e8 64 e4 ff ff       	call   80102330 <kfree>
        p->kstack = 0;
        //cprintf("proc after stack");
        freevm(p->pgdir, pid);
80103ecc:	5a                   	pop    %edx
80103ecd:	59                   	pop    %ecx
80103ece:	56                   	push   %esi
80103ecf:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103ed2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        //cprintf("proc after stack");
        freevm(p->pgdir, pid);
80103ed9:	e8 c2 36 00 00       	call   801075a0 <freevm>
        p->pid = 0;
80103ede:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103ee5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103eec:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ef0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ef7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103efe:	c7 04 24 40 42 11 80 	movl   $0x80114240,(%esp)
80103f05:	e8 26 05 00 00       	call   80104430 <release>
        return pid;
80103f0a:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103f10:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f12:	5b                   	pop    %ebx
80103f13:	5e                   	pop    %esi
80103f14:	5d                   	pop    %ebp
80103f15:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103f16:	83 ec 0c             	sub    $0xc,%esp
80103f19:	68 40 42 11 80       	push   $0x80114240
80103f1e:	e8 0d 05 00 00       	call   80104430 <release>
      return -1;
80103f23:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f26:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80103f29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f2e:	5b                   	pop    %ebx
80103f2f:	5e                   	pop    %esi
80103f30:	5d                   	pop    %ebp
80103f31:	c3                   	ret    
80103f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 10             	sub    $0x10,%esp
80103f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f4a:	68 40 42 11 80       	push   $0x80114240
80103f4f:	e8 2c 04 00 00       	call   80104380 <acquire>
80103f54:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f57:	b8 74 42 11 80       	mov    $0x80114274,%eax
80103f5c:	eb 0c                	jmp    80103f6a <wakeup+0x2a>
80103f5e:	66 90                	xchg   %ax,%ax
80103f60:	83 c0 7c             	add    $0x7c,%eax
80103f63:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103f68:	74 1c                	je     80103f86 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f6a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f6e:	75 f0                	jne    80103f60 <wakeup+0x20>
80103f70:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f73:	75 eb                	jne    80103f60 <wakeup+0x20>
      p->state = RUNNABLE;
80103f75:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f7c:	83 c0 7c             	add    $0x7c,%eax
80103f7f:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103f84:	75 e4                	jne    80103f6a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f86:	c7 45 08 40 42 11 80 	movl   $0x80114240,0x8(%ebp)
}
80103f8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f90:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f91:	e9 9a 04 00 00       	jmp    80104430 <release>
80103f96:	8d 76 00             	lea    0x0(%esi),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	53                   	push   %ebx
80103fa4:	83 ec 10             	sub    $0x10,%esp
80103fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103faa:	68 40 42 11 80       	push   $0x80114240
80103faf:	e8 cc 03 00 00       	call   80104380 <acquire>
80103fb4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb7:	b8 74 42 11 80       	mov    $0x80114274,%eax
80103fbc:	eb 0c                	jmp    80103fca <kill+0x2a>
80103fbe:	66 90                	xchg   %ax,%ax
80103fc0:	83 c0 7c             	add    $0x7c,%eax
80103fc3:	3d 74 61 11 80       	cmp    $0x80116174,%eax
80103fc8:	74 3e                	je     80104008 <kill+0x68>
    if(p->pid == pid){
80103fca:	39 58 10             	cmp    %ebx,0x10(%eax)
80103fcd:	75 f1                	jne    80103fc0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fcf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103fd3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fda:	74 1c                	je     80103ff8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103fdc:	83 ec 0c             	sub    $0xc,%esp
80103fdf:	68 40 42 11 80       	push   $0x80114240
80103fe4:	e8 47 04 00 00       	call   80104430 <release>
      return 0;
80103fe9:	83 c4 10             	add    $0x10,%esp
80103fec:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ff1:	c9                   	leave  
80103ff2:	c3                   	ret    
80103ff3:	90                   	nop
80103ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103ff8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fff:	eb db                	jmp    80103fdc <kill+0x3c>
80104001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104008:	83 ec 0c             	sub    $0xc,%esp
8010400b:	68 40 42 11 80       	push   $0x80114240
80104010:	e8 1b 04 00 00       	call   80104430 <release>
  return -1;
80104015:	83 c4 10             	add    $0x10,%esp
80104018:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010401d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104020:	c9                   	leave  
80104021:	c3                   	ret    
80104022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104030 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	57                   	push   %edi
80104034:	56                   	push   %esi
80104035:	53                   	push   %ebx
80104036:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104039:	bb e0 42 11 80       	mov    $0x801142e0,%ebx
8010403e:	83 ec 3c             	sub    $0x3c,%esp
80104041:	eb 24                	jmp    80104067 <procdump+0x37>
80104043:	90                   	nop
80104044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104048:	83 ec 0c             	sub    $0xc,%esp
8010404b:	68 fb 7f 10 80       	push   $0x80107ffb
80104050:	e8 0b c6 ff ff       	call   80100660 <cprintf>
80104055:	83 c4 10             	add    $0x10,%esp
80104058:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010405b:	81 fb e0 61 11 80    	cmp    $0x801161e0,%ebx
80104061:	0f 84 81 00 00 00    	je     801040e8 <procdump+0xb8>
    if(p->state == UNUSED)
80104067:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010406a:	85 c0                	test   %eax,%eax
8010406c:	74 ea                	je     80104058 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010406e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104071:	ba 40 7f 10 80       	mov    $0x80107f40,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104076:	77 11                	ja     80104089 <procdump+0x59>
80104078:	8b 14 85 a0 7f 10 80 	mov    -0x7fef8060(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010407f:	b8 40 7f 10 80       	mov    $0x80107f40,%eax
80104084:	85 d2                	test   %edx,%edx
80104086:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104089:	53                   	push   %ebx
8010408a:	52                   	push   %edx
8010408b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010408e:	68 44 7f 10 80       	push   $0x80107f44
80104093:	e8 c8 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104098:	83 c4 10             	add    $0x10,%esp
8010409b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010409f:	75 a7                	jne    80104048 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040a1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040a4:	83 ec 08             	sub    $0x8,%esp
801040a7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040aa:	50                   	push   %eax
801040ab:	8b 43 b0             	mov    -0x50(%ebx),%eax
801040ae:	8b 40 0c             	mov    0xc(%eax),%eax
801040b1:	83 c0 08             	add    $0x8,%eax
801040b4:	50                   	push   %eax
801040b5:	e8 86 01 00 00       	call   80104240 <getcallerpcs>
801040ba:	83 c4 10             	add    $0x10,%esp
801040bd:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801040c0:	8b 17                	mov    (%edi),%edx
801040c2:	85 d2                	test   %edx,%edx
801040c4:	74 82                	je     80104048 <procdump+0x18>
        cprintf(" %p", pc[i]);
801040c6:	83 ec 08             	sub    $0x8,%esp
801040c9:	83 c7 04             	add    $0x4,%edi
801040cc:	52                   	push   %edx
801040cd:	68 61 79 10 80       	push   $0x80107961
801040d2:	e8 89 c5 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801040d7:	83 c4 10             	add    $0x10,%esp
801040da:	39 f7                	cmp    %esi,%edi
801040dc:	75 e2                	jne    801040c0 <procdump+0x90>
801040de:	e9 65 ff ff ff       	jmp    80104048 <procdump+0x18>
801040e3:	90                   	nop
801040e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801040e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040eb:	5b                   	pop    %ebx
801040ec:	5e                   	pop    %esi
801040ed:	5f                   	pop    %edi
801040ee:	5d                   	pop    %ebp
801040ef:	c3                   	ret    

801040f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	53                   	push   %ebx
801040f4:	83 ec 0c             	sub    $0xc,%esp
801040f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801040fa:	68 b8 7f 10 80       	push   $0x80107fb8
801040ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104102:	50                   	push   %eax
80104103:	e8 18 01 00 00       	call   80104220 <initlock>
  lk->name = name;
80104108:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010410b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104111:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104114:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010411b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010411e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104121:	c9                   	leave  
80104122:	c3                   	ret    
80104123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104130 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	56                   	push   %esi
80104134:	53                   	push   %ebx
80104135:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	8d 73 04             	lea    0x4(%ebx),%esi
8010413e:	56                   	push   %esi
8010413f:	e8 3c 02 00 00       	call   80104380 <acquire>
  while (lk->locked) {
80104144:	8b 13                	mov    (%ebx),%edx
80104146:	83 c4 10             	add    $0x10,%esp
80104149:	85 d2                	test   %edx,%edx
8010414b:	74 16                	je     80104163 <acquiresleep+0x33>
8010414d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104150:	83 ec 08             	sub    $0x8,%esp
80104153:	56                   	push   %esi
80104154:	53                   	push   %ebx
80104155:	e8 26 fc ff ff       	call   80103d80 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010415a:	8b 03                	mov    (%ebx),%eax
8010415c:	83 c4 10             	add    $0x10,%esp
8010415f:	85 c0                	test   %eax,%eax
80104161:	75 ed                	jne    80104150 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104163:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104169:	e8 62 f6 ff ff       	call   801037d0 <myproc>
8010416e:	8b 40 10             	mov    0x10(%eax),%eax
80104171:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104174:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104177:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010417a:	5b                   	pop    %ebx
8010417b:	5e                   	pop    %esi
8010417c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010417d:	e9 ae 02 00 00       	jmp    80104430 <release>
80104182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104190 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	56                   	push   %esi
80104194:	53                   	push   %ebx
80104195:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104198:	83 ec 0c             	sub    $0xc,%esp
8010419b:	8d 73 04             	lea    0x4(%ebx),%esi
8010419e:	56                   	push   %esi
8010419f:	e8 dc 01 00 00       	call   80104380 <acquire>
  lk->locked = 0;
801041a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801041aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801041b1:	89 1c 24             	mov    %ebx,(%esp)
801041b4:	e8 87 fd ff ff       	call   80103f40 <wakeup>
  release(&lk->lk);
801041b9:	89 75 08             	mov    %esi,0x8(%ebp)
801041bc:	83 c4 10             	add    $0x10,%esp
}
801041bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041c2:	5b                   	pop    %ebx
801041c3:	5e                   	pop    %esi
801041c4:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801041c5:	e9 66 02 00 00       	jmp    80104430 <release>
801041ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041d0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	31 ff                	xor    %edi,%edi
801041d8:	83 ec 18             	sub    $0x18,%esp
801041db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801041de:	8d 73 04             	lea    0x4(%ebx),%esi
801041e1:	56                   	push   %esi
801041e2:	e8 99 01 00 00       	call   80104380 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801041e7:	8b 03                	mov    (%ebx),%eax
801041e9:	83 c4 10             	add    $0x10,%esp
801041ec:	85 c0                	test   %eax,%eax
801041ee:	74 13                	je     80104203 <holdingsleep+0x33>
801041f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801041f3:	e8 d8 f5 ff ff       	call   801037d0 <myproc>
801041f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801041fb:	0f 94 c0             	sete   %al
801041fe:	0f b6 c0             	movzbl %al,%eax
80104201:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104203:	83 ec 0c             	sub    $0xc,%esp
80104206:	56                   	push   %esi
80104207:	e8 24 02 00 00       	call   80104430 <release>
  return r;
}
8010420c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010420f:	89 f8                	mov    %edi,%eax
80104211:	5b                   	pop    %ebx
80104212:	5e                   	pop    %esi
80104213:	5f                   	pop    %edi
80104214:	5d                   	pop    %ebp
80104215:	c3                   	ret    
80104216:	66 90                	xchg   %ax,%ax
80104218:	66 90                	xchg   %ax,%ax
8010421a:	66 90                	xchg   %ax,%ax
8010421c:	66 90                	xchg   %ax,%ax
8010421e:	66 90                	xchg   %ax,%ax

80104220 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104226:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104229:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010422f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104232:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104239:	5d                   	pop    %ebp
8010423a:	c3                   	ret    
8010423b:	90                   	nop
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104240 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104244:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010424a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010424d:	31 c0                	xor    %eax,%eax
8010424f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104250:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104256:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010425c:	77 1a                	ja     80104278 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010425e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104261:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104264:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104267:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104269:	83 f8 0a             	cmp    $0xa,%eax
8010426c:	75 e2                	jne    80104250 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010426e:	5b                   	pop    %ebx
8010426f:	5d                   	pop    %ebp
80104270:	c3                   	ret    
80104271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104278:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010427f:	83 c0 01             	add    $0x1,%eax
80104282:	83 f8 0a             	cmp    $0xa,%eax
80104285:	74 e7                	je     8010426e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104287:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010428e:	83 c0 01             	add    $0x1,%eax
80104291:	83 f8 0a             	cmp    $0xa,%eax
80104294:	75 e2                	jne    80104278 <getcallerpcs+0x38>
80104296:	eb d6                	jmp    8010426e <getcallerpcs+0x2e>
80104298:	90                   	nop
80104299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 04             	sub    $0x4,%esp
801042a7:	9c                   	pushf  
801042a8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801042a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801042aa:	e8 81 f4 ff ff       	call   80103730 <mycpu>
801042af:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801042b5:	85 c0                	test   %eax,%eax
801042b7:	75 11                	jne    801042ca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801042b9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801042bf:	e8 6c f4 ff ff       	call   80103730 <mycpu>
801042c4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801042ca:	e8 61 f4 ff ff       	call   80103730 <mycpu>
801042cf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801042d6:	83 c4 04             	add    $0x4,%esp
801042d9:	5b                   	pop    %ebx
801042da:	5d                   	pop    %ebp
801042db:	c3                   	ret    
801042dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042e0 <popcli>:

void
popcli(void)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042e6:	9c                   	pushf  
801042e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801042e8:	f6 c4 02             	test   $0x2,%ah
801042eb:	75 52                	jne    8010433f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801042ed:	e8 3e f4 ff ff       	call   80103730 <mycpu>
801042f2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801042f8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801042fb:	85 d2                	test   %edx,%edx
801042fd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104303:	78 2d                	js     80104332 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104305:	e8 26 f4 ff ff       	call   80103730 <mycpu>
8010430a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104310:	85 d2                	test   %edx,%edx
80104312:	74 0c                	je     80104320 <popcli+0x40>
    sti();
}
80104314:	c9                   	leave  
80104315:	c3                   	ret    
80104316:	8d 76 00             	lea    0x0(%esi),%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104320:	e8 0b f4 ff ff       	call   80103730 <mycpu>
80104325:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010432b:	85 c0                	test   %eax,%eax
8010432d:	74 e5                	je     80104314 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010432f:	fb                   	sti    
    sti();
}
80104330:	c9                   	leave  
80104331:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104332:	83 ec 0c             	sub    $0xc,%esp
80104335:	68 da 7f 10 80       	push   $0x80107fda
8010433a:	e8 31 c0 ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010433f:	83 ec 0c             	sub    $0xc,%esp
80104342:	68 c3 7f 10 80       	push   $0x80107fc3
80104347:	e8 24 c0 ff ff       	call   80100370 <panic>
8010434c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104350 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	56                   	push   %esi
80104354:	53                   	push   %ebx
80104355:	8b 75 08             	mov    0x8(%ebp),%esi
80104358:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
8010435a:	e8 41 ff ff ff       	call   801042a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010435f:	8b 06                	mov    (%esi),%eax
80104361:	85 c0                	test   %eax,%eax
80104363:	74 10                	je     80104375 <holding+0x25>
80104365:	8b 5e 08             	mov    0x8(%esi),%ebx
80104368:	e8 c3 f3 ff ff       	call   80103730 <mycpu>
8010436d:	39 c3                	cmp    %eax,%ebx
8010436f:	0f 94 c3             	sete   %bl
80104372:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104375:	e8 66 ff ff ff       	call   801042e0 <popcli>
  return r;
}
8010437a:	89 d8                	mov    %ebx,%eax
8010437c:	5b                   	pop    %ebx
8010437d:	5e                   	pop    %esi
8010437e:	5d                   	pop    %ebp
8010437f:	c3                   	ret    

80104380 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104387:	e8 14 ff ff ff       	call   801042a0 <pushcli>
  if(holding(lk))
8010438c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010438f:	83 ec 0c             	sub    $0xc,%esp
80104392:	53                   	push   %ebx
80104393:	e8 b8 ff ff ff       	call   80104350 <holding>
80104398:	83 c4 10             	add    $0x10,%esp
8010439b:	85 c0                	test   %eax,%eax
8010439d:	0f 85 7d 00 00 00    	jne    80104420 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801043a3:	ba 01 00 00 00       	mov    $0x1,%edx
801043a8:	eb 09                	jmp    801043b3 <acquire+0x33>
801043aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043b3:	89 d0                	mov    %edx,%eax
801043b5:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801043b8:	85 c0                	test   %eax,%eax
801043ba:	75 f4                	jne    801043b0 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801043bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043c4:	e8 67 f3 ff ff       	call   80103730 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043c9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801043cb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801043ce:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043d1:	31 c0                	xor    %eax,%eax
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043d8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043de:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043e4:	77 1a                	ja     80104400 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043e6:	8b 5a 04             	mov    0x4(%edx),%ebx
801043e9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043ec:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043ef:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043f1:	83 f8 0a             	cmp    $0xa,%eax
801043f4:	75 e2                	jne    801043d8 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801043f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043f9:	c9                   	leave  
801043fa:	c3                   	ret    
801043fb:	90                   	nop
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104400:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104407:	83 c0 01             	add    $0x1,%eax
8010440a:	83 f8 0a             	cmp    $0xa,%eax
8010440d:	74 e7                	je     801043f6 <acquire+0x76>
    pcs[i] = 0;
8010440f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104416:	83 c0 01             	add    $0x1,%eax
80104419:	83 f8 0a             	cmp    $0xa,%eax
8010441c:	75 e2                	jne    80104400 <acquire+0x80>
8010441e:	eb d6                	jmp    801043f6 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104420:	83 ec 0c             	sub    $0xc,%esp
80104423:	68 e1 7f 10 80       	push   $0x80107fe1
80104428:	e8 43 bf ff ff       	call   80100370 <panic>
8010442d:	8d 76 00             	lea    0x0(%esi),%esi

80104430 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	53                   	push   %ebx
80104434:	83 ec 10             	sub    $0x10,%esp
80104437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010443a:	53                   	push   %ebx
8010443b:	e8 10 ff ff ff       	call   80104350 <holding>
80104440:	83 c4 10             	add    $0x10,%esp
80104443:	85 c0                	test   %eax,%eax
80104445:	74 22                	je     80104469 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104447:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010444e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104455:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010445a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104460:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104463:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104464:	e9 77 fe ff ff       	jmp    801042e0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104469:	83 ec 0c             	sub    $0xc,%esp
8010446c:	68 e9 7f 10 80       	push   $0x80107fe9
80104471:	e8 fa be ff ff       	call   80100370 <panic>
80104476:	66 90                	xchg   %ax,%ax
80104478:	66 90                	xchg   %ax,%ax
8010447a:	66 90                	xchg   %ax,%ax
8010447c:	66 90                	xchg   %ax,%ax
8010447e:	66 90                	xchg   %ax,%ax

80104480 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	53                   	push   %ebx
80104485:	8b 55 08             	mov    0x8(%ebp),%edx
80104488:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010448b:	f6 c2 03             	test   $0x3,%dl
8010448e:	75 05                	jne    80104495 <memset+0x15>
80104490:	f6 c1 03             	test   $0x3,%cl
80104493:	74 13                	je     801044a8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104495:	89 d7                	mov    %edx,%edi
80104497:	8b 45 0c             	mov    0xc(%ebp),%eax
8010449a:	fc                   	cld    
8010449b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010449d:	5b                   	pop    %ebx
8010449e:	89 d0                	mov    %edx,%eax
801044a0:	5f                   	pop    %edi
801044a1:	5d                   	pop    %ebp
801044a2:	c3                   	ret    
801044a3:	90                   	nop
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801044a8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801044ac:	c1 e9 02             	shr    $0x2,%ecx
801044af:	89 fb                	mov    %edi,%ebx
801044b1:	89 f8                	mov    %edi,%eax
801044b3:	c1 e3 18             	shl    $0x18,%ebx
801044b6:	c1 e0 10             	shl    $0x10,%eax
801044b9:	09 d8                	or     %ebx,%eax
801044bb:	09 f8                	or     %edi,%eax
801044bd:	c1 e7 08             	shl    $0x8,%edi
801044c0:	09 f8                	or     %edi,%eax
801044c2:	89 d7                	mov    %edx,%edi
801044c4:	fc                   	cld    
801044c5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801044c7:	5b                   	pop    %ebx
801044c8:	89 d0                	mov    %edx,%eax
801044ca:	5f                   	pop    %edi
801044cb:	5d                   	pop    %ebp
801044cc:	c3                   	ret    
801044cd:	8d 76 00             	lea    0x0(%esi),%esi

801044d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	57                   	push   %edi
801044d4:	56                   	push   %esi
801044d5:	8b 45 10             	mov    0x10(%ebp),%eax
801044d8:	53                   	push   %ebx
801044d9:	8b 75 0c             	mov    0xc(%ebp),%esi
801044dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801044df:	85 c0                	test   %eax,%eax
801044e1:	74 29                	je     8010450c <memcmp+0x3c>
    if(*s1 != *s2)
801044e3:	0f b6 13             	movzbl (%ebx),%edx
801044e6:	0f b6 0e             	movzbl (%esi),%ecx
801044e9:	38 d1                	cmp    %dl,%cl
801044eb:	75 2b                	jne    80104518 <memcmp+0x48>
801044ed:	8d 78 ff             	lea    -0x1(%eax),%edi
801044f0:	31 c0                	xor    %eax,%eax
801044f2:	eb 14                	jmp    80104508 <memcmp+0x38>
801044f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044f8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801044fd:	83 c0 01             	add    $0x1,%eax
80104500:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104504:	38 ca                	cmp    %cl,%dl
80104506:	75 10                	jne    80104518 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104508:	39 f8                	cmp    %edi,%eax
8010450a:	75 ec                	jne    801044f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010450c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010450d:	31 c0                	xor    %eax,%eax
}
8010450f:	5e                   	pop    %esi
80104510:	5f                   	pop    %edi
80104511:	5d                   	pop    %ebp
80104512:	c3                   	ret    
80104513:	90                   	nop
80104514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104518:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010451b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010451c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010451e:	5e                   	pop    %esi
8010451f:	5f                   	pop    %edi
80104520:	5d                   	pop    %ebp
80104521:	c3                   	ret    
80104522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	56                   	push   %esi
80104534:	53                   	push   %ebx
80104535:	8b 45 08             	mov    0x8(%ebp),%eax
80104538:	8b 75 0c             	mov    0xc(%ebp),%esi
8010453b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010453e:	39 c6                	cmp    %eax,%esi
80104540:	73 2e                	jae    80104570 <memmove+0x40>
80104542:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104545:	39 c8                	cmp    %ecx,%eax
80104547:	73 27                	jae    80104570 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104549:	85 db                	test   %ebx,%ebx
8010454b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010454e:	74 17                	je     80104567 <memmove+0x37>
      *--d = *--s;
80104550:	29 d9                	sub    %ebx,%ecx
80104552:	89 cb                	mov    %ecx,%ebx
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104558:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010455c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010455f:	83 ea 01             	sub    $0x1,%edx
80104562:	83 fa ff             	cmp    $0xffffffff,%edx
80104565:	75 f1                	jne    80104558 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104567:	5b                   	pop    %ebx
80104568:	5e                   	pop    %esi
80104569:	5d                   	pop    %ebp
8010456a:	c3                   	ret    
8010456b:	90                   	nop
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104570:	31 d2                	xor    %edx,%edx
80104572:	85 db                	test   %ebx,%ebx
80104574:	74 f1                	je     80104567 <memmove+0x37>
80104576:	8d 76 00             	lea    0x0(%esi),%esi
80104579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104580:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104584:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104587:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010458a:	39 d3                	cmp    %edx,%ebx
8010458c:	75 f2                	jne    80104580 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010458e:	5b                   	pop    %ebx
8010458f:	5e                   	pop    %esi
80104590:	5d                   	pop    %ebp
80104591:	c3                   	ret    
80104592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801045a3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801045a4:	eb 8a                	jmp    80104530 <memmove>
801045a6:	8d 76 00             	lea    0x0(%esi),%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	57                   	push   %edi
801045b4:	56                   	push   %esi
801045b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045b8:	53                   	push   %ebx
801045b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801045bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801045bf:	85 c9                	test   %ecx,%ecx
801045c1:	74 37                	je     801045fa <strncmp+0x4a>
801045c3:	0f b6 17             	movzbl (%edi),%edx
801045c6:	0f b6 1e             	movzbl (%esi),%ebx
801045c9:	84 d2                	test   %dl,%dl
801045cb:	74 3f                	je     8010460c <strncmp+0x5c>
801045cd:	38 d3                	cmp    %dl,%bl
801045cf:	75 3b                	jne    8010460c <strncmp+0x5c>
801045d1:	8d 47 01             	lea    0x1(%edi),%eax
801045d4:	01 cf                	add    %ecx,%edi
801045d6:	eb 1b                	jmp    801045f3 <strncmp+0x43>
801045d8:	90                   	nop
801045d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045e0:	0f b6 10             	movzbl (%eax),%edx
801045e3:	84 d2                	test   %dl,%dl
801045e5:	74 21                	je     80104608 <strncmp+0x58>
801045e7:	0f b6 19             	movzbl (%ecx),%ebx
801045ea:	83 c0 01             	add    $0x1,%eax
801045ed:	89 ce                	mov    %ecx,%esi
801045ef:	38 da                	cmp    %bl,%dl
801045f1:	75 19                	jne    8010460c <strncmp+0x5c>
801045f3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
801045f5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801045f8:	75 e6                	jne    801045e0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801045fa:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801045fb:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801045fd:	5e                   	pop    %esi
801045fe:	5f                   	pop    %edi
801045ff:	5d                   	pop    %ebp
80104600:	c3                   	ret    
80104601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104608:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010460c:	0f b6 c2             	movzbl %dl,%eax
8010460f:	29 d8                	sub    %ebx,%eax
}
80104611:	5b                   	pop    %ebx
80104612:	5e                   	pop    %esi
80104613:	5f                   	pop    %edi
80104614:	5d                   	pop    %ebp
80104615:	c3                   	ret    
80104616:	8d 76 00             	lea    0x0(%esi),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	56                   	push   %esi
80104624:	53                   	push   %ebx
80104625:	8b 45 08             	mov    0x8(%ebp),%eax
80104628:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010462b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010462e:	89 c2                	mov    %eax,%edx
80104630:	eb 19                	jmp    8010464b <strncpy+0x2b>
80104632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104638:	83 c3 01             	add    $0x1,%ebx
8010463b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010463f:	83 c2 01             	add    $0x1,%edx
80104642:	84 c9                	test   %cl,%cl
80104644:	88 4a ff             	mov    %cl,-0x1(%edx)
80104647:	74 09                	je     80104652 <strncpy+0x32>
80104649:	89 f1                	mov    %esi,%ecx
8010464b:	85 c9                	test   %ecx,%ecx
8010464d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104650:	7f e6                	jg     80104638 <strncpy+0x18>
    ;
  while(n-- > 0)
80104652:	31 c9                	xor    %ecx,%ecx
80104654:	85 f6                	test   %esi,%esi
80104656:	7e 17                	jle    8010466f <strncpy+0x4f>
80104658:	90                   	nop
80104659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104660:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104664:	89 f3                	mov    %esi,%ebx
80104666:	83 c1 01             	add    $0x1,%ecx
80104669:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010466b:	85 db                	test   %ebx,%ebx
8010466d:	7f f1                	jg     80104660 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010466f:	5b                   	pop    %ebx
80104670:	5e                   	pop    %esi
80104671:	5d                   	pop    %ebp
80104672:	c3                   	ret    
80104673:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104680 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104688:	8b 45 08             	mov    0x8(%ebp),%eax
8010468b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010468e:	85 c9                	test   %ecx,%ecx
80104690:	7e 26                	jle    801046b8 <safestrcpy+0x38>
80104692:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104696:	89 c1                	mov    %eax,%ecx
80104698:	eb 17                	jmp    801046b1 <safestrcpy+0x31>
8010469a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801046a0:	83 c2 01             	add    $0x1,%edx
801046a3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801046a7:	83 c1 01             	add    $0x1,%ecx
801046aa:	84 db                	test   %bl,%bl
801046ac:	88 59 ff             	mov    %bl,-0x1(%ecx)
801046af:	74 04                	je     801046b5 <safestrcpy+0x35>
801046b1:	39 f2                	cmp    %esi,%edx
801046b3:	75 eb                	jne    801046a0 <safestrcpy+0x20>
    ;
  *s = 0;
801046b5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801046b8:	5b                   	pop    %ebx
801046b9:	5e                   	pop    %esi
801046ba:	5d                   	pop    %ebp
801046bb:	c3                   	ret    
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046c0 <strlen>:

int
strlen(const char *s)
{
801046c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801046c1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801046c3:	89 e5                	mov    %esp,%ebp
801046c5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801046c8:	80 3a 00             	cmpb   $0x0,(%edx)
801046cb:	74 0c                	je     801046d9 <strlen+0x19>
801046cd:	8d 76 00             	lea    0x0(%esi),%esi
801046d0:	83 c0 01             	add    $0x1,%eax
801046d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801046d7:	75 f7                	jne    801046d0 <strlen+0x10>
    ;
  return n;
}
801046d9:	5d                   	pop    %ebp
801046da:	c3                   	ret    

801046db <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801046db:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801046df:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801046e3:	55                   	push   %ebp
  pushl %ebx
801046e4:	53                   	push   %ebx
  pushl %esi
801046e5:	56                   	push   %esi
  pushl %edi
801046e6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801046e7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801046e9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801046eb:	5f                   	pop    %edi
  popl %esi
801046ec:	5e                   	pop    %esi
  popl %ebx
801046ed:	5b                   	pop    %ebx
  popl %ebp
801046ee:	5d                   	pop    %ebp
  ret
801046ef:	c3                   	ret    

801046f0 <sys_countTrap>:
  return 0;
}



int sys_countTrap(void){
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	53                   	push   %ebx
  cprintf("Count: %d \n", countSys);
801046f4:	31 db                	xor    %ebx,%ebx
  return 0;
}



int sys_countTrap(void){
801046f6:	83 ec 0c             	sub    $0xc,%esp
  cprintf("Count: %d \n", countSys);
801046f9:	ff 35 74 b6 10 80    	pushl  0x8010b674
801046ff:	68 f1 7f 10 80       	push   $0x80107ff1
80104704:	e8 57 bf ff ff       	call   80100660 <cprintf>
80104709:	83 c4 10             	add    $0x10,%esp
8010470c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < NELEM(syscalls); i++){
    cprintf("Syscall %d, count: %d \n", i, syscallsValCounters[i]);
80104710:	83 ec 04             	sub    $0x4,%esp
80104713:	ff 34 9d 00 b6 10 80 	pushl  -0x7fef4a00(,%ebx,4)
8010471a:	53                   	push   %ebx
8010471b:	68 fd 7f 10 80       	push   $0x80107ffd



int sys_countTrap(void){
  cprintf("Count: %d \n", countSys);
  for(int i = 0; i < NELEM(syscalls); i++){
80104720:	83 c3 01             	add    $0x1,%ebx
    cprintf("Syscall %d, count: %d \n", i, syscallsValCounters[i]);
80104723:	e8 38 bf ff ff       	call   80100660 <cprintf>



int sys_countTrap(void){
  cprintf("Count: %d \n", countSys);
  for(int i = 0; i < NELEM(syscalls); i++){
80104728:	83 c4 10             	add    $0x10,%esp
8010472b:	83 fb 1d             	cmp    $0x1d,%ebx
8010472e:	75 e0                	jne    80104710 <sys_countTrap+0x20>
  // cprintf("IRQ_SPURIOUS, count: %d \n",  trapValCounters[T_IRQ0+IRQ_SPURIOUS]);

  

  return 0;
}
80104730:	31 c0                	xor    %eax,%eax
80104732:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104735:	c9                   	leave  
80104736:	c3                   	ret    
80104737:	89 f6                	mov    %esi,%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 04             	sub    $0x4,%esp
80104747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010474a:	e8 81 f0 ff ff       	call   801037d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010474f:	8b 00                	mov    (%eax),%eax
80104751:	39 d8                	cmp    %ebx,%eax
80104753:	76 1b                	jbe    80104770 <fetchint+0x30>
80104755:	8d 53 04             	lea    0x4(%ebx),%edx
80104758:	39 d0                	cmp    %edx,%eax
8010475a:	72 14                	jb     80104770 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010475c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010475f:	8b 13                	mov    (%ebx),%edx
80104761:	89 10                	mov    %edx,(%eax)
  return 0;
80104763:	31 c0                	xor    %eax,%eax
}
80104765:	83 c4 04             	add    $0x4,%esp
80104768:	5b                   	pop    %ebx
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	90                   	nop
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104775:	eb ee                	jmp    80104765 <fetchint+0x25>
80104777:	89 f6                	mov    %esi,%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104780 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
80104787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010478a:	e8 41 f0 ff ff       	call   801037d0 <myproc>

  if(addr >= curproc->sz)
8010478f:	39 18                	cmp    %ebx,(%eax)
80104791:	76 29                	jbe    801047bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104793:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104796:	89 da                	mov    %ebx,%edx
80104798:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010479a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010479c:	39 c3                	cmp    %eax,%ebx
8010479e:	73 1c                	jae    801047bc <fetchstr+0x3c>
    if(*s == 0)
801047a0:	80 3b 00             	cmpb   $0x0,(%ebx)
801047a3:	75 10                	jne    801047b5 <fetchstr+0x35>
801047a5:	eb 29                	jmp    801047d0 <fetchstr+0x50>
801047a7:	89 f6                	mov    %esi,%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047b0:	80 3a 00             	cmpb   $0x0,(%edx)
801047b3:	74 1b                	je     801047d0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801047b5:	83 c2 01             	add    $0x1,%edx
801047b8:	39 d0                	cmp    %edx,%eax
801047ba:	77 f4                	ja     801047b0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801047bc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801047bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801047c4:	5b                   	pop    %ebx
801047c5:	5d                   	pop    %ebp
801047c6:	c3                   	ret    
801047c7:	89 f6                	mov    %esi,%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047d0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801047d3:	89 d0                	mov    %edx,%eax
801047d5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801047d7:	5b                   	pop    %ebx
801047d8:	5d                   	pop    %ebp
801047d9:	c3                   	ret    
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801047e5:	e8 e6 ef ff ff       	call   801037d0 <myproc>
801047ea:	8b 40 18             	mov    0x18(%eax),%eax
801047ed:	8b 55 08             	mov    0x8(%ebp),%edx
801047f0:	8b 40 44             	mov    0x44(%eax),%eax
801047f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801047f6:	e8 d5 ef ff ff       	call   801037d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047fb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801047fd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104800:	39 c6                	cmp    %eax,%esi
80104802:	73 1c                	jae    80104820 <argint+0x40>
80104804:	8d 53 08             	lea    0x8(%ebx),%edx
80104807:	39 d0                	cmp    %edx,%eax
80104809:	72 15                	jb     80104820 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010480b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010480e:	8b 53 04             	mov    0x4(%ebx),%edx
80104811:	89 10                	mov    %edx,(%eax)
  return 0;
80104813:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104815:	5b                   	pop    %ebx
80104816:	5e                   	pop    %esi
80104817:	5d                   	pop    %ebp
80104818:	c3                   	ret    
80104819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104825:	eb ee                	jmp    80104815 <argint+0x35>
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
80104835:	83 ec 10             	sub    $0x10,%esp
80104838:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010483b:	e8 90 ef ff ff       	call   801037d0 <myproc>
80104840:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104842:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104845:	83 ec 08             	sub    $0x8,%esp
80104848:	50                   	push   %eax
80104849:	ff 75 08             	pushl  0x8(%ebp)
8010484c:	e8 8f ff ff ff       	call   801047e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104851:	c1 e8 1f             	shr    $0x1f,%eax
80104854:	83 c4 10             	add    $0x10,%esp
80104857:	84 c0                	test   %al,%al
80104859:	75 2d                	jne    80104888 <argptr+0x58>
8010485b:	89 d8                	mov    %ebx,%eax
8010485d:	c1 e8 1f             	shr    $0x1f,%eax
80104860:	84 c0                	test   %al,%al
80104862:	75 24                	jne    80104888 <argptr+0x58>
80104864:	8b 16                	mov    (%esi),%edx
80104866:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104869:	39 c2                	cmp    %eax,%edx
8010486b:	76 1b                	jbe    80104888 <argptr+0x58>
8010486d:	01 c3                	add    %eax,%ebx
8010486f:	39 da                	cmp    %ebx,%edx
80104871:	72 15                	jb     80104888 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104873:	8b 55 0c             	mov    0xc(%ebp),%edx
80104876:	89 02                	mov    %eax,(%edx)
  return 0;
80104878:	31 c0                	xor    %eax,%eax
}
8010487a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010487d:	5b                   	pop    %ebx
8010487e:	5e                   	pop    %esi
8010487f:	5d                   	pop    %ebp
80104880:	c3                   	ret    
80104881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104888:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010488d:	eb eb                	jmp    8010487a <argptr+0x4a>
8010488f:	90                   	nop

80104890 <sys_callBWrite>:
extern int countTrap;
extern int unkownTrap;
extern int trapValCounters[256];


int sys_callBWrite(void){
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
  int devices;
  int blockno;
  char* dataBuffer;

  if(argint(0, &devices) < 0){
80104894:	8d 45 ec             	lea    -0x14(%ebp),%eax
extern int countTrap;
extern int unkownTrap;
extern int trapValCounters[256];


int sys_callBWrite(void){
80104897:	83 ec 1c             	sub    $0x1c,%esp
  int devices;
  int blockno;
  char* dataBuffer;

  if(argint(0, &devices) < 0){
8010489a:	50                   	push   %eax
8010489b:	6a 00                	push   $0x0
8010489d:	e8 3e ff ff ff       	call   801047e0 <argint>
801048a2:	83 c4 10             	add    $0x10,%esp
801048a5:	85 c0                	test   %eax,%eax
801048a7:	78 77                	js     80104920 <sys_callBWrite+0x90>
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argint(1, &blockno) < 0){
801048a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801048ac:	83 ec 08             	sub    $0x8,%esp
801048af:	50                   	push   %eax
801048b0:	6a 01                	push   $0x1
801048b2:	e8 29 ff ff ff       	call   801047e0 <argint>
801048b7:	83 c4 10             	add    $0x10,%esp
801048ba:	85 c0                	test   %eax,%eax
801048bc:	78 62                	js     80104920 <sys_callBWrite+0x90>
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(2, &dataBuffer, BSIZE) < 0){
801048be:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048c1:	83 ec 04             	sub    $0x4,%esp
801048c4:	68 00 02 00 00       	push   $0x200
801048c9:	50                   	push   %eax
801048ca:	6a 02                	push   $0x2
801048cc:	e8 5f ff ff ff       	call   80104830 <argptr>
801048d1:	83 c4 10             	add    $0x10,%esp
801048d4:	85 c0                	test   %eax,%eax
801048d6:	78 48                	js     80104920 <sys_callBWrite+0x90>
        //cprintf("after 1st argint\n");
        return -1;
  }

  struct buf* p = bread(devices, blockno);
801048d8:	83 ec 08             	sub    $0x8,%esp
801048db:	ff 75 f0             	pushl  -0x10(%ebp)
801048de:	ff 75 ec             	pushl  -0x14(%ebp)
801048e1:	e8 ea b7 ff ff       	call   801000d0 <bread>
801048e6:	89 c3                	mov    %eax,%ebx
  memmove(p->data, dataBuffer, BSIZE);
801048e8:	8d 40 5c             	lea    0x5c(%eax),%eax
801048eb:	83 c4 0c             	add    $0xc,%esp
801048ee:	68 00 02 00 00       	push   $0x200
801048f3:	ff 75 f4             	pushl  -0xc(%ebp)
801048f6:	50                   	push   %eax
801048f7:	e8 34 fc ff ff       	call   80104530 <memmove>
  bwrite(p);
801048fc:	89 1c 24             	mov    %ebx,(%esp)
801048ff:	e8 9c b8 ff ff       	call   801001a0 <bwrite>

  brelse(p);
80104904:	89 1c 24             	mov    %ebx,(%esp)
80104907:	e8 d4 b8 ff ff       	call   801001e0 <brelse>

  return 0;
8010490c:	83 c4 10             	add    $0x10,%esp
8010490f:	31 c0                	xor    %eax,%eax
}
80104911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104914:	c9                   	leave  
80104915:	c3                   	ret    
80104916:	8d 76 00             	lea    0x0(%esi),%esi
80104919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int blockno;
  char* dataBuffer;

  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  bwrite(p);

  brelse(p);

  return 0;
}
80104925:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104928:	c9                   	leave  
80104929:	c3                   	ret    
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104930 <sys_callBRead>:

int sys_callBRead(void){
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
  int devices;
  int blockno;
  char* dataBuffer;
  
  
  if(argint(0, &devices) < 0){
80104934:	8d 45 ec             	lea    -0x14(%ebp),%eax
  brelse(p);

  return 0;
}

int sys_callBRead(void){
80104937:	83 ec 1c             	sub    $0x1c,%esp
  int devices;
  int blockno;
  char* dataBuffer;
  
  
  if(argint(0, &devices) < 0){
8010493a:	50                   	push   %eax
8010493b:	6a 00                	push   $0x0
8010493d:	e8 9e fe ff ff       	call   801047e0 <argint>
80104942:	83 c4 10             	add    $0x10,%esp
80104945:	85 c0                	test   %eax,%eax
80104947:	78 67                	js     801049b0 <sys_callBRead+0x80>
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argint(1, &blockno) < 0){
80104949:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010494c:	83 ec 08             	sub    $0x8,%esp
8010494f:	50                   	push   %eax
80104950:	6a 01                	push   $0x1
80104952:	e8 89 fe ff ff       	call   801047e0 <argint>
80104957:	83 c4 10             	add    $0x10,%esp
8010495a:	85 c0                	test   %eax,%eax
8010495c:	78 52                	js     801049b0 <sys_callBRead+0x80>
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(2, &dataBuffer, BSIZE) < 0){
8010495e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104961:	83 ec 04             	sub    $0x4,%esp
80104964:	68 00 02 00 00       	push   $0x200
80104969:	50                   	push   %eax
8010496a:	6a 02                	push   $0x2
8010496c:	e8 bf fe ff ff       	call   80104830 <argptr>
80104971:	83 c4 10             	add    $0x10,%esp
80104974:	85 c0                	test   %eax,%eax
80104976:	78 38                	js     801049b0 <sys_callBRead+0x80>
        return -1;
  }

  

  struct buf* p = bread(devices, blockno);
80104978:	83 ec 08             	sub    $0x8,%esp
8010497b:	ff 75 f0             	pushl  -0x10(%ebp)
8010497e:	ff 75 ec             	pushl  -0x14(%ebp)
80104981:	e8 4a b7 ff ff       	call   801000d0 <bread>
80104986:	89 c3                	mov    %eax,%ebx
  memmove(dataBuffer, p->data, BSIZE);
80104988:	8d 40 5c             	lea    0x5c(%eax),%eax
8010498b:	83 c4 0c             	add    $0xc,%esp
8010498e:	68 00 02 00 00       	push   $0x200
80104993:	50                   	push   %eax
80104994:	ff 75 f4             	pushl  -0xc(%ebp)
80104997:	e8 94 fb ff ff       	call   80104530 <memmove>
  brelse(p);
8010499c:	89 1c 24             	mov    %ebx,(%esp)
8010499f:	e8 3c b8 ff ff       	call   801001e0 <brelse>

  return 0;
801049a4:	83 c4 10             	add    $0x10,%esp
801049a7:	31 c0                	xor    %eax,%eax
  
}
801049a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049ac:	c9                   	leave  
801049ad:	c3                   	ret    
801049ae:	66 90                	xchg   %ax,%ax
  char* dataBuffer;
  
  
  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
801049b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  memmove(dataBuffer, p->data, BSIZE);
  brelse(p);

  return 0;
  
}
801049b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049b8:	c9                   	leave  
801049b9:	c3                   	ret    
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <sys_callSBRead>:

int sys_callSBRead(void){
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	83 ec 20             	sub    $0x20,%esp
  int devices;
  struct superblock* sb;

  if(argint(0, &devices) < 0){
801049c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801049c9:	50                   	push   %eax
801049ca:	6a 00                	push   $0x0
801049cc:	e8 0f fe ff ff       	call   801047e0 <argint>
801049d1:	83 c4 10             	add    $0x10,%esp
801049d4:	85 c0                	test   %eax,%eax
801049d6:	78 30                	js     80104a08 <sys_callSBRead+0x48>
        //cprintf("after 1st argint\n");
        return -1;
  }

  if(argptr(1, (void*)&sb, sizeof(*sb)) < 0)
801049d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049db:	83 ec 04             	sub    $0x4,%esp
801049de:	6a 1c                	push   $0x1c
801049e0:	50                   	push   %eax
801049e1:	6a 01                	push   $0x1
801049e3:	e8 48 fe ff ff       	call   80104830 <argptr>
801049e8:	83 c4 10             	add    $0x10,%esp
801049eb:	85 c0                	test   %eax,%eax
801049ed:	78 19                	js     80104a08 <sys_callSBRead+0x48>
    return -1;

  readsb(devices, sb);
801049ef:	83 ec 08             	sub    $0x8,%esp
801049f2:	ff 75 f4             	pushl  -0xc(%ebp)
801049f5:	ff 75 f0             	pushl  -0x10(%ebp)
801049f8:	e8 83 ca ff ff       	call   80101480 <readsb>

  return 0;
801049fd:	83 c4 10             	add    $0x10,%esp
80104a00:	31 c0                	xor    %eax,%eax
}
80104a02:	c9                   	leave  
80104a03:	c3                   	ret    
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int devices;
  struct superblock* sb;

  if(argint(0, &devices) < 0){
        //cprintf("after 1st argint\n");
        return -1;
80104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;

  readsb(devices, sb);

  return 0;
}
80104a0d:	c9                   	leave  
80104a0e:	c3                   	ret    
80104a0f:	90                   	nop

80104a10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a19:	50                   	push   %eax
80104a1a:	ff 75 08             	pushl  0x8(%ebp)
80104a1d:	e8 be fd ff ff       	call   801047e0 <argint>
80104a22:	83 c4 10             	add    $0x10,%esp
80104a25:	85 c0                	test   %eax,%eax
80104a27:	78 17                	js     80104a40 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a29:	83 ec 08             	sub    $0x8,%esp
80104a2c:	ff 75 0c             	pushl  0xc(%ebp)
80104a2f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a32:	e8 49 fd ff ff       	call   80104780 <fetchstr>
80104a37:	83 c4 10             	add    $0x10,%esp
}
80104a3a:	c9                   	leave  
80104a3b:	c3                   	ret    
80104a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a45:	c9                   	leave  
80104a46:	c3                   	ret    
80104a47:	89 f6                	mov    %esi,%esi
80104a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a50 <syscall>:
  return 0;
}

void
syscall(void)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	53                   	push   %ebx
80104a56:	83 ec 0c             	sub    $0xc,%esp
  int num;
  struct proc *curproc = myproc();
80104a59:	e8 72 ed ff ff       	call   801037d0 <myproc>

  num = curproc->tf->eax;
80104a5e:	8b 78 18             	mov    0x18(%eax),%edi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104a61:	89 c6                	mov    %eax,%esi

  num = curproc->tf->eax;
80104a63:	8b 5f 1c             	mov    0x1c(%edi),%ebx
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a66:	8d 43 ff             	lea    -0x1(%ebx),%eax
80104a69:	83 f8 1b             	cmp    $0x1b,%eax
80104a6c:	77 2a                	ja     80104a98 <syscall+0x48>
80104a6e:	8b 04 9d 40 80 10 80 	mov    -0x7fef7fc0(,%ebx,4),%eax
80104a75:	85 c0                	test   %eax,%eax
80104a77:	74 1f                	je     80104a98 <syscall+0x48>
    curproc->tf->eax = syscalls[num]();
80104a79:	ff d0                	call   *%eax
    syscallsValCounters[num]++;
    countSys++;
80104a7b:	83 05 74 b6 10 80 01 	addl   $0x1,0x8010b674
  int num;
  struct proc *curproc = myproc();

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
80104a82:	89 47 1c             	mov    %eax,0x1c(%edi)
    syscallsValCounters[num]++;
80104a85:	83 04 9d 00 b6 10 80 	addl   $0x1,-0x7fef4a00(,%ebx,4)
80104a8c:	01 
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a90:	5b                   	pop    %ebx
80104a91:	5e                   	pop    %esi
80104a92:	5f                   	pop    %edi
80104a93:	5d                   	pop    %ebp
80104a94:	c3                   	ret    
80104a95:	8d 76 00             	lea    0x0(%esi),%esi
    curproc->tf->eax = syscalls[num]();
    syscallsValCounters[num]++;
    countSys++;
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
80104a98:	8d 46 6c             	lea    0x6c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
    syscallsValCounters[num]++;
    countSys++;
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a9b:	53                   	push   %ebx
80104a9c:	50                   	push   %eax
80104a9d:	ff 76 10             	pushl  0x10(%esi)
80104aa0:	68 15 80 10 80       	push   $0x80108015
80104aa5:	e8 b6 bb ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104aaa:	8b 46 18             	mov    0x18(%esi),%eax
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104ab7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aba:	5b                   	pop    %ebx
80104abb:	5e                   	pop    %esi
80104abc:	5f                   	pop    %edi
80104abd:	5d                   	pop    %ebp
80104abe:	c3                   	ret    
80104abf:	90                   	nop

80104ac0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ac6:	8d 75 ca             	lea    -0x36(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ac9:	83 ec 44             	sub    $0x44,%esp
80104acc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104acf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ad2:	56                   	push   %esi
80104ad3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ad4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ad7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ada:	e8 51 d4 ff ff       	call   80101f30 <nameiparent>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	0f 84 f6 00 00 00    	je     80104be0 <create+0x120>
    return 0;
  ilock(dp);
80104aea:	83 ec 0c             	sub    $0xc,%esp
80104aed:	89 c7                	mov    %eax,%edi
80104aef:	50                   	push   %eax
80104af0:	e8 cb cb ff ff       	call   801016c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104af5:	83 c4 0c             	add    $0xc,%esp
80104af8:	6a 00                	push   $0x0
80104afa:	56                   	push   %esi
80104afb:	57                   	push   %edi
80104afc:	e8 ef d0 ff ff       	call   80101bf0 <dirlookup>
80104b01:	83 c4 10             	add    $0x10,%esp
80104b04:	85 c0                	test   %eax,%eax
80104b06:	89 c3                	mov    %eax,%ebx
80104b08:	74 56                	je     80104b60 <create+0xa0>
    iunlockput(dp);
80104b0a:	83 ec 0c             	sub    $0xc,%esp
80104b0d:	57                   	push   %edi
80104b0e:	e8 3d ce ff ff       	call   80101950 <iunlockput>
    ilock(ip);
80104b13:	89 1c 24             	mov    %ebx,(%esp)
80104b16:	e8 a5 cb ff ff       	call   801016c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b1b:	83 c4 10             	add    $0x10,%esp
80104b1e:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b23:	75 1b                	jne    80104b40 <create+0x80>
80104b25:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104b2a:	89 d8                	mov    %ebx,%eax
80104b2c:	75 12                	jne    80104b40 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b31:	5b                   	pop    %ebx
80104b32:	5e                   	pop    %esi
80104b33:	5f                   	pop    %edi
80104b34:	5d                   	pop    %ebp
80104b35:	c3                   	ret    
80104b36:	8d 76 00             	lea    0x0(%esi),%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b40:	83 ec 0c             	sub    $0xc,%esp
80104b43:	53                   	push   %ebx
80104b44:	e8 07 ce ff ff       	call   80101950 <iunlockput>
    return 0;
80104b49:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104b4f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b51:	5b                   	pop    %ebx
80104b52:	5e                   	pop    %esi
80104b53:	5f                   	pop    %edi
80104b54:	5d                   	pop    %ebp
80104b55:	c3                   	ret    
80104b56:	8d 76 00             	lea    0x0(%esi),%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104b60:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b64:	83 ec 08             	sub    $0x8,%esp
80104b67:	50                   	push   %eax
80104b68:	ff 37                	pushl  (%edi)
80104b6a:	e8 e1 c9 ff ff       	call   80101550 <ialloc>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	89 c3                	mov    %eax,%ebx
80104b76:	0f 84 cc 00 00 00    	je     80104c48 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104b7c:	83 ec 0c             	sub    $0xc,%esp
80104b7f:	50                   	push   %eax
80104b80:	e8 3b cb ff ff       	call   801016c0 <ilock>
  ip->major = major;
80104b85:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b89:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104b8d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b91:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104b95:	b8 01 00 00 00       	mov    $0x1,%eax
80104b9a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104b9e:	89 1c 24             	mov    %ebx,(%esp)
80104ba1:	e8 6a ca ff ff       	call   80101610 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104ba6:	83 c4 10             	add    $0x10,%esp
80104ba9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104bae:	74 40                	je     80104bf0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104bb0:	83 ec 04             	sub    $0x4,%esp
80104bb3:	ff 73 04             	pushl  0x4(%ebx)
80104bb6:	56                   	push   %esi
80104bb7:	57                   	push   %edi
80104bb8:	e8 93 d2 ff ff       	call   80101e50 <dirlink>
80104bbd:	83 c4 10             	add    $0x10,%esp
80104bc0:	85 c0                	test   %eax,%eax
80104bc2:	78 77                	js     80104c3b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104bc4:	83 ec 0c             	sub    $0xc,%esp
80104bc7:	57                   	push   %edi
80104bc8:	e8 83 cd ff ff       	call   80101950 <iunlockput>

  return ip;
80104bcd:	83 c4 10             	add    $0x10,%esp
}
80104bd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104bd3:	89 d8                	mov    %ebx,%eax
}
80104bd5:	5b                   	pop    %ebx
80104bd6:	5e                   	pop    %esi
80104bd7:	5f                   	pop    %edi
80104bd8:	5d                   	pop    %ebp
80104bd9:	c3                   	ret    
80104bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104be0:	31 c0                	xor    %eax,%eax
80104be2:	e9 47 ff ff ff       	jmp    80104b2e <create+0x6e>
80104be7:	89 f6                	mov    %esi,%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104bf0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104bf5:	83 ec 0c             	sub    $0xc,%esp
80104bf8:	57                   	push   %edi
80104bf9:	e8 12 ca ff ff       	call   80101610 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bfe:	83 c4 0c             	add    $0xc,%esp
80104c01:	ff 73 04             	pushl  0x4(%ebx)
80104c04:	68 d0 80 10 80       	push   $0x801080d0
80104c09:	53                   	push   %ebx
80104c0a:	e8 41 d2 ff ff       	call   80101e50 <dirlink>
80104c0f:	83 c4 10             	add    $0x10,%esp
80104c12:	85 c0                	test   %eax,%eax
80104c14:	78 18                	js     80104c2e <create+0x16e>
80104c16:	83 ec 04             	sub    $0x4,%esp
80104c19:	ff 77 04             	pushl  0x4(%edi)
80104c1c:	68 cf 80 10 80       	push   $0x801080cf
80104c21:	53                   	push   %ebx
80104c22:	e8 29 d2 ff ff       	call   80101e50 <dirlink>
80104c27:	83 c4 10             	add    $0x10,%esp
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	79 82                	jns    80104bb0 <create+0xf0>
      panic("create dots");
80104c2e:	83 ec 0c             	sub    $0xc,%esp
80104c31:	68 c3 80 10 80       	push   $0x801080c3
80104c36:	e8 35 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104c3b:	83 ec 0c             	sub    $0xc,%esp
80104c3e:	68 d2 80 10 80       	push   $0x801080d2
80104c43:	e8 28 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104c48:	83 ec 0c             	sub    $0xc,%esp
80104c4b:	68 b4 80 10 80       	push   $0x801080b4
80104c50:	e8 1b b7 ff ff       	call   80100370 <panic>
80104c55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c60 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
80104c65:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c67:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c6a:	89 d3                	mov    %edx,%ebx
80104c6c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c6f:	50                   	push   %eax
80104c70:	6a 00                	push   $0x0
80104c72:	e8 69 fb ff ff       	call   801047e0 <argint>
80104c77:	83 c4 10             	add    $0x10,%esp
80104c7a:	85 c0                	test   %eax,%eax
80104c7c:	78 32                	js     80104cb0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c7e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c82:	77 2c                	ja     80104cb0 <argfd.constprop.0+0x50>
80104c84:	e8 47 eb ff ff       	call   801037d0 <myproc>
80104c89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c8c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c90:	85 c0                	test   %eax,%eax
80104c92:	74 1c                	je     80104cb0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104c94:	85 f6                	test   %esi,%esi
80104c96:	74 02                	je     80104c9a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c98:	89 16                	mov    %edx,(%esi)
  if(pf)
80104c9a:	85 db                	test   %ebx,%ebx
80104c9c:	74 22                	je     80104cc0 <argfd.constprop.0+0x60>
    *pf = f;
80104c9e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104ca0:	31 c0                	xor    %eax,%eax
}
80104ca2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca5:	5b                   	pop    %ebx
80104ca6:	5e                   	pop    %esi
80104ca7:	5d                   	pop    %ebp
80104ca8:	c3                   	ret    
80104ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104cb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104cb8:	5b                   	pop    %ebx
80104cb9:	5e                   	pop    %esi
80104cba:	5d                   	pop    %ebp
80104cbb:	c3                   	ret    
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104cc0:	31 c0                	xor    %eax,%eax
80104cc2:	eb de                	jmp    80104ca2 <argfd.constprop.0+0x42>
80104cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cd0 <sys_seek>:
}

int sys_seek(void){
80104cd0:	55                   	push   %ebp
  int position;
  struct file *fileptr;

  if(argfd(0, 0, &fileptr) < 0){
80104cd1:	31 c0                	xor    %eax,%eax
  if(pf)
    *pf = f;
  return 0;
}

int sys_seek(void){
80104cd3:	89 e5                	mov    %esp,%ebp
80104cd5:	83 ec 18             	sub    $0x18,%esp
  int position;
  struct file *fileptr;

  if(argfd(0, 0, &fileptr) < 0){
80104cd8:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104cdb:	e8 80 ff ff ff       	call   80104c60 <argfd.constprop.0>
80104ce0:	85 c0                	test   %eax,%eax
80104ce2:	78 3c                	js     80104d20 <sys_seek+0x50>
    return -1;
  }

  if(argint(1, &position) < 0){
80104ce4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ce7:	83 ec 08             	sub    $0x8,%esp
80104cea:	50                   	push   %eax
80104ceb:	6a 01                	push   $0x1
80104ced:	e8 ee fa ff ff       	call   801047e0 <argint>
80104cf2:	83 c4 10             	add    $0x10,%esp
80104cf5:	85 c0                	test   %eax,%eax
80104cf7:	78 27                	js     80104d20 <sys_seek+0x50>
    return -1;
  }

  fileptr->off = position;
80104cf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cfc:	8b 55 f4             	mov    -0xc(%ebp),%edx

  cprintf("SEEK POSITION-- %d\n", fileptr->off);
80104cff:	83 ec 08             	sub    $0x8,%esp

  if(argint(1, &position) < 0){
    return -1;
  }

  fileptr->off = position;
80104d02:	89 42 14             	mov    %eax,0x14(%edx)

  cprintf("SEEK POSITION-- %d\n", fileptr->off);
80104d05:	50                   	push   %eax
80104d06:	68 e2 80 10 80       	push   $0x801080e2
80104d0b:	e8 50 b9 ff ff       	call   80100660 <cprintf>

  return 0;
80104d10:	83 c4 10             	add    $0x10,%esp
80104d13:	31 c0                	xor    %eax,%eax
}
80104d15:	c9                   	leave  
80104d16:	c3                   	ret    
80104d17:	89 f6                	mov    %esi,%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
int sys_seek(void){
  int position;
  struct file *fileptr;

  if(argfd(0, 0, &fileptr) < 0){
    return -1;
80104d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  fileptr->off = position;

  cprintf("SEEK POSITION-- %d\n", fileptr->off);

  return 0;
}
80104d25:	c9                   	leave  
80104d26:	c3                   	ret    
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104d30:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d31:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	56                   	push   %esi
80104d36:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d37:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104d3a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d3d:	e8 1e ff ff ff       	call   80104c60 <argfd.constprop.0>
80104d42:	85 c0                	test   %eax,%eax
80104d44:	78 1a                	js     80104d60 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d46:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104d48:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104d4b:	e8 80 ea ff ff       	call   801037d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104d50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d54:	85 d2                	test   %edx,%edx
80104d56:	74 18                	je     80104d70 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d58:	83 c3 01             	add    $0x1,%ebx
80104d5b:	83 fb 10             	cmp    $0x10,%ebx
80104d5e:	75 f0                	jne    80104d50 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d60:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104d63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d68:	5b                   	pop    %ebx
80104d69:	5e                   	pop    %esi
80104d6a:	5d                   	pop    %ebp
80104d6b:	c3                   	ret    
80104d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104d70:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104d74:	83 ec 0c             	sub    $0xc,%esp
80104d77:	ff 75 f4             	pushl  -0xc(%ebp)
80104d7a:	e8 c1 c0 ff ff       	call   80100e40 <filedup>
  return fd;
80104d7f:	83 c4 10             	add    $0x10,%esp
}
80104d82:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104d85:	89 d8                	mov    %ebx,%eax
}
80104d87:	5b                   	pop    %ebx
80104d88:	5e                   	pop    %esi
80104d89:	5d                   	pop    %ebp
80104d8a:	c3                   	ret    
80104d8b:	90                   	nop
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d90 <sys_read>:

int
sys_read(void)
{
80104d90:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 c0 fe ff ff       	call   80104c60 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_read+0x60>
80104da4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da7:	83 ec 08             	sub    $0x8,%esp
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 2e fa ff ff       	call   801047e0 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_read+0x60>
80104db9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbc:	83 ec 04             	sub    $0x4,%esp
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 66 fa ff ff       	call   80104830 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 ce c1 ff ff       	call   80100fb0 <fileread>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_write>:

int
sys_write(void)
{
80104e00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e01:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104e03:	89 e5                	mov    %esp,%ebp
80104e05:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e0b:	e8 50 fe ff ff       	call   80104c60 <argfd.constprop.0>
80104e10:	85 c0                	test   %eax,%eax
80104e12:	78 4c                	js     80104e60 <sys_write+0x60>
80104e14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e17:	83 ec 08             	sub    $0x8,%esp
80104e1a:	50                   	push   %eax
80104e1b:	6a 02                	push   $0x2
80104e1d:	e8 be f9 ff ff       	call   801047e0 <argint>
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	85 c0                	test   %eax,%eax
80104e27:	78 37                	js     80104e60 <sys_write+0x60>
80104e29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e2c:	83 ec 04             	sub    $0x4,%esp
80104e2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e32:	50                   	push   %eax
80104e33:	6a 01                	push   $0x1
80104e35:	e8 f6 f9 ff ff       	call   80104830 <argptr>
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 c0                	test   %eax,%eax
80104e3f:	78 1f                	js     80104e60 <sys_write+0x60>
    return -1;

  //cprintf( "SYSWRITE AFTER POSITION %d\n", f->off);
  int a = filewrite(f, p, n);
80104e41:	83 ec 04             	sub    $0x4,%esp
80104e44:	ff 75 f0             	pushl  -0x10(%ebp)
80104e47:	ff 75 f4             	pushl  -0xc(%ebp)
80104e4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e4d:	e8 ee c1 ff ff       	call   80101040 <filewrite>
  //cprintf("AFTER FILEWRITE POSITION %d\n\n", f->off);

  return a;
80104e52:	83 c4 10             	add    $0x10,%esp
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  //cprintf( "SYSWRITE AFTER POSITION %d\n", f->off);
  int a = filewrite(f, p, n);
  //cprintf("AFTER FILEWRITE POSITION %d\n\n", f->off);

  return a;
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_close>:

int
sys_close(void)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104e76:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e79:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e7c:	e8 df fd ff ff       	call   80104c60 <argfd.constprop.0>
80104e81:	85 c0                	test   %eax,%eax
80104e83:	78 2b                	js     80104eb0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104e85:	e8 46 e9 ff ff       	call   801037d0 <myproc>
80104e8a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e8d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104e90:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e97:	00 
  fileclose(f);
80104e98:	ff 75 f4             	pushl  -0xc(%ebp)
80104e9b:	e8 f0 bf ff ff       	call   80100e90 <fileclose>
  return 0;
80104ea0:	83 c4 10             	add    $0x10,%esp
80104ea3:	31 c0                	xor    %eax,%eax
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104eb5:	c9                   	leave  
80104eb6:	c3                   	ret    
80104eb7:	89 f6                	mov    %esi,%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <sys_fstat>:

int
sys_fstat(void)
{
80104ec0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ecb:	e8 90 fd ff ff       	call   80104c60 <argfd.constprop.0>
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 2c                	js     80104f00 <sys_fstat+0x40>
80104ed4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ed7:	83 ec 04             	sub    $0x4,%esp
80104eda:	6a 14                	push   $0x14
80104edc:	50                   	push   %eax
80104edd:	6a 01                	push   $0x1
80104edf:	e8 4c f9 ff ff       	call   80104830 <argptr>
80104ee4:	83 c4 10             	add    $0x10,%esp
80104ee7:	85 c0                	test   %eax,%eax
80104ee9:	78 15                	js     80104f00 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104eeb:	83 ec 08             	sub    $0x8,%esp
80104eee:	ff 75 f4             	pushl  -0xc(%ebp)
80104ef1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef4:	e8 67 c0 ff ff       	call   80100f60 <filestat>
80104ef9:	83 c4 10             	add    $0x10,%esp
}
80104efc:	c9                   	leave  
80104efd:	c3                   	ret    
80104efe:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f10 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	57                   	push   %edi
80104f14:	56                   	push   %esi
80104f15:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f16:	8d 45 c4             	lea    -0x3c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f19:	83 ec 44             	sub    $0x44,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f1c:	50                   	push   %eax
80104f1d:	6a 00                	push   $0x0
80104f1f:	e8 ec fa ff ff       	call   80104a10 <argstr>
80104f24:	83 c4 10             	add    $0x10,%esp
80104f27:	85 c0                	test   %eax,%eax
80104f29:	0f 88 fb 00 00 00    	js     8010502a <sys_link+0x11a>
80104f2f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f32:	83 ec 08             	sub    $0x8,%esp
80104f35:	50                   	push   %eax
80104f36:	6a 01                	push   $0x1
80104f38:	e8 d3 fa ff ff       	call   80104a10 <argstr>
80104f3d:	83 c4 10             	add    $0x10,%esp
80104f40:	85 c0                	test   %eax,%eax
80104f42:	0f 88 e2 00 00 00    	js     8010502a <sys_link+0x11a>
    return -1;

  begin_op();
80104f48:	e8 53 dc ff ff       	call   80102ba0 <begin_op>
  if((ip = namei(old)) == 0){
80104f4d:	83 ec 0c             	sub    $0xc,%esp
80104f50:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f53:	e8 b8 cf ff ff       	call   80101f10 <namei>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	89 c3                	mov    %eax,%ebx
80104f5f:	0f 84 f3 00 00 00    	je     80105058 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104f65:	83 ec 0c             	sub    $0xc,%esp
80104f68:	50                   	push   %eax
80104f69:	e8 52 c7 ff ff       	call   801016c0 <ilock>
  if(ip->type == T_DIR){
80104f6e:	83 c4 10             	add    $0x10,%esp
80104f71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f76:	0f 84 c4 00 00 00    	je     80105040 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104f7c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f81:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104f84:	8d 7d ca             	lea    -0x36(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104f87:	53                   	push   %ebx
80104f88:	e8 83 c6 ff ff       	call   80101610 <iupdate>
  iunlock(ip);
80104f8d:	89 1c 24             	mov    %ebx,(%esp)
80104f90:	e8 0b c8 ff ff       	call   801017a0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104f95:	58                   	pop    %eax
80104f96:	5a                   	pop    %edx
80104f97:	57                   	push   %edi
80104f98:	ff 75 c0             	pushl  -0x40(%ebp)
80104f9b:	e8 90 cf ff ff       	call   80101f30 <nameiparent>
80104fa0:	83 c4 10             	add    $0x10,%esp
80104fa3:	85 c0                	test   %eax,%eax
80104fa5:	89 c6                	mov    %eax,%esi
80104fa7:	74 5b                	je     80105004 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104fa9:	83 ec 0c             	sub    $0xc,%esp
80104fac:	50                   	push   %eax
80104fad:	e8 0e c7 ff ff       	call   801016c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fb2:	83 c4 10             	add    $0x10,%esp
80104fb5:	8b 03                	mov    (%ebx),%eax
80104fb7:	39 06                	cmp    %eax,(%esi)
80104fb9:	75 3d                	jne    80104ff8 <sys_link+0xe8>
80104fbb:	83 ec 04             	sub    $0x4,%esp
80104fbe:	ff 73 04             	pushl  0x4(%ebx)
80104fc1:	57                   	push   %edi
80104fc2:	56                   	push   %esi
80104fc3:	e8 88 ce ff ff       	call   80101e50 <dirlink>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	85 c0                	test   %eax,%eax
80104fcd:	78 29                	js     80104ff8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104fcf:	83 ec 0c             	sub    $0xc,%esp
80104fd2:	56                   	push   %esi
80104fd3:	e8 78 c9 ff ff       	call   80101950 <iunlockput>
  iput(ip);
80104fd8:	89 1c 24             	mov    %ebx,(%esp)
80104fdb:	e8 10 c8 ff ff       	call   801017f0 <iput>

  end_op();
80104fe0:	e8 2b dc ff ff       	call   80102c10 <end_op>

  return 0;
80104fe5:	83 c4 10             	add    $0x10,%esp
80104fe8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fed:	5b                   	pop    %ebx
80104fee:	5e                   	pop    %esi
80104fef:	5f                   	pop    %edi
80104ff0:	5d                   	pop    %ebp
80104ff1:	c3                   	ret    
80104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	56                   	push   %esi
80104ffc:	e8 4f c9 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105001:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105004:	83 ec 0c             	sub    $0xc,%esp
80105007:	53                   	push   %ebx
80105008:	e8 b3 c6 ff ff       	call   801016c0 <ilock>
  ip->nlink--;
8010500d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105012:	89 1c 24             	mov    %ebx,(%esp)
80105015:	e8 f6 c5 ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
8010501a:	89 1c 24             	mov    %ebx,(%esp)
8010501d:	e8 2e c9 ff ff       	call   80101950 <iunlockput>
  end_op();
80105022:	e8 e9 db ff ff       	call   80102c10 <end_op>
  return -1;
80105027:	83 c4 10             	add    $0x10,%esp
}
8010502a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010502d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105032:	5b                   	pop    %ebx
80105033:	5e                   	pop    %esi
80105034:	5f                   	pop    %edi
80105035:	5d                   	pop    %ebp
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105040:	83 ec 0c             	sub    $0xc,%esp
80105043:	53                   	push   %ebx
80105044:	e8 07 c9 ff ff       	call   80101950 <iunlockput>
    end_op();
80105049:	e8 c2 db ff ff       	call   80102c10 <end_op>
    return -1;
8010504e:	83 c4 10             	add    $0x10,%esp
80105051:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105056:	eb 92                	jmp    80104fea <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105058:	e8 b3 db ff ff       	call   80102c10 <end_op>
    return -1;
8010505d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105062:	eb 86                	jmp    80104fea <sys_link+0xda>
80105064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010506a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105070 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	57                   	push   %edi
80105074:	56                   	push   %esi
80105075:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105076:	8d 45 a0             	lea    -0x60(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105079:	83 ec 74             	sub    $0x74,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010507c:	50                   	push   %eax
8010507d:	6a 00                	push   $0x0
8010507f:	e8 8c f9 ff ff       	call   80104a10 <argstr>
80105084:	83 c4 10             	add    $0x10,%esp
80105087:	85 c0                	test   %eax,%eax
80105089:	0f 88 82 01 00 00    	js     80105211 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010508f:	8d 5d aa             	lea    -0x56(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105092:	e8 09 db ff ff       	call   80102ba0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105097:	83 ec 08             	sub    $0x8,%esp
8010509a:	53                   	push   %ebx
8010509b:	ff 75 a0             	pushl  -0x60(%ebp)
8010509e:	e8 8d ce ff ff       	call   80101f30 <nameiparent>
801050a3:	83 c4 10             	add    $0x10,%esp
801050a6:	85 c0                	test   %eax,%eax
801050a8:	89 45 94             	mov    %eax,-0x6c(%ebp)
801050ab:	0f 84 6a 01 00 00    	je     8010521b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
801050b1:	8b 75 94             	mov    -0x6c(%ebp),%esi
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	56                   	push   %esi
801050b8:	e8 03 c6 ff ff       	call   801016c0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050bd:	58                   	pop    %eax
801050be:	5a                   	pop    %edx
801050bf:	68 d0 80 10 80       	push   $0x801080d0
801050c4:	53                   	push   %ebx
801050c5:	e8 06 cb ff ff       	call   80101bd0 <namecmp>
801050ca:	83 c4 10             	add    $0x10,%esp
801050cd:	85 c0                	test   %eax,%eax
801050cf:	0f 84 fc 00 00 00    	je     801051d1 <sys_unlink+0x161>
801050d5:	83 ec 08             	sub    $0x8,%esp
801050d8:	68 cf 80 10 80       	push   $0x801080cf
801050dd:	53                   	push   %ebx
801050de:	e8 ed ca ff ff       	call   80101bd0 <namecmp>
801050e3:	83 c4 10             	add    $0x10,%esp
801050e6:	85 c0                	test   %eax,%eax
801050e8:	0f 84 e3 00 00 00    	je     801051d1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801050ee:	8d 45 a4             	lea    -0x5c(%ebp),%eax
801050f1:	83 ec 04             	sub    $0x4,%esp
801050f4:	50                   	push   %eax
801050f5:	53                   	push   %ebx
801050f6:	56                   	push   %esi
801050f7:	e8 f4 ca ff ff       	call   80101bf0 <dirlookup>
801050fc:	83 c4 10             	add    $0x10,%esp
801050ff:	85 c0                	test   %eax,%eax
80105101:	89 c3                	mov    %eax,%ebx
80105103:	0f 84 c8 00 00 00    	je     801051d1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105109:	83 ec 0c             	sub    $0xc,%esp
8010510c:	50                   	push   %eax
8010510d:	e8 ae c5 ff ff       	call   801016c0 <ilock>

  if(ip->nlink < 1)
80105112:	83 c4 10             	add    $0x10,%esp
80105115:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010511a:	0f 8e 24 01 00 00    	jle    80105244 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105120:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105125:	8d 75 c8             	lea    -0x38(%ebp),%esi
80105128:	74 66                	je     80105190 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010512a:	83 ec 04             	sub    $0x4,%esp
8010512d:	6a 20                	push   $0x20
8010512f:	6a 00                	push   $0x0
80105131:	56                   	push   %esi
80105132:	e8 49 f3 ff ff       	call   80104480 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105137:	6a 20                	push   $0x20
80105139:	ff 75 a4             	pushl  -0x5c(%ebp)
8010513c:	56                   	push   %esi
8010513d:	ff 75 94             	pushl  -0x6c(%ebp)
80105140:	e8 5b c9 ff ff       	call   80101aa0 <writei>
80105145:	83 c4 20             	add    $0x20,%esp
80105148:	83 f8 20             	cmp    $0x20,%eax
8010514b:	0f 85 e6 00 00 00    	jne    80105237 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105151:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105156:	0f 84 9c 00 00 00    	je     801051f8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010515c:	83 ec 0c             	sub    $0xc,%esp
8010515f:	ff 75 94             	pushl  -0x6c(%ebp)
80105162:	e8 e9 c7 ff ff       	call   80101950 <iunlockput>

  ip->nlink--;
80105167:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010516c:	89 1c 24             	mov    %ebx,(%esp)
8010516f:	e8 9c c4 ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
80105174:	89 1c 24             	mov    %ebx,(%esp)
80105177:	e8 d4 c7 ff ff       	call   80101950 <iunlockput>

  end_op();
8010517c:	e8 8f da ff ff       	call   80102c10 <end_op>

  return 0;
80105181:	83 c4 10             	add    $0x10,%esp
80105184:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105189:	5b                   	pop    %ebx
8010518a:	5e                   	pop    %esi
8010518b:	5f                   	pop    %edi
8010518c:	5d                   	pop    %ebp
8010518d:	c3                   	ret    
8010518e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105190:	83 7b 58 40          	cmpl   $0x40,0x58(%ebx)
80105194:	76 94                	jbe    8010512a <sys_unlink+0xba>
80105196:	bf 40 00 00 00       	mov    $0x40,%edi
8010519b:	eb 0f                	jmp    801051ac <sys_unlink+0x13c>
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
801051a0:	83 c7 20             	add    $0x20,%edi
801051a3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051a6:	0f 83 7e ff ff ff    	jae    8010512a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051ac:	6a 20                	push   $0x20
801051ae:	57                   	push   %edi
801051af:	56                   	push   %esi
801051b0:	53                   	push   %ebx
801051b1:	e8 ea c7 ff ff       	call   801019a0 <readi>
801051b6:	83 c4 10             	add    $0x10,%esp
801051b9:	83 f8 20             	cmp    $0x20,%eax
801051bc:	75 6c                	jne    8010522a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801051be:	66 83 7d c8 00       	cmpw   $0x0,-0x38(%ebp)
801051c3:	74 db                	je     801051a0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801051c5:	83 ec 0c             	sub    $0xc,%esp
801051c8:	53                   	push   %ebx
801051c9:	e8 82 c7 ff ff       	call   80101950 <iunlockput>
    goto bad;
801051ce:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801051d1:	83 ec 0c             	sub    $0xc,%esp
801051d4:	ff 75 94             	pushl  -0x6c(%ebp)
801051d7:	e8 74 c7 ff ff       	call   80101950 <iunlockput>
  end_op();
801051dc:	e8 2f da ff ff       	call   80102c10 <end_op>
  return -1;
801051e1:	83 c4 10             	add    $0x10,%esp
}
801051e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801051e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051ec:	5b                   	pop    %ebx
801051ed:	5e                   	pop    %esi
801051ee:	5f                   	pop    %edi
801051ef:	5d                   	pop    %ebp
801051f0:	c3                   	ret    
801051f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051f8:	8b 45 94             	mov    -0x6c(%ebp),%eax
    iupdate(dp);
801051fb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051fe:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105203:	50                   	push   %eax
80105204:	e8 07 c4 ff ff       	call   80101610 <iupdate>
80105209:	83 c4 10             	add    $0x10,%esp
8010520c:	e9 4b ff ff ff       	jmp    8010515c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105216:	e9 6b ff ff ff       	jmp    80105186 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010521b:	e8 f0 d9 ff ff       	call   80102c10 <end_op>
    return -1;
80105220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105225:	e9 5c ff ff ff       	jmp    80105186 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010522a:	83 ec 0c             	sub    $0xc,%esp
8010522d:	68 08 81 10 80       	push   $0x80108108
80105232:	e8 39 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105237:	83 ec 0c             	sub    $0xc,%esp
8010523a:	68 1a 81 10 80       	push   $0x8010811a
8010523f:	e8 2c b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105244:	83 ec 0c             	sub    $0xc,%esp
80105247:	68 f6 80 10 80       	push   $0x801080f6
8010524c:	e8 1f b1 ff ff       	call   80100370 <panic>
80105251:	eb 0d                	jmp    80105260 <sys_open>
80105253:	90                   	nop
80105254:	90                   	nop
80105255:	90                   	nop
80105256:	90                   	nop
80105257:	90                   	nop
80105258:	90                   	nop
80105259:	90                   	nop
8010525a:	90                   	nop
8010525b:	90                   	nop
8010525c:	90                   	nop
8010525d:	90                   	nop
8010525e:	90                   	nop
8010525f:	90                   	nop

80105260 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	56                   	push   %esi
80105265:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105266:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105269:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010526c:	50                   	push   %eax
8010526d:	6a 00                	push   $0x0
8010526f:	e8 9c f7 ff ff       	call   80104a10 <argstr>
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	85 c0                	test   %eax,%eax
80105279:	0f 88 9e 00 00 00    	js     8010531d <sys_open+0xbd>
8010527f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105282:	83 ec 08             	sub    $0x8,%esp
80105285:	50                   	push   %eax
80105286:	6a 01                	push   $0x1
80105288:	e8 53 f5 ff ff       	call   801047e0 <argint>
8010528d:	83 c4 10             	add    $0x10,%esp
80105290:	85 c0                	test   %eax,%eax
80105292:	0f 88 85 00 00 00    	js     8010531d <sys_open+0xbd>
    return -1;

  begin_op();
80105298:	e8 03 d9 ff ff       	call   80102ba0 <begin_op>

  if(omode & O_CREATE){
8010529d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052a1:	0f 85 89 00 00 00    	jne    80105330 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	ff 75 e0             	pushl  -0x20(%ebp)
801052ad:	e8 5e cc ff ff       	call   80101f10 <namei>
801052b2:	83 c4 10             	add    $0x10,%esp
801052b5:	85 c0                	test   %eax,%eax
801052b7:	89 c6                	mov    %eax,%esi
801052b9:	0f 84 8e 00 00 00    	je     8010534d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	50                   	push   %eax
801052c3:	e8 f8 c3 ff ff       	call   801016c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052c8:	83 c4 10             	add    $0x10,%esp
801052cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052d0:	0f 84 d2 00 00 00    	je     801053a8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052d6:	e8 f5 ba ff ff       	call   80100dd0 <filealloc>
801052db:	85 c0                	test   %eax,%eax
801052dd:	89 c7                	mov    %eax,%edi
801052df:	74 2b                	je     8010530c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052e1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801052e3:	e8 e8 e4 ff ff       	call   801037d0 <myproc>
801052e8:	90                   	nop
801052e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801052f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052f4:	85 d2                	test   %edx,%edx
801052f6:	74 68                	je     80105360 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052f8:	83 c3 01             	add    $0x1,%ebx
801052fb:	83 fb 10             	cmp    $0x10,%ebx
801052fe:	75 f0                	jne    801052f0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	57                   	push   %edi
80105304:	e8 87 bb ff ff       	call   80100e90 <fileclose>
80105309:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010530c:	83 ec 0c             	sub    $0xc,%esp
8010530f:	56                   	push   %esi
80105310:	e8 3b c6 ff ff       	call   80101950 <iunlockput>
    end_op();
80105315:	e8 f6 d8 ff ff       	call   80102c10 <end_op>
    return -1;
8010531a:	83 c4 10             	add    $0x10,%esp
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  
  return fd;
}
8010531d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105320:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  
  return fd;
}
80105325:	5b                   	pop    %ebx
80105326:	5e                   	pop    %esi
80105327:	5f                   	pop    %edi
80105328:	5d                   	pop    %ebp
80105329:	c3                   	ret    
8010532a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105336:	31 c9                	xor    %ecx,%ecx
80105338:	6a 00                	push   $0x0
8010533a:	ba 02 00 00 00       	mov    $0x2,%edx
8010533f:	e8 7c f7 ff ff       	call   80104ac0 <create>
    if(ip == 0){
80105344:	83 c4 10             	add    $0x10,%esp
80105347:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105349:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010534b:	75 89                	jne    801052d6 <sys_open+0x76>
      end_op();
8010534d:	e8 be d8 ff ff       	call   80102c10 <end_op>
      return -1;
80105352:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105357:	eb 43                	jmp    8010539c <sys_open+0x13c>
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105360:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105363:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105367:	56                   	push   %esi
80105368:	e8 33 c4 ff ff       	call   801017a0 <iunlock>
  end_op();
8010536d:	e8 9e d8 ff ff       	call   80102c10 <end_op>

  f->type = FD_INODE;
80105372:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105378:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010537b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010537e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105381:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105388:	89 d0                	mov    %edx,%eax
8010538a:	83 e0 01             	and    $0x1,%eax
8010538d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105390:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105393:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105396:	0f 95 47 09          	setne  0x9(%edi)
  
  return fd;
8010539a:	89 d8                	mov    %ebx,%eax
}
8010539c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010539f:	5b                   	pop    %ebx
801053a0:	5e                   	pop    %esi
801053a1:	5f                   	pop    %edi
801053a2:	5d                   	pop    %ebp
801053a3:	c3                   	ret    
801053a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801053a8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053ab:	85 c9                	test   %ecx,%ecx
801053ad:	0f 84 23 ff ff ff    	je     801052d6 <sys_open+0x76>
801053b3:	e9 54 ff ff ff       	jmp    8010530c <sys_open+0xac>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053c0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053c6:	e8 d5 d7 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ce:	83 ec 08             	sub    $0x8,%esp
801053d1:	50                   	push   %eax
801053d2:	6a 00                	push   $0x0
801053d4:	e8 37 f6 ff ff       	call   80104a10 <argstr>
801053d9:	83 c4 10             	add    $0x10,%esp
801053dc:	85 c0                	test   %eax,%eax
801053de:	78 30                	js     80105410 <sys_mkdir+0x50>
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053e6:	31 c9                	xor    %ecx,%ecx
801053e8:	6a 00                	push   $0x0
801053ea:	ba 01 00 00 00       	mov    $0x1,%edx
801053ef:	e8 cc f6 ff ff       	call   80104ac0 <create>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	74 15                	je     80105410 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053fb:	83 ec 0c             	sub    $0xc,%esp
801053fe:	50                   	push   %eax
801053ff:	e8 4c c5 ff ff       	call   80101950 <iunlockput>
  end_op();
80105404:	e8 07 d8 ff ff       	call   80102c10 <end_op>
  return 0;
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	31 c0                	xor    %eax,%eax
}
8010540e:	c9                   	leave  
8010540f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105410:	e8 fb d7 ff ff       	call   80102c10 <end_op>
    return -1;
80105415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105420 <sys_mknod>:

int
sys_mknod(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105426:	e8 75 d7 ff ff       	call   80102ba0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010542b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010542e:	83 ec 08             	sub    $0x8,%esp
80105431:	50                   	push   %eax
80105432:	6a 00                	push   $0x0
80105434:	e8 d7 f5 ff ff       	call   80104a10 <argstr>
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	85 c0                	test   %eax,%eax
8010543e:	78 60                	js     801054a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105440:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105443:	83 ec 08             	sub    $0x8,%esp
80105446:	50                   	push   %eax
80105447:	6a 01                	push   $0x1
80105449:	e8 92 f3 ff ff       	call   801047e0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	85 c0                	test   %eax,%eax
80105453:	78 4b                	js     801054a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105455:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105458:	83 ec 08             	sub    $0x8,%esp
8010545b:	50                   	push   %eax
8010545c:	6a 02                	push   $0x2
8010545e:	e8 7d f3 ff ff       	call   801047e0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	78 36                	js     801054a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010546a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010546e:	83 ec 0c             	sub    $0xc,%esp
80105471:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105475:	ba 03 00 00 00       	mov    $0x3,%edx
8010547a:	50                   	push   %eax
8010547b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010547e:	e8 3d f6 ff ff       	call   80104ac0 <create>
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	74 16                	je     801054a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010548a:	83 ec 0c             	sub    $0xc,%esp
8010548d:	50                   	push   %eax
8010548e:	e8 bd c4 ff ff       	call   80101950 <iunlockput>
  end_op();
80105493:	e8 78 d7 ff ff       	call   80102c10 <end_op>
  return 0;
80105498:	83 c4 10             	add    $0x10,%esp
8010549b:	31 c0                	xor    %eax,%eax
}
8010549d:	c9                   	leave  
8010549e:	c3                   	ret    
8010549f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801054a0:	e8 6b d7 ff ff       	call   80102c10 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_chdir>:

int
sys_chdir(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	56                   	push   %esi
801054b4:	53                   	push   %ebx
801054b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054b8:	e8 13 e3 ff ff       	call   801037d0 <myproc>
801054bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054bf:	e8 dc d6 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054c7:	83 ec 08             	sub    $0x8,%esp
801054ca:	50                   	push   %eax
801054cb:	6a 00                	push   $0x0
801054cd:	e8 3e f5 ff ff       	call   80104a10 <argstr>
801054d2:	83 c4 10             	add    $0x10,%esp
801054d5:	85 c0                	test   %eax,%eax
801054d7:	78 77                	js     80105550 <sys_chdir+0xa0>
801054d9:	83 ec 0c             	sub    $0xc,%esp
801054dc:	ff 75 f4             	pushl  -0xc(%ebp)
801054df:	e8 2c ca ff ff       	call   80101f10 <namei>
801054e4:	83 c4 10             	add    $0x10,%esp
801054e7:	85 c0                	test   %eax,%eax
801054e9:	89 c3                	mov    %eax,%ebx
801054eb:	74 63                	je     80105550 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054ed:	83 ec 0c             	sub    $0xc,%esp
801054f0:	50                   	push   %eax
801054f1:	e8 ca c1 ff ff       	call   801016c0 <ilock>
  if(ip->type != T_DIR){
801054f6:	83 c4 10             	add    $0x10,%esp
801054f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054fe:	75 30                	jne    80105530 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	53                   	push   %ebx
80105504:	e8 97 c2 ff ff       	call   801017a0 <iunlock>
  iput(curproc->cwd);
80105509:	58                   	pop    %eax
8010550a:	ff 76 68             	pushl  0x68(%esi)
8010550d:	e8 de c2 ff ff       	call   801017f0 <iput>
  end_op();
80105512:	e8 f9 d6 ff ff       	call   80102c10 <end_op>
  curproc->cwd = ip;
80105517:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010551a:	83 c4 10             	add    $0x10,%esp
8010551d:	31 c0                	xor    %eax,%eax
}
8010551f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105522:	5b                   	pop    %ebx
80105523:	5e                   	pop    %esi
80105524:	5d                   	pop    %ebp
80105525:	c3                   	ret    
80105526:	8d 76 00             	lea    0x0(%esi),%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 17 c4 ff ff       	call   80101950 <iunlockput>
    end_op();
80105539:	e8 d2 d6 ff ff       	call   80102c10 <end_op>
    return -1;
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105546:	eb d7                	jmp    8010551f <sys_chdir+0x6f>
80105548:	90                   	nop
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105550:	e8 bb d6 ff ff       	call   80102c10 <end_op>
    return -1;
80105555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010555a:	eb c3                	jmp    8010551f <sys_chdir+0x6f>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105566:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010556c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105572:	50                   	push   %eax
80105573:	6a 00                	push   $0x0
80105575:	e8 96 f4 ff ff       	call   80104a10 <argstr>
8010557a:	83 c4 10             	add    $0x10,%esp
8010557d:	85 c0                	test   %eax,%eax
8010557f:	78 7f                	js     80105600 <sys_exec+0xa0>
80105581:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105587:	83 ec 08             	sub    $0x8,%esp
8010558a:	50                   	push   %eax
8010558b:	6a 01                	push   $0x1
8010558d:	e8 4e f2 ff ff       	call   801047e0 <argint>
80105592:	83 c4 10             	add    $0x10,%esp
80105595:	85 c0                	test   %eax,%eax
80105597:	78 67                	js     80105600 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105599:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010559f:	83 ec 04             	sub    $0x4,%esp
801055a2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055a8:	68 80 00 00 00       	push   $0x80
801055ad:	6a 00                	push   $0x0
801055af:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055b5:	50                   	push   %eax
801055b6:	31 db                	xor    %ebx,%ebx
801055b8:	e8 c3 ee ff ff       	call   80104480 <memset>
801055bd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055c0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055c6:	83 ec 08             	sub    $0x8,%esp
801055c9:	57                   	push   %edi
801055ca:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055cd:	50                   	push   %eax
801055ce:	e8 6d f1 ff ff       	call   80104740 <fetchint>
801055d3:	83 c4 10             	add    $0x10,%esp
801055d6:	85 c0                	test   %eax,%eax
801055d8:	78 26                	js     80105600 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801055da:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055e0:	85 c0                	test   %eax,%eax
801055e2:	74 2c                	je     80105610 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055e4:	83 ec 08             	sub    $0x8,%esp
801055e7:	56                   	push   %esi
801055e8:	50                   	push   %eax
801055e9:	e8 92 f1 ff ff       	call   80104780 <fetchstr>
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	85 c0                	test   %eax,%eax
801055f3:	78 0b                	js     80105600 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801055f5:	83 c3 01             	add    $0x1,%ebx
801055f8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801055fb:	83 fb 20             	cmp    $0x20,%ebx
801055fe:	75 c0                	jne    801055c0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105600:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105603:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105608:	5b                   	pop    %ebx
80105609:	5e                   	pop    %esi
8010560a:	5f                   	pop    %edi
8010560b:	5d                   	pop    %ebp
8010560c:	c3                   	ret    
8010560d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105610:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105616:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105619:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105620:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105624:	50                   	push   %eax
80105625:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010562b:	e8 c0 b3 ff ff       	call   801009f0 <exec>
80105630:	83 c4 10             	add    $0x10,%esp
}
80105633:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105636:	5b                   	pop    %ebx
80105637:	5e                   	pop    %esi
80105638:	5f                   	pop    %edi
80105639:	5d                   	pop    %ebp
8010563a:	c3                   	ret    
8010563b:	90                   	nop
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105640 <sys_pipe>:

int
sys_pipe(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	57                   	push   %edi
80105644:	56                   	push   %esi
80105645:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105646:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105649:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010564c:	6a 08                	push   $0x8
8010564e:	50                   	push   %eax
8010564f:	6a 00                	push   $0x0
80105651:	e8 da f1 ff ff       	call   80104830 <argptr>
80105656:	83 c4 10             	add    $0x10,%esp
80105659:	85 c0                	test   %eax,%eax
8010565b:	78 4a                	js     801056a7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010565d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105660:	83 ec 08             	sub    $0x8,%esp
80105663:	50                   	push   %eax
80105664:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105667:	50                   	push   %eax
80105668:	e8 d3 db ff ff       	call   80103240 <pipealloc>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	85 c0                	test   %eax,%eax
80105672:	78 33                	js     801056a7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105674:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105676:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105679:	e8 52 e1 ff ff       	call   801037d0 <myproc>
8010567e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105680:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105684:	85 f6                	test   %esi,%esi
80105686:	74 30                	je     801056b8 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105688:	83 c3 01             	add    $0x1,%ebx
8010568b:	83 fb 10             	cmp    $0x10,%ebx
8010568e:	75 f0                	jne    80105680 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105690:	83 ec 0c             	sub    $0xc,%esp
80105693:	ff 75 e0             	pushl  -0x20(%ebp)
80105696:	e8 f5 b7 ff ff       	call   80100e90 <fileclose>
    fileclose(wf);
8010569b:	58                   	pop    %eax
8010569c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010569f:	e8 ec b7 ff ff       	call   80100e90 <fileclose>
    return -1;
801056a4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801056aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056af:	5b                   	pop    %ebx
801056b0:	5e                   	pop    %esi
801056b1:	5f                   	pop    %edi
801056b2:	5d                   	pop    %ebp
801056b3:	c3                   	ret    
801056b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056b8:	8d 73 08             	lea    0x8(%ebx),%esi
801056bb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056bf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056c2:	e8 09 e1 ff ff       	call   801037d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801056c7:	31 d2                	xor    %edx,%edx
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056d0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056d4:	85 c9                	test   %ecx,%ecx
801056d6:	74 18                	je     801056f0 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056d8:	83 c2 01             	add    $0x1,%edx
801056db:	83 fa 10             	cmp    $0x10,%edx
801056de:	75 f0                	jne    801056d0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056e0:	e8 eb e0 ff ff       	call   801037d0 <myproc>
801056e5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056ec:	00 
801056ed:	eb a1                	jmp    80105690 <sys_pipe+0x50>
801056ef:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056f0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801056f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056f7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801056f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801056fc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
801056ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105702:	31 c0                	xor    %eax,%eax
}
80105704:	5b                   	pop    %ebx
80105705:	5e                   	pop    %esi
80105706:	5f                   	pop    %edi
80105707:	5d                   	pop    %ebp
80105708:	c3                   	ret    
80105709:	66 90                	xchg   %ax,%ax
8010570b:	66 90                	xchg   %ax,%ax
8010570d:	66 90                	xchg   %ax,%ax
8010570f:	90                   	nop

80105710 <incrementRoughCount>:
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105710:	8b 0d 84 b6 10 80    	mov    0x8010b684,%ecx
    int pid;
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
80105716:	55                   	push   %ebp
80105717:	89 e5                	mov    %esp,%ebp
80105719:	57                   	push   %edi
    for(int i = 0; i < keyToCountSize; i++){
        if(key == keysToCount[i].key){
8010571a:	8b 3d 80 b6 10 80    	mov    0x8010b680,%edi
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105720:	85 c9                	test   %ecx,%ecx
    int pid;
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
80105722:	56                   	push   %esi
80105723:	53                   	push   %ebx
80105724:	8b 5d 08             	mov    0x8(%ebp),%ebx
    for(int i = 0; i < keyToCountSize; i++){
80105727:	7e 20                	jle    80105749 <incrementRoughCount+0x39>
        if(key == keysToCount[i].key){
80105729:	31 d2                	xor    %edx,%edx
8010572b:	3b 1f                	cmp    (%edi),%ebx
8010572d:	8d 47 08             	lea    0x8(%edi),%eax
80105730:	75 10                	jne    80105742 <incrementRoughCount+0x32>
80105732:	eb 2f                	jmp    80105763 <incrementRoughCount+0x53>
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105738:	89 c6                	mov    %eax,%esi
8010573a:	83 c0 08             	add    $0x8,%eax
8010573d:	39 58 f8             	cmp    %ebx,-0x8(%eax)
80105740:	74 23                	je     80105765 <incrementRoughCount+0x55>
    int key;
    int vAddr;
};

void incrementRoughCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105742:	83 c2 01             	add    $0x1,%edx
80105745:	39 ca                	cmp    %ecx,%edx
80105747:	75 ef                	jne    80105738 <incrementRoughCount+0x28>
            return;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    keysToCount[keyToCountSize].key = key;
80105749:	8d 04 cf             	lea    (%edi,%ecx,8),%eax
    keysToCount[keyToCountSize++].count = 1;
8010574c:	83 c1 01             	add    $0x1,%ecx
8010574f:	89 0d 84 b6 10 80    	mov    %ecx,0x8010b684
            return;
        } 
    }

    //cprintf("didn't find it %d\n", key);
    keysToCount[keyToCountSize].key = key;
80105755:	89 18                	mov    %ebx,(%eax)
    keysToCount[keyToCountSize++].count = 1;
80105757:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
}
8010575e:	5b                   	pop    %ebx
8010575f:	5e                   	pop    %esi
80105760:	5f                   	pop    %edi
80105761:	5d                   	pop    %ebp
80105762:	c3                   	ret    
    int vAddr;
};

void incrementRoughCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(key == keysToCount[i].key){
80105763:	89 fe                	mov    %edi,%esi
            keysToCount[i].count++;
80105765:	83 46 04 01          	addl   $0x1,0x4(%esi)
    }

    //cprintf("didn't find it %d\n", key);
    keysToCount[keyToCountSize].key = key;
    keysToCount[keyToCountSize++].count = 1;
}
80105769:	5b                   	pop    %ebx
8010576a:	5e                   	pop    %esi
8010576b:	5f                   	pop    %edi
8010576c:	5d                   	pop    %ebp
8010576d:	c3                   	ret    
8010576e:	66 90                	xchg   %ax,%ax

80105770 <sys_getSharedPage>:





int sys_getSharedPage(void){
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	57                   	push   %edi
80105774:	56                   	push   %esi
80105775:	53                   	push   %ebx
80105776:	83 ec 38             	sub    $0x38,%esp
    acquire(&lock);
80105779:	68 20 b0 10 80       	push   $0x8010b020
8010577e:	e8 fd eb ff ff       	call   80104380 <acquire>
    int key;
    struct proc *curproc = myproc();
80105783:	e8 48 e0 ff ff       	call   801037d0 <myproc>
80105788:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int numOfPages;

    if(keysToCount == 0){
8010578b:	a1 80 b6 10 80       	mov    0x8010b680,%eax
80105790:	83 c4 10             	add    $0x10,%esp
80105793:	85 c0                	test   %eax,%eax
80105795:	0f 84 62 02 00 00    	je     801059fd <sys_getSharedPage+0x28d>
        keysToCount = (struct pairsKC*) kalloc();
    }

    if(keysToPage == 0){
8010579b:	8b 3d 8c b6 10 80    	mov    0x8010b68c,%edi
801057a1:	85 ff                	test   %edi,%edi
801057a3:	0f 84 63 02 00 00    	je     80105a0c <sys_getSharedPage+0x29c>
        keysToPage = (struct pairs*) kalloc();
    }
    
    if(procKeyToAddr == 0){
801057a9:	8b 35 7c b6 10 80    	mov    0x8010b67c,%esi
801057af:	85 f6                	test   %esi,%esi
801057b1:	0f 84 64 02 00 00    	je     80105a1b <sys_getSharedPage+0x2ab>

    

    uint a;

    a = PGROUNDUP(curproc -> sz);
801057b7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    cprintf("Before argint\n");
801057ba:	83 ec 0c             	sub    $0xc,%esp

    

    uint a;

    a = PGROUNDUP(curproc -> sz);
801057bd:	8b 00                	mov    (%eax),%eax
    cprintf("Before argint\n");
801057bf:	68 29 81 10 80       	push   $0x80108129

    

    uint a;

    a = PGROUNDUP(curproc -> sz);
801057c4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801057c7:	05 ff 0f 00 00       	add    $0xfff,%eax
801057cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801057d1:	89 45 cc             	mov    %eax,-0x34(%ebp)
    cprintf("Before argint\n");
801057d4:	e8 87 ae ff ff       	call   80100660 <cprintf>

    if(argint(0, &key) < 0){
801057d9:	59                   	pop    %ecx
801057da:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057dd:	5b                   	pop    %ebx
801057de:	50                   	push   %eax
801057df:	6a 00                	push   $0x0
801057e1:	e8 fa ef ff ff       	call   801047e0 <argint>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	85 c0                	test   %eax,%eax
801057eb:	0f 88 39 02 00 00    	js     80105a2a <sys_getSharedPage+0x2ba>
        //cprintf("after 1st argint\n");
        return -1;
    } 

    incrementRoughCount(key);
801057f1:	83 ec 0c             	sub    $0xc,%esp
801057f4:	ff 75 e0             	pushl  -0x20(%ebp)
801057f7:	e8 14 ff ff ff       	call   80105710 <incrementRoughCount>

    if(argint(1, &numOfPages) < 0){
801057fc:	58                   	pop    %eax
801057fd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105800:	5a                   	pop    %edx
80105801:	50                   	push   %eax
80105802:	6a 01                	push   $0x1
80105804:	e8 d7 ef ff ff       	call   801047e0 <argint>
80105809:	83 c4 10             	add    $0x10,%esp
8010580c:	85 c0                	test   %eax,%eax
8010580e:	0f 88 16 02 00 00    	js     80105a2a <sys_getSharedPage+0x2ba>
    }

    samePage = 0;

    int counter = 0;
    for(int i = 0; i < keysSize; i++){
80105814:	8b 1d 88 b6 10 80    	mov    0x8010b688,%ebx
8010581a:	85 db                	test   %ebx,%ebx
8010581c:	0f 8e d0 01 00 00    	jle    801059f2 <sys_getSharedPage+0x282>
80105822:	8b 0d 8c b6 10 80    	mov    0x8010b68c,%ecx
80105828:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010582b:	8d 3c d9             	lea    (%ecx,%ebx,8),%edi
8010582e:	89 c8                	mov    %ecx,%eax
80105830:	31 db                	xor    %ebx,%ebx
80105832:	89 d6                	mov    %edx,%esi
80105834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(key == keysToPage[i].key){
            samePage = keysToPage[i].page;
            counter++;
80105838:	31 d2                	xor    %edx,%edx
8010583a:	39 30                	cmp    %esi,(%eax)
8010583c:	0f 94 c2             	sete   %dl
8010583f:	83 c0 08             	add    $0x8,%eax
80105842:	01 d3                	add    %edx,%ebx
    }

    samePage = 0;

    int counter = 0;
    for(int i = 0; i < keysSize; i++){
80105844:	39 c7                	cmp    %eax,%edi
80105846:	75 f0                	jne    80105838 <sys_getSharedPage+0xc8>
            counter++;
        } 
    }


    while(counter < numOfPages){
80105848:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
8010584b:	89 f2                	mov    %esi,%edx
8010584d:	7d 56                	jge    801058a5 <sys_getSharedPage+0x135>
8010584f:	90                   	nop
        samePage = kalloc(); 
80105850:	e8 8b cc ff ff       	call   801024e0 <kalloc>
        keysToPage[keysSize].key = key;
80105855:	8b 0d 88 b6 10 80    	mov    0x8010b688,%ecx
8010585b:	8b 15 8c b6 10 80    	mov    0x8010b68c,%edx
        keysToPage[keysSize].page = samePage;
        memset(samePage, 0, PGSIZE); 
80105861:	83 ec 04             	sub    $0x4,%esp
        keysSize++; 
        counter++;
80105864:	83 c3 01             	add    $0x1,%ebx
    }


    while(counter < numOfPages){
        samePage = kalloc(); 
        keysToPage[keysSize].key = key;
80105867:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
8010586a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
        keysToPage[keysSize].page = samePage;
8010586d:	89 42 04             	mov    %eax,0x4(%edx)
    }


    while(counter < numOfPages){
        samePage = kalloc(); 
        keysToPage[keysSize].key = key;
80105870:	89 0a                	mov    %ecx,(%edx)
        keysToPage[keysSize].page = samePage;
        memset(samePage, 0, PGSIZE); 
80105872:	68 00 10 00 00       	push   $0x1000
80105877:	6a 00                	push   $0x0
80105879:	50                   	push   %eax
8010587a:	e8 01 ec ff ff       	call   80104480 <memset>
        keysSize++; 
8010587f:	a1 88 b6 10 80       	mov    0x8010b688,%eax
            counter++;
        } 
    }


    while(counter < numOfPages){
80105884:	83 c4 10             	add    $0x10,%esp
        samePage = kalloc(); 
        keysToPage[keysSize].key = key;
        keysToPage[keysSize].page = samePage;
        memset(samePage, 0, PGSIZE); 
        keysSize++; 
80105887:	83 c0 01             	add    $0x1,%eax
            counter++;
        } 
    }


    while(counter < numOfPages){
8010588a:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
        samePage = kalloc(); 
        keysToPage[keysSize].key = key;
        keysToPage[keysSize].page = samePage;
        memset(samePage, 0, PGSIZE); 
        keysSize++; 
8010588d:	a3 88 b6 10 80       	mov    %eax,0x8010b688
            counter++;
        } 
    }


    while(counter < numOfPages){
80105892:	7f bc                	jg     80105850 <sys_getSharedPage+0xe0>
        counter++;
    }

    //cprintf("after kalloc\n");
    int counter1 = 0;
    for(int i = 0; i < keysSize; i++){
80105894:	85 c0                	test   %eax,%eax
80105896:	0f 8e 5d 01 00 00    	jle    801059f9 <sys_getSharedPage+0x289>
8010589c:	8b 0d 8c b6 10 80    	mov    0x8010b68c,%ecx
801058a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
            counter++;
        } 
    }


    while(counter < numOfPages){
801058a5:	31 db                	xor    %ebx,%ebx
801058a7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801058ae:	eb 18                	jmp    801058c8 <sys_getSharedPage+0x158>
        counter++;
    }

    //cprintf("after kalloc\n");
    int counter1 = 0;
    for(int i = 0; i < keysSize; i++){
801058b0:	83 c3 01             	add    $0x1,%ebx
801058b3:	39 1d 88 b6 10 80    	cmp    %ebx,0x8010b688
801058b9:	0f 8e 01 01 00 00    	jle    801059c0 <sys_getSharedPage+0x250>
801058bf:	8b 0d 8c b6 10 80    	mov    0x8010b68c,%ecx
801058c5:	8b 55 e0             	mov    -0x20(%ebp),%edx
        if(key == keysToPage[i].key){
801058c8:	39 14 d9             	cmp    %edx,(%ecx,%ebx,8)
801058cb:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
801058d2:	75 dc                	jne    801058b0 <sys_getSharedPage+0x140>
            cprintf("Virtual address: %p ", a + counter1 * PGSIZE);
801058d4:	8b 55 d0             	mov    -0x30(%ebp),%edx
801058d7:	8b 45 cc             	mov    -0x34(%ebp),%eax
801058da:	83 ec 08             	sub    $0x8,%esp
        counter++;
    }

    //cprintf("after kalloc\n");
    int counter1 = 0;
    for(int i = 0; i < keysSize; i++){
801058dd:	83 c3 01             	add    $0x1,%ebx
        if(key == keysToPage[i].key){
            cprintf("Virtual address: %p ", a + counter1 * PGSIZE);
801058e0:	c1 e2 0c             	shl    $0xc,%edx
801058e3:	8d 3c 02             	lea    (%edx,%eax,1),%edi
801058e6:	57                   	push   %edi
801058e7:	68 38 81 10 80       	push   $0x80108138
801058ec:	e8 6f ad ff ff       	call   80100660 <cprintf>
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
801058f1:	a1 8c b6 10 80       	mov    0x8010b68c,%eax
801058f6:	5a                   	pop    %edx
801058f7:	59                   	pop    %ecx
801058f8:	8b 44 30 04          	mov    0x4(%eax,%esi,1),%eax
801058fc:	05 00 00 00 80       	add    $0x80000000,%eax
80105901:	50                   	push   %eax
80105902:	68 4d 81 10 80       	push   $0x8010814d
80105907:	e8 54 ad ff ff       	call   80100660 <cprintf>
            mappages(curproc -> pgdir, (char*)a + counter1 * PGSIZE, PGSIZE, V2P(keysToPage[i].page), PTE_W|PTE_U|PTE_S);
8010590c:	a1 8c b6 10 80       	mov    0x8010b68c,%eax
80105911:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80105918:	8b 44 30 04          	mov    0x4(%eax,%esi,1),%eax
8010591c:	05 00 00 00 80       	add    $0x80000000,%eax
80105921:	50                   	push   %eax
80105922:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105925:	68 00 10 00 00       	push   $0x1000
8010592a:	57                   	push   %edi
8010592b:	ff 70 04             	pushl  0x4(%eax)
8010592e:	e8 2d 18 00 00       	call   80107160 <mappages>
            procKeyToAddr[procKeyToAddrSize].pid = curproc -> pid;
80105933:	a1 78 b6 10 80       	mov    0x8010b678,%eax
80105938:	8b 55 d4             	mov    -0x2c(%ebp),%edx
            cprintf("keyToPages pid %d\n", curproc -> pid);
8010593b:	83 c4 18             	add    $0x18,%esp
    for(int i = 0; i < keysSize; i++){
        if(key == keysToPage[i].key){
            cprintf("Virtual address: %p ", a + counter1 * PGSIZE);
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
            mappages(curproc -> pgdir, (char*)a + counter1 * PGSIZE, PGSIZE, V2P(keysToPage[i].page), PTE_W|PTE_U|PTE_S);
            procKeyToAddr[procKeyToAddrSize].pid = curproc -> pid;
8010593e:	8d 04 40             	lea    (%eax,%eax,2),%eax
80105941:	8b 4a 10             	mov    0x10(%edx),%ecx
80105944:	c1 e0 02             	shl    $0x2,%eax
80105947:	03 05 7c b6 10 80    	add    0x8010b67c,%eax
8010594d:	89 08                	mov    %ecx,(%eax)
            cprintf("keyToPages pid %d\n", curproc -> pid);
8010594f:	ff 72 10             	pushl  0x10(%edx)
80105952:	68 64 81 10 80       	push   $0x80108164
80105957:	e8 04 ad ff ff       	call   80100660 <cprintf>
            procKeyToAddr[procKeyToAddrSize].key = key;
8010595c:	a1 78 b6 10 80       	mov    0x8010b678,%eax
80105961:	8d 0c 40             	lea    (%eax,%eax,2),%ecx
80105964:	a1 7c b6 10 80       	mov    0x8010b67c,%eax
80105969:	8d 04 88             	lea    (%eax,%ecx,4),%eax
8010596c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
            procKeyToAddr[procKeyToAddrSize].vAddr = a + counter1 * PGSIZE;
8010596f:	89 78 08             	mov    %edi,0x8(%eax)
            cprintf("Virtual address: %p ", a + counter1 * PGSIZE);
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
            mappages(curproc -> pgdir, (char*)a + counter1 * PGSIZE, PGSIZE, V2P(keysToPage[i].page), PTE_W|PTE_U|PTE_S);
            procKeyToAddr[procKeyToAddrSize].pid = curproc -> pid;
            cprintf("keyToPages pid %d\n", curproc -> pid);
            procKeyToAddr[procKeyToAddrSize].key = key;
80105972:	89 48 04             	mov    %ecx,0x4(%eax)
            procKeyToAddr[procKeyToAddrSize].vAddr = a + counter1 * PGSIZE;
            cprintf("Virtual address: %p ", procKeyToAddr[procKeyToAddrSize].vAddr);
80105975:	58                   	pop    %eax
80105976:	5a                   	pop    %edx
80105977:	57                   	push   %edi
80105978:	68 38 81 10 80       	push   $0x80108138
8010597d:	e8 de ac ff ff       	call   80100660 <cprintf>
            procKeyToAddrSize++;
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
80105982:	a1 8c b6 10 80       	mov    0x8010b68c,%eax
            procKeyToAddr[procKeyToAddrSize].pid = curproc -> pid;
            cprintf("keyToPages pid %d\n", curproc -> pid);
            procKeyToAddr[procKeyToAddrSize].key = key;
            procKeyToAddr[procKeyToAddrSize].vAddr = a + counter1 * PGSIZE;
            cprintf("Virtual address: %p ", procKeyToAddr[procKeyToAddrSize].vAddr);
            procKeyToAddrSize++;
80105987:	83 05 78 b6 10 80 01 	addl   $0x1,0x8010b678
            cprintf("Physical address: %p \n", V2P(keysToPage[i].page));
8010598e:	59                   	pop    %ecx
8010598f:	5f                   	pop    %edi
80105990:	8b 44 30 04          	mov    0x4(%eax,%esi,1),%eax
80105994:	05 00 00 00 80       	add    $0x80000000,%eax
80105999:	50                   	push   %eax
8010599a:	68 4d 81 10 80       	push   $0x8010814d
8010599f:	e8 bc ac ff ff       	call   80100660 <cprintf>
            counter1++;
801059a4:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
801059a8:	83 c4 10             	add    $0x10,%esp
        counter++;
    }

    //cprintf("after kalloc\n");
    int counter1 = 0;
    for(int i = 0; i < keysSize; i++){
801059ab:	39 1d 88 b6 10 80    	cmp    %ebx,0x8010b688
801059b1:	0f 8f 08 ff ff ff    	jg     801058bf <sys_getSharedPage+0x14f>
801059b7:	89 f6                	mov    %esi,%esi
801059b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801059c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
801059c3:	c1 e0 0c             	shl    $0xc,%eax
            counter1++;
        }
    }
    //cprintf("After mappages\n");

    curproc->sz = a + counter1 * PGSIZE;
801059c6:	8b 7d cc             	mov    -0x34(%ebp),%edi
801059c9:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    switchuvm(curproc);
801059cc:	83 ec 0c             	sub    $0xc,%esp
            counter1++;
        }
    }
    //cprintf("After mappages\n");

    curproc->sz = a + counter1 * PGSIZE;
801059cf:	01 f8                	add    %edi,%eax
801059d1:	89 06                	mov    %eax,(%esi)
    switchuvm(curproc);
801059d3:	56                   	push   %esi
801059d4:	e8 47 18 00 00       	call   80107220 <switchuvm>
    release(&lock);
801059d9:	c7 04 24 20 b0 10 80 	movl   $0x8010b020,(%esp)
801059e0:	e8 4b ea ff ff       	call   80104430 <release>
    return a;
801059e5:	89 f8                	mov    %edi,%eax
801059e7:	83 c4 10             	add    $0x10,%esp
}
801059ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059ed:	5b                   	pop    %ebx
801059ee:	5e                   	pop    %esi
801059ef:	5f                   	pop    %edi
801059f0:	5d                   	pop    %ebp
801059f1:	c3                   	ret    
            counter++;
        } 
    }


    while(counter < numOfPages){
801059f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059f5:	85 c0                	test   %eax,%eax
801059f7:	7f 38                	jg     80105a31 <sys_getSharedPage+0x2c1>
801059f9:	31 c0                	xor    %eax,%eax
801059fb:	eb c9                	jmp    801059c6 <sys_getSharedPage+0x256>
    int key;
    struct proc *curproc = myproc();
    int numOfPages;

    if(keysToCount == 0){
        keysToCount = (struct pairsKC*) kalloc();
801059fd:	e8 de ca ff ff       	call   801024e0 <kalloc>
80105a02:	a3 80 b6 10 80       	mov    %eax,0x8010b680
80105a07:	e9 8f fd ff ff       	jmp    8010579b <sys_getSharedPage+0x2b>
    }

    if(keysToPage == 0){
        keysToPage = (struct pairs*) kalloc();
80105a0c:	e8 cf ca ff ff       	call   801024e0 <kalloc>
80105a11:	a3 8c b6 10 80       	mov    %eax,0x8010b68c
80105a16:	e9 8e fd ff ff       	jmp    801057a9 <sys_getSharedPage+0x39>
    }
    
    if(procKeyToAddr == 0){
        procKeyToAddr = (struct sharedMapping*) kalloc();
80105a1b:	e8 c0 ca ff ff       	call   801024e0 <kalloc>
80105a20:	a3 7c b6 10 80       	mov    %eax,0x8010b67c
80105a25:	e9 8d fd ff ff       	jmp    801057b7 <sys_getSharedPage+0x47>
    a = PGROUNDUP(curproc -> sz);
    cprintf("Before argint\n");

    if(argint(0, &key) < 0){
        //cprintf("after 1st argint\n");
        return -1;
80105a2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2f:	eb b9                	jmp    801059ea <sys_getSharedPage+0x27a>
            counter++;
        } 
    }


    while(counter < numOfPages){
80105a31:	31 db                	xor    %ebx,%ebx
80105a33:	e9 18 fe ff ff       	jmp    80105850 <sys_getSharedPage+0xe0>
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a40 <unmapping>:
}




void unmapping(pde_t *pgdir, uint oldsz, uint newsz){
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
80105a46:	83 ec 0c             	sub    $0xc,%esp
    uint a;

    //if(newsz >= oldsz)
    //    return oldsz;

    a = PGROUNDUP(newsz);
80105a49:	8b 45 10             	mov    0x10(%ebp),%eax
}




void unmapping(pde_t *pgdir, uint oldsz, uint newsz){
80105a4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80105a4f:	8b 7d 08             	mov    0x8(%ebp),%edi
    uint a;

    //if(newsz >= oldsz)
    //    return oldsz;

    a = PGROUNDUP(newsz);
80105a52:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80105a58:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    for(; a  < oldsz; a += PGSIZE){
80105a5e:	39 f3                	cmp    %esi,%ebx
80105a60:	72 1b                	jb     80105a7d <unmapping+0x3d>
80105a62:	eb 42                	jmp    80105aa6 <unmapping+0x66>
80105a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pte = walkpgdir(pgdir, (char*)a, 0);
        if(!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if((*pte & PTE_P) != 0){
80105a68:	f6 00 01             	testb  $0x1,(%eax)
80105a6b:	74 06                	je     80105a73 <unmapping+0x33>
            *pte = 0;
80105a6d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //if(newsz >= oldsz)
    //    return oldsz;

    a = PGROUNDUP(newsz);
    for(; a  < oldsz; a += PGSIZE){
80105a73:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105a79:	39 de                	cmp    %ebx,%esi
80105a7b:	76 29                	jbe    80105aa6 <unmapping+0x66>
        pte = walkpgdir(pgdir, (char*)a, 0);
80105a7d:	83 ec 04             	sub    $0x4,%esp
80105a80:	6a 00                	push   $0x0
80105a82:	53                   	push   %ebx
80105a83:	57                   	push   %edi
80105a84:	e8 97 15 00 00       	call   80107020 <walkpgdir>
        if(!pte)
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	85 c0                	test   %eax,%eax
80105a8e:	75 d8                	jne    80105a68 <unmapping+0x28>
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105a90:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80105a96:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

    //if(newsz >= oldsz)
    //    return oldsz;

    a = PGROUNDUP(newsz);
    for(; a  < oldsz; a += PGSIZE){
80105a9c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105aa2:	39 de                	cmp    %ebx,%esi
80105aa4:	77 d7                	ja     80105a7d <unmapping+0x3d>
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if((*pte & PTE_P) != 0){
            *pte = 0;
        }
    }
}
80105aa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aa9:	5b                   	pop    %ebx
80105aaa:	5e                   	pop    %esi
80105aab:	5f                   	pop    %edi
80105aac:	5d                   	pop    %ebp
80105aad:	c3                   	ret    
80105aae:	66 90                	xchg   %ax,%ax

80105ab0 <refCount>:

int refCount(int key){
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	56                   	push   %esi
80105ab4:	53                   	push   %ebx
    for(int i = 0; i < keyToCountSize; i++){
80105ab5:	8b 1d 84 b6 10 80    	mov    0x8010b684,%ebx
            *pte = 0;
        }
    }
}

int refCount(int key){
80105abb:	8b 75 08             	mov    0x8(%ebp),%esi
    for(int i = 0; i < keyToCountSize; i++){
80105abe:	85 db                	test   %ebx,%ebx
80105ac0:	7e 27                	jle    80105ae9 <refCount+0x39>
        if(keysToCount[i].key == key) return keysToCount[i].count;
80105ac2:	8b 0d 80 b6 10 80    	mov    0x8010b680,%ecx
80105ac8:	31 d2                	xor    %edx,%edx
80105aca:	3b 31                	cmp    (%ecx),%esi
80105acc:	8d 41 08             	lea    0x8(%ecx),%eax
80105acf:	75 11                	jne    80105ae2 <refCount+0x32>
80105ad1:	eb 1d                	jmp    80105af0 <refCount+0x40>
80105ad3:	90                   	nop
80105ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ad8:	89 c1                	mov    %eax,%ecx
80105ada:	83 c0 08             	add    $0x8,%eax
80105add:	39 70 f8             	cmp    %esi,-0x8(%eax)
80105ae0:	74 0e                	je     80105af0 <refCount+0x40>
        }
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105ae2:	83 c2 01             	add    $0x1,%edx
80105ae5:	39 da                	cmp    %ebx,%edx
80105ae7:	75 ef                	jne    80105ad8 <refCount+0x28>
        if(keysToCount[i].key == key) return keysToCount[i].count;
    }

    return 0;
}
80105ae9:	5b                   	pop    %ebx
int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key) return keysToCount[i].count;
    }

    return 0;
80105aea:	31 c0                	xor    %eax,%eax
}
80105aec:	5e                   	pop    %esi
80105aed:	5d                   	pop    %ebp
80105aee:	c3                   	ret    
80105aef:	90                   	nop
80105af0:	5b                   	pop    %ebx
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key) return keysToCount[i].count;
80105af1:	8b 41 04             	mov    0x4(%ecx),%eax
    }

    return 0;
}
80105af4:	5e                   	pop    %esi
80105af5:	5d                   	pop    %ebp
80105af6:	c3                   	ret    
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b00 <pageCount>:

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105b00:	a1 88 b6 10 80       	mov    0x8010b688,%eax
    }

    return 0;
}

int pageCount(int key){
80105b05:	55                   	push   %ebp
80105b06:	89 e5                	mov    %esp,%ebp
80105b08:	56                   	push   %esi
80105b09:	53                   	push   %ebx
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105b0a:	85 c0                	test   %eax,%eax
    }

    return 0;
}

int pageCount(int key){
80105b0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105b0f:	7e 23                	jle    80105b34 <pageCount+0x34>
80105b11:	8b 15 8c b6 10 80    	mov    0x8010b68c,%edx
80105b17:	8d 34 c2             	lea    (%edx,%eax,8),%esi
80105b1a:	31 c0                	xor    %eax,%eax
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(keysToPage[i].key == key){
            count++;
80105b20:	31 c9                	xor    %ecx,%ecx
80105b22:	39 1a                	cmp    %ebx,(%edx)
80105b24:	0f 94 c1             	sete   %cl
80105b27:	83 c2 08             	add    $0x8,%edx
80105b2a:	01 c8                	add    %ecx,%eax
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105b2c:	39 f2                	cmp    %esi,%edx
80105b2e:	75 f0                	jne    80105b20 <pageCount+0x20>
            count++;
        }
    }

    return count;
}
80105b30:	5b                   	pop    %ebx
80105b31:	5e                   	pop    %esi
80105b32:	5d                   	pop    %ebp
80105b33:	c3                   	ret    

    return 0;
}

int pageCount(int key){
    int count = 0;
80105b34:	31 c0                	xor    %eax,%eax
80105b36:	eb f8                	jmp    80105b30 <pageCount+0x30>
80105b38:	90                   	nop
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b40 <keysToCountDecrease>:

    return count;
}

void keysToCountDecrease(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105b40:	8b 15 84 b6 10 80    	mov    0x8010b684,%edx
    }

    return count;
}

void keysToCountDecrease(int key){
80105b46:	55                   	push   %ebp
80105b47:	89 e5                	mov    %esp,%ebp
80105b49:	53                   	push   %ebx
    for(int i = 0; i < keyToCountSize; i++){
80105b4a:	85 d2                	test   %edx,%edx
    }

    return count;
}

void keysToCountDecrease(int key){
80105b4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for(int i = 0; i < keyToCountSize; i++){
80105b4f:	7e 2f                	jle    80105b80 <keysToCountDecrease+0x40>
80105b51:	8b 1d 80 b6 10 80    	mov    0x8010b680,%ebx
80105b57:	8d 43 04             	lea    0x4(%ebx),%eax
80105b5a:	8d 5c d3 04          	lea    0x4(%ebx,%edx,8),%ebx
80105b5e:	eb 12                	jmp    80105b72 <keysToCountDecrease+0x32>
        if(keysToCount[i].key == key){
            keysToCount[i].count--;
        }

        if(keysToCount[i].count == 0){
80105b60:	85 d2                	test   %edx,%edx
80105b62:	75 07                	jne    80105b6b <keysToCountDecrease+0x2b>
            keysToCount[i].key = -1;
80105b64:	c7 40 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%eax)
80105b6b:	83 c0 08             	add    $0x8,%eax

    return count;
}

void keysToCountDecrease(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105b6e:	39 d8                	cmp    %ebx,%eax
80105b70:	74 0e                	je     80105b80 <keysToCountDecrease+0x40>
        if(keysToCount[i].key == key){
80105b72:	39 48 fc             	cmp    %ecx,-0x4(%eax)
            keysToCount[i].count--;
80105b75:	8b 10                	mov    (%eax),%edx
    return count;
}

void keysToCountDecrease(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key){
80105b77:	75 e7                	jne    80105b60 <keysToCountDecrease+0x20>
            keysToCount[i].count--;
80105b79:	83 ea 01             	sub    $0x1,%edx
80105b7c:	89 10                	mov    %edx,(%eax)
80105b7e:	eb e0                	jmp    80105b60 <keysToCountDecrease+0x20>
        if(keysToCount[i].count == 0){
            keysToCount[i].key = -1;
        }
    }

}
80105b80:	5b                   	pop    %ebx
80105b81:	5d                   	pop    %ebp
80105b82:	c3                   	ret    
80105b83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b90 <unmapSharedMappings>:

void unmapSharedMappings(struct proc* p, int key){
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	83 ec 1c             	sub    $0x1c,%esp
80105b99:	8b 45 08             	mov    0x8(%ebp),%eax
80105b9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105b9f:	8b 0d 7c b6 10 80    	mov    0x8010b67c,%ecx
    int pid = p -> pid;
80105ba5:	8b 50 10             	mov    0x10(%eax),%edx
    pde_t *pgdir = p -> pgdir;
80105ba8:	8b 40 04             	mov    0x4(%eax),%eax
80105bab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    
    for(int i = 0; i < procKeyToAddrSize; i++){
80105bae:	a1 78 b6 10 80       	mov    0x8010b678,%eax
80105bb3:	85 c0                	test   %eax,%eax
80105bb5:	7e 75                	jle    80105c2c <unmapSharedMappings+0x9c>
80105bb7:	31 db                	xor    %ebx,%ebx
80105bb9:	eb 10                	jmp    80105bcb <unmapSharedMappings+0x3b>
80105bbb:	90                   	nop
80105bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bc0:	83 c3 01             	add    $0x1,%ebx
80105bc3:	39 1d 78 b6 10 80    	cmp    %ebx,0x8010b678
80105bc9:	7e 61                	jle    80105c2c <unmapSharedMappings+0x9c>
80105bcb:	8d 34 5b             	lea    (%ebx,%ebx,2),%esi
80105bce:	c1 e6 02             	shl    $0x2,%esi
        if(procKeyToAddr[i].key == key && procKeyToAddr[i].pid == pid){
80105bd1:	8d 04 31             	lea    (%ecx,%esi,1),%eax
80105bd4:	39 78 04             	cmp    %edi,0x4(%eax)
80105bd7:	75 e7                	jne    80105bc0 <unmapSharedMappings+0x30>
80105bd9:	3b 10                	cmp    (%eax),%edx
80105bdb:	75 e3                	jne    80105bc0 <unmapSharedMappings+0x30>
            uint a = procKeyToAddr[i].vAddr;
            pte_t *pte = walkpgdir(pgdir, (char*)a, 0);
80105bdd:	83 ec 04             	sub    $0x4,%esp
80105be0:	89 55 e0             	mov    %edx,-0x20(%ebp)
80105be3:	6a 00                	push   $0x0
80105be5:	ff 70 08             	pushl  0x8(%eax)
80105be8:	ff 75 e4             	pushl  -0x1c(%ebp)
80105beb:	e8 30 14 00 00       	call   80107020 <walkpgdir>
            if(!pte)
80105bf0:	83 c4 10             	add    $0x10,%esp
80105bf3:	85 c0                	test   %eax,%eax
80105bf5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105bf8:	74 0b                	je     80105c05 <unmapSharedMappings+0x75>
                a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
                //cprintf("Didn't find corresponding table address.");
            else if((*pte & PTE_P) != 0){
80105bfa:	f6 00 01             	testb  $0x1,(%eax)
80105bfd:	74 06                	je     80105c05 <unmapSharedMappings+0x75>
                *pte = 0;
80105bff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            }
            procKeyToAddr[i].key = -1;
80105c05:	8b 0d 7c b6 10 80    	mov    0x8010b67c,%ecx

void unmapSharedMappings(struct proc* p, int key){
    int pid = p -> pid;
    pde_t *pgdir = p -> pgdir;
    
    for(int i = 0; i < procKeyToAddrSize; i++){
80105c0b:	83 c3 01             	add    $0x1,%ebx
                a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
                //cprintf("Didn't find corresponding table address.");
            else if((*pte & PTE_P) != 0){
                *pte = 0;
            }
            procKeyToAddr[i].key = -1;
80105c0e:	01 ce                	add    %ecx,%esi

void unmapSharedMappings(struct proc* p, int key){
    int pid = p -> pid;
    pde_t *pgdir = p -> pgdir;
    
    for(int i = 0; i < procKeyToAddrSize; i++){
80105c10:	39 1d 78 b6 10 80    	cmp    %ebx,0x8010b678
                a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
                //cprintf("Didn't find corresponding table address.");
            else if((*pte & PTE_P) != 0){
                *pte = 0;
            }
            procKeyToAddr[i].key = -1;
80105c16:	c7 46 04 ff ff ff ff 	movl   $0xffffffff,0x4(%esi)
            procKeyToAddr[i].vAddr = 0;
80105c1d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
            procKeyToAddr[i]. pid = -1;
80105c24:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%esi)

void unmapSharedMappings(struct proc* p, int key){
    int pid = p -> pid;
    pde_t *pgdir = p -> pgdir;
    
    for(int i = 0; i < procKeyToAddrSize; i++){
80105c2a:	7f 9f                	jg     80105bcb <unmapSharedMappings+0x3b>
            procKeyToAddr[i].key = -1;
            procKeyToAddr[i].vAddr = 0;
            procKeyToAddr[i]. pid = -1;
        }
    }
}
80105c2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c2f:	5b                   	pop    %ebx
80105c30:	5e                   	pop    %esi
80105c31:	5f                   	pop    %edi
80105c32:	5d                   	pop    %ebp
80105c33:	c3                   	ret    
80105c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105c40 <releaseByKey>:



void releaseByKey(int key){
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	57                   	push   %edi
80105c44:	56                   	push   %esi
80105c45:	53                   	push   %ebx
80105c46:	83 ec 28             	sub    $0x28,%esp
80105c49:	8b 5d 08             	mov    0x8(%ebp),%ebx
     acquire(&lock);
80105c4c:	68 20 b0 10 80       	push   $0x8010b020
80105c51:	e8 2a e7 ff ff       	call   80104380 <acquire>
    struct proc *curproc = myproc();
80105c56:	e8 75 db ff ff       	call   801037d0 <myproc>
        }
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105c5b:	8b 35 84 b6 10 80    	mov    0x8010b684,%esi
80105c61:	83 c4 10             	add    $0x10,%esp



void releaseByKey(int key){
     acquire(&lock);
    struct proc *curproc = myproc();
80105c64:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        }
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105c67:	85 f6                	test   %esi,%esi
80105c69:	7e 2a                	jle    80105c95 <releaseByKey+0x55>
        if(keysToCount[i].key == key) return keysToCount[i].count;
80105c6b:	8b 0d 80 b6 10 80    	mov    0x8010b680,%ecx
80105c71:	31 d2                	xor    %edx,%edx
80105c73:	3b 19                	cmp    (%ecx),%ebx
80105c75:	8d 41 08             	lea    0x8(%ecx),%eax
80105c78:	75 14                	jne    80105c8e <releaseByKey+0x4e>
80105c7a:	e9 91 00 00 00       	jmp    80105d10 <releaseByKey+0xd0>
80105c7f:	90                   	nop
80105c80:	89 c1                	mov    %eax,%ecx
80105c82:	83 c0 08             	add    $0x8,%eax
80105c85:	3b 58 f8             	cmp    -0x8(%eax),%ebx
80105c88:	0f 84 82 00 00 00    	je     80105d10 <releaseByKey+0xd0>
        }
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
80105c8e:	83 c2 01             	add    $0x1,%edx
80105c91:	39 f2                	cmp    %esi,%edx
80105c93:	75 eb                	jne    80105c80 <releaseByKey+0x40>
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105c95:	8b 35 88 b6 10 80    	mov    0x8010b688,%esi
80105c9b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80105ca2:	85 f6                	test   %esi,%esi
80105ca4:	0f 8e d3 00 00 00    	jle    80105d7d <releaseByKey+0x13d>
80105caa:	8b 3d 8c b6 10 80    	mov    0x8010b68c,%edi
80105cb0:	31 d2                	xor    %edx,%edx
80105cb2:	31 c0                	xor    %eax,%eax
80105cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(keysToPage[i].key == key){
            count++;
80105cb8:	31 c9                	xor    %ecx,%ecx
80105cba:	3b 1c c7             	cmp    (%edi,%eax,8),%ebx
80105cbd:	0f 94 c1             	sete   %cl
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105cc0:	83 c0 01             	add    $0x1,%eax
        if(keysToPage[i].key == key){
            count++;
80105cc3:	01 ca                	add    %ecx,%edx
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105cc5:	39 f0                	cmp    %esi,%eax
80105cc7:	7c ef                	jl     80105cb8 <releaseByKey+0x78>
80105cc9:	89 d6                	mov    %edx,%esi
80105ccb:	c1 e6 0c             	shl    $0xc,%esi
     int pageCounts = pageCount(key);
     
    //cprintf("refCount and key: %d and %d \n", refCounts, key);
   

     unmapSharedMappings(curproc, key);
80105cce:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105cd1:	83 ec 08             	sub    $0x8,%esp
80105cd4:	53                   	push   %ebx
80105cd5:	57                   	push   %edi
80105cd6:	e8 b5 fe ff ff       	call   80105b90 <unmapSharedMappings>

    curproc->sz = (curproc -> sz) - (PGSIZE * pageCounts);
80105cdb:	29 37                	sub    %esi,(%edi)
    

    
     if(refCounts == 1){
80105cdd:	83 c4 10             	add    $0x10,%esp
80105ce0:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
80105ce4:	74 42                	je     80105d28 <releaseByKey+0xe8>
                keysToPage[i].key = -1; 
                keysToPage[i].page = 0;
             }   
         }
     }
     keysToCountDecrease(key);
80105ce6:	83 ec 0c             	sub    $0xc,%esp
80105ce9:	53                   	push   %ebx
80105cea:	e8 51 fe ff ff       	call   80105b40 <keysToCountDecrease>
    switchuvm(curproc);
80105cef:	58                   	pop    %eax
80105cf0:	ff 75 e4             	pushl  -0x1c(%ebp)
80105cf3:	e8 28 15 00 00       	call   80107220 <switchuvm>
    release(&lock);
80105cf8:	c7 45 08 20 b0 10 80 	movl   $0x8010b020,0x8(%ebp)
80105cff:	83 c4 10             	add    $0x10,%esp
}
80105d02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d05:	5b                   	pop    %ebx
80105d06:	5e                   	pop    %esi
80105d07:	5f                   	pop    %edi
80105d08:	5d                   	pop    %ebp
             }   
         }
     }
     keysToCountDecrease(key);
    switchuvm(curproc);
    release(&lock);
80105d09:	e9 22 e7 ff ff       	jmp    80104430 <release>
80105d0e:	66 90                	xchg   %ax,%ax
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105d10:	8b 35 88 b6 10 80    	mov    0x8010b688,%esi
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key) return keysToCount[i].count;
80105d16:	8b 41 04             	mov    0x4(%ecx),%eax
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105d19:	85 f6                	test   %esi,%esi
    }
}

int refCount(int key){
    for(int i = 0; i < keyToCountSize; i++){
        if(keysToCount[i].key == key) return keysToCount[i].count;
80105d1b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return 0;
}

int pageCount(int key){
    int count = 0;
    for(int i = 0; i < keysSize; i++){
80105d1e:	7f 8a                	jg     80105caa <releaseByKey+0x6a>
80105d20:	31 f6                	xor    %esi,%esi
80105d22:	eb aa                	jmp    80105cce <releaseByKey+0x8e>
80105d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    

    
     if(refCounts == 1){
         //cprintf("refCounts = 1 \n");
         for(int i = 0; i < keysSize; i++){
80105d28:	8b 15 88 b6 10 80    	mov    0x8010b688,%edx
80105d2e:	85 d2                	test   %edx,%edx
80105d30:	7e b4                	jle    80105ce6 <releaseByKey+0xa6>
80105d32:	31 f6                	xor    %esi,%esi
80105d34:	a1 8c b6 10 80       	mov    0x8010b68c,%eax
80105d39:	eb 10                	jmp    80105d4b <releaseByKey+0x10b>
80105d3b:	90                   	nop
80105d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d40:	83 c6 01             	add    $0x1,%esi
80105d43:	39 35 88 b6 10 80    	cmp    %esi,0x8010b688
80105d49:	7e 9b                	jle    80105ce6 <releaseByKey+0xa6>
80105d4b:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
             if(keysToPage[i].key == key){
80105d52:	8d 14 38             	lea    (%eax,%edi,1),%edx
80105d55:	3b 1a                	cmp    (%edx),%ebx
80105d57:	75 e7                	jne    80105d40 <releaseByKey+0x100>
                kfree(keysToPage[i].page);
80105d59:	83 ec 0c             	sub    $0xc,%esp
80105d5c:	ff 72 04             	pushl  0x4(%edx)
80105d5f:	e8 cc c5 ff ff       	call   80102330 <kfree>
                keysToPage[i].key = -1; 
80105d64:	a1 8c b6 10 80       	mov    0x8010b68c,%eax
                keysToPage[i].page = 0;
80105d69:	83 c4 10             	add    $0x10,%esp
     if(refCounts == 1){
         //cprintf("refCounts = 1 \n");
         for(int i = 0; i < keysSize; i++){
             if(keysToPage[i].key == key){
                kfree(keysToPage[i].page);
                keysToPage[i].key = -1; 
80105d6c:	01 c7                	add    %eax,%edi
80105d6e:	c7 07 ff ff ff ff    	movl   $0xffffffff,(%edi)
                keysToPage[i].page = 0;
80105d74:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%edi)
80105d7b:	eb c3                	jmp    80105d40 <releaseByKey+0x100>
     int pageCounts = pageCount(key);
     
    //cprintf("refCount and key: %d and %d \n", refCounts, key);
   

     unmapSharedMappings(curproc, key);
80105d7d:	83 ec 08             	sub    $0x8,%esp
80105d80:	53                   	push   %ebx
80105d81:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d84:	e8 07 fe ff ff       	call   80105b90 <unmapSharedMappings>
80105d89:	83 c4 10             	add    $0x10,%esp
80105d8c:	e9 55 ff ff ff       	jmp    80105ce6 <releaseByKey+0xa6>
80105d91:	eb 0d                	jmp    80105da0 <procCleanup>
80105d93:	90                   	nop
80105d94:	90                   	nop
80105d95:	90                   	nop
80105d96:	90                   	nop
80105d97:	90                   	nop
80105d98:	90                   	nop
80105d99:	90                   	nop
80105d9a:	90                   	nop
80105d9b:	90                   	nop
80105d9c:	90                   	nop
80105d9d:	90                   	nop
80105d9e:	90                   	nop
80105d9f:	90                   	nop

80105da0 <procCleanup>:
     keysToCountDecrease(key);
    switchuvm(curproc);
    release(&lock);
}

void procCleanup(int pid){
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	56                   	push   %esi
80105da4:	53                   	push   %ebx

    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
80105da5:	8b 1d 78 b6 10 80    	mov    0x8010b678,%ebx
     keysToCountDecrease(key);
    switchuvm(curproc);
    release(&lock);
}

void procCleanup(int pid){
80105dab:	8b 75 08             	mov    0x8(%ebp),%esi

    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
80105dae:	85 db                	test   %ebx,%ebx
80105db0:	7e 27                	jle    80105dd9 <procCleanup+0x39>
        //cprintf("in loop pid %d \n", pid);
        if(procKeyToAddr[i].pid == pid){
80105db2:	8b 0d 7c b6 10 80    	mov    0x8010b67c,%ecx
80105db8:	31 d2                	xor    %edx,%edx
80105dba:	3b 31                	cmp    (%ecx),%esi
80105dbc:	8d 41 0c             	lea    0xc(%ecx),%eax
80105dbf:	75 11                	jne    80105dd2 <procCleanup+0x32>
80105dc1:	eb 1d                	jmp    80105de0 <procCleanup+0x40>
80105dc3:	90                   	nop
80105dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dc8:	89 c1                	mov    %eax,%ecx
80105dca:	83 c0 0c             	add    $0xc,%eax
80105dcd:	39 70 f4             	cmp    %esi,-0xc(%eax)
80105dd0:	74 0e                	je     80105de0 <procCleanup+0x40>
}

void procCleanup(int pid){

    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
80105dd2:	83 c2 01             	add    $0x1,%edx
80105dd5:	39 da                	cmp    %ebx,%edx
80105dd7:	75 ef                	jne    80105dc8 <procCleanup+0x28>
            releaseByKey(procKeyToAddr[i].key);
            break;
        }
    }
    
}
80105dd9:	5b                   	pop    %ebx
80105dda:	5e                   	pop    %esi
80105ddb:	5d                   	pop    %ebp
80105ddc:	c3                   	ret    
80105ddd:	8d 76 00             	lea    0x0(%esi),%esi
    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
        //cprintf("in loop pid %d \n", pid);
        if(procKeyToAddr[i].pid == pid){
            //cprintf("in loop key: %d \n", procKeyToAddr[i].key);
            releaseByKey(procKeyToAddr[i].key);
80105de0:	8b 41 04             	mov    0x4(%ecx),%eax
            break;
        }
    }
    
}
80105de3:	5b                   	pop    %ebx
80105de4:	5e                   	pop    %esi
    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
        //cprintf("in loop pid %d \n", pid);
        if(procKeyToAddr[i].pid == pid){
            //cprintf("in loop key: %d \n", procKeyToAddr[i].key);
            releaseByKey(procKeyToAddr[i].key);
80105de5:	89 45 08             	mov    %eax,0x8(%ebp)
            break;
        }
    }
    
}
80105de8:	5d                   	pop    %ebp
    //cprintf("procCleanUp: before loop\n");
    for(int i = 0; i < procKeyToAddrSize; i++){
        //cprintf("in loop pid %d \n", pid);
        if(procKeyToAddr[i].pid == pid){
            //cprintf("in loop key: %d \n", procKeyToAddr[i].key);
            releaseByKey(procKeyToAddr[i].key);
80105de9:	e9 52 fe ff ff       	jmp    80105c40 <releaseByKey>
80105dee:	66 90                	xchg   %ax,%ax

80105df0 <sys_freeSharedPage>:
        }
    }
    
}

int sys_freeSharedPage(void){
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 20             	sub    $0x20,%esp
     int key;
     
     if(argint(0, &key) < 0){
80105df6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105df9:	50                   	push   %eax
80105dfa:	6a 00                	push   $0x0
80105dfc:	e8 df e9 ff ff       	call   801047e0 <argint>
80105e01:	83 c4 10             	add    $0x10,%esp
80105e04:	85 c0                	test   %eax,%eax
80105e06:	78 18                	js     80105e20 <sys_freeSharedPage+0x30>
        //cprintf("after 1st argint\n");
        return -1;
     } 

    releaseByKey(key);
80105e08:	83 ec 0c             	sub    $0xc,%esp
80105e0b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e0e:	e8 2d fe ff ff       	call   80105c40 <releaseByKey>
     
    return 0;
80105e13:	83 c4 10             	add    $0x10,%esp
80105e16:	31 c0                	xor    %eax,%eax
80105e18:	c9                   	leave  
80105e19:	c3                   	ret    
80105e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
int sys_freeSharedPage(void){
     int key;
     
     if(argint(0, &key) < 0){
        //cprintf("after 1st argint\n");
        return -1;
80105e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     } 

    releaseByKey(key);
     
    return 0;
80105e25:	c9                   	leave  
80105e26:	c3                   	ret    
80105e27:	66 90                	xchg   %ax,%ax
80105e29:	66 90                	xchg   %ax,%ax
80105e2b:	66 90                	xchg   %ax,%ax
80105e2d:	66 90                	xchg   %ax,%ax
80105e2f:	90                   	nop

80105e30 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105e33:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105e34:	e9 37 db ff ff       	jmp    80103970 <fork>
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e40 <sys_exit>:
}

int
sys_exit(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	83 ec 08             	sub    $0x8,%esp
  exit();
80105e46:	e8 b5 dd ff ff       	call   80103c00 <exit>
  return 0;  // not reached
}
80105e4b:	31 c0                	xor    %eax,%eax
80105e4d:	c9                   	leave  
80105e4e:	c3                   	ret    
80105e4f:	90                   	nop

80105e50 <sys_wait>:

int
sys_wait(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105e53:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105e54:	e9 e7 df ff ff       	jmp    80103e40 <wait>
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e60 <sys_kill>:
}

int
sys_kill(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105e66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e69:	50                   	push   %eax
80105e6a:	6a 00                	push   $0x0
80105e6c:	e8 6f e9 ff ff       	call   801047e0 <argint>
80105e71:	83 c4 10             	add    $0x10,%esp
80105e74:	85 c0                	test   %eax,%eax
80105e76:	78 18                	js     80105e90 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105e78:	83 ec 0c             	sub    $0xc,%esp
80105e7b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e7e:	e8 1d e1 ff ff       	call   80103fa0 <kill>
80105e83:	83 c4 10             	add    $0x10,%esp
}
80105e86:	c9                   	leave  
80105e87:	c3                   	ret    
80105e88:	90                   	nop
80105e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105e95:	c9                   	leave  
80105e96:	c3                   	ret    
80105e97:	89 f6                	mov    %esi,%esi
80105e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ea0 <sys_getpid>:

int
sys_getpid(void)
{
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105ea6:	e8 25 d9 ff ff       	call   801037d0 <myproc>
80105eab:	8b 40 10             	mov    0x10(%eax),%eax
}
80105eae:	c9                   	leave  
80105eaf:	c3                   	ret    

80105eb0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105eb7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105eba:	50                   	push   %eax
80105ebb:	6a 00                	push   $0x0
80105ebd:	e8 1e e9 ff ff       	call   801047e0 <argint>
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	78 27                	js     80105ef0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105ec9:	e8 02 d9 ff ff       	call   801037d0 <myproc>
  if(growproc(n) < 0)
80105ece:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105ed1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105ed3:	ff 75 f4             	pushl  -0xc(%ebp)
80105ed6:	e8 15 da ff ff       	call   801038f0 <growproc>
80105edb:	83 c4 10             	add    $0x10,%esp
80105ede:	85 c0                	test   %eax,%eax
80105ee0:	78 0e                	js     80105ef0 <sys_sbrk+0x40>
    return -1;
  return addr;
80105ee2:	89 d8                	mov    %ebx,%eax
}
80105ee4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ee7:	c9                   	leave  
80105ee8:	c3                   	ret    
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ef5:	eb ed                	jmp    80105ee4 <sys_sbrk+0x34>
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f00 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105f07:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105f0a:	50                   	push   %eax
80105f0b:	6a 00                	push   $0x0
80105f0d:	e8 ce e8 ff ff       	call   801047e0 <argint>
80105f12:	83 c4 10             	add    $0x10,%esp
80105f15:	85 c0                	test   %eax,%eax
80105f17:	0f 88 8a 00 00 00    	js     80105fa7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	68 80 61 11 80       	push   $0x80116180
80105f25:	e8 56 e4 ff ff       	call   80104380 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105f2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f2d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105f30:	8b 1d c0 69 11 80    	mov    0x801169c0,%ebx
  while(ticks - ticks0 < n){
80105f36:	85 d2                	test   %edx,%edx
80105f38:	75 27                	jne    80105f61 <sys_sleep+0x61>
80105f3a:	eb 54                	jmp    80105f90 <sys_sleep+0x90>
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105f40:	83 ec 08             	sub    $0x8,%esp
80105f43:	68 80 61 11 80       	push   $0x80116180
80105f48:	68 c0 69 11 80       	push   $0x801169c0
80105f4d:	e8 2e de ff ff       	call   80103d80 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105f52:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105f57:	83 c4 10             	add    $0x10,%esp
80105f5a:	29 d8                	sub    %ebx,%eax
80105f5c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f5f:	73 2f                	jae    80105f90 <sys_sleep+0x90>
    if(myproc()->killed){
80105f61:	e8 6a d8 ff ff       	call   801037d0 <myproc>
80105f66:	8b 40 24             	mov    0x24(%eax),%eax
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	74 d3                	je     80105f40 <sys_sleep+0x40>
      release(&tickslock);
80105f6d:	83 ec 0c             	sub    $0xc,%esp
80105f70:	68 80 61 11 80       	push   $0x80116180
80105f75:	e8 b6 e4 ff ff       	call   80104430 <release>
      return -1;
80105f7a:	83 c4 10             	add    $0x10,%esp
80105f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105f82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f85:	c9                   	leave  
80105f86:	c3                   	ret    
80105f87:	89 f6                	mov    %esi,%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105f90:	83 ec 0c             	sub    $0xc,%esp
80105f93:	68 80 61 11 80       	push   $0x80116180
80105f98:	e8 93 e4 ff ff       	call   80104430 <release>
  return 0;
80105f9d:	83 c4 10             	add    $0x10,%esp
80105fa0:	31 c0                	xor    %eax,%eax
}
80105fa2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fa5:	c9                   	leave  
80105fa6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105fa7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fac:	eb d4                	jmp    80105f82 <sys_sleep+0x82>
80105fae:	66 90                	xchg   %ax,%ax

80105fb0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	53                   	push   %ebx
80105fb4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105fb7:	68 80 61 11 80       	push   $0x80116180
80105fbc:	e8 bf e3 ff ff       	call   80104380 <acquire>
  xticks = ticks;
80105fc1:	8b 1d c0 69 11 80    	mov    0x801169c0,%ebx
  release(&tickslock);
80105fc7:	c7 04 24 80 61 11 80 	movl   $0x80116180,(%esp)
80105fce:	e8 5d e4 ff ff       	call   80104430 <release>
  return xticks;
}
80105fd3:	89 d8                	mov    %ebx,%eax
80105fd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fd8:	c9                   	leave  
80105fd9:	c3                   	ret    

80105fda <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105fda:	1e                   	push   %ds
  pushl %es
80105fdb:	06                   	push   %es
  pushl %fs
80105fdc:	0f a0                	push   %fs
  pushl %gs
80105fde:	0f a8                	push   %gs
  pushal
80105fe0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105fe1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105fe5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105fe7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105fe9:	54                   	push   %esp
  call trap
80105fea:	e8 e1 00 00 00       	call   801060d0 <trap>
  addl $4, %esp
80105fef:	83 c4 04             	add    $0x4,%esp

80105ff2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105ff2:	61                   	popa   
  popl %gs
80105ff3:	0f a9                	pop    %gs
  popl %fs
80105ff5:	0f a1                	pop    %fs
  popl %es
80105ff7:	07                   	pop    %es
  popl %ds
80105ff8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105ff9:	83 c4 08             	add    $0x8,%esp
  iret
80105ffc:	cf                   	iret   
80105ffd:	66 90                	xchg   %ax,%ax
80105fff:	90                   	nop

80106000 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106000:	31 c0                	xor    %eax,%eax
80106002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106008:	8b 14 85 54 b0 10 80 	mov    -0x7fef4fac(,%eax,4),%edx
8010600f:	b9 08 00 00 00       	mov    $0x8,%ecx
80106014:	c6 04 c5 c4 61 11 80 	movb   $0x0,-0x7fee9e3c(,%eax,8)
8010601b:	00 
8010601c:	66 89 0c c5 c2 61 11 	mov    %cx,-0x7fee9e3e(,%eax,8)
80106023:	80 
80106024:	c6 04 c5 c5 61 11 80 	movb   $0x8e,-0x7fee9e3b(,%eax,8)
8010602b:	8e 
8010602c:	66 89 14 c5 c0 61 11 	mov    %dx,-0x7fee9e40(,%eax,8)
80106033:	80 
80106034:	c1 ea 10             	shr    $0x10,%edx
80106037:	66 89 14 c5 c6 61 11 	mov    %dx,-0x7fee9e3a(,%eax,8)
8010603e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010603f:	83 c0 01             	add    $0x1,%eax
80106042:	3d 00 01 00 00       	cmp    $0x100,%eax
80106047:	75 bf                	jne    80106008 <tvinit+0x8>
int countTrap = 0;
int trapValCounters[256] = {0};
int unkownTrap = 0;
void
tvinit(void)
{
80106049:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010604a:	ba 08 00 00 00       	mov    $0x8,%edx
int countTrap = 0;
int trapValCounters[256] = {0};
int unkownTrap = 0;
void
tvinit(void)
{
8010604f:	89 e5                	mov    %esp,%ebp
80106051:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106054:	a1 54 b1 10 80       	mov    0x8010b154,%eax

  initlock(&tickslock, "time");
80106059:	68 77 81 10 80       	push   $0x80108177
8010605e:	68 80 61 11 80       	push   $0x80116180
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106063:	66 89 15 c2 63 11 80 	mov    %dx,0x801163c2
8010606a:	c6 05 c4 63 11 80 00 	movb   $0x0,0x801163c4
80106071:	66 a3 c0 63 11 80    	mov    %ax,0x801163c0
80106077:	c1 e8 10             	shr    $0x10,%eax
8010607a:	c6 05 c5 63 11 80 ef 	movb   $0xef,0x801163c5
80106081:	66 a3 c6 63 11 80    	mov    %ax,0x801163c6

  initlock(&tickslock, "time");
80106087:	e8 94 e1 ff ff       	call   80104220 <initlock>
}
8010608c:	83 c4 10             	add    $0x10,%esp
8010608f:	c9                   	leave  
80106090:	c3                   	ret    
80106091:	eb 0d                	jmp    801060a0 <idtinit>
80106093:	90                   	nop
80106094:	90                   	nop
80106095:	90                   	nop
80106096:	90                   	nop
80106097:	90                   	nop
80106098:	90                   	nop
80106099:	90                   	nop
8010609a:	90                   	nop
8010609b:	90                   	nop
8010609c:	90                   	nop
8010609d:	90                   	nop
8010609e:	90                   	nop
8010609f:	90                   	nop

801060a0 <idtinit>:

void
idtinit(void)
{
801060a0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801060a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801060a6:	89 e5                	mov    %esp,%ebp
801060a8:	83 ec 10             	sub    $0x10,%esp
801060ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801060af:	b8 c0 61 11 80       	mov    $0x801161c0,%eax
801060b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801060b8:	c1 e8 10             	shr    $0x10,%eax
801060bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801060bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801060c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801060c5:	c9                   	leave  
801060c6:	c3                   	ret    
801060c7:	89 f6                	mov    %esi,%esi
801060c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801060d0:	55                   	push   %ebp
801060d1:	89 e5                	mov    %esp,%ebp
801060d3:	57                   	push   %edi
801060d4:	56                   	push   %esi
801060d5:	53                   	push   %ebx
801060d6:	83 ec 1c             	sub    $0x1c,%esp
801060d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801060dc:	8b 47 30             	mov    0x30(%edi),%eax
801060df:	83 f8 40             	cmp    $0x40,%eax
801060e2:	0f 84 98 01 00 00    	je     80106280 <trap+0x1b0>
    if(myproc()->killed)
      exit();
    return;
  }

  trapValCounters[tf->trapno]++;
801060e8:	83 04 85 c0 b6 10 80 	addl   $0x1,-0x7fef4940(,%eax,4)
801060ef:	01 
  countTrap++;
801060f0:	83 05 c0 ba 10 80 01 	addl   $0x1,0x8010bac0

  switch(tf->trapno){
801060f7:	8b 47 30             	mov    0x30(%edi),%eax
801060fa:	83 e8 20             	sub    $0x20,%eax
801060fd:	83 f8 1f             	cmp    $0x1f,%eax
80106100:	77 0e                	ja     80106110 <trap+0x40>
80106102:	ff 24 85 20 82 10 80 	jmp    *-0x7fef7de0(,%eax,4)
80106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    unkownTrap++;
80106110:	83 05 a0 b6 10 80 01 	addl   $0x1,0x8010b6a0
    if(myproc() == 0 || (tf->cs&3) == 0){
80106117:	e8 b4 d6 ff ff       	call   801037d0 <myproc>
8010611c:	85 c0                	test   %eax,%eax
8010611e:	0f 84 d0 01 00 00    	je     801062f4 <trap+0x224>
80106124:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106128:	0f 84 c6 01 00 00    	je     801062f4 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010612e:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106131:	8b 57 38             	mov    0x38(%edi),%edx
80106134:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106137:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010613a:	e8 71 d6 ff ff       	call   801037b0 <cpuid>
8010613f:	8b 77 34             	mov    0x34(%edi),%esi
80106142:	8b 5f 30             	mov    0x30(%edi),%ebx
80106145:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106148:	e8 83 d6 ff ff       	call   801037d0 <myproc>
8010614d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106150:	e8 7b d6 ff ff       	call   801037d0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106155:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106158:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010615b:	51                   	push   %ecx
8010615c:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010615d:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106160:	ff 75 e4             	pushl  -0x1c(%ebp)
80106163:	56                   	push   %esi
80106164:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106165:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106168:	52                   	push   %edx
80106169:	ff 70 10             	pushl  0x10(%eax)
8010616c:	68 dc 81 10 80       	push   $0x801081dc
80106171:	e8 ea a4 ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106176:	83 c4 20             	add    $0x20,%esp
80106179:	e8 52 d6 ff ff       	call   801037d0 <myproc>
8010617e:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106185:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106188:	e8 43 d6 ff ff       	call   801037d0 <myproc>
8010618d:	85 c0                	test   %eax,%eax
8010618f:	74 0c                	je     8010619d <trap+0xcd>
80106191:	e8 3a d6 ff ff       	call   801037d0 <myproc>
80106196:	8b 50 24             	mov    0x24(%eax),%edx
80106199:	85 d2                	test   %edx,%edx
8010619b:	75 43                	jne    801061e0 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010619d:	e8 2e d6 ff ff       	call   801037d0 <myproc>
801061a2:	85 c0                	test   %eax,%eax
801061a4:	74 0b                	je     801061b1 <trap+0xe1>
801061a6:	e8 25 d6 ff ff       	call   801037d0 <myproc>
801061ab:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801061af:	74 47                	je     801061f8 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061b1:	e8 1a d6 ff ff       	call   801037d0 <myproc>
801061b6:	85 c0                	test   %eax,%eax
801061b8:	74 1d                	je     801061d7 <trap+0x107>
801061ba:	e8 11 d6 ff ff       	call   801037d0 <myproc>
801061bf:	8b 40 24             	mov    0x24(%eax),%eax
801061c2:	85 c0                	test   %eax,%eax
801061c4:	74 11                	je     801061d7 <trap+0x107>
801061c6:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801061ca:	83 e0 03             	and    $0x3,%eax
801061cd:	66 83 f8 03          	cmp    $0x3,%ax
801061d1:	0f 84 d2 00 00 00    	je     801062a9 <trap+0x1d9>
    exit();
}
801061d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061da:	5b                   	pop    %ebx
801061db:	5e                   	pop    %esi
801061dc:	5f                   	pop    %edi
801061dd:	5d                   	pop    %ebp
801061de:	c3                   	ret    
801061df:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061e0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801061e4:	83 e0 03             	and    $0x3,%eax
801061e7:	66 83 f8 03          	cmp    $0x3,%ax
801061eb:	75 b0                	jne    8010619d <trap+0xcd>
    exit();
801061ed:	e8 0e da ff ff       	call   80103c00 <exit>
801061f2:	eb a9                	jmp    8010619d <trap+0xcd>
801061f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801061f8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801061fc:	75 b3                	jne    801061b1 <trap+0xe1>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
801061fe:	e8 2d db ff ff       	call   80103d30 <yield>
80106203:	eb ac                	jmp    801061b1 <trap+0xe1>
80106205:	8d 76 00             	lea    0x0(%esi),%esi
  trapValCounters[tf->trapno]++;
  countTrap++;

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106208:	e8 a3 d5 ff ff       	call   801037b0 <cpuid>
8010620d:	85 c0                	test   %eax,%eax
8010620f:	0f 84 ab 00 00 00    	je     801062c0 <trap+0x1f0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106215:	e8 46 c5 ff ff       	call   80102760 <lapiceoi>
    break;
8010621a:	e9 69 ff ff ff       	jmp    80106188 <trap+0xb8>
8010621f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106220:	e8 fb c3 ff ff       	call   80102620 <kbdintr>
    lapiceoi();
80106225:	e8 36 c5 ff ff       	call   80102760 <lapiceoi>
    break;
8010622a:	e9 59 ff ff ff       	jmp    80106188 <trap+0xb8>
8010622f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106230:	e8 5b 02 00 00       	call   80106490 <uartintr>
    lapiceoi();
80106235:	e8 26 c5 ff ff       	call   80102760 <lapiceoi>
    break;
8010623a:	e9 49 ff ff ff       	jmp    80106188 <trap+0xb8>
8010623f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106240:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106244:	8b 77 38             	mov    0x38(%edi),%esi
80106247:	e8 64 d5 ff ff       	call   801037b0 <cpuid>
8010624c:	56                   	push   %esi
8010624d:	53                   	push   %ebx
8010624e:	50                   	push   %eax
8010624f:	68 84 81 10 80       	push   $0x80108184
80106254:	e8 07 a4 ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106259:	e8 02 c5 ff ff       	call   80102760 <lapiceoi>
    break;
8010625e:	83 c4 10             	add    $0x10,%esp
80106261:	e9 22 ff ff ff       	jmp    80106188 <trap+0xb8>
80106266:	8d 76 00             	lea    0x0(%esi),%esi
80106269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106270:	e8 2b be ff ff       	call   801020a0 <ideintr>
80106275:	eb 9e                	jmp    80106215 <trap+0x145>
80106277:	89 f6                	mov    %esi,%esi
80106279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106280:	e8 4b d5 ff ff       	call   801037d0 <myproc>
80106285:	8b 58 24             	mov    0x24(%eax),%ebx
80106288:	85 db                	test   %ebx,%ebx
8010628a:	75 2c                	jne    801062b8 <trap+0x1e8>
      exit();
    myproc()->tf = tf;
8010628c:	e8 3f d5 ff ff       	call   801037d0 <myproc>
80106291:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106294:	e8 b7 e7 ff ff       	call   80104a50 <syscall>
    if(myproc()->killed)
80106299:	e8 32 d5 ff ff       	call   801037d0 <myproc>
8010629e:	8b 48 24             	mov    0x24(%eax),%ecx
801062a1:	85 c9                	test   %ecx,%ecx
801062a3:	0f 84 2e ff ff ff    	je     801061d7 <trap+0x107>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801062a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062ac:	5b                   	pop    %ebx
801062ad:	5e                   	pop    %esi
801062ae:	5f                   	pop    %edi
801062af:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
801062b0:	e9 4b d9 ff ff       	jmp    80103c00 <exit>
801062b5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
801062b8:	e8 43 d9 ff ff       	call   80103c00 <exit>
801062bd:	eb cd                	jmp    8010628c <trap+0x1bc>
801062bf:	90                   	nop
  countTrap++;

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801062c0:	83 ec 0c             	sub    $0xc,%esp
801062c3:	68 80 61 11 80       	push   $0x80116180
801062c8:	e8 b3 e0 ff ff       	call   80104380 <acquire>
      ticks++;
      wakeup(&ticks);
801062cd:	c7 04 24 c0 69 11 80 	movl   $0x801169c0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
801062d4:	83 05 c0 69 11 80 01 	addl   $0x1,0x801169c0
      wakeup(&ticks);
801062db:	e8 60 dc ff ff       	call   80103f40 <wakeup>
      release(&tickslock);
801062e0:	c7 04 24 80 61 11 80 	movl   $0x80116180,(%esp)
801062e7:	e8 44 e1 ff ff       	call   80104430 <release>
801062ec:	83 c4 10             	add    $0x10,%esp
801062ef:	e9 21 ff ff ff       	jmp    80106215 <trap+0x145>
801062f4:	0f 20 d6             	mov    %cr2,%esi
  //PAGEBREAK: 13
  default:
    unkownTrap++;
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062f7:	8b 5f 38             	mov    0x38(%edi),%ebx
801062fa:	e8 b1 d4 ff ff       	call   801037b0 <cpuid>
801062ff:	83 ec 0c             	sub    $0xc,%esp
80106302:	56                   	push   %esi
80106303:	53                   	push   %ebx
80106304:	50                   	push   %eax
80106305:	ff 77 30             	pushl  0x30(%edi)
80106308:	68 a8 81 10 80       	push   $0x801081a8
8010630d:	e8 4e a3 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80106312:	83 c4 14             	add    $0x14,%esp
80106315:	68 7c 81 10 80       	push   $0x8010817c
8010631a:	e8 51 a0 ff ff       	call   80100370 <panic>
8010631f:	90                   	nop

80106320 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106320:	a1 c4 ba 10 80       	mov    0x8010bac4,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106325:	55                   	push   %ebp
80106326:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106328:	85 c0                	test   %eax,%eax
8010632a:	74 1c                	je     80106348 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010632c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106331:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106332:	a8 01                	test   $0x1,%al
80106334:	74 12                	je     80106348 <uartgetc+0x28>
80106336:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010633b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010633c:	0f b6 c0             	movzbl %al,%eax
}
8010633f:	5d                   	pop    %ebp
80106340:	c3                   	ret    
80106341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010634d:	5d                   	pop    %ebp
8010634e:	c3                   	ret    
8010634f:	90                   	nop

80106350 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	57                   	push   %edi
80106354:	56                   	push   %esi
80106355:	53                   	push   %ebx
80106356:	89 c7                	mov    %eax,%edi
80106358:	bb 80 00 00 00       	mov    $0x80,%ebx
8010635d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106362:	83 ec 0c             	sub    $0xc,%esp
80106365:	eb 1b                	jmp    80106382 <uartputc.part.0+0x32>
80106367:	89 f6                	mov    %esi,%esi
80106369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106370:	83 ec 0c             	sub    $0xc,%esp
80106373:	6a 0a                	push   $0xa
80106375:	e8 06 c4 ff ff       	call   80102780 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010637a:	83 c4 10             	add    $0x10,%esp
8010637d:	83 eb 01             	sub    $0x1,%ebx
80106380:	74 07                	je     80106389 <uartputc.part.0+0x39>
80106382:	89 f2                	mov    %esi,%edx
80106384:	ec                   	in     (%dx),%al
80106385:	a8 20                	test   $0x20,%al
80106387:	74 e7                	je     80106370 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106389:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010638e:	89 f8                	mov    %edi,%eax
80106390:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80106391:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106394:	5b                   	pop    %ebx
80106395:	5e                   	pop    %esi
80106396:	5f                   	pop    %edi
80106397:	5d                   	pop    %ebp
80106398:	c3                   	ret    
80106399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801063a0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801063a0:	55                   	push   %ebp
801063a1:	31 c9                	xor    %ecx,%ecx
801063a3:	89 c8                	mov    %ecx,%eax
801063a5:	89 e5                	mov    %esp,%ebp
801063a7:	57                   	push   %edi
801063a8:	56                   	push   %esi
801063a9:	53                   	push   %ebx
801063aa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801063af:	89 da                	mov    %ebx,%edx
801063b1:	83 ec 0c             	sub    $0xc,%esp
801063b4:	ee                   	out    %al,(%dx)
801063b5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801063ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801063bf:	89 fa                	mov    %edi,%edx
801063c1:	ee                   	out    %al,(%dx)
801063c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801063c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063cc:	ee                   	out    %al,(%dx)
801063cd:	be f9 03 00 00       	mov    $0x3f9,%esi
801063d2:	89 c8                	mov    %ecx,%eax
801063d4:	89 f2                	mov    %esi,%edx
801063d6:	ee                   	out    %al,(%dx)
801063d7:	b8 03 00 00 00       	mov    $0x3,%eax
801063dc:	89 fa                	mov    %edi,%edx
801063de:	ee                   	out    %al,(%dx)
801063df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801063e4:	89 c8                	mov    %ecx,%eax
801063e6:	ee                   	out    %al,(%dx)
801063e7:	b8 01 00 00 00       	mov    $0x1,%eax
801063ec:	89 f2                	mov    %esi,%edx
801063ee:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801063ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063f4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801063f5:	3c ff                	cmp    $0xff,%al
801063f7:	74 5a                	je     80106453 <uartinit+0xb3>
    return;
  uart = 1;
801063f9:	c7 05 c4 ba 10 80 01 	movl   $0x1,0x8010bac4
80106400:	00 00 00 
80106403:	89 da                	mov    %ebx,%edx
80106405:	ec                   	in     (%dx),%al
80106406:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010640b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
8010640c:	83 ec 08             	sub    $0x8,%esp
8010640f:	bb a0 82 10 80       	mov    $0x801082a0,%ebx
80106414:	6a 00                	push   $0x0
80106416:	6a 04                	push   $0x4
80106418:	e8 d3 be ff ff       	call   801022f0 <ioapicenable>
8010641d:	83 c4 10             	add    $0x10,%esp
80106420:	b8 78 00 00 00       	mov    $0x78,%eax
80106425:	eb 13                	jmp    8010643a <uartinit+0x9a>
80106427:	89 f6                	mov    %esi,%esi
80106429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106430:	83 c3 01             	add    $0x1,%ebx
80106433:	0f be 03             	movsbl (%ebx),%eax
80106436:	84 c0                	test   %al,%al
80106438:	74 19                	je     80106453 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010643a:	8b 15 c4 ba 10 80    	mov    0x8010bac4,%edx
80106440:	85 d2                	test   %edx,%edx
80106442:	74 ec                	je     80106430 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106444:	83 c3 01             	add    $0x1,%ebx
80106447:	e8 04 ff ff ff       	call   80106350 <uartputc.part.0>
8010644c:	0f be 03             	movsbl (%ebx),%eax
8010644f:	84 c0                	test   %al,%al
80106451:	75 e7                	jne    8010643a <uartinit+0x9a>
    uartputc(*p);
}
80106453:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106456:	5b                   	pop    %ebx
80106457:	5e                   	pop    %esi
80106458:	5f                   	pop    %edi
80106459:	5d                   	pop    %ebp
8010645a:	c3                   	ret    
8010645b:	90                   	nop
8010645c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106460 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106460:	8b 15 c4 ba 10 80    	mov    0x8010bac4,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106466:	55                   	push   %ebp
80106467:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106469:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010646b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010646e:	74 10                	je     80106480 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106470:	5d                   	pop    %ebp
80106471:	e9 da fe ff ff       	jmp    80106350 <uartputc.part.0>
80106476:	8d 76 00             	lea    0x0(%esi),%esi
80106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106480:	5d                   	pop    %ebp
80106481:	c3                   	ret    
80106482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106490 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106496:	68 20 63 10 80       	push   $0x80106320
8010649b:	e8 50 a3 ff ff       	call   801007f0 <consoleintr>
}
801064a0:	83 c4 10             	add    $0x10,%esp
801064a3:	c9                   	leave  
801064a4:	c3                   	ret    

801064a5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801064a5:	6a 00                	push   $0x0
  pushl $0
801064a7:	6a 00                	push   $0x0
  jmp alltraps
801064a9:	e9 2c fb ff ff       	jmp    80105fda <alltraps>

801064ae <vector1>:
.globl vector1
vector1:
  pushl $0
801064ae:	6a 00                	push   $0x0
  pushl $1
801064b0:	6a 01                	push   $0x1
  jmp alltraps
801064b2:	e9 23 fb ff ff       	jmp    80105fda <alltraps>

801064b7 <vector2>:
.globl vector2
vector2:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $2
801064b9:	6a 02                	push   $0x2
  jmp alltraps
801064bb:	e9 1a fb ff ff       	jmp    80105fda <alltraps>

801064c0 <vector3>:
.globl vector3
vector3:
  pushl $0
801064c0:	6a 00                	push   $0x0
  pushl $3
801064c2:	6a 03                	push   $0x3
  jmp alltraps
801064c4:	e9 11 fb ff ff       	jmp    80105fda <alltraps>

801064c9 <vector4>:
.globl vector4
vector4:
  pushl $0
801064c9:	6a 00                	push   $0x0
  pushl $4
801064cb:	6a 04                	push   $0x4
  jmp alltraps
801064cd:	e9 08 fb ff ff       	jmp    80105fda <alltraps>

801064d2 <vector5>:
.globl vector5
vector5:
  pushl $0
801064d2:	6a 00                	push   $0x0
  pushl $5
801064d4:	6a 05                	push   $0x5
  jmp alltraps
801064d6:	e9 ff fa ff ff       	jmp    80105fda <alltraps>

801064db <vector6>:
.globl vector6
vector6:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $6
801064dd:	6a 06                	push   $0x6
  jmp alltraps
801064df:	e9 f6 fa ff ff       	jmp    80105fda <alltraps>

801064e4 <vector7>:
.globl vector7
vector7:
  pushl $0
801064e4:	6a 00                	push   $0x0
  pushl $7
801064e6:	6a 07                	push   $0x7
  jmp alltraps
801064e8:	e9 ed fa ff ff       	jmp    80105fda <alltraps>

801064ed <vector8>:
.globl vector8
vector8:
  pushl $8
801064ed:	6a 08                	push   $0x8
  jmp alltraps
801064ef:	e9 e6 fa ff ff       	jmp    80105fda <alltraps>

801064f4 <vector9>:
.globl vector9
vector9:
  pushl $0
801064f4:	6a 00                	push   $0x0
  pushl $9
801064f6:	6a 09                	push   $0x9
  jmp alltraps
801064f8:	e9 dd fa ff ff       	jmp    80105fda <alltraps>

801064fd <vector10>:
.globl vector10
vector10:
  pushl $10
801064fd:	6a 0a                	push   $0xa
  jmp alltraps
801064ff:	e9 d6 fa ff ff       	jmp    80105fda <alltraps>

80106504 <vector11>:
.globl vector11
vector11:
  pushl $11
80106504:	6a 0b                	push   $0xb
  jmp alltraps
80106506:	e9 cf fa ff ff       	jmp    80105fda <alltraps>

8010650b <vector12>:
.globl vector12
vector12:
  pushl $12
8010650b:	6a 0c                	push   $0xc
  jmp alltraps
8010650d:	e9 c8 fa ff ff       	jmp    80105fda <alltraps>

80106512 <vector13>:
.globl vector13
vector13:
  pushl $13
80106512:	6a 0d                	push   $0xd
  jmp alltraps
80106514:	e9 c1 fa ff ff       	jmp    80105fda <alltraps>

80106519 <vector14>:
.globl vector14
vector14:
  pushl $14
80106519:	6a 0e                	push   $0xe
  jmp alltraps
8010651b:	e9 ba fa ff ff       	jmp    80105fda <alltraps>

80106520 <vector15>:
.globl vector15
vector15:
  pushl $0
80106520:	6a 00                	push   $0x0
  pushl $15
80106522:	6a 0f                	push   $0xf
  jmp alltraps
80106524:	e9 b1 fa ff ff       	jmp    80105fda <alltraps>

80106529 <vector16>:
.globl vector16
vector16:
  pushl $0
80106529:	6a 00                	push   $0x0
  pushl $16
8010652b:	6a 10                	push   $0x10
  jmp alltraps
8010652d:	e9 a8 fa ff ff       	jmp    80105fda <alltraps>

80106532 <vector17>:
.globl vector17
vector17:
  pushl $17
80106532:	6a 11                	push   $0x11
  jmp alltraps
80106534:	e9 a1 fa ff ff       	jmp    80105fda <alltraps>

80106539 <vector18>:
.globl vector18
vector18:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $18
8010653b:	6a 12                	push   $0x12
  jmp alltraps
8010653d:	e9 98 fa ff ff       	jmp    80105fda <alltraps>

80106542 <vector19>:
.globl vector19
vector19:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $19
80106544:	6a 13                	push   $0x13
  jmp alltraps
80106546:	e9 8f fa ff ff       	jmp    80105fda <alltraps>

8010654b <vector20>:
.globl vector20
vector20:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $20
8010654d:	6a 14                	push   $0x14
  jmp alltraps
8010654f:	e9 86 fa ff ff       	jmp    80105fda <alltraps>

80106554 <vector21>:
.globl vector21
vector21:
  pushl $0
80106554:	6a 00                	push   $0x0
  pushl $21
80106556:	6a 15                	push   $0x15
  jmp alltraps
80106558:	e9 7d fa ff ff       	jmp    80105fda <alltraps>

8010655d <vector22>:
.globl vector22
vector22:
  pushl $0
8010655d:	6a 00                	push   $0x0
  pushl $22
8010655f:	6a 16                	push   $0x16
  jmp alltraps
80106561:	e9 74 fa ff ff       	jmp    80105fda <alltraps>

80106566 <vector23>:
.globl vector23
vector23:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $23
80106568:	6a 17                	push   $0x17
  jmp alltraps
8010656a:	e9 6b fa ff ff       	jmp    80105fda <alltraps>

8010656f <vector24>:
.globl vector24
vector24:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $24
80106571:	6a 18                	push   $0x18
  jmp alltraps
80106573:	e9 62 fa ff ff       	jmp    80105fda <alltraps>

80106578 <vector25>:
.globl vector25
vector25:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $25
8010657a:	6a 19                	push   $0x19
  jmp alltraps
8010657c:	e9 59 fa ff ff       	jmp    80105fda <alltraps>

80106581 <vector26>:
.globl vector26
vector26:
  pushl $0
80106581:	6a 00                	push   $0x0
  pushl $26
80106583:	6a 1a                	push   $0x1a
  jmp alltraps
80106585:	e9 50 fa ff ff       	jmp    80105fda <alltraps>

8010658a <vector27>:
.globl vector27
vector27:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $27
8010658c:	6a 1b                	push   $0x1b
  jmp alltraps
8010658e:	e9 47 fa ff ff       	jmp    80105fda <alltraps>

80106593 <vector28>:
.globl vector28
vector28:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $28
80106595:	6a 1c                	push   $0x1c
  jmp alltraps
80106597:	e9 3e fa ff ff       	jmp    80105fda <alltraps>

8010659c <vector29>:
.globl vector29
vector29:
  pushl $0
8010659c:	6a 00                	push   $0x0
  pushl $29
8010659e:	6a 1d                	push   $0x1d
  jmp alltraps
801065a0:	e9 35 fa ff ff       	jmp    80105fda <alltraps>

801065a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801065a5:	6a 00                	push   $0x0
  pushl $30
801065a7:	6a 1e                	push   $0x1e
  jmp alltraps
801065a9:	e9 2c fa ff ff       	jmp    80105fda <alltraps>

801065ae <vector31>:
.globl vector31
vector31:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $31
801065b0:	6a 1f                	push   $0x1f
  jmp alltraps
801065b2:	e9 23 fa ff ff       	jmp    80105fda <alltraps>

801065b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $32
801065b9:	6a 20                	push   $0x20
  jmp alltraps
801065bb:	e9 1a fa ff ff       	jmp    80105fda <alltraps>

801065c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801065c0:	6a 00                	push   $0x0
  pushl $33
801065c2:	6a 21                	push   $0x21
  jmp alltraps
801065c4:	e9 11 fa ff ff       	jmp    80105fda <alltraps>

801065c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801065c9:	6a 00                	push   $0x0
  pushl $34
801065cb:	6a 22                	push   $0x22
  jmp alltraps
801065cd:	e9 08 fa ff ff       	jmp    80105fda <alltraps>

801065d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801065d2:	6a 00                	push   $0x0
  pushl $35
801065d4:	6a 23                	push   $0x23
  jmp alltraps
801065d6:	e9 ff f9 ff ff       	jmp    80105fda <alltraps>

801065db <vector36>:
.globl vector36
vector36:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $36
801065dd:	6a 24                	push   $0x24
  jmp alltraps
801065df:	e9 f6 f9 ff ff       	jmp    80105fda <alltraps>

801065e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801065e4:	6a 00                	push   $0x0
  pushl $37
801065e6:	6a 25                	push   $0x25
  jmp alltraps
801065e8:	e9 ed f9 ff ff       	jmp    80105fda <alltraps>

801065ed <vector38>:
.globl vector38
vector38:
  pushl $0
801065ed:	6a 00                	push   $0x0
  pushl $38
801065ef:	6a 26                	push   $0x26
  jmp alltraps
801065f1:	e9 e4 f9 ff ff       	jmp    80105fda <alltraps>

801065f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801065f6:	6a 00                	push   $0x0
  pushl $39
801065f8:	6a 27                	push   $0x27
  jmp alltraps
801065fa:	e9 db f9 ff ff       	jmp    80105fda <alltraps>

801065ff <vector40>:
.globl vector40
vector40:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $40
80106601:	6a 28                	push   $0x28
  jmp alltraps
80106603:	e9 d2 f9 ff ff       	jmp    80105fda <alltraps>

80106608 <vector41>:
.globl vector41
vector41:
  pushl $0
80106608:	6a 00                	push   $0x0
  pushl $41
8010660a:	6a 29                	push   $0x29
  jmp alltraps
8010660c:	e9 c9 f9 ff ff       	jmp    80105fda <alltraps>

80106611 <vector42>:
.globl vector42
vector42:
  pushl $0
80106611:	6a 00                	push   $0x0
  pushl $42
80106613:	6a 2a                	push   $0x2a
  jmp alltraps
80106615:	e9 c0 f9 ff ff       	jmp    80105fda <alltraps>

8010661a <vector43>:
.globl vector43
vector43:
  pushl $0
8010661a:	6a 00                	push   $0x0
  pushl $43
8010661c:	6a 2b                	push   $0x2b
  jmp alltraps
8010661e:	e9 b7 f9 ff ff       	jmp    80105fda <alltraps>

80106623 <vector44>:
.globl vector44
vector44:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $44
80106625:	6a 2c                	push   $0x2c
  jmp alltraps
80106627:	e9 ae f9 ff ff       	jmp    80105fda <alltraps>

8010662c <vector45>:
.globl vector45
vector45:
  pushl $0
8010662c:	6a 00                	push   $0x0
  pushl $45
8010662e:	6a 2d                	push   $0x2d
  jmp alltraps
80106630:	e9 a5 f9 ff ff       	jmp    80105fda <alltraps>

80106635 <vector46>:
.globl vector46
vector46:
  pushl $0
80106635:	6a 00                	push   $0x0
  pushl $46
80106637:	6a 2e                	push   $0x2e
  jmp alltraps
80106639:	e9 9c f9 ff ff       	jmp    80105fda <alltraps>

8010663e <vector47>:
.globl vector47
vector47:
  pushl $0
8010663e:	6a 00                	push   $0x0
  pushl $47
80106640:	6a 2f                	push   $0x2f
  jmp alltraps
80106642:	e9 93 f9 ff ff       	jmp    80105fda <alltraps>

80106647 <vector48>:
.globl vector48
vector48:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $48
80106649:	6a 30                	push   $0x30
  jmp alltraps
8010664b:	e9 8a f9 ff ff       	jmp    80105fda <alltraps>

80106650 <vector49>:
.globl vector49
vector49:
  pushl $0
80106650:	6a 00                	push   $0x0
  pushl $49
80106652:	6a 31                	push   $0x31
  jmp alltraps
80106654:	e9 81 f9 ff ff       	jmp    80105fda <alltraps>

80106659 <vector50>:
.globl vector50
vector50:
  pushl $0
80106659:	6a 00                	push   $0x0
  pushl $50
8010665b:	6a 32                	push   $0x32
  jmp alltraps
8010665d:	e9 78 f9 ff ff       	jmp    80105fda <alltraps>

80106662 <vector51>:
.globl vector51
vector51:
  pushl $0
80106662:	6a 00                	push   $0x0
  pushl $51
80106664:	6a 33                	push   $0x33
  jmp alltraps
80106666:	e9 6f f9 ff ff       	jmp    80105fda <alltraps>

8010666b <vector52>:
.globl vector52
vector52:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $52
8010666d:	6a 34                	push   $0x34
  jmp alltraps
8010666f:	e9 66 f9 ff ff       	jmp    80105fda <alltraps>

80106674 <vector53>:
.globl vector53
vector53:
  pushl $0
80106674:	6a 00                	push   $0x0
  pushl $53
80106676:	6a 35                	push   $0x35
  jmp alltraps
80106678:	e9 5d f9 ff ff       	jmp    80105fda <alltraps>

8010667d <vector54>:
.globl vector54
vector54:
  pushl $0
8010667d:	6a 00                	push   $0x0
  pushl $54
8010667f:	6a 36                	push   $0x36
  jmp alltraps
80106681:	e9 54 f9 ff ff       	jmp    80105fda <alltraps>

80106686 <vector55>:
.globl vector55
vector55:
  pushl $0
80106686:	6a 00                	push   $0x0
  pushl $55
80106688:	6a 37                	push   $0x37
  jmp alltraps
8010668a:	e9 4b f9 ff ff       	jmp    80105fda <alltraps>

8010668f <vector56>:
.globl vector56
vector56:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $56
80106691:	6a 38                	push   $0x38
  jmp alltraps
80106693:	e9 42 f9 ff ff       	jmp    80105fda <alltraps>

80106698 <vector57>:
.globl vector57
vector57:
  pushl $0
80106698:	6a 00                	push   $0x0
  pushl $57
8010669a:	6a 39                	push   $0x39
  jmp alltraps
8010669c:	e9 39 f9 ff ff       	jmp    80105fda <alltraps>

801066a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801066a1:	6a 00                	push   $0x0
  pushl $58
801066a3:	6a 3a                	push   $0x3a
  jmp alltraps
801066a5:	e9 30 f9 ff ff       	jmp    80105fda <alltraps>

801066aa <vector59>:
.globl vector59
vector59:
  pushl $0
801066aa:	6a 00                	push   $0x0
  pushl $59
801066ac:	6a 3b                	push   $0x3b
  jmp alltraps
801066ae:	e9 27 f9 ff ff       	jmp    80105fda <alltraps>

801066b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $60
801066b5:	6a 3c                	push   $0x3c
  jmp alltraps
801066b7:	e9 1e f9 ff ff       	jmp    80105fda <alltraps>

801066bc <vector61>:
.globl vector61
vector61:
  pushl $0
801066bc:	6a 00                	push   $0x0
  pushl $61
801066be:	6a 3d                	push   $0x3d
  jmp alltraps
801066c0:	e9 15 f9 ff ff       	jmp    80105fda <alltraps>

801066c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801066c5:	6a 00                	push   $0x0
  pushl $62
801066c7:	6a 3e                	push   $0x3e
  jmp alltraps
801066c9:	e9 0c f9 ff ff       	jmp    80105fda <alltraps>

801066ce <vector63>:
.globl vector63
vector63:
  pushl $0
801066ce:	6a 00                	push   $0x0
  pushl $63
801066d0:	6a 3f                	push   $0x3f
  jmp alltraps
801066d2:	e9 03 f9 ff ff       	jmp    80105fda <alltraps>

801066d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $64
801066d9:	6a 40                	push   $0x40
  jmp alltraps
801066db:	e9 fa f8 ff ff       	jmp    80105fda <alltraps>

801066e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801066e0:	6a 00                	push   $0x0
  pushl $65
801066e2:	6a 41                	push   $0x41
  jmp alltraps
801066e4:	e9 f1 f8 ff ff       	jmp    80105fda <alltraps>

801066e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801066e9:	6a 00                	push   $0x0
  pushl $66
801066eb:	6a 42                	push   $0x42
  jmp alltraps
801066ed:	e9 e8 f8 ff ff       	jmp    80105fda <alltraps>

801066f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801066f2:	6a 00                	push   $0x0
  pushl $67
801066f4:	6a 43                	push   $0x43
  jmp alltraps
801066f6:	e9 df f8 ff ff       	jmp    80105fda <alltraps>

801066fb <vector68>:
.globl vector68
vector68:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $68
801066fd:	6a 44                	push   $0x44
  jmp alltraps
801066ff:	e9 d6 f8 ff ff       	jmp    80105fda <alltraps>

80106704 <vector69>:
.globl vector69
vector69:
  pushl $0
80106704:	6a 00                	push   $0x0
  pushl $69
80106706:	6a 45                	push   $0x45
  jmp alltraps
80106708:	e9 cd f8 ff ff       	jmp    80105fda <alltraps>

8010670d <vector70>:
.globl vector70
vector70:
  pushl $0
8010670d:	6a 00                	push   $0x0
  pushl $70
8010670f:	6a 46                	push   $0x46
  jmp alltraps
80106711:	e9 c4 f8 ff ff       	jmp    80105fda <alltraps>

80106716 <vector71>:
.globl vector71
vector71:
  pushl $0
80106716:	6a 00                	push   $0x0
  pushl $71
80106718:	6a 47                	push   $0x47
  jmp alltraps
8010671a:	e9 bb f8 ff ff       	jmp    80105fda <alltraps>

8010671f <vector72>:
.globl vector72
vector72:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $72
80106721:	6a 48                	push   $0x48
  jmp alltraps
80106723:	e9 b2 f8 ff ff       	jmp    80105fda <alltraps>

80106728 <vector73>:
.globl vector73
vector73:
  pushl $0
80106728:	6a 00                	push   $0x0
  pushl $73
8010672a:	6a 49                	push   $0x49
  jmp alltraps
8010672c:	e9 a9 f8 ff ff       	jmp    80105fda <alltraps>

80106731 <vector74>:
.globl vector74
vector74:
  pushl $0
80106731:	6a 00                	push   $0x0
  pushl $74
80106733:	6a 4a                	push   $0x4a
  jmp alltraps
80106735:	e9 a0 f8 ff ff       	jmp    80105fda <alltraps>

8010673a <vector75>:
.globl vector75
vector75:
  pushl $0
8010673a:	6a 00                	push   $0x0
  pushl $75
8010673c:	6a 4b                	push   $0x4b
  jmp alltraps
8010673e:	e9 97 f8 ff ff       	jmp    80105fda <alltraps>

80106743 <vector76>:
.globl vector76
vector76:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $76
80106745:	6a 4c                	push   $0x4c
  jmp alltraps
80106747:	e9 8e f8 ff ff       	jmp    80105fda <alltraps>

8010674c <vector77>:
.globl vector77
vector77:
  pushl $0
8010674c:	6a 00                	push   $0x0
  pushl $77
8010674e:	6a 4d                	push   $0x4d
  jmp alltraps
80106750:	e9 85 f8 ff ff       	jmp    80105fda <alltraps>

80106755 <vector78>:
.globl vector78
vector78:
  pushl $0
80106755:	6a 00                	push   $0x0
  pushl $78
80106757:	6a 4e                	push   $0x4e
  jmp alltraps
80106759:	e9 7c f8 ff ff       	jmp    80105fda <alltraps>

8010675e <vector79>:
.globl vector79
vector79:
  pushl $0
8010675e:	6a 00                	push   $0x0
  pushl $79
80106760:	6a 4f                	push   $0x4f
  jmp alltraps
80106762:	e9 73 f8 ff ff       	jmp    80105fda <alltraps>

80106767 <vector80>:
.globl vector80
vector80:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $80
80106769:	6a 50                	push   $0x50
  jmp alltraps
8010676b:	e9 6a f8 ff ff       	jmp    80105fda <alltraps>

80106770 <vector81>:
.globl vector81
vector81:
  pushl $0
80106770:	6a 00                	push   $0x0
  pushl $81
80106772:	6a 51                	push   $0x51
  jmp alltraps
80106774:	e9 61 f8 ff ff       	jmp    80105fda <alltraps>

80106779 <vector82>:
.globl vector82
vector82:
  pushl $0
80106779:	6a 00                	push   $0x0
  pushl $82
8010677b:	6a 52                	push   $0x52
  jmp alltraps
8010677d:	e9 58 f8 ff ff       	jmp    80105fda <alltraps>

80106782 <vector83>:
.globl vector83
vector83:
  pushl $0
80106782:	6a 00                	push   $0x0
  pushl $83
80106784:	6a 53                	push   $0x53
  jmp alltraps
80106786:	e9 4f f8 ff ff       	jmp    80105fda <alltraps>

8010678b <vector84>:
.globl vector84
vector84:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $84
8010678d:	6a 54                	push   $0x54
  jmp alltraps
8010678f:	e9 46 f8 ff ff       	jmp    80105fda <alltraps>

80106794 <vector85>:
.globl vector85
vector85:
  pushl $0
80106794:	6a 00                	push   $0x0
  pushl $85
80106796:	6a 55                	push   $0x55
  jmp alltraps
80106798:	e9 3d f8 ff ff       	jmp    80105fda <alltraps>

8010679d <vector86>:
.globl vector86
vector86:
  pushl $0
8010679d:	6a 00                	push   $0x0
  pushl $86
8010679f:	6a 56                	push   $0x56
  jmp alltraps
801067a1:	e9 34 f8 ff ff       	jmp    80105fda <alltraps>

801067a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801067a6:	6a 00                	push   $0x0
  pushl $87
801067a8:	6a 57                	push   $0x57
  jmp alltraps
801067aa:	e9 2b f8 ff ff       	jmp    80105fda <alltraps>

801067af <vector88>:
.globl vector88
vector88:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $88
801067b1:	6a 58                	push   $0x58
  jmp alltraps
801067b3:	e9 22 f8 ff ff       	jmp    80105fda <alltraps>

801067b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801067b8:	6a 00                	push   $0x0
  pushl $89
801067ba:	6a 59                	push   $0x59
  jmp alltraps
801067bc:	e9 19 f8 ff ff       	jmp    80105fda <alltraps>

801067c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801067c1:	6a 00                	push   $0x0
  pushl $90
801067c3:	6a 5a                	push   $0x5a
  jmp alltraps
801067c5:	e9 10 f8 ff ff       	jmp    80105fda <alltraps>

801067ca <vector91>:
.globl vector91
vector91:
  pushl $0
801067ca:	6a 00                	push   $0x0
  pushl $91
801067cc:	6a 5b                	push   $0x5b
  jmp alltraps
801067ce:	e9 07 f8 ff ff       	jmp    80105fda <alltraps>

801067d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $92
801067d5:	6a 5c                	push   $0x5c
  jmp alltraps
801067d7:	e9 fe f7 ff ff       	jmp    80105fda <alltraps>

801067dc <vector93>:
.globl vector93
vector93:
  pushl $0
801067dc:	6a 00                	push   $0x0
  pushl $93
801067de:	6a 5d                	push   $0x5d
  jmp alltraps
801067e0:	e9 f5 f7 ff ff       	jmp    80105fda <alltraps>

801067e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801067e5:	6a 00                	push   $0x0
  pushl $94
801067e7:	6a 5e                	push   $0x5e
  jmp alltraps
801067e9:	e9 ec f7 ff ff       	jmp    80105fda <alltraps>

801067ee <vector95>:
.globl vector95
vector95:
  pushl $0
801067ee:	6a 00                	push   $0x0
  pushl $95
801067f0:	6a 5f                	push   $0x5f
  jmp alltraps
801067f2:	e9 e3 f7 ff ff       	jmp    80105fda <alltraps>

801067f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $96
801067f9:	6a 60                	push   $0x60
  jmp alltraps
801067fb:	e9 da f7 ff ff       	jmp    80105fda <alltraps>

80106800 <vector97>:
.globl vector97
vector97:
  pushl $0
80106800:	6a 00                	push   $0x0
  pushl $97
80106802:	6a 61                	push   $0x61
  jmp alltraps
80106804:	e9 d1 f7 ff ff       	jmp    80105fda <alltraps>

80106809 <vector98>:
.globl vector98
vector98:
  pushl $0
80106809:	6a 00                	push   $0x0
  pushl $98
8010680b:	6a 62                	push   $0x62
  jmp alltraps
8010680d:	e9 c8 f7 ff ff       	jmp    80105fda <alltraps>

80106812 <vector99>:
.globl vector99
vector99:
  pushl $0
80106812:	6a 00                	push   $0x0
  pushl $99
80106814:	6a 63                	push   $0x63
  jmp alltraps
80106816:	e9 bf f7 ff ff       	jmp    80105fda <alltraps>

8010681b <vector100>:
.globl vector100
vector100:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $100
8010681d:	6a 64                	push   $0x64
  jmp alltraps
8010681f:	e9 b6 f7 ff ff       	jmp    80105fda <alltraps>

80106824 <vector101>:
.globl vector101
vector101:
  pushl $0
80106824:	6a 00                	push   $0x0
  pushl $101
80106826:	6a 65                	push   $0x65
  jmp alltraps
80106828:	e9 ad f7 ff ff       	jmp    80105fda <alltraps>

8010682d <vector102>:
.globl vector102
vector102:
  pushl $0
8010682d:	6a 00                	push   $0x0
  pushl $102
8010682f:	6a 66                	push   $0x66
  jmp alltraps
80106831:	e9 a4 f7 ff ff       	jmp    80105fda <alltraps>

80106836 <vector103>:
.globl vector103
vector103:
  pushl $0
80106836:	6a 00                	push   $0x0
  pushl $103
80106838:	6a 67                	push   $0x67
  jmp alltraps
8010683a:	e9 9b f7 ff ff       	jmp    80105fda <alltraps>

8010683f <vector104>:
.globl vector104
vector104:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $104
80106841:	6a 68                	push   $0x68
  jmp alltraps
80106843:	e9 92 f7 ff ff       	jmp    80105fda <alltraps>

80106848 <vector105>:
.globl vector105
vector105:
  pushl $0
80106848:	6a 00                	push   $0x0
  pushl $105
8010684a:	6a 69                	push   $0x69
  jmp alltraps
8010684c:	e9 89 f7 ff ff       	jmp    80105fda <alltraps>

80106851 <vector106>:
.globl vector106
vector106:
  pushl $0
80106851:	6a 00                	push   $0x0
  pushl $106
80106853:	6a 6a                	push   $0x6a
  jmp alltraps
80106855:	e9 80 f7 ff ff       	jmp    80105fda <alltraps>

8010685a <vector107>:
.globl vector107
vector107:
  pushl $0
8010685a:	6a 00                	push   $0x0
  pushl $107
8010685c:	6a 6b                	push   $0x6b
  jmp alltraps
8010685e:	e9 77 f7 ff ff       	jmp    80105fda <alltraps>

80106863 <vector108>:
.globl vector108
vector108:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $108
80106865:	6a 6c                	push   $0x6c
  jmp alltraps
80106867:	e9 6e f7 ff ff       	jmp    80105fda <alltraps>

8010686c <vector109>:
.globl vector109
vector109:
  pushl $0
8010686c:	6a 00                	push   $0x0
  pushl $109
8010686e:	6a 6d                	push   $0x6d
  jmp alltraps
80106870:	e9 65 f7 ff ff       	jmp    80105fda <alltraps>

80106875 <vector110>:
.globl vector110
vector110:
  pushl $0
80106875:	6a 00                	push   $0x0
  pushl $110
80106877:	6a 6e                	push   $0x6e
  jmp alltraps
80106879:	e9 5c f7 ff ff       	jmp    80105fda <alltraps>

8010687e <vector111>:
.globl vector111
vector111:
  pushl $0
8010687e:	6a 00                	push   $0x0
  pushl $111
80106880:	6a 6f                	push   $0x6f
  jmp alltraps
80106882:	e9 53 f7 ff ff       	jmp    80105fda <alltraps>

80106887 <vector112>:
.globl vector112
vector112:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $112
80106889:	6a 70                	push   $0x70
  jmp alltraps
8010688b:	e9 4a f7 ff ff       	jmp    80105fda <alltraps>

80106890 <vector113>:
.globl vector113
vector113:
  pushl $0
80106890:	6a 00                	push   $0x0
  pushl $113
80106892:	6a 71                	push   $0x71
  jmp alltraps
80106894:	e9 41 f7 ff ff       	jmp    80105fda <alltraps>

80106899 <vector114>:
.globl vector114
vector114:
  pushl $0
80106899:	6a 00                	push   $0x0
  pushl $114
8010689b:	6a 72                	push   $0x72
  jmp alltraps
8010689d:	e9 38 f7 ff ff       	jmp    80105fda <alltraps>

801068a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801068a2:	6a 00                	push   $0x0
  pushl $115
801068a4:	6a 73                	push   $0x73
  jmp alltraps
801068a6:	e9 2f f7 ff ff       	jmp    80105fda <alltraps>

801068ab <vector116>:
.globl vector116
vector116:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $116
801068ad:	6a 74                	push   $0x74
  jmp alltraps
801068af:	e9 26 f7 ff ff       	jmp    80105fda <alltraps>

801068b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801068b4:	6a 00                	push   $0x0
  pushl $117
801068b6:	6a 75                	push   $0x75
  jmp alltraps
801068b8:	e9 1d f7 ff ff       	jmp    80105fda <alltraps>

801068bd <vector118>:
.globl vector118
vector118:
  pushl $0
801068bd:	6a 00                	push   $0x0
  pushl $118
801068bf:	6a 76                	push   $0x76
  jmp alltraps
801068c1:	e9 14 f7 ff ff       	jmp    80105fda <alltraps>

801068c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801068c6:	6a 00                	push   $0x0
  pushl $119
801068c8:	6a 77                	push   $0x77
  jmp alltraps
801068ca:	e9 0b f7 ff ff       	jmp    80105fda <alltraps>

801068cf <vector120>:
.globl vector120
vector120:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $120
801068d1:	6a 78                	push   $0x78
  jmp alltraps
801068d3:	e9 02 f7 ff ff       	jmp    80105fda <alltraps>

801068d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801068d8:	6a 00                	push   $0x0
  pushl $121
801068da:	6a 79                	push   $0x79
  jmp alltraps
801068dc:	e9 f9 f6 ff ff       	jmp    80105fda <alltraps>

801068e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801068e1:	6a 00                	push   $0x0
  pushl $122
801068e3:	6a 7a                	push   $0x7a
  jmp alltraps
801068e5:	e9 f0 f6 ff ff       	jmp    80105fda <alltraps>

801068ea <vector123>:
.globl vector123
vector123:
  pushl $0
801068ea:	6a 00                	push   $0x0
  pushl $123
801068ec:	6a 7b                	push   $0x7b
  jmp alltraps
801068ee:	e9 e7 f6 ff ff       	jmp    80105fda <alltraps>

801068f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $124
801068f5:	6a 7c                	push   $0x7c
  jmp alltraps
801068f7:	e9 de f6 ff ff       	jmp    80105fda <alltraps>

801068fc <vector125>:
.globl vector125
vector125:
  pushl $0
801068fc:	6a 00                	push   $0x0
  pushl $125
801068fe:	6a 7d                	push   $0x7d
  jmp alltraps
80106900:	e9 d5 f6 ff ff       	jmp    80105fda <alltraps>

80106905 <vector126>:
.globl vector126
vector126:
  pushl $0
80106905:	6a 00                	push   $0x0
  pushl $126
80106907:	6a 7e                	push   $0x7e
  jmp alltraps
80106909:	e9 cc f6 ff ff       	jmp    80105fda <alltraps>

8010690e <vector127>:
.globl vector127
vector127:
  pushl $0
8010690e:	6a 00                	push   $0x0
  pushl $127
80106910:	6a 7f                	push   $0x7f
  jmp alltraps
80106912:	e9 c3 f6 ff ff       	jmp    80105fda <alltraps>

80106917 <vector128>:
.globl vector128
vector128:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $128
80106919:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010691e:	e9 b7 f6 ff ff       	jmp    80105fda <alltraps>

80106923 <vector129>:
.globl vector129
vector129:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $129
80106925:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010692a:	e9 ab f6 ff ff       	jmp    80105fda <alltraps>

8010692f <vector130>:
.globl vector130
vector130:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $130
80106931:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106936:	e9 9f f6 ff ff       	jmp    80105fda <alltraps>

8010693b <vector131>:
.globl vector131
vector131:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $131
8010693d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106942:	e9 93 f6 ff ff       	jmp    80105fda <alltraps>

80106947 <vector132>:
.globl vector132
vector132:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $132
80106949:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010694e:	e9 87 f6 ff ff       	jmp    80105fda <alltraps>

80106953 <vector133>:
.globl vector133
vector133:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $133
80106955:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010695a:	e9 7b f6 ff ff       	jmp    80105fda <alltraps>

8010695f <vector134>:
.globl vector134
vector134:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $134
80106961:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106966:	e9 6f f6 ff ff       	jmp    80105fda <alltraps>

8010696b <vector135>:
.globl vector135
vector135:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $135
8010696d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106972:	e9 63 f6 ff ff       	jmp    80105fda <alltraps>

80106977 <vector136>:
.globl vector136
vector136:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $136
80106979:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010697e:	e9 57 f6 ff ff       	jmp    80105fda <alltraps>

80106983 <vector137>:
.globl vector137
vector137:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $137
80106985:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010698a:	e9 4b f6 ff ff       	jmp    80105fda <alltraps>

8010698f <vector138>:
.globl vector138
vector138:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $138
80106991:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106996:	e9 3f f6 ff ff       	jmp    80105fda <alltraps>

8010699b <vector139>:
.globl vector139
vector139:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $139
8010699d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801069a2:	e9 33 f6 ff ff       	jmp    80105fda <alltraps>

801069a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $140
801069a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801069ae:	e9 27 f6 ff ff       	jmp    80105fda <alltraps>

801069b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $141
801069b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801069ba:	e9 1b f6 ff ff       	jmp    80105fda <alltraps>

801069bf <vector142>:
.globl vector142
vector142:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $142
801069c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801069c6:	e9 0f f6 ff ff       	jmp    80105fda <alltraps>

801069cb <vector143>:
.globl vector143
vector143:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $143
801069cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801069d2:	e9 03 f6 ff ff       	jmp    80105fda <alltraps>

801069d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $144
801069d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801069de:	e9 f7 f5 ff ff       	jmp    80105fda <alltraps>

801069e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $145
801069e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069ea:	e9 eb f5 ff ff       	jmp    80105fda <alltraps>

801069ef <vector146>:
.globl vector146
vector146:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $146
801069f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801069f6:	e9 df f5 ff ff       	jmp    80105fda <alltraps>

801069fb <vector147>:
.globl vector147
vector147:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $147
801069fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106a02:	e9 d3 f5 ff ff       	jmp    80105fda <alltraps>

80106a07 <vector148>:
.globl vector148
vector148:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $148
80106a09:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106a0e:	e9 c7 f5 ff ff       	jmp    80105fda <alltraps>

80106a13 <vector149>:
.globl vector149
vector149:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $149
80106a15:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106a1a:	e9 bb f5 ff ff       	jmp    80105fda <alltraps>

80106a1f <vector150>:
.globl vector150
vector150:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $150
80106a21:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106a26:	e9 af f5 ff ff       	jmp    80105fda <alltraps>

80106a2b <vector151>:
.globl vector151
vector151:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $151
80106a2d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a32:	e9 a3 f5 ff ff       	jmp    80105fda <alltraps>

80106a37 <vector152>:
.globl vector152
vector152:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $152
80106a39:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a3e:	e9 97 f5 ff ff       	jmp    80105fda <alltraps>

80106a43 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $153
80106a45:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a4a:	e9 8b f5 ff ff       	jmp    80105fda <alltraps>

80106a4f <vector154>:
.globl vector154
vector154:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $154
80106a51:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a56:	e9 7f f5 ff ff       	jmp    80105fda <alltraps>

80106a5b <vector155>:
.globl vector155
vector155:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $155
80106a5d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a62:	e9 73 f5 ff ff       	jmp    80105fda <alltraps>

80106a67 <vector156>:
.globl vector156
vector156:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $156
80106a69:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a6e:	e9 67 f5 ff ff       	jmp    80105fda <alltraps>

80106a73 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $157
80106a75:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a7a:	e9 5b f5 ff ff       	jmp    80105fda <alltraps>

80106a7f <vector158>:
.globl vector158
vector158:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $158
80106a81:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a86:	e9 4f f5 ff ff       	jmp    80105fda <alltraps>

80106a8b <vector159>:
.globl vector159
vector159:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $159
80106a8d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106a92:	e9 43 f5 ff ff       	jmp    80105fda <alltraps>

80106a97 <vector160>:
.globl vector160
vector160:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $160
80106a99:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106a9e:	e9 37 f5 ff ff       	jmp    80105fda <alltraps>

80106aa3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $161
80106aa5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106aaa:	e9 2b f5 ff ff       	jmp    80105fda <alltraps>

80106aaf <vector162>:
.globl vector162
vector162:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $162
80106ab1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ab6:	e9 1f f5 ff ff       	jmp    80105fda <alltraps>

80106abb <vector163>:
.globl vector163
vector163:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $163
80106abd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ac2:	e9 13 f5 ff ff       	jmp    80105fda <alltraps>

80106ac7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $164
80106ac9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106ace:	e9 07 f5 ff ff       	jmp    80105fda <alltraps>

80106ad3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $165
80106ad5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106ada:	e9 fb f4 ff ff       	jmp    80105fda <alltraps>

80106adf <vector166>:
.globl vector166
vector166:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $166
80106ae1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106ae6:	e9 ef f4 ff ff       	jmp    80105fda <alltraps>

80106aeb <vector167>:
.globl vector167
vector167:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $167
80106aed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106af2:	e9 e3 f4 ff ff       	jmp    80105fda <alltraps>

80106af7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $168
80106af9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106afe:	e9 d7 f4 ff ff       	jmp    80105fda <alltraps>

80106b03 <vector169>:
.globl vector169
vector169:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $169
80106b05:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106b0a:	e9 cb f4 ff ff       	jmp    80105fda <alltraps>

80106b0f <vector170>:
.globl vector170
vector170:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $170
80106b11:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106b16:	e9 bf f4 ff ff       	jmp    80105fda <alltraps>

80106b1b <vector171>:
.globl vector171
vector171:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $171
80106b1d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106b22:	e9 b3 f4 ff ff       	jmp    80105fda <alltraps>

80106b27 <vector172>:
.globl vector172
vector172:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $172
80106b29:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106b2e:	e9 a7 f4 ff ff       	jmp    80105fda <alltraps>

80106b33 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $173
80106b35:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b3a:	e9 9b f4 ff ff       	jmp    80105fda <alltraps>

80106b3f <vector174>:
.globl vector174
vector174:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $174
80106b41:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b46:	e9 8f f4 ff ff       	jmp    80105fda <alltraps>

80106b4b <vector175>:
.globl vector175
vector175:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $175
80106b4d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b52:	e9 83 f4 ff ff       	jmp    80105fda <alltraps>

80106b57 <vector176>:
.globl vector176
vector176:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $176
80106b59:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b5e:	e9 77 f4 ff ff       	jmp    80105fda <alltraps>

80106b63 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $177
80106b65:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b6a:	e9 6b f4 ff ff       	jmp    80105fda <alltraps>

80106b6f <vector178>:
.globl vector178
vector178:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $178
80106b71:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b76:	e9 5f f4 ff ff       	jmp    80105fda <alltraps>

80106b7b <vector179>:
.globl vector179
vector179:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $179
80106b7d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b82:	e9 53 f4 ff ff       	jmp    80105fda <alltraps>

80106b87 <vector180>:
.globl vector180
vector180:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $180
80106b89:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b8e:	e9 47 f4 ff ff       	jmp    80105fda <alltraps>

80106b93 <vector181>:
.globl vector181
vector181:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $181
80106b95:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106b9a:	e9 3b f4 ff ff       	jmp    80105fda <alltraps>

80106b9f <vector182>:
.globl vector182
vector182:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $182
80106ba1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106ba6:	e9 2f f4 ff ff       	jmp    80105fda <alltraps>

80106bab <vector183>:
.globl vector183
vector183:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $183
80106bad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106bb2:	e9 23 f4 ff ff       	jmp    80105fda <alltraps>

80106bb7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $184
80106bb9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106bbe:	e9 17 f4 ff ff       	jmp    80105fda <alltraps>

80106bc3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $185
80106bc5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106bca:	e9 0b f4 ff ff       	jmp    80105fda <alltraps>

80106bcf <vector186>:
.globl vector186
vector186:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $186
80106bd1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106bd6:	e9 ff f3 ff ff       	jmp    80105fda <alltraps>

80106bdb <vector187>:
.globl vector187
vector187:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $187
80106bdd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106be2:	e9 f3 f3 ff ff       	jmp    80105fda <alltraps>

80106be7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $188
80106be9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bee:	e9 e7 f3 ff ff       	jmp    80105fda <alltraps>

80106bf3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $189
80106bf5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106bfa:	e9 db f3 ff ff       	jmp    80105fda <alltraps>

80106bff <vector190>:
.globl vector190
vector190:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $190
80106c01:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106c06:	e9 cf f3 ff ff       	jmp    80105fda <alltraps>

80106c0b <vector191>:
.globl vector191
vector191:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $191
80106c0d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106c12:	e9 c3 f3 ff ff       	jmp    80105fda <alltraps>

80106c17 <vector192>:
.globl vector192
vector192:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $192
80106c19:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106c1e:	e9 b7 f3 ff ff       	jmp    80105fda <alltraps>

80106c23 <vector193>:
.globl vector193
vector193:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $193
80106c25:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106c2a:	e9 ab f3 ff ff       	jmp    80105fda <alltraps>

80106c2f <vector194>:
.globl vector194
vector194:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $194
80106c31:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c36:	e9 9f f3 ff ff       	jmp    80105fda <alltraps>

80106c3b <vector195>:
.globl vector195
vector195:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $195
80106c3d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c42:	e9 93 f3 ff ff       	jmp    80105fda <alltraps>

80106c47 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $196
80106c49:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c4e:	e9 87 f3 ff ff       	jmp    80105fda <alltraps>

80106c53 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $197
80106c55:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c5a:	e9 7b f3 ff ff       	jmp    80105fda <alltraps>

80106c5f <vector198>:
.globl vector198
vector198:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $198
80106c61:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c66:	e9 6f f3 ff ff       	jmp    80105fda <alltraps>

80106c6b <vector199>:
.globl vector199
vector199:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $199
80106c6d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c72:	e9 63 f3 ff ff       	jmp    80105fda <alltraps>

80106c77 <vector200>:
.globl vector200
vector200:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $200
80106c79:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c7e:	e9 57 f3 ff ff       	jmp    80105fda <alltraps>

80106c83 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $201
80106c85:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c8a:	e9 4b f3 ff ff       	jmp    80105fda <alltraps>

80106c8f <vector202>:
.globl vector202
vector202:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $202
80106c91:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106c96:	e9 3f f3 ff ff       	jmp    80105fda <alltraps>

80106c9b <vector203>:
.globl vector203
vector203:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $203
80106c9d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ca2:	e9 33 f3 ff ff       	jmp    80105fda <alltraps>

80106ca7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $204
80106ca9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106cae:	e9 27 f3 ff ff       	jmp    80105fda <alltraps>

80106cb3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $205
80106cb5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106cba:	e9 1b f3 ff ff       	jmp    80105fda <alltraps>

80106cbf <vector206>:
.globl vector206
vector206:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $206
80106cc1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106cc6:	e9 0f f3 ff ff       	jmp    80105fda <alltraps>

80106ccb <vector207>:
.globl vector207
vector207:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $207
80106ccd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106cd2:	e9 03 f3 ff ff       	jmp    80105fda <alltraps>

80106cd7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $208
80106cd9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106cde:	e9 f7 f2 ff ff       	jmp    80105fda <alltraps>

80106ce3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $209
80106ce5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106cea:	e9 eb f2 ff ff       	jmp    80105fda <alltraps>

80106cef <vector210>:
.globl vector210
vector210:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $210
80106cf1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106cf6:	e9 df f2 ff ff       	jmp    80105fda <alltraps>

80106cfb <vector211>:
.globl vector211
vector211:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $211
80106cfd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106d02:	e9 d3 f2 ff ff       	jmp    80105fda <alltraps>

80106d07 <vector212>:
.globl vector212
vector212:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $212
80106d09:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106d0e:	e9 c7 f2 ff ff       	jmp    80105fda <alltraps>

80106d13 <vector213>:
.globl vector213
vector213:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $213
80106d15:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106d1a:	e9 bb f2 ff ff       	jmp    80105fda <alltraps>

80106d1f <vector214>:
.globl vector214
vector214:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $214
80106d21:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106d26:	e9 af f2 ff ff       	jmp    80105fda <alltraps>

80106d2b <vector215>:
.globl vector215
vector215:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $215
80106d2d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d32:	e9 a3 f2 ff ff       	jmp    80105fda <alltraps>

80106d37 <vector216>:
.globl vector216
vector216:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $216
80106d39:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d3e:	e9 97 f2 ff ff       	jmp    80105fda <alltraps>

80106d43 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $217
80106d45:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d4a:	e9 8b f2 ff ff       	jmp    80105fda <alltraps>

80106d4f <vector218>:
.globl vector218
vector218:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $218
80106d51:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d56:	e9 7f f2 ff ff       	jmp    80105fda <alltraps>

80106d5b <vector219>:
.globl vector219
vector219:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $219
80106d5d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d62:	e9 73 f2 ff ff       	jmp    80105fda <alltraps>

80106d67 <vector220>:
.globl vector220
vector220:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $220
80106d69:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d6e:	e9 67 f2 ff ff       	jmp    80105fda <alltraps>

80106d73 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $221
80106d75:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d7a:	e9 5b f2 ff ff       	jmp    80105fda <alltraps>

80106d7f <vector222>:
.globl vector222
vector222:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $222
80106d81:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d86:	e9 4f f2 ff ff       	jmp    80105fda <alltraps>

80106d8b <vector223>:
.globl vector223
vector223:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $223
80106d8d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106d92:	e9 43 f2 ff ff       	jmp    80105fda <alltraps>

80106d97 <vector224>:
.globl vector224
vector224:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $224
80106d99:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106d9e:	e9 37 f2 ff ff       	jmp    80105fda <alltraps>

80106da3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $225
80106da5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106daa:	e9 2b f2 ff ff       	jmp    80105fda <alltraps>

80106daf <vector226>:
.globl vector226
vector226:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $226
80106db1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106db6:	e9 1f f2 ff ff       	jmp    80105fda <alltraps>

80106dbb <vector227>:
.globl vector227
vector227:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $227
80106dbd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106dc2:	e9 13 f2 ff ff       	jmp    80105fda <alltraps>

80106dc7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $228
80106dc9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106dce:	e9 07 f2 ff ff       	jmp    80105fda <alltraps>

80106dd3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $229
80106dd5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106dda:	e9 fb f1 ff ff       	jmp    80105fda <alltraps>

80106ddf <vector230>:
.globl vector230
vector230:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $230
80106de1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106de6:	e9 ef f1 ff ff       	jmp    80105fda <alltraps>

80106deb <vector231>:
.globl vector231
vector231:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $231
80106ded:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106df2:	e9 e3 f1 ff ff       	jmp    80105fda <alltraps>

80106df7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $232
80106df9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106dfe:	e9 d7 f1 ff ff       	jmp    80105fda <alltraps>

80106e03 <vector233>:
.globl vector233
vector233:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $233
80106e05:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106e0a:	e9 cb f1 ff ff       	jmp    80105fda <alltraps>

80106e0f <vector234>:
.globl vector234
vector234:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $234
80106e11:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106e16:	e9 bf f1 ff ff       	jmp    80105fda <alltraps>

80106e1b <vector235>:
.globl vector235
vector235:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $235
80106e1d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106e22:	e9 b3 f1 ff ff       	jmp    80105fda <alltraps>

80106e27 <vector236>:
.globl vector236
vector236:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $236
80106e29:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106e2e:	e9 a7 f1 ff ff       	jmp    80105fda <alltraps>

80106e33 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $237
80106e35:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e3a:	e9 9b f1 ff ff       	jmp    80105fda <alltraps>

80106e3f <vector238>:
.globl vector238
vector238:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $238
80106e41:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e46:	e9 8f f1 ff ff       	jmp    80105fda <alltraps>

80106e4b <vector239>:
.globl vector239
vector239:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $239
80106e4d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e52:	e9 83 f1 ff ff       	jmp    80105fda <alltraps>

80106e57 <vector240>:
.globl vector240
vector240:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $240
80106e59:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e5e:	e9 77 f1 ff ff       	jmp    80105fda <alltraps>

80106e63 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $241
80106e65:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e6a:	e9 6b f1 ff ff       	jmp    80105fda <alltraps>

80106e6f <vector242>:
.globl vector242
vector242:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $242
80106e71:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e76:	e9 5f f1 ff ff       	jmp    80105fda <alltraps>

80106e7b <vector243>:
.globl vector243
vector243:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $243
80106e7d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e82:	e9 53 f1 ff ff       	jmp    80105fda <alltraps>

80106e87 <vector244>:
.globl vector244
vector244:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $244
80106e89:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e8e:	e9 47 f1 ff ff       	jmp    80105fda <alltraps>

80106e93 <vector245>:
.globl vector245
vector245:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $245
80106e95:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106e9a:	e9 3b f1 ff ff       	jmp    80105fda <alltraps>

80106e9f <vector246>:
.globl vector246
vector246:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $246
80106ea1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106ea6:	e9 2f f1 ff ff       	jmp    80105fda <alltraps>

80106eab <vector247>:
.globl vector247
vector247:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $247
80106ead:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106eb2:	e9 23 f1 ff ff       	jmp    80105fda <alltraps>

80106eb7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $248
80106eb9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106ebe:	e9 17 f1 ff ff       	jmp    80105fda <alltraps>

80106ec3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $249
80106ec5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106eca:	e9 0b f1 ff ff       	jmp    80105fda <alltraps>

80106ecf <vector250>:
.globl vector250
vector250:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $250
80106ed1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106ed6:	e9 ff f0 ff ff       	jmp    80105fda <alltraps>

80106edb <vector251>:
.globl vector251
vector251:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $251
80106edd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ee2:	e9 f3 f0 ff ff       	jmp    80105fda <alltraps>

80106ee7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $252
80106ee9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106eee:	e9 e7 f0 ff ff       	jmp    80105fda <alltraps>

80106ef3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $253
80106ef5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106efa:	e9 db f0 ff ff       	jmp    80105fda <alltraps>

80106eff <vector254>:
.globl vector254
vector254:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $254
80106f01:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106f06:	e9 cf f0 ff ff       	jmp    80105fda <alltraps>

80106f0b <vector255>:
.globl vector255
vector255:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $255
80106f0d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106f12:	e9 c3 f0 ff ff       	jmp    80105fda <alltraps>
80106f17:	66 90                	xchg   %ax,%ax
80106f19:	66 90                	xchg   %ax,%ax
80106f1b:	66 90                	xchg   %ax,%ax
80106f1d:	66 90                	xchg   %ax,%ax
80106f1f:	90                   	nop

80106f20 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106f26:	e8 85 c8 ff ff       	call   801037b0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f2b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106f31:	31 c9                	xor    %ecx,%ecx
80106f33:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106f38:	66 89 90 18 3d 11 80 	mov    %dx,-0x7feec2e8(%eax)
80106f3f:	66 89 88 1a 3d 11 80 	mov    %cx,-0x7feec2e6(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f46:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106f4b:	31 c9                	xor    %ecx,%ecx
80106f4d:	66 89 90 20 3d 11 80 	mov    %dx,-0x7feec2e0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f54:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f59:	66 89 88 22 3d 11 80 	mov    %cx,-0x7feec2de(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f60:	31 c9                	xor    %ecx,%ecx
80106f62:	66 89 90 28 3d 11 80 	mov    %dx,-0x7feec2d8(%eax)
80106f69:	66 89 88 2a 3d 11 80 	mov    %cx,-0x7feec2d6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f70:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106f75:	31 c9                	xor    %ecx,%ecx
80106f77:	66 89 90 30 3d 11 80 	mov    %dx,-0x7feec2d0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f7e:	c6 80 1c 3d 11 80 00 	movb   $0x0,-0x7feec2e4(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106f85:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106f8a:	c6 80 1d 3d 11 80 9a 	movb   $0x9a,-0x7feec2e3(%eax)
80106f91:	c6 80 1e 3d 11 80 cf 	movb   $0xcf,-0x7feec2e2(%eax)
80106f98:	c6 80 1f 3d 11 80 00 	movb   $0x0,-0x7feec2e1(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f9f:	c6 80 24 3d 11 80 00 	movb   $0x0,-0x7feec2dc(%eax)
80106fa6:	c6 80 25 3d 11 80 92 	movb   $0x92,-0x7feec2db(%eax)
80106fad:	c6 80 26 3d 11 80 cf 	movb   $0xcf,-0x7feec2da(%eax)
80106fb4:	c6 80 27 3d 11 80 00 	movb   $0x0,-0x7feec2d9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106fbb:	c6 80 2c 3d 11 80 00 	movb   $0x0,-0x7feec2d4(%eax)
80106fc2:	c6 80 2d 3d 11 80 fa 	movb   $0xfa,-0x7feec2d3(%eax)
80106fc9:	c6 80 2e 3d 11 80 cf 	movb   $0xcf,-0x7feec2d2(%eax)
80106fd0:	c6 80 2f 3d 11 80 00 	movb   $0x0,-0x7feec2d1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106fd7:	66 89 88 32 3d 11 80 	mov    %cx,-0x7feec2ce(%eax)
80106fde:	c6 80 34 3d 11 80 00 	movb   $0x0,-0x7feec2cc(%eax)
80106fe5:	c6 80 35 3d 11 80 f2 	movb   $0xf2,-0x7feec2cb(%eax)
80106fec:	c6 80 36 3d 11 80 cf 	movb   $0xcf,-0x7feec2ca(%eax)
80106ff3:	c6 80 37 3d 11 80 00 	movb   $0x0,-0x7feec2c9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106ffa:	05 10 3d 11 80       	add    $0x80113d10,%eax
80106fff:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80107003:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107007:	c1 e8 10             	shr    $0x10,%eax
8010700a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010700e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107011:	0f 01 10             	lgdtl  (%eax)
}
80107014:	c9                   	leave  
80107015:	c3                   	ret    
80107016:	8d 76 00             	lea    0x0(%esi),%esi
80107019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107020 <walkpgdir>:
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
//static
pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	83 ec 0c             	sub    $0xc,%esp
80107029:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010702c:	8b 55 08             	mov    0x8(%ebp),%edx
8010702f:	89 df                	mov    %ebx,%edi
80107031:	c1 ef 16             	shr    $0x16,%edi
80107034:	8d 3c ba             	lea    (%edx,%edi,4),%edi
  if(*pde & PTE_P){
80107037:	8b 07                	mov    (%edi),%eax
80107039:	a8 01                	test   $0x1,%al
8010703b:	74 23                	je     80107060 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010703d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107042:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107048:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010704b:	c1 eb 0a             	shr    $0xa,%ebx
8010704e:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80107054:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107057:	5b                   	pop    %ebx
80107058:	5e                   	pop    %esi
80107059:	5f                   	pop    %edi
8010705a:	5d                   	pop    %ebp
8010705b:	c3                   	ret    
8010705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107060:	8b 45 10             	mov    0x10(%ebp),%eax
80107063:	85 c0                	test   %eax,%eax
80107065:	74 31                	je     80107098 <walkpgdir+0x78>
80107067:	e8 74 b4 ff ff       	call   801024e0 <kalloc>
8010706c:	85 c0                	test   %eax,%eax
8010706e:	89 c6                	mov    %eax,%esi
80107070:	74 26                	je     80107098 <walkpgdir+0x78>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107072:	83 ec 04             	sub    $0x4,%esp
80107075:	68 00 10 00 00       	push   $0x1000
8010707a:	6a 00                	push   $0x0
8010707c:	50                   	push   %eax
8010707d:	e8 fe d3 ff ff       	call   80104480 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107082:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107088:	83 c4 10             	add    $0x10,%esp
8010708b:	83 c8 07             	or     $0x7,%eax
8010708e:	89 07                	mov    %eax,(%edi)
80107090:	eb b6                	jmp    80107048 <walkpgdir+0x28>
80107092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  return &pgtab[PTX(va)];
}
80107098:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
8010709b:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
8010709d:	5b                   	pop    %ebx
8010709e:	5e                   	pop    %esi
8010709f:	5f                   	pop    %edi
801070a0:	5d                   	pop    %ebp
801070a1:	c3                   	ret    
801070a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070b6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070bc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070be:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070c4:	83 ec 1c             	sub    $0x1c,%esp
801070c7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801070ca:	39 d3                	cmp    %edx,%ebx
801070cc:	73 59                	jae    80107127 <deallocuvm.part.0+0x77>
801070ce:	89 d6                	mov    %edx,%esi
801070d0:	eb 2c                	jmp    801070fe <deallocuvm.part.0+0x4e>
801070d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801070d8:	8b 10                	mov    (%eax),%edx
801070da:	f6 c2 01             	test   $0x1,%dl
801070dd:	74 15                	je     801070f4 <deallocuvm.part.0+0x44>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801070df:	89 d1                	mov    %edx,%ecx
801070e1:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801070e7:	74 69                	je     80107152 <deallocuvm.part.0+0xa2>
        panic("kfree");
      char *v = P2V(pa);
      if((*pte & PTE_S) == 0){
801070e9:	83 e2 08             	and    $0x8,%edx
801070ec:	74 4a                	je     80107138 <deallocuvm.part.0+0x88>
        kfree(v);
      } 
      *pte = 0;
801070ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801070f4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070fa:	39 f3                	cmp    %esi,%ebx
801070fc:	73 29                	jae    80107127 <deallocuvm.part.0+0x77>
    pte = walkpgdir(pgdir, (char*)a, 0);
801070fe:	83 ec 04             	sub    $0x4,%esp
80107101:	6a 00                	push   $0x0
80107103:	53                   	push   %ebx
80107104:	57                   	push   %edi
80107105:	e8 16 ff ff ff       	call   80107020 <walkpgdir>
    if(!pte)
8010710a:	83 c4 10             	add    $0x10,%esp
8010710d:	85 c0                	test   %eax,%eax
8010710f:	75 c7                	jne    801070d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107111:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107117:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010711d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107123:	39 f3                	cmp    %esi,%ebx
80107125:	72 d7                	jb     801070fe <deallocuvm.part.0+0x4e>
      } 
      *pte = 0;
    }
  }
  return newsz;
}
80107127:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010712a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010712d:	5b                   	pop    %ebx
8010712e:	5e                   	pop    %esi
8010712f:	5f                   	pop    %edi
80107130:	5d                   	pop    %ebp
80107131:	c3                   	ret    
80107132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
      if((*pte & PTE_S) == 0){
        kfree(v);
80107138:	83 ec 0c             	sub    $0xc,%esp
8010713b:	81 c1 00 00 00 80    	add    $0x80000000,%ecx
80107141:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107144:	51                   	push   %ecx
80107145:	e8 e6 b1 ff ff       	call   80102330 <kfree>
8010714a:	83 c4 10             	add    $0x10,%esp
8010714d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107150:	eb 9c                	jmp    801070ee <deallocuvm.part.0+0x3e>
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80107152:	83 ec 0c             	sub    $0xc,%esp
80107155:	68 a6 7b 10 80       	push   $0x80107ba6
8010715a:	e8 11 92 ff ff       	call   80100370 <panic>
8010715f:	90                   	nop

80107160 <mappages>:
// be page-aligned.

//static
int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 1c             	sub    $0x1c,%esp
80107169:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010716c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010716f:	8b 75 14             	mov    0x14(%ebp),%esi
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107172:	89 c7                	mov    %eax,%edi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107174:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107178:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010717e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107183:	29 fe                	sub    %edi,%esi
80107185:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107188:	8b 45 18             	mov    0x18(%ebp),%eax
8010718b:	83 c8 01             	or     $0x1,%eax
8010718e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107191:	89 f0                	mov    %esi,%eax
80107193:	89 fe                	mov    %edi,%esi
80107195:	89 c7                	mov    %eax,%edi
80107197:	eb 1c                	jmp    801071b5 <mappages+0x55>
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801071a0:	f6 00 01             	testb  $0x1,(%eax)
801071a3:	75 45                	jne    801071ea <mappages+0x8a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801071a5:	0b 5d e0             	or     -0x20(%ebp),%ebx
    if(a == last)
801071a8:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801071ab:	89 18                	mov    %ebx,(%eax)
    if(a == last)
801071ad:	74 31                	je     801071e0 <mappages+0x80>
      break;
    a += PGSIZE;
801071af:	81 c6 00 10 00 00    	add    $0x1000,%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801071b5:	83 ec 04             	sub    $0x4,%esp
801071b8:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
801071bb:	6a 01                	push   $0x1
801071bd:	56                   	push   %esi
801071be:	ff 75 08             	pushl  0x8(%ebp)
801071c1:	e8 5a fe ff ff       	call   80107020 <walkpgdir>
801071c6:	83 c4 10             	add    $0x10,%esp
801071c9:	85 c0                	test   %eax,%eax
801071cb:	75 d3                	jne    801071a0 <mappages+0x40>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801071cd:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801071d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801071d5:	5b                   	pop    %ebx
801071d6:	5e                   	pop    %esi
801071d7:	5f                   	pop    %edi
801071d8:	5d                   	pop    %ebp
801071d9:	c3                   	ret    
801071da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801071e3:	31 c0                	xor    %eax,%eax
}
801071e5:	5b                   	pop    %ebx
801071e6:	5e                   	pop    %esi
801071e7:	5f                   	pop    %edi
801071e8:	5d                   	pop    %ebp
801071e9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801071ea:	83 ec 0c             	sub    $0xc,%esp
801071ed:	68 a8 82 10 80       	push   $0x801082a8
801071f2:	e8 79 91 ff ff       	call   80100370 <panic>
801071f7:	89 f6                	mov    %esi,%esi
801071f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107200 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107200:	a1 c4 69 11 80       	mov    0x801169c4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107205:	55                   	push   %ebp
80107206:	89 e5                	mov    %esp,%ebp
80107208:	05 00 00 00 80       	add    $0x80000000,%eax
8010720d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80107210:	5d                   	pop    %ebp
80107211:	c3                   	ret    
80107212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107220 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	57                   	push   %edi
80107224:	56                   	push   %esi
80107225:	53                   	push   %ebx
80107226:	83 ec 1c             	sub    $0x1c,%esp
80107229:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010722c:	85 f6                	test   %esi,%esi
8010722e:	0f 84 cd 00 00 00    	je     80107301 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107234:	8b 46 08             	mov    0x8(%esi),%eax
80107237:	85 c0                	test   %eax,%eax
80107239:	0f 84 dc 00 00 00    	je     8010731b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010723f:	8b 7e 04             	mov    0x4(%esi),%edi
80107242:	85 ff                	test   %edi,%edi
80107244:	0f 84 c4 00 00 00    	je     8010730e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
8010724a:	e8 51 d0 ff ff       	call   801042a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010724f:	e8 dc c4 ff ff       	call   80103730 <mycpu>
80107254:	89 c3                	mov    %eax,%ebx
80107256:	e8 d5 c4 ff ff       	call   80103730 <mycpu>
8010725b:	89 c7                	mov    %eax,%edi
8010725d:	e8 ce c4 ff ff       	call   80103730 <mycpu>
80107262:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107265:	83 c7 08             	add    $0x8,%edi
80107268:	e8 c3 c4 ff ff       	call   80103730 <mycpu>
8010726d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107270:	83 c0 08             	add    $0x8,%eax
80107273:	ba 67 00 00 00       	mov    $0x67,%edx
80107278:	c1 e8 18             	shr    $0x18,%eax
8010727b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107282:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107289:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107290:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107297:	83 c1 08             	add    $0x8,%ecx
8010729a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801072a0:	c1 e9 10             	shr    $0x10,%ecx
801072a3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072a9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801072ae:	e8 7d c4 ff ff       	call   80103730 <mycpu>
801072b3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072ba:	e8 71 c4 ff ff       	call   80103730 <mycpu>
801072bf:	b9 10 00 00 00       	mov    $0x10,%ecx
801072c4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072c8:	e8 63 c4 ff ff       	call   80103730 <mycpu>
801072cd:	8b 56 08             	mov    0x8(%esi),%edx
801072d0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801072d6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072d9:	e8 52 c4 ff ff       	call   80103730 <mycpu>
801072de:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801072e2:	b8 28 00 00 00       	mov    $0x28,%eax
801072e7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801072ea:	8b 46 04             	mov    0x4(%esi),%eax
801072ed:	05 00 00 00 80       	add    $0x80000000,%eax
801072f2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801072f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072f8:	5b                   	pop    %ebx
801072f9:	5e                   	pop    %esi
801072fa:	5f                   	pop    %edi
801072fb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801072fc:	e9 df cf ff ff       	jmp    801042e0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80107301:	83 ec 0c             	sub    $0xc,%esp
80107304:	68 ae 82 10 80       	push   $0x801082ae
80107309:	e8 62 90 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010730e:	83 ec 0c             	sub    $0xc,%esp
80107311:	68 d9 82 10 80       	push   $0x801082d9
80107316:	e8 55 90 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
8010731b:	83 ec 0c             	sub    $0xc,%esp
8010731e:	68 c4 82 10 80       	push   $0x801082c4
80107323:	e8 48 90 ff ff       	call   80100370 <panic>
80107328:	90                   	nop
80107329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107330 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107330:	55                   	push   %ebp
80107331:	89 e5                	mov    %esp,%ebp
80107333:	57                   	push   %edi
80107334:	56                   	push   %esi
80107335:	53                   	push   %ebx
80107336:	83 ec 1c             	sub    $0x1c,%esp
80107339:	8b 75 10             	mov    0x10(%ebp),%esi
8010733c:	8b 55 08             	mov    0x8(%ebp),%edx
8010733f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107342:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107348:	77 50                	ja     8010739a <inituvm+0x6a>
8010734a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    panic("inituvm: more than a page");
  mem = kalloc();
8010734d:	e8 8e b1 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80107352:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107355:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107357:	68 00 10 00 00       	push   $0x1000
8010735c:	6a 00                	push   $0x0
8010735e:	50                   	push   %eax
8010735f:	e8 1c d1 ff ff       	call   80104480 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107364:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107367:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010736d:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80107374:	50                   	push   %eax
80107375:	68 00 10 00 00       	push   $0x1000
8010737a:	6a 00                	push   $0x0
8010737c:	52                   	push   %edx
8010737d:	e8 de fd ff ff       	call   80107160 <mappages>
  memmove(mem, init, sz);
80107382:	89 75 10             	mov    %esi,0x10(%ebp)
80107385:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107388:	83 c4 20             	add    $0x20,%esp
8010738b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010738e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107391:	5b                   	pop    %ebx
80107392:	5e                   	pop    %esi
80107393:	5f                   	pop    %edi
80107394:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107395:	e9 96 d1 ff ff       	jmp    80104530 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
8010739a:	83 ec 0c             	sub    $0xc,%esp
8010739d:	68 ed 82 10 80       	push   $0x801082ed
801073a2:	e8 c9 8f ff ff       	call   80100370 <panic>
801073a7:	89 f6                	mov    %esi,%esi
801073a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073b0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	57                   	push   %edi
801073b4:	56                   	push   %esi
801073b5:	53                   	push   %ebx
801073b6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801073b9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801073c0:	0f 85 99 00 00 00    	jne    8010745f <loaduvm+0xaf>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801073c6:	8b 5d 18             	mov    0x18(%ebp),%ebx
801073c9:	31 ff                	xor    %edi,%edi
801073cb:	85 db                	test   %ebx,%ebx
801073cd:	75 1a                	jne    801073e9 <loaduvm+0x39>
801073cf:	eb 77                	jmp    80107448 <loaduvm+0x98>
801073d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073d8:	81 c7 00 10 00 00    	add    $0x1000,%edi
801073de:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073e4:	39 7d 18             	cmp    %edi,0x18(%ebp)
801073e7:	76 5f                	jbe    80107448 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801073ec:	83 ec 04             	sub    $0x4,%esp
801073ef:	6a 00                	push   $0x0
801073f1:	01 f8                	add    %edi,%eax
801073f3:	50                   	push   %eax
801073f4:	ff 75 08             	pushl  0x8(%ebp)
801073f7:	e8 24 fc ff ff       	call   80107020 <walkpgdir>
801073fc:	83 c4 10             	add    $0x10,%esp
801073ff:	85 c0                	test   %eax,%eax
80107401:	74 4f                	je     80107452 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80107403:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107405:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80107408:	be 00 10 00 00       	mov    $0x1000,%esi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010740d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107412:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107418:	0f 46 f3             	cmovbe %ebx,%esi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010741b:	01 f9                	add    %edi,%ecx
8010741d:	05 00 00 00 80       	add    $0x80000000,%eax
80107422:	56                   	push   %esi
80107423:	51                   	push   %ecx
80107424:	50                   	push   %eax
80107425:	ff 75 10             	pushl  0x10(%ebp)
80107428:	e8 73 a5 ff ff       	call   801019a0 <readi>
8010742d:	83 c4 10             	add    $0x10,%esp
80107430:	39 c6                	cmp    %eax,%esi
80107432:	74 a4                	je     801073d8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80107434:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80107437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010743c:	5b                   	pop    %ebx
8010743d:	5e                   	pop    %esi
8010743e:	5f                   	pop    %edi
8010743f:	5d                   	pop    %ebp
80107440:	c3                   	ret    
80107441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107448:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010744b:	31 c0                	xor    %eax,%eax
}
8010744d:	5b                   	pop    %ebx
8010744e:	5e                   	pop    %esi
8010744f:	5f                   	pop    %edi
80107450:	5d                   	pop    %ebp
80107451:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80107452:	83 ec 0c             	sub    $0xc,%esp
80107455:	68 07 83 10 80       	push   $0x80108307
8010745a:	e8 11 8f ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010745f:	83 ec 0c             	sub    $0xc,%esp
80107462:	68 c4 83 10 80       	push   $0x801083c4
80107467:	e8 04 8f ff ff       	call   80100370 <panic>
8010746c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107470 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	57                   	push   %edi
80107474:	56                   	push   %esi
80107475:	53                   	push   %ebx
80107476:	83 ec 0c             	sub    $0xc,%esp
80107479:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010747c:	85 ff                	test   %edi,%edi
8010747e:	0f 88 ca 00 00 00    	js     8010754e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107484:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107487:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010748a:	0f 82 84 00 00 00    	jb     80107514 <allocuvm+0xa4>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107490:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107496:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010749c:	39 df                	cmp    %ebx,%edi
8010749e:	77 45                	ja     801074e5 <allocuvm+0x75>
801074a0:	e9 bb 00 00 00       	jmp    80107560 <allocuvm+0xf0>
801074a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
801074a8:	83 ec 04             	sub    $0x4,%esp
801074ab:	68 00 10 00 00       	push   $0x1000
801074b0:	6a 00                	push   $0x0
801074b2:	50                   	push   %eax
801074b3:	e8 c8 cf ff ff       	call   80104480 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801074b8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801074be:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
801074c5:	50                   	push   %eax
801074c6:	68 00 10 00 00       	push   $0x1000
801074cb:	53                   	push   %ebx
801074cc:	ff 75 08             	pushl  0x8(%ebp)
801074cf:	e8 8c fc ff ff       	call   80107160 <mappages>
801074d4:	83 c4 20             	add    $0x20,%esp
801074d7:	85 c0                	test   %eax,%eax
801074d9:	78 45                	js     80107520 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801074db:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074e1:	39 df                	cmp    %ebx,%edi
801074e3:	76 7b                	jbe    80107560 <allocuvm+0xf0>
    mem = kalloc();
801074e5:	e8 f6 af ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
801074ea:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801074ec:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801074ee:	75 b8                	jne    801074a8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
801074f0:	83 ec 0c             	sub    $0xc,%esp
801074f3:	68 25 83 10 80       	push   $0x80108325
801074f8:	e8 63 91 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801074fd:	83 c4 10             	add    $0x10,%esp
80107500:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107503:	76 49                	jbe    8010754e <allocuvm+0xde>
80107505:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107508:	8b 45 08             	mov    0x8(%ebp),%eax
8010750b:	89 fa                	mov    %edi,%edx
8010750d:	e8 9e fb ff ff       	call   801070b0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80107512:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107514:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107517:	5b                   	pop    %ebx
80107518:	5e                   	pop    %esi
80107519:	5f                   	pop    %edi
8010751a:	5d                   	pop    %ebp
8010751b:	c3                   	ret    
8010751c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80107520:	83 ec 0c             	sub    $0xc,%esp
80107523:	68 3d 83 10 80       	push   $0x8010833d
80107528:	e8 33 91 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010752d:	83 c4 10             	add    $0x10,%esp
80107530:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107533:	76 0d                	jbe    80107542 <allocuvm+0xd2>
80107535:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107538:	8b 45 08             	mov    0x8(%ebp),%eax
8010753b:	89 fa                	mov    %edi,%edx
8010753d:	e8 6e fb ff ff       	call   801070b0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107542:	83 ec 0c             	sub    $0xc,%esp
80107545:	56                   	push   %esi
80107546:	e8 e5 ad ff ff       	call   80102330 <kfree>
      return 0;
8010754b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
8010754e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107551:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107553:	5b                   	pop    %ebx
80107554:	5e                   	pop    %esi
80107555:	5f                   	pop    %edi
80107556:	5d                   	pop    %ebp
80107557:	c3                   	ret    
80107558:	90                   	nop
80107559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107560:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107563:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107565:	5b                   	pop    %ebx
80107566:	5e                   	pop    %esi
80107567:	5f                   	pop    %edi
80107568:	5d                   	pop    %ebp
80107569:	c3                   	ret    
8010756a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107570 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	8b 55 0c             	mov    0xc(%ebp),%edx
80107576:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107579:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010757c:	39 d1                	cmp    %edx,%ecx
8010757e:	73 10                	jae    80107590 <deallocuvm+0x20>
      } 
      *pte = 0;
    }
  }
  return newsz;
}
80107580:	5d                   	pop    %ebp
80107581:	e9 2a fb ff ff       	jmp    801070b0 <deallocuvm.part.0>
80107586:	8d 76 00             	lea    0x0(%esi),%esi
80107589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107590:	89 d0                	mov    %edx,%eax
80107592:	5d                   	pop    %ebp
80107593:	c3                   	ret    
80107594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010759a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075a0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir, int pid)
{
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	57                   	push   %edi
801075a4:	56                   	push   %esi
801075a5:	53                   	push   %ebx
801075a6:	83 ec 18             	sub    $0x18,%esp
801075a9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;
  procCleanup(pid);
801075ac:	ff 75 0c             	pushl  0xc(%ebp)
801075af:	e8 ec e7 ff ff       	call   80105da0 <procCleanup>
  if(pgdir == 0)
801075b4:	83 c4 10             	add    $0x10,%esp
801075b7:	85 f6                	test   %esi,%esi
801075b9:	74 56                	je     80107611 <freevm+0x71>
801075bb:	31 c9                	xor    %ecx,%ecx
801075bd:	ba 00 00 00 80       	mov    $0x80000000,%edx
801075c2:	89 f0                	mov    %esi,%eax
801075c4:	e8 e7 fa ff ff       	call   801070b0 <deallocuvm.part.0>
801075c9:	89 f3                	mov    %esi,%ebx
801075cb:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801075d1:	eb 0c                	jmp    801075df <freevm+0x3f>
801075d3:	90                   	nop
801075d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075d8:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801075db:	39 fb                	cmp    %edi,%ebx
801075dd:	74 23                	je     80107602 <freevm+0x62>
    if(pgdir[i] & PTE_P){
801075df:	8b 03                	mov    (%ebx),%eax
801075e1:	a8 01                	test   $0x1,%al
801075e3:	74 f3                	je     801075d8 <freevm+0x38>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801075e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075ea:	83 ec 0c             	sub    $0xc,%esp
801075ed:	83 c3 04             	add    $0x4,%ebx
801075f0:	05 00 00 00 80       	add    $0x80000000,%eax
801075f5:	50                   	push   %eax
801075f6:	e8 35 ad ff ff       	call   80102330 <kfree>
801075fb:	83 c4 10             	add    $0x10,%esp
  uint i;
  procCleanup(pid);
  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801075fe:	39 fb                	cmp    %edi,%ebx
80107600:	75 dd                	jne    801075df <freevm+0x3f>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107602:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107605:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107608:	5b                   	pop    %ebx
80107609:	5e                   	pop    %esi
8010760a:	5f                   	pop    %edi
8010760b:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010760c:	e9 1f ad ff ff       	jmp    80102330 <kfree>
freevm(pde_t *pgdir, int pid)
{
  uint i;
  procCleanup(pid);
  if(pgdir == 0)
    panic("freevm: no pgdir");
80107611:	83 ec 0c             	sub    $0xc,%esp
80107614:	68 59 83 10 80       	push   $0x80108359
80107619:	e8 52 8d ff ff       	call   80100370 <panic>
8010761e:	66 90                	xchg   %ax,%ax

80107620 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107620:	55                   	push   %ebp
80107621:	89 e5                	mov    %esp,%ebp
80107623:	56                   	push   %esi
80107624:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107625:	e8 b6 ae ff ff       	call   801024e0 <kalloc>
8010762a:	85 c0                	test   %eax,%eax
8010762c:	0f 84 7e 00 00 00    	je     801076b0 <setupkvm+0x90>
    return 0;
  memset(pgdir, 0, PGSIZE);
80107632:	83 ec 04             	sub    $0x4,%esp
80107635:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107637:	bb 60 b4 10 80       	mov    $0x8010b460,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
8010763c:	68 00 10 00 00       	push   $0x1000
80107641:	6a 00                	push   $0x0
80107643:	50                   	push   %eax
80107644:	e8 37 ce ff ff       	call   80104480 <memset>
80107649:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010764c:	8b 43 04             	mov    0x4(%ebx),%eax
8010764f:	8b 53 08             	mov    0x8(%ebx),%edx
80107652:	83 ec 0c             	sub    $0xc,%esp
80107655:	ff 73 0c             	pushl  0xc(%ebx)
80107658:	29 c2                	sub    %eax,%edx
8010765a:	50                   	push   %eax
8010765b:	52                   	push   %edx
8010765c:	ff 33                	pushl  (%ebx)
8010765e:	56                   	push   %esi
8010765f:	e8 fc fa ff ff       	call   80107160 <mappages>
80107664:	83 c4 20             	add    $0x20,%esp
80107667:	85 c0                	test   %eax,%eax
80107669:	78 15                	js     80107680 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010766b:	83 c3 10             	add    $0x10,%ebx
8010766e:	81 fb a0 b4 10 80    	cmp    $0x8010b4a0,%ebx
80107674:	75 d6                	jne    8010764c <setupkvm+0x2c>
80107676:	89 f0                	mov    %esi,%eax
                  cprintf("vm in if mappages");
      freevm(pgdir, myproc() -> pid);
      return 0;
    }
  return pgdir;
}
80107678:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010767b:	5b                   	pop    %ebx
8010767c:	5e                   	pop    %esi
8010767d:	5d                   	pop    %ebp
8010767e:	c3                   	ret    
8010767f:	90                   	nop
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
                  cprintf("vm in if mappages");
80107680:	83 ec 0c             	sub    $0xc,%esp
80107683:	68 6a 83 10 80       	push   $0x8010836a
80107688:	e8 d3 8f ff ff       	call   80100660 <cprintf>
      freevm(pgdir, myproc() -> pid);
8010768d:	e8 3e c1 ff ff       	call   801037d0 <myproc>
80107692:	5a                   	pop    %edx
80107693:	59                   	pop    %ecx
80107694:	ff 70 10             	pushl  0x10(%eax)
80107697:	56                   	push   %esi
80107698:	e8 03 ff ff ff       	call   801075a0 <freevm>
      return 0;
8010769d:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
801076a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
                  cprintf("vm in if mappages");
      freevm(pgdir, myproc() -> pid);
      return 0;
801076a3:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
801076a5:	5b                   	pop    %ebx
801076a6:	5e                   	pop    %esi
801076a7:	5d                   	pop    %ebp
801076a8:	c3                   	ret    
801076a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
801076b0:	31 c0                	xor    %eax,%eax
801076b2:	eb c4                	jmp    80107678 <setupkvm+0x58>
801076b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801076ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801076c0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801076c0:	55                   	push   %ebp
801076c1:	89 e5                	mov    %esp,%ebp
801076c3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076c6:	e8 55 ff ff ff       	call   80107620 <setupkvm>
801076cb:	a3 c4 69 11 80       	mov    %eax,0x801169c4
801076d0:	05 00 00 00 80       	add    $0x80000000,%eax
801076d5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
801076d8:	c9                   	leave  
801076d9:	c3                   	ret    
801076da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801076e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801076e0:	55                   	push   %ebp
801076e1:	89 e5                	mov    %esp,%ebp
801076e3:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801076e6:	6a 00                	push   $0x0
801076e8:	ff 75 0c             	pushl  0xc(%ebp)
801076eb:	ff 75 08             	pushl  0x8(%ebp)
801076ee:	e8 2d f9 ff ff       	call   80107020 <walkpgdir>
  if(pte == 0)
801076f3:	83 c4 10             	add    $0x10,%esp
801076f6:	85 c0                	test   %eax,%eax
801076f8:	74 05                	je     801076ff <clearpteu+0x1f>
    panic("clearpteu");
  *pte &= ~PTE_U;
801076fa:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801076fd:	c9                   	leave  
801076fe:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801076ff:	83 ec 0c             	sub    $0xc,%esp
80107702:	68 7c 83 10 80       	push   $0x8010837c
80107707:	e8 64 8c ff ff       	call   80100370 <panic>
8010770c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107710 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	57                   	push   %edi
80107714:	56                   	push   %esi
80107715:	53                   	push   %ebx
80107716:	83 ec 1c             	sub    $0x1c,%esp
  uint pa, i, flags;
  char *mem;

   

  if((d = setupkvm()) == 0)
80107719:	e8 02 ff ff ff       	call   80107620 <setupkvm>
8010771e:	85 c0                	test   %eax,%eax
80107720:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107723:	0f 84 ed 00 00 00    	je     80107816 <copyuvm+0x106>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107729:	8b 75 0c             	mov    0xc(%ebp),%esi
8010772c:	85 f6                	test   %esi,%esi
8010772e:	0f 84 c4 00 00 00    	je     801077f8 <copyuvm+0xe8>
80107734:	31 f6                	xor    %esi,%esi
80107736:	eb 4c                	jmp    80107784 <copyuvm+0x74>
80107738:	90                   	nop
80107739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107740:	83 ec 04             	sub    $0x4,%esp
80107743:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107749:	68 00 10 00 00       	push   $0x1000
8010774e:	53                   	push   %ebx
8010774f:	50                   	push   %eax
80107750:	e8 db cd ff ff       	call   80104530 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107755:	5b                   	pop    %ebx
80107756:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
8010775c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010775f:	50                   	push   %eax
80107760:	68 00 10 00 00       	push   $0x1000
80107765:	56                   	push   %esi
80107766:	ff 75 e0             	pushl  -0x20(%ebp)
80107769:	e8 f2 f9 ff ff       	call   80107160 <mappages>
8010776e:	83 c4 20             	add    $0x20,%esp
80107771:	85 c0                	test   %eax,%eax
80107773:	0f 88 8f 00 00 00    	js     80107808 <copyuvm+0xf8>

   

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107779:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010777f:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107782:	76 74                	jbe    801077f8 <copyuvm+0xe8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107784:	83 ec 04             	sub    $0x4,%esp
80107787:	6a 00                	push   $0x0
80107789:	56                   	push   %esi
8010778a:	ff 75 08             	pushl  0x8(%ebp)
8010778d:	e8 8e f8 ff ff       	call   80107020 <walkpgdir>
80107792:	83 c4 10             	add    $0x10,%esp
80107795:	85 c0                	test   %eax,%eax
80107797:	0f 84 8a 00 00 00    	je     80107827 <copyuvm+0x117>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
8010779d:	8b 38                	mov    (%eax),%edi
8010779f:	f7 c7 01 00 00 00    	test   $0x1,%edi
801077a5:	74 73                	je     8010781a <copyuvm+0x10a>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801077a7:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
801077a9:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
801077af:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801077b2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801077b8:	e8 23 ad ff ff       	call   801024e0 <kalloc>
801077bd:	85 c0                	test   %eax,%eax
801077bf:	89 c7                	mov    %eax,%edi
801077c1:	0f 85 79 ff ff ff    	jne    80107740 <copyuvm+0x30>
    }
  }
  return d;

bad:
  cprintf("vm in bad");
801077c7:	83 ec 0c             	sub    $0xc,%esp
801077ca:	68 ba 83 10 80       	push   $0x801083ba
801077cf:	e8 8c 8e ff ff       	call   80100660 <cprintf>
  freevm(d, myproc() -> pid);
801077d4:	e8 f7 bf ff ff       	call   801037d0 <myproc>
801077d9:	5a                   	pop    %edx
801077da:	59                   	pop    %ecx
801077db:	ff 70 10             	pushl  0x10(%eax)
801077de:	ff 75 e0             	pushl  -0x20(%ebp)
801077e1:	e8 ba fd ff ff       	call   801075a0 <freevm>
  return 0;
801077e6:	83 c4 10             	add    $0x10,%esp
801077e9:	31 c0                	xor    %eax,%eax
}
801077eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077ee:	5b                   	pop    %ebx
801077ef:	5e                   	pop    %esi
801077f0:	5f                   	pop    %edi
801077f1:	5d                   	pop    %ebp
801077f2:	c3                   	ret    
801077f3:	90                   	nop
801077f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

   

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801077f8:	8b 45 e0             	mov    -0x20(%ebp),%eax

bad:
  cprintf("vm in bad");
  freevm(d, myproc() -> pid);
  return 0;
}
801077fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077fe:	5b                   	pop    %ebx
801077ff:	5e                   	pop    %esi
80107800:	5f                   	pop    %edi
80107801:	5d                   	pop    %ebp
80107802:	c3                   	ret    
80107803:	90                   	nop
80107804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107808:	83 ec 0c             	sub    $0xc,%esp
8010780b:	57                   	push   %edi
8010780c:	e8 1f ab ff ff       	call   80102330 <kfree>
      goto bad;
80107811:	83 c4 10             	add    $0x10,%esp
80107814:	eb b1                	jmp    801077c7 <copyuvm+0xb7>
  char *mem;

   

  if((d = setupkvm()) == 0)
    return 0;
80107816:	31 c0                	xor    %eax,%eax
80107818:	eb d1                	jmp    801077eb <copyuvm+0xdb>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010781a:	83 ec 0c             	sub    $0xc,%esp
8010781d:	68 a0 83 10 80       	push   $0x801083a0
80107822:	e8 49 8b ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107827:	83 ec 0c             	sub    $0xc,%esp
8010782a:	68 86 83 10 80       	push   $0x80108386
8010782f:	e8 3c 8b ff ff       	call   80100370 <panic>
80107834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010783a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107840 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107840:	55                   	push   %ebp
80107841:	89 e5                	mov    %esp,%ebp
80107843:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107846:	6a 00                	push   $0x0
80107848:	ff 75 0c             	pushl  0xc(%ebp)
8010784b:	ff 75 08             	pushl  0x8(%ebp)
8010784e:	e8 cd f7 ff ff       	call   80107020 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107853:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107855:	83 c4 10             	add    $0x10,%esp
80107858:	89 c2                	mov    %eax,%edx
8010785a:	83 e2 05             	and    $0x5,%edx
8010785d:	83 fa 05             	cmp    $0x5,%edx
80107860:	75 0e                	jne    80107870 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107862:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107867:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107868:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010786d:	c3                   	ret    
8010786e:	66 90                	xchg   %ax,%ax

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107870:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107872:	c9                   	leave  
80107873:	c3                   	ret    
80107874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010787a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107880 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 1c             	sub    $0x1c,%esp
80107889:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010788c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010788f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107892:	85 db                	test   %ebx,%ebx
80107894:	75 40                	jne    801078d6 <copyout+0x56>
80107896:	eb 70                	jmp    80107908 <copyout+0x88>
80107898:	90                   	nop
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801078a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801078a3:	89 f1                	mov    %esi,%ecx
801078a5:	29 d1                	sub    %edx,%ecx
801078a7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801078ad:	39 d9                	cmp    %ebx,%ecx
801078af:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801078b2:	29 f2                	sub    %esi,%edx
801078b4:	83 ec 04             	sub    $0x4,%esp
801078b7:	01 d0                	add    %edx,%eax
801078b9:	51                   	push   %ecx
801078ba:	57                   	push   %edi
801078bb:	50                   	push   %eax
801078bc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801078bf:	e8 6c cc ff ff       	call   80104530 <memmove>
    len -= n;
    buf += n;
801078c4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801078c7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801078ca:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801078d0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801078d2:	29 cb                	sub    %ecx,%ebx
801078d4:	74 32                	je     80107908 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801078d6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801078d8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801078db:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801078de:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801078e4:	56                   	push   %esi
801078e5:	ff 75 08             	pushl  0x8(%ebp)
801078e8:	e8 53 ff ff ff       	call   80107840 <uva2ka>
    if(pa0 == 0)
801078ed:	83 c4 10             	add    $0x10,%esp
801078f0:	85 c0                	test   %eax,%eax
801078f2:	75 ac                	jne    801078a0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801078f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801078f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801078fc:	5b                   	pop    %ebx
801078fd:	5e                   	pop    %esi
801078fe:	5f                   	pop    %edi
801078ff:	5d                   	pop    %ebp
80107900:	c3                   	ret    
80107901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107908:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010790b:	31 c0                	xor    %eax,%eax
}
8010790d:	5b                   	pop    %ebx
8010790e:	5e                   	pop    %esi
8010790f:	5f                   	pop    %edi
80107910:	5d                   	pop    %ebp
80107911:	c3                   	ret    
