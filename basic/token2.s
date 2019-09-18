	.byt "TAB",'('+$80
tabtk	=$a3
	.byt "T",'O'+$80
totk	=$a4
	.byt "F",'N'+$80
fntk	=$a5
	.byt "SPC",'('+$80
spctk	=$a6
	.byt "THE",'N'+$80
thentk	=$a7
	.byt "NO",'T'+$80
nottk	=$a8
	.byt "STE",'P'+$80
steptk	=$a9
	.byt '+'+$80
plustk	=$aa
	.byt '-'+$80
minutk	=$ab
	.byt '*'+$80
	.byt '/'+$80
	.byt '^'+$80
	.byt "AN",'D'+$80
	.byt "O",'R'+$80
	.byt '>'+$80
greatk	=$b1
	.byt '='+$80
equltk	=$b2
	.byt '<'+$80
lesstk	=$b3
	.byt "SG",'N'+$80
onefun	=$b4
	.byt "IN",'T'+$80
	.byt "AB",'S'+$80
	.byt "US",'R'+$80
	.byt "FR",'E'+$80
	.byt "PO",'S'+$80
	.byt "SQ",'R'+$80
	.byt "RN",'D'+$80
	.byt "LO",'G'+$80
	.byt "EX",'P'+$80
	.byt "CO",'S'+$80
	.byt "SI",'N'+$80
	.byt "TA",'N'+$80
	.byt "AT",'N'+$80
	.byt "PEE",'K'+$80
	.byt "LE",'N'+$80
	.byt "STR",'$'+$80
	.byt "VA",'L'+$80
	.byt "AS",'C'+$80
	.byt "CHR",'$'+$80
lasnum	=$c7
	.byt "LEFT",'$'+$80
	.byt "RIGHT",'$'+$80
	.byt "MID",'$'+$80
	.byt "G",'O'+$80
gotk	=$cb
	.byt 0

.ifndef C64
reslst2	.byt "MO", 'N' + $80
	.byt "DO", 'S' + $80
	.byt "VPOK", 'E' + $80
	.byt "SCREE", 'N' + $80
	.byt "LAYE", 'R' + $80
	.byt "VPEE", 'K' + $80
	.byt "OF",'F'+$80
	.byt 0
num_esc_statements = 5
num_esc_functions = 1
.endif

err01	.byt "TOO MANY FILE",$d3
err02	.byt "FILE OPE",$ce
err03	.byt "FILE NOT OPE",$ce
err04	.byt "FILE NOT FOUN",$c4
err05	.byt "DEVICE NOT PRESEN",$d4
err06	.byt "NOT INPUT FIL",$c5
err07	.byt "NOT OUTPUT FIL",$c5
err08	.byt "MISSING FILE NAM",$c5
err09	.byt "ILLEGAL DEVICE NUMBE",$d2
err10	.byt "NEXT WITHOUT FO",$d2
errnf	=10
err11	.byt "SYNTA",$d8
errsn	=11
err12	.byt "RETURN WITHOUT GOSU",$c2
errrg	=12
err13	.byt "OUT OF DAT",$c1
errod	=13
err14	.byt "ILLEGAL QUANTIT",$d9
errfc	=14
err15	.byt "OVERFLO",$d7
errov	=15
err16	.byt "OUT OF MEMOR",$d9
errom	=16
err17	.byt "UNDEF",$27
	.byt "D STATEMEN",$d4
errus	=17
err18	.byt "BAD SUBSCRIP",$d4
errbs	=18
err19	.byt "REDIM",$27,"D ARRA",$d9
errdd	=19
err20	.byt "DIVISION BY ZER",$cf
errdvo	=20
err21	.byt "ILLEGAL DIREC",$d4
errid	=21
err22	.byt "TYPE MISMATC",$c8
errtm	=22
err23	.byt "STRING TOO LON",$c7
errls	=23
err24	.byt "FILE DAT",$c1
errbd	=24
err25	.byt "FORMULA TOO COMPLE",$d8
errst	=25
err26	.byt "CAN",$27,"T CONTINU",$c5
errcn	=26
err27	.byt "UNDEF",$27,"D FUNCTIO",$ce
erruf	=27
err28	.byt "VERIF",$d9
ervfy	=28
err29	.byt "LOA",$c4
erload	=29

; table to translate error message #
; to address of string containing message
;
errtab	.word err01
	.word err02
	.word err03
	.word err04
	.word err05
	.word err06
	.word err07
	.word err08
	.word err09
	.word err10
	.word err11
	.word err12
	.word err13
	.word err14
	.word err15
	.word err16
	.word err17
	.word err18
	.word err19
	.word err20
	.word err21
	.word err22
	.word err23
	.word err24
	.word err25
	.word err26
	.word err27
	.word err28
	.word err29
	.word err30

okmsg	.byt $d,"OK",$d,$0
err	.byt $20," ERROR",0 ;add a space for vic-40 screen
intxt	.byt " IN ",0
reddy	.byt $d,$a,"READY.",$d,$a,0
erbrk	=30
brktxt	.byt $d,$a
err30	.byt "BREAK",0,$a0 ;shifted space

forsiz	=$12
fndfor	tsx
	inx
	inx
	inx
	inx
ffloop	lda 257,x
	cmp #fortk
	bne ffrts
	lda forpnt+1
	bne cmpfor
	lda 258,x
	sta forpnt
	lda 259,x
	sta forpnt+1
cmpfor	cmp 259,x
	bne addfrs
	lda forpnt
	cmp 258,x
	beq ffrts
addfrs	txa 
	clc
	adc #forsiz
	tax
	bne ffloop
ffrts	rts
bltu	jsr reason
	sta strend
	sty strend+1
bltuc	sec
	lda hightr
	sbc lowtr
	sta index
	tay
	lda hightr+1
	sbc lowtr+1
	tax
	inx
	tya
	beq decblt
	lda hightr
	sec
	sbc index
	sta hightr
	bcs blt1
	dec hightr+1
	sec
blt1	lda highds
	sbc index
	sta highds
	bcs moren1
	dec highds+1
	bcc moren1
bltlp	lda (hightr),y
	sta (highds),y
moren1	dey
	bne bltlp
	lda (hightr),y
	sta (highds),y
decblt	dec hightr+1
	dec highds+1
	dex
	bne moren1
	rts
getstk	asl a
	adc #numlev+numlev+16
	bcs omerr
	sta index
	tsx
	cpx index
	bcc omerr
	rts
reason	cpy fretop+1
	bcc rearts
	bne trymor
	cmp fretop
	bcc rearts
trymor	pha
	ldx #8+addprc
	tya
reasav	pha
	lda highds-1,x
	dex
	bpl reasav
	jsr garba2
	ldx #248-addprc
reasto	pla
	sta highds+8+addprc,x
	inx
	bmi reasto
	pla
	tay
	pla
	cpy fretop+1
	bcc rearts
	bne omerr
	cmp fretop
	bcs omerr
rearts	rts

