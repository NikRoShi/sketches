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
                                     15 	.globl _writeAddr_I2C
                                     16 	.globl _writeByte_I2C
                                     17 	.globl _ping_I2C
                                     18 	.globl _writeReg_I2C
                                     19 	.globl _readByte_I2C
                                     20 	.globl _readReg_I2C
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 
                                     34 ; default segment ordering for linker
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area CONST
                                     39 	.area INITIALIZER
                                     40 	.area CODE
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; global & static initialisations
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area GSINIT
                                     49 ;--------------------------------------------------------
                                     50 ; Home
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area HOME
                                     54 ;--------------------------------------------------------
                                     55 ; code
                                     56 ;--------------------------------------------------------
                                     57 	.area CODE
                                     58 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     59 ;	-----------------------------------------
                                     60 ;	 function init_I2C
                                     61 ;	-----------------------------------------
      008237                         62 _init_I2C:
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      008237 72 11 52 10      [ 1]   64 	bres	0x5210, #0
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      00823B 35 10 52 12      [ 1]   66 	mov	0x5212+0, #0x10
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      00823F 35 50 52 1B      [ 1]   68 	mov	0x521b+0, #0x50
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      008243 35 00 52 1C      [ 1]   70 	mov	0x521c+0, #0x00
                                     71 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008247 35 11 52 1D      [ 1]   72 	mov	0x521d+0, #0x11
                                     73 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      00824B 72 10 52 10      [ 1]   74 	bset	0x5210, #0
                                     75 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      00824F 81               [ 4]   76 	ret
                                     77 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     78 ;	-----------------------------------------
                                     79 ;	 function stop_I2C
                                     80 ;	-----------------------------------------
      008250                         81 _stop_I2C:
                                     82 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008250 72 12 52 11      [ 1]   83 	bset	0x5211, #1
                                     84 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      008254 81               [ 4]   85 	ret
                                     86 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     87 ;	-----------------------------------------
                                     88 ;	 function start_I2C
                                     89 ;	-----------------------------------------
      008255                         90 _start_I2C:
                                     91 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008255 72 10 52 11      [ 1]   92 	bset	0x5211, #0
                                     93 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008259 AE C3 50         [ 2]   94 	ldw	x, #0xc350
      00825C                         95 00103$:
      00825C 72 00 52 17 09   [ 2]   96 	btjt	0x5217, #0, 00105$
                                     97 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      008261 5A               [ 2]   98 	decw	x
      008262 5D               [ 2]   99 	tnzw	x
      008263 26 F7            [ 1]  100 	jrne	00103$
                                    101 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      008265 CD 82 50         [ 4]  102 	call	_stop_I2C
                                    103 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      008268 4F               [ 1]  104 	clr	a
      008269 81               [ 4]  105 	ret
      00826A                        106 00105$:
                                    107 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      00826A A6 01            [ 1]  108 	ld	a, #0x01
                                    109 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      00826C 81               [ 4]  110 	ret
                                    111 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    112 ;	-----------------------------------------
                                    113 ;	 function clearADDR_I2C
                                    114 ;	-----------------------------------------
      00826D                        115 _clearADDR_I2C:
                                    116 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      00826D C6 52 17         [ 1]  117 	ld	a, 0x5217
                                    118 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      008270 C6 52 19         [ 1]  119 	ld	a, 0x5219
                                    120 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      008273 81               [ 4]  121 	ret
                                    122 ;	../../my_STM8_libraries/stm8_I2C.c: 45: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    123 ;	-----------------------------------------
                                    124 ;	 function writeAddr_I2C
                                    125 ;	-----------------------------------------
      008274                        126 _writeAddr_I2C:
                                    127 ;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == WRITE) I2C_DR = (address << 1);
      008274 48               [ 1]  128 	sll	a
      008275 0D 03            [ 1]  129 	tnz	(0x03, sp)
      008277 26 03            [ 1]  130 	jrne	00102$
      008279 C7 52 16         [ 1]  131 	ld	0x5216, a
      00827C                        132 00102$:
                                    133 ;	../../my_STM8_libraries/stm8_I2C.c: 50: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      00827C 88               [ 1]  134 	push	a
      00827D 7B 04            [ 1]  135 	ld	a, (0x04, sp)
      00827F 4A               [ 1]  136 	dec	a
      008280 84               [ 1]  137 	pop	a
      008281 26 05            [ 1]  138 	jrne	00119$
      008283 AA 01            [ 1]  139 	or	a, #0x01
      008285 C7 52 16         [ 1]  140 	ld	0x5216, a
                                    141 ;	../../my_STM8_libraries/stm8_I2C.c: 52: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008288                        142 00119$:
      008288 AE C3 50         [ 2]  143 	ldw	x, #0xc350
      00828B                        144 00108$:
      00828B 72 02 52 17 0F   [ 2]  145 	btjt	0x5217, #1, 00110$
      008290 72 04 52 18 0A   [ 2]  146 	btjt	0x5218, #2, 00110$
                                    147 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (--timeout == 0) 
      008295 5A               [ 2]  148 	decw	x
      008296 5D               [ 2]  149 	tnzw	x
      008297 26 F2            [ 1]  150 	jrne	00108$
                                    151 ;	../../my_STM8_libraries/stm8_I2C.c: 56: stop_I2C();
      008299 CD 82 50         [ 4]  152 	call	_stop_I2C
                                    153 ;	../../my_STM8_libraries/stm8_I2C.c: 57: return 0;
      00829C 4F               [ 1]  154 	clr	a
      00829D 20 11            [ 2]  155 	jra	00113$
      00829F                        156 00110$:
                                    157 ;	../../my_STM8_libraries/stm8_I2C.c: 60: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00829F 72 03 52 17 04   [ 2]  158 	btjf	0x5217, #1, 00112$
                                    159 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 1;
      0082A4 A6 01            [ 1]  160 	ld	a, #0x01
      0082A6 20 08            [ 2]  161 	jra	00113$
      0082A8                        162 00112$:
                                    163 ;	../../my_STM8_libraries/stm8_I2C.c: 64: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      0082A8 72 15 52 18      [ 1]  164 	bres	0x5218, #2
                                    165 ;	../../my_STM8_libraries/stm8_I2C.c: 65: stop_I2C();
      0082AC CD 82 50         [ 4]  166 	call	_stop_I2C
                                    167 ;	../../my_STM8_libraries/stm8_I2C.c: 66: return 0;
      0082AF 4F               [ 1]  168 	clr	a
      0082B0                        169 00113$:
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 67: }
      0082B0 85               [ 2]  171 	popw	x
      0082B1 5B 01            [ 2]  172 	addw	sp, #1
      0082B3 FC               [ 2]  173 	jp	(x)
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 69: uint8_t writeByte_I2C(uint8_t data)
                                    175 ;	-----------------------------------------
                                    176 ;	 function writeByte_I2C
                                    177 ;	-----------------------------------------
      0082B4                        178 _writeByte_I2C:
                                    179 ;	../../my_STM8_libraries/stm8_I2C.c: 73: I2C_DR = data;	//записываем байт в реистр данных
      0082B4 C7 52 16         [ 1]  180 	ld	0x5216, a
                                    181 ;	../../my_STM8_libraries/stm8_I2C.c: 75: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      0082B7 AE C3 50         [ 2]  182 	ldw	x, #0xc350
      0082BA                        183 00105$:
      0082BA C6 52 17         [ 1]  184 	ld	a, 0x5217
      0082BD 2B 17            [ 1]  185 	jrmi	00107$
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 77: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0082BF 72 05 52 18 09   [ 2]  187 	btjf	0x5218, #2, 00102$
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 79: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0082C4 72 15 52 18      [ 1]  189 	bres	0x5218, #2
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 80: stop_I2C();
      0082C8 CD 82 50         [ 4]  191 	call	_stop_I2C
                                    192 ;	../../my_STM8_libraries/stm8_I2C.c: 81: return 0;
      0082CB 4F               [ 1]  193 	clr	a
      0082CC 81               [ 4]  194 	ret
      0082CD                        195 00102$:
                                    196 ;	../../my_STM8_libraries/stm8_I2C.c: 83: if (--timeout == 0)	//проверка таймаута
      0082CD 5A               [ 2]  197 	decw	x
      0082CE 5D               [ 2]  198 	tnzw	x
      0082CF 26 E9            [ 1]  199 	jrne	00105$
                                    200 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      0082D1 CD 82 50         [ 4]  201 	call	_stop_I2C
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      0082D4 4F               [ 1]  203 	clr	a
      0082D5 81               [ 4]  204 	ret
      0082D6                        205 00107$:
                                    206 ;	../../my_STM8_libraries/stm8_I2C.c: 89: return 1;
      0082D6 A6 01            [ 1]  207 	ld	a, #0x01
                                    208 ;	../../my_STM8_libraries/stm8_I2C.c: 90: }
      0082D8 81               [ 4]  209 	ret
                                    210 ;	../../my_STM8_libraries/stm8_I2C.c: 92: uint8_t ping_I2C(uint8_t address)
                                    211 ;	-----------------------------------------
                                    212 ;	 function ping_I2C
                                    213 ;	-----------------------------------------
      0082D9                        214 _ping_I2C:
      0082D9 88               [ 1]  215 	push	a
      0082DA 6B 01            [ 1]  216 	ld	(0x01, sp), a
                                    217 ;	../../my_STM8_libraries/stm8_I2C.c: 94: if (start_I2C() == 0) return 0;
      0082DC CD 82 55         [ 4]  218 	call	_start_I2C
      0082DF 4D               [ 1]  219 	tnz	a
      0082E0 26 03            [ 1]  220 	jrne	00102$
      0082E2 4F               [ 1]  221 	clr	a
      0082E3 20 15            [ 2]  222 	jra	00105$
      0082E5                        223 00102$:
                                    224 ;	../../my_STM8_libraries/stm8_I2C.c: 95: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0082E5 4B 00            [ 1]  225 	push	#0x00
      0082E7 7B 02            [ 1]  226 	ld	a, (0x02, sp)
      0082E9 CD 82 74         [ 4]  227 	call	_writeAddr_I2C
      0082EC 4D               [ 1]  228 	tnz	a
      0082ED 26 03            [ 1]  229 	jrne	00104$
      0082EF 4F               [ 1]  230 	clr	a
      0082F0 20 08            [ 2]  231 	jra	00105$
      0082F2                        232 00104$:
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 96: clearADDR_I2C(); 
      0082F2 CD 82 6D         [ 4]  234 	call	_clearADDR_I2C
                                    235 ;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
      0082F5 CD 82 50         [ 4]  236 	call	_stop_I2C
                                    237 ;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
      0082F8 A6 01            [ 1]  238 	ld	a, #0x01
      0082FA                        239 00105$:
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: }
      0082FA 5B 01            [ 2]  241 	addw	sp, #1
      0082FC 81               [ 4]  242 	ret
                                    243 ;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    244 ;	-----------------------------------------
                                    245 ;	 function writeReg_I2C
                                    246 ;	-----------------------------------------
      0082FD                        247 _writeReg_I2C:
      0082FD 88               [ 1]  248 	push	a
      0082FE 6B 01            [ 1]  249 	ld	(0x01, sp), a
                                    250 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
      008300 CD 82 55         [ 4]  251 	call	_start_I2C
      008303 4D               [ 1]  252 	tnz	a
      008304 26 03            [ 1]  253 	jrne	00102$
      008306 4F               [ 1]  254 	clr	a
      008307 20 2B            [ 2]  255 	jra	00109$
      008309                        256 00102$:
                                    257 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008309 4B 00            [ 1]  258 	push	#0x00
      00830B 7B 02            [ 1]  259 	ld	a, (0x02, sp)
      00830D CD 82 74         [ 4]  260 	call	_writeAddr_I2C
      008310 4D               [ 1]  261 	tnz	a
      008311 26 03            [ 1]  262 	jrne	00104$
      008313 4F               [ 1]  263 	clr	a
      008314 20 1E            [ 2]  264 	jra	00109$
      008316                        265 00104$:
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 105: clearADDR_I2C();
      008316 CD 82 6D         [ 4]  267 	call	_clearADDR_I2C
                                    268 ;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(reg) == 0) return 0;
      008319 7B 04            [ 1]  269 	ld	a, (0x04, sp)
      00831B CD 82 B4         [ 4]  270 	call	_writeByte_I2C
      00831E 4D               [ 1]  271 	tnz	a
      00831F 26 03            [ 1]  272 	jrne	00106$
      008321 4F               [ 1]  273 	clr	a
      008322 20 10            [ 2]  274 	jra	00109$
      008324                        275 00106$:
                                    276 ;	../../my_STM8_libraries/stm8_I2C.c: 107: if (writeByte_I2C(data) == 0) return 0;
      008324 7B 05            [ 1]  277 	ld	a, (0x05, sp)
      008326 CD 82 B4         [ 4]  278 	call	_writeByte_I2C
      008329 4D               [ 1]  279 	tnz	a
      00832A 26 03            [ 1]  280 	jrne	00108$
      00832C 4F               [ 1]  281 	clr	a
      00832D 20 05            [ 2]  282 	jra	00109$
      00832F                        283 00108$:
                                    284 ;	../../my_STM8_libraries/stm8_I2C.c: 108: stop_I2C();
      00832F CD 82 50         [ 4]  285 	call	_stop_I2C
                                    286 ;	../../my_STM8_libraries/stm8_I2C.c: 109: return 1;
      008332 A6 01            [ 1]  287 	ld	a, #0x01
      008334                        288 00109$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 110: }
      008334 1E 02            [ 2]  290 	ldw	x, (2, sp)
      008336 5B 05            [ 2]  291 	addw	sp, #5
      008338 FC               [ 2]  292 	jp	(x)
                                    293 ;	../../my_STM8_libraries/stm8_I2C.c: 112: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    294 ;	-----------------------------------------
                                    295 ;	 function readByte_I2C
                                    296 ;	-----------------------------------------
      008339                        297 _readByte_I2C:
      008339 52 03            [ 2]  298 	sub	sp, #3
      00833B 6B 03            [ 1]  299 	ld	(0x03, sp), a
      00833D 1F 01            [ 2]  300 	ldw	(0x01, sp), x
                                    301 ;	../../my_STM8_libraries/stm8_I2C.c: 116: if (start_I2C() == 0) return 0;
      00833F CD 82 55         [ 4]  302 	call	_start_I2C
      008342 4D               [ 1]  303 	tnz	a
      008343 26 03            [ 1]  304 	jrne	00102$
      008345 4F               [ 1]  305 	clr	a
      008346 20 35            [ 2]  306 	jra	00110$
      008348                        307 00102$:
                                    308 ;	../../my_STM8_libraries/stm8_I2C.c: 118: I2C_CR2 &= ~I2C_CR2_ACK;
      008348 72 15 52 11      [ 1]  309 	bres	0x5211, #2
                                    310 ;	../../my_STM8_libraries/stm8_I2C.c: 120: if (writeAddr_I2C(address, READ) == 0) return 0;
      00834C 4B 01            [ 1]  311 	push	#0x01
      00834E 7B 04            [ 1]  312 	ld	a, (0x04, sp)
      008350 CD 82 74         [ 4]  313 	call	_writeAddr_I2C
      008353 4D               [ 1]  314 	tnz	a
      008354 26 03            [ 1]  315 	jrne	00104$
      008356 4F               [ 1]  316 	clr	a
      008357 20 24            [ 2]  317 	jra	00110$
      008359                        318 00104$:
                                    319 ;	../../my_STM8_libraries/stm8_I2C.c: 122: clearADDR_I2C();
      008359 CD 82 6D         [ 4]  320 	call	_clearADDR_I2C
                                    321 ;	../../my_STM8_libraries/stm8_I2C.c: 124: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00835C AE C3 50         [ 2]  322 	ldw	x, #0xc350
      00835F                        323 00107$:
      00835F 72 0C 52 17 0A   [ 2]  324 	btjt	0x5217, #6, 00109$
                                    325 ;	../../my_STM8_libraries/stm8_I2C.c: 126: if (--timeout == 0) 
      008364 5A               [ 2]  326 	decw	x
      008365 5D               [ 2]  327 	tnzw	x
      008366 26 F7            [ 1]  328 	jrne	00107$
                                    329 ;	../../my_STM8_libraries/stm8_I2C.c: 128: stop_I2C();
      008368 CD 82 50         [ 4]  330 	call	_stop_I2C
                                    331 ;	../../my_STM8_libraries/stm8_I2C.c: 129: return 0;
      00836B 4F               [ 1]  332 	clr	a
      00836C 20 0F            [ 2]  333 	jra	00110$
      00836E                        334 00109$:
                                    335 ;	../../my_STM8_libraries/stm8_I2C.c: 132: *data = I2C_DR;
      00836E C6 52 16         [ 1]  336 	ld	a, 0x5216
      008371 1E 01            [ 2]  337 	ldw	x, (0x01, sp)
      008373 F7               [ 1]  338 	ld	(x), a
                                    339 ;	../../my_STM8_libraries/stm8_I2C.c: 133: I2C_CR2 |= I2C_CR2_ACK;
      008374 72 14 52 11      [ 1]  340 	bset	0x5211, #2
                                    341 ;	../../my_STM8_libraries/stm8_I2C.c: 134: stop_I2C();
      008378 CD 82 50         [ 4]  342 	call	_stop_I2C
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 135: return 1;
      00837B A6 01            [ 1]  344 	ld	a, #0x01
      00837D                        345 00110$:
                                    346 ;	../../my_STM8_libraries/stm8_I2C.c: 136: }
      00837D 5B 03            [ 2]  347 	addw	sp, #3
      00837F 81               [ 4]  348 	ret
                                    349 ;	../../my_STM8_libraries/stm8_I2C.c: 137: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    350 ;	-----------------------------------------
                                    351 ;	 function readReg_I2C
                                    352 ;	-----------------------------------------
      008380                        353 _readReg_I2C:
      008380 88               [ 1]  354 	push	a
      008381 6B 01            [ 1]  355 	ld	(0x01, sp), a
                                    356 ;	../../my_STM8_libraries/stm8_I2C.c: 141: if (start_I2C() == 0) return 0;
      008383 CD 82 55         [ 4]  357 	call	_start_I2C
      008386 4D               [ 1]  358 	tnz	a
      008387 26 03            [ 1]  359 	jrne	00102$
      008389 4F               [ 1]  360 	clr	a
      00838A 20 59            [ 2]  361 	jra	00116$
      00838C                        362 00102$:
                                    363 ;	../../my_STM8_libraries/stm8_I2C.c: 143: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00838C 4B 00            [ 1]  364 	push	#0x00
      00838E 7B 02            [ 1]  365 	ld	a, (0x02, sp)
      008390 CD 82 74         [ 4]  366 	call	_writeAddr_I2C
      008393 4D               [ 1]  367 	tnz	a
      008394 26 03            [ 1]  368 	jrne	00104$
      008396 4F               [ 1]  369 	clr	a
      008397 20 4C            [ 2]  370 	jra	00116$
      008399                        371 00104$:
                                    372 ;	../../my_STM8_libraries/stm8_I2C.c: 145: clearADDR_I2C();
      008399 CD 82 6D         [ 4]  373 	call	_clearADDR_I2C
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 147: if (writeByte_I2C(reg) == 0) return 0;
      00839C 7B 04            [ 1]  375 	ld	a, (0x04, sp)
      00839E CD 82 B4         [ 4]  376 	call	_writeByte_I2C
      0083A1 4D               [ 1]  377 	tnz	a
      0083A2 26 03            [ 1]  378 	jrne	00106$
      0083A4 4F               [ 1]  379 	clr	a
      0083A5 20 3E            [ 2]  380 	jra	00116$
      0083A7                        381 00106$:
                                    382 ;	../../my_STM8_libraries/stm8_I2C.c: 149: if (start_I2C() == 0) return 0;
      0083A7 CD 82 55         [ 4]  383 	call	_start_I2C
      0083AA 4D               [ 1]  384 	tnz	a
      0083AB 26 03            [ 1]  385 	jrne	00108$
      0083AD 4F               [ 1]  386 	clr	a
      0083AE 20 35            [ 2]  387 	jra	00116$
      0083B0                        388 00108$:
                                    389 ;	../../my_STM8_libraries/stm8_I2C.c: 151: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083B0 4B 01            [ 1]  390 	push	#0x01
      0083B2 7B 02            [ 1]  391 	ld	a, (0x02, sp)
      0083B4 CD 82 74         [ 4]  392 	call	_writeAddr_I2C
      0083B7 4D               [ 1]  393 	tnz	a
      0083B8 26 03            [ 1]  394 	jrne	00110$
      0083BA 4F               [ 1]  395 	clr	a
      0083BB 20 28            [ 2]  396 	jra	00116$
      0083BD                        397 00110$:
                                    398 ;	../../my_STM8_libraries/stm8_I2C.c: 153: I2C_CR2 &= ~I2C_CR2_ACK;
      0083BD 72 15 52 11      [ 1]  399 	bres	0x5211, #2
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 155: clearADDR_I2C();
      0083C1 CD 82 6D         [ 4]  401 	call	_clearADDR_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 157: stop_I2C();
      0083C4 CD 82 50         [ 4]  403 	call	_stop_I2C
                                    404 ;	../../my_STM8_libraries/stm8_I2C.c: 159: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083C7 AE C3 50         [ 2]  405 	ldw	x, #0xc350
      0083CA                        406 00113$:
      0083CA 72 0C 52 17 0A   [ 2]  407 	btjt	0x5217, #6, 00115$
                                    408 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (--timeout == 0)
      0083CF 5A               [ 2]  409 	decw	x
      0083D0 5D               [ 2]  410 	tnzw	x
      0083D1 26 F7            [ 1]  411 	jrne	00113$
                                    412 ;	../../my_STM8_libraries/stm8_I2C.c: 163: stop_I2C();
      0083D3 CD 82 50         [ 4]  413 	call	_stop_I2C
                                    414 ;	../../my_STM8_libraries/stm8_I2C.c: 164: return 0;
      0083D6 4F               [ 1]  415 	clr	a
      0083D7 20 0C            [ 2]  416 	jra	00116$
      0083D9                        417 00115$:
                                    418 ;	../../my_STM8_libraries/stm8_I2C.c: 167: *data = I2C_DR;
      0083D9 1E 05            [ 2]  419 	ldw	x, (0x05, sp)
      0083DB C6 52 16         [ 1]  420 	ld	a, 0x5216
      0083DE F7               [ 1]  421 	ld	(x), a
                                    422 ;	../../my_STM8_libraries/stm8_I2C.c: 168: I2C_CR2 |= I2C_CR2_ACK;
      0083DF 72 14 52 11      [ 1]  423 	bset	0x5211, #2
                                    424 ;	../../my_STM8_libraries/stm8_I2C.c: 169: return 1;
      0083E3 A6 01            [ 1]  425 	ld	a, #0x01
      0083E5                        426 00116$:
                                    427 ;	../../my_STM8_libraries/stm8_I2C.c: 170: }
      0083E5 1E 02            [ 2]  428 	ldw	x, (2, sp)
      0083E7 5B 06            [ 2]  429 	addw	sp, #6
      0083E9 FC               [ 2]  430 	jp	(x)
                                    431 	.area CODE
                                    432 	.area CONST
                                    433 	.area INITIALIZER
                                    434 	.area CABS (ABS)
