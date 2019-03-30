; hl = hl * 8
define(`HLT8', `add  hl, hl  ; multiply hl by 8
    add  hl, hl
    add  hl, hl')

; hl = a
define(`LD_HL_A', `ld   h, 0
    ld   l, a')

; bc = hl
define(`LD_BC_HL', `ld   b, h
    ld   c, l')

; rotate a right 4 times
define(`RRCA_4', `RRCA_2
    RRCA_2')

; rotate a right twice
define(`RRCA_2', `rrca
    rrca')

; rotate a left twice
define(`RLCA_2', `rlca
    rlca')

; hl = hl + a
define(`ADD_HL_A', `add  a, l  ; add a to HL
    ld   l, a
    adc  a, h
    sub  l
    ld   h, a  ; end of add')

; de = de + a
define(`ADD_DE_A', `ex   de, hl
    ADD_HL_A
    ex   de, hl')

; de = de - nn
define(`SUB_DE', `ex   de, hl
    ld   de, $1
    or   a
    sbc  hl, de
    ex   de, hl')

define(`SG2B', `ld   a, (hl)    ; set graphics 2 bits
    and  $1
    RRCA_2
    ld   c, a
    inc  hl
    ld   a, (hl)
    and  $1
    or   c
    $2
    push hl
      ld   hl, charmap

      ADD_HL_A
      ld   a, (hl)
    pop  hl
    ld   (de), a
    inc  de
    dec  hl')


#define d_file $400C
#define char_addr $1E00

;------------------------------------------------------------
; Start
;------------------------------------------------------------
EXTERN asc2zx81

    ld   hl, msg
    call dispstring

;back to BASIC
    ret

;Subroutines

;display a string
;write directly to the screen
.dispstring

    LD_BC_HL        ; bc now points to the dispstring

    ld   de, (d_file)  ; de points to the display file
    inc  de
    ld   a, 08

.loop
    cp   $00
    jp   nz, skip
    ld   a, 33*4 - 4*8
    ADD_DE_A
    ld   a, 08
.skip
    push af

      ld   a, (bc)  ; a now has the ascii character to display
  
      cp   $00
      jp   z, loopEnd
      call asc2zx81   ; after this, a is now a zx81 character
  
      ; multiply the character by 8 and add it to char_addr
      LD_HL_A
  
      HLT8
  
      push bc
        ld   bc, char_addr
    
        add  hl,  bc   ; hl now points to the start of the cha in the rom
    
        ld   b, 4    ; each character is 4 rows of 2
    
.loop1
        SG2B($C0, RRCA_4)
        SG2B($30, RRCA_2)
        SG2B($0C, nop)
        SG2B($03, RLCA_2)
    
        inc  hl
        inc  hl
    
        ld   a, 33 - 4  ; the next line is 33 - 4 bytes away
        ADD_DE_A
    
        dec  b
        jp   nz, loop1
  
      pop  bc
      inc  bc   ; bc again points to the next char to display
  
      SUB_DE($0080)
   
    pop  af     
    dec  a

    jp   loop

.loopEnd
    pop  af     
    ret

.msg
    defb " FRIDAY "
    defb "        "
    defb "  9:52  "
    defb "        "
    defb " 29 MAR "
    defb "        ", $00

;         01234567890123456789012345678901

.charmap
    defb $00, $02, $01, $03, $87, $85, $86, $84, $04, $06, $05, $07, $83, $81, $82, $80

