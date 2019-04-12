;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
.zero
zsrc    =   0
zdst    =   zsrc+2

;--------------------------
.text

;--------------------------
*       =   START_ADDRESS

;--------------------------
; toggle rom on/off
_dosrom =   $04f2

;--------------------------
tmp     =    _start

;--------------------------
_start
        sei
        cld
        jsr   _reset_exos

        lda   #$20
        ldy   #$28
slp_1
        sta   $bb80-1,y
        dey
        bne   slp_1
        
        lda   #$17
        sta   b_paper
        lda   #$00
        sta   b_ink
        jsr   r_cls

        lda   #<(memmsg)
        ldy   #>(memmsg)
        jsr   r_print

        lda   ipc_id
        sta   tmp
loop1
        lda   #<(crlf)
        ldy   #>(crlf)
        jsr   r_print
        dec   tmp
        bpl   loop1

        jsr   test_memory
        jmp   *

;--------------------------
test_memory
        lda   ipc_id
        bne   sktm_1
        jsr   _dosrom
sktm_1
        jsr   _set_ram_on

        lda   #<($c000)
        sta   zsrc
        lda   #>($c000)
        sta   zsrc+1

        ldy   #$00
        ldx   #$04
tm_lp1
        lda   #$55
        sta   (zsrc),y
        lda   (zsrc),y
        eor   #$ff
        cmp   #$aa
        bne   tm_err1
        dey
        bne   tm_lp1
        inc   zsrc+1
        dex
        bne   tm_lp1
        lda   #$00
tm_err1
        pha
        lda   ipc_id
        bne   sktm_2
        jsr   _dosrom
sktm_2
        jsr   _set_ram_off
        pla
        bne   tm_err2
        lda   #<(memok)
        ldy   #>(memok)
        jmp   r_print
tm_err2
        lda   zsrc
        sta   badadr
        lda   zsrc+1
        sta   badadr+1
        
        lda   #<(memerr)
        ldy   #>(memerr)
        jsr   r_print
        ; light led
        lda   ipc_id
        bne   sktm_3
        jsr   _dosrom
sktm_3
        jsr   _set_ram_on
        
        lda   ipc_id
        asl
        tay
        lda   errline,y
        sta   zsrc
        lda   errline+1,y
        sta   zsrc+1

        ldy   #$00
        lda   badadr+1
        jsr   hexprint
        lda   badadr
hexprint
        pha
        lsr
        lsr
        lsr
        lsr
        tax
        lda   hexchr,x
        sta   (zsrc),y
        iny

        pla
        and   #$0f
        tax
        lda   hexchr,x
        sta   (zsrc),y
        iny
        rts

badadr  wrd   0

errline wrd   $bb80+2*40+10
        wrd   $bb80+3*40+10
        wrd   $bb80+4*40+10
        wrd   $bb80+5*40+10


        lda   ipc_id
        asl
        tay
        lda   jump_tab,y
        sta   go_ptr+1
        lda   jump_tab+1,y
        sta   go_ptr+2

go_ptr  =     *
        jmp   $1234

jump_tab
        wrd   oric_0
        wrd   oric_1
        wrd   oric_2
        wrd   oric_3

oric_0
oric_1
oric_2
oric_3
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
hexchr  byt   "0123456789ABCDEF"
memmsg  byt   "Testing RAM overlay",0
memerr  byt   $1b,"AFAIL",0
memok   byt   $1b,"BPASS",0
crlf    byt   $0d, $0a, 0
