;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module blink
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _delay
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
;	blink.c: 3: void delay(void)
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #4
;	blink.c: 5: for (volatile long i = 0; i < 30000; i++);  // простая пауза
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
00103$:
	ldw	x, (0x03, sp)
	cpw	x, #0x7530
	ld	a, (0x02, sp)
	sbc	a, #0x00
	ld	a, (0x01, sp)
	sbc	a, #0x00
	jrsge	00105$
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
	incw	x
	jrne	00122$
	incw	y
00122$:
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00103$
00105$:
;	blink.c: 6: }
	addw	sp, #4
	ret
;	blink.c: 8: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	blink.c: 11: PB_DDR |= (1 << 5);   // направление: выход
	bset	0x5007, #5
;	blink.c: 12: PB_CR1 |= (1 << 5);   // режим push-pull (тянет и к Vcc, и к GND)
	bset	0x5008, #5
;	blink.c: 14: while (1)
00102$:
;	blink.c: 17: PB_ODR ^= (1 << 5);
	bcpl	0x5005, #5
;	blink.c: 18: delay();
	call	_delay
	jra	00102$
;	blink.c: 20: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
