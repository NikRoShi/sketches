;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _tim4_inerrupts
	.globl _digitalRead
	.globl _digitalWrite
	.globl _pinMode
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
;	main.c: 6: void tim4_inerrupts(void) __interrupt(23)
;	-----------------------------------------
;	 function tim4_inerrupts
;	-----------------------------------------
_tim4_inerrupts:
	clr	a
	div	x, a
;	main.c: 8: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	main.c: 9: tim4_tick();
	call	_tim4_tick
;	main.c: 10: }
	iret
;	main.c: 12: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #9
;	main.c: 14: pinMode(PORT_A, 1, PIN_INPUT_PULLUP);
	push	#0x02
	push	#0x01
	clr	a
	call	_pinMode
;	main.c: 15: pinMode(PORT_B, 5, PIN_OUTPUT);
	push	#0x01
	push	#0x05
	ld	a, #0x01
	call	_pinMode
;	main.c: 17: time_init();
	call	_time_init
;	main.c: 18: enableInterrupts();
	rim
;	main.c: 20: uint32_t timer0 = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	main.c: 22: uint8_t flag = 0;
	clr	(0x05, sp)
;	main.c: 24: while(1)
00116$:
;	main.c: 26: button = !digitalRead(PORT_A, 1);
	push	#0x01
	clr	a
	call	_digitalRead
	sub	a, #0x01
	clr	a
	rlc	a
;	main.c: 27: if (button == 1 && flag == 0 && millis() - timer0 >= 50) {
	ld	(0x06, sp), a
	dec	a
	jrne	00184$
	ld	a, #0x01
	ld	(0x07, sp), a
	.byte 0xc5
00184$:
	clr	(0x07, sp)
00185$:
;	main.c: 29: flag = !flag;
	ld	a, (0x05, sp)
	sub	a, #0x01
	clr	a
	rlc	a
	ld	(0x08, sp), a
;	main.c: 27: if (button == 1 && flag == 0 && millis() - timer0 >= 50) {
	tnz	(0x07, sp)
	jreq	00111$
	tnz	(0x05, sp)
	jrne	00111$
	call	_millis
	subw	x, (0x03, sp)
	ld	a, yl
	sbc	a, (0x02, sp)
	ld	yl, a
	ld	a, yh
	sbc	a, (0x01, sp)
	push	a
	cpw	x, #0x0032
	ld	a, yl
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00111$
;	main.c: 28: timer0 = millis();
	call	_millis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	main.c: 29: flag = !flag;
	ld	a, (0x08, sp)
	ld	(0x05, sp), a
	jra	00116$
00111$:
;	main.c: 32: else if (button == 1 && flag == 1) {
	ld	a, (0x05, sp)
	dec	a
	jrne	00190$
	ld	a, #0x01
	ld	(0x09, sp), a
	.byte 0xc5
00190$:
	clr	(0x09, sp)
00191$:
	tnz	(0x07, sp)
	jreq	00107$
	tnz	(0x09, sp)
	jreq	00107$
;	main.c: 33: digitalWrite(PORT_B, 5, LOW);
	push	#0x00
	push	#0x05
	ld	a, #0x01
	call	_digitalWrite
	jra	00116$
00107$:
;	main.c: 35: else if (button == 0 && flag == 1 && millis() - timer0 >= 50) {
	tnz	(0x06, sp)
	jrne	00102$
	tnz	(0x09, sp)
	jreq	00102$
	call	_millis
	exgw	x, y
	subw	y, (0x03, sp)
	ld	a, xl
	sbc	a, (0x02, sp)
	ld	xl, a
	ld	a, xh
	sbc	a, (0x01, sp)
	push	a
	cpw	y, #0x0032
	ld	a, xl
	sbc	a, #0x00
	pop	a
	sbc	a, #0x00
	jrc	00102$
;	main.c: 36: timer0 = millis();
	call	_millis
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	main.c: 37: flag = !flag;
	ld	a, (0x08, sp)
	ld	(0x05, sp), a
	jp	00116$
00102$:
;	main.c: 39: else digitalWrite(PORT_B, 5, HIGH);
	push	#0x01
	push	#0x05
	ld	a, #0x01
	call	_digitalWrite
;	main.c: 41: }
	jp	00116$
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
