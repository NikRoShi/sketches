;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_PWM
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_PWM
	.globl _startChannel_PWM
	.globl _stopChannel_PWM
	.globl _write_PWM
	.globl _writePercent_PWM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_memory_period:
	.ds 2
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
;	../../libs/stm8_PWM.c: 5: void init_PWM(uint16_t period) {	// period = Fmaster / Fpwm (для удобства лучше использовать 1023)
;	-----------------------------------------
;	 function init_PWM
;	-----------------------------------------
_init_PWM:
;	../../libs/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
	bset	0x50c7, #5
;	../../libs/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
	ldw	_memory_period+0, x
;	../../libs/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
	ld	a, xh
	ld	0x530f, a
;	../../libs/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
	ld	a, xl
	ld	0x5310, a
;	../../libs/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
	ld	a, 0x5307
	and	a, #0x8f
	ld	0x5307, a
;	../../libs/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
	ld	a, 0x5308
	and	a, #0x8f
	ld	0x5308, a
;	../../libs/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
	ld	a, 0x5309
	and	a, #0x8f
	ld	0x5309, a
;	../../libs/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
	ld	a, 0x5307
	or	a, #0x60
	ld	0x5307, a
;	../../libs/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
	ld	a, 0x5308
	or	a, #0x60
	ld	0x5308, a
;	../../libs/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
	ld	a, 0x5309
	or	a, #0x60
	ld	0x5309, a
;	../../libs/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
	bset	0x5307, #3
;	../../libs/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
	bset	0x5308, #3
;	../../libs/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
	bset	0x5309, #3
;	../../libs/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
	ld	a, 0x5307
	and	a, #0xfc
	ld	0x5307, a
;	../../libs/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
	ld	a, 0x5308
	and	a, #0xfc
	ld	0x5308, a
;	../../libs/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
	ld	a, 0x5309
	and	a, #0xfc
	ld	0x5309, a
;	../../libs/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
	ld	a, 0x5300
	or	a, #0x81
	ld	0x5300, a
;	../../libs/stm8_PWM.c: 30: }
	ret
;	../../libs/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
;	-----------------------------------------
;	 function startChannel_PWM
;	-----------------------------------------
_startChannel_PWM:
;	../../libs/stm8_PWM.c: 33: switch (channel) {
	cp	a, #0x01
	jreq	00101$
	cp	a, #0x02
	jreq	00102$
	cp	a, #0x03
	jreq	00103$
	ret
;	../../libs/stm8_PWM.c: 34: case 1:		//PD4
00101$:
;	../../libs/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
	bset	0x5011, #4
;	../../libs/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
	bset	0x5012, #4
;	../../libs/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
	bset	0x530a, #0
;	../../libs/stm8_PWM.c: 38: break;
	ret
;	../../libs/stm8_PWM.c: 39: case 2:		//PD3
00102$:
;	../../libs/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
	bset	0x5011, #3
;	../../libs/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
	bset	0x5012, #3
;	../../libs/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
	bset	0x530a, #4
;	../../libs/stm8_PWM.c: 43: break;
	ret
;	../../libs/stm8_PWM.c: 44: case 3:		//PA3
00103$:
;	../../libs/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
	bset	0x5002, #3
;	../../libs/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
	bset	0x5003, #3
;	../../libs/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
	bset	0x530b, #0
;	../../libs/stm8_PWM.c: 50: }
;	../../libs/stm8_PWM.c: 51: }
	ret
;	../../libs/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
;	-----------------------------------------
;	 function stopChannel_PWM
;	-----------------------------------------
_stopChannel_PWM:
;	../../libs/stm8_PWM.c: 54: switch (channel) {
	cp	a, #0x01
	jreq	00101$
	cp	a, #0x02
	jreq	00102$
	cp	a, #0x03
	jreq	00103$
	ret
;	../../libs/stm8_PWM.c: 55: case 1:		//PD4
00101$:
;	../../libs/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
	bres	0x530a, #0
;	../../libs/stm8_PWM.c: 57: break;
	ret
;	../../libs/stm8_PWM.c: 58: case 2:		//PD3
00102$:
;	../../libs/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
	bres	0x530a, #4
;	../../libs/stm8_PWM.c: 60: break;
	ret
;	../../libs/stm8_PWM.c: 61: case 3:		//PA3
00103$:
;	../../libs/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
	bres	0x530b, #0
;	../../libs/stm8_PWM.c: 65: }
;	../../libs/stm8_PWM.c: 66: }
	ret
;	../../libs/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
;	-----------------------------------------
;	 function write_PWM
;	-----------------------------------------
_write_PWM:
;	../../libs/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
	ldw	y, x
;	../../libs/stm8_PWM.c: 69: switch (channel) {
	cp	a, #0x01
	jreq	00101$
	cp	a, #0x02
	jreq	00102$
	cp	a, #0x03
	jreq	00103$
	ret
;	../../libs/stm8_PWM.c: 70: case 1:
00101$:
;	../../libs/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
	ld	a, xh
	ld	0x5311, a
;	../../libs/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
	ldw	x, #0x5312
	ld	a, yl
	ld	(x), a
;	../../libs/stm8_PWM.c: 73: break;
	ret
;	../../libs/stm8_PWM.c: 74: case 2:
00102$:
;	../../libs/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
	ld	a, xh
	ld	0x5313, a
;	../../libs/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
	ldw	x, #0x5314
	ld	a, yl
	ld	(x), a
;	../../libs/stm8_PWM.c: 77: break;
	ret
;	../../libs/stm8_PWM.c: 78: case 3:
00103$:
;	../../libs/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
	ld	a, xh
	ld	0x5315, a
;	../../libs/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
	ldw	x, #0x5316
	ld	a, yl
	ld	(x), a
;	../../libs/stm8_PWM.c: 83: }
;	../../libs/stm8_PWM.c: 84: }
	ret
;	../../libs/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
;	-----------------------------------------
;	 function writePercent_PWM
;	-----------------------------------------
_writePercent_PWM:
	sub	sp, #9
	ld	(0x09, sp), a
;	../../libs/stm8_PWM.c: 87: if (percent > 100) percent = 100;
	ld	a, (0x0c, sp)
	cp	a, #0x64
	jrule	00102$
	ld	a, #0x64
	ld	(0x0c, sp), a
00102$:
;	../../libs/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
	ld	a, (0x0c, sp)
	clrw	x
	ldw	(0x01, sp), x
	ldw	y, _memory_period+0
	clr	(0x06, sp)
	clr	(0x05, sp)
	pushw	y
	ldw	y, (0x07, sp)
	pushw	y
	push	a
	clr	a
	push	a
	ldw	x, (0x07, sp)
	pushw	x
	call	__mullong
	addw	sp, #8
	push	#0x64
	push	#0x00
	push	#0x00
	push	#0x00
	pushw	x
	pushw	y
	call	__divulong
	addw	sp, #8
;	../../libs/stm8_PWM.c: 89: write_PWM(channel, value);
	ld	a, (0x09, sp)
	ldw	y, (10, sp)
	ldw	(11, sp), y
	addw	sp, #10
;	../../libs/stm8_PWM.c: 90: }
	jp	_write_PWM
	pop	a
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__memory_period:
	.dw #0x0000
	.area CABS (ABS)
