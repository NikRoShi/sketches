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
      008612                         65 _init_I2C:
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 8: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      008612 72 11 52 10      [ 1]   67 	bres	0x5210, #0
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 10: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      008616 35 10 52 12      [ 1]   69 	mov	0x5212+0, #0x10
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 12: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      00861A 35 50 52 1B      [ 1]   71 	mov	0x521b+0, #0x50
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_CCRH = (uint8_t)(ccr >> 8);
      00861E 35 00 52 1C      [ 1]   73 	mov	0x521c+0, #0x00
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008622 35 11 52 1D      [ 1]   75 	mov	0x521d+0, #0x11
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 17: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      008626 72 10 52 10      [ 1]   77 	bset	0x5210, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 18: }
      00862A 81               [ 4]   79 	ret
                                     80 ;	../../my_STM8_libraries/stm8_I2C.c: 20: void stop_I2C(void)
                                     81 ;	-----------------------------------------
                                     82 ;	 function stop_I2C
                                     83 ;	-----------------------------------------
      00862B                         84 _stop_I2C:
                                     85 ;	../../my_STM8_libraries/stm8_I2C.c: 22: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      00862B 72 12 52 11      [ 1]   86 	bset	0x5211, #1
                                     87 ;	../../my_STM8_libraries/stm8_I2C.c: 23: }
      00862F 81               [ 4]   88 	ret
                                     89 ;	../../my_STM8_libraries/stm8_I2C.c: 25: uint8_t start_I2C(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function start_I2C
                                     92 ;	-----------------------------------------
      008630                         93 _start_I2C:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 29: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008630 72 10 52 11      [ 1]   95 	bset	0x5211, #0
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 30: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008634 AE C3 50         [ 2]   97 	ldw	x, #0xc350
      008637                         98 00103$:
      008637 72 00 52 17 09   [ 2]   99 	btjt	0x5217, #0, 00105$
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 32: if (--timeout == 0) 
      00863C 5A               [ 2]  101 	decw	x
      00863D 5D               [ 2]  102 	tnzw	x
      00863E 26 F7            [ 1]  103 	jrne	00103$
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 34: stop_I2C();
      008640 CD 86 2B         [ 4]  105 	call	_stop_I2C
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 35: return 0;
      008643 4F               [ 1]  107 	clr	a
      008644 81               [ 4]  108 	ret
      008645                        109 00105$:
                                    110 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 1;
      008645 A6 01            [ 1]  111 	ld	a, #0x01
                                    112 ;	../../my_STM8_libraries/stm8_I2C.c: 39: }
      008647 81               [ 4]  113 	ret
                                    114 ;	../../my_STM8_libraries/stm8_I2C.c: 40: void clearADDR_I2C(void)
                                    115 ;	-----------------------------------------
                                    116 ;	 function clearADDR_I2C
                                    117 ;	-----------------------------------------
      008648                        118 _clearADDR_I2C:
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 42: (void)I2C_SR1;
      008648 C6 52 17         [ 1]  120 	ld	a, 0x5217
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 43: (void)I2C_SR3;
      00864B C6 52 19         [ 1]  122 	ld	a, 0x5219
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 44: }
      00864E 81               [ 4]  124 	ret
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 45: void setACK_I2C(uint8_t state)
                                    126 ;	-----------------------------------------
                                    127 ;	 function setACK_I2C
                                    128 ;	-----------------------------------------
      00864F                        129 _setACK_I2C:
                                    130 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (state == LOW) I2C_CR2 &= ~I2C_CR2_ACK;
      00864F 97               [ 1]  131 	ld	xl, a
      008650 4D               [ 1]  132 	tnz	a
      008651 26 04            [ 1]  133 	jrne	00102$
      008653 72 15 52 11      [ 1]  134 	bres	0x5211, #2
      008657                        135 00102$:
                                    136 ;	../../my_STM8_libraries/stm8_I2C.c: 48: if (state == HIGH) I2C_CR2 |= I2C_CR2_ACK;
      008657 9F               [ 1]  137 	ld	a, xl
      008658 4A               [ 1]  138 	dec	a
      008659 27 01            [ 1]  139 	jreq	00120$
      00865B 81               [ 4]  140 	ret
      00865C                        141 00120$:
      00865C 72 14 52 11      [ 1]  142 	bset	0x5211, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 49: }
      008660 81               [ 4]  144 	ret
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 50: uint8_t writeAddr_I2C(uint8_t address, uint8_t mode)
                                    146 ;	-----------------------------------------
                                    147 ;	 function writeAddr_I2C
                                    148 ;	-----------------------------------------
      008661                        149 _writeAddr_I2C:
                                    150 ;	../../my_STM8_libraries/stm8_I2C.c: 54: if (mode == WRITE) I2C_DR = (address << 1);
      008661 48               [ 1]  151 	sll	a
      008662 0D 03            [ 1]  152 	tnz	(0x03, sp)
      008664 26 03            [ 1]  153 	jrne	00102$
      008666 C7 52 16         [ 1]  154 	ld	0x5216, a
      008669                        155 00102$:
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 55: if (mode == READ) I2C_DR = (address << 1) | 0x01;
      008669 88               [ 1]  157 	push	a
      00866A 7B 04            [ 1]  158 	ld	a, (0x04, sp)
      00866C 4A               [ 1]  159 	dec	a
      00866D 84               [ 1]  160 	pop	a
      00866E 26 05            [ 1]  161 	jrne	00119$
      008670 AA 01            [ 1]  162 	or	a, #0x01
      008672 C7 52 16         [ 1]  163 	ld	0x5216, a
                                    164 ;	../../my_STM8_libraries/stm8_I2C.c: 57: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      008675                        165 00119$:
      008675 AE C3 50         [ 2]  166 	ldw	x, #0xc350
      008678                        167 00108$:
      008678 72 02 52 17 0F   [ 2]  168 	btjt	0x5217, #1, 00110$
      00867D 72 04 52 18 0A   [ 2]  169 	btjt	0x5218, #2, 00110$
                                    170 ;	../../my_STM8_libraries/stm8_I2C.c: 59: if (--timeout == 0) 
      008682 5A               [ 2]  171 	decw	x
      008683 5D               [ 2]  172 	tnzw	x
      008684 26 F2            [ 1]  173 	jrne	00108$
                                    174 ;	../../my_STM8_libraries/stm8_I2C.c: 61: stop_I2C();
      008686 CD 86 2B         [ 4]  175 	call	_stop_I2C
                                    176 ;	../../my_STM8_libraries/stm8_I2C.c: 62: return 0;
      008689 4F               [ 1]  177 	clr	a
      00868A 20 11            [ 2]  178 	jra	00113$
      00868C                        179 00110$:
                                    180 ;	../../my_STM8_libraries/stm8_I2C.c: 65: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00868C 72 03 52 17 04   [ 2]  181 	btjf	0x5217, #1, 00112$
                                    182 ;	../../my_STM8_libraries/stm8_I2C.c: 67: return 1;
      008691 A6 01            [ 1]  183 	ld	a, #0x01
      008693 20 08            [ 2]  184 	jra	00113$
      008695                        185 00112$:
                                    186 ;	../../my_STM8_libraries/stm8_I2C.c: 69: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008695 72 15 52 18      [ 1]  187 	bres	0x5218, #2
                                    188 ;	../../my_STM8_libraries/stm8_I2C.c: 70: stop_I2C();
      008699 CD 86 2B         [ 4]  189 	call	_stop_I2C
                                    190 ;	../../my_STM8_libraries/stm8_I2C.c: 71: return 0;
      00869C 4F               [ 1]  191 	clr	a
      00869D                        192 00113$:
                                    193 ;	../../my_STM8_libraries/stm8_I2C.c: 72: }
      00869D 85               [ 2]  194 	popw	x
      00869E 5B 01            [ 2]  195 	addw	sp, #1
      0086A0 FC               [ 2]  196 	jp	(x)
                                    197 ;	../../my_STM8_libraries/stm8_I2C.c: 74: uint8_t writeByte_I2C(uint8_t data)
                                    198 ;	-----------------------------------------
                                    199 ;	 function writeByte_I2C
                                    200 ;	-----------------------------------------
      0086A1                        201 _writeByte_I2C:
                                    202 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_DR = data;	//записываем байт в реистр данных
      0086A1 C7 52 16         [ 1]  203 	ld	0x5216, a
                                    204 ;	../../my_STM8_libraries/stm8_I2C.c: 80: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      0086A4 AE C3 50         [ 2]  205 	ldw	x, #0xc350
      0086A7                        206 00105$:
      0086A7 C6 52 17         [ 1]  207 	ld	a, 0x5217
      0086AA 2B 17            [ 1]  208 	jrmi	00107$
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      0086AC 72 05 52 18 09   [ 2]  210 	btjf	0x5218, #2, 00102$
                                    211 ;	../../my_STM8_libraries/stm8_I2C.c: 84: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      0086B1 72 15 52 18      [ 1]  212 	bres	0x5218, #2
                                    213 ;	../../my_STM8_libraries/stm8_I2C.c: 85: stop_I2C();
      0086B5 CD 86 2B         [ 4]  214 	call	_stop_I2C
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 86: return 0;
      0086B8 4F               [ 1]  216 	clr	a
      0086B9 81               [ 4]  217 	ret
      0086BA                        218 00102$:
                                    219 ;	../../my_STM8_libraries/stm8_I2C.c: 88: if (--timeout == 0)	//проверка таймаута
      0086BA 5A               [ 2]  220 	decw	x
      0086BB 5D               [ 2]  221 	tnzw	x
      0086BC 26 E9            [ 1]  222 	jrne	00105$
                                    223 ;	../../my_STM8_libraries/stm8_I2C.c: 90: stop_I2C();
      0086BE CD 86 2B         [ 4]  224 	call	_stop_I2C
                                    225 ;	../../my_STM8_libraries/stm8_I2C.c: 91: return 0;
      0086C1 4F               [ 1]  226 	clr	a
      0086C2 81               [ 4]  227 	ret
      0086C3                        228 00107$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 94: return 1;
      0086C3 A6 01            [ 1]  230 	ld	a, #0x01
                                    231 ;	../../my_STM8_libraries/stm8_I2C.c: 95: }
      0086C5 81               [ 4]  232 	ret
                                    233 ;	../../my_STM8_libraries/stm8_I2C.c: 97: uint8_t ping_I2C(uint8_t address)
                                    234 ;	-----------------------------------------
                                    235 ;	 function ping_I2C
                                    236 ;	-----------------------------------------
      0086C6                        237 _ping_I2C:
      0086C6 88               [ 1]  238 	push	a
      0086C7 6B 01            [ 1]  239 	ld	(0x01, sp), a
                                    240 ;	../../my_STM8_libraries/stm8_I2C.c: 99: if (start_I2C() == 0) return 0;
      0086C9 CD 86 30         [ 4]  241 	call	_start_I2C
      0086CC 4D               [ 1]  242 	tnz	a
      0086CD 26 03            [ 1]  243 	jrne	00102$
      0086CF 4F               [ 1]  244 	clr	a
      0086D0 20 15            [ 2]  245 	jra	00105$
      0086D2                        246 00102$:
                                    247 ;	../../my_STM8_libraries/stm8_I2C.c: 100: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0086D2 4B 00            [ 1]  248 	push	#0x00
      0086D4 7B 02            [ 1]  249 	ld	a, (0x02, sp)
      0086D6 CD 86 61         [ 4]  250 	call	_writeAddr_I2C
      0086D9 4D               [ 1]  251 	tnz	a
      0086DA 26 03            [ 1]  252 	jrne	00104$
      0086DC 4F               [ 1]  253 	clr	a
      0086DD 20 08            [ 2]  254 	jra	00105$
      0086DF                        255 00104$:
                                    256 ;	../../my_STM8_libraries/stm8_I2C.c: 101: clearADDR_I2C(); 
      0086DF CD 86 48         [ 4]  257 	call	_clearADDR_I2C
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 102: stop_I2C();
      0086E2 CD 86 2B         [ 4]  259 	call	_stop_I2C
                                    260 ;	../../my_STM8_libraries/stm8_I2C.c: 103: return 1;
      0086E5 A6 01            [ 1]  261 	ld	a, #0x01
      0086E7                        262 00105$:
                                    263 ;	../../my_STM8_libraries/stm8_I2C.c: 104: }
      0086E7 5B 01            [ 2]  264 	addw	sp, #1
      0086E9 81               [ 4]  265 	ret
                                    266 ;	../../my_STM8_libraries/stm8_I2C.c: 106: uint8_t writeReg_I2C(uint8_t address, uint8_t reg, uint8_t data)
                                    267 ;	-----------------------------------------
                                    268 ;	 function writeReg_I2C
                                    269 ;	-----------------------------------------
      0086EA                        270 _writeReg_I2C:
      0086EA 88               [ 1]  271 	push	a
      0086EB 6B 01            [ 1]  272 	ld	(0x01, sp), a
                                    273 ;	../../my_STM8_libraries/stm8_I2C.c: 108: if (start_I2C() == 0) return 0;
      0086ED CD 86 30         [ 4]  274 	call	_start_I2C
      0086F0 4D               [ 1]  275 	tnz	a
      0086F1 26 03            [ 1]  276 	jrne	00102$
      0086F3 4F               [ 1]  277 	clr	a
      0086F4 20 2B            [ 2]  278 	jra	00109$
      0086F6                        279 00102$:
                                    280 ;	../../my_STM8_libraries/stm8_I2C.c: 110: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0086F6 4B 00            [ 1]  281 	push	#0x00
      0086F8 7B 02            [ 1]  282 	ld	a, (0x02, sp)
      0086FA CD 86 61         [ 4]  283 	call	_writeAddr_I2C
      0086FD 4D               [ 1]  284 	tnz	a
      0086FE 26 03            [ 1]  285 	jrne	00104$
      008700 4F               [ 1]  286 	clr	a
      008701 20 1E            [ 2]  287 	jra	00109$
      008703                        288 00104$:
                                    289 ;	../../my_STM8_libraries/stm8_I2C.c: 111: clearADDR_I2C();
      008703 CD 86 48         [ 4]  290 	call	_clearADDR_I2C
                                    291 ;	../../my_STM8_libraries/stm8_I2C.c: 113: if (writeByte_I2C(reg) == 0) return 0;
      008706 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      008708 CD 86 A1         [ 4]  293 	call	_writeByte_I2C
      00870B 4D               [ 1]  294 	tnz	a
      00870C 26 03            [ 1]  295 	jrne	00106$
      00870E 4F               [ 1]  296 	clr	a
      00870F 20 10            [ 2]  297 	jra	00109$
      008711                        298 00106$:
                                    299 ;	../../my_STM8_libraries/stm8_I2C.c: 115: if (writeByte_I2C(data) == 0) return 0;
      008711 7B 05            [ 1]  300 	ld	a, (0x05, sp)
      008713 CD 86 A1         [ 4]  301 	call	_writeByte_I2C
      008716 4D               [ 1]  302 	tnz	a
      008717 26 03            [ 1]  303 	jrne	00108$
      008719 4F               [ 1]  304 	clr	a
      00871A 20 05            [ 2]  305 	jra	00109$
      00871C                        306 00108$:
                                    307 ;	../../my_STM8_libraries/stm8_I2C.c: 117: stop_I2C();
      00871C CD 86 2B         [ 4]  308 	call	_stop_I2C
                                    309 ;	../../my_STM8_libraries/stm8_I2C.c: 118: return 1;
      00871F A6 01            [ 1]  310 	ld	a, #0x01
      008721                        311 00109$:
                                    312 ;	../../my_STM8_libraries/stm8_I2C.c: 119: }
      008721 1E 02            [ 2]  313 	ldw	x, (2, sp)
      008723 5B 05            [ 2]  314 	addw	sp, #5
      008725 FC               [ 2]  315 	jp	(x)
                                    316 ;	../../my_STM8_libraries/stm8_I2C.c: 121: uint8_t readByte_I2C(uint8_t address, uint8_t *data)
                                    317 ;	-----------------------------------------
                                    318 ;	 function readByte_I2C
                                    319 ;	-----------------------------------------
      008726                        320 _readByte_I2C:
      008726 52 03            [ 2]  321 	sub	sp, #3
      008728 6B 03            [ 1]  322 	ld	(0x03, sp), a
      00872A 1F 01            [ 2]  323 	ldw	(0x01, sp), x
                                    324 ;	../../my_STM8_libraries/stm8_I2C.c: 125: setACK_I2C(HIGH);
      00872C A6 01            [ 1]  325 	ld	a, #0x01
      00872E CD 86 4F         [ 4]  326 	call	_setACK_I2C
                                    327 ;	../../my_STM8_libraries/stm8_I2C.c: 127: if (start_I2C() == 0) return 0;
      008731 CD 86 30         [ 4]  328 	call	_start_I2C
      008734 4D               [ 1]  329 	tnz	a
      008735 26 03            [ 1]  330 	jrne	00102$
      008737 4F               [ 1]  331 	clr	a
      008738 20 31            [ 2]  332 	jra	00110$
      00873A                        333 00102$:
                                    334 ;	../../my_STM8_libraries/stm8_I2C.c: 129: if (writeAddr_I2C(address, READ) == 0) return 0;
      00873A 4B 01            [ 1]  335 	push	#0x01
      00873C 7B 04            [ 1]  336 	ld	a, (0x04, sp)
      00873E CD 86 61         [ 4]  337 	call	_writeAddr_I2C
      008741 4D               [ 1]  338 	tnz	a
      008742 26 03            [ 1]  339 	jrne	00104$
      008744 4F               [ 1]  340 	clr	a
      008745 20 24            [ 2]  341 	jra	00110$
      008747                        342 00104$:
                                    343 ;	../../my_STM8_libraries/stm8_I2C.c: 131: setACK_I2C(LOW);
      008747 4F               [ 1]  344 	clr	a
      008748 CD 86 4F         [ 4]  345 	call	_setACK_I2C
                                    346 ;	../../my_STM8_libraries/stm8_I2C.c: 133: clearADDR_I2C();
      00874B CD 86 48         [ 4]  347 	call	_clearADDR_I2C
                                    348 ;	../../my_STM8_libraries/stm8_I2C.c: 135: stop_I2C();
      00874E CD 86 2B         [ 4]  349 	call	_stop_I2C
                                    350 ;	../../my_STM8_libraries/stm8_I2C.c: 137: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008751 AE C3 50         [ 2]  351 	ldw	x, #0xc350
      008754                        352 00107$:
      008754 72 0C 52 17 0A   [ 2]  353 	btjt	0x5217, #6, 00109$
                                    354 ;	../../my_STM8_libraries/stm8_I2C.c: 139: if (--timeout == 0) 
      008759 5A               [ 2]  355 	decw	x
      00875A 5D               [ 2]  356 	tnzw	x
      00875B 26 F7            [ 1]  357 	jrne	00107$
                                    358 ;	../../my_STM8_libraries/stm8_I2C.c: 141: stop_I2C();
      00875D CD 86 2B         [ 4]  359 	call	_stop_I2C
                                    360 ;	../../my_STM8_libraries/stm8_I2C.c: 142: return 0;
      008760 4F               [ 1]  361 	clr	a
      008761 20 08            [ 2]  362 	jra	00110$
      008763                        363 00109$:
                                    364 ;	../../my_STM8_libraries/stm8_I2C.c: 145: *data = I2C_DR;
      008763 C6 52 16         [ 1]  365 	ld	a, 0x5216
      008766 1E 01            [ 2]  366 	ldw	x, (0x01, sp)
      008768 F7               [ 1]  367 	ld	(x), a
                                    368 ;	../../my_STM8_libraries/stm8_I2C.c: 147: return 1;
      008769 A6 01            [ 1]  369 	ld	a, #0x01
      00876B                        370 00110$:
                                    371 ;	../../my_STM8_libraries/stm8_I2C.c: 148: }
      00876B 5B 03            [ 2]  372 	addw	sp, #3
      00876D 81               [ 4]  373 	ret
                                    374 ;	../../my_STM8_libraries/stm8_I2C.c: 149: uint8_t readReg_I2C(uint8_t address, uint8_t reg, uint8_t *data)
                                    375 ;	-----------------------------------------
                                    376 ;	 function readReg_I2C
                                    377 ;	-----------------------------------------
      00876E                        378 _readReg_I2C:
      00876E 88               [ 1]  379 	push	a
      00876F 6B 01            [ 1]  380 	ld	(0x01, sp), a
                                    381 ;	../../my_STM8_libraries/stm8_I2C.c: 153: setACK_I2C(HIGH);
      008771 A6 01            [ 1]  382 	ld	a, #0x01
      008773 CD 86 4F         [ 4]  383 	call	_setACK_I2C
                                    384 ;	../../my_STM8_libraries/stm8_I2C.c: 155: if (start_I2C() == 0) return 0;
      008776 CD 86 30         [ 4]  385 	call	_start_I2C
      008779 4D               [ 1]  386 	tnz	a
      00877A 26 03            [ 1]  387 	jrne	00102$
      00877C 4F               [ 1]  388 	clr	a
      00877D 20 55            [ 2]  389 	jra	00116$
      00877F                        390 00102$:
                                    391 ;	../../my_STM8_libraries/stm8_I2C.c: 157: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      00877F 4B 00            [ 1]  392 	push	#0x00
      008781 7B 02            [ 1]  393 	ld	a, (0x02, sp)
      008783 CD 86 61         [ 4]  394 	call	_writeAddr_I2C
      008786 4D               [ 1]  395 	tnz	a
      008787 26 03            [ 1]  396 	jrne	00104$
      008789 4F               [ 1]  397 	clr	a
      00878A 20 48            [ 2]  398 	jra	00116$
      00878C                        399 00104$:
                                    400 ;	../../my_STM8_libraries/stm8_I2C.c: 159: clearADDR_I2C();
      00878C CD 86 48         [ 4]  401 	call	_clearADDR_I2C
                                    402 ;	../../my_STM8_libraries/stm8_I2C.c: 161: if (writeByte_I2C(reg) == 0) return 0;
      00878F 7B 04            [ 1]  403 	ld	a, (0x04, sp)
      008791 CD 86 A1         [ 4]  404 	call	_writeByte_I2C
      008794 4D               [ 1]  405 	tnz	a
      008795 26 03            [ 1]  406 	jrne	00106$
      008797 4F               [ 1]  407 	clr	a
      008798 20 3A            [ 2]  408 	jra	00116$
      00879A                        409 00106$:
                                    410 ;	../../my_STM8_libraries/stm8_I2C.c: 163: if (start_I2C() == 0) return 0;
      00879A CD 86 30         [ 4]  411 	call	_start_I2C
      00879D 4D               [ 1]  412 	tnz	a
      00879E 26 03            [ 1]  413 	jrne	00108$
      0087A0 4F               [ 1]  414 	clr	a
      0087A1 20 31            [ 2]  415 	jra	00116$
      0087A3                        416 00108$:
                                    417 ;	../../my_STM8_libraries/stm8_I2C.c: 165: if (writeAddr_I2C(address, READ) == 0) return 0;
      0087A3 4B 01            [ 1]  418 	push	#0x01
      0087A5 7B 02            [ 1]  419 	ld	a, (0x02, sp)
      0087A7 CD 86 61         [ 4]  420 	call	_writeAddr_I2C
      0087AA 4D               [ 1]  421 	tnz	a
      0087AB 26 03            [ 1]  422 	jrne	00110$
      0087AD 4F               [ 1]  423 	clr	a
      0087AE 20 24            [ 2]  424 	jra	00116$
      0087B0                        425 00110$:
                                    426 ;	../../my_STM8_libraries/stm8_I2C.c: 167: setACK_I2C(LOW);
      0087B0 4F               [ 1]  427 	clr	a
      0087B1 CD 86 4F         [ 4]  428 	call	_setACK_I2C
                                    429 ;	../../my_STM8_libraries/stm8_I2C.c: 169: clearADDR_I2C();
      0087B4 CD 86 48         [ 4]  430 	call	_clearADDR_I2C
                                    431 ;	../../my_STM8_libraries/stm8_I2C.c: 171: stop_I2C();
      0087B7 CD 86 2B         [ 4]  432 	call	_stop_I2C
                                    433 ;	../../my_STM8_libraries/stm8_I2C.c: 173: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0087BA AE C3 50         [ 2]  434 	ldw	x, #0xc350
      0087BD                        435 00113$:
      0087BD 72 0C 52 17 0A   [ 2]  436 	btjt	0x5217, #6, 00115$
                                    437 ;	../../my_STM8_libraries/stm8_I2C.c: 175: if (--timeout == 0)
      0087C2 5A               [ 2]  438 	decw	x
      0087C3 5D               [ 2]  439 	tnzw	x
      0087C4 26 F7            [ 1]  440 	jrne	00113$
                                    441 ;	../../my_STM8_libraries/stm8_I2C.c: 177: stop_I2C();
      0087C6 CD 86 2B         [ 4]  442 	call	_stop_I2C
                                    443 ;	../../my_STM8_libraries/stm8_I2C.c: 178: return 0;
      0087C9 4F               [ 1]  444 	clr	a
      0087CA 20 08            [ 2]  445 	jra	00116$
      0087CC                        446 00115$:
                                    447 ;	../../my_STM8_libraries/stm8_I2C.c: 181: *data = I2C_DR;
      0087CC 1E 05            [ 2]  448 	ldw	x, (0x05, sp)
      0087CE C6 52 16         [ 1]  449 	ld	a, 0x5216
      0087D1 F7               [ 1]  450 	ld	(x), a
                                    451 ;	../../my_STM8_libraries/stm8_I2C.c: 183: return 1;
      0087D2 A6 01            [ 1]  452 	ld	a, #0x01
      0087D4                        453 00116$:
                                    454 ;	../../my_STM8_libraries/stm8_I2C.c: 184: }
      0087D4 1E 02            [ 2]  455 	ldw	x, (2, sp)
      0087D6 5B 06            [ 2]  456 	addw	sp, #6
      0087D8 FC               [ 2]  457 	jp	(x)
                                    458 ;	../../my_STM8_libraries/stm8_I2C.c: 185: uint8_t readBuffer2_I2C(uint8_t address, uint8_t reg, uint8_t *buf)
                                    459 ;	-----------------------------------------
                                    460 ;	 function readBuffer2_I2C
                                    461 ;	-----------------------------------------
      0087D9                        462 _readBuffer2_I2C:
      0087D9 52 05            [ 2]  463 	sub	sp, #5
      0087DB 6B 05            [ 1]  464 	ld	(0x05, sp), a
                                    465 ;	../../my_STM8_libraries/stm8_I2C.c: 187: uint16_t timeout = 50000;
      0087DD AE C3 50         [ 2]  466 	ldw	x, #0xc350
      0087E0 1F 01            [ 2]  467 	ldw	(0x01, sp), x
                                    468 ;	../../my_STM8_libraries/stm8_I2C.c: 189: setACK_I2C(HIGH);
      0087E2 A6 01            [ 1]  469 	ld	a, #0x01
      0087E4 CD 86 4F         [ 4]  470 	call	_setACK_I2C
                                    471 ;	../../my_STM8_libraries/stm8_I2C.c: 191: if (start_I2C() == 0) return 0;
      0087E7 CD 86 30         [ 4]  472 	call	_start_I2C
      0087EA 4D               [ 1]  473 	tnz	a
      0087EB 26 03            [ 1]  474 	jrne	00102$
      0087ED 4F               [ 1]  475 	clr	a
      0087EE 20 73            [ 2]  476 	jra	00121$
      0087F0                        477 00102$:
                                    478 ;	../../my_STM8_libraries/stm8_I2C.c: 193: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0087F0 4B 00            [ 1]  479 	push	#0x00
      0087F2 7B 06            [ 1]  480 	ld	a, (0x06, sp)
      0087F4 CD 86 61         [ 4]  481 	call	_writeAddr_I2C
      0087F7 4D               [ 1]  482 	tnz	a
      0087F8 26 03            [ 1]  483 	jrne	00104$
      0087FA 4F               [ 1]  484 	clr	a
      0087FB 20 66            [ 2]  485 	jra	00121$
      0087FD                        486 00104$:
                                    487 ;	../../my_STM8_libraries/stm8_I2C.c: 194: clearADDR_I2C();
      0087FD CD 86 48         [ 4]  488 	call	_clearADDR_I2C
                                    489 ;	../../my_STM8_libraries/stm8_I2C.c: 196: if (writeByte_I2C(reg) == 0) return 0;
      008800 7B 08            [ 1]  490 	ld	a, (0x08, sp)
      008802 CD 86 A1         [ 4]  491 	call	_writeByte_I2C
      008805 4D               [ 1]  492 	tnz	a
      008806 26 03            [ 1]  493 	jrne	00106$
      008808 4F               [ 1]  494 	clr	a
      008809 20 58            [ 2]  495 	jra	00121$
      00880B                        496 00106$:
                                    497 ;	../../my_STM8_libraries/stm8_I2C.c: 198: if (start_I2C() == 0) return 0;
      00880B CD 86 30         [ 4]  498 	call	_start_I2C
      00880E 4D               [ 1]  499 	tnz	a
      00880F 26 03            [ 1]  500 	jrne	00108$
      008811 4F               [ 1]  501 	clr	a
      008812 20 4F            [ 2]  502 	jra	00121$
      008814                        503 00108$:
                                    504 ;	../../my_STM8_libraries/stm8_I2C.c: 200: if (writeAddr_I2C(address, READ) == 0) return 0;
      008814 4B 01            [ 1]  505 	push	#0x01
      008816 7B 06            [ 1]  506 	ld	a, (0x06, sp)
      008818 CD 86 61         [ 4]  507 	call	_writeAddr_I2C
      00881B 4D               [ 1]  508 	tnz	a
      00881C 26 03            [ 1]  509 	jrne	00110$
      00881E 4F               [ 1]  510 	clr	a
      00881F 20 42            [ 2]  511 	jra	00121$
      008821                        512 00110$:
                                    513 ;	../../my_STM8_libraries/stm8_I2C.c: 201: clearADDR_I2C();
      008821 CD 86 48         [ 4]  514 	call	_clearADDR_I2C
                                    515 ;	../../my_STM8_libraries/stm8_I2C.c: 203: while (!(I2C_SR1 & I2C_SR1_RXNE))
      008824 AE C3 50         [ 2]  516 	ldw	x, #0xc350
      008827                        517 00113$:
      008827 72 0C 52 17 0C   [ 2]  518 	btjt	0x5217, #6, 00115$
                                    519 ;	../../my_STM8_libraries/stm8_I2C.c: 205: if (--timeout == 0)
      00882C 5A               [ 2]  520 	decw	x
      00882D 1F 01            [ 2]  521 	ldw	(0x01, sp), x
      00882F 5D               [ 2]  522 	tnzw	x
      008830 26 F5            [ 1]  523 	jrne	00113$
                                    524 ;	../../my_STM8_libraries/stm8_I2C.c: 207: stop_I2C();
      008832 CD 86 2B         [ 4]  525 	call	_stop_I2C
                                    526 ;	../../my_STM8_libraries/stm8_I2C.c: 208: return 0;
      008835 4F               [ 1]  527 	clr	a
      008836 20 2B            [ 2]  528 	jra	00121$
      008838                        529 00115$:
                                    530 ;	../../my_STM8_libraries/stm8_I2C.c: 211: buf[0] = I2C_DR;
      008838 16 09            [ 2]  531 	ldw	y, (0x09, sp)
      00883A 17 03            [ 2]  532 	ldw	(0x03, sp), y
      00883C C6 52 16         [ 1]  533 	ld	a, 0x5216
      00883F 1E 03            [ 2]  534 	ldw	x, (0x03, sp)
      008841 F7               [ 1]  535 	ld	(x), a
                                    536 ;	../../my_STM8_libraries/stm8_I2C.c: 212: setACK_I2C(LOW);
      008842 4F               [ 1]  537 	clr	a
      008843 CD 86 4F         [ 4]  538 	call	_setACK_I2C
                                    539 ;	../../my_STM8_libraries/stm8_I2C.c: 214: while (!(I2C_SR1 & I2C_SR1_BTF))
      008846 1E 01            [ 2]  540 	ldw	x, (0x01, sp)
      008848                        541 00118$:
      008848 72 04 52 17 0A   [ 2]  542 	btjt	0x5217, #2, 00120$
                                    543 ;	../../my_STM8_libraries/stm8_I2C.c: 216: if (--timeout == 0)
      00884D 5A               [ 2]  544 	decw	x
      00884E 5D               [ 2]  545 	tnzw	x
      00884F 26 F7            [ 1]  546 	jrne	00118$
                                    547 ;	../../my_STM8_libraries/stm8_I2C.c: 218: stop_I2C();
      008851 CD 86 2B         [ 4]  548 	call	_stop_I2C
                                    549 ;	../../my_STM8_libraries/stm8_I2C.c: 219: return 0;
      008854 4F               [ 1]  550 	clr	a
      008855 20 0C            [ 2]  551 	jra	00121$
      008857                        552 00120$:
                                    553 ;	../../my_STM8_libraries/stm8_I2C.c: 222: stop_I2C();
      008857 CD 86 2B         [ 4]  554 	call	_stop_I2C
                                    555 ;	../../my_STM8_libraries/stm8_I2C.c: 224: buf[1] = I2C_DR;
      00885A 1E 03            [ 2]  556 	ldw	x, (0x03, sp)
      00885C 5C               [ 1]  557 	incw	x
      00885D C6 52 16         [ 1]  558 	ld	a, 0x5216
      008860 F7               [ 1]  559 	ld	(x), a
                                    560 ;	../../my_STM8_libraries/stm8_I2C.c: 226: return 1;
      008861 A6 01            [ 1]  561 	ld	a, #0x01
      008863                        562 00121$:
                                    563 ;	../../my_STM8_libraries/stm8_I2C.c: 227: }
      008863 1E 06            [ 2]  564 	ldw	x, (6, sp)
      008865 5B 0A            [ 2]  565 	addw	sp, #10
      008867 FC               [ 2]  566 	jp	(x)
                                    567 ;	../../my_STM8_libraries/stm8_I2C.c: 228: uint8_t readBuffer_I2C(uint8_t address, uint8_t reg, uint8_t *buf, uint8_t size)
                                    568 ;	-----------------------------------------
                                    569 ;	 function readBuffer_I2C
                                    570 ;	-----------------------------------------
      008868                        571 _readBuffer_I2C:
      008868 52 06            [ 2]  572 	sub	sp, #6
      00886A 6B 04            [ 1]  573 	ld	(0x04, sp), a
                                    574 ;	../../my_STM8_libraries/stm8_I2C.c: 230: uint16_t timeout = 50000;
      00886C AE C3 50         [ 2]  575 	ldw	x, #0xc350
      00886F 1F 01            [ 2]  576 	ldw	(0x01, sp), x
                                    577 ;	../../my_STM8_libraries/stm8_I2C.c: 231: uint8_t i = 0;
      008871 0F 03            [ 1]  578 	clr	(0x03, sp)
                                    579 ;	../../my_STM8_libraries/stm8_I2C.c: 233: setACK_I2C(HIGH);
      008873 A6 01            [ 1]  580 	ld	a, #0x01
      008875 CD 86 4F         [ 4]  581 	call	_setACK_I2C
                                    582 ;	../../my_STM8_libraries/stm8_I2C.c: 235: if (size == 1) 
      008878 7B 0C            [ 1]  583 	ld	a, (0x0c, sp)
      00887A 4A               [ 1]  584 	dec	a
      00887B 26 17            [ 1]  585 	jrne	00104$
                                    586 ;	../../my_STM8_libraries/stm8_I2C.c: 237: if (readReg_I2C(address, reg, buf) == 0) return 0;
      00887D 1E 0A            [ 2]  587 	ldw	x, (0x0a, sp)
      00887F 89               [ 2]  588 	pushw	x
      008880 7B 0B            [ 1]  589 	ld	a, (0x0b, sp)
      008882 88               [ 1]  590 	push	a
      008883 7B 07            [ 1]  591 	ld	a, (0x07, sp)
      008885 CD 87 6E         [ 4]  592 	call	_readReg_I2C
      008888 4D               [ 1]  593 	tnz	a
      008889 26 04            [ 1]  594 	jrne	00102$
      00888B 4F               [ 1]  595 	clr	a
      00888C CC 89 7E         [ 2]  596 	jp	00137$
      00888F                        597 00102$:
                                    598 ;	../../my_STM8_libraries/stm8_I2C.c: 238: return 1;
      00888F A6 01            [ 1]  599 	ld	a, #0x01
      008891 CC 89 7E         [ 2]  600 	jp	00137$
      008894                        601 00104$:
                                    602 ;	../../my_STM8_libraries/stm8_I2C.c: 240: if (size == 2)
      008894 7B 0C            [ 1]  603 	ld	a, (0x0c, sp)
      008896 A1 02            [ 1]  604 	cp	a, #0x02
      008898 26 17            [ 1]  605 	jrne	00108$
                                    606 ;	../../my_STM8_libraries/stm8_I2C.c: 242: if (readBuffer2_I2C(address, reg, buf) == 0) return 0;
      00889A 1E 0A            [ 2]  607 	ldw	x, (0x0a, sp)
      00889C 89               [ 2]  608 	pushw	x
      00889D 7B 0B            [ 1]  609 	ld	a, (0x0b, sp)
      00889F 88               [ 1]  610 	push	a
      0088A0 7B 07            [ 1]  611 	ld	a, (0x07, sp)
      0088A2 CD 87 D9         [ 4]  612 	call	_readBuffer2_I2C
      0088A5 4D               [ 1]  613 	tnz	a
      0088A6 26 04            [ 1]  614 	jrne	00106$
      0088A8 4F               [ 1]  615 	clr	a
      0088A9 CC 89 7E         [ 2]  616 	jp	00137$
      0088AC                        617 00106$:
                                    618 ;	../../my_STM8_libraries/stm8_I2C.c: 243: return 1;
      0088AC A6 01            [ 1]  619 	ld	a, #0x01
      0088AE CC 89 7E         [ 2]  620 	jp	00137$
      0088B1                        621 00108$:
                                    622 ;	../../my_STM8_libraries/stm8_I2C.c: 245: if (start_I2C() == 0) return 0;
      0088B1 CD 86 30         [ 4]  623 	call	_start_I2C
      0088B4 4D               [ 1]  624 	tnz	a
      0088B5 26 04            [ 1]  625 	jrne	00110$
      0088B7 4F               [ 1]  626 	clr	a
      0088B8 CC 89 7E         [ 2]  627 	jp	00137$
      0088BB                        628 00110$:
                                    629 ;	../../my_STM8_libraries/stm8_I2C.c: 247: if (writeAddr_I2C(address, WRITE) == 0) return 0;
      0088BB 4B 00            [ 1]  630 	push	#0x00
      0088BD 7B 05            [ 1]  631 	ld	a, (0x05, sp)
      0088BF CD 86 61         [ 4]  632 	call	_writeAddr_I2C
      0088C2 4D               [ 1]  633 	tnz	a
      0088C3 26 04            [ 1]  634 	jrne	00112$
      0088C5 4F               [ 1]  635 	clr	a
      0088C6 CC 89 7E         [ 2]  636 	jp	00137$
      0088C9                        637 00112$:
                                    638 ;	../../my_STM8_libraries/stm8_I2C.c: 248: clearADDR_I2C();
      0088C9 CD 86 48         [ 4]  639 	call	_clearADDR_I2C
                                    640 ;	../../my_STM8_libraries/stm8_I2C.c: 250: if (writeByte_I2C(reg) == 0) return 0;
      0088CC 7B 09            [ 1]  641 	ld	a, (0x09, sp)
      0088CE CD 86 A1         [ 4]  642 	call	_writeByte_I2C
      0088D1 4D               [ 1]  643 	tnz	a
      0088D2 26 04            [ 1]  644 	jrne	00114$
      0088D4 4F               [ 1]  645 	clr	a
      0088D5 CC 89 7E         [ 2]  646 	jp	00137$
      0088D8                        647 00114$:
                                    648 ;	../../my_STM8_libraries/stm8_I2C.c: 252: if (start_I2C() == 0) return 0;
      0088D8 CD 86 30         [ 4]  649 	call	_start_I2C
      0088DB 4D               [ 1]  650 	tnz	a
      0088DC 26 04            [ 1]  651 	jrne	00116$
      0088DE 4F               [ 1]  652 	clr	a
      0088DF CC 89 7E         [ 2]  653 	jp	00137$
      0088E2                        654 00116$:
                                    655 ;	../../my_STM8_libraries/stm8_I2C.c: 254: if (writeAddr_I2C(address, READ) == 0) return 0;
      0088E2 4B 01            [ 1]  656 	push	#0x01
      0088E4 7B 05            [ 1]  657 	ld	a, (0x05, sp)
      0088E6 CD 86 61         [ 4]  658 	call	_writeAddr_I2C
      0088E9 4D               [ 1]  659 	tnz	a
      0088EA 26 04            [ 1]  660 	jrne	00118$
      0088EC 4F               [ 1]  661 	clr	a
      0088ED CC 89 7E         [ 2]  662 	jp	00137$
      0088F0                        663 00118$:
                                    664 ;	../../my_STM8_libraries/stm8_I2C.c: 255: clearADDR_I2C();
      0088F0 CD 86 48         [ 4]  665 	call	_clearADDR_I2C
                                    666 ;	../../my_STM8_libraries/stm8_I2C.c: 257: while (size > 3)
      0088F3 0F 05            [ 1]  667 	clr	(0x05, sp)
      0088F5 7B 0C            [ 1]  668 	ld	a, (0x0c, sp)
      0088F7 6B 06            [ 1]  669 	ld	(0x06, sp), a
      0088F9                        670 00124$:
      0088F9 7B 06            [ 1]  671 	ld	a, (0x06, sp)
      0088FB A1 03            [ 1]  672 	cp	a, #0x03
      0088FD 23 2B            [ 2]  673 	jrule	00153$
                                    674 ;	../../my_STM8_libraries/stm8_I2C.c: 259: while (!(I2C_SR1 & I2C_SR1_RXNE))
      0088FF 1E 01            [ 2]  675 	ldw	x, (0x01, sp)
      008901                        676 00121$:
      008901 72 0C 52 17 0A   [ 2]  677 	btjt	0x5217, #6, 00123$
                                    678 ;	../../my_STM8_libraries/stm8_I2C.c: 261: if (--timeout == 0)
      008906 5A               [ 2]  679 	decw	x
      008907 5D               [ 2]  680 	tnzw	x
      008908 26 F7            [ 1]  681 	jrne	00121$
                                    682 ;	../../my_STM8_libraries/stm8_I2C.c: 263: stop_I2C();
      00890A CD 86 2B         [ 4]  683 	call	_stop_I2C
                                    684 ;	../../my_STM8_libraries/stm8_I2C.c: 264: return 0;
      00890D 4F               [ 1]  685 	clr	a
      00890E 20 6E            [ 2]  686 	jra	00137$
      008910                        687 00123$:
                                    688 ;	../../my_STM8_libraries/stm8_I2C.c: 267: timeout = 50000;
      008910 AE C3 50         [ 2]  689 	ldw	x, #0xc350
      008913 1F 01            [ 2]  690 	ldw	(0x01, sp), x
                                    691 ;	../../my_STM8_libraries/stm8_I2C.c: 268: buf[i] = I2C_DR;
      008915 5F               [ 1]  692 	clrw	x
      008916 7B 05            [ 1]  693 	ld	a, (0x05, sp)
      008918 97               [ 1]  694 	ld	xl, a
      008919 72 FB 0A         [ 2]  695 	addw	x, (0x0a, sp)
      00891C C6 52 16         [ 1]  696 	ld	a, 0x5216
      00891F F7               [ 1]  697 	ld	(x), a
                                    698 ;	../../my_STM8_libraries/stm8_I2C.c: 269: i++;
      008920 0C 05            [ 1]  699 	inc	(0x05, sp)
      008922 7B 05            [ 1]  700 	ld	a, (0x05, sp)
      008924 6B 03            [ 1]  701 	ld	(0x03, sp), a
                                    702 ;	../../my_STM8_libraries/stm8_I2C.c: 270: size--;
      008926 0A 06            [ 1]  703 	dec	(0x06, sp)
      008928 20 CF            [ 2]  704 	jra	00124$
                                    705 ;	../../my_STM8_libraries/stm8_I2C.c: 273: while (!(I2C_SR1 & I2C_SR1_BTF))
      00892A                        706 00153$:
      00892A 1E 01            [ 2]  707 	ldw	x, (0x01, sp)
      00892C                        708 00129$:
      00892C 72 04 52 17 0A   [ 2]  709 	btjt	0x5217, #2, 00131$
                                    710 ;	../../my_STM8_libraries/stm8_I2C.c: 275: if (--timeout == 0)
      008931 5A               [ 2]  711 	decw	x
      008932 5D               [ 2]  712 	tnzw	x
      008933 26 F7            [ 1]  713 	jrne	00129$
                                    714 ;	../../my_STM8_libraries/stm8_I2C.c: 277: stop_I2C();
      008935 CD 86 2B         [ 4]  715 	call	_stop_I2C
                                    716 ;	../../my_STM8_libraries/stm8_I2C.c: 278: return 0;
      008938 4F               [ 1]  717 	clr	a
      008939 20 43            [ 2]  718 	jra	00137$
      00893B                        719 00131$:
                                    720 ;	../../my_STM8_libraries/stm8_I2C.c: 283: setACK_I2C(LOW);
      00893B 4F               [ 1]  721 	clr	a
      00893C CD 86 4F         [ 4]  722 	call	_setACK_I2C
                                    723 ;	../../my_STM8_libraries/stm8_I2C.c: 285: buf[i] = I2C_DR;
      00893F 5F               [ 1]  724 	clrw	x
      008940 7B 03            [ 1]  725 	ld	a, (0x03, sp)
      008942 97               [ 1]  726 	ld	xl, a
      008943 72 FB 0A         [ 2]  727 	addw	x, (0x0a, sp)
      008946 C6 52 16         [ 1]  728 	ld	a, 0x5216
      008949 F7               [ 1]  729 	ld	(x), a
                                    730 ;	../../my_STM8_libraries/stm8_I2C.c: 286: i++;
      00894A 7B 03            [ 1]  731 	ld	a, (0x03, sp)
      00894C 4C               [ 1]  732 	inc	a
      00894D 6B 06            [ 1]  733 	ld	(0x06, sp), a
                                    734 ;	../../my_STM8_libraries/stm8_I2C.c: 288: stop_I2C();
      00894F CD 86 2B         [ 4]  735 	call	_stop_I2C
                                    736 ;	../../my_STM8_libraries/stm8_I2C.c: 290: buf[i] = I2C_DR;
      008952 5F               [ 1]  737 	clrw	x
      008953 7B 06            [ 1]  738 	ld	a, (0x06, sp)
      008955 97               [ 1]  739 	ld	xl, a
      008956 72 FB 0A         [ 2]  740 	addw	x, (0x0a, sp)
      008959 C6 52 16         [ 1]  741 	ld	a, 0x5216
      00895C F7               [ 1]  742 	ld	(x), a
                                    743 ;	../../my_STM8_libraries/stm8_I2C.c: 291: i++;
      00895D 0C 06            [ 1]  744 	inc	(0x06, sp)
                                    745 ;	../../my_STM8_libraries/stm8_I2C.c: 293: while (!(I2C_SR1 & I2C_SR1_RXNE))
      00895F AE C3 50         [ 2]  746 	ldw	x, #0xc350
      008962                        747 00134$:
      008962 72 0C 52 17 0A   [ 2]  748 	btjt	0x5217, #6, 00136$
                                    749 ;	../../my_STM8_libraries/stm8_I2C.c: 295: if (--timeout == 0)
      008967 5A               [ 2]  750 	decw	x
      008968 5D               [ 2]  751 	tnzw	x
      008969 26 F7            [ 1]  752 	jrne	00134$
                                    753 ;	../../my_STM8_libraries/stm8_I2C.c: 297: stop_I2C();
      00896B CD 86 2B         [ 4]  754 	call	_stop_I2C
                                    755 ;	../../my_STM8_libraries/stm8_I2C.c: 298: return 0;
      00896E 4F               [ 1]  756 	clr	a
      00896F 20 0D            [ 2]  757 	jra	00137$
      008971                        758 00136$:
                                    759 ;	../../my_STM8_libraries/stm8_I2C.c: 301: buf[i] = I2C_DR;
      008971 5F               [ 1]  760 	clrw	x
      008972 7B 06            [ 1]  761 	ld	a, (0x06, sp)
      008974 97               [ 1]  762 	ld	xl, a
      008975 72 FB 0A         [ 2]  763 	addw	x, (0x0a, sp)
      008978 C6 52 16         [ 1]  764 	ld	a, 0x5216
      00897B F7               [ 1]  765 	ld	(x), a
                                    766 ;	../../my_STM8_libraries/stm8_I2C.c: 303: return 1;
      00897C A6 01            [ 1]  767 	ld	a, #0x01
      00897E                        768 00137$:
                                    769 ;	../../my_STM8_libraries/stm8_I2C.c: 304: }
      00897E 1E 07            [ 2]  770 	ldw	x, (7, sp)
      008980 5B 0C            [ 2]  771 	addw	sp, #12
      008982 FC               [ 2]  772 	jp	(x)
                                    773 	.area CODE
                                    774 	.area CONST
                                    775 	.area INITIALIZER
                                    776 	.area CABS (ABS)
