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
	.globl _writeReg
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
;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address)
;	-----------------------------------------
;	 function writeAddr_I2C
;	-----------------------------------------
_writeAddr_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 48: I2C_DR = (address << 1);	//записываем в регистр данных адрес устройства к которому мы хотим обратиться + 0, что значит что мы хотим write
	sll	a
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 49: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
	ldw	x, #0xc350
00104$:
	btjt	0x5217, #1, 00106$
	btjt	0x5218, #2, 00106$
;	../../my_STM8_libraries/stm8_I2C.c: 51: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00104$
;	../../my_STM8_libraries/stm8_I2C.c: 53: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 54: return 0;
	clr	a
	ret
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 57: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
	btjf	0x5217, #1, 00108$
;	../../my_STM8_libraries/stm8_I2C.c: 59: (void)I2C_SR1;	//сбрасываем как в RM
	ld	a, 0x5217
;	../../my_STM8_libraries/stm8_I2C.c: 60: (void)I2C_SR3;
	ld	a, 0x5219
;	../../my_STM8_libraries/stm8_I2C.c: 61: return 1;
	ld	a, #0x01
	ret
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 63: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 64: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 65: return 0;
	clr	a
;	../../my_STM8_libraries/stm8_I2C.c: 66: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 68: uint8_t writeByte_I2C(uint8_t data)
;	-----------------------------------------
;	 function writeByte_I2C
;	-----------------------------------------
_writeByte_I2C:
;	../../my_STM8_libraries/stm8_I2C.c: 72: I2C_DR = data;	//записываем байт в реистр данных
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 74: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
	ldw	x, #0xc350
00105$:
	ld	a, 0x5217
	jrmi	00107$
;	../../my_STM8_libraries/stm8_I2C.c: 76: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
	btjf	0x5218, #2, 00102$
;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 79: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 80: return 0;
	clr	a
	ret
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 82: if (--timeout == 0)	//проверка таймаута
	decw	x
	tnzw	x
	jrne	00105$
;	../../my_STM8_libraries/stm8_I2C.c: 84: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 85: return 0;
	clr	a
	ret
00107$:
;	../../my_STM8_libraries/stm8_I2C.c: 88: return 1;
	ld	a, #0x01
;	../../my_STM8_libraries/stm8_I2C.c: 89: }
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 91: uint8_t ping_I2C(uint8_t address)
;	-----------------------------------------
;	 function ping_I2C
;	-----------------------------------------
_ping_I2C:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 93: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00105$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 94: if (writeAddr_I2C(address) == 0) return 0; 
	ld	a, (0x01, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00105$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 95: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 96: return 1;
	ld	a, #0x01
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 97: }
	addw	sp, #1
	ret
;	../../my_STM8_libraries/stm8_I2C.c: 99: uint8_t writeReg(uint8_t address, uint8_t reg, uint8_t data)
;	-----------------------------------------
;	 function writeReg
;	-----------------------------------------
_writeReg:
	push	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 101: if (start_I2C() == 0) return 0;
	call	_start_I2C
	tnz	a
	jrne	00102$
	clr	a
	jra	00109$
00102$:
;	../../my_STM8_libraries/stm8_I2C.c: 102: if (writeAddr_I2C(address) == 0) return 0;
	ld	a, (0x01, sp)
	call	_writeAddr_I2C
	tnz	a
	jrne	00104$
	clr	a
	jra	00109$
00104$:
;	../../my_STM8_libraries/stm8_I2C.c: 103: if (writeByte_I2C(reg) == 0) return 0;
	ld	a, (0x04, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00106$
	clr	a
	jra	00109$
00106$:
;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeByte_I2C(data) == 0) return 0;
	ld	a, (0x05, sp)
	call	_writeByte_I2C
	tnz	a
	jrne	00108$
	clr	a
	jra	00109$
00108$:
;	../../my_STM8_libraries/stm8_I2C.c: 105: stop_I2C();
	call	_stop_I2C
;	../../my_STM8_libraries/stm8_I2C.c: 106: return 1;
	ld	a, #0x01
00109$:
;	../../my_STM8_libraries/stm8_I2C.c: 107: }
	ldw	x, (2, sp)
	addw	sp, #5
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
