                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_TIME
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _tick_TIME
                                     12 	.globl _init_TIME
                                     13 	.globl _get_ms
                                     14 	.globl _get_mcs
                                     15 	.globl _delay
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
      000003                         24 __milsec:
      000003                         25 	.ds 4
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	../../my_STM8_libraries/stm8_TIME.c: 5: void tick_TIME(void) {
                                     56 ;	-----------------------------------------
                                     57 ;	 function tick_TIME
                                     58 ;	-----------------------------------------
      008641                         59 _tick_TIME:
                                     60 ;	../../my_STM8_libraries/stm8_TIME.c: 6: _milsec++;
      008641 CE 00 05         [ 2]   61 	ldw	x, __milsec+2
      008644 90 CE 00 03      [ 2]   62 	ldw	y, __milsec+0
      008648 5C               [ 1]   63 	incw	x
      008649 26 02            [ 1]   64 	jrne	00103$
      00864B 90 5C            [ 1]   65 	incw	y
      00864D                         66 00103$:
      00864D CF 00 05         [ 2]   67 	ldw	__milsec+2, x
      008650 90 CF 00 03      [ 2]   68 	ldw	__milsec+0, y
                                     69 ;	../../my_STM8_libraries/stm8_TIME.c: 7: }
      008654 81               [ 4]   70 	ret
                                     71 ;	../../my_STM8_libraries/stm8_TIME.c: 9: void init_TIME(void) {
                                     72 ;	-----------------------------------------
                                     73 ;	 function init_TIME
                                     74 ;	-----------------------------------------
      008655                         75 _init_TIME:
                                     76 ;	../../my_STM8_libraries/stm8_TIME.c: 10: _milsec = 0;
      008655 5F               [ 1]   77 	clrw	x
      008656 CF 00 05         [ 2]   78 	ldw	__milsec+2, x
      008659 CF 00 03         [ 2]   79 	ldw	__milsec+0, x
                                     80 ;	../../my_STM8_libraries/stm8_TIME.c: 11: TIM4_CR1 = 0;
      00865C 35 00 53 40      [ 1]   81 	mov	0x5340+0, #0x00
                                     82 ;	../../my_STM8_libraries/stm8_TIME.c: 12: TIM4_PSCR = 0x07;
      008660 35 07 53 47      [ 1]   83 	mov	0x5347+0, #0x07
                                     84 ;	../../my_STM8_libraries/stm8_TIME.c: 13: TIM4_ARR  = 124;
      008664 35 7C 53 48      [ 1]   85 	mov	0x5348+0, #0x7c
                                     86 ;	../../my_STM8_libraries/stm8_TIME.c: 14: TIM4_IER |= 0x01;
      008668 72 10 53 43      [ 1]   87 	bset	0x5343, #0
                                     88 ;	../../my_STM8_libraries/stm8_TIME.c: 15: TIM4_CR1 |= (1 << 0);
      00866C 72 10 53 40      [ 1]   89 	bset	0x5340, #0
                                     90 ;	../../my_STM8_libraries/stm8_TIME.c: 16: TIM4_SR = 0;
      008670 35 00 53 44      [ 1]   91 	mov	0x5344+0, #0x00
                                     92 ;	../../my_STM8_libraries/stm8_TIME.c: 17: }
      008674 81               [ 4]   93 	ret
                                     94 ;	../../my_STM8_libraries/stm8_TIME.c: 19: uint32_t get_ms(void) {
                                     95 ;	-----------------------------------------
                                     96 ;	 function get_ms
                                     97 ;	-----------------------------------------
      008675                         98 _get_ms:
                                     99 ;	../../my_STM8_libraries/stm8_TIME.c: 22: disableInterrupts();
      008675 9B               [ 1]  100 	sim
                                    101 ;	../../my_STM8_libraries/stm8_TIME.c: 23: ms = _milsec;
      008676 CE 00 05         [ 2]  102 	ldw	x, __milsec+2
      008679 90 CE 00 03      [ 2]  103 	ldw	y, __milsec+0
                                    104 ;	../../my_STM8_libraries/stm8_TIME.c: 24: enableInterrupts();
      00867D 9A               [ 1]  105 	rim
                                    106 ;	../../my_STM8_libraries/stm8_TIME.c: 26: return ms;
                                    107 ;	../../my_STM8_libraries/stm8_TIME.c: 27: }
      00867E 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_TIME.c: 30: uint32_t get_mcs(void) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function get_mcs
                                    112 ;	-----------------------------------------
      00867F                        113 _get_mcs:
      00867F 52 05            [ 2]  114 	sub	sp, #5
                                    115 ;	../../my_STM8_libraries/stm8_TIME.c: 34: disableInterrupts();
      008681 9B               [ 1]  116 	sim
                                    117 ;	../../my_STM8_libraries/stm8_TIME.c: 35: ms = _milsec;
      008682 CE 00 05         [ 2]  118 	ldw	x, __milsec+2
      008685 90 CE 00 03      [ 2]  119 	ldw	y, __milsec+0
                                    120 ;	../../my_STM8_libraries/stm8_TIME.c: 36: ticks = TIM4_CNTR; // Текущее значение счетчика (0-124)
      008689 C6 53 46         [ 1]  121 	ld	a, 0x5346
      00868C 6B 01            [ 1]  122 	ld	(0x01, sp), a
                                    123 ;	../../my_STM8_libraries/stm8_TIME.c: 37: enableInterrupts();
      00868E 9A               [ 1]  124 	rim
                                    125 ;	../../my_STM8_libraries/stm8_TIME.c: 39: return (ms * 1000) + (uint32_t)(ticks * 8);
      00868F 89               [ 2]  126 	pushw	x
      008690 90 89            [ 2]  127 	pushw	y
      008692 4B E8            [ 1]  128 	push	#0xe8
      008694 4B 03            [ 1]  129 	push	#0x03
      008696 5F               [ 1]  130 	clrw	x
      008697 89               [ 2]  131 	pushw	x
      008698 CD 88 61         [ 4]  132 	call	__mullong
      00869B 5B 08            [ 2]  133 	addw	sp, #8
      00869D 1F 04            [ 2]  134 	ldw	(0x04, sp), x
      00869F 17 02            [ 2]  135 	ldw	(0x02, sp), y
      0086A1 5F               [ 1]  136 	clrw	x
      0086A2 7B 01            [ 1]  137 	ld	a, (0x01, sp)
      0086A4 97               [ 1]  138 	ld	xl, a
      0086A5 58               [ 2]  139 	sllw	x
      0086A6 58               [ 2]  140 	sllw	x
      0086A7 58               [ 2]  141 	sllw	x
      0086A8 51               [ 1]  142 	exgw	x, y
      0086A9 5F               [ 1]  143 	clrw	x
      0086AA 90 5D            [ 2]  144 	tnzw	y
      0086AC 2A 01            [ 1]  145 	jrpl	00103$
      0086AE 5A               [ 2]  146 	decw	x
      0086AF                        147 00103$:
      0086AF 72 F9 04         [ 2]  148 	addw	y, (0x04, sp)
      0086B2 9F               [ 1]  149 	ld	a, xl
      0086B3 19 03            [ 1]  150 	adc	a, (0x03, sp)
      0086B5 02               [ 1]  151 	rlwa	x
      0086B6 19 02            [ 1]  152 	adc	a, (0x02, sp)
      0086B8 95               [ 1]  153 	ld	xh, a
      0086B9 51               [ 1]  154 	exgw	x, y
                                    155 ;	../../my_STM8_libraries/stm8_TIME.c: 40: }
      0086BA 5B 05            [ 2]  156 	addw	sp, #5
      0086BC 81               [ 4]  157 	ret
                                    158 ;	../../my_STM8_libraries/stm8_TIME.c: 43: void delay(uint32_t ms) {
                                    159 ;	-----------------------------------------
                                    160 ;	 function delay
                                    161 ;	-----------------------------------------
      0086BD                        162 _delay:
      0086BD 52 0C            [ 2]  163 	sub	sp, #12
                                    164 ;	../../my_STM8_libraries/stm8_TIME.c: 44: uint32_t start = get_ms();
      0086BF CD 86 75         [ 4]  165 	call	_get_ms
      0086C2 1F 03            [ 2]  166 	ldw	(0x03, sp), x
      0086C4 17 01            [ 2]  167 	ldw	(0x01, sp), y
                                    168 ;	../../my_STM8_libraries/stm8_TIME.c: 45: while ((get_ms() - start) < ms);
      0086C6                        169 00101$:
      0086C6 CD 86 75         [ 4]  170 	call	_get_ms
      0086C9 1F 07            [ 2]  171 	ldw	(0x07, sp), x
      0086CB 17 05            [ 2]  172 	ldw	(0x05, sp), y
      0086CD 1E 07            [ 2]  173 	ldw	x, (0x07, sp)
      0086CF 72 F0 03         [ 2]  174 	subw	x, (0x03, sp)
      0086D2 1F 0B            [ 2]  175 	ldw	(0x0b, sp), x
      0086D4 7B 06            [ 1]  176 	ld	a, (0x06, sp)
      0086D6 12 02            [ 1]  177 	sbc	a, (0x02, sp)
      0086D8 6B 0A            [ 1]  178 	ld	(0x0a, sp), a
      0086DA 7B 05            [ 1]  179 	ld	a, (0x05, sp)
      0086DC 12 01            [ 1]  180 	sbc	a, (0x01, sp)
      0086DE 88               [ 1]  181 	push	a
      0086DF 1E 0C            [ 2]  182 	ldw	x, (0x0c, sp)
      0086E1 13 12            [ 2]  183 	cpw	x, (0x12, sp)
      0086E3 7B 0B            [ 1]  184 	ld	a, (0x0b, sp)
      0086E5 12 11            [ 1]  185 	sbc	a, (0x11, sp)
      0086E7 84               [ 1]  186 	pop	a
      0086E8 12 0F            [ 1]  187 	sbc	a, (0x0f, sp)
      0086EA 25 DA            [ 1]  188 	jrc	00101$
                                    189 ;	../../my_STM8_libraries/stm8_TIME.c: 46: }
      0086EC 1E 0D            [ 2]  190 	ldw	x, (13, sp)
      0086EE 5B 12            [ 2]  191 	addw	sp, #18
      0086F0 FC               [ 2]  192 	jp	(x)
                                    193 	.area CODE
                                    194 	.area CONST
                                    195 	.area INITIALIZER
      0080AA                        196 __xinit___milsec:
      0080AA 00 00 00 00            197 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    198 	.area CABS (ABS)
