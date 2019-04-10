;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = SLAVE_ADDRESS

_start
        sei
        cld
        jsr   _reset_exos
        
        lda   #$20
        ldx   #39
loop0
        sta   $bb80,x
        dex
        bpl   loop0
        
        lda   ipc_id
        sta   tmp
        sec
        adc   #'@'
        sta   msg+1
        lda   ipc_id
        ora   #$30
        sta   msgn
       
        ; hide cursor
        lda   $251
        and   #$fe
        sta   $251
        jsr   $f6fe
       
        ; pos cursor
        lda   #$00  
        sta   $0269 
        lda   ipc_id    
        sta   $0268 
        jsr   $da0c 
        lda   $1f   
        ldy   $20
        sta   $12
        sty   $13

        lda   #<(msg)
        ldy   #>(msg)
        jsr   r_print

        jsr   wait

_stop
        jmp   _stop
        
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
msg     byt   $1b,$00,"ORIC #X READY.",$0d,$0a,0
msgn    =     msg + 8

;--------------------------
; reuse space
tmp     =     _start
