; The tiles data

IF !DEF(TILES_INC)
    
    DEF TILES_INC EQU 1


	SECTION "Tile data", ROM0

	TILES:
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $3C,$3C,$3C,$00,$3C,$14,$01,$7E
		DB $80,$3C,$00,$3C,$40,$24,$04,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
		DB $00,$00,$00,$00,$00,$00,$00,$00
	.end

ENDC