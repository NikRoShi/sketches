                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.10 #15702 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _TIM4_UPD_OVF_IRQHandler
                                     12 	.globl _read_UART
                                     13 	.globl _available_UART
                                     14 	.globl _init_UART
                                     15 	.globl _tick_TIM4
                                     16 	.globl _init_TIM4
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram
                                     27 ;--------------------------------------------------------
                                     28 	.area SSEG
      000007                         29 __start__stack:
      000007                         30 	.ds	1
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
      008064 82 00 80 97             75 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     76 ;--------------------------------------------------------
                                     77 ; global & static initialisations
                                     78 ;--------------------------------------------------------
                                     79 	.area HOME
                                     80 	.area GSINIT
                                     81 	.area GSFINAL
                                     82 	.area GSINIT
      00806B CD 84 24         [ 4]   83 	call	___sdcc_external_startup
      00806E 4D               [ 1]   84 	tnz	a
      00806F 27 03            [ 1]   85 	jreq	__sdcc_init_data
      008071 CC 80 68         [ 2]   86 	jp	__sdcc_program_startup
      008074                         87 __sdcc_init_data:
                                     88 ; stm8_genXINIT() start
      008074 AE 00 00         [ 2]   89 	ldw x, #l_DATA
      008077 27 07            [ 1]   90 	jreq	00002$
      008079                         91 00001$:
      008079 72 4F 00 00      [ 1]   92 	clr (s_DATA - 1, x)
      00807D 5A               [ 2]   93 	decw x
      00807E 26 F9            [ 1]   94 	jrne	00001$
      008080                         95 00002$:
      008080 AE 00 06         [ 2]   96 	ldw	x, #l_INITIALIZER
      008083 27 09            [ 1]   97 	jreq	00004$
      008085                         98 00003$:
      008085 D6 80 90         [ 1]   99 	ld	a, (s_INITIALIZER - 1, x)
      008088 D7 00 00         [ 1]  100 	ld	(s_INITIALIZED - 1, x), a
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
      008068 CC 80 A1         [ 2]  113 	jp	_main
                                    114 ;	return from main will return to caller
                                    115 ;--------------------------------------------------------
                                    116 ; code
                                    117 ;--------------------------------------------------------
                                    118 	.area CODE
                                    119 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    120 ;	-----------------------------------------
                                    121 ;	 function TIM4_UPD_OVF_IRQHandler
                                    122 ;	-----------------------------------------
      008097                        123 _TIM4_UPD_OVF_IRQHandler:
      008097 4F               [ 1]  124 	clr	a
      008098 62               [ 2]  125 	div	x, a
                                    126 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      008099 72 11 53 44      [ 1]  127 	bres	0x5344, #0
                                    128 ;	main.c: 8: tick_TIM4();
      00809D CD 82 A2         [ 4]  129 	call	_tick_TIM4
                                    130 ;	main.c: 9: }
      0080A0 80               [11]  131 	iret
                                    132 ;	main.c: 11: void main(void) {
                                    133 ;	-----------------------------------------
                                    134 ;	 function main
                                    135 ;	-----------------------------------------
      0080A1                        136 _main:
                                    137 ;	main.c: 13: CLK_CKDIVR = 0x00;
      0080A1 35 00 50 C6      [ 1]  138 	mov	0x50c6+0, #0x00
                                    139 ;	main.c: 15: init_TIM4();
      0080A5 CD 82 B6         [ 4]  140 	call	_init_TIM4
                                    141 ;	main.c: 16: init_UART(9600);
      0080A8 4B 80            [ 1]  142 	push	#0x80
      0080AA 4B 25            [ 1]  143 	push	#0x25
      0080AC 5F               [ 1]  144 	clrw	x
      0080AD 89               [ 2]  145 	pushw	x
      0080AE CD 82 E0         [ 4]  146 	call	_init_UART
                                    147 ;	main.c: 18: enableInterrupts();
      0080B1 9A               [ 1]  148 	rim
                                    149 ;	main.c: 20: PD_DDR |= (1 << 2) | (1 << 3);
      0080B2 C6 50 11         [ 1]  150 	ld	a, 0x5011
      0080B5 AA 0C            [ 1]  151 	or	a, #0x0c
      0080B7 C7 50 11         [ 1]  152 	ld	0x5011, a
                                    153 ;	main.c: 21: PD_CR1 |= (1 << 2) | (1 << 3);
      0080BA C6 50 12         [ 1]  154 	ld	a, 0x5012
      0080BD AA 0C            [ 1]  155 	or	a, #0x0c
      0080BF C7 50 12         [ 1]  156 	ld	0x5012, a
                                    157 ;	main.c: 23: while(1) {
      0080C2                        158 00107$:
                                    159 ;	main.c: 24: if (available_UART() == 1) {
      0080C2 CD 83 BB         [ 4]  160 	call	_available_UART
      0080C5 4A               [ 1]  161 	dec	a
      0080C6 26 FA            [ 1]  162 	jrne	00107$
                                    163 ;	main.c: 25: switch (read_UART()) {
      0080C8 CD 83 C5         [ 4]  164 	call	_read_UART
      0080CB A1 31            [ 1]  165 	cp	a, #0x31
      0080CD 27 06            [ 1]  166 	jreq	00101$
      0080CF A1 32            [ 1]  167 	cp	a, #0x32
      0080D1 27 08            [ 1]  168 	jreq	00102$
      0080D3 20 ED            [ 2]  169 	jra	00107$
                                    170 ;	main.c: 26: case '1':
      0080D5                        171 00101$:
                                    172 ;	main.c: 27: PD_ODR ^= (1 << 3);
      0080D5 90 16 50 0F      [ 1]  173 	bcpl	0x500f, #3
                                    174 ;	main.c: 28: break;
      0080D9 20 E7            [ 2]  175 	jra	00107$
                                    176 ;	main.c: 29: case '2':
      0080DB                        177 00102$:
                                    178 ;	main.c: 30: PD_ODR ^= (1 << 2);
      0080DB 90 14 50 0F      [ 1]  179 	bcpl	0x500f, #2
                                    180 ;	main.c: 32: }
      0080DF 20 E1            [ 2]  181 	jra	00107$
                                    182 ;	main.c: 35: }
      0080E1 81               [ 4]  183 	ret
                                    184 	.area CODE
                                    185 	.area CONST
                                    186 	.area INITIALIZER
                                    187 	.area CABS (ABS)
