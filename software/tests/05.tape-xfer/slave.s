;--------------------------
#define byt           .byte
#define wrd           .word

;--------------------------
.text

;--------------------------
r_cls   = $ccce
r_print = $ccb0
r_cload = $e874

id_addr = $edb0


b_paper = $026b
b_ink   = $026c

;--------------------------
*       = START_ADDRESS

_start
        sei
        cld
        ldx   #$ff
        txs

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
        
oric_0
        jsr   wait
        jsr   test_tape_out
        lda   #$10+1
        sta   b_paper
        jmp   _stop

oric_1
        jsr   test_tape_in
        lda   #$10+2
        sta   b_paper
        jmp   _stop

oric_2
        lda   #$10+3
        sta   b_paper
        jmp   _stop

oric_3
        lda   #$10+4
        sta   b_paper
        jmp   _stop

_stop
        jsr   r_cls

        cli
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
id      byt  0
tmp     byt  0
crlf    byt  $0d, $0a, 0
msg     byt  $1b,$00,"ORIC #"
msgn    byt  "X READY.",$0d,$0a,0


;--------------------------
