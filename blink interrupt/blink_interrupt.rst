                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module blink_interrupt
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _tim4_init
                                     12 	.globl _TIM4_UPD_OVF_IRQHandler
                                     13 	.globl _last_time
                                     14 	.globl _ms_counter
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
      000001                         23 _ms_counter::
      000001                         24 	.ds 2
      000003                         25 _last_time::
      000003                         26 	.ds 2
                                     27 ;--------------------------------------------------------
                                     28 ; Stack segment in internal ram
                                     29 ;--------------------------------------------------------
                                     30 	.area SSEG
      000005                         31 __start__stack:
      000005                         32 	.ds	1
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; absolute external ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area DABS (ABS)
                                     38 
                                     39 ; default segment ordering for linker
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area CONST
                                     44 	.area INITIALIZER
                                     45 	.area CODE
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; interrupt vector
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
      008000                         51 __interrupt_vect:
      008000 82 00 80 6B             52 	int s_GSINIT ; reset
      008004 82 00 00 00             53 	int 0x000000 ; trap
      008008 82 00 00 00             54 	int 0x000000 ; int0
      00800C 82 00 00 00             55 	int 0x000000 ; int1
      008010 82 00 00 00             56 	int 0x000000 ; int2
      008014 82 00 00 00             57 	int 0x000000 ; int3
      008018 82 00 00 00             58 	int 0x000000 ; int4
      00801C 82 00 00 00             59 	int 0x000000 ; int5
      008020 82 00 00 00             60 	int 0x000000 ; int6
      008024 82 00 00 00             61 	int 0x000000 ; int7
      008028 82 00 00 00             62 	int 0x000000 ; int8
      00802C 82 00 00 00             63 	int 0x000000 ; int9
      008030 82 00 00 00             64 	int 0x000000 ; int10
      008034 82 00 00 00             65 	int 0x000000 ; int11
      008038 82 00 00 00             66 	int 0x000000 ; int12
      00803C 82 00 00 00             67 	int 0x000000 ; int13
      008040 82 00 00 00             68 	int 0x000000 ; int14
      008044 82 00 00 00             69 	int 0x000000 ; int15
      008048 82 00 00 00             70 	int 0x000000 ; int16
      00804C 82 00 00 00             71 	int 0x000000 ; int17
      008050 82 00 00 00             72 	int 0x000000 ; int18
      008054 82 00 00 00             73 	int 0x000000 ; int19
      008058 82 00 00 00             74 	int 0x000000 ; int20
      00805C 82 00 00 00             75 	int 0x000000 ; int21
      008060 82 00 00 00             76 	int 0x000000 ; int22
      008064 82 00 80 95             77 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     78 ;--------------------------------------------------------
                                     79 ; global & static initialisations
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area GSINIT
                                     83 	.area GSFINAL
                                     84 	.area GSINIT
      00806B CD 80 E3         [ 4]   85 	call	___sdcc_external_startup
      00806E 4D               [ 1]   86 	tnz	a
      00806F 27 03            [ 1]   87 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   88 	jp	__sdcc_program_startup
      008074                         89 __sdcc_init_data:
                                     90 ; stm8_genXINIT() start
      008074 AE 00 00         [ 2]   91 	ldw x, #l_DATA
      008077 27 07            [ 1]   92 	jreq	00002$
      008079                         93 00001$:
      008079 72 4F 00 00      [ 1]   94 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   95 	decw x
      00807E 26 F9            [ 1]   96 	jrne	00001$
      008080                         97 00002$:
      008080 AE 00 04         [ 2]   98 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]   99 	jreq	00004$
      008085                        100 00003$:
      008085 D6 80 90         [ 1]  101 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 00         [ 1]  102 	ld	(s_INITIALIZED - 1, x), a
      00808B 5A               [ 2]  103 	decw	x
      00808C 26 F7            [ 1]  104 	jrne	00003$
      00808E                        105 00004$:
                                    106 ; stm8_genXINIT() end
                                    107 	.area GSFINAL
      00808E CC 80 68         [ 2]  108 	jp	__sdcc_program_startup
                                    109 ;--------------------------------------------------------
                                    110 ; Home
                                    111 ;--------------------------------------------------------
                                    112 	.area HOME
                                    113 	.area HOME
      008068                        114 __sdcc_program_startup:
      008068 CC 80 BA         [ 2]  115 	jp	_main
                                    116 ;	return from main will return to caller
                                    117 ;--------------------------------------------------------
                                    118 ; code
                                    119 ;--------------------------------------------------------
                                    120 	.area CODE
                                    121 ;	blink_interrupt.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23)
                                    122 ;	-----------------------------------------
                                    123 ;	 function TIM4_UPD_OVF_IRQHandler
                                    124 ;	-----------------------------------------
      008095                        125 _TIM4_UPD_OVF_IRQHandler:
                                    126 ;	blink_interrupt.c: 9: TIM4_SR = 0;
      008095 35 00 53 44      [ 1]  127 	mov	0x5344+0, #0x00
                                    128 ;	blink_interrupt.c: 10: ms_counter++;
      008099 CE 00 01         [ 2]  129 	ldw	x, _ms_counter+0
      00809C 5C               [ 1]  130 	incw	x
      00809D CF 00 01         [ 2]  131 	ldw	_ms_counter+0, x
                                    132 ;	blink_interrupt.c: 11: }
      0080A0 80               [11]  133 	iret
                                    134 ;	blink_interrupt.c: 13: void tim4_init(void)
                                    135 ;	-----------------------------------------
                                    136 ;	 function tim4_init
                                    137 ;	-----------------------------------------
      0080A1                        138 _tim4_init:
                                    139 ;	blink_interrupt.c: 15: TIM4_CR1 = 0;      // выключаем таймер
      0080A1 35 00 53 40      [ 1]  140 	mov	0x5340+0, #0x00
                                    141 ;	blink_interrupt.c: 17: TIM4_PSCR = 0x07;  // prescaler = 128
      0080A5 35 07 53 47      [ 1]  142 	mov	0x5347+0, #0x07
                                    143 ;	blink_interrupt.c: 18: TIM4_ARR  = 128;   // 1 мс
      0080A9 35 80 53 48      [ 1]  144 	mov	0x5348+0, #0x80
                                    145 ;	blink_interrupt.c: 20: TIM4_IER |= 0x01;  // разрешаем прерывание по переполнению
      0080AD 72 10 53 43      [ 1]  146 	bset	0x5343, #0
                                    147 ;	blink_interrupt.c: 21: TIM4_SR  = 0;      // сброс флагов
      0080B1 35 00 53 44      [ 1]  148 	mov	0x5344+0, #0x00
                                    149 ;	blink_interrupt.c: 23: TIM4_CR1 |= 0x01;  // включаем таймер
      0080B5 72 10 53 40      [ 1]  150 	bset	0x5340, #0
                                    151 ;	blink_interrupt.c: 24: }
      0080B9 81               [ 4]  152 	ret
                                    153 ;	blink_interrupt.c: 28: int main(void)
                                    154 ;	-----------------------------------------
                                    155 ;	 function main
                                    156 ;	-----------------------------------------
      0080BA                        157 _main:
                                    158 ;	blink_interrupt.c: 30: PB_DDR |= LED_MASK;
      0080BA 72 1A 50 07      [ 1]  159 	bset	0x5007, #5
                                    160 ;	blink_interrupt.c: 31: PB_CR1 |= LED_MASK;
      0080BE 72 1A 50 08      [ 1]  161 	bset	0x5008, #5
                                    162 ;	blink_interrupt.c: 33: CLK_CKDIVR = 0x00; // HSI / 1, CPU = 16 МГц
      0080C2 35 00 50 C6      [ 1]  163 	mov	0x50c6+0, #0x00
                                    164 ;	blink_interrupt.c: 35: tim4_init();
      0080C6 CD 80 A1         [ 4]  165 	call	_tim4_init
                                    166 ;	blink_interrupt.c: 36: enableInterrupts();   // глобально разрешаем прерывания
      0080C9 9A               [ 1]  167 	rim
                                    168 ;	blink_interrupt.c: 38: while (1)
      0080CA                        169 00104$:
                                    170 ;	blink_interrupt.c: 40: if ((uint16_t)(ms_counter - last_time) >= 1000)
      0080CA CE 00 01         [ 2]  171 	ldw	x, _ms_counter+0
      0080CD 72 B0 00 03      [ 2]  172 	subw	x, _last_time+0
      0080D1 A3 03 E8         [ 2]  173 	cpw	x, #0x03e8
      0080D4 25 F4            [ 1]  174 	jrc	00104$
                                    175 ;	blink_interrupt.c: 42: PB_ODR ^= LED_MASK;   // переключаем светодиод
      0080D6 90 1A 50 05      [ 1]  176 	bcpl	0x5005, #5
                                    177 ;	blink_interrupt.c: 43: last_time = ms_counter;
      0080DA CE 00 01         [ 2]  178 	ldw	x, _ms_counter+0
      0080DD CF 00 03         [ 2]  179 	ldw	_last_time+0, x
      0080E0 20 E8            [ 2]  180 	jra	00104$
                                    181 ;	blink_interrupt.c: 46: }
      0080E2 81               [ 4]  182 	ret
                                    183 	.area CODE
                                    184 	.area CONST
                                    185 	.area INITIALIZER
      008091                        186 __xinit__ms_counter:
      008091 00 00                  187 	.dw #0x0000
      008093                        188 __xinit__last_time:
      008093 00 00                  189 	.dw #0x0000
                                    190 	.area CABS (ABS)
