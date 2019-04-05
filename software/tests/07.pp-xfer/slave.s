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
; sample command to send 
; (40*25) bytes
; from masters $BB80
; to slaves $BB80
test_cmd

; command id
cmd_id
        byt   %00000000

; command flag
;              +-------- autorun
;              |    +--- slave 1
;              |    |+-- slave 2
;              |    ||+- slave 3
;              |    |||
cmd_flg
        byt   %00000111

; destination start address
cmd_dst
        wrd   $bb80
        
; transfer size
cmd_size
        wrd   40*25
        
; source start address
cmd_src
        wrd   $bb80

;--------------------------
;--- test-pp-out ----------
;--------------------------
test_pp_master
        jsr   _pp_setup_master
        ; A:X command ptr
        lda   #>test_cmd
        ldx   #<test_cmd
        jsr   pp_send
        jsr   _pp_reset
        rts

;--------------------------
;--- test-pp-in -----------
;--------------------------
test_pp_slave
        jsr   _pp_setup_slave
        ; Y - slave
        ldy   id
        ; A:X command ptr
        lda   #>test_cmd
        ldx   #<test_cmd
        jsr   pp_receive
        jsr   _pp_reset

        lda   cmd_flg
        ; no autoexec
        bpl   nope

        and   #%00000011
        ldx   id
        and   id_mask,x
        ; not for this slave
        beq   nope
        
        jmp   (cmd_dst)
nope
        rts

oric_0
        jsr   wait
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls

        jsr   wait
        lda   #%00000001
        sta   cmd_flg
        lda   #<(40*10)
        sta   cmd_size
        lda   #>(40*10)
        sta   cmd_size+1
        lda   #$11
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_master

        jsr   wait
        lda   #%00000010
        sta   cmd_flg
        lda   #<(40*15)
        sta   cmd_size
        lda   #>(40*15)
        sta   cmd_size+1
        lda   #$12
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_master

        jsr   wait
        lda   #%00000100
        sta   cmd_flg
        lda   #<(40*20)
        sta   cmd_size
        lda   #>(40*20)
        sta   cmd_size+1
        lda   #$13
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_master

        jsr   wait
        lda   #$14
        sta   b_paper
        jsr   r_cls
        
        jmp   _stop
        rts


oric_1
oric_2
oric_3
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_slave
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
tmp     byt   0
;--------------------------
id      byt   0
;--------------------------
crlf    byt   $0d, $0a, 0
msg     byt   $1b,$00,"ORIC #"
msgn    byt   "X READY.",$0d,$0a,0
