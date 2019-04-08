;--------------------------
#include <defasm.h>
#include <oricexos.h>


#define irq_addrlo $fffe
#define irq_addrhi $ffff
#define rst_addrlo $fffc
#define rst_addrhi $fffd
#define nmi_addrlo $fffa
#define nmi_addrhi $fffb


;--------------------------
.text

;--------------------------
*       = SLAVE_01_ADDRESS
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

        bit   #via_irq_cb1
        beq   no_vsync
        jsr   ipc_vsync
        lda   via_b
        jmp   skip

no_vsync
        bit   #via_irq_t1
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
        sei
        lda   #$10
        sta   b_paper
        lda   #$07
        sta   b_ink
        jsr   r_cls

        jsr   r_hires
        
        jsr   _set_ram_on
        
        lda   #<_irq_handler
        sta   irq_addrlo
        lda   #>_irq_handler
        sta   irq_addrhi        

        ; redirect
        lda   #<0400
        sta   nmi_addrlo        
        sta   rst_addrlo        
        lda   #>0400
        sta   nmi_addrhi        
        sta   rst_addrhi        

        ; rts op-code
        lda   #$60
        sta   ipc_vsync
        sta   ipc_vsync+1
        sta   ipc_vsync+2
        rts
