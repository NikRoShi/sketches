;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_TIME
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tick_TIME
	.globl _init_TIME
	.globl _get_milsec
	.globl _get_micsec
	.globl _delay
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
__milsec:
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
;	../../libs/stm8_TIME.c: 5: void tick_TIME(void) {
;	-----------------------------------------
;	 function tick_TIME
;	-----------------------------------------
_tick_TIME:
;	../../libs/stm8_TIME.c: 6: _milsec++;
	ldw	x, __milsec+2
	ldw	y, __milsec+0
	incw	x
	jrne	00103$
	incw	y
00103$:
	ldw	__milsec+2, x
	ldw	__milsec+0, y
;	../../libs/stm8_TIME.c: 7: }
	ret
;	../../libs/stm8_TIME.c: 9: void init_TIME(void) {
;	-----------------------------------------
;	 function init_TIME
;	-----------------------------------------
_init_TIME:
;	../../libs/stm8_TIME.c: 10: _milsec = 0;
	clrw	x
	ldw	__milsec+2, x
	ldw	__milsec+0, x
;	../../libs/stm8_TIME.c: 11: TIM4_CR1 = 0;
	mov	0x5340+0, #0x00
;	../../libs/stm8_TIME.c: 12: TIM4_PSCR = 0x07;
	mov	0x5347+0, #0x07
;	../../libs/stm8_TIME.c: 13: TIM4_ARR  = 124;
	mov	0x5348+0, #0x7c
;	../../libs/stm8_TIME.c: 14: TIM4_IER |= 0x01;
	bset	0x5343, #0
;	../../libs/stm8_TIME.c: 15: TIM4_CR1 |= (1 << 0);
	bset	0x5340, #0
;	../../libs/stm8_TIME.c: 16: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	../../libs/stm8_TIME.c: 17: }
	ret
;	../../libs/stm8_TIME.c: 19: uint32_t get_milsec(void) {
;	-----------------------------------------
;	 function get_milsec
;	-----------------------------------------
_get_milsec:
;	../../libs/stm8_TIME.c: 22: disableInterrupts();
	sim
;	../../libs/stm8_TIME.c: 23: ms = _milsec;
	ldw	x, __milsec+2
	ldw	y, __milsec+0
;	../../libs/stm8_TIME.c: 24: enableInterrupts();
	rim
;	../../libs/stm8_TIME.c: 26: return ms;
;	../../libs/stm8_TIME.c: 27: }
	ret
;	../../libs/stm8_TIME.c: 30: uint32_t get_micsec(void) {
;	-----------------------------------------
;	 function get_micsec
;	-----------------------------------------
_get_micsec:
	sub	sp, #5
;	../../libs/stm8_TIME.c: 34: disableInterrupts();
	sim
;	../../libs/stm8_TIME.c: 35: ms = _milsec;
	ldw	x, __milsec+2
	ldw	y, __milsec+0
;	../../libs/stm8_TIME.c: 36: ticks = TIM4_CNTR; // Текущее значение счетчика (0-124)
	ld	a, 0x5346
	ld	(0x01, sp), a
;	../../libs/stm8_TIME.c: 37: enableInterrupts();
	rim
;	../../libs/stm8_TIME.c: 39: return (ms * 1000) + (uint32_t)(ticks * 8);
	pushw	x
	pushw	y
	push	#0xe8
	push	#0x03
	clrw	x
	pushw	x
	call	__mullong
	addw	sp, #8
	ldw	(0x04, sp), x
	ldw	(0x02, sp), y
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	sllw	x
	sllw	x
	sllw	x
	exgw	x, y
	clrw	x
	tnzw	y
	jrpl	00103$
	decw	x
00103$:
	addw	y, (0x04, sp)
	clr	a
	adc	a, (0x03, sp)
	ld	xl, a
	clr	a
	adc	a, (0x02, sp)
	ld	xh, a
	exgw	x, y
;	../../libs/stm8_TIME.c: 40: }
	addw	sp, #5
	ret
;	../../libs/stm8_TIME.c: 43: void delay(uint32_t ms) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	sub	sp, #12
;	../../libs/stm8_TIME.c: 44: uint32_t start = get_milsec();
	call	_get_milsec
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../../libs/stm8_TIME.c: 45: while ((get_milsec() - start) < ms);
00101$:
	call	_get_milsec
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
	cpw	x, (0x12, sp)
	ld	a, (0x0b, sp)
	sbc	a, (0x11, sp)
	pop	a
	sbc	a, (0x0f, sp)
	jrc	00101$
;	../../libs/stm8_TIME.c: 46: }
	ldw	x, (13, sp)
	addw	sp, #18
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit___milsec:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
	.area CABS (ABS)
