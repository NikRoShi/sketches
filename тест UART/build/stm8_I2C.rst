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
                                     17 	.globl _writeReg
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; global & static initialisations
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area GSINIT
                                     46 ;--------------------------------------------------------
                                     47 ; Home
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area HOME
                                     51 ;--------------------------------------------------------
                                     52 ; code
                                     53 ;--------------------------------------------------------
                                     54 	.area CODE
                                     55 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     56 ;	-----------------------------------------
                                     57 ;	 function init_I2C
                                     58 ;	-----------------------------------------
      0081E5                         59 _init_I2C:
                                     60 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0081E5 72 11 52 10      [ 1]   61 	bres	0x5210, #0
                                     62 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0081E9 35 10 52 12      [ 1]   63 	mov	0x5212+0, #0x10
                                     64 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0081ED 35 50 52 1B      [ 1]   65 	mov	0x521b+0, #0x50
                                     66 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      0081F1 35 00 52 1C      [ 1]   67 	mov	0x521c+0, #0x00
                                     68 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      0081F5 35 11 52 1D      [ 1]   69 	mov	0x521d+0, #0x11
                                     70 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      0081F9 72 10 52 10      [ 1]   71 	bset	0x5210, #0
                                     72 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      0081FD 81               [ 4]   73 	ret
                                     74 ;	../../my_STM8_libraries/stm8_I2C.c: 23: void stop_I2C(void)
                                     75 ;	-----------------------------------------
                                     76 ;	 function stop_I2C
                                     77 ;	-----------------------------------------
      0081FE                         78 _stop_I2C:
                                     79 ;	../../my_STM8_libraries/stm8_I2C.c: 25: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      0081FE 72 12 52 11      [ 1]   80 	bset	0x5211, #1
                                     81 ;	../../my_STM8_libraries/stm8_I2C.c: 26: }
      008202 81               [ 4]   82 	ret
                                     83 ;	../../my_STM8_libraries/stm8_I2C.c: 28: uint8_t start_I2C(void)
                                     84 ;	-----------------------------------------
                                     85 ;	 function start_I2C
                                     86 ;	-----------------------------------------
      008203                         87 _start_I2C:
                                     88 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008203 72 10 52 11      [ 1]   89 	bset	0x5211, #0
                                     90 ;	../../my_STM8_libraries/stm8_I2C.c: 33: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008207 AE C3 50         [ 2]   91 	ldw	x, #0xc350
      00820A                         92 00103$:
      00820A 72 00 52 17 09   [ 2]   93 	btjt	0x5217, #0, 00105$
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 35: if (--timeout == 0) 
      00820F 5A               [ 2]   95 	decw	x
      008210 5D               [ 2]   96 	tnzw	x
      008211 26 F7            [ 1]   97 	jrne	00103$
                                     98 ;	../../my_STM8_libraries/stm8_I2C.c: 37: stop_I2C();
      008213 CD 81 FE         [ 4]   99 	call	_stop_I2C
                                    100 ;	../../my_STM8_libraries/stm8_I2C.c: 38: return 0;
      008216 4F               [ 1]  101 	clr	a
      008217 81               [ 4]  102 	ret
      008218                        103 00105$:
                                    104 ;	../../my_STM8_libraries/stm8_I2C.c: 41: return 1;
      008218 A6 01            [ 1]  105 	ld	a, #0x01
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 42: }
      00821A 81               [ 4]  107 	ret
                                    108 ;	../../my_STM8_libraries/stm8_I2C.c: 44: uint8_t writeAddr_I2C(uint8_t address)
                                    109 ;	-----------------------------------------
                                    110 ;	 function writeAddr_I2C
                                    111 ;	-----------------------------------------
      00821B                        112 _writeAddr_I2C:
                                    113 ;	../../my_STM8_libraries/stm8_I2C.c: 48: I2C_DR = (address << 1);	//записываем в регистр данных адрес устройства к которому мы хотим обратиться + 0, что значит что мы хотим write
      00821B 48               [ 1]  114 	sll	a
      00821C C7 52 16         [ 1]  115 	ld	0x5216, a
                                    116 ;	../../my_STM8_libraries/stm8_I2C.c: 49: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))
      00821F AE C3 50         [ 2]  117 	ldw	x, #0xc350
      008222                        118 00104$:
      008222 72 02 52 17 0E   [ 2]  119 	btjt	0x5217, #1, 00106$
      008227 72 04 52 18 09   [ 2]  120 	btjt	0x5218, #2, 00106$
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 51: if (--timeout == 0) 
      00822C 5A               [ 2]  122 	decw	x
      00822D 5D               [ 2]  123 	tnzw	x
      00822E 26 F2            [ 1]  124 	jrne	00104$
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 53: stop_I2C();
      008230 CD 81 FE         [ 4]  126 	call	_stop_I2C
                                    127 ;	../../my_STM8_libraries/stm8_I2C.c: 54: return 0;
      008233 4F               [ 1]  128 	clr	a
      008234 81               [ 4]  129 	ret
      008235                        130 00106$:
                                    131 ;	../../my_STM8_libraries/stm8_I2C.c: 57: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      008235 72 03 52 17 09   [ 2]  132 	btjf	0x5217, #1, 00108$
                                    133 ;	../../my_STM8_libraries/stm8_I2C.c: 59: (void)I2C_SR1;	//сбрасываем как в RM
      00823A C6 52 17         [ 1]  134 	ld	a, 0x5217
                                    135 ;	../../my_STM8_libraries/stm8_I2C.c: 60: (void)I2C_SR3;
      00823D C6 52 19         [ 1]  136 	ld	a, 0x5219
                                    137 ;	../../my_STM8_libraries/stm8_I2C.c: 61: return 1;
      008240 A6 01            [ 1]  138 	ld	a, #0x01
      008242 81               [ 4]  139 	ret
      008243                        140 00108$:
                                    141 ;	../../my_STM8_libraries/stm8_I2C.c: 63: I2C_SR2 &= ~I2C_SR2_AF;	//иначе, сбрасываем ошибку подтверждения
      008243 72 15 52 18      [ 1]  142 	bres	0x5218, #2
                                    143 ;	../../my_STM8_libraries/stm8_I2C.c: 64: stop_I2C();
      008247 CD 81 FE         [ 4]  144 	call	_stop_I2C
                                    145 ;	../../my_STM8_libraries/stm8_I2C.c: 65: return 0;
      00824A 4F               [ 1]  146 	clr	a
                                    147 ;	../../my_STM8_libraries/stm8_I2C.c: 66: }
      00824B 81               [ 4]  148 	ret
                                    149 ;	../../my_STM8_libraries/stm8_I2C.c: 68: uint8_t writeByte_I2C(uint8_t data)
                                    150 ;	-----------------------------------------
                                    151 ;	 function writeByte_I2C
                                    152 ;	-----------------------------------------
      00824C                        153 _writeByte_I2C:
                                    154 ;	../../my_STM8_libraries/stm8_I2C.c: 72: I2C_DR = data;	//записываем байт в реистр данных
      00824C C7 52 16         [ 1]  155 	ld	0x5216, a
                                    156 ;	../../my_STM8_libraries/stm8_I2C.c: 74: while(!(I2C_SR1 & I2C_SR1_TXE))	//ждём флага о том, что регистр данных опустел
      00824F AE C3 50         [ 2]  157 	ldw	x, #0xc350
      008252                        158 00105$:
      008252 C6 52 17         [ 1]  159 	ld	a, 0x5217
      008255 2B 17            [ 1]  160 	jrmi	00107$
                                    161 ;	../../my_STM8_libraries/stm8_I2C.c: 76: if (I2C_SR2 & I2C_SR2_AF)	//если пришёл NACK
      008257 72 05 52 18 09   [ 2]  162 	btjf	0x5218, #2, 00102$
                                    163 ;	../../my_STM8_libraries/stm8_I2C.c: 78: I2C_SR2 &= ~I2C_SR2_AF;	//очищаем регистр ошибки
      00825C 72 15 52 18      [ 1]  164 	bres	0x5218, #2
                                    165 ;	../../my_STM8_libraries/stm8_I2C.c: 79: stop_I2C();
      008260 CD 81 FE         [ 4]  166 	call	_stop_I2C
                                    167 ;	../../my_STM8_libraries/stm8_I2C.c: 80: return 0;
      008263 4F               [ 1]  168 	clr	a
      008264 81               [ 4]  169 	ret
      008265                        170 00102$:
                                    171 ;	../../my_STM8_libraries/stm8_I2C.c: 82: if (--timeout == 0)	//проверка таймаута
      008265 5A               [ 2]  172 	decw	x
      008266 5D               [ 2]  173 	tnzw	x
      008267 26 E9            [ 1]  174 	jrne	00105$
                                    175 ;	../../my_STM8_libraries/stm8_I2C.c: 84: stop_I2C();
      008269 CD 81 FE         [ 4]  176 	call	_stop_I2C
                                    177 ;	../../my_STM8_libraries/stm8_I2C.c: 85: return 0;
      00826C 4F               [ 1]  178 	clr	a
      00826D 81               [ 4]  179 	ret
      00826E                        180 00107$:
                                    181 ;	../../my_STM8_libraries/stm8_I2C.c: 88: return 1;
      00826E A6 01            [ 1]  182 	ld	a, #0x01
                                    183 ;	../../my_STM8_libraries/stm8_I2C.c: 89: }
      008270 81               [ 4]  184 	ret
                                    185 ;	../../my_STM8_libraries/stm8_I2C.c: 91: uint8_t ping_I2C(uint8_t address)
                                    186 ;	-----------------------------------------
                                    187 ;	 function ping_I2C
                                    188 ;	-----------------------------------------
      008271                        189 _ping_I2C:
      008271 88               [ 1]  190 	push	a
      008272 6B 01            [ 1]  191 	ld	(0x01, sp), a
                                    192 ;	../../my_STM8_libraries/stm8_I2C.c: 93: if (start_I2C() == 0) return 0;
      008274 CD 82 03         [ 4]  193 	call	_start_I2C
      008277 4D               [ 1]  194 	tnz	a
      008278 26 03            [ 1]  195 	jrne	00102$
      00827A 4F               [ 1]  196 	clr	a
      00827B 20 10            [ 2]  197 	jra	00105$
      00827D                        198 00102$:
                                    199 ;	../../my_STM8_libraries/stm8_I2C.c: 94: if (writeAddr_I2C(address) == 0) return 0; 
      00827D 7B 01            [ 1]  200 	ld	a, (0x01, sp)
      00827F CD 82 1B         [ 4]  201 	call	_writeAddr_I2C
      008282 4D               [ 1]  202 	tnz	a
      008283 26 03            [ 1]  203 	jrne	00104$
      008285 4F               [ 1]  204 	clr	a
      008286 20 05            [ 2]  205 	jra	00105$
      008288                        206 00104$:
                                    207 ;	../../my_STM8_libraries/stm8_I2C.c: 95: stop_I2C();
      008288 CD 81 FE         [ 4]  208 	call	_stop_I2C
                                    209 ;	../../my_STM8_libraries/stm8_I2C.c: 96: return 1;
      00828B A6 01            [ 1]  210 	ld	a, #0x01
      00828D                        211 00105$:
                                    212 ;	../../my_STM8_libraries/stm8_I2C.c: 97: }
      00828D 5B 01            [ 2]  213 	addw	sp, #1
      00828F 81               [ 4]  214 	ret
                                    215 ;	../../my_STM8_libraries/stm8_I2C.c: 99: uint8_t writeReg(uint8_t address, uint8_t reg, uint8_t data)
                                    216 ;	-----------------------------------------
                                    217 ;	 function writeReg
                                    218 ;	-----------------------------------------
      008290                        219 _writeReg:
      008290 88               [ 1]  220 	push	a
      008291 6B 01            [ 1]  221 	ld	(0x01, sp), a
                                    222 ;	../../my_STM8_libraries/stm8_I2C.c: 101: if (start_I2C() == 0) return 0;
      008293 CD 82 03         [ 4]  223 	call	_start_I2C
      008296 4D               [ 1]  224 	tnz	a
      008297 26 03            [ 1]  225 	jrne	00102$
      008299 4F               [ 1]  226 	clr	a
      00829A 20 26            [ 2]  227 	jra	00109$
      00829C                        228 00102$:
                                    229 ;	../../my_STM8_libraries/stm8_I2C.c: 102: if (writeAddr_I2C(address) == 0) return 0;
      00829C 7B 01            [ 1]  230 	ld	a, (0x01, sp)
      00829E CD 82 1B         [ 4]  231 	call	_writeAddr_I2C
      0082A1 4D               [ 1]  232 	tnz	a
      0082A2 26 03            [ 1]  233 	jrne	00104$
      0082A4 4F               [ 1]  234 	clr	a
      0082A5 20 1B            [ 2]  235 	jra	00109$
      0082A7                        236 00104$:
                                    237 ;	../../my_STM8_libraries/stm8_I2C.c: 103: if (writeByte_I2C(reg) == 0) return 0;
      0082A7 7B 04            [ 1]  238 	ld	a, (0x04, sp)
      0082A9 CD 82 4C         [ 4]  239 	call	_writeByte_I2C
      0082AC 4D               [ 1]  240 	tnz	a
      0082AD 26 03            [ 1]  241 	jrne	00106$
      0082AF 4F               [ 1]  242 	clr	a
      0082B0 20 10            [ 2]  243 	jra	00109$
      0082B2                        244 00106$:
                                    245 ;	../../my_STM8_libraries/stm8_I2C.c: 104: if (writeByte_I2C(data) == 0) return 0;
      0082B2 7B 05            [ 1]  246 	ld	a, (0x05, sp)
      0082B4 CD 82 4C         [ 4]  247 	call	_writeByte_I2C
      0082B7 4D               [ 1]  248 	tnz	a
      0082B8 26 03            [ 1]  249 	jrne	00108$
      0082BA 4F               [ 1]  250 	clr	a
      0082BB 20 05            [ 2]  251 	jra	00109$
      0082BD                        252 00108$:
                                    253 ;	../../my_STM8_libraries/stm8_I2C.c: 105: stop_I2C();
      0082BD CD 81 FE         [ 4]  254 	call	_stop_I2C
                                    255 ;	../../my_STM8_libraries/stm8_I2C.c: 106: return 1;
      0082C0 A6 01            [ 1]  256 	ld	a, #0x01
      0082C2                        257 00109$:
                                    258 ;	../../my_STM8_libraries/stm8_I2C.c: 107: }
      0082C2 1E 02            [ 2]  259 	ldw	x, (2, sp)
      0082C4 5B 05            [ 2]  260 	addw	sp, #5
      0082C6 FC               [ 2]  261 	jp	(x)
                                    262 	.area CODE
                                    263 	.area CONST
                                    264 	.area INITIALIZER
                                    265 	.area CABS (ABS)
