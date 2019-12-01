#include <via.h>
#include <psg.h>

/*
 * The AY-3-8912 is not memory mapped in the Oric and
 * the method of accessing it is obscure (to say the least).
 * However, with a little knowledge, it is easy enough to
 * write and read from any register.
 *
 * The AY-3-8912 is linked to the system by the way of
 * one data/register port and 2 control lines.
 * The control lines are known as CA2 and CB2 since they
 * are held within the VIA 6522 and may be set/reset in
 * Memory location $030C.
 *
 * The Data/Register Port is also used by the Printer Port
 * (Which may also be attached to a joystick interface)
 * and appears at location $030F.
 *
 * The control line Register (Also known as the PCR)
 * actually controls the behaviour of CA1,CA2,CB1,CB2,
 * but for the most part, we can get away with 3 values
 * directly poked into this location.
 *
 * The three values are...
 * $DD == $030F is inactive
 * $FD == $030F holds data for a preset Register
 * $FF == $030F holds a Register number
 *
 * The AY-3-8912 has 15 Registers numbered $00 to $0E.
 *
 * 00 Bits 0 to 7(0-255)   - Pitch Register LSB Channel A
 * 01 Bits 0 to 3(0-15)    - Pitch Register MSB Channel A
 * 02 Bits 0 to 7(0-255)   - Pitch Register LSB Channel B
 * 03 Bits 0 to 3(0-15)    - Pitch Register MSB Channel B
 * 04 Bits 0 to 7(0-255)   - Pitch Register LSB Channel C
 * 05 Bits 0 to 3(0-15)    - Pitch Register MSB Channel C
 * 06 Bits 0 to 4(0-31)    - Noise Pulsewidth
 * 07 Bit 0(0-1)           - Link Pitch A to Output DAC A
 * 07 Bit 1(0-1)           - Link Pitch B to Output DAC B
 * 07 Bit 2(0-1)           - Link Pitch C to Output DAC C
 * 07 Bit 3(0-1)           - Link Noise to Output DAC A
 * 07 Bit 4(0-1)           - Link Noise to Output DAC B
 * 07 Bit 5(0-1)           - Link Noise to Output DAC C
 * 08 Bits 0-3(0-15)       - DAC Amplitude(Volume) A
 * 08 Bit 4                - Envelope Generator controls Amplitude of A
 * 09 Bits 0-3(0-15)       - DAC Amplitude(Volume) B
 * 09 Bit 4                - Envelope Generator controls Amplitude of B
 * 0A Bits 0-3(0-15)       - DAC Amplitude(Volume) C
 * 0A Bit 4                - Envelope Generator controls Amplitude of C
 * 0B Bits 0 to 7(0-255)   - Envelope Generator Period Counter LSB
 * 0C Bits 0 to 7(0-255)   - Envelope Generator Period Counter MSB
 * 0D Bits 0 to 3(0-15)    - Envelope Generator Cycle Register
*/

/*
 * VIA CA2 is connected to AY BC1
 * VIA CB2 is connected to AY /BDIR
*/


; ---------------------------------------------------------------------------
.text

; ---------------------------------------------------------------------------
_psg
_psg_reg    =     *+1
            lda   #$00
_psg_val    =     *+1
            ldx   #$00

; ---------------------------------------------------------------------------
; write X to register A
_psg_write_X_to_A
            sta   via_aor         ; Send A to port A of 6522.
            tay
            txa
            cpy   #$07            ; If writing to register 7, set
            bne   4+*             ; 1/0 port to output.
            ora   #$40
            pha
            lda   via_pcr         ; Set CA2 (BC1 of 8912) to 1,
            ora   #$ee            ; set CB2 (BDIR of 8912) to 1.
            sta   via_pcr         ; 8912 latches the address.
            and   #$11            ; Set CA2 and CB2 to 0, BC1 and
            ora   #$cc            ; BDIR in inactive state.
            sta   via_pcr         ;
            tax
            pla
            sta   via_aor         ; Send data to 8912 register.
            txa
            ora   #$ec            ; Set CA2 to 0 and CB2 to 1,
            sta   via_pcr         ; 8912 latches data.
            and   #$11            ; Set CA2 and CB2 to 0, BC1 and
            ora   #$cc            ; BDIR in inactive state.
            sta   via_pcr         ;
            rts

; ---------------------------------------------------------------------------
_psg_write_0_to_Y
            ldx   #0

; ---------------------------------------------------------------------------
_psg_write_X_to_Y
            sty   via_aor             ; Send Y to port A of 6522.
            txa
            cpy   #$07                ; If writing to register 7, set
            bne   4+*                 ; 1/0 port to output.
            ora   #$40
            pha
            lda   via_pcr             ; Set CA2 (BC1 of 8912) to 1,
            ora   #$ee                ; set CB2 (BDIR of 8912) to 1.
            sta   via_pcr             ; 8912 latches the address.
            and   #$11                ; Set CA2 and CB2 to 0, BC1 and
            ora   #$cc                ; BDIR in inactive state.
            sta   via_pcr
            tax
            pla
            sta   via_aor               ; Send data to 8912 register.
            txa
            ora   #$ec                ; Set CA2 to 0 and CB2 to 1,
            sta   via_pcr             ; 8912 latches data.
            and   #$11                ; Set CA2 and CB2 to 0, BC1 and
            ora   #$cc                ; BDIR in inactive state.
            sta   via_pcr
            rts

; ---------------------------------------------------------------------------
_psg_stop
            ; Stop the sound
            lda   #8
            ldx   #0
            jsr   _psg_write_X_to_A

            lda   #9
            ldx   #0
            jsr   _psg_write_X_to_A

            lda   #10
            ldx   #0
            jsr   _psg_write_X_to_A

            rts

