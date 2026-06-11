;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_ADC
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_ADC
	.globl _start_ADC
	.globl _isReady_ADC
	.globl _getValue_ADC
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
;	stm8_ADC.c: 4: void init_ADC(uint8_t channel) {
;	-----------------------------------------
;	 function init_ADC
;	-----------------------------------------
_init_ADC:
	push	a
	ld	xl, a
;	stm8_ADC.c: 5: CLK_PCKENR2 |= (1 << 3);	//включить тактирование адс
	bset	0x50ca, #3
;	stm8_ADC.c: 7: ADC_CSR &= ~0x0F;        // Очистить старый канал
	ld	a, 0x5400
	and	a, #0xf0
	ld	0x5400, a
;	stm8_ADC.c: 8: ADC_CSR |= (channel & 0x0F); // Записать номер канала
	ld	a, 0x5400
	ld	(0x01, sp), a
	ld	a, xl
	and	a, #0x0f
	or	a, (0x01, sp)
	ld	0x5400, a
;	stm8_ADC.c: 10: if (channel < 8) 			//отключаем триггер шмидта на выбраном канале
	ld	a, xl
	cp	a, #0x08
	jrnc	00102$
;	stm8_ADC.c: 11: ADC_TDRL |= (1 << channel);
	ld	a, 0x5407
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00115$
00114$:
	sll	(0x02, sp)
	dec	a
	jrne	00114$
00115$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5407, a
	jra	00103$
00102$:
;	stm8_ADC.c: 13: ADC_TDRH |= (1 << (channel - 8));
	ld	a, 0x5406
	ld	(0x01, sp), a
	subw	x, #8
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00117$
00116$:
	sll	(1, sp)
	dec	a
	jrne	00116$
00117$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5406, a
00103$:
;	stm8_ADC.c: 15: ADC_CR2 |= (1 << 3);		//выравнивание вправо
	bset	0x5402, #3
;	stm8_ADC.c: 17: ADC_CR1 &= ~(0b111 << 4);	//очищаем значение делителя
	ld	a, 0x5401
	and	a, #0x8f
	ld	0x5401, a
;	stm8_ADC.c: 18: ADC_CR1 |= (0b100 << 4);	//устанавливаем делитьеть на 8(2Мгц для ADC)
	bset	0x5401, #6
;	stm8_ADC.c: 20: ADC_CR1 |= (1 << 0);		//запускаем ADON(прогрев)
	bset	0x5401, #0
;	stm8_ADC.c: 21: }
	pop	a
	ret
;	stm8_ADC.c: 23: void start_ADC(void) {
;	-----------------------------------------
;	 function start_ADC
;	-----------------------------------------
_start_ADC:
;	stm8_ADC.c: 24: ADC_CR1 |= (1 << 0);		//вторая запись в адон запускает преобразование
	bset	0x5401, #0
;	stm8_ADC.c: 25: }
	ret
;	stm8_ADC.c: 27: uint8_t isReady_ADC(void) {
;	-----------------------------------------
;	 function isReady_ADC
;	-----------------------------------------
_isReady_ADC:
;	stm8_ADC.c: 28: if (ADC_CSR & (1 << 7)) {return 1;}	//1 если значение готово
	ld	a, 0x5400
	jrpl	00102$
	ld	a, #0x01
	ret
00102$:
;	stm8_ADC.c: 29: return 0;
	clr	a
;	stm8_ADC.c: 30: }
	ret
;	stm8_ADC.c: 32: uint16_t getValue_ADC (void) {
;	-----------------------------------------
;	 function getValue_ADC
;	-----------------------------------------
_getValue_ADC:
	sub	sp, #2
;	stm8_ADC.c: 33: uint16_t val = ADC_DRL;
	ld	a, 0x5405
	ld	xl, a
;	stm8_ADC.c: 34: val |= (uint16_t)ADC_DRH << 8;
	ld	a, 0x5404
	ld	xh, a
	clr	(0x02, sp)
;	stm8_ADC.c: 36: ADC_CSR &= ~(1 << 7);
	bres	0x5400, #7
;	stm8_ADC.c: 38: return val;
;	stm8_ADC.c: 39: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
