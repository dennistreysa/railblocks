INCLUDE "hardware.inc"


; Macros to work with interrupts

IF !DEF(VISUALS_INC)
    
    DEF VISUALS_INC EQU 1


    ; ------------------------------------------------------------------------------
    ; `macro WaitForVblank()`
    ;
    ; Loops until the LCD enters the vertical blanking period by reading the 
    ; current horizontal scan-line and comparing it to 144 at which point all the
    ; data is transmitted and the V-Blank period begins. V-Blank is from 144 to 153 
    ; ------------------------------------------------------------------------------
    MACRO WaitForVblank
    .loop\@
        ld a, [rLY]
        cp a, SCRN_Y
        jr c, .loop\@
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro WaitForVblankEnd()`
    ;
    ; Loops until the LCD exits the vertical blanking period.
    ; ------------------------------------------------------------------------------
    MACRO WaitForVblankEnd
    .loop\@
        ld a, [rLY]
        cp SCRN_Y
        jr nc, .loop\@
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro VSync()`
    ;
    ; Waits for V-blank then waits for V-blank-end
    ; ------------------------------------------------------------------------------
    MACRO VSync
        WaitForVblank
        WaitForVblankEnd
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro WaitForFreshVblank()`
    ;
    ; Waits for V-blank then waits for V-blank-end and waits for V-blank again
    ; ------------------------------------------------------------------------------
    MACRO WaitForFreshVblank
        WaitForVblank
        WaitForVblankEnd
        WaitForVblank
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro DisableLCD()`
    ;
    ; Disables the LCD
    ; ------------------------------------------------------------------------------
    MACRO DisableLCD
        WaitForFreshVblank
        ld a, [rLCDC]
        and a, ($ff - LCDCF_ON)
        ld [rLCDC], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro EnableLCD()`
    ;
    ; Enables the LCD
    ; ------------------------------------------------------------------------------
    MACRO EnableLCD
        ld a, [rLCDC]
        or a, LCDCF_ON
        ld [rLCDC], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro EnableBackground()`
    ;
    ; Enables the background
    ; ------------------------------------------------------------------------------
    MACRO EnableBackground
        ld a, [rLCDC]
        or a, LCDCF_BGON
        ld [rLCDC], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro EnableSprites()`
    ;
    ; Enables the sprites
    ; ------------------------------------------------------------------------------
    MACRO EnableSprites
        ld a, [rLCDC]
        or a, LCDCF_OBJON
        ld [rLCDC], a
    ENDM


    ; ------------------------------------------------------------------------------
    ; `macro EnableSprites()`
    ;
    ; Enables the sprites
    ; ------------------------------------------------------------------------------
    MACRO DisableSprites
        WaitForFreshVblank
        ld a, [rLCDC]
        and a, ($ff - LCDCF_OBJON)
        ld [rLCDC], a
    ENDM

ENDC