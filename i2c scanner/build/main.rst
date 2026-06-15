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
      008065 CD 85 0C         [ 4]  104 	call	_init_UART
                                    105 ;	main.c: 11: init_I2C();
      008068 CD 82 45         [ 4]  106 	call	_init_I2C
                                    107 ;	main.c: 13: sendLine_UART();
      00806B CD 85 7C         [ 4]  108 	call	_sendLine_UART
                                    109 ;	main.c: 14: sendLine_UART();
      00806E CD 85 7C         [ 4]  110 	call	_sendLine_UART
                                    111 ;	main.c: 15: sendString_UART("--Star scanning--");
      008071 AE 80 24         [ 2]  112 	ldw	x, #(___str_0+0)
      008074 CD 85 6F         [ 4]  113 	call	_sendString_UART
                                    114 ;	main.c: 16: sendLine_UART();
      008077 CD 85 7C         [ 4]  115 	call	_sendLine_UART
                                    116 ;	main.c: 17: for (uint8_t i = 1; i < 128; i++)
      00807A A6 01            [ 1]  117 	ld	a, #0x01
      00807C 6B 01            [ 1]  118 	ld	(0x01, sp), a
      00807E                        119 00108$:
      00807E 7B 01            [ 1]  120 	ld	a, (0x01, sp)
      008080 A1 80            [ 1]  121 	cp	a, #0x80
      008082 24 1A            [ 1]  122 	jrnc	00103$
                                    123 ;	main.c: 19: if (ping_I2C(i) == 1)
      008084 7B 01            [ 1]  124 	ld	a, (0x01, sp)
      008086 CD 82 D1         [ 4]  125 	call	_ping_I2C
      008089 4A               [ 1]  126 	dec	a
      00808A 26 0E            [ 1]  127 	jrne	00109$
                                    128 ;	main.c: 21: sendString_UART("devise in 0x");
      00808C AE 80 36         [ 2]  129 	ldw	x, #(___str_1+0)
      00808F CD 85 6F         [ 4]  130 	call	_sendString_UART
                                    131 ;	main.c: 22: sendHex_UART(i);
      008092 7B 01            [ 1]  132 	ld	a, (0x01, sp)
      008094 CD 85 F9         [ 4]  133 	call	_sendHex_UART
                                    134 ;	main.c: 23: sendLine_UART();
      008097 CD 85 7C         [ 4]  135 	call	_sendLine_UART
      00809A                        136 00109$:
                                    137 ;	main.c: 17: for (uint8_t i = 1; i < 128; i++)
      00809A 0C 01            [ 1]  138 	inc	(0x01, sp)
      00809C 20 E0            [ 2]  139 	jra	00108$
      00809E                        140 00103$:
                                    141 ;	main.c: 26: sendString_UART("--end scanning--");
      00809E AE 80 43         [ 2]  142 	ldw	x, #(___str_2+0)
      0080A1 CD 85 6F         [ 4]  143 	call	_sendString_UART
                                    144 ;	main.c: 27: sendLine_UART();
      0080A4 CD 85 7C         [ 4]  145 	call	_sendLine_UART
                                    146 ;	main.c: 28: while (1)
      0080A7                        147 00105$:
      0080A7 20 FE            [ 2]  148 	jra	00105$
                                    149 ;	main.c: 32: }
      0080A9 84               [ 1]  150 	pop	a
      0080AA 81               [ 4]  151 	ret
                                    152 	.area CODE
                                    153 	.area CONST
                                    154 	.area CONST
      008024                        155 ___str_0:
      008024 2D 2D 53 74 61 72 20   156 	.ascii "--Star scanning--"
             73 63 61 6E 6E 69 6E
             67 2D 2D
      008035 00                     157 	.db 0x00
                                    158 	.area CODE
                                    159 	.area CONST
      008036                        160 ___str_1:
      008036 64 65 76 69 73 65 20   161 	.ascii "devise in 0x"
             69 6E 20 30 78
      008042 00                     162 	.db 0x00
                                    163 	.area CODE
                                    164 	.area CONST
      008043                        165 ___str_2:
      008043 2D 2D 65 6E 64 20 73   166 	.ascii "--end scanning--"
             63 61 6E 6E 69 6E 67
             2D 2D
      008053 00                     167 	.db 0x00
                                    168 	.area CODE
                                    169 	.area INITIALIZER
                                    170 	.area CABS (ABS)
