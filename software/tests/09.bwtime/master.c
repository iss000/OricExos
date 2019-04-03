#include <compat.h>
#include <oricexos.h>
#include <pp.h>

#include <libsedoric.h>

static void* heap = (void*)(0x4000);
static void* scrn = (void*)(0xbb80);
static int rc, len;

// static t_ppcmd ppc;

void main(void)
{
  paper(3);
  ink(4);
  cls();
  
  len = 0;
  //printf("\nLoading SLAVE.BIN");
  //rc = loadfile("SLAVE.BIN", heap, &len);

  _pp_cmd_buf.cmd = 0;
  _pp_cmd_buf.flags = 0x07; // 0x87; // autoexec + 3 slaves;
  _pp_cmd_buf.dst_addr = scrn;  //(void*)0x0600;
  _pp_cmd_buf.length = 25*4;
  _pp_cmd_buf.src_addr = scrn;  //heap;
  
  printf("\nSending SLAVE.BIN (%d bytes)", len);
  
  sei();
  pp_setup_master();
  _pp_send(); // pp_send(&ppc);
  pp_reset();  
  cli();
  
  paper(0);
  ink(7);
  cls();
}
