; #LAYOUT# STD *        #TAKE
; #LAYOUT# *   KERNAL_0 #TAKE
; #LAYOUT# *   *        #IGNORE

;
; CHROUT routine - screen support, INS key handling
;


chrout_screen_INS:

	; First check if last character of the logical line is space
	
	jsr screen_check_space_ends_line
	beq chrout_screen_ins_possible

	; Not space, we cannot insert anything

	bne_16 chrout_screen_done

chrout_screen_ins_possible:

	; Move chars towards end of the line
	jsr screen_get_logical_line_end_ptr

	; Special handling for cursor in second line
	ldx TBLX
	lda LDTBL+0, x
	bpl chrout_screen_ins_second_line

	; Perform character copy
	jsr chrout_screen_ins_copy_loop

	; Put space in the inserted gap
	lda #$20
	jsr screen_set_char

	; If line does not end with space now, try to grow the logical line
	
	jsr screen_check_space_ends_line
	beq chrout_screen_ins_done
	jsr screen_grow_logical_line

	; FALLTROUGH

chrout_screen_ins_done:

	; End of processing
	jmp chrout_screen_calc_lptr_done

chrout_screen_ins_second_line:

	; Adapt PNTR for copying
	lda PNTR
	sec
	sbc llen
	sta PNTR

	; Perform character copy
	jsr chrout_screen_ins_copy_loop

	; Put space in the inserted gap
	lda #$20
	jsr screen_set_char

	; End of processing
	bne chrout_screen_ins_done         ; branch always

chrout_screen_ins_copy_loop:

	; Note: While the following routine is obvious to any skilled
	; in the art as the most obvious simple and efficient solution,
	; if the screen writes are before the colour writes, it results
	; in a relatively long verbatim stretch of bytes when compared to
	; the C64 KERNAL.  Thus we have swapped the order, just to reduce
	; the potential for any argument of copyright infringement, even
	; though we really do not believe that the routine can be copyrighted
	; due to the lack of creativity.
	dey
	jsr screen_get_color
	iny
	jsr screen_set_color
	dey
	jsr screen_get_char
	iny
	jsr screen_set_char

	dey
	cpy PNTR
	bne chrout_screen_ins_copy_loop

	; Increase insert mode count (which causes quote-mode like behaviour)
	inc INSRT

	; Return from loop
	rts
