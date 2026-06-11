;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_UART
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_UART
	.globl _sendByte_UART
	.globl _sendString_UART
	.globl _sendLine_UART
	.globl _sendInt_UART
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
;	stm8_UART.c: 3: void init_UART(uint32_t baudRate) {
;	-----------------------------------------
;	 function init_UART
;	-----------------------------------------
_init_UART:
	push	a
;	stm8_UART.c: 5: CLK_PCKENR1 |= (1 << 3); 
	bset	0x50c7, #3
;	stm8_UART.c: 8: PD_DDR |= (1 << TX_PIN);
	bset	0x5011, #5
;	stm8_UART.c: 9: PD_CR1 |= (1 << TX_PIN);
	bset	0x5012, #5
;	stm8_UART.c: 10: PD_CR2 |= (1 << TX_PIN);
	bset	0x5013, #5
;	stm8_UART.c: 12: PD_DDR &= ~(1 << RX_PIN);
	bres	0x5011, #6
;	stm8_UART.c: 13: PD_CR1 &= ~(1 << RX_PIN);
	bres	0x5012, #6
;	stm8_UART.c: 15: uint16_t uart_div = (uint32_t)(16000000 / baudRate);
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
;	stm8_UART.c: 16: UART1_BRR2 = ((uart_div >> 12) << 4) | (uart_div & 0x000F);
	ld	a, xh
	clrw	y
	and	a, #240
	ld	(0x01, sp), a
	ld	a, xl
	and	a, #0x0f
	or	a, (0x01, sp)
	ld	0x5233, a
;	stm8_UART.c: 17: UART1_BRR1 = (uart_div >> 4) & 0x00FF;
	ld	a, #0x10
	div	x, a
	ld	a, xl
	ld	0x5232, a
;	stm8_UART.c: 19: UART1_CR2 |= (1 << 3) | (1 << 2);
	ld	a, 0x5235
	or	a, #0x0c
	ld	0x5235, a
;	stm8_UART.c: 20: }
	ldw	x, (2, sp)
	addw	sp, #7
	jp	(x)
;	stm8_UART.c: 22: void sendByte_UART(uint8_t byte) {
;	-----------------------------------------
;	 function sendByte_UART
;	-----------------------------------------
_sendByte_UART:
	push	a
	ld	(0x01, sp), a
;	stm8_UART.c: 23: while(!(UART1_SR & (1 << 7))) {}
00101$:
	ld	a, 0x5230
	jrpl	00101$
;	stm8_UART.c: 24: UART1_DR = byte;
	ldw	x, #0x5231
	ld	a, (0x01, sp)
	ld	(x), a
;	stm8_UART.c: 25: }	
	pop	a
	ret
;	stm8_UART.c: 27: void sendString_UART(const char *str) {
;	-----------------------------------------
;	 function sendString_UART
;	-----------------------------------------
_sendString_UART:
;	stm8_UART.c: 28: while (*str) {               // Пока текущий символ не '\0' (не ноль)
00101$:
	ld	a, (x)
	jrne	00121$
	ret
00121$:
;	stm8_UART.c: 29: sendByte_UART(*str);     // Отправляем текущий символ
	pushw	x
	call	_sendByte_UART
	popw	x
;	stm8_UART.c: 30: str++;                   // Переходим к следующему адресу в памяти
	incw	x
	jra	00101$
;	stm8_UART.c: 32: }
	ret
;	stm8_UART.c: 34: void sendLine_UART(void) {
;	-----------------------------------------
;	 function sendLine_UART
;	-----------------------------------------
_sendLine_UART:
;	stm8_UART.c: 35: sendByte_UART('\r');
	ld	a, #0x0d
	call	_sendByte_UART
;	stm8_UART.c: 36: sendByte_UART('\n');
	ld	a, #0x0a
;	stm8_UART.c: 37: }
	jp	_sendByte_UART
;	stm8_UART.c: 39: void sendInt_UART(uint8_t num) {
;	-----------------------------------------
;	 function sendInt_UART
;	-----------------------------------------
_sendInt_UART:
	sub	sp, #6
;	stm8_UART.c: 40: if (num == 0) {
	ld	xl, a
	tnz	a
	jrne	00113$
;	stm8_UART.c: 41: sendByte_UART('0');
	ld	a, #0x30
	addw	sp, #6
;	stm8_UART.c: 42: return;
	jp	_sendByte_UART
;	stm8_UART.c: 49: while (num > 0) {
00113$:
	clr	(0x06, sp)
00103$:
	ld	a, xl
	tnz	a
	jreq	00115$
;	stm8_UART.c: 50: digits[i++] = (num % 10) + '0'; // Берем остаток и превращаем в символ
	ld	a, (0x06, sp)
	ld	(0x02, sp), a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	(0x01, sp), a
	inc	(0x06, sp)
	ldw	y, sp
	addw	y, #3
	addw	y, (0x01, sp)
	pushw	x
	clr	a
	ld	xh, a
	ld	a, #0x0a
	div	x, a
	popw	x
	add	a, #0x30
	ld	(y), a
;	stm8_UART.c: 51: num /= 10;
	clr	a
	ld	xh, a
	ld	a, #0x0a
	div	x, a
	jra	00103$
;	stm8_UART.c: 55: while (i > 0) {
00115$:
00106$:
	ld	a, (0x06, sp)
	cp	a, #0x00
	jrsle	00109$
;	stm8_UART.c: 56: sendByte_UART(digits[--i]);
	dec	(0x06, sp)
	ld	a, (0x06, sp)
	ldw	x, sp
	addw	x, #3
	pushw	x
	clrw	x
	ld	xl, a
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	call	_sendByte_UART
	jra	00106$
00109$:
;	stm8_UART.c: 58: }
	addw	sp, #6
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
