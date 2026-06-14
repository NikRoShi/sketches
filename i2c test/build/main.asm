;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _ping_I2C
	.globl _init_I2C
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
	.area	SSEG
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
;	main.c: 6: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 10: pinMode(PORTC, 8, OUTPUT);
	push	#0x00
	ld	a, #0x08
	ldw	x, #0x500a
	call	_pinMode
;	main.c: 12: init_I2C();
	call	_init_I2C
;	main.c: 13: if (ping_I2C(0x3F)) writePin(PORTC, 8, HIGH);
	ld	a, #0x3f
	call	_ping_I2C
	tnz	a
	jreq	00102$
	push	#0x01
	ld	a, #0x08
	ldw	x, #0x500a
	call	_writePin
	jra	00105$
00102$:
;	main.c: 14: else writePin(PORTC, 8, LOW);
	push	#0x00
	ld	a, #0x08
	ldw	x, #0x500a
	call	_writePin
;	main.c: 16: while (1)
00105$:
	jra	00105$
;	main.c: 20: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
