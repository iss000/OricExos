#ifndef __VSYNC_H__
#define __VSYNC_H__

#define _50HZ_T1  19966
#define _60HZ_T1  16894

#ifdef ASSEMBLER

#else

typedef void (*vsync_flipper_callback)(void);
extern vsync_flipper_callback vsync_flipper;
extern unsigned char vsync_freq;
extern unsigned char vsync_type;
extern unsigned int vsync_id;

int vsync_check(void);
void vsync_wait(void);

void vsync_open(void);
void vsync_close(void);

void vsync_on(void);
void vsync_off(void);

#define vsync_open_flipper(x) {vsync_flipper=((vsync_flipper_callback)(x));}
#define vsync_close_flipper() {vsync_off();}

#endif

#endif /* __VSYNC_H__ */
