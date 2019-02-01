; OricExos ----------------

#include <defasm.h>
#include <oricexos.h>

;==========================
; oricexos extension board
;
; note: the code below can 
; be lot optimized

;--------------------------
extadr    =   $380

;--------------------------
; hold the extension status
; bit 0 - ram/rom switch
; bit 1 - on/off pp buffer
; bit 2 - in/out pp buffer
; bit 3 - mixer switch

extstat   byt 0

;--------------------------
#define f_ram_off   %11111110
#define f_ram_on    %00000001

#define f_pp_off    %11111101
#define f_pp_on     %00000010

#define f_pp_out     %11111011
#define f_pp_in      %00000100

#define f_mix_a     %11110111
#define f_mix_b     %00001000

;==========================
_set_ram_on
_set_rom_off
.(
        pha
        txa
        pha
        lda   extstat
        ora   #f_ram_on
        ; forced branch
        bne   br

;--------------------------
_set_rom_on
_set_ram_off
        pha
        txa
        pha
        lda   extstat
        and   #f_ram_off
br            
        sta   extstat        
        tax   
        sta   extadr,x
        pla
        tax
        pla
        rts
.)

;==========================
_set_pp_on
.(
        pha
        txa
        pha
        lda   extstat
        ora   #f_pp_on
        ; forced branch
        bne   br

;--------------------------
_set_pp_off
        pha
        txa
        pha
        lda   extstat
        and   #f_pp_off
br
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts
.)

;==========================
_set_pp_in
.(
        pha
        txa
        pha
        lda   extstat
        ora   #f_pp_in
        ; forced branch
        bne br

;--------------------------
_set_pp_out
        pha
        txa
        pha
        lda   extstat
        and   #f_pp_out
br
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts
.)

;==========================
_set_mix_a
.(
        pha
        txa
        pha
        lda   extstat
        ora   #f_mix_a
        ; forced branch
        bne   br

;--------------------------
_set_mix_b
        pha
        txa
        pha
        lda   extstat
        and   #f_mix_b
br
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts
.)

