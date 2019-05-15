/* =========
 * bmpslicer
 * slices bmp files
 * 
 * © 2019 iss
 * free for personal use
 * 
*/

/*
 * Usage:
 *   bmpslicer <input.bmp> <output.bmp> <oric id: 0|1|2|3> <mixer type: 0|1>
 * 
 * NOTE: this tools is intended for scripted usage, so:
 * - no inteligent parameter parsing
 * - no error reporting
 * - support only 24-bit bmp ver.3
 *
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static FILE *f;
static unsigned char *buf;
static unsigned char level, inlevels[256];
static unsigned char mask = 0x08;
static unsigned char oric;
static int width, height, i, n, len;


// leveles with posterize 5
// static unsigned char levels[4] = { 64, 127, 191, 255 };

// leveles with posterize 6
static unsigned char levels[4] = { 51, 102, 153, 204 };

int main(int argc, char* argv[])
{
  buf = malloc(54);
  if(!buf)
    return -1;
  
  f = fopen(argv[1], "rb");  
  if (!f) 
    return -1;

  fread(buf, 1, 54, f);
  n=0,i=4;
  while(i-->0)
    n = (n << 8) + buf[0x0a+i];
  
  if(54 != n)
  {
    fclose(f);
    return -3;
  }
  
  width=0,i=4;
  while(i-->0)
    width = (width << 8) + buf[0x12+i];
  
  height=0,i=4;
  while(i-->0)
    height = (height << 8) + buf[0x16+i];
  
  /* DEBUG:
  printf("w:%d, h:%d\n", width, height); return 0; */
  
  len = width*height*3+54;
  buf = realloc(buf, len);
  if(!buf)
  {
    fclose(f);
    return -1;
  }
  
  fread(buf+54, 1, len-54, f);

  oric = 3 & atoi(argv[3]);
  mask >>= oric;
  
  n = 1 & atoi(argv[4]);

  if(1 == n)
  {
    /* process mixer B - 16 level */
    
    for(i=54; i<len; i++)
      buf[i] = (mask & (buf[i]/16)) ? 0xff : 0x00;
  }
  else
  {
    /* process mixer A - 5 level */
  
    /* DEBUG: dumps actual levels used in
     * the pre-posterized image
     * /
    memset(inlevels, 0, sizeof(inlevels));
    for(i=54; i<len; i++) {
      if(inlevels[buf[i]] < 0xff)
        inlevels[buf[i]]++;
    }
    printf("\n======================\n");
    for(i=0; i<sizeof(inlevels); i++) {
      if(0 < inlevels[i])
        printf("%4d %4d\n", i, inlevels[i]);
    }
    */
  
    level = levels[oric];
    for(i=54; i<len; i++)
      buf[i] = level <= buf[i] ? 0xff : 0x00;
  }
  
  f = fopen(argv[2], "wb");
  if (!f) 
    return -2;
  fwrite(buf, 1, len, f);
  fclose(f);
  
  return 0;
}
