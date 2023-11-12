INCLUDE "macros.inc"
INCLUDE "defines.inc"
INCLUDE "time.inc"


; Private member
SECTION "game_member", WRAM0

Last_Tick:    DB
Sprite_X:     DB


SECTION "game_methods", ROM0


; ------------------------------------------------------------------------------
; `func GameInit()`
;
; Initializes the game
; ------------------------------------------------------------------------------
GameInit:

    PUSH_ALL

    ; Clear local variables
    ld c, SIZEOF("game_member")
    ld a, 0
    ld hl, STARTOF("game_member")
    memset8

    POP_ALL

    ret

; ------------------------------------------------------------------------------
; `func GameUpdate()`
;
; Performs the game update loop
; ------------------------------------------------------------------------------
GameUpdate:

    PUSH_ALL

    ld a, [Last_Tick]
    ld b, a

    ; Check if we need to update the game
    GetTime8

    ; Store current time for later use
    ld d, a

    ; a := (current - last)
    sub a, b

    sub a, GAME_TICK_TIMEOUT

    ; if ((current - last) > timeou)
    jr c, .done

    ; Perform game stuff
    ld a, [Sprite_X]
    inc a
    ld [Sprite_X], a
    ld b, a
    ld a, 0
    ld c, 100
    call SetSpritePos

    ld a, [rSCY]
    inc a
    ld [rSCY], a

    ; Write back time of last schedule
    ld a, d
    ld [Last_Tick], a

.done:
    
    POP_ALL
    
    ret