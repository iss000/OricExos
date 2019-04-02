; ---------------------------------------------------------------------------
#include <compat.h>
; ---------------------------------------------------------------------------
#ifdef __CC65__
; ---------------------------------------------------------------------------
.zero
tmp       .byt  0,0
_tmp      = tmp

.text

; Use OSDK as donor

_cls        jmp $ccce
_text       jmp $ec21
_lores0     jmp $d9ed
_lores1     jmp $d9ea
_hires      jmp $ec33

_kbdclick1  jmp $fb14
_kbdclick2  jmp $fb2a

; export these symbols
_grexit     = grexit
_grexit2    = grexit2
_getXparm   = getXparm 


_key
            jsr $023B       ; get key without waiting. If not available
            bpl key001      ; return 0
            jmp grexit2
key001          
            lda #0
            jmp grexit2

_get
            jsr $023B       ; blatantly ripped off Fabrice`s getchar
            bpl _get        ; loop until char available
            jmp grexit2     ; rip off Vaggelis`s code as well, and exit. 

_paper
            sta $2e1
            stx $2e2
            lda #$00
            sta $2e0
            jsr $f204      ; paper
            retbyt($2e0)

;             ldx #1         ; Get one parm
;             jsr getXparm
;             jsr $f204      ; paper
;             jmp grexit     ; common exit point

_ink
            sta $2e1
            stx $2e2
            lda #$00
            sta $2e0
            jsr $f210      ; ink
            retbyt($2e0)

;             ldx #1         ; Get one parm
;             jsr getXparm
;             jsr $f210      ; ink
;             jmp grexit     ; common exit point

; Help routines for more complicated functions

getXparm                   ; Get X params (16bit) from stack
            ldy #0         ; X is the number of params
            sty $2e0       ; Zero error indicator.
            stx tmpptr     ; store X in storage byte
            ldx #0
getXloop
            lda (sp),y
            sta $2e1,x
            inx
            iny
            lda (sp),y
            sta $2e1,x
            inx
            iny            ;
            dec tmpptr     ; decrement pointer
            bne getXloop
            rts

grexit
            lda $2e0       ; Return error from Graphics or sound routines
grexit2
            ldx #0
            rts

tmpptr      .byt 0


; invoke a SEDORIC command using black magic
__sedoric_cmdptr
            .byt  0,0
__sedoric
            tya
            pha
            lda __sedoric_cmdptr
            sta tmp
            lda __sedoric_cmdptr+1
            sta tmp+1
            ldy #0

sedoric_lp  ; copy the string to #35..#84              
            lda (tmp),y
            sta $35,y
            beq sedoric_go
            iny
            bne sedoric_lp

sedoric_go            
            sta $ea         ; update the line start pointer
            lda #$35;
            sta $e9
            
            jsr $00e2       ; get next token
            jsr sedoric_call
            pla
            tay
            return(0)

sedoric_call
            jmp ($02f5)     ; call the ! command handler

#endif /* __CC65__ */

; ---------------------------------------------------------------------------
#ifdef __OSDK__
; ---------------------------------------------------------------------------
.text

#endif /* __OSDK__ */
