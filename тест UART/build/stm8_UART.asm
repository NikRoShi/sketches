;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_UART
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_UART
	.globl _write_UART
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint16_t baudrate)
;	-----------------------------------------
;	 function init_UART
;	-----------------------------------------
_init_UART:
	push	a
;	../../my_STM8_libraries/stm8_UART.c: 7: PD_DDR |= (1 << TX_PIN);
	bset	0x5011, #5
;	../../my_STM8_libraries/stm8_UART.c: 8: PD_CR1 |= (1 << TX_PIN);
	bset	0x5012, #5
;	../../my_STM8_libraries/stm8_UART.c: 10: uartdiv = F_CPU / baudrate;
	clrw	y
	pushw	x
	pushw	y
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	__divulong
	addw	sp, #8
;	../../my_STM8_libraries/stm8_UART.c: 12: UART1_BRR2 = (uartdiv & 0x000F) | ((uartdiv >> 8) & 0x00F0);
	ld	a, xl
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xh
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5233, a
;	../../my_STM8_libraries/stm8_UART.c: 13: UART1_BRR1 = (uartdiv >> 4) & 0x00FF;
	ld	a, #0x10
	div	x, a
	ld	a, xl
	ld	0x5232, a
;	../../my_STM8_libraries/stm8_UART.c: 15: UART1_CR2 |= UART1_CR2_TEN;
	bset	0x5235, #3
;	../../my_STM8_libraries/stm8_UART.c: 16: }
	pop	a
	ret
;	../../my_STM8_libraries/stm8_UART.c: 17: uint8_t write_UART(uint8_t data)
;	-----------------------------------------
;	 function write_UART
;	-----------------------------------------
_write_UART:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_UART.c: 21: while (!(UART1_SR & UART1_SR_TXE))
00103$:
	ld	a, 0x5230
	jrpl	00103$
;	../../my_STM8_libraries/stm8_UART.c: 26: UART1_DR = data;
	ldw	x, #0x5231
	ld	a, (0x01, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_UART.c: 27: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_UART.c: 28: }
	addw	sp, #1
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
