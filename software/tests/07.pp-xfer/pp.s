;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
;--- parallel port xfer ---
;--------------------------

;--------------------------
.zero

;--------------------------
.text

;--------------------------
; send data to
; parallel port
_pp_out
        jsr   set_pp_out
        rts

;--------------------------
; load data from 
; parallel port
_pp_in
        jsr   set_pp_in
        rts

;--------------------------
set_pp_out

;--------------------------
set_pp_in
        ; disable via irq
        lda   #0  ;%01111111
        sta   via_ier
        lda   #$00
        sta   via_ifr
        
        ; set pb4(stb) to 0
        lda   via_b
        and   #%11101111
        sta   via_b
        ; set pb4 as output
        lda   via_ddrb
        ora   #%00010000
        sta   via_ddrb
        ; disable port b latch
        lda   via_acr
        and   #%11111101
        sta   via_acr
        
        ; set ca1 active pos edge
        lda   via_pcr
        ora   #%00000001
        sta   via_pcr
        ; set port a as input
        lda   #%00000000
        sta   via_ddra
        sta   via_a
        ; enable port a latch
        lda   via_acr
        ora   #%00000001
        sta   via_acr
        rts

;--------------------------
pp_out_put_byte
        rts
;--------------------------
pp_out_get_byte
        rts

pp_in_put_byte
        rts
;--------------------------
pp_in_get_byte
        
        rts

;--------------------------

        
;--------------------------
; #include <scrn_tab.s>
