;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module my_millis
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _millis
	.globl _tim4_init
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _ms_counter
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_ms_counter::
	.ds 4
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
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int 0x000000 ; int17
	int 0x000000 ; int18
	int 0x000000 ; int19
	int 0x000000 ; int20
	int 0x000000 ; int21
	int 0x000000 ; int22
	int _TIM4_UPD_OVF_IRQHandler ; int23
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
;	my_millis.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
;	my_millis.c: 8: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	my_millis.c: 9: ms_counter++;
	ldw	x, _ms_counter+2
	ldw	y, _ms_counter+0
	incw	x
	jrne	00103$
	incw	y
00103$:
	ldw	_ms_counter+2, x
	ldw	_ms_counter+0, y
;	my_millis.c: 10: }
	iret
;	my_millis.c: 12: void tim4_init(void)
;	-----------------------------------------
;	 function tim4_init
;	-----------------------------------------
_tim4_init:
;	my_millis.c: 14: TIM4_CR1 = 0;      // выключаем таймер
	mov	0x5340+0, #0x00
;	my_millis.c: 16: TIM4_PSCR = 0x07;  // prescaler = 128
	mov	0x5347+0, #0x07
;	my_millis.c: 17: TIM4_ARR  = 124;   // 1 мс
	mov	0x5348+0, #0x7c
;	my_millis.c: 19: TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
	bset	0x5343, #0
;	my_millis.c: 20: TIM4_SR  = 0;      // сброс флагов
	mov	0x5344+0, #0x00
;	my_millis.c: 22: TIM4_CR1 |= 0x01;  // включаем таймер
	bset	0x5340, #0
;	my_millis.c: 23: }
	ret
;	my_millis.c: 25: uint32_t millis(void)
;	-----------------------------------------
;	 function millis
;	-----------------------------------------
_millis:
;	my_millis.c: 29: disableInterrupts();
	sim
;	my_millis.c: 30: t = ms_counter;
	ldw	x, _ms_counter+2
	ldw	y, _ms_counter+0
;	my_millis.c: 31: enableInterrupts();
	rim
;	my_millis.c: 33: return t;
;	my_millis.c: 34: }
	ret
;	my_millis.c: 38: int main(void) // здесь какбы начинается setup()
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #12
;	my_millis.c: 40: PB_DDR |= LED_MASK;
	bset	0x5007, #5
;	my_millis.c: 41: PB_CR1 |= LED_MASK;
	bset	0x5008, #5
;	my_millis.c: 43: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
	mov	0x50c6+0, #0x00
;	my_millis.c: 45: tim4_init();
	call	_tim4_init
;	my_millis.c: 46: enableInterrupts();   // глобально разрешаем прерывания
	rim
;	my_millis.c: 48: uint32_t timer1 = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	my_millis.c: 50: while(1) // здесь какбы заканчивается setup() и начинается loop()
00104$:
;	my_millis.c: 52: if (millis() - timer1 >= 333)
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
	cpw	x, #0x014d
	ld	a, (0x0b, sp)
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00104$
;	my_millis.c: 54: timer1 = millis();
	call	_millis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	my_millis.c: 55: PB_ODR ^= LED_MASK;   // переключаем светодиод
	bcpl	0x5005, #5
	jra	00104$
;	my_millis.c: 58: }
	addw	sp, #12
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
