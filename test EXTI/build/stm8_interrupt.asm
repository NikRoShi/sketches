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
	.globl _EXTIPinMaskD
	.globl _previousStateD
	.globl _EXTI_FlagC
	.globl _EXTIPinMaskC
	.globl _previousStateC
	.globl _EXTI_FlagB
	.globl _EXTIPinMaskB
	.globl _previousStateB
	.globl _EXTI_FlagA
	.globl _EXTIPinMaskA
	.globl _previousStateA
	.globl _set_EXTI
	.globl _set_EXTI_pin
	.globl _clear_EXTI_pin
	.globl _setInterruptPriority
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_previousStateA::
	.ds 1
_EXTIPinMaskA::
	.ds 1
_EXTI_FlagA::
	.ds 1
_previousStateB::
	.ds 1
_EXTIPinMaskB::
	.ds 1
_EXTI_FlagB::
	.ds 1
_previousStateC::
	.ds 1
_EXTIPinMaskC::
	.ds 1
_EXTI_FlagC::
	.ds 1
_previousStateD::
	.ds 1
_EXTIPinMaskD::
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
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 21: EXTI_CR1 &= ~(0b11 << port);
	ld	a, 0x50a0
	ld	(0x01, sp), a
	ld	a, xl
	rlwa	x
	ld	a, #0x03
	rrwa	x
	tnz	a
	jreq	00104$
00103$:
	rlwa	x
	sll	a
	rrwa	x
	dec	a
	jrne	00103$
00104$:
	ld	a, xh
	cpl	a
	and	a, (0x01, sp)
	ld	0x50a0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 22: EXTI_CR1 |= mode << port;
	ld	a, 0x50a0
	push	a
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00106$
00105$:
	sll	(0x02, sp)
	dec	a
	jrne	00105$
00106$:
	pop	a
	or	a, (0x01, sp)
	ld	0x50a0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 23: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 24: void set_EXTI_pin(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function set_EXTI_pin
;	-----------------------------------------
_set_EXTI_pin:
;	../../my_STM8_libraries/stm8_interrupt.c: 26: switch (port)
	cp	a, #0x00
	jreq	00101$
	cp	a, #0x02
	jreq	00104$
	cp	a, #0x04
	jreq	00107$
	cp	a, #0x06
	jreq	00110$
	jp	00114$
;	../../my_STM8_libraries/stm8_interrupt.c: 28: case EXTI_PORTA:
00101$:
;	../../my_STM8_libraries/stm8_interrupt.c: 29: if (EXTIPinMaskA == 0) previousStateA = PA_IDR;
	ld	a, _EXTIPinMaskA+0
	jrne	00103$
	mov	_previousStateA+0, 0x5001
00103$:
;	../../my_STM8_libraries/stm8_interrupt.c: 30: EXTIPinMaskA |= (1 << pin);
	ld	a, (0x03, sp)
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00170$
00169$:
	sll	(1, sp)
	dec	a
	jrne	00169$
00170$:
	pop	a
	or	a, _EXTIPinMaskA+0
	ld	_EXTIPinMaskA+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 31: break;
	jra	00114$
;	../../my_STM8_libraries/stm8_interrupt.c: 32: case EXTI_PORTB:
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 33: if (EXTIPinMaskB == 0) previousStateB = PB_IDR;
	ld	a, _EXTIPinMaskB+0
	jrne	00106$
	mov	_previousStateB+0, 0x5006
00106$:
;	../../my_STM8_libraries/stm8_interrupt.c: 34: EXTIPinMaskB |= (1 << pin);
	ld	a, (0x03, sp)
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00173$
00172$:
	sll	(1, sp)
	dec	a
	jrne	00172$
00173$:
	pop	a
	or	a, _EXTIPinMaskB+0
	ld	_EXTIPinMaskB+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 35: break;
	jra	00114$
;	../../my_STM8_libraries/stm8_interrupt.c: 36: case EXTI_PORTC:
00107$:
;	../../my_STM8_libraries/stm8_interrupt.c: 37: if (EXTIPinMaskC == 0) previousStateC = PC_IDR;
	ld	a, _EXTIPinMaskC+0
	jrne	00109$
	mov	_previousStateC+0, 0x500b
00109$:
;	../../my_STM8_libraries/stm8_interrupt.c: 38: EXTIPinMaskC |= (1 << pin);
	ld	a, (0x03, sp)
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00176$
00175$:
	sll	(1, sp)
	dec	a
	jrne	00175$
00176$:
	pop	a
	or	a, _EXTIPinMaskC+0
	ld	_EXTIPinMaskC+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 39: break;
	jra	00114$
;	../../my_STM8_libraries/stm8_interrupt.c: 40: case EXTI_PORTD:
00110$:
;	../../my_STM8_libraries/stm8_interrupt.c: 41: if (EXTIPinMaskD == 0) previousStateD = PD_IDR;
	ld	a, _EXTIPinMaskD+0
	jrne	00112$
	mov	_previousStateD+0, 0x5010
00112$:
;	../../my_STM8_libraries/stm8_interrupt.c: 42: EXTIPinMaskD |= (1 << pin);
	ld	a, (0x03, sp)
	ld	xl, a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00179$
00178$:
	sll	(1, sp)
	dec	a
	jrne	00178$
00179$:
	pop	a
	or	a, _EXTIPinMaskD+0
	ld	_EXTIPinMaskD+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 44: }
00114$:
;	../../my_STM8_libraries/stm8_interrupt.c: 45: }
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 46: void clear_EXTI_pin(uint8_t port, uint8_t pin)
;	-----------------------------------------
;	 function clear_EXTI_pin
;	-----------------------------------------
_clear_EXTI_pin:
	ld	xl, a
;	../../my_STM8_libraries/stm8_interrupt.c: 51: EXTIPinMaskA &= ~(1 << pin);
	ld	a, (0x03, sp)
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
	ld	xh, a
;	../../my_STM8_libraries/stm8_interrupt.c: 48: switch (port)
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
;	../../my_STM8_libraries/stm8_interrupt.c: 50: case EXTI_PORTA:
00101$:
;	../../my_STM8_libraries/stm8_interrupt.c: 51: EXTIPinMaskA &= ~(1 << pin);
	ld	a, xh
	and	a, _EXTIPinMaskA+0
	ld	_EXTIPinMaskA+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 52: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 53: case EXTI_PORTB:
00102$:
;	../../my_STM8_libraries/stm8_interrupt.c: 54: EXTIPinMaskB &= ~(1 << pin);
	ld	a, xh
	and	a, _EXTIPinMaskB+0
	ld	_EXTIPinMaskB+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 55: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 56: case EXTI_PORTC:
00103$:
;	../../my_STM8_libraries/stm8_interrupt.c: 57: EXTIPinMaskC &= ~(1 << pin);
	ld	a, xh
	and	a, _EXTIPinMaskC+0
	ld	_EXTIPinMaskC+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 58: break;
	jra	00106$
;	../../my_STM8_libraries/stm8_interrupt.c: 59: case EXTI_PORTD:
00104$:
;	../../my_STM8_libraries/stm8_interrupt.c: 60: EXTIPinMaskD &= ~(1 << pin);
	ld	a, xh
	and	a, _EXTIPinMaskD+0
	ld	_EXTIPinMaskD+0, a
;	../../my_STM8_libraries/stm8_interrupt.c: 62: }
00106$:
;	../../my_STM8_libraries/stm8_interrupt.c: 63: }
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_interrupt.c: 64: void setInterruptPriority(uint8_t interrupt, uint8_t priorityLevel)
;	-----------------------------------------
;	 function setInterruptPriority
;	-----------------------------------------
_setInterruptPriority:
	sub	sp, #2
;	../../my_STM8_libraries/stm8_interrupt.c: 66: volatile uint8_t *priorityReg = &ITC_SPR1 + (interrupt >> 2);
	ld	yl, a
	srl	a
	srl	a
	clrw	x
	ld	xl, a
	addw	x, #0x7f70
;	../../my_STM8_libraries/stm8_interrupt.c: 67: *priorityReg &= ~(3 << ((interrupt & 3) << 1));
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
;	../../my_STM8_libraries/stm8_interrupt.c: 68: *priorityReg |= (priorityLevel << ((interrupt & 3) << 1));
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
;	../../my_STM8_libraries/stm8_interrupt.c: 69: }
	addw	sp, #2
	popw	x
	pop	a
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__previousStateA:
	.db #0x00	; 0
__xinit__EXTIPinMaskA:
	.db #0x00	; 0
__xinit__EXTI_FlagA:
	.db #0x00	; 0
__xinit__previousStateB:
	.db #0x00	; 0
__xinit__EXTIPinMaskB:
	.db #0x00	; 0
__xinit__EXTI_FlagB:
	.db #0x00	; 0
__xinit__previousStateC:
	.db #0x00	; 0
__xinit__EXTIPinMaskC:
	.db #0x00	; 0
__xinit__EXTI_FlagC:
	.db #0x00	; 0
__xinit__previousStateD:
	.db #0x00	; 0
__xinit__EXTIPinMaskD:
	.db #0x00	; 0
__xinit__EXTI_FlagD:
	.db #0x00	; 0
	.area CABS (ABS)
