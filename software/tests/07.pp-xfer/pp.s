;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
;--- parallel port xfer ---
;--------------------------

;--------------------------
.zero
zpp     =     0
zptr    =     zpp
zcmd    =     zpp+2
zflg    =     zpp+3
zdst    =     zpp+4
zsiz    =     zpp+6
zsrc    =     zpp+8

;--------------------------
.text

;--------------------------
pp_out_put_byte
        pha
        
        sta   via_a

        lda   via_b
        and   #%11101111
        sta   via_b

        lda   #via_irq_ca1
lp_opb
        bit   via_ifr
        beq   lp_opb

        lda   via_b
        ora   #%00010000
        sta   via_b
        
        pla
        rts

;--------------------------
pp_out_get_byte
        ; ToDo ....
        rts

;--------------------------
pp_in_put_byte
        ; ToDo ....
        rts
;--------------------------
pp_in_get_byte
        lda   #via_irq_ca1
lp_igb
        bit   via_ifr
        beq   lp_igb
        
        lda   via_a
        pha

        ; the tricky part
        ; set PB4 as input
        ; which sets line to 1
        lda   #%11101111
        and   via_ddrb
        sta   via_ddrb

        ; wait other slaves
        ; to do the same
lp_igbw
        lda   via_b
        and   #%00010000
        beq   lp_igbw

        ; set PB4 as output
        ; which sets line to 0
        lda   #%00010000
        ora   via_ddrb
        sta   via_ddrb

        pla
        rts

;--------------------------
_pp_setup_master
        ; disable via irq
        lda   #%01111111
        sta   via_ier
        lda   #$00
        sta   via_ifr

        ; set pb4(stb) to 1
        lda   via_b
        ora   #%00010000
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
        ora   #via_ca1_rise
        sta   via_pcr
        ; set port a as output
        lda   #%11111111
        sta   via_ddra
        sta   via_a

        ; disable port a latch
        lda   via_acr
        and   #%11111110
        sta   via_acr

        jsr   _set_pp_out
        jsr   _set_pp_on
        rts

;--------------------------
_pp_send
        ; A:X command ptr
        sta   zptr+1
        stx   zptr

        ldy   #$07
        ; setup source buffer ptr
        lda   (zptr),y
        sta   zsrc+1
        dey
        lda   (zptr),y
        sta   zsrc
        dey

        ; setup size counter
        lda   (zptr),y
        sta   zsiz+1
        dey
        lda   (zptr),y
        sta   zsiz

        ; send synchro
        ; 55 55 .. 55 AA
        ldy   #$07
        lda   #$55
tx_syn
        jsr   pp_out_put_byte
        dey
        bne   tx_syn
        lda   #$aa
        jsr   pp_out_put_byte
        
        ; send 6 bytes header
        ldy   #$00
tx_hdr
        lda   (zptr),y
        jsr   pp_out_put_byte
        iny
        cpy   #$06
        bne   tx_hdr

        ; send content
        ldy   #$00
tx_cont
        lda   (zsrc),y
        jsr   pp_out_put_byte
        ;
        inc   zsrc
        bne   txs_1
        inc   zsrc+1
txs_1
        dec   zsiz
        bne   tx_cont
        lda   zsiz+1
        beq   txs_2
        dec   zsiz+1
        jmp   tx_cont
txs_2
        rts


;--------------------------
_pp_setup_slave
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
        and   #via_ca1_fall
        sta   via_pcr

        ; set port a as input
        lda   #%00000000
        sta   via_ddra
        sta   via_a

        ; enable port a latch
        lda   via_acr
        ora   #%00000001
        sta   via_acr

        jsr   _set_pp_in
        jsr   _set_pp_on
        rts

;--------------------------
_pp_receive
        ; Y - slave mask
        sty   zflg
        ; A:X command ptr
        sta   zptr+1
        stx   zptr

        ; receive synchro
rx_55
        jsr   pp_in_get_byte
        cmp   #$55
        bne   rx_55
rx_AA
        jsr   pp_in_get_byte
        cmp   #$55
        beq   rx_AA
        cmp   #$aa
        bne   rx_55
        
        ; receive 6 bytes header
        ldy   #$00
rx_hdr
        jsr   pp_in_get_byte
        sta   (zptr),y
        iny
        cpy   #$06
        bne   rx_hdr

        ldy   #$05
        ; setup size counter
        lda   (zptr),y
        sta   zsiz+1
        dey
        lda   (zptr),y
        sta   zsiz
        dey

        ; setup destination buffer ptr
        lda   (zptr),y
        sta   zdst+1
        dey
        lda   (zptr),y
        sta   zdst
        dey

        ; get flags
        lda   (zptr),y
        and   zflg
        sta   zflg

        ; receive content
        ldy   #$00
rx_cont
        jsr   pp_in_get_byte
        ldx   zflg
        beq   rxs_1
        sta   (zdst),y

        inc   zdst
        bne   rxs_1
        inc   zdst+1
rxs_1
        dec   zsiz
        bne   rx_cont
        lda   zsiz+1
        beq   rxs_2
        dec   zsiz+1
        jmp   rx_cont
rxs_2
        rts

;--------------------------
; restore VIA defaults
_pp_reset
        jsr   _set_pp_off
        jsr   _set_pp_out

        ; this code is from Atmos ROM
        lda   #$ff
        sta   via_ddra
        lda   #$f7
        sta   via_ddrb
        lda   #$b7
        sta   via_b
        lda   #$dd
        sta   via_pcr
        lda   #$7f
        sta   via_ier
        lda   #$40
        sta   via_acr
        lda   #$c0
        sta   via_ier
        lda   #$10
        sta   via_t1ll
        sta   via_t1cl
        lda   #$27
        sta   via_t1lh
        sta   via_t1ch
        rts

;--------------------------
; #include <scrn_tab.s>
