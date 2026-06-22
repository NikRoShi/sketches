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
      0082B1                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0082B1 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0082B5 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0082B9 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      0082BD 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0082C1 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0082C5 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      0082C9 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      0082CA                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0082CA 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      0082CE 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      0082CF                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      0082CF 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      0082D3 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      0082D6                         98 00103$:
      0082D6 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      0082DB 5A               [ 2]  101 	decw	x
      0082DC 5D               [ 2]  102 	tnzw	x
      0082DD 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      0082DF CD 82 CA         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      0082E2 4F               [ 1]  107 	clr	a
      0082E3 81               [ 4]  108 	ret
      0082E4                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      0082E4 A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      0082E6 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      0082E7                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      0082E7 C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      0082EA C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      0082ED 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      0082EE                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      0082EE 97               [ 1]  131 	ld	xl, a
      0082EF 4D               [ 1]  132 	tnz	a
      0082F0 26 04            [ 1]  133 	jrne	00102$
      0082F2 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      0082F6                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      0082F6 9F               [ 1]  137 	ld	a, xl
      0082F7 4A               [ 1]  138 	dec	a
      0082F8 27 01            [ 1]  139 	jreq	00120$
      0082FA 81               [ 4]  140 	ret
      0082FB                        141 00120$:
      0082FB 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      0082FF 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      008300                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      008300 48               [ 1]  151 	sll	a
      008301 0D 03            [ 1]  152 	tnz	(0x03, sp)
      008303 26 03            [ 1]  153 	jrne	00102$
      008305 C7 52 16         [ 1]  154 	ld	0x5216, a
      008308                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008308 88               [ 1]  157 	push	a
      008309 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      00830B 4A               [ 1]  159 	dec	a
      00830C 84               [ 1]  160 	pop	a
      00830D 26 05            [ 1]  161 	jrne	00119$
      00830F AA 01            [ 1]  162 	or	a, #0x01
      008311 C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008314                        165 00119$:
      008314 AE C3 50         [ 2]  166 	ldw	x, #0xc350
      008317                        167 00108$:
      008317 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      00831C 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      008321 5A               [ 2]  171 	decw	x
      008322 5D               [ 2]  172 	tnzw	x
      008323 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      008325 CD 82 CA         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      008328 4F               [ 1]  177 	clr	a
      008329 20 11            [ 2]  178 	jra	00113$
      00832B                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00832B 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      008330 A6 01            [ 1]  183 	ld	a, #0x01
      008332 20 08            [ 2]  184 	jra	00113$
      008334                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008334 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      008338 CD 82 CA         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      00833B 4F               [ 1]  191 	clr	a
      00833C                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      00833C 85               [ 2]  194 	popw	x
      00833D 5B 01            [ 2]  195 	addw	sp, #1
      00833F FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      008340                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      008340 C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      008343 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      008346                        206 00105$:
      008346 C6 52 17         [ 1]  207 	ld	a, 0x5217
      008349 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      00834B 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      008350 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      008354 CD 82 CA         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      008357 4F               [ 1]  216 	clr	a
      008358 81               [ 4]  217 	ret
      008359                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      008359 5A               [ 2]  220 	decw	x
      00835A 5D               [ 2]  221 	tnzw	x
      00835B 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      00835D CD 82 CA         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      008360 4F               [ 1]  226 	clr	a
      008361 81               [ 4]  227 	ret
      008362                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      008362 A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      008364 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      008365                        237 _ping_I2C:
      008365 88               [ 1]  238 	push	a
      008366 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      008368 CD 82 CF         [ 4]  241 	call	_start_I2C
      00836B 4D               [ 1]  242 	tnz	a
      00836C 26 03            [ 1]  243 	jrne	00102$
      00836E 4F               [ 1]  244 	clr	a
      00836F 20 15            [ 2]  245 	jra	00105$
      008371                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008371 4B 00            [ 1]  248 	push	#0x00
      008373 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      008375 CD 83 00         [ 4]  250 	call	_writeAddr_I2C
      008378 4D               [ 1]  251 	tnz	a
      008379 26 03            [ 1]  252 	jrne	00104$
      00837B 4F               [ 1]  253 	clr	a
      00837C 20 08            [ 2]  254 	jra	00105$
      00837E                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      00837E CD 82 E7         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      008381 CD 82 CA         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      008384 A6 01            [ 1]  261 	ld	a, #0x01
      008386                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      008386 5B 01            [ 2]  264 	addw	sp, #1
      008388 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      008389                        270 _writeReg_I2C:
      008389 88               [ 1]  271 	push	a
      00838A 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      00838C CD 82 CF         [ 4]  274 	call	_start_I2C
      00838F 4D               [ 1]  275 	tnz	a
      008390 26 03            [ 1]  276 	jrne	00102$
      008392 4F               [ 1]  277 	clr	a
      008393 20 2B            [ 2]  278 	jra	00109$
      008395                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008395 4B 00            [ 1]  281 	push	#0x00
      008397 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      008399 CD 83 00         [ 4]  283 	call	_writeAddr_I2C
      00839C 4D               [ 1]  284 	tnz	a
      00839D 26 03            [ 1]  285 	jrne	00104$
      00839F 4F               [ 1]  286 	clr	a
      0083A0 20 1E            [ 2]  287 	jra	00109$
      0083A2                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      0083A2 CD 82 E7         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      0083A5 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      0083A7 CD 83 40         [ 4]  293 	call	_writeByte_I2C
      0083AA 4D               [ 1]  294 	tnz	a
      0083AB 26 03            [ 1]  295 	jrne	00106$
      0083AD 4F               [ 1]  296 	clr	a
      0083AE 20 10            [ 2]  297 	jra	00109$
      0083B0                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      0083B0 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      0083B2 CD 83 40         [ 4]  301 	call	_writeByte_I2C
      0083B5 4D               [ 1]  302 	tnz	a
      0083B6 26 03            [ 1]  303 	jrne	00108$
      0083B8 4F               [ 1]  304 	clr	a
      0083B9 20 05            [ 2]  305 	jra	00109$
      0083BB                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      0083BB CD 82 CA         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      0083BE A6 01            [ 1]  310 	ld	a, #0x01
      0083C0                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      0083C0 1E 02            [ 2]  313 	ldw	x, (2, sp)
      0083C2 5B 05            [ 2]  314 	addw	sp, #5
      0083C4 FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      0083C5                        320 _readByte_I2C:
      0083C5 52 03            [ 2]  321 	sub	sp, #3
      0083C7 6B 03            [ 1]  322 	ld	(0x03, sp), a
      0083C9 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: if (start_I2C() == 0) return 0;
      0083CB CD 82 CF         [ 4]  325 	call	_start_I2C
      0083CE 4D               [ 1]  326 	tnz	a
      0083CF 26 03            [ 1]  327 	jrne	00102$
      0083D1 4F               [ 1]  328 	clr	a
      0083D2 20 36            [ 2]  329 	jra	00110$
      0083D4                        330 00102$:
                                    331 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083D4 4B 01            [ 1]  332 	push	#0x01
      0083D6 7B 04            [ 1]  333 	ld	a, (0x04, sp)
      0083D8 CD 83 00         [ 4]  334 	call	_writeAddr_I2C
      0083DB 4D               [ 1]  335 	tnz	a
      0083DC 26 03            [ 1]  336 	jrne	00104$
      0083DE 4F               [ 1]  337 	clr	a
      0083DF 20 29            [ 2]  338 	jra	00110$
      0083E1                        339 00104$:
                                    340 ;	../../my_STM8_libraries/stm8_I2C.c: 129: setACK_I2C(LOW);
      0083E1 4F               [ 1]  341 	clr	a
      0083E2 CD 82 EE         [ 4]  342 	call	_setACK_I2C
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: clearADDR_I2C();
      0083E5 CD 82 E7         [ 4]  344 	call	_clearADDR_I2C
                                    345 ;	../../my_STM8_libraries/stm8_I2C.c: 133: stop_I2C();
      0083E8 CD 82 CA         [ 4]  346 	call	_stop_I2C
                                    347 ;	../../my_STM8_libraries/stm8_I2C.c: 135: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083EB AE C3 50         [ 2]  348 	ldw	x, #0xc350
      0083EE                        349 00107$:
      0083EE 72 0C 52 17 0A   [ 2]  350 	btjt	0x5217, #6, 00109$
                                    351 ;	../../my_STM8_libraries/stm8_I2C.c: 137: if (--timeout == 0) 
      0083F3 5A               [ 2]  352 	decw	x
      0083F4 5D               [ 2]  353 	tnzw	x
      0083F5 26 F7            [ 1]  354 	jrne	00107$
                                    355 ;	../../my_STM8_libraries/stm8_I2C.c: 139: stop_I2C();
      0083F7 CD 82 CA         [ 4]  356 	call	_stop_I2C
                                    357 ;	../../my_STM8_libraries/stm8_I2C.c: 140: return 0;
      0083FA 4F               [ 1]  358 	clr	a
      0083FB 20 0D            [ 2]  359 	jra	00110$
      0083FD                        360 00109$:
                                    361 ;	../../my_STM8_libraries/stm8_I2C.c: 143: *data = I2C_DR;
      0083FD C6 52 16         [ 1]  362 	ld	a, 0x5216
      008400 1E 01            [ 2]  363 	ldw	x, (0x01, sp)
      008402 F7               [ 1]  364 	ld	(x), a
                                    365 ;	../../my_STM8_libraries/stm8_I2C.c: 145: setACK_I2C(HIGH);
      008403 A6 01            [ 1]  366 	ld	a, #0x01
      008405 CD 82 EE         [ 4]  367 	call	_setACK_I2C
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      008408 A6 01            [ 1]  369 	ld	a, #0x01
      00840A                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      00840A 5B 03            [ 2]  372 	addw	sp, #3
      00840C 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      00840D                        378 _readReg_I2C:
      00840D 88               [ 1]  379 	push	a
      00840E 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: if (start_I2C() == 0) return 0;
      008410 CD 82 CF         [ 4]  382 	call	_start_I2C
      008413 4D               [ 1]  383 	tnz	a
      008414 26 03            [ 1]  384 	jrne	00102$
      008416 4F               [ 1]  385 	clr	a
      008417 20 5A            [ 2]  386 	jra	00116$
      008419                        387 00102$:
                                    388 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008419 4B 00            [ 1]  389 	push	#0x00
      00841B 7B 02            [ 1]  390 	ld	a, (0x02, sp)
      00841D CD 83 00         [ 4]  391 	call	_writeAddr_I2C
      008420 4D               [ 1]  392 	tnz	a
      008421 26 03            [ 1]  393 	jrne	00104$
      008423 4F               [ 1]  394 	clr	a
      008424 20 4D            [ 2]  395 	jra	00116$
      008426                        396 00104$:
                                    397 ;	../../my_STM8_libraries/stm8_I2C.c: 157: clearADDR_I2C();
      008426 CD 82 E7         [ 4]  398 	call	_clearADDR_I2C
                                    399 ;	../../my_STM8_libraries/stm8_I2C.c: 159: if (writeByte_I2C(reg) == 0) return 0;
      008429 7B 04            [ 1]  400 	ld	a, (0x04, sp)
      00842B CD 83 40         [ 4]  401 	call	_writeByte_I2C
      00842E 4D               [ 1]  402 	tnz	a
      00842F 26 03            [ 1]  403 	jrne	00106$
      008431 4F               [ 1]  404 	clr	a
      008432 20 3F            [ 2]  405 	jra	00116$
      008434                        406 00106$:
                                    407 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (start_I2C() == 0) return 0;
      008434 CD 82 CF         [ 4]  408 	call	_start_I2C
      008437 4D               [ 1]  409 	tnz	a
      008438 26 03            [ 1]  410 	jrne	00108$
      00843A 4F               [ 1]  411 	clr	a
      00843B 20 36            [ 2]  412 	jra	00116$
      00843D                        413 00108$:
                                    414 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (writeAddr_I2C(address, READ) == 0) return 0;
      00843D 4B 01            [ 1]  415 	push	#0x01
      00843F 7B 02            [ 1]  416 	ld	a, (0x02, sp)
      008441 CD 83 00         [ 4]  417 	call	_writeAddr_I2C
      008444 4D               [ 1]  418 	tnz	a
      008445 26 03            [ 1]  419 	jrne	00110$
      008447 4F               [ 1]  420 	clr	a
      008448 20 29            [ 2]  421 	jra	00116$
      00844A                        422 00110$:
                                    423 ;	../../my_STM8_libraries/stm8_I2C.c: 165: setACK_I2C(LOW);
      00844A 4F               [ 1]  424 	clr	a
      00844B CD 82 EE         [ 4]  425 	call	_setACK_I2C
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: clearADDR_I2C();
      00844E CD 82 E7         [ 4]  427 	call	_clearADDR_I2C
                                    428 ;	../../my_STM8_libraries/stm8_I2C.c: 169: stop_I2C();
      008451 CD 82 CA         [ 4]  429 	call	_stop_I2C
                                    430 ;	../../my_STM8_libraries/stm8_I2C.c: 171: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008454 AE C3 50         [ 2]  431 	ldw	x, #0xc350
      008457                        432 00113$:
      008457 72 0C 52 17 0A   [ 2]  433 	btjt	0x5217, #6, 00115$
                                    434 ;	../../my_STM8_libraries/stm8_I2C.c: 173: if (--timeout == 0)
      00845C 5A               [ 2]  435 	decw	x
      00845D 5D               [ 2]  436 	tnzw	x
      00845E 26 F7            [ 1]  437 	jrne	00113$
                                    438 ;	../../my_STM8_libraries/stm8_I2C.c: 175: stop_I2C();
      008460 CD 82 CA         [ 4]  439 	call	_stop_I2C
                                    440 ;	../../my_STM8_libraries/stm8_I2C.c: 176: return 0;
      008463 4F               [ 1]  441 	clr	a
      008464 20 0D            [ 2]  442 	jra	00116$
      008466                        443 00115$:
                                    444 ;	../../my_STM8_libraries/stm8_I2C.c: 179: *data = I2C_DR;
      008466 1E 05            [ 2]  445 	ldw	x, (0x05, sp)
      008468 C6 52 16         [ 1]  446 	ld	a, 0x5216
      00846B F7               [ 1]  447 	ld	(x), a
                                    448 ;	../../my_STM8_libraries/stm8_I2C.c: 181: setACK_I2C(HIGH);
      00846C A6 01            [ 1]  449 	ld	a, #0x01
      00846E CD 82 EE         [ 4]  450 	call	_setACK_I2C
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      008471 A6 01            [ 1]  452 	ld	a, #0x01
      008473                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      008473 1E 02            [ 2]  455 	ldw	x, (2, sp)
      008475 5B 06            [ 2]  456 	addw	sp, #6
      008477 FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      008478                        462 _readBuffer2_I2C:
      008478 52 05            [ 2]  463 	sub	sp, #5
      00847A 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      00847C AE C3 50         [ 2]  466 	ldw	x, #0xc350
      00847F 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: if (start_I2C() == 0) return 0;
      008481 CD 82 CF         [ 4]  469 	call	_start_I2C
      008484 4D               [ 1]  470 	tnz	a
      008485 26 03            [ 1]  471 	jrne	00102$
      008487 4F               [ 1]  472 	clr	a
      008488 20 78            [ 2]  473 	jra	00121$
      00848A                        474 00102$:
                                    475 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00848A 4B 00            [ 1]  476 	push	#0x00
      00848C 7B 06            [ 1]  477 	ld	a, (0x06, sp)
      00848E CD 83 00         [ 4]  478 	call	_writeAddr_I2C
      008491 4D               [ 1]  479 	tnz	a
      008492 26 03            [ 1]  480 	jrne	00104$
      008494 4F               [ 1]  481 	clr	a
      008495 20 6B            [ 2]  482 	jra	00121$
      008497                        483 00104$:
                                    484 ;	../../my_STM8_libraries/stm8_I2C.c: 192: clearADDR_I2C();
      008497 CD 82 E7         [ 4]  485 	call	_clearADDR_I2C
                                    486 ;	../../my_STM8_libraries/stm8_I2C.c: 194: if (writeByte_I2C(reg) == 0) return 0;
      00849A 7B 08            [ 1]  487 	ld	a, (0x08, sp)
      00849C CD 83 40         [ 4]  488 	call	_writeByte_I2C
      00849F 4D               [ 1]  489 	tnz	a
      0084A0 26 03            [ 1]  490 	jrne	00106$
      0084A2 4F               [ 1]  491 	clr	a
      0084A3 20 5D            [ 2]  492 	jra	00121$
      0084A5                        493 00106$:
                                    494 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (start_I2C() == 0) return 0;
      0084A5 CD 82 CF         [ 4]  495 	call	_start_I2C
      0084A8 4D               [ 1]  496 	tnz	a
      0084A9 26 03            [ 1]  497 	jrne	00108$
      0084AB 4F               [ 1]  498 	clr	a
      0084AC 20 54            [ 2]  499 	jra	00121$
      0084AE                        500 00108$:
                                    501 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084AE 4B 01            [ 1]  502 	push	#0x01
      0084B0 7B 06            [ 1]  503 	ld	a, (0x06, sp)
      0084B2 CD 83 00         [ 4]  504 	call	_writeAddr_I2C
      0084B5 4D               [ 1]  505 	tnz	a
      0084B6 26 03            [ 1]  506 	jrne	00110$
      0084B8 4F               [ 1]  507 	clr	a
      0084B9 20 47            [ 2]  508 	jra	00121$
      0084BB                        509 00110$:
                                    510 ;	../../my_STM8_libraries/stm8_I2C.c: 199: clearADDR_I2C();
      0084BB CD 82 E7         [ 4]  511 	call	_clearADDR_I2C
                                    512 ;	../../my_STM8_libraries/stm8_I2C.c: 201: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0084BE AE C3 50         [ 2]  513 	ldw	x, #0xc350
      0084C1                        514 00113$:
      0084C1 72 0C 52 17 0C   [ 2]  515 	btjt	0x5217, #6, 00115$
                                    516 ;	../../my_STM8_libraries/stm8_I2C.c: 203: if (--timeout == 0)
      0084C6 5A               [ 2]  517 	decw	x
      0084C7 1F 01            [ 2]  518 	ldw	(0x01, sp), x
      0084C9 5D               [ 2]  519 	tnzw	x
      0084CA 26 F5            [ 1]  520 	jrne	00113$
                                    521 ;	../../my_STM8_libraries/stm8_I2C.c: 205: stop_I2C();
      0084CC CD 82 CA         [ 4]  522 	call	_stop_I2C
                                    523 ;	../../my_STM8_libraries/stm8_I2C.c: 206: return 0;
      0084CF 4F               [ 1]  524 	clr	a
      0084D0 20 30            [ 2]  525 	jra	00121$
      0084D2                        526 00115$:
                                    527 ;	../../my_STM8_libraries/stm8_I2C.c: 209: buf[0] = I2C_DR;
      0084D2 16 09            [ 2]  528 	ldw	y, (0x09, sp)
      0084D4 17 03            [ 2]  529 	ldw	(0x03, sp), y
      0084D6 C6 52 16         [ 1]  530 	ld	a, 0x5216
      0084D9 1E 03            [ 2]  531 	ldw	x, (0x03, sp)
      0084DB F7               [ 1]  532 	ld	(x), a
                                    533 ;	../../my_STM8_libraries/stm8_I2C.c: 210: setACK_I2C(LOW);
      0084DC 4F               [ 1]  534 	clr	a
      0084DD CD 82 EE         [ 4]  535 	call	_setACK_I2C
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: while (!(I2C_SR1 & I2C_SR1_BTF))
      0084E0 1E 01            [ 2]  537 	ldw	x, (0x01, sp)
      0084E2                        538 00118$:
      0084E2 72 04 52 17 0A   [ 2]  539 	btjt	0x5217, #2, 00120$
                                    540 ;	../../my_STM8_libraries/stm8_I2C.c: 214: if (--timeout == 0)
      0084E7 5A               [ 2]  541 	decw	x
      0084E8 5D               [ 2]  542 	tnzw	x
      0084E9 26 F7            [ 1]  543 	jrne	00118$
                                    544 ;	../../my_STM8_libraries/stm8_I2C.c: 216: stop_I2C();
      0084EB CD 82 CA         [ 4]  545 	call	_stop_I2C
                                    546 ;	../../my_STM8_libraries/stm8_I2C.c: 217: return 0;
      0084EE 4F               [ 1]  547 	clr	a
      0084EF 20 11            [ 2]  548 	jra	00121$
      0084F1                        549 00120$:
                                    550 ;	../../my_STM8_libraries/stm8_I2C.c: 220: stop_I2C();
      0084F1 CD 82 CA         [ 4]  551 	call	_stop_I2C
                                    552 ;	../../my_STM8_libraries/stm8_I2C.c: 222: buf[1] = I2C_DR;
      0084F4 1E 03            [ 2]  553 	ldw	x, (0x03, sp)
      0084F6 5C               [ 1]  554 	incw	x
      0084F7 C6 52 16         [ 1]  555 	ld	a, 0x5216
      0084FA F7               [ 1]  556 	ld	(x), a
                                    557 ;	../../my_STM8_libraries/stm8_I2C.c: 224: setACK_I2C(HIGH);
      0084FB A6 01            [ 1]  558 	ld	a, #0x01
      0084FD CD 82 EE         [ 4]  559 	call	_setACK_I2C
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      008500 A6 01            [ 1]  561 	ld	a, #0x01
      008502                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      008502 1E 06            [ 2]  564 	ldw	x, (6, sp)
      008504 5B 0A            [ 2]  565 	addw	sp, #10
      008506 FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      008507                        571 _readBuffer_I2C:
                                    572 ;	../../my_STM8_libraries/stm8_I2C.c: 231: }
      008507 1E 01            [ 2]  573 	ldw	x, (1, sp)
      008509 5B 06            [ 2]  574 	addw	sp, #6
      00850B FC               [ 2]  575 	jp	(x)
                                    576 	.area CODE
                                    577 	.area CONST
                                    578 	.area INITIALIZER
                                    579 	.area CABS (ABS)
