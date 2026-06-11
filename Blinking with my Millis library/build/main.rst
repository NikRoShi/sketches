                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _TIM4_UPD_OVF_IRQHandler
                                     13 	.globl _get_ms
                                     14 	.globl _init_TIME
                                     15 	.globl _tick_TIME
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; Stack segment in internal ram
                                     26 ;--------------------------------------------------------
                                     27 	.area	SSEG
      000007                         28 __start__stack:
      000007                         29 	.ds	1
                                     30 
                                     31 ;--------------------------------------------------------
                                     32 ; absolute external ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DABS (ABS)
                                     35 
                                     36 ; default segment ordering for linker
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area CONST
                                     41 	.area INITIALIZER
                                     42 	.area CODE
                                     43 
                                     44 ;--------------------------------------------------------
                                     45 ; interrupt vector
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
      008000                         48 __interrupt_vect:
      008000 82 00 80 6B             49 	int s_GSINIT ; reset
      008004 82 00 00 00             50 	int 0x000000 ; trap
      008008 82 00 00 00             51 	int 0x000000 ; int0
      00800C 82 00 00 00             52 	int 0x000000 ; int1
      008010 82 00 00 00             53 	int 0x000000 ; int2
      008014 82 00 00 00             54 	int 0x000000 ; int3
      008018 82 00 00 00             55 	int 0x000000 ; int4
      00801C 82 00 00 00             56 	int 0x000000 ; int5
      008020 82 00 00 00             57 	int 0x000000 ; int6
      008024 82 00 00 00             58 	int 0x000000 ; int7
      008028 82 00 00 00             59 	int 0x000000 ; int8
      00802C 82 00 00 00             60 	int 0x000000 ; int9
      008030 82 00 00 00             61 	int 0x000000 ; int10
      008034 82 00 00 00             62 	int 0x000000 ; int11
      008038 82 00 00 00             63 	int 0x000000 ; int12
      00803C 82 00 00 00             64 	int 0x000000 ; int13
      008040 82 00 00 00             65 	int 0x000000 ; int14
      008044 82 00 00 00             66 	int 0x000000 ; int15
      008048 82 00 00 00             67 	int 0x000000 ; int16
      00804C 82 00 00 00             68 	int 0x000000 ; int17
      008050 82 00 00 00             69 	int 0x000000 ; int18
      008054 82 00 00 00             70 	int 0x000000 ; int19
      008058 82 00 00 00             71 	int 0x000000 ; int20
      00805C 82 00 00 00             72 	int 0x000000 ; int21
      008060 82 00 00 00             73 	int 0x000000 ; int22
      008064 82 00 80 8E             74 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     75 ;--------------------------------------------------------
                                     76 ; global & static initialisations
                                     77 ;--------------------------------------------------------
                                     78 	.area HOME
                                     79 	.area GSINIT
                                     80 	.area GSFINAL
                                     81 	.area GSINIT
      00806B                         82 __sdcc_init_data:
                                     83 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   84 	ldw x, #l_DATA
      00806E 27 07            [ 1]   85 	jreq	00002$
      008070                         86 00001$:
      008070 72 4F 00 00      [ 1]   87 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   88 	decw x
      008075 26 F9            [ 1]   89 	jrne	00001$
      008077                         90 00002$:
      008077 AE 00 06         [ 2]   91 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   92 	jreq	00004$
      00807C                         93 00003$:
      00807C D6 80 87         [ 1]   94 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]   95 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]   96 	decw	x
      008083 26 F7            [ 1]   97 	jrne	00003$
      008085                         98 00004$:
                                     99 ; stm8_genXINIT() end
                                    100 	.area GSFINAL
      008085 CC 80 68         [ 2]  101 	jp	__sdcc_program_startup
                                    102 ;--------------------------------------------------------
                                    103 ; Home
                                    104 ;--------------------------------------------------------
                                    105 	.area HOME
                                    106 	.area HOME
      008068                        107 __sdcc_program_startup:
      008068 CC 80 98         [ 2]  108 	jp	_main
                                    109 ;	return from main will return to caller
                                    110 ;--------------------------------------------------------
                                    111 ; code
                                    112 ;--------------------------------------------------------
                                    113 	.area CODE
                                    114 ;	main.c: 5: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    115 ;	-----------------------------------------
                                    116 ;	 function TIM4_UPD_OVF_IRQHandler
                                    117 ;	-----------------------------------------
      00808E                        118 _TIM4_UPD_OVF_IRQHandler:
      00808E 4F               [ 1]  119 	clr	a
      00808F 62               [ 2]  120 	div	x, a
                                    121 ;	main.c: 6: TIM4_SR &= ~(1 << 0);
      008090 72 11 53 44      [ 1]  122 	bres	0x5344, #0
                                    123 ;	main.c: 7: tick_TIME();
      008094 CD 83 E0         [ 4]  124 	call	_tick_TIME
                                    125 ;	main.c: 8: }
      008097 80               [11]  126 	iret
                                    127 ;	main.c: 10: int main(void)
                                    128 ;	-----------------------------------------
                                    129 ;	 function main
                                    130 ;	-----------------------------------------
      008098                        131 _main:
      008098 52 0F            [ 2]  132 	sub	sp, #15
                                    133 ;	main.c: 12: CLK_CKDIVR = 0;
      00809A 35 00 50 C6      [ 1]  134 	mov	0x50c6+0, #0x00
                                    135 ;	main.c: 14: PB_DDR |= (1 << 5);
      00809E 72 1A 50 07      [ 1]  136 	bset	0x5007, #5
                                    137 ;	main.c: 15: PB_CR1 |= (1 << 5);
      0080A2 C6 50 08         [ 1]  138 	ld	a, 0x5008
      0080A5 AA 20            [ 1]  139 	or	a, #0x20
      0080A7 C7 50 08         [ 1]  140 	ld	0x5008, a
                                    141 ;	main.c: 17: init_TIME();
      0080AA CD 83 F4         [ 4]  142 	call	_init_TIME
                                    143 ;	main.c: 18: enableInterrupts();
      0080AD 9A               [ 1]  144 	rim
                                    145 ;	main.c: 20: uint32_t timer0 = 0;
      0080AE 5F               [ 1]  146 	clrw	x
      0080AF 1F 03            [ 2]  147 	ldw	(0x03, sp), x
      0080B1 1F 01            [ 2]  148 	ldw	(0x01, sp), x
                                    149 ;	main.c: 21: int8_t step = 5;
      0080B3 A6 05            [ 1]  150 	ld	a, #0x05
      0080B5 6B 05            [ 1]  151 	ld	(0x05, sp), a
                                    152 ;	main.c: 22: uint16_t value = 0;
      0080B7 5F               [ 1]  153 	clrw	x
      0080B8 1F 06            [ 2]  154 	ldw	(0x06, sp), x
                                    155 ;	main.c: 24: while (1)
      0080BA                        156 00108$:
                                    157 ;	main.c: 26: value = value + step;
      0080BA 7B 05            [ 1]  158 	ld	a, (0x05, sp)
      0080BC 97               [ 1]  159 	ld	xl, a
      0080BD 49               [ 1]  160 	rlc	a
      0080BE 4F               [ 1]  161 	clr	a
      0080BF A2 00            [ 1]  162 	sbc	a, #0x00
      0080C1 16 06            [ 2]  163 	ldw	y, (0x06, sp)
      0080C3 17 0E            [ 2]  164 	ldw	(0x0e, sp), y
      0080C5 95               [ 1]  165 	ld	xh, a
      0080C6 72 FB 0E         [ 2]  166 	addw	x, (0x0e, sp)
                                    167 ;	main.c: 27: if (value > 950) step = -5;
      0080C9 1F 06            [ 2]  168 	ldw	(0x06, sp), x
      0080CB A3 03 B6         [ 2]  169 	cpw	x, #0x03b6
      0080CE 23 04            [ 2]  170 	jrule	00102$
      0080D0 A6 FB            [ 1]  171 	ld	a, #0xfb
      0080D2 6B 05            [ 1]  172 	ld	(0x05, sp), a
      0080D4                        173 00102$:
                                    174 ;	main.c: 28: if (value < 50) step = 5;
      0080D4 A3 00 32         [ 2]  175 	cpw	x, #0x0032
      0080D7 24 04            [ 1]  176 	jrnc	00104$
      0080D9 A6 05            [ 1]  177 	ld	a, #0x05
      0080DB 6B 05            [ 1]  178 	ld	(0x05, sp), a
      0080DD                        179 00104$:
                                    180 ;	main.c: 30: if (get_ms() - timer0 >= value) {
      0080DD CD 84 14         [ 4]  181 	call	_get_ms
      0080E0 90 9F            [ 1]  182 	ld	a, yl
      0080E2 72 F0 03         [ 2]  183 	subw	x, (0x03, sp)
      0080E5 12 02            [ 1]  184 	sbc	a, (0x02, sp)
      0080E7 6B 09            [ 1]  185 	ld	(0x09, sp), a
      0080E9 90 9E            [ 1]  186 	ld	a, yh
      0080EB 12 01            [ 1]  187 	sbc	a, (0x01, sp)
      0080ED 16 06            [ 2]  188 	ldw	y, (0x06, sp)
      0080EF 17 0E            [ 2]  189 	ldw	(0x0e, sp), y
      0080F1 0F 0D            [ 1]  190 	clr	(0x0d, sp)
      0080F3 0F 0C            [ 1]  191 	clr	(0x0c, sp)
      0080F5 88               [ 1]  192 	push	a
      0080F6 13 0F            [ 2]  193 	cpw	x, (0x0f, sp)
      0080F8 7B 0A            [ 1]  194 	ld	a, (0x0a, sp)
      0080FA 12 0E            [ 1]  195 	sbc	a, (0x0e, sp)
      0080FC 84               [ 1]  196 	pop	a
      0080FD 12 0C            [ 1]  197 	sbc	a, (0x0c, sp)
      0080FF 25 B9            [ 1]  198 	jrc	00108$
                                    199 ;	main.c: 31: timer0 = get_ms();
      008101 CD 84 14         [ 4]  200 	call	_get_ms
      008104 1F 03            [ 2]  201 	ldw	(0x03, sp), x
      008106 17 01            [ 2]  202 	ldw	(0x01, sp), y
                                    203 ;	main.c: 32: PB_ODR ^= (1 << 5);
      008108 90 1A 50 05      [ 1]  204 	bcpl	0x5005, #5
      00810C 20 AC            [ 2]  205 	jra	00108$
                                    206 ;	main.c: 35: }
      00810E 5B 0F            [ 2]  207 	addw	sp, #15
      008110 81               [ 4]  208 	ret
                                    209 	.area CODE
                                    210 	.area CONST
                                    211 	.area INITIALIZER
                                    212 	.area CABS (ABS)
