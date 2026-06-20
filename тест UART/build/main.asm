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
	.globl _write_UART
	.globl _init_UART
	.globl _delay
	.globl _init_TIME
	.globl _tick_TIME
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
;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 8: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 9: tick_TIME();
	call	_tick_TIME
;	main.c: 10: }
	iret
;	main.c: 12: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 14: CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 16: init_UART(9600);	// 2. Инициализируем периферию
	ldw	x, #0x2580
	call	_init_UART
;	main.c: 17: init_TIME();
	call	_init_TIME
;	main.c: 19: pinMode(PORTC, 3, OUTPUT);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500a
	call	_pinMode
;	main.c: 21: while(1)
00104$:
;	main.c: 23: if (write_UART('A') == 0) 
	ld	a, #0x41
	call	_write_UART
	tnz	a
	jrne	00102$
;	main.c: 25: writePin(PORTC, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500a
	call	_writePin
00102$:
;	main.c: 27: writePin(PORTC, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500a
	call	_writePin
;	main.c: 28: delay(1000);  
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	call	_delay
	jra	00104$
;	main.c: 30: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
