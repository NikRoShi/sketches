;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module stm8_BEEP
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _init_BEEP
	.globl _beep
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
;	../../my_STM8_libraries/stm8_BEEP.c: 4: void init_BEEP(uint8_t freq)
;	-----------------------------------------
;	 function init_BEEP
;	-----------------------------------------
_init_BEEP:
	push	a
;	../../my_STM8_libraries/stm8_BEEP.c: 6: if (freq != BEEP_1KHZ && freq != BEEP_2KHZ && freq != BEEP_4KHZ) freq = BEEP_1KHZ;
	ld	xl, a
	tnz	a
	jreq	00102$
	ld	a, xl
	dec	a
	jreq	00102$
	ld	a, xl
	cp	a, #0x02
	jreq	00102$
	clrw	x
00102$:
;	../../my_STM8_libraries/stm8_BEEP.c: 7: BEEP_CSR &= ~BEEP_CSR_BEEPEN;
	bres	0x50f3, #5
;	../../my_STM8_libraries/stm8_BEEP.c: 9: BEEP_CSR &= ~(0x1F << BEEP_CSR_BEEPDIV);
	ld	a, 0x50f3
	and	a, #0xe0
	ld	0x50f3, a
;	../../my_STM8_libraries/stm8_BEEP.c: 10: BEEP_CSR |= (0x10 << BEEP_CSR_BEEPDIV);
	bset	0x50f3, #4
;	../../my_STM8_libraries/stm8_BEEP.c: 12: BEEP_CSR &= ~(0x03 << BEEP_CSR_BEEPSEL);
	ld	a, 0x50f3
	and	a, #0x3f
	ld	0x50f3, a
;	../../my_STM8_libraries/stm8_BEEP.c: 13: BEEP_CSR |= (freq << BEEP_CSR_BEEPSEL);
	ld	a, 0x50f3
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	sll	a
	sll	a
	or	a, (0x01, sp)
	ld	0x50f3, a
;	../../my_STM8_libraries/stm8_BEEP.c: 14: }
	pop	a
	ret
;	../../my_STM8_libraries/stm8_BEEP.c: 15: void beep(uint8_t state)
;	-----------------------------------------
;	 function beep
;	-----------------------------------------
_beep:
;	../../my_STM8_libraries/stm8_BEEP.c: 17: if (state == HIGH) BEEP_CSR |= BEEP_CSR_BEEPEN;
	ld	xl, a
	dec	a
	jrne	00102$
	bset	0x50f3, #5
00102$:
;	../../my_STM8_libraries/stm8_BEEP.c: 18: if (state == LOW) BEEP_CSR &= ~BEEP_CSR_BEEPEN;
	ld	a, xl
	tnz	a
	jreq	00120$
	ret
00120$:
	bres	0x50f3, #5
;	../../my_STM8_libraries/stm8_BEEP.c: 19: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
