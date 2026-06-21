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
	.globl _clearADDR_I2C
	.globl _setACK_I2C
	.globl _writeAddr_I2C
	.globl _writeByte_I2C
	.globl _ping_I2C
	.globl _writeReg_I2C
	.globl _readByte_I2C
	.globl _readReg_I2C
	.globl _readBuffer2_I2C
	.globl _readBuffer_I2C
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
;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
	bres	0x5210, #0
;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
	mov	0x5212+0, #0x10
;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
	mov	0x521b+0, #0x50
;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
	mov	0x521c+0, #0x00
;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
	mov	0x521d+0, #0x11
;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
	bset	0x5210, #0
;	../../my_STM8_libraries/stm8_I2C.c: 18: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
;	-----------------------------------------
;	 function stop_I2C
;	-----------------------------------------
_stop_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 23: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
;	-----------------------------------------
;	 function start_I2C
;	-----------------------------------------
_start_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
	bset	0x5211, #0
;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
	ldw	x, #0xc350
00103$:
	btjt	0x5217, #0, 00105$
;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00103$
;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
	clr	a
	ret
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_I2C.c: 39: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
;	-----------------------------------------
;	 function clearADDR_I2C
;	-----------------------------------------
_clearADDR_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
	ld	a, 0x5217
;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
	ld	a, 0x5219
;	../../my_STM8_libraries/stm8_I2C.c: 44: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
;	-----------------------------------------
;	 function setACK_I2C
;	-----------------------------------------
_setACK_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
	ld	a, 0x5211
	tnz	(0x01, sp)
	jrne	00102$
	and	a, #0xfb
	ld	0x5211, a
	jra	00104$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 48: else I2C_CR2 |= I2C_CR2_ACK;
	or	a, #0x04
	ld	0x5211, a
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 49: }
	pop	a
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
;	-----------------------------------------
;	 function writeAddr_I2C
;	-----------------------------------------
_writeAddr_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
	sll	a
	tnz	(0x03, sp)
	jrne	00102$
	ld	0x5216, a
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
	push	a
	ld	a, (0x04, sp)
	dec	a
	pop	a
	jrne	00119$
	or	a, #0x01
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
00119$:
	ldw	x, #0xc350
00108$:
	btjt	0x5217, #1, 00110$
	btjt	0x5218, #2, 00110$
;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00108$
;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
	clr	a
	jra	00113$
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
	btjf	0x5217, #1, 00112$
;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
	ld	a, #0x01
	jra	00113$
00112$:
;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
	clr	a
00113$:
;	../../my_STM8_libraries/stm8_I2C.c: 72: }
	popw	x
	addw	sp, #1
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
;	-----------------------------------------
;	 function writeByte_I2C
;	-----------------------------------------
_writeByte_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
	ldw	x, #0xc350
00105$:
	ld	a, 0x5217
	jrmi	00107$
;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
	btjf	0x5218, #2, 00102$
;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
	clr	a
	ret
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
	decw	x
	tnzw	x
	jrne	00105$
;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
	clr	a
	ret
00107$:
;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_I2C.c: 95: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
;	-----------------------------------------
;	 function ping_I2C
;	-----------------------------------------
_ping_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00105$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00105$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
	ld	a, #0x01
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 104: }
	addw	sp, #1
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
;	-----------------------------------------
;	 function writeReg_I2C
;	-----------------------------------------
_writeReg_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00109$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00109$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00109$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
	ld	a, (0x05, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00109$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
	ld	a, #0x01
00109$:
;	../../my_STM8_libraries/stm8_I2C.c: 119: }
	ldw	x, (2, sp)
	addw	sp, #5
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
;	-----------------------------------------
;	 function readByte_I2C
;	-----------------------------------------
_readByte_I2C:
	sub	sp, #3
	ld	(0x03, sp), a
	ldw	(0x01, sp), x
;	../../my_STM8_libraries/stm8_I2C.c: 125: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00110$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 127: if (writeAddr_I2C(address, READ) == 0) return 0;
	push	#0x01
	ld	a, (0x04, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00110$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 129: setACK_I2C(LOW);
	clr	a
	call	_setACK_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 131: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 133: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 135: while (!(I2C_SR1 & I2C_SR1_RXNE))
	ldw	x, #0xc350
00107$:
	btjt	0x5217, #6, 00109$
;	../../my_STM8_libraries/stm8_I2C.c: 137: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00107$
;	../../my_STM8_libraries/stm8_I2C.c: 139: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 140: return 0;
	clr	a
	jra	00110$
00109$:
;	../../my_STM8_libraries/stm8_I2C.c: 143: *data = I2C_DR;
	ld	a, 0x5216
	ldw	x, (0x01, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 145: setACK_I2C(HIGH);
	ld	a, #0x01
	call	_setACK_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
	ld	a, #0x01
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 148: }
	addw	sp, #3
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
;	-----------------------------------------
;	 function readReg_I2C
;	-----------------------------------------
_readReg_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 153: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00116$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 155: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00116$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 157: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 159: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00116$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 161: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00116$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 163: if (writeAddr_I2C(address, READ) == 0) return 0;
	push	#0x01
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00110$
	clr	a
	jra	00116$
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 165: setACK_I2C(LOW);
	clr	a
	call	_setACK_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 167: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 169: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 171: while (!(I2C_SR1 & I2C_SR1_RXNE))
	ldw	x, #0xc350
00113$:
	btjt	0x5217, #6, 00115$
;	../../my_STM8_libraries/stm8_I2C.c: 173: if (--timeout == 0)
	decw	x
	tnzw	x
	jrne	00113$
;	../../my_STM8_libraries/stm8_I2C.c: 175: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 176: return 0;
	clr	a
	jra	00116$
00115$:
;	../../my_STM8_libraries/stm8_I2C.c: 179: *data = I2C_DR;
	ldw	x, (0x05, sp)
	ld	a, 0x5216
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 181: setACK_I2C(HIGH);
	ld	a, #0x01
	call	_setACK_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
	ld	a, #0x01
00116$:
;	../../my_STM8_libraries/stm8_I2C.c: 184: }
	ldw	x, (2, sp)
	addw	sp, #6
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
;	-----------------------------------------
;	 function readBuffer2_I2C
;	-----------------------------------------
_readBuffer2_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 189: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00116$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 191: if (writeAddr_I2C(address, WRITE) == 0) return 0;
	push	#0x00
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00116$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 192: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 194: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00116$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 196: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00116$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 198: if (writeAddr_I2C(address, READ) == 0) return 0;
	push	#0x01
	ld	a, (0x02, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00110$
	clr	a
	jra	00116$
00110$:
;	../../my_STM8_libraries/stm8_I2C.c: 199: clearADDR_I2C();
	call	_clearADDR_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 200: setACK_I2C(LOW);
	clr	a
	call	_setACK_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 202: while (!(I2C_SR1 & I2C_SR1_BTF))
	ldw	x, #0xc350
00113$:
	btjt	0x5217, #2, 00115$
;	../../my_STM8_libraries/stm8_I2C.c: 204: if (--timeout == 0)
	decw	x
	tnzw	x
	jrne	00113$
;	../../my_STM8_libraries/stm8_I2C.c: 206: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 207: return 0;
	clr	a
	jra	00116$
00115$:
;	../../my_STM8_libraries/stm8_I2C.c: 210: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 212: buf[0] = I2C_DR;
	ldw	x, (0x05, sp)
	ld	a, 0x5216
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 213: buf[1] = I2C_DR;
	incw	x
	ld	a, 0x5216
	ld	(x), a
;	../../my_STM8_libraries/stm8_I2C.c: 215: return 1;
	ld	a, #0x01
00116$:
;	../../my_STM8_libraries/stm8_I2C.c: 216: }
	ldw	x, (2, sp)
	addw	sp, #6
	jp	(x)
;	../../my_STM8_libraries/stm8_I2C.c: 217: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
;	-----------------------------------------
;	 function readBuffer_I2C
;	-----------------------------------------
_readBuffer_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 220: }
	ldw	x, (1, sp)
	addw	sp, #6
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
