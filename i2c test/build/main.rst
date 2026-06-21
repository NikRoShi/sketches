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
                                     12 	.globl _BCDtoDEC
                                     13 	.globl _TIM4_UPD_OVF_IRQHandler
                                     14 	.globl _init_TIME
                                     15 	.globl _tick_TIME
                                     16 	.globl _line_UART
                                     17 	.globl _printInt_UART
                                     18 	.globl _print_UART
                                     19 	.globl _init_UART
                                     20 	.globl _readBuffer2_I2C
                                     21 	.globl _init_I2C
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DATA
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area INITIALIZED
                                     30 ;--------------------------------------------------------
                                     31 ; Stack segment in internal ram
                                     32 ;--------------------------------------------------------
                                     33 	.area	SSEG
      000007                         34 __start__stack:
      000007                         35 	.ds	1
                                     36 
                                     37 ;--------------------------------------------------------
                                     38 ; absolute external ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DABS (ABS)
                                     41 
                                     42 ; default segment ordering for linker
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area CONST
                                     47 	.area INITIALIZER
                                     48 	.area CODE
                                     49 
                                     50 ;--------------------------------------------------------
                                     51 ; interrupt vector
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
      008000                         54 __interrupt_vect:
      008000 82 00 80 6B             55 	int s_GSINIT ; reset
      008004 82 00 00 00             56 	int 0x000000 ; trap
      008008 82 00 00 00             57 	int 0x000000 ; int0
      00800C 82 00 00 00             58 	int 0x000000 ; int1
      008010 82 00 00 00             59 	int 0x000000 ; int2
      008014 82 00 00 00             60 	int 0x000000 ; int3
      008018 82 00 00 00             61 	int 0x000000 ; int4
      00801C 82 00 00 00             62 	int 0x000000 ; int5
      008020 82 00 00 00             63 	int 0x000000 ; int6
      008024 82 00 00 00             64 	int 0x000000 ; int7
      008028 82 00 00 00             65 	int 0x000000 ; int8
      00802C 82 00 00 00             66 	int 0x000000 ; int9
      008030 82 00 00 00             67 	int 0x000000 ; int10
      008034 82 00 00 00             68 	int 0x000000 ; int11
      008038 82 00 00 00             69 	int 0x000000 ; int12
      00803C 82 00 00 00             70 	int 0x000000 ; int13
      008040 82 00 00 00             71 	int 0x000000 ; int14
      008044 82 00 00 00             72 	int 0x000000 ; int15
      008048 82 00 00 00             73 	int 0x000000 ; int16
      00804C 82 00 00 00             74 	int 0x000000 ; int17
      008050 82 00 00 00             75 	int 0x000000 ; int18
      008054 82 00 00 00             76 	int 0x000000 ; int19
      008058 82 00 00 00             77 	int 0x000000 ; int20
      00805C 82 00 00 00             78 	int 0x000000 ; int21
      008060 82 00 00 00             79 	int 0x000000 ; int22
      008064 82 00 80 AA             80 	int _TIM4_UPD_OVF_IRQHandler ; int23
                                     81 ;--------------------------------------------------------
                                     82 ; global & static initialisations
                                     83 ;--------------------------------------------------------
                                     84 	.area HOME
                                     85 	.area GSINIT
                                     86 	.area GSFINAL
                                     87 	.area GSINIT
      00806B                         88 __sdcc_init_data:
                                     89 ; stm8_genXINIT() start
      00806B AE 00 00         [ 2]   90 	ldw x, #l_DATA
      00806E 27 07            [ 1]   91 	jreq	00002$
      008070                         92 00001$:
      008070 72 4F 00 00      [ 1]   93 	clr (s_DATA - 1, x)
      008074 5A               [ 2]   94 	decw x
      008075 26 F9            [ 1]   95 	jrne	00001$
      008077                         96 00002$:
      008077 AE 00 06         [ 2]   97 	ldw	x, #l_INITIALIZER
      00807A 27 09            [ 1]   98 	jreq	00004$
      00807C                         99 00003$:
      00807C D6 80 A3         [ 1]  100 	ld	a, (s_INITIALIZER - 1, x)
      00807F D7 00 00         [ 1]  101 	ld	(s_INITIALIZED - 1, x), a
      008082 5A               [ 2]  102 	decw	x
      008083 26 F7            [ 1]  103 	jrne	00003$
      008085                        104 00004$:
                                    105 ; stm8_genXINIT() end
                                    106 	.area GSFINAL
      008085 CC 80 68         [ 2]  107 	jp	__sdcc_program_startup
                                    108 ;--------------------------------------------------------
                                    109 ; Home
                                    110 ;--------------------------------------------------------
                                    111 	.area HOME
                                    112 	.area HOME
      008068                        113 __sdcc_program_startup:
      008068 CC 80 C5         [ 2]  114 	jp	_main
                                    115 ;	return from main will return to caller
                                    116 ;--------------------------------------------------------
                                    117 ; code
                                    118 ;--------------------------------------------------------
                                    119 	.area CODE
                                    120 ;	main.c: 7: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    121 ;	-----------------------------------------
                                    122 ;	 function TIM4_UPD_OVF_IRQHandler
                                    123 ;	-----------------------------------------
      0080AA                        124 _TIM4_UPD_OVF_IRQHandler:
      0080AA 4F               [ 1]  125 	clr	a
      0080AB 62               [ 2]  126 	div	x, a
                                    127 ;	main.c: 8: TIM4_SR &= ~(1 << 0);
      0080AC 72 11 53 44      [ 1]  128 	bres	0x5344, #0
                                    129 ;	main.c: 9: tick_TIME();
      0080B0 CD 86 29         [ 4]  130 	call	_tick_TIME
                                    131 ;	main.c: 10: }
      0080B3 80               [11]  132 	iret
                                    133 ;	main.c: 12: uint8_t BCDtoDEC(uint8_t bcd) 
                                    134 ;	-----------------------------------------
                                    135 ;	 function BCDtoDEC
                                    136 ;	-----------------------------------------
      0080B4                        137 _BCDtoDEC:
                                    138 ;	main.c: 14: return (((bcd >> 4) * 10) + (bcd & 0x0F));
      0080B4 97               [ 1]  139 	ld	xl, a
      0080B5 4E               [ 1]  140 	swap	a
      0080B6 A4 0F            [ 1]  141 	and	a, #0x0f
      0080B8 41               [ 1]  142 	exg	a, xl
      0080B9 88               [ 1]  143 	push	a
      0080BA A6 0A            [ 1]  144 	ld	a, #0x0a
      0080BC 42               [ 4]  145 	mul	x, a
      0080BD 84               [ 1]  146 	pop	a
      0080BE A4 0F            [ 1]  147 	and	a, #0x0f
      0080C0 89               [ 2]  148 	pushw	x
      0080C1 1B 02            [ 1]  149 	add	a, (2, sp)
      0080C3 85               [ 2]  150 	popw	x
                                    151 ;	main.c: 15: }
      0080C4 81               [ 4]  152 	ret
                                    153 ;	main.c: 17: int main(void)
                                    154 ;	-----------------------------------------
                                    155 ;	 function main
                                    156 ;	-----------------------------------------
      0080C5                        157 _main:
      0080C5 52 02            [ 2]  158 	sub	sp, #2
                                    159 ;	main.c: 21: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      0080C7 35 00 50 C6      [ 1]  160 	mov	0x50c6+0, #0x00
                                    161 ;	main.c: 23: init_I2C();
      0080CB CD 82 B7         [ 4]  162 	call	_init_I2C
                                    163 ;	main.c: 24: init_TIME();
      0080CE CD 86 3D         [ 4]  164 	call	_init_TIME
                                    165 ;	main.c: 25: init_UART(9600);
      0080D1 AE 25 80         [ 2]  166 	ldw	x, #0x2580
      0080D4 CD 86 D9         [ 4]  167 	call	_init_UART
                                    168 ;	main.c: 27: while (1)
      0080D7                        169 00105$:
                                    170 ;	main.c: 29: if (readBuffer2_I2C(0x68, 0x00, buf) == 0)
      0080D7 96               [ 1]  171 	ldw	x, sp
      0080D8 5C               [ 1]  172 	incw	x
      0080D9 89               [ 2]  173 	pushw	x
      0080DA 4B 00            [ 1]  174 	push	#0x00
      0080DC A6 68            [ 1]  175 	ld	a, #0x68
      0080DE CD 84 84         [ 4]  176 	call	_readBuffer2_I2C
      0080E1 4D               [ 1]  177 	tnz	a
      0080E2 26 0B            [ 1]  178 	jrne	00102$
                                    179 ;	main.c: 31: print_UART("fail");
      0080E4 AE 80 88         [ 2]  180 	ldw	x, #(___str_0+0)
      0080E7 CD 87 23         [ 4]  181 	call	_print_UART
                                    182 ;	main.c: 32: line_UART();
      0080EA CD 87 95         [ 4]  183 	call	_line_UART
      0080ED 20 E8            [ 2]  184 	jra	00105$
      0080EF                        185 00102$:
                                    186 ;	main.c: 36: print_UART("second is ");
      0080EF AE 80 8D         [ 2]  187 	ldw	x, #(___str_1+0)
      0080F2 CD 87 23         [ 4]  188 	call	_print_UART
                                    189 ;	main.c: 37: printInt_UART(BCDtoDEC(buf[0]));
      0080F5 7B 01            [ 1]  190 	ld	a, (0x01, sp)
      0080F7 CD 80 B4         [ 4]  191 	call	_BCDtoDEC
      0080FA 5F               [ 1]  192 	clrw	x
      0080FB 97               [ 1]  193 	ld	xl, a
      0080FC CD 87 36         [ 4]  194 	call	_printInt_UART
                                    195 ;	main.c: 38: line_UART();
      0080FF CD 87 95         [ 4]  196 	call	_line_UART
                                    197 ;	main.c: 39: print_UART("minutes is ");
      008102 AE 80 98         [ 2]  198 	ldw	x, #(___str_2+0)
      008105 CD 87 23         [ 4]  199 	call	_print_UART
                                    200 ;	main.c: 40: printInt_UART(BCDtoDEC(buf[1]));
      008108 7B 02            [ 1]  201 	ld	a, (0x02, sp)
      00810A CD 80 B4         [ 4]  202 	call	_BCDtoDEC
      00810D 5F               [ 1]  203 	clrw	x
      00810E 97               [ 1]  204 	ld	xl, a
      00810F CD 87 36         [ 4]  205 	call	_printInt_UART
                                    206 ;	main.c: 41: line_UART();
      008112 CD 87 95         [ 4]  207 	call	_line_UART
                                    208 ;	main.c: 42: line_UART();
      008115 CD 87 95         [ 4]  209 	call	_line_UART
      008118 20 BD            [ 2]  210 	jra	00105$
                                    211 ;	main.c: 45: }
      00811A 5B 02            [ 2]  212 	addw	sp, #2
      00811C 81               [ 4]  213 	ret
                                    214 	.area CODE
                                    215 	.area CONST
                                    216 	.area CONST
      008088                        217 ___str_0:
      008088 66 61 69 6C            218 	.ascii "fail"
      00808C 00                     219 	.db 0x00
                                    220 	.area CODE
                                    221 	.area CONST
      00808D                        222 ___str_1:
      00808D 73 65 63 6F 6E 64 20   223 	.ascii "second is "
             69 73 20
      008097 00                     224 	.db 0x00
                                    225 	.area CODE
                                    226 	.area CONST
      008098                        227 ___str_2:
      008098 6D 69 6E 75 74 65 73   228 	.ascii "minutes is "
             20 69 73 20
      0080A3 00                     229 	.db 0x00
                                    230 	.area CODE
                                    231 	.area INITIALIZER
                                    232 	.area CABS (ABS)
