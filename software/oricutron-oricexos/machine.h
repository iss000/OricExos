/*
**  Oricutron
**  Copyright (C) 2009-2014 Peter Gordon
**
**  This program is free software; you can redistribute it and/or
**  modify it under the terms of the GNU General Public License
**  as published by the Free Software Foundation, version 2
**  of the License.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program; if not, write to the Free Software
**  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
**
**  Oric machine stuff
*/
#include <stdio.h>

#include "keyboard.h"

enum
{
  DRV_NONE = 0,
  DRV_JASMIN,
  DRV_MICRODISC,
  DRV_BD500,
  DRV_PRAVETZ,
};

enum
{
  MACH_ORIC1 = 0,
  MACH_ORIC1_16K,
  MACH_ATMOS,
  MACH_TELESTRAT,
  MACH_PRAVETZ,
  MACH_LAST
};

enum
{
  EM_PAUSED = 0,
  EM_RUNNING,
  EM_DEBUG,
  EM_MENU,
  EM_PLEASEQUIT
};

enum
{
  TELEBANK_RAM,
  TELEBANK_ROM,
  TELEBANK_HALFNHALF
};

enum
{
  KMAP_QWERTY = 0,
  KMAP_AZERTY,
  KMAP_QWERTZ
};

/* Return values from detect_image_type */
enum
{
  IMG_I_DUNNO = 0,
  IMG_ATMOS_MICRODISC,
  IMG_ATMOS_JASMIN,
  IMG_TELESTRAT_DISK,
  IMG_BD500_DISK,
  IMG_PRAVETZ_DISK,
  IMG_GUESS_MICRODISC,
  IMG_SNAPSHOT,
  IMG_TAPE
};

struct telebankinfo
{
  unsigned char type;
  unsigned char *ptr;
};

struct exosstat
{
  SDL_bool map:1;
  SDL_bool ppenable:1;
  SDL_bool ppdir:1;
  SDL_bool mix:1;
};

struct machine
{
  int exos_id;
  struct machine* exos[4];
  struct exosstat exos_stat;
  SDL_bool exos_gammacorrection;
  
  Uint8 type;
  struct m6502 cpu;
  struct via via;
  struct ay8912 ay;
  unsigned int memsize;
  unsigned char *mem;
  unsigned char *rom;
  int emu_mode;

  struct symboltable romsyms;
  struct symboltable usersyms;
  struct symboltable *disksyms;

  struct telebankinfo tele_bank[8];
  struct symboltable  tele_banksyms[8];
  struct via          tele_via;
  struct acia         tele_acia;
  struct ch376        *ch376;
  SDL_bool            ch376_activated;
  int                 tele_currbank;
  unsigned char       tele_banktype;

  // Video
  int vid_start;           // Start drawing video
  int vid_end;             // Stop drawing video
  int vid_maxrast;         // Number of raster lines
  int vid_raster;          // Current rasterline
  int vid_offset;          // Current T1 counter position

  int vid_fg_col;
  int vid_bg_col;
  Uint16 *vid_bitptr;
  Uint16 *vid_inv_bitptr;
  int vid_mode;
  int vid_freq;
  int vid_textattrs;
  int vid_blinkmask;
  int vid_chline;
  int frames;
  SDL_bool vid_dirty[224];
  void (*vid_block_func)( struct machine *, SDL_bool, int, int );

  int overclockmult, overclockshift;

  int cyclesperraster;
  int vsync;

  SDL_bool vid_double;
  SDL_bool romdis, romon, rom16;
  SDL_bool vsynchack;

  unsigned short vid_addr;
  unsigned char *vid_ch_data;
  unsigned char *vid_ch_base;

  Uint8  *scrpt;
  Uint8  *scr;

  Uint16 vidbases[4];

  int drivetype;
  struct wd17xx    wddisk;
  struct microdisc md;
  struct bd500     bd;
  struct jasmin    jasmin;
  struct pravetz   pravetz;
  char diskname[MAX_DRIVES][32];
  SDL_bool diskautosave;
  SDL_bool auto_jasmin_reset;

  FILE *prf;
  int prclose, prclock;

  unsigned char tapebit, tapeout, tapeparity;
  int tapelen, tapeoffs, tapecount, tapetime, tapedupbytes, tapehdrend, tapedelay;
  unsigned char *tapebuf;
  SDL_bool tapemotor, tapenoise, tapeturbo, autorewind, autoinsert;
  SDL_bool tapeturbo_forceoff;
  SDL_bool symbolsautoload, symbolscase;
  SDL_bool rawtape;
  int nonrawend, tapehitend;
  char lasttapefile[20];
  char tapename[32];
  int tapeturbo_syncstack;
  FILE *tapecap;
  int tapecapcount;
  int tapecaplastbit;
  int tapecapsavbytes;
  int tapecapsavoffs;

  // Filename decoding patch addresses
  int pch_fd_cload_getname_pc;
  int pch_fd_csave_getname_pc;
  int pch_fd_store_getname_pc;
  int pch_fd_recall_getname_pc;
  int pch_fd_getname_addr;
  SDL_bool pch_fd_available;

  // Turbo tape patch addresses
  int pch_tt_getsync_pc;
  int pch_tt_getsync_end_pc;
  int pch_tt_getsync_loop_pc;
  int pch_tt_readbyte_pc;
  int pch_tt_readbyte_end_pc;
  int pch_tt_readbyte_storebyte_addr;
  int pch_tt_readbyte_storezero_addr;
  int pch_tt_putbyte_pc;
  int pch_tt_putbyte_end_pc;
  int pch_tt_csave_end_pc;
  int pch_tt_store_end_pc;
  int pch_tt_writeleader_pc;
  int pch_tt_writeleader_end_pc;
  SDL_bool pch_tt_readbyte_setcarry;
  SDL_bool pch_tt_available;
  SDL_bool pch_tt_save_available;
  FILE *tsavf;

  Sint32 keymap;

  SDL_bool aratio, hstretch, scanlines, palghost, pravdiskautoboot;
  Sint32 sw_depth; // Bit depth of the emulator video mode

  int rendermode;
  void (*render_begin)(struct machine *);
  void (*render_end)(struct machine *);
  void (*render_textzone_alloc)(struct machine *, int);
  void (*render_textzone_free)(struct machine *, int);
  void (*render_textzone)(struct machine *, int);
  void (*render_clear_area)( int, int, int, int );
  void (*render_gimg)(int, Sint32, Sint32);
  void (*render_gimgpart)(int, Sint32, Sint32, Sint32, Sint32, Sint32, Sint32);
  void (*render_alloc_textzone)(struct machine *, struct textzone *);
  void (*render_free_textzone)(struct machine *, struct textzone *);
  void (*render_video)(struct machine *, SDL_bool);
  SDL_bool (*render_togglefullscreen)(struct machine *oric);
  SDL_bool (*init_render)(struct machine *);
  void (*shut_render)(struct machine *);

  char popupstr[40];
  int popuptime;
  SDL_bool newpopupstr;

  char statusstr[40];
  SDL_bool newstatusstr;

  int statusbar_mode;

  int rampattern;

  Sint32 joy_iface;
  Sint32 joymode_a, joymode_b;
  Sint32 telejoymode_a, telejoymode_b;
  SDL_COMPAT_KEY kbjoy1[7], kbjoy2[7];

  SDL_bool printenable;
  SDL_bool printfilter;
  SDL_bool dcadjust;

  SDL_bool lightpen;
  Uint8  lightpenx, lightpeny;
  unsigned char (*read_not_lightpen)(struct m6502 *,Uint16);

  Uint8  porta_joy, porta_ay;
  SDL_bool porta_is_ay;

  SDL_Joystick *sdljoy_a, *sdljoy_b;

  struct keyboard_mapping keyboard_mapping;
  SDL_bool show_keyboard;
  SDL_bool define_mapping;
  SDL_bool sticky_mod_keys;

  int aciaoffset;
  int aciabackend;
  int aciabackendcfg;
  int aciabackendcfgport;
  int aciabackendcfgdomain;
  char aciabackendname[ACIA_BACKEND_NAME_LEN];
};

void setromon( struct machine *oric );
void setemumode( struct machine *oric, struct osdmenuitem *mitem, int mode );
void video_show( struct machine *oric );
SDL_bool emu_event( SDL_Event *ev, struct machine *oric, SDL_bool *needrender );

void preinit_machine( struct machine *oric );
void load_diskroms( struct machine *oric );
SDL_bool init_machine( struct machine *oric, int type, SDL_bool nukebreakpoints );
void shut_machine( struct machine *oric );
void setdrivetype( struct machine *oric, struct osdmenuitem *mitem, int type );
void swapmach( struct machine *oric, struct osdmenuitem *mitem, int which );
SDL_bool isram( struct machine *oric, unsigned short addr );

void clear_patches( struct machine *oric );

unsigned char lightpen_read( struct m6502 *cpu, unsigned short addr );

int detect_image_type(char *filename);
