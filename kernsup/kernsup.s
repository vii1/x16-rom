.include "../banks.inc"

.import bjsrfar, banked_irq

.macro bridge_internal segment, symbol
	.local address
	.segment segment
address = *
	.segment "KERNSUP"
symbol:
	jsr bjsrfar
	.word address
	.byte BANK_KERNAL
	rts
	.segment segment
	jmp symbol
.endmacro

.macro bridge symbol
	bridge_internal "KERNSUPV", symbol
.endmacro

	.segment "KERNSUPV"

	.byte 0,0,0            ; $FEE1
	.byte 0,0,0            ; $FEE4
	.byte 0,0,0            ; $FEE7
	.byte 0,0,0            ; $FEEA
	.byte 0,0,0            ; $FEED
	.byte 0,0,0            ; $FEF0
	.byte 0,0,0            ; $FEF3
	.byte 0,0,0            ; $FEF6

	bridge GRAPH_LL_init                ; $FEF9
	bridge GRAPH_LL_get_info            ; $FEFC
	bridge GRAPH_LL_cursor_position     ; $FEFF
	bridge GRAPH_LL_cursor_next_line    ; $FF02
	bridge GRAPH_LL_get_pixel           ; $FF05
	bridge GRAPH_LL_get_pixels          ; $FF08
	bridge GRAPH_LL_set_pixel           ; $FF0B
	bridge GRAPH_LL_set_pixels          ; $FF0E
	bridge GRAPH_LL_set_8_pixels        ; $FF11
	bridge GRAPH_LL_set_8_pixels_opaque ; $FF14
	bridge GRAPH_LL_fill_pixels         ; $FF17
	bridge GRAPH_LL_filter_pixels       ; $FF1A
	bridge GRAPH_LL_move_pixels         ; $FF1D

	bridge GRAPH_init          ; $FF20
	bridge GRAPH_clear         ; $FF23
	bridge GRAPH_set_window    ; $FF26
	bridge GRAPH_set_colors    ; $FF29
	bridge GRAPH_draw_line     ; $FF2C
	bridge GRAPH_draw_rect     ; $FF2F
	bridge GRAPH_move_rect     ; $FF32
	bridge GRAPH_draw_oval     ; $FF35
	bridge GRAPH_draw_image    ; $FF38
	bridge GRAPH_set_font      ; $FF3B
	bridge GRAPH_get_char_size ; $FF3E
	bridge GRAPH_put_char      ; $FF41
	bridge monitor             ; $FF44: monitor
	bridge restore_basic       ; $FF47: restore_basic
	bridge close_all           ; $FF4A: CLOSE_ALL – close all files on a device
	bridge clock_set_date_time ; $FF4D: clock_set_date_time - set date and time
	bridge clock_get_date_time ; $FF50: clock_get_date_time - get date and time
	bridge joystick_scan       ; $FF53: joystick_scan
	bridge joystick_get        ; $FF56: joystick_get
	bridge lkupla              ; $FF59: LKUPLA
	bridge lkupsa              ; $FF5C: LKUPSA
	bridge swapper             ; $FF5F: SWAPPER – switch between 40 and 80 columns
	.byte 0,0,0                ; $FF62: DLCHR – init 80-col character RAM  [NYI]
	.byte 0,0,0                ; $FF65: PFKEY – program a function key [NYI]
	bridge mouse_config        ; $FF68: mouse_config
	bridge mouse_get           ; $FF6B: mouse_get
	jmp bjsrfar                ; $FF6E: JSRFAR – gosub in another bank
	.byte 0,0,0                ; $FF71: JMPFAR – goto another bank
	bridge indfet              ; $FF74: FETCH – LDA (fetvec),Y from any bank
	bridge stash               ; $FF77: STASH – STA (stavec),Y to any bank
	bridge cmpare              ; $FF7A: CMPARE – CMP (cmpvec),Y to any bank
	bridge primm               ; $FF7D: PRIMM – print string following the caller’s code

	.byte $ff                  ; space for KERNAL version

	bridge cint
	bridge ioinit
	bridge ramtas

	bridge restor
	bridge vector

	bridge setmsg
	bridge secnd
	bridge tksa
	bridge memtop
	bridge membot
	bridge scnkey
	bridge settmo
	bridge acptr
	bridge ciout
	bridge untlk
	bridge unlsn
	bridge listn
	bridge talk
	bridge readst
	bridge setlfs
	bridge setnam
	bridge open
	bridge close
	bridge chkin
	bridge ckout
	bridge clrch
	bridge basin
	bridge bsout
	bridge loadsp
	bridge savesp
	bridge settim
	bridge rdtim
	bridge stop
	bridge getin
	bridge clall
	bridge udtim
	bridge scrorg
	bridge plot
	bridge iobase

	;private
	jmp monitor
	.byte 0

	.word $ffff ; nmi
	.word $ffff ; reset
	.word banked_irq

