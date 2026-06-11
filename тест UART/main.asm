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
	.globl _sendLine_UART
	.globl _sendString_UART
	.globl _init_UART
	.globl _tim4_tick
	.globl _time_init
	.globl _millis
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
;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 9: TIM4_SR &= ~(1 << 0); // Очистка флага UIF (лучше через &= ~)
	bres	0x5344, #0
;	main.c: 10: tim4_tick();
	call	_tim4_tick
;	main.c: 11: }
	iret
;	main.c: 13: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #12
;	main.c: 15: CLK_CKDIVR = 0; 
	mov	0x50c6+0, #0x00
;	main.c: 18: init_UART(9600);
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_init_UART
;	main.c: 19: time_init();   // Настройка TIM4
	call	_time_init
;	main.c: 22: enableInterrupts();
	rim
;	main.c: 24: uint32_t timer0 = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	main.c: 26: while(1) {
00104$:
;	main.c: 27: if (millis() - timer0 >= 333) {
	call	_millis
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
	ldw	x, (0x07, sp)
	subw	x, (0x03, sp)
	ldw	(0x0b, sp), x
	ld	a, (0x06, sp)
	sbc	a, (0x02, sp)
	ld	(0x0a, sp), a
	ld	a, (0x05, sp)
	sbc	a, (0x01, sp)
	push	a
	ldw	x, (0x0c, sp)
	cpw	x, #0x014d
	ld	a, (0x0b, sp)
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00104$
;	main.c: 28: timer0 = millis();
	call	_millis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	main.c: 29: sendString_UART("hello world!");
	ldw	x, #(___str_0+0)
	call	_sendString_UART
;	main.c: 30: sendLine_UART(); // Если в sendString уже есть \r\n, то это лишнее
	call	_sendLine_UART
	jra	00104$
;	main.c: 33: }
	addw	sp, #12
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "hello world!"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
