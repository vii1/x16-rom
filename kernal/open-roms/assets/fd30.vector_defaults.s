.if ROM_LAYOUT_STD || (ROM_LAYOUT_M65 && SEGMENT_KERNAL_0)

;
; Default values for Kernal vectors - described in:
;
; - [RG64] C64 Programmers Reference Guide   - page 293 (RESTOR), 304 (VECTOR)
; - [CM64] Computes Mapping the Commodore 64 - page 237
;

vector_defaults:
	.word default_irq_handler    ; CINV
	.word default_brk_handler    ; CBINV
	.word default_nmi_handler    ; NMINV

	.word OPEN                   ; IOPEN
	.word CLOSE                  ; ICLOSE
	.word CHKIN                  ; ICHKIN
	.word CKOUT                  ; ICKOUT
	.word CLRCHN                 ; ICLRCH
	.word CHRIN                  ; IBASIN
	.word CHROUT                 ; IBSOUT
	.word STOP                   ; ISTOP
	.word GETIN                  ; IGETIN
	.word CLALL                  ; ICLALL
	.word default_brk_handler    ; USRCMD
	.word LOAD                   ; ILOAD 
	.word SAVE                   ; ISAVE


.endif ; ROM layout
