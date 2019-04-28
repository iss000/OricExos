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
**  Software rendering
*/

#include <stdlib.h>
#include <string.h>

#include "system.h"
#include "6502.h"
#include "via.h"
#include "8912.h"
#include "disk.h"
#include "gui.h"
#include "monitor.h"
#include "6551.h"
#include "machine.h"
#include "render_sw.h"
#include "ula.h"

static struct SDL_Surface *screen;
static Uint32 gpal[NUM_GUI_COLS];

static Uint32 pixel_size, offset_top;
static Uint32 pal[8*2]; // Palette
static Uint32 dpal[8*2];
static Uint8 *mgimg[NUM_GIMG];

extern SDL_bool fullscreen, hwsurface;
static SDL_bool needclr;
extern struct textzone *tz[NUM_TZ];
extern unsigned char sgpal[];
extern Uint8 oricpalette[];
extern struct guiimg gimgs[NUM_GIMG];
extern SDL_bool refreshstatus;

// Our "lovely" hand-coded font
extern unsigned char thefont[];

// Pointer on the char rendering function
void (*printchar)( Uint8*, unsigned char, Uint32, Uint32, SDL_bool );

// Pointer on the guiimg conversion function
SDL_bool (*guiimg_to_img)(Uint8** dst, const struct guiimg* src);

// --- printchar template function --------------------------------------------
// Print a char onto a X-bit framebuffer, X being a power of 2
//   ptr       = where to draw it
//   ch        = which char to draw
//   fcol      = foreground colour
//   bcol      = background colour
//   solidfont = use background colour

#define DEFINE_printchar_X_bpp(BIT_DEPTH) \
static void printchar_ ## BIT_DEPTH ## bpp \
( Uint8* ptr, unsigned char ch, Uint32 fcol, Uint32 bcol, SDL_bool solidfont ) \
{ \
  int x, y, mask;                                                 \
  const Uint8 *src_byte;                                          \
  Uint ## BIT_DEPTH *dst_pixel;                                   \
  Uint8* dst_scanline;                                            \
                                                                  \
  if( ch > 127 ) return;                                          \
                                                                  \
  src_byte = &thefont[ch*12];                                     \
                                                                  \
  dst_scanline = ptr;                                             \
                                                                  \
  for( y=12; y!=0; --y, ++src_byte, dst_scanline+=screen->pitch ) \
  {                                                               \
    dst_pixel = (Uint ## BIT_DEPTH *)dst_scanline;                \
                                                                  \
    for( mask=0x80, x=8; x!=0; --x, ++dst_pixel, mask>>=1 )       \
    {                                                             \
      if( (*src_byte)&mask )                                      \
        *dst_pixel = (Uint ## BIT_DEPTH)fcol;                     \
      else if( solidfont )                                        \
        *dst_pixel = (Uint ## BIT_DEPTH)bcol;                     \
    }                                                             \
  }                                                               \
}

DEFINE_printchar_X_bpp(16)
DEFINE_printchar_X_bpp(32)

// --- end of printchar template function -------------------------------------

void render_begin_sw( struct machine *oric )
{
  int x, y;
  Uint8 *dst_scanline;
  
  if( 0<oric->exos_id )
    return;

  if( SDL_MUSTLOCK( screen ) )
    SDL_LockSurface( screen );

  if( oric->newpopupstr )
  {
    dst_scanline = (Uint8*)screen->pixels;
    dst_scanline += 320 * pixel_size;

    if( oric->sw_depth == 16 )
    {
      Uint16 *dst_pixel;
      for( y=12; y!=0; --y, dst_scanline += screen->pitch)
      {
        dst_pixel = (Uint16 *)dst_scanline;
        for( x=320; x<640; x++, dst_pixel++ )
          *dst_pixel = gpal[0];
      }
    } else {
      Uint32 *dst_pixel;
      for( y=12; y!=0; --y, dst_scanline += screen->pitch)
      {
        dst_pixel = (Uint32 *)dst_scanline;
        for( x=320; x<640; x++, dst_pixel++ )
          *dst_pixel = gpal[0];
      }
    }
    oric->newpopupstr = SDL_FALSE;
  }
  
  if( oric->newstatusstr )
  {
    refreshstatus = SDL_TRUE;
    oric->newstatusstr = SDL_FALSE;
  }
}

void render_end_sw( struct machine *oric )
{
  int i;
  Uint32 char_pitch;
  Uint8 *dst_pixel;

  if( 0<oric->exos_id )
    return;
  
  char_pitch = 8 * pixel_size;

  if( oric->emu_mode == EM_RUNNING )
  {
    if( oric->popupstr[0] )
    {
      dst_pixel = (Uint8*)screen->pixels;
      dst_pixel += 320 * pixel_size;

      for( i=0; oric->popupstr[i]; i++, dst_pixel += char_pitch )
        printchar( dst_pixel, oric->popupstr[i], gpal[1], gpal[0], SDL_TRUE );
    }
  
    if( oric->statusstr[0] )
    {
      dst_pixel = (Uint8*)screen->pixels;
      dst_pixel += 466 * screen->pitch;

      for( i=0; oric->statusstr[i]; i++, dst_pixel += char_pitch )
        printchar( dst_pixel, oric->statusstr[i], gpal[1], 0, SDL_FALSE );
    }
  }

  if( SDL_MUSTLOCK( screen ) )
    SDL_UnlockSurface( screen );

  SDL_COMPAT_Flip( screen );
}

void render_textzone_alloc_sw( struct machine *oric, int i )
{
}

void render_textzone_free_sw( struct machine *oric, int i )
{
}

void render_textzone_sw( struct machine *oric, int i )
{
  int x, y, o;
  Uint32 char_pitch;
  struct textzone *ptz = tz[i];
  Uint8 *dst_scanline, *dst_pixel;

  if( 0<oric->exos_id )
    return;
  
  char_pitch = 8 * pixel_size;

  dst_scanline = (Uint8 *)screen->pixels;
  dst_scanline += screen->pitch * ptz->y + pixel_size * ptz->x;

  o = 0;
  for( y=ptz->h; y!=0; --y, dst_scanline+=12*screen->pitch )
  {
    dst_pixel = dst_scanline;

    for( x=ptz->w; x!=0; --x, ++o, dst_pixel+=char_pitch )
      printchar( dst_pixel, ptz->tx[o], gpal[ptz->fc[o]], gpal[ptz->bc[o]], SDL_TRUE );
  }

}

// Clear an area to background
void render_clear_area_sw( int x, int y, int w, int h )
{
  Uint8 *dst_scanline;
  Sint32 i;

  dst_scanline = (Uint8 *)screen->pixels;
  dst_scanline += screen->pitch * y + pixel_size * x;

  for( i=0; i<h; i++, dst_scanline+=screen->pitch )
    memset( dst_scanline, 0, pixel_size*w );
}

// Draw a GUI image at X,Y
void render_gimg_sw( int img_id, Sint32 xp, Sint32 yp )
{
  struct guiimg *gi = &gimgs[img_id];
  Uint8 *src_scanline, *dst_scanline;
  Sint32 i;

  src_scanline = mgimg[img_id];

  dst_scanline = (Uint8 *)screen->pixels;
  dst_scanline += screen->pitch * yp + pixel_size * xp;

  for( i=gi->h; i!=0; --i, src_scanline+=pixel_size*gi->w, dst_scanline+=screen->pitch )
    memcpy( dst_scanline, src_scanline, pixel_size*gi->w );
}

// Draw part of an image (xp,yp = screen location, ox, oy = offset into image, w, h = dimensions)
void render_gimgpart_sw( int img_id, Sint32 xp, Sint32 yp, Sint32 ox, Sint32 oy, Sint32 w, Sint32 h )
{
  struct guiimg *gi = &gimgs[img_id];
  Uint8 *src_scanline, *dst_scanline;
  Sint32 i;

  src_scanline = mgimg[img_id];
  src_scanline += pixel_size*(gi->w * oy + ox);

  dst_scanline = (Uint8 *)screen->pixels;
  dst_scanline += screen->pitch * yp + pixel_size * xp;

  for( i=h; i!=0; --i, src_scanline+=pixel_size*gi->w, dst_scanline+=screen->pitch )
    memcpy( dst_scanline, src_scanline, pixel_size*w );
}

// Copy the video output buffer to the SDL surface, assuming 16bpp video mode
void render_video_sw_16bpp( struct machine *oric, SDL_bool doublesize )
{
  int x, y;
  Uint8 *src_pixel;
  Uint8 *src_pixel1, *src_pixel2, *src_pixel3;
  Sint32 dst_pitch_x2;
  Uint32 c;
  Uint32 c1, c2, c3;
  Uint8 *dst_scanline, *dst_even_scanline, *dst_odd_scanline;
  Uint16 *dst_pixel;
  Uint32 *dst_even_pixel, *dst_odd_pixel;

  if( 0<oric->exos_id || !oric->scr )
    return;

  if( doublesize )
  {
    if( needclr )
    {
      SDL_FillRect(screen, NULL, gpal[0]);
      needclr = SDL_FALSE;
    }

    src_pixel = oric->scr;
    src_pixel1 = oric->exos[1]->scr;
    src_pixel2 = oric->exos[2]->scr;
    src_pixel3 = oric->exos[3]->scr;
    
    dst_pitch_x2 = 2 * screen->pitch;

    dst_even_scanline = ((Uint8*)screen->pixels) + offset_top;

    dst_odd_scanline = dst_even_scanline;
    dst_odd_scanline += screen->pitch;

    if( oric->scanlines )
    {
      for( y=0; y<224; y++, dst_even_scanline+=dst_pitch_x2, dst_odd_scanline+=dst_pitch_x2 )
      {
        if (!oric->vid_dirty[y])
        {
          src_pixel += 240;
          src_pixel1 += 240;
          src_pixel2 += 240;
          src_pixel3 += 240;
          continue;
        }
        dst_even_pixel = (Uint32*)dst_even_scanline;
        dst_odd_pixel  = (Uint32*)dst_odd_scanline;

        for( x=240; x!=0; --x )
        {
          c = *(src_pixel++);
          c1 = *(src_pixel1++);
          c2 = *(src_pixel2++);
          c3 = *(src_pixel3++);
          
          *(dst_even_pixel++) = dpal[c];
          *(dst_odd_pixel++)  = dpal[c+8];
        }
        oric->vid_dirty[y] = SDL_FALSE;

      }
    } else {
      for( y=0; y<224; y++, dst_even_scanline+=dst_pitch_x2, dst_odd_scanline+=dst_pitch_x2 )
      {
        if (!oric->vid_dirty[y])
        {
          src_pixel += 240;
          src_pixel1 += 240;
          src_pixel2 += 240;
          src_pixel3 += 240;
          continue;
        }
        dst_even_pixel = (Uint32*)dst_even_scanline;
        dst_odd_pixel  = (Uint32*)dst_odd_scanline;

        for( x=240; x!=0; --x ) 
        {
          c = dpal[*(src_pixel++)];
          c1 = dpal[*(src_pixel1++)];
          c2 = dpal[*(src_pixel2++)];
          c3 = dpal[*(src_pixel3++)];
          
          *(dst_even_pixel++) = c;
          *(dst_odd_pixel++)  = c;
        }
        oric->vid_dirty[y] = SDL_FALSE;
      }
    }
    return;
  }

  needclr = SDL_TRUE;

  src_pixel = oric->scr;
  dst_scanline = (Uint8*)screen->pixels;

  for( y=0; y<4; y++ )
  {
    memset( dst_scanline, 0, 240*pixel_size );
    dst_scanline += screen->pitch;
  }
  for( ; y<228; y++, dst_scanline+=screen->pitch )
  {
    dst_pixel = (Uint16*)dst_scanline;

    for( x=240; x!=0; --x )
      *(dst_pixel++) = (Uint16)pal[*(src_pixel++)];
  }
}

static Uint32 mix32( struct machine *oric, Uint32 c0, Uint32 c1, Uint32 c2, Uint32 c3 )
{
  Uint8 r0, g0, b0;
  Uint8 r1, g1, b1;
  Uint8 r2, g2, b2;
  Uint8 r3, g3, b3;
  
  SDL_GetRGB(c0, screen->format, &r0, &g0, &b0);
  SDL_GetRGB(c1, screen->format, &r1, &g1, &b1);
  SDL_GetRGB(c2, screen->format, &r2, &g2, &b2);
  SDL_GetRGB(c3, screen->format, &r3, &g3, &b3);
  
  return SDL_MapRGB( screen->format, 
                     (r0+r1+r2+r3)/4,
                     (g0+g1+g2+g3)/4,
                     (b0+b1+b2+b3)/4);
}

static SDL_bool isdirty( struct machine *oric, int y )
{
  return 
  oric->vid_dirty[y] |
  oric->exos[1]->vid_dirty[y] |
  oric->exos[2]->vid_dirty[y] |
  oric->exos[3]->vid_dirty[y];
}

static void setdirty( struct machine *oric, int y, SDL_bool b )
{
  oric->vid_dirty[y] = 
  oric->exos[1]->vid_dirty[y] = 
  oric->exos[2]->vid_dirty[y] = 
  oric->exos[3]->vid_dirty[y] = b;
}


// Copy the video output buffer to the SDL surface, assuming 32bpp video mode
void render_video_sw_32bpp( struct machine *oric, SDL_bool doublesize )
{
  int x, y;
  Uint8 *src_pixel;
  Uint8 *src_pixel1, *src_pixel2, *src_pixel3;
  Sint32 dst_pitch_x2;
  Uint32 c, cc;
  Uint32 c1, cc1, c2, cc2, c3, cc3;
  Uint8 *dst_scanline, *dst_even_scanline, *dst_odd_scanline;
  Uint32 *dst_pixel, *dst_even_pixel, *dst_odd_pixel;

  if( 0<oric->exos_id || !oric->scr )
    return;

  if( doublesize )
  {
    if( needclr )
    {
      SDL_FillRect(screen, NULL, gpal[0]);
      needclr = SDL_FALSE;
    }

    src_pixel = oric->scr;
    src_pixel1 = oric->exos[1]->scr;
    src_pixel2 = oric->exos[2]->scr;
    src_pixel3 = oric->exos[3]->scr;
    
    dst_pitch_x2 = 2 * screen->pitch;

    dst_even_scanline = ((Uint8*)screen->pixels) + offset_top;

    dst_odd_scanline = dst_even_scanline;
    dst_odd_scanline += screen->pitch;

    if( oric->scanlines )
    {
      for( y=0; y<224; y++, dst_even_scanline+=dst_pitch_x2, dst_odd_scanline+=dst_pitch_x2 )
      {
        if (!isdirty( oric, y ))
        {
          src_pixel += 240;
          src_pixel1 += 240;
          src_pixel2 += 240;
          src_pixel3 += 240;
          continue;
        }
        dst_even_pixel = (Uint32*)dst_even_scanline;
        dst_odd_pixel  = (Uint32*)dst_odd_scanline;

        for( x=240; x!=0; --x )
        {
          cc = pal[(*src_pixel)+8];
          c = pal[*(src_pixel++)];
          
          cc1 = pal[(*src_pixel1)+8];
          c1 = pal[*(src_pixel1++)];
          
          cc2 = pal[(*src_pixel2)+8];
          c2 = pal[*(src_pixel2++)];
          
          cc3 = pal[(*src_pixel3)+8];
          c3 = pal[*(src_pixel3++)];
          
          c = mix32( oric, c, c1, c2, c3 );
          cc = mix32( oric, cc, cc1, cc2, cc3 );

          *(dst_even_pixel++) = c;
          *(dst_even_pixel++) = c;
          *(dst_odd_pixel++)  = cc;
          *(dst_odd_pixel++)  = cc;
        }
        setdirty( oric, y, SDL_FALSE );
      }
    } else {
      for( y=0; y<224; y++, dst_even_scanline+=dst_pitch_x2, dst_odd_scanline+=dst_pitch_x2 )
      {
        if (!isdirty( oric, y ))
        {
          src_pixel += 240;
          src_pixel1 += 240;
          src_pixel2 += 240;
          src_pixel3 += 240;
          continue;
        }
        dst_even_pixel = (Uint32*)dst_even_scanline;
        dst_odd_pixel  = (Uint32*)dst_odd_scanline;

        for( x=240; x!=0; --x ) 
        {
          c = pal[*(src_pixel++)];
          c1 = pal[*(src_pixel1++)];
          c2 = pal[*(src_pixel2++)];
          c3 = pal[*(src_pixel3++)];
          
          c = mix32( oric, c, c1, c2, c3 );
          *(dst_even_pixel++) = c;
          *(dst_even_pixel++) = c;
          *(dst_odd_pixel++)  = c;
          *(dst_odd_pixel++)  = c;
        }
        setdirty( oric, y, SDL_FALSE );
      }
    }
    return;
  }

  needclr = SDL_TRUE;

  src_pixel = oric->scr;
  dst_scanline = (Uint8*)screen->pixels;

  for( y=0; y<4; y++ )
  {
    memset( dst_scanline, 0, 240*pixel_size );
    dst_scanline += screen->pitch;
  }

  for( ; y<228; y++, dst_scanline+=screen->pitch )
  {
    dst_pixel = (Uint32*)dst_scanline;

    for( x=240; x!=0; --x )
      *(dst_pixel++) = pal[*(src_pixel++)];
  }
}

void render_sw_detectvideo( struct machine *oric )
{
  int BitsPerPixel = SDL_COMPAT_GetBitsPerPixel();

  // Guess the suitable video mode, either 16bpp or 32bpp
  oric->sw_depth = 16;

  switch( BitsPerPixel )
  {
    // Great, cases we handle
    case 8:
    case 16:
    case 24:
    case 32:
    oric->sw_depth = BitsPerPixel;
      break;
    // Damn, cases we don't handle. Let's say 16 bpp gonna be ok
    default:
      break;
  }
}

void preinit_render_sw( struct machine *oric )
{
  Sint32 i;

  // Screen surface is not set yet
  screen = NULL;

  if( 0<oric->exos_id )
    return;
  
  // Images are not set yet
  for( i=0; i<NUM_GIMG; i++ )
    mgimg[i] = NULL;
}

SDL_bool render_togglefullscreen_sw( struct machine *oric )
{
  if( 0<oric->exos_id )
    return SDL_FALSE;
  
#if defined(__amigaos4__) || defined(__linux__) || defined(__MORPHOS__)
  // Use SDL_WM_ToggleFullScreen on systems where it is supported
  if( SDL_COMPAT_WM_ToggleFullScreen( screen ) )
  {
    fullscreen = !fullscreen;
    return SDL_TRUE;
  }

  return SDL_FALSE;
#else
  oric->shut_render( oric );
  fullscreen = !fullscreen;
  if( oric->init_render( oric ) ) return SDL_TRUE;
  set_render_mode( oric, RENDERMODE_NULL );
  oric->emu_mode = EM_PLEASEQUIT; 
  return SDL_FALSE;
#endif
}

// --- guiimg_to_img_X_bpp template function ----------------------------------

#define DEFINE_guiimg_to_img_X_bpp(BIT_DEPTH) \
static SDL_bool guiimg_to_img_ ## BIT_DEPTH ## bpp \
(Uint8** dst, const struct guiimg* src)  \
{ \
  size_t i;                                                            \
  const Uint8 *src_pixel;                                              \
  Uint ## BIT_DEPTH *dst_pixel;                                        \
                                                                       \
  (*dst) = (Uint8 *)malloc( src->w*src->h*sizeof(Uint ## BIT_DEPTH) ); \
  if ((*dst) == NULL)                                                  \
    return SDL_FALSE;                                                  \
                                                                       \
  src_pixel = src->buf;                                                \
  dst_pixel = (Uint ## BIT_DEPTH *)(*dst);                             \
                                                                       \
  for( i=src->w*src->h; i!=0; --i, src_pixel += 3, ++dst_pixel )       \
    (*dst_pixel) =                                                     \
      (Uint ## BIT_DEPTH)SDL_MapRGB( screen->format,                   \
                                     src_pixel[0],                     \
                                     src_pixel[1],                     \
                                     src_pixel[2] );                   \
                                                                       \
  return SDL_TRUE;                                                     \
}

DEFINE_guiimg_to_img_X_bpp(16)
DEFINE_guiimg_to_img_X_bpp(32)

// --- end of guiimg_to_img_X_bpp template function ---------------------------

SDL_bool init_render_sw( struct machine *oric )
{
  if( oric->exos_id == 0 )
  {
    int i;
    unsigned char* pal_it;
    Sint32 surfacemode;
    
    pixel_size = oric->sw_depth / 8;
    
    surfacemode = fullscreen ? SDL_COMPAT_FULLSCREEN : SDL_SWSURFACE;
    if( hwsurface ) { surfacemode &= ~SDL_SWSURFACE; surfacemode |= SDL_COMPAT_HWSURFACE; }
    
    // Try to setup the video display
    if (oric->show_keyboard) {
      screen = SDL_COMPAT_SetVideoMode( 640, 480+240, oric->sw_depth, surfacemode );
    } else {
      screen = SDL_COMPAT_SetVideoMode( 640, 480, oric->sw_depth, surfacemode );
    }
    
    if( !screen )
    {
      printf( "SDL video failed\n" );
      return SDL_FALSE;
    }
    
    SDL_COMPAT_WM_SetCaption( APP_NAME_FULL, APP_NAME_FULL );
    
    // Set the video bit depth dependent function
    if (oric->sw_depth == 16) {
      printchar = printchar_16bpp;
      guiimg_to_img = guiimg_to_img_16bpp;
      //    SDL_COMPAT_WM_SetCaption( "16bit video", "16bit video" );
    }
    else if (oric->sw_depth == 32) {
      printchar = printchar_32bpp;
      guiimg_to_img = guiimg_to_img_32bpp;
      //    SDL_COMPAT_WM_SetCaption( "32bit video", "32bit video" );
    }
    
    // Convert the GUI palette to the screen format bti depth
    pal_it = sgpal;
    for( i=0; i<NUM_GUI_COLS; i++, pal_it+=3 )
      gpal[i] = SDL_MapRGB( screen->format, pal_it[0], pal_it[1], pal_it[2] );
    
    // Convert the Oric palette to the screen format bti depth
    pal_it = oricpalette;
    for( i=0; i<8; i++, pal_it+=3 )
    {
      pal[i  ] = SDL_MapRGB( screen->format, pal_it[0],   pal_it[1],   pal_it[2] );
      pal[i+8] = SDL_MapRGB( screen->format, pal_it[0]/2, pal_it[1]/2, pal_it[2]/2 );
    }
    
    // Get the images for the GUI
    for( i=0; i<NUM_GIMG; i++ )
    {
      if (!guiimg_to_img(mgimg + i, gimgs + i))
        return SDL_FALSE;
    }
    
    // Precompute pixels pairs for efficient rendering in 16 bpp mode
    for( i=0; i<8*2; i++ )
      dpal[i] = (pal[i]<<16)|pal[i];
    
    // For the first frame rendered, we need to clean the screen
    needclr = SDL_TRUE;
    refreshstatus = SDL_TRUE;
    
    // Calculate the offset to render the screen
    offset_top = (240 - 226) * screen->pitch;
    offset_top += pixel_size * 80;
  }

  ula_set_dirty( oric );

  // Job done
  return SDL_TRUE;
}

void shut_render_sw( struct machine *oric )
{
  Sint32 i;

  for( i=0; oric->exos_id==0 && i<NUM_GIMG; i++  )
  {
    if( mgimg[i] ) free( mgimg[i] );
    mgimg[i] = NULL;
  }

  // The surface will be freed by SDL_Quit, or a call to SDL_COMPAT_SetVideoMode from a different render module
}
