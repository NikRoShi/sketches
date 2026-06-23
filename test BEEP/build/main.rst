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
                                     13 	.globl _beep
                                     14 	.globl _init_BEEP
                                     15 	.globl _delay
                                     16 	.globl _init_TIME
                                     17 	.globl _tick_TIME
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; Stack segment in internal ram
                                     28 ;--------------------------------------------------------
                                     29 	.area	SSEG
      000007                         30 __start__stack:
      000007                         31 	.ds	1
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 
                                     38 ; default segment ordering for linker
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area CONST
                                     43 	.area INITIALIZER
                                     44 	.area CODE
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; interrupt vector
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
      008000                         50 __interrupt_vect:
      008000 82 00 80 6B             51 	int s_GSINIT ; reset
      008004 82 00 00 00             52 	int 0x000000 ; trap
      008008 82 00 00 00             53 	int 0x000000 ; int0
      00800C 82 00 00 00             54 	int 0x000000 ; int1
      008010 82 00 00 00             55 	int 0x000000 ; int2
      008014 82 00 00 00             56 	int 0x000000 ; int3
      008018 82 00 00 00             57 	int 0x000000 ; int4
      00801C 82 00 00 00             58 	int 0x000000 ; int5
      008020 82 00 00 00             59 	int 0x000000 ; int6
      008024 82 00 00 00             60 	int 0x000000 ; int7
      008028 82 00 00 00             61 	int 0x000000 ; int8
      00802C 82 00 00 00             62 	int 0x000000 ; int9
      008030 82 00 00 00             63 	int 0x000000 ; int10
      008034 82 00 00 00             64 	int 0x000000 ; int11
      008038 82 00 00 00             65 	int 0x000000 ; int12
      00803C 82 00 00 00             66 	int 0x000000 ; int13
      008040 82 00 00 00             67 	int 0x000000 ; int14
      008044 82 00 00 00             68 	int 0x000000 ; int15
      008048 82 00 00 00             69 	int 0x000000 ; int16
      00804C 82 00 00 00             70 	int 0x000000 ; int17
      008050 82 00 00 00             71 	int 0x000000 ; int18
      008054 82 00 00 00             72 	int 0x000000 ; int19
      008058 82 00 00 00             73 	int 0x000000 ; int20
      00805C 82 00 00 00             74 	int 0x000000 ; int21
      008060 82 00 00 00             75 	int 0x000000 ; int22
      008064 82 00 80 8E             76 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     77 ;--------------------------------------------------------
                                     78 ; global & static initialisations
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area GSINIT
                                     82 	.area GSFINAL
                                     83 	.area GSINIT
      00806B                         84 __sdcc_init_data:
                                     85 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   86 	ldw x, #l_DATA
      00806E 27 07            [ 1]   87 	jreq	00002$
      008070                         88 00001$:
      008070 72 4F 00 00      [ 1]   89 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   90 	decw x
      008075 26 F9            [ 1]   91 	jrne	00001$
      008077                         92 00002$:
      008077 AE 00 06         [ 2]   93 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   94 	jreq	00004$
      00807C                         95 00003$:
      00807C D6 80 87         [ 1]   96 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]   97 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]   98 	decw	x
      008083 26 F7            [ 1]   99 	jrne	00003$
      008085                        100 00004$:
                                    101 ; stm8_genXINIT() end
                                    102 	.area GSFINAL
      008085 CC 80 68         [ 2]  103 	jp	__sdcc_program_startup
                                    104 ;--------------------------------------------------------
                                    105 ; Home
                                    106 ;--------------------------------------------------------
                                    107 	.area HOME
                                    108 	.area HOME
      008068                        109 __sdcc_program_startup:
      008068 CC 80 98         [ 2]  110 	jp	_main
                                    111 ;	return from main will return to caller
                                    112 ;--------------------------------------------------------
                                    113 ; code
                                    114 ;--------------------------------------------------------
                                    115 	.area CODE
                                    116 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    117 ;	-----------------------------------------
                                    118 ;	 function TIM4_UPD_OVF_IRQHandler
                                    119 ;	-----------------------------------------
      00808E                        120 _TIM4_UPD_OVF_IRQHandler:
      00808E 4F               [ 1]  121 	clr	a
      00808F 62               [ 2]  122 	div	x, a
                                    123 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      008090 72 11 53 44      [ 1]  124 	bres	0x5344, #0
                                    125 ;	main.c: 8: tick_TIME();
      008094 CD 87 4D         [ 4]  126 	call	_tick_TIME
                                    127 ;	main.c: 9: }
      008097 80               [11]  128 	iret
                                    129 ;	main.c: 11: int main(void)
                                    130 ;	-----------------------------------------
                                    131 ;	 function main
                                    132 ;	-----------------------------------------
      008098                        133 _main:
                                    134 ;	main.c: 13: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008098 35 00 50 C6      [ 1]  135 	mov	0x50c6+0, #0x00
                                    136 ;	main.c: 15: init_TIME();
      00809C CD 87 61         [ 4]  137 	call	_init_TIME
                                    138 ;	main.c: 16: init_BEEP(BEEP_4KHZ);
      00809F A6 02            [ 1]  139 	ld	a, #0x02
      0080A1 CD 81 57         [ 4]  140 	call	_init_BEEP
                                    141 ;	main.c: 18: while (1)
      0080A4                        142 00102$:
                                    143 ;	main.c: 20: beep(HIGH);
      0080A4 A6 01            [ 1]  144 	ld	a, #0x01
      0080A6 CD 81 90         [ 4]  145 	call	_beep
                                    146 ;	main.c: 21: delay(100);
      0080A9 4B 64            [ 1]  147 	push	#0x64
      0080AB 5F               [ 1]  148 	clrw	x
      0080AC 89               [ 2]  149 	pushw	x
      0080AD 4B 00            [ 1]  150 	push	#0x00
      0080AF CD 87 C9         [ 4]  151 	call	_delay
                                    152 ;	main.c: 22: beep(LOW);
      0080B2 4F               [ 1]  153 	clr	a
      0080B3 CD 81 90         [ 4]  154 	call	_beep
                                    155 ;	main.c: 23: delay(100);
      0080B6 4B 64            [ 1]  156 	push	#0x64
      0080B8 5F               [ 1]  157 	clrw	x
      0080B9 89               [ 2]  158 	pushw	x
      0080BA 4B 00            [ 1]  159 	push	#0x00
      0080BC CD 87 C9         [ 4]  160 	call	_delay
      0080BF 20 E3            [ 2]  161 	jra	00102$
                                    162 ;	main.c: 25: }
      0080C1 81               [ 4]  163 	ret
                                    164 	.area CODE
                                    165 	.area CONST
                                    166 	.area INITIALIZER
                                    167 	.area CABS (ABS)
