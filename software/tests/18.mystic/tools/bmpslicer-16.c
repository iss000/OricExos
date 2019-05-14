#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define W 96
#define H 96

static unsigned char buf[W*H*3+54];
static unsigned char inlevels[256];
static unsigned char mask = 0x08;
static unsigned char oric;
static int i;

int main(int argc, char* argv[])
{
  FILE *f = fopen(argv[1], "rb");
  if (!f) 
    return -1;
  fread(buf, 1, sizeof(buf), f);
  fclose(f);
  
  oric = atoi(argv[3]);
  mask >>= oric;
  
  #if 0
  memset(inlevels, 0, sizeof(inlevels));
  for(i=54; i<sizeof(buf); i++) {
    if(inlevels[buf[i]] < 0xff) {
      inlevels[buf[i]]++;
    }
  }
  
  // this code dumps actual levels used in 
  // the pre-posterized image
  printf("\n======================\n");
  for(i=0; i<sizeof(inlevels); i++) {
    if(0 < inlevels[i]) {
      printf("%4d %4d\n", i, inlevels[i]);
    }
  }
#endif

  for(i=54; i<sizeof(buf); i++)
    buf[i] = (mask & (buf[i]/16)) ? 0xff : 0x00;
  
  f = fopen(argv[2], "wb");
  if (!f) 
    return -2;
  fwrite(buf, 1, sizeof(buf), f);
  fclose(f);
  
  return 0;
}
