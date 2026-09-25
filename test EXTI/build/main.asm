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
	.globl _EXTI_A_IRQHandler
	.globl _set_EXTI_pin
	.globl _set_EXTI
	.globl _line_UART
	.globl _printInt_UART
	.globl _init_UART
	.globl _counter
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_counter::
	.ds 1
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
	int _EXTI_A_IRQHandler ; int3
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
;	main.c: 8: void EXTI_A_IRQHandler(void) __interrupt(IRQ_EXTI0)
;	-----------------------------------------
;	 function EXTI_A_IRQHandler
;	-----------------------------------------
_EXTI_A_IRQHandler:
;	main.c: 13: currentStateA = PA_IDR;
	ld	a, 0x5001
;	main.c: 14: changedA = previousStateA ^ currentStateA;
	ld	xl, a
	xor	a, _previousStateA+0
;	main.c: 15: changedA &= EXTIPinMaskA;
	and	a, _EXTIPinMaskA+0
;	main.c: 16: EXTI_FlagA |= changedA;
	or	a, _EXTI_FlagA+0
	ld	_EXTI_FlagA+0, a
;	main.c: 17: previousStateA = currentStateA;
	ld	a, xl
	ld	_previousStateA+0, a
;	main.c: 18: }
	iret
;	main.c: 20: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 22: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 24: init_UART(9600, DISABLE);
	clr	a
	ldw	x, #0x2580
	call	_init_UART
;	main.c: 26: set_EXTI(EXTI_PORTA, FALLING);
	push	#0x02
	clr	a
	call	_set_EXTI
;	main.c: 27: set_EXTI_pin(EXTI_PORTA, 1);
	push	#0x01
	clr	a
	call	_set_EXTI_pin
;	main.c: 29: enableInterrupts();	
	rim
;	main.c: 30: while (1)
00104$:
;	main.c: 32: if (EXTI_FlagA & (1 << 1))
	btjf	_EXTI_FlagA+0, #1, 00104$
;	main.c: 34: EXTI_FlagA &= ~(1 << 1);
	bres	_EXTI_FlagA+0, #1
;	main.c: 35: counter++;
	inc	_counter+0
;	main.c: 36: printInt_UART(counter);
	ld	a, _counter+0
	clrw	x
	ld	xl, a
	call	_printInt_UART
;	main.c: 37: line_UART();
	call	_line_UART
	jra	00104$
;	main.c: 40: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__counter:
	.db #0x00	; 0
	.area CABS (ABS)
