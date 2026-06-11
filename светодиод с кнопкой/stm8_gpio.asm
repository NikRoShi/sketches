;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_gpio
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pinMode
	.globl _digitalWrite
	.globl _togglePin
	.globl _digitalRead
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_gpio_ports:
	.ds 32
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
;	stm8_gpio.c: 42: void pinMode(Port_t port, uint8_t pin, PinMode_t mode)
;	-----------------------------------------
;	 function pinMode
;	-----------------------------------------
_pinMode:
	sub	sp, #6
	ld	xl, a
;	stm8_gpio.c: 44: GPIO_Port *p = &gpio_ports[port];
	ld	a, #0x08
	mul	x, a
	addw	x, #(_gpio_ports+0)
;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
	ldw	y, x
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	a, (0x09, sp)
	jreq	00124$
00123$:
	sll	(0x01, sp)
	dec	a
	jrne	00123$
00124$:
;	stm8_gpio.c: 48: *p->CR1 |=  (1 << pin);   // push-pull
	addw	y, #0x0004
	ldw	(0x02, sp), y
;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
	ldw	x, (0x2, x)
	ldw	(0x04, sp), x
	ld	a, (x)
	ld	xl, a
;	stm8_gpio.c: 46: if (mode == PIN_OUTPUT) {
	ld	a, (0x0a, sp)
	dec	a
	jrne	00105$
;	stm8_gpio.c: 47: *p->DDR |=  (1 << pin);   // output
	ld	a, xl
	or	a, (0x01, sp)
	ldw	x, (0x04, sp)
	ld	(x), a
;	stm8_gpio.c: 48: *p->CR1 |=  (1 << pin);   // push-pull
	ldw	x, (0x02, sp)
	ldw	x, (x)
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
	jra	00107$
00105$:
;	stm8_gpio.c: 51: *p->DDR &= ~(1 << pin);   // input
	ld	a, (0x01, sp)
	cpl	a
	ld	(0x06, sp), a
	ld	a, xl
	and	a, (0x06, sp)
;	stm8_gpio.c: 50: else if (mode == PIN_INPUT) {
	tnz	(0x0a, sp)
	jrne	00102$
;	stm8_gpio.c: 51: *p->DDR &= ~(1 << pin);   // input
	ldw	x, (0x04, sp)
	ld	(x), a
;	stm8_gpio.c: 52: *p->CR1 &= ~(1 << pin);   // floating
	ldw	x, (0x02, sp)
	ldw	x, (x)
	ld	a, (x)
	and	a, (0x06, sp)
	ld	(x), a
	jra	00107$
00102$:
;	stm8_gpio.c: 55: *p->DDR &= ~(1 << pin);   // input
	ldw	x, (0x04, sp)
	ld	(x), a
;	stm8_gpio.c: 56: *p->CR1 |= (1 << pin);
	ldw	x, (0x02, sp)
	ldw	x, (x)
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
00107$:
;	stm8_gpio.c: 58: }
	ldw	x, (7, sp)
	addw	sp, #10
	jp	(x)
;	stm8_gpio.c: 60: void digitalWrite(Port_t port, uint8_t pin, PinState_t state)
;	-----------------------------------------
;	 function digitalWrite
;	-----------------------------------------
_digitalWrite:
	sub	sp, #2
	ld	xl, a
;	stm8_gpio.c: 62: GPIO_Port *p = &gpio_ports[port];
	ld	a, #0x08
	mul	x, a
	addw	x, #(_gpio_ports+0)
;	stm8_gpio.c: 65: *p->ODR |=  (1 << pin);
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	a, (0x05, sp)
	jreq	00114$
00113$:
	sll	(0x01, sp)
	dec	a
	jrne	00113$
00114$:
	ldw	x, (x)
	ld	a, (x)
	ld	(0x02, sp), a
;	stm8_gpio.c: 64: if (state == HIGH)
	ld	a, (0x06, sp)
	dec	a
	jrne	00102$
;	stm8_gpio.c: 65: *p->ODR |=  (1 << pin);
	ld	a, (0x02, sp)
	or	a, (0x01, sp)
	ld	(x), a
	jra	00104$
00102$:
;	stm8_gpio.c: 67: *p->ODR &= ~(1 << pin);
	ld	a, (0x01, sp)
	cpl	a
	and	a, (0x02, sp)
	ld	(x), a
00104$:
;	stm8_gpio.c: 68: }
	ldw	x, (3, sp)
	addw	sp, #6
	jp	(x)
;	stm8_gpio.c: 70: void togglePin(Port_t port, uint8_t pin)
;	-----------------------------------------
;	 function togglePin
;	-----------------------------------------
_togglePin:
	push	a
	ld	xl, a
;	stm8_gpio.c: 72: GPIO_Port *p = &gpio_ports[port];
	ld	a, #0x08
	mul	x, a
	addw	x, #(_gpio_ports+0)
;	stm8_gpio.c: 73: *p->ODR ^= (1 << pin);
	ldw	x, (x)
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x05, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	xor	a, (0x01, sp)
	ld	(x), a
;	stm8_gpio.c: 74: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	stm8_gpio.c: 76: uint8_t digitalRead(Port_t port, uint8_t pin)
;	-----------------------------------------
;	 function digitalRead
;	-----------------------------------------
_digitalRead:
	sub	sp, #2
	ld	xl, a
;	stm8_gpio.c: 78: GPIO_Port *p = &gpio_ports[port];
	ld	a, #0x08
	mul	x, a
	addw	x, #(_gpio_ports+0)
;	stm8_gpio.c: 79: return ((*p->IDR & (1 << pin)) != 0);
	ldw	x, (0x6, x)
	ld	a, (x)
	push	a
	clrw	x
	incw	x
	ld	a, (0x06, sp)
	jreq	00104$
00103$:
	sllw	x
	dec	a
	jrne	00103$
00104$:
	pop	a
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ld	a, xl
	and	a, (0x02, sp)
	ld	xl, a
	clr	a
	ld	xh, a
	tnzw	x
	jrne	00106$
	clr	a
	.byte 0xc5
00106$:
	ld	a, #0x01
00107$:
;	stm8_gpio.c: 80: }
	addw	sp, #2
	popw	x
	addw	sp, #1
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__gpio_ports:
	.dw #0x5000
	.dw #0x5002
	.dw #0x5003
	.dw #0x5001
	.dw #0x5005
	.dw #0x5007
	.dw #0x5008
	.dw #0x5006
	.dw #0x500a
	.dw #0x500c
	.dw #0x500d
	.dw #0x500b
	.dw #0x500f
	.dw #0x5011
	.dw #0x5012
	.dw #0x5010
	.area CABS (ABS)
