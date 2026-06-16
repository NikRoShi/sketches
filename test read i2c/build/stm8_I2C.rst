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
      00821B                         60 _init_I2C:
                                     61 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      00821B 72 11 52 10      [ 1]   62 	bres	0x5210, #0
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      00821F 35 10 52 12      [ 1]   64 	mov	0x5212+0, #0x10
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      008223 35 50 52 1B      [ 1]   66 	mov	0x521b+0, #0x50
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      008227 35 00 52 1C      [ 1]   68 	mov	0x521c+0, #0x00
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      00822B 35 11 52 1D      [ 1]   70 	mov	0x521d+0, #0x11
                                     71 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      00822F 72 10 52 10      [ 1]   72 	bset	0x5210, #0
                                     73 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      008233 81               [ 4]   74 	ret
                                     75 ;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
                                     76 ;	-----------------------------------------
                                     77 ;	 function stop_I2C
                                     78 ;	-----------------------------------------
      008234                         79 _stop_I2C:
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008234 72 12 52 11      [ 1]   81 	bset	0x5211, #1
                                     82 ;	../../my_STM8_libraries/stm8_I2C.c: 26: }
      008238 81               [ 4]   83 	ret
                                     84 ;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
                                     85 ;	-----------------------------------------
                                     86 ;	 function start_I2C
                                     87 ;	-----------------------------------------
      008239                         88 _start_I2C:
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008239 72 10 52 11      [ 1]   90 	bset	0x5211, #0
                                     91 ;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      00823D AE C3 50         [ 2]   92 	ldw	x, #0xc350
      008240                         93 00103$:
      008240 72 00 52 17 09   [ 2]   94 	btjt	0x5217, #0, 00105$
                                     95 ;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
      008245 5A               [ 2]   96 	decw	x
      008246 5D               [ 2]   97 	tnzw	x
      008247 26 F7            [ 1]   98 	jrne	00103$
                                     99 ;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
      008249 CD 82 34         [ 4]  100 	call	_stop_I2C
                                    101 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
      00824C 4F               [ 1]  102 	clr	a
      00824D 81               [ 4]  103 	ret
      00824E                        104 00105$:
                                    105 ;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
      00824E A6 01            [ 1]  106 	ld	a, #0x01
                                    107 ;	../../my_STM8_libraries/stm8_I2C.c: 42: }
      008250 81               [ 4]  108 	ret
                                    109 ;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    110 ;	-----------------------------------------
                                    111 ;	 function writeAddr_I2C
                                    112 ;	-----------------------------------------
      008251                        113 _writeAddr_I2C:
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (mode == WRITE) I2C_DR = (address << 1);
      008251 48               [ 1]  115 	sll	a
      008252 0D 03            [ 1]  116 	tnz	(0x03, sp)
      008254 26 03            [ 1]  117 	jrne	00102$
      008256 C7 52 16         [ 1]  118 	ld	0x5216, a
      008259                        119 00102$:
                                    120 ;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008259 88               [ 1]  121 	push	a
      00825A 7B 04            [ 1]  122 	ld	a, (0x04, sp)
      00825C 4A               [ 1]  123 	dec	a
      00825D 84               [ 1]  124 	pop	a
      00825E 26 05            [ 1]  125 	jrne	00119$
      008260 AA 01            [ 1]  126 	or	a, #0x01
      008262 C7 52 16         [ 1]  127 	ld	0x5216, a
                                    128 ;	../../my_STM8_libraries/stm8_I2C.c: 51: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008265                        129 00119$:
      008265 AE C3 50         [ 2]  130 	ldw	x, #0xc350
      008268                        131 00108$:
      008268 72 02 52 17 0F   [ 2]  132 	btjt	0x5217, #1, 00110$
      00826D 72 04 52 18 0A   [ 2]  133 	btjt	0x5218, #2, 00110$
                                    134 ;	../../my_STM8_libraries/stm8_I2C.c: 53: if (--timeout == 0) 
      008272 5A               [ 2]  135 	decw	x
      008273 5D               [ 2]  136 	tnzw	x
      008274 26 F2            [ 1]  137 	jrne	00108$
                                    138 ;	../../my_STM8_libraries/stm8_I2C.c: 55: stop_I2C();
      008276 CD 82 34         [ 4]  139 	call	_stop_I2C
                                    140 ;	../../my_STM8_libraries/stm8_I2C.c: 56: return 0;
      008279 4F               [ 1]  141 	clr	a
      00827A 20 17            [ 2]  142 	jra	00113$
      00827C                        143 00110$:
                                    144 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00827C 72 03 52 17 0A   [ 2]  145 	btjf	0x5217, #1, 00112$
                                    146 ;	../../my_STM8_libraries/stm8_I2C.c: 61: (void)I2C_SR1;	//сбрасываем как в RM
      008281 C6 52 17         [ 1]  147 	ld	a, 0x5217
                                    148 ;	../../my_STM8_libraries/stm8_I2C.c: 62: (void)I2C_SR3;
      008284 C6 52 19         [ 1]  149 	ld	a, 0x5219
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 63: return 1;
      008287 A6 01            [ 1]  151 	ld	a, #0x01
      008289 20 08            [ 2]  152 	jra	00113$
      00828B                        153 00112$:
                                    154 ;	../../my_STM8_libraries/stm8_I2C.c: 65: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      00828B 72 15 52 18      [ 1]  155 	bres	0x5218, #2
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 66: stop_I2C();
      00828F CD 82 34         [ 4]  157 	call	_stop_I2C
                                    158 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 0;
      008292 4F               [ 1]  159 	clr	a
      008293                        160 00113$:
                                    161 ;	../../my_STM8_libraries/stm8_I2C.c: 68: }
      008293 85               [ 2]  162 	popw	x
      008294 5B 01            [ 2]  163 	addw	sp, #1
      008296 FC               [ 2]  164 	jp	(x)
                                    165 ;	../../my_STM8_libraries/stm8_I2C.c: 70: uint8_t writeByte_I2C(uint8_t data)
                                    166 ;	-----------------------------------------
                                    167 ;	 function writeByte_I2C
                                    168 ;	-----------------------------------------
      008297                        169 _writeByte_I2C:
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 74: I2C_DR = data;	//записываем байт в реистр данных
      008297 C7 52 16         [ 1]  171 	ld	0x5216, a
                                    172 ;	../../my_STM8_libraries/stm8_I2C.c: 76: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      00829A AE C3 50         [ 2]  173 	ldw	x, #0xc350
      00829D                        174 00105$:
      00829D C6 52 17         [ 1]  175 	ld	a, 0x5217
      0082A0 2B 17            [ 1]  176 	jrmi	00107$
                                    177 ;	../../my_STM8_libraries/stm8_I2C.c: 78: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0082A2 72 05 52 18 09   [ 2]  178 	btjf	0x5218, #2, 00102$
                                    179 ;	../../my_STM8_libraries/stm8_I2C.c: 80: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0082A7 72 15 52 18      [ 1]  180 	bres	0x5218, #2
                                    181 ;	../../my_STM8_libraries/stm8_I2C.c: 81: stop_I2C();
      0082AB CD 82 34         [ 4]  182 	call	_stop_I2C
                                    183 ;	../../my_STM8_libraries/stm8_I2C.c: 82: return 0;
      0082AE 4F               [ 1]  184 	clr	a
      0082AF 81               [ 4]  185 	ret
      0082B0                        186 00102$:
                                    187 ;	../../my_STM8_libraries/stm8_I2C.c: 84: if (--timeout == 0)	//проверка таймаута
      0082B0 5A               [ 2]  188 	decw	x
      0082B1 5D               [ 2]  189 	tnzw	x
      0082B2 26 E9            [ 1]  190 	jrne	00105$
                                    191 ;	../../my_STM8_libraries/stm8_I2C.c: 86: stop_I2C();
      0082B4 CD 82 34         [ 4]  192 	call	_stop_I2C
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 87: return 0;
      0082B7 4F               [ 1]  194 	clr	a
      0082B8 81               [ 4]  195 	ret
      0082B9                        196 00107$:
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 90: return 1;
      0082B9 A6 01            [ 1]  198 	ld	a, #0x01
                                    199 ;	../../my_STM8_libraries/stm8_I2C.c: 91: }
      0082BB 81               [ 4]  200 	ret
                                    201 ;	../../my_STM8_libraries/stm8_I2C.c: 93: uint8_t ping_I2C(uint8_t address)
                                    202 ;	-----------------------------------------
                                    203 ;	 function ping_I2C
                                    204 ;	-----------------------------------------
      0082BC                        205 _ping_I2C:
      0082BC 88               [ 1]  206 	push	a
      0082BD 6B 01            [ 1]  207 	ld	(0x01, sp), a
                                    208 ;	../../my_STM8_libraries/stm8_I2C.c: 95: if (start_I2C() == 0) return 0;
      0082BF CD 82 39         [ 4]  209 	call	_start_I2C
      0082C2 4D               [ 1]  210 	tnz	a
      0082C3 26 03            [ 1]  211 	jrne	00102$
      0082C5 4F               [ 1]  212 	clr	a
      0082C6 20 12            [ 2]  213 	jra	00105$
      0082C8                        214 00102$:
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 96: if (writeAddr_I2C(address, WRITE) == 0) return 0; 
      0082C8 4B 00            [ 1]  216 	push	#0x00
      0082CA 7B 02            [ 1]  217 	ld	a, (0x02, sp)
      0082CC CD 82 51         [ 4]  218 	call	_writeAddr_I2C
      0082CF 4D               [ 1]  219 	tnz	a
      0082D0 26 03            [ 1]  220 	jrne	00104$
      0082D2 4F               [ 1]  221 	clr	a
      0082D3 20 05            [ 2]  222 	jra	00105$
      0082D5                        223 00104$:
                                    224 ;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
      0082D5 CD 82 34         [ 4]  225 	call	_stop_I2C
                                    226 ;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
      0082D8 A6 01            [ 1]  227 	ld	a, #0x01
      0082DA                        228 00105$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 99: }
      0082DA 5B 01            [ 2]  230 	addw	sp, #1
      0082DC 81               [ 4]  231 	ret
                                    232 ;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    233 ;	-----------------------------------------
                                    234 ;	 function writeReg_I2C
                                    235 ;	-----------------------------------------
      0082DD                        236 _writeReg_I2C:
      0082DD 88               [ 1]  237 	push	a
      0082DE 6B 01            [ 1]  238 	ld	(0x01, sp), a
                                    239 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
      0082E0 CD 82 39         [ 4]  240 	call	_start_I2C
      0082E3 4D               [ 1]  241 	tnz	a
      0082E4 26 03            [ 1]  242 	jrne	00102$
      0082E6 4F               [ 1]  243 	clr	a
      0082E7 20 28            [ 2]  244 	jra	00109$
      0082E9                        245 00102$:
                                    246 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0082E9 4B 00            [ 1]  247 	push	#0x00
      0082EB 7B 02            [ 1]  248 	ld	a, (0x02, sp)
      0082ED CD 82 51         [ 4]  249 	call	_writeAddr_I2C
      0082F0 4D               [ 1]  250 	tnz	a
      0082F1 26 03            [ 1]  251 	jrne	00104$
      0082F3 4F               [ 1]  252 	clr	a
      0082F4 20 1B            [ 2]  253 	jra	00109$
      0082F6                        254 00104$:
                                    255 ;	../../my_STM8_libraries/stm8_I2C.c: 105: if (writeByte_I2C(reg) == 0) return 0;
      0082F6 7B 04            [ 1]  256 	ld	a, (0x04, sp)
      0082F8 CD 82 97         [ 4]  257 	call	_writeByte_I2C
      0082FB 4D               [ 1]  258 	tnz	a
      0082FC 26 03            [ 1]  259 	jrne	00106$
      0082FE 4F               [ 1]  260 	clr	a
      0082FF 20 10            [ 2]  261 	jra	00109$
      008301                        262 00106$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(data) == 0) return 0;
      008301 7B 05            [ 1]  264 	ld	a, (0x05, sp)
      008303 CD 82 97         [ 4]  265 	call	_writeByte_I2C
      008306 4D               [ 1]  266 	tnz	a
      008307 26 03            [ 1]  267 	jrne	00108$
      008309 4F               [ 1]  268 	clr	a
      00830A 20 05            [ 2]  269 	jra	00109$
      00830C                        270 00108$:
                                    271 ;	../../my_STM8_libraries/stm8_I2C.c: 107: stop_I2C();
      00830C CD 82 34         [ 4]  272 	call	_stop_I2C
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: return 1;
      00830F A6 01            [ 1]  274 	ld	a, #0x01
      008311                        275 00109$:
                                    276 ;	../../my_STM8_libraries/stm8_I2C.c: 109: }
      008311 1E 02            [ 2]  277 	ldw	x, (2, sp)
      008313 5B 05            [ 2]  278 	addw	sp, #5
      008315 FC               [ 2]  279 	jp	(x)
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 111: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    281 ;	-----------------------------------------
                                    282 ;	 function readByte_I2C
                                    283 ;	-----------------------------------------
      008316                        284 _readByte_I2C:
      008316 88               [ 1]  285 	push	a
      008317 6B 01            [ 1]  286 	ld	(0x01, sp), a
                                    287 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (start_I2C() == 0) return 0;
      008319 CD 82 39         [ 4]  288 	call	_start_I2C
      00831C 4D               [ 1]  289 	tnz	a
      00831D 26 03            [ 1]  290 	jrne	00102$
      00831F 4F               [ 1]  291 	clr	a
      008320 20 2F            [ 2]  292 	jra	00110$
      008322                        293 00102$:
                                    294 ;	../../my_STM8_libraries/stm8_I2C.c: 116: if (writeAddr_I2C(address, READ) == 0) return 0;
      008322 4B 01            [ 1]  295 	push	#0x01
      008324 7B 02            [ 1]  296 	ld	a, (0x02, sp)
      008326 CD 82 51         [ 4]  297 	call	_writeAddr_I2C
      008329 4D               [ 1]  298 	tnz	a
      00832A 26 03            [ 1]  299 	jrne	00104$
      00832C 4F               [ 1]  300 	clr	a
      00832D 20 22            [ 2]  301 	jra	00110$
      00832F                        302 00104$:
                                    303 ;	../../my_STM8_libraries/stm8_I2C.c: 118: I2C_CR2 &= ~I2C_CR2_ACK;
      00832F 72 15 52 11      [ 1]  304 	bres	0x5211, #2
                                    305 ;	../../my_STM8_libraries/stm8_I2C.c: 120: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008333 AE C3 50         [ 2]  306 	ldw	x, #0xc350
      008336                        307 00107$:
      008336 72 0C 52 17 0A   [ 2]  308 	btjt	0x5217, #6, 00109$
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 122: if (--timeout == 0) 
      00833B 5A               [ 2]  310 	decw	x
      00833C 5D               [ 2]  311 	tnzw	x
      00833D 26 F7            [ 1]  312 	jrne	00107$
                                    313 ;	../../my_STM8_libraries/stm8_I2C.c: 124: stop_I2C();
      00833F CD 82 34         [ 4]  314 	call	_stop_I2C
                                    315 ;	../../my_STM8_libraries/stm8_I2C.c: 125: return 0;
      008342 4F               [ 1]  316 	clr	a
      008343 20 0C            [ 2]  317 	jra	00110$
      008345                        318 00109$:
                                    319 ;	../../my_STM8_libraries/stm8_I2C.c: 128: data = I2C_DR;
      008345 C6 52 16         [ 1]  320 	ld	a, 0x5216
                                    321 ;	../../my_STM8_libraries/stm8_I2C.c: 129: stop_I2C();
      008348 CD 82 34         [ 4]  322 	call	_stop_I2C
                                    323 ;	../../my_STM8_libraries/stm8_I2C.c: 130: I2C_CR2 |= I2C_CR2_ACK;
      00834B 72 14 52 11      [ 1]  324 	bset	0x5211, #2
                                    325 ;	../../my_STM8_libraries/stm8_I2C.c: 131: return 1;
      00834F A6 01            [ 1]  326 	ld	a, #0x01
      008351                        327 00110$:
                                    328 ;	../../my_STM8_libraries/stm8_I2C.c: 132: }
      008351 5B 01            [ 2]  329 	addw	sp, #1
      008353 81               [ 4]  330 	ret
                                    331 	.area CODE
                                    332 	.area CONST
                                    333 	.area INITIALIZER
                                    334 	.area CABS (ABS)
