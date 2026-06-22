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
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _init_TIME
	.globl _tick_TIME
	.globl _readBuffer2_I2C
	.globl _init_I2C
	.globl _printHex_UART
	.globl _line_UART
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
;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 8: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 9: tick_TIME();
	call	_tick_TIME
;	main.c: 10: }
	iret
;	main.c: 12: uint8_t BCDtoDEC(uint8_t bcd) 
;	-----------------------------------------
;	 function BCDtoDEC
;	-----------------------------------------
_BCDtoDEC:
;	main.c: 14: return (((bcd >> 4) * 10) + (bcd & 0x0F));
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
;	main.c: 15: }
	ret
;	main.c: 17: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #2
;	main.c: 21: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 23: init_I2C();
	call	_init_I2C
;	main.c: 24: init_TIME();
	call	_init_TIME
;	main.c: 25: init_UART(9600);
	ldw	x, #0x2580
	call	_init_UART
;	main.c: 27: while (1)
00105$:
;	main.c: 29: if (readBuffer2_I2C(0x68, 0x00, buf) == 0)
	ldw	x, sp
	incw	x
	pushw	x
	push	#0x00
	ld	a, #0x68
	call	_readBuffer2_I2C
	tnz	a
	jrne	00102$
;	main.c: 31: print_UART("fail");
	ldw	x, #(___str_0+0)
	call	_print_UART
;	main.c: 32: line_UART();
	call	_line_UART
	jra	00105$
00102$:
;	main.c: 36: print_UART("second is 0x");
	ldw	x, #(___str_1+0)
	call	_print_UART
;	main.c: 37: printHex_UART(buf[0]);
	ld	a, (0x01, sp)
	call	_printHex_UART
;	main.c: 38: line_UART();
	call	_line_UART
;	main.c: 39: print_UART("minutes is 0x");
	ldw	x, #(___str_2+0)
	call	_print_UART
;	main.c: 40: printHex_UART(buf[1]);
	ld	a, (0x02, sp)
	call	_printHex_UART
;	main.c: 41: line_UART();
	call	_line_UART
;	main.c: 42: line_UART();
	call	_line_UART
	jra	00105$
;	main.c: 45: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "fail"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "second is 0x"
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.ascii "minutes is 0x"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
