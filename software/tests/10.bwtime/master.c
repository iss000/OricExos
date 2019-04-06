#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static t_ppcmd ppc;

static const void* buffer = (const void*)0x4000;
static unsigned int len;
static int rc;

static void send_item(const char* name, void* dst, void* src, unsigned char flags);

void main(void)
{
  paper(0);
  ink(7);
  cls();

  send_item("PPLINK.BIN", (void*)PPLINK_ADDRESS, buffer, 0x87);
  send_item("SLAVE01.BIN", (void*)SLAVE_01_ADDRESS, buffer, 0x87);
  send_item("SLAVE.BIN", (void*)SLAVE_ADDRESS, buffer, 0x87);

  printf("\nMaster done.");
  for(rc=0;rc<10000;rc++);
  
  // jump to slave code
  rc = loadfile("SLAVE.BIN", (void*)SLAVE_ADDRESS, &len);
  ((void (*)(void))SLAVE_ADDRESS)();
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
