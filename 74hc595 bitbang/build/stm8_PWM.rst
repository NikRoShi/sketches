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
      0086C1                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      0086C1 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      0086C5 CF 00 01         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      0086C8 9E               [ 1]   65 	ld	a, xh
      0086C9 C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      0086CC 9F               [ 1]   68 	ld	a, xl
      0086CD C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      0086D0 C6 53 07         [ 1]   71 	ld	a, 0x5307
      0086D3 A4 8F            [ 1]   72 	and	a, #0x8f
      0086D5 C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      0086D8 C6 53 08         [ 1]   75 	ld	a, 0x5308
      0086DB A4 8F            [ 1]   76 	and	a, #0x8f
      0086DD C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      0086E0 C6 53 09         [ 1]   79 	ld	a, 0x5309
      0086E3 A4 8F            [ 1]   80 	and	a, #0x8f
      0086E5 C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      0086E8 C6 53 07         [ 1]   83 	ld	a, 0x5307
      0086EB AA 60            [ 1]   84 	or	a, #0x60
      0086ED C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      0086F0 C6 53 08         [ 1]   87 	ld	a, 0x5308
      0086F3 AA 60            [ 1]   88 	or	a, #0x60
      0086F5 C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      0086F8 C6 53 09         [ 1]   91 	ld	a, 0x5309
      0086FB AA 60            [ 1]   92 	or	a, #0x60
      0086FD C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      008700 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      008704 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      008708 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      00870C C6 53 07         [ 1]  101 	ld	a, 0x5307
      00870F A4 FC            [ 1]  102 	and	a, #0xfc
      008711 C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      008714 C6 53 08         [ 1]  105 	ld	a, 0x5308
      008717 A4 FC            [ 1]  106 	and	a, #0xfc
      008719 C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      00871C C6 53 09         [ 1]  109 	ld	a, 0x5309
      00871F A4 FC            [ 1]  110 	and	a, #0xfc
      008721 C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      008724 C6 53 00         [ 1]  113 	ld	a, 0x5300
      008727 AA 81            [ 1]  114 	or	a, #0x81
      008729 C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      00872C 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      00872D                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      00872D A1 01            [ 1]  124 	cp	a, #0x01
      00872F 27 09            [ 1]  125 	jreq	00101$
      008731 A1 02            [ 1]  126 	cp	a, #0x02
      008733 27 12            [ 1]  127 	jreq	00102$
      008735 A1 03            [ 1]  128 	cp	a, #0x03
      008737 27 1B            [ 1]  129 	jreq	00103$
      008739 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case PWM_CH1:		//PD4
      00873A                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      00873A 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      00873E 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      008742 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      008746 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case PWM_CH2:		//PD3
      008747                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      008747 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      00874B 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      00874F 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      008753 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case PWM_CH3:		//PA3
      008754                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      008754 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      008758 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      00875C 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      008760 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      008761                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      008761 A1 01            [ 1]  168 	cp	a, #0x01
      008763 27 09            [ 1]  169 	jreq	00101$
      008765 A1 02            [ 1]  170 	cp	a, #0x02
      008767 27 0A            [ 1]  171 	jreq	00102$
      008769 A1 03            [ 1]  172 	cp	a, #0x03
      00876B 27 0B            [ 1]  173 	jreq	00103$
      00876D 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case PWM_CH1:		//PD4
      00876E                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      00876E 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      008772 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case PWM_CH2:		//PD3
      008773                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      008773 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      008777 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case PWM_CH3:		//PA3
      008778                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      008778 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      00877C 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      00877D                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      00877D 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      00877F A1 01            [ 1]  202 	cp	a, #0x01
      008781 27 09            [ 1]  203 	jreq	00101$
      008783 A1 02            [ 1]  204 	cp	a, #0x02
      008785 27 10            [ 1]  205 	jreq	00102$
      008787 A1 03            [ 1]  206 	cp	a, #0x03
      008789 27 17            [ 1]  207 	jreq	00103$
      00878B 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case PWM_CH1:
      00878C                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      00878C 9E               [ 1]  212 	ld	a, xh
      00878D C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008790 AE 53 12         [ 2]  215 	ldw	x, #0x5312
      008793 90 9F            [ 1]  216 	ld	a, yl
      008795 F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      008796 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case PWM_CH2:
      008797                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      008797 9E               [ 1]  223 	ld	a, xh
      008798 C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      00879B AE 53 14         [ 2]  226 	ldw	x, #0x5314
      00879E 90 9F            [ 1]  227 	ld	a, yl
      0087A0 F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      0087A1 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case PWM_CH3:
      0087A2                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      0087A2 9E               [ 1]  234 	ld	a, xh
      0087A3 C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      0087A6 AE 53 16         [ 2]  237 	ldw	x, #0x5316
      0087A9 90 9F            [ 1]  238 	ld	a, yl
      0087AB F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      0087AC 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      0087AD                        247 _writePercent_PWM:
      0087AD 52 09            [ 2]  248 	sub	sp, #9
      0087AF 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      0087B1 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      0087B3 A1 64            [ 1]  252 	cp	a, #0x64
      0087B5 23 04            [ 2]  253 	jrule	00102$
      0087B7 A6 64            [ 1]  254 	ld	a, #0x64
      0087B9 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      0087BB                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      0087BB 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      0087BD 5F               [ 1]  259 	clrw	x
      0087BE 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      0087C0 90 CE 00 01      [ 2]  261 	ldw	y, _memory_period+0
      0087C4 0F 06            [ 1]  262 	clr	(0x06, sp)
      0087C6 0F 05            [ 1]  263 	clr	(0x05, sp)
      0087C8 90 89            [ 2]  264 	pushw	y
      0087CA 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      0087CC 90 89            [ 2]  266 	pushw	y
      0087CE 88               [ 1]  267 	push	a
      0087CF 9E               [ 1]  268 	ld	a, xh
      0087D0 88               [ 1]  269 	push	a
      0087D1 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      0087D3 89               [ 2]  271 	pushw	x
      0087D4 CD 8A 16         [ 4]  272 	call	__mullong
      0087D7 5B 08            [ 2]  273 	addw	sp, #8
      0087D9 4B 64            [ 1]  274 	push	#0x64
      0087DB 4B 00            [ 1]  275 	push	#0x00
      0087DD 4B 00            [ 1]  276 	push	#0x00
      0087DF 4B 00            [ 1]  277 	push	#0x00
      0087E1 89               [ 2]  278 	pushw	x
      0087E2 90 89            [ 2]  279 	pushw	y
      0087E4 CD 89 BD         [ 4]  280 	call	__divulong
      0087E7 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      0087E9 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      0087EB 16 0A            [ 2]  284 	ldw	y, (10, sp)
      0087ED 17 0B            [ 2]  285 	ldw	(11, sp), y
      0087EF 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      0087F1 CC 87 7D         [ 2]  288 	jp	_write_PWM
      0087F4 84               [ 1]  289 	pop	a
      0087F5 FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      008088                        294 __xinit__memory_period:
      008088 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
