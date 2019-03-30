# bigchars
Z80 code for a ZX81 to "plot" large characters onto the screen

Use m4 macro processing and z80asm assembler as part of z80dk to create a routine
which converts ascii to "plot characters" on the screen.

ZX81 does not use ascii, so subtract 32 from the ascii character value, then use a
lookup table to convert to ZX81 character.

For a given ZX81 character, lookup the 8 byte character definition in the ROM.
Take the 1st 2 bits of the 1st 2 bytes of the character definition, and convert
to a 4 bit number, 0-15 thus:

| bit 1 | bit 0 |
| ----- |-------|
| bit 3 | bit 2 |

