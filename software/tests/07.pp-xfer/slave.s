;--------------------------
#define byt           .byte
#define wrd           .word
#define dsb           .dsb

;--------------------------
.text

;--------------------------
r_cls   = $ccce
r_print = $ccb0
r_cload = $e874
r_text  = $ec21
r_lores0= $d9ed
r_lores1= $d9ea
r_hires = $ec33

b_paper = $026b
b_ink   = $026c

id_addr = $edb0

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
        ; FIXME
        rts

;--------------------------
;--- test-pp-in ---------
;--------------------------
test_pp_in
        ; FIXME
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
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_in
        jmp   _stop

oric_2
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_in
        jmp   _stop

oric_3
        clc
        lda   #$10
        adc   id
        sta   b_paper
        jsr   r_cls
        jsr   test_pp_in
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

;--------------------------
mlines
        rts
        ldy   #0
ml_1
        lda   _scrn_lo,y
        sta   ml_2+1
        lda   _scrn_hi,y
        sta   ml_2+2

        lda   #$6a
        ldx   #4
ml_2  = *
        sta   $1234,x
        dex
        bne   ml_2
        
        tya
        clc
        adc   #8
        tay
        cpy   #200
        bne   ml_1
        rts     

;--------------------------
mdigits
        ldy   #1
        ldx   #2
md_1
        clc
        lda   _scrn_lo,y
        adc   #<($bb80-$a000)
        sta   md_2+1
        lda   _scrn_hi,y
        adc   #>($bb80-$a000)
        sta   md_2+2

        tya
        adc   #'@'
md_2  = *
        sta   $1234,x
        
        iny
        cpy   #25
        bcc   md_1
        rts     

