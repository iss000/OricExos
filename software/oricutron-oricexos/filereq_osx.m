/*
**  Oricutron
**  Copyright (C) 2009-2010 Peter Gordon
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
**  Mac OS X file dialog
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#import <Cocoa/Cocoa.h>

#include "system.h"
#include "6502.h"
#include "via.h"
#include "8912.h"
#include "disk.h"
#include "gui.h"
#include "monitor.h"
#include "6551.h"
#include "machine.h"
#include "filereq.h"


SDL_bool init_filerequester( struct machine *oric )
{
  return SDL_TRUE;
}

void shut_filerequester( struct machine *oric )
{
}

SDL_bool filerequester( struct machine *oric, char *title, char *path, char *fname, int type )
{
  SDL_bool ret;

  NSString *pat = nil;
  NSString *pat2 = nil;
  NSString *pat3 = nil;

  //NSString *msg = @"Select the file to open.";
  bool dosavemode = false;

  switch( type )
  {
    case FR_DISKSAVE:
      dosavemode = true;
    case FR_DISKLOAD:
      pat = @"dsk";
      break;
    
    case FR_TAPESAVETAP:
      dosavemode = true;
      pat = @"tap";
      break;

    case FR_TAPESAVEORT:
      dosavemode = true;
      pat = @"ort";
      break;

    // *.tap, *.ort, *.wav
    case FR_TAPELOAD:
      pat = @"tap";
      pat2 = @"ort";
      pat3 = @"wav";
      break;
    
    case FR_ROMS:
      pat = @"rom";
      break;

    case FR_SNAPSHOTSAVE:
      dosavemode = true;
    case FR_SNAPSHOTLOAD:
      pat = @"sna";
      break;
          
    case FR_KEYMAPPINGSAVE:
          dosavemode = true;
    case FR_KEYMAPPINGLOAD:
          pat = @"kma";
          break;
 
    default:
      pat = NULL;
      break;
  }

  NSSavePanel *sp = nil;
  NSOpenPanel *op = nil;
  if (dosavemode)
    sp = [[NSSavePanel alloc] init];
  else
    sp = op = [[NSOpenPanel alloc] init];

  [sp setTitle:[NSString stringWithUTF8String:title]];

  if (path)
    [sp setDirectoryURL:[NSURL fileURLWithPath:[NSString stringWithUTF8String:path]]];

  if (pat) {
      if (pat2) {
          if (pat3)
              [sp setAllowedFileTypes:[NSArray arrayWithObjects:pat, [pat uppercaseString], pat2,
                                        [pat2 uppercaseString], pat3, [pat3 uppercaseString], nil]];
          else
              [sp setAllowedFileTypes:[NSArray arrayWithObjects:pat, [pat uppercaseString], pat2, [pat2 uppercaseString], nil]];
      } else {
          [sp setAllowedFileTypes:[NSArray arrayWithObjects:pat, [pat uppercaseString], nil]];
      }
  }

  ret = [sp runModal] == NSAlertDefaultReturn;
  if (!ret)
    return ret;

  if (![[sp URL] isFileURL])
    return SDL_FALSE;

  strncpy( path,  [[[[sp URL] URLByDeletingLastPathComponent] path] UTF8String], 4096 ); path[4095] = 0;
  strncpy( fname, [[[sp URL] lastPathComponent] UTF8String],   512  ); path[511]  = 0;

  return ret;
}
