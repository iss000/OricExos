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

// --------------------------
extern p_ppcmd _pp_cmd_ptr;

// --------------------------
// pp flags
#define PP_AUTO     (0x80)
#define PP_SLAVE1   (0x01)
#define PP_SLAVE2   (0x02)
#define PP_SLAVE3   (0x04)
#define PP_SLAVEALL (PP_SLAVE1|PP_SLAVE2|PP_SLAVE3)


// --------------------------
void _pp_send(void);
#define pp_send(ppcmd) (_pp_cmd_ptr=(p_ppcmd)ppcmd,_pp_send())

// --------------------------
void _pp_receive(void);
#define pp_receive(ppcmd) (_pp_cmd_ptr=(p_ppcmd)ppcmd,_pp_receive())

#endif

#endif /* __PP_H__ */
