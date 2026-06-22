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
                                     13 	.globl _readBuffer_I2C
                                     14 	.globl _init_I2C
                                     15 	.globl _line_UART
                                     16 	.globl _printInt_UART
                                     17 	.globl _print_UART
                                     18 	.globl _init_UART
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
      000007                         31 __start__stack:
      000007                         32 	.ds	1
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
      008000 82 00 80 07             52 	int s_GSINIT ; reset
                                     53 ;--------------------------------------------------------
                                     54 ; global & static initialisations
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
                                     57 	.area GSINIT
                                     58 	.area GSFINAL
                                     59 	.area GSINIT
      008007                         60 __sdcc_init_data:
                                     61 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   62 	ldw x, #l_DATA
      00800A 27 07            [ 1]   63 	jreq	00002$
      00800C                         64 00001$:
      00800C 72 4F 00 00      [ 1]   65 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   66 	decw x
      008011 26 F9            [ 1]   67 	jrne	00001$
      008013                         68 00002$:
      008013 AE 00 06         [ 2]   69 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   70 	jreq	00004$
      008018                         71 00003$:
      008018 D6 80 73         [ 1]   72 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   73 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   74 	decw	x
      00801F 26 F7            [ 1]   75 	jrne	00003$
      008021                         76 00004$:
                                     77 ; stm8_genXINIT() end
                                     78 	.area GSFINAL
      008021 CC 80 04         [ 2]   79 	jp	__sdcc_program_startup
                                     80 ;--------------------------------------------------------
                                     81 ; Home
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area HOME
      008004                         85 __sdcc_program_startup:
      008004 CC 80 8B         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	main.c: 6: uint8_t BCDtoDEC(uint8_t bcd) 
                                     93 ;	-----------------------------------------
                                     94 ;	 function BCDtoDEC
                                     95 ;	-----------------------------------------
      00807A                         96 _BCDtoDEC:
                                     97 ;	main.c: 8: return (((bcd >> 4) * 10) + (bcd & 0x0F));
      00807A 97               [ 1]   98 	ld	xl, a
      00807B 4E               [ 1]   99 	swap	a
      00807C A4 0F            [ 1]  100 	and	a, #0x0f
      00807E 41               [ 1]  101 	exg	a, xl
      00807F 88               [ 1]  102 	push	a
      008080 A6 0A            [ 1]  103 	ld	a, #0x0a
      008082 42               [ 4]  104 	mul	x, a
      008083 84               [ 1]  105 	pop	a
      008084 A4 0F            [ 1]  106 	and	a, #0x0f
      008086 89               [ 2]  107 	pushw	x
      008087 1B 02            [ 1]  108 	add	a, (2, sp)
      008089 85               [ 2]  109 	popw	x
                                    110 ;	main.c: 9: }
      00808A 81               [ 4]  111 	ret
                                    112 ;	main.c: 11: int main(void)
                                    113 ;	-----------------------------------------
                                    114 ;	 function main
                                    115 ;	-----------------------------------------
      00808B                        116 _main:
      00808B 52 07            [ 2]  117 	sub	sp, #7
                                    118 ;	main.c: 13: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00808D 35 00 50 C6      [ 1]  119 	mov	0x50c6+0, #0x00
                                    120 ;	main.c: 15: init_I2C();
      008091 CD 82 E1         [ 4]  121 	call	_init_I2C
                                    122 ;	main.c: 16: init_UART(9600);
      008094 AE 25 80         [ 2]  123 	ldw	x, #0x2580
      008097 CD 88 37         [ 4]  124 	call	_init_UART
                                    125 ;	main.c: 18: print_UART("start reading");
      00809A AE 80 24         [ 2]  126 	ldw	x, #(___str_0+0)
      00809D CD 88 81         [ 4]  127 	call	_print_UART
                                    128 ;	main.c: 19: line_UART();
      0080A0 CD 88 F3         [ 4]  129 	call	_line_UART
                                    130 ;	main.c: 23: while (1)
      0080A3                        131 00104$:
                                    132 ;	main.c: 25: if (readBuffer_I2C(0x68, 0x00, data, 7) == 0)
      0080A3 4B 07            [ 1]  133 	push	#0x07
      0080A5 96               [ 1]  134 	ldw	x, sp
      0080A6 5C               [ 1]  135 	incw	x
      0080A7 5C               [ 1]  136 	incw	x
      0080A8 89               [ 2]  137 	pushw	x
      0080A9 4B 00            [ 1]  138 	push	#0x00
      0080AB A6 68            [ 1]  139 	ld	a, #0x68
      0080AD CD 85 37         [ 4]  140 	call	_readBuffer_I2C
      0080B0 4D               [ 1]  141 	tnz	a
      0080B1 26 09            [ 1]  142 	jrne	00102$
                                    143 ;	main.c: 27: print_UART("fail");
      0080B3 AE 80 32         [ 2]  144 	ldw	x, #(___str_1+0)
      0080B6 CD 88 81         [ 4]  145 	call	_print_UART
                                    146 ;	main.c: 28: line_UART();
      0080B9 CD 88 F3         [ 4]  147 	call	_line_UART
      0080BC                        148 00102$:
                                    149 ;	main.c: 30: print_UART("sec is ");
      0080BC AE 80 37         [ 2]  150 	ldw	x, #(___str_2+0)
      0080BF CD 88 81         [ 4]  151 	call	_print_UART
                                    152 ;	main.c: 31: printInt_UART(BCDtoDEC(data[0]));
      0080C2 7B 01            [ 1]  153 	ld	a, (0x01, sp)
      0080C4 CD 80 7A         [ 4]  154 	call	_BCDtoDEC
      0080C7 5F               [ 1]  155 	clrw	x
      0080C8 97               [ 1]  156 	ld	xl, a
      0080C9 CD 88 94         [ 4]  157 	call	_printInt_UART
                                    158 ;	main.c: 32: line_UART();
      0080CC CD 88 F3         [ 4]  159 	call	_line_UART
                                    160 ;	main.c: 33: print_UART("min is ");
      0080CF AE 80 3F         [ 2]  161 	ldw	x, #(___str_3+0)
      0080D2 CD 88 81         [ 4]  162 	call	_print_UART
                                    163 ;	main.c: 34: printInt_UART(BCDtoDEC(data[1]));
      0080D5 7B 02            [ 1]  164 	ld	a, (0x02, sp)
      0080D7 CD 80 7A         [ 4]  165 	call	_BCDtoDEC
      0080DA 5F               [ 1]  166 	clrw	x
      0080DB 97               [ 1]  167 	ld	xl, a
      0080DC CD 88 94         [ 4]  168 	call	_printInt_UART
                                    169 ;	main.c: 35: line_UART();
      0080DF CD 88 F3         [ 4]  170 	call	_line_UART
                                    171 ;	main.c: 36: print_UART("hour is ");
      0080E2 AE 80 47         [ 2]  172 	ldw	x, #(___str_4+0)
      0080E5 CD 88 81         [ 4]  173 	call	_print_UART
                                    174 ;	main.c: 37: printInt_UART(BCDtoDEC(data[2]));
      0080E8 7B 03            [ 1]  175 	ld	a, (0x03, sp)
      0080EA CD 80 7A         [ 4]  176 	call	_BCDtoDEC
      0080ED 5F               [ 1]  177 	clrw	x
      0080EE 97               [ 1]  178 	ld	xl, a
      0080EF CD 88 94         [ 4]  179 	call	_printInt_UART
                                    180 ;	main.c: 38: line_UART();
      0080F2 CD 88 F3         [ 4]  181 	call	_line_UART
                                    182 ;	main.c: 39: print_UART("day is ");
      0080F5 AE 80 50         [ 2]  183 	ldw	x, #(___str_5+0)
      0080F8 CD 88 81         [ 4]  184 	call	_print_UART
                                    185 ;	main.c: 40: printInt_UART(BCDtoDEC(data[3]));
      0080FB 7B 04            [ 1]  186 	ld	a, (0x04, sp)
      0080FD CD 80 7A         [ 4]  187 	call	_BCDtoDEC
      008100 5F               [ 1]  188 	clrw	x
      008101 97               [ 1]  189 	ld	xl, a
      008102 CD 88 94         [ 4]  190 	call	_printInt_UART
                                    191 ;	main.c: 41: line_UART();
      008105 CD 88 F3         [ 4]  192 	call	_line_UART
                                    193 ;	main.c: 42: print_UART("date is ");
      008108 AE 80 58         [ 2]  194 	ldw	x, #(___str_6+0)
      00810B CD 88 81         [ 4]  195 	call	_print_UART
                                    196 ;	main.c: 43: printInt_UART(BCDtoDEC(data[4]));
      00810E 7B 05            [ 1]  197 	ld	a, (0x05, sp)
      008110 CD 80 7A         [ 4]  198 	call	_BCDtoDEC
      008113 5F               [ 1]  199 	clrw	x
      008114 97               [ 1]  200 	ld	xl, a
      008115 CD 88 94         [ 4]  201 	call	_printInt_UART
                                    202 ;	main.c: 44: line_UART();
      008118 CD 88 F3         [ 4]  203 	call	_line_UART
                                    204 ;	main.c: 45: print_UART("month is ");
      00811B AE 80 61         [ 2]  205 	ldw	x, #(___str_7+0)
      00811E CD 88 81         [ 4]  206 	call	_print_UART
                                    207 ;	main.c: 46: printInt_UART(BCDtoDEC(data[5]));
      008121 7B 06            [ 1]  208 	ld	a, (0x06, sp)
      008123 CD 80 7A         [ 4]  209 	call	_BCDtoDEC
      008126 5F               [ 1]  210 	clrw	x
      008127 97               [ 1]  211 	ld	xl, a
      008128 CD 88 94         [ 4]  212 	call	_printInt_UART
                                    213 ;	main.c: 47: line_UART();
      00812B CD 88 F3         [ 4]  214 	call	_line_UART
                                    215 ;	main.c: 48: print_UART("year is ");
      00812E AE 80 6B         [ 2]  216 	ldw	x, #(___str_8+0)
      008131 CD 88 81         [ 4]  217 	call	_print_UART
                                    218 ;	main.c: 49: printInt_UART(BCDtoDEC(data[6]));
      008134 7B 07            [ 1]  219 	ld	a, (0x07, sp)
      008136 CD 80 7A         [ 4]  220 	call	_BCDtoDEC
      008139 5F               [ 1]  221 	clrw	x
      00813A 97               [ 1]  222 	ld	xl, a
      00813B CD 88 94         [ 4]  223 	call	_printInt_UART
                                    224 ;	main.c: 50: line_UART();
      00813E CD 88 F3         [ 4]  225 	call	_line_UART
                                    226 ;	main.c: 51: line_UART();
      008141 CD 88 F3         [ 4]  227 	call	_line_UART
                                    228 ;	main.c: 53: }
      008144 CC 80 A3         [ 2]  229 	jp	00104$
                                    230 	.area CODE
                                    231 	.area CONST
                                    232 	.area CONST
      008024                        233 ___str_0:
      008024 73 74 61 72 74 20 72   234 	.ascii "start reading"
             65 61 64 69 6E 67
      008031 00                     235 	.db 0x00
                                    236 	.area CODE
                                    237 	.area CONST
      008032                        238 ___str_1:
      008032 66 61 69 6C            239 	.ascii "fail"
      008036 00                     240 	.db 0x00
                                    241 	.area CODE
                                    242 	.area CONST
      008037                        243 ___str_2:
      008037 73 65 63 20 69 73 20   244 	.ascii "sec is "
      00803E 00                     245 	.db 0x00
                                    246 	.area CODE
                                    247 	.area CONST
      00803F                        248 ___str_3:
      00803F 6D 69 6E 20 69 73 20   249 	.ascii "min is "
      008046 00                     250 	.db 0x00
                                    251 	.area CODE
                                    252 	.area CONST
      008047                        253 ___str_4:
      008047 68 6F 75 72 20 69 73   254 	.ascii "hour is "
             20
      00804F 00                     255 	.db 0x00
                                    256 	.area CODE
                                    257 	.area CONST
      008050                        258 ___str_5:
      008050 64 61 79 20 69 73 20   259 	.ascii "day is "
      008057 00                     260 	.db 0x00
                                    261 	.area CODE
                                    262 	.area CONST
      008058                        263 ___str_6:
      008058 64 61 74 65 20 69 73   264 	.ascii "date is "
             20
      008060 00                     265 	.db 0x00
                                    266 	.area CODE
                                    267 	.area CONST
      008061                        268 ___str_7:
      008061 6D 6F 6E 74 68 20 69   269 	.ascii "month is "
             73 20
      00806A 00                     270 	.db 0x00
                                    271 	.area CODE
                                    272 	.area CONST
      00806B                        273 ___str_8:
      00806B 79 65 61 72 20 69 73   274 	.ascii "year is "
             20
      008073 00                     275 	.db 0x00
                                    276 	.area CODE
                                    277 	.area INITIALIZER
                                    278 	.area CABS (ABS)
