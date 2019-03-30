
; Quick routine to convert ASCII to ZX81 Characters
;------------------------------------------------------------

PUBLIC asc2zx81

; trashed hl
.asc2zx81
    sub  32
    cp   91
    jr   nc,isTooHigh
    ld   hl,zxmap
    add  a,l                    ; add a to hl - a bit convoluted
    ld   l,a
    adc  a,h
    sub  l
    ld   h,a
    ld   a,(hl)
    ret

.isTooHigh
    ld   a,0
    ret

.zxmap
    defb $00, $0C, $0B, $00, $0D, $00, $00, $00
    defb $10, $11, $17, $15, $1A, $16, $1B, $18
    defb $1C, $1D, $1E, $1F, $20, $21, $22, $23
    defb $24, $25, $0E, $19, $13, $14, $12, $0F
    defb $00, $26, $27, $28, $29, $2A, $2B, $2C
    defb $2D, $2E, $2F, $30, $31, $32, $33, $34
    defb $35, $36, $37, $38, $39, $3A, $3B, $3C
    defb $3D, $3E, $3F, $00, $00, $00, $00, $00
    defb $00, $A6, $A7, $A8, $A9, $AA, $AB, $AC
    defb $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4
    defb $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC
    defb $BD, $BE, $BF
