#include <defasm.h>
#include <oricexos.h>
#include <pp.h>

;--------------------------
.text

;--------------------------
*       = PPLINK_ADDRESS
_entry
        jmp   first_start
;--------------------------
pp_link     = *
pp_link_cmd = pp_link+1
pp_link_flg = pp_link+2
pp_link_dst = pp_link+3
pp_link_siz = pp_link+5

;--------------------------
; this space is reused
first_start
        lda   #<_start
        sta   _entry+1
        lda   #>_start
        sta   _entry+2

        ; clear status line
        lda   #$20
        ldx   #39
lp_1
        sta   $bb80,x
        dex
        bpl   lp_1
        
        lda   #$10
        sta   b_paper
        lda   #$07
        sta   b_ink
        jsr   r_cls
        
        lda   id_addr
        and   #$03
        sta   ipc_id
        
        ; setup indicator
        clc
        adc   #<($bfdf-4)
        sta   __auto_indptr+1
        lda   #0
        adc   #>($bfdf-4)
        sta   __auto_indptr+2
        
;--------------------------
; fall trough here
;--------------------------
_start
        jsr   show_indicator
        
        lda   ipc_id
        sta   pp_link_flg
        lda   #<pp_link_cmd
        sta   __pp_cmd_ptr
        lda   #>pp_link_cmd
        sta   __pp_cmd_ptr+1
        
        jsr   __pp_receive

        lda   pp_link_flg
        beq   _start
                
        jsr   hide_indicator
        
        lda   #>(_start-1)
        pha
        lda   #<(_start-1)
        pha
        
        jmp   (pp_link_dst)

show_indicator
        lda   id_addr
        ora   #$80
hide_indicator  
        ; bit op-code
        byt   $2c
        lda   #$20
__auto_indptr
        sta   $1234
        rts
