                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_TIME
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _tick_TIME
                                     11 	.globl _init_TIME
                                     12 	.globl _get_milsec
                                     13 	.globl _get_micsec
                                     14 	.globl _delay
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
      000003                         23 __milsec:
      000003                         24 	.ds 4
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	../../libs/stm8_TIME.c: 5: void tick_TIME(void) {
                                     55 ;	-----------------------------------------
                                     56 ;	 function tick_TIME
                                     57 ;	-----------------------------------------
      0084EF                         58 _tick_TIME:
                                     59 ;	../../libs/stm8_TIME.c: 6: _milsec++;
      0084EF CE 00 05         [ 2]   60 	ldw	x, __milsec+2
      0084F2 90 CE 00 03      [ 2]   61 	ldw	y, __milsec+0
      0084F6 5C               [ 1]   62 	incw	x
      0084F7 26 02            [ 1]   63 	jrne	00103$
      0084F9 90 5C            [ 1]   64 	incw	y
      0084FB                         65 00103$:
      0084FB CF 00 05         [ 2]   66 	ldw	__milsec+2, x
      0084FE 90 CF 00 03      [ 2]   67 	ldw	__milsec+0, y
                                     68 ;	../../libs/stm8_TIME.c: 7: }
      008502 81               [ 4]   69 	ret
                                     70 ;	../../libs/stm8_TIME.c: 9: void init_TIME(void) {
                                     71 ;	-----------------------------------------
                                     72 ;	 function init_TIME
                                     73 ;	-----------------------------------------
      008503                         74 _init_TIME:
                                     75 ;	../../libs/stm8_TIME.c: 10: _milsec = 0;
      008503 5F               [ 1]   76 	clrw	x
      008504 CF 00 05         [ 2]   77 	ldw	__milsec+2, x
      008507 CF 00 03         [ 2]   78 	ldw	__milsec+0, x
                                     79 ;	../../libs/stm8_TIME.c: 11: TIM4_CR1 = 0;
      00850A 35 00 53 40      [ 1]   80 	mov	0x5340+0, #0x00
                                     81 ;	../../libs/stm8_TIME.c: 12: TIM4_PSCR = 0x07;
      00850E 35 07 53 47      [ 1]   82 	mov	0x5347+0, #0x07
                                     83 ;	../../libs/stm8_TIME.c: 13: TIM4_ARR  = 124;
      008512 35 7C 53 48      [ 1]   84 	mov	0x5348+0, #0x7c
                                     85 ;	../../libs/stm8_TIME.c: 14: TIM4_IER |= 0x01;
      008516 72 10 53 43      [ 1]   86 	bset	0x5343, #0
                                     87 ;	../../libs/stm8_TIME.c: 15: TIM4_CR1 |= (1 << 0);
      00851A 72 10 53 40      [ 1]   88 	bset	0x5340, #0
                                     89 ;	../../libs/stm8_TIME.c: 16: TIM4_SR = 0;
      00851E 35 00 53 44      [ 1]   90 	mov	0x5344+0, #0x00
                                     91 ;	../../libs/stm8_TIME.c: 17: }
      008522 81               [ 4]   92 	ret
                                     93 ;	../../libs/stm8_TIME.c: 19: uint32_t get_milsec(void) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function get_milsec
                                     96 ;	-----------------------------------------
      008523                         97 _get_milsec:
                                     98 ;	../../libs/stm8_TIME.c: 22: disableInterrupts();
      008523 9B               [ 1]   99 	sim
                                    100 ;	../../libs/stm8_TIME.c: 23: ms = _milsec;
      008524 CE 00 05         [ 2]  101 	ldw	x, __milsec+2
      008527 90 CE 00 03      [ 2]  102 	ldw	y, __milsec+0
                                    103 ;	../../libs/stm8_TIME.c: 24: enableInterrupts();
      00852B 9A               [ 1]  104 	rim
                                    105 ;	../../libs/stm8_TIME.c: 26: return ms;
                                    106 ;	../../libs/stm8_TIME.c: 27: }
      00852C 81               [ 4]  107 	ret
                                    108 ;	../../libs/stm8_TIME.c: 30: uint32_t get_micsec(void) {
                                    109 ;	-----------------------------------------
                                    110 ;	 function get_micsec
                                    111 ;	-----------------------------------------
      00852D                        112 _get_micsec:
      00852D 52 05            [ 2]  113 	sub	sp, #5
                                    114 ;	../../libs/stm8_TIME.c: 34: disableInterrupts();
      00852F 9B               [ 1]  115 	sim
                                    116 ;	../../libs/stm8_TIME.c: 35: ms = _milsec;
      008530 CE 00 05         [ 2]  117 	ldw	x, __milsec+2
      008533 90 CE 00 03      [ 2]  118 	ldw	y, __milsec+0
                                    119 ;	../../libs/stm8_TIME.c: 36: ticks = TIM4_CNTR; // Текущее значение счетчика (0-124)
      008537 C6 53 46         [ 1]  120 	ld	a, 0x5346
      00853A 6B 01            [ 1]  121 	ld	(0x01, sp), a
                                    122 ;	../../libs/stm8_TIME.c: 37: enableInterrupts();
      00853C 9A               [ 1]  123 	rim
                                    124 ;	../../libs/stm8_TIME.c: 39: return (ms * 1000) + (uint32_t)(ticks * 8);
      00853D 89               [ 2]  125 	pushw	x
      00853E 90 89            [ 2]  126 	pushw	y
      008540 4B E8            [ 1]  127 	push	#0xe8
      008542 4B 03            [ 1]  128 	push	#0x03
      008544 5F               [ 1]  129 	clrw	x
      008545 89               [ 2]  130 	pushw	x
      008546 CD 86 E6         [ 4]  131 	call	__mullong
      008549 5B 08            [ 2]  132 	addw	sp, #8
      00854B 1F 04            [ 2]  133 	ldw	(0x04, sp), x
      00854D 17 02            [ 2]  134 	ldw	(0x02, sp), y
      00854F 5F               [ 1]  135 	clrw	x
      008550 7B 01            [ 1]  136 	ld	a, (0x01, sp)
      008552 97               [ 1]  137 	ld	xl, a
      008553 58               [ 2]  138 	sllw	x
      008554 58               [ 2]  139 	sllw	x
      008555 58               [ 2]  140 	sllw	x
      008556 51               [ 1]  141 	exgw	x, y
      008557 5F               [ 1]  142 	clrw	x
      008558 90 5D            [ 2]  143 	tnzw	y
      00855A 2A 01            [ 1]  144 	jrpl	00103$
      00855C 5A               [ 2]  145 	decw	x
      00855D                        146 00103$:
      00855D 72 F9 04         [ 2]  147 	addw	y, (0x04, sp)
      008560 4F               [ 1]  148 	clr	a
      008561 19 03            [ 1]  149 	adc	a, (0x03, sp)
      008563 97               [ 1]  150 	ld	xl, a
      008564 4F               [ 1]  151 	clr	a
      008565 19 02            [ 1]  152 	adc	a, (0x02, sp)
      008567 95               [ 1]  153 	ld	xh, a
      008568 51               [ 1]  154 	exgw	x, y
                                    155 ;	../../libs/stm8_TIME.c: 40: }
      008569 5B 05            [ 2]  156 	addw	sp, #5
      00856B 81               [ 4]  157 	ret
                                    158 ;	../../libs/stm8_TIME.c: 43: void delay(uint32_t ms) {
                                    159 ;	-----------------------------------------
                                    160 ;	 function delay
                                    161 ;	-----------------------------------------
      00856C                        162 _delay:
      00856C 52 0C            [ 2]  163 	sub	sp, #12
                                    164 ;	../../libs/stm8_TIME.c: 44: uint32_t start = get_milsec();
      00856E CD 85 23         [ 4]  165 	call	_get_milsec
      008571 1F 03            [ 2]  166 	ldw	(0x03, sp), x
      008573 17 01            [ 2]  167 	ldw	(0x01, sp), y
                                    168 ;	../../libs/stm8_TIME.c: 45: while ((get_milsec() - start) < ms);
      008575                        169 00101$:
      008575 CD 85 23         [ 4]  170 	call	_get_milsec
      008578 1F 07            [ 2]  171 	ldw	(0x07, sp), x
      00857A 17 05            [ 2]  172 	ldw	(0x05, sp), y
      00857C 1E 07            [ 2]  173 	ldw	x, (0x07, sp)
      00857E 72 F0 03         [ 2]  174 	subw	x, (0x03, sp)
      008581 1F 0B            [ 2]  175 	ldw	(0x0b, sp), x
      008583 7B 06            [ 1]  176 	ld	a, (0x06, sp)
      008585 12 02            [ 1]  177 	sbc	a, (0x02, sp)
      008587 6B 0A            [ 1]  178 	ld	(0x0a, sp), a
      008589 7B 05            [ 1]  179 	ld	a, (0x05, sp)
      00858B 12 01            [ 1]  180 	sbc	a, (0x01, sp)
      00858D 88               [ 1]  181 	push	a
      00858E 1E 0C            [ 2]  182 	ldw	x, (0x0c, sp)
      008590 13 12            [ 2]  183 	cpw	x, (0x12, sp)
      008592 7B 0B            [ 1]  184 	ld	a, (0x0b, sp)
      008594 12 11            [ 1]  185 	sbc	a, (0x11, sp)
      008596 84               [ 1]  186 	pop	a
      008597 12 0F            [ 1]  187 	sbc	a, (0x0f, sp)
      008599 25 DA            [ 1]  188 	jrc	00101$
                                    189 ;	../../libs/stm8_TIME.c: 46: }
      00859B 1E 0D            [ 2]  190 	ldw	x, (13, sp)
      00859D 5B 12            [ 2]  191 	addw	sp, #18
      00859F FC               [ 2]  192 	jp	(x)
                                    193 	.area CODE
                                    194 	.area CONST
                                    195 	.area INITIALIZER
      0080B3                        196 __xinit___milsec:
      0080B3 00 00 00 00            197 	.byte #0x00, #0x00, #0x00, #0x00	; 0
                                    198 	.area CABS (ABS)
