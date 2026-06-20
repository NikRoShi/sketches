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
      00829C                         60 _init_I2C:
                                     61 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      00829C 72 11 52 10      [ 1]   62 	bres	0x5210, #0
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0082A0 35 10 52 12      [ 1]   64 	mov	0x5212+0, #0x10
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0082A4 35 50 52 1B      [ 1]   66 	mov	0x521b+0, #0x50
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      0082A8 35 00 52 1C      [ 1]   68 	mov	0x521c+0, #0x00
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0082AC 35 11 52 1D      [ 1]   70 	mov	0x521d+0, #0x11
                                     71 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0082B0 72 10 52 10      [ 1]   72 	bset	0x5210, #0
                                     73 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      0082B4 81               [ 4]   74 	ret
                                     75 ;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
                                     76 ;	-----------------------------------------
                                     77 ;	 function stop_I2C
                                     78 ;	-----------------------------------------
      0082B5                         79 _stop_I2C:
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0082B5 72 12 52 11      [ 1]   81 	bset	0x5211, #1
                                     82 ;	../../my_STM8_libraries/stm8_I2C.c: 26: }
      0082B9 81               [ 4]   83 	ret
                                     84 ;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
                                     85 ;	-----------------------------------------
                                     86 ;	 function start_I2C
                                     87 ;	-----------------------------------------
      0082BA                         88 _start_I2C:
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      0082BA 72 10 52 11      [ 1]   90 	bset	0x5211, #0
                                     91 ;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      0082BE AE C3 50         [ 2]   92 	ldw	x, #0xc350
      0082C1                         93 00103$:
      0082C1 72 00 52 17 09   [ 2]   94 	btjt	0x5217, #0, 00105$
                                     95 ;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
      0082C6 5A               [ 2]   96 	decw	x
      0082C7 5D               [ 2]   97 	tnzw	x
      0082C8 26 F7            [ 1]   98 	jrne	00103$
                                     99 ;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
      0082CA CD 82 B5         [ 4]  100 	call	_stop_I2C
                                    101 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
      0082CD 4F               [ 1]  102 	clr	a
      0082CE 81               [ 4]  103 	ret
      0082CF                        104 00105$:
                                    105 ;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
      0082CF A6 01            [ 1]  106 	ld	a, #0x01
                                    107 ;	../../my_STM8_libraries/stm8_I2C.c: 42: }
      0082D1 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    110 ;	-----------------------------------------
                                    111 ;	 function writeAddr_I2C
                                    112 ;	-----------------------------------------
      0082D2                        113 _writeAddr_I2C:
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (mode == WRITE) I2C_DR = (address << 1);
      0082D2 48               [ 1]  115 	sll	a
      0082D3 0D 03            [ 1]  116 	tnz	(0x03, sp)
      0082D5 26 03            [ 1]  117 	jrne	00102$
      0082D7 C7 52 16         [ 1]  118 	ld	0x5216, a
      0082DA                        119 00102$:
                                    120 ;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      0082DA 88               [ 1]  121 	push	a
      0082DB 7B 04            [ 1]  122 	ld	a, (0x04, sp)
      0082DD 4A               [ 1]  123 	dec	a
      0082DE 84               [ 1]  124 	pop	a
      0082DF 26 05            [ 1]  125 	jrne	00119$
      0082E1 AA 01            [ 1]  126 	or	a, #0x01
      0082E3 C7 52 16         [ 1]  127 	ld	0x5216, a
                                    128 ;	../../my_STM8_libraries/stm8_I2C.c: 51: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      0082E6                        129 00119$:
      0082E6 AE C3 50         [ 2]  130 	ldw	x, #0xc350
      0082E9                        131 00108$:
      0082E9 72 02 52 17 0F   [ 2]  132 	btjt	0x5217, #1, 00110$
      0082EE 72 04 52 18 0A   [ 2]  133 	btjt	0x5218, #2, 00110$
                                    134 ;	../../my_STM8_libraries/stm8_I2C.c: 53: if (--timeout == 0) 
      0082F3 5A               [ 2]  135 	decw	x
      0082F4 5D               [ 2]  136 	tnzw	x
      0082F5 26 F2            [ 1]  137 	jrne	00108$
                                    138 ;	../../my_STM8_libraries/stm8_I2C.c: 55: stop_I2C();
      0082F7 CD 82 B5         [ 4]  139 	call	_stop_I2C
                                    140 ;	../../my_STM8_libraries/stm8_I2C.c: 56: return 0;
      0082FA 4F               [ 1]  141 	clr	a
      0082FB 20 17            [ 2]  142 	jra	00113$
      0082FD                        143 00110$:
                                    144 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      0082FD 72 03 52 17 0A   [ 2]  145 	btjf	0x5217, #1, 00112$
                                    146 ;	../../my_STM8_libraries/stm8_I2C.c: 61: (void)I2C_SR1;	//сбрасываем как в RM
      008302 C6 52 17         [ 1]  147 	ld	a, 0x5217
                                    148 ;	../../my_STM8_libraries/stm8_I2C.c: 62: (void)I2C_SR3;
      008305 C6 52 19         [ 1]  149 	ld	a, 0x5219
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 63: return 1;
      008308 A6 01            [ 1]  151 	ld	a, #0x01
      00830A 20 08            [ 2]  152 	jra	00113$
      00830C                        153 00112$:
                                    154 ;	../../my_STM8_libraries/stm8_I2C.c: 65: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      00830C 72 15 52 18      [ 1]  155 	bres	0x5218, #2
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 66: stop_I2C();
      008310 CD 82 B5         [ 4]  157 	call	_stop_I2C
                                    158 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 0;
      008313 4F               [ 1]  159 	clr	a
      008314                        160 00113$:
                                    161 ;	../../my_STM8_libraries/stm8_I2C.c: 68: }
      008314 85               [ 2]  162 	popw	x
      008315 5B 01            [ 2]  163 	addw	sp, #1
      008317 FC               [ 2]  164 	jp	(x)
                                    165 ;	../../my_STM8_libraries/stm8_I2C.c: 70: uint8_t writeByte_I2C(uint8_t data)
                                    166 ;	-----------------------------------------
                                    167 ;	 function writeByte_I2C
                                    168 ;	-----------------------------------------
      008318                        169 _writeByte_I2C:
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 74: I2C_DR = data;	//записываем байт в реистр данных
      008318 C7 52 16         [ 1]  171 	ld	0x5216, a
                                    172 ;	../../my_STM8_libraries/stm8_I2C.c: 76: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      00831B AE C3 50         [ 2]  173 	ldw	x, #0xc350
      00831E                        174 00105$:
      00831E C6 52 17         [ 1]  175 	ld	a, 0x5217
      008321 2B 17            [ 1]  176 	jrmi	00107$
                                    177 ;	../../my_STM8_libraries/stm8_I2C.c: 78: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      008323 72 05 52 18 09   [ 2]  178 	btjf	0x5218, #2, 00102$
                                    179 ;	../../my_STM8_libraries/stm8_I2C.c: 80: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      008328 72 15 52 18      [ 1]  180 	bres	0x5218, #2
                                    181 ;	../../my_STM8_libraries/stm8_I2C.c: 81: stop_I2C();
      00832C CD 82 B5         [ 4]  182 	call	_stop_I2C
                                    183 ;	../../my_STM8_libraries/stm8_I2C.c: 82: return 0;
      00832F 4F               [ 1]  184 	clr	a
      008330 81               [ 4]  185 	ret
      008331                        186 00102$:
                                    187 ;	../../my_STM8_libraries/stm8_I2C.c: 84: if (--timeout == 0)	//проверка таймаута
      008331 5A               [ 2]  188 	decw	x
      008332 5D               [ 2]  189 	tnzw	x
      008333 26 E9            [ 1]  190 	jrne	00105$
                                    191 ;	../../my_STM8_libraries/stm8_I2C.c: 86: stop_I2C();
      008335 CD 82 B5         [ 4]  192 	call	_stop_I2C
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 87: return 0;
      008338 4F               [ 1]  194 	clr	a
      008339 81               [ 4]  195 	ret
      00833A                        196 00107$:
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 90: return 1;
      00833A A6 01            [ 1]  198 	ld	a, #0x01
                                    199 ;	../../my_STM8_libraries/stm8_I2C.c: 91: }
      00833C 81               [ 4]  200 	ret
                                    201 ;	../../my_STM8_libraries/stm8_I2C.c: 93: uint8_t ping_I2C(uint8_t address)
                                    202 ;	-----------------------------------------
                                    203 ;	 function ping_I2C
                                    204 ;	-----------------------------------------
      00833D                        205 _ping_I2C:
      00833D 88               [ 1]  206 	push	a
      00833E 6B 01            [ 1]  207 	ld	(0x01, sp), a
                                    208 ;	../../my_STM8_libraries/stm8_I2C.c: 95: if (start_I2C() == 0) return 0;
      008340 CD 82 BA         [ 4]  209 	call	_start_I2C
      008343 4D               [ 1]  210 	tnz	a
      008344 26 03            [ 1]  211 	jrne	00102$
      008346 4F               [ 1]  212 	clr	a
      008347 20 12            [ 2]  213 	jra	00105$
      008349                        214 00102$:
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 96: if (writeAddr_I2C(address, WRITE) == 0) return 0; 
      008349 4B 00            [ 1]  216 	push	#0x00
      00834B 7B 02            [ 1]  217 	ld	a, (0x02, sp)
      00834D CD 82 D2         [ 4]  218 	call	_writeAddr_I2C
      008350 4D               [ 1]  219 	tnz	a
      008351 26 03            [ 1]  220 	jrne	00104$
      008353 4F               [ 1]  221 	clr	a
      008354 20 05            [ 2]  222 	jra	00105$
      008356                        223 00104$:
                                    224 ;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
      008356 CD 82 B5         [ 4]  225 	call	_stop_I2C
                                    226 ;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
      008359 A6 01            [ 1]  227 	ld	a, #0x01
      00835B                        228 00105$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 99: }
      00835B 5B 01            [ 2]  230 	addw	sp, #1
      00835D 81               [ 4]  231 	ret
                                    232 ;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    233 ;	-----------------------------------------
                                    234 ;	 function writeReg_I2C
                                    235 ;	-----------------------------------------
      00835E                        236 _writeReg_I2C:
      00835E 88               [ 1]  237 	push	a
      00835F 6B 01            [ 1]  238 	ld	(0x01, sp), a
                                    239 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
      008361 CD 82 BA         [ 4]  240 	call	_start_I2C
      008364 4D               [ 1]  241 	tnz	a
      008365 26 03            [ 1]  242 	jrne	00102$
      008367 4F               [ 1]  243 	clr	a
      008368 20 28            [ 2]  244 	jra	00109$
      00836A                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00836A 4B 00            [ 1]  247 	push	#0x00
      00836C 7B 02            [ 1]  248 	ld	a, (0x02, sp)
      00836E CD 82 D2         [ 4]  249 	call	_writeAddr_I2C
      008371 4D               [ 1]  250 	tnz	a
      008372 26 03            [ 1]  251 	jrne	00104$
      008374 4F               [ 1]  252 	clr	a
      008375 20 1B            [ 2]  253 	jra	00109$
      008377                        254 00104$:
                                    255 ;	../../my_STM8_libraries/stm8_I2C.c: 105: if (writeByte_I2C(reg) == 0) return 0;
      008377 7B 04            [ 1]  256 	ld	a, (0x04, sp)
      008379 CD 83 18         [ 4]  257 	call	_writeByte_I2C
      00837C 4D               [ 1]  258 	tnz	a
      00837D 26 03            [ 1]  259 	jrne	00106$
      00837F 4F               [ 1]  260 	clr	a
      008380 20 10            [ 2]  261 	jra	00109$
      008382                        262 00106$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(data) == 0) return 0;
      008382 7B 05            [ 1]  264 	ld	a, (0x05, sp)
      008384 CD 83 18         [ 4]  265 	call	_writeByte_I2C
      008387 4D               [ 1]  266 	tnz	a
      008388 26 03            [ 1]  267 	jrne	00108$
      00838A 4F               [ 1]  268 	clr	a
      00838B 20 05            [ 2]  269 	jra	00109$
      00838D                        270 00108$:
                                    271 ;	../../my_STM8_libraries/stm8_I2C.c: 107: stop_I2C();
      00838D CD 82 B5         [ 4]  272 	call	_stop_I2C
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: return 1;
      008390 A6 01            [ 1]  274 	ld	a, #0x01
      008392                        275 00109$:
                                    276 ;	../../my_STM8_libraries/stm8_I2C.c: 109: }
      008392 1E 02            [ 2]  277 	ldw	x, (2, sp)
      008394 5B 05            [ 2]  278 	addw	sp, #5
      008396 FC               [ 2]  279 	jp	(x)
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 111: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    281 ;	-----------------------------------------
                                    282 ;	 function readByte_I2C
                                    283 ;	-----------------------------------------
      008397                        284 _readByte_I2C:
      008397 52 03            [ 2]  285 	sub	sp, #3
      008399 6B 03            [ 1]  286 	ld	(0x03, sp), a
      00839B 1F 01            [ 2]  287 	ldw	(0x01, sp), x
                                    288 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (start_I2C() == 0) return 0;
      00839D CD 82 BA         [ 4]  289 	call	_start_I2C
      0083A0 4D               [ 1]  290 	tnz	a
      0083A1 26 03            [ 1]  291 	jrne	00102$
      0083A3 4F               [ 1]  292 	clr	a
      0083A4 20 32            [ 2]  293 	jra	00110$
      0083A6                        294 00102$:
                                    295 ;	../../my_STM8_libraries/stm8_I2C.c: 117: I2C_CR2 &= ~I2C_CR2_ACK;
      0083A6 72 15 52 11      [ 1]  296 	bres	0x5211, #2
                                    297 ;	../../my_STM8_libraries/stm8_I2C.c: 119: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083AA 4B 01            [ 1]  298 	push	#0x01
      0083AC 7B 04            [ 1]  299 	ld	a, (0x04, sp)
      0083AE CD 82 D2         [ 4]  300 	call	_writeAddr_I2C
      0083B1 4D               [ 1]  301 	tnz	a
      0083B2 26 03            [ 1]  302 	jrne	00115$
      0083B4 4F               [ 1]  303 	clr	a
      0083B5 20 21            [ 2]  304 	jra	00110$
                                    305 ;	../../my_STM8_libraries/stm8_I2C.c: 121: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083B7                        306 00115$:
      0083B7 AE C3 50         [ 2]  307 	ldw	x, #0xc350
      0083BA                        308 00107$:
      0083BA 72 0C 52 17 0A   [ 2]  309 	btjt	0x5217, #6, 00109$
                                    310 ;	../../my_STM8_libraries/stm8_I2C.c: 123: if (--timeout == 0) 
      0083BF 5A               [ 2]  311 	decw	x
      0083C0 5D               [ 2]  312 	tnzw	x
      0083C1 26 F7            [ 1]  313 	jrne	00107$
                                    314 ;	../../my_STM8_libraries/stm8_I2C.c: 125: stop_I2C();
      0083C3 CD 82 B5         [ 4]  315 	call	_stop_I2C
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 126: return 0;
      0083C6 4F               [ 1]  317 	clr	a
      0083C7 20 0F            [ 2]  318 	jra	00110$
      0083C9                        319 00109$:
                                    320 ;	../../my_STM8_libraries/stm8_I2C.c: 129: *data = I2C_DR;
      0083C9 C6 52 16         [ 1]  321 	ld	a, 0x5216
      0083CC 1E 01            [ 2]  322 	ldw	x, (0x01, sp)
      0083CE F7               [ 1]  323 	ld	(x), a
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 130: stop_I2C();
      0083CF CD 82 B5         [ 4]  325 	call	_stop_I2C
                                    326 ;	../../my_STM8_libraries/stm8_I2C.c: 131: I2C_CR2 |= I2C_CR2_ACK;
      0083D2 72 14 52 11      [ 1]  327 	bset	0x5211, #2
                                    328 ;	../../my_STM8_libraries/stm8_I2C.c: 132: return 1;
      0083D6 A6 01            [ 1]  329 	ld	a, #0x01
      0083D8                        330 00110$:
                                    331 ;	../../my_STM8_libraries/stm8_I2C.c: 133: }
      0083D8 5B 03            [ 2]  332 	addw	sp, #3
      0083DA 81               [ 4]  333 	ret
                                    334 	.area CODE
                                    335 	.area CONST
                                    336 	.area INITIALIZER
                                    337 	.area CABS (ABS)
