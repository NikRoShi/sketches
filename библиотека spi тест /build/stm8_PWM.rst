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
      008634                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      008634 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      008638 CF 00 01         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      00863B 9E               [ 1]   65 	ld	a, xh
      00863C C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      00863F 9F               [ 1]   68 	ld	a, xl
      008640 C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      008643 C6 53 07         [ 1]   71 	ld	a, 0x5307
      008646 A4 8F            [ 1]   72 	and	a, #0x8f
      008648 C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      00864B C6 53 08         [ 1]   75 	ld	a, 0x5308
      00864E A4 8F            [ 1]   76 	and	a, #0x8f
      008650 C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      008653 C6 53 09         [ 1]   79 	ld	a, 0x5309
      008656 A4 8F            [ 1]   80 	and	a, #0x8f
      008658 C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      00865B C6 53 07         [ 1]   83 	ld	a, 0x5307
      00865E AA 60            [ 1]   84 	or	a, #0x60
      008660 C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      008663 C6 53 08         [ 1]   87 	ld	a, 0x5308
      008666 AA 60            [ 1]   88 	or	a, #0x60
      008668 C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      00866B C6 53 09         [ 1]   91 	ld	a, 0x5309
      00866E AA 60            [ 1]   92 	or	a, #0x60
      008670 C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      008673 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      008677 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      00867B 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      00867F C6 53 07         [ 1]  101 	ld	a, 0x5307
      008682 A4 FC            [ 1]  102 	and	a, #0xfc
      008684 C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      008687 C6 53 08         [ 1]  105 	ld	a, 0x5308
      00868A A4 FC            [ 1]  106 	and	a, #0xfc
      00868C C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      00868F C6 53 09         [ 1]  109 	ld	a, 0x5309
      008692 A4 FC            [ 1]  110 	and	a, #0xfc
      008694 C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      008697 C6 53 00         [ 1]  113 	ld	a, 0x5300
      00869A AA 81            [ 1]  114 	or	a, #0x81
      00869C C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      00869F 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      0086A0                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      0086A0 A1 01            [ 1]  124 	cp	a, #0x01
      0086A2 27 09            [ 1]  125 	jreq	00101$
      0086A4 A1 02            [ 1]  126 	cp	a, #0x02
      0086A6 27 12            [ 1]  127 	jreq	00102$
      0086A8 A1 03            [ 1]  128 	cp	a, #0x03
      0086AA 27 1B            [ 1]  129 	jreq	00103$
      0086AC 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case PWM_CH1:		//PD4
      0086AD                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      0086AD 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      0086B1 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      0086B5 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      0086B9 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case PWM_CH2:		//PD3
      0086BA                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      0086BA 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      0086BE 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      0086C2 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      0086C6 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case PWM_CH3:		//PA3
      0086C7                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      0086C7 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      0086CB 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      0086CF 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      0086D3 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      0086D4                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      0086D4 A1 01            [ 1]  168 	cp	a, #0x01
      0086D6 27 09            [ 1]  169 	jreq	00101$
      0086D8 A1 02            [ 1]  170 	cp	a, #0x02
      0086DA 27 0A            [ 1]  171 	jreq	00102$
      0086DC A1 03            [ 1]  172 	cp	a, #0x03
      0086DE 27 0B            [ 1]  173 	jreq	00103$
      0086E0 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case PWM_CH1:		//PD4
      0086E1                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      0086E1 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      0086E5 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case PWM_CH2:		//PD3
      0086E6                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      0086E6 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      0086EA 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case PWM_CH3:		//PA3
      0086EB                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      0086EB 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      0086EF 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      0086F0                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0086F0 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      0086F2 A1 01            [ 1]  202 	cp	a, #0x01
      0086F4 27 09            [ 1]  203 	jreq	00101$
      0086F6 A1 02            [ 1]  204 	cp	a, #0x02
      0086F8 27 10            [ 1]  205 	jreq	00102$
      0086FA A1 03            [ 1]  206 	cp	a, #0x03
      0086FC 27 17            [ 1]  207 	jreq	00103$
      0086FE 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case PWM_CH1:
      0086FF                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      0086FF 9E               [ 1]  212 	ld	a, xh
      008700 C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008703 AE 53 12         [ 2]  215 	ldw	x, #0x5312
      008706 90 9F            [ 1]  216 	ld	a, yl
      008708 F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      008709 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case PWM_CH2:
      00870A                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      00870A 9E               [ 1]  223 	ld	a, xh
      00870B C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      00870E AE 53 14         [ 2]  226 	ldw	x, #0x5314
      008711 90 9F            [ 1]  227 	ld	a, yl
      008713 F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      008714 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case PWM_CH3:
      008715                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      008715 9E               [ 1]  234 	ld	a, xh
      008716 C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      008719 AE 53 16         [ 2]  237 	ldw	x, #0x5316
      00871C 90 9F            [ 1]  238 	ld	a, yl
      00871E F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      00871F 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      008720                        247 _writePercent_PWM:
      008720 52 09            [ 2]  248 	sub	sp, #9
      008722 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      008724 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      008726 A1 64            [ 1]  252 	cp	a, #0x64
      008728 23 04            [ 2]  253 	jrule	00102$
      00872A A6 64            [ 1]  254 	ld	a, #0x64
      00872C 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      00872E                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      00872E 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      008730 5F               [ 1]  259 	clrw	x
      008731 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      008733 90 CE 00 01      [ 2]  261 	ldw	y, _memory_period+0
      008737 0F 06            [ 1]  262 	clr	(0x06, sp)
      008739 0F 05            [ 1]  263 	clr	(0x05, sp)
      00873B 90 89            [ 2]  264 	pushw	y
      00873D 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      00873F 90 89            [ 2]  266 	pushw	y
      008741 88               [ 1]  267 	push	a
      008742 9E               [ 1]  268 	ld	a, xh
      008743 88               [ 1]  269 	push	a
      008744 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      008746 89               [ 2]  271 	pushw	x
      008747 CD 8A 0F         [ 4]  272 	call	__mullong
      00874A 5B 08            [ 2]  273 	addw	sp, #8
      00874C 4B 64            [ 1]  274 	push	#0x64
      00874E 4B 00            [ 1]  275 	push	#0x00
      008750 4B 00            [ 1]  276 	push	#0x00
      008752 4B 00            [ 1]  277 	push	#0x00
      008754 89               [ 2]  278 	pushw	x
      008755 90 89            [ 2]  279 	pushw	y
      008757 CD 89 B6         [ 4]  280 	call	__divulong
      00875A 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      00875C 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      00875E 16 0A            [ 2]  284 	ldw	y, (10, sp)
      008760 17 0B            [ 2]  285 	ldw	(11, sp), y
      008762 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      008764 CC 86 F0         [ 2]  288 	jp	_write_PWM
      008767 84               [ 1]  289 	pop	a
      008768 FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      008088                        294 __xinit__memory_period:
      008088 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
