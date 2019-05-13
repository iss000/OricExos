#include <compat.h>
#include <oricexos.h>

static void (*dosrom)(void) = (void(*)(void))0x04f2;
static unsigned char* scrn = (unsigned char*)0xbb80;

static int i, x, y;
static unsigned char mask = 0x08;

void main(void)
{
  sei();
  reset_exos();
  
  memset(scrn, 0x10, 40*28);
  sprintf((char*)scrn,"EXOS %s%d", 
          ipc.id==0? "":
          ipc.id==1? " ":
          ipc.id==2? "  ":"   ",
          ipc.id
         );

  sprintf((char*)scrn+40*3+5,"0 1 2 3 4 5 6 7 8 9 A B C D E F");
          
  // MSB - Oric0, LSB Oric3
  mask >>= ipc.id;

  for(y=3, i = 0x11; y<26; y += 3, i++)
  {
    for(x=0; x<16; x++)
    {
      scrn[(y+1)*40+2*x+4] = (x & mask)? i : 0x10;
      scrn[(y+1)*40+2*x+5] = (x & mask)? i : 0x10;
      scrn[(y+2)*40+2*x+4] = (x & mask)? i : 0x10;
      scrn[(y+2)*40+2*x+5] = (x & mask)? i : 0x10;
      scrn[(y+3)*40+2*x+4] = (x & mask)? i : 0x10;
      scrn[(y+3)*40+2*x+5] = (x & mask)? i : 0x10;
    }
  }
  
  while(1)
  {
    set_mix_b();
    sprintf((char*)scrn+3*20,"\x07MIXER: R-2R  ");
    set_ram_on();
    sleep(0xffff);
    sleep(0xffff);
    set_mix_a();
    sprintf((char*)scrn+3*20,"\x07MIXER: DIRECT");
    set_ram_off();
    sleep(0xffff);
    sleep(0xffff);
  }
}
