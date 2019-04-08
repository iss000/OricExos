;--------------------------
#include <defasm.h>
#include <oricexos.h>
;--------------------------
.text

;--------------------------
*       = SPLAYER_ADDRESS

;--------------------------
_start
        lda   #<19966
        sta   via_t1ll
        lda   #>19966
        sta   via_t1lh
        cli

        jmp   _player
        
;         lda   ipc_id
;         asl
;         tay
;         lda   jmptab,y
;         pha
;         lda   jmptab+1,y
;         pha
;         rts
; 
; jmptab  byt   >(_player-1),<(_player-1)
;         byt   >(_player-1),<(_player-1)
;         byt   >(_player-1),<(_player-1)
;         byt   >(_player-1),<(_player-1)
;        
; ;--------------------------
_stop
        jmp   *
        
;--------------------------
_player
        jsr   blit
        ldx   frame
        inx
        cpx   #frames
        bne   flp_1
        ldx   #$00
flp_1
        stx   frame
        jmp   _player
        
;--------------------------
framew  =     (150/6)
frameh  =     (120)
frames  =     (11)

_tab_frames_lo = MOVIE_ADDRESS+(framew*frameh*frames)
_tab_frames_hi = _tab_frames_lo+frames 

frame   byt   0
        
blit
        ldy   frame
        lda   _tab_frames_lo,y
        sta   __auto_src+1
        lda   _tab_frames_hi,y
        sta   __auto_src+2

        ldy   #0
blp_y
        lda   _scrn_lo-1,y
        sta   __auto_dst+1
        lda   _scrn_hi-1,y
        sta   __auto_dst+2
        ldx   #0
blp_x
;
__auto_src
        lda   $f00d,x
;
__auto_dst
        sta   $f00d,x

        inx
        cpx   #framew
        bne   blp_x
        
        txa
        clc
        adc   __auto_src+1
        sta   __auto_src+1
        lda   #$00
        adc   __auto_src+2
        sta   __auto_src+2
        
        iny
        cpy   #frameh
        bne   blp_y

        rts

;--------------------------
#include "scrn_tab.s"
