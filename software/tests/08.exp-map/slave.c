#include <compat.h>
#include <oricexos.h>

static void (*dosrom)(void) = (void(*)(void))0x04f2;
static const unsigned char* scrn = (unsigned char*)0xbb80;
static unsigned char* ovl = (unsigned char*)0xc000;
static const char title[] = "Testing RAM Overlay";
static char* stat;
static unsigned char b;
static unsigned int i;


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
  
  if(0<ipc.id)
    set_ram_on();
  else
    dosrom();

  while(1)
  {
    for(i=0x0000; i<0x4000; i++)
    {
      b = ovl[i];
      b ^= 0xff;
      ovl[i] = b;
      stat[4] = b == ovl[i]? 0x02 : 0x01;
      sprintf(stat+5,"%s $%x", b == ovl[i]? "PASS":"FAIL", ovl+i);
    }
  }
}
