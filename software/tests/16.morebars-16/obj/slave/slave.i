;--------------------------
;--------------------------
.text
;--------------------------
r_cls = $ccce
r_print = $ccb0
r_cload = $e874
r_cstat = $e5f5
r_pstat = $e5ea
b_paper = $026b
b_ink = $026c
id_addr = $edb0
;--------------------------
* = 1536
_start
sei
cld
; paper black
lda #$10+0
sta b_paper
; ink white
lda #$07
sta b_ink
jsr r_cls
ldx #39
lda #$20
loop_1
sta _scrn_ptr,x
dex
bpl loop_1
lda id_addr
and #$07
sta id
cmp #$04
bcs _stop
asl
tay
lda jmptab,y
pha
lda jmptab+1,y
pha
rts
_stop
jsr r_cstat
lda #<(mhalt)
ldy #>(mhalt)
jsr r_pstat
jmp *
; jmp r_cload
;--------------------------
wait
lda #$00
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
bne loop_wait
dex
bne loop_wait
rts
;--------------------------
id .byt 0
tmp .byt 0
crlf .byt $0d, $0a, 0
mhalt .byt $10, $01, "Oric halted",0
jmptab .byt >(_master-1),<(_master-1)
.byt >(_slave_1-1),<(_slave_1-1)
.byt >(_slave_2-1),<(_slave_2-1)
.byt >(_slave_3-1),<(_slave_3-1)
;--------------------------
_master
jsr wait
jsr wait
jsr wait
lda #$10
m_loop
sta b_paper
jsr r_cls
jsr wait
jsr _set_mix_b
jsr wait
jsr _set_mix_a
jsr wait
inc b_paper
lda b_paper
cmp #$18
bne m_loop
lda #$10
sta b_paper
jsr r_cls
; jmp _stop
jmp *
;--------------------------
_slave_1
ldy #$01
ldx #$10
lda #$03
sta tmp
s1_loop
lda _scrn_lo,y
sta s1_ptr+1
lda _scrn_hi,y
sta s1_ptr+2
txa
s1_ptr
sta $1234
iny
dec tmp
bne s1_loop
lda #$03
sta tmp
inx
cpx #$18
bne s1_loop
lda #28
sta tmp
s1_loopw
jsr wait
dec tmp
bne s1_loopw
lda #$10
sta b_paper
jsr r_cls
; jmp _stop
jmp *
;--------------------------
_slave_2
ldy #$00
s2_loopy
lda _scrn_lo+1,y
sta s2_ptr+1
lda _scrn_hi+1,y
sta s2_ptr+2
ldx #$00
s2_loopx
lda s2_div8,x
s2_ptr
sta $1234,x
inx
cpx #$28
bne s2_loopx
iny
cpy #$18
bne s2_loopy
lda #28
sta tmp
s2_loopw
jsr wait
dec tmp
bne s2_loopw
lda #$10
sta b_paper
jsr r_cls
; jmp _stop
jmp *
s2_div8 
.byt $10,$10,$10,$10,$10
.byt $11,$11,$11,$11,$11
.byt $12,$12,$12,$12,$12
.byt $13,$13,$13,$13,$13
.byt $14,$14,$14,$14,$14
.byt $15,$15,$15,$15,$15
.byt $16,$16,$16,$16,$16
.byt $17,$17,$17,$17,$17
;--------------------------
_slave_3
; jmp _stop
jmp *
;--------------------------
; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
_scrn_ptr = $bb80
_scrn_lo
.byt <(_scrn_ptr+( 0*40))
.byt <(_scrn_ptr+( 1*40))
.byt <(_scrn_ptr+( 2*40))
.byt <(_scrn_ptr+( 3*40))
.byt <(_scrn_ptr+( 4*40))
.byt <(_scrn_ptr+( 5*40))
.byt <(_scrn_ptr+( 6*40))
.byt <(_scrn_ptr+( 7*40))
.byt <(_scrn_ptr+( 8*40))
.byt <(_scrn_ptr+( 9*40))
.byt <(_scrn_ptr+( 10*40))
.byt <(_scrn_ptr+( 11*40))
.byt <(_scrn_ptr+( 12*40))
.byt <(_scrn_ptr+( 13*40))
.byt <(_scrn_ptr+( 14*40))
.byt <(_scrn_ptr+( 15*40))
.byt <(_scrn_ptr+( 16*40))
.byt <(_scrn_ptr+( 17*40))
.byt <(_scrn_ptr+( 18*40))
.byt <(_scrn_ptr+( 19*40))
.byt <(_scrn_ptr+( 20*40))
.byt <(_scrn_ptr+( 21*40))
.byt <(_scrn_ptr+( 22*40))
.byt <(_scrn_ptr+( 23*40))
.byt <(_scrn_ptr+( 24*40))
.byt <(_scrn_ptr+( 25*40))
.byt <(_scrn_ptr+( 26*40))
.byt <(_scrn_ptr+( 27*40))
_scrn_hi
.byt >(_scrn_ptr+( 0*40))
.byt >(_scrn_ptr+( 1*40))
.byt >(_scrn_ptr+( 2*40))
.byt >(_scrn_ptr+( 3*40))
.byt >(_scrn_ptr+( 4*40))
.byt >(_scrn_ptr+( 5*40))
.byt >(_scrn_ptr+( 6*40))
.byt >(_scrn_ptr+( 7*40))
.byt >(_scrn_ptr+( 8*40))
.byt >(_scrn_ptr+( 9*40))
.byt >(_scrn_ptr+( 10*40))
.byt >(_scrn_ptr+( 11*40))
.byt >(_scrn_ptr+( 12*40))
.byt >(_scrn_ptr+( 13*40))
.byt >(_scrn_ptr+( 14*40))
.byt >(_scrn_ptr+( 15*40))
.byt >(_scrn_ptr+( 16*40))
.byt >(_scrn_ptr+( 17*40))
.byt >(_scrn_ptr+( 18*40))
.byt >(_scrn_ptr+( 19*40))
.byt >(_scrn_ptr+( 20*40))
.byt >(_scrn_ptr+( 21*40))
.byt >(_scrn_ptr+( 22*40))
.byt >(_scrn_ptr+( 23*40))
.byt >(_scrn_ptr+( 24*40))
.byt >(_scrn_ptr+( 25*40))
.byt >(_scrn_ptr+( 26*40))
.byt >(_scrn_ptr+( 27*40))

