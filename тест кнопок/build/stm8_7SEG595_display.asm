;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_7SEG595_display
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _writePin
	.globl _pinMode
	.globl _write_SPI
	.globl _init_SPI
	.globl _clear_display
	.globl _init_display
	.globl _setDigit
	.globl _refresh_display
	.globl _printNumber
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_latchPort:
	.ds 2
_latchPin:
	.ds 1
_displayBuffer:
	.ds 8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_currentPosition:
	.ds 1
_a:
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
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 35: void clear_display(void) 
;	-----------------------------------------
;	 function clear_display
;	-----------------------------------------
_clear_display:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
	clr	a
00103$:
	cp	a, #0x08
	jrc	00118$
	ret
00118$:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 39: displayBuffer[i] = DISPLAY_BLANK;
	clrw	x
	ld	xl, a
	addw	x, #(_displayBuffer+0)
	push	a
	ld	a, #0xff
	ld	(x), a
	pop	a
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 37: for (uint8_t i = 0; i < 8; i++)
	inc	a
	jra	00103$
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 41: }
	ret
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 43: void init_display(volatile uint8_t *port, uint8_t pin)
;	-----------------------------------------
;	 function init_display
;	-----------------------------------------
_init_display:
	sub	sp, #2
	ldw	(0x01, sp), x
	ld	_latchPin+0, a
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 45: latchPort = port;
	ldw	x, (0x01, sp)
	ldw	_latchPort+0, x
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 47: currentPosition = 0;
	clr	_currentPosition+0
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 48: clear_display();
	call	_clear_display
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 50: init_SPI(SPI_MODE0, SPI_DIV16, SPI_MSB, SPI_MST);
	push	#0x04
	push	#0x00
	push	#0x18
	clr	a
	call	_init_SPI
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 51: pinMode(latchPort, latchPin, OUTPUT);
	push	#0x00
	ld	a, _latchPin+0
	ldw	x, _latchPort+0
	call	_pinMode
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 53: writePin(latchPort, latchPin, LOW);
	push	#0x00
	ld	a, _latchPin+0
	ldw	x, _latchPort+0
	call	_writePin
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 54: }
	addw	sp, #2
	ret
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 55: void setDigit(uint8_t position, uint8_t digit)
;	-----------------------------------------
;	 function setDigit
;	-----------------------------------------
_setDigit:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 57: if (position > 7) return;
	cp	a, #0x07
	jrugt	00105$
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 58: if (digit > 9) return;
	push	a
	ld	a, (0x04, sp)
	cp	a, #0x09
	pop	a
	jrugt	00105$
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 60: displayBuffer[position] = digitTable[digit];
	clrw	x
	ld	xl, a
	addw	x, #(_displayBuffer+0)
	clrw	y
	ld	a, (0x03, sp)
	ld	yl, a
	addw	y, #(_digitTable+0)
	ld	a, (y)
	ld	(x), a
00105$:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 61: }
	popw	x
	pop	a
	jp	(x)
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 62: void refresh_display(void)
;	-----------------------------------------
;	 function refresh_display
;	-----------------------------------------
_refresh_display:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 64: write_SPI(displayBuffer[currentPosition]);
	clrw	x
	ld	a, _currentPosition+0
	ld	xl, a
	ld	a, (_displayBuffer+0, x)
	call	_write_SPI
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 65: write_SPI(positionTable[currentPosition]);
	clrw	x
	ld	a, _currentPosition+0
	ld	xl, a
	ld	a, (_positionTable+0, x)
	call	_write_SPI
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 67: writePin(latchPort, latchPin, HIGH);
	push	#0x01
	ld	a, _latchPin+0
	ldw	x, _latchPort+0
	call	_writePin
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 68: writePin(latchPort, latchPin, LOW);
	push	#0x00
	ld	a, _latchPin+0
	ldw	x, _latchPort+0
	call	_writePin
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 70: currentPosition++;
	inc	_currentPosition+0
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 71: if (currentPosition > 7) currentPosition = 0;
	ld	a, _currentPosition+0
	cp	a, #0x07
	jrugt	00110$
	ret
00110$:
	clr	_currentPosition+0
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 72: }
	ret
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 73: void printNumber(uint32_t number)
;	-----------------------------------------
;	 function printNumber
;	-----------------------------------------
_printNumber:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 75: while (number)
00101$:
	ldw	x, (0x05, sp)
	jrne	00116$
	ldw	x, (0x03, sp)
	jreq	00103$
00116$:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 77: setDigit(a, number % 10);
	push	#0x0a
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	__modulong
	addw	sp, #8
	ld	a, xl
	push	a
	ld	a, _a+0
	call	_setDigit
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 78: number /= 10;
	push	#0x0a
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	__divulong
	addw	sp, #8
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 79: a++;
	inc	_a+0
	jra	00101$
00103$:
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 81: a = 0;
	clr	_a+0
;	../../my_STM8_libraries/stm8_7SEG595_display.c: 82: }
	ldw	x, (1, sp)
	addw	sp, #6
	jp	(x)
	.area CODE
	.area CONST
_positionTable:
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
_digitTable:
	.db #0xc0	; 192
	.db #0xf9	; 249
	.db #0xa4	; 164
	.db #0xb0	; 176
	.db #0x99	; 153
	.db #0x92	; 146
	.db #0x82	; 130
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x90	; 144
	.area INITIALIZER
__xinit__currentPosition:
	.db #0x00	; 0
__xinit__a:
	.db #0x00	; 0
	.area CABS (ABS)
