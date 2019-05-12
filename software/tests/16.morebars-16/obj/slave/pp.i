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
;==========================
;--------------------------
__pp_defprogress
lda #<__pp_defprogress
ldx #>__pp_defprogress
__pp_setprogress
sta pp_progress_1+1
sta pp_progress_2+1
stx pp_progress_1+2
stx pp_progress_2+2
rts
;--------------------------
__pp_receive
php
sei
sty pp_save_y
jsr pp_setup_slave
lda __pp_cmd_ptr
sta zptr
lda __pp_cmd_ptr+1
sta zptr+1
; zflg holds slave number
ldy #(zflg-zcmd)
lda (zptr),y
tay
lda id_mask,y
sta zsrc
; receive synchro
rx_55
jsr pp_in_get_byte
cmp #$55
bne rx_55
rx_AA
jsr pp_in_get_byte
cmp #$55
beq rx_AA
cmp #$aa
bne rx_55
; receive 6 bytes header
ldy #$00
rx_hdr
jsr pp_in_get_byte
sta (zptr),y
sta zcmd,y
iny
cpy #$06
bne rx_hdr
; mask slave
lda zflg
and zsrc
sta zsrc
; if not for this slave
; no store, no autoexec
beq rxs_0
lda zflg
and #$80 
rxs_0
; autoexec flag
ldy #(zflg-zcmd)
sta (zptr),y
sta zflg
; signal client
lda zsrc
bne rx_go
pp_progress_1
jsr __pp_defprogress
rx_go
; receive content
ldy #$00
rx_cont
jsr pp_in_get_byte
; not for this slave
ldx zsrc
beq rxs_1
sta (zdst),y
inc zdst
bne rxs_1
inc zdst+1
rxs_1
dec zsiz
bne rx_cont
lda zsiz+1
beq rxs_2
dec zsiz+1
jmp rx_cont
rxs_2
; restore via registers
jsr pp_reset
pp_progress_2
jsr __pp_defprogress
ldy pp_save_y
plp
rts
;--------------------------
id_mask .byt $00,$01,$02,$04
;--------------------------
pp_setup_slave
; disable via irq
lda #%01111111
sta $030e
sta $030d
; set pb4(stb) to 0
lda $0300
and #%11101111
sta $0300
; set pb4 as output
lda $0302
ora #%00010000
sta $0302
; set ca1 active neg edge
lda $030c
and #($ff ^ %00000001)
sta $030c
; set port a as input
lda #%00000000
sta $0303
sta $0301
lda $030b
; disable port b latch
and #%11111101
; enable port a latch
ora #%00000001
sta $030b
jsr _set_pp_in
jsr _set_pp_on
rts
;--------------------------
pp_in_setup_send
; ToDo ....
rts
;--------------------------
pp_in_put_byte
; ToDo ....
rts
;--------------------------
pp_in_get_byte
lda #(1<<1)
lp_igb
bit $030d
beq lp_igb
lda $0301
pha
; the tricky part
; set PB4 as input
; which sets line to 1
lda #%11101111
and $0302
sta $0302
; wait other slaves
; to do the same
lp_igbw
lda $0300
and #%00010000
beq lp_igbw
; set PB4 as output
; which sets line to 0
; optimized - lda #%00010000
ora $0302
sta $0302
pla
rts
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
