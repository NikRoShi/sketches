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
                                     13 	.globl _refresh_display
                                     14 	.globl _setDigit
                                     15 	.globl _init_display
                                     16 	.globl _clear_display
                                     17 	.globl _delay
                                     18 	.globl _init_TIME
                                     19 	.globl _tick_TIME
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
      000013                         32 __start__stack:
      000013                         33 	.ds	1
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
      008064 82 00 80 A1             78 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     79 ;--------------------------------------------------------
                                     80 ; global & static initialisations
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area GSINIT
                                     84 	.area GSFINAL
                                     85 	.area GSINIT
      00806B                         86 __sdcc_init_data:
                                     87 ; stm8_genXINIT() start
      00806B AE 00 0B         [ 2]   88 	ldw x, #l_DATA
      00806E 27 07            [ 1]   89 	jreq	00002$
      008070                         90 00001$:
      008070 72 4F 00 00      [ 1]   91 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   92 	decw x
      008075 26 F9            [ 1]   93 	jrne	00001$
      008077                         94 00002$:
      008077 AE 00 07         [ 2]   95 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   96 	jreq	00004$
      00807C                         97 00003$:
      00807C D6 80 99         [ 1]   98 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 0B         [ 1]   99 	ld	(s_INITIALIZED - 1, x), a
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
      008068 CC 80 AE         [ 2]  112 	jp	_main
                                    113 ;	return from main will return to caller
                                    114 ;--------------------------------------------------------
                                    115 ; code
                                    116 ;--------------------------------------------------------
                                    117 	.area CODE
                                    118 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(IRQ_TIM4) {
                                    119 ;	-----------------------------------------
                                    120 ;	 function TIM4_UPD_OVF_IRQHandler
                                    121 ;	-----------------------------------------
      0080A1                        122 _TIM4_UPD_OVF_IRQHandler:
      0080A1 4F               [ 1]  123 	clr	a
      0080A2 62               [ 2]  124 	div	x, a
                                    125 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      0080A3 72 11 53 44      [ 1]  126 	bres	0x5344, #0
                                    127 ;	main.c: 8: tick_TIME();
      0080A7 CD 88 AA         [ 4]  128 	call	_tick_TIME
                                    129 ;	main.c: 9: refresh_display();
      0080AA CD 81 5C         [ 4]  130 	call	_refresh_display
                                    131 ;	main.c: 10: }
      0080AD 80               [11]  132 	iret
                                    133 ;	main.c: 12: void main(void)
                                    134 ;	-----------------------------------------
                                    135 ;	 function main
                                    136 ;	-----------------------------------------
      0080AE                        137 _main:
      0080AE 52 02            [ 2]  138 	sub	sp, #2
                                    139 ;	main.c: 14: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      0080B0 35 00 50 C6      [ 1]  140 	mov	0x50c6+0, #0x00
                                    141 ;	main.c: 16: init_display(PD, 3);
      0080B4 A6 03            [ 1]  142 	ld	a, #0x03
      0080B6 AE 50 0F         [ 2]  143 	ldw	x, #0x500f
      0080B9 CD 81 05         [ 4]  144 	call	_init_display
                                    145 ;	main.c: 17: init_TIME();
      0080BC CD 88 BE         [ 4]  146 	call	_init_TIME
                                    147 ;	main.c: 18: enableInterrupts();
      0080BF 9A               [ 1]  148 	rim
                                    149 ;	main.c: 22: for (uint8_t position = 0; position < 8; position++)
      0080C0                        150 00117$:
      0080C0 0F 01            [ 1]  151 	clr	(0x01, sp)
      0080C2                        152 00110$:
      0080C2 7B 01            [ 1]  153 	ld	a, (0x01, sp)
      0080C4 A1 08            [ 1]  154 	cp	a, #0x08
      0080C6 24 21            [ 1]  155 	jrnc	00102$
                                    156 ;	main.c: 24: for (uint8_t digit = 0; digit < 10; digit++)
      0080C8 0F 02            [ 1]  157 	clr	(0x02, sp)
      0080CA                        158 00107$:
      0080CA 7B 02            [ 1]  159 	ld	a, (0x02, sp)
      0080CC A1 0A            [ 1]  160 	cp	a, #0x0a
      0080CE 24 15            [ 1]  161 	jrnc	00111$
                                    162 ;	main.c: 26: setDigit(position, digit);
      0080D0 7B 02            [ 1]  163 	ld	a, (0x02, sp)
      0080D2 88               [ 1]  164 	push	a
      0080D3 7B 02            [ 1]  165 	ld	a, (0x02, sp)
      0080D5 CD 81 3B         [ 4]  166 	call	_setDigit
                                    167 ;	main.c: 27: delay(200);
      0080D8 4B C8            [ 1]  168 	push	#0xc8
      0080DA 5F               [ 1]  169 	clrw	x
      0080DB 89               [ 2]  170 	pushw	x
      0080DC 4B 00            [ 1]  171 	push	#0x00
      0080DE CD 89 26         [ 4]  172 	call	_delay
                                    173 ;	main.c: 24: for (uint8_t digit = 0; digit < 10; digit++)
      0080E1 0C 02            [ 1]  174 	inc	(0x02, sp)
      0080E3 20 E5            [ 2]  175 	jra	00107$
      0080E5                        176 00111$:
                                    177 ;	main.c: 22: for (uint8_t position = 0; position < 8; position++)
      0080E5 0C 01            [ 1]  178 	inc	(0x01, sp)
      0080E7 20 D9            [ 2]  179 	jra	00110$
      0080E9                        180 00102$:
                                    181 ;	main.c: 30: clear_display();
      0080E9 CD 80 F1         [ 4]  182 	call	_clear_display
      0080EC 20 D2            [ 2]  183 	jra	00117$
                                    184 ;	main.c: 32: }
      0080EE 5B 02            [ 2]  185 	addw	sp, #2
      0080F0 81               [ 4]  186 	ret
                                    187 	.area CODE
                                    188 	.area CONST
                                    189 	.area INITIALIZER
                                    190 	.area CABS (ABS)
