;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _adc_filter
	.globl _analogRead
	.globl _adc_init
	.globl _tim2_init
	.globl _tim4_inerrupts
	.globl _TIM2_UPD_OVF_IRQHandler
	.globl _tim4_tick
	.globl _time_init
	.globl _millis
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_adc_filter_filtered_10000_15:
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

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
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int 0x000000 ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int 0x000000 ; int11
	int 0x000000 ; int12
	int _TIM2_UPD_OVF_IRQHandler ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int 0x000000 ; int17
	int 0x000000 ; int18
	int 0x000000 ; int19
	int 0x000000 ; int20
	int 0x000000 ; int21
	int 0x000000 ; int22
	int _tim4_inerrupts ; int23
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
;	main.c: 65: static uint16_t filtered = 0;
	clrw	x
	ldw	_adc_filter_filtered_10000_15+0, x
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 16: void TIM2_UPD_OVF_IRQHandler(void) __interrupt(13)
;	-----------------------------------------
;	 function TIM2_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM2_UPD_OVF_IRQHandler:
;	main.c: 18: TIM2_SR1 = 0;   // ОБЯЗАТЕЛЬНО первым делом
	mov	0x5304+0, #0x00
;	main.c: 20: PC_ODR ^= (1 << 4) | (1 << 5);
	ld	a, 0x500a
	xor	a, #0x30
	ld	0x500a, a
;	main.c: 21: }
	iret
;	main.c: 23: void tim4_inerrupts(void) __interrupt(23)
;	-----------------------------------------
;	 function tim4_inerrupts
;	-----------------------------------------
_tim4_inerrupts:
	clr	a
	div	x, a
;	main.c: 25: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	main.c: 26: tim4_tick();
	call	_tim4_tick
;	main.c: 27: }
	iret
;	main.c: 29: void tim2_init(void)
;	-----------------------------------------
;	 function tim2_init
;	-----------------------------------------
_tim2_init:
;	main.c: 31: TIM2_CR1 = 0;          // стоп таймера
	mov	0x5300+0, #0x00
;	main.c: 33: TIM2_PSCR = 4;         // prescaler = 16
	mov	0x530e+0, #0x04
;	main.c: 34: TIM2_ARRH = ARR_MAX >> 8;
	mov	0x530f+0, #0x03
;	main.c: 35: TIM2_ARRL = ARR_MAX & 0xFF;    //  частота 500гц по умолчанию
	mov	0x5310+0, #0xe8
;	main.c: 37: TIM2_IER |= 0x01;      // update interrupt
	bset	0x5303, #0
;	main.c: 38: TIM2_SR1 = 0;          // сброс флага
	mov	0x5304+0, #0x00
;	main.c: 40: TIM2_CR1 |= 0x01;      // старт
	bset	0x5300, #0
;	main.c: 41: }
	ret
;	main.c: 43: void adc_init(void)
;	-----------------------------------------
;	 function adc_init
;	-----------------------------------------
_adc_init:
;	main.c: 45: ADC_CR2 &= ~(1 << 3);   // ALIGN = 0 → right aligned
	bres	0x5402, #3
;	main.c: 47: ADC_CR1 = (ADC_CR1 & ~0x70) | 0x70;  // делитель /18
	ld	a, 0x5401
	and	a, #0x8f
	or	a, #0x70
	ld	0x5401, a
;	main.c: 49: ADC_CR1 |= (1 << 0);   // включить ADC
	bset	0x5401, #0
;	main.c: 50: }
	ret
;	main.c: 52: uint8_t analogRead(adc_port_t channel)
;	-----------------------------------------
;	 function analogRead
;	-----------------------------------------
_analogRead:
	push	a
	ld	(0x01, sp), a
;	main.c: 54: ADC_CSR = (ADC_CSR & ~0x0F) | channel;
	ld	a, 0x5400
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5400, a
;	main.c: 56: ADC_CR1 |=  (1 << 0);  // ADON = 1 → старт
	bset	0x5401, #0
;	main.c: 58: while (!(ADC_CSR & (1 << 7)));
00101$:
	ld	a, 0x5400
	jrpl	00101$
;	main.c: 60: return ADC_DRH;
	ld	a, 0x5404
;	main.c: 61: }
	addw	sp, #1
	ret
;	main.c: 63: uint8_t adc_filter(uint8_t new_value)
;	-----------------------------------------
;	 function adc_filter
;	-----------------------------------------
_adc_filter:
	sub	sp, #2
;	main.c: 67: filtered = filtered + new_value - (filtered >> 3);
	ldw	y, _adc_filter_filtered_10000_15+0
	ld	(0x02, sp), a
	clr	(0x01, sp)
	addw	y, (0x01, sp)
	ldw	x, _adc_filter_filtered_10000_15+0
	srlw	x
	srlw	x
	srlw	x
	ldw	(0x01, sp), y
	negw	x
	addw	x, (0x01, sp)
;	main.c: 69: return filtered >> 3;
	ldw	_adc_filter_filtered_10000_15+0, x
	srlw	x
	srlw	x
	srlw	x
	ld	a, xl
;	main.c: 70: }
	addw	sp, #2
	ret
;	main.c: 72: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #12
;	main.c: 74: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 76: PC_DDR |= (1 << 4) | (1 << 5);
	ld	a, 0x500c
	or	a, #0x30
	ld	0x500c, a
;	main.c: 77: PC_CR1 |= (1 << 4) | (1 << 5);
	ld	a, 0x500d
	or	a, #0x30
	ld	0x500d, a
;	main.c: 78: PC_ODR &= ~((1 << 4) | (1 << 5));
	ld	a, 0x500a
	and	a, #0xcf
	ld	0x500a, a
;	main.c: 79: PC_ODR |= (1 << 4);
	bset	0x500a, #4
;	main.c: 81: PD_DDR &= ~(1 << 5);
	bres	0x5011, #5
;	main.c: 82: PD_CR1 &= ~(1 << 5);
	bres	0x5012, #5
;	main.c: 83: PD_CR2 &= ~(1 << 5);
	bres	0x5013, #5
;	main.c: 85: adc_init();
	call	_adc_init
;	main.c: 87: tim2_init();
	call	_tim2_init
;	main.c: 88: time_init();
	call	_time_init
;	main.c: 89: enableInterrupts();
	rim
;	main.c: 91: uint32_t timer0 = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	main.c: 93: while (1) {
00104$:
;	main.c: 94: if (millis() - timer0 >= 10) {
	call	_millis
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
	ldw	x, (0x07, sp)
	subw	x, (0x03, sp)
	ldw	(0x0b, sp), x
	ld	a, (0x06, sp)
	sbc	a, (0x02, sp)
	ld	(0x0a, sp), a
	ld	a, (0x05, sp)
	sbc	a, (0x01, sp)
	push	a
	ldw	x, (0x0c, sp)
	cpw	x, #0x000a
	ld	a, (0x0b, sp)
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00104$
;	main.c: 95: timer0 = millis();
	call	_millis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	main.c: 97: uint8_t pot = adc_filter(analogRead(AIN5));
	ld	a, #0x05
	call	_analogRead
	call	_adc_filter
;	main.c: 98: uint16_t arr = ARR_MAX - ((uint32_t)pot * (ARR_MAX - ARR_MIN)) / 255;
	clrw	x
	clr	(0x09, sp)
	push	a
	pushw	x
	clr	a
	push	a
	push	#0xc7
	push	#0x03
	clrw	x
	pushw	x
	call	__mullong
	addw	sp, #8
	push	#0xff
	push	#0x00
	push	#0x00
	push	#0x00
	pushw	x
	pushw	y
	call	__divulong
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	x, #0x03e8
	subw	x, (0x0b, sp)
;	main.c: 100: TIM2_ARRH = arr >> 8;
	ld	a, xh
	ld	0x530f, a
;	main.c: 101: TIM2_ARRL = arr & 0xFF;
	ld	a, xl
	ld	0x5310, a
	jra	00104$
;	main.c: 104: }
	addw	sp, #12
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
