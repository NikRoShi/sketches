;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _read_UART
	.globl _available_UART
	.globl _init_UART
	.globl _tick_TIM4
	.globl _init_TIM4
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
;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 7: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 8: tick_TIM4();
	call	_tick_TIM4
;	main.c: 9: }
	iret
;	main.c: 11: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 13: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	main.c: 15: init_TIM4();
	call	_init_TIM4
;	main.c: 16: init_UART(9600);
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_init_UART
;	main.c: 18: enableInterrupts();
	rim
;	main.c: 20: PD_DDR |= (1 << 2) | (1 << 3);
	ld	a, 0x5011
	or	a, #0x0c
	ld	0x5011, a
;	main.c: 21: PD_CR1 |= (1 << 2) | (1 << 3);
	ld	a, 0x5012
	or	a, #0x0c
	ld	0x5012, a
;	main.c: 23: while(1) {
00107$:
;	main.c: 24: if (available_UART() == 1) {
	call	_available_UART
	dec	a
	jrne	00107$
;	main.c: 25: switch (read_UART()) {
	call	_read_UART
	cp	a, #0x31
	jreq	00101$
	cp	a, #0x32
	jreq	00102$
	jra	00107$
;	main.c: 26: case '1':
00101$:
;	main.c: 27: PD_ODR ^= (1 << 3);
	bcpl	0x500f, #3
;	main.c: 28: break;
	jra	00107$
;	main.c: 29: case '2':
00102$:
;	main.c: 30: PD_ODR ^= (1 << 2);
	bcpl	0x500f, #2
;	main.c: 32: }
	jra	00107$
;	main.c: 35: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
