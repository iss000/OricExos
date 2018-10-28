;--------------------------
#define byt           .byt
#define wrd           .word

;--------------------------
.text

;--------------------------
;--- test-tape-in ---------
;--------------------------

test_tape_in
                lda #$d
                sta buffer
                lda #0
                sta buffer+$16
                jsr load

                rts

