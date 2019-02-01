;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
.text

;--------------------------
*       = START_ADDRESS

_start
        sei
        cld
        ldx   #$ff
        txs

        lda   #$10
        sta   b_paper
        lda   #$07
        sta   b_ink
        jsr   r_cls

        lda   id_addr
        and   #$07
        sta   id
        sta   tmp
        clc
        adc   #'@'
        sta   msg+1
        lda   id
        ora   #$30
        sta   msgn
        
loop1
        lda   #<(crlf)
        ldy   #>(crlf)
        jsr   r_print
        dec   tmp
        bpl   loop1
        
        lda   #<(msg)
        ldy   #>(msg)
        jsr   r_print

        lda   id
        asl
        tay
        lda   jump_tab,y
        sta   go_ptr
        lda   jump_tab+1,y
        sta   go_ptr+1

go_ptr  = *+1
        jmp   $1234

        
jump_tab
        wrd   oric_0
        wrd   oric_1
        wrd   oric_2
        wrd   oric_3

;--------------------------
;--- test-pp-out --------
;--------------------------
test_pp_out
        jmp   _pp_out
        rts

;--------------------------
;--- test-pp-in ---------
;--------------------------
test_pp_in
        jmp   _pp_in
        rts

oric_0
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_out
        jmp   _stop

oric_1
oric_2
oric_3
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_in
        jmp   _stop

_stop
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
id      byt  0
tmp     byt  0
crlf    byt  $0d, $0a, 0
msg     byt  $1b,$00,"ORIC #"
msgn    byt  "X READY.",$0d,$0a,0
