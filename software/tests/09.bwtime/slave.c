#include <compat.h>
#include <oricexos.h>
#include <pp.h>

static void* heap = (void*)(0x4000);
static void* scrn = (void*)(0xbb80);

static t_ppcmd ppc;
static char id;

void main(void)
{
  cls();
  id = peek(id_addr)&0x03;
  printf("SLAVE %d running!", id);
  
  ppc.id = id;

  pp_setup_slave();
  pp_receive(&ppc);
  pp_reset();  
}
