#ifndef __MYM_h__
#define __MYM_h__

void mym_setup(void);
void mym_start(void);
void mym_stop(void);
void mym_seek_frame(void);
void mym_play_frame(void);

extern char mym_playing;
extern unsigned int mym_frame_counter;

#endif /* __MYM_h__ */
