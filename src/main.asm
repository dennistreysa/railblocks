INCLUDE "hardware.inc"
INCLUDE "macros.inc"


SECTION "palettes", ROM0

Palette0: DB $00, $00, $4a, $29, $b5, $56, $ff, $7f


SECTION	"header", ROM0[$0100]


EntryPoint:
    ; Directly disable interrupts
    di

    ; This is where the user code starts.
    ; We directly jump to the main since the following bytes are for the header and are later added by RGBFIX
    jp	Main

    ; This is filled with the header code by RGBFIX
    ; Means: Fill everything from this address with zeros, padded to $50 bytes
    ds $150 - @, 0


SECTION	"main", ROM0

Main:
	
	StackInit

	call AudioInit
	call VisualsInit
	call TimeInit
	call GameInit

	EnableLCD
	EnableBackground
	EnableSprites

	WaitForVblank

	; enable interrupts globally
	ei
:
	
	call GameUpdate
    
	jr :-