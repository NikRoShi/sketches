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
	.globl _print_UART
	.globl _printInt_UART
	.globl _line_UART
	.globl _printHex_UART
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
	ld	yl, a
;	../../my_STM8_libraries/stm8_UART.c: 21: while (!(UART1_SR & UART1_SR_TXE))
	ldw	x, #0xc350
00103$:
	ld	a, 0x5230
	jrmi	00105$
;	../../my_STM8_libraries/stm8_UART.c: 23: if (--timeout == 0) return 0;
	decw	x
	tnzw	x
	jrne	00103$
	clr	a
	ret
00105$:
;	../../my_STM8_libraries/stm8_UART.c: 26: UART1_DR = data;
	ldw	x, #0x5231
	ld	a, yl
	ld	(x), a
;	../../my_STM8_libraries/stm8_UART.c: 27: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_UART.c: 28: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 29: uint8_t print_UART(char *str)
;	-----------------------------------------
;	 function print_UART
;	-----------------------------------------
_print_UART:
;	../../my_STM8_libraries/stm8_UART.c: 31: while (*str != 0)
00104$:
	ld	a, (x)
	jreq	00106$
;	../../my_STM8_libraries/stm8_UART.c: 33: if (write_UART(*str) == 1)
	pushw	x
	call	_write_UART
	popw	x
	dec	a
	jrne	00102$
;	../../my_STM8_libraries/stm8_UART.c: 35: str++;
	incw	x
	jra	00104$
00102$:
;	../../my_STM8_libraries/stm8_UART.c: 37: else return 0;
	clr	a
	ret
00106$:
;	../../my_STM8_libraries/stm8_UART.c: 39: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_UART.c: 40: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 41: uint8_t printInt_UART(uint16_t data)
;	-----------------------------------------
;	 function printInt_UART
;	-----------------------------------------
_printInt_UART:
	sub	sp, #8
;	../../my_STM8_libraries/stm8_UART.c: 46: if (data == 0)
	tnzw	x
	jrne	00115$
;	../../my_STM8_libraries/stm8_UART.c: 48: write_UART('0');
	ld	a, #0x30
	call	_write_UART
;	../../my_STM8_libraries/stm8_UART.c: 49: return 1;
	ld	a, #0x01
	jra	00111$
;	../../my_STM8_libraries/stm8_UART.c: 51: while (data != 0)
00115$:
	clr	(0x08, sp)
00103$:
	tnzw	x
	jreq	00117$
;	../../my_STM8_libraries/stm8_UART.c: 53: buf[i] = (data % 10) + '0';
	pushw	x
	clrw	x
	ld	a, (0x0a, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #7
	addw	x, (1, sp)
	ldw	(0x05, sp), x
	addw	sp, #2
	popw	x
	pushw	x
	ldw	y, #0x000a
	divw	x, y
	popw	x
	ld	a, yl
	add	a, #0x30
	ldw	y, (0x01, sp)
	ld	(y), a
;	../../my_STM8_libraries/stm8_UART.c: 54: data /= 10;
	ldw	y, #0x000a
	divw	x, y
;	../../my_STM8_libraries/stm8_UART.c: 55: i++;
	inc	(0x08, sp)
	jra	00103$
;	../../my_STM8_libraries/stm8_UART.c: 57: while (i > 0)
00117$:
00108$:
	tnz	(0x08, sp)
	jreq	00110$
;	../../my_STM8_libraries/stm8_UART.c: 59: i--;
	dec	(0x08, sp)
;	../../my_STM8_libraries/stm8_UART.c: 60: if (write_UART(buf[i]) == 0) return 0;
	clrw	x
	ld	a, (0x08, sp)
	ld	xl, a
	pushw	x
	ldw	x, sp
	addw	x, #5
	addw	x, (1, sp)
	addw	sp, #2
	ld	a, (x)
	call	_write_UART
	tnz	a
	jrne	00108$
	clr	a
;	../../my_STM8_libraries/stm8_UART.c: 62: return 1;
	.byte 0xc5
00110$:
	ld	a, #0x01
00111$:
;	../../my_STM8_libraries/stm8_UART.c: 63: }
	addw	sp, #8
	ret
;	../../my_STM8_libraries/stm8_UART.c: 64: uint8_t line_UART(void)
;	-----------------------------------------
;	 function line_UART
;	-----------------------------------------
_line_UART:
;	../../my_STM8_libraries/stm8_UART.c: 66: if (write_UART('\r') == 0) return 0;
	ld	a, #0x0d
	call	_write_UART
	tnz	a
	jrne	00102$
	clr	a
	ret
00102$:
;	../../my_STM8_libraries/stm8_UART.c: 67: if (write_UART('\n') == 0) return 0;
	ld	a, #0x0a
	call	_write_UART
	tnz	a
	jrne	00104$
	clr	a
	ret
00104$:
;	../../my_STM8_libraries/stm8_UART.c: 68: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_UART.c: 69: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 70: static char nibbleToHex(uint8_t nibble)
;	-----------------------------------------
;	 function nibbleToHex
;	-----------------------------------------
_nibbleToHex:
;	../../my_STM8_libraries/stm8_UART.c: 72: if (nibble < 10) return nibble + '0';
	ld	xl, a
	cp	a, #0x0a
	jrnc	00102$
	ld	a, xl
	add	a, #0x30
	ret
00102$:
;	../../my_STM8_libraries/stm8_UART.c: 73: else return nibble - 10 + 'A';
	ld	a, xl
	add	a, #0x37
;	../../my_STM8_libraries/stm8_UART.c: 74: }
	ret
;	../../my_STM8_libraries/stm8_UART.c: 75: uint8_t printHex_UART(uint8_t data)
;	-----------------------------------------
;	 function printHex_UART
;	-----------------------------------------
_printHex_UART:
	push	a
;	../../my_STM8_libraries/stm8_UART.c: 77: uint8_t high = data >> 4;
	ld	xl, a
	swap	a
	and	a, #0x0f
	exg	a, xl
;	../../my_STM8_libraries/stm8_UART.c: 78: uint8_t low = data & 0x0F;
	and	a, #0x0f
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_UART.c: 80: if (write_UART(nibbleToHex(high)) == 0) return 0;
	ld	a, xl
	call	_nibbleToHex
	call	_write_UART
	tnz	a
	jrne	00102$
	clr	a
	jra	00105$
00102$:
;	../../my_STM8_libraries/stm8_UART.c: 81: if (write_UART(nibbleToHex(low)) == 0) return 0;
	ld	a, (0x01, sp)
	call	_nibbleToHex
	call	_write_UART
	tnz	a
	jrne	00104$
	clr	a
;	../../my_STM8_libraries/stm8_UART.c: 82: return 1;
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
;	../../my_STM8_libraries/stm8_UART.c: 83: }
	addw	sp, #1
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
