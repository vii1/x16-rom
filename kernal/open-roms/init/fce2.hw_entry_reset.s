// #LAYOUT# STD *        #TAKE
// #LAYOUT# *   KERNAL_0 #TAKE
// #LAYOUT# *   *        #IGNORE

// Resources describing the C64 reset sequence:
// https://www.c64-wiki.com/wiki/Reset_(Process)


hw_entry_reset:

	// The GPL program at https://github.com/Klaus2m5/6502_65C02_functional_tests/blob/master/6502_functional_test.a65
	// uses the similar initial reset sequence, affirmed by c64 PRG p269

	sei // disable the interrupts, as fast as possible - they are disabled in case of HW reset,
	    // but this routine can be also called manually

	cld // required for all CPUs - due to possibility of manual call

	ldx #$FF
	txs

	// The following routine is based on reading the public KERNAL jumptable routine
	// list, and making unimaginative assumptions about what should be done on reset.
	// Also, https://codebase64.org/doku.php?id=base:assembling_your_own_cart_rom_image was used
	// as it shows example startup sequence, to be followe by cartridge creators

	// C64 PRG p269
	jsr cartridge_check
	bne !+
	jmp (ICART_COLD_START)
!:
	// Disable the screen (and set 40 columns) to prevent visual glitches later
	ldx #$28
	stx VIC_SCROLX

	// Initialising IO is obviously required. Also indicated by c64 prg p269.
	jsr JIOINIT

	// Setting up the screen and testing ram is obviously required
	// also affirmed by p269 of c64 prg
	jsr JRAMTAS // called RANTAM on Codebase64 wiki

	// Resetting IO vectors is obviously required, if we want interrupts to run
	// also affirmed by c64 prg p269
	jsr JRESTOR

	//  "Compute's Mapping the 64" p236
	jsr JCINT

	// What do we do when finished?  A C64 jumps into the BASIC ROM
	cli // allow interrupts to happen

	// c64 prg p269
	jmp (IBASIC_COLD_START)
