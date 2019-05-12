;==========================
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
;==========================
;--- parallel port xfer ---
;--------------------------
;==========================
.zero
;--------------------------
; NOTE: 
; change zpp if needed
zpp = $90
zptr = zpp+0
zcmd = zpp+2
zflg = zpp+3
zdst = zpp+4
zsiz = zpp+6
zsrc = zpp+8
;==========================
.text
;--------------------------
__pp_cmd_ptr
.word 0
;--------------------------
pp_save_via_ier
.byt 0
pp_save_via_acr
.byt 0
pp_save_via_pcr
.byt 0
pp_save_via_ddra
.byt 0
pp_save_via_ddrb
.byt 0
pp_save_via_a
.byt 0
pp_save_via_b
.byt 0
;--------------------------
pp_save_y 
.byt 0
;==========================
;--------------------------
__pp_send
php
sei
sty pp_save_y
jsr pp_setup_master
lda __pp_cmd_ptr
sta zptr
lda __pp_cmd_ptr+1
sta zptr+1
ldy #$00
txl_1
lda (zptr),y
sta zcmd,y
iny
cpy #$08
bne txl_1
; send synchro
; 55 55 ... 55 AA
ldy #$07
lda #$55
tx_syn
jsr pp_out_put_byte
dey
bne tx_syn
lda #$aa
jsr pp_out_put_byte
; send 6 bytes header
ldy #$00
tx_hdr
lda (zptr),y
jsr pp_out_put_byte
iny
cpy #$06
bne tx_hdr
; send content
ldy #$00
tx_cont
lda (zsrc),y
jsr pp_out_put_byte
;
inc zsrc
bne txs_1
inc zsrc+1
txs_1
dec zsiz
bne tx_cont
lda zsiz+1
beq txs_2
dec zsiz+1
jmp tx_cont
txs_2
; restore via registers
jsr pp_reset
ldy pp_save_y
plp
rts
;--------------------------
pp_setup_master
lda $030e
sta pp_save_via_ier
; disable via irq
lda #%01111111
sta $030e
sta $030d
; set pb4(stb) to 1
lda $0300
sta pp_save_via_b
ora #%00010000
sta $0300
; set pb4 as output
lda $0302
sta pp_save_via_ddrb
ora #%00010000
sta $0302
; set ca1 active pos edge
lda $030c
sta pp_save_via_pcr
ora #%00000001
sta $030c
; set port a as output
lda $0301
sta pp_save_via_a
lda $0303
sta pp_save_via_ddra
lda #%11111111
sta $0303
sta $0301
; disable port a+b latch
lda $030b
sta pp_save_via_acr
and #%11111100
sta $030b
jsr _set_pp_out
jsr _set_pp_on
rts
;--------------------------
pp_out_put_byte
pha
sta $0301
lda $0300
and #%11101111
sta $0300
lda #(1<<1)
lp_opb
bit $030d
beq lp_opb
lda $0300
ora #%00010000
sta $0300
pla
rts
;--------------------------
pp_out_setup_receive
; ToDo ....
rts
;--------------------------
pp_out_get_byte
; ToDo ....
rts
;==========================
;==========================
;--------------------------
pp_reset
jsr _set_pp_off
jsr _set_pp_out
lda pp_save_via_b
sta $0300
lda pp_save_via_ddrb
sta $0302
lda pp_save_via_a
sta $0301
lda pp_save_via_ddra
sta $0303
lda pp_save_via_pcr
sta $030c
lda pp_save_via_acr
sta $030b
lda #%01111111
sta $030e
sta $030d
lda pp_save_via_ier
ora #$80
sta $030e
rts
