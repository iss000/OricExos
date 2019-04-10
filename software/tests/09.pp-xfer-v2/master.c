#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static t_ppcmd ppc;

static void* slave_buffer = (void*)SLAVE_ADDRESS;
static unsigned int len;
static int rc;

void main(void)
{
  reset_exos();
  
  paper(0);
  ink(7);
  cls();
  
  len = 0;
  printf("\n\n\n\n\n\n\n\n\n\nLoading SLAVE.COM");
  rc = loadfile("SLAVE.COM", slave_buffer, &len);
  
  ppc.cmd = 0;
  ppc.flags = (PP_AUTO|PP_SLAVEALL); // autoexec + 3 slaves;
  ppc.dst_addr = ppc.src_addr = slave_buffer;
  ppc.length = len;
  
  printf("\nSending SLAVE.COM (%d%d bytes)", len/100, len%100);
  pp_send(&ppc);
  printf("\nMaster done.");
  
  // jump to slave code
  ((void (*)(void))slave_buffer)();
}
