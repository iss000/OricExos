#ifndef __LIBSEDORIC_H__
#define __LIBSEDORIC_H__

#ifndef ASSEMBLER
extern const char* sed_fname;
extern void* sed_begin;
extern void* sed_end;
extern unsigned int sed_size;
extern int sed_err;

void execfile(const char* fname)
{
  extern void sed_execfile(void);
  sed_fname = fname;
  sed_execfile();    
}

int savefile(const char* fname, void* buf, unsigned int len) 
{
    extern void sed_savefile(void);
    sed_fname = fname;
    sed_begin = buf;
    sed_end = (char*)sed_begin+len-1;
    sed_size = len;
    sed_savefile();    
    return sed_err;
}

int loadfile(const char* fname, void* buf, unsigned int* len)
{
    extern void sed_loadfile(void);
    sed_fname = fname;
    sed_begin = buf;
    sed_loadfile();    
    *len = sed_size;
    return sed_err;
}
#endif

#endif /* __LIBSEDORIC_H__ */
