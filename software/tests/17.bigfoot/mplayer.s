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
     
        ; clear last line
        ldx   #40
        lda   #$20
slp_1
        sta   $bb80-1+27*40,x
        dex
        bne   slp_1

        ; toggle rom on/off
;         jsr   _dosrom
        ; ligth the led
;         jsr   _set_ram_on
        
        jsr   _set_irq_handler

        ; hook nmi and reset
;         lda   #<_irq_handler
;         sta   nmi_addrlo        
;         sta   rst_addrlo        
;         lda   #>_irq_handler
;         sta   nmi_addrhi        
;         sta   rst_addrhi        

;--------------------------
        jmp   _player

;--------------------------
; hires line addresses
#include "scrn_tab.s"
