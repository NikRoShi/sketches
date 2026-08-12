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
      00000D                         24 _memory_period:
      00000D                         25 	.ds 2
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
      0086EF                         59 _init_PWM:
                                     60 ;	../../my_STM8_libraries/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      0086EF 72 1A 50 C7      [ 1]   61 	bset	0x50c7, #5
                                     62 ;	../../my_STM8_libraries/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      0086F3 CF 00 0D         [ 2]   63 	ldw	_memory_period+0, x
                                     64 ;	../../my_STM8_libraries/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      0086F6 9E               [ 1]   65 	ld	a, xh
      0086F7 C7 53 0F         [ 1]   66 	ld	0x530f, a
                                     67 ;	../../my_STM8_libraries/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      0086FA 9F               [ 1]   68 	ld	a, xl
      0086FB C7 53 10         [ 1]   69 	ld	0x5310, a
                                     70 ;	../../my_STM8_libraries/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      0086FE C6 53 07         [ 1]   71 	ld	a, 0x5307
      008701 A4 8F            [ 1]   72 	and	a, #0x8f
      008703 C7 53 07         [ 1]   73 	ld	0x5307, a
                                     74 ;	../../my_STM8_libraries/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      008706 C6 53 08         [ 1]   75 	ld	a, 0x5308
      008709 A4 8F            [ 1]   76 	and	a, #0x8f
      00870B C7 53 08         [ 1]   77 	ld	0x5308, a
                                     78 ;	../../my_STM8_libraries/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      00870E C6 53 09         [ 1]   79 	ld	a, 0x5309
      008711 A4 8F            [ 1]   80 	and	a, #0x8f
      008713 C7 53 09         [ 1]   81 	ld	0x5309, a
                                     82 ;	../../my_STM8_libraries/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      008716 C6 53 07         [ 1]   83 	ld	a, 0x5307
      008719 AA 60            [ 1]   84 	or	a, #0x60
      00871B C7 53 07         [ 1]   85 	ld	0x5307, a
                                     86 ;	../../my_STM8_libraries/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      00871E C6 53 08         [ 1]   87 	ld	a, 0x5308
      008721 AA 60            [ 1]   88 	or	a, #0x60
      008723 C7 53 08         [ 1]   89 	ld	0x5308, a
                                     90 ;	../../my_STM8_libraries/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      008726 C6 53 09         [ 1]   91 	ld	a, 0x5309
      008729 AA 60            [ 1]   92 	or	a, #0x60
      00872B C7 53 09         [ 1]   93 	ld	0x5309, a
                                     94 ;	../../my_STM8_libraries/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      00872E 72 16 53 07      [ 1]   95 	bset	0x5307, #3
                                     96 ;	../../my_STM8_libraries/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      008732 72 16 53 08      [ 1]   97 	bset	0x5308, #3
                                     98 ;	../../my_STM8_libraries/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      008736 72 16 53 09      [ 1]   99 	bset	0x5309, #3
                                    100 ;	../../my_STM8_libraries/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      00873A C6 53 07         [ 1]  101 	ld	a, 0x5307
      00873D A4 FC            [ 1]  102 	and	a, #0xfc
      00873F C7 53 07         [ 1]  103 	ld	0x5307, a
                                    104 ;	../../my_STM8_libraries/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      008742 C6 53 08         [ 1]  105 	ld	a, 0x5308
      008745 A4 FC            [ 1]  106 	and	a, #0xfc
      008747 C7 53 08         [ 1]  107 	ld	0x5308, a
                                    108 ;	../../my_STM8_libraries/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      00874A C6 53 09         [ 1]  109 	ld	a, 0x5309
      00874D A4 FC            [ 1]  110 	and	a, #0xfc
      00874F C7 53 09         [ 1]  111 	ld	0x5309, a
                                    112 ;	../../my_STM8_libraries/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      008752 C6 53 00         [ 1]  113 	ld	a, 0x5300
      008755 AA 81            [ 1]  114 	or	a, #0x81
      008757 C7 53 00         [ 1]  115 	ld	0x5300, a
                                    116 ;	../../my_STM8_libraries/stm8_PWM.c: 30: }
      00875A 81               [ 4]  117 	ret
                                    118 ;	../../my_STM8_libraries/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    119 ;	-----------------------------------------
                                    120 ;	 function startChannel_PWM
                                    121 ;	-----------------------------------------
      00875B                        122 _startChannel_PWM:
                                    123 ;	../../my_STM8_libraries/stm8_PWM.c: 33: switch (channel) {
      00875B A1 01            [ 1]  124 	cp	a, #0x01
      00875D 27 09            [ 1]  125 	jreq	00101$
      00875F A1 02            [ 1]  126 	cp	a, #0x02
      008761 27 12            [ 1]  127 	jreq	00102$
      008763 A1 03            [ 1]  128 	cp	a, #0x03
      008765 27 1B            [ 1]  129 	jreq	00103$
      008767 81               [ 4]  130 	ret
                                    131 ;	../../my_STM8_libraries/stm8_PWM.c: 34: case PWM_CH1:		//PD4
      008768                        132 00101$:
                                    133 ;	../../my_STM8_libraries/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      008768 72 18 50 11      [ 1]  134 	bset	0x5011, #4
                                    135 ;	../../my_STM8_libraries/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      00876C 72 18 50 12      [ 1]  136 	bset	0x5012, #4
                                    137 ;	../../my_STM8_libraries/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      008770 72 10 53 0A      [ 1]  138 	bset	0x530a, #0
                                    139 ;	../../my_STM8_libraries/stm8_PWM.c: 38: break;
      008774 81               [ 4]  140 	ret
                                    141 ;	../../my_STM8_libraries/stm8_PWM.c: 39: case PWM_CH2:		//PD3
      008775                        142 00102$:
                                    143 ;	../../my_STM8_libraries/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      008775 72 16 50 11      [ 1]  144 	bset	0x5011, #3
                                    145 ;	../../my_STM8_libraries/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      008779 72 16 50 12      [ 1]  146 	bset	0x5012, #3
                                    147 ;	../../my_STM8_libraries/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      00877D 72 18 53 0A      [ 1]  148 	bset	0x530a, #4
                                    149 ;	../../my_STM8_libraries/stm8_PWM.c: 43: break;
      008781 81               [ 4]  150 	ret
                                    151 ;	../../my_STM8_libraries/stm8_PWM.c: 44: case PWM_CH3:		//PA3
      008782                        152 00103$:
                                    153 ;	../../my_STM8_libraries/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      008782 72 16 50 02      [ 1]  154 	bset	0x5002, #3
                                    155 ;	../../my_STM8_libraries/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      008786 72 16 50 03      [ 1]  156 	bset	0x5003, #3
                                    157 ;	../../my_STM8_libraries/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      00878A 72 10 53 0B      [ 1]  158 	bset	0x530b, #0
                                    159 ;	../../my_STM8_libraries/stm8_PWM.c: 50: }
                                    160 ;	../../my_STM8_libraries/stm8_PWM.c: 51: }
      00878E 81               [ 4]  161 	ret
                                    162 ;	../../my_STM8_libraries/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    163 ;	-----------------------------------------
                                    164 ;	 function stopChannel_PWM
                                    165 ;	-----------------------------------------
      00878F                        166 _stopChannel_PWM:
                                    167 ;	../../my_STM8_libraries/stm8_PWM.c: 54: switch (channel) {
      00878F A1 01            [ 1]  168 	cp	a, #0x01
      008791 27 09            [ 1]  169 	jreq	00101$
      008793 A1 02            [ 1]  170 	cp	a, #0x02
      008795 27 0A            [ 1]  171 	jreq	00102$
      008797 A1 03            [ 1]  172 	cp	a, #0x03
      008799 27 0B            [ 1]  173 	jreq	00103$
      00879B 81               [ 4]  174 	ret
                                    175 ;	../../my_STM8_libraries/stm8_PWM.c: 55: case PWM_CH1:		//PD4
      00879C                        176 00101$:
                                    177 ;	../../my_STM8_libraries/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      00879C 72 11 53 0A      [ 1]  178 	bres	0x530a, #0
                                    179 ;	../../my_STM8_libraries/stm8_PWM.c: 57: break;
      0087A0 81               [ 4]  180 	ret
                                    181 ;	../../my_STM8_libraries/stm8_PWM.c: 58: case PWM_CH2:		//PD3
      0087A1                        182 00102$:
                                    183 ;	../../my_STM8_libraries/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      0087A1 72 19 53 0A      [ 1]  184 	bres	0x530a, #4
                                    185 ;	../../my_STM8_libraries/stm8_PWM.c: 60: break;
      0087A5 81               [ 4]  186 	ret
                                    187 ;	../../my_STM8_libraries/stm8_PWM.c: 61: case PWM_CH3:		//PA3
      0087A6                        188 00103$:
                                    189 ;	../../my_STM8_libraries/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      0087A6 72 11 53 0B      [ 1]  190 	bres	0x530b, #0
                                    191 ;	../../my_STM8_libraries/stm8_PWM.c: 65: }
                                    192 ;	../../my_STM8_libraries/stm8_PWM.c: 66: }
      0087AA 81               [ 4]  193 	ret
                                    194 ;	../../my_STM8_libraries/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    195 ;	-----------------------------------------
                                    196 ;	 function write_PWM
                                    197 ;	-----------------------------------------
      0087AB                        198 _write_PWM:
                                    199 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0087AB 90 93            [ 1]  200 	ldw	y, x
                                    201 ;	../../my_STM8_libraries/stm8_PWM.c: 69: switch (channel) {
      0087AD A1 01            [ 1]  202 	cp	a, #0x01
      0087AF 27 09            [ 1]  203 	jreq	00101$
      0087B1 A1 02            [ 1]  204 	cp	a, #0x02
      0087B3 27 10            [ 1]  205 	jreq	00102$
      0087B5 A1 03            [ 1]  206 	cp	a, #0x03
      0087B7 27 17            [ 1]  207 	jreq	00103$
      0087B9 81               [ 4]  208 	ret
                                    209 ;	../../my_STM8_libraries/stm8_PWM.c: 70: case PWM_CH1:
      0087BA                        210 00101$:
                                    211 ;	../../my_STM8_libraries/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      0087BA 9E               [ 1]  212 	ld	a, xh
      0087BB C7 53 11         [ 1]  213 	ld	0x5311, a
                                    214 ;	../../my_STM8_libraries/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      0087BE AE 53 12         [ 2]  215 	ldw	x, #0x5312
      0087C1 90 9F            [ 1]  216 	ld	a, yl
      0087C3 F7               [ 1]  217 	ld	(x), a
                                    218 ;	../../my_STM8_libraries/stm8_PWM.c: 73: break;
      0087C4 81               [ 4]  219 	ret
                                    220 ;	../../my_STM8_libraries/stm8_PWM.c: 74: case PWM_CH2:
      0087C5                        221 00102$:
                                    222 ;	../../my_STM8_libraries/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      0087C5 9E               [ 1]  223 	ld	a, xh
      0087C6 C7 53 13         [ 1]  224 	ld	0x5313, a
                                    225 ;	../../my_STM8_libraries/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      0087C9 AE 53 14         [ 2]  226 	ldw	x, #0x5314
      0087CC 90 9F            [ 1]  227 	ld	a, yl
      0087CE F7               [ 1]  228 	ld	(x), a
                                    229 ;	../../my_STM8_libraries/stm8_PWM.c: 77: break;
      0087CF 81               [ 4]  230 	ret
                                    231 ;	../../my_STM8_libraries/stm8_PWM.c: 78: case PWM_CH3:
      0087D0                        232 00103$:
                                    233 ;	../../my_STM8_libraries/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      0087D0 9E               [ 1]  234 	ld	a, xh
      0087D1 C7 53 15         [ 1]  235 	ld	0x5315, a
                                    236 ;	../../my_STM8_libraries/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      0087D4 AE 53 16         [ 2]  237 	ldw	x, #0x5316
      0087D7 90 9F            [ 1]  238 	ld	a, yl
      0087D9 F7               [ 1]  239 	ld	(x), a
                                    240 ;	../../my_STM8_libraries/stm8_PWM.c: 83: }
                                    241 ;	../../my_STM8_libraries/stm8_PWM.c: 84: }
      0087DA 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    244 ;	-----------------------------------------
                                    245 ;	 function writePercent_PWM
                                    246 ;	-----------------------------------------
      0087DB                        247 _writePercent_PWM:
      0087DB 52 09            [ 2]  248 	sub	sp, #9
      0087DD 6B 09            [ 1]  249 	ld	(0x09, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      0087DF 7B 0C            [ 1]  251 	ld	a, (0x0c, sp)
      0087E1 A1 64            [ 1]  252 	cp	a, #0x64
      0087E3 23 04            [ 2]  253 	jrule	00102$
      0087E5 A6 64            [ 1]  254 	ld	a, #0x64
      0087E7 6B 0C            [ 1]  255 	ld	(0x0c, sp), a
      0087E9                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      0087E9 7B 0C            [ 1]  258 	ld	a, (0x0c, sp)
      0087EB 5F               [ 1]  259 	clrw	x
      0087EC 1F 01            [ 2]  260 	ldw	(0x01, sp), x
      0087EE 90 CE 00 0D      [ 2]  261 	ldw	y, _memory_period+0
      0087F2 0F 06            [ 1]  262 	clr	(0x06, sp)
      0087F4 0F 05            [ 1]  263 	clr	(0x05, sp)
      0087F6 90 89            [ 2]  264 	pushw	y
      0087F8 16 07            [ 2]  265 	ldw	y, (0x07, sp)
      0087FA 90 89            [ 2]  266 	pushw	y
      0087FC 88               [ 1]  267 	push	a
      0087FD 9E               [ 1]  268 	ld	a, xh
      0087FE 88               [ 1]  269 	push	a
      0087FF 1E 07            [ 2]  270 	ldw	x, (0x07, sp)
      008801 89               [ 2]  271 	pushw	x
      008802 CD 8A CA         [ 4]  272 	call	__mullong
      008805 5B 08            [ 2]  273 	addw	sp, #8
      008807 4B 64            [ 1]  274 	push	#0x64
      008809 4B 00            [ 1]  275 	push	#0x00
      00880B 4B 00            [ 1]  276 	push	#0x00
      00880D 4B 00            [ 1]  277 	push	#0x00
      00880F 89               [ 2]  278 	pushw	x
      008810 90 89            [ 2]  279 	pushw	y
      008812 CD 8A 71         [ 4]  280 	call	__divulong
      008815 5B 08            [ 2]  281 	addw	sp, #8
                                    282 ;	../../my_STM8_libraries/stm8_PWM.c: 89: write_PWM(channel, value);
      008817 7B 09            [ 1]  283 	ld	a, (0x09, sp)
      008819 16 0A            [ 2]  284 	ldw	y, (10, sp)
      00881B 17 0B            [ 2]  285 	ldw	(11, sp), y
      00881D 5B 0A            [ 2]  286 	addw	sp, #10
                                    287 ;	../../my_STM8_libraries/stm8_PWM.c: 90: }
      00881F CC 87 AB         [ 2]  288 	jp	_write_PWM
      008822 84               [ 1]  289 	pop	a
      008823 FC               [ 2]  290 	jp	(x)
                                    291 	.area CODE
                                    292 	.area CONST
                                    293 	.area INITIALIZER
      00809B                        294 __xinit__memory_period:
      00809B 00 00                  295 	.dw #0x0000
                                    296 	.area CABS (ABS)
