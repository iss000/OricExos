;--------------------------
#include <defasm.h>
#include <oricexos.h>

;--------------------------
.text

;--------------------------
*       = SPLAYER_ADDRESS
;--------------------------
        jmp   _start

;--------------------------
; player code
#include "player.s"


;--------------------------
_start
        sei
        jsr   _set_ram_on
        jsr   _set_irq_handler

        ; hook nmi and reset
        lda   #<PPLINK_ADDRESS
        sta   nmi_addrlo        
        sta   rst_addrlo        
        lda   #>PPLINK_ADDRESS
        sta   nmi_addrhi        
        sta   rst_addrhi        

;--------------------------
        ; show time
        jsr   wait_vsync
        cli
        
;--------------------------
        ; loop forever
        jmp   *
        
;--------------------------
wait_vsync
        lda   via_b
        lda   #via_irq_cb1
wvlp_1
        bit   via_ifr
        beq   wvlp_1
        rts
        
;--------------------------
; hires line addresses
#include "scrn_tab.s"
