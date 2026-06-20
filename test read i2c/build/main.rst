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
                                     12 	.globl _printHex_UART
                                     13 	.globl _line_UART
                                     14 	.globl _print_UART
                                     15 	.globl _init_UART
                                     16 	.globl _readByte_I2C
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
      008018 D6 80 39         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 40         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 6: int main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008040                         95 _main:
      008040 88               [ 1]   96 	push	a
                                     97 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008041 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	main.c: 10: init_I2C();
      008045 CD 82 18         [ 4]  100 	call	_init_I2C
                                    101 ;	main.c: 11: init_UART(9600);
      008048 AE 25 80         [ 2]  102 	ldw	x, #0x2580
      00804B CD 85 3C         [ 4]  103 	call	_init_UART
                                    104 ;	main.c: 15: print_UART("start");
      00804E AE 80 24         [ 2]  105 	ldw	x, #(___str_0+0)
      008051 CD 85 86         [ 4]  106 	call	_print_UART
                                    107 ;	main.c: 16: line_UART();
      008054 CD 85 F8         [ 4]  108 	call	_line_UART
                                    109 ;	main.c: 18: while (1)
      008057                        110 00105$:
                                    111 ;	main.c: 20: if (readByte_I2C(0x68, &i2cData) == 1)
      008057 96               [ 1]  112 	ldw	x, sp
      008058 5C               [ 1]  113 	incw	x
      008059 A6 68            [ 1]  114 	ld	a, #0x68
      00805B CD 83 13         [ 4]  115 	call	_readByte_I2C
      00805E 4A               [ 1]  116 	dec	a
      00805F 26 10            [ 1]  117 	jrne	00102$
                                    118 ;	main.c: 22: print_UART("data is 0x");
      008061 AE 80 2A         [ 2]  119 	ldw	x, #(___str_1+0)
      008064 CD 85 86         [ 4]  120 	call	_print_UART
                                    121 ;	main.c: 23: printHex_UART(i2cData);
      008067 7B 01            [ 1]  122 	ld	a, (0x01, sp)
      008069 CD 86 1C         [ 4]  123 	call	_printHex_UART
                                    124 ;	main.c: 24: line_UART();
      00806C CD 85 F8         [ 4]  125 	call	_line_UART
      00806F 20 E6            [ 2]  126 	jra	00105$
      008071                        127 00102$:
                                    128 ;	main.c: 28: print_UART("fail");
      008071 AE 80 35         [ 2]  129 	ldw	x, #(___str_2+0)
      008074 CD 85 86         [ 4]  130 	call	_print_UART
                                    131 ;	main.c: 29: line_UART();
      008077 CD 85 F8         [ 4]  132 	call	_line_UART
      00807A 20 DB            [ 2]  133 	jra	00105$
                                    134 ;	main.c: 32: }
      00807C 84               [ 1]  135 	pop	a
      00807D 81               [ 4]  136 	ret
                                    137 	.area CODE
                                    138 	.area CONST
                                    139 	.area CONST
      008024                        140 ___str_0:
      008024 73 74 61 72 74         141 	.ascii "start"
      008029 00                     142 	.db 0x00
                                    143 	.area CODE
                                    144 	.area CONST
      00802A                        145 ___str_1:
      00802A 64 61 74 61 20 69 73   146 	.ascii "data is 0x"
             20 30 78
      008034 00                     147 	.db 0x00
                                    148 	.area CODE
                                    149 	.area CONST
      008035                        150 ___str_2:
      008035 66 61 69 6C            151 	.ascii "fail"
      008039 00                     152 	.db 0x00
                                    153 	.area CODE
                                    154 	.area INITIALIZER
                                    155 	.area CABS (ABS)
