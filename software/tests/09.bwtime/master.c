#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static void* heap = (void*)(0x4000);
static void* scrn = (void*)(0xbb80);
static int rc, len;

// static t_ppcmd ppc;
#define ppc _pp_cmd_buf

void main(void)
{
  paper(3);
  ink(4);
  cls();
  
  len = 0;
  printf("\nLoading SLAVE.BIN");
  rc = loadfile("SLAVE.BIN", heap, &len);
  
  ppc.cmd = 0;
  ppc.flags = 0x87; // autoexec + 3 slaves;
  ppc.dst_addr = (void*)START_ADDRESS; // i.e. 0x0600;
  ppc.length = len;
  ppc.src_addr = heap;

  printf("\nSending SLAVE.BIN (%d bytes)", len);
  
  sei();
  pp_setup_master();
  _pp_send(); // pp_send(&ppc);
  pp_reset();  
  cli();
  
  paper(0);
  ink(7);
  cls();
  
  printf("Master done.");
}
