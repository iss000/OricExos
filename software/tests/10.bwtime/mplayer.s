;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = MPLAYER_ADDRESS

;--------------------------
_dosrom =     $04f2

;--------------------------
        jmp   _start
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
        ; Clear T1 IRQ event
        bit   via_t1cl

skip
        ldy   irq_save_y
        ldx   irq_save_x
        lda   irq_save_a
        plp
        rti

;--------------------------
_start
        lda   id_addr
        and   #$03
        sta   ipc_id
     
        ldx   #40
slp_1
        sta   $bb80-1+27*40,x
        dex
        bne   slp_1

        sei
        ; toggle rom on/off
        jsr   _dosrom

        ; redirect irq
        lda   #<_irq_handler
        sta   irq_addrlo
        sta   nmi_addrlo        
        sta   rst_addrlo        
        lda   #>_irq_handler
        sta   irq_addrhi        
        sta   nmi_addrhi        
        sta   rst_addrhi        

        ; rts op-code
        lda   #$60
        sta   ipc_vsync
        sta   ipc_vsync+1
        sta   ipc_vsync+2

        lda   #<19966
        sta   via_t1ll
        lda   #>19966
        sta   via_t1lh
        cli

        jmp   _player
;--------------------------
_stop
        jmp   *
        
;--------------------------
_player
        jsr   blit
        ldx   frame
        inx
        cpx   #frames
        bne   flp_1
        ldx   #$00
flp_1
        stx   frame
        jmp   _player
        
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

;--------------------------
#include "scrn_tab.s"
