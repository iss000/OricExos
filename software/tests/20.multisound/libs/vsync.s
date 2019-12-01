; ---------------------------------------------------------------------------
#include <compat.h>
#include <isr.h>
#include <via.h>
#include <vsync.h>
; ---------------------------------------------------------------------------
.text
; ---------------------------------------------------------------------------
#ifdef USE_VSYNC_HARD
#undef USE_VSYNC_SOFT
#define vsync_type    2
#endif

#ifdef USE_VSYNC_SOFT
#undef USE_VSYNC_HARD
#define vsync_type    1
#endif

#ifndef vsync_type
#define vsync_type    0
#endif

; ---------------------------------------------------------------------------
_vsync_type .byt  vsync_type

; ---------------------------------------------------------------------------
#ifdef USE_VSYNC_50HZ
_vsync_freq .byt  50
#else
_vsync_freq .byt  60
#endif

; ---------------------------------------------------------------------------
_vsync_id   .word 0

; ---------------------------------------------------------------------------
#define vsync_mask    via_irq_cb1

; ---------------------------------------------------------------------------
_vsync_check
.(
            php
            sei
            lda   #$00
            sta   _vsync_id+1
            sta   _vsync_id
            inc   _vsync_id
            lda   via_b
            lda   #vsync_mask
vc_loop
            bit   via_ifr
            bne   vc_ret
            inc   _vsync_id
            bne   vc_loop
            inc   _vsync_id+1
            bne   vc_loop
vc_ret
            plp
            rts
.)
; ---------------------------------------------------------------------------
_vsync_wait
.(
            php
            sei
            lda   via_b
            lda   #vsync_mask
vw_loop
            bit   via_ifr
            beq   vw_loop
            plp
            rts
.)

; ---------------------------------------------------------------------------
vsync_set   .byt  0
; ---------------------------------------------------------------------------
_vsync_on
            lda #$01
            sta vsync_set
            rts
; ---------------------------------------------------------------------------
_vsync_off
            lda #$00
            sta vsync_set
            rts

; ---------------------------------------------------------------------------
_vsync_handler
            lda   _isr_flag

#ifdef USE_VSYNC_HARD
            and   #via_irq_cb1
            beq   _vsync_handler_ret
            lda   via_b
#endif

#ifdef USE_VSYNC_SOFT
            and   #via_irq_t1
            beq   _vsync_handler_ret
#endif
            lda   vsync_set
            beq   _vsync_handler_ret

_vsync_flipper    = 1+*
            jmp   *+3

_vsync_handler_ret
            rts

; ---------------------------------------------------------------------------
_vsync_open
.(
            php
            sei

            jsr   _vsync_check
            lda   _vsync_id
            ora   _vsync_id+1
            beq   vo_wait
            jsr   _vsync_wait
vo_wait

#ifdef USE_VSYNC_HARD
#ifdef USE_VSYNC_NEGEDGE
            jsr   _via_cb1_set_fall
#else
            jsr   _via_cb1_set_rise
#endif
#endif


#ifdef USE_VSYNC_SOFT
            ; T1 period
#ifdef USE_VSYNC_50HZ
            lda   #<_50HZ_T1
            ldx   #>_50HZ_T1
#else
            lda   #<_60HZ_T1
            ldx   #>_60HZ_T1
#endif
            sta   _isr_period
            stx   _isr_period+1
            jsr   _isr_clear_pending
            jsr   _isr_calc_period
            jsr   _isr_timer_set
#endif

            lda   via_ier

#ifdef USE_VSYNC_SOFT
            ora   #via_irq_t1
#endif

#ifdef USE_VSYNC_HARD
            ora   #via_irq_cb1
#endif
            sta   via_ier

            plp
            rts
.)

; ---------------------------------------------------------------------------
_vsync_close
            php
            sei
            jsr   _vsync_off
            plp
            rts

; ---------------------------------------------------------------------------
