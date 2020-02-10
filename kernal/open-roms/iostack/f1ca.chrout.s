; #LAYOUT# STD *        #TAKE
; #LAYOUT# *   KERNAL_0 #TAKE
; #LAYOUT# *   *        #IGNORE

;
; Official Kernal routine, described in:
;
; - [RG64] C64 Programmers Reference Guide   - page 278/279
; - [CM64] Computes Mapping the Commodore 64 - page 228
;
; CPU registers that has to be preserved (see [RG64]): .Y
; Additionally we have to preserve .X for out CHRIN and implementation
;

CHROUT:

	sta SCHAR

	; Save X and Y values
	; (Confirmed by writing a test program that X and Y
	; do not get modified, in agreement with C64 PRG
	; description of CHROUT)

	phx_trash_a
	phy_trash_a

	php

	; Determine the device number
	lda DFLTO

	cmp #$03 ; screen
	beq_16 chrout_screen

.if HAS_RS232
	cmp #$02 
	beq_16 chrout_rs232
.endif

.if CONFIG_IEC
	jsr iec_check_devnum_oc
	bcc_16 chrout_iec
.endif

	; FALLTROUGH

chrout_done_fail:

	plp

	; Restore X and Y
	ply_trash_a
	plx_trash_a

	sec ; indicate failure
	rts

chrout_done_unknown_device:

	plp

	; Restore X and Y
	ply_trash_a
	plx_trash_a

	; End wioth error
	jmp lvs_device_not_found_error

chrout_done_success:
	
	plp
	cli ; needed for screen (checked calling the routine on original ROMs), XXX what about other devices?

	; Restore X and Y
	ply_trash_a
	plx_trash_a

	lda SCHAR
	clc ; indicate success
	rts
