;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module blink_interrupt
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _tim4_init
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _last_time
	.globl _ms_counter
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_ms_counter::
	.ds 2
_last_time::
	.ds 2
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
;	blink_interrupt.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
;	blink_interrupt.c: 9: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	blink_interrupt.c: 10: ms_counter++;
	ldw	x, _ms_counter+0
	incw	x
	ldw	_ms_counter+0, x
;	blink_interrupt.c: 11: }
	iret
;	blink_interrupt.c: 13: void tim4_init(void)
;	-----------------------------------------
;	 function tim4_init
;	-----------------------------------------
_tim4_init:
;	blink_interrupt.c: 15: TIM4_CR1 = 0;      // выключаем таймер
	mov	0x5340+0, #0x00
;	blink_interrupt.c: 17: TIM4_PSCR = 0x07;  // prescaler = 128
	mov	0x5347+0, #0x07
;	blink_interrupt.c: 18: TIM4_ARR  = 128;   // 1 мс
	mov	0x5348+0, #0x80
;	blink_interrupt.c: 20: TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
	bset	0x5343, #0
;	blink_interrupt.c: 21: TIM4_SR  = 0;      // сброс флагов
	mov	0x5344+0, #0x00
;	blink_interrupt.c: 23: TIM4_CR1 |= 0x01;  // включаем таймер
	bset	0x5340, #0
;	blink_interrupt.c: 24: }
	ret
;	blink_interrupt.c: 28: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	blink_interrupt.c: 30: PB_DDR |= LED_MASK;
	bset	0x5007, #5
;	blink_interrupt.c: 31: PB_CR1 |= LED_MASK;
	bset	0x5008, #5
;	blink_interrupt.c: 33: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
	mov	0x50c6+0, #0x00
;	blink_interrupt.c: 35: tim4_init();
	call	_tim4_init
;	blink_interrupt.c: 36: enableInterrupts();   // глобально разрешаем прерывания
	rim
;	blink_interrupt.c: 38: while (1)
00104$:
;	blink_interrupt.c: 40: if ((uint16_t)(ms_counter - last_time) >= 1000)
	ldw	x, _ms_counter+0
	subw	x, _last_time+0
	cpw	x, #0x03e8
	jrc	00104$
;	blink_interrupt.c: 42: PB_ODR ^= LED_MASK;   // переключаем светодиод
	bcpl	0x5005, #5
;	blink_interrupt.c: 43: last_time = ms_counter;
	ldw	x, _ms_counter+0
	ldw	_last_time+0, x
	jra	00104$
;	blink_interrupt.c: 46: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__ms_counter:
	.dw #0x0000
__xinit__last_time:
	.dw #0x0000
	.area CABS (ABS)
