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
	.globl _ping_I2C
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
;	../../my_STM8_libraries/stm8_I2C.c: 8: PB_DDR |= (1 << 4) | (1 << 5);  // настраиваем PB4 и PB5 как выход
	ld	a, 0x5007
	or	a, #0x30
	ld	0x5007, a
;	../../my_STM8_libraries/stm8_I2C.c: 9: PB_CR1 &= ~((1 << 4) | (1 << 5));	// настраиваем PB4 и PB5 открытый коллектор 
	ld	a, 0x5008
	and	a, #0xcf
	ld	0x5008, a
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
;	../../my_STM8_libraries/stm8_I2C.c: 23: uint8_t ping_I2C(uint8_t address)
;	-----------------------------------------
;	 function ping_I2C
;	-----------------------------------------
_ping_I2C:
	sub	sp, #3
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_I2C.c: 27: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
	bset	0x5211, #0
;	../../my_STM8_libraries/stm8_I2C.c: 29: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
	ldw	x, #0xc350
	ldw	(0x02, sp), x
00103$:
	btjt	0x5217, #0, 00105$
;	../../my_STM8_libraries/stm8_I2C.c: 31: if (--timeout == 0) 
	ldw	x, (0x02, sp)
	decw	x
	ldw	(0x02, sp), x
	jrne	00103$
;	../../my_STM8_libraries/stm8_I2C.c: 33: I2C_CR2 |= I2C_CR2_STOP;
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 34: return 0;
	clr	a
	jra	00114$
00105$:
;	../../my_STM8_libraries/stm8_I2C.c: 40: I2C_DR = (address << 1);	//записываем в регистр данных адрес устройства к которому мы хотим обратиться + 0, что значит что мы хотим write
	ld	a, (0x01, sp)
	sll	a
	ld	0x5216, a
;	../../my_STM8_libraries/stm8_I2C.c: 42: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))	//ждём либо флага подтверждения адреса либо ошибки подтверждения
	ldw	x, #0xc350
00109$:
	btjt	0x5217, #1, 00111$
	btjt	0x5218, #2, 00111$
;	../../my_STM8_libraries/stm8_I2C.c: 44: if (--timeout == 0) 
	decw	x
	tnzw	x
	jrne	00109$
;	../../my_STM8_libraries/stm8_I2C.c: 46: I2C_CR2 |= I2C_CR2_STOP;
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 47: return 0;
	clr	a
	jra	00114$
00111$:
;	../../my_STM8_libraries/stm8_I2C.c: 50: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
	btjf	0x5217, #1, 00113$
;	../../my_STM8_libraries/stm8_I2C.c: 52: (void)I2C_SR1;	//сбрасываем как в RM
	ld	a, 0x5217
;	../../my_STM8_libraries/stm8_I2C.c: 53: (void)I2C_SR3;
	ld	a, 0x5219
;	../../my_STM8_libraries/stm8_I2C.c: 55: I2C_CR2 |= I2C_CR2_STOP;	//даём стоп на линии
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 56: return 1;
	ld	a, #0x01
	jra	00114$
00113$:
;	../../my_STM8_libraries/stm8_I2C.c: 58: I2C_SR2 &= ~I2C_SR2_AF;	//если ошибка подтверждения
	bres	0x5218, #2
;	../../my_STM8_libraries/stm8_I2C.c: 60: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
	bset	0x5211, #1
;	../../my_STM8_libraries/stm8_I2C.c: 61: return 0;
	clr	a
00114$:
;	../../my_STM8_libraries/stm8_I2C.c: 62: }
	addw	sp, #3
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
