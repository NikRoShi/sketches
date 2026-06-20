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
                                     13 	.globl _printHex_UART
                                     14 	.globl _line_UART
                                     15 	.globl _printInt_UART
                                     16 	.globl _print_UART
                                     17 	.globl _write_UART
                                     18 	.globl _init_UART
                                     19 	.globl _delay
                                     20 	.globl _init_TIME
                                     21 	.globl _tick_TIME
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
      008064 82 00 80 9B             80 	int _TIM4_UPD_OVF_IRQHandler ; int23
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
      00807C D6 80 94         [ 1]  100 	ld	a, (s_INITIALIZER - 1, x)
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
      008068 CC 80 A5         [ 2]  114 	jp	_main
                                    115 ;	return from main will return to caller
                                    116 ;--------------------------------------------------------
                                    117 ; code
                                    118 ;--------------------------------------------------------
                                    119 	.area CODE
                                    120 ;	main.c: 6: void TIM4_UPD_OVF_IRQHandler(void) __interrupt(23) {
                                    121 ;	-----------------------------------------
                                    122 ;	 function TIM4_UPD_OVF_IRQHandler
                                    123 ;	-----------------------------------------
      00809B                        124 _TIM4_UPD_OVF_IRQHandler:
      00809B 4F               [ 1]  125 	clr	a
      00809C 62               [ 2]  126 	div	x, a
                                    127 ;	main.c: 7: TIM4_SR &= ~(1 << 0);
      00809D 72 11 53 44      [ 1]  128 	bres	0x5344, #0
                                    129 ;	main.c: 8: tick_TIME();
      0080A1 CD 85 10         [ 4]  130 	call	_tick_TIME
                                    131 ;	main.c: 9: }
      0080A4 80               [11]  132 	iret
                                    133 ;	main.c: 11: void main(void) {
                                    134 ;	-----------------------------------------
                                    135 ;	 function main
                                    136 ;	-----------------------------------------
      0080A5                        137 _main:
                                    138 ;	main.c: 13: CLK_CKDIVR = 0;		// 1. Устанавливаем частоту 16 МГц
      0080A5 35 00 50 C6      [ 1]  139 	mov	0x50c6+0, #0x00
                                    140 ;	main.c: 15: init_UART(9600);	// 2. Инициализируем периферию
      0080A9 AE 25 80         [ 2]  141 	ldw	x, #0x2580
      0080AC CD 85 C0         [ 4]  142 	call	_init_UART
                                    143 ;	main.c: 16: init_TIME();
      0080AF CD 85 24         [ 4]  144 	call	_init_TIME
                                    145 ;	main.c: 18: for (uint8_t i = 33; i < 127; i++)
      0080B2 A6 21            [ 1]  146 	ld	a, #0x21
      0080B4                        147 00106$:
      0080B4 A1 7F            [ 1]  148 	cp	a, #0x7f
      0080B6 24 08            [ 1]  149 	jrnc	00101$
                                    150 ;	main.c: 20: write_UART(i);	
      0080B8 88               [ 1]  151 	push	a
      0080B9 CD 85 F5         [ 4]  152 	call	_write_UART
      0080BC 84               [ 1]  153 	pop	a
                                    154 ;	main.c: 18: for (uint8_t i = 33; i < 127; i++)
      0080BD 4C               [ 1]  155 	inc	a
      0080BE 20 F4            [ 2]  156 	jra	00106$
      0080C0                        157 00101$:
                                    158 ;	main.c: 22: line_UART();
      0080C0 CD 86 80         [ 4]  159 	call	_line_UART
                                    160 ;	main.c: 23: delay(333);
      0080C3 4B 4D            [ 1]  161 	push	#0x4d
      0080C5 4B 01            [ 1]  162 	push	#0x01
      0080C7 5F               [ 1]  163 	clrw	x
      0080C8 89               [ 2]  164 	pushw	x
      0080C9 CD 85 8C         [ 4]  165 	call	_delay
                                    166 ;	main.c: 25: print_UART("Hello world!");
      0080CC AE 80 88         [ 2]  167 	ldw	x, #(___str_0+0)
      0080CF CD 86 0E         [ 4]  168 	call	_print_UART
                                    169 ;	main.c: 26: line_UART();
      0080D2 CD 86 80         [ 4]  170 	call	_line_UART
                                    171 ;	main.c: 27: delay(333);
      0080D5 4B 4D            [ 1]  172 	push	#0x4d
      0080D7 4B 01            [ 1]  173 	push	#0x01
      0080D9 5F               [ 1]  174 	clrw	x
      0080DA 89               [ 2]  175 	pushw	x
      0080DB CD 85 8C         [ 4]  176 	call	_delay
                                    177 ;	main.c: 29: printInt_UART(0);
      0080DE 5F               [ 1]  178 	clrw	x
      0080DF CD 86 21         [ 4]  179 	call	_printInt_UART
                                    180 ;	main.c: 30: line_UART();
      0080E2 CD 86 80         [ 4]  181 	call	_line_UART
                                    182 ;	main.c: 31: printInt_UART(12345);
      0080E5 AE 30 39         [ 2]  183 	ldw	x, #0x3039
      0080E8 CD 86 21         [ 4]  184 	call	_printInt_UART
                                    185 ;	main.c: 32: line_UART();
      0080EB CD 86 80         [ 4]  186 	call	_line_UART
                                    187 ;	main.c: 33: delay(333);
      0080EE 4B 4D            [ 1]  188 	push	#0x4d
      0080F0 4B 01            [ 1]  189 	push	#0x01
      0080F2 5F               [ 1]  190 	clrw	x
      0080F3 89               [ 2]  191 	pushw	x
      0080F4 CD 85 8C         [ 4]  192 	call	_delay
                                    193 ;	main.c: 35: printHex_UART(0xAB);
      0080F7 A6 AB            [ 1]  194 	ld	a, #0xab
      0080F9 CD 86 A4         [ 4]  195 	call	_printHex_UART
                                    196 ;	main.c: 36: line_UART();
      0080FC CD 86 80         [ 4]  197 	call	_line_UART
                                    198 ;	main.c: 38: while(1)
      0080FF                        199 00103$:
      0080FF 20 FE            [ 2]  200 	jra	00103$
                                    201 ;	main.c: 42: }
      008101 81               [ 4]  202 	ret
                                    203 	.area CODE
                                    204 	.area CONST
                                    205 	.area CONST
      008088                        206 ___str_0:
      008088 48 65 6C 6C 6F 20 77   207 	.ascii "Hello world!"
             6F 72 6C 64 21
      008094 00                     208 	.db 0x00
                                    209 	.area CODE
                                    210 	.area INITIALIZER
                                    211 	.area CABS (ABS)
