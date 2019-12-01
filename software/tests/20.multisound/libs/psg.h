#ifndef __PSG_H__
#define __PSG_H__

#ifdef ASSEMBLER
#else

extern unsigned char psg_reg;
extern unsigned char psg_val;

void psg(void);
void psg_stop(void);

#define psg_set(r,v)  {psg_reg=(r);psg_val=(v);psg();}
#define psg_vola(v)   {psg_reg=(0x08);psg_val=(v);psg();}
#define psg_volb(v)   {psg_reg=(0x09);psg_val=(v);psg();}
#define psg_volc(v)   {psg_reg=(0x0a);psg_val=(v);psg();}
#define psg_vol(v)    {psg_vola(v);psg_volb(v);psg_volc(v);}

#endif

#endif /* __PSG_H__ */
