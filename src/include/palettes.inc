; The palette data

IF !DEF(PALETTES_INC)
    
    DEF PALETTES_INC EQU 1


	SECTION "Palette data", ROM0

    PALETTE_BACKGROUND:
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
		DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
        DB $00, $00, $4a, $29, $b5, $56, $ff, $7f
	.end

ENDC