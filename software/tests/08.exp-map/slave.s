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
;--- test-map-master
;--------------------------
test_ext_map_master
        jsr copy_rom_to_ram
        jmp $f88f

;--------------------------
;--- test-map-slave
;--------------------------
test_ext_map_slave
        jsr copy_rom_to_ram
        jmp $f88f

oric_0
        jsr   test_ext_map_master
        jmp   _stop

oric_1
        jsr   test_ext_map_slave
        jmp   _stop

oric_2
        jsr   test_ext_map_slave
        jmp   _stop

oric_3
        jsr   test_ext_map_slave
        jmp   _stop

_stop
;       cli
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

oricx   byt  "Oric0"

;--------------------------

copy_rom_to_ram
        ;
        jsr _set_rom_on

        lda #<$c000
        sta $00
        lda #>$c000
        sta $01

        lda #<$3000
        sta $02
        lda #>$3000
        sta $03
        
        ldy #0
lp1
        lda ($00),y
        sta ($02),y
        dey
        bne lp1
        inc $03
        inc $01
        bne lp1

        ;
        jsr _set_rom_off

        lda #<$c000
        sta $00
        lda #>$c000
        sta $01

        lda #<$3000
        sta $02
        lda #>$3000
        sta $03
        
        ldy #0
lp2
        lda ($02),y
        sta ($00),y
        dey
        bne lp2
        inc $03
        inc $01
        bne lp2
        
        ; patch Ready to OricX
        ldy #5
        lda id
lp3
        clc
        adc oricx-1,y
        sta $c3b4-1,y
        lda #0
        dey
        bne lp3
        rts
