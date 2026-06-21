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
                                     12 	.globl _readReg_I2C
                                     13 	.globl _init_I2C
                                     14 	.globl _line_UART
                                     15 	.globl _printInt_UART
                                     16 	.globl _print_UART
                                     17 	.globl _init_UART
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
      008018 D6 80 41         [ 1]   71 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 48         [ 2]   85 	jp	_main
                                     86 ;	return from main will return to caller
                                     87 ;--------------------------------------------------------
                                     88 ; code
                                     89 ;--------------------------------------------------------
                                     90 	.area CODE
                                     91 ;	main.c: 6: int main(void)
                                     92 ;	-----------------------------------------
                                     93 ;	 function main
                                     94 ;	-----------------------------------------
      008048                         95 _main:
      008048 88               [ 1]   96 	push	a
                                     97 ;	main.c: 8: CLK_CKDIVR = 0;	//частота тактирования мк 16 МГц
      008049 35 00 50 C6      [ 1]   98 	mov	0x50c6+0, #0x00
                                     99 ;	main.c: 10: init_I2C();
      00804D CD 82 23         [ 4]  100 	call	_init_I2C
                                    101 ;	main.c: 11: init_UART(9600);
      008050 AE 25 80         [ 2]  102 	ldw	x, #0x2580
      008053 CD 85 A8         [ 4]  103 	call	_init_UART
                                    104 ;	main.c: 13: print_UART("start reading");
      008056 AE 80 24         [ 2]  105 	ldw	x, #(___str_0+0)
      008059 CD 85 F2         [ 4]  106 	call	_print_UART
                                    107 ;	main.c: 14: line_UART();
      00805C CD 86 64         [ 4]  108 	call	_line_UART
                                    109 ;	main.c: 18: while (1)
      00805F                        110 00104$:
                                    111 ;	main.c: 20: if (readReg_I2C(0x68, 0x00, &data) == 0)
      00805F 96               [ 1]  112 	ldw	x, sp
      008060 5C               [ 1]  113 	incw	x
      008061 89               [ 2]  114 	pushw	x
      008062 4B 00            [ 1]  115 	push	#0x00
      008064 A6 68            [ 1]  116 	ld	a, #0x68
      008066 CD 83 5F         [ 4]  117 	call	_readReg_I2C
      008069 4D               [ 1]  118 	tnz	a
      00806A 26 09            [ 1]  119 	jrne	00102$
                                    120 ;	main.c: 22: print_UART("fail");
      00806C AE 80 32         [ 2]  121 	ldw	x, #(___str_1+0)
      00806F CD 85 F2         [ 4]  122 	call	_print_UART
                                    123 ;	main.c: 23: line_UART();
      008072 CD 86 64         [ 4]  124 	call	_line_UART
      008075                        125 00102$:
                                    126 ;	main.c: 25: print_UART("second is ");
      008075 AE 80 37         [ 2]  127 	ldw	x, #(___str_2+0)
      008078 CD 85 F2         [ 4]  128 	call	_print_UART
                                    129 ;	main.c: 26: printInt_UART(data);
      00807B 7B 01            [ 1]  130 	ld	a, (0x01, sp)
      00807D 5F               [ 1]  131 	clrw	x
      00807E 97               [ 1]  132 	ld	xl, a
      00807F CD 86 05         [ 4]  133 	call	_printInt_UART
                                    134 ;	main.c: 27: line_UART();
      008082 CD 86 64         [ 4]  135 	call	_line_UART
      008085 20 D8            [ 2]  136 	jra	00104$
                                    137 ;	main.c: 29: }
      008087 84               [ 1]  138 	pop	a
      008088 81               [ 4]  139 	ret
                                    140 	.area CODE
                                    141 	.area CONST
                                    142 	.area CONST
      008024                        143 ___str_0:
      008024 73 74 61 72 74 20 72   144 	.ascii "start reading"
             65 61 64 69 6E 67
      008031 00                     145 	.db 0x00
                                    146 	.area CODE
                                    147 	.area CONST
      008032                        148 ___str_1:
      008032 66 61 69 6C            149 	.ascii "fail"
      008036 00                     150 	.db 0x00
                                    151 	.area CODE
                                    152 	.area CONST
      008037                        153 ___str_2:
      008037 73 65 63 6F 6E 64 20   154 	.ascii "second is "
             69 73 20
      008041 00                     155 	.db 0x00
                                    156 	.area CODE
                                    157 	.area INITIALIZER
                                    158 	.area CABS (ABS)
