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
      0082E1                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0082E1 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0082E5 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0082E9 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      0082ED 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0082F1 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0082F5 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      0082F9 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      0082FA                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0082FA 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      0082FE 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      0082FF                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      0082FF 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008303 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      008306                         98 00103$:
      008306 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      00830B 5A               [ 2]  101 	decw	x
      00830C 5D               [ 2]  102 	tnzw	x
      00830D 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      00830F CD 82 FA         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      008312 4F               [ 1]  107 	clr	a
      008313 81               [ 4]  108 	ret
      008314                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      008314 A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      008316 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      008317                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      008317 C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      00831A C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      00831D 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      00831E                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      00831E 97               [ 1]  131 	ld	xl, a
      00831F 4D               [ 1]  132 	tnz	a
      008320 26 04            [ 1]  133 	jrne	00102$
      008322 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      008326                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      008326 9F               [ 1]  137 	ld	a, xl
      008327 4A               [ 1]  138 	dec	a
      008328 27 01            [ 1]  139 	jreq	00120$
      00832A 81               [ 4]  140 	ret
      00832B                        141 00120$:
      00832B 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      00832F 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      008330                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      008330 48               [ 1]  151 	sll	a
      008331 0D 03            [ 1]  152 	tnz	(0x03, sp)
      008333 26 03            [ 1]  153 	jrne	00102$
      008335 C7 52 16         [ 1]  154 	ld	0x5216, a
      008338                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008338 88               [ 1]  157 	push	a
      008339 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      00833B 4A               [ 1]  159 	dec	a
      00833C 84               [ 1]  160 	pop	a
      00833D 26 05            [ 1]  161 	jrne	00119$
      00833F AA 01            [ 1]  162 	or	a, #0x01
      008341 C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008344                        165 00119$:
      008344 AE C3 50         [ 2]  166 	ldw	x, #0xc350
      008347                        167 00108$:
      008347 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      00834C 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      008351 5A               [ 2]  171 	decw	x
      008352 5D               [ 2]  172 	tnzw	x
      008353 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      008355 CD 82 FA         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      008358 4F               [ 1]  177 	clr	a
      008359 20 11            [ 2]  178 	jra	00113$
      00835B                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00835B 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      008360 A6 01            [ 1]  183 	ld	a, #0x01
      008362 20 08            [ 2]  184 	jra	00113$
      008364                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008364 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      008368 CD 82 FA         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      00836B 4F               [ 1]  191 	clr	a
      00836C                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      00836C 85               [ 2]  194 	popw	x
      00836D 5B 01            [ 2]  195 	addw	sp, #1
      00836F FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      008370                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      008370 C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      008373 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      008376                        206 00105$:
      008376 C6 52 17         [ 1]  207 	ld	a, 0x5217
      008379 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      00837B 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      008380 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      008384 CD 82 FA         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      008387 4F               [ 1]  216 	clr	a
      008388 81               [ 4]  217 	ret
      008389                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      008389 5A               [ 2]  220 	decw	x
      00838A 5D               [ 2]  221 	tnzw	x
      00838B 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      00838D CD 82 FA         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      008390 4F               [ 1]  226 	clr	a
      008391 81               [ 4]  227 	ret
      008392                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      008392 A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      008394 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      008395                        237 _ping_I2C:
      008395 88               [ 1]  238 	push	a
      008396 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      008398 CD 82 FF         [ 4]  241 	call	_start_I2C
      00839B 4D               [ 1]  242 	tnz	a
      00839C 26 03            [ 1]  243 	jrne	00102$
      00839E 4F               [ 1]  244 	clr	a
      00839F 20 15            [ 2]  245 	jra	00105$
      0083A1                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0083A1 4B 00            [ 1]  248 	push	#0x00
      0083A3 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      0083A5 CD 83 30         [ 4]  250 	call	_writeAddr_I2C
      0083A8 4D               [ 1]  251 	tnz	a
      0083A9 26 03            [ 1]  252 	jrne	00104$
      0083AB 4F               [ 1]  253 	clr	a
      0083AC 20 08            [ 2]  254 	jra	00105$
      0083AE                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      0083AE CD 83 17         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      0083B1 CD 82 FA         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      0083B4 A6 01            [ 1]  261 	ld	a, #0x01
      0083B6                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      0083B6 5B 01            [ 2]  264 	addw	sp, #1
      0083B8 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      0083B9                        270 _writeReg_I2C:
      0083B9 88               [ 1]  271 	push	a
      0083BA 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      0083BC CD 82 FF         [ 4]  274 	call	_start_I2C
      0083BF 4D               [ 1]  275 	tnz	a
      0083C0 26 03            [ 1]  276 	jrne	00102$
      0083C2 4F               [ 1]  277 	clr	a
      0083C3 20 2B            [ 2]  278 	jra	00109$
      0083C5                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0083C5 4B 00            [ 1]  281 	push	#0x00
      0083C7 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      0083C9 CD 83 30         [ 4]  283 	call	_writeAddr_I2C
      0083CC 4D               [ 1]  284 	tnz	a
      0083CD 26 03            [ 1]  285 	jrne	00104$
      0083CF 4F               [ 1]  286 	clr	a
      0083D0 20 1E            [ 2]  287 	jra	00109$
      0083D2                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      0083D2 CD 83 17         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      0083D5 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      0083D7 CD 83 70         [ 4]  293 	call	_writeByte_I2C
      0083DA 4D               [ 1]  294 	tnz	a
      0083DB 26 03            [ 1]  295 	jrne	00106$
      0083DD 4F               [ 1]  296 	clr	a
      0083DE 20 10            [ 2]  297 	jra	00109$
      0083E0                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      0083E0 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      0083E2 CD 83 70         [ 4]  301 	call	_writeByte_I2C
      0083E5 4D               [ 1]  302 	tnz	a
      0083E6 26 03            [ 1]  303 	jrne	00108$
      0083E8 4F               [ 1]  304 	clr	a
      0083E9 20 05            [ 2]  305 	jra	00109$
      0083EB                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      0083EB CD 82 FA         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      0083EE A6 01            [ 1]  310 	ld	a, #0x01
      0083F0                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      0083F0 1E 02            [ 2]  313 	ldw	x, (2, sp)
      0083F2 5B 05            [ 2]  314 	addw	sp, #5
      0083F4 FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      0083F5                        320 _readByte_I2C:
      0083F5 52 03            [ 2]  321 	sub	sp, #3
      0083F7 6B 03            [ 1]  322 	ld	(0x03, sp), a
      0083F9 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: if (start_I2C() == 0) return 0;
      0083FB CD 82 FF         [ 4]  325 	call	_start_I2C
      0083FE 4D               [ 1]  326 	tnz	a
      0083FF 26 03            [ 1]  327 	jrne	00102$
      008401 4F               [ 1]  328 	clr	a
      008402 20 36            [ 2]  329 	jra	00110$
      008404                        330 00102$:
                                    331 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (writeAddr_I2C(address, READ) == 0) return 0;
      008404 4B 01            [ 1]  332 	push	#0x01
      008406 7B 04            [ 1]  333 	ld	a, (0x04, sp)
      008408 CD 83 30         [ 4]  334 	call	_writeAddr_I2C
      00840B 4D               [ 1]  335 	tnz	a
      00840C 26 03            [ 1]  336 	jrne	00104$
      00840E 4F               [ 1]  337 	clr	a
      00840F 20 29            [ 2]  338 	jra	00110$
      008411                        339 00104$:
                                    340 ;	../../my_STM8_libraries/stm8_I2C.c: 129: setACK_I2C(LOW);
      008411 4F               [ 1]  341 	clr	a
      008412 CD 83 1E         [ 4]  342 	call	_setACK_I2C
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: clearADDR_I2C();
      008415 CD 83 17         [ 4]  344 	call	_clearADDR_I2C
                                    345 ;	../../my_STM8_libraries/stm8_I2C.c: 133: stop_I2C();
      008418 CD 82 FA         [ 4]  346 	call	_stop_I2C
                                    347 ;	../../my_STM8_libraries/stm8_I2C.c: 135: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00841B AE C3 50         [ 2]  348 	ldw	x, #0xc350
      00841E                        349 00107$:
      00841E 72 0C 52 17 0A   [ 2]  350 	btjt	0x5217, #6, 00109$
                                    351 ;	../../my_STM8_libraries/stm8_I2C.c: 137: if (--timeout == 0) 
      008423 5A               [ 2]  352 	decw	x
      008424 5D               [ 2]  353 	tnzw	x
      008425 26 F7            [ 1]  354 	jrne	00107$
                                    355 ;	../../my_STM8_libraries/stm8_I2C.c: 139: stop_I2C();
      008427 CD 82 FA         [ 4]  356 	call	_stop_I2C
                                    357 ;	../../my_STM8_libraries/stm8_I2C.c: 140: return 0;
      00842A 4F               [ 1]  358 	clr	a
      00842B 20 0D            [ 2]  359 	jra	00110$
      00842D                        360 00109$:
                                    361 ;	../../my_STM8_libraries/stm8_I2C.c: 143: *data = I2C_DR;
      00842D C6 52 16         [ 1]  362 	ld	a, 0x5216
      008430 1E 01            [ 2]  363 	ldw	x, (0x01, sp)
      008432 F7               [ 1]  364 	ld	(x), a
                                    365 ;	../../my_STM8_libraries/stm8_I2C.c: 145: setACK_I2C(HIGH);
      008433 A6 01            [ 1]  366 	ld	a, #0x01
      008435 CD 83 1E         [ 4]  367 	call	_setACK_I2C
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      008438 A6 01            [ 1]  369 	ld	a, #0x01
      00843A                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      00843A 5B 03            [ 2]  372 	addw	sp, #3
      00843C 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      00843D                        378 _readReg_I2C:
      00843D 88               [ 1]  379 	push	a
      00843E 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: if (start_I2C() == 0) return 0;
      008440 CD 82 FF         [ 4]  382 	call	_start_I2C
      008443 4D               [ 1]  383 	tnz	a
      008444 26 03            [ 1]  384 	jrne	00102$
      008446 4F               [ 1]  385 	clr	a
      008447 20 5A            [ 2]  386 	jra	00116$
      008449                        387 00102$:
                                    388 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008449 4B 00            [ 1]  389 	push	#0x00
      00844B 7B 02            [ 1]  390 	ld	a, (0x02, sp)
      00844D CD 83 30         [ 4]  391 	call	_writeAddr_I2C
      008450 4D               [ 1]  392 	tnz	a
      008451 26 03            [ 1]  393 	jrne	00104$
      008453 4F               [ 1]  394 	clr	a
      008454 20 4D            [ 2]  395 	jra	00116$
      008456                        396 00104$:
                                    397 ;	../../my_STM8_libraries/stm8_I2C.c: 157: clearADDR_I2C();
      008456 CD 83 17         [ 4]  398 	call	_clearADDR_I2C
                                    399 ;	../../my_STM8_libraries/stm8_I2C.c: 159: if (writeByte_I2C(reg) == 0) return 0;
      008459 7B 04            [ 1]  400 	ld	a, (0x04, sp)
      00845B CD 83 70         [ 4]  401 	call	_writeByte_I2C
      00845E 4D               [ 1]  402 	tnz	a
      00845F 26 03            [ 1]  403 	jrne	00106$
      008461 4F               [ 1]  404 	clr	a
      008462 20 3F            [ 2]  405 	jra	00116$
      008464                        406 00106$:
                                    407 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (start_I2C() == 0) return 0;
      008464 CD 82 FF         [ 4]  408 	call	_start_I2C
      008467 4D               [ 1]  409 	tnz	a
      008468 26 03            [ 1]  410 	jrne	00108$
      00846A 4F               [ 1]  411 	clr	a
      00846B 20 36            [ 2]  412 	jra	00116$
      00846D                        413 00108$:
                                    414 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (writeAddr_I2C(address, READ) == 0) return 0;
      00846D 4B 01            [ 1]  415 	push	#0x01
      00846F 7B 02            [ 1]  416 	ld	a, (0x02, sp)
      008471 CD 83 30         [ 4]  417 	call	_writeAddr_I2C
      008474 4D               [ 1]  418 	tnz	a
      008475 26 03            [ 1]  419 	jrne	00110$
      008477 4F               [ 1]  420 	clr	a
      008478 20 29            [ 2]  421 	jra	00116$
      00847A                        422 00110$:
                                    423 ;	../../my_STM8_libraries/stm8_I2C.c: 165: setACK_I2C(LOW);
      00847A 4F               [ 1]  424 	clr	a
      00847B CD 83 1E         [ 4]  425 	call	_setACK_I2C
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: clearADDR_I2C();
      00847E CD 83 17         [ 4]  427 	call	_clearADDR_I2C
                                    428 ;	../../my_STM8_libraries/stm8_I2C.c: 169: stop_I2C();
      008481 CD 82 FA         [ 4]  429 	call	_stop_I2C
                                    430 ;	../../my_STM8_libraries/stm8_I2C.c: 171: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008484 AE C3 50         [ 2]  431 	ldw	x, #0xc350
      008487                        432 00113$:
      008487 72 0C 52 17 0A   [ 2]  433 	btjt	0x5217, #6, 00115$
                                    434 ;	../../my_STM8_libraries/stm8_I2C.c: 173: if (--timeout == 0)
      00848C 5A               [ 2]  435 	decw	x
      00848D 5D               [ 2]  436 	tnzw	x
      00848E 26 F7            [ 1]  437 	jrne	00113$
                                    438 ;	../../my_STM8_libraries/stm8_I2C.c: 175: stop_I2C();
      008490 CD 82 FA         [ 4]  439 	call	_stop_I2C
                                    440 ;	../../my_STM8_libraries/stm8_I2C.c: 176: return 0;
      008493 4F               [ 1]  441 	clr	a
      008494 20 0D            [ 2]  442 	jra	00116$
      008496                        443 00115$:
                                    444 ;	../../my_STM8_libraries/stm8_I2C.c: 179: *data = I2C_DR;
      008496 1E 05            [ 2]  445 	ldw	x, (0x05, sp)
      008498 C6 52 16         [ 1]  446 	ld	a, 0x5216
      00849B F7               [ 1]  447 	ld	(x), a
                                    448 ;	../../my_STM8_libraries/stm8_I2C.c: 181: setACK_I2C(HIGH);
      00849C A6 01            [ 1]  449 	ld	a, #0x01
      00849E CD 83 1E         [ 4]  450 	call	_setACK_I2C
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      0084A1 A6 01            [ 1]  452 	ld	a, #0x01
      0084A3                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      0084A3 1E 02            [ 2]  455 	ldw	x, (2, sp)
      0084A5 5B 06            [ 2]  456 	addw	sp, #6
      0084A7 FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      0084A8                        462 _readBuffer2_I2C:
      0084A8 52 05            [ 2]  463 	sub	sp, #5
      0084AA 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      0084AC AE C3 50         [ 2]  466 	ldw	x, #0xc350
      0084AF 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: if (start_I2C() == 0) return 0;
      0084B1 CD 82 FF         [ 4]  469 	call	_start_I2C
      0084B4 4D               [ 1]  470 	tnz	a
      0084B5 26 03            [ 1]  471 	jrne	00102$
      0084B7 4F               [ 1]  472 	clr	a
      0084B8 20 78            [ 2]  473 	jra	00121$
      0084BA                        474 00102$:
                                    475 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0084BA 4B 00            [ 1]  476 	push	#0x00
      0084BC 7B 06            [ 1]  477 	ld	a, (0x06, sp)
      0084BE CD 83 30         [ 4]  478 	call	_writeAddr_I2C
      0084C1 4D               [ 1]  479 	tnz	a
      0084C2 26 03            [ 1]  480 	jrne	00104$
      0084C4 4F               [ 1]  481 	clr	a
      0084C5 20 6B            [ 2]  482 	jra	00121$
      0084C7                        483 00104$:
                                    484 ;	../../my_STM8_libraries/stm8_I2C.c: 192: clearADDR_I2C();
      0084C7 CD 83 17         [ 4]  485 	call	_clearADDR_I2C
                                    486 ;	../../my_STM8_libraries/stm8_I2C.c: 194: if (writeByte_I2C(reg) == 0) return 0;
      0084CA 7B 08            [ 1]  487 	ld	a, (0x08, sp)
      0084CC CD 83 70         [ 4]  488 	call	_writeByte_I2C
      0084CF 4D               [ 1]  489 	tnz	a
      0084D0 26 03            [ 1]  490 	jrne	00106$
      0084D2 4F               [ 1]  491 	clr	a
      0084D3 20 5D            [ 2]  492 	jra	00121$
      0084D5                        493 00106$:
                                    494 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (start_I2C() == 0) return 0;
      0084D5 CD 82 FF         [ 4]  495 	call	_start_I2C
      0084D8 4D               [ 1]  496 	tnz	a
      0084D9 26 03            [ 1]  497 	jrne	00108$
      0084DB 4F               [ 1]  498 	clr	a
      0084DC 20 54            [ 2]  499 	jra	00121$
      0084DE                        500 00108$:
                                    501 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084DE 4B 01            [ 1]  502 	push	#0x01
      0084E0 7B 06            [ 1]  503 	ld	a, (0x06, sp)
      0084E2 CD 83 30         [ 4]  504 	call	_writeAddr_I2C
      0084E5 4D               [ 1]  505 	tnz	a
      0084E6 26 03            [ 1]  506 	jrne	00110$
      0084E8 4F               [ 1]  507 	clr	a
      0084E9 20 47            [ 2]  508 	jra	00121$
      0084EB                        509 00110$:
                                    510 ;	../../my_STM8_libraries/stm8_I2C.c: 199: clearADDR_I2C();
      0084EB CD 83 17         [ 4]  511 	call	_clearADDR_I2C
                                    512 ;	../../my_STM8_libraries/stm8_I2C.c: 201: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0084EE AE C3 50         [ 2]  513 	ldw	x, #0xc350
      0084F1                        514 00113$:
      0084F1 72 0C 52 17 0C   [ 2]  515 	btjt	0x5217, #6, 00115$
                                    516 ;	../../my_STM8_libraries/stm8_I2C.c: 203: if (--timeout == 0)
      0084F6 5A               [ 2]  517 	decw	x
      0084F7 1F 01            [ 2]  518 	ldw	(0x01, sp), x
      0084F9 5D               [ 2]  519 	tnzw	x
      0084FA 26 F5            [ 1]  520 	jrne	00113$
                                    521 ;	../../my_STM8_libraries/stm8_I2C.c: 205: stop_I2C();
      0084FC CD 82 FA         [ 4]  522 	call	_stop_I2C
                                    523 ;	../../my_STM8_libraries/stm8_I2C.c: 206: return 0;
      0084FF 4F               [ 1]  524 	clr	a
      008500 20 30            [ 2]  525 	jra	00121$
      008502                        526 00115$:
                                    527 ;	../../my_STM8_libraries/stm8_I2C.c: 209: buf[0] = I2C_DR;
      008502 16 09            [ 2]  528 	ldw	y, (0x09, sp)
      008504 17 03            [ 2]  529 	ldw	(0x03, sp), y
      008506 C6 52 16         [ 1]  530 	ld	a, 0x5216
      008509 1E 03            [ 2]  531 	ldw	x, (0x03, sp)
      00850B F7               [ 1]  532 	ld	(x), a
                                    533 ;	../../my_STM8_libraries/stm8_I2C.c: 210: setACK_I2C(LOW);
      00850C 4F               [ 1]  534 	clr	a
      00850D CD 83 1E         [ 4]  535 	call	_setACK_I2C
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: while (!(I2C_SR1 & I2C_SR1_BTF))
      008510 1E 01            [ 2]  537 	ldw	x, (0x01, sp)
      008512                        538 00118$:
      008512 72 04 52 17 0A   [ 2]  539 	btjt	0x5217, #2, 00120$
                                    540 ;	../../my_STM8_libraries/stm8_I2C.c: 214: if (--timeout == 0)
      008517 5A               [ 2]  541 	decw	x
      008518 5D               [ 2]  542 	tnzw	x
      008519 26 F7            [ 1]  543 	jrne	00118$
                                    544 ;	../../my_STM8_libraries/stm8_I2C.c: 216: stop_I2C();
      00851B CD 82 FA         [ 4]  545 	call	_stop_I2C
                                    546 ;	../../my_STM8_libraries/stm8_I2C.c: 217: return 0;
      00851E 4F               [ 1]  547 	clr	a
      00851F 20 11            [ 2]  548 	jra	00121$
      008521                        549 00120$:
                                    550 ;	../../my_STM8_libraries/stm8_I2C.c: 220: stop_I2C();
      008521 CD 82 FA         [ 4]  551 	call	_stop_I2C
                                    552 ;	../../my_STM8_libraries/stm8_I2C.c: 222: buf[1] = I2C_DR;
      008524 1E 03            [ 2]  553 	ldw	x, (0x03, sp)
      008526 5C               [ 1]  554 	incw	x
      008527 C6 52 16         [ 1]  555 	ld	a, 0x5216
      00852A F7               [ 1]  556 	ld	(x), a
                                    557 ;	../../my_STM8_libraries/stm8_I2C.c: 224: setACK_I2C(HIGH);
      00852B A6 01            [ 1]  558 	ld	a, #0x01
      00852D CD 83 1E         [ 4]  559 	call	_setACK_I2C
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      008530 A6 01            [ 1]  561 	ld	a, #0x01
      008532                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      008532 1E 06            [ 2]  564 	ldw	x, (6, sp)
      008534 5B 0A            [ 2]  565 	addw	sp, #10
      008536 FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      008537                        571 _readBuffer_I2C:
      008537 52 06            [ 2]  572 	sub	sp, #6
      008539 6B 04            [ 1]  573 	ld	(0x04, sp), a
                                    574 ;	../../my_STM8_libraries/stm8_I2C.c: 230: uint16_t timeout = 50000;
      00853B AE C3 50         [ 2]  575 	ldw	x, #0xc350
      00853E 1F 01            [ 2]  576 	ldw	(0x01, sp), x
                                    577 ;	../../my_STM8_libraries/stm8_I2C.c: 231: uint8_t i = 0;
      008540 0F 03            [ 1]  578 	clr	(0x03, sp)
                                    579 ;	../../my_STM8_libraries/stm8_I2C.c: 233: if (size == 1) 
      008542 7B 0C            [ 1]  580 	ld	a, (0x0c, sp)
      008544 4A               [ 1]  581 	dec	a
      008545 26 17            [ 1]  582 	jrne	00104$
                                    583 ;	../../my_STM8_libraries/stm8_I2C.c: 235: if (readReg_I2C(address, reg, buf) == 0) return 0;
      008547 1E 0A            [ 2]  584 	ldw	x, (0x0a, sp)
      008549 89               [ 2]  585 	pushw	x
      00854A 7B 0B            [ 1]  586 	ld	a, (0x0b, sp)
      00854C 88               [ 1]  587 	push	a
      00854D 7B 07            [ 1]  588 	ld	a, (0x07, sp)
      00854F CD 84 3D         [ 4]  589 	call	_readReg_I2C
      008552 4D               [ 1]  590 	tnz	a
      008553 26 04            [ 1]  591 	jrne	00102$
      008555 4F               [ 1]  592 	clr	a
      008556 CC 86 4D         [ 2]  593 	jp	00137$
      008559                        594 00102$:
                                    595 ;	../../my_STM8_libraries/stm8_I2C.c: 236: return 1;
      008559 A6 01            [ 1]  596 	ld	a, #0x01
      00855B CC 86 4D         [ 2]  597 	jp	00137$
      00855E                        598 00104$:
                                    599 ;	../../my_STM8_libraries/stm8_I2C.c: 238: if (size == 2)
      00855E 7B 0C            [ 1]  600 	ld	a, (0x0c, sp)
      008560 A1 02            [ 1]  601 	cp	a, #0x02
      008562 26 17            [ 1]  602 	jrne	00108$
                                    603 ;	../../my_STM8_libraries/stm8_I2C.c: 240: if (readBuffer2_I2C(address, reg, buf) == 0) return 0;
      008564 1E 0A            [ 2]  604 	ldw	x, (0x0a, sp)
      008566 89               [ 2]  605 	pushw	x
      008567 7B 0B            [ 1]  606 	ld	a, (0x0b, sp)
      008569 88               [ 1]  607 	push	a
      00856A 7B 07            [ 1]  608 	ld	a, (0x07, sp)
      00856C CD 84 A8         [ 4]  609 	call	_readBuffer2_I2C
      00856F 4D               [ 1]  610 	tnz	a
      008570 26 04            [ 1]  611 	jrne	00106$
      008572 4F               [ 1]  612 	clr	a
      008573 CC 86 4D         [ 2]  613 	jp	00137$
      008576                        614 00106$:
                                    615 ;	../../my_STM8_libraries/stm8_I2C.c: 241: return 1;
      008576 A6 01            [ 1]  616 	ld	a, #0x01
      008578 CC 86 4D         [ 2]  617 	jp	00137$
      00857B                        618 00108$:
                                    619 ;	../../my_STM8_libraries/stm8_I2C.c: 243: if (start_I2C() == 0) return 0;
      00857B CD 82 FF         [ 4]  620 	call	_start_I2C
      00857E 4D               [ 1]  621 	tnz	a
      00857F 26 04            [ 1]  622 	jrne	00110$
      008581 4F               [ 1]  623 	clr	a
      008582 CC 86 4D         [ 2]  624 	jp	00137$
      008585                        625 00110$:
                                    626 ;	../../my_STM8_libraries/stm8_I2C.c: 245: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008585 4B 00            [ 1]  627 	push	#0x00
      008587 7B 05            [ 1]  628 	ld	a, (0x05, sp)
      008589 CD 83 30         [ 4]  629 	call	_writeAddr_I2C
      00858C 4D               [ 1]  630 	tnz	a
      00858D 26 04            [ 1]  631 	jrne	00112$
      00858F 4F               [ 1]  632 	clr	a
      008590 CC 86 4D         [ 2]  633 	jp	00137$
      008593                        634 00112$:
                                    635 ;	../../my_STM8_libraries/stm8_I2C.c: 246: clearADDR_I2C();
      008593 CD 83 17         [ 4]  636 	call	_clearADDR_I2C
                                    637 ;	../../my_STM8_libraries/stm8_I2C.c: 248: if (writeByte_I2C(reg) == 0) return 0;
      008596 7B 09            [ 1]  638 	ld	a, (0x09, sp)
      008598 CD 83 70         [ 4]  639 	call	_writeByte_I2C
      00859B 4D               [ 1]  640 	tnz	a
      00859C 26 04            [ 1]  641 	jrne	00114$
      00859E 4F               [ 1]  642 	clr	a
      00859F CC 86 4D         [ 2]  643 	jp	00137$
      0085A2                        644 00114$:
                                    645 ;	../../my_STM8_libraries/stm8_I2C.c: 250: if (start_I2C() == 0) return 0;
      0085A2 CD 82 FF         [ 4]  646 	call	_start_I2C
      0085A5 4D               [ 1]  647 	tnz	a
      0085A6 26 04            [ 1]  648 	jrne	00116$
      0085A8 4F               [ 1]  649 	clr	a
      0085A9 CC 86 4D         [ 2]  650 	jp	00137$
      0085AC                        651 00116$:
                                    652 ;	../../my_STM8_libraries/stm8_I2C.c: 252: if (writeAddr_I2C(address, READ) == 0) return 0;
      0085AC 4B 01            [ 1]  653 	push	#0x01
      0085AE 7B 05            [ 1]  654 	ld	a, (0x05, sp)
      0085B0 CD 83 30         [ 4]  655 	call	_writeAddr_I2C
      0085B3 4D               [ 1]  656 	tnz	a
      0085B4 26 04            [ 1]  657 	jrne	00118$
      0085B6 4F               [ 1]  658 	clr	a
      0085B7 CC 86 4D         [ 2]  659 	jp	00137$
      0085BA                        660 00118$:
                                    661 ;	../../my_STM8_libraries/stm8_I2C.c: 253: clearADDR_I2C();
      0085BA CD 83 17         [ 4]  662 	call	_clearADDR_I2C
                                    663 ;	../../my_STM8_libraries/stm8_I2C.c: 255: while (size > 3)
      0085BD 0F 05            [ 1]  664 	clr	(0x05, sp)
      0085BF 7B 0C            [ 1]  665 	ld	a, (0x0c, sp)
      0085C1 6B 06            [ 1]  666 	ld	(0x06, sp), a
      0085C3                        667 00124$:
      0085C3 7B 06            [ 1]  668 	ld	a, (0x06, sp)
      0085C5 A1 03            [ 1]  669 	cp	a, #0x03
      0085C7 23 2B            [ 2]  670 	jrule	00153$
                                    671 ;	../../my_STM8_libraries/stm8_I2C.c: 257: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0085C9 1E 01            [ 2]  672 	ldw	x, (0x01, sp)
      0085CB                        673 00121$:
      0085CB 72 0C 52 17 0A   [ 2]  674 	btjt	0x5217, #6, 00123$
                                    675 ;	../../my_STM8_libraries/stm8_I2C.c: 259: if (--timeout == 0)
      0085D0 5A               [ 2]  676 	decw	x
      0085D1 5D               [ 2]  677 	tnzw	x
      0085D2 26 F7            [ 1]  678 	jrne	00121$
                                    679 ;	../../my_STM8_libraries/stm8_I2C.c: 261: stop_I2C();
      0085D4 CD 82 FA         [ 4]  680 	call	_stop_I2C
                                    681 ;	../../my_STM8_libraries/stm8_I2C.c: 262: return 0;
      0085D7 4F               [ 1]  682 	clr	a
      0085D8 20 73            [ 2]  683 	jra	00137$
      0085DA                        684 00123$:
                                    685 ;	../../my_STM8_libraries/stm8_I2C.c: 265: timeout = 50000;
      0085DA AE C3 50         [ 2]  686 	ldw	x, #0xc350
      0085DD 1F 01            [ 2]  687 	ldw	(0x01, sp), x
                                    688 ;	../../my_STM8_libraries/stm8_I2C.c: 266: buf[i] = I2C_DR;
      0085DF 5F               [ 1]  689 	clrw	x
      0085E0 7B 05            [ 1]  690 	ld	a, (0x05, sp)
      0085E2 97               [ 1]  691 	ld	xl, a
      0085E3 72 FB 0A         [ 2]  692 	addw	x, (0x0a, sp)
      0085E6 C6 52 16         [ 1]  693 	ld	a, 0x5216
      0085E9 F7               [ 1]  694 	ld	(x), a
                                    695 ;	../../my_STM8_libraries/stm8_I2C.c: 267: i++;
      0085EA 0C 05            [ 1]  696 	inc	(0x05, sp)
      0085EC 7B 05            [ 1]  697 	ld	a, (0x05, sp)
      0085EE 6B 03            [ 1]  698 	ld	(0x03, sp), a
                                    699 ;	../../my_STM8_libraries/stm8_I2C.c: 268: size--;
      0085F0 0A 06            [ 1]  700 	dec	(0x06, sp)
      0085F2 20 CF            [ 2]  701 	jra	00124$
                                    702 ;	../../my_STM8_libraries/stm8_I2C.c: 271: while (!(I2C_SR1 & I2C_SR1_BTF))
      0085F4                        703 00153$:
      0085F4 1E 01            [ 2]  704 	ldw	x, (0x01, sp)
      0085F6                        705 00129$:
      0085F6 72 04 52 17 0A   [ 2]  706 	btjt	0x5217, #2, 00131$
                                    707 ;	../../my_STM8_libraries/stm8_I2C.c: 273: if (--timeout == 0)
      0085FB 5A               [ 2]  708 	decw	x
      0085FC 5D               [ 2]  709 	tnzw	x
      0085FD 26 F7            [ 1]  710 	jrne	00129$
                                    711 ;	../../my_STM8_libraries/stm8_I2C.c: 275: stop_I2C();
      0085FF CD 82 FA         [ 4]  712 	call	_stop_I2C
                                    713 ;	../../my_STM8_libraries/stm8_I2C.c: 276: return 0;
      008602 4F               [ 1]  714 	clr	a
      008603 20 48            [ 2]  715 	jra	00137$
      008605                        716 00131$:
                                    717 ;	../../my_STM8_libraries/stm8_I2C.c: 281: setACK_I2C(LOW);
      008605 4F               [ 1]  718 	clr	a
      008606 CD 83 1E         [ 4]  719 	call	_setACK_I2C
                                    720 ;	../../my_STM8_libraries/stm8_I2C.c: 283: buf[i] = I2C_DR;
      008609 5F               [ 1]  721 	clrw	x
      00860A 7B 03            [ 1]  722 	ld	a, (0x03, sp)
      00860C 97               [ 1]  723 	ld	xl, a
      00860D 72 FB 0A         [ 2]  724 	addw	x, (0x0a, sp)
      008610 C6 52 16         [ 1]  725 	ld	a, 0x5216
      008613 F7               [ 1]  726 	ld	(x), a
                                    727 ;	../../my_STM8_libraries/stm8_I2C.c: 284: i++;
      008614 7B 03            [ 1]  728 	ld	a, (0x03, sp)
      008616 4C               [ 1]  729 	inc	a
      008617 6B 06            [ 1]  730 	ld	(0x06, sp), a
                                    731 ;	../../my_STM8_libraries/stm8_I2C.c: 286: stop_I2C();
      008619 CD 82 FA         [ 4]  732 	call	_stop_I2C
                                    733 ;	../../my_STM8_libraries/stm8_I2C.c: 288: buf[i] = I2C_DR;
      00861C 5F               [ 1]  734 	clrw	x
      00861D 7B 06            [ 1]  735 	ld	a, (0x06, sp)
      00861F 97               [ 1]  736 	ld	xl, a
      008620 72 FB 0A         [ 2]  737 	addw	x, (0x0a, sp)
      008623 C6 52 16         [ 1]  738 	ld	a, 0x5216
      008626 F7               [ 1]  739 	ld	(x), a
                                    740 ;	../../my_STM8_libraries/stm8_I2C.c: 289: i++;
      008627 0C 06            [ 1]  741 	inc	(0x06, sp)
                                    742 ;	../../my_STM8_libraries/stm8_I2C.c: 291: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008629 AE C3 50         [ 2]  743 	ldw	x, #0xc350
      00862C                        744 00134$:
      00862C 72 0C 52 17 0A   [ 2]  745 	btjt	0x5217, #6, 00136$
                                    746 ;	../../my_STM8_libraries/stm8_I2C.c: 293: if (--timeout == 0)
      008631 5A               [ 2]  747 	decw	x
      008632 5D               [ 2]  748 	tnzw	x
      008633 26 F7            [ 1]  749 	jrne	00134$
                                    750 ;	../../my_STM8_libraries/stm8_I2C.c: 295: stop_I2C();
      008635 CD 82 FA         [ 4]  751 	call	_stop_I2C
                                    752 ;	../../my_STM8_libraries/stm8_I2C.c: 296: return 0;
      008638 4F               [ 1]  753 	clr	a
      008639 20 12            [ 2]  754 	jra	00137$
      00863B                        755 00136$:
                                    756 ;	../../my_STM8_libraries/stm8_I2C.c: 299: buf[i] = I2C_DR;
      00863B 5F               [ 1]  757 	clrw	x
      00863C 7B 06            [ 1]  758 	ld	a, (0x06, sp)
      00863E 97               [ 1]  759 	ld	xl, a
      00863F 72 FB 0A         [ 2]  760 	addw	x, (0x0a, sp)
      008642 C6 52 16         [ 1]  761 	ld	a, 0x5216
      008645 F7               [ 1]  762 	ld	(x), a
                                    763 ;	../../my_STM8_libraries/stm8_I2C.c: 301: setACK_I2C(HIGH);
      008646 A6 01            [ 1]  764 	ld	a, #0x01
      008648 CD 83 1E         [ 4]  765 	call	_setACK_I2C
                                    766 ;	../../my_STM8_libraries/stm8_I2C.c: 303: return 1;
      00864B A6 01            [ 1]  767 	ld	a, #0x01
      00864D                        768 00137$:
                                    769 ;	../../my_STM8_libraries/stm8_I2C.c: 304: }
      00864D 1E 07            [ 2]  770 	ldw	x, (7, sp)
      00864F 5B 0C            [ 2]  771 	addw	sp, #12
      008651 FC               [ 2]  772 	jp	(x)
                                    773 	.area CODE
                                    774 	.area CONST
                                    775 	.area INITIALIZER
                                    776 	.area CABS (ABS)
