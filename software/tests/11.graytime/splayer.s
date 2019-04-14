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
        jsr   _reset_exos

        ; ligth the led
;         jsr   _set_ram_on
        
        jsr   _set_irq_handler

        ; hook nmi and reset
;         lda   #<_irq_handler
;         sta   nmi_ram_addrlo        
;         sta   rst_ram_addrlo        
;         lda   #>_irq_handler
;         sta   nmi_ram_addrhi        
;         sta   rst_ram_addrhi        

;--------------------------
        jmp   _player

;--------------------------
; hires line addresses
#include "scrn_tab.s"
