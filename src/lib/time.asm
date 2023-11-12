INCLUDE "macros.inc"
INCLUDE "interrupts.inc"


; Private member
SECTION "time_member", WRAM0

Current_Time:    DL


SECTION "time_methods", ROM0


; ------------------------------------------------------------------------------
; `func TimeInit()`
;
; Initializes the timer module
; ------------------------------------------------------------------------------
TimeInit:

    PUSH_AFBCDE

    ld bc, 4
    ld d, 0
    ld hl, Current_Time
    memset

    ; Settings:
    ; 1ms TMA=67, TAC=10
    ; 10ms TMA=168, TAC=11
    ; 50ms TMA=209, TAC=00

    ; Set up timer to trigger once per ms

    ; Register the callback
    ld hl, TimerCallback
    call RegisterIRQTimer

    ; Set timer modulo to 67
    ld a, (255 - (67 - 1))
    ld [rTMA], a

    ; Set clock select to (CPU Clock / 64) := 67110 Hz
    ld a, %00000110
    ld [rTAC], a

    ;  This should result in 67110/67 -> 1001.6 Hz

    ; Finally, enable the timer interrupt
    IntEnableTimer

    POP_DEBCAF

    ret


; ------------------------------------------------------------------------------
; `func TimerCallback()`
;
; Is called when the timer overflows
; ------------------------------------------------------------------------------
TimerCallback:
    
    push af
    push hl

    ld hl, Current_Time

    ; Byte 0
    ld a, [hl]
    add a, 1        ; Note: "inc a" won't set the carry flag
    ldi [hl], a
    ld a, 0         ; Note: "xor a, a" will delete the carry flag
    
    ; Byte 1
    adc a, [hl]
    ldi [hl], a
    ld a, 0

    ; Byte 2
    ;adc a, [hl]
    ;ldi [hl], a
    ;ld a, 0

    ; Byte 3
    ;adc a, [hl]
    ;ldi [hl], a
    ;ld a, 0

    pop hl
    pop af
    
    ret

; ------------------------------------------------------------------------------
; `func GetTime()`
;
; Is called when the timer overflows
; ------------------------------------------------------------------------------
GetTime8:
    di