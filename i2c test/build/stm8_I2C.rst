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
                                     55 ;	../../my_STM8_libraries/stm8_I2C.c: 11: I2C_CR1 &= ~I2C_CR1_PE;	// отключим модуль перед настройкой
      0081F6 72 11 52 10      [ 1]   56 	bres	0x5210, #0
                                     57 ;	../../my_STM8_libraries/stm8_I2C.c: 13: I2C_FREQR = F_CPU / 1000000UL;	// сообщим модулю частоту ядра
      0081FA 35 10 52 12      [ 1]   58 	mov	0x5212+0, #0x10
                                     59 ;	../../my_STM8_libraries/stm8_I2C.c: 15: I2C_CCRL = (uint8_t)ccr;	// настроим частоту
      0081FE 35 50 52 1B      [ 1]   60 	mov	0x521b+0, #0x50
                                     61 ;	../../my_STM8_libraries/stm8_I2C.c: 16: I2C_CCRH = (uint8_t)(ccr >> 8);
      008202 35 00 52 1C      [ 1]   62 	mov	0x521c+0, #0x00
                                     63 ;	../../my_STM8_libraries/stm8_I2C.c: 18: I2C_TRISER = (F_CPU / 1000000UL) + 1;	//время нарастания = Fcpu + 1
      008206 35 11 52 1D      [ 1]   64 	mov	0x521d+0, #0x11
                                     65 ;	../../my_STM8_libraries/stm8_I2C.c: 20: I2C_CR1 |= I2C_CR1_PE;	// включим модуль перед настройкой
      00820A 72 10 52 10      [ 1]   66 	bset	0x5210, #0
                                     67 ;	../../my_STM8_libraries/stm8_I2C.c: 21: }
      00820E 81               [ 4]   68 	ret
                                     69 ;	../../my_STM8_libraries/stm8_I2C.c: 23: uint8_t ping_I2C(uint8_t address)
                                     70 ;	-----------------------------------------
                                     71 ;	 function ping_I2C
                                     72 ;	-----------------------------------------
      00820F                         73 _ping_I2C:
      00820F 52 03            [ 2]   74 	sub	sp, #3
      008211 6B 01            [ 1]   75 	ld	(0x01, sp), a
                                     76 ;	../../my_STM8_libraries/stm8_I2C.c: 27: I2C_CR2 |= I2C_CR2_START;	//даём старт на линии
      008213 72 10 52 11      [ 1]   77 	bset	0x5211, #0
                                     78 ;	../../my_STM8_libraries/stm8_I2C.c: 28: while (!(I2C_SR1 & I2C_SR1_SB))	//ждём флага что старт сформирован
      008217 AE C3 50         [ 2]   79 	ldw	x, #0xc350
      00821A 1F 02            [ 2]   80 	ldw	(0x02, sp), x
      00821C                         81 00103$:
      00821C 72 00 52 17 0E   [ 2]   82 	btjt	0x5217, #0, 00105$
                                     83 ;	../../my_STM8_libraries/stm8_I2C.c: 30: if (--timeout == 0) 
      008221 1E 02            [ 2]   84 	ldw	x, (0x02, sp)
      008223 5A               [ 2]   85 	decw	x
      008224 1F 02            [ 2]   86 	ldw	(0x02, sp), x
      008226 26 F4            [ 1]   87 	jrne	00103$
                                     88 ;	../../my_STM8_libraries/stm8_I2C.c: 32: I2C_CR2 |= I2C_CR2_STOP;
      008228 72 12 52 11      [ 1]   89 	bset	0x5211, #1
                                     90 ;	../../my_STM8_libraries/stm8_I2C.c: 33: return 0;
      00822C 4F               [ 1]   91 	clr	a
      00822D 20 3A            [ 2]   92 	jra	00114$
      00822F                         93 00105$:
                                     94 ;	../../my_STM8_libraries/stm8_I2C.c: 38: I2C_DR = (address << 1);	//записываем в регистр данных адрес устройства к которому мы хотим обратиться + 0, что значит что мы хотим write
      00822F 7B 01            [ 1]   95 	ld	a, (0x01, sp)
      008231 48               [ 1]   96 	sll	a
      008232 C7 52 16         [ 1]   97 	ld	0x5216, a
                                     98 ;	../../my_STM8_libraries/stm8_I2C.c: 39: while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR2 & I2C_SR2_AF))	//ждём либо флага подтверждения адреса либо ошибки подтверждения
      008235 AE C3 50         [ 2]   99 	ldw	x, #0xc350
      008238                        100 00109$:
      008238 72 02 52 17 10   [ 2]  101 	btjt	0x5217, #1, 00111$
      00823D 72 04 52 18 0B   [ 2]  102 	btjt	0x5218, #2, 00111$
                                    103 ;	../../my_STM8_libraries/stm8_I2C.c: 41: if (--timeout == 0) 
      008242 5A               [ 2]  104 	decw	x
      008243 5D               [ 2]  105 	tnzw	x
      008244 26 F2            [ 1]  106 	jrne	00109$
                                    107 ;	../../my_STM8_libraries/stm8_I2C.c: 43: I2C_CR2 |= I2C_CR2_STOP;
      008246 72 12 52 11      [ 1]  108 	bset	0x5211, #1
                                    109 ;	../../my_STM8_libraries/stm8_I2C.c: 44: return 0;
      00824A 4F               [ 1]  110 	clr	a
      00824B 20 1C            [ 2]  111 	jra	00114$
      00824D                        112 00111$:
                                    113 ;	../../my_STM8_libraries/stm8_I2C.c: 47: if (I2C_SR1 & I2C_SR1_ADDR)	//если адрес ответил 
      00824D 72 03 52 17 0E   [ 2]  114 	btjf	0x5217, #1, 00113$
                                    115 ;	../../my_STM8_libraries/stm8_I2C.c: 49: (void)I2C_SR1;	//сбрасываем как в RM
      008252 C6 52 17         [ 1]  116 	ld	a, 0x5217
                                    117 ;	../../my_STM8_libraries/stm8_I2C.c: 50: (void)I2C_SR3;
      008255 C6 52 19         [ 1]  118 	ld	a, 0x5219
                                    119 ;	../../my_STM8_libraries/stm8_I2C.c: 52: I2C_CR2 |= I2C_CR2_STOP;	//даём стоп на линии
      008258 72 12 52 11      [ 1]  120 	bset	0x5211, #1
                                    121 ;	../../my_STM8_libraries/stm8_I2C.c: 53: return 1;
      00825C A6 01            [ 1]  122 	ld	a, #0x01
      00825E 20 09            [ 2]  123 	jra	00114$
      008260                        124 00113$:
                                    125 ;	../../my_STM8_libraries/stm8_I2C.c: 55: I2C_SR2 &= ~I2C_SR2_AF;	//если ошибка подтверждения
      008260 72 15 52 18      [ 1]  126 	bres	0x5218, #2
                                    127 ;	../../my_STM8_libraries/stm8_I2C.c: 57: I2C_CR2 |= I2C_CR2_STOP;	//формируем стоп на линии
      008264 72 12 52 11      [ 1]  128 	bset	0x5211, #1
                                    129 ;	../../my_STM8_libraries/stm8_I2C.c: 58: return 0;
      008268 4F               [ 1]  130 	clr	a
      008269                        131 00114$:
                                    132 ;	../../my_STM8_libraries/stm8_I2C.c: 59: }
      008269 5B 03            [ 2]  133 	addw	sp, #3
      00826B 81               [ 4]  134 	ret
                                    135 	.area CODE
                                    136 	.area CONST
                                    137 	.area INITIALIZER
                                    138 	.area CABS (ABS)
