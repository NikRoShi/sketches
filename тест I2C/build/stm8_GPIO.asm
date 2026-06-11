;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_GPIO
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pinMode
	.globl _writePin
	.globl _togglePin
	.globl _readPin
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
;	../../libs/stm8_GPIO.c: 3: void pinMode(volatile uint8_t* port, uint8_t pin, uint8_t mode) {
;	-----------------------------------------
;	 function pinMode
;	-----------------------------------------
_pinMode:
	sub	sp, #6
;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
	ldw	(0x05, sp), x
	incw	x
	incw	x
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	pop	a
	tnz	a
	jreq	00153$
00152$:
	sll	(0x01, sp)
	dec	a
	jrne	00152$
00153$:
;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
	ldw	y, (0x05, sp)
	addw	y, #0x0003
	ldw	(0x02, sp), y
;	../../libs/stm8_GPIO.c: 4: if (mode == OUTPUT) {
	tnz	(0x09, sp)
	jrne	00113$
;	../../libs/stm8_GPIO.c: 5: *(port + 2) |= (1 << pin);
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 6: *(port + 3) |= (1 << pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	or	a, (0x01, sp)
	ldw	x, (0x02, sp)
	ld	(x), a
	jra	00115$
00113$:
;	../../libs/stm8_GPIO.c: 8: else if (mode == OUTPUT_FAST) {
	ld	a, (0x09, sp)
	dec	a
	jrne	00110$
;	../../libs/stm8_GPIO.c: 9: *(port + 2) |= (1 << pin);
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 10: *(port + 3) |= (1 << pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	or	a, (0x01, sp)
	ldw	x, (0x02, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 11: *(port + 4) |= (1 << pin);
	ldw	x, (0x05, sp)
	addw	x, #0x0004
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
	jra	00115$
00110$:
;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
	ld	a, (0x01, sp)
	cpl	a
	ld	(0x04, sp), a
;	../../libs/stm8_GPIO.c: 13: else if (mode == INPUT) {
	ld	a, (0x09, sp)
	cp	a, #0x02
	jrne	00107$
;	../../libs/stm8_GPIO.c: 14: *(port + 2) &= ~(1 << pin);
	ld	a, (x)
	and	a, (0x04, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 15: *(port + 3) &= ~(1 << pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	and	a, (0x04, sp)
	ldw	x, (0x02, sp)
	ld	(x), a
	jra	00115$
00107$:
;	../../libs/stm8_GPIO.c: 17: else if (mode == INPUT_PULLUP) {
	ld	a, (0x09, sp)
	cp	a, #0x03
	jrne	00104$
;	../../libs/stm8_GPIO.c: 18: *(port + 2) &= ~(1 << pin);
	ld	a, (x)
	and	a, (0x04, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 19: *(port + 3) |= (1 << pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	or	a, (0x01, sp)
	ldw	x, (0x02, sp)
	ld	(x), a
	jra	00115$
00104$:
;	../../libs/stm8_GPIO.c: 21: else if (mode == OUTPUT_OD) {
	ld	a, (0x09, sp)
	cp	a, #0x04
	jrne	00115$
;	../../libs/stm8_GPIO.c: 22: *(port + 2) |= (1 << pin);  // DDR = 1 (Выход)
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 23: *(port + 3) &= ~(1 << pin); // CR1 = 0 (Open Drain)
	ldw	x, (0x02, sp)
	ld	a, (x)
	and	a, (0x04, sp)
	ldw	x, (0x02, sp)
	ld	(x), a
00115$:
;	../../libs/stm8_GPIO.c: 25: }
	addw	sp, #6
	popw	x
	pop	a
	jp	(x)
;	../../libs/stm8_GPIO.c: 27: void writePin(volatile uint8_t* port, uint8_t pin, uint8_t state) {
;	-----------------------------------------
;	 function writePin
;	-----------------------------------------
_writePin:
	sub	sp, #4
;	../../libs/stm8_GPIO.c: 29: *port |= (1 << pin);
	ldw	(0x03, sp), x
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	pop	a
	tnz	a
	jreq	00114$
00113$:
	sll	(0x01, sp)
	dec	a
	jrne	00113$
00114$:
	ld	a, (x)
	ld	(0x02, sp), a
;	../../libs/stm8_GPIO.c: 28: if (state == HIGH) {
	ld	a, (0x07, sp)
	dec	a
	jrne	00102$
;	../../libs/stm8_GPIO.c: 29: *port |= (1 << pin);
	ld	a, (0x02, sp)
	or	a, (0x01, sp)
	ld	(x), a
	jra	00104$
00102$:
;	../../libs/stm8_GPIO.c: 31: else {*port &= ~(1 << pin);}
	ld	a, (0x01, sp)
	cpl	a
	and	a, (0x02, sp)
	ld	(x), a
00104$:
;	../../libs/stm8_GPIO.c: 32: }
	addw	sp, #4
	popw	x
	pop	a
	jp	(x)
;	../../libs/stm8_GPIO.c: 34: void togglePin(volatile uint8_t* port, uint8_t pin) {
;	-----------------------------------------
;	 function togglePin
;	-----------------------------------------
_togglePin:
	sub	sp, #4
	ldw	(0x03, sp), x
	ld	(0x02, sp), a
;	../../libs/stm8_GPIO.c: 35: *port ^= (1 << pin);
	ldw	x, (0x03, sp)
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	xor	a, (0x01, sp)
	ld	(x), a
;	../../libs/stm8_GPIO.c: 36: }
	addw	sp, #4
	ret
;	../../libs/stm8_GPIO.c: 38: uint8_t readPin(volatile uint8_t* port, uint8_t pin) {
;	-----------------------------------------
;	 function readPin
;	-----------------------------------------
_readPin:
	sub	sp, #7
	ldw	(0x06, sp), x
	ld	(0x05, sp), a
;	../../libs/stm8_GPIO.c: 39: if (*(port +1) & (1 << pin)) {
	ldw	x, (0x06, sp)
	ld	a, (0x1, x)
	push	a
	clrw	x
	incw	x
	ld	a, (0x06, sp)
	jreq	00113$
00112$:
	sllw	x
	dec	a
	jrne	00112$
00113$:
	pop	a
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ld	a, xl
	and	a, (0x02, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, (0x03, sp)
	jreq	00102$
;	../../libs/stm8_GPIO.c: 40: return 1;
	ld	a, #0x01
;	../../libs/stm8_GPIO.c: 42: return 0;
	.byte 0x21
00102$:
	clr	a
00103$:
;	../../libs/stm8_GPIO.c: 43: }
	addw	sp, #7
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
