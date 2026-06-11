;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_time
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tim4_tick
	.globl _time_init
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
;	stm8_time.c: 7: void tim4_tick(void)
;	-----------------------------------------
;	 function tim4_tick
;	-----------------------------------------
_tim4_tick:
;	stm8_time.c: 9: _millis++;
	ldw	x, __millis+2
	ldw	y, __millis+0
	incw	x
	jrne	00103$
	incw	y
00103$:
	ldw	__millis+2, x
	ldw	__millis+0, y
;	stm8_time.c: 10: }
	ret
;	stm8_time.c: 12: void time_init(void)
;	-----------------------------------------
;	 function time_init
;	-----------------------------------------
_time_init:
;	stm8_time.c: 14: _millis = 0;
	clrw	x
	ldw	__millis+2, x
	ldw	__millis+0, x
;	stm8_time.c: 16: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	stm8_time.c: 18: TIM4_CR1 = 0;
	mov	0x5340+0, #0x00
;	stm8_time.c: 19: TIM4_PSCR = 0x07;
	mov	0x5347+0, #0x07
;	stm8_time.c: 20: TIM4_ARR  = 124;
	mov	0x5348+0, #0x7c
;	stm8_time.c: 22: TIM4_IER |= 0x01;
	bset	0x5343, #0
;	stm8_time.c: 23: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	stm8_time.c: 24: TIM4_CR1 |= 0x01;
	bset	0x5340, #0
;	stm8_time.c: 25: }
	ret
;	stm8_time.c: 27: uint32_t millis(void)
;	-----------------------------------------
;	 function millis
;	-----------------------------------------
_millis:
;	stm8_time.c: 31: disableInterrupts();
	sim
;	stm8_time.c: 32: ms = _millis;
	ldw	x, __millis+2
	ldw	y, __millis+0
;	stm8_time.c: 33: enableInterrupts();
	rim
;	stm8_time.c: 35: return ms;
;	stm8_time.c: 36: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit___millis:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
	.area CABS (ABS)
