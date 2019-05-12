;--------------------------
.text

;--------------------------
r_cls   = $ccce
r_print = $ccb0
r_cload = $e874
r_cstat = $e5f5
r_pstat = $e5ea


b_paper = $026b
b_ink   = $026c


id_addr = $edb0

;--------------------------
*       = START_ADDRESS

_start
        sei

        ; paper black
        lda   #$10+0
        sta   b_paper
        ; ink white
        lda   #$07
        sta   b_ink
        jsr   r_cls
        
        ldx   #$40
        lda   #$20
loop_1
        sta   _scrn_ptr-1,x
        dex
        bne   loop_1

        lda   id_addr
        and   #$07
        sta   id
        cmp   #$04
        bcs   _stop
        asl
        tay
        lda   jmptab,y
        pha
        lda   jmptab+1,y
        pha
        rts
       
_stop
        jsr   r_cstat
        lda   #<(mhalt)
        ldy   #>(mhalt)
        jsr   r_pstat
        jmp   *

;       jmp   r_cload
        
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
id     .byt   0
tmp    .byt   0
crlf   .byt   $0d, $0a, 0
mhalt  .byt   $10, $01, "Oric halted",0

jmptab .byt   >(_master-1),<(_master-1)
       .byt   >(_slave_1-1),<(_slave_1-1)
       .byt   >(_slave_2-1),<(_slave_2-1)
       .byt   >(_slave_3-1),<(_slave_3-1)

;--------------------------
_master
        ldy   #$00
        ldx   #$11
        lda   #$04
        sta   tmp
m_loop
        lda   _scrn_lo,y
        sta   m_ptr+1
        lda   _scrn_hi,y
        sta   m_ptr+2
        txa
m_ptr
        sta   $1234
        iny
        dec   tmp
        bne   m_loop
        lda   #$04
        sta   tmp
        inx
        cpx   #$18
        bne   m_loop

forever
        jsr   _set_mix_b
        jsr   wait
        jsr   _set_mix_a
        jsr   wait
        jmp   forever
        
;       jmp   _stop
        jmp   *


;--------------------------
_slave_1
        ldy   #$01
        ldx   #$11
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
        iny
        lda   #$03
        sta   tmp
        inx
        cpx   #$18
        bne   s1_loop

;       jmp   _stop
        jmp   *


;--------------------------
_slave_2
        ldy   #$02
        ldx   #$11
        lda   #$02
        sta   tmp
s2_loop
        lda   _scrn_lo,y
        sta   s2_ptr+1
        lda   _scrn_hi,y
        sta   s2_ptr+2
        txa
s2_ptr
        sta   $1234
        iny
        dec   tmp
        bne   s2_loop
        iny
        iny
        lda   #$02
        sta   tmp
        inx
        cpx   #$18
        bne   s2_loop

;       jmp   _stop
        jmp   *


;--------------------------
_slave_3
        ldy   #$03
        ldx   #$11
        lda   #$01
        sta   tmp
s3_loop
        lda   _scrn_lo,y
        sta   s3_ptr+1
        lda   _scrn_hi,y
        sta   s3_ptr+2
        txa
s3_ptr
        sta   $1234
        iny
        dec   tmp
        bne   s3_loop
        iny
        iny
        iny
        lda   #$01
        sta   tmp
        inx
        cpx   #$18
        bne   s3_loop

;       jmp   _stop
        jmp   *

;--------------------------
#include "scrn_tab.s"
