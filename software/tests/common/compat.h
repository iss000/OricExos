#ifndef __COMPAT_H__
#define __COMPAT_H__

/* Compatibility */

/* ========================== */
#ifdef ASSEMBLER
/* ========================== */

#ifndef __CC65__
/* __OSDK__ */
#define __TOOLCHAIN__   __OSDK__
#ifndef __OSDK__
#define __OSDK__
#endif

#define export(x)

#define align(x)   .dsb ((x)-(* & ((x)-1))),'?'
#define page       align(256)

#define return(x) .byt $a2, <x, $a9, >x, $60
#define retbyt(x) .byt $ae, <x, >x, $a9, $00, $60
#define retwrd(x) .byt $ae, <x, >x, $ad, <(x+1), >(x+1), $60

#else
/* __CC65__ */
#define __TOOLCHAIN__   __CC65__

#define export(x)  .export x

#define align(x)   .align (x)
#define page       align(256)

#define return(x) .byt $a9, <x, $a2, >x, $60
#define retbyt(x) .byt $a2, $00, $ad, <x, >x, $60
#define retwrd(x) .byt $ad, <x, >x, $ae, <(x+1), >(x+1), $60

#endif

#define itmp0        $b0
#define itmp1        $b1
#define itmp2        $b2
#define itmp3        $b3
#define itmp4        $b4
#define itmp5        $b5
#define itmp6        $b6
#define itmp7        $b7

#define utmp0        $b8
#define utmp1        $b9
#define utmp2        $ba
#define utmp3        $bb
#define utmp4        $bc
#define utmp5        $bd
#define utmp6        $be
#define utmp7        $bf

#define A_FWBLACK    0
#define A_FWRED      1
#define A_FWGREEN    2
#define A_FWYELLOW   3
#define A_FWBLUE     4
#define A_FWMAGENTA  5
#define A_FWCYAN     6
#define A_FWWHITE    7
#define A_BGBLACK    16
#define A_BGRED      17
#define A_BGGREEN    18
#define A_BGYELLOW   19
#define A_BGBLUE     20
#define A_BGMAGENTA  21
#define A_BGCYAN     22
#define A_BGWHITE    23
#define A_STD        8
#define A_ALT        9
#define A_STD2H      10
#define A_ALT2H      11
#define A_STDFL      12
#define A_ALTFL      13
#define A_STD2HFL    14
#define A_ALT2HFL    15
#define A_TEXT60     24
#define A_TEXT50     26
#define A_HIRES60    28
#define A_HIRES50    30

/* ========================== */
#else /* ASSEMBLER */
/* ========================== */
#ifndef __CC65__
/* __OSDK__ */
#define TOOLCHAIN       "OSDK"
#define __TOOLCHAIN__   __OSDK__
#ifndef __OSDK__
#define __OSDK__
#endif
#include <lib.h>

#define __cdecl__
#define __fastcall__

#else
/* __CC65__ */
#define TOOLCHAIN       "CC65"
#define __TOOLCHAIN__   __CC65__
#include <atmos.h>
#include <ctype.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#undef putc

void __fastcall__ cls(void);
void __fastcall__ text(void);
void __fastcall__ lores0(void);
void __fastcall__ lores1(void);
void __fastcall__ hires(void);
void __fastcall__ paper(int val);
void __fastcall__ ink(int val);
void __fastcall__ kbdclick1(void);
void __fastcall__ kbdclick2(void);
char __fastcall__ key(void);
int  __fastcall__ get(void); /* get character without echoing */

/* This gets and sets some system flags    */
/* Use the #defines below to set the flags */

#define getflags()  peek(0x26a)
#define setflags(x) poke(0x26a,x)

#define F_CURSOR     0x01  /* Cursor on             (ctrl-q) */
#define F_SCREEN     0x02  /* Printout to screen on (ctrl-s) */
#define F_NOKEYCLICK 0x08  /* Turn keyclick off     (ctrl-f) */
#define F_PROTECT    0x20  /* Protect columns 0-1   (ctrl-]) */

#define peek(addr)          ((unsigned char*)addr)[0]
#define poke(addr, val)     {((unsigned char*)addr)[0] = val;}

#define deek(addr)          ((unsigned int*)addr)[0]
#define doke(addr, val)     {((unsigned int*)addr)[0] = val;}


/* sedoric(): Please use the exclamation mark as well, e.g. sedoric("!DIR") */
/*            Bear in mind that this might well be broken. I don't know     */
/*            much about SEDORIC yet... No error handling! Anything wrong   */
/*            happens, and you get an error, and go back to the 'Ready'     */
/*            prompt. Can anyone fix things here? I declare my ignorance.   */

extern char* _sedoric_cmdptr;
extern void _sedoric(void);
#define sedoric(cmd)  { _sedoric_cmdptr = cmd; _sedoric(); }

/* Serial Attributes, curses style :-| */

#define A_FWBLACK    0
#define A_FWRED      1
#define A_FWGREEN    2
#define A_FWYELLOW   3
#define A_FWBLUE     4
#define A_FWMAGENTA  5
#define A_FWCYAN     6
#define A_FWWHITE    7
#define A_BGBLACK    16
#define A_BGRED      17
#define A_BGGREEN    18
#define A_BGYELLOW   19
#define A_BGBLUE     20
#define A_BGMAGENTA  21
#define A_BGCYAN     22
#define A_BGWHITE    23
#define A_STD        8
#define A_ALT        9
#define A_STD2H      10
#define A_ALT2H      11
#define A_STDFL      12
#define A_ALTFL      13
#define A_STD2HFL    14
#define A_ALT2HFL    15
#define A_TEXT60     24
#define A_TEXT50     26
#define A_HIRES60    28
#define A_HIRES50    30

#endif /* __CC65__ */

enum
{
  RET_OK = 0,
  RET_ERR,
};

#ifndef NULL
#define NULL    ((void*)0)
#endif /* NULL */

#ifndef abs
#define abs(x)  ((x<0)? (-(x)):(x))
#endif /* abs */

#ifndef STRINGIFY
#define STRINGIFY_(x) #x
#define STRINGIFY(x) STRINGIFY_(x)
#endif

#define mkptr(x)  ((void*)(x))

/* ========================== */
#endif /* ASSEMBLER */
/* ========================== */

#endif /* __COMPAT_H__ */
