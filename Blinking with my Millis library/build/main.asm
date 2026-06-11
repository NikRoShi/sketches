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
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _get_ms
	.globl _init_TIME
	.globl _tick_TIME
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
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int 0x000000 ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int 0x000000 ; int11
	int 0x000000 ; int12
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int 0x000000 ; int17
	int 0x000000 ; int18
	int 0x000000 ; int19
	int 0x000000 ; int20
	int 0x000000 ; int21
	int 0x000000 ; int22
	int _TIM4_UPD_OVF_IRQHandler ; int23
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
;	main.c: 5: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 6: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 7: tick_TIME();
	call	_tick_TIME
;	main.c: 8: }
	iret
;	main.c: 10: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #15
;	main.c: 12: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 14: PB_DDR |= (1 << 5);
	bset	0x5007, #5
;	main.c: 15: PB_CR1 |= (1 << 5);
	ld	a, 0x5008
	or	a, #0x20
	ld	0x5008, a
;	main.c: 17: init_TIME();
	call	_init_TIME
;	main.c: 18: enableInterrupts();
	rim
;	main.c: 20: uint32_t timer0 = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	main.c: 21: int8_t step = 5;
	ld	a, #0x05
	ld	(0x05, sp), a
;	main.c: 22: uint16_t value = 0;
	clrw	x
	ldw	(0x06, sp), x
;	main.c: 24: while (1)
00108$:
;	main.c: 26: value = value + step;
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ldw	y, (0x06, sp)
	ldw	(0x0e, sp), y
	ld	xh, a
	addw	x, (0x0e, sp)
;	main.c: 27: if (value > 950) step = -5;
	ldw	(0x06, sp), x
	cpw	x, #0x03b6
	jrule	00102$
	ld	a, #0xfb
	ld	(0x05, sp), a
00102$:
;	main.c: 28: if (value < 50) step = 5;
	cpw	x, #0x0032
	jrnc	00104$
	ld	a, #0x05
	ld	(0x05, sp), a
00104$:
;	main.c: 30: if (get_ms() - timer0 >= value) {
	call	_get_ms
	ld	a, yl
	subw	x, (0x03, sp)
	sbc	a, (0x02, sp)
	ld	(0x09, sp), a
	ld	a, yh
	sbc	a, (0x01, sp)
	ldw	y, (0x06, sp)
	ldw	(0x0e, sp), y
	clr	(0x0d, sp)
	clr	(0x0c, sp)
	push	a
	cpw	x, (0x0f, sp)
	ld	a, (0x0a, sp)
	sbc	a, (0x0e, sp)
	pop	a
	sbc	a, (0x0c, sp)
	jrc	00108$
;	main.c: 31: timer0 = get_ms();
	call	_get_ms
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	main.c: 32: PB_ODR ^= (1 << 5);
	bcpl	0x5005, #5
	jra	00108$
;	main.c: 35: }
	addw	sp, #15
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
