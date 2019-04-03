#ifndef __PP_H__
#define __PP_H__

#ifdef ASSEMBLER

#else

// --------------------------
typedef struct s_ppcmd {
  unsigned char cmd;
  unsigned char flags;
  unsigned char* dst_addr;
  unsigned int length;
  unsigned char* src_addr;
} t_ppcmd, *p_ppcmd;

extern t_ppcmd _pp_cmd_buf;

// --------------------------
void pp_setup_master(void);
void pp_setup_slave(void);
void pp_reset(void);

// --------------------------
void _pp_send(void);
#define pp_send(ppcmd) (memcpy(&_pp_cmd_buf,(void*)ppcmd,sizeof(t_ppcmd)), _pp_send())

// --------------------------
void _pp_receive(void);
#define pp_receive(ppcmd) (memcpy(&_pp_cmd_buf,(void*)ppcmd,sizeof(t_ppcmd)), _pp_receive())

#endif

#endif /* __PP_H__ */
