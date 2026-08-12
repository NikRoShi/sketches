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
      00837E                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      00837E 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      008382 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      008386 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      00838A 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      00838E 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      008392 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      008396 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      008397                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008397 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      00839B 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      00839C                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      00839C 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      0083A0 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      0083A3                         98 00103$:
      0083A3 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      0083A8 5A               [ 2]  101 	decw	x
      0083A9 5D               [ 2]  102 	tnzw	x
      0083AA 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      0083AC CD 83 97         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      0083AF 4F               [ 1]  107 	clr	a
      0083B0 81               [ 4]  108 	ret
      0083B1                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      0083B1 A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      0083B3 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      0083B4                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      0083B4 C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      0083B7 C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      0083BA 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      0083BB                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      0083BB 97               [ 1]  131 	ld	xl, a
      0083BC 4D               [ 1]  132 	tnz	a
      0083BD 26 04            [ 1]  133 	jrne	00102$
      0083BF 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      0083C3                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      0083C3 9F               [ 1]  137 	ld	a, xl
      0083C4 4A               [ 1]  138 	dec	a
      0083C5 27 01            [ 1]  139 	jreq	00120$
      0083C7 81               [ 4]  140 	ret
      0083C8                        141 00120$:
      0083C8 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      0083CC 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      0083CD                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      0083CD 48               [ 1]  151 	sll	a
      0083CE 0D 03            [ 1]  152 	tnz	(0x03, sp)
      0083D0 26 03            [ 1]  153 	jrne	00102$
      0083D2 C7 52 16         [ 1]  154 	ld	0x5216, a
      0083D5                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      0083D5 88               [ 1]  157 	push	a
      0083D6 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      0083D8 4A               [ 1]  159 	dec	a
      0083D9 84               [ 1]  160 	pop	a
      0083DA 26 05            [ 1]  161 	jrne	00119$
      0083DC AA 01            [ 1]  162 	or	a, #0x01
      0083DE C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      0083E1                        165 00119$:
      0083E1 AE C3 50         [ 2]  166 	ldw	x, #0xc350
      0083E4                        167 00108$:
      0083E4 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      0083E9 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      0083EE 5A               [ 2]  171 	decw	x
      0083EF 5D               [ 2]  172 	tnzw	x
      0083F0 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      0083F2 CD 83 97         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      0083F5 4F               [ 1]  177 	clr	a
      0083F6 20 11            [ 2]  178 	jra	00113$
      0083F8                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      0083F8 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      0083FD A6 01            [ 1]  183 	ld	a, #0x01
      0083FF 20 08            [ 2]  184 	jra	00113$
      008401                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008401 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      008405 CD 83 97         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      008408 4F               [ 1]  191 	clr	a
      008409                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      008409 85               [ 2]  194 	popw	x
      00840A 5B 01            [ 2]  195 	addw	sp, #1
      00840C FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      00840D                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      00840D C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      008410 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      008413                        206 00105$:
      008413 C6 52 17         [ 1]  207 	ld	a, 0x5217
      008416 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      008418 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      00841D 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      008421 CD 83 97         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      008424 4F               [ 1]  216 	clr	a
      008425 81               [ 4]  217 	ret
      008426                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      008426 5A               [ 2]  220 	decw	x
      008427 5D               [ 2]  221 	tnzw	x
      008428 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      00842A CD 83 97         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      00842D 4F               [ 1]  226 	clr	a
      00842E 81               [ 4]  227 	ret
      00842F                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      00842F A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      008431 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      008432                        237 _ping_I2C:
      008432 88               [ 1]  238 	push	a
      008433 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      008435 CD 83 9C         [ 4]  241 	call	_start_I2C
      008438 4D               [ 1]  242 	tnz	a
      008439 26 03            [ 1]  243 	jrne	00102$
      00843B 4F               [ 1]  244 	clr	a
      00843C 20 15            [ 2]  245 	jra	00105$
      00843E                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00843E 4B 00            [ 1]  248 	push	#0x00
      008440 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      008442 CD 83 CD         [ 4]  250 	call	_writeAddr_I2C
      008445 4D               [ 1]  251 	tnz	a
      008446 26 03            [ 1]  252 	jrne	00104$
      008448 4F               [ 1]  253 	clr	a
      008449 20 08            [ 2]  254 	jra	00105$
      00844B                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      00844B CD 83 B4         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      00844E CD 83 97         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      008451 A6 01            [ 1]  261 	ld	a, #0x01
      008453                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      008453 5B 01            [ 2]  264 	addw	sp, #1
      008455 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      008456                        270 _writeReg_I2C:
      008456 88               [ 1]  271 	push	a
      008457 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      008459 CD 83 9C         [ 4]  274 	call	_start_I2C
      00845C 4D               [ 1]  275 	tnz	a
      00845D 26 03            [ 1]  276 	jrne	00102$
      00845F 4F               [ 1]  277 	clr	a
      008460 20 2B            [ 2]  278 	jra	00109$
      008462                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008462 4B 00            [ 1]  281 	push	#0x00
      008464 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      008466 CD 83 CD         [ 4]  283 	call	_writeAddr_I2C
      008469 4D               [ 1]  284 	tnz	a
      00846A 26 03            [ 1]  285 	jrne	00104$
      00846C 4F               [ 1]  286 	clr	a
      00846D 20 1E            [ 2]  287 	jra	00109$
      00846F                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      00846F CD 83 B4         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      008472 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      008474 CD 84 0D         [ 4]  293 	call	_writeByte_I2C
      008477 4D               [ 1]  294 	tnz	a
      008478 26 03            [ 1]  295 	jrne	00106$
      00847A 4F               [ 1]  296 	clr	a
      00847B 20 10            [ 2]  297 	jra	00109$
      00847D                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      00847D 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      00847F CD 84 0D         [ 4]  301 	call	_writeByte_I2C
      008482 4D               [ 1]  302 	tnz	a
      008483 26 03            [ 1]  303 	jrne	00108$
      008485 4F               [ 1]  304 	clr	a
      008486 20 05            [ 2]  305 	jra	00109$
      008488                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      008488 CD 83 97         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      00848B A6 01            [ 1]  310 	ld	a, #0x01
      00848D                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      00848D 1E 02            [ 2]  313 	ldw	x, (2, sp)
      00848F 5B 05            [ 2]  314 	addw	sp, #5
      008491 FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      008492                        320 _readByte_I2C:
      008492 52 03            [ 2]  321 	sub	sp, #3
      008494 6B 03            [ 1]  322 	ld	(0x03, sp), a
      008496 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: setACK_I2C(HIGH);
      008498 A6 01            [ 1]  325 	ld	a, #0x01
      00849A CD 83 BB         [ 4]  326 	call	_setACK_I2C
                                    327 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (start_I2C() == 0) return 0;
      00849D CD 83 9C         [ 4]  328 	call	_start_I2C
      0084A0 4D               [ 1]  329 	tnz	a
      0084A1 26 03            [ 1]  330 	jrne	00102$
      0084A3 4F               [ 1]  331 	clr	a
      0084A4 20 31            [ 2]  332 	jra	00110$
      0084A6                        333 00102$:
                                    334 ;	../../my_STM8_libraries/stm8_I2C.c: 129: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084A6 4B 01            [ 1]  335 	push	#0x01
      0084A8 7B 04            [ 1]  336 	ld	a, (0x04, sp)
      0084AA CD 83 CD         [ 4]  337 	call	_writeAddr_I2C
      0084AD 4D               [ 1]  338 	tnz	a
      0084AE 26 03            [ 1]  339 	jrne	00104$
      0084B0 4F               [ 1]  340 	clr	a
      0084B1 20 24            [ 2]  341 	jra	00110$
      0084B3                        342 00104$:
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: setACK_I2C(LOW);
      0084B3 4F               [ 1]  344 	clr	a
      0084B4 CD 83 BB         [ 4]  345 	call	_setACK_I2C
                                    346 ;	../../my_STM8_libraries/stm8_I2C.c: 133: clearADDR_I2C();
      0084B7 CD 83 B4         [ 4]  347 	call	_clearADDR_I2C
                                    348 ;	../../my_STM8_libraries/stm8_I2C.c: 135: stop_I2C();
      0084BA CD 83 97         [ 4]  349 	call	_stop_I2C
                                    350 ;	../../my_STM8_libraries/stm8_I2C.c: 137: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0084BD AE C3 50         [ 2]  351 	ldw	x, #0xc350
      0084C0                        352 00107$:
      0084C0 72 0C 52 17 0A   [ 2]  353 	btjt	0x5217, #6, 00109$
                                    354 ;	../../my_STM8_libraries/stm8_I2C.c: 139: if (--timeout == 0) 
      0084C5 5A               [ 2]  355 	decw	x
      0084C6 5D               [ 2]  356 	tnzw	x
      0084C7 26 F7            [ 1]  357 	jrne	00107$
                                    358 ;	../../my_STM8_libraries/stm8_I2C.c: 141: stop_I2C();
      0084C9 CD 83 97         [ 4]  359 	call	_stop_I2C
                                    360 ;	../../my_STM8_libraries/stm8_I2C.c: 142: return 0;
      0084CC 4F               [ 1]  361 	clr	a
      0084CD 20 08            [ 2]  362 	jra	00110$
      0084CF                        363 00109$:
                                    364 ;	../../my_STM8_libraries/stm8_I2C.c: 145: *data = I2C_DR;
      0084CF C6 52 16         [ 1]  365 	ld	a, 0x5216
      0084D2 1E 01            [ 2]  366 	ldw	x, (0x01, sp)
      0084D4 F7               [ 1]  367 	ld	(x), a
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      0084D5 A6 01            [ 1]  369 	ld	a, #0x01
      0084D7                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      0084D7 5B 03            [ 2]  372 	addw	sp, #3
      0084D9 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      0084DA                        378 _readReg_I2C:
      0084DA 88               [ 1]  379 	push	a
      0084DB 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: setACK_I2C(HIGH);
      0084DD A6 01            [ 1]  382 	ld	a, #0x01
      0084DF CD 83 BB         [ 4]  383 	call	_setACK_I2C
                                    384 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (start_I2C() == 0) return 0;
      0084E2 CD 83 9C         [ 4]  385 	call	_start_I2C
      0084E5 4D               [ 1]  386 	tnz	a
      0084E6 26 03            [ 1]  387 	jrne	00102$
      0084E8 4F               [ 1]  388 	clr	a
      0084E9 20 55            [ 2]  389 	jra	00116$
      0084EB                        390 00102$:
                                    391 ;	../../my_STM8_libraries/stm8_I2C.c: 157: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0084EB 4B 00            [ 1]  392 	push	#0x00
      0084ED 7B 02            [ 1]  393 	ld	a, (0x02, sp)
      0084EF CD 83 CD         [ 4]  394 	call	_writeAddr_I2C
      0084F2 4D               [ 1]  395 	tnz	a
      0084F3 26 03            [ 1]  396 	jrne	00104$
      0084F5 4F               [ 1]  397 	clr	a
      0084F6 20 48            [ 2]  398 	jra	00116$
      0084F8                        399 00104$:
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 159: clearADDR_I2C();
      0084F8 CD 83 B4         [ 4]  401 	call	_clearADDR_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (writeByte_I2C(reg) == 0) return 0;
      0084FB 7B 04            [ 1]  403 	ld	a, (0x04, sp)
      0084FD CD 84 0D         [ 4]  404 	call	_writeByte_I2C
      008500 4D               [ 1]  405 	tnz	a
      008501 26 03            [ 1]  406 	jrne	00106$
      008503 4F               [ 1]  407 	clr	a
      008504 20 3A            [ 2]  408 	jra	00116$
      008506                        409 00106$:
                                    410 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (start_I2C() == 0) return 0;
      008506 CD 83 9C         [ 4]  411 	call	_start_I2C
      008509 4D               [ 1]  412 	tnz	a
      00850A 26 03            [ 1]  413 	jrne	00108$
      00850C 4F               [ 1]  414 	clr	a
      00850D 20 31            [ 2]  415 	jra	00116$
      00850F                        416 00108$:
                                    417 ;	../../my_STM8_libraries/stm8_I2C.c: 165: if (writeAddr_I2C(address, READ) == 0) return 0;
      00850F 4B 01            [ 1]  418 	push	#0x01
      008511 7B 02            [ 1]  419 	ld	a, (0x02, sp)
      008513 CD 83 CD         [ 4]  420 	call	_writeAddr_I2C
      008516 4D               [ 1]  421 	tnz	a
      008517 26 03            [ 1]  422 	jrne	00110$
      008519 4F               [ 1]  423 	clr	a
      00851A 20 24            [ 2]  424 	jra	00116$
      00851C                        425 00110$:
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: setACK_I2C(LOW);
      00851C 4F               [ 1]  427 	clr	a
      00851D CD 83 BB         [ 4]  428 	call	_setACK_I2C
                                    429 ;	../../my_STM8_libraries/stm8_I2C.c: 169: clearADDR_I2C();
      008520 CD 83 B4         [ 4]  430 	call	_clearADDR_I2C
                                    431 ;	../../my_STM8_libraries/stm8_I2C.c: 171: stop_I2C();
      008523 CD 83 97         [ 4]  432 	call	_stop_I2C
                                    433 ;	../../my_STM8_libraries/stm8_I2C.c: 173: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008526 AE C3 50         [ 2]  434 	ldw	x, #0xc350
      008529                        435 00113$:
      008529 72 0C 52 17 0A   [ 2]  436 	btjt	0x5217, #6, 00115$
                                    437 ;	../../my_STM8_libraries/stm8_I2C.c: 175: if (--timeout == 0)
      00852E 5A               [ 2]  438 	decw	x
      00852F 5D               [ 2]  439 	tnzw	x
      008530 26 F7            [ 1]  440 	jrne	00113$
                                    441 ;	../../my_STM8_libraries/stm8_I2C.c: 177: stop_I2C();
      008532 CD 83 97         [ 4]  442 	call	_stop_I2C
                                    443 ;	../../my_STM8_libraries/stm8_I2C.c: 178: return 0;
      008535 4F               [ 1]  444 	clr	a
      008536 20 08            [ 2]  445 	jra	00116$
      008538                        446 00115$:
                                    447 ;	../../my_STM8_libraries/stm8_I2C.c: 181: *data = I2C_DR;
      008538 1E 05            [ 2]  448 	ldw	x, (0x05, sp)
      00853A C6 52 16         [ 1]  449 	ld	a, 0x5216
      00853D F7               [ 1]  450 	ld	(x), a
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      00853E A6 01            [ 1]  452 	ld	a, #0x01
      008540                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      008540 1E 02            [ 2]  455 	ldw	x, (2, sp)
      008542 5B 06            [ 2]  456 	addw	sp, #6
      008544 FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      008545                        462 _readBuffer2_I2C:
      008545 52 05            [ 2]  463 	sub	sp, #5
      008547 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      008549 AE C3 50         [ 2]  466 	ldw	x, #0xc350
      00854C 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: setACK_I2C(HIGH);
      00854E A6 01            [ 1]  469 	ld	a, #0x01
      008550 CD 83 BB         [ 4]  470 	call	_setACK_I2C
                                    471 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (start_I2C() == 0) return 0;
      008553 CD 83 9C         [ 4]  472 	call	_start_I2C
      008556 4D               [ 1]  473 	tnz	a
      008557 26 03            [ 1]  474 	jrne	00102$
      008559 4F               [ 1]  475 	clr	a
      00855A 20 73            [ 2]  476 	jra	00121$
      00855C                        477 00102$:
                                    478 ;	../../my_STM8_libraries/stm8_I2C.c: 193: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00855C 4B 00            [ 1]  479 	push	#0x00
      00855E 7B 06            [ 1]  480 	ld	a, (0x06, sp)
      008560 CD 83 CD         [ 4]  481 	call	_writeAddr_I2C
      008563 4D               [ 1]  482 	tnz	a
      008564 26 03            [ 1]  483 	jrne	00104$
      008566 4F               [ 1]  484 	clr	a
      008567 20 66            [ 2]  485 	jra	00121$
      008569                        486 00104$:
                                    487 ;	../../my_STM8_libraries/stm8_I2C.c: 194: clearADDR_I2C();
      008569 CD 83 B4         [ 4]  488 	call	_clearADDR_I2C
                                    489 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (writeByte_I2C(reg) == 0) return 0;
      00856C 7B 08            [ 1]  490 	ld	a, (0x08, sp)
      00856E CD 84 0D         [ 4]  491 	call	_writeByte_I2C
      008571 4D               [ 1]  492 	tnz	a
      008572 26 03            [ 1]  493 	jrne	00106$
      008574 4F               [ 1]  494 	clr	a
      008575 20 58            [ 2]  495 	jra	00121$
      008577                        496 00106$:
                                    497 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (start_I2C() == 0) return 0;
      008577 CD 83 9C         [ 4]  498 	call	_start_I2C
      00857A 4D               [ 1]  499 	tnz	a
      00857B 26 03            [ 1]  500 	jrne	00108$
      00857D 4F               [ 1]  501 	clr	a
      00857E 20 4F            [ 2]  502 	jra	00121$
      008580                        503 00108$:
                                    504 ;	../../my_STM8_libraries/stm8_I2C.c: 200: if (writeAddr_I2C(address, READ) == 0) return 0;
      008580 4B 01            [ 1]  505 	push	#0x01
      008582 7B 06            [ 1]  506 	ld	a, (0x06, sp)
      008584 CD 83 CD         [ 4]  507 	call	_writeAddr_I2C
      008587 4D               [ 1]  508 	tnz	a
      008588 26 03            [ 1]  509 	jrne	00110$
      00858A 4F               [ 1]  510 	clr	a
      00858B 20 42            [ 2]  511 	jra	00121$
      00858D                        512 00110$:
                                    513 ;	../../my_STM8_libraries/stm8_I2C.c: 201: clearADDR_I2C();
      00858D CD 83 B4         [ 4]  514 	call	_clearADDR_I2C
                                    515 ;	../../my_STM8_libraries/stm8_I2C.c: 203: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008590 AE C3 50         [ 2]  516 	ldw	x, #0xc350
      008593                        517 00113$:
      008593 72 0C 52 17 0C   [ 2]  518 	btjt	0x5217, #6, 00115$
                                    519 ;	../../my_STM8_libraries/stm8_I2C.c: 205: if (--timeout == 0)
      008598 5A               [ 2]  520 	decw	x
      008599 1F 01            [ 2]  521 	ldw	(0x01, sp), x
      00859B 5D               [ 2]  522 	tnzw	x
      00859C 26 F5            [ 1]  523 	jrne	00113$
                                    524 ;	../../my_STM8_libraries/stm8_I2C.c: 207: stop_I2C();
      00859E CD 83 97         [ 4]  525 	call	_stop_I2C
                                    526 ;	../../my_STM8_libraries/stm8_I2C.c: 208: return 0;
      0085A1 4F               [ 1]  527 	clr	a
      0085A2 20 2B            [ 2]  528 	jra	00121$
      0085A4                        529 00115$:
                                    530 ;	../../my_STM8_libraries/stm8_I2C.c: 211: buf[0] = I2C_DR;
      0085A4 16 09            [ 2]  531 	ldw	y, (0x09, sp)
      0085A6 17 03            [ 2]  532 	ldw	(0x03, sp), y
      0085A8 C6 52 16         [ 1]  533 	ld	a, 0x5216
      0085AB 1E 03            [ 2]  534 	ldw	x, (0x03, sp)
      0085AD F7               [ 1]  535 	ld	(x), a
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: setACK_I2C(LOW);
      0085AE 4F               [ 1]  537 	clr	a
      0085AF CD 83 BB         [ 4]  538 	call	_setACK_I2C
                                    539 ;	../../my_STM8_libraries/stm8_I2C.c: 214: while (!(I2C_SR1 & I2C_SR1_BTF))
      0085B2 1E 01            [ 2]  540 	ldw	x, (0x01, sp)
      0085B4                        541 00118$:
      0085B4 72 04 52 17 0A   [ 2]  542 	btjt	0x5217, #2, 00120$
                                    543 ;	../../my_STM8_libraries/stm8_I2C.c: 216: if (--timeout == 0)
      0085B9 5A               [ 2]  544 	decw	x
      0085BA 5D               [ 2]  545 	tnzw	x
      0085BB 26 F7            [ 1]  546 	jrne	00118$
                                    547 ;	../../my_STM8_libraries/stm8_I2C.c: 218: stop_I2C();
      0085BD CD 83 97         [ 4]  548 	call	_stop_I2C
                                    549 ;	../../my_STM8_libraries/stm8_I2C.c: 219: return 0;
      0085C0 4F               [ 1]  550 	clr	a
      0085C1 20 0C            [ 2]  551 	jra	00121$
      0085C3                        552 00120$:
                                    553 ;	../../my_STM8_libraries/stm8_I2C.c: 222: stop_I2C();
      0085C3 CD 83 97         [ 4]  554 	call	_stop_I2C
                                    555 ;	../../my_STM8_libraries/stm8_I2C.c: 224: buf[1] = I2C_DR;
      0085C6 1E 03            [ 2]  556 	ldw	x, (0x03, sp)
      0085C8 5C               [ 1]  557 	incw	x
      0085C9 C6 52 16         [ 1]  558 	ld	a, 0x5216
      0085CC F7               [ 1]  559 	ld	(x), a
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      0085CD A6 01            [ 1]  561 	ld	a, #0x01
      0085CF                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      0085CF 1E 06            [ 2]  564 	ldw	x, (6, sp)
      0085D1 5B 0A            [ 2]  565 	addw	sp, #10
      0085D3 FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      0085D4                        571 _readBuffer_I2C:
      0085D4 52 06            [ 2]  572 	sub	sp, #6
      0085D6 6B 04            [ 1]  573 	ld	(0x04, sp), a
                                    574 ;	../../my_STM8_libraries/stm8_I2C.c: 230: uint16_t timeout = 50000;
      0085D8 AE C3 50         [ 2]  575 	ldw	x, #0xc350
      0085DB 1F 01            [ 2]  576 	ldw	(0x01, sp), x
                                    577 ;	../../my_STM8_libraries/stm8_I2C.c: 231: uint8_t i = 0;
      0085DD 0F 03            [ 1]  578 	clr	(0x03, sp)
                                    579 ;	../../my_STM8_libraries/stm8_I2C.c: 233: setACK_I2C(HIGH);
      0085DF A6 01            [ 1]  580 	ld	a, #0x01
      0085E1 CD 83 BB         [ 4]  581 	call	_setACK_I2C
                                    582 ;	../../my_STM8_libraries/stm8_I2C.c: 235: if (size == 1) 
      0085E4 7B 0C            [ 1]  583 	ld	a, (0x0c, sp)
      0085E6 4A               [ 1]  584 	dec	a
      0085E7 26 17            [ 1]  585 	jrne	00104$
                                    586 ;	../../my_STM8_libraries/stm8_I2C.c: 237: if (readReg_I2C(address, reg, buf) == 0) return 0;
      0085E9 1E 0A            [ 2]  587 	ldw	x, (0x0a, sp)
      0085EB 89               [ 2]  588 	pushw	x
      0085EC 7B 0B            [ 1]  589 	ld	a, (0x0b, sp)
      0085EE 88               [ 1]  590 	push	a
      0085EF 7B 07            [ 1]  591 	ld	a, (0x07, sp)
      0085F1 CD 84 DA         [ 4]  592 	call	_readReg_I2C
      0085F4 4D               [ 1]  593 	tnz	a
      0085F5 26 04            [ 1]  594 	jrne	00102$
      0085F7 4F               [ 1]  595 	clr	a
      0085F8 CC 86 EA         [ 2]  596 	jp	00137$
      0085FB                        597 00102$:
                                    598 ;	../../my_STM8_libraries/stm8_I2C.c: 238: return 1;
      0085FB A6 01            [ 1]  599 	ld	a, #0x01
      0085FD CC 86 EA         [ 2]  600 	jp	00137$
      008600                        601 00104$:
                                    602 ;	../../my_STM8_libraries/stm8_I2C.c: 240: if (size == 2)
      008600 7B 0C            [ 1]  603 	ld	a, (0x0c, sp)
      008602 A1 02            [ 1]  604 	cp	a, #0x02
      008604 26 17            [ 1]  605 	jrne	00108$
                                    606 ;	../../my_STM8_libraries/stm8_I2C.c: 242: if (readBuffer2_I2C(address, reg, buf) == 0) return 0;
      008606 1E 0A            [ 2]  607 	ldw	x, (0x0a, sp)
      008608 89               [ 2]  608 	pushw	x
      008609 7B 0B            [ 1]  609 	ld	a, (0x0b, sp)
      00860B 88               [ 1]  610 	push	a
      00860C 7B 07            [ 1]  611 	ld	a, (0x07, sp)
      00860E CD 85 45         [ 4]  612 	call	_readBuffer2_I2C
      008611 4D               [ 1]  613 	tnz	a
      008612 26 04            [ 1]  614 	jrne	00106$
      008614 4F               [ 1]  615 	clr	a
      008615 CC 86 EA         [ 2]  616 	jp	00137$
      008618                        617 00106$:
                                    618 ;	../../my_STM8_libraries/stm8_I2C.c: 243: return 1;
      008618 A6 01            [ 1]  619 	ld	a, #0x01
      00861A CC 86 EA         [ 2]  620 	jp	00137$
      00861D                        621 00108$:
                                    622 ;	../../my_STM8_libraries/stm8_I2C.c: 245: if (start_I2C() == 0) return 0;
      00861D CD 83 9C         [ 4]  623 	call	_start_I2C
      008620 4D               [ 1]  624 	tnz	a
      008621 26 04            [ 1]  625 	jrne	00110$
      008623 4F               [ 1]  626 	clr	a
      008624 CC 86 EA         [ 2]  627 	jp	00137$
      008627                        628 00110$:
                                    629 ;	../../my_STM8_libraries/stm8_I2C.c: 247: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008627 4B 00            [ 1]  630 	push	#0x00
      008629 7B 05            [ 1]  631 	ld	a, (0x05, sp)
      00862B CD 83 CD         [ 4]  632 	call	_writeAddr_I2C
      00862E 4D               [ 1]  633 	tnz	a
      00862F 26 04            [ 1]  634 	jrne	00112$
      008631 4F               [ 1]  635 	clr	a
      008632 CC 86 EA         [ 2]  636 	jp	00137$
      008635                        637 00112$:
                                    638 ;	../../my_STM8_libraries/stm8_I2C.c: 248: clearADDR_I2C();
      008635 CD 83 B4         [ 4]  639 	call	_clearADDR_I2C
                                    640 ;	../../my_STM8_libraries/stm8_I2C.c: 250: if (writeByte_I2C(reg) == 0) return 0;
      008638 7B 09            [ 1]  641 	ld	a, (0x09, sp)
      00863A CD 84 0D         [ 4]  642 	call	_writeByte_I2C
      00863D 4D               [ 1]  643 	tnz	a
      00863E 26 04            [ 1]  644 	jrne	00114$
      008640 4F               [ 1]  645 	clr	a
      008641 CC 86 EA         [ 2]  646 	jp	00137$
      008644                        647 00114$:
                                    648 ;	../../my_STM8_libraries/stm8_I2C.c: 252: if (start_I2C() == 0) return 0;
      008644 CD 83 9C         [ 4]  649 	call	_start_I2C
      008647 4D               [ 1]  650 	tnz	a
      008648 26 04            [ 1]  651 	jrne	00116$
      00864A 4F               [ 1]  652 	clr	a
      00864B CC 86 EA         [ 2]  653 	jp	00137$
      00864E                        654 00116$:
                                    655 ;	../../my_STM8_libraries/stm8_I2C.c: 254: if (writeAddr_I2C(address, READ) == 0) return 0;
      00864E 4B 01            [ 1]  656 	push	#0x01
      008650 7B 05            [ 1]  657 	ld	a, (0x05, sp)
      008652 CD 83 CD         [ 4]  658 	call	_writeAddr_I2C
      008655 4D               [ 1]  659 	tnz	a
      008656 26 04            [ 1]  660 	jrne	00118$
      008658 4F               [ 1]  661 	clr	a
      008659 CC 86 EA         [ 2]  662 	jp	00137$
      00865C                        663 00118$:
                                    664 ;	../../my_STM8_libraries/stm8_I2C.c: 255: clearADDR_I2C();
      00865C CD 83 B4         [ 4]  665 	call	_clearADDR_I2C
                                    666 ;	../../my_STM8_libraries/stm8_I2C.c: 257: while (size > 3)
      00865F 0F 05            [ 1]  667 	clr	(0x05, sp)
      008661 7B 0C            [ 1]  668 	ld	a, (0x0c, sp)
      008663 6B 06            [ 1]  669 	ld	(0x06, sp), a
      008665                        670 00124$:
      008665 7B 06            [ 1]  671 	ld	a, (0x06, sp)
      008667 A1 03            [ 1]  672 	cp	a, #0x03
      008669 23 2B            [ 2]  673 	jrule	00153$
                                    674 ;	../../my_STM8_libraries/stm8_I2C.c: 259: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00866B 1E 01            [ 2]  675 	ldw	x, (0x01, sp)
      00866D                        676 00121$:
      00866D 72 0C 52 17 0A   [ 2]  677 	btjt	0x5217, #6, 00123$
                                    678 ;	../../my_STM8_libraries/stm8_I2C.c: 261: if (--timeout == 0)
      008672 5A               [ 2]  679 	decw	x
      008673 5D               [ 2]  680 	tnzw	x
      008674 26 F7            [ 1]  681 	jrne	00121$
                                    682 ;	../../my_STM8_libraries/stm8_I2C.c: 263: stop_I2C();
      008676 CD 83 97         [ 4]  683 	call	_stop_I2C
                                    684 ;	../../my_STM8_libraries/stm8_I2C.c: 264: return 0;
      008679 4F               [ 1]  685 	clr	a
      00867A 20 6E            [ 2]  686 	jra	00137$
      00867C                        687 00123$:
                                    688 ;	../../my_STM8_libraries/stm8_I2C.c: 267: timeout = 50000;
      00867C AE C3 50         [ 2]  689 	ldw	x, #0xc350
      00867F 1F 01            [ 2]  690 	ldw	(0x01, sp), x
                                    691 ;	../../my_STM8_libraries/stm8_I2C.c: 268: buf[i] = I2C_DR;
      008681 5F               [ 1]  692 	clrw	x
      008682 7B 05            [ 1]  693 	ld	a, (0x05, sp)
      008684 97               [ 1]  694 	ld	xl, a
      008685 72 FB 0A         [ 2]  695 	addw	x, (0x0a, sp)
      008688 C6 52 16         [ 1]  696 	ld	a, 0x5216
      00868B F7               [ 1]  697 	ld	(x), a
                                    698 ;	../../my_STM8_libraries/stm8_I2C.c: 269: i++;
      00868C 0C 05            [ 1]  699 	inc	(0x05, sp)
      00868E 7B 05            [ 1]  700 	ld	a, (0x05, sp)
      008690 6B 03            [ 1]  701 	ld	(0x03, sp), a
                                    702 ;	../../my_STM8_libraries/stm8_I2C.c: 270: size--;
      008692 0A 06            [ 1]  703 	dec	(0x06, sp)
      008694 20 CF            [ 2]  704 	jra	00124$
                                    705 ;	../../my_STM8_libraries/stm8_I2C.c: 273: while (!(I2C_SR1 & I2C_SR1_BTF))
      008696                        706 00153$:
      008696 1E 01            [ 2]  707 	ldw	x, (0x01, sp)
      008698                        708 00129$:
      008698 72 04 52 17 0A   [ 2]  709 	btjt	0x5217, #2, 00131$
                                    710 ;	../../my_STM8_libraries/stm8_I2C.c: 275: if (--timeout == 0)
      00869D 5A               [ 2]  711 	decw	x
      00869E 5D               [ 2]  712 	tnzw	x
      00869F 26 F7            [ 1]  713 	jrne	00129$
                                    714 ;	../../my_STM8_libraries/stm8_I2C.c: 277: stop_I2C();
      0086A1 CD 83 97         [ 4]  715 	call	_stop_I2C
                                    716 ;	../../my_STM8_libraries/stm8_I2C.c: 278: return 0;
      0086A4 4F               [ 1]  717 	clr	a
      0086A5 20 43            [ 2]  718 	jra	00137$
      0086A7                        719 00131$:
                                    720 ;	../../my_STM8_libraries/stm8_I2C.c: 283: setACK_I2C(LOW);
      0086A7 4F               [ 1]  721 	clr	a
      0086A8 CD 83 BB         [ 4]  722 	call	_setACK_I2C
                                    723 ;	../../my_STM8_libraries/stm8_I2C.c: 285: buf[i] = I2C_DR;
      0086AB 5F               [ 1]  724 	clrw	x
      0086AC 7B 03            [ 1]  725 	ld	a, (0x03, sp)
      0086AE 97               [ 1]  726 	ld	xl, a
      0086AF 72 FB 0A         [ 2]  727 	addw	x, (0x0a, sp)
      0086B2 C6 52 16         [ 1]  728 	ld	a, 0x5216
      0086B5 F7               [ 1]  729 	ld	(x), a
                                    730 ;	../../my_STM8_libraries/stm8_I2C.c: 286: i++;
      0086B6 7B 03            [ 1]  731 	ld	a, (0x03, sp)
      0086B8 4C               [ 1]  732 	inc	a
      0086B9 6B 06            [ 1]  733 	ld	(0x06, sp), a
                                    734 ;	../../my_STM8_libraries/stm8_I2C.c: 288: stop_I2C();
      0086BB CD 83 97         [ 4]  735 	call	_stop_I2C
                                    736 ;	../../my_STM8_libraries/stm8_I2C.c: 290: buf[i] = I2C_DR;
      0086BE 5F               [ 1]  737 	clrw	x
      0086BF 7B 06            [ 1]  738 	ld	a, (0x06, sp)
      0086C1 97               [ 1]  739 	ld	xl, a
      0086C2 72 FB 0A         [ 2]  740 	addw	x, (0x0a, sp)
      0086C5 C6 52 16         [ 1]  741 	ld	a, 0x5216
      0086C8 F7               [ 1]  742 	ld	(x), a
                                    743 ;	../../my_STM8_libraries/stm8_I2C.c: 291: i++;
      0086C9 0C 06            [ 1]  744 	inc	(0x06, sp)
                                    745 ;	../../my_STM8_libraries/stm8_I2C.c: 293: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0086CB AE C3 50         [ 2]  746 	ldw	x, #0xc350
      0086CE                        747 00134$:
      0086CE 72 0C 52 17 0A   [ 2]  748 	btjt	0x5217, #6, 00136$
                                    749 ;	../../my_STM8_libraries/stm8_I2C.c: 295: if (--timeout == 0)
      0086D3 5A               [ 2]  750 	decw	x
      0086D4 5D               [ 2]  751 	tnzw	x
      0086D5 26 F7            [ 1]  752 	jrne	00134$
                                    753 ;	../../my_STM8_libraries/stm8_I2C.c: 297: stop_I2C();
      0086D7 CD 83 97         [ 4]  754 	call	_stop_I2C
                                    755 ;	../../my_STM8_libraries/stm8_I2C.c: 298: return 0;
      0086DA 4F               [ 1]  756 	clr	a
      0086DB 20 0D            [ 2]  757 	jra	00137$
      0086DD                        758 00136$:
                                    759 ;	../../my_STM8_libraries/stm8_I2C.c: 301: buf[i] = I2C_DR;
      0086DD 5F               [ 1]  760 	clrw	x
      0086DE 7B 06            [ 1]  761 	ld	a, (0x06, sp)
      0086E0 97               [ 1]  762 	ld	xl, a
      0086E1 72 FB 0A         [ 2]  763 	addw	x, (0x0a, sp)
      0086E4 C6 52 16         [ 1]  764 	ld	a, 0x5216
      0086E7 F7               [ 1]  765 	ld	(x), a
                                    766 ;	../../my_STM8_libraries/stm8_I2C.c: 303: return 1;
      0086E8 A6 01            [ 1]  767 	ld	a, #0x01
      0086EA                        768 00137$:
                                    769 ;	../../my_STM8_libraries/stm8_I2C.c: 304: }
      0086EA 1E 07            [ 2]  770 	ldw	x, (7, sp)
      0086EC 5B 0C            [ 2]  771 	addw	sp, #12
      0086EE FC               [ 2]  772 	jp	(x)
                                    773 	.area CODE
                                    774 	.area CONST
                                    775 	.area INITIALIZER
                                    776 	.area CABS (ABS)
