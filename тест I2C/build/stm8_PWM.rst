                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_PWM
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _init_PWM
                                     11 	.globl _startChannel_PWM
                                     12 	.globl _stopChannel_PWM
                                     13 	.globl _write_PWM
                                     14 	.globl _writePercent_PWM
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
      000001                         23 _memory_period:
      000001                         24 	.ds 2
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
                                     54 ;	../../libs/stm8_PWM.c: 5: void init_PWM(uint16_t period) {	// period = Fmaster / Fpwm (для удобства лучше использовать 1023)
                                     55 ;	-----------------------------------------
                                     56 ;	 function init_PWM
                                     57 ;	-----------------------------------------
      0083BA                         58 _init_PWM:
                                     59 ;	../../libs/stm8_PWM.c: 6: CLK_PCKENR1 |= (1 << 5);		//включить тактирование TIM2
      0083BA 72 1A 50 C7      [ 1]   60 	bset	0x50c7, #5
                                     61 ;	../../libs/stm8_PWM.c: 8: memory_period = period;			// запомним период чтобы считать проценты
      0083BE CF 00 01         [ 2]   62 	ldw	_memory_period+0, x
                                     63 ;	../../libs/stm8_PWM.c: 10: TIM2_ARRH = (uint8_t)((period >> 8));	//устанавливаем период
      0083C1 9E               [ 1]   64 	ld	a, xh
      0083C2 C7 53 0F         [ 1]   65 	ld	0x530f, a
                                     66 ;	../../libs/stm8_PWM.c: 11: TIM2_ARRL = (uint8_t)((period & 0xFF));
      0083C5 9F               [ 1]   67 	ld	a, xl
      0083C6 C7 53 10         [ 1]   68 	ld	0x5310, a
                                     69 ;	../../libs/stm8_PWM.c: 13: TIM2_CCMR1 &= ~(0b111 << 4);		//сбрасываем значения настройки в 0 PD4
      0083C9 C6 53 07         [ 1]   70 	ld	a, 0x5307
      0083CC A4 8F            [ 1]   71 	and	a, #0x8f
      0083CE C7 53 07         [ 1]   72 	ld	0x5307, a
                                     73 ;	../../libs/stm8_PWM.c: 14: TIM2_CCMR2 &= ~(0b111 << 4);		//PD3
      0083D1 C6 53 08         [ 1]   74 	ld	a, 0x5308
      0083D4 A4 8F            [ 1]   75 	and	a, #0x8f
      0083D6 C7 53 08         [ 1]   76 	ld	0x5308, a
                                     77 ;	../../libs/stm8_PWM.c: 15: TIM2_CCMR3 &= ~(0b111 << 4);		//PA3
      0083D9 C6 53 09         [ 1]   78 	ld	a, 0x5309
      0083DC A4 8F            [ 1]   79 	and	a, #0x8f
      0083DE C7 53 09         [ 1]   80 	ld	0x5309, a
                                     81 ;	../../libs/stm8_PWM.c: 17: TIM2_CCMR1 |= (0b110 << 4);		//настроить режим работы вывода PD4
      0083E1 C6 53 07         [ 1]   82 	ld	a, 0x5307
      0083E4 AA 60            [ 1]   83 	or	a, #0x60
      0083E6 C7 53 07         [ 1]   84 	ld	0x5307, a
                                     85 ;	../../libs/stm8_PWM.c: 18: TIM2_CCMR2 |= (0b110 << 4);		//PD3
      0083E9 C6 53 08         [ 1]   86 	ld	a, 0x5308
      0083EC AA 60            [ 1]   87 	or	a, #0x60
      0083EE C7 53 08         [ 1]   88 	ld	0x5308, a
                                     89 ;	../../libs/stm8_PWM.c: 19: TIM2_CCMR3 |= (0b110 << 4);		//PA3
      0083F1 C6 53 09         [ 1]   90 	ld	a, 0x5309
      0083F4 AA 60            [ 1]   91 	or	a, #0x60
      0083F6 C7 53 09         [ 1]   92 	ld	0x5309, a
                                     93 ;	../../libs/stm8_PWM.c: 21: TIM2_CCMR1 |= (1 << 3);		//настроить PD4 как выход
      0083F9 72 16 53 07      [ 1]   94 	bset	0x5307, #3
                                     95 ;	../../libs/stm8_PWM.c: 22: TIM2_CCMR2 |= (1 << 3);		//PD3
      0083FD 72 16 53 08      [ 1]   96 	bset	0x5308, #3
                                     97 ;	../../libs/stm8_PWM.c: 23: TIM2_CCMR3 |= (1 << 3);		//PA3
      008401 72 16 53 09      [ 1]   98 	bset	0x5309, #3
                                     99 ;	../../libs/stm8_PWM.c: 25: TIM2_CCMR1 &= ~0b11;		//настроить PD4 как выход
      008405 C6 53 07         [ 1]  100 	ld	a, 0x5307
      008408 A4 FC            [ 1]  101 	and	a, #0xfc
      00840A C7 53 07         [ 1]  102 	ld	0x5307, a
                                    103 ;	../../libs/stm8_PWM.c: 26: TIM2_CCMR2 &= ~0b11;		//PD3
      00840D C6 53 08         [ 1]  104 	ld	a, 0x5308
      008410 A4 FC            [ 1]  105 	and	a, #0xfc
      008412 C7 53 08         [ 1]  106 	ld	0x5308, a
                                    107 ;	../../libs/stm8_PWM.c: 27: TIM2_CCMR3 &= ~0b11;		//PA3
      008415 C6 53 09         [ 1]  108 	ld	a, 0x5309
      008418 A4 FC            [ 1]  109 	and	a, #0xfc
      00841A C7 53 09         [ 1]  110 	ld	0x5309, a
                                    111 ;	../../libs/stm8_PWM.c: 29: TIM2_CR1 |= (1 << 7) | (1 << 0);
      00841D C6 53 00         [ 1]  112 	ld	a, 0x5300
      008420 AA 81            [ 1]  113 	or	a, #0x81
      008422 C7 53 00         [ 1]  114 	ld	0x5300, a
                                    115 ;	../../libs/stm8_PWM.c: 30: }
      008425 81               [ 4]  116 	ret
                                    117 ;	../../libs/stm8_PWM.c: 32: void startChannel_PWM(uint8_t channel) {	//функция разрешает вывод на соответствующий пин
                                    118 ;	-----------------------------------------
                                    119 ;	 function startChannel_PWM
                                    120 ;	-----------------------------------------
      008426                        121 _startChannel_PWM:
                                    122 ;	../../libs/stm8_PWM.c: 33: switch (channel) {
      008426 A1 01            [ 1]  123 	cp	a, #0x01
      008428 27 09            [ 1]  124 	jreq	00101$
      00842A A1 02            [ 1]  125 	cp	a, #0x02
      00842C 27 12            [ 1]  126 	jreq	00102$
      00842E A1 03            [ 1]  127 	cp	a, #0x03
      008430 27 1B            [ 1]  128 	jreq	00103$
      008432 81               [ 4]  129 	ret
                                    130 ;	../../libs/stm8_PWM.c: 34: case 1:		//PD4
      008433                        131 00101$:
                                    132 ;	../../libs/stm8_PWM.c: 35: PD_DDR |= (1 << 4);
      008433 72 18 50 11      [ 1]  133 	bset	0x5011, #4
                                    134 ;	../../libs/stm8_PWM.c: 36: PD_CR1 |= (1 << 4);
      008437 72 18 50 12      [ 1]  135 	bset	0x5012, #4
                                    136 ;	../../libs/stm8_PWM.c: 37: TIM2_CCER1 |= (1 << 0);	
      00843B 72 10 53 0A      [ 1]  137 	bset	0x530a, #0
                                    138 ;	../../libs/stm8_PWM.c: 38: break;
      00843F 81               [ 4]  139 	ret
                                    140 ;	../../libs/stm8_PWM.c: 39: case 2:		//PD3
      008440                        141 00102$:
                                    142 ;	../../libs/stm8_PWM.c: 40: PD_DDR |= (1 << 3);
      008440 72 16 50 11      [ 1]  143 	bset	0x5011, #3
                                    144 ;	../../libs/stm8_PWM.c: 41: PD_CR1 |= (1 << 3);
      008444 72 16 50 12      [ 1]  145 	bset	0x5012, #3
                                    146 ;	../../libs/stm8_PWM.c: 42: TIM2_CCER1 |= (1 << 4);	
      008448 72 18 53 0A      [ 1]  147 	bset	0x530a, #4
                                    148 ;	../../libs/stm8_PWM.c: 43: break;
      00844C 81               [ 4]  149 	ret
                                    150 ;	../../libs/stm8_PWM.c: 44: case 3:		//PA3
      00844D                        151 00103$:
                                    152 ;	../../libs/stm8_PWM.c: 45: PA_DDR |= (1 << 3);
      00844D 72 16 50 02      [ 1]  153 	bset	0x5002, #3
                                    154 ;	../../libs/stm8_PWM.c: 46: PA_CR1 |= (1 << 3);
      008451 72 16 50 03      [ 1]  155 	bset	0x5003, #3
                                    156 ;	../../libs/stm8_PWM.c: 47: TIM2_CCER2 |= (1 << 0);	
      008455 72 10 53 0B      [ 1]  157 	bset	0x530b, #0
                                    158 ;	../../libs/stm8_PWM.c: 50: }
                                    159 ;	../../libs/stm8_PWM.c: 51: }
      008459 81               [ 4]  160 	ret
                                    161 ;	../../libs/stm8_PWM.c: 53: void stopChannel_PWM(uint8_t channel) {		//функция запрещает вывод на соответствующий пин
                                    162 ;	-----------------------------------------
                                    163 ;	 function stopChannel_PWM
                                    164 ;	-----------------------------------------
      00845A                        165 _stopChannel_PWM:
                                    166 ;	../../libs/stm8_PWM.c: 54: switch (channel) {
      00845A A1 01            [ 1]  167 	cp	a, #0x01
      00845C 27 09            [ 1]  168 	jreq	00101$
      00845E A1 02            [ 1]  169 	cp	a, #0x02
      008460 27 0A            [ 1]  170 	jreq	00102$
      008462 A1 03            [ 1]  171 	cp	a, #0x03
      008464 27 0B            [ 1]  172 	jreq	00103$
      008466 81               [ 4]  173 	ret
                                    174 ;	../../libs/stm8_PWM.c: 55: case 1:		//PD4
      008467                        175 00101$:
                                    176 ;	../../libs/stm8_PWM.c: 56: TIM2_CCER1 &= ~(1 << 0);
      008467 72 11 53 0A      [ 1]  177 	bres	0x530a, #0
                                    178 ;	../../libs/stm8_PWM.c: 57: break;
      00846B 81               [ 4]  179 	ret
                                    180 ;	../../libs/stm8_PWM.c: 58: case 2:		//PD3
      00846C                        181 00102$:
                                    182 ;	../../libs/stm8_PWM.c: 59: TIM2_CCER1 &= ~(1 << 4);
      00846C 72 19 53 0A      [ 1]  183 	bres	0x530a, #4
                                    184 ;	../../libs/stm8_PWM.c: 60: break;
      008470 81               [ 4]  185 	ret
                                    186 ;	../../libs/stm8_PWM.c: 61: case 3:		//PA3
      008471                        187 00103$:
                                    188 ;	../../libs/stm8_PWM.c: 62: TIM2_CCER2 &= ~(1 << 0);
      008471 72 11 53 0B      [ 1]  189 	bres	0x530b, #0
                                    190 ;	../../libs/stm8_PWM.c: 65: }
                                    191 ;	../../libs/stm8_PWM.c: 66: }
      008475 81               [ 4]  192 	ret
                                    193 ;	../../libs/stm8_PWM.c: 68: void write_PWM(uint8_t channel, uint16_t value) {
                                    194 ;	-----------------------------------------
                                    195 ;	 function write_PWM
                                    196 ;	-----------------------------------------
      008476                        197 _write_PWM:
                                    198 ;	../../libs/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008476 90 93            [ 1]  199 	ldw	y, x
                                    200 ;	../../libs/stm8_PWM.c: 69: switch (channel) {
      008478 A1 01            [ 1]  201 	cp	a, #0x01
      00847A 27 09            [ 1]  202 	jreq	00101$
      00847C A1 02            [ 1]  203 	cp	a, #0x02
      00847E 27 10            [ 1]  204 	jreq	00102$
      008480 A1 03            [ 1]  205 	cp	a, #0x03
      008482 27 17            [ 1]  206 	jreq	00103$
      008484 81               [ 4]  207 	ret
                                    208 ;	../../libs/stm8_PWM.c: 70: case 1:
      008485                        209 00101$:
                                    210 ;	../../libs/stm8_PWM.c: 71: TIM2_CCR1H = (uint8_t)(value >> 8);
      008485 9E               [ 1]  211 	ld	a, xh
      008486 C7 53 11         [ 1]  212 	ld	0x5311, a
                                    213 ;	../../libs/stm8_PWM.c: 72: TIM2_CCR1L = (uint8_t)(value & 0xFF);
      008489 AE 53 12         [ 2]  214 	ldw	x, #0x5312
      00848C 90 9F            [ 1]  215 	ld	a, yl
      00848E F7               [ 1]  216 	ld	(x), a
                                    217 ;	../../libs/stm8_PWM.c: 73: break;
      00848F 81               [ 4]  218 	ret
                                    219 ;	../../libs/stm8_PWM.c: 74: case 2:
      008490                        220 00102$:
                                    221 ;	../../libs/stm8_PWM.c: 75: TIM2_CCR2H = (uint8_t)(value >> 8);
      008490 9E               [ 1]  222 	ld	a, xh
      008491 C7 53 13         [ 1]  223 	ld	0x5313, a
                                    224 ;	../../libs/stm8_PWM.c: 76: TIM2_CCR2L = (uint8_t)(value & 0xFF);
      008494 AE 53 14         [ 2]  225 	ldw	x, #0x5314
      008497 90 9F            [ 1]  226 	ld	a, yl
      008499 F7               [ 1]  227 	ld	(x), a
                                    228 ;	../../libs/stm8_PWM.c: 77: break;
      00849A 81               [ 4]  229 	ret
                                    230 ;	../../libs/stm8_PWM.c: 78: case 3:
      00849B                        231 00103$:
                                    232 ;	../../libs/stm8_PWM.c: 79: TIM2_CCR3H = (uint8_t)(value >> 8);
      00849B 9E               [ 1]  233 	ld	a, xh
      00849C C7 53 15         [ 1]  234 	ld	0x5315, a
                                    235 ;	../../libs/stm8_PWM.c: 80: TIM2_CCR3L = (uint8_t)(value & 0xFF);
      00849F AE 53 16         [ 2]  236 	ldw	x, #0x5316
      0084A2 90 9F            [ 1]  237 	ld	a, yl
      0084A4 F7               [ 1]  238 	ld	(x), a
                                    239 ;	../../libs/stm8_PWM.c: 83: }
                                    240 ;	../../libs/stm8_PWM.c: 84: }
      0084A5 81               [ 4]  241 	ret
                                    242 ;	../../libs/stm8_PWM.c: 86: void writePercent_PWM(uint8_t channel, uint8_t percent) {
                                    243 ;	-----------------------------------------
                                    244 ;	 function writePercent_PWM
                                    245 ;	-----------------------------------------
      0084A6                        246 _writePercent_PWM:
      0084A6 52 09            [ 2]  247 	sub	sp, #9
      0084A8 6B 09            [ 1]  248 	ld	(0x09, sp), a
                                    249 ;	../../libs/stm8_PWM.c: 87: if (percent > 100) percent = 100;
      0084AA 7B 0C            [ 1]  250 	ld	a, (0x0c, sp)
      0084AC A1 64            [ 1]  251 	cp	a, #0x64
      0084AE 23 04            [ 2]  252 	jrule	00102$
      0084B0 A6 64            [ 1]  253 	ld	a, #0x64
      0084B2 6B 0C            [ 1]  254 	ld	(0x0c, sp), a
      0084B4                        255 00102$:
                                    256 ;	../../libs/stm8_PWM.c: 88: uint16_t value = (uint16_t)(((uint32_t)percent * memory_period) / 100);
      0084B4 7B 0C            [ 1]  257 	ld	a, (0x0c, sp)
      0084B6 5F               [ 1]  258 	clrw	x
      0084B7 1F 01            [ 2]  259 	ldw	(0x01, sp), x
      0084B9 90 CE 00 01      [ 2]  260 	ldw	y, _memory_period+0
      0084BD 0F 06            [ 1]  261 	clr	(0x06, sp)
      0084BF 0F 05            [ 1]  262 	clr	(0x05, sp)
      0084C1 90 89            [ 2]  263 	pushw	y
      0084C3 16 07            [ 2]  264 	ldw	y, (0x07, sp)
      0084C5 90 89            [ 2]  265 	pushw	y
      0084C7 88               [ 1]  266 	push	a
      0084C8 4F               [ 1]  267 	clr	a
      0084C9 88               [ 1]  268 	push	a
      0084CA 1E 07            [ 2]  269 	ldw	x, (0x07, sp)
      0084CC 89               [ 2]  270 	pushw	x
      0084CD CD 86 E6         [ 4]  271 	call	__mullong
      0084D0 5B 08            [ 2]  272 	addw	sp, #8
      0084D2 4B 64            [ 1]  273 	push	#0x64
      0084D4 4B 00            [ 1]  274 	push	#0x00
      0084D6 4B 00            [ 1]  275 	push	#0x00
      0084D8 4B 00            [ 1]  276 	push	#0x00
      0084DA 89               [ 2]  277 	pushw	x
      0084DB 90 89            [ 2]  278 	pushw	y
      0084DD CD 86 89         [ 4]  279 	call	__divulong
      0084E0 5B 08            [ 2]  280 	addw	sp, #8
                                    281 ;	../../libs/stm8_PWM.c: 89: write_PWM(channel, value);
      0084E2 7B 09            [ 1]  282 	ld	a, (0x09, sp)
      0084E4 16 0A            [ 2]  283 	ldw	y, (10, sp)
      0084E6 17 0B            [ 2]  284 	ldw	(11, sp), y
      0084E8 5B 0A            [ 2]  285 	addw	sp, #10
                                    286 ;	../../libs/stm8_PWM.c: 90: }
      0084EA CC 84 76         [ 2]  287 	jp	_write_PWM
      0084ED 84               [ 1]  288 	pop	a
      0084EE FC               [ 2]  289 	jp	(x)
                                    290 	.area CODE
                                    291 	.area CONST
                                    292 	.area INITIALIZER
      0080B1                        293 __xinit__memory_period:
      0080B1 00 00                  294 	.dw #0x0000
                                    295 	.area CABS (ABS)
