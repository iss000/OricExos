;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
.text

;--------------------------
*       = START_ADDRESS

;--------------------------
; toggle rom on/off
_dosrom = $04f2

;--------------------------
tmp     =    _start

;--------------------------
_start
        sei
        cld
        jsr   _reset_exos

        lda   #$10
        sta   b_paper
        lda   #$07
        sta   b_ink
        jsr   r_cls

        lda   ipc_id
        sta   tmp
        clc
        adc   #'@'
        sta   msg+1
        lda   ipc_id
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

        lda   ipc_id
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
        jsr   copy_rom_to_ram
        jmp   $f88f

;--------------------------
;--- test-map-slave
;--------------------------
test_ext_map_slave
        jsr   copy_rom_to_ram
        jmp   $f88f

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
crlf    byt   $0d, $0a, 0
msg     byt   $1b,$00,"ORIC #X READY.",$0d,$0a,0
msgn    =     msg + 8
oricx   byt   "Oric0"
btng    byt   "Booting  ",0
ptch    byt   $20,$B0,$CC,$A9,$B0,$A0,$CC
;--------------------------

copy_rom_to_ram
        ;
        lda   ipc_id
        beq   skpm
        jsr   _set_rom_on
        nop
        nop
        nop
skpm
        lda   #<$c000
        sta   $00
        lda   #>$c000
        sta   $01

        lda   #<$3000
        sta   $02
        lda   #>$3000
        sta   $03

        ldy   #0
lp1
        lda   ($00),y
        sta   ($02),y
        dey
        bne   lp1
        inc   $03
        inc   $01
        bne   lp1

        ;
        lda   ipc_id
        beq   skpm_1
        jsr   _set_rom_off
        nop
        nop
        nop
        jmp   skpm_2
skpm_1
        jsr   _dosrom
skpm_2
        lda   #<$c000
        sta   $00
        lda   #>$c000
        sta   $01

        lda   #<$3000
        sta   $02
        lda   #>$3000
        sta   $03

        ldy   #0
lp2
        lda   ($02),y
        sta   ($00),y
        dey
        bne   lp2
        inc   $03
        inc   $01
        bne   lp2

        ; patch Ready to OricX
        ldy   #5
        lda   ipc_id
lp3
        clc
        adc   oricx-1,y
        sta   $c3b4-1,y
        lda   #0
        dey
        bne   lp3
        ; y = 0
lp4
        lda   btng,y
        beq   lp5
        sta   $e50d,y
        iny
        bne   lp4
lp5
        ldy   #$7
lp6
        lda   ptch-1,y
        sta   $ed73-1
        dey
        bpl   lp6

        rts
