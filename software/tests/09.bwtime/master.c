#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static void* heap = (void*)(0x4000);
static void* scrn = (void*)(0xbb80);
static int rc, len = 40;
static unsigned char buf[] = "0123456789012345678901234567890123456789";
static t_ppcmd ppc;

void main(void)
{
  paper(3);
  ink(4);
  cls();
  
  len = 0;
  printf("\nLoading SLAVE.BIN");
//   rc = loadfile("SLAVE.BIN", heap, &len);
  
//   ppc.cmd = 0;
//   ppc.flags = 0x87; // autoexec + 3 slaves;
//   ppc.dst_addr = (void*)START_ADDRESS; // i.e. 0x0600;
//   ppc.length = len;
//   ppc.src_addr = heap;

  ppc.cmd = 0;
  ppc.flags = 0x07; // autoexec + 3 slaves;
  ppc.dst_addr = (void*)scrn; // i.e. 0x0600;
  ppc.length = 40;
  ppc.src_addr = buf;

  
  printf("\nSending SLAVE.BIN (%d bytes)", len);
  
  pp_send(&ppc);
  
  paper(0);
  ink(7);
  cls();
  
  printf("\nMaster done.");
}
