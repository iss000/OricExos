;--------------------------
#define dsb           .dsb 
#define byt           .byt
#define wrd           .word

;--------------------------
.text

;--------------------------
;--- test-tape-out --------
;--------------------------

test_data
                byt 'screen',$0d
                dsb 16-(*-test_data),$00
                wrd $bb80
                wrd $bb80+(40*28)
                wrd $0000
                byt $00

;--------------------------
test_tape_out
                ldx #$16
tto_1
                lda test_data,x
                sta buffer,x
                dex
                bpl tto_1
                jsr save
                rts
