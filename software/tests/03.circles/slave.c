// Original code Dbug

// 10 ID=2^PEEK(#EDB0)
// 20 IF ID>8 THEN END
// 30 HIRES:PAPER 0:INK ID
// 40 CURSET 120,100,3
// 50 FOR I=1 TO 99 STEP 5
// 60   IF C AND ID THEN CIRCLE I,2
// 70   C=C+1
// 80 NEXT I

#include <lib.h>

static unsigned char oric_id,id,c;
static int i;

void main(void)
{
  oric_id = 0x03 & peek(0xEDB0);
//   id = 1 << oric_id;
  id = 1 + oric_id;
  if(id<8)
  {
    hires();
    paper(0);
    ink(id);
    curset(120,100,3);
    for(c=0,i=1; i<99; i+=5,c++)
      if(c & id)
        circle(i,2);
  }
  
  for(i=0; i<oric_id; i++)
    printf("\n");
  
  printf("Oric #%d halted", oric_id);
  while(1);
}
