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
      00001B                         24 _memory_period:
      00001B                         25 	.ds 2
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
      00893C                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      00893C 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      008940 CF 00 1B         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      008943 9E               [ 1]   65 	ld	a, xh
      008944 C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      008947 9F               [ 1]   68 	ld	a, xl
      008948 C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      00894B C6 53 07         [ 1]   71 	ld	a, 0x5307
      00894E A4 8F            [ 1]   72 	and	a, #0x8f
      008950 C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      008953 C6 53 08         [ 1]   75 	ld	a, 0x5308
      008956 A4 8F            [ 1]   76 	and	a, #0x8f
      008958 C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      00895B C6 53 09         [ 1]   79 	ld	a, 0x5309
      00895E A4 8F            [ 1]   80 	and	a, #0x8f
      008960 C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      008963 C6 53 07         [ 1]   83 	ld	a, 0x5307
      008966 AA 60            [ 1]   84 	or	a, #0x60
      008968 C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      00896B C6 53 08         [ 1]   87 	ld	a, 0x5308
      00896E AA 60            [ 1]   88 	or	a, #0x60
      008970 C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      008973 C6 53 09         [ 1]   91 	ld	a, 0x5309
      008976 AA 60            [ 1]   92 	or	a, #0x60
      008978 C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      00897B 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      00897F 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      008983 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      008987 C6 53 07         [ 1]  101 	ld	a, 0x5307
      00898A A4 FC            [ 1]  102 	and	a, #0xfc
      00898C C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      00898F C6 53 08         [ 1]  105 	ld	a, 0x5308
      008992 A4 FC            [ 1]  106 	and	a, #0xfc
      008994 C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      008997 C6 53 09         [ 1]  109 	ld	a, 0x5309
      00899A A4 FC            [ 1]  110 	and	a, #0xfc
      00899C C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      00899F C6 53 00         [ 1]  113 	ld	a, 0x5300
      0089A2 AA 81            [ 1]  114 	or	a, #0x81
      0089A4 C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      0089A7 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      0089A8                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      0089A8 A1 01            [ 1]  124 	cp	a, #0x01
      0089AA 27 09            [ 1]  125 	jreq	00101$
      0089AC A1 02            [ 1]  126 	cp	a, #0x02
      0089AE 27 12            [ 1]  127 	jreq	00102$
      0089B0 A1 03            [ 1]  128 	cp	a, #0x03
      0089B2 27 1B            [ 1]  129 	jreq	00103$
      0089B4 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case PWM_CH1:		//PD4
      0089B5                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      0089B5 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      0089B9 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      0089BD 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      0089C1 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case PWM_CH2:		//PD3
      0089C2                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      0089C2 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      0089C6 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      0089CA 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      0089CE 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case PWM_CH3:		//PA3
      0089CF                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      0089CF 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      0089D3 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      0089D7 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      0089DB 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      0089DC                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      0089DC A1 01            [ 1]  168 	cp	a, #0x01
      0089DE 27 09            [ 1]  169 	jreq	00101$
      0089E0 A1 02            [ 1]  170 	cp	a, #0x02
      0089E2 27 0A            [ 1]  171 	jreq	00102$
      0089E4 A1 03            [ 1]  172 	cp	a, #0x03
      0089E6 27 0B            [ 1]  173 	jreq	00103$
      0089E8 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case PWM_CH1:		//PD4
      0089E9                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      0089E9 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      0089ED 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case PWM_CH2:		//PD3
      0089EE                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      0089EE 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      0089F2 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case PWM_CH3:		//PA3
      0089F3                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      0089F3 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      0089F7 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      0089F8                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0089F8 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      0089FA A1 01            [ 1]  202 	cp	a, #0x01
      0089FC 27 09            [ 1]  203 	jreq	00101$
      0089FE A1 02            [ 1]  204 	cp	a, #0x02
      008A00 27 10            [ 1]  205 	jreq	00102$
      008A02 A1 03            [ 1]  206 	cp	a, #0x03
      008A04 27 17            [ 1]  207 	jreq	00103$
      008A06 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case PWM_CH1:
      008A07                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      008A07 9E               [ 1]  212 	ld	a, xh
      008A08 C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008A0B AE 53 12         [ 2]  215 	ldw	x, #0x5312
      008A0E 90 9F            [ 1]  216 	ld	a, yl
      008A10 F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      008A11 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case PWM_CH2:
      008A12                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      008A12 9E               [ 1]  223 	ld	a, xh
      008A13 C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      008A16 AE 53 14         [ 2]  226 	ldw	x, #0x5314
      008A19 90 9F            [ 1]  227 	ld	a, yl
      008A1B F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      008A1C 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case PWM_CH3:
      008A1D                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      008A1D 9E               [ 1]  234 	ld	a, xh
      008A1E C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      008A21 AE 53 16         [ 2]  237 	ldw	x, #0x5316
      008A24 90 9F            [ 1]  238 	ld	a, yl
      008A26 F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      008A27 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      008A28                        247 _writePercent_PWM:
      008A28 52 09            [ 2]  248 	sub	sp, #9
      008A2A 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      008A2C 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      008A2E A1 64            [ 1]  252 	cp	a, #0x64
      008A30 23 04            [ 2]  253 	jrule	00102$
      008A32 A6 64            [ 1]  254 	ld	a, #0x64
      008A34 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      008A36                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      008A36 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      008A38 5F               [ 1]  259 	clrw	x
      008A39 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      008A3B 90 CE 00 1B      [ 2]  261 	ldw	y, _memory_period+0
      008A3F 0F 06            [ 1]  262 	clr	(0x06, sp)
      008A41 0F 05            [ 1]  263 	clr	(0x05, sp)
      008A43 90 89            [ 2]  264 	pushw	y
      008A45 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      008A47 90 89            [ 2]  266 	pushw	y
      008A49 88               [ 1]  267 	push	a
      008A4A 9E               [ 1]  268 	ld	a, xh
      008A4B 88               [ 1]  269 	push	a
      008A4C 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      008A4E 89               [ 2]  271 	pushw	x
      008A4F CD 8D 99         [ 4]  272 	call	__mullong
      008A52 5B 08            [ 2]  273 	addw	sp, #8
      008A54 4B 64            [ 1]  274 	push	#0x64
      008A56 4B 00            [ 1]  275 	push	#0x00
      008A58 4B 00            [ 1]  276 	push	#0x00
      008A5A 4B 00            [ 1]  277 	push	#0x00
      008A5C 89               [ 2]  278 	pushw	x
      008A5D 90 89            [ 2]  279 	pushw	y
      008A5F CD 8D 40         [ 4]  280 	call	__divulong
      008A62 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      008A64 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      008A66 16 0A            [ 2]  284 	ldw	y, (10, sp)
      008A68 17 0B            [ 2]  285 	ldw	(11, sp), y
      008A6A 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      008A6C CC 89 F8         [ 2]  288 	jp	_write_PWM
      008A6F 84               [ 1]  289 	pop	a
      008A70 FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      008059                        294 __xinit__memory_period:
      008059 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
