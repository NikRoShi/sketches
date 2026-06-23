                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_PWM
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_PWM
                                     12 	.globl _startChannel_PWM
                                     13 	.globl _stopChannel_PWM
                                     14 	.globl _write_PWM
                                     15 	.globl _writePercent_PWM
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
      000001                         24 _memory_period:
      000001                         25 	.ds 2
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
                                     55 ;	../../my_STM8_libraries/stm8_PWM.c: 5: void init_PWM(uint16_t period) {	// period = Fmaster / Fpwm (для удобства лучше использовать 1023)
                                     56 ;	-----------------------------------------
                                     57 ;	 function init_PWM
                                     58 ;	-----------------------------------------
      008618                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      008618 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      00861C CF 00 01         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      00861F 9E               [ 1]   65 	ld	a, xh
      008620 C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      008623 9F               [ 1]   68 	ld	a, xl
      008624 C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      008627 C6 53 07         [ 1]   71 	ld	a, 0x5307
      00862A A4 8F            [ 1]   72 	and	a, #0x8f
      00862C C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      00862F C6 53 08         [ 1]   75 	ld	a, 0x5308
      008632 A4 8F            [ 1]   76 	and	a, #0x8f
      008634 C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      008637 C6 53 09         [ 1]   79 	ld	a, 0x5309
      00863A A4 8F            [ 1]   80 	and	a, #0x8f
      00863C C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      00863F C6 53 07         [ 1]   83 	ld	a, 0x5307
      008642 AA 60            [ 1]   84 	or	a, #0x60
      008644 C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      008647 C6 53 08         [ 1]   87 	ld	a, 0x5308
      00864A AA 60            [ 1]   88 	or	a, #0x60
      00864C C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      00864F C6 53 09         [ 1]   91 	ld	a, 0x5309
      008652 AA 60            [ 1]   92 	or	a, #0x60
      008654 C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      008657 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      00865B 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      00865F 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      008663 C6 53 07         [ 1]  101 	ld	a, 0x5307
      008666 A4 FC            [ 1]  102 	and	a, #0xfc
      008668 C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      00866B C6 53 08         [ 1]  105 	ld	a, 0x5308
      00866E A4 FC            [ 1]  106 	and	a, #0xfc
      008670 C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      008673 C6 53 09         [ 1]  109 	ld	a, 0x5309
      008676 A4 FC            [ 1]  110 	and	a, #0xfc
      008678 C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      00867B C6 53 00         [ 1]  113 	ld	a, 0x5300
      00867E AA 81            [ 1]  114 	or	a, #0x81
      008680 C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      008683 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      008684                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      008684 A1 01            [ 1]  124 	cp	a, #0x01
      008686 27 09            [ 1]  125 	jreq	00101$
      008688 A1 02            [ 1]  126 	cp	a, #0x02
      00868A 27 12            [ 1]  127 	jreq	00102$
      00868C A1 03            [ 1]  128 	cp	a, #0x03
      00868E 27 1B            [ 1]  129 	jreq	00103$
      008690 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case 1:		//PD4
      008691                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      008691 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      008695 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      008699 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      00869D 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case 2:		//PD3
      00869E                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      00869E 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      0086A2 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      0086A6 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      0086AA 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case 3:		//PA3
      0086AB                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      0086AB 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      0086AF 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      0086B3 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      0086B7 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      0086B8                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      0086B8 A1 01            [ 1]  168 	cp	a, #0x01
      0086BA 27 09            [ 1]  169 	jreq	00101$
      0086BC A1 02            [ 1]  170 	cp	a, #0x02
      0086BE 27 0A            [ 1]  171 	jreq	00102$
      0086C0 A1 03            [ 1]  172 	cp	a, #0x03
      0086C2 27 0B            [ 1]  173 	jreq	00103$
      0086C4 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case 1:		//PD4
      0086C5                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      0086C5 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      0086C9 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case 2:		//PD3
      0086CA                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      0086CA 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      0086CE 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case 3:		//PA3
      0086CF                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      0086CF 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      0086D3 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      0086D4                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0086D4 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      0086D6 A1 01            [ 1]  202 	cp	a, #0x01
      0086D8 27 09            [ 1]  203 	jreq	00101$
      0086DA A1 02            [ 1]  204 	cp	a, #0x02
      0086DC 27 10            [ 1]  205 	jreq	00102$
      0086DE A1 03            [ 1]  206 	cp	a, #0x03
      0086E0 27 17            [ 1]  207 	jreq	00103$
      0086E2 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case 1:
      0086E3                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      0086E3 9E               [ 1]  212 	ld	a, xh
      0086E4 C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0086E7 AE 53 12         [ 2]  215 	ldw	x, #0x5312
      0086EA 90 9F            [ 1]  216 	ld	a, yl
      0086EC F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      0086ED 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case 2:
      0086EE                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      0086EE 9E               [ 1]  223 	ld	a, xh
      0086EF C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      0086F2 AE 53 14         [ 2]  226 	ldw	x, #0x5314
      0086F5 90 9F            [ 1]  227 	ld	a, yl
      0086F7 F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      0086F8 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case 3:
      0086F9                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      0086F9 9E               [ 1]  234 	ld	a, xh
      0086FA C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      0086FD AE 53 16         [ 2]  237 	ldw	x, #0x5316
      008700 90 9F            [ 1]  238 	ld	a, yl
      008702 F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      008703 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      008704                        247 _writePercent_PWM:
      008704 52 09            [ 2]  248 	sub	sp, #9
      008706 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      008708 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      00870A A1 64            [ 1]  252 	cp	a, #0x64
      00870C 23 04            [ 2]  253 	jrule	00102$
      00870E A6 64            [ 1]  254 	ld	a, #0x64
      008710 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      008712                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      008712 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      008714 5F               [ 1]  259 	clrw	x
      008715 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      008717 90 CE 00 01      [ 2]  261 	ldw	y, _memory_period+0
      00871B 0F 06            [ 1]  262 	clr	(0x06, sp)
      00871D 0F 05            [ 1]  263 	clr	(0x05, sp)
      00871F 90 89            [ 2]  264 	pushw	y
      008721 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      008723 90 89            [ 2]  266 	pushw	y
      008725 88               [ 1]  267 	push	a
      008726 9E               [ 1]  268 	ld	a, xh
      008727 88               [ 1]  269 	push	a
      008728 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      00872A 89               [ 2]  271 	pushw	x
      00872B CD 89 6D         [ 4]  272 	call	__mullong
      00872E 5B 08            [ 2]  273 	addw	sp, #8
      008730 4B 64            [ 1]  274 	push	#0x64
      008732 4B 00            [ 1]  275 	push	#0x00
      008734 4B 00            [ 1]  276 	push	#0x00
      008736 4B 00            [ 1]  277 	push	#0x00
      008738 89               [ 2]  278 	pushw	x
      008739 90 89            [ 2]  279 	pushw	y
      00873B CD 89 14         [ 4]  280 	call	__divulong
      00873E 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      008740 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      008742 16 0A            [ 2]  284 	ldw	y, (10, sp)
      008744 17 0B            [ 2]  285 	ldw	(11, sp), y
      008746 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      008748 CC 86 D4         [ 2]  288 	jp	_write_PWM
      00874B 84               [ 1]  289 	pop	a
      00874C FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      008088                        294 __xinit__memory_period:
      008088 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
