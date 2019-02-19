;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
;--- parallel port xfer ---
;--------------------------

;--------------------------
.zero
zpp     =     0

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
        lda   #%01111111
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
        
        ; set ca1 active neg edge
        lda   via_pcr
        and   #%11111110
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
_pp_setup_master
        rts

;--------------------------
_pp_send
        stx   zpp
        sta   zpp+1

        ldy   #$07
        ; setup source buffer ptr
        lda   (zpp),y
        sta   zpp+3
        dey
        sta   zpp+2
        dey

        ; setup size counter
        lda   (zpp),y
        sta   zpp+5
        dey
        lda   (zpp),y
        sta   zpp+4

        ; send 6 bytes header
        ldy   #$00
        ldx   #$06
lp_hdr
        lda   (zpp),y
        jsr   pp_out_put_byte
        dex
        bne   lp_hdr
        
        ; send content
        ldy   #$00
lp_cont
        lda   (zpp+2),y
        jsr   pp_out_put_byte
        inc   zpp+2
        bne   skp_1
        inc   zpp+3
skp_1
        dec   zpp+4
        bne   lp_cont
        lda   zpp+5
        beq   skp_2
        dec   zpp+5
        jmp   lp_cont
skp_2
        rts


;--------------------------
_pp_setup_slave
        rts
;--------------------------
_pp_receive
        rts
        
;--------------------------
; #include <scrn_tab.s>
