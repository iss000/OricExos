#include <compat.h>
#include <oricexos.h>

static const unsigned char* scrn = (unsigned char*)0xbb80;
static const char title[] = "Bitcoin miner for OricExes";
static char* stat;

void main(void)
{
  sei();
  reset_exos();
  
  memset(scrn, 0x10, 40*28);
  strcpy((char*)scrn+40, title);

  stat = (char*)scrn + 40*(ipc.id*4+3);

  stat[0] = '0' + ipc.id;

  while(1)
  {
    
  }
}
