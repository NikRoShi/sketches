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
      008157                         54 _init_BEEP:
      008157 88               [ 1]   55 	push	a
                                     56 ;	../../my_STM8_libraries/stm8_BEEP.c: 6: if (freq != BEEP_1KHZ && freq != BEEP_2KHZ && freq != BEEP_4KHZ) freq = BEEP_1KHZ;
      008158 97               [ 1]   57 	ld	xl, a
      008159 4D               [ 1]   58 	tnz	a
      00815A 27 0A            [ 1]   59 	jreq	00102$
      00815C 9F               [ 1]   60 	ld	a, xl
      00815D 4A               [ 1]   61 	dec	a
      00815E 27 06            [ 1]   62 	jreq	00102$
      008160 9F               [ 1]   63 	ld	a, xl
      008161 A1 02            [ 1]   64 	cp	a, #0x02
      008163 27 01            [ 1]   65 	jreq	00102$
      008165 5F               [ 1]   66 	clrw	x
      008166                         67 00102$:
                                     68 ;	../../my_STM8_libraries/stm8_BEEP.c: 7: BEEP_CSR &= ~BEEP_CSR_BEEPEN;
      008166 72 1B 50 F3      [ 1]   69 	bres	0x50f3, #5
                                     70 ;	../../my_STM8_libraries/stm8_BEEP.c: 9: BEEP_CSR &= ~(0x1F << BEEP_CSR_BEEPDIV);
      00816A C6 50 F3         [ 1]   71 	ld	a, 0x50f3
      00816D A4 E0            [ 1]   72 	and	a, #0xe0
      00816F C7 50 F3         [ 1]   73 	ld	0x50f3, a
                                     74 ;	../../my_STM8_libraries/stm8_BEEP.c: 10: BEEP_CSR |= (0x10 << BEEP_CSR_BEEPDIV);
      008172 72 18 50 F3      [ 1]   75 	bset	0x50f3, #4
                                     76 ;	../../my_STM8_libraries/stm8_BEEP.c: 12: BEEP_CSR &= ~(0x03 << BEEP_CSR_BEEPSEL);
      008176 C6 50 F3         [ 1]   77 	ld	a, 0x50f3
      008179 A4 3F            [ 1]   78 	and	a, #0x3f
      00817B C7 50 F3         [ 1]   79 	ld	0x50f3, a
                                     80 ;	../../my_STM8_libraries/stm8_BEEP.c: 13: BEEP_CSR |= (freq << BEEP_CSR_BEEPSEL);
      00817E C6 50 F3         [ 1]   81 	ld	a, 0x50f3
      008181 6B 01            [ 1]   82 	ld	(0x01, sp), a
      008183 9F               [ 1]   83 	ld	a, xl
      008184 4E               [ 1]   84 	swap	a
      008185 A4 F0            [ 1]   85 	and	a, #0xf0
      008187 48               [ 1]   86 	sll	a
      008188 48               [ 1]   87 	sll	a
      008189 1A 01            [ 1]   88 	or	a, (0x01, sp)
      00818B C7 50 F3         [ 1]   89 	ld	0x50f3, a
                                     90 ;	../../my_STM8_libraries/stm8_BEEP.c: 14: }
      00818E 84               [ 1]   91 	pop	a
      00818F 81               [ 4]   92 	ret
                                     93 ;	../../my_STM8_libraries/stm8_BEEP.c: 15: void beep(uint8_t state)
                                     94 ;	-----------------------------------------
                                     95 ;	 function beep
                                     96 ;	-----------------------------------------
      008190                         97 _beep:
                                     98 ;	../../my_STM8_libraries/stm8_BEEP.c: 17: if (state == HIGH) BEEP_CSR |= BEEP_CSR_BEEPEN;
      008190 97               [ 1]   99 	ld	xl, a
      008191 4A               [ 1]  100 	dec	a
      008192 26 04            [ 1]  101 	jrne	00102$
      008194 72 1A 50 F3      [ 1]  102 	bset	0x50f3, #5
      008198                        103 00102$:
                                    104 ;	../../my_STM8_libraries/stm8_BEEP.c: 18: if (state == LOW) BEEP_CSR &= ~BEEP_CSR_BEEPEN;
      008198 9F               [ 1]  105 	ld	a, xl
      008199 4D               [ 1]  106 	tnz	a
      00819A 27 01            [ 1]  107 	jreq	00120$
      00819C 81               [ 4]  108 	ret
      00819D                        109 00120$:
      00819D 72 1B 50 F3      [ 1]  110 	bres	0x50f3, #5
                                    111 ;	../../my_STM8_libraries/stm8_BEEP.c: 19: }
      0081A1 81               [ 4]  112 	ret
                                    113 	.area CODE
                                    114 	.area CONST
                                    115 	.area INITIALIZER
                                    116 	.area CABS (ABS)
