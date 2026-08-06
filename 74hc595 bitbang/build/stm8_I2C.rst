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
                                     14 	.globl _clearADDR_I2C
                                     15 	.globl _setACK_I2C
                                     16 	.globl _writeAddr_I2C
                                     17 	.globl _writeByte_I2C
                                     18 	.globl _ping_I2C
                                     19 	.globl _writeReg_I2C
                                     20 	.globl _readByte_I2C
                                     21 	.globl _readReg_I2C
                                     22 	.globl _readBuffer2_I2C
                                     23 	.globl _readBuffer_I2C
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DATA
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area INITIALIZED
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; global & static initialisations
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area GSINIT
                                     50 	.area GSFINAL
                                     51 	.area GSINIT
                                     52 ;--------------------------------------------------------
                                     53 ; Home
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area HOME
                                     57 ;--------------------------------------------------------
                                     58 ; code
                                     59 ;--------------------------------------------------------
                                     60 	.area CODE
                                     61 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     62 ;	-----------------------------------------
                                     63 ;	 function init_I2C
                                     64 ;	-----------------------------------------
      008350                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      008350 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      008354 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      008358 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      00835C 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008360 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      008364 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      008368 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      008369                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008369 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      00836D 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      00836E                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      00836E 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008372 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      008375                         98 00103$:
      008375 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      00837A 5A               [ 2]  101 	decw	x
      00837B 5D               [ 2]  102 	tnzw	x
      00837C 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      00837E CD 83 69         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      008381 4F               [ 1]  107 	clr	a
      008382 81               [ 4]  108 	ret
      008383                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      008383 A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      008385 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      008386                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      008386 C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      008389 C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      00838C 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      00838D                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      00838D 97               [ 1]  131 	ld	xl, a
      00838E 4D               [ 1]  132 	tnz	a
      00838F 26 04            [ 1]  133 	jrne	00102$
      008391 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      008395                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      008395 9F               [ 1]  137 	ld	a, xl
      008396 4A               [ 1]  138 	dec	a
      008397 27 01            [ 1]  139 	jreq	00120$
      008399 81               [ 4]  140 	ret
      00839A                        141 00120$:
      00839A 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      00839E 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      00839F                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      00839F 48               [ 1]  151 	sll	a
      0083A0 0D 03            [ 1]  152 	tnz	(0x03, sp)
      0083A2 26 03            [ 1]  153 	jrne	00102$
      0083A4 C7 52 16         [ 1]  154 	ld	0x5216, a
      0083A7                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      0083A7 88               [ 1]  157 	push	a
      0083A8 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      0083AA 4A               [ 1]  159 	dec	a
      0083AB 84               [ 1]  160 	pop	a
      0083AC 26 05            [ 1]  161 	jrne	00119$
      0083AE AA 01            [ 1]  162 	or	a, #0x01
      0083B0 C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      0083B3                        165 00119$:
      0083B3 AE C3 50         [ 2]  166 	ldw	x, #0xc350
      0083B6                        167 00108$:
      0083B6 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      0083BB 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      0083C0 5A               [ 2]  171 	decw	x
      0083C1 5D               [ 2]  172 	tnzw	x
      0083C2 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      0083C4 CD 83 69         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      0083C7 4F               [ 1]  177 	clr	a
      0083C8 20 11            [ 2]  178 	jra	00113$
      0083CA                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      0083CA 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      0083CF A6 01            [ 1]  183 	ld	a, #0x01
      0083D1 20 08            [ 2]  184 	jra	00113$
      0083D3                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      0083D3 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      0083D7 CD 83 69         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      0083DA 4F               [ 1]  191 	clr	a
      0083DB                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      0083DB 85               [ 2]  194 	popw	x
      0083DC 5B 01            [ 2]  195 	addw	sp, #1
      0083DE FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      0083DF                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      0083DF C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      0083E2 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      0083E5                        206 00105$:
      0083E5 C6 52 17         [ 1]  207 	ld	a, 0x5217
      0083E8 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0083EA 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0083EF 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      0083F3 CD 83 69         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      0083F6 4F               [ 1]  216 	clr	a
      0083F7 81               [ 4]  217 	ret
      0083F8                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      0083F8 5A               [ 2]  220 	decw	x
      0083F9 5D               [ 2]  221 	tnzw	x
      0083FA 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      0083FC CD 83 69         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      0083FF 4F               [ 1]  226 	clr	a
      008400 81               [ 4]  227 	ret
      008401                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      008401 A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      008403 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      008404                        237 _ping_I2C:
      008404 88               [ 1]  238 	push	a
      008405 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      008407 CD 83 6E         [ 4]  241 	call	_start_I2C
      00840A 4D               [ 1]  242 	tnz	a
      00840B 26 03            [ 1]  243 	jrne	00102$
      00840D 4F               [ 1]  244 	clr	a
      00840E 20 15            [ 2]  245 	jra	00105$
      008410                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008410 4B 00            [ 1]  248 	push	#0x00
      008412 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      008414 CD 83 9F         [ 4]  250 	call	_writeAddr_I2C
      008417 4D               [ 1]  251 	tnz	a
      008418 26 03            [ 1]  252 	jrne	00104$
      00841A 4F               [ 1]  253 	clr	a
      00841B 20 08            [ 2]  254 	jra	00105$
      00841D                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      00841D CD 83 86         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      008420 CD 83 69         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      008423 A6 01            [ 1]  261 	ld	a, #0x01
      008425                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      008425 5B 01            [ 2]  264 	addw	sp, #1
      008427 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      008428                        270 _writeReg_I2C:
      008428 88               [ 1]  271 	push	a
      008429 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      00842B CD 83 6E         [ 4]  274 	call	_start_I2C
      00842E 4D               [ 1]  275 	tnz	a
      00842F 26 03            [ 1]  276 	jrne	00102$
      008431 4F               [ 1]  277 	clr	a
      008432 20 2B            [ 2]  278 	jra	00109$
      008434                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008434 4B 00            [ 1]  281 	push	#0x00
      008436 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      008438 CD 83 9F         [ 4]  283 	call	_writeAddr_I2C
      00843B 4D               [ 1]  284 	tnz	a
      00843C 26 03            [ 1]  285 	jrne	00104$
      00843E 4F               [ 1]  286 	clr	a
      00843F 20 1E            [ 2]  287 	jra	00109$
      008441                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      008441 CD 83 86         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      008444 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      008446 CD 83 DF         [ 4]  293 	call	_writeByte_I2C
      008449 4D               [ 1]  294 	tnz	a
      00844A 26 03            [ 1]  295 	jrne	00106$
      00844C 4F               [ 1]  296 	clr	a
      00844D 20 10            [ 2]  297 	jra	00109$
      00844F                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      00844F 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      008451 CD 83 DF         [ 4]  301 	call	_writeByte_I2C
      008454 4D               [ 1]  302 	tnz	a
      008455 26 03            [ 1]  303 	jrne	00108$
      008457 4F               [ 1]  304 	clr	a
      008458 20 05            [ 2]  305 	jra	00109$
      00845A                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      00845A CD 83 69         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      00845D A6 01            [ 1]  310 	ld	a, #0x01
      00845F                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      00845F 1E 02            [ 2]  313 	ldw	x, (2, sp)
      008461 5B 05            [ 2]  314 	addw	sp, #5
      008463 FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      008464                        320 _readByte_I2C:
      008464 52 03            [ 2]  321 	sub	sp, #3
      008466 6B 03            [ 1]  322 	ld	(0x03, sp), a
      008468 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: setACK_I2C(HIGH);
      00846A A6 01            [ 1]  325 	ld	a, #0x01
      00846C CD 83 8D         [ 4]  326 	call	_setACK_I2C
                                    327 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (start_I2C() == 0) return 0;
      00846F CD 83 6E         [ 4]  328 	call	_start_I2C
      008472 4D               [ 1]  329 	tnz	a
      008473 26 03            [ 1]  330 	jrne	00102$
      008475 4F               [ 1]  331 	clr	a
      008476 20 31            [ 2]  332 	jra	00110$
      008478                        333 00102$:
                                    334 ;	../../my_STM8_libraries/stm8_I2C.c: 129: if (writeAddr_I2C(address, READ) == 0) return 0;
      008478 4B 01            [ 1]  335 	push	#0x01
      00847A 7B 04            [ 1]  336 	ld	a, (0x04, sp)
      00847C CD 83 9F         [ 4]  337 	call	_writeAddr_I2C
      00847F 4D               [ 1]  338 	tnz	a
      008480 26 03            [ 1]  339 	jrne	00104$
      008482 4F               [ 1]  340 	clr	a
      008483 20 24            [ 2]  341 	jra	00110$
      008485                        342 00104$:
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: setACK_I2C(LOW);
      008485 4F               [ 1]  344 	clr	a
      008486 CD 83 8D         [ 4]  345 	call	_setACK_I2C
                                    346 ;	../../my_STM8_libraries/stm8_I2C.c: 133: clearADDR_I2C();
      008489 CD 83 86         [ 4]  347 	call	_clearADDR_I2C
                                    348 ;	../../my_STM8_libraries/stm8_I2C.c: 135: stop_I2C();
      00848C CD 83 69         [ 4]  349 	call	_stop_I2C
                                    350 ;	../../my_STM8_libraries/stm8_I2C.c: 137: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00848F AE C3 50         [ 2]  351 	ldw	x, #0xc350
      008492                        352 00107$:
      008492 72 0C 52 17 0A   [ 2]  353 	btjt	0x5217, #6, 00109$
                                    354 ;	../../my_STM8_libraries/stm8_I2C.c: 139: if (--timeout == 0) 
      008497 5A               [ 2]  355 	decw	x
      008498 5D               [ 2]  356 	tnzw	x
      008499 26 F7            [ 1]  357 	jrne	00107$
                                    358 ;	../../my_STM8_libraries/stm8_I2C.c: 141: stop_I2C();
      00849B CD 83 69         [ 4]  359 	call	_stop_I2C
                                    360 ;	../../my_STM8_libraries/stm8_I2C.c: 142: return 0;
      00849E 4F               [ 1]  361 	clr	a
      00849F 20 08            [ 2]  362 	jra	00110$
      0084A1                        363 00109$:
                                    364 ;	../../my_STM8_libraries/stm8_I2C.c: 145: *data = I2C_DR;
      0084A1 C6 52 16         [ 1]  365 	ld	a, 0x5216
      0084A4 1E 01            [ 2]  366 	ldw	x, (0x01, sp)
      0084A6 F7               [ 1]  367 	ld	(x), a
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      0084A7 A6 01            [ 1]  369 	ld	a, #0x01
      0084A9                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      0084A9 5B 03            [ 2]  372 	addw	sp, #3
      0084AB 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      0084AC                        378 _readReg_I2C:
      0084AC 88               [ 1]  379 	push	a
      0084AD 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: setACK_I2C(HIGH);
      0084AF A6 01            [ 1]  382 	ld	a, #0x01
      0084B1 CD 83 8D         [ 4]  383 	call	_setACK_I2C
                                    384 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (start_I2C() == 0) return 0;
      0084B4 CD 83 6E         [ 4]  385 	call	_start_I2C
      0084B7 4D               [ 1]  386 	tnz	a
      0084B8 26 03            [ 1]  387 	jrne	00102$
      0084BA 4F               [ 1]  388 	clr	a
      0084BB 20 55            [ 2]  389 	jra	00116$
      0084BD                        390 00102$:
                                    391 ;	../../my_STM8_libraries/stm8_I2C.c: 157: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0084BD 4B 00            [ 1]  392 	push	#0x00
      0084BF 7B 02            [ 1]  393 	ld	a, (0x02, sp)
      0084C1 CD 83 9F         [ 4]  394 	call	_writeAddr_I2C
      0084C4 4D               [ 1]  395 	tnz	a
      0084C5 26 03            [ 1]  396 	jrne	00104$
      0084C7 4F               [ 1]  397 	clr	a
      0084C8 20 48            [ 2]  398 	jra	00116$
      0084CA                        399 00104$:
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 159: clearADDR_I2C();
      0084CA CD 83 86         [ 4]  401 	call	_clearADDR_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (writeByte_I2C(reg) == 0) return 0;
      0084CD 7B 04            [ 1]  403 	ld	a, (0x04, sp)
      0084CF CD 83 DF         [ 4]  404 	call	_writeByte_I2C
      0084D2 4D               [ 1]  405 	tnz	a
      0084D3 26 03            [ 1]  406 	jrne	00106$
      0084D5 4F               [ 1]  407 	clr	a
      0084D6 20 3A            [ 2]  408 	jra	00116$
      0084D8                        409 00106$:
                                    410 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (start_I2C() == 0) return 0;
      0084D8 CD 83 6E         [ 4]  411 	call	_start_I2C
      0084DB 4D               [ 1]  412 	tnz	a
      0084DC 26 03            [ 1]  413 	jrne	00108$
      0084DE 4F               [ 1]  414 	clr	a
      0084DF 20 31            [ 2]  415 	jra	00116$
      0084E1                        416 00108$:
                                    417 ;	../../my_STM8_libraries/stm8_I2C.c: 165: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084E1 4B 01            [ 1]  418 	push	#0x01
      0084E3 7B 02            [ 1]  419 	ld	a, (0x02, sp)
      0084E5 CD 83 9F         [ 4]  420 	call	_writeAddr_I2C
      0084E8 4D               [ 1]  421 	tnz	a
      0084E9 26 03            [ 1]  422 	jrne	00110$
      0084EB 4F               [ 1]  423 	clr	a
      0084EC 20 24            [ 2]  424 	jra	00116$
      0084EE                        425 00110$:
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: setACK_I2C(LOW);
      0084EE 4F               [ 1]  427 	clr	a
      0084EF CD 83 8D         [ 4]  428 	call	_setACK_I2C
                                    429 ;	../../my_STM8_libraries/stm8_I2C.c: 169: clearADDR_I2C();
      0084F2 CD 83 86         [ 4]  430 	call	_clearADDR_I2C
                                    431 ;	../../my_STM8_libraries/stm8_I2C.c: 171: stop_I2C();
      0084F5 CD 83 69         [ 4]  432 	call	_stop_I2C
                                    433 ;	../../my_STM8_libraries/stm8_I2C.c: 173: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0084F8 AE C3 50         [ 2]  434 	ldw	x, #0xc350
      0084FB                        435 00113$:
      0084FB 72 0C 52 17 0A   [ 2]  436 	btjt	0x5217, #6, 00115$
                                    437 ;	../../my_STM8_libraries/stm8_I2C.c: 175: if (--timeout == 0)
      008500 5A               [ 2]  438 	decw	x
      008501 5D               [ 2]  439 	tnzw	x
      008502 26 F7            [ 1]  440 	jrne	00113$
                                    441 ;	../../my_STM8_libraries/stm8_I2C.c: 177: stop_I2C();
      008504 CD 83 69         [ 4]  442 	call	_stop_I2C
                                    443 ;	../../my_STM8_libraries/stm8_I2C.c: 178: return 0;
      008507 4F               [ 1]  444 	clr	a
      008508 20 08            [ 2]  445 	jra	00116$
      00850A                        446 00115$:
                                    447 ;	../../my_STM8_libraries/stm8_I2C.c: 181: *data = I2C_DR;
      00850A 1E 05            [ 2]  448 	ldw	x, (0x05, sp)
      00850C C6 52 16         [ 1]  449 	ld	a, 0x5216
      00850F F7               [ 1]  450 	ld	(x), a
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      008510 A6 01            [ 1]  452 	ld	a, #0x01
      008512                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      008512 1E 02            [ 2]  455 	ldw	x, (2, sp)
      008514 5B 06            [ 2]  456 	addw	sp, #6
      008516 FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      008517                        462 _readBuffer2_I2C:
      008517 52 05            [ 2]  463 	sub	sp, #5
      008519 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      00851B AE C3 50         [ 2]  466 	ldw	x, #0xc350
      00851E 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: setACK_I2C(HIGH);
      008520 A6 01            [ 1]  469 	ld	a, #0x01
      008522 CD 83 8D         [ 4]  470 	call	_setACK_I2C
                                    471 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (start_I2C() == 0) return 0;
      008525 CD 83 6E         [ 4]  472 	call	_start_I2C
      008528 4D               [ 1]  473 	tnz	a
      008529 26 03            [ 1]  474 	jrne	00102$
      00852B 4F               [ 1]  475 	clr	a
      00852C 20 73            [ 2]  476 	jra	00121$
      00852E                        477 00102$:
                                    478 ;	../../my_STM8_libraries/stm8_I2C.c: 193: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00852E 4B 00            [ 1]  479 	push	#0x00
      008530 7B 06            [ 1]  480 	ld	a, (0x06, sp)
      008532 CD 83 9F         [ 4]  481 	call	_writeAddr_I2C
      008535 4D               [ 1]  482 	tnz	a
      008536 26 03            [ 1]  483 	jrne	00104$
      008538 4F               [ 1]  484 	clr	a
      008539 20 66            [ 2]  485 	jra	00121$
      00853B                        486 00104$:
                                    487 ;	../../my_STM8_libraries/stm8_I2C.c: 194: clearADDR_I2C();
      00853B CD 83 86         [ 4]  488 	call	_clearADDR_I2C
                                    489 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (writeByte_I2C(reg) == 0) return 0;
      00853E 7B 08            [ 1]  490 	ld	a, (0x08, sp)
      008540 CD 83 DF         [ 4]  491 	call	_writeByte_I2C
      008543 4D               [ 1]  492 	tnz	a
      008544 26 03            [ 1]  493 	jrne	00106$
      008546 4F               [ 1]  494 	clr	a
      008547 20 58            [ 2]  495 	jra	00121$
      008549                        496 00106$:
                                    497 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (start_I2C() == 0) return 0;
      008549 CD 83 6E         [ 4]  498 	call	_start_I2C
      00854C 4D               [ 1]  499 	tnz	a
      00854D 26 03            [ 1]  500 	jrne	00108$
      00854F 4F               [ 1]  501 	clr	a
      008550 20 4F            [ 2]  502 	jra	00121$
      008552                        503 00108$:
                                    504 ;	../../my_STM8_libraries/stm8_I2C.c: 200: if (writeAddr_I2C(address, READ) == 0) return 0;
      008552 4B 01            [ 1]  505 	push	#0x01
      008554 7B 06            [ 1]  506 	ld	a, (0x06, sp)
      008556 CD 83 9F         [ 4]  507 	call	_writeAddr_I2C
      008559 4D               [ 1]  508 	tnz	a
      00855A 26 03            [ 1]  509 	jrne	00110$
      00855C 4F               [ 1]  510 	clr	a
      00855D 20 42            [ 2]  511 	jra	00121$
      00855F                        512 00110$:
                                    513 ;	../../my_STM8_libraries/stm8_I2C.c: 201: clearADDR_I2C();
      00855F CD 83 86         [ 4]  514 	call	_clearADDR_I2C
                                    515 ;	../../my_STM8_libraries/stm8_I2C.c: 203: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008562 AE C3 50         [ 2]  516 	ldw	x, #0xc350
      008565                        517 00113$:
      008565 72 0C 52 17 0C   [ 2]  518 	btjt	0x5217, #6, 00115$
                                    519 ;	../../my_STM8_libraries/stm8_I2C.c: 205: if (--timeout == 0)
      00856A 5A               [ 2]  520 	decw	x
      00856B 1F 01            [ 2]  521 	ldw	(0x01, sp), x
      00856D 5D               [ 2]  522 	tnzw	x
      00856E 26 F5            [ 1]  523 	jrne	00113$
                                    524 ;	../../my_STM8_libraries/stm8_I2C.c: 207: stop_I2C();
      008570 CD 83 69         [ 4]  525 	call	_stop_I2C
                                    526 ;	../../my_STM8_libraries/stm8_I2C.c: 208: return 0;
      008573 4F               [ 1]  527 	clr	a
      008574 20 2B            [ 2]  528 	jra	00121$
      008576                        529 00115$:
                                    530 ;	../../my_STM8_libraries/stm8_I2C.c: 211: buf[0] = I2C_DR;
      008576 16 09            [ 2]  531 	ldw	y, (0x09, sp)
      008578 17 03            [ 2]  532 	ldw	(0x03, sp), y
      00857A C6 52 16         [ 1]  533 	ld	a, 0x5216
      00857D 1E 03            [ 2]  534 	ldw	x, (0x03, sp)
      00857F F7               [ 1]  535 	ld	(x), a
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: setACK_I2C(LOW);
      008580 4F               [ 1]  537 	clr	a
      008581 CD 83 8D         [ 4]  538 	call	_setACK_I2C
                                    539 ;	../../my_STM8_libraries/stm8_I2C.c: 214: while (!(I2C_SR1 & I2C_SR1_BTF))
      008584 1E 01            [ 2]  540 	ldw	x, (0x01, sp)
      008586                        541 00118$:
      008586 72 04 52 17 0A   [ 2]  542 	btjt	0x5217, #2, 00120$
                                    543 ;	../../my_STM8_libraries/stm8_I2C.c: 216: if (--timeout == 0)
      00858B 5A               [ 2]  544 	decw	x
      00858C 5D               [ 2]  545 	tnzw	x
      00858D 26 F7            [ 1]  546 	jrne	00118$
                                    547 ;	../../my_STM8_libraries/stm8_I2C.c: 218: stop_I2C();
      00858F CD 83 69         [ 4]  548 	call	_stop_I2C
                                    549 ;	../../my_STM8_libraries/stm8_I2C.c: 219: return 0;
      008592 4F               [ 1]  550 	clr	a
      008593 20 0C            [ 2]  551 	jra	00121$
      008595                        552 00120$:
                                    553 ;	../../my_STM8_libraries/stm8_I2C.c: 222: stop_I2C();
      008595 CD 83 69         [ 4]  554 	call	_stop_I2C
                                    555 ;	../../my_STM8_libraries/stm8_I2C.c: 224: buf[1] = I2C_DR;
      008598 1E 03            [ 2]  556 	ldw	x, (0x03, sp)
      00859A 5C               [ 1]  557 	incw	x
      00859B C6 52 16         [ 1]  558 	ld	a, 0x5216
      00859E F7               [ 1]  559 	ld	(x), a
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      00859F A6 01            [ 1]  561 	ld	a, #0x01
      0085A1                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      0085A1 1E 06            [ 2]  564 	ldw	x, (6, sp)
      0085A3 5B 0A            [ 2]  565 	addw	sp, #10
      0085A5 FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      0085A6                        571 _readBuffer_I2C:
      0085A6 52 06            [ 2]  572 	sub	sp, #6
      0085A8 6B 04            [ 1]  573 	ld	(0x04, sp), a
                                    574 ;	../../my_STM8_libraries/stm8_I2C.c: 230: uint16_t timeout = 50000;
      0085AA AE C3 50         [ 2]  575 	ldw	x, #0xc350
      0085AD 1F 01            [ 2]  576 	ldw	(0x01, sp), x
                                    577 ;	../../my_STM8_libraries/stm8_I2C.c: 231: uint8_t i = 0;
      0085AF 0F 03            [ 1]  578 	clr	(0x03, sp)
                                    579 ;	../../my_STM8_libraries/stm8_I2C.c: 233: setACK_I2C(HIGH);
      0085B1 A6 01            [ 1]  580 	ld	a, #0x01
      0085B3 CD 83 8D         [ 4]  581 	call	_setACK_I2C
                                    582 ;	../../my_STM8_libraries/stm8_I2C.c: 235: if (size == 1) 
      0085B6 7B 0C            [ 1]  583 	ld	a, (0x0c, sp)
      0085B8 4A               [ 1]  584 	dec	a
      0085B9 26 17            [ 1]  585 	jrne	00104$
                                    586 ;	../../my_STM8_libraries/stm8_I2C.c: 237: if (readReg_I2C(address, reg, buf) == 0) return 0;
      0085BB 1E 0A            [ 2]  587 	ldw	x, (0x0a, sp)
      0085BD 89               [ 2]  588 	pushw	x
      0085BE 7B 0B            [ 1]  589 	ld	a, (0x0b, sp)
      0085C0 88               [ 1]  590 	push	a
      0085C1 7B 07            [ 1]  591 	ld	a, (0x07, sp)
      0085C3 CD 84 AC         [ 4]  592 	call	_readReg_I2C
      0085C6 4D               [ 1]  593 	tnz	a
      0085C7 26 04            [ 1]  594 	jrne	00102$
      0085C9 4F               [ 1]  595 	clr	a
      0085CA CC 86 BC         [ 2]  596 	jp	00137$
      0085CD                        597 00102$:
                                    598 ;	../../my_STM8_libraries/stm8_I2C.c: 238: return 1;
      0085CD A6 01            [ 1]  599 	ld	a, #0x01
      0085CF CC 86 BC         [ 2]  600 	jp	00137$
      0085D2                        601 00104$:
                                    602 ;	../../my_STM8_libraries/stm8_I2C.c: 240: if (size == 2)
      0085D2 7B 0C            [ 1]  603 	ld	a, (0x0c, sp)
      0085D4 A1 02            [ 1]  604 	cp	a, #0x02
      0085D6 26 17            [ 1]  605 	jrne	00108$
                                    606 ;	../../my_STM8_libraries/stm8_I2C.c: 242: if (readBuffer2_I2C(address, reg, buf) == 0) return 0;
      0085D8 1E 0A            [ 2]  607 	ldw	x, (0x0a, sp)
      0085DA 89               [ 2]  608 	pushw	x
      0085DB 7B 0B            [ 1]  609 	ld	a, (0x0b, sp)
      0085DD 88               [ 1]  610 	push	a
      0085DE 7B 07            [ 1]  611 	ld	a, (0x07, sp)
      0085E0 CD 85 17         [ 4]  612 	call	_readBuffer2_I2C
      0085E3 4D               [ 1]  613 	tnz	a
      0085E4 26 04            [ 1]  614 	jrne	00106$
      0085E6 4F               [ 1]  615 	clr	a
      0085E7 CC 86 BC         [ 2]  616 	jp	00137$
      0085EA                        617 00106$:
                                    618 ;	../../my_STM8_libraries/stm8_I2C.c: 243: return 1;
      0085EA A6 01            [ 1]  619 	ld	a, #0x01
      0085EC CC 86 BC         [ 2]  620 	jp	00137$
      0085EF                        621 00108$:
                                    622 ;	../../my_STM8_libraries/stm8_I2C.c: 245: if (start_I2C() == 0) return 0;
      0085EF CD 83 6E         [ 4]  623 	call	_start_I2C
      0085F2 4D               [ 1]  624 	tnz	a
      0085F3 26 04            [ 1]  625 	jrne	00110$
      0085F5 4F               [ 1]  626 	clr	a
      0085F6 CC 86 BC         [ 2]  627 	jp	00137$
      0085F9                        628 00110$:
                                    629 ;	../../my_STM8_libraries/stm8_I2C.c: 247: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0085F9 4B 00            [ 1]  630 	push	#0x00
      0085FB 7B 05            [ 1]  631 	ld	a, (0x05, sp)
      0085FD CD 83 9F         [ 4]  632 	call	_writeAddr_I2C
      008600 4D               [ 1]  633 	tnz	a
      008601 26 04            [ 1]  634 	jrne	00112$
      008603 4F               [ 1]  635 	clr	a
      008604 CC 86 BC         [ 2]  636 	jp	00137$
      008607                        637 00112$:
                                    638 ;	../../my_STM8_libraries/stm8_I2C.c: 248: clearADDR_I2C();
      008607 CD 83 86         [ 4]  639 	call	_clearADDR_I2C
                                    640 ;	../../my_STM8_libraries/stm8_I2C.c: 250: if (writeByte_I2C(reg) == 0) return 0;
      00860A 7B 09            [ 1]  641 	ld	a, (0x09, sp)
      00860C CD 83 DF         [ 4]  642 	call	_writeByte_I2C
      00860F 4D               [ 1]  643 	tnz	a
      008610 26 04            [ 1]  644 	jrne	00114$
      008612 4F               [ 1]  645 	clr	a
      008613 CC 86 BC         [ 2]  646 	jp	00137$
      008616                        647 00114$:
                                    648 ;	../../my_STM8_libraries/stm8_I2C.c: 252: if (start_I2C() == 0) return 0;
      008616 CD 83 6E         [ 4]  649 	call	_start_I2C
      008619 4D               [ 1]  650 	tnz	a
      00861A 26 04            [ 1]  651 	jrne	00116$
      00861C 4F               [ 1]  652 	clr	a
      00861D CC 86 BC         [ 2]  653 	jp	00137$
      008620                        654 00116$:
                                    655 ;	../../my_STM8_libraries/stm8_I2C.c: 254: if (writeAddr_I2C(address, READ) == 0) return 0;
      008620 4B 01            [ 1]  656 	push	#0x01
      008622 7B 05            [ 1]  657 	ld	a, (0x05, sp)
      008624 CD 83 9F         [ 4]  658 	call	_writeAddr_I2C
      008627 4D               [ 1]  659 	tnz	a
      008628 26 04            [ 1]  660 	jrne	00118$
      00862A 4F               [ 1]  661 	clr	a
      00862B CC 86 BC         [ 2]  662 	jp	00137$
      00862E                        663 00118$:
                                    664 ;	../../my_STM8_libraries/stm8_I2C.c: 255: clearADDR_I2C();
      00862E CD 83 86         [ 4]  665 	call	_clearADDR_I2C
                                    666 ;	../../my_STM8_libraries/stm8_I2C.c: 257: while (size > 3)
      008631 0F 05            [ 1]  667 	clr	(0x05, sp)
      008633 7B 0C            [ 1]  668 	ld	a, (0x0c, sp)
      008635 6B 06            [ 1]  669 	ld	(0x06, sp), a
      008637                        670 00124$:
      008637 7B 06            [ 1]  671 	ld	a, (0x06, sp)
      008639 A1 03            [ 1]  672 	cp	a, #0x03
      00863B 23 2B            [ 2]  673 	jrule	00153$
                                    674 ;	../../my_STM8_libraries/stm8_I2C.c: 259: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00863D 1E 01            [ 2]  675 	ldw	x, (0x01, sp)
      00863F                        676 00121$:
      00863F 72 0C 52 17 0A   [ 2]  677 	btjt	0x5217, #6, 00123$
                                    678 ;	../../my_STM8_libraries/stm8_I2C.c: 261: if (--timeout == 0)
      008644 5A               [ 2]  679 	decw	x
      008645 5D               [ 2]  680 	tnzw	x
      008646 26 F7            [ 1]  681 	jrne	00121$
                                    682 ;	../../my_STM8_libraries/stm8_I2C.c: 263: stop_I2C();
      008648 CD 83 69         [ 4]  683 	call	_stop_I2C
                                    684 ;	../../my_STM8_libraries/stm8_I2C.c: 264: return 0;
      00864B 4F               [ 1]  685 	clr	a
      00864C 20 6E            [ 2]  686 	jra	00137$
      00864E                        687 00123$:
                                    688 ;	../../my_STM8_libraries/stm8_I2C.c: 267: timeout = 50000;
      00864E AE C3 50         [ 2]  689 	ldw	x, #0xc350
      008651 1F 01            [ 2]  690 	ldw	(0x01, sp), x
                                    691 ;	../../my_STM8_libraries/stm8_I2C.c: 268: buf[i] = I2C_DR;
      008653 5F               [ 1]  692 	clrw	x
      008654 7B 05            [ 1]  693 	ld	a, (0x05, sp)
      008656 97               [ 1]  694 	ld	xl, a
      008657 72 FB 0A         [ 2]  695 	addw	x, (0x0a, sp)
      00865A C6 52 16         [ 1]  696 	ld	a, 0x5216
      00865D F7               [ 1]  697 	ld	(x), a
                                    698 ;	../../my_STM8_libraries/stm8_I2C.c: 269: i++;
      00865E 0C 05            [ 1]  699 	inc	(0x05, sp)
      008660 7B 05            [ 1]  700 	ld	a, (0x05, sp)
      008662 6B 03            [ 1]  701 	ld	(0x03, sp), a
                                    702 ;	../../my_STM8_libraries/stm8_I2C.c: 270: size--;
      008664 0A 06            [ 1]  703 	dec	(0x06, sp)
      008666 20 CF            [ 2]  704 	jra	00124$
                                    705 ;	../../my_STM8_libraries/stm8_I2C.c: 273: while (!(I2C_SR1 & I2C_SR1_BTF))
      008668                        706 00153$:
      008668 1E 01            [ 2]  707 	ldw	x, (0x01, sp)
      00866A                        708 00129$:
      00866A 72 04 52 17 0A   [ 2]  709 	btjt	0x5217, #2, 00131$
                                    710 ;	../../my_STM8_libraries/stm8_I2C.c: 275: if (--timeout == 0)
      00866F 5A               [ 2]  711 	decw	x
      008670 5D               [ 2]  712 	tnzw	x
      008671 26 F7            [ 1]  713 	jrne	00129$
                                    714 ;	../../my_STM8_libraries/stm8_I2C.c: 277: stop_I2C();
      008673 CD 83 69         [ 4]  715 	call	_stop_I2C
                                    716 ;	../../my_STM8_libraries/stm8_I2C.c: 278: return 0;
      008676 4F               [ 1]  717 	clr	a
      008677 20 43            [ 2]  718 	jra	00137$
      008679                        719 00131$:
                                    720 ;	../../my_STM8_libraries/stm8_I2C.c: 283: setACK_I2C(LOW);
      008679 4F               [ 1]  721 	clr	a
      00867A CD 83 8D         [ 4]  722 	call	_setACK_I2C
                                    723 ;	../../my_STM8_libraries/stm8_I2C.c: 285: buf[i] = I2C_DR;
      00867D 5F               [ 1]  724 	clrw	x
      00867E 7B 03            [ 1]  725 	ld	a, (0x03, sp)
      008680 97               [ 1]  726 	ld	xl, a
      008681 72 FB 0A         [ 2]  727 	addw	x, (0x0a, sp)
      008684 C6 52 16         [ 1]  728 	ld	a, 0x5216
      008687 F7               [ 1]  729 	ld	(x), a
                                    730 ;	../../my_STM8_libraries/stm8_I2C.c: 286: i++;
      008688 7B 03            [ 1]  731 	ld	a, (0x03, sp)
      00868A 4C               [ 1]  732 	inc	a
      00868B 6B 06            [ 1]  733 	ld	(0x06, sp), a
                                    734 ;	../../my_STM8_libraries/stm8_I2C.c: 288: stop_I2C();
      00868D CD 83 69         [ 4]  735 	call	_stop_I2C
                                    736 ;	../../my_STM8_libraries/stm8_I2C.c: 290: buf[i] = I2C_DR;
      008690 5F               [ 1]  737 	clrw	x
      008691 7B 06            [ 1]  738 	ld	a, (0x06, sp)
      008693 97               [ 1]  739 	ld	xl, a
      008694 72 FB 0A         [ 2]  740 	addw	x, (0x0a, sp)
      008697 C6 52 16         [ 1]  741 	ld	a, 0x5216
      00869A F7               [ 1]  742 	ld	(x), a
                                    743 ;	../../my_STM8_libraries/stm8_I2C.c: 291: i++;
      00869B 0C 06            [ 1]  744 	inc	(0x06, sp)
                                    745 ;	../../my_STM8_libraries/stm8_I2C.c: 293: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00869D AE C3 50         [ 2]  746 	ldw	x, #0xc350
      0086A0                        747 00134$:
      0086A0 72 0C 52 17 0A   [ 2]  748 	btjt	0x5217, #6, 00136$
                                    749 ;	../../my_STM8_libraries/stm8_I2C.c: 295: if (--timeout == 0)
      0086A5 5A               [ 2]  750 	decw	x
      0086A6 5D               [ 2]  751 	tnzw	x
      0086A7 26 F7            [ 1]  752 	jrne	00134$
                                    753 ;	../../my_STM8_libraries/stm8_I2C.c: 297: stop_I2C();
      0086A9 CD 83 69         [ 4]  754 	call	_stop_I2C
                                    755 ;	../../my_STM8_libraries/stm8_I2C.c: 298: return 0;
      0086AC 4F               [ 1]  756 	clr	a
      0086AD 20 0D            [ 2]  757 	jra	00137$
      0086AF                        758 00136$:
                                    759 ;	../../my_STM8_libraries/stm8_I2C.c: 301: buf[i] = I2C_DR;
      0086AF 5F               [ 1]  760 	clrw	x
      0086B0 7B 06            [ 1]  761 	ld	a, (0x06, sp)
      0086B2 97               [ 1]  762 	ld	xl, a
      0086B3 72 FB 0A         [ 2]  763 	addw	x, (0x0a, sp)
      0086B6 C6 52 16         [ 1]  764 	ld	a, 0x5216
      0086B9 F7               [ 1]  765 	ld	(x), a
                                    766 ;	../../my_STM8_libraries/stm8_I2C.c: 303: return 1;
      0086BA A6 01            [ 1]  767 	ld	a, #0x01
      0086BC                        768 00137$:
                                    769 ;	../../my_STM8_libraries/stm8_I2C.c: 304: }
      0086BC 1E 07            [ 2]  770 	ldw	x, (7, sp)
      0086BE 5B 0C            [ 2]  771 	addw	sp, #12
      0086C0 FC               [ 2]  772 	jp	(x)
                                    773 	.area CODE
                                    774 	.area CONST
                                    775 	.area INITIALIZER
                                    776 	.area CABS (ABS)
