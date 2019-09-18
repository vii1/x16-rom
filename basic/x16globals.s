;
; init X16 globals
;
initx16	lda #0
		sta grflags
		rts

.segment "BASICRAM"
grflags	.res 1		; Flags for graphic functions
					; bit 0 = active layer (1=layer 2)
