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
                                     19 	.globl _readReg_I2C
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; global & static initialisations
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area GSINIT
                                     48 ;--------------------------------------------------------
                                     49 ; Home
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area HOME
                                     53 ;--------------------------------------------------------
                                     54 ; code
                                     55 ;--------------------------------------------------------
                                     56 	.area CODE
                                     57 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     58 ;	-----------------------------------------
                                     59 ;	 function init_I2C
                                     60 ;	-----------------------------------------
      008237                         61 _init_I2C:
                                     62 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      008237 72 11 52 10      [ 1]   63 	bres	0x5210, #0
                                     64 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      00823B 35 10 52 12      [ 1]   65 	mov	0x5212+0, #0x10
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      00823F 35 50 52 1B      [ 1]   67 	mov	0x521b+0, #0x50
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      008243 35 00 52 1C      [ 1]   69 	mov	0x521c+0, #0x00
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008247 35 11 52 1D      [ 1]   71 	mov	0x521d+0, #0x11
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      00824B 72 10 52 10      [ 1]   73 	bset	0x5210, #0
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      00824F 81               [ 4]   75 	ret
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
                                     77 ;	-----------------------------------------
                                     78 ;	 function stop_I2C
                                     79 ;	-----------------------------------------
      008250                         80 _stop_I2C:
                                     81 ;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008250 72 12 52 11      [ 1]   82 	bset	0x5211, #1
                                     83 ;	../../my_STM8_libraries/stm8_I2C.c: 26: }
      008254 81               [ 4]   84 	ret
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
                                     86 ;	-----------------------------------------
                                     87 ;	 function start_I2C
                                     88 ;	-----------------------------------------
      008255                         89 _start_I2C:
                                     90 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008255 72 10 52 11      [ 1]   91 	bset	0x5211, #0
                                     92 ;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008259 AE C3 50         [ 2]   93 	ldw	x, #0xc350
      00825C                         94 00103$:
      00825C 72 00 52 17 09   [ 2]   95 	btjt	0x5217, #0, 00105$
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
      008261 5A               [ 2]   97 	decw	x
      008262 5D               [ 2]   98 	tnzw	x
      008263 26 F7            [ 1]   99 	jrne	00103$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
      008265 CD 82 50         [ 4]  101 	call	_stop_I2C
                                    102 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
      008268 4F               [ 1]  103 	clr	a
      008269 81               [ 4]  104 	ret
      00826A                        105 00105$:
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
      00826A A6 01            [ 1]  107 	ld	a, #0x01
                                    108 ;	../../my_STM8_libraries/stm8_I2C.c: 42: }
      00826C 81               [ 4]  109 	ret
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    111 ;	-----------------------------------------
                                    112 ;	 function writeAddr_I2C
                                    113 ;	-----------------------------------------
      00826D                        114 _writeAddr_I2C:
                                    115 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (mode == WRITE) I2C_DR = (address << 1);
      00826D 48               [ 1]  116 	sll	a
      00826E 0D 03            [ 1]  117 	tnz	(0x03, sp)
      008270 26 03            [ 1]  118 	jrne	00102$
      008272 C7 52 16         [ 1]  119 	ld	0x5216, a
      008275                        120 00102$:
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 49: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008275 88               [ 1]  122 	push	a
      008276 7B 04            [ 1]  123 	ld	a, (0x04, sp)
      008278 4A               [ 1]  124 	dec	a
      008279 84               [ 1]  125 	pop	a
      00827A 26 05            [ 1]  126 	jrne	00119$
      00827C AA 01            [ 1]  127 	or	a, #0x01
      00827E C7 52 16         [ 1]  128 	ld	0x5216, a
                                    129 ;	../../my_STM8_libraries/stm8_I2C.c: 51: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008281                        130 00119$:
      008281 AE C3 50         [ 2]  131 	ldw	x, #0xc350
      008284                        132 00108$:
      008284 72 02 52 17 0F   [ 2]  133 	btjt	0x5217, #1, 00110$
      008289 72 04 52 18 0A   [ 2]  134 	btjt	0x5218, #2, 00110$
                                    135 ;	../../my_STM8_libraries/stm8_I2C.c: 53: if (--timeout == 0) 
      00828E 5A               [ 2]  136 	decw	x
      00828F 5D               [ 2]  137 	tnzw	x
      008290 26 F2            [ 1]  138 	jrne	00108$
                                    139 ;	../../my_STM8_libraries/stm8_I2C.c: 55: stop_I2C();
      008292 CD 82 50         [ 4]  140 	call	_stop_I2C
                                    141 ;	../../my_STM8_libraries/stm8_I2C.c: 56: return 0;
      008295 4F               [ 1]  142 	clr	a
      008296 20 17            [ 2]  143 	jra	00113$
      008298                        144 00110$:
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      008298 72 03 52 17 0A   [ 2]  146 	btjf	0x5217, #1, 00112$
                                    147 ;	../../my_STM8_libraries/stm8_I2C.c: 61: (void)I2C_SR1;	//сбрасываем как в RM
      00829D C6 52 17         [ 1]  148 	ld	a, 0x5217
                                    149 ;	../../my_STM8_libraries/stm8_I2C.c: 62: (void)I2C_SR3;
      0082A0 C6 52 19         [ 1]  150 	ld	a, 0x5219
                                    151 ;	../../my_STM8_libraries/stm8_I2C.c: 63: return 1;
      0082A3 A6 01            [ 1]  152 	ld	a, #0x01
      0082A5 20 08            [ 2]  153 	jra	00113$
      0082A7                        154 00112$:
                                    155 ;	../../my_STM8_libraries/stm8_I2C.c: 65: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      0082A7 72 15 52 18      [ 1]  156 	bres	0x5218, #2
                                    157 ;	../../my_STM8_libraries/stm8_I2C.c: 66: stop_I2C();
      0082AB CD 82 50         [ 4]  158 	call	_stop_I2C
                                    159 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 0;
      0082AE 4F               [ 1]  160 	clr	a
      0082AF                        161 00113$:
                                    162 ;	../../my_STM8_libraries/stm8_I2C.c: 68: }
      0082AF 85               [ 2]  163 	popw	x
      0082B0 5B 01            [ 2]  164 	addw	sp, #1
      0082B2 FC               [ 2]  165 	jp	(x)
                                    166 ;	../../my_STM8_libraries/stm8_I2C.c: 70: uint8_t writeByte_I2C(uint8_t data)
                                    167 ;	-----------------------------------------
                                    168 ;	 function writeByte_I2C
                                    169 ;	-----------------------------------------
      0082B3                        170 _writeByte_I2C:
                                    171 ;	../../my_STM8_libraries/stm8_I2C.c: 74: I2C_DR = data;	//записываем байт в реистр данных
      0082B3 C7 52 16         [ 1]  172 	ld	0x5216, a
                                    173 ;	../../my_STM8_libraries/stm8_I2C.c: 76: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      0082B6 AE C3 50         [ 2]  174 	ldw	x, #0xc350
      0082B9                        175 00105$:
      0082B9 C6 52 17         [ 1]  176 	ld	a, 0x5217
      0082BC 2B 17            [ 1]  177 	jrmi	00107$
                                    178 ;	../../my_STM8_libraries/stm8_I2C.c: 78: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0082BE 72 05 52 18 09   [ 2]  179 	btjf	0x5218, #2, 00102$
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 80: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0082C3 72 15 52 18      [ 1]  181 	bres	0x5218, #2
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 81: stop_I2C();
      0082C7 CD 82 50         [ 4]  183 	call	_stop_I2C
                                    184 ;	../../my_STM8_libraries/stm8_I2C.c: 82: return 0;
      0082CA 4F               [ 1]  185 	clr	a
      0082CB 81               [ 4]  186 	ret
      0082CC                        187 00102$:
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 84: if (--timeout == 0)	//проверка таймаута
      0082CC 5A               [ 2]  189 	decw	x
      0082CD 5D               [ 2]  190 	tnzw	x
      0082CE 26 E9            [ 1]  191 	jrne	00105$
                                    192 ;	../../my_STM8_libraries/stm8_I2C.c: 86: stop_I2C();
      0082D0 CD 82 50         [ 4]  193 	call	_stop_I2C
                                    194 ;	../../my_STM8_libraries/stm8_I2C.c: 87: return 0;
      0082D3 4F               [ 1]  195 	clr	a
      0082D4 81               [ 4]  196 	ret
      0082D5                        197 00107$:
                                    198 ;	../../my_STM8_libraries/stm8_I2C.c: 90: return 1;
      0082D5 A6 01            [ 1]  199 	ld	a, #0x01
                                    200 ;	../../my_STM8_libraries/stm8_I2C.c: 91: }
      0082D7 81               [ 4]  201 	ret
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 93: uint8_t ping_I2C(uint8_t address)
                                    203 ;	-----------------------------------------
                                    204 ;	 function ping_I2C
                                    205 ;	-----------------------------------------
      0082D8                        206 _ping_I2C:
      0082D8 88               [ 1]  207 	push	a
      0082D9 6B 01            [ 1]  208 	ld	(0x01, sp), a
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 95: if (start_I2C() == 0) return 0;
      0082DB CD 82 55         [ 4]  210 	call	_start_I2C
      0082DE 4D               [ 1]  211 	tnz	a
      0082DF 26 03            [ 1]  212 	jrne	00102$
      0082E1 4F               [ 1]  213 	clr	a
      0082E2 20 12            [ 2]  214 	jra	00105$
      0082E4                        215 00102$:
                                    216 ;	../../my_STM8_libraries/stm8_I2C.c: 96: if (writeAddr_I2C(address, WRITE) == 0) return 0; 
      0082E4 4B 00            [ 1]  217 	push	#0x00
      0082E6 7B 02            [ 1]  218 	ld	a, (0x02, sp)
      0082E8 CD 82 6D         [ 4]  219 	call	_writeAddr_I2C
      0082EB 4D               [ 1]  220 	tnz	a
      0082EC 26 03            [ 1]  221 	jrne	00104$
      0082EE 4F               [ 1]  222 	clr	a
      0082EF 20 05            [ 2]  223 	jra	00105$
      0082F1                        224 00104$:
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 97: stop_I2C();
      0082F1 CD 82 50         [ 4]  226 	call	_stop_I2C
                                    227 ;	../../my_STM8_libraries/stm8_I2C.c: 98: return 1;
      0082F4 A6 01            [ 1]  228 	ld	a, #0x01
      0082F6                        229 00105$:
                                    230 ;	../../my_STM8_libraries/stm8_I2C.c: 99: }
      0082F6 5B 01            [ 2]  231 	addw	sp, #1
      0082F8 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 101: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    234 ;	-----------------------------------------
                                    235 ;	 function writeReg_I2C
                                    236 ;	-----------------------------------------
      0082F9                        237 _writeReg_I2C:
      0082F9 88               [ 1]  238 	push	a
      0082FA 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (start_I2C() == 0) return 0;
      0082FC CD 82 55         [ 4]  241 	call	_start_I2C
      0082FF 4D               [ 1]  242 	tnz	a
      008300 26 03            [ 1]  243 	jrne	00102$
      008302 4F               [ 1]  244 	clr	a
      008303 20 28            [ 2]  245 	jra	00109$
      008305                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      008305 4B 00            [ 1]  248 	push	#0x00
      008307 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      008309 CD 82 6D         [ 4]  250 	call	_writeAddr_I2C
      00830C 4D               [ 1]  251 	tnz	a
      00830D 26 03            [ 1]  252 	jrne	00104$
      00830F 4F               [ 1]  253 	clr	a
      008310 20 1B            [ 2]  254 	jra	00109$
      008312                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 105: if (writeByte_I2C(reg) == 0) return 0;
      008312 7B 04            [ 1]  257 	ld	a, (0x04, sp)
      008314 CD 82 B3         [ 4]  258 	call	_writeByte_I2C
      008317 4D               [ 1]  259 	tnz	a
      008318 26 03            [ 1]  260 	jrne	00106$
      00831A 4F               [ 1]  261 	clr	a
      00831B 20 10            [ 2]  262 	jra	00109$
      00831D                        263 00106$:
                                    264 ;	../../my_STM8_libraries/stm8_I2C.c: 106: if (writeByte_I2C(data) == 0) return 0;
      00831D 7B 05            [ 1]  265 	ld	a, (0x05, sp)
      00831F CD 82 B3         [ 4]  266 	call	_writeByte_I2C
      008322 4D               [ 1]  267 	tnz	a
      008323 26 03            [ 1]  268 	jrne	00108$
      008325 4F               [ 1]  269 	clr	a
      008326 20 05            [ 2]  270 	jra	00109$
      008328                        271 00108$:
                                    272 ;	../../my_STM8_libraries/stm8_I2C.c: 107: stop_I2C();
      008328 CD 82 50         [ 4]  273 	call	_stop_I2C
                                    274 ;	../../my_STM8_libraries/stm8_I2C.c: 108: return 1;
      00832B A6 01            [ 1]  275 	ld	a, #0x01
      00832D                        276 00109$:
                                    277 ;	../../my_STM8_libraries/stm8_I2C.c: 109: }
      00832D 1E 02            [ 2]  278 	ldw	x, (2, sp)
      00832F 5B 05            [ 2]  279 	addw	sp, #5
      008331 FC               [ 2]  280 	jp	(x)
                                    281 ;	../../my_STM8_libraries/stm8_I2C.c: 111: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    282 ;	-----------------------------------------
                                    283 ;	 function readByte_I2C
                                    284 ;	-----------------------------------------
      008332                        285 _readByte_I2C:
      008332 52 03            [ 2]  286 	sub	sp, #3
      008334 6B 03            [ 1]  287 	ld	(0x03, sp), a
      008336 1F 01            [ 2]  288 	ldw	(0x01, sp), x
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (start_I2C() == 0) return 0;
      008338 CD 82 55         [ 4]  290 	call	_start_I2C
      00833B 4D               [ 1]  291 	tnz	a
      00833C 26 03            [ 1]  292 	jrne	00102$
      00833E 4F               [ 1]  293 	clr	a
      00833F 20 2F            [ 2]  294 	jra	00110$
      008341                        295 00102$:
                                    296 ;	../../my_STM8_libraries/stm8_I2C.c: 117: I2C_CR2 &= ~I2C_CR2_ACK;
      008341 72 15 52 11      [ 1]  297 	bres	0x5211, #2
                                    298 ;	../../my_STM8_libraries/stm8_I2C.c: 119: if (writeAddr_I2C(address, READ) == 0) return 0;
      008345 4B 01            [ 1]  299 	push	#0x01
      008347 7B 04            [ 1]  300 	ld	a, (0x04, sp)
      008349 CD 82 6D         [ 4]  301 	call	_writeAddr_I2C
      00834C 4D               [ 1]  302 	tnz	a
      00834D 26 03            [ 1]  303 	jrne	00115$
      00834F 4F               [ 1]  304 	clr	a
      008350 20 1E            [ 2]  305 	jra	00110$
                                    306 ;	../../my_STM8_libraries/stm8_I2C.c: 121: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008352                        307 00115$:
      008352 AE C3 50         [ 2]  308 	ldw	x, #0xc350
      008355                        309 00107$:
      008355 72 0C 52 17 0A   [ 2]  310 	btjt	0x5217, #6, 00109$
                                    311 ;	../../my_STM8_libraries/stm8_I2C.c: 123: if (--timeout == 0) 
      00835A 5A               [ 2]  312 	decw	x
      00835B 5D               [ 2]  313 	tnzw	x
      00835C 26 F7            [ 1]  314 	jrne	00107$
                                    315 ;	../../my_STM8_libraries/stm8_I2C.c: 125: stop_I2C();
      00835E CD 82 50         [ 4]  316 	call	_stop_I2C
                                    317 ;	../../my_STM8_libraries/stm8_I2C.c: 126: return 0;
      008361 4F               [ 1]  318 	clr	a
      008362 20 0C            [ 2]  319 	jra	00110$
      008364                        320 00109$:
                                    321 ;	../../my_STM8_libraries/stm8_I2C.c: 129: *data = I2C_DR;
      008364 C6 52 16         [ 1]  322 	ld	a, 0x5216
      008367 1E 01            [ 2]  323 	ldw	x, (0x01, sp)
      008369 F7               [ 1]  324 	ld	(x), a
                                    325 ;	../../my_STM8_libraries/stm8_I2C.c: 130: I2C_CR2 |= I2C_CR2_ACK;
      00836A 72 14 52 11      [ 1]  326 	bset	0x5211, #2
                                    327 ;	../../my_STM8_libraries/stm8_I2C.c: 131: return 1;
      00836E A6 01            [ 1]  328 	ld	a, #0x01
      008370                        329 00110$:
                                    330 ;	../../my_STM8_libraries/stm8_I2C.c: 132: }
      008370 5B 03            [ 2]  331 	addw	sp, #3
      008372 81               [ 4]  332 	ret
                                    333 ;	../../my_STM8_libraries/stm8_I2C.c: 133: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    334 ;	-----------------------------------------
                                    335 ;	 function readReg_I2C
                                    336 ;	-----------------------------------------
      008373                        337 _readReg_I2C:
      008373 88               [ 1]  338 	push	a
      008374 6B 01            [ 1]  339 	ld	(0x01, sp), a
                                    340 ;	../../my_STM8_libraries/stm8_I2C.c: 137: if (start_I2C() == 0) return 0;
      008376 CD 82 55         [ 4]  341 	call	_start_I2C
      008379 4D               [ 1]  342 	tnz	a
      00837A 26 03            [ 1]  343 	jrne	00102$
      00837C 4F               [ 1]  344 	clr	a
      00837D 20 53            [ 2]  345 	jra	00116$
      00837F                        346 00102$:
                                    347 ;	../../my_STM8_libraries/stm8_I2C.c: 139: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00837F 4B 00            [ 1]  348 	push	#0x00
      008381 7B 02            [ 1]  349 	ld	a, (0x02, sp)
      008383 CD 82 6D         [ 4]  350 	call	_writeAddr_I2C
      008386 4D               [ 1]  351 	tnz	a
      008387 26 03            [ 1]  352 	jrne	00104$
      008389 4F               [ 1]  353 	clr	a
      00838A 20 46            [ 2]  354 	jra	00116$
      00838C                        355 00104$:
                                    356 ;	../../my_STM8_libraries/stm8_I2C.c: 141: if (writeByte_I2C(reg) == 0) return 0;
      00838C 7B 04            [ 1]  357 	ld	a, (0x04, sp)
      00838E CD 82 B3         [ 4]  358 	call	_writeByte_I2C
      008391 4D               [ 1]  359 	tnz	a
      008392 26 03            [ 1]  360 	jrne	00106$
      008394 4F               [ 1]  361 	clr	a
      008395 20 3B            [ 2]  362 	jra	00116$
      008397                        363 00106$:
                                    364 ;	../../my_STM8_libraries/stm8_I2C.c: 143: if (start_I2C() == 0) return 0;
      008397 CD 82 55         [ 4]  365 	call	_start_I2C
      00839A 4D               [ 1]  366 	tnz	a
      00839B 26 03            [ 1]  367 	jrne	00108$
      00839D 4F               [ 1]  368 	clr	a
      00839E 20 32            [ 2]  369 	jra	00116$
      0083A0                        370 00108$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 145: if (writeAddr_I2C(address, READ) == 0) return 0;
      0083A0 4B 01            [ 1]  372 	push	#0x01
      0083A2 7B 02            [ 1]  373 	ld	a, (0x02, sp)
      0083A4 CD 82 6D         [ 4]  374 	call	_writeAddr_I2C
      0083A7 4D               [ 1]  375 	tnz	a
      0083A8 26 03            [ 1]  376 	jrne	00110$
      0083AA 4F               [ 1]  377 	clr	a
      0083AB 20 25            [ 2]  378 	jra	00116$
      0083AD                        379 00110$:
                                    380 ;	../../my_STM8_libraries/stm8_I2C.c: 147: I2C_CR2 &= ~I2C_CR2_ACK;
      0083AD 72 15 52 11      [ 1]  381 	bres	0x5211, #2
                                    382 ;	../../my_STM8_libraries/stm8_I2C.c: 149: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0083B1 AE C3 50         [ 2]  383 	ldw	x, #0xc350
      0083B4                        384 00113$:
      0083B4 72 0C 52 17 0A   [ 2]  385 	btjt	0x5217, #6, 00115$
                                    386 ;	../../my_STM8_libraries/stm8_I2C.c: 151: if (--timeout == 0)
      0083B9 5A               [ 2]  387 	decw	x
      0083BA 5D               [ 2]  388 	tnzw	x
      0083BB 26 F7            [ 1]  389 	jrne	00113$
                                    390 ;	../../my_STM8_libraries/stm8_I2C.c: 153: stop_I2C();
      0083BD CD 82 50         [ 4]  391 	call	_stop_I2C
                                    392 ;	../../my_STM8_libraries/stm8_I2C.c: 154: return 0;
      0083C0 4F               [ 1]  393 	clr	a
      0083C1 20 0F            [ 2]  394 	jra	00116$
      0083C3                        395 00115$:
                                    396 ;	../../my_STM8_libraries/stm8_I2C.c: 157: *data = I2C_DR;
      0083C3 1E 05            [ 2]  397 	ldw	x, (0x05, sp)
      0083C5 C6 52 16         [ 1]  398 	ld	a, 0x5216
      0083C8 F7               [ 1]  399 	ld	(x), a
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 158: stop_I2C();
      0083C9 CD 82 50         [ 4]  401 	call	_stop_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 159: I2C_CR2 |= I2C_CR2_ACK;
      0083CC 72 14 52 11      [ 1]  403 	bset	0x5211, #2
                                    404 ;	../../my_STM8_libraries/stm8_I2C.c: 160: return 1;
      0083D0 A6 01            [ 1]  405 	ld	a, #0x01
      0083D2                        406 00116$:
                                    407 ;	../../my_STM8_libraries/stm8_I2C.c: 161: }
      0083D2 1E 02            [ 2]  408 	ldw	x, (2, sp)
      0083D4 5B 06            [ 2]  409 	addw	sp, #6
      0083D6 FC               [ 2]  410 	jp	(x)
                                    411 	.area CODE
                                    412 	.area CONST
                                    413 	.area INITIALIZER
                                    414 	.area CABS (ABS)
