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
                                     13 	.globl _readReg_I2C
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
      008018 D6 80 41         [ 1]   72 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 59         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	main.c: 6: uint8_t BCDtoDEC(uint8_t bcd) 
                                     93 ;	-----------------------------------------
                                     94 ;	 function BCDtoDEC
                                     95 ;	-----------------------------------------
      008048                         96 _BCDtoDEC:
                                     97 ;	main.c: 8: return (((bcd >> 4) * 10) + (bcd & 0x0F));
      008048 97               [ 1]   98 	ld	xl, a
      008049 4E               [ 1]   99 	swap	a
      00804A A4 0F            [ 1]  100 	and	a, #0x0f
      00804C 41               [ 1]  101 	exg	a, xl
      00804D 88               [ 1]  102 	push	a
      00804E A6 0A            [ 1]  103 	ld	a, #0x0a
      008050 42               [ 4]  104 	mul	x, a
      008051 84               [ 1]  105 	pop	a
      008052 A4 0F            [ 1]  106 	and	a, #0x0f
      008054 89               [ 2]  107 	pushw	x
      008055 1B 02            [ 1]  108 	add	a, (2, sp)
      008057 85               [ 2]  109 	popw	x
                                    110 ;	main.c: 9: }
      008058 81               [ 4]  111 	ret
                                    112 ;	main.c: 11: int main(void)
                                    113 ;	-----------------------------------------
                                    114 ;	 function main
                                    115 ;	-----------------------------------------
      008059                        116 _main:
      008059 88               [ 1]  117 	push	a
                                    118 ;	main.c: 13: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00805A 35 00 50 C6      [ 1]  119 	mov	0x50c6+0, #0x00
                                    120 ;	main.c: 15: init_I2C();
      00805E CD 82 37         [ 4]  121 	call	_init_I2C
                                    122 ;	main.c: 16: init_UART(9600);
      008061 AE 25 80         [ 2]  123 	ldw	x, #0x2580
      008064 CD 85 BC         [ 4]  124 	call	_init_UART
                                    125 ;	main.c: 18: print_UART("start reading");
      008067 AE 80 24         [ 2]  126 	ldw	x, #(___str_0+0)
      00806A CD 86 06         [ 4]  127 	call	_print_UART
                                    128 ;	main.c: 19: line_UART();
      00806D CD 86 78         [ 4]  129 	call	_line_UART
                                    130 ;	main.c: 23: while (1)
      008070                        131 00104$:
                                    132 ;	main.c: 25: if (readReg_I2C(0x68, 0x00, &data) == 0)
      008070 96               [ 1]  133 	ldw	x, sp
      008071 5C               [ 1]  134 	incw	x
      008072 89               [ 2]  135 	pushw	x
      008073 4B 00            [ 1]  136 	push	#0x00
      008075 A6 68            [ 1]  137 	ld	a, #0x68
      008077 CD 83 73         [ 4]  138 	call	_readReg_I2C
      00807A 4D               [ 1]  139 	tnz	a
      00807B 26 09            [ 1]  140 	jrne	00102$
                                    141 ;	main.c: 27: print_UART("fail");
      00807D AE 80 32         [ 2]  142 	ldw	x, #(___str_1+0)
      008080 CD 86 06         [ 4]  143 	call	_print_UART
                                    144 ;	main.c: 28: line_UART();
      008083 CD 86 78         [ 4]  145 	call	_line_UART
      008086                        146 00102$:
                                    147 ;	main.c: 30: print_UART("second is ");
      008086 AE 80 37         [ 2]  148 	ldw	x, #(___str_2+0)
      008089 CD 86 06         [ 4]  149 	call	_print_UART
                                    150 ;	main.c: 31: printInt_UART(BCDtoDEC(data));
      00808C 7B 01            [ 1]  151 	ld	a, (0x01, sp)
      00808E CD 80 48         [ 4]  152 	call	_BCDtoDEC
      008091 5F               [ 1]  153 	clrw	x
      008092 97               [ 1]  154 	ld	xl, a
      008093 CD 86 19         [ 4]  155 	call	_printInt_UART
                                    156 ;	main.c: 32: line_UART();
      008096 CD 86 78         [ 4]  157 	call	_line_UART
      008099 20 D5            [ 2]  158 	jra	00104$
                                    159 ;	main.c: 34: }
      00809B 84               [ 1]  160 	pop	a
      00809C 81               [ 4]  161 	ret
                                    162 	.area CODE
                                    163 	.area CONST
                                    164 	.area CONST
      008024                        165 ___str_0:
      008024 73 74 61 72 74 20 72   166 	.ascii "start reading"
             65 61 64 69 6E 67
      008031 00                     167 	.db 0x00
                                    168 	.area CODE
                                    169 	.area CONST
      008032                        170 ___str_1:
      008032 66 61 69 6C            171 	.ascii "fail"
      008036 00                     172 	.db 0x00
                                    173 	.area CODE
                                    174 	.area CONST
      008037                        175 ___str_2:
      008037 73 65 63 6F 6E 64 20   176 	.ascii "second is "
             69 73 20
      008041 00                     177 	.db 0x00
                                    178 	.area CODE
                                    179 	.area INITIALIZER
                                    180 	.area CABS (ABS)
