#include <compat.h>
#include <oricexos.h>

#ifdef __OSDK__
#define HEXFORMAT "x"
#else
#define HEXFORMAT "X"
#endif


static void (*dosrom)(void) = (void(*)(void))0x04f2;
static const unsigned char* scrn = (unsigned char*)0xbb80;
static unsigned char* ovl = (unsigned char*)0xc000;
static const char title[] = "Testing RAM Overlay";
static char* stat;
static unsigned char b;
static unsigned int i;
static unsigned int bad;

void main(void)
{
  sei();
  reset_exos();
  
  memset(scrn, 0x10, 40*28);
  strcpy((char*)scrn+40, title);

  stat = (char*)scrn + 40*(ipc.id+3);

  stat[0] = '0' + ipc.id;
  stat[1] = '.';
  stat[2] = ' ';
  stat[15] = 0x10;
  stat[16] = '>';
  stat[39] = '<';
  
  // light the led
  set_ram_on();
  // if master use fdc
  if(0==ipc.id)
    dosrom();

  bad = 0;
  while(1)
  {
    for(i=0x0000; i<0x4000; i++)
    {
      b = ovl[i];
      b ^= 0xff;
      ovl[i] = b;
      stat[4] = b == ovl[i]? 0x02 : 0x01;
      if( b == ovl[i] )
      {
        sprintf(stat+5,"PASS $%"HEXFORMAT, ovl+i);
      }
      else
      {
        sprintf(stat+5,"FAIL $%"HEXFORMAT, ovl+i);
        stat[17+bad] ^= 0x80;
        bad++;
        if(bad == 39-17)
          bad = 0;
      }
      stat[15] = 0x10;
    }
  }
}
