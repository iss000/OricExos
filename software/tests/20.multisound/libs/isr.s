; ---------------------------------------------------------------------------
#include <compat.h>
#include <isr.h>
#include <via.h>
; ---------------------------------------------------------------------------
#define def_period  50000
; ---------------------------------------------------------------------------
.text
; ---------------------------------------------------------------------------
_isr_period .byt  <(def_period-2), >(def_period-2)
_isr_timer  .byt  $ff,$ff,$ff,$ff,$99,$09
_isr_flag   .byt  0

; ---------------------------------------------------------------------------
_isr_timer_str
            .byt  <timerstr
            .byt  >timerstr
timerstr    .byt  "0000000000."
timerfrac   .byt  "000",0

; ---------------------------------------------------------------------------
save_nmi    .word 0
save_irq    .word 0

save_v_t1   .byt  0
save_v_acr  .byt  0
save_v_pcr  .byt  0
save_v_ier  .byt  0

save_a      .byt  0
save_x      .byt  0
save_y      .byt  0

; ---------------------------------------------------------------------------
timerflag   .byt  0

timerms     .byt  0,0
timerms_us  .byt  0,0

timerend    .byt  0,0
timerend_us .byt  0,0

ticks       .byt  0,0,0,0
ticks_us    .byt  0,0

; ---------------------------------------------------------------------------
d1k_dividend  = utmp2
d1k_remainder = utmp4
d1k_result    = d1k_dividend

; ---------------------------------------------------------------------------
irq_handler
.(
            php
            sta   save_a
            stx   save_x
            sty   save_y
            cld

            lda   via_ifr
            sta   _isr_flag

#ifdef USE_VSYNC
            jsr _vsync_handler
#endif
            lda   _isr_flag
            and   #via_irq_t1
            beq   skip
            ; Clear T1 IRQ event
            bit   via_t1cl

            sed
            clc
            lda   timerms_us
            adc   ticks_us
            sta   ticks_us

            lda   timerms_us+1
            adc   ticks_us+1
            cmp   #$10
            and   #$0f
            sta   ticks_us+1
            cld

            lda   #0
            adc   #0
            adc   timerms
            adc   ticks
            sta   ticks
            lda   timerms+1
            adc   ticks+1
            sta   ticks+1
            lda   #$00
            adc   ticks+2
            sta   ticks+2
            lda   #$00
            adc   ticks+3
            sta   ticks+3

            lda   #$01
            sta   timerflag

skip
            ldy   save_y
            ldx   save_x
            lda   save_a
            plp
            rti
.)

; ---------------------------------------------------------------------------
nmi_handler
            rti

; ---------------------------------------------------------------------------
_isr_open
.(
            sei
            lda   via_t1ll
            sta   save_v_t1
            lda   via_t1lh
            sta   save_v_t1+1

            lda   via_acr
            sta   save_v_acr

            lda   via_pcr
            sta   save_v_pcr

            lda   via_ier
            and   #$7f
            sta   save_v_ier

            ; Disable all VIA interrupts
            lda   #%01111111
            sta   via_ier

            lda   via_acr

            ; Disable PORT A latching
            and   #%11111110
            ; Disable PORT B latching
            and   #%11111101
            ; Disable SR
            and   #%11100011

            ; T2 mode - ACR bit 5 = 0
            and   #%11011111
            ora   #%00000000

            ; T1 mode - ACR bit 7,6 = 0,1
            and   #%00111111
            ora   #%01000000

            sta   via_acr

            lda   #%11111111
            ; PORT A all output
            sta   via_ddra
            lda   #%11111111
            sta   via_a
            sta   via_aor
            lda   #%11110111
            ; PORT B all output except bit 3
            sta   via_ddrb
            lda   #%10110111
            ; turn off cassette motor.
            sta via_b

            jsr   _isr_clear_pending
            jsr   _isr_calc_period
            jsr   _isr_timer_set

            ; enable T1 interrupt
            lda   #%10000000
            ora   #via_irq_t1
            sta   via_ier

#ifdef USE_NO_ROM
            lda   nmi_addrlo
            sta   save_nmi
            lda   nmi_addrhi
            sta   save_nmi+1

            lda   #<nmi_handler
            sta   nmi_addrlo
            lda   #>nmi_handler
            sta   nmi_addrhi

            lda   irq_addrlo
            sta   save_irq
            lda   irq_addrhi
            sta   save_irq+1

            lda   #<irq_handler
            sta   irq_addrlo
            lda   #>irq_handler
            sta   irq_addrhi
#else
            lda   $fffe
            cmp   #<$244
            bne   is_oric1
            ; Atmos default vectors
            lda   nmi_addrlo_atmos
            sta   save_nmi
            lda   nmi_addrhi_atmos
            sta   save_nmi+1

            lda   #<nmi_handler
            sta   nmi_addrlo_atmos
            lda   #>nmi_handler
            sta   nmi_addrhi_atmos

            lda   irq_addrlo_atmos
            sta   save_irq
            lda   irq_addrhi_atmos
            sta   save_irq+1

            lda   #<irq_handler
            sta   irq_addrlo_atmos
            lda   #>irq_handler
            sta   irq_addrhi_atmos
            clc
            bcc   is_atmos

is_oric1    ; Oric-1 default vectors
            lda   nmi_addrlo_oric1
            sta   save_nmi
            lda   nmi_addrhi_oric1
            sta   save_nmi+1

            lda   #<nmi_handler
            sta   nmi_addrlo_oric1
            lda   #>nmi_handler
            sta   nmi_addrhi_oric1

            lda   irq_addrlo_oric1
            sta   save_irq
            lda   irq_addrhi_oric1
            sta   save_irq+1

            lda   #<irq_handler
            sta   irq_addrlo_oric1
            lda   #>irq_handler
            sta   irq_addrhi_oric1
#endif
is_atmos
            cli
            rts
.)

; ---------------------------------------------------------------------------
_isr_close
.(
            sei
            ; Disable all VIA interrupts
            lda   #%01111111
            sta   via_ier

            jsr   _isr_clear_pending

            lda   save_v_t1
            sta   via_t1cl
            lda   save_v_t1+1
            sta   via_t1ch

            lda   save_v_acr
            sta   via_acr

            lda   save_v_pcr
            sta   via_pcr

            lda   save_v_ier
            ora   #$80
            sta   via_ier

            lda   save_v_ier
            eor   #$7f
            sta   via_ier

#ifdef USE_NO_ROM
            lda   save_nmi
            sta   nmi_addrlo
            lda   save_nmi+1
            sta   nmi_addrhi

            lda   save_irq
            sta   irq_addrlo
            lda   save_irq+1
            sta   irq_addrhi
#else
            lda   $fffe
            cmp   #<$244
            bne   is_oric1
            ; Atmos default vectors
            lda   save_nmi
            sta   nmi_addrlo_atmos
            lda   save_nmi+1
            sta   nmi_addrhi_atmos

            lda   save_irq
            sta   irq_addrlo_atmos
            lda   save_irq+1
            sta   irq_addrhi_atmos
            clc
            bcc   is_atmos
is_oric1
            ; Oric-1 default vectors
            lda   save_nmi
            sta   nmi_addrlo_oric1
            lda   save_nmi+1
            sta   nmi_addrhi_oric1

            lda   save_irq
            sta   irq_addrlo_oric1
            lda   save_irq+1
            sta   irq_addrhi_oric1
is_atmos
#endif
            cli
            rts
.)

; ---------------------------------------------------------------------------
_isr_calc_period
.(
            ; get timer period and div by 1000
            clc
            lda   #2
            adc   _isr_period
            sta   d1k_dividend
            lda   #0
            adc   _isr_period+1
            sta   d1k_dividend+1
            lda   #<1000
            ldx   #>1000
            jsr   div1xxx

            lda   d1k_result
            sta   timerms
            lda   d1k_result+1
            sta   timerms+1

            ; store reminder in BCD
            ; -- hundreds
            lda   d1k_remainder
            sta   d1k_dividend
            lda   d1k_remainder+1
            sta   d1k_dividend+1
            lda   #<100
            ldx   #>100
            jsr   div1xxx

            lda   d1k_result
            sta   timerms_us+1

            ; -- tens
            lda   d1k_remainder
            sta   d1k_dividend
            lda   d1k_remainder+1
            sta   d1k_dividend+1
            lda   #<10
            ldx   #>10
            jsr   div1xxx

            lda   d1k_result
            clc
            asl
            asl
            asl
            asl
            ; -- ones
            ora   d1k_remainder
            sta   timerms_us

            rts
.)

; ---------------------------------------------------------------------------
_isr_clear_pending
            lda   #$00
            ; Clear all pending interrupts
            bit   via_sr
            bit   via_t2ll
            bit   via_t1ll
            bit   via_a
            bit   via_b
            sta   via_ifr
            rts

; ---------------------------------------------------------------------------
_sei_
            sei
            rts

; ---------------------------------------------------------------------------
_cli_
            cli
            rts

; ---------------------------------------------------------------------------
_isr_timeout
.(
            lda   timerflag
            beq   zero
            lda   #$00
            sta   timerflag
            return(1)
zero
            return(0)
.)

; ---------------------------------------------------------------------------
_isr_timer_set
.(
            php
            sei

            lda   #$00
            sta   ticks_us
            sta   ticks_us+1
            sta   ticks
            sta   ticks+1
            sta   ticks+2
            sta   ticks+3

            sta   _isr_timer
            sta   _isr_timer+1
            sta   _isr_timer+2
            sta   _isr_timer+3
            sta   _isr_timer+4
            sta   _isr_timer+5

            lda   _isr_period
            sta   via_t1cl
            lda   _isr_period+1
            sta   via_t1ch

            plp
            rts
.)

; ---------------------------------------------------------------------------
_isr_timer_get
.(
            php
            sei

            ; get current T1 pos
again
            lda   via_t1ch
            ldx   via_t1cl
            cmp   via_t1ch
            bne   again

            stx   d1k_dividend
            sta   d1k_dividend+1

            ; substract it from period
            ; and div by 1000
            sec
            lda   _isr_period
            sbc   d1k_dividend
            sta   d1k_dividend
            lda   _isr_period+1
            sbc   d1k_dividend+1
            sta   d1k_dividend+1
            lda   #<1000
            ldx   #>1000
            jsr   div1xxx

            lda   d1k_result
            sta   timerend
            lda   d1k_result+1
            sta   timerend+1

            ; store reminder in BCD
            ; -- hundreds
            lda   d1k_remainder
            sta   d1k_dividend
            lda   d1k_remainder+1
            sta   d1k_dividend+1
            lda   #<100
            ldx   #>100
            jsr   div1xxx

            lda   d1k_result
            sta   timerend_us+1

            ; -- tens
            lda   d1k_remainder
            sta   d1k_dividend
            lda   d1k_remainder+1
            sta   d1k_dividend+1

            ; -- ones
            lda   #<10
            ldx   #>10
            jsr   div1xxx

            lda   d1k_result
            asl
            asl
            asl
            asl
            ora   d1k_remainder
            sta   timerend_us

            ; timerend = timerend + ticks
            sed
            clc
            lda   ticks_us
            adc   timerend_us
            sta   timerend_us
            sta   _isr_timer+4
            lda   ticks_us+1
            adc   timerend_us+1
            cmp   #$10
            and   #$0f
            sta   timerend_us+1
            sta   _isr_timer+5
            ; keep carry flag
            cld

            lda   ticks
            adc   timerend
            sta   _isr_timer
            lda   ticks+1
            adc   timerend+1
            sta   _isr_timer+1
            lda   ticks+2
            adc   #0
            sta   _isr_timer+2
            lda   ticks+3
            adc   #0
            sta   _isr_timer+3

            plp
            rts
.)

; ---------------------------------------------------------------------------
; used for division by 10,100,1000
; input X:A = divisor
; ---------------------------------------------------------------------------
div1xxx
.(
            sta   div1xxx_lo    ; setup the divisor
            stx   div1xxx_hi

            lda #0              ; preset remainder to 0
            sta d1k_remainder
            sta d1k_remainder+1

            ldx #16             ; repeat for each bit: ...
divloop
            asl d1k_dividend    ; dividend lb & hb*2, msb -> Carry
            rol d1k_dividend+1
            rol d1k_remainder   ; remainder lb & hb * 2 + msb from carry
            rol d1k_remainder+1
            lda d1k_remainder
            sec
div1xxx_lo  = 1+*
            sbc #$aa            ; substract divisor to see if it fits in
            tay                 ; lb result -> Y, for we may need it later
            lda d1k_remainder+1
div1xxx_hi  = 1+*
            sbc #$aa
            bcc skip            ; if carry=0 then divisor didn`t fit in yet

            sta d1k_remainder+1 ; else save substraction result as new remainder,
            sty d1k_remainder
            inc d1k_dividend    ; and INCrement result cause divisor fit in 1 times
skip
            dex
            bne divloop
            rts
.)

#ifdef USE_TIMER_STRINGS
; ---------------------------------------------------------------------------
_isr_timer_get_str
.(
#ifdef USE_TIMER_STRINGS_ZEROS
            lda   #"0"
#else
            lda   #" "
#endif
            ldx   #10
loop
            dex
            sta   timerstr,x
            bne   loop

            lda   #"D"           ;radix character
            ldx   #<_isr_timer   ;binary value address lsb
            ldy   #>_isr_timer   ;binary value address msb
            jsr   _binstr        ;perform conversion

            stx   loop2_src
            sty   loop2_src+1
            sta   utmp2
            ldx   #9
            tay
            dey
loop2
loop2_src   =     1+*
            lda   $1234,y
            sta   timerstr,x
            dex
            dey
            dec   utmp2
            bne   loop2

            clc
            lda	  _isr_timer+5
            ora   #"0"
            sta   timerfrac
            lda   _isr_timer+4
            lsr
            lsr
            lsr
            lsr
            ora   #"0"
            sta   timerfrac+1
            lda    _isr_timer+4
            and   #$0f
            ora   #"0"
            sta   timerfrac+2
            rts
.)
#endif USE_TIMER_STRINGS
