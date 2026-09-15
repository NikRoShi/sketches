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
	.globl _UART1_RX_IRQHandler
	.globl _writePin
	.globl _pinMode
	.globl _getData_UART
	.globl _init_UART
	.globl _key
	.globl _ledFlag
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_ledFlag::
	.ds 1
_key::
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
	int _UART1_RX_IRQHandler ; int18
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
;	main.c: 9: void UART1_RX_IRQHandler(void) __interrupt(18) {
;	-----------------------------------------
;	 function UART1_RX_IRQHandler
;	-----------------------------------------
_UART1_RX_IRQHandler:
	clr	a
	div	x, a
;	main.c: 11: key = getData_UART();
	call	_getData_UART
;	main.c: 13: if (key == 's' || key == 'S') ledFlag = 1;
	ld	_key+0, a
	cp	a, #0x73
	jreq	00101$
	ld	a, _key+0
	cp	a, #0x53
	jrne	00102$
00101$:
	mov	_ledFlag+0, #0x01
00102$:
;	main.c: 14: if (key == 'r' || key == 'R') ledFlag = 0;
	ld	a, _key+0
	cp	a, #0x72
	jreq	00104$
	ld	a, _key+0
	cp	a, #0x52
	jrne	00107$
00104$:
	clr	_ledFlag+0
00107$:
;	main.c: 15: }
	iret
;	main.c: 17: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 19: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 21: pinMode(PB, 5, OUTPUT);
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x5005
	call	_pinMode
;	main.c: 23: init_UART(9600, ENABLE);
	ld	a, #0x01
	ldw	x, #0x2580
	call	_init_UART
;	main.c: 24: enableInterrupts();
	rim
;	main.c: 26: while (1)
00105$:
;	main.c: 28: if (ledFlag) writePin(PB, 5, HIGH);
	ld	a, _ledFlag+0
	jreq	00102$
	push	#0x01
	ld	a, #0x05
	ldw	x, #0x5005
	call	_writePin
	jra	00105$
00102$:
;	main.c: 29: else writePin(PB, 5, LOW);
	push	#0x00
	ld	a, #0x05
	ldw	x, #0x5005
	call	_writePin
	jra	00105$
;	main.c: 31: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__ledFlag:
	.db #0x00	; 0
__xinit__key:
	.db #0x72	; 114	'r'
	.area CABS (ABS)
