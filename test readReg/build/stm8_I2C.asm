;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_I2C
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_I2C
	.globl _stop_I2C
	.globl _start_I2C
	.globl _writeAddr_I2C
	.globl _writeByte_I2C
	.globl _ping_I2C
	.globl _writeReg_I2C
	.globl _readByte_I2C
	.globl _readReg_I2C
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
;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
;	-----------------------------------------
;	 function init_I2C
;	-----------------------------------------
_init_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
	bres	0x5210, #0
;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
	mov	0x5212+0, #0x10
;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
	mov	0x521b+0, #0x50
;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
	mov	0x521c+0, #0x00
;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
	mov	0x521d+0, #0x11
;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
	bset	0x5210, #0
;	../../my_STM8_libraries/stm8_I2C.c: 21: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
;	-----------------------------------------
;	 function stop_I2C
;	-----------------------------------------
_stop_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 26: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
;	-----------------------------------------
;	 function start_I2C
;	-----------------------------------------
_start_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
	bset	0x5211, #0
;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
	ldw	x, #0xc350
00103$:
	btjt	0x5217, #0, 00105$
;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00103$
;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
	clr	a
	ret
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_I2C.c: 42: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
;	-----------------------------------------
;	 function writeAddr_I2C
;	-----------------------------------------
_writeAddr_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 48: if (mode == WRITE) I2C_DR = (address << 1);
	sll	a
	tnz	(0x03, sp)
	jrne	00102$
	ld	0x5216, a
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == READ) I2C_DR = (address << 1) | 0x01;
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00119$
	or	a, #0x01
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 51: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
00119$:
	ldw	x, #0xc350
00108$:
	btjt	0x5217, #1, 00110$
	btjt	0x5218, #2, 00110$
;	../../my_STM8_libraries/stm8_I2C.c: 53: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00108$
;	../../my_STM8_libraries/stm8_I2C.c: 55: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 56: return 0;
	clr	a
	jra	00113$
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 59: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
	btjf	0x5217, #1, 00112$
;	../../my_STM8_libraries/stm8_I2C.c: 61: (void)I2C_SR1;	//сбрасываем как в RM
	ld	a, 0x5217
;	../../my_STM8_libraries/stm8_I2C.c: 62: (void)I2C_SR3;
	ld	a, 0x5219
;	../../my_STM8_libraries/stm8_I2C.c: 63: return 1;
	ld	a, #0x01
	jra	00113$
00112$:
;	../../my_STM8_libraries/stm8_I2C.c: 65: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 66: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 67: return 0;
	clr	a
00113$:
;	../../my_STM8_libraries/stm8_I2C.c: 68: }
	popw	x
	addw	sp, #1
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 70: uint8_t writeByte_I2C(uint8_t data)
;	-----------------------------------------
;	 function writeByte_I2C
;	-----------------------------------------
_writeByte_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 74: I2C_DR = data;	//записываем байт в реистр данных
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 76: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
	ldw	x, #0xc350
00105$:
	ld	a, 0x5217
	jrmi	00107$
;	../../my_STM8_libraries/stm8_I2C.c: 78: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
	btjf	0x5218, #2, 00102$
;	../../my_STM8_libraries/stm8_I2C.c: 80: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 81: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 82: return 0;
	clr	a
	ret
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 84: if (--timeout == 0)	//проверка таймаута
	decw	x
	tnzw	x
	jrne	00105$
;	../../my_STM8_libraries/stm8_I2C.c: 86: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 87: return 0;
	clr	a
	ret
00107$:
;	../../my_STM8_libraries/stm8_I2C.c: 90: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_I2C.c: 91: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 93: uint8_t ping_I2C(uint8_t address)
;	-----------------------------------------
;	 function ping_I2C
;	-----------------------------------------
_ping_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 95: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00105$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 96: if (writeAddr_I2C(address, WRITE) == 0) return 0; 
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00105$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
	ld	a, #0x01
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 99: }
	addw	sp, #1
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
;	-----------------------------------------
;	 function writeReg_I2C
;	-----------------------------------------
_writeReg_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00109$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00109$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 105: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00109$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(data) == 0) return 0;
	ld	a, (0x05, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00109$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 107: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 108: return 1;
	ld	a, #0x01
00109$:
;	../../my_STM8_libraries/stm8_I2C.c: 109: }
	ldw	x, (2, sp)
	addw	sp, #5
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 111: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
;	-----------------------------------------
;	 function readByte_I2C
;	-----------------------------------------
_readByte_I2C:
	sub	sp, #3
	ld	(0x03, sp), a
	ldw	(0x01, sp), x
;	../../my_STM8_libraries/stm8_I2C.c: 115: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00110$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 117: I2C_CR2 &= ~I2C_CR2_ACK;
	bres	0x5211, #2
;	../../my_STM8_libraries/stm8_I2C.c: 119: if (writeAddr_I2C(address, READ) == 0) return 0;
	push	#0x01
	ld	a, (0x04, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00115$
	clr	a
	jra	00110$
;	../../my_STM8_libraries/stm8_I2C.c: 121: while (!(I2C_SR1 & I2C_SR1_RXNE))
00115$:
	ldw	x, #0xc350
00107$:
	btjt	0x5217, #6, 00109$
;	../../my_STM8_libraries/stm8_I2C.c: 123: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00107$
;	../../my_STM8_libraries/stm8_I2C.c: 125: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 126: return 0;
	clr	a
	jra	00110$
00109$:
;	../../my_STM8_libraries/stm8_I2C.c: 129: *data = I2C_DR;
	ld	a, 0x5216
	ldw	x, (0x01, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 130: I2C_CR2 |= I2C_CR2_ACK;
	bset	0x5211, #2
;	../../my_STM8_libraries/stm8_I2C.c: 131: return 1;
	ld	a, #0x01
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 132: }
	addw	sp, #3
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 133: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
;	-----------------------------------------
;	 function readReg_I2C
;	-----------------------------------------
_readReg_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 137: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00116$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 139: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00116$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 141: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00116$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 143: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00116$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 145: if (writeAddr_I2C(address, READ) == 0) return 0;
	push	#0x01
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00110$
	clr	a
	jra	00116$
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 147: I2C_CR2 &= ~I2C_CR2_ACK;
	bres	0x5211, #2
;	../../my_STM8_libraries/stm8_I2C.c: 149: while (!(I2C_SR1 & I2C_SR1_RXNE))
	ldw	x, #0xc350
00113$:
	btjt	0x5217, #6, 00115$
;	../../my_STM8_libraries/stm8_I2C.c: 151: if (--timeout == 0)
	decw	x
	tnzw	x
	jrne	00113$
;	../../my_STM8_libraries/stm8_I2C.c: 153: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 154: return 0;
	clr	a
	jra	00116$
00115$:
;	../../my_STM8_libraries/stm8_I2C.c: 157: *data = I2C_DR;
	ldw	x, (0x05, sp)
	ld	a, 0x5216
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 158: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 159: I2C_CR2 |= I2C_CR2_ACK;
	bset	0x5211, #2
;	../../my_STM8_libraries/stm8_I2C.c: 160: return 1;
	ld	a, #0x01
00116$:
;	../../my_STM8_libraries/stm8_I2C.c: 161: }
	ldw	x, (2, sp)
	addw	sp, #6
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
