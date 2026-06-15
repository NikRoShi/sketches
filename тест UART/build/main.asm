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
	.globl _sendHex_UART
	.globl _sendLine_UART
	.globl _init_UART
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
;	main.c: 5: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 7: CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 9: init_UART(9600);	// 2. Инициализируем периферию
	push	#0x80
	push	#0x25
	clrw	x
	pushw	x
	call	_init_UART
;	main.c: 11: for (uint8_t i = 1; i < 128; i++)
	ld	a, #0x01
00106$:
	cp	a, #0x80
	jrnc	00103$
;	main.c: 13: sendHex_UART(i);
	push	a
	call	_sendHex_UART
	call	_sendLine_UART
	pop	a
;	main.c: 11: for (uint8_t i = 1; i < 128; i++)
	inc	a
	jra	00106$
;	main.c: 17: while(1)
00103$:
	jra	00103$
;	main.c: 21: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
