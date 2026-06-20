                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8_I2C
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _init_I2C
                                     12 	.globl _stop_I2C
                                     13 	.globl _start_I2C
                                     14 	.globl _writeAddr_I2C
                                     15 	.globl _writeByte_I2C
                                     16 	.globl _ping_I2C
                                     17 	.globl _writeReg_I2C
                                     18 	.globl _readByte_I2C
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; global & static initialisations
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area GSINIT
                                     47 ;--------------------------------------------------------
                                     48 ; Home
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area HOME
                                     52 ;--------------------------------------------------------
                                     53 ; code
                                     54 ;--------------------------------------------------------
                                     55 	.area CODE
                                     56 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     57 ;	-----------------------------------------
                                     58 ;	 function init_I2C
                                     59 ;	-----------------------------------------
      00823E                         60 _init_I2C:
                                     61 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      00823E 72 11 52 10      [ 1]   62 	bres	0x5210, #0
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      008242 35 10 52 12      [ 1]   64 	mov	0x5212+0, #0x10
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      008246 35 50 52 1B      [ 1]   66 	mov	0x521b+0, #0x50
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      00824A 35 00 52 1C      [ 1]   68 	mov	0x521c+0, #0x00
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      00824E 35 11 52 1D      [ 1]   70 	mov	0x521d+0, #0x11
                                     71 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      008252 72 10 52 10      [ 1]   72 	bset	0x5210, #0
                                     73 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      008256 81               [ 4]   74 	ret
                                     75 ;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
                                     76 ;	-----------------------------------------
                                     77 ;	 function stop_I2C
                                     78 ;	-----------------------------------------
      008257                         79 _stop_I2C:
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008257 72 12 52 11      [ 1]   81 	bset	0x5211, #1
                                     82 ;	../../my_STM8_libraries/stm8_I2C.c: 26: }
      00825B 81               [ 4]   83 	ret
                                     84 ;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
                                     85 ;	-----------------------------------------
                                     86 ;	 function start_I2C
                                     87 ;	-----------------------------------------
      00825C                         88 _start_I2C:
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      00825C 72 10 52 11      [ 1]   90 	bset	0x5211, #0
                                     91 ;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008260 AE C3 50         [ 2]   92 	ldw	x, #0xc350
      008263                         93 00103$:
      008263 72 00 52 17 09   [ 2]   94 	btjt	0x5217, #0, 00105$
                                     95 ;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
      008268 5A               [ 2]   96 	decw	x
      008269 5D               [ 2]   97 	tnzw	x
      00826A 26 F7            [ 1]   98 	jrne	00103$
                                     99 ;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
      00826C CD 82 57         [ 4]  100 	call	_stop_I2C
                                    101 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
      00826F 4F               [ 1]  102 	clr	a
      008270 81               [ 4]  103 	ret
      008271                        104 00105$:
                                    105 ;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
      008271 A6 01            [ 1]  106 	ld	a, #0x01
                                    107 ;	../../my_STM8_libraries/stm8_I2C.c: 42: }
      008273 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    110 ;	-----------------------------------------
                                    111 ;	 function writeAddr_I2C
                                    112 ;	-----------------------------------------
      008274                        113 _writeAddr_I2C:
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (mode == WRITE) I2C_DR = (address << 1);
      008274 48               [ 1]  115 	sll	a
      008275 0D 03            [ 1]  116 	tnz	(0x03, sp)
      008277 26 03            [ 1]  117 	jrne	00102$
      008279 C7 52 16         [ 1]  118 	ld	0x5216, a
      00827C                        119 00102$:
                                    120 ;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      00827C 88               [ 1]  121 	push	a
      00827D 7B 04            [ 1]  122 	ld	a, (0x04, sp)
      00827F 4A               [ 1]  123 	dec	a
      008280 84               [ 1]  124 	pop	a
      008281 26 05            [ 1]  125 	jrne	00119$
      008283 AA 01            [ 1]  126 	or	a, #0x01
      008285 C7 52 16         [ 1]  127 	ld	0x5216, a
                                    128 ;	../../my_STM8_libraries/stm8_I2C.c: 51: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008288                        129 00119$:
      008288 AE C3 50         [ 2]  130 	ldw	x, #0xc350
      00828B                        131 00108$:
      00828B 72 02 52 17 0F   [ 2]  132 	btjt	0x5217, #1, 00110$
      008290 72 04 52 18 0A   [ 2]  133 	btjt	0x5218, #2, 00110$
                                    134 ;	../../my_STM8_libraries/stm8_I2C.c: 53: if (--timeout == 0) 
      008295 5A               [ 2]  135 	decw	x
      008296 5D               [ 2]  136 	tnzw	x
      008297 26 F2            [ 1]  137 	jrne	00108$
                                    138 ;	../../my_STM8_libraries/stm8_I2C.c: 55: stop_I2C();
      008299 CD 82 57         [ 4]  139 	call	_stop_I2C
                                    140 ;	../../my_STM8_libraries/stm8_I2C.c: 56: return 0;
      00829C 4F               [ 1]  141 	clr	a
      00829D 20 17            [ 2]  142 	jra	00113$
      00829F                        143 00110$:
                                    144 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00829F 72 03 52 17 0A   [ 2]  145 	btjf	0x5217, #1, 00112$
                                    146 ;	../../my_STM8_libraries/stm8_I2C.c: 61: (void)I2C_SR1;	//сбрасываем как в RM
      0082A4 C6 52 17         [ 1]  147 	ld	a, 0x5217
                                    148 ;	../../my_STM8_libraries/stm8_I2C.c: 62: (void)I2C_SR3;
      0082A7 C6 52 19         [ 1]  149 	ld	a, 0x5219
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 63: return 1;
      0082AA A6 01            [ 1]  151 	ld	a, #0x01
      0082AC 20 08            [ 2]  152 	jra	00113$
      0082AE                        153 00112$:
                                    154 ;	../../my_STM8_libraries/stm8_I2C.c: 65: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      0082AE 72 15 52 18      [ 1]  155 	bres	0x5218, #2
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 66: stop_I2C();
      0082B2 CD 82 57         [ 4]  157 	call	_stop_I2C
                                    158 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 0;
      0082B5 4F               [ 1]  159 	clr	a
      0082B6                        160 00113$:
                                    161 ;	../../my_STM8_libraries/stm8_I2C.c: 68: }
      0082B6 85               [ 2]  162 	popw	x
      0082B7 5B 01            [ 2]  163 	addw	sp, #1
      0082B9 FC               [ 2]  164 	jp	(x)
                                    165 ;	../../my_STM8_libraries/stm8_I2C.c: 70: uint8_t writeByte_I2C(uint8_t data)
                                    166 ;	-----------------------------------------
                                    167 ;	 function writeByte_I2C
                                    168 ;	-----------------------------------------
      0082BA                        169 _writeByte_I2C:
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 74: I2C_DR = data;	//записываем байт в реистр данных
      0082BA C7 52 16         [ 1]  171 	ld	0x5216, a
                                    172 ;	../../my_STM8_libraries/stm8_I2C.c: 76: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      0082BD AE C3 50         [ 2]  173 	ldw	x, #0xc350
      0082C0                        174 00105$:
      0082C0 C6 52 17         [ 1]  175 	ld	a, 0x5217
      0082C3 2B 17            [ 1]  176 	jrmi	00107$
                                    177 ;	../../my_STM8_libraries/stm8_I2C.c: 78: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0082C5 72 05 52 18 09   [ 2]  178 	btjf	0x5218, #2, 00102$
                                    179 ;	../../my_STM8_libraries/stm8_I2C.c: 80: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0082CA 72 15 52 18      [ 1]  180 	bres	0x5218, #2
                                    181 ;	../../my_STM8_libraries/stm8_I2C.c: 81: stop_I2C();
      0082CE CD 82 57         [ 4]  182 	call	_stop_I2C
                                    183 ;	../../my_STM8_libraries/stm8_I2C.c: 82: return 0;
      0082D1 4F               [ 1]  184 	clr	a
      0082D2 81               [ 4]  185 	ret
      0082D3                        186 00102$:
                                    187 ;	../../my_STM8_libraries/stm8_I2C.c: 84: if (--timeout == 0)	//проверка таймаута
      0082D3 5A               [ 2]  188 	decw	x
      0082D4 5D               [ 2]  189 	tnzw	x
      0082D5 26 E9            [ 1]  190 	jrne	00105$
                                    191 ;	../../my_STM8_libraries/stm8_I2C.c: 86: stop_I2C();
      0082D7 CD 82 57         [ 4]  192 	call	_stop_I2C
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 87: return 0;
      0082DA 4F               [ 1]  194 	clr	a
      0082DB 81               [ 4]  195 	ret
      0082DC                        196 00107$:
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 90: return 1;
      0082DC A6 01            [ 1]  198 	ld	a, #0x01
                                    199 ;	../../my_STM8_libraries/stm8_I2C.c: 91: }
      0082DE 81               [ 4]  200 	ret
                                    201 ;	../../my_STM8_libraries/stm8_I2C.c: 93: uint8_t ping_I2C(uint8_t address)
                                    202 ;	-----------------------------------------
                                    203 ;	 function ping_I2C
                                    204 ;	-----------------------------------------
      0082DF                        205 _ping_I2C:
      0082DF 88               [ 1]  206 	push	a
      0082E0 6B 01            [ 1]  207 	ld	(0x01, sp), a
                                    208 ;	../../my_STM8_libraries/stm8_I2C.c: 95: if (start_I2C() == 0) return 0;
      0082E2 CD 82 5C         [ 4]  209 	call	_start_I2C
      0082E5 4D               [ 1]  210 	tnz	a
      0082E6 26 03            [ 1]  211 	jrne	00102$
      0082E8 4F               [ 1]  212 	clr	a
      0082E9 20 12            [ 2]  213 	jra	00105$
      0082EB                        214 00102$:
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 96: if (writeAddr_I2C(address, WRITE) == 0) return 0; 
      0082EB 4B 00            [ 1]  216 	push	#0x00
      0082ED 7B 02            [ 1]  217 	ld	a, (0x02, sp)
      0082EF CD 82 74         [ 4]  218 	call	_writeAddr_I2C
      0082F2 4D               [ 1]  219 	tnz	a
      0082F3 26 03            [ 1]  220 	jrne	00104$
      0082F5 4F               [ 1]  221 	clr	a
      0082F6 20 05            [ 2]  222 	jra	00105$
      0082F8                        223 00104$:
                                    224 ;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
      0082F8 CD 82 57         [ 4]  225 	call	_stop_I2C
                                    226 ;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
      0082FB A6 01            [ 1]  227 	ld	a, #0x01
      0082FD                        228 00105$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 99: }
      0082FD 5B 01            [ 2]  230 	addw	sp, #1
      0082FF 81               [ 4]  231 	ret
                                    232 ;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    233 ;	-----------------------------------------
                                    234 ;	 function writeReg_I2C
                                    235 ;	-----------------------------------------
      008300                        236 _writeReg_I2C:
      008300 88               [ 1]  237 	push	a
      008301 6B 01            [ 1]  238 	ld	(0x01, sp), a
                                    239 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
      008303 CD 82 5C         [ 4]  240 	call	_start_I2C
      008306 4D               [ 1]  241 	tnz	a
      008307 26 03            [ 1]  242 	jrne	00102$
      008309 4F               [ 1]  243 	clr	a
      00830A 20 28            [ 2]  244 	jra	00109$
      00830C                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00830C 4B 00            [ 1]  247 	push	#0x00
      00830E 7B 02            [ 1]  248 	ld	a, (0x02, sp)
      008310 CD 82 74         [ 4]  249 	call	_writeAddr_I2C
      008313 4D               [ 1]  250 	tnz	a
      008314 26 03            [ 1]  251 	jrne	00104$
      008316 4F               [ 1]  252 	clr	a
      008317 20 1B            [ 2]  253 	jra	00109$
      008319                        254 00104$:
                                    255 ;	../../my_STM8_libraries/stm8_I2C.c: 105: if (writeByte_I2C(reg) == 0) return 0;
      008319 7B 04            [ 1]  256 	ld	a, (0x04, sp)
      00831B CD 82 BA         [ 4]  257 	call	_writeByte_I2C
      00831E 4D               [ 1]  258 	tnz	a
      00831F 26 03            [ 1]  259 	jrne	00106$
      008321 4F               [ 1]  260 	clr	a
      008322 20 10            [ 2]  261 	jra	00109$
      008324                        262 00106$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(data) == 0) return 0;
      008324 7B 05            [ 1]  264 	ld	a, (0x05, sp)
      008326 CD 82 BA         [ 4]  265 	call	_writeByte_I2C
      008329 4D               [ 1]  266 	tnz	a
      00832A 26 03            [ 1]  267 	jrne	00108$
      00832C 4F               [ 1]  268 	clr	a
      00832D 20 05            [ 2]  269 	jra	00109$
      00832F                        270 00108$:
                                    271 ;	../../my_STM8_libraries/stm8_I2C.c: 107: stop_I2C();
      00832F CD 82 57         [ 4]  272 	call	_stop_I2C
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: return 1;
      008332 A6 01            [ 1]  274 	ld	a, #0x01
      008334                        275 00109$:
                                    276 ;	../../my_STM8_libraries/stm8_I2C.c: 109: }
      008334 1E 02            [ 2]  277 	ldw	x, (2, sp)
      008336 5B 05            [ 2]  278 	addw	sp, #5
      008338 FC               [ 2]  279 	jp	(x)
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 111: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    281 ;	-----------------------------------------
                                    282 ;	 function readByte_I2C
                                    283 ;	-----------------------------------------
      008339                        284 _readByte_I2C:
      008339 52 03            [ 2]  285 	sub	sp, #3
      00833B 6B 03            [ 1]  286 	ld	(0x03, sp), a
      00833D 1F 01            [ 2]  287 	ldw	(0x01, sp), x
                                    288 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (start_I2C() == 0) return 0;
      00833F CD 82 5C         [ 4]  289 	call	_start_I2C
      008342 4D               [ 1]  290 	tnz	a
      008343 26 03            [ 1]  291 	jrne	00102$
      008345 4F               [ 1]  292 	clr	a
      008346 20 32            [ 2]  293 	jra	00110$
      008348                        294 00102$:
                                    295 ;	../../my_STM8_libraries/stm8_I2C.c: 117: I2C_CR2 &= ~I2C_CR2_ACK;
      008348 72 15 52 11      [ 1]  296 	bres	0x5211, #2
                                    297 ;	../../my_STM8_libraries/stm8_I2C.c: 119: if (writeAddr_I2C(address, READ) == 0) return 0;
      00834C 4B 01            [ 1]  298 	push	#0x01
      00834E 7B 04            [ 1]  299 	ld	a, (0x04, sp)
      008350 CD 82 74         [ 4]  300 	call	_writeAddr_I2C
      008353 4D               [ 1]  301 	tnz	a
      008354 26 03            [ 1]  302 	jrne	00115$
      008356 4F               [ 1]  303 	clr	a
      008357 20 21            [ 2]  304 	jra	00110$
                                    305 ;	../../my_STM8_libraries/stm8_I2C.c: 121: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008359                        306 00115$:
      008359 AE C3 50         [ 2]  307 	ldw	x, #0xc350
      00835C                        308 00107$:
      00835C 72 0C 52 17 0A   [ 2]  309 	btjt	0x5217, #6, 00109$
                                    310 ;	../../my_STM8_libraries/stm8_I2C.c: 123: if (--timeout == 0) 
      008361 5A               [ 2]  311 	decw	x
      008362 5D               [ 2]  312 	tnzw	x
      008363 26 F7            [ 1]  313 	jrne	00107$
                                    314 ;	../../my_STM8_libraries/stm8_I2C.c: 125: stop_I2C();
      008365 CD 82 57         [ 4]  315 	call	_stop_I2C
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 126: return 0;
      008368 4F               [ 1]  317 	clr	a
      008369 20 0F            [ 2]  318 	jra	00110$
      00836B                        319 00109$:
                                    320 ;	../../my_STM8_libraries/stm8_I2C.c: 129: *data = I2C_DR;
      00836B C6 52 16         [ 1]  321 	ld	a, 0x5216
      00836E 1E 01            [ 2]  322 	ldw	x, (0x01, sp)
      008370 F7               [ 1]  323 	ld	(x), a
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 130: stop_I2C();
      008371 CD 82 57         [ 4]  325 	call	_stop_I2C
                                    326 ;	../../my_STM8_libraries/stm8_I2C.c: 131: I2C_CR2 |= I2C_CR2_ACK;
      008374 72 14 52 11      [ 1]  327 	bset	0x5211, #2
                                    328 ;	../../my_STM8_libraries/stm8_I2C.c: 132: return 1;
      008378 A6 01            [ 1]  329 	ld	a, #0x01
      00837A                        330 00110$:
                                    331 ;	../../my_STM8_libraries/stm8_I2C.c: 133: }
      00837A 5B 03            [ 2]  332 	addw	sp, #3
      00837C 81               [ 4]  333 	ret
                                    334 	.area CODE
                                    335 	.area CONST
                                    336 	.area INITIALIZER
                                    337 	.area CABS (ABS)
