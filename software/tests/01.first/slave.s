;--------------------------
.text

;--------------------------
r_cls   = $ccce
r_print = $ccb0
r_cload = $e874

id_addr = $edb0

;--------------------------
*       = START_ADDRESS

_start
        sei
        
        jsr   r_cls
        lda   id_addr
        and   #$07
        sta   id
        sta   tmp
        sec
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

        jsr   wait

_stop
        jmp   _stop
        
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
id     .byt  0
crlf   .byt  $0d, $0a, 0
msg    .byt  $1b,$00,"ORIC #"
msgn   .byt  "X READY.",$0d,$0a,0
tmp    .byt  0
