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
                                     13 	.globl _printNumber
                                     14 	.globl _refresh_display
                                     15 	.globl _init_display
                                     16 	.globl _clear_display
                                     17 	.globl _init_TIME
                                     18 	.globl _tick_TIME
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; Stack segment in internal ram
                                     29 ;--------------------------------------------------------
                                     30 	.area	SSEG
      000014                         31 __start__stack:
      000014                         32 	.ds	1
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
      008064 82 00 80 A2             77 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     78 ;--------------------------------------------------------
                                     79 ; global & static initialisations
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area GSINIT
                                     83 	.area GSFINAL
                                     84 	.area GSINIT
      00806B                         85 __sdcc_init_data:
                                     86 ; stm8_genXINIT() start
      00806B AE 00 0B         [ 2]   87 	ldw x, #l_DATA
      00806E 27 07            [ 1]   88 	jreq	00002$
      008070                         89 00001$:
      008070 72 4F 00 00      [ 1]   90 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   91 	decw x
      008075 26 F9            [ 1]   92 	jrne	00001$
      008077                         93 00002$:
      008077 AE 00 08         [ 2]   94 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   95 	jreq	00004$
      00807C                         96 00003$:
      00807C D6 80 99         [ 1]   97 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 0B         [ 1]   98 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]   99 	decw	x
      008083 26 F7            [ 1]  100 	jrne	00003$
      008085                        101 00004$:
                                    102 ; stm8_genXINIT() end
                                    103 	.area GSFINAL
      008085 CC 80 68         [ 2]  104 	jp	__sdcc_program_startup
                                    105 ;--------------------------------------------------------
                                    106 ; Home
                                    107 ;--------------------------------------------------------
                                    108 	.area HOME
                                    109 	.area HOME
      008068                        110 __sdcc_program_startup:
      008068 CC 80 AF         [ 2]  111 	jp	_main
                                    112 ;	return from main will return to caller
                                    113 ;--------------------------------------------------------
                                    114 ; code
                                    115 ;--------------------------------------------------------
                                    116 	.area CODE
                                    117 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
                                    118 ;	-----------------------------------------
                                    119 ;	 function TIM4_UPD_OVF_IRQHandler
                                    120 ;	-----------------------------------------
      0080A2                        121 _TIM4_UPD_OVF_IRQHandler:
      0080A2 4F               [ 1]  122 	clr	a
      0080A3 62               [ 2]  123 	div	x, a
                                    124 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      0080A4 72 11 53 44      [ 1]  125 	bres	0x5344, #0
                                    126 ;	main.c: 8: tick_TIME();
      0080A8 CD 88 F4         [ 4]  127 	call	_tick_TIME
                                    128 ;	main.c: 9: refresh_display();
      0080AB CD 81 61         [ 4]  129 	call	_refresh_display
                                    130 ;	main.c: 10: }
      0080AE 80               [11]  131 	iret
                                    132 ;	main.c: 12: void main(void)
                                    133 ;	-----------------------------------------
                                    134 ;	 function main
                                    135 ;	-----------------------------------------
      0080AF                        136 _main:
      0080AF 52 04            [ 2]  137 	sub	sp, #4
                                    138 ;	main.c: 14: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      0080B1 35 00 50 C6      [ 1]  139 	mov	0x50c6+0, #0x00
                                    140 ;	main.c: 16: init_display(PD, 3);
      0080B5 A6 03            [ 1]  141 	ld	a, #0x03
      0080B7 AE 50 0F         [ 2]  142 	ldw	x, #0x500f
      0080BA CD 81 0A         [ 4]  143 	call	_init_display
                                    144 ;	main.c: 17: init_TIME();
      0080BD CD 89 08         [ 4]  145 	call	_init_TIME
                                    146 ;	main.c: 18: enableInterrupts();
      0080C0 9A               [ 1]  147 	rim
                                    148 ;	main.c: 27: clear_display();
      0080C1 5F               [ 1]  149 	clrw	x
      0080C2 90 5F            [ 1]  150 	clrw	y
      0080C4 1F 03            [ 2]  151 	ldw	(0x03, sp), x
      0080C6 17 01            [ 2]  152 	ldw	(0x01, sp), y
      0080C8                        153 00106$:
                                    154 ;	main.c: 22: for (uint32_t a; a < 100000000; a++)
      0080C8 1E 03            [ 2]  155 	ldw	x, (0x03, sp)
      0080CA A3 E1 00         [ 2]  156 	cpw	x, #0xe100
      0080CD 7B 02            [ 1]  157 	ld	a, (0x02, sp)
      0080CF A2 F5            [ 1]  158 	sbc	a, #0xf5
      0080D1 7B 01            [ 1]  159 	ld	a, (0x01, sp)
      0080D3 A2 05            [ 1]  160 	sbc	a, #0x05
      0080D5 24 17            [ 1]  161 	jrnc	00101$
                                    162 ;	main.c: 24: printNumber(a);
      0080D7 1E 03            [ 2]  163 	ldw	x, (0x03, sp)
      0080D9 89               [ 2]  164 	pushw	x
      0080DA 1E 03            [ 2]  165 	ldw	x, (0x03, sp)
      0080DC 89               [ 2]  166 	pushw	x
      0080DD CD 81 9E         [ 4]  167 	call	_printNumber
                                    168 ;	main.c: 22: for (uint32_t a; a < 100000000; a++)
      0080E0 1E 03            [ 2]  169 	ldw	x, (0x03, sp)
      0080E2 5C               [ 1]  170 	incw	x
      0080E3 1F 03            [ 2]  171 	ldw	(0x03, sp), x
      0080E5 26 E1            [ 1]  172 	jrne	00106$
      0080E7 1E 01            [ 2]  173 	ldw	x, (0x01, sp)
      0080E9 5C               [ 1]  174 	incw	x
      0080EA 1F 01            [ 2]  175 	ldw	(0x01, sp), x
      0080EC 20 DA            [ 2]  176 	jra	00106$
      0080EE                        177 00101$:
                                    178 ;	main.c: 27: clear_display();
      0080EE CD 80 F6         [ 4]  179 	call	_clear_display
      0080F1 20 D5            [ 2]  180 	jra	00106$
                                    181 ;	main.c: 29: }
      0080F3 5B 04            [ 2]  182 	addw	sp, #4
      0080F5 81               [ 4]  183 	ret
                                    184 	.area CODE
                                    185 	.area CONST
                                    186 	.area INITIALIZER
                                    187 	.area CABS (ABS)
