#include <compat.h>
#include <oricexos.h>

#include "isr.h"
#include "vsync.h"
#include "mym.h"

static const unsigned char* scrn = (unsigned char*)0xbb80;
static const char title[] = "OricExos Multi-channel sound player";
static char* stat;

extern void kick(void);

void main(void)
{
  sei();
  reset_exos();
  
  memset(scrn, 0x10, 40*28);
  strcpy((char*)scrn+40, title);
  stat = (char*)scrn+40*(ipc.id+3);
  stat[0] = '0' + ipc.id;
  
  isr_open();
  vsync_open();
  vsync_open_flipper(mym_play_frame);

  mym_setup();
  mym_start();
  
  sei();
  vsync_on();
  kick();
  cli();

  while(1)
    sprintf(&stat[2],"POS:%5d   ", mym_frame_counter);

  mym_stop();
  
  vsync_off();
  vsync_close_flipper();
  vsync_close();
  
  isr_close();
  
  while(1);
}
