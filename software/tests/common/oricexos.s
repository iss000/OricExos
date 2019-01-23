; OricExos ----------------

#include <defasm.h>
#include <oricexos.h>

;--------------------------
extadr    =   $380

;--------------------------
; hold the extension status
; bit 0 - ram/rom switch
; bit 1
; bit 2
; bit 3

extstat   byt 0

;--------------------------
#define f_ram_off   %11111110
#define f_ram_on    %00000001

;--------------------------
_set_ram_on
_set_rom_off
        pha
        txa
        pha
        lda extstat
        ora #f_ram_on
        ; forced branch
        bne oe_ret

;--------------------------
_set_rom_on
_set_ram_off
        pha
        txa
        pha
        lda extstat
        and #f_ram_off
oe_ret
        sta extstat        
        tax
        sta extadr,x
        pla
        tax
        pla
        rts
