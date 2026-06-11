;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _readPin
	.globl _writePin
	.globl _pinMode
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 5: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 7: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 9: pinMode(PORTA, 1, INPUT_PULLUP);
	push	#0x03
	ld	a, #0x01
	ldw	x, #0x5000
	call	_pinMode
;	main.c: 10: pinMode(PORTD, 3, OUTPUT);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_pinMode
;	main.c: 11: while(1) {
00105$:
;	main.c: 12: if (readPin(PORTA, 1) == 0) {
	ld	a, #0x01
	ldw	x, #0x5000
	call	_readPin
	tnz	a
	jrne	00102$
;	main.c: 13: writePin(PORTD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
	jra	00105$
00102$:
;	main.c: 15: else writePin(PORTD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
	jra	00105$
;	main.c: 17: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
