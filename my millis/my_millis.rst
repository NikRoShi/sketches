                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module my_millis
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _millis
                                     12 	.globl _tim4_init
                                     13 	.globl _TIM4_UPD_OVF_IRQHandler
                                     14 	.globl _ms_counter
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
      000001                         19 _ms_counter::
      000001                         20 	.ds 4
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram
                                     27 ;--------------------------------------------------------
                                     28 	.area SSEG
      000005                         29 __start__stack:
      000005                         30 	.ds	1
                                     31 
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
                                     46 ; interrupt vector
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
      008000                         49 __interrupt_vect:
      008000 82 00 80 6B             50 	int s_GSINIT ; reset
      008004 82 00 00 00             51 	int 0x000000 ; trap
      008008 82 00 00 00             52 	int 0x000000 ; int0
      00800C 82 00 00 00             53 	int 0x000000 ; int1
      008010 82 00 00 00             54 	int 0x000000 ; int2
      008014 82 00 00 00             55 	int 0x000000 ; int3
      008018 82 00 00 00             56 	int 0x000000 ; int4
      00801C 82 00 00 00             57 	int 0x000000 ; int5
      008020 82 00 00 00             58 	int 0x000000 ; int6
      008024 82 00 00 00             59 	int 0x000000 ; int7
      008028 82 00 00 00             60 	int 0x000000 ; int8
      00802C 82 00 00 00             61 	int 0x000000 ; int9
      008030 82 00 00 00             62 	int 0x000000 ; int10
      008034 82 00 00 00             63 	int 0x000000 ; int11
      008038 82 00 00 00             64 	int 0x000000 ; int12
      00803C 82 00 00 00             65 	int 0x000000 ; int13
      008040 82 00 00 00             66 	int 0x000000 ; int14
      008044 82 00 00 00             67 	int 0x000000 ; int15
      008048 82 00 00 00             68 	int 0x000000 ; int16
      00804C 82 00 00 00             69 	int 0x000000 ; int17
      008050 82 00 00 00             70 	int 0x000000 ; int18
      008054 82 00 00 00             71 	int 0x000000 ; int19
      008058 82 00 00 00             72 	int 0x000000 ; int20
      00805C 82 00 00 00             73 	int 0x000000 ; int21
      008060 82 00 00 00             74 	int 0x000000 ; int22
      008064 82 00 80 91             75 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     76 ;--------------------------------------------------------
                                     77 ; global & static initialisations
                                     78 ;--------------------------------------------------------
                                     79 	.area HOME
                                     80 	.area GSINIT
                                     81 	.area GSFINAL
                                     82 	.area GSINIT
      00806B CD 81 1A         [ 4]   83 	call	___sdcc_external_startup
      00806E 4D               [ 1]   84 	tnz	a
      00806F 27 03            [ 1]   85 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   86 	jp	__sdcc_program_startup
      008074                         87 __sdcc_init_data:
                                     88 ; stm8_genXINIT() start
      008074 AE 00 04         [ 2]   89 	ldw x, #l_DATA
      008077 27 07            [ 1]   90 	jreq	00002$
      008079                         91 00001$:
      008079 72 4F 00 00      [ 1]   92 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   93 	decw x
      00807E 26 F9            [ 1]   94 	jrne	00001$
      008080                         95 00002$:
      008080 AE 00 00         [ 2]   96 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]   97 	jreq	00004$
      008085                         98 00003$:
      008085 D6 80 90         [ 1]   99 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 04         [ 1]  100 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  101 	decw	x
      00808C 26 F7            [ 1]  102 	jrne	00003$
      00808E                        103 00004$:
                                    104 ; stm8_genXINIT() end
                                    105 	.area GSFINAL
      00808E CC 80 68         [ 2]  106 	jp	__sdcc_program_startup
                                    107 ;--------------------------------------------------------
                                    108 ; Home
                                    109 ;--------------------------------------------------------
                                    110 	.area HOME
                                    111 	.area HOME
      008068                        112 __sdcc_program_startup:
      008068 CC 80 CC         [ 2]  113 	jp	_main
                                    114 ;	return from main will return to caller
                                    115 ;--------------------------------------------------------
                                    116 ; code
                                    117 ;--------------------------------------------------------
                                    118 	.area CODE
                                    119 ;	my_millis.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
                                    120 ;	-----------------------------------------
                                    121 ;	 function TIM4_UPD_OVF_IRQHandler
                                    122 ;	-----------------------------------------
      008091                        123 _TIM4_UPD_OVF_IRQHandler:
                                    124 ;	my_millis.c: 8: TIM4_SR = 0;
      008091 35 00 53 44      [ 1]  125 	mov	0x5344+0, #0x00
                                    126 ;	my_millis.c: 9: ms_counter++;
      008095 CE 00 03         [ 2]  127 	ldw	x, _ms_counter+2
      008098 90 CE 00 01      [ 2]  128 	ldw	y, _ms_counter+0
      00809C 5C               [ 1]  129 	incw	x
      00809D 26 02            [ 1]  130 	jrne	00103$
      00809F 90 5C            [ 1]  131 	incw	y
      0080A1                        132 00103$:
      0080A1 CF 00 03         [ 2]  133 	ldw	_ms_counter+2, x
      0080A4 90 CF 00 01      [ 2]  134 	ldw	_ms_counter+0, y
                                    135 ;	my_millis.c: 10: }
      0080A8 80               [11]  136 	iret
                                    137 ;	my_millis.c: 12: void tim4_init(void)
                                    138 ;	-----------------------------------------
                                    139 ;	 function tim4_init
                                    140 ;	-----------------------------------------
      0080A9                        141 _tim4_init:
                                    142 ;	my_millis.c: 14: TIM4_CR1 = 0;      // выключаем таймер
      0080A9 35 00 53 40      [ 1]  143 	mov	0x5340+0, #0x00
                                    144 ;	my_millis.c: 16: TIM4_PSCR = 0x07;  // prescaler = 128
      0080AD 35 07 53 47      [ 1]  145 	mov	0x5347+0, #0x07
                                    146 ;	my_millis.c: 17: TIM4_ARR  = 124;   // 1 мс
      0080B1 35 7C 53 48      [ 1]  147 	mov	0x5348+0, #0x7c
                                    148 ;	my_millis.c: 19: TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
      0080B5 72 10 53 43      [ 1]  149 	bset	0x5343, #0
                                    150 ;	my_millis.c: 20: TIM4_SR  = 0;      // сброс флагов
      0080B9 35 00 53 44      [ 1]  151 	mov	0x5344+0, #0x00
                                    152 ;	my_millis.c: 22: TIM4_CR1 |= 0x01;  // включаем таймер
      0080BD 72 10 53 40      [ 1]  153 	bset	0x5340, #0
                                    154 ;	my_millis.c: 23: }
      0080C1 81               [ 4]  155 	ret
                                    156 ;	my_millis.c: 25: uint32_t millis(void)
                                    157 ;	-----------------------------------------
                                    158 ;	 function millis
                                    159 ;	-----------------------------------------
      0080C2                        160 _millis:
                                    161 ;	my_millis.c: 29: disableInterrupts();
      0080C2 9B               [ 1]  162 	sim
                                    163 ;	my_millis.c: 30: t = ms_counter;
      0080C3 CE 00 03         [ 2]  164 	ldw	x, _ms_counter+2
      0080C6 90 CE 00 01      [ 2]  165 	ldw	y, _ms_counter+0
                                    166 ;	my_millis.c: 31: enableInterrupts();
      0080CA 9A               [ 1]  167 	rim
                                    168 ;	my_millis.c: 33: return t;
                                    169 ;	my_millis.c: 34: }
      0080CB 81               [ 4]  170 	ret
                                    171 ;	my_millis.c: 38: int main(void) // здесь какбы начинается setup()
                                    172 ;	-----------------------------------------
                                    173 ;	 function main
                                    174 ;	-----------------------------------------
      0080CC                        175 _main:
      0080CC 52 0C            [ 2]  176 	sub	sp, #12
                                    177 ;	my_millis.c: 40: PB_DDR |= LED_MASK;
      0080CE 72 1A 50 07      [ 1]  178 	bset	0x5007, #5
                                    179 ;	my_millis.c: 41: PB_CR1 |= LED_MASK;
      0080D2 72 1A 50 08      [ 1]  180 	bset	0x5008, #5
                                    181 ;	my_millis.c: 43: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
      0080D6 35 00 50 C6      [ 1]  182 	mov	0x50c6+0, #0x00
                                    183 ;	my_millis.c: 45: tim4_init();
      0080DA CD 80 A9         [ 4]  184 	call	_tim4_init
                                    185 ;	my_millis.c: 46: enableInterrupts();   // глобально разрешаем прерывания
      0080DD 9A               [ 1]  186 	rim
                                    187 ;	my_millis.c: 48: uint32_t timer1 = 0;
      0080DE 5F               [ 1]  188 	clrw	x
      0080DF 1F 03            [ 2]  189 	ldw	(0x03, sp), x
      0080E1 1F 01            [ 2]  190 	ldw	(0x01, sp), x
                                    191 ;	my_millis.c: 50: while(1) // здесь какбы заканчивается setup() и начинается loop()
      0080E3                        192 00104$:
                                    193 ;	my_millis.c: 52: if (millis() - timer1 >= 333)
      0080E3 CD 80 C2         [ 4]  194 	call	_millis
      0080E6 1F 07            [ 2]  195 	ldw	(0x07, sp), x
      0080E8 17 05            [ 2]  196 	ldw	(0x05, sp), y
      0080EA 1E 07            [ 2]  197 	ldw	x, (0x07, sp)
      0080EC 72 F0 03         [ 2]  198 	subw	x, (0x03, sp)
      0080EF 1F 0B            [ 2]  199 	ldw	(0x0b, sp), x
      0080F1 7B 06            [ 1]  200 	ld	a, (0x06, sp)
      0080F3 12 02            [ 1]  201 	sbc	a, (0x02, sp)
      0080F5 6B 0A            [ 1]  202 	ld	(0x0a, sp), a
      0080F7 7B 05            [ 1]  203 	ld	a, (0x05, sp)
      0080F9 12 01            [ 1]  204 	sbc	a, (0x01, sp)
      0080FB 88               [ 1]  205 	push	a
      0080FC 1E 0C            [ 2]  206 	ldw	x, (0x0c, sp)
      0080FE A3 01 4D         [ 2]  207 	cpw	x, #0x014d
      008101 7B 0B            [ 1]  208 	ld	a, (0x0b, sp)
      008103 A2 00            [ 1]  209 	sbc	a, #0x00
      008105 84               [ 1]  210 	pop	a
      008106 A2 00            [ 1]  211 	sbc	a, #0x00
      008108 25 D9            [ 1]  212 	jrc	00104$
                                    213 ;	my_millis.c: 54: timer1 = millis();
      00810A CD 80 C2         [ 4]  214 	call	_millis
      00810D 1F 03            [ 2]  215 	ldw	(0x03, sp), x
      00810F 17 01            [ 2]  216 	ldw	(0x01, sp), y
                                    217 ;	my_millis.c: 55: PB_ODR ^= LED_MASK;   // переключаем светодиод
      008111 90 1A 50 05      [ 1]  218 	bcpl	0x5005, #5
      008115 20 CC            [ 2]  219 	jra	00104$
                                    220 ;	my_millis.c: 58: }
      008117 5B 0C            [ 2]  221 	addw	sp, #12
      008119 81               [ 4]  222 	ret
                                    223 	.area CODE
                                    224 	.area CONST
                                    225 	.area INITIALIZER
                                    226 	.area CABS (ABS)
