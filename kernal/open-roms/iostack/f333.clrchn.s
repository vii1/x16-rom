; #LAYOUT# STD *        #TAKE
; #LAYOUT# *   KERNAL_0 #TAKE
; #LAYOUT# *   *        #IGNORE

;
; Official Kernal routine, described in:
;
; - [RG64] C64 Programmers Reference Guide   - page 282
; - [CM64] Computes Mapping the Commodore 64 - page 230
;
; CPU registers that has to be preserved (see [RG64]): .Y
;


CLRCHN:

	jsr clrchn_iec

	; FALLTROUGH

clrchn_reset: ; entry needed by setup_vicii

	; Set input device number to keyboard
	lda #$00
	sta DFLTN

	; Set output device number to screen
	lda #$03
	sta DFLTO

	rts
