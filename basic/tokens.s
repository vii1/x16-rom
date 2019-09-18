	.segment "LOBASIC"
	.word init       ;c000 hard reset
	.word panic      ;c000 soft reset
	.byt "CBMBASIC"
stmdsp	.word end-1
	.word for-1
	.word next-1
	.word data-1
	.word inputn-1
	.word input-1
	.word dim-1
	.word read-1
	.word let-1
	.word goto-1
	.word run-1
	.word if-1
	.word restor-1
	.word gosub-1
	.word return-1
	.word rem-1
	.word stop-1
	.word ongoto-1
	.word fnwait-1
	.word cload-1
	.word csave-1
	.word cverf-1
	.word def-1
	.word poke-1
	.word printn-1
	.word print-1
	.word cont-1
	.word list-1
	.word clear-1
	.word cmd-1
	.word csys-1 
	.word copen-1
	.word cclos-1
	.word get-1
	.word scrath-1
fundsp	.word sgn
	.word int
	.word abs
usrloc	.word usrpok
	.word fre
	.word pos
	.word sqr
	.word rnd
	.word log
	.word exp
	.word cos
	.word sin
	.word tan
	.word atn
	.word peek
	.word len
	.word strd
	.word val
	.word asc
	.word chrd
	.word leftd
	.word rightd
	.word midd
optab	.byt 121
	.word faddt-1
	.byt 121
	.word fsubt-1
	.byt 123
	.word fmultt-1
	.byt 123
	.word fdivt-1
	.byt 127
	.word fpwrt-1
	.byt 80
	.word andop-1
	.byt 70
	.word orop-1
negtab	.byt 125
	.word negop-1 
nottab	.byt 90
	.word notop-1
ptdorl	.byt 100
	.word dorel-1
q=128-1

.ifndef C64
stmdsp2	; statements
	.word monitor-1
	.word dos-1
	.word vpoke-1
	.word st_layer-1
	; functions
	.word vpeek
.endif

reslst	.byt "EN",'D'+$80
endtk	=$80
	.byt "FO",'R'+$80
fortk	=$81
	.byt "NEX",'T'+$80
	.byt "DAT",'A'+$80
datatk	=$83
	.byt "INPUT",'#'+$80
	.byt "INPU",'T'+$80
	.byt "DI",'M'+$80
	.byt "REA",'D'+$80
	.byt "LE",'T'+$80
	.byt "GOT",'O'+$80
gototk	=$89
	.byt "RU",'N'+$80
	.byt "I",'F'+$80
	.byt "RESTOR",'E'+$80
	.byt "GOSU",'B'+$80
gosutk	=$8d
	.byt "RETUR",'N'+$80
	.byt "RE",'M'+$80
remtk	=$8f
	.byt "STO",'P'+$80
	.byt "O",'N'+$80
tk_on = $91
	.byt "WAI",'T'+$80
	.byt "LOA",'D'+$80
	.byt "SAV",'E'+$80
	.byt "VERIF",'Y'+$80
	.byt "DE",'F'+$80
	.byt "POK",'E'+$80
	.byt "PRINT",'#'+$80
	.byt "PRIN",'T'+$80
printk	=$99
	.byt "CON",'T'+$80
	.byt "LIS",'T'+$80
	.byt "CL",'R'+$80
	.byt "CM",'D'+$80
	.byt "SY",'S'+$80
	.byt "OPE",'N'+$80
	.byt "CLOS",'E'+$80
	.byt "GE",'T'+$80
	.byt "NE",'W'+$80
scratk	=$a2

