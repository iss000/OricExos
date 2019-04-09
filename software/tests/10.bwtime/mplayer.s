;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
_dosrom =     $04f2

;--------------------------
*       = MPLAYER_ADDRESS

;--------------------------
        jmp   _start

;--------------------------
; player code
#include "player.s"

;--------------------------
_start
        sei
        jsr   _reset_exos

        lda   id_addr
        and   #$03
        sta   ipc_id
     
        ; clear last line
        ldx   #40
slp_1
        sta   $bb80-1+27*40,x
        dex
        bne   slp_1

        ; toggle rom on/off
        jsr   _dosrom
        ; ligth the led
        jsr   _set_ram_on
        jsr   _set_irq_handler

        ; hook nmi and reset
        ; redirect irq
        lda   #<_irq_handler
        sta   nmi_addrlo        
        sta   rst_addrlo        
        lda   #>_irq_handler
        sta   nmi_addrhi        
        sta   rst_addrhi        

;--------------------------
        ; show time
        jsr   _set_vsync_on
        jsr   _wait_vsync
        cli
        
;--------------------------
        ; loop forever
        jmp   *
        
;--------------------------
_wait_vsync
        lda   via_b
        lda   #via_irq_cb1
wvlp_1
        bit   via_ifr
        beq   wvlp_1
        rts

;--------------------------
; hires line addresses
#include "scrn_tab.s"
