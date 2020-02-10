; #LAYOUT# STD *        #TAKE
; #LAYOUT# *   KERNAL_0 #TAKE
; #LAYOUT# *   *        #IGNORE


screen_get_logical_line_end_ptr:

	ldy TBLX
	cpy nlinesm1
	bcs screen_get_logical_line_end_39 ; last line of the screen

	lda LDTBL+0, y
	bpl screen_get_logical_line_end_39 ; current line continues previous one

	lda LDTBL+1, y
	bmi screen_get_logical_line_end_39 ; current line is not continued

	; FALLTROUGH

screen_get_logical_line_end_79:

	lda llen
	asl
	tay
	dey
	rts

screen_get_logical_line_end_39:

	ldy llen
	dey
	rts
