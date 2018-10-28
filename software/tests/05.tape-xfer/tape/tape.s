;--------------------------
#define dsb             .dsb
#define byt             .byt
#define wrd             .word


;--------------------------
#define via_b           $0300
#define via_a           $0301
#define via_ddrb        $0302
#define via_ddra        $0303
#define via_t1cl        $0304
#define via_t1ch        $0305
#define via_t1ll        $0306
#define via_t1lh        $0307
#define via_t2ll        $0308
#define via_t2lh        $0309
#define via_t2cl        $0308
#define via_t2ch        $0309
#define via_sr          $030a
#define via_acr         $030b
#define via_pcr         $030c
#define via_ifr         $030d
#define via_ier         $030e
#define via_aor         $030f

;--------------------------
.zero

shifter                 = $2f
block                   = $32                     ; current block in hex
crc                     = $33                     ; crc is stored here.
crcl                    = crc
crch                    = crc+1
length                  = $35                     ; msb of length, for last block
crcdata                 = $36                     ; pointer to where crc will be calculated from        
crcdatal                = crcdata
crcdatah                = crcdata+1
crclen                  = $38                     ; length of data for crc.
errorflg                = $39                     ; 0 no error, 1 error
dstptr                  = $40
                        
buffer                  = $b400
tap_start               = buffer+$10
tap_end                 = buffer+$12
tap_run                 = buffer+$14
                        
bit_time                = $b0

r_via_set               = $e76a       ; init VIA (disable T1 interrupt) and set flag I
r_via_reset             = $e93d       ; restore VIA settings and clear flag I

;--------------------------
.text

;--------------------------
;--- tape -----------------
;--------------------------

; via_reset
;                 php
;                 sei
;                 lda #$40
;                 sta via_acr
;                 lda #$7f
;                 sta via_ier
;                 lda #$c0
;                 sta via_ier
;                 lda #$10
;                 sta via_t1ll
;                 sta via_t1cl
;                 lda #$27
;                 sta via_t1lh
;                 sta via_t1ch
;                 lda #$ff
;                 sta via_ifr
;                 plp
;                 rts

; via_set
;                 php
;                 sei
;                 lda #<(bit_time)
;                 sta via_t1cl
;                 lda #>(bit_time)
;                 sta via_t1ch
;                 lda #$c0
;                 sta via_acr
;                 lda #$ff
;                 sta via_ddrb
;                 lda #$10
;                 sta via_pcr
;                 lda #$f4
;                 sta via_t2ll
;                 lda #$7f
;                 sta via_ier
;                 plp
;                 rts

; displays name, y holds offset
; from buffer for start of name.
dispname        
                ldx #0
dispname_1
                lda buffer,y
                cmp #$d
                beq dspnend
                sta $bf92,x
                inx
                iny
                cpx #16
                bne dispname_1
                rts

dspnend
                lda #32
dspnend_1       
                sta $bf92,x
                inx
                cpx #16
                bne dspnend_1
                rts

; prints A in hex
; X - offset
dispblock
                pha
                lsr
                lsr
                lsr
                lsr
                jsr hexprint
                pla
                inx
                and #$0f
                jsr hexprint
                rts

hexprint
                clc
                adc #48
                cmp #58
                bcc notletter
                clc
                adc #7
notletter      
                sta $bf68,x
                rts


; calculates crc of data at dstptr
; for crclen bytes (256 max)
; crc left in crcl and crch.
crccalc
                lda #0
                sta crch
                sta crcl
                tay
nextbyte        
                lda (crcdata),y
                eor crch
                sta crch
                ldx #8
bloblop        
                lda crch
                rol
                bcc bz7
                lda crch
                eor #8
                sta crch
                lda crcl
                eor #$10
                sta crcl
bz7             
                rol crcl
                rol crch
                dex
                bne bloblop
                iny
                cpy crclen
                bne nextbyte
                rts


;--------------------------
;--- tape-in --------------
;--------------------------

loading         byt 'loading',0
blkdudms        byt 'block ? '
heddudms        byt 'buffer ?'
datdudms        byt 'data ?  '
errormess       byt 'error at block : '
searmess        byt 'searching'

load
                jsr r_via_set
                lda #0
                sta errorflg
                sta block
                ldx #8
load_1 
                lda searmess,x
                sta $bf6a,x
                dex
                bpl load_1

; main loop for loading on blocks
blockload
                jsr synchin
blockload_4 
                jsr inbyte
                cmp #$16
                beq blockload_4
                cmp #$b4
                bne blockload

; check that we are about to load
; header and not data.
                ldy #0
blockload_1
                jsr inbyte
                sta buffer+$20,y
                iny
                cpy #28

; load entire header ( like wow !)
                bne blockload_1
                ldx #39
                lda #32
blockload_3
                sta $bfba,x
                dex
                bpl blockload_3
                ldy #$20
                jsr dispname
                lda buffer+$30
                ldx #$3b
                jsr dispblock
                lda buffer
                cmp #$d
                beq nameok
                ldx #0
blockload_2
                lda buffer,x
                cmp buffer+$20,x
                bne nameduff
                cmp #$d
                beq nameok
                inx
                cpx #16
                bne blockload_2

; name is ok, how about block ?
nameok
                ldx #0
nameok_2
                lda buffer+$20,x
                sta buffer,x
                inx
                cmp #$d
                bne nameok_2
                lda buffer+$30
                cmp block
                beq blockok

; nope, name or block are bad.
nameduff
                ldx #7
nameduff_1
                lda blkdudms,x
                sta $bfba,x
                dex
                bpl nameduff_1
                jmp loaderror

blockok
                lda #<(buffer+$20)
                sta crcdata
                lda #>(buffer+$20)
                sta crcdata+1
                lda #$16
                sta crclen
                jsr crccalc
                lda crcl
                cmp buffer+$36
                bne headbad
                lda crch
                cmp buffer+$37
                beq bufferok
                
; crc on buffer is bad, say so.
headbad
                ldx #7
headbad_1
                lda heddudms,x
                sta $bfba,x
                dex
                bpl headbad_1
                jmp loaderror

; if we get here then buffer is ok
; so let`s try and load some data.
bufferok
                ldx #7
bufferok_2
                lda loading,x
                sta $bf6a,x
                dex
                bpl bufferok_2
                inx
                stx errorflg
                lda buffer+$31
                sta dstptr
                lda buffer+$32
                clc
                adc block
                sta dstptr+1
                jsr synchin

; wait for zero after synch
bufferok_1
                jsr inbyte
                bne bufferok_1

                ldy #0
bufferok_6
                jsr inbyte
                sta (dstptr),y
                iny
                bne bufferok_6
                
; yes readers, this pathetic bit
; of code is all it takes to load
; on all of the data
                lda dstptr
                sta crcdata
                lda dstptr+1
                sta crcdata+1
                jsr inbyte
                sta dstptr
                jsr inbyte
                sta dstptr+1
                lda #0
                sta crclen
                jsr crccalc
                lda crcl
                cmp dstptr
                bne databad
                lda crch
                cmp dstptr+1
                bne databad
                lda buffer+$33
                bne endload

; is it the last block ?
                inc block
                jmp blockload

; yup, it`s the last block
endload
                lda buffer+$35
                beq noautorun
                
; does it orto run ?
                jmp (buffer+$34)
noautorun
                jsr r_via_reset
                rts

; the poor bastard has had a data
; error, pity him.
databad
                ldx #7
databad_1
                lda datdudms,x
                sta $bfba,x
                dex
                bpl databad_1
loaderror
                lda errorflg
                bne errorbef
                ldx #$10
databad_2
                lda errormess,x
                sta $bf6a,x
                dex
                bpl databad_2
                stx errorflg
                ldx #$15
                lda block
                jsr dispblock
errorbef        
                jmp blockload


; get computer in synch with cass.
synchin
                pha
                txa
                pha
                tya
                pha
inbyte_14
                jsr inbyte_1
                ror shifter
                lda #$16
                cmp shifter
                bne inbyte_14
                ldx #3
inbyte_4
                jsr inbyte
                cmp #$16
                bne inbyte_14
                dex
                bne inbyte_4
                pla
                tay
                pla
                tax
                pla
                rts
inbyte_1
                jsr inbyte_3
inbyte_13
                rts
inbyte_3
                pha
                lda via_b
inbyte_7
                lda via_ifr
                and #$10
                beq inbyte_7
                
                lda via_t2ch

                pha
                lda #$ff
                sta via_t2ch
                pla
                
                cmp #$fe
                
                pla
                rts


; get byte from cassette, leave in
; acc, others registers unharmed.
inbyte
                txa
                pha
                tya
                pha
                jsr inbyte_3
inbyte_8
                jsr inbyte_3
                bcs inbyte_8
                jsr inbyte_13
                bcs inbyte_9
                lda #0
                ldy #8
inbyte_10
                jsr inbyte_1
                php
                ror shifter
                plp
                adc #0
                dey
                bne inbyte_10
                jsr inbyte_1
                adc #0
                clc
inbyte_9
                pla
                tay
                pla
                tax
                lda shifter
                rts


;--------------------------
;--- tape-out -------------
;--------------------------
save
                lda #0
                sta block
                sta tap_start
                lda #$ff
                sta tap_end
                lda tap_end+1
                sec
                sbc tap_start+1
                sta length
                jsr r_via_set
                ldy #0
                jsr dispname
                lda tap_start
                sta dstptr
                lda tap_start+1
                sta dstptr+1

; main loop for outputting blocks
saveblock
                lda block
                ldx #$3b
                jsr dispblock
                jsr sendblock
                inc block
                
;                 ldx dstptr+1
;                 inx
;                 stx dstptr+1
;                 dex
;                 cpx tap_end+1

                ldx dstptr+1
                inc dstptr+1
                cpx tap_end+1

                bne saveblock
                jsr r_via_reset
                rts

; outputs byte
outbyte
                sta shifter
                pha
                txa
                pha
                tya
                pha
                jsr outbyte_10
                clc
                ldy #9
                lda #0
                beq outbyte_1
outbyte_2
                lsr shifter
                php
                adc #0
                plp
outbyte_1
                jsr outbyte_4
                dey
                bne outbyte_2
                eor #1
                lsr
                ldy #4
outbyte_3
                jsr outbyte_4
                sec
                dey
                bne outbyte_3
                pla
                tay
                pla
                tax
                pla
                rts
outbyte_4
                pha
                php
                sec
                jsr outbyte_11
                plp
                jsr outbyte_11
                pla
                rts
                
outbyte_11
                lda #<(bit_time)
                ldx #>(bit_time)
                bcs outbyte_6
                lda #<(bit_time*2)
                ldx #>(bit_time*2)
outbyte_6
                sta via_t1ll
                stx via_t1lh
outbyte_10
                lda via_t1cl
outbyte_7
                bit via_ifr
                bvc outbyte_7
                rts

; as outbyte but crc check is
; recalculated accordingly
crcoutbyt
                jsr outbyte
                sta shifter
                pha
                txa
                pha
                tya
                pha
                lda shifter
                eor crch
                sta crch
                ldx #8
blobbo
                lda crch
                rol
                bcc bzz7
                lda crch
                eor #8
                sta crch
                lda crcl
                eor #$10
                sta crcl
bzz7
                rol crcl
                rol crch
                dex
                bne blobbo
                pla
                tay
                pla
                tax
                pla
                rts

; send 16 x $16 codes then 1 code 0
synchout
                pha
                txa
                pha
                tya
                pha
                lda #$16
                ldx #16
synchout_1
                jsr outbyte
                dex
                bne synchout_1
                txa
                jsr outbyte
                pla
                tay
                pla
                tax
                pla
                rts


; outputs block, buffer, crc.
; this does all the work for save
sendblock
                ldx #16
                lda buffer+$16
                beq fastgap
                ldx #2
fastgap

; send gap of 1`s
                lda #1
sendblock_1
                jsr outbyte
                dex
                bne sendblock_1

                lda #$16
                ldx #8
sendblock_5
                jsr outbyte
                dex
                bne sendblock_5

; we are sending buffer so $b4
; comes after synch.
                lda #$b4
                jsr outbyte
                
                ldy #0
                sty crcl
                sty crch
sendblock_2
; send name
                lda buffer,y
                jsr crcoutbyt
                iny
                cpy #16
                bne sendblock_2

                lda block
                jsr crcoutbyt
                lda tap_start
                jsr crcoutbyt
                lda tap_start+1
                jsr crcoutbyt
                ldx #0
                lda block
                cmp length
                bne notend
                dex

; not last block
notend
                txa
                jsr crcoutbyt
                lda tap_run
                jsr crcoutbyt
                lda tap_run+1
                jsr crcoutbyt
                lda crcl
                jsr outbyte
                lda crch
                jsr outbyte
                ldy #4
                lda #0
notend_1
                jsr outbyte
                dey
                bne notend_1
                jsr synchout
                ldy #0

; send 256 bytes of data loop
outdata
                lda (dstptr),y
                jsr outbyte
                iny
                bne outdata
                lda dstptr
                sta crcdata
                lda dstptr+1
                sta crcdata+1
                sty crclen
                jsr crccalc
                lda crcl
                jsr outbyte
                lda crch
                jsr outbyte
                lda #1
                jsr outbyte
                jsr outbyte
                rts