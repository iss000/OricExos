;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = PLAYER_ADDRESS

;--------------------------
_start
        lda   ipc_id
        asl
        tay
        lda   jmptab,y
        pha
        lda   jmptab+1,y
        pha
        rts

jmptab  byt   >(player),<(player)
        byt   >(player),<(player)
        byt   >(player),<(player)
        byt   >(player),<(player)
       
_stop
        jmp   *
        
;--------------------------
player
        jmp   _stop

;--------------------------
#include "scrn_tab.s"

_sedoric		; invoke a SEDORIC command using black magic
			; Watch it! I have reasons to believe this is broken
        ldy #$0         ; grab string pointer
        lda (sp),y
        sta tmp
        iny
        lda (sp),y
        sta tmp+1
        dey

sedoricloop1            ; copy the string to #35..#84
        lda (tmp),y
        sta $35,y
        iny
        ora #$0
        bne sedoricloop1

        sta $ea         ; update the line start pointer
        lda #$35;
        sta $e9

        jsr $00e2       ; get next token
        jmp ($02f5)     ; call the ! command handler

