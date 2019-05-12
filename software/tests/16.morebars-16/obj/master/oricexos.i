; OricExos ----------------
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
;==========================
; oricexos inter process
; common area (ipc)
_ipc = $bfe0
;==========================
; oricexos extension board
;
; note: the code below can 
; be lot optimized
;--------------------------
extadr = $380
;--------------------------
; hold the extension status
; bit 0 - ram/rom switch
; bit 1 - on/off pp buffer
; bit 2 - in/out pp buffer
; bit 3 - mixer switch
extstat = $bfe0+1
;--------------------------
;==========================
_sei
sei
rts
;--------------------------
_cli
cli
rts
;--------------------------
irqflag .byt 0
;--------------------------
_phi
php
pla
and #%00000100
sta irqflag
sei
rts
;--------------------------
_pli
php
pla
ora irqflag
pha
plp
rts
;--------------------------
__sleept 
.word 0
__sleep
lda __sleept
bne slskp_1
lda __sleept+1
bne slskp_2
rts
slskp_2
dec __sleept+1
slskp_1
dec __sleept
clc
nop
bcc __sleep
;==========================
_reset_exos
; reset extension
lda #0
sta extstat
sta extadr
; disable vsync
jsr _set_vsync_off
; set oric id
lda $edb0
and #$03
sta $bfe0+0
rts
;==========================
_set_ram_on
_set_rom_off
pha
txa
pha
lda extstat
ora #%00000001
; forced branch
bne br_rm
;--------------------------
_set_rom_on
_set_ram_off
pha
txa
pha
lda extstat
and #%11111110
br_rm
sta extstat 
tax 
sta extadr,x
pla
tax
pla
rts
;==========================
_set_pp_on
pha
txa
pha
lda extstat
ora #%00000010
; forced branch
bne br_ppoff
;--------------------------
_set_pp_off
pha
txa
pha
lda extstat
and #%11111101
br_ppoff
sta extstat 
tax
sta extadr,x
pla
tax
pla
rts
;==========================
_set_pp_in
pha
txa
pha
lda extstat
ora #%00000100
; forced branch
bne br_ppout
;--------------------------
_set_pp_out
pha
txa
pha
lda extstat
and #%11111011
br_ppout
sta extstat 
tax
sta extadr,x
pla
tax
pla
rts
;==========================
_set_mix_b
pha
txa
pha
lda extstat
ora #%00001000
; forced branch
bne br_mix
;--------------------------
_set_mix_a
pha
txa
pha
lda extstat
and #%11110111
br_mix
sta extstat 
tax
sta extadr,x
pla
tax
pla
rts
;==========================
; tape relay off = vsync on
_set_vsync_on
pha
lda $0302
ora #%01000000
sta $0302
lda $0300
and #%10111111
sta $0300
pla
rts
;--------------------------
; tape relay on = vsync off
_set_vsync_off
pha
lda $0302
ora #%01000000
sta $0302
lda $0300
ora #%01000000
sta $0300
pla
rts
