                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_time
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _tim4_tick
                                     11 	.globl _time_init
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
                                     52 ;	stm8_time.c: 7: void tim4_tick(void)
                                     53 ;	-----------------------------------------
                                     54 ;	 function tim4_tick
                                     55 ;	-----------------------------------------
      0081C9                         56 _tim4_tick:
                                     57 ;	stm8_time.c: 9: _millis++;
      0081C9 CE 00 05         [ 2]   58 	ldw	x, __millis+2
      0081CC 90 CE 00 03      [ 2]   59 	ldw	y, __millis+0
      0081D0 5C               [ 1]   60 	incw	x
      0081D1 26 02            [ 1]   61 	jrne	00103$
      0081D3 90 5C            [ 1]   62 	incw	y
      0081D5                         63 00103$:
      0081D5 CF 00 05         [ 2]   64 	ldw	__millis+2, x
      0081D8 90 CF 00 03      [ 2]   65 	ldw	__millis+0, y
                                     66 ;	stm8_time.c: 10: }
      0081DC 81               [ 4]   67 	ret
                                     68 ;	stm8_time.c: 12: void time_init(void)
                                     69 ;	-----------------------------------------
                                     70 ;	 function time_init
                                     71 ;	-----------------------------------------
      0081DD                         72 _time_init:
                                     73 ;	stm8_time.c: 14: _millis = 0;
      0081DD 5F               [ 1]   74 	clrw	x
      0081DE CF 00 05         [ 2]   75 	ldw	__millis+2, x
      0081E1 CF 00 03         [ 2]   76 	ldw	__millis+0, x
                                     77 ;	stm8_time.c: 16: CLK_CKDIVR = 0x00;
      0081E4 35 00 50 C6      [ 1]   78 	mov	0x50c6+0, #0x00
                                     79 ;	stm8_time.c: 18: TIM4_CR1 = 0;
      0081E8 35 00 53 40      [ 1]   80 	mov	0x5340+0, #0x00
                                     81 ;	stm8_time.c: 19: TIM4_PSCR = 0x07;
      0081EC 35 07 53 47      [ 1]   82 	mov	0x5347+0, #0x07
                                     83 ;	stm8_time.c: 20: TIM4_ARR  = 124;
      0081F0 35 7C 53 48      [ 1]   84 	mov	0x5348+0, #0x7c
                                     85 ;	stm8_time.c: 22: TIM4_IER |= 0x01;
      0081F4 72 10 53 43      [ 1]   86 	bset	0x5343, #0
                                     87 ;	stm8_time.c: 23: TIM4_SR = 0;
      0081F8 35 00 53 44      [ 1]   88 	mov	0x5344+0, #0x00
                                     89 ;	stm8_time.c: 24: TIM4_CR1 |= 0x01;
      0081FC 72 10 53 40      [ 1]   90 	bset	0x5340, #0
                                     91 ;	stm8_time.c: 25: }
      008200 81               [ 4]   92 	ret
                                     93 ;	stm8_time.c: 27: uint32_t millis(void)
                                     94 ;	-----------------------------------------
                                     95 ;	 function millis
                                     96 ;	-----------------------------------------
      008201                         97 _millis:
                                     98 ;	stm8_time.c: 31: disableInterrupts();
      008201 9B               [ 1]   99 	sim
                                    100 ;	stm8_time.c: 32: ms = _millis;
      008202 CE 00 05         [ 2]  101 	ldw	x, __millis+2
      008205 90 CE 00 03      [ 2]  102 	ldw	y, __millis+0
                                    103 ;	stm8_time.c: 33: enableInterrupts();
      008209 9A               [ 1]  104 	rim
                                    105 ;	stm8_time.c: 35: return ms;
                                    106 ;	stm8_time.c: 36: }
      00820A 81               [ 4]  107 	ret
                                    108 	.area CODE
                                    109 	.area CONST
                                    110 	.area INITIALIZER
      008095                        111 __xinit___millis:
      008095 00 00 00 00            112 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    113 	.area CABS (ABS)
