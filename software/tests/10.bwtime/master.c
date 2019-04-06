#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static t_ppcmd ppc;

static void* slave_buffer = (void*)SLAVE_ADDRESS;
static int rc, len;

void main(void)
{
  paper(0);
  ink(7);
  cls();
  
  len = 0;
  printf("\n\n\n\n\n\nLoading SLAVE.BIN");
  rc = loadfile("SLAVE.BIN", slave_buffer, &len);
  
  ppc.cmd = 0;
  ppc.flags = 0x87; // autoexec + 3 slaves;
  ppc.dst_addr = (void*)START_ADDRESS;
  ppc.length = len;
  ppc.src_addr = slave_buffer;

  printf("\nSending SLAVE.BIN (%d bytes)", len);
  pp_send(&ppc);
  printf("\nMaster done.");
  
  for(rc=0;rc<10000;rc++);
  
  // jump to slave code
  ((void (*)(void))slave_buffer)();
}
