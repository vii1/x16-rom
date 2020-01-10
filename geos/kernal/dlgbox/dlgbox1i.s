; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: up/down button

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "gkernal.inc"
.include "c64.inc"

.global DBGFArrowPic

.segment "dlgbox1i"

DBGFArrowPic:
.ifdef wheels_dlgbox_features
	.byte 10, %11111111 ; repeat 10
	.byte $80+2 ; 2 data bytes
	.byte                     %10000000, %00000001
	.byte 4, %10000001 ; repeat 4
	.byte $80 + 36
	;     %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111
	;     %11111111,%11111111,%10000000,%00000001,%10000001,%10000001,%10000001,%10000001
	.byte %11111111,%11111111,%10000000,%00000001,%10000011,%11000001,%10000001,%10000001
	.byte %10000000,%00000001,%10000000,%00000001,%10000111,%11100001,%10001111,%11110001
	.byte %10000000,%00000001,%10000000,%00000001,%10001111,%11110001,%10000111,%11100001
	.byte %10000000,%00000001,%11111111,%11111111,%10000001,%10000001,%10000011,%11000001
	.byte %10000000,%00000001,%11111111,%11111111;%10000001,%10000001,%10000001,%10000001
	;     %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111
	.byte 4, %10000001 ; repeat 4
	.byte 8, %11111111 ; repeat 8

	.byte 8, $bf ; ??? unused
.else
	.byte 3, %11111111, $80+(10*3)
	     ;%11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000001 ;1
	.byte %10000000, %00000000, %00000001 ;2
	.byte %10000010, %00000000, %11100001 ;3
	.byte %10000111, %00000111, %11111101 ;4
	.byte %10001111, %10000011, %11111001 ;5
	.byte %10011111, %11000001, %11110001 ;6
	.byte %10111111, %11100000, %11100001 ;7
	.byte %10000111, %00000000, %01000001 ;8
	.byte %10000000, %00000000, %00000001 ;9
	.byte %10000000, %00000000, %00000001 ;10
	     ;%11111111, %11111111, %11111111
	.byte 3, %11111111
.endif

