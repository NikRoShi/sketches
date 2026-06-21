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
	.globl _BCDtoDEC
	.globl _readReg_I2C
	.globl _init_I2C
	.globl _line_UART
	.globl _printInt_UART
	.globl _print_UART
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
;	main.c: 6: uint8_t BCDtoDEC(uint8_t bcd) 
;	-----------------------------------------
;	 function BCDtoDEC
;	-----------------------------------------
_BCDtoDEC:
;	main.c: 8: return (((bcd >> 4) * 10) + (bcd & 0x0F));
	ld	xl, a
	swap	a
	and	a, #0x0f
	exg	a, xl
	push	a
	ld	a, #0x0a
	mul	x, a
	pop	a
	and	a, #0x0f
	pushw	x
	add	a, (2, sp)
	popw	x
;	main.c: 9: }
	ret
;	main.c: 11: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	push	a
;	main.c: 13: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 15: init_I2C();
	call	_init_I2C
;	main.c: 16: init_UART(9600);
	ldw	x, #0x2580
	call	_init_UART
;	main.c: 18: print_UART("start reading");
	ldw	x, #(___str_0+0)
	call	_print_UART
;	main.c: 19: line_UART();
	call	_line_UART
;	main.c: 23: while (1)
00104$:
;	main.c: 25: if (readReg_I2C(0x68, 0x00, &data) == 0)
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x00
	ld	a, #0x68
	call	_readReg_I2C
	tnz	a
	jrne	00102$
;	main.c: 27: print_UART("fail");
	ldw	x, #(___str_1+0)
	call	_print_UART
;	main.c: 28: line_UART();
	call	_line_UART
00102$:
;	main.c: 30: print_UART("second is ");
	ldw	x, #(___str_2+0)
	call	_print_UART
;	main.c: 31: printInt_UART(BCDtoDEC(data));
	ld	a, (0x01, sp)
	call	_BCDtoDEC
	clrw	x
	ld	xl, a
	call	_printInt_UART
;	main.c: 32: line_UART();
	call	_line_UART
	jra	00104$
;	main.c: 34: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "start reading"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "fail"
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "second is "
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
