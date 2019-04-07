;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = SLAVE_ADDRESS

;--------------------------
_start
        jsr   r_text
        
        lda   ipc_id
        asl
        tay
        lda   jmptab,y
        pha
        lda   jmptab+1,y
        pha
        rts
       
_stop
        lda   #<(mhalt)
        ldy   #>(mhalt)
        jsr   r_pstat
        jmp   *
        
;--------------------------
wait
        lda   #$00
        tax
        tay

loop_wait
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        dey
        bne   loop_wait
        dex
        bne   loop_wait
        rts

;--------------------------
tmp     byt   0
crlf    byt   $0d, $0a, 0
mhalt   byt   $10, $01, "Oric halted",0
        
jmptab  byt   >(_master-1),<(_master-1)
        byt   >(_slave_1-1),<(_slave_1-1)
        byt   >(_slave_2-1),<(_slave_2-1)
        byt   >(_slave_3-1),<(_slave_3-1)

;--------------------------
_master
        lda   #$10
        sta   b_paper
        jsr   r_cls
        
;       jmp   _stop
        jmp   *


;--------------------------
_slave_1
        ldy   #$01
        ldx   #$10
        lda   #$03
        sta   tmp
s1_loop
        lda   _scrn_lo,y
        sta   s1_ptr+1
        lda   _scrn_hi,y
        sta   s1_ptr+2
        txa
s1_ptr
        sta   $1234
        iny
        dec   tmp
        bne   s1_loop
        lda   #$03
        sta   tmp
        inx
        cpx   #$18
        bne   s1_loop

        lda   #28
        sta   tmp
s1_loopw
        jsr   wait
        dec   tmp
        bne   s1_loopw
        
        lda   #$10
        sta   b_paper
        jsr   r_cls

;       jmp   _stop
        jmp   *

;--------------------------
_slave_2
        ldy   #$00
s2_loopy
        lda   _scrn_lo+1,y
        sta   s2_ptr+1
        lda   _scrn_hi+1,y
        sta   s2_ptr+2
        ldx   #$00
s2_loopx
        lda   s2_div8,x
s2_ptr
        sta   $1234,x
        inx
        cpx   #$28
        bne   s2_loopx
        iny
        cpy   #$18
        bne   s2_loopy

        lda   #28
        sta   tmp
s2_loopw
        jsr   wait
        dec   tmp
        bne   s2_loopw

        lda   #$10
        sta   b_paper
        jsr   r_cls

;       jmp   _stop
        jmp   *
        
s2_div8 
        byt  $10,$10,$10,$10,$10,
        byt  $11,$11,$11,$11,$11,
        byt  $12,$12,$12,$12,$12,
        byt  $13,$13,$13,$13,$13,
        byt  $14,$14,$14,$14,$14,
        byt  $15,$15,$15,$15,$15,
        byt  $16,$16,$16,$16,$16,
        byt  $17,$17,$17,$17,$17,

;--------------------------
_slave_3
        jsr   wait
        jsr   wait
        jsr   wait
        lda   #$10
s3_loop
        sta   b_paper
        jsr   r_cls
        jsr   wait
        jsr   wait
        jsr   wait
        inc   b_paper
        lda   b_paper
        cmp   #$18
        bne   s3_loop

        lda   #$10
        sta   b_paper
        jsr   r_cls
        
;       jmp   _stop
        jmp   *

;--------------------------
#include "scrn_tab.s"
