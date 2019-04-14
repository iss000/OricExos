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
  { "PPLINK.COM", PPLINK_ADDRESS, PP_AUTO|PP_SLAVEALL },
  { "MOVIE03.BIN", MOVIE_ADDRESS, PP_SLAVE3 },
  { "MOVIE02.BIN", MOVIE_ADDRESS, PP_SLAVE2 },
  { "MOVIE01.BIN", MOVIE_ADDRESS, PP_SLAVE1 },
  { "SPLAYER.COM", SPLAYER_ADDRESS, PP_AUTO|PP_SLAVEALL },
};

static const void* buffer = (const void*)MOVIE_ADDRESS;
static unsigned int len;
static int i;

static void load_item(const char* name, void* src);
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
  
  load_item("MOVIE00.BIN", (void*)MOVIE_ADDRESS);
  
  sprintf(statline, "\x06RUNNING\x07MPLAYER.COM");
  execfile("!MPLAYER.COM");
}

static void load_item(const char* name, void* src)
{
  sprintf(statline, "\x02LOADING\x07%s", name);
  loadfile(name, src, &len);
  memset(statline, 0x20, 40);
}

static void send_item(const char* name, void* dst, void* src, unsigned char flags)
{
  load_item(name, src);
  
  ppc.cmd = 0;
  ppc.flags = flags;
  ppc.dst_addr = dst;
  ppc.src_addr = src;
  ppc.length = len;
  
  sprintf(statline, "\x03SENDING\x07%s %d bytes >", name, len);
  pp_send(&ppc);
  memset(statline, 0x20, 40);
}
