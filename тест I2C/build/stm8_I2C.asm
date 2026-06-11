;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.10 #15702 (MINGW64)
;--------------------------------------------------------
	.module stm8_I2C
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_I2C
	.globl _start_I2C
	.globl _sendAddress_I2C
	.globl _write_I2C
	.globl _readAck_I2C
	.globl _readNack_I2C
	.globl _stop_I2C
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
;	../../libs/stm8_I2C.c: 3: void init_I2C(void) {
;	-----------------------------------------
;	 function init_I2C
;	-----------------------------------------
_init_I2C:
;	../../libs/stm8_I2C.c: 4: I2C_CR1 &= ~(1 << 0); // PE = 0
	bres	0x5210, #0
;	../../libs/stm8_I2C.c: 5: CLK_PCKENR1 |= (1 << 0);
	bset	0x50c7, #0
;	../../libs/stm8_I2C.c: 6: I2C_FREQR = 16;
	mov	0x5212+0, #0x10
;	../../libs/stm8_I2C.c: 7: I2C_CCRL = 0x50;      // 100 кГц
	mov	0x521a+0, #0x50
;	../../libs/stm8_I2C.c: 8: I2C_CCRH = 0x00;
	mov	0x521b+0, #0x00
;	../../libs/stm8_I2C.c: 9: I2C_TRISER = 17;
	mov	0x521c+0, #0x11
;	../../libs/stm8_I2C.c: 10: I2C_CR1 |= (1 << 0);  // PE = 1
	bset	0x5210, #0
;	../../libs/stm8_I2C.c: 11: }
	ret
;	../../libs/stm8_I2C.c: 13: uint8_t start_I2C(void) {
;	-----------------------------------------
;	 function start_I2C
;	-----------------------------------------
_start_I2C:
;	../../libs/stm8_I2C.c: 15: I2C_CR2 |= (1 << 0); // START
	bset	0x5211, #0
;	../../libs/stm8_I2C.c: 16: while (!(I2C_SR1 & (1 << 0)) && --timeout);
	ldw	x, #0x07d0
00102$:
	btjt	0x5217, #0, 00104$
	decw	x
	jrne	00102$
00104$:
;	../../libs/stm8_I2C.c: 17: return (timeout > 0); // 1 - успех, 0 - провал
	tnzw	x
	jreq	00107$
	ld	a, #0x01
	ret
00107$:
	clr	a
;	../../libs/stm8_I2C.c: 18: }
	ret
;	../../libs/stm8_I2C.c: 20: uint8_t sendAddress_I2C(uint8_t addr) {
;	-----------------------------------------
;	 function sendAddress_I2C
;	-----------------------------------------
_sendAddress_I2C:
;	../../libs/stm8_I2C.c: 22: I2C_DR = addr;
	ld	0x5216, a
;	../../libs/stm8_I2C.c: 23: while (!(I2C_SR1 & (1 << 1)) && --timeout);
	ldw	x, #0x07d0
00102$:
	btjt	0x5217, #1, 00104$
	decw	x
	jrne	00102$
00104$:
;	../../libs/stm8_I2C.c: 24: if (timeout == 0) return 0;
	tnzw	x
	jrne	00106$
	clr	a
	ret
00106$:
;	../../libs/stm8_I2C.c: 25: (void)I2C_SR1; 
	ld	a, 0x5217
;	../../libs/stm8_I2C.c: 26: (void)I2C_SR3; // Сброс ADDR
	ld	a, 0x5219
;	../../libs/stm8_I2C.c: 27: return 1;
	ld	a, #0x01
;	../../libs/stm8_I2C.c: 28: }
	ret
;	../../libs/stm8_I2C.c: 30: uint8_t write_I2C(uint8_t data) {
;	-----------------------------------------
;	 function write_I2C
;	-----------------------------------------
_write_I2C:
;	../../libs/stm8_I2C.c: 32: I2C_DR = data;
	ld	0x5216, a
;	../../libs/stm8_I2C.c: 33: while (!(I2C_SR1 & (1 << 7)) && --timeout); // Ждем TXE
	ldw	x, #0x07d0
00102$:
	ld	a, 0x5217
	jrmi	00104$
	decw	x
	jrne	00102$
00104$:
;	../../libs/stm8_I2C.c: 34: return (timeout > 0);
	tnzw	x
	jreq	00107$
	ld	a, #0x01
	ret
00107$:
	clr	a
;	../../libs/stm8_I2C.c: 35: }
	ret
;	../../libs/stm8_I2C.c: 37: uint8_t readAck_I2C(void) {
;	-----------------------------------------
;	 function readAck_I2C
;	-----------------------------------------
_readAck_I2C:
;	../../libs/stm8_I2C.c: 38: I2C_CR2 |= (1 << 4); // ACK On
	bset	0x5211, #4
;	../../libs/stm8_I2C.c: 39: while (!(I2C_SR1 & (1 << 6))); // RXNE
00101$:
	btjf	0x5217, #6, 00101$
;	../../libs/stm8_I2C.c: 40: return I2C_DR;
	ld	a, 0x5216
;	../../libs/stm8_I2C.c: 41: }
	ret
;	../../libs/stm8_I2C.c: 43: uint8_t readNack_I2C(void) {
;	-----------------------------------------
;	 function readNack_I2C
;	-----------------------------------------
_readNack_I2C:
;	../../libs/stm8_I2C.c: 44: I2C_CR2 &= ~(1 << 4); // ACK Off (NACK)
	bres	0x5211, #4
;	../../libs/stm8_I2C.c: 45: I2C_CR2 |= (1 << 1);  // STOP
	bset	0x5211, #1
;	../../libs/stm8_I2C.c: 46: while (!(I2C_SR1 & (1 << 6))); // RXNE
00101$:
	btjf	0x5217, #6, 00101$
;	../../libs/stm8_I2C.c: 47: return I2C_DR;
	ld	a, 0x5216
;	../../libs/stm8_I2C.c: 48: }
	ret
;	../../libs/stm8_I2C.c: 50: void stop_I2C(void) {
;	-----------------------------------------
;	 function stop_I2C
;	-----------------------------------------
_stop_I2C:
;	../../libs/stm8_I2C.c: 51: I2C_CR2 |= (1 << 1); // STOP
	bset	0x5211, #1
;	../../libs/stm8_I2C.c: 52: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
