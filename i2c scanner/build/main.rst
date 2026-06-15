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
                                     12 	.globl _sendHex_UART
                                     13 	.globl _sendLine_UART
                                     14 	.globl _sendString_UART
                                     15 	.globl _init_UART
                                     16 	.globl _ping_I2C
                                     17 	.globl _init_I2C
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
      008000 82 00 80 07             51 	int s_GSINIT ; reset
                                     52 ;--------------------------------------------------------
                                     53 ; global & static initialisations
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area GSINIT
      008007                         59 __sdcc_init_data:
                                     60 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   61 	ldw x, #l_DATA
      00800A 27 07            [ 1]   62 	jreq	00002$
      00800C                         63 00001$:
      00800C 72 4F 00 00      [ 1]   64 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   65 	decw x
      008011 26 F9            [ 1]   66 	jrne	00001$
      008013                         67 00002$:
      008013 AE 00 06         [ 2]   68 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   69 	jreq	00004$
      008018                         70 00003$:
      008018 D6 80 53         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   72 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   73 	decw	x
      00801F 26 F7            [ 1]   74 	jrne	00003$
      008021                         75 00004$:
                                     76 ; stm8_genXINIT() end
                                     77 	.area GSFINAL
      008021 CC 80 04         [ 2]   78 	jp	__sdcc_program_startup
                                     79 ;--------------------------------------------------------
                                     80 ; Home
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area HOME
      008004                         84 __sdcc_program_startup:
      008004 CC 80 5A         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 6: int main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      00805A                         95 _main:
      00805A 88               [ 1]   96 	push	a
                                     97 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      00805B 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	main.c: 10: init_UART(9600);
      00805F 4B 80            [ 1]  100 	push	#0x80
      008061 4B 25            [ 1]  101 	push	#0x25
      008063 5F               [ 1]  102 	clrw	x
      008064 89               [ 2]  103 	pushw	x
      008065 CD 85 06         [ 4]  104 	call	_init_UART
                                    105 ;	main.c: 11: init_I2C();
      008068 CD 82 3F         [ 4]  106 	call	_init_I2C
                                    107 ;	main.c: 13: sendString_UART("--Star scanning--");
      00806B AE 80 24         [ 2]  108 	ldw	x, #(___str_0+0)
      00806E CD 85 69         [ 4]  109 	call	_sendString_UART
                                    110 ;	main.c: 14: sendLine_UART();
      008071 CD 85 76         [ 4]  111 	call	_sendLine_UART
                                    112 ;	main.c: 15: for (uint8_t i = 1; i < 128; i++)
      008074 A6 01            [ 1]  113 	ld	a, #0x01
      008076 6B 01            [ 1]  114 	ld	(0x01, sp), a
      008078                        115 00108$:
      008078 7B 01            [ 1]  116 	ld	a, (0x01, sp)
      00807A A1 80            [ 1]  117 	cp	a, #0x80
      00807C 24 1A            [ 1]  118 	jrnc	00103$
                                    119 ;	main.c: 17: if (ping_I2C(i) == 1)
      00807E 7B 01            [ 1]  120 	ld	a, (0x01, sp)
      008080 CD 82 CB         [ 4]  121 	call	_ping_I2C
      008083 4A               [ 1]  122 	dec	a
      008084 26 0E            [ 1]  123 	jrne	00109$
                                    124 ;	main.c: 19: sendString_UART("devise in 0x");
      008086 AE 80 36         [ 2]  125 	ldw	x, #(___str_1+0)
      008089 CD 85 69         [ 4]  126 	call	_sendString_UART
                                    127 ;	main.c: 20: sendHex_UART(i);
      00808C 7B 01            [ 1]  128 	ld	a, (0x01, sp)
      00808E CD 85 F3         [ 4]  129 	call	_sendHex_UART
                                    130 ;	main.c: 21: sendLine_UART();
      008091 CD 85 76         [ 4]  131 	call	_sendLine_UART
      008094                        132 00109$:
                                    133 ;	main.c: 15: for (uint8_t i = 1; i < 128; i++)
      008094 0C 01            [ 1]  134 	inc	(0x01, sp)
      008096 20 E0            [ 2]  135 	jra	00108$
      008098                        136 00103$:
                                    137 ;	main.c: 24: sendString_UART("--end scanning--");
      008098 AE 80 43         [ 2]  138 	ldw	x, #(___str_2+0)
      00809B CD 85 69         [ 4]  139 	call	_sendString_UART
                                    140 ;	main.c: 25: sendLine_UART();
      00809E CD 85 76         [ 4]  141 	call	_sendLine_UART
                                    142 ;	main.c: 26: while (1)
      0080A1                        143 00105$:
      0080A1 20 FE            [ 2]  144 	jra	00105$
                                    145 ;	main.c: 30: }
      0080A3 84               [ 1]  146 	pop	a
      0080A4 81               [ 4]  147 	ret
                                    148 	.area CODE
                                    149 	.area CONST
                                    150 	.area CONST
      008024                        151 ___str_0:
      008024 2D 2D 53 74 61 72 20   152 	.ascii "--Star scanning--"
             73 63 61 6E 6E 69 6E
             67 2D 2D
      008035 00                     153 	.db 0x00
                                    154 	.area CODE
                                    155 	.area CONST
      008036                        156 ___str_1:
      008036 64 65 76 69 73 65 20   157 	.ascii "devise in 0x"
             69 6E 20 30 78
      008042 00                     158 	.db 0x00
                                    159 	.area CODE
                                    160 	.area CONST
      008043                        161 ___str_2:
      008043 2D 2D 65 6E 64 20 73   162 	.ascii "--end scanning--"
             63 61 6E 6E 69 6E 67
             2D 2D
      008053 00                     163 	.db 0x00
                                    164 	.area CODE
                                    165 	.area INITIALIZER
                                    166 	.area CABS (ABS)
