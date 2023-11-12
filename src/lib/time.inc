INCLUDE "hardware.inc"


; Macros to work with time

IF !DEF(TIME_INC)
    
    DEF TIME_INC EQU 1

    ; ------------------------------------------------------------------------------
    ; `macro GetTime8()`
    ;
    ; Returns the lowest byte of the internal time
    ;
    ; - `a` - Holds the time
    ; ------------------------------------------------------------------------------
    MACRO GetTime8
        ; No interrupt disable needed, this is already atomic
        ld a, [Current_Time]
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro GetTime8()`
    ;
    ; Returns the lower 2 bytes of the internal time
    ;
    ; - `hl` - Holds the time
    ; ------------------------------------------------------------------------------
    MACRO GetTime16
        di
        ld a, [Current_Time]
        ld l, a
        ld a, [Current_Time + 1]
        ld h, a
        ei
    ENDM


ENDC