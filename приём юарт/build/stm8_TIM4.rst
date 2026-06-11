                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_TIM4
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _tick_TIM4
                                     11 	.globl _init_TIM4
                                     12 	.globl _millis
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
      000003                         21 __millis:
      000003                         22 	.ds 4
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	../../libs/stm8_TIM4.c: 7: void tick_TIM4(void)
                                     53 ;	-----------------------------------------
                                     54 ;	 function tick_TIM4
                                     55 ;	-----------------------------------------
      0082A2                         56 _tick_TIM4:
                                     57 ;	../../libs/stm8_TIM4.c: 9: _millis++;
      0082A2 CE 00 05         [ 2]   58 	ldw	x, __millis+2
      0082A5 90 CE 00 03      [ 2]   59 	ldw	y, __millis+0
      0082A9 5C               [ 1]   60 	incw	x
      0082AA 26 02            [ 1]   61 	jrne	00103$
      0082AC 90 5C            [ 1]   62 	incw	y
      0082AE                         63 00103$:
      0082AE CF 00 05         [ 2]   64 	ldw	__millis+2, x
      0082B1 90 CF 00 03      [ 2]   65 	ldw	__millis+0, y
                                     66 ;	../../libs/stm8_TIM4.c: 10: }
      0082B5 81               [ 4]   67 	ret
                                     68 ;	../../libs/stm8_TIM4.c: 12: void init_TIM4(void)
                                     69 ;	-----------------------------------------
                                     70 ;	 function init_TIM4
                                     71 ;	-----------------------------------------
      0082B6                         72 _init_TIM4:
                                     73 ;	../../libs/stm8_TIM4.c: 14: _millis = 0;
      0082B6 5F               [ 1]   74 	clrw	x
      0082B7 CF 00 05         [ 2]   75 	ldw	__millis+2, x
      0082BA CF 00 03         [ 2]   76 	ldw	__millis+0, x
                                     77 ;	../../libs/stm8_TIM4.c: 16: TIM4_CR1 = 0;
      0082BD 35 00 53 40      [ 1]   78 	mov	0x5340+0, #0x00
                                     79 ;	../../libs/stm8_TIM4.c: 17: TIM4_PSCR = 0x07;
      0082C1 35 07 53 47      [ 1]   80 	mov	0x5347+0, #0x07
                                     81 ;	../../libs/stm8_TIM4.c: 18: TIM4_ARR  = 124;
      0082C5 35 7C 53 48      [ 1]   82 	mov	0x5348+0, #0x7c
                                     83 ;	../../libs/stm8_TIM4.c: 20: TIM4_IER |= 0x01;
      0082C9 72 10 53 43      [ 1]   84 	bset	0x5343, #0
                                     85 ;	../../libs/stm8_TIM4.c: 21: TIM4_SR = 0;
      0082CD 35 00 53 44      [ 1]   86 	mov	0x5344+0, #0x00
                                     87 ;	../../libs/stm8_TIM4.c: 22: TIM4_CR1 |= 0x01;
      0082D1 72 10 53 40      [ 1]   88 	bset	0x5340, #0
                                     89 ;	../../libs/stm8_TIM4.c: 23: }
      0082D5 81               [ 4]   90 	ret
                                     91 ;	../../libs/stm8_TIM4.c: 25: uint32_t millis(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function millis
                                     94 ;	-----------------------------------------
      0082D6                         95 _millis:
                                     96 ;	../../libs/stm8_TIM4.c: 29: disableInterrupts();
      0082D6 9B               [ 1]   97 	sim
                                     98 ;	../../libs/stm8_TIM4.c: 30: ms = _millis;
      0082D7 CE 00 05         [ 2]   99 	ldw	x, __millis+2
      0082DA 90 CE 00 03      [ 2]  100 	ldw	y, __millis+0
                                    101 ;	../../libs/stm8_TIM4.c: 31: enableInterrupts();
      0082DE 9A               [ 1]  102 	rim
                                    103 ;	../../libs/stm8_TIM4.c: 33: return ms;
                                    104 ;	../../libs/stm8_TIM4.c: 34: }
      0082DF 81               [ 4]  105 	ret
                                    106 	.area CODE
                                    107 	.area CONST
                                    108 	.area INITIALIZER
      008093                        109 __xinit___millis:
      008093 00 00 00 00            110 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    111 	.area CABS (ABS)
