INCLUDE "hardware.inc"
INCLUDE "macros.inc"


SECTION "audio", ROM0


; ------------------------------------------------------------------------------
; `func AudioInit()`
;
; Initializes the audio
; ------------------------------------------------------------------------------
AudioInit:
    
    DisableAudio
    
    ret