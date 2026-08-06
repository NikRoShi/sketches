;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_SPI
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_SPI
	.globl _exchange_SPI
	.globl _write_SPI
	.globl _read_SPI
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
;	../../my_STM8_libraries/stm8_SPI.c: 3: void init_SPI(uint8_t mode, uint8_t div, uint8_t firstBit, uint8_t masterSlave)
;	-----------------------------------------
;	 function init_SPI
;	-----------------------------------------
_init_SPI:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_SPI.c: 5: SPI_CR1 &= ~(1 << 6);
	bres	0x5200, #6
;	../../my_STM8_libraries/stm8_SPI.c: 6: SPI_CR1 = 0;
	mov	0x5200+0, #0x00
;	../../my_STM8_libraries/stm8_SPI.c: 7: SPI_CR1 |= mode;
	ld	a, 0x5200
	or	a, (0x01, sp)
	ld	0x5200, a
;	../../my_STM8_libraries/stm8_SPI.c: 8: SPI_CR1 |= div;
	ld	a, 0x5200
	or	a, (0x04, sp)
	ld	0x5200, a
;	../../my_STM8_libraries/stm8_SPI.c: 9: SPI_CR1 |= firstBit;
	ld	a, 0x5200
	or	a, (0x05, sp)
	ld	0x5200, a
;	../../my_STM8_libraries/stm8_SPI.c: 10: SPI_CR1 |= masterSlave;
	ld	a, 0x5200
	or	a, (0x06, sp)
	ld	0x5200, a
;	../../my_STM8_libraries/stm8_SPI.c: 11: SPI_CR1 |= (1 << 6);
	ld	a, 0x5200
	or	a, #0x40
	ld	0x5200, a
;	../../my_STM8_libraries/stm8_SPI.c: 12: }
	ldw	x, (2, sp)
	addw	sp, #6
	jp	(x)
;	../../my_STM8_libraries/stm8_SPI.c: 13: uint8_t exchange_SPI(uint8_t data)
;	-----------------------------------------
;	 function exchange_SPI
;	-----------------------------------------
_exchange_SPI:
	sub	sp, #3
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_SPI.c: 17: while (!(SPI_SR & SPI_SR_TXE))
	ldw	x, #0xc350
	ldw	(0x02, sp), x
00103$:
	btjt	0x5203, #1, 00105$
;	../../my_STM8_libraries/stm8_SPI.c: 19: if (--timeout == 0) return 0;
	ldw	x, (0x02, sp)
	decw	x
	ldw	(0x02, sp), x
	jrne	00103$
	clr	a
	jra	00116$
00105$:
;	../../my_STM8_libraries/stm8_SPI.c: 23: SPI_DR = data;
	ldw	x, #0x5204
	ld	a, (0x01, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_SPI.c: 25: while (!(SPI_SR & SPI_SR_RXNE))
	ldw	x, #0xc350
00108$:
	btjt	0x5203, #0, 00110$
;	../../my_STM8_libraries/stm8_SPI.c: 27: if (--timeout == 0) return 0;
	decw	x
	tnzw	x
	jrne	00108$
	clr	a
	jra	00116$
00110$:
;	../../my_STM8_libraries/stm8_SPI.c: 31: uint8_t result = SPI_DR;
	ld	a, 0x5204
	ld	(0x03, sp), a
;	../../my_STM8_libraries/stm8_SPI.c: 33: while (SPI_SR & SPI_SR_BSY)
	ldw	x, #0xc350
00113$:
	ld	a, 0x5203
	jrpl	00115$
;	../../my_STM8_libraries/stm8_SPI.c: 35: if (--timeout == 0) return 0;
	decw	x
	tnzw	x
	jrne	00113$
	clr	a
	jra	00116$
00115$:
;	../../my_STM8_libraries/stm8_SPI.c: 37: return result;
	ld	a, (0x03, sp)
00116$:
;	../../my_STM8_libraries/stm8_SPI.c: 38: }
	addw	sp, #3
	ret
;	../../my_STM8_libraries/stm8_SPI.c: 39: void write_SPI(uint8_t data)
;	-----------------------------------------
;	 function write_SPI
;	-----------------------------------------
_write_SPI:
;	../../my_STM8_libraries/stm8_SPI.c: 41: (void)exchange_SPI(data);
;	../../my_STM8_libraries/stm8_SPI.c: 42: }
	jp	_exchange_SPI
;	../../my_STM8_libraries/stm8_SPI.c: 43: uint8_t read_SPI(void)
;	-----------------------------------------
;	 function read_SPI
;	-----------------------------------------
_read_SPI:
;	../../my_STM8_libraries/stm8_SPI.c: 45: return exchange_SPI(0xFF);
	ld	a, #0xff
;	../../my_STM8_libraries/stm8_SPI.c: 46: }
	jp	_exchange_SPI
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
