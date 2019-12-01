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
  { "CHARSET.BIN", 0xb400, PP_SLAVEALL },
  { "HASH.BIN", HASH_ADDRESS, PP_SLAVEALL },
  { "SLAVE.COM", SLAVE_ADDRESS, PP_AUTO|PP_SLAVEALL },
};

static void(*slave_code)(void) = (void(*)(void))SLAVE_ADDRESS;

static unsigned int len;
static void* buffer;
static int i;

static void load_item(const char* name, void* src);
static void send_item(const char* name, void* dst, void* src, unsigned char flags);

void main(void)
{
  reset_exos();
  sleep(32767);
  
  paper(0);
  ink(7);
  cls();

  for(i=0; i<sizeof(slave_items)/sizeof(t_item); i++) 
  {
    send_item(slave_items[i].name, 
              (void*)slave_items[i].address, 
              (void*)slave_items[i].address, 
              slave_items[i].flags);
  }
  
  // jump to slave code
  slave_code();
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
  
  sprintf(statline, "\x03SENDING\x07%s %d%d bytes >", name, len/100, len%100);
  pp_send(&ppc);
  memset(statline, 0x20, 40);
}
