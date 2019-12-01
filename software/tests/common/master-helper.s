#define _dosrom $04f2

.text
*           =   $0f00
_sed_begin  = *
_sed_end    = _sed_begin+2

            sei
            jsr _dosrom
            lda $c052
            sta _sed_begin ; Start Address Lo
            lda $c053
            sta _sed_begin+1 ; Start Address Hi

            clc
            lda $c04f
            adc _sed_begin
            sta _sed_end ; End Address Lo
            lda $c050
            adc _sed_begin+1
            sta _sed_end+1 ; End Address Lo

            jsr _dosrom ; disable OverlayRAM
            cli ; re-enable interrupts
            rts

