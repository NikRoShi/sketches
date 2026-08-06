;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _BB_transmite
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _delay
	.globl _init_TIME
	.globl _tick_TIME
	.globl _writePin
	.globl _pinMode
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
	.area	SSEG
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
;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 7: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 8: tick_TIME();
	call	_tick_TIME
;	main.c: 9: }
	iret
;	main.c: 11: void BB_transmite(uint8_t data)
;	-----------------------------------------
;	 function BB_transmite
;	-----------------------------------------
_BB_transmite:
	sub	sp, #2
	ld	(0x01, sp), a
;	main.c: 13: writePin(PD, 2, LOW);	// latc в low
	push	#0x00
	ld	a, #0x02
	ldw	x, #0x500f
	call	_writePin
;	main.c: 14: writePin(PC, 5, LOW);	// clk в low
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x500a
	call	_writePin
;	main.c: 15: writePin(PC, 6, LOW);	// data в low
	push	#0x00
	ld	a, #0x06
	ldw	x, #0x500a
	call	_writePin
	clr	(0x02, sp)
00106$:
;	main.c: 17: for (uint8_t a; a < 8; a++)
	ld	a, (0x02, sp)
	cp	a, #0x08
	jrnc	00104$
;	main.c: 19: if (data & 1)
	ld	a, (0x01, sp)
	srl	a
	jrnc	00102$
;	main.c: 21: writePin(PC, 6, HIGH);	// data в high
	push	#0x01
	ld	a, #0x06
	ldw	x, #0x500a
	call	_writePin
;	main.c: 22: writePin(PC, 5, HIGH);	// clk в high
	push	#0x01
	ld	a, #0x05
	ldw	x, #0x500a
	call	_writePin
;	main.c: 23: writePin(PC, 5, LOW);	// clk в low
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x500a
	call	_writePin
	jra	00103$
00102$:
;	main.c: 27: writePin(PC, 6, LOW);	// data в low
	push	#0x00
	ld	a, #0x06
	ldw	x, #0x500a
	call	_writePin
;	main.c: 28: writePin(PC, 5, HIGH);	// clk в high
	push	#0x01
	ld	a, #0x05
	ldw	x, #0x500a
	call	_writePin
;	main.c: 29: writePin(PC, 5, LOW);	// clk в low
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x500a
	call	_writePin
00103$:
;	main.c: 31: data = data >> 1;
	srl	(0x01, sp)
;	main.c: 17: for (uint8_t a; a < 8; a++)
	inc	(0x02, sp)
	jra	00106$
00104$:
;	main.c: 34: writePin(PD, 2, HIGH);	// latc в high
	push	#0x01
	ld	a, #0x02
	ldw	x, #0x500f
	call	_writePin
;	main.c: 35: writePin(PD, 2, LOW);	// latc в low
	push	#0x00
	ld	a, #0x02
	ldw	x, #0x500f
	call	_writePin
;	main.c: 36: }
	addw	sp, #2
	ret
;	main.c: 38: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	push	a
;	main.c: 40: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 42: init_TIME();
	call	_init_TIME
;	main.c: 44: uint8_t i = 0;
	clr	(0x01, sp)
;	main.c: 46: pinMode(PC, 5, OUTPUT); // CLK
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x500a
	call	_pinMode
;	main.c: 47: pinMode(PC, 6, OUTPUT);	// data
	push	#0x00
	ld	a, #0x06
	ldw	x, #0x500a
	call	_pinMode
;	main.c: 48: pinMode(PD, 2, OUTPUT);	// latc
	push	#0x00
	ld	a, #0x02
	ldw	x, #0x500f
	call	_pinMode
;	main.c: 50: while (1)
00103$:
;	main.c: 52: BB_transmite(0);
	clr	a
	call	_BB_transmite
;	main.c: 53: for (i; i < 255; i++) {
	ld	a, (0x01, sp)
00106$:
	cp	a, #0xff
	jrnc	00101$
;	main.c: 54: BB_transmite(i);
	push	a
	call	_BB_transmite
	push	#0x32
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	pop	a
;	main.c: 53: for (i; i < 255; i++) {
	inc	a
	jra	00106$
00101$:
;	main.c: 57: i = 0;
	clr	(0x01, sp)
	jra	00103$
;	main.c: 59: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
