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
	.globl _sendByte_UART
	.globl _sendString_UART
	.globl _sendLine_UART
	.globl _sendInt_UART
	.globl _available_UART
	.globl _read_UART
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
;	../../my_STM8_libraries/stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
;	-----------------------------------------
;	 function init_UART
;	-----------------------------------------
_init_UART:
	push	a
;	../../my_STM8_libraries/stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
	bset	0x50c7, #3
;	../../my_STM8_libraries/stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
	bset	0x5011, #5
;	../../my_STM8_libraries/stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
	bset	0x5012, #5
;	../../my_STM8_libraries/stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
	bset	0x5013, #5
;	../../my_STM8_libraries/stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
	bres	0x5011, #6
;	../../my_STM8_libraries/stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
	bres	0x5012, #6
;	../../my_STM8_libraries/stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x06, sp)
	pushw	x
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	__divulong
	addw	sp, #8
;	../../my_STM8_libraries/stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
	ld	a, xh
	clrw	y
	and	a, #240
	ld	yl, a
	ld	a, xl
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, yl
	or	a, (0x01, sp)
	ld	0x5233, a
;	../../my_STM8_libraries/stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
	ld	a, #0x10
	div	x, a
	ld	a, xl
	ld	0x5232, a
;	../../my_STM8_libraries/stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
	ld	a, 0x5235
	or	a, #0x0c
	ld	0x5235, a
;	../../my_STM8_libraries/stm8_UART.c: 20: }
	ldw	x, (2, sp)
	addw	sp, #7
	jp	(x)
;	../../my_STM8_libraries/stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
;	-----------------------------------------
;	 function sendByte_UART
;	-----------------------------------------
_sendByte_UART:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	../../my_STM8_libraries/stm8_UART.c: 24: UART1_DR = byte;
	ldw	x, #0x5231
	ld	a, (0x01, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_UART.c: 25: }	
	pop	a
	ret
;	../../my_STM8_libraries/stm8_UART.c: 27: void sendString_UART(const char *str) {
;	-----------------------------------------
;	 function sendString_UART
;	-----------------------------------------
_sendString_UART:
;	../../my_STM8_libraries/stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
00101$:
	ld	a, (x)
	jrne	00117$
	ret
00117$:
;	../../my_STM8_libraries/stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
	pushw	x
	call	_sendByte_UART
	popw	x
;	../../my_STM8_libraries/stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
	incw	x
	jra	00101$
;	../../my_STM8_libraries/stm8_UART.c: 32: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 34: void sendLine_UART(void) {
;	-----------------------------------------
;	 function sendLine_UART
;	-----------------------------------------
_sendLine_UART:
;	../../my_STM8_libraries/stm8_UART.c: 35: sendByte_UART('\r');
	ld	a, #0x0d
	call	_sendByte_UART
;	../../my_STM8_libraries/stm8_UART.c: 36: sendByte_UART('\n');
	ld	a, #0x0a
;	../../my_STM8_libraries/stm8_UART.c: 37: }
	jp	_sendByte_UART
;	../../my_STM8_libraries/stm8_UART.c: 39: void sendInt_UART(uint16_t num) {
;	-----------------------------------------
;	 function sendInt_UART
;	-----------------------------------------
_sendInt_UART:
	sub	sp, #15
;	../../my_STM8_libraries/stm8_UART.c: 40: if (num == 0) {
	ldw	(0x0d, sp), x
	jrne	00113$
;	../../my_STM8_libraries/stm8_UART.c: 41: sendByte_UART('0');
	ld	a, #0x30
	addw	sp, #15
;	../../my_STM8_libraries/stm8_UART.c: 42: return;
	jp	_sendByte_UART
;	../../my_STM8_libraries/stm8_UART.c: 49: while (num > 0) {
00113$:
	clr	a
00103$:
	ldw	x, (0x0d, sp)
	jreq	00115$
;	../../my_STM8_libraries/stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
	ld	xl, a
	push	a
	ld	a, xl
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	pop	a
	inc	a
	sllw	x
	ldw	(0x0b, sp), x
	ldw	x, sp
	incw	x
	addw	x, (0x0b, sp)
	ldw	y, (0x0d, sp)
	ldw	(0x0b, sp), y
	pushw	x
	ldw	x, (0x0d, sp)
	ldw	y, #0x000a
	divw	x, y
	popw	x
	addw	y, #0x0030
	ldw	(x), y
;	../../my_STM8_libraries/stm8_UART.c: 51: num /= 10;
	ldw	x, (0x0b, sp)
	ldw	y, #0x000a
	divw	x, y
	ldw	(0x0d, sp), x
	jra	00103$
;	../../my_STM8_libraries/stm8_UART.c: 55: while (i > 0) {
00115$:
	ld	(0x0f, sp), a
00106$:
	ld	a, (0x0f, sp)
	cp	a, #0x00
	jrsle	00109$
;	../../my_STM8_libraries/stm8_UART.c: 56: sendByte_UART(digits[--i]);
	dec	(0x0f, sp)
	ld	a, (0x0f, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	sllw	x
	ldw	(0x0b, sp), x
	ldw	x, sp
	incw	x
	addw	x, (0x0b, sp)
	ld	a, (0x1, x)
	call	_sendByte_UART
	jra	00106$
00109$:
;	../../my_STM8_libraries/stm8_UART.c: 58: }
	addw	sp, #15
	ret
;	../../my_STM8_libraries/stm8_UART.c: 61: uint8_t available_UART(void) {
;	-----------------------------------------
;	 function available_UART
;	-----------------------------------------
_available_UART:
;	../../my_STM8_libraries/stm8_UART.c: 62: if (UART1_SR & (1 << 5)) return 1;
	btjf	0x5230, #5, 00102$
	ld	a, #0x01
	ret
00102$:
;	../../my_STM8_libraries/stm8_UART.c: 63: return 0;
	clr	a
;	../../my_STM8_libraries/stm8_UART.c: 64: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 67: uint8_t read_UART(void) {
;	-----------------------------------------
;	 function read_UART
;	-----------------------------------------
_read_UART:
;	../../my_STM8_libraries/stm8_UART.c: 68: return UART1_DR;           // Чтение DR автоматически сбрасывает флаг RXNE
	ld	a, 0x5231
;	../../my_STM8_libraries/stm8_UART.c: 69: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
