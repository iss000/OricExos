#include <compat.h>
#include <oricexos.h>

static const unsigned char* scrn = (unsigned char*)0xbb80;
static const char title[] = "\x10\x07 Bitcoin miner for OricExos";
static const char info[] =  "\x10\x02 Original code 8BITCOIN by option8";
static const char url[] =   "\x10\x03 https://github.com/option8/8BITCOIN";
static char* stat;

static void(*hash_code)(void) = (void(*)(void))HASH_ADDRESS;

void main(void)
{
  sei();
  reset_exos();

  memset(scrn, 0x10, 40*28);
  strcpy((char*)scrn+0*40, title);
  strcpy((char*)scrn+3*40, info);
  strcpy((char*)scrn+4*40, url);
  
  stat = (char*)scrn + 40*(ipc.id*4+12);

  stat[0] = '0' + ipc.id;

  while(1)
  {
    hash_code();
  }
}
