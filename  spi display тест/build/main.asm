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
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _delay
	.globl _init_TIME
	.globl _tick_TIME
	.globl _write_SPI
	.globl _init_SPI
	.globl _writePin
	.globl _pinMode
	.globl _b
	.globl _a
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_a::
	.ds 1
_b::
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
;	main.c: 30: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	clr	a
	div	x, a
;	main.c: 31: TIM4_SR &= ~(1 << 0);
	bres	0x5344, #0
;	main.c: 32: tick_TIME();
	call	_tick_TIME
;	main.c: 33: }
	iret
;	main.c: 35: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 37: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
	mov	0x50c6+0, #0x00
;	main.c: 39: init_TIME();
	call	_init_TIME
;	main.c: 40: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
	push	#0x04
	push	#0x00
	push	#0x18
	clr	a
	call	_init_SPI
;	main.c: 41: pinMode(PD, 3, OUTPUT);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_pinMode
;	main.c: 52: while (a < 8)
00134$:
	ld	a, _a+0
	cp	a, #0x08
	jrc	00237$
	jp	00136$
00237$:
;	main.c: 54: switch (a)
	ld	a, _a+0
	cp	a, #0x07
	jrule	00238$
	jp	00133$
00238$:
	clrw	x
	ld	a, _a+0
	ld	xl, a
	sllw	x
	ldw	x, (#00239$, x)
	jp	(x)
00239$:
	.dw	#00101$
	.dw	#00105$
	.dw	#00109$
	.dw	#00113$
	.dw	#00117$
	.dw	#00121$
	.dw	#00125$
	.dw	#00129$
;	main.c: 56: case 0:
00101$:
;	main.c: 57: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 58: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 59: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 60: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 61: while (b < 8)
00102$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00104$
;	main.c: 63: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00242$
00241$:
	sll	(1, sp)
	dec	a
	jrne	00241$
00242$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 64: write_SPI(DIGIT_ONE);
	ld	a, #0x08
	call	_write_SPI
;	main.c: 65: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 66: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 67: b++;
	inc	_b+0
;	main.c: 68: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00102$
00104$:
;	main.c: 70: b = 0;
	clr	_b+0
;	main.c: 71: break;
	jp	00133$
;	main.c: 72: case 1:
00105$:
;	main.c: 73: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 74: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 75: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 76: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 77: while (b < 8)
00106$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00108$
;	main.c: 79: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00245$
00244$:
	sll	(1, sp)
	dec	a
	jrne	00244$
00245$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 80: write_SPI(DIGIT_TWO);
	ld	a, #0x04
	call	_write_SPI
;	main.c: 81: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 82: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 83: b++;
	inc	_b+0
;	main.c: 84: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00106$
00108$:
;	main.c: 86: b = 0;
	clr	_b+0
;	main.c: 87: break;
	jp	00133$
;	main.c: 88: case 2:
00109$:
;	main.c: 89: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 90: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 91: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 92: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 93: while (b < 8)
00110$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00112$
;	main.c: 95: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00248$
00247$:
	sll	(1, sp)
	dec	a
	jrne	00247$
00248$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 96: write_SPI(DIGIT_THREE);
	ld	a, #0x02
	call	_write_SPI
;	main.c: 97: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 98: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 99: b++;
	inc	_b+0
;	main.c: 100: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00110$
00112$:
;	main.c: 102: b = 0;
	clr	_b+0
;	main.c: 103: break;
	jp	00133$
;	main.c: 104: case 3:
00113$:
;	main.c: 105: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 106: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 107: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 108: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 109: while (b < 8)
00114$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00116$
;	main.c: 111: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00251$
00250$:
	sll	(1, sp)
	dec	a
	jrne	00250$
00251$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 112: write_SPI(DIGIT_FOUR);
	ld	a, #0x01
	call	_write_SPI
;	main.c: 113: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 114: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 115: b++;
	inc	_b+0
;	main.c: 116: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00114$
00116$:
;	main.c: 118: b = 0;
	clr	_b+0
;	main.c: 119: break;
	jp	00133$
;	main.c: 120: case 4:
00117$:
;	main.c: 121: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 122: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 123: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 124: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 125: while (b < 8)
00118$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00120$
;	main.c: 127: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00254$
00253$:
	sll	(1, sp)
	dec	a
	jrne	00253$
00254$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 128: write_SPI(DIGIT_FIVE);
	ld	a, #0x80
	call	_write_SPI
;	main.c: 129: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 130: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 131: b++;
	inc	_b+0
;	main.c: 132: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00118$
00120$:
;	main.c: 134: b = 0;
	clr	_b+0
;	main.c: 135: break;
	jp	00133$
;	main.c: 136: case 5:
00121$:
;	main.c: 137: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 138: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 139: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 140: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 141: while (b < 8)
00122$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00124$
;	main.c: 143: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00257$
00256$:
	sll	(1, sp)
	dec	a
	jrne	00256$
00257$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 144: write_SPI(DIGIT_SIX);
	ld	a, #0x40
	call	_write_SPI
;	main.c: 145: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 146: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 147: b++;
	inc	_b+0
;	main.c: 148: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00122$
00124$:
;	main.c: 150: b = 0;
	clr	_b+0
;	main.c: 151: break;
	jp	00133$
;	main.c: 152: case 6:
00125$:
;	main.c: 153: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 154: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 155: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 156: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 157: while (b < 8)
00126$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00128$
;	main.c: 159: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00260$
00259$:
	sll	(1, sp)
	dec	a
	jrne	00259$
00260$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 160: write_SPI(DIGIT_SEVEN);
	ld	a, #0x20
	call	_write_SPI
;	main.c: 161: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 162: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 163: b++;
	inc	_b+0
;	main.c: 164: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00126$
00128$:
;	main.c: 166: b = 0;
	clr	_b+0
;	main.c: 167: break;
	jra	00133$
;	main.c: 168: case 7:
00129$:
;	main.c: 169: write_SPI(0xFF);	//сбросили в ноль все микросхемы
	ld	a, #0xff
	call	_write_SPI
;	main.c: 170: write_SPI(0x00);
	clr	a
	call	_write_SPI
;	main.c: 171: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 172: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 173: while (b < 8)
00130$:
	ld	a, _b+0
	cp	a, #0x08
	jrnc	00132$
;	main.c: 175: write_SPI(~(1 << b));
	ld	a, _b+0
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00263$
00262$:
	sll	(1, sp)
	dec	a
	jrne	00262$
00263$:
	pop	a
	cpl	a
	call	_write_SPI
;	main.c: 176: write_SPI(DIGIT_EIGHT);
	ld	a, #0x10
	call	_write_SPI
;	main.c: 177: writePin(PD, 3, HIGH);
	push	#0x01
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 178: writePin(PD, 3, LOW);
	push	#0x00
	ld	a, #0x03
	ldw	x, #0x500f
	call	_writePin
;	main.c: 179: b++;
	inc	_b+0
;	main.c: 180: delay(DELAY_TIME);
	push	#0xc8
	clrw	x
	pushw	x
	push	#0x00
	call	_delay
	jra	00130$
00132$:
;	main.c: 182: b = 0;
	clr	_b+0
;	main.c: 184: }
00133$:
;	main.c: 185: a++;
	inc	_a+0
	jp	00134$
00136$:
;	main.c: 187: a = 0;
	clr	_a+0
;	main.c: 189: }
	jp	00134$
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__a:
	.db #0x00	; 0
__xinit__b:
	.db #0x00	; 0
	.area CABS (ABS)
