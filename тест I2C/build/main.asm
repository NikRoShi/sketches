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
	.globl _stop_I2C
	.globl _readNack_I2C
	.globl _readAck_I2C
	.globl _write_I2C
	.globl _sendAddress_I2C
	.globl _start_I2C
	.globl _init_I2C
	.globl _sendInt_UART
	.globl _sendLine_UART
	.globl _sendString_UART
	.globl _init_UART
	.globl _delay
	.globl _init_TIME
	.globl _tick_TIME
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
;	main.c: 8: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 9: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 10: tick_TIME();
	call	_tick_TIME
;	main.c: 11: }
	iret
;	main.c: 13: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #11
;	main.c: 14: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 15: init_TIME();
	call	_init_TIME
;	main.c: 16: init_UART(9600);
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_init_UART
;	main.c: 17: init_I2C();
	call	_init_I2C
;	main.c: 18: enableInterrupts();
	rim
;	main.c: 21: pinMode(PORTD, 5, OUTPUT);
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x500f
	call	_pinMode
;	main.c: 24: pinMode(PORTB, 4, OUTPUT_OD);
	push	#0x04
	ld	a, #0x04
	ldw	x, #0x5005
	call	_pinMode
;	main.c: 25: pinMode(PORTB, 5, OUTPUT_OD);
	push	#0x04
	ld	a, #0x05
	ldw	x, #0x5005
	call	_pinMode
;	main.c: 29: if (start_I2C() && sendAddress_I2C(0xEC)) {
	call	_start_I2C
	tnz	a
	jreq	00108$
	ld	a, #0xec
	call	_sendAddress_I2C
	tnz	a
	jreq	00108$
;	main.c: 30: write_I2C(0xF4); // Регистр ctrl_meas
	ld	a, #0xf4
	call	_write_I2C
;	main.c: 31: write_I2C(0x2E); // Значение настроек
	ld	a, #0x2e
	call	_write_I2C
;	main.c: 32: stop_I2C();
	call	_stop_I2C
;	main.c: 33: sendString_UART("Sensor Configured!\r\n");
	ldw	x, #(___str_0+0)
	call	_sendString_UART
;	main.c: 36: while(1) {
00108$:
;	main.c: 37: if (start_I2C() && sendAddress_I2C(0xEC)) {
	call	_start_I2C
	tnz	a
	jreq	00105$
	ld	a, #0xec
	call	_sendAddress_I2C
	tnz	a
	jreq	00105$
;	main.c: 38: write_I2C(0xFA); // Начальный регистр температуры
	ld	a, #0xfa
	call	_write_I2C
;	main.c: 40: start_I2C();     // Restart
	call	_start_I2C
;	main.c: 41: sendAddress_I2C(0xED); // Переходим на чтение
	ld	a, #0xed
	call	_sendAddress_I2C
;	main.c: 44: uint32_t msb  = readAck_I2C();
	call	_readAck_I2C
	ld	(0x03, sp), a
	clr	(0x02, sp)
;	main.c: 45: uint32_t lsb  = readAck_I2C();
	call	_readAck_I2C
	ld	(0x05, sp), a
	clr	(0x04, sp)
;	main.c: 46: uint32_t xlsb = readNack_I2C(); 
	call	_readNack_I2C
	ld	(0x09, sp), a
	clrw	y
	clr	(0x06, sp)
;	main.c: 50: uint32_t raw_temp = (msb << 12) | (lsb << 4) | (xlsb >> 4);
	ld	a, (0x03, sp)
	ld	(0x0a, sp), a
	clr	(0x0b, sp)
	sll	(0x0b, sp)
	rlc	(0x0a, sp)
	sll	(0x0b, sp)
	rlc	(0x0a, sp)
	sll	(0x0b, sp)
	rlc	(0x0a, sp)
	sll	(0x0b, sp)
	rlc	(0x0a, sp)
	ldw	x, (0x04, sp)
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	ld	a, xh
	or	a, (0x0a, sp)
	ld	xh, a
	clr	(0x01, sp)
	swapw	y
	ld	a, (0x09, sp)
	srl	(0x01, sp)
	rrcw	y
	rrc	a
	srl	(0x01, sp)
	rrcw	y
	rrc	a
	srl	(0x01, sp)
	rrcw	y
	rrc	a
	srl	(0x01, sp)
	rrcw	y
	rrc	a
	ld	(0x0b, sp), a
	ld	a, xl
	or	a, (0x0b, sp)
	ld	xl, a
;	main.c: 52: sendString_UART("Raw Temp: ");
	pushw	x
	ldw	x, #(___str_1+0)
	call	_sendString_UART
	popw	x
;	main.c: 53: sendInt_UART(raw_temp); 
	call	_sendInt_UART
;	main.c: 54: sendLine_UART();
	call	_sendLine_UART
00105$:
;	main.c: 57: delay(500); // Пауза полсекунды
	push	#0xf4
	push	#0x01
	clrw	x
	pushw	x
	call	_delay
;	main.c: 59: }
	jp	00108$
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "Sensor Configured!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "Raw Temp: "
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
