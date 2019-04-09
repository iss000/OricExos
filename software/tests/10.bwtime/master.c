#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

#define statline  ((char*)(0xbb80+27*40))

static t_ppcmd ppc;

typedef struct s_item {
  char *name;
  unsigned int address;
  unsigned char flags;
} t_item, *p_item;

static t_item slave_items[] = 
{
  { "PPLINK.COM", PPLINK_ADDRESS, 0x87 },
  { "MOVIE01.BIN", MOVIE_ADDRESS, 0x01 },
  { "MOVIE02.BIN", MOVIE_ADDRESS, 0x02 },
  { "MOVIE03.BIN", MOVIE_ADDRESS, 0x04 },
  { "SPLAYER.COM", SPLAYER_ADDRESS, 0x87 },
};

static const void* buffer = (const void*)MOVIE_ADDRESS;
static unsigned int len;
static int i, rc;

static void send_item(const char* name, void* dst, void* src, unsigned char flags);

void main(void)
{
  reset_exos();
  
  paper(0);
  ink(7);
  cls();
  
  hires();
  
  for(i=0; i<sizeof(slave_items)/sizeof(t_item); i++) {
    send_item(slave_items[i].name, (void*)slave_items[i].address, buffer, slave_items[i].flags);
  }
  
  memset(statline, 0x20, 40);
  sprintf(statline, "\x02Loading\x07MOVIE00.BIN");
  rc = loadfile("MOVIE00.BIN", (void*)MOVIE_ADDRESS, &len);
  
  memset(statline, 0x20, 40);
  sprintf(statline, "\x06Running\x07MPLAYER.COM");
  execfile("!MPLAYER.COM");
}

static void send_item(const char* name, void* dst, void* src, unsigned char flags)
{
  len = 0;
  memset(statline, 0x20, 40);
  sprintf(statline, "\x02Loading\x07%s", name);
  rc = loadfile(name, src, &len);
  
  ppc.cmd = 0;
  ppc.flags = flags;
  ppc.dst_addr = dst;
  ppc.src_addr = src;
  ppc.length = len;
  
  memset(statline, 0x20, 40);
  sprintf(statline, "\x03Sending\x07%s %d%d bytes ->", name, len/100, len%100);
  pp_send(&ppc);
}
