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
                                     12 	.globl _ping_I2C
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	../../my_STM8_libraries/stm8_I2C.c: 3: void init_I2C(void) 
                                     51 ;	-----------------------------------------
                                     52 ;	 function init_I2C
                                     53 ;	-----------------------------------------
      0081F6                         54 _init_I2C:
                                     55 ;	../../my_STM8_libraries/stm8_I2C.c: 8: PB_DDR |= (1 << 4) | (1 << 5);  // настраиваем PB4 и PB5 как выход
      0081F6 C6 50 07         [ 1]   56 	ld	a, 0x5007
      0081F9 AA 30            [ 1]   57 	or	a, #0x30
      0081FB C7 50 07         [ 1]   58 	ld	0x5007, a
                                     59 ;	../../my_STM8_libraries/stm8_I2C.c: 9: PB_CR1 &= ~((1 << 4) | (1 << 5));	// настраиваем PB4 и PB5 открытый коллектор 
      0081FE C6 50 08         [ 1]   60 	ld	a, 0x5008
      008201 A4 CF            [ 1]   61 	and	a, #0xcf
      008203 C7 50 08         [ 1]   62 	ld	0x5008, a
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      008206 72 11 52 10      [ 1]   64 	bres	0x5210, #0
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      00820A 35 10 52 12      [ 1]   66 	mov	0x5212+0, #0x10
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      00820E 35 50 52 1B      [ 1]   68 	mov	0x521b+0, #0x50
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      008212 35 00 52 1C      [ 1]   70 	mov	0x521c+0, #0x00
                                     71 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008216 35 11 52 1D      [ 1]   72 	mov	0x521d+0, #0x11
                                     73 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      00821A 72 10 52 10      [ 1]   74 	bset	0x5210, #0
                                     75 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      00821E 81               [ 4]   76 	ret
                                     77 ;	../../my_STM8_libraries/stm8_I2C.c: 23: uint8_t ping_I2C(uint8_t address)
                                     78 ;	-----------------------------------------
                                     79 ;	 function ping_I2C
                                     80 ;	-----------------------------------------
      00821F                         81 _ping_I2C:
      00821F 52 03            [ 2]   82 	sub	sp, #3
      008221 6B 01            [ 1]   83 	ld	(0x01, sp), a
                                     84 ;	../../my_STM8_libraries/stm8_I2C.c: 27: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008223 72 10 52 11      [ 1]   85 	bset	0x5211, #0
                                     86 ;	../../my_STM8_libraries/stm8_I2C.c: 29: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008227 AE C3 50         [ 2]   87 	ldw	x, #0xc350
      00822A 1F 02            [ 2]   88 	ldw	(0x02, sp), x
      00822C                         89 00103$:
      00822C 72 00 52 17 0E   [ 2]   90 	btjt	0x5217, #0, 00105$
                                     91 ;	../../my_STM8_libraries/stm8_I2C.c: 31: if (--timeout == 0) 
      008231 1E 02            [ 2]   92 	ldw	x, (0x02, sp)
      008233 5A               [ 2]   93 	decw	x
      008234 1F 02            [ 2]   94 	ldw	(0x02, sp), x
      008236 26 F4            [ 1]   95 	jrne	00103$
                                     96 ;	../../my_STM8_libraries/stm8_I2C.c: 33: I2C_CR2 |= I2C_CR2_STOP;
      008238 72 12 52 11      [ 1]   97 	bset	0x5211, #1
                                     98 ;	../../my_STM8_libraries/stm8_I2C.c: 34: return 0;
      00823C 4F               [ 1]   99 	clr	a
      00823D 20 3A            [ 2]  100 	jra	00114$
      00823F                        101 00105$:
                                    102 ;	../../my_STM8_libraries/stm8_I2C.c: 40: I2C_DR = (address << 1);	//записываем в регистр данных адрес устройства к которому мы хотим обратиться + 0, что значит что мы хотим write
      00823F 7B 01            [ 1]  103 	ld	a, (0x01, sp)
      008241 48               [ 1]  104 	sll	a
      008242 C7 52 16         [ 1]  105 	ld	0x5216, a
                                    106 ;	../../my_STM8_libraries/stm8_I2C.c: 42: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))	//ждём либо флага подтверждения адреса либо ошибки подтверждения
      008245 AE C3 50         [ 2]  107 	ldw	x, #0xc350
      008248                        108 00109$:
      008248 72 02 52 17 10   [ 2]  109 	btjt	0x5217, #1, 00111$
      00824D 72 04 52 18 0B   [ 2]  110 	btjt	0x5218, #2, 00111$
                                    111 ;	../../my_STM8_libraries/stm8_I2C.c: 44: if (--timeout == 0) 
      008252 5A               [ 2]  112 	decw	x
      008253 5D               [ 2]  113 	tnzw	x
      008254 26 F2            [ 1]  114 	jrne	00109$
                                    115 ;	../../my_STM8_libraries/stm8_I2C.c: 46: I2C_CR2 |= I2C_CR2_STOP;
      008256 72 12 52 11      [ 1]  116 	bset	0x5211, #1
                                    117 ;	../../my_STM8_libraries/stm8_I2C.c: 47: return 0;
      00825A 4F               [ 1]  118 	clr	a
      00825B 20 1C            [ 2]  119 	jra	00114$
      00825D                        120 00111$:
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 50: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00825D 72 03 52 17 0E   [ 2]  122 	btjf	0x5217, #1, 00113$
                                    123 ;	../../my_STM8_libraries/stm8_I2C.c: 52: (void)I2C_SR1;	//сбрасываем как в RM
      008262 C6 52 17         [ 1]  124 	ld	a, 0x5217
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 53: (void)I2C_SR3;
      008265 C6 52 19         [ 1]  126 	ld	a, 0x5219
                                    127 ;	../../my_STM8_libraries/stm8_I2C.c: 55: I2C_CR2 |= I2C_CR2_STOP;	//даём стоп на линии
      008268 72 12 52 11      [ 1]  128 	bset	0x5211, #1
                                    129 ;	../../my_STM8_libraries/stm8_I2C.c: 56: return 1;
      00826C A6 01            [ 1]  130 	ld	a, #0x01
      00826E 20 09            [ 2]  131 	jra	00114$
      008270                        132 00113$:
                                    133 ;	../../my_STM8_libraries/stm8_I2C.c: 58: I2C_SR2 &= ~I2C_SR2_AF;	//если ошибка подтверждения
      008270 72 15 52 18      [ 1]  134 	bres	0x5218, #2
                                    135 ;	../../my_STM8_libraries/stm8_I2C.c: 60: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008274 72 12 52 11      [ 1]  136 	bset	0x5211, #1
                                    137 ;	../../my_STM8_libraries/stm8_I2C.c: 61: return 0;
      008278 4F               [ 1]  138 	clr	a
      008279                        139 00114$:
                                    140 ;	../../my_STM8_libraries/stm8_I2C.c: 62: }
      008279 5B 03            [ 2]  141 	addw	sp, #3
      00827B 81               [ 4]  142 	ret
                                    143 	.area CODE
                                    144 	.area CONST
                                    145 	.area INITIALIZER
                                    146 	.area CABS (ABS)
