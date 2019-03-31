; ---------------------------------
; parallel port receiver
; for integration in slave ROMs

; ---------------------------------
; addr : mem | ppbuf | ppdir | mix
; ---------------------------------
; $380 : rom |  off  |  out  |  A
; $381 : ram |  off  |  out  |  A
; $382 : rom |  on   |  out  |  A
; $383 : ram |  on   |  out  |  A
; $384 : rom |  off  |  in   |  A
; $385 : ram |  off  |  in   |  A
; $386 : rom |  on   |  in   |  A
; $387 : ram |  on   |  in   |  A
; $388 : rom |  off  |  out  |  B
; $389 : ram |  off  |  out  |  B
; $38A : rom |  on   |  out  |  B
; $38B : ram |  on   |  out  |  B
; $38C : rom |  off  |  in   |  B
; $38D : ram |  off  |  in   |  B
; $38E : rom |  on   |  in   |  B
; $38F : ram |  on   |  in   |  B
; ---------------------------------

; ---------------------------------
#define via_b         $0300
#define via_a         $0301
#define via_ddrb      $0302
#define via_ddra      $0303
#define via_t1cl      $0304
#define via_t1ch      $0305
#define via_t1ll      $0306
#define via_t1lh      $0307
#define via_t2ll      $0308
#define via_t2lh      $0309
#define via_t2cl      $0308
#define via_t2ch      $0309
#define via_sr        $030a
#define via_acr       $030b
#define via_pcr       $030c
#define via_ifr       $030d
#define via_ier       $030e
#define via_aor       $030f

#define via_bit_ca2   0
#define via_irq_ca2   (1<<via_bit_ca2)

#define via_bit_ca1   1
#define via_irq_ca1   (1<<via_bit_ca1)
#define via_ca1_rise  via_irq_ca1
#define via_ca1_fall  ($ff ^ via_irq_ca1)

#define via_bit_sr    2
#define via_irq_sr    (1<<via_bit_sr)

#define via_bit_cb2   3
#define via_irq_cb2   (1<<via_bit_cb2)

#define via_bit_cb1   4
#define via_irq_cb1   (1<<via_bit_cb1)
#define via_cb1_rise  via_irq_cb1
#define via_cb1_fall  ($ff ^ via_irq_cb1)

#define via_bit_t2    5
#define via_irq_t2    (1<<via_bit_t2)
#define via_mask_t2   ($7f ^ via_irq_t2)

#define via_bit_t1    6
#define via_irq_t1    (1<<via_bit_t1)
#define via_mask_t1   ($7f ^ via_irq_t1)


; =================================
.zero
zpp     =     0
zcmd    =     zpp
zflg    =     zpp+1
zdst    =     zpp+2
zsiz    =     zpp+4
zid     =     zpp+6


; ---------------------------------
; the value on address is 
; used as ID of every oric
; PEEK(#EDB0) AND 7
#define id_addr       $edb0

; ---------------------------------
#define r_via_reset   $e93d
#define r_searching   $e57d

; =================================
.text
; ---------------------------------
*       =     $FBD0
; ---------------------------------

; =================================
entry
        ; -------------------
        ; setup via for slave
        
        ; disable via irq
        lda   #%01111111
        sta   via_ier
        lda   #$00
        sta   via_ifr

        ; set pb4(stb) to 0
        lda   via_b
        and   #%11101111
        sta   via_b

        ; set pb4 as output
        lda   via_ddrb
        ora   #%00010000
        sta   via_ddrb

        ; set ca1 active neg edge
        lda   via_pcr
        and   #via_ca1_fall
        sta   via_pcr

        ; set port a as input
        lda   #%00000000
        sta   via_ddra
        sta   via_a

        lda   via_acr
        ; disable port b latch
        and   #%11111101
        ; enable port a latch
        ora   #%00000001
        sta   via_acr
       
        ; $386 : rom|on |in|A
        sta   $386
        
        ;        
        jsr   r_searching
        jsr   receive

        ; $384 : rom|off|in|A
        sta   $384
        jsr   r_via_reset
        
        ; not for this slave
        lda   zid
        beq   entry
        ; not autoexec
        lda   zflg
        bpl   entry

; ---------------------------------
        jmp   (zdst)
; ---------------------------------

;--------------------------
receive_byte
        lda   #via_irq_ca1
lp_igb
        bit   via_ifr
        beq   lp_igb
        
        ldx   via_a

        ; the tricky part
        ; set PB4 as input
        ; which sets line to 1
        lda   #%11101111
        and   via_ddrb
        sta   via_ddrb

        ; wait other slaves
        ; to do the same
lp_igbw
        lda   via_b
        and   #%00010000
        beq   lp_igbw

        ; set PB4 as output
        ; which sets line to 0
        ; optimized the same value
        ; lda   #%00010000 - 
        ora   via_ddrb
        sta   via_ddrb

        txa
        rts

; ---------------------------------
receive
        ; receive synchro
rx_55
        jsr   receive_byte
        cmp   #$55
        bne   rx_55
rx_AA
        jsr   receive_byte
        cmp   #$55
        beq   rx_AA
        cmp   #$aa
        bne   rx_55

        ; receive 6 bytes header
        ldy   #$00
rx_hdr
        jsr   receive_byte
        sta   zpp,y
        iny
        cpy   #$06
        bne   rx_hdr

        lda   id_addr
        ; optimized - posible values are $31,$32,$33
        ; and   #%00000111
        and   zflg
        sta   zid

        ; receive content
        ldy   #$00
rx_cont
        jsr   receive_byte
        ldx   zid
        beq   rxs_1
        sta   (zdst),y

        inc   zdst
        bne   rxs_1
        inc   zdst+1
rxs_1
        dec   zsiz
        bne   rx_cont
        lda   zsiz+1
        beq   rxs_2
        dec   zsiz+1
        jmp   rx_cont
rxs_2
        rts

finish
