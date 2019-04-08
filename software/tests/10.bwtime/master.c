#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static t_ppcmd ppc;

typedef struct s_item {
  char *name;
  unsigned int address;
  unsigned char flags;
} t_item, *p_item;

static t_item slave_items[] = 
{
  { "PPLINK.BIN", PPLINK_ADDRESS, 0x87 },
  { "MOVIE01.BIN", MOVIE_ADDRESS, 0x01 },
  { "MOVIE02.BIN", MOVIE_ADDRESS, 0x02 },
  { "MOVIE03.BIN", MOVIE_ADDRESS, 0x04 },
  { "SLAVE01.BIN", SLAVE_01_ADDRESS, 0x87 },
};

static const void* buffer = (const void*)MOVIE_ADDRESS;
static unsigned int len;
static int i, rc;

static void send_item(const char* name, void* dst, void* src, unsigned char flags);

void main(void)
{
  paper(0);
  ink(7);
  cls();
  
  for(i=0; i<sizeof(slave_items)/sizeof(t_item); i++) {
    send_item(slave_items[i].name, (void*)slave_items[i].address, buffer, slave_items[i].flags);
  }

  printf("\nMaster done.");
  for(rc=0;rc<10000;rc++);
  
  rc = loadfile("MOVIE00.BIN", (void*)MOVIE_ADDRESS, &len);

  // jump to slave code
  //((void (*)(void))SLAVE_ADDRESS)();
}

static void send_item(const char* name, void* dst, void* src, unsigned char flags)
{
  len = 0;
  printf("\nLoading %s", name);
  rc = loadfile(name, src, &len);
  
  ppc.cmd = 0;
  ppc.flags = flags;
  ppc.dst_addr = dst;
  ppc.src_addr = src;
  ppc.length = len;
  
  printf("\nSending %s (%d bytes)", name, len);
  pp_send(&ppc);
}
