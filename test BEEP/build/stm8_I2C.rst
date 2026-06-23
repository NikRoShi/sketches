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
      0082A7                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0082A7 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0082AB 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0082AF 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      0082B3 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0082B7 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0082BB 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      0082BF 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      0082C0                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0082C0 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      0082C4 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      0082C5                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      0082C5 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      0082C9 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      0082CC                         98 00103$:
      0082CC 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      0082D1 5A               [ 2]  101 	decw	x
      0082D2 5D               [ 2]  102 	tnzw	x
      0082D3 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      0082D5 CD 82 C0         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      0082D8 4F               [ 1]  107 	clr	a
      0082D9 81               [ 4]  108 	ret
      0082DA                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      0082DA A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      0082DC 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      0082DD                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      0082DD C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      0082E0 C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      0082E3 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      0082E4                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      0082E4 97               [ 1]  131 	ld	xl, a
      0082E5 4D               [ 1]  132 	tnz	a
      0082E6 26 04            [ 1]  133 	jrne	00102$
      0082E8 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      0082EC                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      0082EC 9F               [ 1]  137 	ld	a, xl
      0082ED 4A               [ 1]  138 	dec	a
      0082EE 27 01            [ 1]  139 	jreq	00120$
      0082F0 81               [ 4]  140 	ret
      0082F1                        141 00120$:
      0082F1 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      0082F5 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      0082F6                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      0082F6 48               [ 1]  151 	sll	a
      0082F7 0D 03            [ 1]  152 	tnz	(0x03, sp)
      0082F9 26 03            [ 1]  153 	jrne	00102$
      0082FB C7 52 16         [ 1]  154 	ld	0x5216, a
      0082FE                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      0082FE 88               [ 1]  157 	push	a
      0082FF 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      008301 4A               [ 1]  159 	dec	a
      008302 84               [ 1]  160 	pop	a
      008303 26 05            [ 1]  161 	jrne	00119$
      008305 AA 01            [ 1]  162 	or	a, #0x01
      008307 C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      00830A                        165 00119$:
      00830A AE C3 50         [ 2]  166 	ldw	x, #0xc350
      00830D                        167 00108$:
      00830D 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      008312 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      008317 5A               [ 2]  171 	decw	x
      008318 5D               [ 2]  172 	tnzw	x
      008319 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      00831B CD 82 C0         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      00831E 4F               [ 1]  177 	clr	a
      00831F 20 11            [ 2]  178 	jra	00113$
      008321                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      008321 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      008326 A6 01            [ 1]  183 	ld	a, #0x01
      008328 20 08            [ 2]  184 	jra	00113$
      00832A                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      00832A 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      00832E CD 82 C0         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      008331 4F               [ 1]  191 	clr	a
      008332                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      008332 85               [ 2]  194 	popw	x
      008333 5B 01            [ 2]  195 	addw	sp, #1
      008335 FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      008336                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      008336 C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      008339 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      00833C                        206 00105$:
      00833C C6 52 17         [ 1]  207 	ld	a, 0x5217
      00833F 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      008341 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      008346 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      00834A CD 82 C0         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      00834D 4F               [ 1]  216 	clr	a
      00834E 81               [ 4]  217 	ret
      00834F                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      00834F 5A               [ 2]  220 	decw	x
      008350 5D               [ 2]  221 	tnzw	x
      008351 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      008353 CD 82 C0         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      008356 4F               [ 1]  226 	clr	a
      008357 81               [ 4]  227 	ret
      008358                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      008358 A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      00835A 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      00835B                        237 _ping_I2C:
      00835B 88               [ 1]  238 	push	a
      00835C 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      00835E CD 82 C5         [ 4]  241 	call	_start_I2C
      008361 4D               [ 1]  242 	tnz	a
      008362 26 03            [ 1]  243 	jrne	00102$
      008364 4F               [ 1]  244 	clr	a
      008365 20 15            [ 2]  245 	jra	00105$
      008367                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008367 4B 00            [ 1]  248 	push	#0x00
      008369 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      00836B CD 82 F6         [ 4]  250 	call	_writeAddr_I2C
      00836E 4D               [ 1]  251 	tnz	a
      00836F 26 03            [ 1]  252 	jrne	00104$
      008371 4F               [ 1]  253 	clr	a
      008372 20 08            [ 2]  254 	jra	00105$
      008374                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      008374 CD 82 DD         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      008377 CD 82 C0         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      00837A A6 01            [ 1]  261 	ld	a, #0x01
      00837C                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      00837C 5B 01            [ 2]  264 	addw	sp, #1
      00837E 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      00837F                        270 _writeReg_I2C:
      00837F 88               [ 1]  271 	push	a
      008380 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      008382 CD 82 C5         [ 4]  274 	call	_start_I2C
      008385 4D               [ 1]  275 	tnz	a
      008386 26 03            [ 1]  276 	jrne	00102$
      008388 4F               [ 1]  277 	clr	a
      008389 20 2B            [ 2]  278 	jra	00109$
      00838B                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00838B 4B 00            [ 1]  281 	push	#0x00
      00838D 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      00838F CD 82 F6         [ 4]  283 	call	_writeAddr_I2C
      008392 4D               [ 1]  284 	tnz	a
      008393 26 03            [ 1]  285 	jrne	00104$
      008395 4F               [ 1]  286 	clr	a
      008396 20 1E            [ 2]  287 	jra	00109$
      008398                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      008398 CD 82 DD         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      00839B 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      00839D CD 83 36         [ 4]  293 	call	_writeByte_I2C
      0083A0 4D               [ 1]  294 	tnz	a
      0083A1 26 03            [ 1]  295 	jrne	00106$
      0083A3 4F               [ 1]  296 	clr	a
      0083A4 20 10            [ 2]  297 	jra	00109$
      0083A6                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      0083A6 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      0083A8 CD 83 36         [ 4]  301 	call	_writeByte_I2C
      0083AB 4D               [ 1]  302 	tnz	a
      0083AC 26 03            [ 1]  303 	jrne	00108$
      0083AE 4F               [ 1]  304 	clr	a
      0083AF 20 05            [ 2]  305 	jra	00109$
      0083B1                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      0083B1 CD 82 C0         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      0083B4 A6 01            [ 1]  310 	ld	a, #0x01
      0083B6                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      0083B6 1E 02            [ 2]  313 	ldw	x, (2, sp)
      0083B8 5B 05            [ 2]  314 	addw	sp, #5
      0083BA FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      0083BB                        320 _readByte_I2C:
      0083BB 52 03            [ 2]  321 	sub	sp, #3
      0083BD 6B 03            [ 1]  322 	ld	(0x03, sp), a
      0083BF 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: setACK_I2C(HIGH);
      0083C1 A6 01            [ 1]  325 	ld	a, #0x01
      0083C3 CD 82 E4         [ 4]  326 	call	_setACK_I2C
                                    327 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (start_I2C() == 0) return 0;
      0083C6 CD 82 C5         [ 4]  328 	call	_start_I2C
      0083C9 4D               [ 1]  329 	tnz	a
      0083CA 26 03            [ 1]  330 	jrne	00102$
      0083CC 4F               [ 1]  331 	clr	a
      0083CD 20 31            [ 2]  332 	jra	00110$
      0083CF                        333 00102$:
                                    334 ;	../../my_STM8_libraries/stm8_I2C.c: 129: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083CF 4B 01            [ 1]  335 	push	#0x01
      0083D1 7B 04            [ 1]  336 	ld	a, (0x04, sp)
      0083D3 CD 82 F6         [ 4]  337 	call	_writeAddr_I2C
      0083D6 4D               [ 1]  338 	tnz	a
      0083D7 26 03            [ 1]  339 	jrne	00104$
      0083D9 4F               [ 1]  340 	clr	a
      0083DA 20 24            [ 2]  341 	jra	00110$
      0083DC                        342 00104$:
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: setACK_I2C(LOW);
      0083DC 4F               [ 1]  344 	clr	a
      0083DD CD 82 E4         [ 4]  345 	call	_setACK_I2C
                                    346 ;	../../my_STM8_libraries/stm8_I2C.c: 133: clearADDR_I2C();
      0083E0 CD 82 DD         [ 4]  347 	call	_clearADDR_I2C
                                    348 ;	../../my_STM8_libraries/stm8_I2C.c: 135: stop_I2C();
      0083E3 CD 82 C0         [ 4]  349 	call	_stop_I2C
                                    350 ;	../../my_STM8_libraries/stm8_I2C.c: 137: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083E6 AE C3 50         [ 2]  351 	ldw	x, #0xc350
      0083E9                        352 00107$:
      0083E9 72 0C 52 17 0A   [ 2]  353 	btjt	0x5217, #6, 00109$
                                    354 ;	../../my_STM8_libraries/stm8_I2C.c: 139: if (--timeout == 0) 
      0083EE 5A               [ 2]  355 	decw	x
      0083EF 5D               [ 2]  356 	tnzw	x
      0083F0 26 F7            [ 1]  357 	jrne	00107$
                                    358 ;	../../my_STM8_libraries/stm8_I2C.c: 141: stop_I2C();
      0083F2 CD 82 C0         [ 4]  359 	call	_stop_I2C
                                    360 ;	../../my_STM8_libraries/stm8_I2C.c: 142: return 0;
      0083F5 4F               [ 1]  361 	clr	a
      0083F6 20 08            [ 2]  362 	jra	00110$
      0083F8                        363 00109$:
                                    364 ;	../../my_STM8_libraries/stm8_I2C.c: 145: *data = I2C_DR;
      0083F8 C6 52 16         [ 1]  365 	ld	a, 0x5216
      0083FB 1E 01            [ 2]  366 	ldw	x, (0x01, sp)
      0083FD F7               [ 1]  367 	ld	(x), a
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      0083FE A6 01            [ 1]  369 	ld	a, #0x01
      008400                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      008400 5B 03            [ 2]  372 	addw	sp, #3
      008402 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      008403                        378 _readReg_I2C:
      008403 88               [ 1]  379 	push	a
      008404 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: setACK_I2C(HIGH);
      008406 A6 01            [ 1]  382 	ld	a, #0x01
      008408 CD 82 E4         [ 4]  383 	call	_setACK_I2C
                                    384 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (start_I2C() == 0) return 0;
      00840B CD 82 C5         [ 4]  385 	call	_start_I2C
      00840E 4D               [ 1]  386 	tnz	a
      00840F 26 03            [ 1]  387 	jrne	00102$
      008411 4F               [ 1]  388 	clr	a
      008412 20 55            [ 2]  389 	jra	00116$
      008414                        390 00102$:
                                    391 ;	../../my_STM8_libraries/stm8_I2C.c: 157: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008414 4B 00            [ 1]  392 	push	#0x00
      008416 7B 02            [ 1]  393 	ld	a, (0x02, sp)
      008418 CD 82 F6         [ 4]  394 	call	_writeAddr_I2C
      00841B 4D               [ 1]  395 	tnz	a
      00841C 26 03            [ 1]  396 	jrne	00104$
      00841E 4F               [ 1]  397 	clr	a
      00841F 20 48            [ 2]  398 	jra	00116$
      008421                        399 00104$:
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 159: clearADDR_I2C();
      008421 CD 82 DD         [ 4]  401 	call	_clearADDR_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (writeByte_I2C(reg) == 0) return 0;
      008424 7B 04            [ 1]  403 	ld	a, (0x04, sp)
      008426 CD 83 36         [ 4]  404 	call	_writeByte_I2C
      008429 4D               [ 1]  405 	tnz	a
      00842A 26 03            [ 1]  406 	jrne	00106$
      00842C 4F               [ 1]  407 	clr	a
      00842D 20 3A            [ 2]  408 	jra	00116$
      00842F                        409 00106$:
                                    410 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (start_I2C() == 0) return 0;
      00842F CD 82 C5         [ 4]  411 	call	_start_I2C
      008432 4D               [ 1]  412 	tnz	a
      008433 26 03            [ 1]  413 	jrne	00108$
      008435 4F               [ 1]  414 	clr	a
      008436 20 31            [ 2]  415 	jra	00116$
      008438                        416 00108$:
                                    417 ;	../../my_STM8_libraries/stm8_I2C.c: 165: if (writeAddr_I2C(address, READ) == 0) return 0;
      008438 4B 01            [ 1]  418 	push	#0x01
      00843A 7B 02            [ 1]  419 	ld	a, (0x02, sp)
      00843C CD 82 F6         [ 4]  420 	call	_writeAddr_I2C
      00843F 4D               [ 1]  421 	tnz	a
      008440 26 03            [ 1]  422 	jrne	00110$
      008442 4F               [ 1]  423 	clr	a
      008443 20 24            [ 2]  424 	jra	00116$
      008445                        425 00110$:
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: setACK_I2C(LOW);
      008445 4F               [ 1]  427 	clr	a
      008446 CD 82 E4         [ 4]  428 	call	_setACK_I2C
                                    429 ;	../../my_STM8_libraries/stm8_I2C.c: 169: clearADDR_I2C();
      008449 CD 82 DD         [ 4]  430 	call	_clearADDR_I2C
                                    431 ;	../../my_STM8_libraries/stm8_I2C.c: 171: stop_I2C();
      00844C CD 82 C0         [ 4]  432 	call	_stop_I2C
                                    433 ;	../../my_STM8_libraries/stm8_I2C.c: 173: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00844F AE C3 50         [ 2]  434 	ldw	x, #0xc350
      008452                        435 00113$:
      008452 72 0C 52 17 0A   [ 2]  436 	btjt	0x5217, #6, 00115$
                                    437 ;	../../my_STM8_libraries/stm8_I2C.c: 175: if (--timeout == 0)
      008457 5A               [ 2]  438 	decw	x
      008458 5D               [ 2]  439 	tnzw	x
      008459 26 F7            [ 1]  440 	jrne	00113$
                                    441 ;	../../my_STM8_libraries/stm8_I2C.c: 177: stop_I2C();
      00845B CD 82 C0         [ 4]  442 	call	_stop_I2C
                                    443 ;	../../my_STM8_libraries/stm8_I2C.c: 178: return 0;
      00845E 4F               [ 1]  444 	clr	a
      00845F 20 08            [ 2]  445 	jra	00116$
      008461                        446 00115$:
                                    447 ;	../../my_STM8_libraries/stm8_I2C.c: 181: *data = I2C_DR;
      008461 1E 05            [ 2]  448 	ldw	x, (0x05, sp)
      008463 C6 52 16         [ 1]  449 	ld	a, 0x5216
      008466 F7               [ 1]  450 	ld	(x), a
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      008467 A6 01            [ 1]  452 	ld	a, #0x01
      008469                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      008469 1E 02            [ 2]  455 	ldw	x, (2, sp)
      00846B 5B 06            [ 2]  456 	addw	sp, #6
      00846D FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      00846E                        462 _readBuffer2_I2C:
      00846E 52 05            [ 2]  463 	sub	sp, #5
      008470 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      008472 AE C3 50         [ 2]  466 	ldw	x, #0xc350
      008475 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: setACK_I2C(HIGH);
      008477 A6 01            [ 1]  469 	ld	a, #0x01
      008479 CD 82 E4         [ 4]  470 	call	_setACK_I2C
                                    471 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (start_I2C() == 0) return 0;
      00847C CD 82 C5         [ 4]  472 	call	_start_I2C
      00847F 4D               [ 1]  473 	tnz	a
      008480 26 03            [ 1]  474 	jrne	00102$
      008482 4F               [ 1]  475 	clr	a
      008483 20 73            [ 2]  476 	jra	00121$
      008485                        477 00102$:
                                    478 ;	../../my_STM8_libraries/stm8_I2C.c: 193: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008485 4B 00            [ 1]  479 	push	#0x00
      008487 7B 06            [ 1]  480 	ld	a, (0x06, sp)
      008489 CD 82 F6         [ 4]  481 	call	_writeAddr_I2C
      00848C 4D               [ 1]  482 	tnz	a
      00848D 26 03            [ 1]  483 	jrne	00104$
      00848F 4F               [ 1]  484 	clr	a
      008490 20 66            [ 2]  485 	jra	00121$
      008492                        486 00104$:
                                    487 ;	../../my_STM8_libraries/stm8_I2C.c: 194: clearADDR_I2C();
      008492 CD 82 DD         [ 4]  488 	call	_clearADDR_I2C
                                    489 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (writeByte_I2C(reg) == 0) return 0;
      008495 7B 08            [ 1]  490 	ld	a, (0x08, sp)
      008497 CD 83 36         [ 4]  491 	call	_writeByte_I2C
      00849A 4D               [ 1]  492 	tnz	a
      00849B 26 03            [ 1]  493 	jrne	00106$
      00849D 4F               [ 1]  494 	clr	a
      00849E 20 58            [ 2]  495 	jra	00121$
      0084A0                        496 00106$:
                                    497 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (start_I2C() == 0) return 0;
      0084A0 CD 82 C5         [ 4]  498 	call	_start_I2C
      0084A3 4D               [ 1]  499 	tnz	a
      0084A4 26 03            [ 1]  500 	jrne	00108$
      0084A6 4F               [ 1]  501 	clr	a
      0084A7 20 4F            [ 2]  502 	jra	00121$
      0084A9                        503 00108$:
                                    504 ;	../../my_STM8_libraries/stm8_I2C.c: 200: if (writeAddr_I2C(address, READ) == 0) return 0;
      0084A9 4B 01            [ 1]  505 	push	#0x01
      0084AB 7B 06            [ 1]  506 	ld	a, (0x06, sp)
      0084AD CD 82 F6         [ 4]  507 	call	_writeAddr_I2C
      0084B0 4D               [ 1]  508 	tnz	a
      0084B1 26 03            [ 1]  509 	jrne	00110$
      0084B3 4F               [ 1]  510 	clr	a
      0084B4 20 42            [ 2]  511 	jra	00121$
      0084B6                        512 00110$:
                                    513 ;	../../my_STM8_libraries/stm8_I2C.c: 201: clearADDR_I2C();
      0084B6 CD 82 DD         [ 4]  514 	call	_clearADDR_I2C
                                    515 ;	../../my_STM8_libraries/stm8_I2C.c: 203: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0084B9 AE C3 50         [ 2]  516 	ldw	x, #0xc350
      0084BC                        517 00113$:
      0084BC 72 0C 52 17 0C   [ 2]  518 	btjt	0x5217, #6, 00115$
                                    519 ;	../../my_STM8_libraries/stm8_I2C.c: 205: if (--timeout == 0)
      0084C1 5A               [ 2]  520 	decw	x
      0084C2 1F 01            [ 2]  521 	ldw	(0x01, sp), x
      0084C4 5D               [ 2]  522 	tnzw	x
      0084C5 26 F5            [ 1]  523 	jrne	00113$
                                    524 ;	../../my_STM8_libraries/stm8_I2C.c: 207: stop_I2C();
      0084C7 CD 82 C0         [ 4]  525 	call	_stop_I2C
                                    526 ;	../../my_STM8_libraries/stm8_I2C.c: 208: return 0;
      0084CA 4F               [ 1]  527 	clr	a
      0084CB 20 2B            [ 2]  528 	jra	00121$
      0084CD                        529 00115$:
                                    530 ;	../../my_STM8_libraries/stm8_I2C.c: 211: buf[0] = I2C_DR;
      0084CD 16 09            [ 2]  531 	ldw	y, (0x09, sp)
      0084CF 17 03            [ 2]  532 	ldw	(0x03, sp), y
      0084D1 C6 52 16         [ 1]  533 	ld	a, 0x5216
      0084D4 1E 03            [ 2]  534 	ldw	x, (0x03, sp)
      0084D6 F7               [ 1]  535 	ld	(x), a
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: setACK_I2C(LOW);
      0084D7 4F               [ 1]  537 	clr	a
      0084D8 CD 82 E4         [ 4]  538 	call	_setACK_I2C
                                    539 ;	../../my_STM8_libraries/stm8_I2C.c: 214: while (!(I2C_SR1 & I2C_SR1_BTF))
      0084DB 1E 01            [ 2]  540 	ldw	x, (0x01, sp)
      0084DD                        541 00118$:
      0084DD 72 04 52 17 0A   [ 2]  542 	btjt	0x5217, #2, 00120$
                                    543 ;	../../my_STM8_libraries/stm8_I2C.c: 216: if (--timeout == 0)
      0084E2 5A               [ 2]  544 	decw	x
      0084E3 5D               [ 2]  545 	tnzw	x
      0084E4 26 F7            [ 1]  546 	jrne	00118$
                                    547 ;	../../my_STM8_libraries/stm8_I2C.c: 218: stop_I2C();
      0084E6 CD 82 C0         [ 4]  548 	call	_stop_I2C
                                    549 ;	../../my_STM8_libraries/stm8_I2C.c: 219: return 0;
      0084E9 4F               [ 1]  550 	clr	a
      0084EA 20 0C            [ 2]  551 	jra	00121$
      0084EC                        552 00120$:
                                    553 ;	../../my_STM8_libraries/stm8_I2C.c: 222: stop_I2C();
      0084EC CD 82 C0         [ 4]  554 	call	_stop_I2C
                                    555 ;	../../my_STM8_libraries/stm8_I2C.c: 224: buf[1] = I2C_DR;
      0084EF 1E 03            [ 2]  556 	ldw	x, (0x03, sp)
      0084F1 5C               [ 1]  557 	incw	x
      0084F2 C6 52 16         [ 1]  558 	ld	a, 0x5216
      0084F5 F7               [ 1]  559 	ld	(x), a
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      0084F6 A6 01            [ 1]  561 	ld	a, #0x01
      0084F8                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      0084F8 1E 06            [ 2]  564 	ldw	x, (6, sp)
      0084FA 5B 0A            [ 2]  565 	addw	sp, #10
      0084FC FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      0084FD                        571 _readBuffer_I2C:
      0084FD 52 06            [ 2]  572 	sub	sp, #6
      0084FF 6B 04            [ 1]  573 	ld	(0x04, sp), a
                                    574 ;	../../my_STM8_libraries/stm8_I2C.c: 230: uint16_t timeout = 50000;
      008501 AE C3 50         [ 2]  575 	ldw	x, #0xc350
      008504 1F 01            [ 2]  576 	ldw	(0x01, sp), x
                                    577 ;	../../my_STM8_libraries/stm8_I2C.c: 231: uint8_t i = 0;
      008506 0F 03            [ 1]  578 	clr	(0x03, sp)
                                    579 ;	../../my_STM8_libraries/stm8_I2C.c: 233: setACK_I2C(HIGH);
      008508 A6 01            [ 1]  580 	ld	a, #0x01
      00850A CD 82 E4         [ 4]  581 	call	_setACK_I2C
                                    582 ;	../../my_STM8_libraries/stm8_I2C.c: 235: if (size == 1) 
      00850D 7B 0C            [ 1]  583 	ld	a, (0x0c, sp)
      00850F 4A               [ 1]  584 	dec	a
      008510 26 17            [ 1]  585 	jrne	00104$
                                    586 ;	../../my_STM8_libraries/stm8_I2C.c: 237: if (readReg_I2C(address, reg, buf) == 0) return 0;
      008512 1E 0A            [ 2]  587 	ldw	x, (0x0a, sp)
      008514 89               [ 2]  588 	pushw	x
      008515 7B 0B            [ 1]  589 	ld	a, (0x0b, sp)
      008517 88               [ 1]  590 	push	a
      008518 7B 07            [ 1]  591 	ld	a, (0x07, sp)
      00851A CD 84 03         [ 4]  592 	call	_readReg_I2C
      00851D 4D               [ 1]  593 	tnz	a
      00851E 26 04            [ 1]  594 	jrne	00102$
      008520 4F               [ 1]  595 	clr	a
      008521 CC 86 13         [ 2]  596 	jp	00137$
      008524                        597 00102$:
                                    598 ;	../../my_STM8_libraries/stm8_I2C.c: 238: return 1;
      008524 A6 01            [ 1]  599 	ld	a, #0x01
      008526 CC 86 13         [ 2]  600 	jp	00137$
      008529                        601 00104$:
                                    602 ;	../../my_STM8_libraries/stm8_I2C.c: 240: if (size == 2)
      008529 7B 0C            [ 1]  603 	ld	a, (0x0c, sp)
      00852B A1 02            [ 1]  604 	cp	a, #0x02
      00852D 26 17            [ 1]  605 	jrne	00108$
                                    606 ;	../../my_STM8_libraries/stm8_I2C.c: 242: if (readBuffer2_I2C(address, reg, buf) == 0) return 0;
      00852F 1E 0A            [ 2]  607 	ldw	x, (0x0a, sp)
      008531 89               [ 2]  608 	pushw	x
      008532 7B 0B            [ 1]  609 	ld	a, (0x0b, sp)
      008534 88               [ 1]  610 	push	a
      008535 7B 07            [ 1]  611 	ld	a, (0x07, sp)
      008537 CD 84 6E         [ 4]  612 	call	_readBuffer2_I2C
      00853A 4D               [ 1]  613 	tnz	a
      00853B 26 04            [ 1]  614 	jrne	00106$
      00853D 4F               [ 1]  615 	clr	a
      00853E CC 86 13         [ 2]  616 	jp	00137$
      008541                        617 00106$:
                                    618 ;	../../my_STM8_libraries/stm8_I2C.c: 243: return 1;
      008541 A6 01            [ 1]  619 	ld	a, #0x01
      008543 CC 86 13         [ 2]  620 	jp	00137$
      008546                        621 00108$:
                                    622 ;	../../my_STM8_libraries/stm8_I2C.c: 245: if (start_I2C() == 0) return 0;
      008546 CD 82 C5         [ 4]  623 	call	_start_I2C
      008549 4D               [ 1]  624 	tnz	a
      00854A 26 04            [ 1]  625 	jrne	00110$
      00854C 4F               [ 1]  626 	clr	a
      00854D CC 86 13         [ 2]  627 	jp	00137$
      008550                        628 00110$:
                                    629 ;	../../my_STM8_libraries/stm8_I2C.c: 247: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008550 4B 00            [ 1]  630 	push	#0x00
      008552 7B 05            [ 1]  631 	ld	a, (0x05, sp)
      008554 CD 82 F6         [ 4]  632 	call	_writeAddr_I2C
      008557 4D               [ 1]  633 	tnz	a
      008558 26 04            [ 1]  634 	jrne	00112$
      00855A 4F               [ 1]  635 	clr	a
      00855B CC 86 13         [ 2]  636 	jp	00137$
      00855E                        637 00112$:
                                    638 ;	../../my_STM8_libraries/stm8_I2C.c: 248: clearADDR_I2C();
      00855E CD 82 DD         [ 4]  639 	call	_clearADDR_I2C
                                    640 ;	../../my_STM8_libraries/stm8_I2C.c: 250: if (writeByte_I2C(reg) == 0) return 0;
      008561 7B 09            [ 1]  641 	ld	a, (0x09, sp)
      008563 CD 83 36         [ 4]  642 	call	_writeByte_I2C
      008566 4D               [ 1]  643 	tnz	a
      008567 26 04            [ 1]  644 	jrne	00114$
      008569 4F               [ 1]  645 	clr	a
      00856A CC 86 13         [ 2]  646 	jp	00137$
      00856D                        647 00114$:
                                    648 ;	../../my_STM8_libraries/stm8_I2C.c: 252: if (start_I2C() == 0) return 0;
      00856D CD 82 C5         [ 4]  649 	call	_start_I2C
      008570 4D               [ 1]  650 	tnz	a
      008571 26 04            [ 1]  651 	jrne	00116$
      008573 4F               [ 1]  652 	clr	a
      008574 CC 86 13         [ 2]  653 	jp	00137$
      008577                        654 00116$:
                                    655 ;	../../my_STM8_libraries/stm8_I2C.c: 254: if (writeAddr_I2C(address, READ) == 0) return 0;
      008577 4B 01            [ 1]  656 	push	#0x01
      008579 7B 05            [ 1]  657 	ld	a, (0x05, sp)
      00857B CD 82 F6         [ 4]  658 	call	_writeAddr_I2C
      00857E 4D               [ 1]  659 	tnz	a
      00857F 26 04            [ 1]  660 	jrne	00118$
      008581 4F               [ 1]  661 	clr	a
      008582 CC 86 13         [ 2]  662 	jp	00137$
      008585                        663 00118$:
                                    664 ;	../../my_STM8_libraries/stm8_I2C.c: 255: clearADDR_I2C();
      008585 CD 82 DD         [ 4]  665 	call	_clearADDR_I2C
                                    666 ;	../../my_STM8_libraries/stm8_I2C.c: 257: while (size > 3)
      008588 0F 05            [ 1]  667 	clr	(0x05, sp)
      00858A 7B 0C            [ 1]  668 	ld	a, (0x0c, sp)
      00858C 6B 06            [ 1]  669 	ld	(0x06, sp), a
      00858E                        670 00124$:
      00858E 7B 06            [ 1]  671 	ld	a, (0x06, sp)
      008590 A1 03            [ 1]  672 	cp	a, #0x03
      008592 23 2B            [ 2]  673 	jrule	00153$
                                    674 ;	../../my_STM8_libraries/stm8_I2C.c: 259: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008594 1E 01            [ 2]  675 	ldw	x, (0x01, sp)
      008596                        676 00121$:
      008596 72 0C 52 17 0A   [ 2]  677 	btjt	0x5217, #6, 00123$
                                    678 ;	../../my_STM8_libraries/stm8_I2C.c: 261: if (--timeout == 0)
      00859B 5A               [ 2]  679 	decw	x
      00859C 5D               [ 2]  680 	tnzw	x
      00859D 26 F7            [ 1]  681 	jrne	00121$
                                    682 ;	../../my_STM8_libraries/stm8_I2C.c: 263: stop_I2C();
      00859F CD 82 C0         [ 4]  683 	call	_stop_I2C
                                    684 ;	../../my_STM8_libraries/stm8_I2C.c: 264: return 0;
      0085A2 4F               [ 1]  685 	clr	a
      0085A3 20 6E            [ 2]  686 	jra	00137$
      0085A5                        687 00123$:
                                    688 ;	../../my_STM8_libraries/stm8_I2C.c: 267: timeout = 50000;
      0085A5 AE C3 50         [ 2]  689 	ldw	x, #0xc350
      0085A8 1F 01            [ 2]  690 	ldw	(0x01, sp), x
                                    691 ;	../../my_STM8_libraries/stm8_I2C.c: 268: buf[i] = I2C_DR;
      0085AA 5F               [ 1]  692 	clrw	x
      0085AB 7B 05            [ 1]  693 	ld	a, (0x05, sp)
      0085AD 97               [ 1]  694 	ld	xl, a
      0085AE 72 FB 0A         [ 2]  695 	addw	x, (0x0a, sp)
      0085B1 C6 52 16         [ 1]  696 	ld	a, 0x5216
      0085B4 F7               [ 1]  697 	ld	(x), a
                                    698 ;	../../my_STM8_libraries/stm8_I2C.c: 269: i++;
      0085B5 0C 05            [ 1]  699 	inc	(0x05, sp)
      0085B7 7B 05            [ 1]  700 	ld	a, (0x05, sp)
      0085B9 6B 03            [ 1]  701 	ld	(0x03, sp), a
                                    702 ;	../../my_STM8_libraries/stm8_I2C.c: 270: size--;
      0085BB 0A 06            [ 1]  703 	dec	(0x06, sp)
      0085BD 20 CF            [ 2]  704 	jra	00124$
                                    705 ;	../../my_STM8_libraries/stm8_I2C.c: 273: while (!(I2C_SR1 & I2C_SR1_BTF))
      0085BF                        706 00153$:
      0085BF 1E 01            [ 2]  707 	ldw	x, (0x01, sp)
      0085C1                        708 00129$:
      0085C1 72 04 52 17 0A   [ 2]  709 	btjt	0x5217, #2, 00131$
                                    710 ;	../../my_STM8_libraries/stm8_I2C.c: 275: if (--timeout == 0)
      0085C6 5A               [ 2]  711 	decw	x
      0085C7 5D               [ 2]  712 	tnzw	x
      0085C8 26 F7            [ 1]  713 	jrne	00129$
                                    714 ;	../../my_STM8_libraries/stm8_I2C.c: 277: stop_I2C();
      0085CA CD 82 C0         [ 4]  715 	call	_stop_I2C
                                    716 ;	../../my_STM8_libraries/stm8_I2C.c: 278: return 0;
      0085CD 4F               [ 1]  717 	clr	a
      0085CE 20 43            [ 2]  718 	jra	00137$
      0085D0                        719 00131$:
                                    720 ;	../../my_STM8_libraries/stm8_I2C.c: 283: setACK_I2C(LOW);
      0085D0 4F               [ 1]  721 	clr	a
      0085D1 CD 82 E4         [ 4]  722 	call	_setACK_I2C
                                    723 ;	../../my_STM8_libraries/stm8_I2C.c: 285: buf[i] = I2C_DR;
      0085D4 5F               [ 1]  724 	clrw	x
      0085D5 7B 03            [ 1]  725 	ld	a, (0x03, sp)
      0085D7 97               [ 1]  726 	ld	xl, a
      0085D8 72 FB 0A         [ 2]  727 	addw	x, (0x0a, sp)
      0085DB C6 52 16         [ 1]  728 	ld	a, 0x5216
      0085DE F7               [ 1]  729 	ld	(x), a
                                    730 ;	../../my_STM8_libraries/stm8_I2C.c: 286: i++;
      0085DF 7B 03            [ 1]  731 	ld	a, (0x03, sp)
      0085E1 4C               [ 1]  732 	inc	a
      0085E2 6B 06            [ 1]  733 	ld	(0x06, sp), a
                                    734 ;	../../my_STM8_libraries/stm8_I2C.c: 288: stop_I2C();
      0085E4 CD 82 C0         [ 4]  735 	call	_stop_I2C
                                    736 ;	../../my_STM8_libraries/stm8_I2C.c: 290: buf[i] = I2C_DR;
      0085E7 5F               [ 1]  737 	clrw	x
      0085E8 7B 06            [ 1]  738 	ld	a, (0x06, sp)
      0085EA 97               [ 1]  739 	ld	xl, a
      0085EB 72 FB 0A         [ 2]  740 	addw	x, (0x0a, sp)
      0085EE C6 52 16         [ 1]  741 	ld	a, 0x5216
      0085F1 F7               [ 1]  742 	ld	(x), a
                                    743 ;	../../my_STM8_libraries/stm8_I2C.c: 291: i++;
      0085F2 0C 06            [ 1]  744 	inc	(0x06, sp)
                                    745 ;	../../my_STM8_libraries/stm8_I2C.c: 293: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0085F4 AE C3 50         [ 2]  746 	ldw	x, #0xc350
      0085F7                        747 00134$:
      0085F7 72 0C 52 17 0A   [ 2]  748 	btjt	0x5217, #6, 00136$
                                    749 ;	../../my_STM8_libraries/stm8_I2C.c: 295: if (--timeout == 0)
      0085FC 5A               [ 2]  750 	decw	x
      0085FD 5D               [ 2]  751 	tnzw	x
      0085FE 26 F7            [ 1]  752 	jrne	00134$
                                    753 ;	../../my_STM8_libraries/stm8_I2C.c: 297: stop_I2C();
      008600 CD 82 C0         [ 4]  754 	call	_stop_I2C
                                    755 ;	../../my_STM8_libraries/stm8_I2C.c: 298: return 0;
      008603 4F               [ 1]  756 	clr	a
      008604 20 0D            [ 2]  757 	jra	00137$
      008606                        758 00136$:
                                    759 ;	../../my_STM8_libraries/stm8_I2C.c: 301: buf[i] = I2C_DR;
      008606 5F               [ 1]  760 	clrw	x
      008607 7B 06            [ 1]  761 	ld	a, (0x06, sp)
      008609 97               [ 1]  762 	ld	xl, a
      00860A 72 FB 0A         [ 2]  763 	addw	x, (0x0a, sp)
      00860D C6 52 16         [ 1]  764 	ld	a, 0x5216
      008610 F7               [ 1]  765 	ld	(x), a
                                    766 ;	../../my_STM8_libraries/stm8_I2C.c: 303: return 1;
      008611 A6 01            [ 1]  767 	ld	a, #0x01
      008613                        768 00137$:
                                    769 ;	../../my_STM8_libraries/stm8_I2C.c: 304: }
      008613 1E 07            [ 2]  770 	ldw	x, (7, sp)
      008615 5B 0C            [ 2]  771 	addw	sp, #12
      008617 FC               [ 2]  772 	jp	(x)
                                    773 	.area CODE
                                    774 	.area CONST
                                    775 	.area INITIALIZER
                                    776 	.area CABS (ABS)
