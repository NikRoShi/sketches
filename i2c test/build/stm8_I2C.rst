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
      0082B7                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0082B7 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0082BB 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0082BF 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      0082C3 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0082C7 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0082CB 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      0082CF 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      0082D0                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0082D0 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      0082D4 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      0082D5                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      0082D5 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      0082D9 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      0082DC                         98 00103$:
      0082DC 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      0082E1 5A               [ 2]  101 	decw	x
      0082E2 5D               [ 2]  102 	tnzw	x
      0082E3 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      0082E5 CD 82 D0         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      0082E8 4F               [ 1]  107 	clr	a
      0082E9 81               [ 4]  108 	ret
      0082EA                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      0082EA A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      0082EC 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      0082ED                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      0082ED C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      0082F0 C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      0082F3 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      0082F4                        129 _setACK_I2C:
      0082F4 88               [ 1]  130 	push	a
      0082F5 6B 01            [ 1]  131 	ld	(0x01, sp), a
                                    132 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      0082F7 C6 52 11         [ 1]  133 	ld	a, 0x5211
      0082FA 0D 01            [ 1]  134 	tnz	(0x01, sp)
      0082FC 26 07            [ 1]  135 	jrne	00102$
      0082FE A4 FB            [ 1]  136 	and	a, #0xfb
      008300 C7 52 11         [ 1]  137 	ld	0x5211, a
      008303 20 05            [ 2]  138 	jra	00104$
      008305                        139 00102$:
                                    140 ;	../../my_STM8_libraries/stm8_I2C.c: 48: else I2C_CR2 |= I2C_CR2_ACK;
      008305 AA 04            [ 1]  141 	or	a, #0x04
      008307 C7 52 11         [ 1]  142 	ld	0x5211, a
      00830A                        143 00104$:
                                    144 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      00830A 84               [ 1]  145 	pop	a
      00830B 81               [ 4]  146 	ret
                                    147 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    148 ;	-----------------------------------------
                                    149 ;	 function writeAddr_I2C
                                    150 ;	-----------------------------------------
      00830C                        151 _writeAddr_I2C:
                                    152 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      00830C 48               [ 1]  153 	sll	a
      00830D 0D 03            [ 1]  154 	tnz	(0x03, sp)
      00830F 26 03            [ 1]  155 	jrne	00102$
      008311 C7 52 16         [ 1]  156 	ld	0x5216, a
      008314                        157 00102$:
                                    158 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008314 88               [ 1]  159 	push	a
      008315 7B 04            [ 1]  160 	ld	a, (0x04, sp)
      008317 4A               [ 1]  161 	dec	a
      008318 84               [ 1]  162 	pop	a
      008319 26 05            [ 1]  163 	jrne	00119$
      00831B AA 01            [ 1]  164 	or	a, #0x01
      00831D C7 52 16         [ 1]  165 	ld	0x5216, a
                                    166 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008320                        167 00119$:
      008320 AE C3 50         [ 2]  168 	ldw	x, #0xc350
      008323                        169 00108$:
      008323 72 02 52 17 0F   [ 2]  170 	btjt	0x5217, #1, 00110$
      008328 72 04 52 18 0A   [ 2]  171 	btjt	0x5218, #2, 00110$
                                    172 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      00832D 5A               [ 2]  173 	decw	x
      00832E 5D               [ 2]  174 	tnzw	x
      00832F 26 F2            [ 1]  175 	jrne	00108$
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      008331 CD 82 D0         [ 4]  177 	call	_stop_I2C
                                    178 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      008334 4F               [ 1]  179 	clr	a
      008335 20 11            [ 2]  180 	jra	00113$
      008337                        181 00110$:
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      008337 72 03 52 17 04   [ 2]  183 	btjf	0x5217, #1, 00112$
                                    184 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      00833C A6 01            [ 1]  185 	ld	a, #0x01
      00833E 20 08            [ 2]  186 	jra	00113$
      008340                        187 00112$:
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008340 72 15 52 18      [ 1]  189 	bres	0x5218, #2
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      008344 CD 82 D0         [ 4]  191 	call	_stop_I2C
                                    192 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      008347 4F               [ 1]  193 	clr	a
      008348                        194 00113$:
                                    195 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      008348 85               [ 2]  196 	popw	x
      008349 5B 01            [ 2]  197 	addw	sp, #1
      00834B FC               [ 2]  198 	jp	(x)
                                    199 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    200 ;	-----------------------------------------
                                    201 ;	 function writeByte_I2C
                                    202 ;	-----------------------------------------
      00834C                        203 _writeByte_I2C:
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      00834C C7 52 16         [ 1]  205 	ld	0x5216, a
                                    206 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      00834F AE C3 50         [ 2]  207 	ldw	x, #0xc350
      008352                        208 00105$:
      008352 C6 52 17         [ 1]  209 	ld	a, 0x5217
      008355 2B 17            [ 1]  210 	jrmi	00107$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      008357 72 05 52 18 09   [ 2]  212 	btjf	0x5218, #2, 00102$
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      00835C 72 15 52 18      [ 1]  214 	bres	0x5218, #2
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      008360 CD 82 D0         [ 4]  216 	call	_stop_I2C
                                    217 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      008363 4F               [ 1]  218 	clr	a
      008364 81               [ 4]  219 	ret
      008365                        220 00102$:
                                    221 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      008365 5A               [ 2]  222 	decw	x
      008366 5D               [ 2]  223 	tnzw	x
      008367 26 E9            [ 1]  224 	jrne	00105$
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      008369 CD 82 D0         [ 4]  226 	call	_stop_I2C
                                    227 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      00836C 4F               [ 1]  228 	clr	a
      00836D 81               [ 4]  229 	ret
      00836E                        230 00107$:
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      00836E A6 01            [ 1]  232 	ld	a, #0x01
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      008370 81               [ 4]  234 	ret
                                    235 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    236 ;	-----------------------------------------
                                    237 ;	 function ping_I2C
                                    238 ;	-----------------------------------------
      008371                        239 _ping_I2C:
      008371 88               [ 1]  240 	push	a
      008372 6B 01            [ 1]  241 	ld	(0x01, sp), a
                                    242 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      008374 CD 82 D5         [ 4]  243 	call	_start_I2C
      008377 4D               [ 1]  244 	tnz	a
      008378 26 03            [ 1]  245 	jrne	00102$
      00837A 4F               [ 1]  246 	clr	a
      00837B 20 15            [ 2]  247 	jra	00105$
      00837D                        248 00102$:
                                    249 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00837D 4B 00            [ 1]  250 	push	#0x00
      00837F 7B 02            [ 1]  251 	ld	a, (0x02, sp)
      008381 CD 83 0C         [ 4]  252 	call	_writeAddr_I2C
      008384 4D               [ 1]  253 	tnz	a
      008385 26 03            [ 1]  254 	jrne	00104$
      008387 4F               [ 1]  255 	clr	a
      008388 20 08            [ 2]  256 	jra	00105$
      00838A                        257 00104$:
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      00838A CD 82 ED         [ 4]  259 	call	_clearADDR_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      00838D CD 82 D0         [ 4]  261 	call	_stop_I2C
                                    262 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      008390 A6 01            [ 1]  263 	ld	a, #0x01
      008392                        264 00105$:
                                    265 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      008392 5B 01            [ 2]  266 	addw	sp, #1
      008394 81               [ 4]  267 	ret
                                    268 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    269 ;	-----------------------------------------
                                    270 ;	 function writeReg_I2C
                                    271 ;	-----------------------------------------
      008395                        272 _writeReg_I2C:
      008395 88               [ 1]  273 	push	a
      008396 6B 01            [ 1]  274 	ld	(0x01, sp), a
                                    275 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      008398 CD 82 D5         [ 4]  276 	call	_start_I2C
      00839B 4D               [ 1]  277 	tnz	a
      00839C 26 03            [ 1]  278 	jrne	00102$
      00839E 4F               [ 1]  279 	clr	a
      00839F 20 2B            [ 2]  280 	jra	00109$
      0083A1                        281 00102$:
                                    282 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0083A1 4B 00            [ 1]  283 	push	#0x00
      0083A3 7B 02            [ 1]  284 	ld	a, (0x02, sp)
      0083A5 CD 83 0C         [ 4]  285 	call	_writeAddr_I2C
      0083A8 4D               [ 1]  286 	tnz	a
      0083A9 26 03            [ 1]  287 	jrne	00104$
      0083AB 4F               [ 1]  288 	clr	a
      0083AC 20 1E            [ 2]  289 	jra	00109$
      0083AE                        290 00104$:
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      0083AE CD 82 ED         [ 4]  292 	call	_clearADDR_I2C
                                    293 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      0083B1 7B 04            [ 1]  294 	ld	a, (0x04, sp)
      0083B3 CD 83 4C         [ 4]  295 	call	_writeByte_I2C
      0083B6 4D               [ 1]  296 	tnz	a
      0083B7 26 03            [ 1]  297 	jrne	00106$
      0083B9 4F               [ 1]  298 	clr	a
      0083BA 20 10            [ 2]  299 	jra	00109$
      0083BC                        300 00106$:
                                    301 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      0083BC 7B 05            [ 1]  302 	ld	a, (0x05, sp)
      0083BE CD 83 4C         [ 4]  303 	call	_writeByte_I2C
      0083C1 4D               [ 1]  304 	tnz	a
      0083C2 26 03            [ 1]  305 	jrne	00108$
      0083C4 4F               [ 1]  306 	clr	a
      0083C5 20 05            [ 2]  307 	jra	00109$
      0083C7                        308 00108$:
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      0083C7 CD 82 D0         [ 4]  310 	call	_stop_I2C
                                    311 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      0083CA A6 01            [ 1]  312 	ld	a, #0x01
      0083CC                        313 00109$:
                                    314 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      0083CC 1E 02            [ 2]  315 	ldw	x, (2, sp)
      0083CE 5B 05            [ 2]  316 	addw	sp, #5
      0083D0 FC               [ 2]  317 	jp	(x)
                                    318 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    319 ;	-----------------------------------------
                                    320 ;	 function readByte_I2C
                                    321 ;	-----------------------------------------
      0083D1                        322 _readByte_I2C:
      0083D1 52 03            [ 2]  323 	sub	sp, #3
      0083D3 6B 03            [ 1]  324 	ld	(0x03, sp), a
      0083D5 1F 01            [ 2]  325 	ldw	(0x01, sp), x
                                    326 ;	../../my_STM8_libraries/stm8_I2C.c: 125: if (start_I2C() == 0) return 0;
      0083D7 CD 82 D5         [ 4]  327 	call	_start_I2C
      0083DA 4D               [ 1]  328 	tnz	a
      0083DB 26 03            [ 1]  329 	jrne	00102$
      0083DD 4F               [ 1]  330 	clr	a
      0083DE 20 36            [ 2]  331 	jra	00110$
      0083E0                        332 00102$:
                                    333 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083E0 4B 01            [ 1]  334 	push	#0x01
      0083E2 7B 04            [ 1]  335 	ld	a, (0x04, sp)
      0083E4 CD 83 0C         [ 4]  336 	call	_writeAddr_I2C
      0083E7 4D               [ 1]  337 	tnz	a
      0083E8 26 03            [ 1]  338 	jrne	00104$
      0083EA 4F               [ 1]  339 	clr	a
      0083EB 20 29            [ 2]  340 	jra	00110$
      0083ED                        341 00104$:
                                    342 ;	../../my_STM8_libraries/stm8_I2C.c: 129: setACK_I2C(LOW);
      0083ED 4F               [ 1]  343 	clr	a
      0083EE CD 82 F4         [ 4]  344 	call	_setACK_I2C
                                    345 ;	../../my_STM8_libraries/stm8_I2C.c: 131: clearADDR_I2C();
      0083F1 CD 82 ED         [ 4]  346 	call	_clearADDR_I2C
                                    347 ;	../../my_STM8_libraries/stm8_I2C.c: 133: stop_I2C();
      0083F4 CD 82 D0         [ 4]  348 	call	_stop_I2C
                                    349 ;	../../my_STM8_libraries/stm8_I2C.c: 135: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083F7 AE C3 50         [ 2]  350 	ldw	x, #0xc350
      0083FA                        351 00107$:
      0083FA 72 0C 52 17 0A   [ 2]  352 	btjt	0x5217, #6, 00109$
                                    353 ;	../../my_STM8_libraries/stm8_I2C.c: 137: if (--timeout == 0) 
      0083FF 5A               [ 2]  354 	decw	x
      008400 5D               [ 2]  355 	tnzw	x
      008401 26 F7            [ 1]  356 	jrne	00107$
                                    357 ;	../../my_STM8_libraries/stm8_I2C.c: 139: stop_I2C();
      008403 CD 82 D0         [ 4]  358 	call	_stop_I2C
                                    359 ;	../../my_STM8_libraries/stm8_I2C.c: 140: return 0;
      008406 4F               [ 1]  360 	clr	a
      008407 20 0D            [ 2]  361 	jra	00110$
      008409                        362 00109$:
                                    363 ;	../../my_STM8_libraries/stm8_I2C.c: 143: *data = I2C_DR;
      008409 C6 52 16         [ 1]  364 	ld	a, 0x5216
      00840C 1E 01            [ 2]  365 	ldw	x, (0x01, sp)
      00840E F7               [ 1]  366 	ld	(x), a
                                    367 ;	../../my_STM8_libraries/stm8_I2C.c: 145: setACK_I2C(HIGH);
      00840F A6 01            [ 1]  368 	ld	a, #0x01
      008411 CD 82 F4         [ 4]  369 	call	_setACK_I2C
                                    370 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      008414 A6 01            [ 1]  371 	ld	a, #0x01
      008416                        372 00110$:
                                    373 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      008416 5B 03            [ 2]  374 	addw	sp, #3
      008418 81               [ 4]  375 	ret
                                    376 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    377 ;	-----------------------------------------
                                    378 ;	 function readReg_I2C
                                    379 ;	-----------------------------------------
      008419                        380 _readReg_I2C:
      008419 88               [ 1]  381 	push	a
      00841A 6B 01            [ 1]  382 	ld	(0x01, sp), a
                                    383 ;	../../my_STM8_libraries/stm8_I2C.c: 153: if (start_I2C() == 0) return 0;
      00841C CD 82 D5         [ 4]  384 	call	_start_I2C
      00841F 4D               [ 1]  385 	tnz	a
      008420 26 03            [ 1]  386 	jrne	00102$
      008422 4F               [ 1]  387 	clr	a
      008423 20 5A            [ 2]  388 	jra	00116$
      008425                        389 00102$:
                                    390 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008425 4B 00            [ 1]  391 	push	#0x00
      008427 7B 02            [ 1]  392 	ld	a, (0x02, sp)
      008429 CD 83 0C         [ 4]  393 	call	_writeAddr_I2C
      00842C 4D               [ 1]  394 	tnz	a
      00842D 26 03            [ 1]  395 	jrne	00104$
      00842F 4F               [ 1]  396 	clr	a
      008430 20 4D            [ 2]  397 	jra	00116$
      008432                        398 00104$:
                                    399 ;	../../my_STM8_libraries/stm8_I2C.c: 157: clearADDR_I2C();
      008432 CD 82 ED         [ 4]  400 	call	_clearADDR_I2C
                                    401 ;	../../my_STM8_libraries/stm8_I2C.c: 159: if (writeByte_I2C(reg) == 0) return 0;
      008435 7B 04            [ 1]  402 	ld	a, (0x04, sp)
      008437 CD 83 4C         [ 4]  403 	call	_writeByte_I2C
      00843A 4D               [ 1]  404 	tnz	a
      00843B 26 03            [ 1]  405 	jrne	00106$
      00843D 4F               [ 1]  406 	clr	a
      00843E 20 3F            [ 2]  407 	jra	00116$
      008440                        408 00106$:
                                    409 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (start_I2C() == 0) return 0;
      008440 CD 82 D5         [ 4]  410 	call	_start_I2C
      008443 4D               [ 1]  411 	tnz	a
      008444 26 03            [ 1]  412 	jrne	00108$
      008446 4F               [ 1]  413 	clr	a
      008447 20 36            [ 2]  414 	jra	00116$
      008449                        415 00108$:
                                    416 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (writeAddr_I2C(address, READ) == 0) return 0;
      008449 4B 01            [ 1]  417 	push	#0x01
      00844B 7B 02            [ 1]  418 	ld	a, (0x02, sp)
      00844D CD 83 0C         [ 4]  419 	call	_writeAddr_I2C
      008450 4D               [ 1]  420 	tnz	a
      008451 26 03            [ 1]  421 	jrne	00110$
      008453 4F               [ 1]  422 	clr	a
      008454 20 29            [ 2]  423 	jra	00116$
      008456                        424 00110$:
                                    425 ;	../../my_STM8_libraries/stm8_I2C.c: 165: setACK_I2C(LOW);
      008456 4F               [ 1]  426 	clr	a
      008457 CD 82 F4         [ 4]  427 	call	_setACK_I2C
                                    428 ;	../../my_STM8_libraries/stm8_I2C.c: 167: clearADDR_I2C();
      00845A CD 82 ED         [ 4]  429 	call	_clearADDR_I2C
                                    430 ;	../../my_STM8_libraries/stm8_I2C.c: 169: stop_I2C();
      00845D CD 82 D0         [ 4]  431 	call	_stop_I2C
                                    432 ;	../../my_STM8_libraries/stm8_I2C.c: 171: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008460 AE C3 50         [ 2]  433 	ldw	x, #0xc350
      008463                        434 00113$:
      008463 72 0C 52 17 0A   [ 2]  435 	btjt	0x5217, #6, 00115$
                                    436 ;	../../my_STM8_libraries/stm8_I2C.c: 173: if (--timeout == 0)
      008468 5A               [ 2]  437 	decw	x
      008469 5D               [ 2]  438 	tnzw	x
      00846A 26 F7            [ 1]  439 	jrne	00113$
                                    440 ;	../../my_STM8_libraries/stm8_I2C.c: 175: stop_I2C();
      00846C CD 82 D0         [ 4]  441 	call	_stop_I2C
                                    442 ;	../../my_STM8_libraries/stm8_I2C.c: 176: return 0;
      00846F 4F               [ 1]  443 	clr	a
      008470 20 0D            [ 2]  444 	jra	00116$
      008472                        445 00115$:
                                    446 ;	../../my_STM8_libraries/stm8_I2C.c: 179: *data = I2C_DR;
      008472 1E 05            [ 2]  447 	ldw	x, (0x05, sp)
      008474 C6 52 16         [ 1]  448 	ld	a, 0x5216
      008477 F7               [ 1]  449 	ld	(x), a
                                    450 ;	../../my_STM8_libraries/stm8_I2C.c: 181: setACK_I2C(HIGH);
      008478 A6 01            [ 1]  451 	ld	a, #0x01
      00847A CD 82 F4         [ 4]  452 	call	_setACK_I2C
                                    453 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      00847D A6 01            [ 1]  454 	ld	a, #0x01
      00847F                        455 00116$:
                                    456 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      00847F 1E 02            [ 2]  457 	ldw	x, (2, sp)
      008481 5B 06            [ 2]  458 	addw	sp, #6
      008483 FC               [ 2]  459 	jp	(x)
                                    460 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    461 ;	-----------------------------------------
                                    462 ;	 function readBuffer2_I2C
                                    463 ;	-----------------------------------------
      008484                        464 _readBuffer2_I2C:
      008484 88               [ 1]  465 	push	a
      008485 6B 01            [ 1]  466 	ld	(0x01, sp), a
                                    467 ;	../../my_STM8_libraries/stm8_I2C.c: 189: if (start_I2C() == 0) return 0;
      008487 CD 82 D5         [ 4]  468 	call	_start_I2C
      00848A 4D               [ 1]  469 	tnz	a
      00848B 26 03            [ 1]  470 	jrne	00102$
      00848D 4F               [ 1]  471 	clr	a
      00848E 20 5A            [ 2]  472 	jra	00116$
      008490                        473 00102$:
                                    474 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008490 4B 00            [ 1]  475 	push	#0x00
      008492 7B 02            [ 1]  476 	ld	a, (0x02, sp)
      008494 CD 83 0C         [ 4]  477 	call	_writeAddr_I2C
      008497 4D               [ 1]  478 	tnz	a
      008498 26 03            [ 1]  479 	jrne	00104$
      00849A 4F               [ 1]  480 	clr	a
      00849B 20 4D            [ 2]  481 	jra	00116$
      00849D                        482 00104$:
                                    483 ;	../../my_STM8_libraries/stm8_I2C.c: 192: clearADDR_I2C();
      00849D CD 82 ED         [ 4]  484 	call	_clearADDR_I2C
                                    485 ;	../../my_STM8_libraries/stm8_I2C.c: 194: if (writeByte_I2C(reg) == 0) return 0;
      0084A0 7B 04            [ 1]  486 	ld	a, (0x04, sp)
      0084A2 CD 83 4C         [ 4]  487 	call	_writeByte_I2C
      0084A5 4D               [ 1]  488 	tnz	a
      0084A6 26 03            [ 1]  489 	jrne	00106$
      0084A8 4F               [ 1]  490 	clr	a
      0084A9 20 3F            [ 2]  491 	jra	00116$
      0084AB                        492 00106$:
                                    493 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (start_I2C() == 0) return 0;
      0084AB CD 82 D5         [ 4]  494 	call	_start_I2C
      0084AE 4D               [ 1]  495 	tnz	a
      0084AF 26 03            [ 1]  496 	jrne	00108$
      0084B1 4F               [ 1]  497 	clr	a
      0084B2 20 36            [ 2]  498 	jra	00116$
      0084B4                        499 00108$:
                                    500 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084B4 4B 01            [ 1]  501 	push	#0x01
      0084B6 7B 02            [ 1]  502 	ld	a, (0x02, sp)
      0084B8 CD 83 0C         [ 4]  503 	call	_writeAddr_I2C
      0084BB 4D               [ 1]  504 	tnz	a
      0084BC 26 03            [ 1]  505 	jrne	00110$
      0084BE 4F               [ 1]  506 	clr	a
      0084BF 20 29            [ 2]  507 	jra	00116$
      0084C1                        508 00110$:
                                    509 ;	../../my_STM8_libraries/stm8_I2C.c: 199: clearADDR_I2C();
      0084C1 CD 82 ED         [ 4]  510 	call	_clearADDR_I2C
                                    511 ;	../../my_STM8_libraries/stm8_I2C.c: 200: setACK_I2C(LOW);
      0084C4 4F               [ 1]  512 	clr	a
      0084C5 CD 82 F4         [ 4]  513 	call	_setACK_I2C
                                    514 ;	../../my_STM8_libraries/stm8_I2C.c: 202: while (!(I2C_SR1 & I2C_SR1_BTF))
      0084C8 AE C3 50         [ 2]  515 	ldw	x, #0xc350
      0084CB                        516 00113$:
      0084CB 72 04 52 17 0A   [ 2]  517 	btjt	0x5217, #2, 00115$
                                    518 ;	../../my_STM8_libraries/stm8_I2C.c: 204: if (--timeout == 0)
      0084D0 5A               [ 2]  519 	decw	x
      0084D1 5D               [ 2]  520 	tnzw	x
      0084D2 26 F7            [ 1]  521 	jrne	00113$
                                    522 ;	../../my_STM8_libraries/stm8_I2C.c: 206: stop_I2C();
      0084D4 CD 82 D0         [ 4]  523 	call	_stop_I2C
                                    524 ;	../../my_STM8_libraries/stm8_I2C.c: 207: return 0;
      0084D7 4F               [ 1]  525 	clr	a
      0084D8 20 10            [ 2]  526 	jra	00116$
      0084DA                        527 00115$:
                                    528 ;	../../my_STM8_libraries/stm8_I2C.c: 210: stop_I2C();
      0084DA CD 82 D0         [ 4]  529 	call	_stop_I2C
                                    530 ;	../../my_STM8_libraries/stm8_I2C.c: 212: buf[0] = I2C_DR;
      0084DD 1E 05            [ 2]  531 	ldw	x, (0x05, sp)
      0084DF C6 52 16         [ 1]  532 	ld	a, 0x5216
      0084E2 F7               [ 1]  533 	ld	(x), a
                                    534 ;	../../my_STM8_libraries/stm8_I2C.c: 213: buf[1] = I2C_DR;
      0084E3 5C               [ 1]  535 	incw	x
      0084E4 C6 52 16         [ 1]  536 	ld	a, 0x5216
      0084E7 F7               [ 1]  537 	ld	(x), a
                                    538 ;	../../my_STM8_libraries/stm8_I2C.c: 215: return 1;
      0084E8 A6 01            [ 1]  539 	ld	a, #0x01
      0084EA                        540 00116$:
                                    541 ;	../../my_STM8_libraries/stm8_I2C.c: 216: }
      0084EA 1E 02            [ 2]  542 	ldw	x, (2, sp)
      0084EC 5B 06            [ 2]  543 	addw	sp, #6
      0084EE FC               [ 2]  544 	jp	(x)
                                    545 ;	../../my_STM8_libraries/stm8_I2C.c: 217: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    546 ;	-----------------------------------------
                                    547 ;	 function readBuffer_I2C
                                    548 ;	-----------------------------------------
      0084EF                        549 _readBuffer_I2C:
                                    550 ;	../../my_STM8_libraries/stm8_I2C.c: 220: }
      0084EF 1E 01            [ 2]  551 	ldw	x, (1, sp)
      0084F1 5B 06            [ 2]  552 	addw	sp, #6
      0084F3 FC               [ 2]  553 	jp	(x)
                                    554 	.area CODE
                                    555 	.area CONST
                                    556 	.area INITIALIZER
                                    557 	.area CABS (ABS)
