#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static void* heap = (void*)(0x4000);
static void* scrn = (void*)(0xbb80);
static int rc, len;

static t_ppcmd ppc;

void main(void)
{
  cls();
  printf("\nLoading SLAVE.BIN");
  
  len = 0;
  rc = loadfile("SLAVE.BIN", heap, &len);

  ppc.cmd = 0;
  ppc.flags = 0x83; // autoexec + 3 slaves;
  ppc.dst_addr = (void*)0x0600;
  ppc.length = len;
  ppc.src_addr = heap;
  
  pp_setup_master();
  printf("\nSending SLAVE.BIN (%d bytes)", len);
  pp_send(ppc);
  pp_reset();  
}

