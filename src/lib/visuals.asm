INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "defines.inc"
INCLUDE "tiles.inc"
INCLUDE "map_game.z80"
INCLUDE "palettes.inc"


; Private member
SECTION "visuals_member", WRAM0




SECTION "visuals", ROM0


; ------------------------------------------------------------------------------
; `func VisualsInit()`
;
; Initializes the visuals (LCD etc.)
; ------------------------------------------------------------------------------
VisualsInit:
    
    DisableLCD

    call LoadTiles
    call LoadTileMap
    call ClearOAM
    call LoadPallettesBackground
    call LoadPallettesSprites


    ld a, 0
    ld b, 100
    ld c, 100
    call SetSpritePos

    ld a, 0
    ld b, 1
    call SetSpriteTile

    ld a, 0
    ld b, 0
    call SetSpriteAttributes
    
    ret


; ------------------------------------------------------------------------------
; `func LoadTiles()`
;
; Initializes the tiles
; ------------------------------------------------------------------------------
LoadTiles:

    push af
    push bc
    push de
    
    ; Copy tiles
    ld bc, TILES.end - TILES
    ld de, TILES
    ld hl, _VRAM
    memcpy

    pop de
    pop bc
    pop af
    
    ret


; ------------------------------------------------------------------------------
; `func LoadTiles()`
;
; Initializes the tiles
; ------------------------------------------------------------------------------
LoadTileMap:
 
    push af
    push bc
    push de

    ; Copy tiles
    ld bc, TILEMAP.end - TILEMAP
    ld de, TILEMAP
    ld hl, _SCRN0
    memcpy

    pop de
    pop bc
    pop af
    
    ret


; ------------------------------------------------------------------------------
; `func ClearOAM()`
;
; Clears the OAM (Object Attribute Memory) memory (sprites)
; ------------------------------------------------------------------------------
ClearOAM:
 
    PUSH_ALL

    ld c, (OAM_COUNT * 4)
    ld a, 0
    ld hl, _OAMRAM
    memset8

    POP_ALL
    
    ret


; ------------------------------------------------------------------------------
; `func LoadPallettesBackground()`
;
; Initializes the palettes for the background
; ------------------------------------------------------------------------------
LoadPallettesBackground:
 
    PUSH_ALL

    ld c, (PALETTE_BACKGROUND.end - PALETTE_BACKGROUND)

    ld a, $80
    ld [rBGPI], a
    ld hl, PALETTE_BACKGROUND

.loop:
    ld a, [hli]
    ld [rBGPD], a
    dec c
    jr nz, .loop

    POP_ALL
    
    ret


; ------------------------------------------------------------------------------
; `func LoadPallettesSprites()`
;
; Initializes the palettes for the background
; ------------------------------------------------------------------------------
LoadPallettesSprites:
 
    PUSH_ALL

    ld c, (PALETTE_BACKGROUND.end - PALETTE_BACKGROUND)

    ld a, $80
    ld [rOBPI], a
    ld hl, PALETTE_BACKGROUND

.loop:
    ld a, [hli]
    ld [rOBPD], a
    dec c
    jr nz, .loop

    POP_ALL
    
    ret


; ------------------------------------------------------------------------------
; `func SetSpritePos()`
;
; Sets the position of a given sprite
;
; - `a` - The sprite
; - `b` - The x coordinate
; - `c` - The y coordinate
; ------------------------------------------------------------------------------
SetSpritePos:

    PUSH_ALL

    ; Multiply a by 4 to get the corrent index into the OAM
    sla a
    sla a

    ; cast to 16 bit
    ld d, 0
    ld e, a

    ; Base + offset
    ld hl, _OAMRAM
    add hl, de

    ; Finally, set the position
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a

    POP_ALL

    ret


; ------------------------------------------------------------------------------
; `func SetSpriteTile()`
;
; Sets the tile index of a given sprite
;
; - `a` - The sprite
; - `b` - The index of the tile
; ------------------------------------------------------------------------------
SetSpriteTile:

    PUSH_ALL

    ; Multiply a by 4 to get the corrent index into the OAM
    sla a
    sla a

    ; Get to the offset of the tile attribute
    inc a
    inc a

    ; cast to 16 bit
    ld d, 0
    ld e, a

    ; Base + offset
    ld hl, _OAMRAM
    add hl, de

    ; Finally, set the sprite
    ld a, b
    ld [hl], a

    POP_ALL

    ret


; ------------------------------------------------------------------------------
; `func SetSpriteAttributes()`
;
; Sets the attributes of a given sprite
;
; - `a` - The sprite
; - `b` - The attributes
; ------------------------------------------------------------------------------
SetSpriteAttributes:

    PUSH_ALL

    ; Multiply a by 4 to get the corrent index into the OAM
    sla a
    sla a

    ; Get to the offset of the tile attribute
    inc a
    inc a
    inc a

    ; cast to 16 bit
    ld d, 0
    ld e, a

    ; Base + offset
    ld hl, _OAMRAM
    add hl, de

    ; Finally, set the position
    ld a, b
    ld [hl], a

    POP_ALL

    ret