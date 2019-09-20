;
; STATEMENT: LAYER { n | ON | OFF }
; Sets current graphic layer
;
.proc st_layer
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
.endproc

;
; STATEMENT: CLS
; Clears all content in active layer, appropiately for the current mode
; e.g. -> tile mode   = clears ALL map (not only visible screen)
;         bitmap mode = clears bitmap
; Fills color information with current color ($0286)
;
.proc st_cls
count = index
        lda #1			; get active layer
		bit grflags
		bne @layer1		; select layer vaddress
		lda #$20
		.byt $2c
@layer1	lda #$30
		sta veramid
		lda #$1F        ; Bank $F, autoincrement 1
		sta verahi
		lda #0			; VERA layer register 0 (Ln_CTRL0)
		sta veralo
        lda veradat     ; Read register
        and #$e0        ; Get mode
        cmp #5          ; Tiled or bitmap?
        bcs bitmap
        lda veradat     ; Read VERA layer register 1 (Ln_CTRL1)
        tax             ; Save it in X for later
        ; count = 4 << mapv << maph
        ; repeat count times:
        ;   repeat 256 times:
        ;     write 0, attribute
        and #$03        ; Get MAPV
        tay
        lda #4          ; count = 4 << mapv
        cpy #0
        beq @a
@shl1   asl a
        dey
        bne @shl1
@a      sta count
        txa
        and #$0C        ; Get MAPH
        lsr
        lsr
        tax             ; count <<= maph
        beq getmapbase
        lda #0
        sta count+1
@shl2   asl count
        rol count+1
        dex
        bne @shl2
getmapbase              ; Get map base and setup VERA address regs
        lda veradat     ; get MAP_BASE_L
        asl
        sta poker
        lda veradat     ; get MAP_BASE_H
        rol
        sta veramid
        ldx #$10        ; autoincrement 1
        bcc @b
        inx
@b      stx verahi
        ldy $0286       ; Y = current color
        ; All set. Now we write count*256*2 bytes to VERA mem
@loop1  lda count          ; end loop if count == 0
        ora count+1
        beq done
        clc
        lda #$FF        ; count -= 1
        adc count
        sta count
        bcs @l1a
        dec count+1
@l1a    ldx #$FF        ; repeat 256 times
        lda #0
@loop2  sta veradat     ; blank space
        sty veradat     ; color attribute
        dex
        cpx #$FF
        bne @loop2      ; loop until X wraps to $FF again
        beq @loop1

done    clc             ; Move cursor to home
        ldx #0
        ldy #0
        jmp plot

        


        
bitmap

.endproc

;
; STATEMENT: COLOR fg[,bg[,border]]
;

; STATEMENT: SCALE xscale[,yscale]
; STATEMENT: BORDER ntiles
;            BORDER tbtiles,lrtiles
;            BORDER top,right,bottom,left