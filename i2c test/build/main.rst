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
                                     13 	.globl _delay
                                     14 	.globl _init_TIME
                                     15 	.globl _tick_TIME
                                     16 	.globl _writeByte_I2C
                                     17 	.globl _writeAddr_I2C
                                     18 	.globl _start_I2C
                                     19 	.globl _init_I2C
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
                                     28 ;--------------------------------------------------------
                                     29 ; Stack segment in internal ram
                                     30 ;--------------------------------------------------------
                                     31 	.area	SSEG
      000007                         32 __start__stack:
      000007                         33 	.ds	1
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; absolute external ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area DABS (ABS)
                                     39 
                                     40 ; default segment ordering for linker
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area CONST
                                     45 	.area INITIALIZER
                                     46 	.area CODE
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; interrupt vector
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
      008000                         52 __interrupt_vect:
      008000 82 00 80 6B             53 	int s_GSINIT ; reset
      008004 82 00 00 00             54 	int 0x000000 ; trap
      008008 82 00 00 00             55 	int 0x000000 ; int0
      00800C 82 00 00 00             56 	int 0x000000 ; int1
      008010 82 00 00 00             57 	int 0x000000 ; int2
      008014 82 00 00 00             58 	int 0x000000 ; int3
      008018 82 00 00 00             59 	int 0x000000 ; int4
      00801C 82 00 00 00             60 	int 0x000000 ; int5
      008020 82 00 00 00             61 	int 0x000000 ; int6
      008024 82 00 00 00             62 	int 0x000000 ; int7
      008028 82 00 00 00             63 	int 0x000000 ; int8
      00802C 82 00 00 00             64 	int 0x000000 ; int9
      008030 82 00 00 00             65 	int 0x000000 ; int10
      008034 82 00 00 00             66 	int 0x000000 ; int11
      008038 82 00 00 00             67 	int 0x000000 ; int12
      00803C 82 00 00 00             68 	int 0x000000 ; int13
      008040 82 00 00 00             69 	int 0x000000 ; int14
      008044 82 00 00 00             70 	int 0x000000 ; int15
      008048 82 00 00 00             71 	int 0x000000 ; int16
      00804C 82 00 00 00             72 	int 0x000000 ; int17
      008050 82 00 00 00             73 	int 0x000000 ; int18
      008054 82 00 00 00             74 	int 0x000000 ; int19
      008058 82 00 00 00             75 	int 0x000000 ; int20
      00805C 82 00 00 00             76 	int 0x000000 ; int21
      008060 82 00 00 00             77 	int 0x000000 ; int22
      008064 82 00 80 8E             78 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     79 ;--------------------------------------------------------
                                     80 ; global & static initialisations
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area GSINIT
                                     84 	.area GSFINAL
                                     85 	.area GSINIT
      00806B                         86 __sdcc_init_data:
                                     87 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   88 	ldw x, #l_DATA
      00806E 27 07            [ 1]   89 	jreq	00002$
      008070                         90 00001$:
      008070 72 4F 00 00      [ 1]   91 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   92 	decw x
      008075 26 F9            [ 1]   93 	jrne	00001$
      008077                         94 00002$:
      008077 AE 00 06         [ 2]   95 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   96 	jreq	00004$
      00807C                         97 00003$:
      00807C D6 80 87         [ 1]   98 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]   99 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]  100 	decw	x
      008083 26 F7            [ 1]  101 	jrne	00003$
      008085                        102 00004$:
                                    103 ; stm8_genXINIT() end
                                    104 	.area GSFINAL
      008085 CC 80 68         [ 2]  105 	jp	__sdcc_program_startup
                                    106 ;--------------------------------------------------------
                                    107 ; Home
                                    108 ;--------------------------------------------------------
                                    109 	.area HOME
                                    110 	.area HOME
      008068                        111 __sdcc_program_startup:
      008068 CC 80 98         [ 2]  112 	jp	_main
                                    113 ;	return from main will return to caller
                                    114 ;--------------------------------------------------------
                                    115 ; code
                                    116 ;--------------------------------------------------------
                                    117 	.area CODE
                                    118 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    119 ;	-----------------------------------------
                                    120 ;	 function TIM4_UPD_OVF_IRQHandler
                                    121 ;	-----------------------------------------
      00808E                        122 _TIM4_UPD_OVF_IRQHandler:
      00808E 4F               [ 1]  123 	clr	a
      00808F 62               [ 2]  124 	div	x, a
                                    125 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      008090 72 11 53 44      [ 1]  126 	bres	0x5344, #0
                                    127 ;	main.c: 8: tick_TIME();
      008094 CD 84 79         [ 4]  128 	call	_tick_TIME
                                    129 ;	main.c: 9: }
      008097 80               [11]  130 	iret
                                    131 ;	main.c: 11: int main(void)
                                    132 ;	-----------------------------------------
                                    133 ;	 function main
                                    134 ;	-----------------------------------------
      008098                        135 _main:
                                    136 ;	main.c: 13: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008098 35 00 50 C6      [ 1]  137 	mov	0x50c6+0, #0x00
                                    138 ;	main.c: 15: init_I2C();
      00809C CD 82 62         [ 4]  139 	call	_init_I2C
                                    140 ;	main.c: 16: init_TIME();
      00809F CD 84 8D         [ 4]  141 	call	_init_TIME
                                    142 ;	main.c: 18: start_I2C();
      0080A2 CD 82 80         [ 4]  143 	call	_start_I2C
                                    144 ;	main.c: 19: writeAddr_I2C(0x3F);
      0080A5 A6 3F            [ 1]  145 	ld	a, #0x3f
      0080A7 CD 82 98         [ 4]  146 	call	_writeAddr_I2C
                                    147 ;	main.c: 21: while (1)
      0080AA                        148 00102$:
                                    149 ;	main.c: 23: writeByte_I2C(0x08);
      0080AA A6 08            [ 1]  150 	ld	a, #0x08
      0080AC CD 82 C9         [ 4]  151 	call	_writeByte_I2C
                                    152 ;	main.c: 24: delay(1000);
      0080AF 4B E8            [ 1]  153 	push	#0xe8
      0080B1 4B 03            [ 1]  154 	push	#0x03
      0080B3 5F               [ 1]  155 	clrw	x
      0080B4 89               [ 2]  156 	pushw	x
      0080B5 CD 84 F5         [ 4]  157 	call	_delay
                                    158 ;	main.c: 25: writeByte_I2C(0x00);
      0080B8 4F               [ 1]  159 	clr	a
      0080B9 CD 82 C9         [ 4]  160 	call	_writeByte_I2C
                                    161 ;	main.c: 26: delay(1000);
      0080BC 4B E8            [ 1]  162 	push	#0xe8
      0080BE 4B 03            [ 1]  163 	push	#0x03
      0080C0 5F               [ 1]  164 	clrw	x
      0080C1 89               [ 2]  165 	pushw	x
      0080C2 CD 84 F5         [ 4]  166 	call	_delay
      0080C5 20 E3            [ 2]  167 	jra	00102$
                                    168 ;	main.c: 28: }
      0080C7 81               [ 4]  169 	ret
                                    170 	.area CODE
                                    171 	.area CONST
                                    172 	.area INITIALIZER
                                    173 	.area CABS (ABS)
