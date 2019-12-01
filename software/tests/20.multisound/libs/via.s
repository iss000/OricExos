; ---------------------------------------------------------------------------
#include <via.h>
; ---------------------------------------------------------------------------
.text
; ---------------------------------------------------------------------------
_via              =     $300

; ---------------------------------------------------------------------------
_via_cb1_edge .byt  %00010000

#if defined ( USE_CB1_INTERRUPT ) || defined ( USE_VSYNC_HARD )

_via_cb1_set_rise
                  ; CB1 interrupt by 0->1 edge
                  lda   #%00010000
                  sta   _via_cb1_edge
                  lda   #via_cb1_rise
                  ora   via_pcr
                  sta   via_pcr
                  rts

_via_cb1_set_fall
                  ; CB1 interrupt by 1->0 edge
                  lda   #%00000000
                  sta   _via_cb1_edge
                  lda   #via_cb1_fall
                  and   via_pcr
                  sta   via_pcr
                  rts

#endif
