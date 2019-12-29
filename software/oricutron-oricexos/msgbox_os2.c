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
**  Amiga OS2.x message box
*/

#include <proto/intuition.h>

#include "system.h"
#include "via.h"
#include "msgbox.h"

SDL_bool init_msgbox( struct machine *oric )
{
  return SDL_TRUE;
}

void shut_msgbox( struct machine *oric )
{
}

SDL_bool msgbox( struct machine *oric, int type, char *msg )
{
  char *btns = "OK|Cancel";
  struct EasyStruct myES =
    {
    sizeof(struct EasyStruct),
    0,
    (UBYTE *) "Oricutron Request",
    (UBYTE *) msg,
    (UBYTE *) btns,
    };

  switch( type )
  {
    case MSGBOX_YES_NO:
      strcpy(btns, "Yes|No");
      break;

    case MSGBOX_OK:
      strcpy(btns, "OK");
      break;

    case MSGBOX_OK_CANCEL:
      break;
  }

  return EasyRequest(NULL, &myES, NULL);
}
