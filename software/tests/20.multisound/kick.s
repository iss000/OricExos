#include <via.h>
#include <oricexos.h>

;--------------------------
_kick
;--------------------------
        ; show time
        jsr   _set_mix_a
        
        ; is this master
        lda   ipc_id
        beq   _send_kick
       
;--------------------------
_wait_kick
        lda   via_a
        lda   #via_irq_ca1
wkl_1
        bit   via_ifr
        beq   wkl_1
        rts
;--------------------------
_send_kick
        lda   via_b
        and   #%11101111
        sta   via_b
        ora   #%00010000
        sta   via_b
        rts
