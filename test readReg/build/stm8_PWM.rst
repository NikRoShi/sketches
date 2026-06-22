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
      008652                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      008652 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      008656 CF 00 01         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      008659 9E               [ 1]   65 	ld	a, xh
      00865A C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      00865D 9F               [ 1]   68 	ld	a, xl
      00865E C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      008661 C6 53 07         [ 1]   71 	ld	a, 0x5307
      008664 A4 8F            [ 1]   72 	and	a, #0x8f
      008666 C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      008669 C6 53 08         [ 1]   75 	ld	a, 0x5308
      00866C A4 8F            [ 1]   76 	and	a, #0x8f
      00866E C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      008671 C6 53 09         [ 1]   79 	ld	a, 0x5309
      008674 A4 8F            [ 1]   80 	and	a, #0x8f
      008676 C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      008679 C6 53 07         [ 1]   83 	ld	a, 0x5307
      00867C AA 60            [ 1]   84 	or	a, #0x60
      00867E C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      008681 C6 53 08         [ 1]   87 	ld	a, 0x5308
      008684 AA 60            [ 1]   88 	or	a, #0x60
      008686 C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      008689 C6 53 09         [ 1]   91 	ld	a, 0x5309
      00868C AA 60            [ 1]   92 	or	a, #0x60
      00868E C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      008691 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      008695 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      008699 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      00869D C6 53 07         [ 1]  101 	ld	a, 0x5307
      0086A0 A4 FC            [ 1]  102 	and	a, #0xfc
      0086A2 C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      0086A5 C6 53 08         [ 1]  105 	ld	a, 0x5308
      0086A8 A4 FC            [ 1]  106 	and	a, #0xfc
      0086AA C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      0086AD C6 53 09         [ 1]  109 	ld	a, 0x5309
      0086B0 A4 FC            [ 1]  110 	and	a, #0xfc
      0086B2 C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      0086B5 C6 53 00         [ 1]  113 	ld	a, 0x5300
      0086B8 AA 81            [ 1]  114 	or	a, #0x81
      0086BA C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      0086BD 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      0086BE                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      0086BE A1 01            [ 1]  124 	cp	a, #0x01
      0086C0 27 09            [ 1]  125 	jreq	00101$
      0086C2 A1 02            [ 1]  126 	cp	a, #0x02
      0086C4 27 12            [ 1]  127 	jreq	00102$
      0086C6 A1 03            [ 1]  128 	cp	a, #0x03
      0086C8 27 1B            [ 1]  129 	jreq	00103$
      0086CA 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case 1:		//PD4
      0086CB                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      0086CB 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      0086CF 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      0086D3 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      0086D7 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case 2:		//PD3
      0086D8                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      0086D8 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      0086DC 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      0086E0 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      0086E4 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case 3:		//PA3
      0086E5                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      0086E5 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      0086E9 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      0086ED 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      0086F1 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      0086F2                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      0086F2 A1 01            [ 1]  168 	cp	a, #0x01
      0086F4 27 09            [ 1]  169 	jreq	00101$
      0086F6 A1 02            [ 1]  170 	cp	a, #0x02
      0086F8 27 0A            [ 1]  171 	jreq	00102$
      0086FA A1 03            [ 1]  172 	cp	a, #0x03
      0086FC 27 0B            [ 1]  173 	jreq	00103$
      0086FE 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case 1:		//PD4
      0086FF                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      0086FF 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      008703 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case 2:		//PD3
      008704                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      008704 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      008708 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case 3:		//PA3
      008709                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      008709 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      00870D 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      00870E                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      00870E 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      008710 A1 01            [ 1]  202 	cp	a, #0x01
      008712 27 09            [ 1]  203 	jreq	00101$
      008714 A1 02            [ 1]  204 	cp	a, #0x02
      008716 27 10            [ 1]  205 	jreq	00102$
      008718 A1 03            [ 1]  206 	cp	a, #0x03
      00871A 27 17            [ 1]  207 	jreq	00103$
      00871C 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case 1:
      00871D                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      00871D 9E               [ 1]  212 	ld	a, xh
      00871E C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008721 AE 53 12         [ 2]  215 	ldw	x, #0x5312
      008724 90 9F            [ 1]  216 	ld	a, yl
      008726 F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      008727 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case 2:
      008728                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      008728 9E               [ 1]  223 	ld	a, xh
      008729 C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      00872C AE 53 14         [ 2]  226 	ldw	x, #0x5314
      00872F 90 9F            [ 1]  227 	ld	a, yl
      008731 F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      008732 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case 3:
      008733                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      008733 9E               [ 1]  234 	ld	a, xh
      008734 C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      008737 AE 53 16         [ 2]  237 	ldw	x, #0x5316
      00873A 90 9F            [ 1]  238 	ld	a, yl
      00873C F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      00873D 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      00873E                        247 _writePercent_PWM:
      00873E 52 09            [ 2]  248 	sub	sp, #9
      008740 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      008742 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      008744 A1 64            [ 1]  252 	cp	a, #0x64
      008746 23 04            [ 2]  253 	jrule	00102$
      008748 A6 64            [ 1]  254 	ld	a, #0x64
      00874A 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      00874C                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      00874C 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      00874E 5F               [ 1]  259 	clrw	x
      00874F 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      008751 90 CE 00 01      [ 2]  261 	ldw	y, _memory_period+0
      008755 0F 06            [ 1]  262 	clr	(0x06, sp)
      008757 0F 05            [ 1]  263 	clr	(0x05, sp)
      008759 90 89            [ 2]  264 	pushw	y
      00875B 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      00875D 90 89            [ 2]  266 	pushw	y
      00875F 88               [ 1]  267 	push	a
      008760 9E               [ 1]  268 	ld	a, xh
      008761 88               [ 1]  269 	push	a
      008762 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      008764 89               [ 2]  271 	pushw	x
      008765 CD 89 A7         [ 4]  272 	call	__mullong
      008768 5B 08            [ 2]  273 	addw	sp, #8
      00876A 4B 64            [ 1]  274 	push	#0x64
      00876C 4B 00            [ 1]  275 	push	#0x00
      00876E 4B 00            [ 1]  276 	push	#0x00
      008770 4B 00            [ 1]  277 	push	#0x00
      008772 89               [ 2]  278 	pushw	x
      008773 90 89            [ 2]  279 	pushw	y
      008775 CD 89 4E         [ 4]  280 	call	__divulong
      008778 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      00877A 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      00877C 16 0A            [ 2]  284 	ldw	y, (10, sp)
      00877E 17 0B            [ 2]  285 	ldw	(11, sp), y
      008780 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      008782 CC 87 0E         [ 2]  288 	jp	_write_PWM
      008785 84               [ 1]  289 	pop	a
      008786 FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      008074                        294 __xinit__memory_period:
      008074 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
