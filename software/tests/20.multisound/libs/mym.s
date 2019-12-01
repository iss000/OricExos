; ---------------------------------------------------------------------------
#include <compat.h>

#define mym_frame_bits          7
#define mym_frame_size          (1<<mym_frame_bits)
#define mym_frame_mask          (mym_frame_size-1)

; ---------------------------------------------------------------------------
        .zero
        *=$90

_ptr_register_buffer            .dsb 2          ; Points to the low byte of the decoded register buffer


; ---------------------------------------------------------------------------
        .text

mym_player_data_begin
; ---------------------------------------------------------------------------
_DecodedByte                    .dsb 1          ; Byte being currently decoded from the MYM stream
_DecodeBitCounter               .dsb 1          ; Number of bits we can read in the current byte
_DecodedResult                  .dsb 1          ; What is returned by the `read bits` function
_CurrentAYRegister              .dsb 1          ; Contains the number of the register being decoded
_MusicResetCounter              .dsb 2          ; Contains the number of rows to play before reseting
_CurrentFrame                   .dsb 1          ; From 0 to 255 and then cycles... the index of the frame to play this vbl
_PlayerVbl                      .dsb 1          ; Swapped between 0 and 128 to address the start of the register buffer for this frame
_FrameLoadBalancer              .dsb 1          ; We depack a new frame every 9 VBLs, this way the 14 registers are evenly depacked over 128 frames
_PlayerRegCurrentValue          .dsb 1          ; For depacking of data
mym_reg_values                  .dsb 14         ; 14 values, each containing the value of one of the PSG registers
; ---------------------------------------------------------------------------
mym_player_data_end

mym_keep_y
          .byt 0

mym_temp
          .dsb 1

_mym_playing
          .byt 0

_mym_frame_counter
          .byt 0,0

_mym_stop
          sty mym_keep_y
          lda #0
          sta _mym_playing
          ; Stop the sound
          jsr _psg_stop
          ldy mym_keep_y
          rts

_mym_start
          lda #1
          sta _mym_playing
          rts

_mym_setup
          sty mym_keep_y
          jsr mym_rewind
          ldy mym_keep_y
          rts

mym_rewind
.(
          lda #0
          sta _mym_frame_counter
          sta _mym_frame_counter+1

          ; Initialize the read bit counter
          lda #<(_MusicData+2)
          sta __auto_music_ptr+1
          lda #>(_MusicData+2)
          sta __auto_music_ptr+2

          ; Unpack the 128 first register frames
          lda #>_PlayerBuffer
          sta _ptr_register_buffer+1
          lda #0
          sta _ptr_register_buffer

          ; Clear all data
          ldx #(mym_player_data_end-mym_player_data_begin)
loop_clear
          sta mym_player_data_begin-1,x
          dex
          bne loop_clear

          ; The two first bytes of the MYM music is the number of rows in the music
          ; We decrement that at each frame, and when we reach zero, time to start again.
          ldx _MusicData+0
          stx _MusicResetCounter+0
          ldx _MusicData+1
          inx
          stx _MusicResetCounter+1

          ldx #0
unp_loop
          jsr _PlayerUnpackRegister                       ; Unpack that register (x register as input, returns x+1)
          cpx #14
          bne unp_loop

          jmp NextFrameBlock
;         rts
.)

_mym_play_frame
.(
          lda _mym_playing
          beq frame_end

          inc _mym_frame_counter
          bne skip0
          inc _mym_frame_counter+1
skip0

          ; Check for end of music
          dec _MusicResetCounter+0
          bne skip1
          dec _MusicResetCounter+1
          bne skip1
          ; reset the music
          jsr _psg_stop
          jsr mym_rewind
skip1

          ; Play a frame of 14 registers, starting by the last one
          lda _CurrentFrame
          sta __auto_psg_play_read+1
          lda #>(_PlayerBuffer+13*256)
          sta __auto_psg_play_read+2

          ldy #13
reg_loop

__auto_psg_play_read = *
          ldx _PlayerBuffer                   ;
          jsr _psg_write_X_to_Y

          dec __auto_psg_play_read+2
          dey
          bpl reg_loop

          inc _CurrentFrame

          ; Depack one new frame ?
          ldx _CurrentAYRegister
          cpx #14
          bcs reg_end

          dec _FrameLoadBalancer
          bne frame_end

          jsr _PlayerUnpackRegister                       ; Unpack that register (x register as input, returns x+1)
          jsr ResetLoadBalancer
          bne frame_end
reg_end

          ; Reached a multiple of 128 frames?
          lda _CurrentFrame
          and #(mym_frame_mask)                          ; Probably possible to use BIT to check for more stuff at once
          bne frame_end
          jsr NextFrameBlock

frame_end
          rts
.)

_mym_seek_frame
.(
          sty mym_keep_y

          inc _mym_frame_counter
          bne skip0
          inc _mym_frame_counter+1
skip0

          ; Check for end of music
          dec _MusicResetCounter+0
          bne skip1
          dec _MusicResetCounter+1
          bne skip1
          ; reset the music
          jsr mym_rewind
skip1

          inc _CurrentFrame

          ; Depack one new frame ?
          ldx _CurrentAYRegister
          cpx #14
          bcs reg_end

          dec _FrameLoadBalancer
          bne frame_end

          jsr _PlayerUnpackRegister                       ; Unpack that register (x register as input, returns x+1)
          jsr ResetLoadBalancer
          bne frame_end
reg_end

          ; Reached a multiple of 128 frames?
          lda _CurrentFrame
          and #(mym_frame_mask)                          ; Probably possible to use BIT to check for more stuff at once
          bne frame_end
          jsr NextFrameBlock

frame_end
          ldy mym_keep_y
          rts
.)



NextFrameBlock
          lda #0
          sta _CurrentAYRegister

          lda #>_PlayerBuffer
          sta _ptr_register_buffer+1

          lda _PlayerVbl+0
          eor #(mym_frame_size)
          sta _PlayerVbl+0

ResetLoadBalancer
          lda #(mym_frame_size/14)
          sta _FrameLoadBalancer
          rts


; Initialise X with the number of bits to read
; Y is not modified
; A contains the value on exit
_ReadOneBit
          lda #1
_ReadBits
          tax
          lda #0
          sta _DecodedResult

          ; Will iterate X times (number of bits to read)
bits_loop
          dec _DecodeBitCounter
          bpl reload_end

          ; reset mask
          lda #(mym_frame_bits)
          sta _DecodeBitCounter

          ; fetch a new byte, and increment the adress.
__auto_music_ptr = *
          lda _MusicData+2
          sta _DecodedByte

          inc __auto_music_ptr+1
          bne reload_end
          inc __auto_music_ptr+2
reload_end

          asl _DecodedByte
          rol _DecodedResult

          dex
          bne bits_loop

          lda _DecodedResult
          rts


; X=Register to unpack
_PlayerUnpackRegister
          stx _CurrentAYRegister

          ; Init register bit count and current value
          lda mym_reg_values,x
          sta _PlayerRegCurrentValue

          ; Either 0 or 128 at this point else we have a problem...
          ldy _PlayerVbl

          ; Check if it`s packed or not and call adequate routine...
          jsr _ReadOneBit
          bne loop_depack_fragment

          ; No change at all, just repeat _PlayerRegCurrentValue 128 times
UnchangedFragment
          lda _PlayerRegCurrentValue
          ldx #(mym_frame_size)

loop_repeat_register
          sta (_ptr_register_buffer),y
          iny
          dex
          bne loop_repeat_register
          beq done_depacking

          ; Main fragment depacking loop
loop_depack_fragment
          jsr _ReadOneBit                      ; Check packing method
          beq RepeatLastRegisterValue
          jsr _ReadOneBit                      ; Check packing method
          bne skip_depack_fragment
          jmp DecompressWithOffset
skip_depack_fragment

          ; New register value copied to the register stream
ReadNewRegisterValue
          ldx _CurrentAYRegister               ; Read new register value (variable bit count)
          lda _PlayerRegBits,x
          jsr _ReadBits
          bcc WriteSingleValue

          ; Repeat the previous value of the register
RepeatLastRegisterValue
          lda _PlayerRegCurrentValue           ; Value to copy

WriteSingleValue
          sta (_ptr_register_buffer),y
          iny

_player_return
          sta _PlayerRegCurrentValue           ; New value to write

          ; Check end of loop
          tya
          and #(mym_frame_mask)
          bne loop_depack_fragment

done_depacking
          inc _ptr_register_buffer+1        ; Move to the next register buffer

          ; Write back register current value
          ldx _CurrentAYRegister
          lda _PlayerRegCurrentValue
          sta mym_reg_values,x

          inx
          stx _CurrentAYRegister
          rts

; Offset depacking
DecompressWithOffset
.(
          lda _ptr_register_buffer+1           ; highpart of buffer adress + register number
          sta __auto_read+1                    ; Read adress

          ; Read Offset (0 to 127)
          lda #(mym_frame_bits)
          jsr _ReadBits
          ; Compute wrap around offset...
          tya
          adc _DecodedResult                   ; between 0 and 255
          eor #(mym_frame_size)
          sta mym_temp

          ; Read count (7 bits)
          lda #(mym_frame_bits)
          jsr _ReadBits

          ldx mym_temp
loop
__auto_read = 1+*
          lda _PlayerBuffer,x                  ; X for reading
          inx

          sta (_ptr_register_buffer),y         ; Y for writing
          iny
          dec _DecodedResult
          bpl loop
          jmp _player_return
.)

; Size in bits of each PSG register
_PlayerRegBits
          ; Chanel A Frequency
          .byt 8,4
          ; Chanel B Frequency
          .byt 8,4
          ; Chanel C Frequency
          .byt 8,4
          ; Chanel sound generator and select
          .byt 5,8
          ; Volume A,B,C
          .byt 5,5,5
          ; Wave period and form
          .byt 8,8,8

 align(256)
_PlayerBuffer
           .dsb 256*14

_MusicData = MUSIC_DATA

