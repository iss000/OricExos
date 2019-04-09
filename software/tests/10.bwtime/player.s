;==========================
; interrupt handler code
;==========================

;--------------------------
_set_irq_handler
        ; setup via t1 at 50hz
        lda   #<19966
        sta   via_t1ll
        lda   #>19966
        sta   via_t1lh

        ; hook vsync handler
        ; jmp op-code
        lda   #$4c
        sta   ipc_vsync
        lda   #<_player_vsync
        sta   ipc_vsync+1
        lda   #>_player_vsync
        sta   ipc_vsync+2
        
        ; hook interrupt
        lda   #<_irq_handler
        sta   irq_addrlo
        lda   #>_irq_handler
        sta   irq_addrhi
        
        lda   #$7f
        sta   via_ier
        sta   via_ifr
        
        lda   #$80
        ora   #via_irq_t1
        ora   #via_irq_cb1
        sta   via_ier
        
        rts

;--------------------------
irq_save_a 
        byt   0
irq_save_x
        byt   0
irq_save_y
        byt   0
irq_flag
        byt   0

;--------------------------
_irq_handler
        php
        sta   irq_save_a
        stx   irq_save_x
        sty   irq_save_y
        cld

        lda   via_ifr
        sta   irq_flag

        lda   #via_irq_cb1
        bit   irq_flag
        beq   no_vsync
        jsr   ipc_vsync
        lda   via_b
        jmp   skip

no_vsync
        lda   #via_irq_t1
        bit   irq_flag
        beq   skip
        ; clear t1 irq event
        bit   via_t1cl

skip
        ldy   irq_save_y
        ldx   irq_save_x
        lda   irq_save_a
        plp
        rti

;==========================
; frame player code
;==========================

;--------------------------
_player
        jmp   _player
        
;--------------------------
_player_vsync
        jsr   blit
        ldx   frame
        inx
        cpx   #frames
        bne   flp_1
        ldx   #$00
flp_1
        stx   frame
        rts
        
;--------------------------
framew  =     (150/6)
frameh  =     (120)
frames  =     (11)

_tab_frames_lo = MOVIE_ADDRESS+(framew*frameh*frames)
_tab_frames_hi = _tab_frames_lo+frames 

frame   byt   0
        
blit
        ldy   frame
        lda   _tab_frames_lo,y
        sta   __auto_src+1
        lda   _tab_frames_hi,y
        sta   __auto_src+2

        ldy   #0
blp_y
        lda   _scrn_lo-1,y
        sta   __auto_dst+1
        lda   _scrn_hi-1,y
        sta   __auto_dst+2
        ldx   #0
blp_x
;
__auto_src
        lda   $f00d,x
;
__auto_dst
        sta   $f00d,x

        inx
        cpx   #framew
        bne   blp_x
        
        txa
        clc
        adc   __auto_src+1
        sta   __auto_src+1
        lda   #$00
        adc   __auto_src+2
        sta   __auto_src+2
        
        iny
        cpy   #frameh
        bne   blp_y

        rts
