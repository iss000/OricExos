#define BYT   .BYTE
#define byt   .byte
#define DSB   .DSB
#define dsb   .dsb

        *=$c000
;
; **** ZP FIELDS **** 
;
f00 = $00
f01 = $01
f02 = $02
f03 = $03
f04 = $04
f0B = $0B
f35 = $35
f44 = $44
f98 = $98
fC6 = $C6
fCC = $CC
fCF = $CF
fD0 = $D0
fD7 = $D7
fD8 = $D8
fE1 = $E1

;
; **** ZP POINTERS **** 
;
p0C = $0C
p0E = $0E
p10 = $10
p12 = $12
p14 = $14
p18 = $18
p1D = $1D
p1F = $1F
p33 = $33
p46 = $46
p91 = $91
p93 = $93
p9A = $9A
pA4 = $A4
pB2 = $B2
pB6 = $B6
pB8 = $B8
pBD = $BD
pBF = $BF
pC7 = $C7
pC9 = $C9
pCE = $CE
pD1 = $D1
pD3 = $D3
pDB = $DB
pDE = $DE
pE0 = $E0
pE9 = $E9
;
; **** FIELDS **** 
;
f0001 = $0001
f0002 = $0002
f0003 = $0003
f0004 = $0004
f000B = $000B
f0030 = $0030
f0031 = $0031
f0032 = $0032
f0033 = $0033
f00FF = $00FF
f0100 = $0100
f0101 = $0101
f0102 = $0102
f0103 = $0103
f0104 = $0104
f0109 = $0109
f010F = $010F
f0110 = $0110
f0111 = $0111
f0112 = $0112
f0238 = $0238
f0272 = $0272
f0273 = $0273
f0277 = $0277
f027F = $027F
f0293 = $0293
f02A7 = $02A7
f02E1 = $02E1
f02E2 = $02E2
fBB7F = $BB7F
fBB80 = $BB80
fBFDE = $BFDE
fBFDF = $BFDF
;
; **** ABSOLUTE ADRESSES **** 
;
a00A0 = $00A0
a00A2 = $00A2
a00A9 = $00A9
a0200 = $0200
a0201 = $0201
a0202 = $0202
a0203 = $0203
a0204 = $0204
a0208 = $0208
a0209 = $0209
a020A = $020A
a020C = $020C
a020D = $020D
a020E = $020E
a0210 = $0210
a0211 = $0211
a0212 = $0212
a0213 = $0213
a0214 = $0214
a0215 = $0215
a0216 = $0216
a0217 = $0217
a0218 = $0218
a0219 = $0219
a021A = $021A
a021B = $021B
a021C = $021C
a021D = $021D
a021E = $021E
a021F = $021F
a0220 = $0220
a024D = $024D
a024E = $024E
a024F = $024F
a0251 = $0251
a0252 = $0252
a0253 = $0253
a0256 = $0256
a0257 = $0257
a0258 = $0258
a0259 = $0259
a025A = $025A
a025B = $025B
a025C = $025C
a025D = $025D
a025E = $025E
a025F = $025F
a0260 = $0260
a0261 = $0261
a0262 = $0262
a0263 = $0263
a0264 = $0264
a0265 = $0265
a0268 = $0268
a0269 = $0269
a026A = $026A
a026C = $026C
a0271 = $0271
a0278 = $0278
a0279 = $0279
a027A = $027A
a027B = $027B
a027C = $027C
a027D = $027D
a027E = $027E
a02A9 = $02A9
a02AA = $02AA
a02AB = $02AB
a02AC = $02AC
a02AD = $02AD
a02AE = $02AE
a02AF = $02AF
a02B0 = $02B0
a02B1 = $02B1
a02C0 = $02C0
a02C1 = $02C1
a02C2 = $02C2
a02C3 = $02C3
a02DF = $02DF
a02E0 = $02E0
a02E3 = $02E3
a02E4 = $02E4
a02E5 = $02E5
a02E6 = $02E6
a02E7 = $02E7
a02E8 = $02E8
a02F0 = $02F0
a02F1 = $02F1
a02F2 = $02F2
a02F4 = $02F4
a02F6 = $02F6
a02F8 = $02F8
a02FB = $02FB
a02FC = $02FC
a02FD = $02FD
a0300 = $0300
a0301 = $0301
a0302 = $0302
a0303 = $0303
a0304 = $0304
a0305 = $0305
a0306 = $0306
a0307 = $0307
a0309 = $0309
a030B = $030B
a030C = $030C
a030D = $030D
a030E = $030E
a030F = $030F
aA000 = $A000
;
; **** POINTERS **** 
;
p0091 = $0091
pD0 = $00D0
p02F5 = $02F5
p0500 = $0500
pB900 = $B900
;
; **** EXTERNAL JUMPS **** 
;
e001A = $001A
e00C3 = $00C3
e00E2 = $00E2
e00E8 = $00E8
e023B = $023B
e023E = $023E
e024A = $024A

        * = $C000

        JMP StartBASIC

        JMP RestartBASIC

JumpTab BYT  $72
fC007   BYT  $C9,$91,$C6,$86,$E9,$D0,$E9,$15
        BYT  $CD,$18,$CD,$11,$CA,$50,$DA,$A0
        BYT  $DA,$DD,$D9,$66,$D9,$84,$DA,$A0
        BYT  $DA,$54,$C8,$FC,$C7,$08,$C8,$97
        BYT  $CE,$3B,$CA,$54,$CD,$7D,$D1,$CD
        BYT  $CC,$88,$CD,$1B,$CB,$E4,$C9,$BC
        BYT  $C9,$6F,$CA,$51,$C9,$C7,$C9,$11
        BYT  $CA,$98,$CA,$CD,$EB,$E6,$EB,$0B
        BYT  $EC,$20,$EC,$32,$EC,$B4,$FA,$CA
        BYT  $FA,$E0,$FA,$9E,$FA,$FB,$EA,$FB
        BYT  $EA,$FB,$EA,$EF,$EA,$EF,$EA,$EF
        BYT  $EA,$EF,$EA,$EF,$EA,$EF,$EA,$EF
        BYT  $EA,$FB,$EA,$FB,$EA,$70,$C9,$C1
        BYT  $CA,$57,$D9,$5A,$E8,$08,$E9,$B9
        BYT  $D4,$4E,$D9,$AA,$CB,$9F,$C9,$47
        BYT  $C7,$0C,$C7,$45,$CD,$45,$E9,$12
        BYT  $CD,$ED,$C6,$21,$DF,$BD,$DF,$49
        BYT  $DF,$21,$00,$7E,$D4,$A6,$D4,$B5
        BYT  $D9,$FB,$02,$2E,$E2,$4F,$E3,$AF
        BYT  $DC,$AA,$E2,$8B,$E3,$92,$E3,$DB
        BYT  $E3,$3F,$E4,$38,$D9,$83,$D9,$D4
        BYT  $DD,$A6,$D8,$93,$D5,$D7,$D8,$B5
        BYT  $D8,$16,$D8,$77,$DE,$0F,$DF,$0B
        BYT  $DF,$DA,$DA,$3F,$DA,$45,$EC,$2A
        BYT  $D8,$56,$D8,$61,$D8
fC0CC   BYT  $79
fC0CD   BYT  $24
fC0CE   BYT  $DB,$79,$0D,$DB,$7B,$EF,$DC,$7B
        BYT  $E6,$DD,$7F,$37,$E2,$50,$E5,$D0
        BYT  $46,$E2,$D0,$7D,$70,$E2,$5A,$3B
        BYT  $D0,$64,$12
pC0E9   BYT  $D1

Keywords
        BYT  $45,$4E,$C4,$45,$44,$49,$D4,$53
        BYT  $54,$4F,$52,$C5,$52,$45,$43,$41
        BYT  $4C,$CC,$54,$52,$4F,$CE,$54,$52
        BYT  $4F,$46,$C6,$50,$4F,$D0,$50,$4C
        BYT  $4F,$D4,$50,$55,$4C,$CC,$4C,$4F
        BYT  $52,$45,$D3,$44,$4F,$4B,$C5,$52
        BYT  $45,$50,$45,$41,$D4,$55,$4E,$54
        BYT  $49,$CC,$46,$4F,$D2,$4C,$4C,$49
        BYT  $53,$D4,$4C,$50,$52,$49,$4E,$D4
        BYT  $4E,$45,$58,$D4,$44,$41,$54,$C1
        BYT  $49,$4E,$50,$55,$D4,$44,$49,$CD
        BYT  $43,$4C,$D3,$52,$45,$41,$C4,$4C
        BYT  $45,$D4,$47,$4F,$54,$CF,$52,$55
        BYT  $CE,$49,$C6,$52,$45,$53,$54,$4F
        BYT  $52,$C5,$47,$4F,$53,$55,$C2,$52
        BYT  $45,$54,$55,$52,$CE,$52,$45,$CD
        BYT  $48,$49,$4D,$45,$CD,$47,$52,$41
        BYT  $C2,$52,$45,$4C,$45,$41,$53,$C5
        BYT  $54,$45,$58,$D4,$48,$49,$52,$45
        BYT  $D3,$53,$48,$4F,$4F,$D4,$45,$58
        BYT  $50,$4C,$4F,$44,$C5,$5A,$41,$D0
        BYT  $50,$49,$4E,$C7,$53,$4F,$55,$4E
        BYT  $C4,$4D,$55,$53,$49,$C3,$50,$4C
        BYT  $41,$D9,$43,$55,$52,$53,$45,$D4
        BYT  $43,$55,$52,$4D,$4F,$D6,$44,$52
        BYT  $41,$D7,$43,$49,$52,$43,$4C,$C5
        BYT  $50,$41,$54,$54,$45,$52,$CE,$46
        BYT  $49,$4C,$CC,$43,$48,$41,$D2,$50
        BYT  $41,$50,$45,$D2,$49,$4E,$CB,$53
        BYT  $54,$4F,$D0,$4F,$CE,$57,$41,$49
        BYT  $D4,$43,$4C,$4F,$41,$C4,$43,$53
        BYT  $41,$56,$C5,$44,$45,$C6,$50,$4F
        BYT  $4B,$C5,$50,$52,$49,$4E,$D4,$43
        BYT  $4F,$4E,$D4,$4C,$49,$53,$D4,$43
        BYT  $4C,$45,$41,$D2,$47,$45,$D4,$43
        BYT  $41,$4C,$CC,$A1,$4E,$45,$D7,$54
        BYT  $41,$42,$A8,$54,$CF,$46,$CE,$53
        BYT  $50,$43,$A8,$C0,$41,$55,$54,$CF
        BYT  $45,$4C,$53,$C5,$54,$48,$45,$CE
        BYT  $4E,$4F,$D4,$53,$54,$45,$D0,$AB
        BYT  $AD,$AA,$AF,$DE,$41,$4E,$C4,$4F
        BYT  $D2,$BE,$BD,$BC,$53,$47,$CE,$49
        BYT  $4E,$D4,$41,$42,$D3,$55,$53,$D2
        BYT  $46,$52,$C5,$50,$4F,$D3,$48,$45
        BYT  $58,$A4,$A6,$53,$51,$D2,$52,$4E
        BYT  $C4,$4C,$CE,$45,$58,$D0,$43,$4F
        BYT  $D3,$53,$49,$CE,$54,$41,$CE,$41
        BYT  $54,$CE,$50,$45,$45,$CB,$44,$45
        BYT  $45,$CB,$4C,$4F,$C7,$4C,$45,$CE
        BYT  $53,$54,$52,$A4,$56,$41,$CC,$41
        BYT  $53,$C3,$43,$48,$52,$A4,$50,$C9
        BYT  $54,$52,$55,$C5,$46,$41,$4C,$53
        BYT  $C5,$4B,$45,$59,$A4,$53,$43,$52
        BYT  $CE,$50,$4F,$49,$4E,$D4,$4C,$45
        BYT  $46,$54,$A4,$52,$49,$47,$48,$54
        BYT  $A4,$4D,$49,$44,$A4,$00

ErrorMsgs
        BYT  $4E,$45,$58,$54,$20,$57,$49,$54
        BYT  $48,$4F,$55,$54,$20,$46,$4F,$D2
        BYT  $53,$59,$4E,$54,$41,$D8,$52,$45
        BYT  $54,$55,$52,$4E,$20,$57,$49,$54
        BYT  $48,$4F,$55,$54,$20,$47,$4F,$53
        BYT  $55,$C2,$4F,$55,$54,$20,$4F,$46
        BYT  $20,$44,$41,$54,$C1,$49,$4C,$4C
        BYT  $45,$47,$41,$4C,$20,$51,$55,$41
        BYT  $4E,$54,$49,$54,$D9,$4F,$56,$45
        BYT  $52,$46,$4C,$4F,$D7,$4F,$55,$54
        BYT  $20,$4F,$46,$20,$4D,$45,$4D,$4F
        BYT  $52,$D9,$55,$4E,$44,$45,$46,$27
        BYT  $44,$20,$53,$54,$41,$54,$45,$4D
        BYT  $45,$4E,$D4,$42,$41,$44,$20,$53
        BYT  $55,$42,$53,$43,$52,$49,$50,$D4
        BYT  $52,$45,$44,$49,$4D,$27,$44,$20
        BYT  $41,$52,$52,$41,$D9,$44,$49,$56
        BYT  $49,$53,$49,$4F,$4E,$20,$42,$59
        BYT  $20,$5A,$45,$52,$CF,$49,$4C,$4C
        BYT  $45,$47,$41,$4C,$20,$44,$49,$52
        BYT  $45,$43,$D4,$44,$49,$53,$50,$20
        BYT  $54,$59,$50,$45,$20,$4D,$49,$53
        BYT  $4D,$41,$54,$43,$C8,$53,$54,$52
        BYT  $49,$4E,$47,$20,$54,$4F,$4F,$20
        BYT  $4C,$4F,$4E,$C7,$46,$4F,$52,$4D
        BYT  $55,$4C,$41,$20,$54,$4F,$4F,$20
        BYT  $43,$4F,$4D,$50,$4C,$45,$D8,$43
        BYT  $41,$4E,$27,$54,$20,$43,$4F,$4E
        BYT  $54,$49,$4E,$55,$C5,$55,$4E,$44
        BYT  $45,$46,$27,$44,$20,$46,$55,$4E
        BYT  $43,$54,$49,$4F,$CE,$42,$41,$44
        BYT  $20,$55,$4E,$54,$49,$CC,$20,$45
        BYT  $52,$52,$4F,$52,$00,$20,$49,$4E
        BYT  $20,$00,$0D,$0A,$52,$65,$61,$64
        BYT  $79,$20,$0D,$0A,$00,$0D,$0A,$20
        BYT  $42,$52,$45,$41,$4B,$00
        
FindForVar TSX 
        INX 
        INX 
        INX 
        INX 
bC3CB   LDA f0101,X
        CMP #$8D
        BNE bC3F3
        LDA $B9
        BNE bC3E0
        LDA f0102,X
        STA $B8
        LDA f0103,X
        STA $B9
bC3E0   CMP f0103,X
        BNE bC3EC
        LDA $B8
        CMP f0102,X
        BEQ bC3F3
bC3EC   TXA 
        CLC 
        ADC #$12
        TAX 
        BNE bC3CB
bC3F3   RTS 

VarAlloc JSR FreeMemCheck
        STA $A0
        STY $A1
sC3FB   SEC 
        LDA $C9
        SBC $CE
        STA $91
        TAY 
        LDA $CA
        SBC $CF
        TAX 
        INX 
        TYA 
        BEQ bC42F
        LDA $C9
        SEC 
        SBC $91
        STA $C9
        BCS bC418
        DEC $CA
        SEC 
bC418   LDA $C7
        SBC $91
        STA $C7
        BCS bC428
        DEC $C8
        BCC bC428
bC424   LDA (pC9),Y
        STA (pC7),Y
bC428   DEY 
        BNE bC424
        LDA (pC9),Y
        STA (pC7),Y
bC42F   DEC $CA
        DEC $C8
        DEX 
        BNE bC428
        RTS 

sC437   ASL 
        ADC #$3E
        BCS PrintError
        STA $91
        TSX 
        CPX $91
        BCC PrintError
        RTS 

FreeMemCheck CPY $A3
        BCC bC470
        BNE bC44E
        CMP $A2
        BCC bC470
bC44E   PHA 
        LDX #$09
        TYA 
bC452   PHA 
        LDA fC6,X
        DEX 
        BPL bC452
        JSR GarbageCollect
        LDX #$F7
bC45D   PLA 
        STA fD0,X
        INX 
        BMI bC45D
        PLA 
        TAY 
        PLA 
        CPY $A3
        BCC bC470
        BNE PrintError
        CMP $A2
        BCS PrintError
bC470   RTS 

RestartBASIC
        LDA $02C0
        AND #$FE
        STA $02C0
        JMP BackToBASIC

PrintError LDX #$4D
jC47E   JSR SetScreen
        LSR $2E
        JSR NewLine
        JSR sCCD7
bC489   LDA ErrorMsgs,X
        PHA 
        AND #$7F
        JSR sCCD9
        INX 
        PLA 
        BPL bC489
        JSR sC726
        LDA #$A6
        LDY #$C3
jC49D   JSR PrintString
        LDY $A9
        INY 
        BEQ BackToBASIC
        JSR sE0BA
BackToBASIC LSR $0252
        LSR $2E
        LSR $02F2
        LDA #$B2
        LDY #$C3
        JSR $001A
bC4B7   JSR SetScreen
        JSR GetLine
        STX $E9
        STY $EA
        JSR $00E2
        TAX 
        BEQ bC4B7
        LDX #$FF
        STX $A9
        BCC InsDelLine
        JSR TokeniseLine
        JMP jC90C

InsDelLine JSR Txt2Int
        JSR TokeniseLine
        STY $26
        JSR FindLine
        BCC InsertLine
DeleteLine LDY #$01
        LDA (pCE),Y
        STA $92
        LDA $9C
        STA $91
        LDA $CF
        STA $94
        LDA $CE
        DEY 
        SBC (pCE),Y
        CLC 
        ADC $9C
        STA $9C
        STA $93
        LDA $9D
        ADC #$FF
        STA $9D
        SBC $CF
        TAX 
        SEC 
        LDA $CE
        SBC $9C
        TAY 
        BCS bC50E
        INX 
        DEC $94
bC50E   CLC 
        ADC $91
        BCC bC516
        DEC $92
        CLC 
bC516   LDA (p91),Y
        STA (p93),Y
        INY 
        BNE bC516
        INC $92
        INC $94
        DEX 
        BNE bC516
InsertLine JSR sC708
        JSR SetLineLinkPtrs
        LDA $35
        BEQ bC4B7
        CLC 
        LDA $9C
        STA $C9
        ADC $26
        STA $C7
        LDY $9D
        STY $CA
        BCC bC53E
        INY 
bC53E   STY $C8
        JSR VarAlloc
        LDA $A0
        LDY $A1
        STA $9C
        STY $9D
        LDY $26
        DEY 
bC54E   LDA f0031,Y
        STA (pCE),Y
        DEY 
        BPL bC54E
        JSR sC708
        JSR SetLineLinkPtrs
        JMP bC4B7

SetLineLinkPtrs LDA $9A
        LDY $9B
        STA $91
        STY $92
        CLC 
bC568   LDY #$01
        LDA (p91),Y
        BEQ bC58B
        LDY #$04
bC570   INY 
        LDA (p91),Y
        BNE bC570
        INY 
        TYA 
        ADC $91
        TAX 
        LDY #$00
        STA (p91),Y
        LDA $92
        ADC #$00
        INY 
        STA (p91),Y
        STX $91
        STA $92
        BCC bC568
bC58B   RTS 

bC58C   DEX 
        BPL bC594
bC58F   JSR NewLine
GetLine LDX #$00
bC594   JSR ReadKey
        CMP #$01
        BNE bC5A8
        LDY $0269
        LDA (p12),Y
        AND #$7F
        CMP #$20
        BCS bC5A8
        LDA #$09
bC5A8   PHA 
        JSR sCCD9
        PLA 
        CMP #$7F
        BEQ bC58C
        CMP #$0D
        BEQ bC5E5
        CMP #$03
        BEQ bC5E1
        CMP #$18
        BEQ bC5C8
        CMP #$20
        BCC bC594
        STA f35,X
        INX 
        CPX #$4F
        BCC bC5CF
bC5C8   LDA #$5C
        JSR sCCD9
        BNE bC58F
bC5CF   CPX #$4C
        BCC bC594
        TXA 
        PHA 
        TYA 
        PHA 
        JSR PING
        PLA 
        TAY 
        PLA 
        TAX 
        JMP bC594

bC5E1   INC $17
        LDX #$00
bC5E5   JMP jCBEA

ReadKey JSR e023B
        BPL ReadKey
        CMP #$0F
        BNE bC5F9
        PHA 
        LDA $2E
        EOR #$FF
        STA $2E
        PLA 
bC5F9   RTS 

TokeniseLine LDX $E9
        LDY #$04
        STY $2A
bC600   LDA f00,X
        CMP #$20
        BEQ bC647
        STA $25
        CMP #$22
        BEQ bC66B
        BIT $2A
        BVS bC647
        CMP #$3F
        BNE bC618
        LDA #$BA
        BNE bC647
bC618   CMP #$30
        BCC bC620
        CMP #$3C
        BCC bC647
bC620   STY $E0
        LDY #$00
        STY $26
        LDA #<pC0E9
        STA $18
        LDA #>pC0E9
        STA $19
        STX $E9
        DEX 
bC631   INX 
        INC $18
        BNE bC638
        INC $19
bC638   LDA f00,X
        SEC 
        SBC (p18),Y
        BEQ bC631
        CMP #$80
        BNE bC672
        ORA $26
bC645   LDY $E0
bC647   INX 
        INY 
        STA f0030,Y
        LDA f0030,Y
        BEQ bC68A
        SEC 
        SBC #$3A
        BEQ bC65A
        CMP #$57
        BNE bC65C
bC65A   STA $2A
bC65C   SEC 
        SBC #$63
        BNE bC600
        STA $25
bC663   LDA f00,X
        BEQ bC647
        CMP $25
        BEQ bC647
bC66B   INY 
        STA f0030,Y
        INX 
        BNE bC663
bC672   LDX $E9
        INC $26
bC676   LDA (p18),Y
        PHP 
        INC $18
        BNE bC67F
        INC $19
bC67F   PLP 
        BPL bC676
        LDA (p18),Y
        BNE bC638
        LDA f00,X
        BPL bC645
bC68A   STA f0032,Y
        LDA #$34
        STA $E9
        RTS 

EDIT    JSR Txt2Int
        JSR FindLine
        BCC bC6B0
        ROR $02F2
        JSR sC76C
        LSR $02F2
        JSR NewLine
        LDA #$0B
        JSR sCCD9
        PLA 
        PLA 
        JMP bC4B7

bC6B0   JMP jCA23

FindLine LDA #$00
        STA $1D
        STA $1E
        LDA $9A
        LDX $9B
bC6BD   LDY #$01
        STA $CE
        STX $CF
        LDA (pCE),Y
        BEQ bC6EC
        INY 
        INY 
        INC $1D
        BNE bC6CF
        INC $1E
bC6CF   LDA $34
        CMP (pCE),Y
        BCC bC6ED
        BEQ bC6DA
        DEY 
        BNE bC6E3
bC6DA   LDA $33
        DEY 
        CMP (pCE),Y
        BCC bC6ED
        BEQ bC6ED
bC6E3   DEY 
        LDA (pCE),Y
        TAX 
        DEY 
        LDA (pCE),Y
        BCS bC6BD
bC6EC   CLC 
bC6ED   RTS 

NEW     BNE bC6ED
sC6F0   LDA #$00
        LSR $02F4
        TAY 
        STA (p9A),Y
        INY 
        STA (p9A),Y
        LDA $9A
        CLC 
        ADC #$02
        STA $9C
        LDA $9B
        ADC #$00
        STA $9D
sC708   JSR sC73A
        LDA #$00
CLEAR   BNE bC739
sC70F   LDA $A6
        LDY $A7
        STA $A2
        STY $A3
        LDA $9C
        LDY $9D
        STA $9E
        STY $9F
        STA $A0
        STY $A1
        JSR RESTORE
sC726   LDX #$88
        STX $85
        PLA 
        TAY 
        PLA 
        LDX #$FE
        TXS 
        PHA 
        TYA 
        PHA 
        LDA #$00
        STA $AD
        STA $2B
bC739   RTS 

sC73A   CLC 
        LDA $9A
        ADC #$FF
        STA $E9
        LDA $9B
        ADC #$FF
        STA $EA
        RTS 

LIST    PHP 
        JSR Txt2Int
        JSR FindLine
        PLP 
        BEQ bC766
        JSR $00E8
        BEQ sC76C
        CMP #$CD
        BNE bC6ED
        JSR $00E2
        BEQ bC766
        JSR Txt2Int
        BEQ sC76C
        RTS 

bC766   LDA #$FF
        STA $33
        STA $34
sC76C   LDY #$01
        LDA (pCE),Y
        BEQ bC7BF
        JSR sC962
        CMP #$20
        BNE bC787
        LSR $02DF
bC77C   LDA $02DF
        BPL bC77C
        JSR sC962
        LSR $02DF
bC787   INY 
        LDA (pCE),Y
        TAX 
        INY 
        LDA (pCE),Y
        CMP $34
        BNE bC796
        CPX $33
        BEQ bC798
bC796   BCS bC7BF
bC798   STY $B8
        PHA 
        JSR NewLine
        PLA 
        JSR PrintInt
        LDA #$20
bC7A4   LDY $B8
        AND #$7F
bC7A8   JSR sCCD9
        INY 
        BEQ bC7BF
        LDA (pCE),Y
        BNE bC7D0
        TAY 
        LDA (pCE),Y
        TAX 
        INY 
        LDA (pCE),Y
        STX $CE
        STA $CF
        BNE sC76C
bC7BF   BIT $02F2
        BPL bC7C5
        RTS 

bC7C5   JSR NewLine
        JSR SetScreen
        PLA 
        PLA 
        JMP BackToBASIC

bC7D0   BPL bC7A8
        SEC 
        SBC #$7F
        TAX 
        STY $B8
        LDY #$00
        LDA #<pC0E9
        STA $18
        LDA #>pC0E9
        STA $19
jC7E2   DEX 
        BEQ bC7F2
bC7E5   INC $18
        BNE bC7EB
        INC $19
bC7EB   LDA (p18),Y
        BPL bC7E5
        JMP jC7E2

bC7F2   INY 
        LDA (p18),Y
        BMI bC7A4
        JSR sCCD9
        JMP bC7F2

LLIST   JSR SetPrinter
        LSR $02F2
        JSR $00E8
        JMP LIST

LPRINT  JSR SetPrinter
        JSR $00E8
        JSR PRINT
        JSR SetScreen
        RTS 

SetPrinter BIT $02F1
        BMI bC854
        LDA $30
        STA $0259
        LDA $0258
        STA $30
        SEC 
        ROR $02F1
        LDA $0256
        JMP jC844

SetScreen BIT $02F1
        BPL bC854
        LDA $30
        STA $0258
        LDA $0259
        STA $30
sC83E   LSR $02F1
        LDA $0257
jC844   STA $31
bC846   SEC 
        SBC #$08
        BCS bC846
        EOR #$FF
        SBC #$06
        CLC 
        ADC $31
        STA $32
bC854   RTS 

FOR     LDA #$80
        STA $2B
        JSR LET
        JSR FindForVar
        BNE bC866
        TXA 
        ADC #$0F
        TAX 
        TXS 
bC866   PLA 
        PLA 
        LDA #$09
        JSR sC437
        JSR FindEndOfStatement
        CLC 
        TYA 
        ADC $E9
        PHA 
        LDA $EA
        ADC #$00
        PHA 
        LDA $A9
        PHA 
        LDA $A8
        PHA 
        LDA #$C3
        JSR sD067
        JSR sCF06
        JSR GetExpr
        LDA $D5
        ORA #$7F
        AND $D1
        STA $D1
        LDA #<pC89E
        LDY #>pC89E
        STA $91
        STY $92
        JMP jCFC0

pC89E   LDA #$81
        LDY #$DC
        JSR sDE7B
        JSR $00E8
        CMP #$CB
        BNE bC8B2
        JSR $00E2
        JSR GetExpr
bC8B2   JSR GetSign
        JSR sCFB1
        LDA $B9
        PHA 
        LDA $B8
        PHA 
        LDA #$8D
        PHA 
DoNextLine JSR sC962
        LDA $E9
        LDY $EA
        BEQ bC8D0
        STA $AC
        STY $AD
        LDY #$00
bC8D0   LDA (pE9),Y
        BNE bC92F
        LSR $0252
        LDY #$02
        LDA (pE9),Y
        CLC 
        BNE bC8E1
        JMP jC98A

bC8E1   INY 
        LDA (pE9),Y
        STA $A8
        INY 
        LDA (pE9),Y
        STA $A9
        TYA 
        ADC $E9
        STA $E9
        BCC bC8F4
        INC $EA
bC8F4   BIT $02F4
        BPL jC90C
        PHA 
        LDA #$5B
        JSR sCCFB
        LDA $A9
        LDX $A8
        JSR PrintInt
        LDA #$5D
        JSR sCCFB
        PLA 
jC90C   JSR $00E2
        JSR DoStatement
        JMP DoNextLine

DoStatement BEQ bC960
jC917   SBC #$80
        BCC bC92C
        CMP #$42
        BCS bC94F
        ASL 
        TAY 
        LDA fC007,Y
        PHA 
        LDA JumpTab,Y
        PHA 
        JMP $00E2

bC92C   JMP LET

bC92F   CMP #$3A
        BEQ bC8F4
        CMP #$C8
        BNE bC945
        BIT $0252
        BPL bC94F
        JSR sCAB1
        LSR $0252
        JMP DoNextLine

bC945   CMP #$27
        BNE bC94F
        JSR REM
        JMP DoNextLine

bC94F   JMP jD070

RESTORE SEC 
        LDA $9A
        SBC #$01
        LDY $9B
        BCS bC95C
        DEY 
bC95C   STA $B0
        STY $B1
bC960   RTS 

bC961   RTS 

sC962   LDA $02DF
        BPL bC960
        AND #$7F
        LDX #$08
        CMP #$03
        BNE bC961
        CMP #$03
        BCS bC974
        CLC 
bC974   BNE bC9B9
        LDA $E9
        LDY $EA
        BEQ bC988
        STA $AC
        STY $AD
jC980   LDA $A8
        LDY $A9
        STA $AA
        STY $AB
bC988   PLA 
        PLA 
jC98A   LDA #$BD
        LDY #$C3
        LDX #$00
        STX $02F1
        STX $02DF
        STX $2E
        BCC bC99D
        JMP jC49D

bC99D   JMP BackToBASIC

CONT    BNE bC9B9
        LDX #$D7
        LDY $AD
        BNE bC9AB
        JMP jC47E

bC9AB   LDA $AC
        STA $E9
        STY $EA
        LDA $AA
        LDY $AB
        STA $A8
        STY $A9
bC9B9   RTS 

        JMP jD336

RUN     BNE bC9C2
        JMP sC708

bC9C2   JSR sC70F
        JMP jC9DC

GOSUB   LDA #$03
        JSR sC437
        LDA $EA
        PHA 
        LDA $E9
        PHA 
        LDA $A9
        PHA 
        LDA $A8
        PHA 
        LDA #$9B
        PHA 
jC9DC   JSR $00E8
        JSR GOTO
        JMP DoNextLine

GOTO    JSR sE853
        JSR FindEOL
        LDA $A9
        CMP $34
        BCS bC9FC
        TYA 
        SEC 
        ADC $E9
        LDX $EA
        BCC bCA00
        INX 
        BCS bCA00
bC9FC   LDA $9A
        LDX $9B
bCA00   JSR bC6BD
        BCC jCA23
        LDA $CE
        SBC #$01
        STA $E9
        LDA $CF
        SBC #$00
        STA $EA
bCA11   RTS 

RETURN  BNE bCA11
        LDA #$FF
        STA $B9
        JSR FindForVar
        TXS 
        CMP #$9B
        BEQ bCA2B
        LDX #$16
jCA23   =*+$01
        BIT $5AA2
        JMP jC47E

        JMP jD070

bCA2B   PLA 
        PLA 
        CPY #$0C
        BEQ bCA4A
        STA $A8
        PLA 
        STA $A9
        PLA 
        STA $E9
        PLA 
        STA $EA
sCA3C   JSR FindEndOfStatement
bCA3F   TYA 
        CLC 
        ADC $E9
        STA $E9
        BCC bCA49
        INC $EA
bCA49   RTS 

bCA4A   PLA 
        PLA 
        PLA 
        RTS 

FindEndOfStatement LDX #$3A
FindEOL   =*+$01
        BIT !$00A2              ; Force absolute mode
        STX $24
        LDY #$00
        STY $25
bCA59   LDA $25
        LDX $24
        STA $24
        STX $25
bCA61   LDA (pE9),Y
        BEQ bCA49
        CMP $25
        BEQ bCA49
        INY 
        CMP #$22
        BNE bCA61
        BEQ bCA59
IF      JSR EvalExpr
        JSR $00E8
        CMP #$97
        BEQ bCA7F
        LDA #$C9
        JSR sD067
bCA7F   LDA $D0
        BNE bCA88
        JSR sCA9E
        BEQ bCA3F
bCA88   JSR $00E8
        BCS bCA90
        JMP GOTO

bCA90   PHP 
        SEC 
        ROR $0252
        PLP 
        JMP DoStatement

REM     JSR FindEOL
        BEQ bCA3F
sCA9E   LDY #$00
bCAA0   LDA (pE9),Y
        BEQ bCAB0
        INY 
        CMP #$C9
        BEQ REM
        CMP #$C8
        BNE bCAA0
        JMP bCA3F

bCAB0   RTS 

sCAB1   LDY #$FF
bCAB3   INY 
        LDA (pE9),Y
        BEQ bCABC
        CMP #$3A
        BNE bCAB3
bCABC   JMP bCA3F

bCABF   JMP jD070

ON      JSR sD8C8
        PHA 
        CMP #$9B
        BEQ bCACE
bCACA   CMP #$97
        BNE bCABF
bCACE   DEC $D4
        BNE bCAD6
        PLA 
        JMP jC917

bCAD6   JSR $00E2
        JSR Txt2Int
        CMP #$2C
        BEQ bCACE
        PLA 
bCAE1   RTS 

Txt2Int LDX #$00
        STX $33
        STX $34
jCAE8   BCS bCAE1
        SBC #$2F
        STA $24
        LDA $34
        STA $91
        CMP #$19
        BCS bCACA
        LDA $33
        ASL 
        ROL $91
        ASL 
        ROL $91
        ADC $33
        STA $33
        LDA $91
        ADC $34
        STA $34
        ASL $33
        ROL $34
        LDA $33
        ADC $24
        STA $33
        BCC bCB16
        INC $34
bCB16   JSR $00E2
        JMP jCAE8

LET     JSR GetVarFromText
        STA $B8
        STY $B9
        LDA #$D4
        JSR sD067
        LDA $29
        PHA 
        LDA $28
        PHA 
        JSR EvalExpr
        PLA 
        ROL 
        JSR sCF09
        BNE bCB50
        PLA 
sCB39   BPL bCB4D
        JSR RoundFPA
        JSR sD2A9
        LDY #$00
        LDA $D3
        STA (pB8),Y
        INY 
        LDA $D4
        STA (pB8),Y
        RTS 

bCB4D   JMP jDEA9

bCB50   PLA 
sCB51   LDY #$02
        LDA (pD3),Y
        CMP $A3
        BCC bCB70
        BNE bCB62
        DEY 
        LDA (pD3),Y
        CMP $A2
        BCC bCB70
bCB62   LDY $D4
        CPY $9D
        BCC bCB70
        BNE bCB77
        LDA $D3
        CMP $9C
        BCS bCB77
bCB70   LDA $D3
        LDY $D4
        JMP jCB8D

bCB77   LDY #$00
        LDA (pD3),Y
        JSR SetupString
        LDA $BF
        LDY $C0
        STA $DE
        STY $DF
        JSR sD7A4
        LDA #<pD0
        LDY #>pD0
jCB8D   STA $BF
        STY $C0
        JSR sD805
        LDY #$00
        LDA (pBF),Y
        STA (pB8),Y
        INY 
        LDA (pBF),Y
        STA (pB8),Y
        INY 
        LDA (pBF),Y
        STA (pB8),Y
        RTS 

bCBA5   JSR sCCB3
bCBA8   JSR $00E8
PRINT   BEQ NewLine
jCBAD   BEQ bCC0B
        CMP #$C2
        BEQ bCC2E
        CMP #$C5
        CLC 
        BEQ bCC2E
        CMP #$2C
        BEQ bCC0C
        CMP #$3B
        BEQ bCC2B
        CMP #$C6
        BNE bCBC7
        JMP SetCursor

bCBC7   JSR EvalExpr
        BIT $28
        BMI bCBA5
        JSR sE0D5
        JSR GetString
        LDY #$00
        LDA (pD3),Y
        CLC 
        ADC $30
        CMP $31
        BCC bCBE2
        JSR NewLine
bCBE2   JSR sCCB3
        JSR sCCD4
        BNE bCBA8
jCBEA   LDY #$00
        STY f35,X
        LDX #$34
NewLine LDA $30
        PHA 
        LDA #$0D
        JSR sCCD9
        PLA 
        BIT $02F1
        BMI bCC02
        CMP $31
        BEQ bCC0B
bCC02   LDA #$00
        STA $30
        LDA #$0A
        JSR sCCD9
bCC0B   RTS 

bCC0C   LDA $30
        BIT $02F1
        BMI bCC17
        SEC 
        SBC $0253
bCC17   SEC 
bCC18   SBC #$08
        BCS bCC18
        EOR #$FF
        ADC #$01
        TAX 
        CLC 
        ADC $30
        CMP $31
        BCC bCC47
        JSR NewLine
bCC2B   JMP jCC4B

bCC2E   PHP 
        JSR GetByteExpr
        CMP #$29
        BNE bCC56
        PLP 
        BCC bCC47
        TXA 
        CMP $31
        BCC bCC41
        JMP jD336

bCC41   SEC 
        SBC $30
        BCC jCC4B
        TAX 
bCC47   INX 
bCC48   DEX 
        BNE bCC51
jCC4B   JSR $00E2
        JMP jCBAD

bCC51   JSR sCCD4
        BNE bCC48
bCC56   JMP jD070

SetCursor BIT $02F1
        BMI bCC56
        LDX $021F
        BEQ bCC66
        JMP jEAF7

bCC66   JSR GetByteExpr
        CPX #$28
        BCS bCCAD
        STX $0C
        JSR sD065
        JSR sD8C8
        INX 
        CPX #$1C
        BCS bCCAD
        LDA $026A
        PHA 
        AND #$FE
        STA $026A
        LDA #$00
        JSR sF801
        LDA $0C
        STA $0269
        TXA 
        STA $0268
        JSR RowCalc
        LDA $1F
        LDY $20
        STA $12
        STY $13
        PLA 
        STA $026A
        LDA #$01
        JSR sF801
        LDA #$3B
        JSR sD067
        JMP jCBAD

bCCAD   JMP jD8C2

PrintString JSR GetString
sCCB3   JSR sD7D0
        TAX 
        LDY #$00
        INX 
bCCBA   DEX 
        BEQ bCCCD
        LDA (p91),Y
        JSR sCCD9
        INY 
        CMP #$0D
        BNE bCCBA
        JSR bCC0B
        JMP bCCBA

bCCCD   RTS 

ClrScr  LDA #$0C
        BIT $11A9
sCCD4   =*+$01
        BIT $20A9
sCCD7   =*+$01
        BIT $3FA9
sCCD9   BIT $2E
        BMI bCD10
        PHA 
        CMP #$20
        BCC bCCED
        LDA $30
        CMP $31
        BNE bCCEB
        JSR NewLine
bCCEB   INC $30
bCCED   PLA 
        BIT $02F1
        BPL sCCFB
        PHA 
        JSR e023E
        PLA 
        AND #$FF
        RTS 

sCCFB   STX $27
        TAX 
        JSR Char2Scr
        CMP #$20
        BCC bCD09
        CMP #$7F
        BNE bCD0E
bCD09   LDX $0269
        STX $30
bCD0E   LDX $27
bCD10   AND #$FF
        RTS 

        JMP (p02F5)

TRON    LDA #$80
        BIT !$00A9
        STA $02F4
        RTS 

jCD1F   LDA $2C
        BEQ bCD36
        BMI bCD29
        LDY #$FF
        BNE bCD2D
bCD29   LDA $AE
        LDY $AF
bCD2D   STA $A8
        STY $A9
        LDX #$A8
        JMP jC47E

bCD36   LDA #$85
        LDY #$CE
        JSR PrintString
        LDA $AC
        LDY $AD
        STA $E9
        STY $EA
        RTS 

GET     JSR sD4D2
        LDX #$36
        LDY #$00
        STY $36
        LDA #$40
        JSR sCD8F
        RTS 

INPUT   LSR $2E
        CMP #$22
        BNE bCD66
        JSR sD025
        LDA #$3B
        JSR sD067
        JSR sCCB3
bCD66   JSR sD4D2
        LDA #$2C
        STA $34
bCD6D   LDA #$00
        STA $17
        JSR sCD80
        LDA $35
        BNE bCD8E
        LDA $17
        BEQ bCD6D
        CLC 
        JMP jC980

sCD80   JSR sCCD7
        JSR sCCD4
        JMP GetLine

READ    LDX $B0
        LDY $B1
bCD8E   =*+$01
        LDA #$98
sCD8F   STA $2C
        STX $B2
        STY $B3
jCD95   JSR GetVarFromText
        STA $B8
        STY $B9
        LDA $E9
        LDY $EA
        STA $BA
        STY $BB
        LDX $B2
        LDY $B3
        STX $E9
        STY $EA
        JSR $00E8
        BNE bCDCE
        BIT $2C
        BVC bCDC2
bCDB5   JSR CheckKbd
        BPL bCDB5
        STA $35
        LDX #$34
        LDY #$00
        BEQ bCDCA
bCDC2   BMI bCE35
        JSR sCCD7
        JSR sCD80
bCDCA   STX $E9
        STY $EA
bCDCE   JSR $00E2
        BIT $28
        BPL bCE06
        BIT $2C
        BVC bCDE2
        INX 
        STX $E9
        LDA #$00
        STA $24
        BEQ bCDEE
bCDE2   STA $24
        CMP #$22
        BEQ bCDEF
        LDA #$3A
        STA $24
        LDA #$2C
bCDEE   CLC 
bCDEF   STA $25
        LDA $E9
        LDY $EA
        ADC #$00
        BCC bCDFA
        INY 
bCDFA   JSR sD5BB
        JSR sD90D
        JSR sCB51
        JMP jCE0E

bCE06   JSR GetNumber
        LDA $29
        JSR sCB39
jCE0E   JSR $00E8
        BEQ bCE1A
        CMP #$2C
        BEQ bCE1A
        JMP jCD1F

bCE1A   LDA $E9
        LDY $EA
        STA $B2
        STY $B3
        LDA $BA
        LDY $BB
        STA $E9
        STY $EA
        JSR $00E8
        BEQ bCE5B
        JSR sD065
        JMP jCD95

bCE35   JSR FindEndOfStatement
        INY 
        TAX 
        BNE bCE4E
        LDX #$2A
        INY 
        LDA (pE9),Y
        BEQ bCEAC
        INY 
        LDA (pE9),Y
        STA $AE
        INY 
        LDA (pE9),Y
        INY 
        STA $AF
bCE4E   LDA (pE9),Y
        TAX 
        JSR bCA3F
        CPX #$91
        BNE bCE35
        JMP bCDCE

bCE5B   LDA $B2
        LDY $B3
        LDX $2C
        BPL bCE66
        JMP bC95C

bCE66   LDY #$00
        LDA (pB2),Y
        BEQ bCE73
        LDA #$74
        LDY #$CE
        JMP PrintString

bCE73   RTS 

        BYT  $3F,$45,$58,$54,$52,$41,$20,$49
        BYT  $47,$4E,$4F,$52,$45,$44,$0D,$0A
        BYT  $00,$3F,$52,$45,$44,$4F,$20,$46
        BYT  $52,$4F,$4D,$20,$53,$54,$41,$52
        BYT  $54,$0D,$0A,$00
        
NEXT    BNE bCE9E
        LDY #$00
        BEQ bCEA1
bCE9E   JSR GetVarFromText
bCEA1   STA $B8
        STY $B9
        JSR FindForVar
        BEQ bCEAE
        LDX #$00
bCEAC   BEQ bCF14
bCEAE   TXS 
        TXA 
        CLC 
        ADC #$04
        PHA 
        ADC #$06
        STA $93
        PLA 
        LDY #$01
        JSR sDE7B
        TSX 
        LDA f0109,X
        STA $D5
        LDA $B8
        LDY $B9
        JSR sDB22
        JSR jDEA9
        LDY #$01
        JSR sDF4E
        TSX 
        SEC 
        SBC f0109,X
        BEQ bCEF1
        LDA f010F,X
        STA $A8
        LDA f0110,X
        STA $A9
        LDA f0112,X
        STA $E9
        LDA f0111,X
        STA $EA
bCEEE   JMP DoNextLine

bCEF1   TXA 
        ADC #$11
        TAX 
        TXS 
        JSR $00E8
        CMP #$2C
        BNE bCEEE
        JSR $00E2
        JSR bCE9E
GetExpr JSR EvalExpr
sCF06   CLC 
sCF08   =*+$01
        BIT $38
sCF09   BIT $28
        BMI bCF10
        BCS bCF12
bCF0F   RTS 

bCF10   BCS bCF0F
bCF12   LDX #$A8
bCF14   JMP jC47E

EvalExpr LDX $E9
        BNE bCF1D
        DEC $EA
bCF1D   DEC $E9
        LDX #$00
jCF22   =*+$01
        BIT $48
        TXA 
        PHA 
        LDA #$01
        JSR sC437
        JSR GetItem
        LDA #$00
        STA $BC
jCF31   JSR $00E8
jCF34   SEC 
        SBC #$D3
        BCC bCF50
        CMP #$03
        BCS bCF50
        CMP #$01
        ROL 
        EOR #$01
        EOR $BC
        CMP $BC
        BCC bCFA9
        STA $BC
        JSR $00E2
        JMP jCF34

bCF50   LDX $BC
        BNE bCF80
        BCS bCFD5
        ADC #$07
        BCC bCFD5
        ADC $28
        BNE bCF61
        JMP StrCat

bCF61   ADC #$FF
        STA $91
        ASL 
        ADC $91
        TAY 
bCF69   PLA 
        CMP fC0CC,Y
        BCS bCFDA
        JSR sCF06
bCF72   PHA 
jCF73   JSR sCF99
        PLA 
        LDY $BA
        BPL bCF92
        TAX 
        BEQ bCFD8
        BNE bCFE3
bCF80   LSR $28
        TXA 
        ROL 
        LDX $E9
        BNE bCF8A
        DEC $EA
bCF8A   DEC $E9
        LDY #$1B
        STA $BC
        BNE bCF69
bCF92   CMP fC0CC,Y
        BCS bCFE3
        BCC bCF72
sCF99   LDA fC0CE,Y
        PHA 
        LDA fC0CD,Y
        PHA 
        JSR DoOper
        LDA $BC
        JMP jCF22

bCFA9   JMP jD070

DoOper  LDA $D5
        LDX fC0CC,Y
sCFB1   TAY 
        PLA 
        STA $91
        PLA 
        STA $92
        INC $91
        BNE bCFBE
        INC $92
bCFBE   TYA 
        PHA 
jCFC0   JSR RoundFPA
        LDA $D4
        PHA 
        LDA $D3
        PHA 
        LDA $D2
        PHA 
        LDA $D1
        PHA 
        LDA $D0
        PHA 
        JMP (p0091)

bCFD5   LDY #$FF
        PLA 
bCFD8   BEQ bCFFD
bCFDA   CMP #$64
        BEQ bCFE1
        JSR sCF06
bCFE1   STY $BA
bCFE3   PLA 
        LSR 
        STA $2D
        PLA 
        STA $D8
        PLA 
        STA $D9
        PLA 
        STA $DA
        PLA 
        STA $DB
        PLA 
        STA $DC
        PLA 
        STA $DD
        EOR $D5
        STA $DE
bCFFD   LDA $D0
        RTS 

GetItem LDA #$00
        STA $28
bD004   JSR $00E2
        BCS bD00C
bD009   JMP GetNumber

bD00C   JSR sD216
        BCS GetVarVal
        CMP #$2E
        BEQ bD009
        CMP #$23
        BEQ bD009
        CMP #$CD
        BEQ bD075
        CMP #$CC
        BEQ bD004
        CMP #$22
        BNE bD034
sD025   LDA $E9
        LDY $EA
        ADC #$00
        BCC bD02E
        INY 
bD02E   JSR GetString
        JMP sD90D

bD034   CMP #$CA
        BNE bD04B
        LDY #$18
        BNE bD077
NOT     JSR sD2A9
        LDA $D4
        EOR #$FF
        TAY 
        LDA $D3
        EOR #$FF
        JMP jD499

bD04B   CMP #$C4
        BNE bD052
        JMP jD522

bD052   CMP #$D6
        BCC EvalBracket
        JMP jD0A0

EvalBracket JSR sD062
        JSR EvalExpr
sD05F   LDA #$29
sD062   =*+$01
        BIT $28A9
sD065   =*+$01
        BIT $2CA9
sD067   LDY #$00
        CMP (pE9),Y
        BNE jD070
        JMP $00E2

jD070   LDX #$10
        JMP jC47E

bD075   LDY #$15
bD077   PLA 
        PLA 
        JMP jCF73

GetVarVal JSR GetVarFromText
        STA $D3
        STY $D4
        LDX $28
        BEQ bD08C
        LDX #$00
        STX $DF
        RTS 

bD08C   LDX $29
        BPL bD09D
        LDY #$00
        LDA (pD3),Y
        TAX 
        INY 
        LDA (pD3),Y
        TAY 
        TXA 
        JMP jD499

bD09D   JMP sDE7B

jD0A0   ASL 
        PHA 
        TAX 
        JSR $00E2
        CPX #$DB
        BCC bD0CE
        CPX #$E7
        BCC bD0D1
        JSR sD062
        JSR EvalExpr
        JSR sD065
        JSR sCF08
        PLA 
        TAX 
        LDA $D4
        PHA 
        LDA $D3
        PHA 
        TXA 
        PHA 
        JSR sD8C8
        PLA 
        TAY 
        TXA 
        PHA 
        JMP jD0D3

bD0CE   JSR EvalBracket
bD0D1   PLA 
        TAY 
jD0D3   LDA fBFDE,Y
        STA $C4
        LDA fBFDF,Y
        STA $C5
        JSR $00C3
        JMP sCF06

        LDY #$FF
        BIT !$00A0
        STY $26
        JSR sD2A9
        LDA $D3
        EOR $26
        STA $24
        LDA $D4
        EOR $26
        STA $25
        JSR sDED5
        JSR sD2A9
        LDA $D4
        EOR $26
        AND $25
        EOR $26
        TAY 
        LDA $D3
        EOR $26
        AND $24
        EOR $26
        JMP jD499

Compare JSR sCF09
        BCS bD12B
        LDA $DD
        ORA #$7F
        AND $D9
        STA $D9
        LDA #$D8
        LDY #$00
        JSR CompareFPA
        TAX 
        JMP jD15E

bD12B   LDA #$00
        STA $28
        DEC $BC
        JSR sD7D0
        STA $D0
        STX $D1
        STY $D2
        LDA $DB
        LDY $DC
        JSR sD7D4
        STX $DB
        STY $DC
        TAX 
        SEC 
        SBC $D0
        BEQ bD153
        LDA #$01
        BCC bD153
        LDX $D0
        LDA #$FF
bD153   STA $D5
        LDY #$FF
        INX 
bD158   INY 
        DEX 
        BNE bD163
        LDX $D5
jD15E   BMI bD16F
        CLC 
        BCC bD16F
bD163   LDA (pDB),Y
        CMP (pD1),Y
        BEQ bD158
        LDX #$FF
        BCS bD16F
        LDX #$01
bD16F   INX 
        TXA 
        ROL 
        AND $2D
        BEQ bD178
        LDA #$FF
bD178   JMP jDF24

bD17B   JSR sD065
DIM     TAX 
        JSR sD18D
        JSR $00E8
        BNE bD17B
        RTS 

GetVarFromText LDX #$00
        JSR $00E8
sD18D   STX $27
sD18F   STA $B4
        JSR $00E8
        JSR sD216
        BCS bD19C
bD199   JMP jD070

bD19C   LDX #$00
        STX $28
        STX $29
        JSR $00E2
        BCC bD1AC
        JSR sD216
        BCC bD1B7
bD1AC   TAX 
bD1AD   JSR $00E2
        BCC bD1AD
        JSR sD216
        BCS bD1AD
bD1B7   CMP #$24
        BNE bD1C1
        LDA #$FF
        STA $28
        BNE bD1D1
bD1C1   CMP #$25
        BNE bD1D8
        LDA $2B
        BMI bD199
        LDA #$80
        STA $29
        ORA $B4
        STA $B4
bD1D1   TXA 
        ORA #$80
        TAX 
        JSR $00E2
bD1D8   STX $B5
        SEC 
        ORA $2B
        SBC #$28
        BNE bD1E4
bD1E1   JMP jD2BB

bD1E4   BIT $2B
        BVS bD1E1
        LDA #$00
        STA $2B
        LDA $9C
        LDX $9D
        LDY #$00
bD1F2   STX $CF
bD1F4   STA $CE
        CPX $9F
        BNE bD1FE
        CMP $9E
        BEQ bD222
bD1FE   LDA $B4
        CMP (pCE),Y
        BNE bD20C
        LDA $B5
        INY 
        CMP (pCE),Y
        BEQ bD277
        DEY 
bD20C   CLC 
        LDA $CE
        ADC #$07
        BCC bD1F4
        INX 
        BNE bD1F2
sD216   CMP #$41
        BCC bD221
        SBC #$5B
        SEC 
        SBC #$A5
        BCS bD221
bD221   RTS 

bD222   PLA 
        PHA 
        CMP #$7E
        BNE bD235
        TSX 
        LDA f0102,X
        CMP #$D0
        BNE bD235
        LDA #$07
        LDY #$E2
        RTS 

bD235   LDA $9E
        LDY $9F
        STA $CE
        STY $CF
        LDA $A0
        LDY $A1
        STA $C9
        STY $CA
        CLC 
        ADC #$07
        BCC bD24B
        INY 
bD24B   STA $C7
        STY $C8
        JSR VarAlloc
        LDA $C7
        LDY $C8
        INY 
        STA $9E
        STY $9F
        LDY #$00
        LDA $B4
        STA (pCE),Y
        INY 
        LDA $B5
        STA (pCE),Y
        LDA #$00
        INY 
        STA (pCE),Y
        INY 
        STA (pCE),Y
        INY 
        STA (pCE),Y
        INY 
        STA (pCE),Y
        INY 
        STA (pCE),Y
bD277   LDA $CE
        CLC 
        ADC #$02
        LDY $CF
        BCC bD281
        INY 
bD281   STA $B6
        STY $B7
        RTS 

sD286   LDA $26
sD288   ASL 
        ADC #$05
        ADC $CE
        LDY $CF
        BCC bD292
        INY 
bD292   STA $C7
        STY $C8
        RTS 

        BYT  $90,$80,$00,$00,$00
sD29C   JSR $00E2
        JSR EvalExpr
sD2A2   JSR sCF06
        LDA $D5
        BMI bD2B6
sD2A9   LDA $D0
        CMP #$90
        BCC bD2B8
        LDA #$97
        LDY #$D2
        JSR CompareFPA
bD2B6   BNE jD336
bD2B8   JMP FPA2Int

jD2BB   LDA $2B
        BNE bD306
        LDA $27
        ORA $29
        PHA 
        LDA $28
        PHA 
        LDY #$00
bD2C9   TYA 
        PHA 
        LDA $B5
        PHA 
        LDA $B4
        PHA 
        JSR sD29C
        PLA 
        STA $B4
        PLA 
        STA $B5
        PLA 
        TAY 
        TSX 
        LDA f0102,X
        PHA 
        LDA f0101,X
        PHA 
        LDA $D3
        STA f0102,X
        LDA $D4
        STA f0101,X
        INY 
        JSR $00E8
        CMP #$2C
        BEQ bD2C9
        STY $26
        JSR sD05F
        PLA 
        STA $28
        PLA 
        STA $29
        AND #$7F
        STA $27
bD306   LDX $9E
        LDA $9F
bD30A   STX $CE
        STA $CF
        CMP $A1
        BNE bD316
        CPX $A0
        BEQ bD355
bD316   LDY #$00
        LDA (pCE),Y
        INY 
        CMP $B4
        BNE bD325
        LDA $B5
        CMP (pCE),Y
        BEQ bD33B
bD325   INY 
        LDA (pCE),Y
        CLC 
        ADC $CE
        TAX 
        INY 
        LDA (pCE),Y
        ADC $CF
        BCC bD30A
bD333   LDX #$6B
jD336   =*+$01
        BIT $35A2
bD338   JMP jC47E

bD33B   LDX #$78
        LDA $27
        BNE bD338
        LDA $2B
        BEQ bD347
        SEC 
        RTS 

bD347   JSR sD286
        LDA $26
        LDY #$04
        CMP (pCE),Y
        BNE bD333
        JMP GetArrayElement

bD355   LDA $2B
        BEQ DimArray
        JSR sE93D
        LDX #$2A
        JMP jC47E

DimArray JSR sD286
        JSR FreeMemCheck
        LDA #$00
        TAY 
        STA $E1
        LDX #$05
        LDA $B4
        STA (pCE),Y
        BPL bD375
        DEX 
bD375   INY 
        LDA $B5
        STA (pCE),Y
        BPL bD37E
        DEX 
        DEX 
bD37E   STX $E0
        LDA $26
        INY 
        INY 
        INY 
        STA (pCE),Y
bD387   LDX #$0B
        LDA #$00
        BIT $27
        BVC bD397
        PLA 
        CLC 
        ADC #$01
        TAX 
        PLA 
        ADC #$00
bD397   INY 
        STA (pCE),Y
        INY 
        TXA 
        STA (pCE),Y
        JSR sD44D
        STX $E0
        STA $E1
        LDY $91
        DEC $26
        BNE bD387
        ADC $C8
        BCS bD40C
        STA $C8
        TAY 
        TXA 
        ADC $C7
        BCC bD3BA
        INY 
        BEQ bD40C
bD3BA   JSR FreeMemCheck
        STA $A0
        STY $A1
        LDA #$00
        INC $E1
        LDY $E0
        BEQ bD3CE
bD3C9   DEY 
        STA (pC7),Y
        BNE bD3C9
bD3CE   DEC $C8
        DEC $E1
        BNE bD3C9
        INC $C8
        SEC 
        LDA $A0
        SBC $CE
        LDY #$02
        STA (pCE),Y
        LDA $A1
        INY 
        SBC $CF
        STA (pCE),Y
        LDA $27
        BNE bD44C
        INY 
GetArrayElement LDA (pCE),Y
        STA $26
        LDA #$00
        STA $E0
bD3F3   STA $E1
        INY 
        PLA 
        TAX 
        STA $D3
        PLA 
        STA $D4
        CMP (pCE),Y
        BCC bD40F
        BNE bD409
        INY 
        TXA 
        CMP (pCE),Y
        BCC bD410
bD409   JMP bD333

bD40C   JMP PrintError

bD40F   INY 
bD410   LDA $E1
        ORA $E0
        CLC 
        BEQ bD421
        JSR sD44D
        TXA 
        ADC $D3
        TAX 
        TYA 
        LDY $91
bD421   ADC $D4
        STX $E0
        DEC $26
        BNE bD3F3
        STA $E1
        LDX #$05
        LDA $B4
        BPL bD432
        DEX 
bD432   LDA $B5
        BPL bD438
        DEX 
        DEX 
bD438   STX $97
        LDA #$00
        JSR sD456
        TXA 
        ADC $C7
        STA $B6
        TYA 
        ADC $C8
        STA $B7
        TAY 
        LDA $B6
bD44C   RTS 

sD44D   STY $91
        LDA (pCE),Y
        STA $97
        DEY 
        LDA (pCE),Y
sD456   STA $98
        LDA #$10
        STA $CC
        LDX #$00
        LDY #$00
bD460   TXA 
        ASL 
        TAX 
        TYA 
        ROL 
        TAY 
        BCS bD40C
        ASL $E0
        ROL $E1
        BCC bD479
        CLC 
        TXA 
        ADC $97
        TAX 
        TYA 
        ADC $98
        TAY 
        BCS bD40C
bD479   DEC $CC
        BNE bD460
        RTS 

FRE     LDA $28
        BEQ bD485
        JSR sD7D0
bD485   JSR GarbageCollect
        SEC 
        LDA $A2
        SBC $A0
        TAY 
        LDA $A3
        SBC $A1
        LDX #$00
        STX $28
        JMP jDF40

jD499   LDX #$00
        STX $28
        STA $D1
        STY $D2
        LDX #$90
        JMP jDF2C

POS     JSR sD8CB
        TXA 
        BEQ bD4B4
        LDY $0258
        BIT $02F1
        BPL bD4B6
bD4B4   LDY $30
bD4B6   LDA #$00
        BEQ jD499
DEF     CMP #$D9
        BNE bD4DF
        JSR $00E2
        LDA #$D4
        JSR sD067
        JSR sE853
        LDA $33
        LDY $34
        STA $22
        STY $23
bD4D1   RTS 

sD4D2   LDX $A9
        INX 
        BNE bD4D1
        LDX #$95
bD4DA   =*+$01
        BIT $E5A2
        JMP jC47E

bD4DF   JSR sD50D
        JSR sD4D2
        JSR sD062
        LDA #$80
        STA $2B
        JSR GetVarFromText
        JSR sCF06
        JSR sD05F
        LDA #$D4
        JSR sD067
        PHA 
        LDA $B7
        PHA 
        LDA $B6
        PHA 
        LDA $EA
        PHA 
        LDA $E9
        PHA 
        JSR sCA3C
        JMP jD57D

sD50D   LDA #$C4
        JSR sD067
        ORA #$80
        LDX #$80
        STX $2B
        JSR sD18F
        STA $BD
        STY $BE
        JMP sCF06

jD522   JSR sD50D
        LDA $BE
        PHA 
        LDA $BD
        PHA 
        JSR EvalBracket
        JSR sCF06
        PLA 
        STA $BD
        PLA 
        STA $BE
        LDY #$02
        LDA (pBD),Y
        STA $B6
        TAX 
        INY 
        LDA (pBD),Y
        BEQ bD4DA
        STA $B7
        INY 
bD546   LDA (pB6),Y
        PHA 
        DEY 
        BPL bD546
        LDY $B7
        JSR sDEAD
        LDA $EA
        PHA 
        LDA $E9
        PHA 
        LDA (pBD),Y
        STA $E9
        INY 
        LDA (pBD),Y
        STA $EA
        LDA $B7
        PHA 
        LDA $B6
        PHA 
        JSR GetExpr
        PLA 
        STA $BD
        PLA 
        STA $BE
        JSR $00E8
        BEQ bD577
        JMP jD070

bD577   PLA 
        STA $E9
        PLA 
        STA $EA
jD57D   LDY #$00
        PLA 
        STA (pBD),Y
        PLA 
        INY 
        STA (pBD),Y
        PLA 
        INY 
        STA (pBD),Y
        PLA 
        INY 
        STA (pBD),Y
        PLA 
        INY 
        STA (pBD),Y
        RTS 

STR     JSR sCF06
        LDY #$00
        JSR sE0D7
jD59B   PLA 
        PLA 
        LDA #$FF
        LDY #$00
        BEQ GetString
SetupString LDX $D3
        LDY $D4
        STX $BF
        STY $C0
sD5AB   JSR sD61E
        STX $D1
        STY $D2
        STA $D0
        RTS 

GetString LDX #$22
        STX $24
        STX $25
sD5BB   STA $DE
        STY $DF
        STA $D1
        STY $D2
        LDY #$FF
bD5C5   INY 
        LDA (pDE),Y
        BEQ bD5D6
        CMP $24
        BEQ bD5D2
        CMP $25
        BNE bD5C5
bD5D2   CMP #$22
        BEQ bD5D7
bD5D6   CLC 
bD5D7   STY $D0
        TYA 
        ADC $DE
        STA $E0
        LDX $DF
        BCC bD5E3
        INX 
bD5E3   STX $E1
        LDA $DF
        BNE bD5F4
        TYA 
        JSR SetupString
        LDX $DE
        LDY $DF
        JSR sD7B2
bD5F4   LDX $85
        CPX #$91
        BNE bD5FF
        LDX #$C4
bD5FC   JMP jC47E

bD5FF   LDA $D0
        STA f00,X
        LDA $D1
        STA f01,X
        LDA $D2
        STA f02,X
        LDY #$00
        STX $D3
        STY $D4
        STY $DF
        DEY 
        STY $28
        STX $86
        INX 
        INX 
        INX 
        STX $85
        RTS 

sD61E   LSR $2A
bD620   PHA 
        EOR #$FF
        SEC 
        ADC $A2
        LDY $A3
        BCS bD62B
        DEY 
bD62B   CPY $A1
        BCC bD640
        BNE bD635
        CMP $A0
        BCC bD640
bD635   STA $A2
        STY $A3
        STA $A4
        STY $A5
        TAX 
        PLA 
        RTS 

bD640   LDX #$4D
        LDA $2A
        BMI bD5FC
        JSR GarbageCollect
        LDA #$80
        STA $2A
        PLA 
        BNE bD620
GarbageCollect LDX $A6
        LDA $A7
jD654   STX $A2
        STA $A3
        LDY #$00
        STY $BE
        STY $BD
        LDA $A0
        LDX $A1
        STA $CE
        STX $CF
        LDA #$88
        LDX #$00
        STA $91
        STX $92
bD66E   CMP $85
        BEQ bD677
        JSR sD6F1
        BEQ bD66E
bD677   LDA #$07
        STA $C2
        LDA $9C
        LDX $9D
        STA $91
        STX $92
bD683   CPX $9F
        BNE bD68B
        CMP $9E
        BEQ bD690
bD68B   JSR sD6E7
        BEQ bD683
bD690   STA $C7
        STX $C8
        LDA #$03
        STA $C2
bD698   LDA $C7
        LDX $C8
bD69C   CPX $A1
        BNE bD6A7
        CMP $A0
        BNE bD6A7
        JMP CopyString

bD6A7   STA $91
        STX $92
        LDY #$00
        LDA (p91),Y
        TAX 
        INY 
        LDA (p91),Y
        PHP 
        INY 
        LDA (p91),Y
        ADC $C7
        STA $C7
        INY 
        LDA (p91),Y
        ADC $C8
        STA $C8
        PLP 
        BPL bD698
        TXA 
        BMI bD698
        INY 
        LDA (p91),Y
        LDY #$00
        ASL 
        ADC #$05
        ADC $91
        STA $91
        BCC bD6D8
        INC $92
bD6D8   LDX $92
bD6DA   CPX $C8
        BNE bD6E2
        CMP $C7
        BEQ bD69C
bD6E2   JSR sD6F1
        BEQ bD6DA
sD6E7   LDA (p91),Y
        BMI bD720
        INY 
        LDA (p91),Y
        BPL bD720
        INY 
sD6F1   LDA (p91),Y
        BEQ bD720
        INY 
        LDA (p91),Y
        TAX 
        INY 
        LDA (p91),Y
        CMP $A3
        BCC bD706
        BNE bD720
        CPX $A2
        BCS bD720
bD706   CMP $CF
        BCC bD720
        BNE bD710
        CPX $CE
        BCC bD720
bD710   STX $CE
        STA $CF
        LDA $91
        LDX $92
        STA $BD
        STX $BE
        LDA $C2
        STA $C4
bD720   LDA $C2
        CLC 
        ADC $91
        STA $91
        BCC bD72B
        INC $92
bD72B   LDX $92
        LDY #$00
        RTS 

CopyString LDA $BE
        ORA $BD
        BEQ bD72B
        LDA $C4
        AND #$04
        LSR 
        TAY 
        STA $C4
        LDA (pBD),Y
        ADC $CE
        STA $C9
        LDA $CF
        ADC #$00
        STA $CA
        LDA $A2
        LDX $A3
        STA $C7
        STX $C8
        JSR sC3FB
        LDY $C4
        INY 
        LDA $C7
        STA (pBD),Y
        TAX 
        INC $C8
        LDA $C8
        INY 
        STA (pBD),Y
        JMP jD654

StrCat  LDA $D4
        PHA 
        LDA $D3
        PHA 
        JSR GetItem
        JSR sCF08
        PLA 
        STA $DE
        PLA 
        STA $DF
        LDY #$00
        LDA (pDE),Y
        CLC 
        ADC (pD3),Y
        BCC bD787
        LDX #$B5
        JMP jC47E

bD787   JSR SetupString
        JSR sD7A4
        LDA $BF
        LDY $C0
        JSR sD7D4
        JSR sD7B6
        LDA $DE
        LDY $DF
        JSR sD7D4
        JSR bD5F4
        JMP jCF31

sD7A4   LDY #$00
        LDA (pDE),Y
        PHA 
        INY 
        LDA (pDE),Y
        TAX 
        INY 
        LDA (pDE),Y
        TAY 
        PLA 
sD7B2   STX $91
        STY $92
sD7B6   TAY 
        BEQ bD7C3
        PHA 
bD7BA   DEY 
        LDA (p91),Y
        STA (pA4),Y
        TYA 
        BNE bD7BA
        PLA 
bD7C3   CLC 
        ADC $A4
        STA $A4
        BCC bD7CC
        INC $A5
bD7CC   RTS 

sD7CD   JSR sCF08
sD7D0   LDA $D3
        LDY $D4
sD7D4   STA $91
        STY $92
        JSR sD805
        PHP 
        LDY #$00
        LDA (p91),Y
        PHA 
        INY 
        LDA (p91),Y
        TAX 
        INY 
        LDA (p91),Y
        TAY 
        PLA 
        PLP 
        BNE bD800
        CPY $A3
        BNE bD800
        CPX $A2
        BNE bD800
        PHA 
        CLC 
        ADC $A2
        STA $A2
        BCC bD7FF
        INC $A3
bD7FF   PLA 
bD800   STX $91
        STY $92
        RTS 

sD805   CPY $87
        BNE bD815
        CMP $86
        BNE bD815
        STA $85
        SBC #$03
        STA $86
        LDY #$00
bD815   RTS 

CHR     JSR sD8CB
        TXA 
        PHA 
        LDA #$01
        JSR sD5AB
        PLA 
        LDY #$00
        STA (pD1),Y
        PLA 
        PLA 
        JMP bD5F4

LEFT    JSR sD88B
        CMP (pBF),Y
        TYA 
jD830   BCC bD836
        LDA (pBF),Y
        TAX 
        TYA 
bD836   PHA 
bD837   TXA 
bD838   PHA 
        JSR sD5AB
        LDA $BF
        LDY $C0
        JSR sD7D4
        PLA 
        TAY 
        PLA 
        CLC 
        ADC $91
        STA $91
        BCC bD84F
        INC $92
bD84F   TYA 
        JSR sD7B6
        JMP bD5F4

RIGHT   JSR sD88B
        CLC 
        SBC (pBF),Y
        EOR #$FF
        JMP jD830

MID     LDA #$FF
        STA $D4
        JSR $00E8
        CMP #$29
        BEQ bD872
        JSR sD065
        JSR sD8C8
bD872   JSR sD88B
        BEQ jD8C2
        DEX 
        TXA 
        PHA 
        CLC 
        LDX #$00
        SBC (pBF),Y
        BCS bD837
        EOR #$FF
        CMP $D4
        BCC bD838
        LDA $D4
        BCS bD838
sD88B   JSR sD05F
        PLA 
        TAY 
        PLA 
        STA $C4
        PLA 
        PLA 
        PLA 
        TAX 
        PLA 
        STA $BF
        PLA 
        STA $C0
        LDA $C4
        PHA 
        TYA 
        PHA 
        LDY #$00
        TXA 
        RTS 

LEN     JSR sD8AC
        JMP bD4B6

sD8AC   JSR sD7CD
        LDX #$00
        STX $28
        TAY 
        RTS 

ASC     JSR sD8AC
        BEQ jD8C2
        LDY #$00
        LDA (p91),Y
        TAY 
        JMP bD4B6

jD8C2   JMP jD336

GetByteExpr JSR $00E2
sD8C8   JSR GetExpr
sD8CB   JSR sD2A2
        LDX $D3
        BNE jD8C2
        LDX $D4
        JMP $00E8

        JSR sD8AC
        BNE bD8DF
        JMP jDBB2

bD8DF   LDX $E9
        LDY $EA
        STX $E0
        STY $E1
        LDX $91
        STX $E9
        CLC 
        ADC $91
        STA $93
        LDX $92
        STX $EA
        BCC bD8F7
        INX 
bD8F7   STX $94
        LDY #$00
        LDA (p93),Y
        PHA 
        LDA #$00
        STA (p93),Y
        JSR $00E8
        JSR GetNumber
        PLA 
        LDY #$00
        STA (p93),Y
sD90D   LDX $E0
        LDY $E1
        STX $E9
        STY $EA
        RTS 

sD916   JSR GetExpr
        JSR FP2Int
        JSR sD065
        JMP sD8C8

FP2Int  LDA $D5
        BMI jD8C2
        LDA $D0
        CMP #$91
sD92A   BCS jD8C2
        JSR FPA2Int
        LDA $D3
        LDY $D4
        STY $33
        STA $34
        RTS 

PEEK    LDA $34
        PHA 
        LDA $33
        PHA 
        JSR FP2Int
        LDY #$00
        LDA (p33),Y
        TAY 
        PLA 
        STA $33
        PLA 
        STA $34
        JMP bD4B6

POKE    JSR sD916
        TXA 
        LDY #$00
        STA (p33),Y
        RTS 

WAIT    JSR GetExpr
        JSR FP2Int
        LDY $33
        LDX $34
        LDA #$02
        JMP Delay

DOKE    JSR sE853
        LDA $33
        LDY $34
        STA $1D
        STY $1E
        JSR sD065
        JSR sE853
        LDY #$01
bD97A   LDA f0033,Y
        STA (p1D),Y
        DEY 
        BPL bD97A
        RTS 

DEEK    JSR FP2Int
        LDY #$01
        LDA (p33),Y
        PHA 
        DEY 
        LDA (p33),Y
        TAY 
        PLA 
        JMP jDF40

Byte2Hex PHA 
        LSR 
        LSR 
        LSR 
        LSR 
        JSR sD99C
        PLA 
sD99C   AND #$0F
        ORA #$30
        CMP #$3A
        BCC bD9A6
        ADC #$06
bD9A6   CMP #$30
        BNE bD9AE
        LDY $2F
        BEQ bD9B4
bD9AE   STA $2F
        STA f0100,X
        INX 
bD9B4   RTS 

HEX     JSR FP2Int
        LDX #$00
        STX $2F
        LDA #$23
        STA $FF
        LDA $34
        JSR Byte2Hex
        LDA $33
        JSR Byte2Hex
        TXA 
        BNE bD9D3
        LDA #$30
        STA f0100,X
        INX 
bD9D3   LDA #$00
        STA f0100,X
        JMP jD59B

bD9DB   JMP jD070

LORES   JSR TEXT
        JSR sD8C8
        TXA 
        BEQ bD9ED
        DEX 
        BNE bD9DB
        LDA #$09
bD9ED   =*+$01
        BIT $08A9
        LDX #$10
        STX $02F8
        LDX #$1B
bD9F6   PHA 
        TXA 
        JSR RowCalc
        LDA $02F8
        LDY #$27
bDA00   STA (p1F),Y
        DEY 
        BNE bDA00
        PLA 
        STA (p1F),Y
        DEX 
        BNE bD9F6
        RTS 

RowCalc JSR sF731
        STY $20
        CLC 
        ADC #$80
        PHA 
        STA $1F
        LDA #$BB
        ADC $20
        STA $20
        PLA 
        RTS 

bDA1F   JMP jD8C2

sDA22   JSR TxtTest
        JSR sD8C8
        CPX #$28
        BCS bDA1F
        STX $02F8
        JSR sD065
        JSR sD8C8
        CPX #$1B
        BCS bDA1F
        INX 
        TXA 
        JSR RowCalc
        RTS 

SCRN    JSR sD062
        JSR sDA22
        JSR sD05F
        LDY $02F8
        LDA (p1F),Y
        TAY 
        JMP bD4B6

PLOT    JSR sDA22
        JSR sD065
        JSR EvalExpr
        BIT $28
        BPL bDA7B
        JSR sD7D0
        TAX 
        CLC 
        LDA $02F8
        ADC $1F
        BCC bDA6C
        INC $20
bDA6C   STA $1F
        LDY #$00
        INX 
bDA71   DEX 
        BEQ bDA84
        LDA (p91),Y
        STA (p1F),Y
        INY 
        BNE bDA71
bDA7B   JSR sD8CB
        TXA 
        LDY $02F8
        STA (p1F),Y
bDA84   RTS 

        BNE bDA9E
        LDA #$03
        JSR sC437
jDA8C   LDA $EA
        PHA 
        LDA $E9
        PHA 
        LDA $A9
        PHA 
        LDA $A8
        PHA 
        LDA #$8B
        PHA 
        JMP DoNextLine

bDA9E   JMP jD070

UNTIL   LDA #$FF
        STA $B9
        JSR FindForVar
        TXS 
        CMP #$8B
REPEAT  BEQ bDAB2
        LDX #$F5
        JMP jC47E

bDAB2   CPY #$10
        BNE bDABB
        STY $D0
        TYA 
        BNE bDAC1
bDABB   JSR $00E8
        JSR EvalExpr
bDAC1   PLA 
        LDA $D0
        BEQ bDACB
        PLA 
        PLA 
        PLA 
        PLA 
        RTS 

bDACB   PLA 
        STA $A8
        PLA 
        STA $A9
        PLA 
        STA $E9
        PLA 
        STA $EA
        JMP jDA8C

KEY     JSR CheckKbd
        PHP 
        PHA 
        BPL bDAE4
        LDA #$01
bDAE4   =*+$01
        BIT !$00A9
        JSR sD5AB
        PLA 
        PLP 
        BPL bDAF1
        LDY #$00
        STA (pD1),Y
bDAF1   PLA 
        PLA 
        JMP bD5F4

TxtTest LDA $02C0
        AND #$01
        BEQ bDB02
        LDX #$A3
        JMP jC47E

bDB02   RTS 

bDB03   RTS 

sDB04   LDA #$05
        LDY #$E2
        JMP sDB22

sDB0B   JSR UnpackFPA
sDB0E   LDA $D5
        EOR #$FF
        STA $D5
        EOR $DD
        STA $DE
        LDA $D0
        JMP jDB25

bDB1D   JSR sDC54
        BCC bDB5E
sDB22   JSR UnpackFPA
jDB25   BNE bDB2A
        JMP sDED5

bDB2A   LDX $DF
        STX $C5
        LDX #$D8
        LDA $D8
sDB32   TAY 
        BEQ bDB03
        SEC 
        SBC $D0
        BEQ bDB5E
        BCC bDB4E
        STY $D0
        LDY $DD
        STY $D5
        EOR #$FF
        ADC #$00
        LDY #$00
        STY $C5
        LDX #$D0
        BNE bDB52
bDB4E   LDY #$00
        STY $DF
bDB52   CMP #$F9
        BMI bDB1D
        TAY 
        LDA $DF
        LSR f01,X
        JSR sDC6B
bDB5E   BIT $DE
        BPL AddMantissas
        LDY #$D0
        CPX #$D8
        BEQ bDB6A
        LDY #$D8
bDB6A   SEC 
        EOR #$FF
        ADC $C5
        STA $DF
        LDA f0004,Y
        SBC f04,X
        STA $D4
        LDA f0003,Y
        SBC f03,X
        STA $D3
        LDA f0002,Y
        SBC f02,X
        STA $D2
        LDA f0001,Y
        SBC f01,X
        STA $D1
jDB8D   BCS Normalise
        JSR sDC02
Normalise LDY #$00
        TYA 
        CLC 
bDB96   LDX $D1
        BNE bDBE4
        LDX $D2
        STX $D1
        LDX $D3
        STX $D2
        LDX $D4
        STX $D3
        LDX $DF
        STX $D4
        STY $DF
        ADC #$08
        CMP #$28
        BNE bDB96
jDBB2   LDA #$00
jDBB4   STA $D0
jDBB6   STA $D5
        RTS 

AddMantissas ADC $C5
        STA $DF
        LDA $D4
        ADC $DC
        STA $D4
        LDA $D3
        ADC $DB
        STA $D3
        LDA $D2
        ADC $DA
        STA $D2
        LDA $D1
        ADC $D9
        STA $D1
        JMP jDBF1

bDBD8   ADC #$01
        ASL $DF
        ROL $D4
        ROL $D3
        ROL $D2
        ROL $D1
bDBE4   BPL bDBD8
        SEC 
        SBC $D0
        BCS jDBB2
        EOR #$FF
        ADC #$01
        STA $D0
jDBF1   BCC bDC01
jDBF3   INC $D0
        BEQ bDC39
        ROR $D1
        ROR $D2
        ROR $D3
        ROR $D4
        ROR $DF
bDC01   RTS 

sDC02   LDA $D5
        EOR #$FF
        STA $D5
sDC08   LDA $D1
        EOR #$FF
        STA $D1
        LDA $D2
        EOR #$FF
        STA $D2
        LDA $D3
        EOR #$FF
        STA $D3
        LDA $D4
        EOR #$FF
        STA $D4
        LDA $DF
        EOR #$FF
        STA $DF
        INC $DF
        BNE bDC38
sDC2A   INC $D4
        BNE bDC38
        INC $D3
        BNE bDC38
        INC $D2
        BNE bDC38
        INC $D1
bDC38   RTS 

bDC39   LDX #$45
        JMP jC47E

jDC3E   LDX #$94
bDC40   LDY f04,X
        STY $DF
        LDY f03,X
        STY f04,X
        LDY f02,X
        STY f03,X
        LDY f01,X
        STY f02,X
        LDY $D7
        STY f01,X
sDC54   ADC #$08
        BMI bDC40
        BEQ bDC40
        SBC #$08
        TAY 
        LDA $DF
        BCS bDC75
bDC61   ASL f01,X
        BCC bDC67
        INC f01,X
bDC67   ROR f01,X
        ROR f01,X
sDC6B   ROR f02,X
        ROR f03,X
        ROR f04,X
        ROR 
        INY 
        BNE bDC61
bDC75   CLC 
        RTS 

        BYT  $82,$13,$5D,$8D,$DE
pDC7C   BYT  $82,$49,$0F,$DA,$9E,$81,$00,$00
        BYT  $00,$00,$03,$7F,$5E,$56,$CB,$79
        BYT  $80,$13,$9B,$0B,$64,$80,$76,$38
        BYT  $93,$16,$82,$38,$AA,$3B,$20,$80
        BYT  $35,$04,$F3,$34,$81,$35,$04,$F3
        BYT  $34,$80,$80,$00,$00,$00,$80,$31
        BYT  $72,$17,$F8
LN      JSR GetSign
        BEQ bDCB6
        BPL bDCB9
bDCB6   JMP jD336

bDCB9   LDA $D0
        SBC #$7F
        PHA 
        LDA #$80
        STA $D0
        LDA #$9B
        LDY #$DC
        JSR sDB22
        LDA #$A0
        LDY #$DC
        JSR sDDE4
        LDA #$81
        LDY #$DC
        JSR sDB0B
        LDA #$86
        LDY #$DC
        JSR sE2FD
        LDA #$A5
        LDY #$DC
        JSR sDB22
        PLA 
        JSR AddToFPA
        LDA #$AA
        LDY #$DC
sDCED   JSR UnpackFPA
        BNE bDCF5
        JMP jDD50

bDCF5   JSR sDD7C
        LDA #$00
        STA $95
        STA $96
        STA $97
        STA $98
        LDA $DF
        JSR sDD1E
        LDA $D4
        JSR sDD1E
        LDA $D3
        JSR sDD1E
        LDA $D2
        JSR sDD1E
        LDA $D1
        JSR sDD23
        JMP jDE64

sDD1E   BNE sDD23
        JMP jDC3E

sDD23   LSR 
        ORA #$80
bDD26   TAY 
        BCC bDD42
        CLC 
        LDA $98
        ADC $DC
        STA $98
        LDA $97
        ADC $DB
        STA $97
        LDA $96
        ADC $DA
        STA $96
        LDA $95
        ADC $D9
        STA $95
bDD42   ROR $95
        ROR $96
        ROR $97
        ROR $98
        ROR $DF
        TYA 
        LSR 
        BNE bDD26
jDD50   RTS 

UnpackFPA STA $91
        STY $92
        LDY #$04
        LDA (p91),Y
        STA $DC
        DEY 
        LDA (p91),Y
        STA $DB
        DEY 
        LDA (p91),Y
        STA $DA
        DEY 
        LDA (p91),Y
        STA $DD
        EOR $D5
        STA $DE
        LDA $DD
        ORA #$80
        STA $D9
        DEY 
        LDA (p91),Y
        STA $D8
        LDA $D0
        RTS 

sDD7C   LDA $D8
sDD7E   BEQ bDD9F
        CLC 
        ADC $D0
        BCC bDD89
        BMI bDDA4
        CLC 
bDD89   =*+$01
        BIT $1410
        ADC #$80
        STA $D0
        BNE bDD94
        JMP jDBB6

bDD94   LDA $DE
        STA $D5
        RTS 

sDD99   LDA $D5
        EOR #$FF
        BMI bDDA4
bDD9F   PLA 
        PLA 
        JMP jDBB2

bDDA4   JMP bDC39

FPAMult10 JSR sDEE5
        TAX 
        BEQ bDDBD
        CLC 
        ADC #$02
        BCS bDDA4
        LDX #$00
        STX $DE
        JSR sDB32
        INC $D0
        BEQ bDDA4
bDDBD   RTS 

        BYT  $84,$20,$00,$00,$00
FPADiv10 JSR sDEE5
        LDA #$BE
        LDY #$DD
        LDX #$00
sDDCC   STX $DE
        JSR sDE7B
        JMP jDDE7

LOG     JSR LN
        JSR sDEE5
        LDA #$77
        LDY #$DC
        JSR sDE7B
        JMP jDDE7

sDDE4   JSR UnpackFPA
jDDE7   BEQ bDE5F
        JSR RoundFPA
        LDA #$00
        SEC 
        SBC $D0
        STA $D0
        JSR sDD7C
        INC $D0
        BEQ bDDA4
        LDX #$FC
        LDA #$01
bDDFE   LDY $D9
        CPY $D1
        BNE bDE14
        LDY $DA
        CPY $D2
        BNE bDE14
        LDY $DB
        CPY $D3
        BNE bDE14
        LDY $DC
        CPY $D4
bDE14   PHP 
        ROL 
        BCC bDE21
        INX 
        STA f98,X
        BEQ bDE4F
        BPL bDE53
        LDA #$01
bDE21   PLP 
        BCS bDE32
jDE24   ASL $DC
        ROL $DB
        ROL $DA
        ROL $D9
        BCS bDE14
        BMI bDDFE
        BPL bDE14
bDE32   TAY 
        LDA $DC
        SBC $D4
        STA $DC
        LDA $DB
        SBC $D3
        STA $DB
        LDA $DA
        SBC $D2
        STA $DA
        LDA $D9
        SBC $D1
        STA $D9
        TYA 
        JMP jDE24

bDE4F   LDA #$40
        BNE bDE21
bDE53   ASL 
        ASL 
        ASL 
        ASL 
        ASL 
        ASL 
        STA $DF
        PLP 
        JMP jDE64

bDE5F   LDX #$85
        JMP jC47E

jDE64   LDA $95
        STA $D1
        LDA $96
        STA $D2
        LDA $97
        STA $D3
        LDA $98
        STA $D4
        JMP Normalise

PI      LDA #<pDC7C
        LDY #>pDC7C
sDE7B   STA $91
        STY $92
        LDY #$04
        LDA (p91),Y
        STA $D4
        DEY 
        LDA (p91),Y
        STA $D3
        DEY 
        LDA (p91),Y
        STA $D2
        DEY 
        LDA (p91),Y
        STA $D5
        ORA #$80
        STA $D1
        DEY 
        LDA (p91),Y
        STA $D0
        STY $DF
        RTS 

sDEA0   LDX #$CB
sDEA3   =*+$01
        BIT $C6A2
        LDY #$00
        BEQ sDEAD
jDEA9   LDX $B8
        LDY $B9
sDEAD   JSR RoundFPA
        STX $91
        STY $92
        LDY #$04
        LDA $D4
        STA (p91),Y
        DEY 
        LDA $D3
        STA (p91),Y
        DEY 
        LDA $D2
        STA (p91),Y
        DEY 
        LDA $D5
        ORA #$7F
        AND $D1
        STA (p91),Y
        DEY 
        LDA $D0
        STA (p91),Y
        STY $DF
        RTS 

sDED5   LDA $DD
sDED7   STA $D5
        LDX #$05
bDEDB   LDA fD7,X
        STA fCF,X
        DEX 
        BNE bDEDB
        STX $DF
        RTS 

sDEE5   JSR RoundFPA
sDEE8   LDX #$06
bDEEA   LDA fCF,X
        STA fD7,X
        DEX 
        BNE bDEEA
        STX $DF
bDEF3   RTS 

RoundFPA LDA $D0
        BEQ bDEF3
        ASL $DF
        BCC bDEF3
sDEFC   JSR sDC2A
        BNE bDEF3
        JMP jDBF3

        JSR sD2A9
        LSR $D4
        BCS TRUE
FALSE   LDA #$00
        BEQ jDF24
TRUE    LDA #$FF
        BMI jDF24
GetSign LDA $D0
        BEQ bDF20
bDF17   LDA $D5
jDF19   ROL 
        LDA #$FF
        BCS bDF20
        LDA #$01
bDF20   RTS 

SGN     JSR GetSign
jDF24   STA $D1
        LDA #$00
        STA $D2
        LDX #$88
jDF2C   LDA $D1
        EOR #$FF
        ROL 
bDF31   LDA #$00
        STA $D4
        STA $D3
        STX $D0
        STA $DF
        STA $D5
        JMP jDB8D

jDF40   STA $D1
        STY $D2
        LDX #$90
        SEC 
        BCS bDF31
        LSR $D5
        RTS 

CompareFPA STA $93
sDF4E   STY $94
        LDY #$00
        LDA (p93),Y
        INY 
        TAX 
        BEQ GetSign
        LDA (p93),Y
        EOR $D5
        BMI bDF17
        CPX $D0
        BNE bDF83
        LDA (p93),Y
        ORA #$80
        CMP $D1
        BNE bDF83
        INY 
        LDA (p93),Y
        CMP $D2
        BNE bDF83
        INY 
        LDA (p93),Y
        CMP $D3
        BNE bDF83
        INY 
        LDA #$7F
        CMP $DF
        LDA (p93),Y
        SBC $D4
        BEQ bDFAB
bDF83   LDA $D5
        BCC bDF89
        EOR #$FF
bDF89   JMP jDF19

FPA2Int LDA $D0
        BEQ bDFDA
        SEC 
        SBC #$A0
        BIT $D5
        BPL bDFA0
        TAX 
        LDA #$FF
        STA $D7
        JSR sDC08
        TXA 
bDFA0   LDX #$D0
        CMP #$F9
        BPL bDFAC
        JSR sDC54
        STY $D7
bDFAB   RTS 

bDFAC   TAY 
        LDA $D5
        AND #$80
        LSR $D1
        ORA $D1
        STA $D1
        JSR sDC6B
        STY $D7
        RTS 

INT     LDA $D0
        CMP #$A0
        BCS bDFE3
        JSR FPA2Int
        STY $DF
        LDA $D5
        STY $D5
        EOR #$80
        ROL 
        LDA #$A0
        STA $D0
        LDA $D4
        STA $24
        JMP jDB8D

bDFDA   STA $D1
        STA $D2
        STA $D3
        STA $D4
        TAY 
bDFE3   RTS 

bDFE4   JMP jE981

GetNumber LDY #$00
        LDX #$0A
bDFEB   STY fCC,X
        DEX 
        BPL bDFEB
        BCC bE005
        CMP #$23
        BEQ bDFE4
        CMP #$2D
        BNE bDFFE
        STX $D6
        BEQ bE002
bDFFE   CMP #$2B
        BNE bE007
bE002   JSR $00E2
bE005   BCC bE062
bE007   CMP #$2E
        BEQ bE039
        CMP #$45
        BNE bE03F
        JSR $00E2
        BCC bE02B
        CMP #$CD
        BEQ bE026
        CMP #$2D
        BEQ bE026
        CMP #$CC
        BEQ bE028
        CMP #$2B
        BEQ bE028
        BNE bE02D
bE026   ROR $CF
bE028   JSR $00E2
bE02B   BCC bE089
bE02D   BIT $CF
        BPL bE03F
        LDA #$00
        SEC 
        SBC $CD
        JMP jE041

bE039   ROR $CE
        BIT $CE
        BVC bE002
bE03F   LDA $CD
jE041   SEC 
        SBC $CC
        STA $CD
        BEQ bE05A
        BPL bE053
bE04A   JSR FPADiv10
        INC $CD
        BNE bE04A
        BEQ bE05A
bE053   JSR FPAMult10
        DEC $CD
        BNE bE053
bE05A   LDA $D6
        BMI bE05F
        RTS 

bE05F   JMP jE271

bE062   PHA 
        BIT $CE
        BPL bE069
        INC $CC
bE069   JSR FPAMult10
        PLA 
        SEC 
        SBC #$30
        JSR AddToFPA
        JMP bE002

AddToFPA PHA 
        JSR sDEE5
        PLA 
        JSR jDF24
        LDA $DD
        EOR $D5
        STA $DE
        LDX $D0
        JMP jDB25

bE089   LDA $CD
        CMP #$0A
        BCC bE098
        LDA #$64
        BIT $CF
        BMI bE0A6
        JMP bDC39

bE098   ASL 
        ASL 
        CLC 
        ADC $CD
        ASL 
        CLC 
        LDY #$00
        ADC (pE9),Y
        SEC 
        SBC #$30
bE0A6   STA $CD
        JMP bE028

        BYT  $9B,$3E,$BC,$1F,$FD,$9E,$6E,$6B
        BYT  $27,$FD,$9E,$6E,$6B,$28,$00
sE0BA   LDA #$AD
        LDY #$C3
        JSR sE0D2
        LDA $A9
        LDX $A8
PrintInt STA $D1
        STX $D2
        LDX #$90
        SEC 
        JSR bDF31
        JSR sE0D5
sE0D2   JMP PrintString

sE0D5   LDY #$01
sE0D7   LDA #$20
        BIT $D5
        BPL bE0DF
        LDA #$2D
bE0DF   STA f00FF,Y
        STA $D5
        STY $E0
        INY 
        LDA #$30
        LDX $D0
        BNE bE0F0
        JMP jE1F8

bE0F0   LDA #$00
        CPX #$80
        BEQ bE0F8
        BCS bE101
bE0F8   LDA #$B5
        LDY #$E0
        JSR sDCED
        LDA #$F7
bE101   STA $CC
bE103   LDA #$B0
        LDY #$E0
        JSR CompareFPA
        BEQ bE12A
        BPL bE120
bE10E   LDA #$AB
        LDY #$E0
        JSR CompareFPA
        BEQ bE119
        BPL bE127
bE119   JSR FPAMult10
        DEC $CC
        BNE bE10E
bE120   JSR FPADiv10
        INC $CC
        BNE bE103
bE127   JSR sDB04
bE12A   JSR FPA2Int
        LDX #$01
        LDA $CC
        CLC 
        ADC #$0A
        BMI bE13F
        CMP #$0B
        BCS bE140
        ADC #$FF
        TAX 
        LDA #$02
bE13F   SEC 
bE140   SBC #$02
        STA $CD
        STX $CC
        TXA 
        BEQ bE14B
        BPL bE15E
bE14B   LDY $E0
        LDA #$2E
        INY 
        STA f00FF,Y
        TXA 
        BEQ bE15C
        LDA #$30
        INY 
        STA f00FF,Y
bE15C   STY $E0
bE15E   LDY #$00
        LDX #$80
bE162   LDA $D4
        CLC 
        ADC fE20D,Y
        STA $D4
        LDA $D3
        ADC fE20C,Y
        STA $D3
        LDA $D2
        ADC fE20B,Y
        STA $D2
        LDA $D1
        ADC fE20A,Y
        STA $D1
        INX 
        BCS bE186
        BPL bE162
        BMI bE188
bE186   BMI bE162
bE188   TXA 
        BCC bE18F
        EOR #$FF
        ADC #$0A
bE18F   ADC #$2F
        INY 
        INY 
        INY 
        INY 
        STY $B6
        LDY $E0
        INY 
        TAX 
        AND #$7F
        STA f00FF,Y
        DEC $CC
        BNE bE1AA
        LDA #$2E
        INY 
        STA f00FF,Y
bE1AA   STY $E0
        LDY $B6
        TXA 
        EOR #$FF
        AND #$80
        TAX 
        CPY #$24
        BNE bE162
        LDY $E0
bE1BA   LDA f00FF,Y
        DEY 
        CMP #$30
        BEQ bE1BA
        CMP #$2E
        BEQ bE1C7
        INY 
bE1C7   LDA #$2B
        LDX $CD
        BEQ bE1FB
        BPL bE1D7
        LDA #$00
        SEC 
        SBC $CD
        TAX 
        LDA #$2D
bE1D7   STA f0101,Y
        LDA #$45
        STA f0100,Y
        TXA 
        LDX #$2F
        SEC 
bE1E3   INX 
        SBC #$0A
        BCS bE1E3
        ADC #$3A
        STA f0103,Y
        TXA 
        STA f0102,Y
        LDA #$00
        STA f0104,Y
        BEQ bE200
jE1F8   STA f00FF,Y
bE1FB   LDA #$00
        STA f0100,Y
bE200   LDA #$00
        LDY #$01
        RTS 

        BYT  $80,$00,$00,$00,$00
fE20A   BYT  $FA
fE20B   BYT  $0A
fE20C   BYT  $1F
fE20D   BYT  $00,$00,$98,$96,$80,$FF,$F0,$BD
        BYT  $C0,$00,$01,$86,$A0,$FF,$FF,$D8
        BYT  $F0,$00,$00,$03,$E8,$FF,$FF,$FF
        BYT  $9C,$00,$00,$00,$0A
EXP     BYT  $FF,$FF,$FF,$FF
SQR     JSR sDEE5
        LDA #$05
        LDY #$E2
        JSR sDE7B
        BEQ bE2AA
        LDA $D8
        BNE bE241
        JMP jDBB4

bE241   LDX #$BD
        LDY #$00
        JSR sDEAD
        LDA $DD
        BPL bE25B
        JSR INT
        LDA #$BD
        LDY #$00
        JSR CompareFPA
        BNE bE25B
        TYA 
        LDY $24
bE25B   JSR sDED7
        TYA 
        PHA 
        JSR LN
        LDA #$BD
        LDY #$00
        JSR sDCED
        JSR bE2AA
        PLA 
        LSR 
        BCC bE27B
jE271   LDA $D0
        BEQ bE27B
        LDA $D5
        EOR #$FF
        STA $D5
bE27B   RTS 

ExpData BYT  $81,$38,$AA,$3B,$29,$07,$71,$34
        BYT  $58,$3E,$56,$74,$16,$7E,$B3,$1B
        BYT  $77,$2F,$EE,$E3,$85,$7A,$1D,$84
        BYT  $1C,$2A,$7C,$63,$59,$58,$0A,$7E
        BYT  $75,$FD,$E7,$C6,$80,$31,$72,$18
        BYT  $10,$81,$00,$00,$00,$00
bE2AA   LDA #$7C
        LDY #$E2
        JSR sDCED
        LDA $DF
        ADC #$50
        BCC bE2BA
        JSR sDEFC
bE2BA   STA $C5
        JSR sDEE8
        LDA $D0
        CMP #$88
        BCC bE2C8
bE2C5   JSR sDD99
bE2C8   JSR INT
        LDA $24
        CLC 
        ADC #$81
        BEQ bE2C5
        SEC 
        SBC #$01
        PHA 
        LDX #$05
bE2D8   LDA fD8,X
        LDY fD0,X
        STA fD0,X
        STY fD8,X
        DEX 
        BPL bE2D8
        LDA $C5
        STA $DF
        JSR sDB0E
        JSR jE271
        LDA #$81
        LDY #$E2
        JSR SeriesEval
        LDA #$00
        STA $DE
        PLA 
        JSR sDD7E
        RTS 

sE2FD   STA $E0
        STY $E1
        JSR sDEA3
        LDA #$C6
        JSR sDCED
        JSR sE317
        LDA #$C6
        LDY #$00
        JMP sDCED

SeriesEval STA $E0
        STY $E1
sE317   JSR sDEA0
        LDA (pE0),Y
        STA $D6
        LDY $E0
        INY 
        TYA 
        BNE bE326
        INC $E1
bE326   STA $E0
        LDY $E1
bE32A   JSR sDCED
        LDA $E0
        LDY $E1
        CLC 
        ADC #$05
        BCC bE337
        INY 
bE337   STA $E0
        STY $E1
        JSR sDB22
        LDA #$CB
        LDY #$00
        DEC $D6
        BNE bE32A
bE346   RTS 

        TYA 
        AND f44,X
        BYT  $7A
        PLA 
        PLP 
        LDA (p46),Y
RND     JSR GetSign
        TAX 
        BMI bE36D
        LDA #$FA
        LDY #$00
        JSR sDE7B
        TXA 
        BEQ bE346
        LDA #$47
        LDY #$E3
        JSR sDCED
        LDA #$4B
        LDY #$E3
        JSR sDB22
bE36D   LDX $D4
        LDA $D1
        STA $D4
        STX $D1
        LDA #$00
        STA $D5
        LDA $D0
        STA $DF
        LDA #$80
        STA $D0
        JSR Normalise
        LDX #$FA
        LDY #$00
sE388   JMP sDEAD

COS     LDA #$07
        LDY #$E4
        JSR sDB22
SIN     JSR sDEE5
        LDA #$0C
        LDY #$E4
        LDX $DD
        JSR sDDCC
        JSR sDEE5
        JSR INT
        LDA #$00
        STA $DE
        JSR sDB0E
        LDA #$11
        LDY #$E4
        JSR sDB0B
        LDA $D5
        PHA 
        BPL bE3C4
        JSR sDB04
        LDA $D5
        BMI bE3C7
        LDA $2D
        EOR #$FF
        STA $2D
bE3C4   JSR jE271
bE3C7   LDA #$11
        LDY #$E4
        JSR sDB22
        PLA 
        BPL bE3D4
        JSR jE271
bE3D4   LDA #$16
        LDY #$E4
        JMP sE2FD

        JSR sDEA3
        LDA #$00
        STA $2D
        JSR SIN
        LDX #$BD
        LDY #$00
        JSR sE388
        LDA #$C6
        LDY #$00
        JSR sDE7B
        LDA #$00
        STA $D5
        LDA $2D
        JSR sE403
        LDA #$BD
        LDY #$00
        JMP sDDE4

sE403   PHA 
        JMP bE3C4

TrigData BYT  $81,$49,$0F,$DA,$A2,$83,$49,$0F
        BYT  $DA,$A2,$7F,$00,$00,$00,$00,$05
        BYT  $84,$E6,$1A,$2D,$1B,$86,$28,$07
        BYT  $FB,$F8,$87,$99,$68,$89,$01,$87
        BYT  $23,$35,$DF,$E1,$86,$A5,$5D,$E7
        BYT  $28,$83,$49,$0F,$DA,$A2,$A1,$54
        BYT  $46,$8F,$13,$8F,$52,$43,$89,$CD
ATN     LDA $D5
        PHA 
        BPL bE447
        JSR jE271
bE447   LDA $D0
        PHA 
        CMP #$81
        BCC bE455
        LDA #$81
        LDY #$DC
        JSR sDDE4
bE455   LDA #$6F
        LDY #$E4
        JSR sE2FD
        PLA 
        CMP #$81
        BCC bE468
        LDA #$07
        LDY #$E4
        JSR sDB0B
bE468   PLA 
        BPL bE46E
        JMP jE271

bE46E   RTS 

ATNData BYT  $0B,$76,$B3,$83,$BD,$D3,$79,$1E
        BYT  $F4,$A6,$F5,$7B,$83,$FC,$B0,$10
        BYT  $7C,$0C,$1F,$67,$CA,$7C,$DE,$53
        BYT  $CB,$C1,$7D,$14,$64,$70,$4C,$7D
        BYT  $B7,$EA,$51,$7A,$7D,$63,$30,$88
        BYT  $7E,$7E,$92,$44,$99,$3A,$7E,$4C
        BYT  $CC,$91,$C7,$7F,$AA,$AA,$AA,$13
        BYT  $81,$00,$00,$00,$00


TapeSync JSR SyncTape
bE4AF   JSR GetTapeByte
        CMP #$24
        BNE bE4AF
        STX $02B1
        LDX #$09
bE4BB   JSR GetTapeByte
        STA f02A7,X
        DEX 
        BNE bE4BB
bE4C4   JSR GetTapeByte
        BEQ bE4D3
        CPX #$10
        BCS bE4C4
        STA f0293,X
        INX 
        BNE bE4C4
bE4D3   STA f0293,X
        JSR PrintFound
        JSR sE790
        TXA 
        BNE TapeSync
        RTS 

GetTapeData LDA $02A9
        LDY $02AA
        STA $33
        STY $34
        LDY #$00
bE4EC   JSR GetTapeByte
        LDX $025B
VERIFY  BNE bE4F9
        STA (p33),Y
        JMP jE505

bE4F9   CMP (p33),Y
        BEQ jE505
        INC $025C
        BNE jE505
        INC $025D
jE505   JSR IncTapeCount
        BCC bE4EC
        RTS 

        BYT  $10,$07,$53,$65,$61,$72,$63,$68
        BYT  $69,$6E,$67,$20,$2E,$2E,$00,$10
        BYT  $07,$4C,$6F,$61,$64,$69,$6E,$67
        BYT  $20,$2E,$2E,$00,$0A,$0D,$45,$72
        BYT  $72,$6F,$72,$73,$20,$66,$6F,$75
        BYT  $6E,$64,$0D,$0A,$00,$10,$07,$46
        BYT  $6F,$75,$6E,$64,$20,$2E,$2E,$00
        BYT  $10,$07,$56,$65,$72,$69,$66,$79
        BYT  $69,$6E,$67,$20,$2E,$2E,$00,$20
        BYT  $56,$65,$72,$69,$66,$79,$20,$65
        BYT  $72,$72,$6F,$72,$73,$20,$64,$65
        BYT  $74,$65,$63,$74,$65,$64,$0D,$0A
        BYT  $00
IncTapeCount LDA $33
        CMP $02AB
        LDA $34
        SBC $02AC
        INC $33
        BNE bE57C
        INC $34
bE57C   RTS 

PrintSearching LDA #$0B
        LDY #$E5
        JSR ClrStatus
        RTS 

PrintSaving LDA #$45
        LDY #$E6
        JSR ClrStatus
PrintFName LDA #$7F
        LDY #$02
        JSR PrintMsg
        RTS 

PrintFound LDA #$38
        LDY #$E5
        JMP PrintVerifying

sE59B   LDA $025B
        BNE bE5A7
        LDA #$1A
aE5A2   LDY #$E5
PrintLoading JMP PrintVerifying

bE5A7   LDA #$43
        LDY #$E5
PrintVerifying JSR ClrStatus
        LDA #$93
        LDY #$02
        JSR PrintMsg
        RTS 

PrintMsg JSR PrintStatus
        INX 
        LDY #$00
        STY $025F
        LDA $02AE
        BEQ bE5D7
        INY 
        BIT $02AE
        BMI bE5D7
        INY 
        BIT $02AF
        BMI bE5D7
        INY 
        BIT $02B0
        BMI bE5D7
        INY 
bE5D7   LDA fE5E5,Y
        STA $025E
        LDA #$5E
        LDY #$02
        JSR PrintStatus
        RTS 

fE5E5   BYT  $42,$43,$53,$49,$52
ClrStatus JSR ClrTapeStatus
        LDX #$00
        JSR PrintStatus
        INX 
        INX 
        RTS 

ClrTapeStatus PHA 
        LDA $021F
        BNE bE605
        LDX #$22
        LDA #$10
bE5FF   STA fBB80,X
        DEX 
        BPL bE5FF
bE605   PLA 
        RTS 

WriteFileHeader JSR WriteLeader
        LDA #$24
        JSR PutTapeByte
        LDX #$09
bE611   LDA f02A7,X
        JSR PutTapeByte
        DEX 
        BNE bE611
bE61A   LDA f027F,X
        BEQ bE625
        JSR PutTapeByte
        INX 
        BNE bE61A
bE625   JSR PutTapeByte
        LDX #$00
bE62A   DEX 
        BNE bE62A
        RTS 

sE62E   LDA $02A9
        LDY $02AA
        STA $33
        STY $34
        LDY #$00
bE63A   LDA (p33),Y
        JSR PutTapeByte
        JSR IncTapeCount
        BCC bE63A
        RTS 

        BYT  $10,$07,$53,$61,$76,$69,$6E,$67
        BYT  $20,$2E,$2E,$00
sE651   LDA $02B1
        BEQ bE65D
        LDA #$27
        LDY #$E5
        JSR PrintString
bE65D   RTS 

PutTapeByte STA $2F
        TXA 
        PHA 
        TYA 
        PHA 
        JSR sE6C0
        CLC 
        LDY #$09
        LDA #$00
        BEQ bE674
bE66E   LSR $2F
        PHP 
        ADC #$00
        PLP 
bE674   JSR sE68B
        DEY 
        BNE bE66E
        EOR #$01
        LSR 
        LDY #$04
bE67F   JSR sE68B
        SEC 
        DEY 
        BNE bE67F
        PLA 
        TAY 
        PLA 
        TAX 
        RTS 

sE68B   PHA 
        PHP 
        LDA $024D
        BNE bE69C
        SEC 
        JSR sE6B2
        PLP 
        JSR sE6B2
        PLA 
        RTS 

bE69C   JSR sE6B2
        LDX #$0F
        PLP 
        BCS bE6A6
        LDX #$07
bE6A6   JSR sE6AB
        PLA 
        RTS 

sE6AB   JSR sE6C0
        DEX 
        BNE sE6AB
        RTS 

sE6B2   LDA #$D0
        LDX #$00
        BCS bE6BA
        ASL 
        INX 
bE6BA   STA $0306
        STX $0307
sE6C0   LDA $0304
bE6C3   BIT $030D
        BVC bE6C3
        RTS 

GetTapeByte TYA 
        PHA 
        TXA 
        PHA 
        JSR sE71C
bE6D0   JSR sE71C
        BCS bE6D0
        JSR sE6FF
        BCS bE6F0
        LDA #$00
        LDY #$08
bE6DE   JSR sE6FC
        PHP 
        ROR $2F
        PLP 
        ADC #$00
        DEY 
        BNE bE6DE
        JSR sE6FC
        SBC #$00
        LSR 
bE6F0   BCC bE6F5
        ROL $02B1
bE6F5   PLA 
        TAX 
        PLA 
        TAY 
        LDA $2F
        RTS 

sE6FC   JSR sE71C
sE6FF   PHA 
        LDA $024D
        BEQ bE71A
        JSR sE71C
        LDX #$02
        BCC bE70E
        LDX #$06
bE70E   LDA #$00
bE710   JSR sE71C
        ADC #$00
        DEX 
        BNE bE710
        CMP #$04
bE71A   PLA 
        RTS 

sE71C   PHA 
        LDA $0300
bE720   LDA $030D
        AND #$10
        BEQ bE720
        LDA $0309
        PHA 
        LDA #$FF
        STA $0309
        PLA 
        CMP #$FE
        PLA 
        RTS 

SyncTape JSR sE6FC
        ROR $2F
        LDA #$16
        CMP $2F
        BNE SyncTape
        LDA $024D
        BEQ bE74D
        JSR sE71C
bE748   JSR sE71C
        BCS bE748
bE74D   LDX #$03
bE74F   JSR GetTapeByte
        CMP #$16
        BNE SyncTape
        DEX 
        BNE bE74F
        RTS 

WriteLeader LDX #$02
        LDY #$03
bE75E   LDA #$16
        JSR PutTapeByte
        DEY 
        BNE bE75E
        DEX 
        BNE bE75E
        RTS 

SetupTape JSR StopTimer
        LDY #$06
        SEI 
bE770   LDX fE782,Y
        LDA fE789,Y
        STA $0300,X
        DEY 
        BPL bE770
; ==================================
#ifndef ORICEXOS
; ==================================
        LDA #$40
#else
        LDA #$60  ; PB5 patch
#endif
        STA $0300
        RTS 

; ==================================
#ifndef ORICEXOS
; ==================================
fE782   BYT  $05,$04,$0B,$02,$0C,$08,$0E
fE789   BYT  $00,$D0,$C0,$FF,$10,$F4,$7F
#else
fE782   BYT  $05,$04,$0B,$02,$0C,$08,$0E
fE789   BYT  $00,$D0,$C0,$F7,$10,$F4,$7F
#endif

sE790   LDY #$00
        LDX #$00
        LDA f027F
        BEQ bE7AE
bE799   LDA f027F,Y
        CMP f0293,Y
        BEQ bE7A2
        INX 
bE7A2   STA f0293,Y
        INY 
        CPY #$11
        BCS bE7AE
        PHA 
        PLA 
        BNE bE799
bE7AE   RTS 

bE7AF   JMP jD070

GetTapeParams LDA #$00
        STA $024D
        STA $02AD
        STA $02AE
        STA $025B
        STA $025A
        STA $025C
        STA $025D
        STA $02B1
        JSR EvalExpr
        BIT $28
        BPL bE7AF
        JSR sD7D0
        TAX 
        LDY #$00
        INX 
bE7DA   DEX 
        BEQ bE7E7
        LDA (p91),Y
        STA f027F,Y
        INY 
        CPY #$10
        BNE bE7DA
bE7E7   LDA #$00
        STA f027F,Y
bE7EC   JSR $00E8
        BEQ bE852
        CMP #$2C
        BNE bE7AF
bE7F5   JSR $00E2
        BEQ bE852
        CMP #$2C
        BEQ bE7F5
        CMP #$C7
        BNE bE807
        STA $02AD
        BCS bE7F5
bE807   CMP #$53
        BNE bE810
        STA $024D
        BCS bE7F5
bE810   CMP #$56
        BNE bE819
        STA $025B
        BCS bE7F5
bE819   CMP #$4A
        BNE bE822
        STA $025A
        BCS bE7F5
bE822   CMP #$41
        BEQ bE82A
        CMP #$45
        BNE bE871
bE82A   STA $0E
        JSR $00E2
        LDX #$80
        STX $02AE
        JSR sE853
        LDA $33
        LDY $34
        LDX $0E
        CPX #$41
        BNE bE849
        STA $02A9
        STY $02AA
        BCS bE7EC
bE849   STA $02AB
        STY $02AC
        JMP bE7EC

bE852   RTS 

sE853   JSR GetExpr
        JSR FP2Int
        CLC 
        RTS 

CLOAD   PHP 
        JSR GetTapeParams
        LDA $02AD
        ORA $02AE
        BNE bE871
        LDA $025A
        BEQ bE874
        LDA $025B
        BEQ bE874
bE871   JMP jD070

bE874   JSR SetupTape
        JSR PrintSearching
bE87A   JSR TapeSync
        BIT $02AE
        BVS bE87A
        LDA $025A
        BEQ bE8B3
        LDA $02AE
        BNE bE87A
        LDA $9C
        LDY $9D
        SEC 
        SBC #$02
        BCS bE896
        DEY 
bE896   STA $02A9
        STY $02AA
        SEC 
        SBC $9A
        TAX 
        TYA 
        SBC $9B
        TAY 
        CLC 
        TXA 
        ADC $02AB
        STA $02AB
        TYA 
        ADC $02AC
        STA $02AC
bE8B3   JSR sE59B
        JSR GetTapeData
        JSR sE93D
        PLP 
        LDA $025B
        BEQ bE8D3
        LDX $025C
        LDA $025D
        JSR PrintInt
        LDA #$52
        LDY #$E5
        JSR PrintString
        RTS 

bE8D3   JSR sE651
        LDA $02AE
        BEQ bE8E9
        LDA $02AD
        BEQ bE8E8
        LDA $02B1
        NOP 
        NOP 
        JMP (a02A9)

bE8E8   RTS 

bE8E9   LDX $02AB
        LDA $02AC
        STX $9C
        STA $9D
        JSR SetLineLinkPtrs
        LDA $02AD
        BEQ bE903
        LDA $02B1
        NOP 
        NOP 
        JMP sC708

bE903   JSR sC708
        JMP BackToBASIC

CSAVE   LDA $9A
        LDY $9B
        STA $02A9
        STY $02AA
        LDA $9C
        LDY $9D
        STA $02AB
        STY $02AC
        PHP 
        JSR GetTapeParams
        LDA $025A
        ORA $025B
        BEQ bE92C
        JMP jD070

bE92C   JSR SetupTape
        JSR PrintSaving
        JSR WriteFileHeader
        JSR sE62E
        JSR sE93D
        PLP 
        RTS 

sE93D   JSR ClrTapeStatus
        JSR ResetVIA
        JMP SetupTimer

CALL    JSR sE853
        JMP (f0033)

sE94C   LDX #$00
        STX $0C
        STX $0D
        BEQ bE967
bE954   LDX #$03
        ASL 
        ASL 
        ASL 
        ASL 
bE95A   ASL 
        ROL $0C
        ROL $0D
        BCC bE964
        JMP bDC39

bE964   DEX 
        BPL bE95A
bE967   JSR $00E2
        CMP #$80
        BCS bE97C
        ORA #$80
        EOR #$B0
        CMP #$0A
        BCC bE954
        ADC #$88
        CMP #$FA
        BCS bE954
bE97C   LDA $0D
        LDY $0C
        RTS 

jE981   JSR sE94C
        JMP jDF40

; ==================================
#ifndef ORICEXOS
; ==================================
; E987
STORE   PHP 
        JSR sEA57
        LDA #$40
        STA $02AE
        LDA $28
        STA $02AF
        LDA $29
        STA $02B0
        JSR PrintSaving
        JSR WriteFileHeader
        JSR sEA9E
        JSR sE62E
        BIT $28
        BPL bE9CC
bE9AA   LDY #$00
        LDA (p0C),Y
        BEQ bE9C7
        TAX 
        LDY #$02
bE9B3   LDA (p0C),Y
        STA pD0,Y
        DEY 
        BNE bE9B3
        INX 
bE9BC   DEX 
        BEQ bE9C7
        LDA (pD1),Y
        JSR PutTapeByte
        INY 
        BNE bE9BC
bE9C7   JSR sEA42
        BCC bE9AA
bE9CC   JSR sE93D
        PLP 
        RTS 

RECALL  JSR GarbageCollect
        PHP 
        JSR sEA57
        JSR PrintSearching
bE9DB   JSR TapeSync
        BIT $02AE
        BVC bE9DB
        LDA $02AF
        EOR $28
        BNE bE9DB
        LDA $02B0
        EOR $29
        BNE bE9DB
        JSR sE59B
        LDY #$02
        LDA (pCE),Y
        CMP $02A9
        INY 
        LDA (pCE),Y
        SBC $02AA
        BCS bEA09
        JSR sE93D
        JMP PrintError

bEA09   JSR sEA9E
        JSR GetTapeData
        BIT $28
        BPL bEA3A
bEA13   LDY #$00
        LDA (p0C),Y
        BEQ bEA35
        JSR sD5AB
        LDY #$00
        TAX 
        INX 
bEA20   DEX 
        BEQ bEA2B
        JSR GetTapeByte
        STA (pD1),Y
        INY 
        BNE bEA20
bEA2B   LDY #$02
bEA2D   LDA pD0,Y
        STA (p0C),Y
        DEY 
        BNE bEA2D
bEA35   JSR sEA42
        BCC bEA13
bEA3A   JSR sE93D
        JSR sE651
        PLP 
        RTS 

sEA42   CLC 
        LDA #$03
        ADC $0C
        STA $0C
        BCC bEA4D
        INC $0D
bEA4D   TAY 
        LDA $0D
        CPY $02AB
        SBC $02AC
        RTS 

sEA57   LDA #$40
        STA $2B
        JSR GetVarFromText
        LDA #$00
aEA60   STA $2B
        LDY #$03
        LDA (pCE),Y
        STA $02AA
        DEY 
        LDA (pCE),Y
        STA $02A9
        BNE bEA74
        DEC $02AA
bEA74   DEC $02A9
        JSR sD065
        LDA $29
        PHA 
        LDA $28
        PHA 
        JSR GetTapeParams
        PLA 
        STA $28
        PLA 
        STA $29
        LDA $025B
        ORA $02AD
        ORA $02AE
        ORA $025A
        BEQ bEA9A
        JMP jD070

bEA9A   JSR SetupTape
        RTS 

sEA9E   CLC 
        LDA $CE
        ADC $02A9
        STA $02AB
        LDA $CF
        ADC $02AA
        STA $02AC
        LDY #$04
        LDA (pCE),Y
        JSR sD288
        STA $02A9
        STY $02AA
        STA $0C
        STY $0D
        RTS 
; ==================================
#else
; ---------------------------------
; ORICEXOS
; ---------------------------------
; parallel port receiver
; for integration in slave ROMs
; ---------------------------------
; addr : mem | ppbuf | ppdir | mix
; ---------------------------------
; $380 : rom |  off  |  out  |  A
; $381 : ram |  off  |  out  |  A
; $382 : rom |  on   |  out  |  A
; $383 : ram |  on   |  out  |  A
; $384 : rom |  off  |  in   |  A
; $385 : ram |  off  |  in   |  A
; $386 : rom |  on   |  in   |  A
; $387 : ram |  on   |  in   |  A
; $388 : rom |  off  |  out  |  B
; $389 : ram |  off  |  out  |  B
; $38A : rom |  on   |  out  |  B
; $38B : ram |  on   |  out  |  B
; $38C : rom |  off  |  in   |  B
; $38D : ram |  off  |  in   |  B
; $38E : rom |  on   |  in   |  B
; $38F : ram |  on   |  in   |  B
; ---------------------------------

; ---------------------------------
#define via_b         $0300
#define via_a         $0301
#define via_ddrb      $0302
#define via_ddra      $0303
#define via_t1cl      $0304
#define via_t1ch      $0305
#define via_t1ll      $0306
#define via_t1lh      $0307
#define via_t2ll      $0308
#define via_t2lh      $0309
#define via_t2cl      $0308
#define via_t2ch      $0309
#define via_sr        $030a
#define via_acr       $030b
#define via_pcr       $030c
#define via_ifr       $030d
#define via_ier       $030e
#define via_aor       $030f

#define via_bit_ca2   0
#define via_irq_ca2   (1<<via_bit_ca2)

#define via_bit_ca1   1
#define via_irq_ca1   (1<<via_bit_ca1)
#define via_ca1_rise  %00000001
#define via_ca1_fall  ($ff ^ via_ca1_rise)

#define via_bit_sr    2
#define via_irq_sr    (1<<via_bit_sr)

#define via_bit_cb2   3
#define via_irq_cb2   (1<<via_bit_cb2)

#define via_bit_cb1   4
#define via_irq_cb1   (1<<via_bit_cb1)
#define via_cb1_rise  %00010000
#define via_cb1_fall  ($ff ^ via_cb1_rise)

#define via_bit_t2    5
#define via_irq_t2    (1<<via_bit_t2)
#define via_mask_t2   ($7f ^ via_irq_t2)

#define via_bit_t1    6
#define via_irq_t1    (1<<via_bit_t1)
#define via_mask_t1   ($7f ^ via_irq_t1)

; =================================
zpp     =     0
zptr    =     zpp+0
zcmd    =     zpp+2
zflg    =     zpp+3
zdst    =     zpp+4
zsiz    =     zpp+6
zsrc    =     zpp+8

; ---------------------------------
; the value at address $EDB0
; is ID of every slave oric
; PEEK(#EDB0) AND 3

; ---------------------------------
#define r_via_reset   $e93d

; =================================
PPLOAD
        sei
        cld
; ---------------------------------
        sta   $380          ; $380 : rom|off|out|A
        jsr   setup_slave
; ---------------------------------
reload
        ; setup id mask
        lda   id_addr
        and   #%00000011
        tax
        lda   id_mask,x
        sta   zsrc

        sta   $386          ; $386 : rom|on |in |A
        
;       jsr   PrintSearching
        lda   #<exos_logo
        ldy   #>exos_logo
        jsr   ClrStatus

        jsr   receive
        sta   $384          ; $384 : rom|off|in |A

        ; not for this slave
        lda   zsrc
        beq   reload
        ; not autoexec
        lda   zflg
        beq   reload
; ---------------------------------
        jmp   (zptr)

; ---------------------------------
id_mask 
        byt   $00,$01,$02,$04
        
exos_logo
        byt   "RGB OricExos 123 BGR",0

; ---------------------------------
setup_slave
        ; disable via irq
        lda   #%01111111
        sta   via_ier
        sta   via_ifr

        ; set ca1 active neg edge
        lda   #%11011100
        sta   via_pcr

        ; disable port b latch
        ; enable port a latch
        lda   #%01000001
        sta   via_acr

        ; set pb4(stb) to 0
        lda   via_b
        and   #%11101111
        sta   via_b

        ; set pb4 as output
        lda   via_ddrb
        ora   #%00010000
        sta   via_ddrb

        ; set port a as input
        lda   #%00000000
        sta   via_ddra
        sta   via_a

        rts

; ---------------------------------
receive
        lda   #<zcmd
        sta   zptr
        lda   #>zcmd
        sta   zptr+1

        ; clear pendig interrupt
        lda   via_a

        ; receive synchro
rx_55
        jsr   receive_byte
        cmp   #$55
        bne   rx_55
rx_AA
        jsr   receive_byte
        cmp   #$55
        beq   rx_AA
        cmp   #$aa
        bne   rx_55
        
        ; receive 6 bytes header
        ldy   #$00
rx_hdr
        jsr   receive_byte
        sta   (zptr),y
        iny
        cpy   #$06
        bne   rx_hdr

        lda   zsrc
        and   zflg
        sta   zsrc

        lda   zflg
        and   #$80
        sta   zflg
        
        lda   zdst
        sta   zptr
        lda   zdst+1
        sta   zptr+1
        
        ; receive content
        ldy   #$00
rx_cont
        jsr   receive_byte
        ldx   zsrc
        beq   rxs_1
        
        sta   (zdst),y
        inc   zdst
        bne   rxs_1
        inc   zdst+1
rxs_1
        dec   zsiz
        bne   rx_cont
        lda   zsiz+1
        beq   rxs_2
        dec   zsiz+1
        jmp   rx_cont
rxs_2
        rts

;--------------------------
receive_byte
        lda   #via_irq_ca1
lp_igb
        bit   via_ifr
        beq   lp_igb
        
        lda   via_a
        pha

        ; the tricky part
        ; set PB4 as input
        ; which sets line to 1
        lda   #%11101111
        and   via_ddrb
        sta   via_ddrb

        ; wait other slaves
        ; to do the same
lp_igbw
        lda   via_b
        and   #%00010000
        beq   lp_igbw

        ; set PB4 as output
        ; which sets line to 0
        ; optimized - lda   #%00010000
        ora   via_ddrb
        sta   via_ddrb

        pla
        rts
; ----------------------------------
        dsb  $eac1-*,$ea
; ==================================
#endif 
; ==================================

fEAC1   BYT  $3F
fEAC2   BYT  $FB,$17,$FC,$CF,$FB,$C7,$F0,$FC
        BYT  $F0,$0F,$F1,$7E,$F3,$1C,$F1,$67
        BYT  $F2,$2C,$F1,$03,$F2,$0F,$F2
fEAD9   BYT  $03,$04,$04,$03,$03,$03,$02,$01
        BYT  $03,$03,$01,$01
fEAE5   BYT  $00,$00,$00,$00,$01,$01,$00,$00
        BYT  $00,$00,$00
HiresTest LDA $02C0
        AND #$01
        BNE bEAFC
jEAF7   LDX #$A3
        JMP jC47E

bEAFC   CPY #$4E
        BCS bEB03
bEB00   JMP jD070

bEB03   CPY #$66
        BCS bEB00
        TYA 
        SEC 
        SBC #$4E
        TAY 
        LDA fEAC2,Y
        PHA 
        LDA fEAC1,Y
        PHA 
        TYA 
        LSR 
        TAY 
        LDA fEAD9,Y
        PHA 
        LDA fEAE5,Y
        STA $02C3
        LDA #$00
        STA $02F0
jEB26   JSR GetExpr
        LDA $02C3
        BNE bEB34
        JSR FP2Int
        JMP jEB3B

bEB34   LDA $D0
        CMP #$90
        JSR sD92A
jEB3B   LDY $02F0
        LDA $33
        STA f02E1,Y
        LDA $34
        STA f02E2,Y
        INY 
        INY 
        STY $02F0
        PLA 
        TAY 
        DEY 
        BEQ bEB5A
        TYA 
        PHA 
        JSR sD065
        JMP jEB26

bEB5A   LDA #$00
        STA $02E0
        PLA 
        TAX 
        PLA 
        TAY 
        LDA #$EB
        PHA 
        LDA #$6D
        PHA 
        TYA 
        PHA 
        TXA 
        PHA 
bEB6D   RTS 

        LDA #$01
        BIT $02E0
        BEQ bEB6D
        JMP jD336

CheckKbd LDA $02DF
        BPL bEB88
        PHP 
        AND #$7F
        PHA 
        LDA #$00
        STA $02DF
        PLA 
        PLP 
bEB88   RTS 

sEB89   CPY $9D
        BCS bEB8F
bEB8D   SEC 
bEB8E   RTS 

bEB8F   BNE bEB97
        CMP $9C
        BCC bEB8E
        BEQ bEB8E
bEB97   JSR sEBB5
        BCC bEB8E
        TAX 
        LDA $02C0
        AND #$02
        PHP 
        TXA 
        PLP 
        BNE bEB8D
        TYA 
        PHA 
        SEC 
        SBC #$1C
        TAY 
        TXA 
        JSR sEBB5
        PLA 
        TAY 
        TXA 
        RTS 

sEBB5   CPY $02C2
        BCC bEBBC
        BEQ bEBBD
bEBBC   RTS 

bEBBD   CMP $02C1
        RTS 

sEBC1   LDY $02C2
        LDA $02C1
        BNE bEBCA
        DEY 
bEBCA   SEC 
        SBC #$01
        RTS 

HIMEM   JSR GetExpr
        JSR FP2Int
        LDA $33
        LDY $34
        JSR sEB89
        BCC bEBE0
bEBDD   JMP PrintError

bEBE0   STA $A6
        STY $A7
        JMP sC70F

        LDA $0260
        BNE bEBDD
        LDA $02C0
        PHA 
        AND #$01
        BEQ bEBF9
bEBF4   LDX #$A3
        JMP jC47E

bEBF9   PLA 
        AND #$FD
        STA $02C0
        JSR sEBC1
        PHA 
        TYA 
        CLC 
        ADC #$1C
        TAY 
        PLA 
        JMP bEBE0

RELEASE JSR sEBC1
        JSR sEB89
        BCS bEBDD
        PHA 
        LDA $02C0
        ORA #$02
        STA $02C0
        PLA 
        JMP bEBE0

TEXT    LDA $02C0
        TAY 
        AND #$01
        BEQ bEC32
        TYA 
        AND #$FE
        STA $02C0
        JSR LoresMode
bEC32   RTS 

HIRES   LDA $02C0
        PHA 
        AND #$02
        BEQ bEBF4
        PLA 
        ORA #$01
        STA $02C0
        JSR HiresMode
        RTS 

POINT   JSR sD062
        JSR EvalExpr
        LDA $34
        PHA 
        LDA $33
        PHA 
        JSR FP2Int
        LDA $33
        STA f02E1
        LDA $34
        STA f02E2
        PLA 
        STA $33
        PLA 
        STA $34
        JSR sD065
        JSR EvalExpr
        LDA $34
        PHA 
        LDA $33
        PHA 
        JSR FP2Int
        LDA $34
        STA $02E4
        LDA $33
        STA $02E3
        PLA 
        STA $33
        PLA 
        STA $34
        JSR sF1C8
        LDY f02E1
        LDA $02E0
        AND #$01
        BNE bEC99
        LDA f02E2
        JSR jD499
        JMP sD05F

fEC9B   =*+$02
bEC99   JMP jD8C2

bEC9C   INC $E9
        BNE bECA2
        INC $EA
bECA2   LDA $EA60
        CMP #$20
        BEQ bEC9C
        JSR sECB9
        RTS 

        BIT $EA60
        BIT $EA60
        RTS 

        BYT  $80,$4F
        BYT  $C7,$52
        CLI 
sECB9   CMP #$C8
        BEQ bECCB
        CMP #$27
        BEQ bECCB
        CMP #$3A
        BCS bECCB
        SEC 
        SBC #$30
        SEC 
        SBC #$D0
bECCB   RTS 

StartBASIC CLD 
        LDX #$FF
        STX $A9
        TXS 
        LDA #<StartBASIC
        LDY #>StartBASIC
        STA $1B
        STY $1C
        LDA #$4C
        STA $1A
        STA $C3
        STA $21
        STA $02FB
        LDA #<jD336
        LDY #>jD336
        STA $22
        STY $23
        STA $02FC
        STY $02FD
        STA p02F5
        STY $02F6
        LDX #$1C
bECFB   LDA fEC9B,X
        STA fE1,X
        DEX 
        BNE bECFB
        LDA #$03
        STA $C2
        TXA 
        STA $D7
        STA $87
        STA $2F
        PHA 
        STA $2E
        STA $02F2
        LDX #$88
        STX $85
        TAY 
        LDA #$02
        STA $02C0
        LDA #$28
        STA $0257
        LDA #$50
        STA $0256
        LDA #$00
        STA $30
        STA $0258
        STA $0259
        JSR sC83E
        JSR ClrScr
        LDA #$96
        LDY #$ED
        JSR PrintString
        JSR NewLine
        LDX #<p0500
        LDY #>p0500
        STX $9A
        STY $9B
        LDY #$00
        TYA 
        STA (p9A),Y
        INC $9A
        BNE bED55
        INC $9B
bED55   JSR sC6F0
        LDA $9A
        LDY $9B
        JSR FreeMemCheck
        JSR NewLine
        LDA $A6
        SEC 
        SBC $9A
        TAX 
        LDA $A7
        SBC $9B
        JSR PrintInt
        LDA #$88
        LDY #$ED
; ==================================
#ifndef ORICEXOS
; ==================================
        JSR PrintString
        LDA #<PrintString
        LDY #>PrintString
#else
        jsr ClrScr
        lda #<PPLOAD
        ldy #>PPLOAD
#endif
        STA $1B
        STY $1C
        LDA #$10
        STA $02F8
        JMP BackToBASIC

        BYT  $00,$00
        
MessageBytesFree 
        BYT  $20,$42,$59,$54,$45,$53,$20,$46
        BYT  $52,$45,$45,$0A,$0D,$00

MessageOricExtendedBasic 
        BYT  $4F,$52,$49,$43,$20,$45,$58,$54
        BYT  $45,$4E,$44,$45,$44,$20,$42,$41
        BYT  $53,$49,$43,$20,$56,$31,$2E,$31
        BYT  $0D,$0A

id_addr
        BYT  $60

        BYT  $20,$31,$39,$38,$33
        
; ==================================
#ifndef ORICEXOS
; ==================================
        BYT  $20
#else
        BYT  $11 ; hide cursor
#endif

        BYT  $54,$41,$4E,$47,$45,$52,$49
        BYT  $4E,$45,$0D,$0A,$00,$00

CopyMem LDX #$00
        LDY #$00
bEDC8   CPY $10
        BNE bEDD0
        CPX $11
        BEQ bEDDF
bEDD0   LDA (p0C),Y
        STA (p0E),Y
        INY 
        BNE bEDC8
        INC $0D
        INC $0F
        INX 
        JMP bEDC8

bEDDF   RTS 

SetupTimer PHA 
        JSR ResetTimer
        LDA #$00
        LDX #$00
        LDY #$03
        JSR SetTimer
        LDA #$01
        LDY #$19
        JSR SetTimer
        LDA #$00
        STA $0271
        LDA $030B
        AND #$7F
        ORA #$40
        STA $030B
        LDA #$C0
        STA $030E
        LDA #$10
        STA $0306
        STA $0304
        LDA #$27
        STA $0307
        STA $0305
        PLA 
        RTS 

StopTimer PHA 
        LDA #$40
        STA $030E
        PLA 
        RTS 

IRQ     PHA 
        LDA $030D
        AND #$40
        BEQ bEE30
        STA $030D
        JSR sEE34
bEE30   PLA 
        JMP e024A

sEE34   PHA 
        TXA 
        PHA 
        TYA 
        PHA 
        LDY #$00
bEE3B   LDA f0272,Y
        SEC 
        SBC #$01
        STA f0272,Y
        INY 
        LDA f0272,Y
        SBC #$00
        STA f0272,Y
        INY 
        CPY #$06
        BNE bEE3B
        LDA #$00
        JSR GetTimer
        CPY #$00
        BNE bEE6B
        LDX #$00
        LDY #$03
        JSR SetTimer
; ==================================
#ifndef ORICEXOS
; ==================================
        JSR ReadKbd
#else
        ldx #$00
        nop
#endif
        TXA 
        BPL bEE6B
        STX $02DF
bEE6B   LDA #$01
        JSR GetTimer
        CPY #$00
        BNE bEE86
        LDX #$00
        LDY #$19
        JSR SetTimer
        LDA $0271
        EOR #$01
        STA $0271
        JSR sF801
bEE86   PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTS 

ResetTimer PHA 
        TYA 
        PHA 
        LDY #$05
        LDA #$00
bEE93   STA f0272,Y
        DEY 
        BPL bEE93
        PLA 
        TAY 
        PLA 
        RTS 

GetTimer PHA 
        ASL 
        TAY 
        SEI 
        LDA f0272,Y
        LDX f0273,Y
        CLI 
        TAY 
        PLA 
        RTS 

SetTimer PHA 
        TXA 
        PHA 
        TYA 
        PHA 
        TSX 
        LDA f0103,X
        ASL 
        TAY 
        PLA 
        PHA 
        SEI 
        STA f0272,Y
        LDA f0102,X
        STA f0273,Y
        CLI 
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTS 

Delay   JSR SetTimer
bEECC   JSR GetTimer
        CPY #$00
        BNE bEECC
        CPX #$00
        BNE bEECC
        RTS 

sEED8   LDA $0213
        STA $0214
sEEDE   LSR $0212
        ROR $0212
        ROR $0212
        RTS 

WritePixel PHA 
        TYA 
        PHA 
        JSR sEEDE
        JSR sF049
        JSR sF024
        PLA 
        TAY 
        PLA 
        RTS 

DrawLine CLD 
        JSR sEED8
        BIT f02E2
        BPL bEF0B
        LDA #$FF
        EOR f02E1
        TAX 
        INX 
        STX f02E1
bEF0B   BIT $02E4
        BPL bEF1A
        LDA #$FF
        EOR $02E3
        TAX 
        INX 
        STX $02E3
bEF1A   LDA f02E1
        CMP $02E3
        BCC bEF31
        LDX f02E1
        BEQ bEF30
        LDA $02E3
        JSR sEF40
        JSR sEF84
bEF30   RTS 

bEF31   LDX $02E3
        BEQ bEF3F
        LDA f02E1
        JSR sEF40
        JSR sEF5C
bEF3F   RTS 

sEF40   STA $0D
        STX $0200
        LDA #$00
        STA $0C
        STA $0201
        JSR sEFC8
        JSR sEFFA
        LDA #$00
        STA $0E
        STA $0F
        STA $0200
        RTS 

sEF5C   BIT $02E4
        BPL bEF67
        JSR sF095
        JMP jEF6A

bEF67   JSR sF089
jEF6A   JSR sEFAC
        BEQ bEF7D
        BIT f02E2
        BPL bEF7A
        JSR sF0B2
        JMP bEF7D

bEF7A   JSR sF0A1
bEF7D   JSR sF016
        DEX 
        BNE sEF5C
        RTS 

sEF84   BIT f02E2
        BPL bEF8F
        JSR sF0B2
        JMP jEF92

bEF8F   JSR sF0A1
jEF92   JSR sEFAC
        BEQ bEFA5
        BIT $02E4
        BPL bEFA2
        JSR sF095
        JMP bEFA5

bEFA2   JSR sF089
bEFA5   JSR sF016
        DEX 
        BNE sEF84
        RTS 

sEFAC   CLD 
        CLC 
        LDA $0E
        ADC $0C
        STA $0E
        LDA $0F
        ADC $0D
        STA $0F
        BIT $0E
        BPL bEFC1
        CLC 
        ADC #$01
bEFC1   CMP $0200
        STA $0200
        RTS 

sEFC8   PHA 
        TXA 
        PHA 
        TYA 
        PHA 
        LDA #$00
        STA $0E
        STA $0F
        LDX #$10
bEFD5   ASL $0C
        ROL $0D
        ROL $0E
        ROL $0F
        LDA $0E
        SEC 
        SBC $0200
        TAY 
        LDA $0F
        SBC $0201
        BCC bEFF1
        INC $0C
        STY $0E
        STA $0F
bEFF1   DEX 
        BNE bEFD5
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTS 

sEFFA   PHA 
        ASL $0200
        ROL $0201
        LDA $0200
        SEC 
        SBC $0E
        LDA $0201
        SBC $0F
        BCS bF014
        INC $0C
        BNE bF014
        INC $0D
bF014   PLA 
        RTS 

sF016   BIT $0214
        CLC 
        BPL bF020
        JSR sF024
        SEC 
bF020   ROL $0214
        RTS 

sF024   LDY #$00
        LDA (p10),Y
        AND #$40
        BEQ bF048
        LDA $0215
        BIT $0212
        BMI bF042
        BVS bF03D
        EOR #$FF
        AND (p10),Y
        STA (p10),Y
        RTS 

bF03D   ORA (p10),Y
        STA (p10),Y
        RTS 

bF042   BVS bF048
        EOR (p10),Y
        STA (p10),Y
bF048   RTS 

sF049   CLD 
        PHA 
        TYA 
        PHA 
        JSR sF731
        CLC 
        ADC #$00
        STA $10
        TYA 
        ADC #$A0
        STA $11
        LDA #$00
        STA $0D
        STA $0201
        STX $0C
        LDA #$06
        STA $0200
        JSR sEFC8
        CLC 
        LDA $0C
        ADC $10
        STA $10
        LDA #$00
        ADC $11
        STA $11
        LDA #$20
        LDY $0E
bF07C   BEQ bF082
        LSR 
        DEY 
        BCC bF07C
bF082   STA $0215
        PLA 
        TAY 
        PLA 
        RTS 

sF089   CLC 
        LDA $10
        ADC #$28
        STA $10
        BCC bF094
        INC $11
bF094   RTS 

sF095   SEC 
        LDA $10
        SBC #$28
        STA $10
        BCS bF0A0
        DEC $11
bF0A0   RTS 

sF0A1   LSR $0215
        BCC bF0B1
        LDA #$20
        STA $0215
        INC $10
        BNE bF0B1
        INC $11
bF0B1   RTS 

sF0B2   ASL $0215
        BIT $0215
        BVC bF0C7
        LDA #$01
        STA $0215
        LDA $10
        BNE bF0C5
        DEC $11
bF0C5   DEC $10
bF0C7   RTS 

CURSET  LDA #$04
        LDX #$E5
        JSR sF2F8
        BCS bF0F9
        LDA $02E5
        STA $0212
        LDA #$F0
        LDX #$E1
        JSR sF2F8
        BCS bF0F9
        LDA #$C8
        LDX #$E3
        JSR sF2F8
        BCS bF0F9
        LDX f02E1
        STX $0219
        LDY $02E3
        STY $021A
        JSR WritePixel
        RTS 

bF0F9   INC $02E0
        RTS 

CURMOV  JSR sF30A
        BCS bF10C
        LDX $0219
        LDY $021A
        JSR WritePixel
        RTS 

bF10C   INC $02E0
        RTS 

DRAW    JSR sF30A
        BCS bF119
        JSR DrawLine
        RTS 

bF119   INC $02E0
        RTS 

PATTERN LDX f02E2
        BNE bF129
        LDX f02E1
        STX $0213
        RTS 

bF129   INC $02E0
        RTS 

CHAR    LDX f02E2
        BNE bF16D
        LDX f02E1
        CPX #$20
        BCC bF16D
        CPX #$80
        BCS bF16D
        LDA #$02
        LDX #$E3
        JSR sF2F8
        BCS bF16D
        LDA #$04
        LDX #$E5
        JSR sF2F8
        BCS bF16D
        LDA $0219
        CMP #$EB
        BCS bF16D
        LDA $021A
        CMP #$C1
        BCS bF16D
        JSR sF171
        JSR sF19B
        LDX $0219
        LDY $021A
        JSR sF049
        RTS 

bF16D   INC $02E0
        RTS 

sF171   CLD 
        LDA $02E5
        STA $0212
        JSR sEEDE
        LDA f02E1
        STA $0C
        LDA #$00
        STA $0D
        LDX #$03
bF186   ASL $0C
        ROL $0D
        DEX 
        BNE bF186
        LDA $02E3
        ASL 
        ASL 
        CLC 
        ADC #$98
        CLC 
        ADC $0D
        STA $0D
        RTS 

sF19B   CLD 
        LDY #$00
bF19E   STY $0F
        LDA (p0C),Y
        STA $0E
        JSR sF35D
        ROL $0E
        ROL $0E
        LDX #$06
bF1AD   ROL $0E
        BCC bF1B4
        JSR sF024
bF1B4   JSR sF0A1
        DEX 
        BNE bF1AD
        JSR sF36E
        JSR sF089
        LDY $0F
        INY 
        CPY #$08
        BNE bF19E
        RTS 

sF1C8   LDA #$F0
        LDX #$E1
        JSR sF2F8
        BCS bF200
        LDA #$C8
        LDX #$E3
        JSR sF2F8
        BCS bF200
        LDX f02E1
        STX $0219
        LDY $02E3
        STY $021A
        JSR sF049
        LDY #$00
        LDA (p10),Y
        AND $0215
        BEQ bF1F7
        LDA #$FF
        JMP jF1F9

bF1F7   LDA #$00
jF1F9   STA f02E1
        STA f02E2
        RTS 

bF200   INC $02E0
        RTS 

PAPER   LDA #$10
        STA $0C
        LDA #$00
        STA $0D
        JSR sF21C
        RTS 

INK     LDA #<f0100
        STA $0C
        LDA #>f0100
        STA $0D
        JSR sF21C
        RTS 

sF21C   LDA #$08
        LDX #$E1
        JSR sF2F8
        BCS bF264
        JSR sF35D
        LDA f02E1
        ORA $0C
        STA $0202
        LDX $021F
        BNE bF247
        LDX $0D
        STA $026B,X
        LDA #$A8
        CLC 
        ADC $0D
        TAX 
        LDY #$BB
        LDA #$1B
        JMP jF251

bF247   LDA #$00
        CLC 
        ADC $0D
        TAX 
        LDY #$A0
        LDA #$C8
jF251   STA $0200
        STX $10
        STY $11
        LDA #$01
        STA $0201
        JSR sF2CD
        JSR sF36E
        RTS 

bF264   INC $02E0
        RTS 

FILL    CLD 
        LDA $02E3
        STA $0201
        BEQ bF2C9
        LDY #$00
        LDA $0219
jF276   SEC 
        SBC #$06
        BCC bF27F
        INY 
        JMP jF276

bF27F   TYA 
        CLC 
        ADC $02E3
        TAY 
        LDA $02E4
        ADC #$00
        BNE bF2C9
        CPY #$29
        BCS bF2C9
        LDA $02E6
        BNE bF2C9
        LDA f02E1
        STA $0200
        BEQ bF2C9
        CLC 
        ADC $021A
        TAY 
        LDA f02E2
        ADC #$00
        BNE bF2C9
        CPY #$C9
        BCS bF2C9
        CPY #$C8
        BNE bF2B3
        LDY #$00
bF2B3   STY $021A
        LDA $02E5
        STA $0202
        JSR sF2CD
        LDY $021A
        LDX $0219
        JSR sF049
        RTS 

bF2C9   INC $02E0
        RTS 

sF2CD   CLD 
bF2CE   LDA $0202
        LDY #$00
bF2D3   STA (p10),Y
        INY 
        CPY $0201
        BNE bF2D3
        JSR sF089
        DEC $0200
        BNE bF2CE
        RTS 

sF2E4   STA $0204
        LDA $0201,X
        BNE bF2F6
        LDA $0200,X
        BEQ bF2F6
        CMP $0204
        BCC bF2F7
bF2F6   SEC 
bF2F7   RTS 

sF2F8   STA $0204
        LDA $0201,X
        BNE bF308
        LDA $0200,X
        CMP $0204
        BCC bF309
bF308   SEC 
bF309   RTS 

sF30A   LDA #$04
        LDX #$E5
        JSR sF2F8
        BCS bF35C
        CLC 
        LDA f02E1
        ADC $0219
        STA $0200
        LDA f02E2
        ADC #$00
        STA $0201
        LDX #$00
        LDA #$F0
        JSR sF2F8
        BCS bF35C
        CLC 
        LDA $02E3
        ADC $021A
        STA $0202
        LDA $02E4
        ADC #$00
        STA $0203
        LDX #$02
        LDA #$C8
        JSR sF2F8
        BCS bF35C
        LDA $02E5
        STA $0212
        LDA $0200
        STA $0219
        LDA $0202
        STA $021A
        CLC 
bF35C   RTS 

sF35D   LDA $10
        STA $0216
        LDA $11
        STA $0217
        LDA $0215
        STA $0218
        RTS 

sF36E   LDA $0216
        STA $10
        LDA $0217
        STA $11
        LDA $0218
        STA $0215
        RTS 

CIRCLE
        CLD 
        LDA f02E2
        BNE bF3C2
        LDA f02E1
        BEQ bF3C2
        LDA $0219
        CMP f02E1
        BCC bF3C2
        CLC 
        ADC f02E1
        CMP #$F0
        BCS bF3C2
        LDA $021A
        CMP f02E1
        BCC bF3C2
        CLC 
        ADC f02E1
        CMP #$C8
        BCS bF3C2
        LDX #$E3
        LDA #$04
        JSR sF2F8
        BCS bF3C2
        LDA $02E3
        STA $0212
        JSR sEED8
        JSR sF3C6
        JMP jF3C5

bF3C2   INC $02E0
jF3C5   RTS 

sF3C6   JSR sF35D
        LDA $021A
        SEC 
        SBC f02E1
        TAY 
        LDX $0219
        JSR sF049
        LDA f02E1
        STA $0F
        JSR sF485
        LDA #$80
        STA $021B
        STA $021D
        LDA #$00
        STA $021C
        LDA f02E1
        STA $021E
bF3F2   LDA #$00
        STA $0F
        JSR sF414
        JSR sF444
        LDA $0F
        BEQ bF403
        JSR sF016
bF403   LDA $021C
        BNE bF3F2
        LDA $021E
        CMP f02E1
        BNE bF3F2
        JSR sF36E
        RTS 

sF414   LDA $021D
        LDX $021E
        JSR sF474
        LDA $0C
        CLC 
        ADC $021B
        STA $021B
        LDA $021C
        STA $0C
        ADC $0D
        STA $021C
        CMP $0C
        BEQ bF443
        BCS bF43C
        JSR sF0A1
        JMP jF43F

bF43C   JSR sF0B2
jF43F   LDA #$01
        STA $0F
bF443   RTS 

sF444   LDA $021B
        LDX $021C
        JSR sF474
        SEC 
        LDA $021D
        SBC $0C
        STA $021D
        LDA $021E
        STA $0C
        SBC $0D
        STA $021E
        CMP $0C
        BEQ bF473
        BCS bF46C
        JSR sF089
        JMP jF46F

bF46C   JSR sF095
jF46F   LDA #$01
        STA $0F
bF473   RTS 

sF474   STA $0C
        STX $0D
        LDX $0E
bF47A   LDA $0D
        ROL 
        ROR $0D
        ROR $0C
        DEX 
        BNE bF47A
        RTS 

sF485   INC $0F
        LDA #$00
        STA $0E
        LDA #$01
bF48D   ASL 
        INC $0E
        CMP $0F
        BCC bF48D
        RTS 

ReadKbd
        PHA 
        PHP 
        TYA 
        PHA 
        CLD 
        LDA $0208
        BPL bF4BD
        AND #$87
        STA $0210
        LDX $020A
        JSR ReadKbdCol
        CMP $0210
        BNE bF4BD
        DEC $020E
        BNE bF4E7
        LDA $024F
        STA $020E
        JMP jF4C6

bF4BD   LDA $024E
        STA $020E
        JSR FindKey
jF4C6   JSR Key2ASCII
        TAX 
        BPL bF4E9
        PHA 
        LDA $026A
        AND #$08
        BNE bF4E3
        PLA 
        PHA 
        CMP #$A0
        BCC bF4E0
        JSR KeyClickH
        JMP bF4E3

bF4E0   JSR KeyClickL
bF4E3   PLA 
        JMP bF4E9

bF4E7   LDA #$00
bF4E9   TAX 
        PLA 
        TAY 
        PLP 
        PLA 
        RTS 

Key2ASCII
        LDA $0209
        TAY 
        LDA #$00
        CPY #$A4
        BEQ bF4FD
        CPY #$A7
        BNE bF500
bF4FD   CLC 
        ADC #$40
bF500   CLC 
        ADC $0208
        BPL bF522
        AND #$7F
        TAX 
        LDA KeyCodeTab,X
        AND $020C
        BPL bF514
        SEC 
        SBC #$20
bF514   AND #$7F
        CPY #$A2
        BNE bF520
        CMP #$40
        BMI bF520
        AND #$1F
bF520   ORA #$80
bF522   RTS 

FindKey
        LDA #$38
        STA $020D
        STA $0208
        STA $0209
        LDA #$7F
        PHA 
bF531   PLA 
        PHA 
        TAX 
        LDA #$07
        JSR ReadKbdCol
        ORA $020D
        BPL bF550
        LDX #$00
        LDY #$20
        CPY $020D
        BNE bF548
        INX 
bF548   STA $0208,X
        PLA 
        PHA 
        STA $020A,X
bF550   SEC 
        PLA 
        ROR 
        PHA 
        SEC 
        LDA $020D
        SBC #$08
        STA $020D
        BPL bF531
        PLA 
        RTS 

ReadKbdCol
        PHA 
        LDA #$0E
        JSR WriteToAY
        PLA 
        AND #$07
        TAX 
        STA $0211
        
; ==================================
#ifndef ORICEXOS
; ==================================
bF56E   ORA #$B8
#else
bF56E   ora #$a8  ; pb4 = 0
#endif

        STA $0300
        LDY #$04
bF575   DEY 
        BNE bF575
        LDA $0300
        AND #$08
        BNE bF58C
        DEX 
        TXA 
        AND #$07
        TAX 
        CMP $0211
        BNE bF56E
        LDA #$00
        RTS 

bF58C   TXA 
        ORA #$80
        RTS 

WriteToAY PHP 
        SEI 
        STA $030F
        TAY 
        TXA 
        CPY #$07
        BNE bF59D
        ORA #$40
bF59D   PHA 
        LDA $030C
        ORA #$EE
        STA $030C
        AND #$11
        ORA #$CC
        STA $030C
        TAX 
        PLA 
        STA $030F
        TXA 
        ORA #$EC
        STA $030C
        AND #$11
        ORA #$CC
        STA $030C
        PLP 
        RTS 

PrintChar
        PHP 
        SEI 
        STA $0301
        LDA $0300
        AND #$EF
        STA $0300
        LDA $0300
        ORA #$10
        STA $0300
        PLP 
bF5D7   LDA $030D
        AND #$02
        BEQ bF5D7
        LDA $030D
        RTS 

fF5E2   BYT  $CF,$CF,$CF,$CF,$A3,$CF,$A6,$CC
        BYT  $00,$27,$34,$0F,$66,$99,$60,$CF
        BYT  $A7,$B3,$CF,$A8,$BE,$CF,$CF,$CF
        BYT  $CF,$CF,$A5,$A5,$CF,$A4,$84,$CF

ControlChr
        AND #$1F
        TAX 
        LDA fF5E2,X
        CLC 
        ADC #$2F
        STA $0261
        LDA #$00
        ADC #$F6
        STA $0262
        LDA $026A
        PHA 
        AND #$FE
        STA $026A
        PLA 
        AND #$01
        STA $0251
        LDA #$00
        JSR sF801
        SEC 
        LDA #$00
        JMP (a0261)

        DEC $0269
        BMI bF639
        JSR sF7D7
        BNE bF679
bF639   LDA #$27
        STA $0269
        LDA $0268
        CMP #$01
        BEQ bF679
        DEC $0268
        SEC 
        LDA $12
        SBC #$28
        STA $12
        BCS bF653
        DEC $13
bF653   JMP jF6FE

        INC $0269
        LDX #$27
        CPX $0269
        BPL bF679
        JSR sF70D
        LDA $0268
        CMP $027E
        BEQ bF67C
        INC $0268
        CLC 
        LDA $12
        ADC #$28
        STA $12
        BCC bF679
        INC $13
bF679   JMP jF6FE

bF67C   JSR sF35D
        LDX #$06
bF681   LDA f0277,X
        STA f0B,X
        DEX 
        BNE bF681
        JSR CopyMem
        JSR sF36E
        JSR ClearLine
        JMP jF6FE

        LDX $027E
        LDA $027A
        STA $12
        LDA $027B
        STA $13
bF6A2   JSR ClearLine
        CLC 
        LDA $12
        ADC #$28
        STA $12
        BCC bF6B0
        INC $13
bF6B0   DEX 
        BNE bF6A2
        JSR sF70D
        LDA #$01
        STA $0268
        LDA $027A
        STA $12
        LDA $027B
        STA $13
        JMP jF6FE

        JSR sF70D
        STX $0253
        JMP jF6FE

        ROL 
        ROL 
        ROL 
        ROL 
        ROL 
        ROL 
        ROL 
        ROL 
        EOR $026A
        STA $026A
        JMP jF6FE

        LDA $0251
        EOR #$01
        STA $0251
        JMP jF6FE

        LDA $020C
        EOR #$80
        STA $020C
        JSR sF75A
        JMP jF6FE

        JSR PING
jF6FE   LDA $026A
        ORA $0251
        STA $026A
        LDA #$01
        JSR sF801
        RTS 

sF70D   LDX #$00
        JSR sF7DE
        BNE bF716
        INX 
        INX 
bF716   STX $0269
        RTS 

ClearLine
        LDY #$27
        LDA #$20
bF71E   STA (p12),Y
        DEY 
        BPL bF71E
        LDY #$00
        LDA $026B
        STA (p12),Y
        LDA $026C
        INY 
        STA (p12),Y
        RTS 

sF731   LDY #$00
        STY $0263
        STA $0264
        ASL 
        ROL $0263
        ASL 
        ROL $0263
        CLC 
        ADC $0264
        BCC bF74A
        INC $0263
bF74A   ASL 
        ROL $0263
        ASL 
        ROL $0263
        ASL 
        ROL $0263
        LDY $0263
        RTS 

sF75A   LDA $020C
        BPL bF766
        LDA #<(CAPS)                    ; $F770
        LDY #>(CAPS)
        JMP jF76A

bF766   LDA #<(NOCAPS)                  ; $F776
        LDY #>(NOCAPS)
jF76A   LDX #$23
        JSR PrintStatus
        RTS

; ==================================
#ifndef ORICEXOS
; ==================================
CAPS
        BYT  $07,$43,$41,$50,$53,$00
NOCAPS
        BYT  $07,$20,$20,$20,$20,$00
#else  
CAPS
        BYT  $10,$10,$10,$10,$10,$00
NOCAPS
        BYT  $10,$10,$10,$10,$10,$00
#endif

Char2Scr
        PHA 
        PHP 
        TYA 
        PHA 
        TXA 
        PHA 
        CLD 
        CPX #$13
        BEQ bF7CD
        CPX #$14
        BEQ bF7CD
        CPX #$06
        BEQ bF7CD
        LDA $026A
        AND #$02
        BEQ bF7D0
        TXA 
        CMP #$20
        BCC bF7CD
        LDA $026A
        AND #$10
        BEQ bF7B5
        TXA 
        SEC 
        SBC #$40
        BMI bF7B1
        AND #$1F
bF7AA   JSR PrintA
        LDA #$1B
        BNE bF7CD
bF7B1   LDA #$20
        BPL bF7AA
bF7B5   CPX #$7F
        BEQ bF7C1
        PLA 
        PHA 
        JSR PrintA
        JMP bF7D0

bF7C1   LDA #$08
        JSR ControlChr
        LDA #$20
        JSR PrintA
        LDA #$08
bF7CD   JSR ControlChr
bF7D0   PLA 
        TAX 
        PLA 
        TAY 
        PLP 
        PLA 
        RTS 

sF7D7   LDA $0269
        AND #$FE
        BNE bF7E3
sF7DE   LDA $026A
        AND #$20
bF7E3   RTS 

PrintA  PHA 
        LDY $0269
        STA (p12),Y
        BIT $026A
        BVC bF7FA
        LDA $0269
        CLC 
        ADC #$28
        TAY 
        PLA 
        PHA 
        STA (p12),Y
bF7FA   LDA #$09
        JSR ControlChr
        PLA 
        RTS 

sF801   AND $026A
        LSR 
        ROR 
        STA $0265
        LDY $0269
        LDA (p12),Y
        AND #$7F
        ORA $0265
        STA (p12),Y
        RTS 

AltChars
        LDA #<pB900
        STA $0C
        LDA #>pB900
        STA $0D
        LDA #$00
        JSR sF82D
        LDY #$BA
        STY $0D
        LDA #$20
        JSR sF82D
        RTS 

sF82D   LDY #$00
jF82F   PHA 
        JSR sF854
        STA (p0C),Y
        INY 
        PLA 
        PHA 
        JSR sF852
        PLA 
        PHA 
        JSR sF850
        STA (p0C),Y
        INY 
        CPY #$00
        BEQ bF84E
        PLA 
        CLC 
        ADC #$01
        JMP jF82F

bF84E   PLA 
        RTS 

sF850   LSR 
        LSR 
sF852   LSR 
        LSR 
sF854   AND #$03
        TAX 
        LDA AltCharsData,X
        STA (p0C),Y
        INY 
        STA (p0C),Y
        INY 
        RTS 

AltCharsData
        BYT  $00,$38,$07,$3F

PrintStatus
        STA $0C
        STY $0D
        LDA $021F
        BNE bF87B
        LDY #$00
bF870   LDA (p0C),Y
        BEQ bF87B
        STA fBB80,X
        INX 
        INY 
        BNE bF870
bF87B   RTS 

fF87C   JMP Char2Scr
        JMP CheckKbd
        JMP PrintChar
        JMP PrintStatus
        JMP IRQ
        JMP NMI
        RTI 

Reset   LDX #$FF
        TXS 
        CLI 
        CLD 
        LDX #$12
bF896   LDA fF87C,X
        STA f0238,X
        DEX 
        BPL bF896
        LDA #$20
        STA $024E
        LDA #$04
        STA $024F
        JSR RamTest
        JSR SystemSetUp

BASICStart 
        JMP StartBASIC

NMI     
        JSR SystemSetUp

BASICRestart 
        JMP RestartBASIC

SystemSetUp
        JSR ResetVIA
        LDA #$07
        LDX #$40
        JSR WriteToAY
        JSR SetupTimer
        JSR sF90E
        LDA #$FF
        STA $020C
        JSR SetupText
        LDX #$05
        JSR sF982
        JSR AltChars
        JSR sF75A
        RTS 

sF8DC   PHA 
        TXA 
        PHA 
        LDA #$01
        STA $021F
        LDA #$BF
        STA $027B
        STA $0279
        LDA #$68
        STA $027A
        LDA #$90
        STA $0278
        LDA #>a0300
        STA $027E
        LDA #<a0300
        STA $027D
        LDA #$50
        STA $027C
        LDX #$0C
        JSR f0238
        PLA 
        TAX 
        PLA 
        RTS 

sF90E   PHA 
        LDA #$03
        STA $026A
; ==================================
#ifndef ORICEXOS
; ==================================
        LDA #$00
        STA $026C
        LDA #$17
        STA $026B
#else
        lda #$07    ; ink 7
        sta $026c
        lda #$00    ; paper 0
        sta $026b
#endif
        PLA 
        RTS 

HiresMode
        PHA 
        LDA $021F
        BNE bF92B
        LDX #$0B
        JSR sF982
bF92B   LDA #$FE
        AND $026A
        STA $026A
        LDA #$1E
        STA fBFDF
        LDA #$40
        STA $A000
        LDX #$17
        JSR sF982
        LDA #$00
        STA $0219
        STA $021A
        STA $10
        LDA #$A0
        STA $11
        LDA #$20
        STA $0215
        LDA #$FF
        STA $0213
        JSR sF8DC
        LDA #$01
        ORA $026A
        STA $026A
        PLA 
        RTS 

LoresMode
        PHA 
        LDA #$FE
        AND $026A
        STA $026A
        LDX #$11
        JSR sF982
        JSR SetupText
        LDA #$01
        ORA $026A
        STA $026A
        PLA 
        RTS 

sF982   LDY #$06
bF984   LDA AddressTable,X
        STA f000B,Y
        DEX 
        DEY 
        BNE bF984
        JSR CopyMem
        RTS 

AddressTable
        BYT  $78,$FC,$00,$B5,$00,$03,$00,$B4
        BYT  $00,$98,$80,$07,$00,$98,$00,$B4
        BYT  $80,$07,$00,$A0,$01,$A0,$3F,$1F

ResetVIA 
; ==================================
#ifndef ORICEXOS
; ==================================
        LDA #$FF
        STA $0303
        LDA #$F7
        STA $0302
        LDA #$B7
        STA $0300
        LDA #$DD
        STA $030C
        LDA #$7F
        STA $030E
        LDA #$00
        STA $030B
        RTS 
#else
        lda #$00      ; RESET 6522
        sta $0303     ; Port A all input.
        lda #$a7      ; Turn off cassette motor. PB4 = L
        sta $0300     ;
        lda #$f7      ;
        sta $0302     ; Port B all output except bit 3.
        lda #$dc      ; Set CA2 and CB2 to 0 and set
        sta $030c     ; CA1 active H to L and CB1 active L to H.
        lda #$7f      ;
        sta $030e     ; Disable all interrupts.
        lda #$01      ; Enable port A latch with CA1
        sta $030b     ; Set the ACR.
        rts
#endif

SetupText LDA #$1A
        JSR sFA07
        LDA #$20
        LDY #$28
bF9D2   STA fBB7F,Y
        DEY 
        BNE bF9D2
        LDA #$00
        STA $021F
        LDA #$BB
        STA $027B
        STA $0279
        LDA #$A8
        STA $027A
        LDA #$D0
        STA $0278
        LDA #$1B
        STA $027E
        LDA #$04
        STA $027D
        LDA #$10
        STA $027C
        LDX #$0C
        JSR f0238
        JSR sF75A
        RTS 

sFA07   STA fBFDF
        LDA #$02
        LDX #$00
        LDY #$03
        JSR Delay
        RTS 

RamTest LDY #$00
        STY $0260
        STY $0220
        STY p0500
        STY $0E
        DEY 
        STY $0C
        STY $4500
        LDA p0500
        BNE bFA30
        LDA #$C0
        BNE bFA35
bFA30   INC $0220
        LDA #$40
bFA35   STA $0F
        INY 
        LDA #$03
        STA $0D
bFA3C   INC $0C
        BNE bFA42
        INC $0D
bFA42   LDA $0C
        CMP $0E
        BNE bFA4E
        LDA $0D
        CMP $0F
        BEQ bFA5D
bFA4E   LDA #$AA
        STA (p0C),Y
        CMP (p0C),Y
        BNE bFA5D
        LSR 
        STA (p0C),Y
        CMP (p0C),Y
        BEQ bFA3C
bFA5D   SEC 
        LDA $0F
        SBC #$28
        STA $0F
        LDA $0E
        CMP $0C
        LDA $0F
        SBC $0D
        BCC bFA77
        LDA $0C
        LDY $0D
        INC $0260
        BNE bFA7B
bFA77   LDA $0E
        LDY $0F
bFA7B   STA $A6
        STY $A7
        STA $02C1
        STY $02C2
        RTS 

sFA86   PHP 
        SEI 
        STX $14
        STY $15
        LDY #$00
bFA8E   LDA (p14),Y
        TAX 
        TYA 
        PHA 
        JSR WriteToAY
        PLA 
        TAY 
        INY 
        CPY #$0E
        BNE bFA8E
        PLP 
        RTS 

PING
        LDX #$A7
        LDY #$FA
        JSR sFA86
        RTS 
PingData
        BYT  $18,$00,$00,$00,$00,$00,$00,$3E
        BYT  $10,$00,$00,$00,$0F,$00

SHOOT
        LDX #$BD
        LDY #$FA
        JSR sFA86
        RTS 
ShootData
        BYT  $00,$00,$00,$00,$00,$00,$0F,$07
        BYT  $10,$10,$10,$00,$08,$00
        
EXPLODE
        LDX #$D3
        LDY #$FA
        JSR sFA86
        RTS 
ExplodeData 
        BYT  $00,$00,$00,$00,$00,$00,$1F,$07
        BYT  $10,$10,$10,$00,$18,$00

ZAP     LDX #$06
        LDY #$FB
        JSR sFA86

        LDA #$00
        TAX 
bFAEB   TXA 
        PHA 
        LDA #$00
        JSR WriteToAY
        LDX #$00
bFAF4   DEX 
        BNE bFAF4
        PLA 
        TAX 
        INX 
        CPX #$70
        BNE bFAEB
        LDA #$08
        LDX #$00
        JSR WriteToAY
        RTS 

ZapData
        BYT  $00,$00,$00,$00,$00,$00,$00,$3E
        BYT  $0F,$00,$00,$00,$00,$00

KeyClickH
        LDX #$1C
        LDY #$FB
        JSR sFA86
        RTS 

KeyClickHData 
        BYT  $1F,$00,$00,$00,$00,$00,$00,$3E
        BYT  $10,$00,$00,$1F,$00,$00
        
KeyClickL 
        LDX #$32
        LDY #$FB
        JSR sFA86
        RTS 

KeyClickLData 
        BYT  $2F,$00,$00,$00,$00,$00,$00,$3E
        BYT  $10,$00,$00,$1F,$00,$00

SOUND   LDA f02E1
        CMP #$01
        BNE bFB69
        LDA #$00
        LDX $02E3
        JSR WriteToAY
        LDA #$01
        LDX $02E4
        JSR WriteToAY
bFB57   LDA $02E5
        AND #$0F
        BNE bFB62
        LDX #$10
        BNE bFB63
bFB62   TAX 
bFB63   LDA #$08
        JSR WriteToAY
        RTS 

bFB69   CMP #$02
        BNE bFB8F
        LDA #$02
        LDX $02E3
        JSR WriteToAY
        LDA #$03
        LDX $02E4
        JSR WriteToAY
bFB7D   LDA $02E5
        AND #$0F
        BNE bFB88
        LDX #$10
        BNE bFB89
bFB88   TAX 
bFB89   LDA #$09
        JSR WriteToAY
        RTS 

bFB8F   CMP #$03
        BNE bFBB5
        LDA #$04
        LDX $02E3
        JSR WriteToAY
        LDA #$05
        LDX $02E4
        JSR WriteToAY
bFBA3   LDA $02E5
        AND #$0F
        BNE bFBAE
        LDX #$10
        BNE bFBAF
bFBAE   TAX 
bFBAF   LDA #$0A
        JSR WriteToAY
        RTS 

bFBB5   LDA #$06
        LDX $02E3
        JSR WriteToAY
        LDA f02E1
        CMP #$04
        BEQ bFB57
        CMP #$05
        BEQ bFB7D
        CMP #$06
        BEQ bFBA3
        INC $02E0
        RTS 

PLAY    LDA $02E3
        ASL 
        ASL 
        ASL 
        ORA f02E1
        EOR #$3F
        TAX 
        LDA #$07
        JSR WriteToAY
        CLC 
        LDA $02E7
        ASL 
        STA $02E7
        LDA $02E8
        ROL 
        STA $02E8
        LDA #$0B
        LDX $02E7
        JSR WriteToAY
        LDA #$0C
        LDX $02E8
        JSR WriteToAY
        LDA $02E5
        AND #$07
        TAY 
        LDA EnvelopePatterns,Y
        TAX 
        LDA #$0D
        JSR WriteToAY
        RTS 

EnvelopePatterns   
        BYT  $00,$00,$04,$08,$0A,$0B,$0C,$0D

MUSIC   LDX #$E1
        LDA #$04
        JSR sF2E4
        BCS bFC5A
        LDX #$E3
        LDA #$08
        JSR sF2F8
        BCS bFC5A
        LDX #$E5
        LDA #$0D
        JSR sF2E4
        BCS bFC5A
        LDY $02E3
        LDX $02E5
        LDA MusicData,X
        STA $02E4
        LDA MusicData2,X
        STA $02E3
        LDA $02E7
        STA $02E5
jFC4B   DEY 
        BMI bFC57
        LSR $02E4
        ROR $02E3
        JMP jFC4B

bFC57   JMP SOUND

bFC5A   INC $02E0
        RTS 

MusicData 
        BYT  $00,$07,$07,$06,$06,$05,$05,$05
        BYT  $04,$04,$04,$04,$03
MusicData2   
        BYT  $00,$77,$0B,$A6,$47,$EC,$97,$47
        BYT  $FB,$B3,$70,$30,$F4
CharSet
        BYT  $00,$00,$00,$00,$00,$00,$00,$00
        BYT  $08,$08,$08,$08,$08,$00,$08,$00
        BYT  $14,$14,$14,$00,$00,$00,$00,$00
        BYT  $14,$14,$3E,$14,$3E,$14,$14,$00
        BYT  $08,$1E,$28,$1C,$0A,$3C,$08,$00
        BYT  $30,$32,$04,$08,$10,$26,$06,$00
        BYT  $10,$28,$28,$10,$2A,$24,$1A,$00
        BYT  $08,$08,$08,$00,$00,$00,$00,$00
        BYT  $08,$10,$20,$20,$20,$10,$08,$00
        BYT  $08,$04,$02,$02,$02,$04,$08,$00
        BYT  $08,$2A,$1C,$08,$1C,$2A,$08,$00
        BYT  $00,$08,$08,$3E,$08,$08,$00,$00
        BYT  $00,$00,$00,$00,$00,$08,$08,$10
        BYT  $00,$00,$00,$3E,$00,$00,$00,$00
        BYT  $00,$00,$00,$00,$00,$04,$00,$00
        BYT  $00,$02,$04,$08,$10,$20,$00,$00
        BYT  $1C,$22,$26,$2A,$32,$22,$1C,$00
        BYT  $08,$18,$08,$08,$08,$08,$1C,$00
        BYT  $1C,$22,$02,$04,$08,$10,$3E,$00
        BYT  $3E,$02,$04,$0C,$02,$22,$1C,$00
        BYT  $04,$0C,$14,$24,$3E,$04,$04,$00
        BYT  $3E,$20,$3C,$02,$02,$22,$1C,$00
        BYT  $0C,$10,$20,$3C,$22,$22,$1C,$00
        BYT  $3E,$02,$04,$08,$10,$10,$10,$00
        BYT  $1C,$22,$22,$1C,$22,$22,$1C,$00
        BYT  $1C,$22,$22,$1E,$02,$04,$18,$00
        BYT  $00,$00,$08,$00,$00,$08,$00,$00
        BYT  $00,$00,$08,$00,$00,$08,$08,$10
        BYT  $04,$08,$10,$20,$10,$08,$04,$00
        BYT  $00,$00,$3E,$00,$3E,$00,$00,$00
        BYT  $10,$08,$04,$02,$04,$08,$10,$00
        BYT  $1C,$22,$04,$08,$08,$00,$08,$00
        BYT  $1C,$22,$2A,$2E,$2C,$20,$1E,$00
        BYT  $08,$14,$22,$22,$3E,$22,$22,$00
        BYT  $3C,$22,$22,$3C,$22,$22,$3C,$00
        BYT  $1C,$22,$20,$20,$20,$22,$1C,$00
        BYT  $3C,$22,$22,$22,$22,$22,$3C,$00
        BYT  $3E,$20,$20,$3C,$20,$20,$3E,$00
        BYT  $3E,$20,$20,$3C,$20,$20,$20,$00
        BYT  $1E,$20,$20,$20,$26,$22,$1E,$00
        BYT  $22,$22,$22,$3E,$22,$22,$22,$00
        BYT  $1C,$08,$08,$08,$08,$08,$1C,$00
        BYT  $02,$02,$02,$02,$02,$22,$1C,$00
        BYT  $22,$24,$28,$30,$28,$24,$22,$00
        BYT  $20,$20,$20,$20,$20,$20,$3E,$00
        BYT  $22,$36,$2A,$2A,$22,$22,$22,$00
        BYT  $22,$22,$32,$2A,$26,$22,$22,$00
        BYT  $1C,$22,$22,$22,$22,$22,$1C,$00
        BYT  $3C,$22,$22,$3C,$20,$20,$20,$00
        BYT  $1C,$22,$22,$22,$2A,$24,$1A,$00
        BYT  $3C,$22,$22,$3C,$28,$24,$22,$00
        BYT  $1C,$22,$20,$1C,$02,$22,$1C,$00
        BYT  $3E,$08,$08,$08,$08,$08,$08,$00
        BYT  $22,$22,$22,$22,$22,$22,$1C,$00
        BYT  $22,$22,$22,$22,$22,$14,$08,$00
        BYT  $22,$22,$22,$2A,$2A,$36,$22,$00
        BYT  $22,$22,$14,$08,$14,$22,$22,$00
        BYT  $22,$22,$14,$08,$08,$08,$08,$00
        BYT  $3E,$02,$04,$08,$10,$20,$3E,$00
        BYT  $1E,$10,$10,$10,$10,$10,$1E,$00
        BYT  $00,$20,$10,$08,$04,$02,$00,$00
        BYT  $3C,$04,$04,$04,$04,$04,$3C,$00
        BYT  $08,$14,$2A,$08,$08,$08,$08,$00
        BYT  $0E,$10,$10,$10,$3C,$10,$3E,$00
        BYT  $0C,$12,$2D,$29,$29,$2D,$12,$0C
        BYT  $00,$00,$1C,$02,$1E,$22,$1E,$00
        BYT  $20,$20,$3C,$22,$22,$22,$3C,$00
        BYT  $00,$00,$1E,$20,$20,$20,$1E,$00
        BYT  $02,$02,$1E,$22,$22,$22,$1E,$00
        BYT  $00,$00,$1C,$22,$3E,$20,$1E,$00
        BYT  $0C,$12,$10,$3C,$10,$10,$10,$00
        BYT  $00,$00,$1C,$22,$22,$1E,$02,$1C
        BYT  $20,$20,$3C,$22,$22,$22,$22,$00
        BYT  $08,$00,$18,$08,$08,$08,$1C,$00
        BYT  $04,$00,$0C,$04,$04,$04,$24,$18
        BYT  $20,$20,$22,$24,$38,$24,$22,$00
        BYT  $18,$08,$08,$08,$08,$08,$1C,$00
        BYT  $00,$00,$36,$2A,$2A,$2A,$22,$00
        BYT  $00,$00,$3C,$22,$22,$22,$22,$00
        BYT  $00,$00,$1C,$22,$22,$22,$1C,$00
        BYT  $00,$00,$3C,$22,$22,$3C,$20,$20
        BYT  $00,$00,$1E,$22,$22,$1E,$02,$02
        BYT  $00,$00,$2E,$30,$20,$20,$20,$00
        BYT  $00,$00,$1E,$20,$1C,$02,$3C,$00
        BYT  $10,$10,$3C,$10,$10,$12,$0C,$00
        BYT  $00,$00,$22,$22,$22,$26,$1A,$00
        BYT  $00,$00,$22,$22,$22,$14,$08,$00
        BYT  $00,$00,$22,$22,$2A,$2A,$36,$00
        BYT  $00,$00,$22,$14,$08,$14,$22,$00
        BYT  $00,$00,$22,$22,$22,$1E,$02,$1C
        BYT  $00,$00,$3E,$04,$08,$10,$3E,$00
        BYT  $0E,$18,$18,$30,$18,$18,$0E,$00
        BYT  $08,$08,$08,$08,$08,$08,$08,$08
        BYT  $38,$0C,$0C,$06,$0C,$0C,$38,$00
        BYT  $2A,$15,$2A,$15,$2A,$15,$2A,$15
        BYT  $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F

KeyCodeTab
        BYT  $37,$EA,$ED,$EB,$20,$F5,$F9,$38
        BYT  $EE,$F4,$36,$39,$2C,$E9,$E8,$EC
        BYT  $35,$F2,$E2,$3B,$2E,$EF,$E7,$30
        BYT  $F6,$E6,$34,$2D,$0B,$F0,$E5,$2F
        BYT  $00,$00,$00,$00,$00,$00,$00,$00
        BYT  $31,$1B,$FA,$00,$08,$7F,$E1,$0D
        BYT  $F8,$F1,$32,$5C,$0A,$5D,$F3,$00
        BYT  $33,$E4,$E3,$27,$09,$5B,$F7,$3D
        BYT  $26,$4A,$4D,$4B,$20,$55,$59,$2A
        BYT  $4E,$54,$5E,$28,$3C,$49,$48,$4C
        BYT  $25,$52,$42,$3A,$3E,$4F,$47,$29
        BYT  $56,$46,$24,$5F,$0B,$50,$45,$3F
        BYT  $00,$00,$00,$00,$00,$00,$00,$00
        BYT  $21,$1B,$5A,$00,$08,$7F,$41,$0D
        BYT  $58,$51,$40,$7C,$0A,$7D,$53,$00
        BYT  $23,$44,$43,$22,$09,$7B,$57,$2B
        BYT  $D0,$01

VECTOR_NMI     
        BYT  $47,$02

VECTOR_RESET   
        BYT  $8F,$F8

VECTOR_IRQ     
        BYT  $44,$02


