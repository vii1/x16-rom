// #LAYOUT# STD *        #TAKE
// #LAYOUT# *   KERNAL_0 #TAKE
// #LAYOUT# *   *        #IGNORE


default_nmi_handler:

	// Implemented according to Computes Mapping the Commodore 64, page 74
	// and to https://www.c64-wiki.com/wiki/Interrupt

	// Save registers, sequence according to Computes Mapping the Commodore 64, page 73
	pha
	phx_trash_a
	phy_trash_a

	// XXX: RS-232 support is not implemented

	// XXX confirm NMIs from CIA, or no other NMI will arrive!

	jsr cartridge_check
	bne !+
	jmp (ICART_WARM_START)
!:
	// According to C64 Wiki, if STOP key is pressed, the routine assumes warm start request

	// XXX is it right? how to check that IRQ was caused by RESTORE?

	jsr JSTOP
	bcs !+
	jmp return_from_interrupt // no STOP pressed
!:
	// STOP + RESTORE - clean the address of the BRK instruction (it is not BRK) first
	lda #$00
	sta CMP0+0
	sta CMP0+1
	jmp (CBINV)
