;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_TIM4
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tick_TIM4
	.globl _init_TIM4
	.globl _millis
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
__millis:
	.ds 4
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
;	../../libs/stm8_TIM4.c: 7: void tick_TIM4(void)
;	-----------------------------------------
;	 function tick_TIM4
;	-----------------------------------------
_tick_TIM4:
;	../../libs/stm8_TIM4.c: 9: _millis++;
	ldw	x, __millis+2
	ldw	y, __millis+0
	incw	x
	jrne	00103$
	incw	y
00103$:
	ldw	__millis+2, x
	ldw	__millis+0, y
;	../../libs/stm8_TIM4.c: 10: }
	ret
;	../../libs/stm8_TIM4.c: 12: void init_TIM4(void)
;	-----------------------------------------
;	 function init_TIM4
;	-----------------------------------------
_init_TIM4:
;	../../libs/stm8_TIM4.c: 14: _millis = 0;
	clrw	x
	ldw	__millis+2, x
	ldw	__millis+0, x
;	../../libs/stm8_TIM4.c: 16: TIM4_CR1 = 0;
	mov	0x5340+0, #0x00
;	../../libs/stm8_TIM4.c: 17: TIM4_PSCR = 0x07;
	mov	0x5347+0, #0x07
;	../../libs/stm8_TIM4.c: 18: TIM4_ARR  = 124;
	mov	0x5348+0, #0x7c
;	../../libs/stm8_TIM4.c: 20: TIM4_IER |= 0x01;
	bset	0x5343, #0
;	../../libs/stm8_TIM4.c: 21: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	../../libs/stm8_TIM4.c: 22: TIM4_CR1 |= 0x01;
	bset	0x5340, #0
;	../../libs/stm8_TIM4.c: 23: }
	ret
;	../../libs/stm8_TIM4.c: 25: uint32_t millis(void)
;	-----------------------------------------
;	 function millis
;	-----------------------------------------
_millis:
;	../../libs/stm8_TIM4.c: 29: disableInterrupts();
	sim
;	../../libs/stm8_TIM4.c: 30: ms = _millis;
	ldw	x, __millis+2
	ldw	y, __millis+0
;	../../libs/stm8_TIM4.c: 31: enableInterrupts();
	rim
;	../../libs/stm8_TIM4.c: 33: return ms;
;	../../libs/stm8_TIM4.c: 34: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit___millis:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
	.area CABS (ABS)
