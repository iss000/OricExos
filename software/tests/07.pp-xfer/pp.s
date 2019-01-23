;--------------------------
#include <defasm.h>

;--------------------------
#define dsb             .dsb
#define byt             .byt
#define wrd             .word


;--------------------------
#define via_b           $0300
#define via_a           $0301
#define via_ddrb        $0302
#define via_ddra        $0303
#define via_t1cl        $0304
#define via_t1ch        $0305
#define via_t1ll        $0306
#define via_t1lh        $0307
#define via_t2ll        $0308
#define via_t2lh        $0309
#define via_t2cl        $0308
#define via_t2ch        $0309
#define via_sr          $030a
#define via_acr         $030b
#define via_pcr         $030c
#define via_ifr         $030d
#define via_ier         $030e
#define via_aor         $030f

;--------------------------
.zero

r_via_reset             = $e93d       ; restore VIA settings and clear flag I
r_via_set               = $e76a       ; init VIA (disable T1 interrupt) and set flag I

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
#include <scrn_tab.s>
