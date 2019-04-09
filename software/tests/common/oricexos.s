; OricExos ----------------

#include <defasm.h>
#include <oricexos.h>

;==========================
; oricexos inter process
; common area (ipc)
_ipc      =   ipc_ptr

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

extstat   =   ipc_exos

;--------------------------
#define f_ram_off   %11111110
#define f_ram_on    %00000001

#define f_pp_off    %11111101
#define f_pp_on     %00000010

#define f_pp_out    %11111011
#define f_pp_in     %00000100

#define f_mix_a     %11110111
#define f_mix_b     %00001000

;==========================
_sei
        sei
        rts
;--------------------------
_cli
        cli
        rts

;--------------------------
irqflag byt   0
;--------------------------
_phi
        php
        pla
        and   #%00000100
        sta   irqflag
        sei
        rts
;--------------------------
_pli
        php
        pla
        ora   irqflag
        pha
        plp
        rts

;==========================
_reset_exos
        lda   #0
        sta   extstat
        sta   extadr
        rts

;==========================
_set_ram_on
_set_rom_off
        pha
        txa
        pha
        lda   extstat
        ora   #f_ram_on
        ; forced branch
        bne   br_rm
;--------------------------
_set_rom_on
_set_ram_off
        pha
        txa
        pha
        lda   extstat
        and   #f_ram_off
br_rm
        sta   extstat        
        tax   
        sta   extadr,x
        pla
        tax
        pla
        rts


;==========================
_set_pp_on
        pha
        txa
        pha
        lda   extstat
        ora   #f_pp_on
        ; forced branch
        bne   br_ppoff
;--------------------------
_set_pp_off
        pha
        txa
        pha
        lda   extstat
        and   #f_pp_off
br_ppoff
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts

;==========================
_set_pp_in
        pha
        txa
        pha
        lda   extstat
        ora   #f_pp_in
        ; forced branch
        bne br_ppout
;--------------------------
_set_pp_out
        pha
        txa
        pha
        lda   extstat
        and   #f_pp_out
br_ppout
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts

;==========================
_set_mix_a
        pha
        txa
        pha
        lda   extstat
        ora   #f_mix_a
        ; forced branch
        bne   br_mix
;--------------------------
_set_mix_b
        pha
        txa
        pha
        lda   extstat
        and   #f_mix_b
br_mix
        sta   extstat        
        tax
        sta   extadr,x
        pla
        tax
        pla
        rts

;==========================
; tape relay off = vsync on
_set_vsync_on
        pha
        lda   via_b
        and   #%10111111
        sta   via_b
        pla
        rts
;--------------------------
; tape relay on = vsync off
_set_vsync_off
        pha
        lda   via_b
        ora   #%01000000
        sta   via_b
        pla
        rts
