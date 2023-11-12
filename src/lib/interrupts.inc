INCLUDE "hardware.inc"


; Macros to work with interrupts

IF !DEF(INTERRUPTS_INC)
    
    DEF INTERRUPTS_INC EQU 1


    ; ------------------------------------------------------------------------------
    ; `macro IntEnableVblank()`
    ;
    ; Enables the Vblank interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntEnableVblank
        ld a, [rIE]
        or a, IEF_VBLANK
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntDisableVblank()`
    ;
    ; Enables the Vblank interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntDisableVblank
        ld a, [rIE]
        and a, (0xff - IEF_VBLANK)
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntEnableStat()`
    ;
    ; Enables the Stat interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntEnableStat
        ld a, [rIE]
        or a, IEF_STAT
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntDisableStat()`
    ;
    ; Enables the Stat interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntDisableStat
        ld a, [rIE]
        and a, (0xff - IEF_STAT)
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntEnableTimer()`
    ;
    ; Enables the Timer interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntEnableTimer
        ld a, [rIE]
        or a, IEF_TIMER
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntDisableTimer()`
    ;
    ; Enables the Timer interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntDisableTimer
        ld a, [rIE]
        and a, (0xff - IEF_TIMER)
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntEnableSerial()`
    ;
    ; Enables the Serial interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntEnableSerial
        ld a, [rIE]
        or a, IEF_SERIAL
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntDisableSerial()`
    ;
    ; Enables the Serial interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntDisableSerial
        ld a, [rIE]
        and a, (0xff - IEF_SERIAL)
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntEnableJoypad()`
    ;
    ; Enables the Joypad interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntEnableJoypad
        ld a, [rIE]
        or a, IEF_HILO
        ld [rIE], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro IntDisableJoypad()`
    ;
    ; Enables the Joypad interrupt
    ; ------------------------------------------------------------------------------
    MACRO IntDisableJoypad
        ld a, [rIE]
        and a, (0xff - IEF_HILO)
        ld [rIE], a
    ENDM

ENDC