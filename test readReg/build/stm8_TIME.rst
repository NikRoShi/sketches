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
      008787                         59 _tick_TIME:
                                     60 ;	../../my_STM8_libraries/stm8_TIME.c: 6: _milsec++;
      008787 CE 00 05         [ 2]   61 	ldw	x, __milsec+2
      00878A 90 CE 00 03      [ 2]   62 	ldw	y, __milsec+0
      00878E 5C               [ 1]   63 	incw	x
      00878F 26 02            [ 1]   64 	jrne	00103$
      008791 90 5C            [ 1]   65 	incw	y
      008793                         66 00103$:
      008793 CF 00 05         [ 2]   67 	ldw	__milsec+2, x
      008796 90 CF 00 03      [ 2]   68 	ldw	__milsec+0, y
                                     69 ;	../../my_STM8_libraries/stm8_TIME.c: 7: }
      00879A 81               [ 4]   70 	ret
                                     71 ;	../../my_STM8_libraries/stm8_TIME.c: 9: void init_TIME(void) {
                                     72 ;	-----------------------------------------
                                     73 ;	 function init_TIME
                                     74 ;	-----------------------------------------
      00879B                         75 _init_TIME:
                                     76 ;	../../my_STM8_libraries/stm8_TIME.c: 10: _milsec = 0;
      00879B 5F               [ 1]   77 	clrw	x
      00879C CF 00 05         [ 2]   78 	ldw	__milsec+2, x
      00879F CF 00 03         [ 2]   79 	ldw	__milsec+0, x
                                     80 ;	../../my_STM8_libraries/stm8_TIME.c: 11: TIM4_CR1 = 0;
      0087A2 35 00 53 40      [ 1]   81 	mov	0x5340+0, #0x00
                                     82 ;	../../my_STM8_libraries/stm8_TIME.c: 12: TIM4_PSCR = 0x07;
      0087A6 35 07 53 47      [ 1]   83 	mov	0x5347+0, #0x07
                                     84 ;	../../my_STM8_libraries/stm8_TIME.c: 13: TIM4_ARR  = 124;
      0087AA 35 7C 53 48      [ 1]   85 	mov	0x5348+0, #0x7c
                                     86 ;	../../my_STM8_libraries/stm8_TIME.c: 14: TIM4_IER |= 0x01;
      0087AE 72 10 53 43      [ 1]   87 	bset	0x5343, #0
                                     88 ;	../../my_STM8_libraries/stm8_TIME.c: 15: TIM4_CR1 |= (1 << 0);
      0087B2 72 10 53 40      [ 1]   89 	bset	0x5340, #0
                                     90 ;	../../my_STM8_libraries/stm8_TIME.c: 16: TIM4_SR = 0;
      0087B6 35 00 53 44      [ 1]   91 	mov	0x5344+0, #0x00
                                     92 ;	../../my_STM8_libraries/stm8_TIME.c: 17: }
      0087BA 81               [ 4]   93 	ret
                                     94 ;	../../my_STM8_libraries/stm8_TIME.c: 19: uint32_t get_ms(void) {
                                     95 ;	-----------------------------------------
                                     96 ;	 function get_ms
                                     97 ;	-----------------------------------------
      0087BB                         98 _get_ms:
                                     99 ;	../../my_STM8_libraries/stm8_TIME.c: 22: disableInterrupts();
      0087BB 9B               [ 1]  100 	sim
                                    101 ;	../../my_STM8_libraries/stm8_TIME.c: 23: ms = _milsec;
      0087BC CE 00 05         [ 2]  102 	ldw	x, __milsec+2
      0087BF 90 CE 00 03      [ 2]  103 	ldw	y, __milsec+0
                                    104 ;	../../my_STM8_libraries/stm8_TIME.c: 24: enableInterrupts();
      0087C3 9A               [ 1]  105 	rim
                                    106 ;	../../my_STM8_libraries/stm8_TIME.c: 26: return ms;
                                    107 ;	../../my_STM8_libraries/stm8_TIME.c: 27: }
      0087C4 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_TIME.c: 30: uint32_t get_mcs(void) {
                                    110 ;	-----------------------------------------
                                    111 ;	 function get_mcs
                                    112 ;	-----------------------------------------
      0087C5                        113 _get_mcs:
      0087C5 52 05            [ 2]  114 	sub	sp, #5
                                    115 ;	../../my_STM8_libraries/stm8_TIME.c: 34: disableInterrupts();
      0087C7 9B               [ 1]  116 	sim
                                    117 ;	../../my_STM8_libraries/stm8_TIME.c: 35: ms = _milsec;
      0087C8 CE 00 05         [ 2]  118 	ldw	x, __milsec+2
      0087CB 90 CE 00 03      [ 2]  119 	ldw	y, __milsec+0
                                    120 ;	../../my_STM8_libraries/stm8_TIME.c: 36: ticks = TIM4_CNTR; // Текущее значение счетчика (0-124)
      0087CF C6 53 46         [ 1]  121 	ld	a, 0x5346
      0087D2 6B 01            [ 1]  122 	ld	(0x01, sp), a
                                    123 ;	../../my_STM8_libraries/stm8_TIME.c: 37: enableInterrupts();
      0087D4 9A               [ 1]  124 	rim
                                    125 ;	../../my_STM8_libraries/stm8_TIME.c: 39: return (ms * 1000) + (uint32_t)(ticks * 8);
      0087D5 89               [ 2]  126 	pushw	x
      0087D6 90 89            [ 2]  127 	pushw	y
      0087D8 4B E8            [ 1]  128 	push	#0xe8
      0087DA 4B 03            [ 1]  129 	push	#0x03
      0087DC 5F               [ 1]  130 	clrw	x
      0087DD 89               [ 2]  131 	pushw	x
      0087DE CD 89 A7         [ 4]  132 	call	__mullong
      0087E1 5B 08            [ 2]  133 	addw	sp, #8
      0087E3 1F 04            [ 2]  134 	ldw	(0x04, sp), x
      0087E5 17 02            [ 2]  135 	ldw	(0x02, sp), y
      0087E7 5F               [ 1]  136 	clrw	x
      0087E8 7B 01            [ 1]  137 	ld	a, (0x01, sp)
      0087EA 97               [ 1]  138 	ld	xl, a
      0087EB 58               [ 2]  139 	sllw	x
      0087EC 58               [ 2]  140 	sllw	x
      0087ED 58               [ 2]  141 	sllw	x
      0087EE 51               [ 1]  142 	exgw	x, y
      0087EF 5F               [ 1]  143 	clrw	x
      0087F0 90 5D            [ 2]  144 	tnzw	y
      0087F2 2A 01            [ 1]  145 	jrpl	00103$
      0087F4 5A               [ 2]  146 	decw	x
      0087F5                        147 00103$:
      0087F5 72 F9 04         [ 2]  148 	addw	y, (0x04, sp)
      0087F8 9F               [ 1]  149 	ld	a, xl
      0087F9 19 03            [ 1]  150 	adc	a, (0x03, sp)
      0087FB 02               [ 1]  151 	rlwa	x
      0087FC 19 02            [ 1]  152 	adc	a, (0x02, sp)
      0087FE 95               [ 1]  153 	ld	xh, a
      0087FF 51               [ 1]  154 	exgw	x, y
                                    155 ;	../../my_STM8_libraries/stm8_TIME.c: 40: }
      008800 5B 05            [ 2]  156 	addw	sp, #5
      008802 81               [ 4]  157 	ret
                                    158 ;	../../my_STM8_libraries/stm8_TIME.c: 43: void delay(uint32_t ms) {
                                    159 ;	-----------------------------------------
                                    160 ;	 function delay
                                    161 ;	-----------------------------------------
      008803                        162 _delay:
      008803 52 0C            [ 2]  163 	sub	sp, #12
                                    164 ;	../../my_STM8_libraries/stm8_TIME.c: 44: uint32_t start = get_ms();
      008805 CD 87 BB         [ 4]  165 	call	_get_ms
      008808 1F 03            [ 2]  166 	ldw	(0x03, sp), x
      00880A 17 01            [ 2]  167 	ldw	(0x01, sp), y
                                    168 ;	../../my_STM8_libraries/stm8_TIME.c: 45: while ((get_ms() - start) < ms);
      00880C                        169 00101$:
      00880C CD 87 BB         [ 4]  170 	call	_get_ms
      00880F 1F 07            [ 2]  171 	ldw	(0x07, sp), x
      008811 17 05            [ 2]  172 	ldw	(0x05, sp), y
      008813 1E 07            [ 2]  173 	ldw	x, (0x07, sp)
      008815 72 F0 03         [ 2]  174 	subw	x, (0x03, sp)
      008818 1F 0B            [ 2]  175 	ldw	(0x0b, sp), x
      00881A 7B 06            [ 1]  176 	ld	a, (0x06, sp)
      00881C 12 02            [ 1]  177 	sbc	a, (0x02, sp)
      00881E 6B 0A            [ 1]  178 	ld	(0x0a, sp), a
      008820 7B 05            [ 1]  179 	ld	a, (0x05, sp)
      008822 12 01            [ 1]  180 	sbc	a, (0x01, sp)
      008824 88               [ 1]  181 	push	a
      008825 1E 0C            [ 2]  182 	ldw	x, (0x0c, sp)
      008827 13 12            [ 2]  183 	cpw	x, (0x12, sp)
      008829 7B 0B            [ 1]  184 	ld	a, (0x0b, sp)
      00882B 12 11            [ 1]  185 	sbc	a, (0x11, sp)
      00882D 84               [ 1]  186 	pop	a
      00882E 12 0F            [ 1]  187 	sbc	a, (0x0f, sp)
      008830 25 DA            [ 1]  188 	jrc	00101$
                                    189 ;	../../my_STM8_libraries/stm8_TIME.c: 46: }
      008832 1E 0D            [ 2]  190 	ldw	x, (13, sp)
      008834 5B 12            [ 2]  191 	addw	sp, #18
      008836 FC               [ 2]  192 	jp	(x)
                                    193 	.area CODE
                                    194 	.area CONST
                                    195 	.area INITIALIZER
      008076                        196 __xinit___milsec:
      008076 00 00 00 00            197 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    198 	.area CABS (ABS)
