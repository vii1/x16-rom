;
; STATEMENT: LAYER { n | ON | OFF }
; Sets current graphic layer
;
st_layer
		cmp #tk_on	; 'ON' ?
		beq @enable	;  -> enable current layer
		cmp #$ce 	; escape token
		bne @getn	;  -> no 'OFF' token
		jsr chrget
		sbc #$80
		cmp #tk_off	; must be 'OFF'
		bne @errsn	; else, syntax error
@disable:
		ldx #0		; set X = enable/disable
		.byt $2c
@enable:
		ldx #1
		jsr chrget	; prepare next token for parser

		lda #1			; get active layer
		bit grflags
		bne @layer1		; select layer vaddress
		lda #$20
		.byt $2c
@layer1	lda #$30
		sta veramid
		lda #$F
		sta verahi
		lda #0			; VERA layer register 0 (Ln_CTRL0)
		sta veralo
		lda veradat		; vpeek from VERA register
		and #$FE		; clear enable bit
		cpx #1			; carry = x
		adc #0			; add carry
		sta veradat		; vpoke to VERA register
		rts
@getn:
		jsr getbyt		; get number
		cpx #2			; must be < 2
		bcs @errqt		; ...else, illegal quantity
		stx grflags		; store flag
		rts

@errsn:	ldx #11 ; syntax error
		.byt $2c
@errqt:	ldx #14	; illegal quantity
		jmp error
