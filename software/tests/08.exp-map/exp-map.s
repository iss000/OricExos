;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
.zero

;--------------------------
.text

_values           dsb   256,0

;--------------------------
;--- tape -----------------
;--------------------------

; via_reset
;                 php
;                 sei
;                 lda #$40
;                 sta via_acr
;                 lda #$7f
;                 sta via_ier
;                 lda #$c0
;                 sta via_ier
;                 lda #$10
;                 sta via_t1ll
;                 sta via_t1cl
;                 lda #$27
;                 sta via_t1lh
;                 sta via_t1ch
;                 lda #$ff
;                 sta via_ifr
;                 plp
;                 rts

via_set
                  jsr r_via_set

                  lda #$ff
                  sta via_t1ll
                  lda #$ff
                  sta via_t1lh
                  lda #$ff
                  sta via_t2ll
                  lda #$ff
                  sta via_t2lh
                  rts
                  
;                 php
;                 sei
;                 lda #$ff
;                 sta via_t1cl
;                 lda #$ff
;                 sta via_t1ch
;                 lda #$c0
;                 sta via_acr
;                 lda #$ff
;                 sta via_ddrb
;                 lda #$10
;                 sta via_pcr
;                 lda #$f4
;                 sta via_t2ll
;                 lda #$7f
;                 sta via_ier
;                 plp
;                 rts

;--------------------------

;--------------------------
#include "scrn_tab.s"
