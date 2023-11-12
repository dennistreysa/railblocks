INCLUDE "defines.inc"
INCLUDE "interrupts.inc"
INCLUDE "visuals.inc"

IF !DEF(MACROS_INC)
    
    DEF MACROS_INC EQU 1


    ; ------------------------------------------------------------------------------
    ; `macro StackInit()`
    ;
    ; Initializes the stack pointer
    ; ------------------------------------------------------------------------------
    MACRO StackInit
        ld sp, $0FFFE
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro DisableAudio()`
    ;
    ; Disables the audio
    ; ------------------------------------------------------------------------------
    MACRO DisableAudio
        xor a, a
        ld [rNR52], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro memcpy()`
    ;
    ; Copy `bc` bytes from `de` to `hl`  
    ;
    ; - `bc` - The number of bytes to copy
    ; - `de` - Source
    ; - `hl` - Destination
    ; ------------------------------------------------------------------------------
    MACRO memcpy
    .loop\@
        ld a, [de]
        ldi [hl], a
        inc de
        dec bc
        ld a, b
        or a, c
        jr nz, .loop\@
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro memset()`
    ;
    ; Write `d` to the buffer in `hl` for the length of `bc`  
    ;
    ; - `bc` - The number of bytes to write to
    ; - `d` - The byte to write
    ; - `hl` - Destination
    ; ------------------------------------------------------------------------------
    MACRO memset
    .loop\@
        ld a, d
        ldi [hl], a
        dec bc
        ld a, b
        or a, c
        jr nz, .loop\@
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro memset8()`
    ;
    ; Write `a` to the buffer in `hl` for the length of `c`  
    ;
    ; - `c` - The number of bytes to write to
    ; - `d` - The byte to write
    ; - `hl` - Destination
    ; ------------------------------------------------------------------------------
    MACRO memset8
    .loop\@
        ldi [hl], a
        dec c
        jr nz, .loop\@
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro BusyWait()`
    ;
    ; Decrements until `bc`is zero
    ;
    ; - `bc` - The wait value
    ; ------------------------------------------------------------------------------
    MACRO BusyWait
    .loop\@
        dec bc
        ld a, b
        or a, c
        jr nz, .loop\@
    ENDM

    MACRO PUSH_ALL
        push af
        push bc
        push de
        push hl
    ENDM

    MACRO POP_ALL
        pop hl
        pop de
        pop bc
        pop af
    ENDM

    MACRO PUSH_AFBCDE
        push af
        push bc
        push de
    ENDM

    MACRO POP_DEBCAF
        pop de
        pop bc
        pop af
    ENDM

ENDC