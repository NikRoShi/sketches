                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_BEEP
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_BEEP
                                     12 	.globl _beep
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	../../my_STM8_libraries/stm8_BEEP.c: 4: void init_BEEP(uint8_t freq)
                                     51 ;	-----------------------------------------
                                     52 ;	 function init_BEEP
                                     53 ;	-----------------------------------------
      008221                         54 _init_BEEP:
      008221 88               [ 1]   55 	push	a
                                     56 ;	../../my_STM8_libraries/stm8_BEEP.c: 6: if (freq != BEEP_1KHZ && freq != BEEP_2KHZ && freq != BEEP_4KHZ) freq = BEEP_1KHZ;
      008222 97               [ 1]   57 	ld	xl, a
      008223 4D               [ 1]   58 	tnz	a
      008224 27 0A            [ 1]   59 	jreq	00102$
      008226 9F               [ 1]   60 	ld	a, xl
      008227 4A               [ 1]   61 	dec	a
      008228 27 06            [ 1]   62 	jreq	00102$
      00822A 9F               [ 1]   63 	ld	a, xl
      00822B A1 02            [ 1]   64 	cp	a, #0x02
      00822D 27 01            [ 1]   65 	jreq	00102$
      00822F 5F               [ 1]   66 	clrw	x
      008230                         67 00102$:
                                     68 ;	../../my_STM8_libraries/stm8_BEEP.c: 7: BEEP_CSR &= ~BEEP_CSR_BEEPEN;
      008230 72 1B 50 F3      [ 1]   69 	bres	0x50f3, #5
                                     70 ;	../../my_STM8_libraries/stm8_BEEP.c: 9: BEEP_CSR &= ~(0x1F << BEEP_CSR_BEEPDIV);
      008234 C6 50 F3         [ 1]   71 	ld	a, 0x50f3
      008237 A4 E0            [ 1]   72 	and	a, #0xe0
      008239 C7 50 F3         [ 1]   73 	ld	0x50f3, a
                                     74 ;	../../my_STM8_libraries/stm8_BEEP.c: 10: BEEP_CSR |= (0x10 << BEEP_CSR_BEEPDIV);
      00823C 72 18 50 F3      [ 1]   75 	bset	0x50f3, #4
                                     76 ;	../../my_STM8_libraries/stm8_BEEP.c: 12: BEEP_CSR &= ~(0x03 << BEEP_CSR_BEEPSEL);
      008240 C6 50 F3         [ 1]   77 	ld	a, 0x50f3
      008243 A4 3F            [ 1]   78 	and	a, #0x3f
      008245 C7 50 F3         [ 1]   79 	ld	0x50f3, a
                                     80 ;	../../my_STM8_libraries/stm8_BEEP.c: 13: BEEP_CSR |= (freq << BEEP_CSR_BEEPSEL);
      008248 C6 50 F3         [ 1]   81 	ld	a, 0x50f3
      00824B 6B 01            [ 1]   82 	ld	(0x01, sp), a
      00824D 9F               [ 1]   83 	ld	a, xl
      00824E 4E               [ 1]   84 	swap	a
      00824F A4 F0            [ 1]   85 	and	a, #0xf0
      008251 48               [ 1]   86 	sll	a
      008252 48               [ 1]   87 	sll	a
      008253 1A 01            [ 1]   88 	or	a, (0x01, sp)
      008255 C7 50 F3         [ 1]   89 	ld	0x50f3, a
                                     90 ;	../../my_STM8_libraries/stm8_BEEP.c: 14: }
      008258 84               [ 1]   91 	pop	a
      008259 81               [ 4]   92 	ret
                                     93 ;	../../my_STM8_libraries/stm8_BEEP.c: 15: void beep(uint8_t state)
                                     94 ;	-----------------------------------------
                                     95 ;	 function beep
                                     96 ;	-----------------------------------------
      00825A                         97 _beep:
                                     98 ;	../../my_STM8_libraries/stm8_BEEP.c: 17: if (state == HIGH) BEEP_CSR |= BEEP_CSR_BEEPEN;
      00825A 97               [ 1]   99 	ld	xl, a
      00825B 4A               [ 1]  100 	dec	a
      00825C 26 04            [ 1]  101 	jrne	00102$
      00825E 72 1A 50 F3      [ 1]  102 	bset	0x50f3, #5
      008262                        103 00102$:
                                    104 ;	../../my_STM8_libraries/stm8_BEEP.c: 18: if (state == LOW) BEEP_CSR &= ~BEEP_CSR_BEEPEN;
      008262 9F               [ 1]  105 	ld	a, xl
      008263 4D               [ 1]  106 	tnz	a
      008264 27 01            [ 1]  107 	jreq	00120$
      008266 81               [ 4]  108 	ret
      008267                        109 00120$:
      008267 72 1B 50 F3      [ 1]  110 	bres	0x50f3, #5
                                    111 ;	../../my_STM8_libraries/stm8_BEEP.c: 19: }
      00826B 81               [ 4]  112 	ret
                                    113 	.area CODE
                                    114 	.area CONST
                                    115 	.area INITIALIZER
                                    116 	.area CABS (ABS)
