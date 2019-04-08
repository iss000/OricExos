;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = PLAYER_ADDRESS

;--------------------------
_start
        lda   ipc_id
        asl
        tay
        lda   jmptab,y
        pha
        lda   jmptab+1,y
        pha
        rts

jmptab  byt   >(player),<(player)
        byt   >(player),<(player)
        byt   >(player),<(player)
        byt   >(player),<(player)
       
_stop
        jmp   *
        
;--------------------------
player
        jmp   _stop

;--------------------------
#include "scrn_tab.s"
