;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = SLAVE_01_ADDRESS

_start
        lda   #$10
        sta   b_paper
        lda   #$07
        sta   b_ink
        jsr   r_cls

        jsr   r_hires
        rts
