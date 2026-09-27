;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_interrupt
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _EXTI_FlagD
	.globl _EXTI_FlagC
	.globl _EXTI_FlagB
	.globl _EXTI_FlagA
	.globl _set_EXTI
	.globl _set_EXTI_pin
	.globl _clear_EXTI_pin
	.globl _setInterruptPriority
	.globl _handlerPortA
	.globl _handlerPortB
	.globl _handlerPortC
	.globl _handlerPortD
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_modeA:
	.ds 1
_EXTIPinMaskA:
	.ds 1
_EXTI_FlagA::
	.ds 1
_modeB:
	.ds 1
_EXTIPinMaskB:
	.ds 1
_EXTI_FlagB::
	.ds 1
_modeC:
	.ds 1
_EXTIPinMaskC:
	.ds 1
_EXTI_FlagC::
	.ds 1
_modeD:
	.ds 1
_EXTIPinMaskD:
	.ds 1
_EXTI_FlagD::
	.ds 1
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
;	../../my_STM8_libraries/stm8_interrupt.c: 19: void set_EXTI(uint8_t port, uint8_t mode)
;	-----------------------------------------
;	 function set_EXTI
;	-----------------------------------------
_set_EXTI:
	push	a
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 21: EXTI_CR1 &= ~(0b11 << port);
	ld	a, 0x50a0
	ld	(0x01, sp), a
	ld	a, xh
	exg	a, xl
	ld	a, #0x03
	exg	a, xl
	tnz	a
	jreq	00132$
00131$:
	exg	a, xl
	sll	a
	exg	a, xl
	dec	a
	jrne	00131$
00132$:
	ld	a, xl
	cpl	a
	and	a, (0x01, sp)
	ld	0x50a0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 22: EXTI_CR1 |= mode << port;
	ld	a, 0x50a0
	push	a
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	ld	a, xh
	tnz	a
	jreq	00134$
00133$:
	sll	(0x02, sp)
	dec	a
	jrne	00133$
00134$:
	pop	a
	or	a, (0x01, sp)
	ld	0x50a0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 23: if (port == EXTI_PORTA) modeA = mode;
	ld	a, (0x04, sp)
	ld	xl, a
	ld	a, xh
	tnz	a
	jrne	00102$
	ld	a, xl
	ld	_modeA+0, a
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 24: if (port == EXTI_PORTB) modeB = mode;
	ld	a, xh
	cp	a, #0x02
	jrne	00104$
	ld	a, xl
	ld	_modeB+0, a
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 25: if (port == EXTI_PORTC) modeC = mode;
	ld	a, xh
	cp	a, #0x04
	jrne	00106$
	ld	a, xl
	ld	_modeC+0, a
00106$:
;	../../my_STM8_libraries/stm8_interrupt.c: 26: if (port == EXTI_PORTD) modeD = mode;
	ld	a, xh
	cp	a, #0x06
	jrne	00109$
	ld	a, xl
	ld	_modeD+0, a
00109$:
;	../../my_STM8_libraries/stm8_interrupt.c: 27: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 28: void set_EXTI_pin(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function set_EXTI_pin
;	-----------------------------------------
_set_EXTI_pin:
	sub	sp, #2
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 33: EXTIPinMaskA |= (1 << pin);
	ld	a, (0x05, sp)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	pop	a
	tnz	a
	jreq	00129$
00128$:
	sll	(0x01, sp)
	dec	a
	jrne	00128$
00129$:
;	../../my_STM8_libraries/stm8_interrupt.c: 34: PA_DDR &= ~(1 << pin);
	ld	a, (0x01, sp)
	cpl	a
	ld	(0x02, sp), a
;	../../my_STM8_libraries/stm8_interrupt.c: 30: switch (port)
	ld	a, xl
	cp	a, #0x00
	jreq	00101$
	ld	a, xl
	cp	a, #0x02
	jreq	00102$
	ld	a, xl
	cp	a, #0x04
	jreq	00103$
	ld	a, xl
	cp	a, #0x06
	jreq	00104$
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 32: case EXTI_PORTA:
00101$:
;	../../my_STM8_libraries/stm8_interrupt.c: 33: EXTIPinMaskA |= (1 << pin);
	ld	a, (0x01, sp)
	or	a, _EXTIPinMaskA+0
	ld	_EXTIPinMaskA+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 34: PA_DDR &= ~(1 << pin);
	ld	a, 0x5002
	and	a, (0x02, sp)
	ld	0x5002, a
;	../../my_STM8_libraries/stm8_interrupt.c: 35: PA_CR2 |= (1 << pin);
	ld	a, 0x5004
	or	a, (0x01, sp)
	ld	0x5004, a
;	../../my_STM8_libraries/stm8_interrupt.c: 36: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 37: case EXTI_PORTB:
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 38: EXTIPinMaskB |= (1 << pin);
	ld	a, (0x01, sp)
	or	a, _EXTIPinMaskB+0
	ld	_EXTIPinMaskB+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 39: PB_DDR &= ~(1 << pin);
	ld	a, 0x5007
	and	a, (0x02, sp)
	ld	0x5007, a
;	../../my_STM8_libraries/stm8_interrupt.c: 40: PB_CR2 |= (1 << pin);
	ld	a, 0x5009
	or	a, (0x01, sp)
	ld	0x5009, a
;	../../my_STM8_libraries/stm8_interrupt.c: 41: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 42: case EXTI_PORTC:
00103$:
;	../../my_STM8_libraries/stm8_interrupt.c: 43: EXTIPinMaskC |= (1 << pin);
	ld	a, (0x01, sp)
	or	a, _EXTIPinMaskC+0
	ld	_EXTIPinMaskC+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 44: PC_DDR &= ~(1 << pin);
	ld	a, 0x500c
	and	a, (0x02, sp)
	ld	0x500c, a
;	../../my_STM8_libraries/stm8_interrupt.c: 45: PC_CR2 |= (1 << pin);
	ld	a, 0x500e
	or	a, (0x01, sp)
	ld	0x500e, a
;	../../my_STM8_libraries/stm8_interrupt.c: 46: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 47: case EXTI_PORTD:
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 48: EXTIPinMaskD |= (1 << pin);
	ld	a, (0x01, sp)
	or	a, _EXTIPinMaskD+0
	ld	_EXTIPinMaskD+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 49: PD_DDR &= ~(1 << pin);
	ld	a, 0x5011
	and	a, (0x02, sp)
	ld	0x5011, a
;	../../my_STM8_libraries/stm8_interrupt.c: 50: PD_CR2 |= (1 << pin);
	ld	a, 0x5013
	or	a, (0x01, sp)
	ld	0x5013, a
;	../../my_STM8_libraries/stm8_interrupt.c: 52: }
00106$:
;	../../my_STM8_libraries/stm8_interrupt.c: 53: }
	addw	sp, #2
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 54: void clear_EXTI_pin(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function clear_EXTI_pin
;	-----------------------------------------
_clear_EXTI_pin:
	push	a
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
	ld	a, (0x04, sp)
	ld	xh, a
	ld	a, #0x01
	push	a
	ld	a, xh
	tnz	a
	jreq	00129$
00128$:
	sll	(1, sp)
	dec	a
	jrne	00128$
00129$:
	pop	a
	cpl	a
	ld	(0x01, sp), a
;	../../my_STM8_libraries/stm8_interrupt.c: 56: switch (port)
	ld	a, xl
	cp	a, #0x00
	jreq	00101$
	ld	a, xl
	cp	a, #0x02
	jreq	00102$
	ld	a, xl
	cp	a, #0x04
	jreq	00103$
	ld	a, xl
	cp	a, #0x06
	jreq	00104$
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 58: case EXTI_PORTA:
00101$:
;	../../my_STM8_libraries/stm8_interrupt.c: 59: EXTIPinMaskA &= ~(1 << pin);
	ld	a, (0x01, sp)
	and	a, _EXTIPinMaskA+0
	ld	_EXTIPinMaskA+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 60: PA_DDR &= ~(1 << pin);
	ld	a, 0x5002
	and	a, (0x01, sp)
	ld	0x5002, a
;	../../my_STM8_libraries/stm8_interrupt.c: 61: PA_CR2 &= ~(1 << pin);
	ld	a, 0x5004
	and	a, (0x01, sp)
	ld	0x5004, a
;	../../my_STM8_libraries/stm8_interrupt.c: 62: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 63: case EXTI_PORTB:
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 64: EXTIPinMaskB &= ~(1 << pin);
	ld	a, (0x01, sp)
	and	a, _EXTIPinMaskB+0
	ld	_EXTIPinMaskB+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 65: PB_DDR &= ~(1 << pin);
	ld	a, 0x5007
	and	a, (0x01, sp)
	ld	0x5007, a
;	../../my_STM8_libraries/stm8_interrupt.c: 66: PB_CR2 &= ~(1 << pin);
	ld	a, 0x5009
	and	a, (0x01, sp)
	ld	0x5009, a
;	../../my_STM8_libraries/stm8_interrupt.c: 67: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 68: case EXTI_PORTC:
00103$:
;	../../my_STM8_libraries/stm8_interrupt.c: 69: EXTIPinMaskC &= ~(1 << pin);
	ld	a, (0x01, sp)
	and	a, _EXTIPinMaskC+0
	ld	_EXTIPinMaskC+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 70: PC_DDR &= ~(1 << pin);
	ld	a, 0x500c
	and	a, (0x01, sp)
	ld	0x500c, a
;	../../my_STM8_libraries/stm8_interrupt.c: 71: PC_CR2 &= ~(1 << pin);
	ld	a, 0x500e
	and	a, (0x01, sp)
	ld	0x500e, a
;	../../my_STM8_libraries/stm8_interrupt.c: 72: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 73: case EXTI_PORTD:
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 74: EXTIPinMaskD &= ~(1 << pin);
	ld	a, (0x01, sp)
	and	a, _EXTIPinMaskD+0
	ld	_EXTIPinMaskD+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 75: PD_DDR &= ~(1 << pin);
	ld	a, 0x5011
	and	a, (0x01, sp)
	ld	0x5011, a
;	../../my_STM8_libraries/stm8_interrupt.c: 76: PD_CR2 &= ~(1 << pin);
	ld	a, 0x5013
	and	a, (0x01, sp)
	ld	0x5013, a
;	../../my_STM8_libraries/stm8_interrupt.c: 78: }
00106$:
;	../../my_STM8_libraries/stm8_interrupt.c: 79: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 80: void setInterruptPriority(uint8_t interrupt, uint8_t priorityLevel)
;	-----------------------------------------
;	 function setInterruptPriority
;	-----------------------------------------
_setInterruptPriority:
	sub	sp, #2
;	../../my_STM8_libraries/stm8_interrupt.c: 82: volatile uint8_t *priorityReg = &ITC_SPR1 + (interrupt >> 2);
	ld	yl, a
	srl	a
	srl	a
	clrw	x
	ld	xl, a
	addw	x, #0x7f70
;	../../my_STM8_libraries/stm8_interrupt.c: 83: *priorityReg &= ~(3 << ((interrupt & 3) << 1));
	ld	a, (x)
	ld	(0x02, sp), a
	ld	a, yl
	and	a, #0x03
	sll	a
	ld	(0x01, sp), a
	ld	a, #0x03
	push	a
	ld	a, (0x02, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x02, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_interrupt.c: 84: *priorityReg |= (priorityLevel << ((interrupt & 3) << 1));
	ld	a, (x)
	ld	(0x02, sp), a
	ld	a, (0x05, sp)
	push	a
	ld	a, (0x02, sp)
	jreq	00106$
00105$:
	sll	(1, sp)
	dec	a
	jrne	00105$
00106$:
	pop	a
	or	a, (0x02, sp)
	ld	(x), a
;	../../my_STM8_libraries/stm8_interrupt.c: 85: }
	addw	sp, #2
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 86: void handlerPortA(void)
;	-----------------------------------------
;	 function handlerPortA
;	-----------------------------------------
_handlerPortA:
;	../../my_STM8_libraries/stm8_interrupt.c: 88: uint8_t current = PA_IDR;
	ld	a, 0x5001
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 89: uint8_t event = 0;
	clr	a
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 90: if (modeA == FALLING)
	ld	a, _modeA+0
	cp	a, #0x02
	jrne	00102$
;	../../my_STM8_libraries/stm8_interrupt.c: 92: event = (~current) & EXTIPinMaskA;
	ld	a, xh
	cpl	a
	and	a, _EXTIPinMaskA+0
	ld	xl, a
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 94: if (modeA == RISING)
	ld	a, _modeA+0
	dec	a
	jrne	00104$
;	../../my_STM8_libraries/stm8_interrupt.c: 96: event = current & EXTIPinMaskA;
	ld	a, xh
	and	a, _EXTIPinMaskA+0
	ld	xl, a
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 98: EXTI_FlagA |= event;
	ld	a, xl
	or	a, _EXTI_FlagA+0
	ld	_EXTI_FlagA+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 99: }
	ret
;	../../my_STM8_libraries/stm8_interrupt.c: 100: void handlerPortB(void)
;	-----------------------------------------
;	 function handlerPortB
;	-----------------------------------------
_handlerPortB:
;	../../my_STM8_libraries/stm8_interrupt.c: 102: uint8_t current = PB_IDR;
	ld	a, 0x5006
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 103: uint8_t event = 0;
	clr	a
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 104: if (modeB == FALLING)
	ld	a, _modeB+0
	cp	a, #0x02
	jrne	00102$
;	../../my_STM8_libraries/stm8_interrupt.c: 106: event = (~current) & EXTIPinMaskB;
	ld	a, xh
	cpl	a
	and	a, _EXTIPinMaskB+0
	ld	xl, a
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 108: if (modeB == RISING)
	ld	a, _modeB+0
	dec	a
	jrne	00104$
;	../../my_STM8_libraries/stm8_interrupt.c: 110: event = current & EXTIPinMaskB;
	ld	a, xh
	and	a, _EXTIPinMaskB+0
	ld	xl, a
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 112: EXTI_FlagB |= event;
	ld	a, xl
	or	a, _EXTI_FlagB+0
	ld	_EXTI_FlagB+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 113: }
	ret
;	../../my_STM8_libraries/stm8_interrupt.c: 114: void handlerPortC(void)
;	-----------------------------------------
;	 function handlerPortC
;	-----------------------------------------
_handlerPortC:
;	../../my_STM8_libraries/stm8_interrupt.c: 116: uint8_t current = PC_IDR;
	ld	a, 0x500b
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 117: uint8_t event = 0;
	clr	a
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 118: if (modeC == FALLING)
	ld	a, _modeC+0
	cp	a, #0x02
	jrne	00102$
;	../../my_STM8_libraries/stm8_interrupt.c: 120: event = (~current) & EXTIPinMaskC;
	ld	a, xh
	cpl	a
	and	a, _EXTIPinMaskC+0
	ld	xl, a
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 122: if (modeC == RISING)
	ld	a, _modeC+0
	dec	a
	jrne	00104$
;	../../my_STM8_libraries/stm8_interrupt.c: 124: event = current & EXTIPinMaskC;
	ld	a, xh
	and	a, _EXTIPinMaskC+0
	ld	xl, a
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 126: EXTI_FlagC |= event;
	ld	a, xl
	or	a, _EXTI_FlagC+0
	ld	_EXTI_FlagC+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 127: }
	ret
;	../../my_STM8_libraries/stm8_interrupt.c: 128: void handlerPortD(void)
;	-----------------------------------------
;	 function handlerPortD
;	-----------------------------------------
_handlerPortD:
;	../../my_STM8_libraries/stm8_interrupt.c: 130: uint8_t current = PD_IDR;
	ld	a, 0x5010
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 131: uint8_t event = 0;
	clr	a
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 132: if (modeD == FALLING)
	ld	a, _modeD+0
	cp	a, #0x02
	jrne	00102$
;	../../my_STM8_libraries/stm8_interrupt.c: 134: event = (~current) & EXTIPinMaskD;
	ld	a, xh
	cpl	a
	and	a, _EXTIPinMaskD+0
	ld	xl, a
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 136: if (modeD == RISING)
	ld	a, _modeD+0
	dec	a
	jrne	00104$
;	../../my_STM8_libraries/stm8_interrupt.c: 138: event = current & EXTIPinMaskD;
	ld	a, xh
	and	a, _EXTIPinMaskD+0
	ld	xl, a
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 140: EXTI_FlagD |= event;
	ld	a, xl
	or	a, _EXTI_FlagD+0
	ld	_EXTI_FlagD+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 141: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__modeA:
	.db #0x00	; 0
__xinit__EXTIPinMaskA:
	.db #0x00	; 0
__xinit__EXTI_FlagA:
	.db #0x00	; 0
__xinit__modeB:
	.db #0x00	; 0
__xinit__EXTIPinMaskB:
	.db #0x00	; 0
__xinit__EXTI_FlagB:
	.db #0x00	; 0
__xinit__modeC:
	.db #0x00	; 0
__xinit__EXTIPinMaskC:
	.db #0x00	; 0
__xinit__EXTI_FlagC:
	.db #0x00	; 0
__xinit__modeD:
	.db #0x00	; 0
__xinit__EXTIPinMaskD:
	.db #0x00	; 0
__xinit__EXTI_FlagD:
	.db #0x00	; 0
	.area CABS (ABS)
