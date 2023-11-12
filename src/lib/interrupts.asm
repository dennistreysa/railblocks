INCLUDE "hardware.inc"

;
;   RST Handlers
;
SECTION "rst_irq_user_handler", ROM0[$30]
    jp hl


;
;   Interrupt Handlers
;
SECTION "irq_stub_vblank", ROM0[INT_HANDLER_VBLANK]
    jp IRQ_Vblank

SECTION "irq_stub_stat", ROM0[INT_HANDLER_STAT]
    jp IRQ_Stat

SECTION "irq_stub_timer", ROM0[INT_HANDLER_TIMER]
    jp IRQ_Timer

SECTION "irq_stub_serial", ROM0[INT_HANDLER_SERIAL]
    jp IRQ_Serial

SECTION "irq_stub_joypad", ROM0[INT_HANDLER_JOYPAD]
    jp IRQ_Joypad


;
;   User interrupt callback addresses
;
SECTION "irq_user_handler", WRAM0

IRQ_Vblank_User:    DW
IRQ_Stat_User:      DW
IRQ_Timer_User:     DW
IRQ_Serial_User:    DW
IRQ_Joypad_User:    DW


SECTION "irq_implementations", ROM0

; ------------------------------------------------------------------------------
; `func IRQ_Vblank()`
;
; IRQ handler for the Vblank interrupt
; ------------------------------------------------------------------------------
IRQ_Vblank:

    ; Save the registers we are going to use first
    push af
    push hl

    ; Load callback address into hl
    ld a, [IRQ_Vblank_User]
    ld l, a
    ld a, [IRQ_Vblank_User + 1]
    ld h, a

    ; Check if it is in use
    or a, l

    jr z, .no_callback

    ; Jump to the rst handler at 0x30
    rst $30

.no_callback:
    ; Restore the registers
    pop hl
    pop af

    reti


; ------------------------------------------------------------------------------
; `func RegisterIRQVblank()`
;
; Registers an IRQ handler for the Vblank interrupt
; Note: Will disable, but NOT enable the interrupts
;
; - `hl` - The addres of the handler
; ------------------------------------------------------------------------------
RegisterIRQVblank:

    push af

    di

    ld a, l
    ld [IRQ_Vblank_User], a
    ld a, h
    ld [IRQ_Vblank_User + 1], a

    pop af

    ret


    ; ------------------------------------------------------------------------------
; `func UnRegisterIRQVblank()`
;
; Un-Registers an IRQ handler for the Vblank interrupt
; Note: Will disable, but NOT enable the interrupts
; ------------------------------------------------------------------------------
UnRegisterIRQVblank:

    push hl

    ld hl, 0
    call RegisterIRQVblank

    pop hl

    ret


; ------------------------------------------------------------------------------
; `func IRQ_Stat()`
;
; IRQ handler for the Stat interrupt
; ------------------------------------------------------------------------------
IRQ_Stat:

    ; Save the registers we are going to use first
    push af
    push hl

    ; Load callback address into hl
    ld a, [IRQ_Stat_User]
    ld l, a
    ld a, [IRQ_Stat_User + 1]
    ld h, a

    ; Check if it is in use
    or a, l

    jr z, .no_callback

    ; Jump to the rst handler at 0x30
    rst $30

.no_callback:
    ; Restore the registers
    pop hl
    pop af

    reti


; ------------------------------------------------------------------------------
; `func RegisterIRQStat()`
;
; Registers an IRQ handler for the Stat interrupt
; Note: Will disable, but NOT enable the interrupts
;
; - `hl` - The addres of the handler
; ------------------------------------------------------------------------------
RegisterIRQStat:

    push af

    di

    ld a, l
    ld [IRQ_Stat_User], a
    ld a, h
    ld [IRQ_Stat_User + 1], a

    pop af

    ret


    ; ------------------------------------------------------------------------------
; `func UnRegisterIRQStat()`
;
; Un-Registers an IRQ handler for the Stat interrupt
; Note: Will disable, but NOT enable the interrupts
; ------------------------------------------------------------------------------
UnRegisterIRQStat:

    push hl

    ld hl, 0
    call RegisterIRQStat

    pop hl

    ret


; ------------------------------------------------------------------------------
; `func IRQ_Timer()`
;
; IRQ handler for the Timer interrupt
; ------------------------------------------------------------------------------
IRQ_Timer:

    ; Save the registers we are going to use first
    push af
    push hl

    ; Load callback address into hl
    ld a, [IRQ_Timer_User]
    ld l, a
    ld a, [IRQ_Timer_User + 1]
    ld h, a

    ; Check if it is in use
    or a, l

    jr z, .no_callback

    ; Jump to the rst handler at 0x30
    rst $30

.no_callback:
    ; Restore the registers
    pop hl
    pop af

    reti


; ------------------------------------------------------------------------------
; `func RegisterIRQTimer()`
;
; Registers an IRQ handler for the Timer interrupt
; Note: Will disable, but NOT enable the interrupts
;
; - `hl` - The addres of the handler
; ------------------------------------------------------------------------------
RegisterIRQTimer:

    push af

    di

    ld a, l
    ld [IRQ_Timer_User], a
    ld a, h
    ld [IRQ_Timer_User + 1], a

    pop af

    ret


    ; ------------------------------------------------------------------------------
; `func UnRegisterIRQTimer()`
;
; Un-Registers an IRQ handler for the Timer interrupt
; Note: Will disable, but NOT enable the interrupts
; ------------------------------------------------------------------------------
UnRegisterIRQTimer:

    push hl

    ld hl, 0
    call RegisterIRQTimer

    pop hl

    ret


; ------------------------------------------------------------------------------
; `func IRQ_Joypad()`
;
; IRQ handler for the Joypad interrupt
; ------------------------------------------------------------------------------
IRQ_Joypad:

    ; Save the registers we are going to use first
    push af
    push hl

    ; Load callback address into hl
    ld a, [IRQ_Joypad_User]
    ld l, a
    ld a, [IRQ_Joypad_User + 1]
    ld h, a

    ; Check if it is in use
    or a, l

    jr z, .no_callback

    ; Jump to the rst handler at 0x30
    rst $30

.no_callback:
    ; Restore the registers
    pop hl
    pop af

    reti


; ------------------------------------------------------------------------------
; `func RegisterIRQJoypad()`
;
; Registers an IRQ handler for the Joypad interrupt
; Note: Will disable, but NOT enable the interrupts
;
; - `hl` - The addres of the handler
; ------------------------------------------------------------------------------
RegisterIRQJoypad:

    push af

    di

    ld a, l
    ld [IRQ_Joypad_User], a
    ld a, h
    ld [IRQ_Joypad_User + 1], a

    pop af

    ret


    ; ------------------------------------------------------------------------------
; `func UnRegisterIRQJoypad()`
;
; Un-Registers an IRQ handler for the Joypad interrupt
; Note: Will disable, but NOT enable the interrupts
; ------------------------------------------------------------------------------
UnRegisterIRQJoypad:

    push hl

    ld hl, 0
    call RegisterIRQJoypad

    pop hl

    ret

    
; ------------------------------------------------------------------------------
; `func IRQ_Serial()`
;
; IRQ handler for the Serial interrupt
; ------------------------------------------------------------------------------
IRQ_Serial:

    ; Save the registers we are going to use first
    push af
    push hl

    ; Load callback address into hl
    ld a, [IRQ_Serial_User]
    ld l, a
    ld a, [IRQ_Serial_User + 1]
    ld h, a

    ; Check if it is in use
    or a, l

    jr z, .no_callback

    ; Jump to the rst handler at 0x30
    rst $30

.no_callback:
    ; Restore the registers
    pop hl
    pop af

    reti


; ------------------------------------------------------------------------------
; `func RegisterIRQSerial()`
;
; Registers an IRQ handler for the Serial interrupt
; Note: Will disable, but NOT enable the interrupts
;
; - `hl` - The addres of the handler
; ------------------------------------------------------------------------------
RegisterIRQSerial:

    push af

    di

    ld a, l
    ld [IRQ_Serial_User], a
    ld a, h
    ld [IRQ_Serial_User + 1], a

    pop af

    ret


    ; ------------------------------------------------------------------------------
; `func UnRegisterIRQSerial()`
;
; Un-Registers an IRQ handler for the Serial interrupt
; Note: Will disable, but NOT enable the interrupts
; ------------------------------------------------------------------------------
UnRegisterIRQSerial:

    push hl

    ld hl, 0
    call RegisterIRQSerial

    pop hl

    ret
