#include <compat.h>
#include <oricexos.h>

#include "isr.h"
#include "vsync.h"
#include "mym.h"

static const unsigned char* scrn = (unsigned char*)0xbb80;
static const char title[] = "\x10\x07  OricExos 9-channel Sound Tracker    ";
static char* stat;

extern void kick(void);

void main(void)
{
  sei();
  reset_exos();
  
  memset(scrn, 0x10, 40*28);
  strcpy((char*)scrn+40, title);
  memset((char*)scrn+2*40, 95, 40);
  
  stat = (char*)scrn+40*(ipc.id+5);
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

  while(ipc.id != 0)
    sprintf(&stat[4],"POS:%d     ", mym_frame_counter);

  mym_stop();
  vsync_off();
  vsync_close_flipper();
  vsync_close();
  
  sprintf(&stat[4],"IDLE        ", mym_frame_counter);
  while(1);
  
  //isr_close();
}
